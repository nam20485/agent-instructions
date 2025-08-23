import fs from 'node:fs';
import path from 'node:path';
import { pathToFileURL } from 'node:url';

function parseArgs(argv) {
  const args = { dryRun: false, strict: false, console: false, verbose: false };
  for (let i = 2; i < argv.length; i++) {
    const a = argv[i];
    const next = argv[i + 1];
    switch (a) {
      case '--dry-run':
      case '--dry':
        args.dryRun = true; break;
      case '--strict':
        args.strict = true; break;
      case '--console':
        args.console = true; break;
      case '--verbose':
        args.verbose = true; break;
      case '--workflow':
      case '-w':
        args.workflow = next; i++; break;
      case '--file':
      case '-f':
        args.file = next; i++; break;
      case '--fixtures':
        args.fixtures = next; i++; break;
      case '--params':
        args.params = next; i++; break;
      case '--log':
        args.log = next; i++; break;
      case '--exec-paths':
        args.execPaths = next; i++; break;
      case '--workflows-path':
        args.workflowsPath = next; i++; break;
      default:
        break;
    }
  }
  return args;
}

function fail(msg, code = 1) { console.error(msg); process.exit(code); }
function ensureDir(dir) { if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true }); }
function readFileSafe(p) { return fs.readFileSync(p, 'utf8'); }
function loadJson(p, kind) { if (!p) return null; try { return JSON.parse(fs.readFileSync(p, 'utf8')); } catch (e) { throw new Error(`Failed to read ${kind} ${p}: ${e.message}`);} }
function jsonlWriter(filePath) { const fd = fs.openSync(filePath, 'w'); return { write: (o) => fs.writeSync(fd, JSON.stringify(o) + '\n'), close: () => fs.closeSync(fd) }; }
function timestamp() { return new Date().toISOString(); }

class Logger {
  constructor({ filePath, toConsole = false }) { this.toConsole = toConsole; this.writer = filePath ? jsonlWriter(filePath) : null; }
  action(obj) { const rec = { ...obj, timestamp: obj.timestamp ?? timestamp() }; if (this.writer) this.writer.write(rec); if (this.toConsole) { const { type, step, action } = rec; console.log(`[${type}] ${step} :: ${action}`);} }
  warn(obj) { const rec = { type: 'warning', ...obj, timestamp: obj.timestamp ?? timestamp() }; if (this.writer) this.writer.write(rec); console.warn(`WARN${rec.step ? ' [' + rec.step + ']' : ''} ${rec.message}${rec.line ? ' (line ' + rec.line + ')' : ''}`); }
  error(obj) { const rec = { type: 'error', ...obj, timestamp: obj.timestamp ?? timestamp() }; if (this.writer) this.writer.write(rec); console.error(`ERROR${rec.step ? ' [' + rec.step + ']' : ''} ${rec.message}${rec.line ? ' (line ' + rec.line + ')' : ''}`); }
  close() { if (this.writer) this.writer.close(); }
}

const reStep = /^###\s+([a-z0-9-]+)\s*$/i;
const reVarArraySingle = /^\s*`?\$([A-Za-z_][A-Za-z0-9_]*)`?\s*=\s*\[(.+?)\]\s*$/;
const reVarArrayStart = /^\s*`?\$([A-Za-z_][A-Za-z0-9_]*)`?\s*=\s*\[\s*$/;
const reForEach = /^\s*For each\s+`?\$([A-Za-z_][A-Za-z0-9_]*)`?\s+in\s+`?\$([A-Za-z_][A-Za-z0-9_]*)`?/i;
const reFunctionAssign = /^\s*`?\$([A-Za-z_][A-Za-z0-9_]*)`?\s*=\s*([a-z0-9-]+)\((.*?)\)\s*$/i;
const reAssignLine = /assign the agent the\s+`?([A-Za-z0-9-_\$]+)`?\s+assignment/i;
const reOutputRecord = /record output as\s+`?#([A-Za-z0-9-]+)\.\$?([A-Za-z0-9-_]+)`?/i;
const reRef = /#([a-z0-9-]+)(?:\.([a-z0-9-]+))?/i;

function splitArrayLiteral(s) { return s.split(',').map(x => x.trim()).filter(Boolean).map(x => { if ((x.startsWith('`') && x.endsWith('`')) || (x.startsWith("'") && x.endsWith("'")) || (x.startsWith('"') && x.endsWith('"'))) { return x.slice(1, -1);} return x;}); }

function extractScript(content) {
  const lines = content.split(/\r?\n/);
  let start = -1; for (let i = 0; i < lines.length; i++) { if (/^##\s+Script\s*$/i.test(lines[i])) { start = i + 1; break; } }
  if (start === -1) return { lines: [], offset: 0 };
  let end = lines.length; for (let i = start; i < lines.length; i++) { if (/^##\s+[^#]/.test(lines[i])) { end = i; break; } }
  return { lines: lines.slice(start, end), offset: start };
}

function simulateFunction(name, args, fixtures) {
  if (!fixtures) return { __missingFixture: true };
  const table = fixtures[name];
  if (!table) return { __missingFixture: true };
  if (args && args.ref && Object.prototype.hasOwnProperty.call(table, args.ref)) return table[args.ref];
  if (Object.prototype.hasOwnProperty.call(table, '*')) return table['*'];
  return { __missingFixture: true };
}

function planFromScript(scriptLines, offset, opts) {
  const plan = { steps: [], env: { variables: {}, references: {} }, warnings: [], errors: [] };
  let i = 0;
  function addWarning(stepId, message, line) { plan.warnings.push({ stepId, message, line }); }
  function addError(stepId, message, line) { plan.errors.push({ stepId, message, line }); }
  while (i < scriptLines.length) {
    const line = scriptLines[i];
    const m = reStep.exec(line);
    if (!m) { i++; continue; }
    const stepId = m[1];
    const stepStart = i; i++;
    const actions = [];
    while (i < scriptLines.length && !reStep.test(scriptLines[i])) {
      let l = scriptLines[i];
      let mv = reVarArraySingle.exec(l);
      if (mv) { const name = mv[1]; const items = splitArrayLiteral(mv[2]); plan.env.variables[name] = items; i++; continue; }
      const mvs = reVarArrayStart.exec(l);
      if (mvs) { const name = mvs[1]; i++; let acc = ''; let closed = false; while (i < scriptLines.length) { const ll = scriptLines[i]; const idxClose = ll.indexOf(']'); if (idxClose !== -1) { acc += (acc ? ',' : '') + ll.slice(0, idxClose); closed = true; i++; break; } else { acc += (acc ? ',' : '') + ll; i++; } } if (!closed) { addError(stepId, `Unterminated array assignment for $${name}`, offset + i + 1);} const items = splitArrayLiteral(acc); plan.env.variables[name] = items; continue; }
      const mf = reFunctionAssign.exec(l);
      if (mf) { const varName = mf[1]; const funcName = mf[2]; const rawArgs = mf[3]; const args = {}; const refm = reRef.exec(rawArgs); if (refm) { args.ref = `#${refm[1]}${refm[2] ? '.' + refm[2] : ''}`; } const action = { type: 'function', stepId, functionName: funcName, args, source: { line: offset + i + 1 } }; actions.push(action); const out = simulateFunction(funcName, args, opts.fixtures); if (out.__missingFixture) { addWarning(stepId, `No fixtures for ${funcName}${args.ref ? ' ' + args.ref : ''}; defaulting to []`, offset + i + 1); if (opts.strict) addError(stepId, `Missing fixtures for ${funcName}`, offset + i + 1); plan.env.variables[varName] = []; } else { action.simulatedOutput = out; plan.env.variables[varName] = out; } i++; continue; }
      const me = reForEach.exec(l);
      if (me) { const iterVar = me[1]; const listVar = me[2]; const arr = plan.env.variables[listVar]; if (!Array.isArray(arr)) { addWarning(stepId, `List variable $${listVar} is not defined or not an array`, offset + i + 1); if (opts.strict) addError(stepId, `List variable $${listVar} missing for for-each`, offset + i + 1); } i++; const bullets = []; while (i < scriptLines.length) { const bl = scriptLines[i]; if (reStep.test(bl)) break; if (/^\s*$/.test(bl)) { i++; break; } if (!/^\s*-\s+/.test(bl)) { i++; continue; } bullets.push({ text: bl, idx: i }); i++; } const list = Array.isArray(arr) ? arr : []; for (const item of list) { plan.env.variables[iterVar] = item; for (const b of bullets) { const txt = b.text; const ma = reAssignLine.exec(txt); if (ma) { let assignmentId = ma[1]; if (assignmentId.startsWith('$')) { const v = plan.env.variables[assignmentId.replace(/^\$/,'')]; assignmentId = v ?? assignmentId; } const action = { type: 'assignment', stepId, assignmentId, outputKey: `${stepId}.${assignmentId}`, source: { line: offset + b.idx + 1 } }; actions.push(action); continue; } const mo = reOutputRecord.exec(txt); if (mo) { continue; } } } continue; }
      const ma = reAssignLine.exec(l);
      if (ma) { const assignmentId = ma[1]; actions.push({ type: 'assignment', stepId, assignmentId, source: { line: offset + i + 1 } }); i++; continue; }
      i++;
    }
    plan.steps.push({ id: stepId, source: { lineStart: offset + stepStart + 1, lineEnd: offset + i }, actions });
  }
  return plan;
}

function emitJsonl(plan, outPath) { const dir = path.dirname(outPath); ensureDir(dir); const log = jsonlWriter(outPath); try { for (const step of plan.steps) { for (const a of step.actions) { if (a.type === 'assignment') { log.write({ type: 'assignment', step: step.id, action: a.assignmentId, outputKey: a.outputKey, timestamp: timestamp() }); } else if (a.type === 'function') { log.write({ type: 'function', step: step.id, action: a.functionName, args: a.args, simulatedOutput: a.simulatedOutput, timestamp: timestamp() }); } } } } finally { log.close(); } }

async function loadExecutor(modulePath) { try { if (!fs.existsSync(modulePath)) return null; const mod = await import(pathToFileURL(modulePath).href); if (!mod || typeof mod.default !== 'function') return null; return mod.default; } catch { return null; } }

function makeRefs(outputs) { return { get(ref) { if (!ref || typeof ref !== 'string') return undefined; if (!ref.startsWith('#')) return undefined; const parts = ref.slice(1).split('.'); if (parts.length < 2) return outputs['#' + parts[0]]; const baseKey = `#${parts[0]}.${parts[1]}`; let val = outputs[baseKey]; if (val === undefined) return undefined; if (parts.length > 2) { for (let i = 2; i < parts.length && val != null; i++) { val = val[parts[i]]; } } return val; } }; }

function nowMs() { return Date.now(); }
function isPlainObject(o) { return o && typeof o === 'object' && !Array.isArray(o); }
function deepMerge(a, b) { if (!isPlainObject(a)) a = {}; if (!isPlainObject(b)) return { ...a }; const out = { ...a }; for (const k of Object.keys(b)) { if (isPlainObject(b[k]) && isPlainObject(out[k])) out[k] = deepMerge(out[k], b[k]); else out[k] = b[k]; } return out; }
function interpolateRefs(value, refs) { if (typeof value === 'string') { const m = value.match(/^\$\{([^}]+)\}$/); if (m) { const v = refs.get(m[1]); return v === undefined ? value : v; } return value.replace(/\$\{([^}]+)\}/g, (_, expr) => { const v = refs.get(expr); return v === undefined ? '${' + expr + '}' : String(v); }); } if (Array.isArray(value)) return value.map(v => interpolateRefs(v, refs)); if (isPlainObject(value)) { const out = {}; for (const [k, v] of Object.entries(value)) out[k] = interpolateRefs(v, refs); return out; } return value; }
function resolveParams(paramsCfg, stepId, assignmentId, refs) { if (!paramsCfg) return undefined; const specificKey = `#${stepId}.${assignmentId}`; const merged = deepMerge(paramsCfg.defaults || {}, deepMerge((paramsCfg.assignments && paramsCfg.assignments[assignmentId]) || {}, deepMerge((paramsCfg.steps && paramsCfg.steps[stepId]) || {}, (paramsCfg.actions && paramsCfg.actions[specificKey]) || {}))); return interpolateRefs(merged, refs); }

export default async function cli() {
  const cwd = process.cwd();
  const args = parseArgs(process.argv);
  let filePath = args.file;
  if (!filePath) {
    if (!args.workflow) fail('Specify --workflow <name> or --file <path>');
    const wfBase = args.workflowsPath ? (path.isAbsolute(args.workflowsPath) ? args.workflowsPath : path.join(cwd, args.workflowsPath)) : path.join(cwd, 'workflows');
    filePath = path.join(wfBase, `${args.workflow}.md`);
  }
  if (!fs.existsSync(filePath)) fail(`Workflow file not found: ${filePath}`);
  const content = readFileSafe(filePath);
  const { lines: scriptLines, offset } = extractScript(content);
  if (!scriptLines.length) fail('No "## Script" section found in workflow file');
  const fixtures = args.fixtures ? loadJson(args.fixtures, 'fixtures') : null;
  const paramsCfg = args.params ? loadJson(args.params, 'params') : null;
  const plan = planFromScript(scriptLines, offset, { fixtures, strict: args.strict });
  if (args.strict && plan.errors.length) { for (const e of plan.errors) console.error(`ERROR [${e.stepId}] ${e.message} (line ${e.line})`); process.exit(2); }
  const wfName = args.workflow ?? path.basename(filePath, '.md');
  const out = args.log ?? (args.dryRun ? path.join(cwd, 'logs', `${wfName}-dryrun-${Date.now()}.jsonl`) : null);
  if (out) ensureDir(path.dirname(out));
  const logger = new Logger({ filePath: out, toConsole: !!args.console || !!args.verbose });
  for (const w of plan.warnings) logger.warn({ step: w.stepId, message: w.message, line: w.line });

  if (args.dryRun) {
    for (const step of plan.steps) { for (const a of step.actions) { if (a.type === 'assignment') { logger.action({ type: 'assignment', step: step.id, action: a.assignmentId, outputKey: a.outputKey }); } else if (a.type === 'function') { logger.action({ type: 'function', step: step.id, action: a.functionName, args: a.args, simulatedOutput: a.simulatedOutput }); } } }
    logger.close(); if (out) console.log(`Dry-run plan written: ${out}`); return;
  }

  const outputs = {}; const env = {}; const refs = makeRefs(outputs); const runId = `run-${Date.now()}`;
  const searchPaths = [];
  if (args.execPaths) { for (const token of args.execPaths.split(/[;,]/)) { const p = token.trim(); if (!p) continue; searchPaths.push(path.isAbsolute(p) ? p : path.join(cwd, p)); } }
  // default to ./executors next to invocation cwd
  searchPaths.push(path.join(cwd, 'executors'));

  function findAssignmentExecutor(actionId) { for (const base of searchPaths) { const modPath = path.join(base, 'assignments', `${actionId}.mjs`); if (fs.existsSync(modPath)) return modPath; } return path.join(searchPaths[0], 'assignments', `${actionId}.mjs`); }
  function findFunctionExecutor(funcName) { for (const base of searchPaths) { const modPath = path.join(base, 'functions', `${funcName}.mjs`); if (fs.existsSync(modPath)) return modPath; } return path.join(searchPaths[0], 'functions', `${funcName}.mjs`); }

  for (const step of plan.steps) {
    for (const a of step.actions) {
      if (a.type === 'assignment') {
        const actionId = a.assignmentId;
        const modPath = findAssignmentExecutor(actionId);
        const execFn = await loadExecutor(modPath);
        const meta = { stepId: step.id, actionId, source: a.source, runId };
        const start = nowMs();
        logger.action({ type: 'assignment-start', step: step.id, action: actionId, outputKey: a.outputKey });
        if (!execFn) { const errMsg = `Missing assignment executor: ${modPath}`; logger.error({ step: step.id, message: errMsg, line: a.source?.line }); logger.action({ type: 'assignment-end', step: step.id, action: actionId, outputKey: a.outputKey, status: 'error', durationMs: nowMs() - start }); logger.close(); fail(errMsg); }
        try { const ctx = { meta, env, refs, logger, config: process.env }; const params = resolveParams(paramsCfg, step.id, actionId, refs); if (params !== undefined) ctx.params = params; const result = await execFn(ctx); const output = result?.output; const artifacts = result?.artifacts; const outKey = `#${step.id}.${actionId}`; outputs[outKey] = output ?? null; if (result?.vars && typeof result.vars === 'object') Object.assign(env, result.vars); logger.action({ type: 'assignment-end', step: step.id, action: actionId, outputKey: a.outputKey, status: 'ok', durationMs: nowMs() - start, artifacts }); } catch (e) { logger.error({ step: step.id, message: e?.message ?? String(e) }); logger.action({ type: 'assignment-end', step: step.id, action: actionId, outputKey: a.outputKey, status: 'error', durationMs: nowMs() - start }); logger.close(); fail(`Executor failed for ${actionId}: ${e?.message ?? e}`); }
      } else if (a.type === 'function') {
        const funcName = a.functionName; const modPath = findFunctionExecutor(funcName); const execFn = await loadExecutor(modPath); const meta = { stepId: step.id, functionName: funcName, source: a.source, runId }; const start = nowMs(); logger.action({ type: 'function-start', step: step.id, action: funcName, args: a.args }); if (!execFn) { const errMsg = `Missing function executor: ${modPath}`; logger.error({ step: step.id, message: errMsg, line: a.source?.line }); logger.action({ type: 'function-end', step: step.id, action: funcName, status: 'error', durationMs: nowMs() - start }); logger.close(); fail(errMsg); }
        try { const ctx = { meta, env, refs, logger, config: process.env, args: a.args }; const result = await execFn(ctx); const output = result?.output; if (result?.vars && typeof result.vars === 'object') Object.assign(env, result.vars); logger.action({ type: 'function-end', step: step.id, action: funcName, status: 'ok', durationMs: nowMs() - start, output }); } catch (e) { logger.error({ step: step.id, message: e?.message ?? String(e) }); logger.action({ type: 'function-end', step: step.id, action: funcName, status: 'error', durationMs: nowMs() - start }); logger.close(); fail(`Function executor failed for ${funcName}: ${e?.message ?? e}`); }
      }
    }
  }
  logger.close(); if (out) console.log(`Execution log written: ${out}`);
}
