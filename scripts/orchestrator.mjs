#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

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
      case '--log':
        args.log = next; i++; break;
      default:
        // ignore unknown flags for now
        break;
    }
  }
  return args;
}

function fail(msg, code = 1) {
  console.error(msg);
  process.exit(code);
}

function readFileSafe(p) {
  return fs.readFileSync(p, 'utf8');
}

function loadFixtures(p) {
  if (!p) return null;
  try {
    return JSON.parse(fs.readFileSync(p, 'utf8'));
  } catch (e) {
    throw new Error(`Failed to read fixtures ${p}: ${e.message}`);
  }
}

function ensureDir(dir) {
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
}

function jsonlWriter(filePath) {
  const fd = fs.openSync(filePath, 'w');
  return {
    write: (obj) => fs.writeSync(fd, JSON.stringify(obj) + '\n'),
    close: () => fs.closeSync(fd)
  };
}

function timestamp() { return new Date().toISOString(); }

// --- Unified logger (console + JSONL file) ---
class Logger {
  constructor({ filePath, toConsole = false }) {
    this.toConsole = toConsole;
    this.writer = filePath ? jsonlWriter(filePath) : null;
  }
  action(obj) {
    const rec = { ...obj, timestamp: obj.timestamp ?? timestamp() };
    if (this.writer) this.writer.write(rec);
    if (this.toConsole) {
      const { type, step, action } = rec;
      console.log(`[${type}] ${step} :: ${action}`);
    }
  }
  warn(obj) {
    const rec = { type: 'warning', ...obj, timestamp: obj.timestamp ?? timestamp() };
    if (this.writer) this.writer.write(rec);
    console.warn(`WARN${rec.step ? ' [' + rec.step + ']' : ''} ${rec.message}${rec.line ? ' (line ' + rec.line + ')' : ''}`);
  }
  error(obj) {
    const rec = { type: 'error', ...obj, timestamp: obj.timestamp ?? timestamp() };
    if (this.writer) this.writer.write(rec);
    console.error(`ERROR${rec.step ? ' [' + rec.step + ']' : ''} ${rec.message}${rec.line ? ' (line ' + rec.line + ')' : ''}`);
  }
  close() { if (this.writer) this.writer.close(); }
}

// --- Simple DSL parsing helpers ---
const reStep = /^###\s+([a-z0-9-]+)\s*$/i;
const reVarArraySingle = /^\s*`?\$([A-Za-z_][A-Za-z0-9_]*)`?\s*=\s*\[(.+?)\]\s*$/;
const reVarArrayStart = /^\s*`?\$([A-Za-z_][A-Za-z0-9_]*)`?\s*=\s*\[\s*$/;
const reForEach = /^\s*For each\s+`?\$([A-Za-z_][A-Za-z0-9_]*)`?\s+in\s+`?\$([A-Za-z_][A-Za-z0-9_]*)`?/i;
const reFunctionAssign = /^\s*`?\$([A-Za-z_][A-Za-z0-9_]*)`?\s*=\s*([a-z0-9-]+)\((.*?)\)\s*$/i;
const reAssignLine = /assign the agent the\s+`?([A-Za-z0-9-_\$]+)`?\s+assignment/i;
const reOutputRecord = /record output as\s+`?#([A-Za-z0-9-]+)\.\$?([A-Za-z0-9-_]+)`?/i;
const reRef = /#([a-z0-9-]+)(?:\.([a-z0-9-]+))?/i;

function splitArrayLiteral(s) {
  // split on commas not inside quotes/backticks - simple approach: split, then trim wrappers
  return s.split(',').map(x => x.trim()).filter(Boolean).map(x => {
    if ((x.startsWith('`') && x.endsWith('`')) || (x.startsWith("'") && x.endsWith("'")) || (x.startsWith('"') && x.endsWith('"'))) {
      return x.slice(1, -1);
    }
    return x;
  });
}

function extractScript(content) {
  const lines = content.split(/\r?\n/);
  let start = -1;
  for (let i = 0; i < lines.length; i++) {
    if (/^##\s+Script\s*$/i.test(lines[i])) { start = i + 1; break; }
  }
  if (start === -1) return { lines: [], offset: 0 };
  // find end at next top-level ## or EOF
  let end = lines.length;
  for (let i = start; i < lines.length; i++) {
    if (/^##\s+[^#]/.test(lines[i])) { end = i; break; }
  }
  return { lines: lines.slice(start, end), offset: start };
}

function planFromScript(scriptLines, offset, opts) {
  const plan = { steps: [], env: { variables: {}, references: {} }, warnings: [], errors: [] };
  let i = 0;
  function addWarning(stepId, message, line) {
    plan.warnings.push({ stepId, message, line });
  }
  function addError(stepId, message, line) {
    plan.errors.push({ stepId, message, line });
  }
  while (i < scriptLines.length) {
    const line = scriptLines[i];
    const m = reStep.exec(line);
    if (!m) { i++; continue; }
    const stepId = m[1];
    const stepStart = i; i++;
    const actions = [];
    // read until next step or EOF
    while (i < scriptLines.length && !reStep.test(scriptLines[i])) {
      let l = scriptLines[i];
      // variable array assignment (single-line)
      let mv = reVarArraySingle.exec(l);
      if (mv) {
        const name = mv[1];
        const items = splitArrayLiteral(mv[2]);
        plan.env.variables[name] = items;
        i++; continue;
      }
      // variable array assignment (multi-line)
      const mvs = reVarArrayStart.exec(l);
      if (mvs) {
        const name = mvs[1];
        i++;
        let acc = '';
        let closed = false;
        while (i < scriptLines.length) {
          const ll = scriptLines[i];
          const idxClose = ll.indexOf(']');
          if (idxClose !== -1) {
            acc += (acc ? ',' : '') + ll.slice(0, idxClose);
            closed = true;
            // consume the rest of the line and move past
            i++;
            break;
          } else {
            acc += (acc ? ',' : '') + ll;
            i++;
          }
        }
        if (!closed) {
          addError(stepId, `Unterminated array assignment for $${name}`, offset + i + 1);
        }
        const items = splitArrayLiteral(acc);
        plan.env.variables[name] = items;
        continue;
      }
      // function assignment to variable: $var = func(args)
      const mf = reFunctionAssign.exec(l);
      if (mf) {
        const varName = mf[1];
        const funcName = mf[2];
        const rawArgs = mf[3];
        const args = {};
        const refm = reRef.exec(rawArgs);
        if (refm) { args.ref = `#${refm[1]}${refm[2] ? '.' + refm[2] : ''}`; }
        const action = { type: 'function', stepId, functionName: funcName, args, source: { line: offset + i + 1 } };
        actions.push(action);
        // simulate output now for planning
        const out = simulateFunction(funcName, args, opts.fixtures);
        if (out.__missingFixture) {
          addWarning(stepId, `No fixtures for ${funcName}${args.ref ? ' ' + args.ref : ''}; defaulting to []`, offset + i + 1);
          if (opts.strict) addError(stepId, `Missing fixtures for ${funcName}`, offset + i + 1);
          plan.env.variables[varName] = [];
        } else {
          action.simulatedOutput = out;
          plan.env.variables[varName] = out;
        }
        i++; continue;
      }
      // for-each block
      const me = reForEach.exec(l);
      if (me) {
        const iterVar = me[1];
        const listVar = me[2];
        const arr = plan.env.variables[listVar];
        if (!Array.isArray(arr)) {
          addWarning(stepId, `List variable $${listVar} is not defined or not an array`, offset + i + 1);
          if (opts.strict) addError(stepId, `List variable $${listVar} missing for for-each`, offset + i + 1);
        }
        // collect following bullet lines until blank line or next heading
        i++;
        const bullets = [];
        while (i < scriptLines.length) {
          const bl = scriptLines[i];
          if (reStep.test(bl)) break;
          if (/^\s*$/.test(bl)) { i++; break; }
          if (!/^\s*-\s+/.test(bl)) { i++; continue; }
          bullets.push({ text: bl, idx: i });
          i++;
        }
        const list = Array.isArray(arr) ? arr : [];
        for (const item of list) {
          plan.env.variables[iterVar] = item;
          for (const b of bullets) {
            const txt = b.text;
            const ma = reAssignLine.exec(txt);
            if (ma) {
              let assignmentId = ma[1];
              if (assignmentId.startsWith('$')) {
                const v = plan.env.variables[assignmentId.replace(/^\$/,'')];
                assignmentId = v ?? assignmentId; // if not found, keep literal
              }
              const action = {
                type: 'assignment', stepId, assignmentId,
                outputKey: `${stepId}.${assignmentId}`,
                source: { line: offset + b.idx + 1 }
              };
              actions.push(action);
              continue;
            }
            const mo = reOutputRecord.exec(txt);
            if (mo) {
              // explicit output record hint; already implied by convention
              continue;
            }
            // other bullets are ignored for planning
          }
        }
        continue;
      }
      // single assignment outside loop
      const ma = reAssignLine.exec(l);
      if (ma) {
        const assignmentId = ma[1];
        actions.push({ type: 'assignment', stepId, assignmentId, source: { line: offset + i + 1 } });
        i++; continue;
      }
      // otherwise skip
      i++;
    }
    plan.steps.push({ id: stepId, source: { lineStart: offset + stepStart + 1, lineEnd: offset + i }, actions });
  }
  return plan;
}

function simulateFunction(name, args, fixtures) {
  if (!fixtures) return { __missingFixture: true };
  const table = fixtures[name];
  if (!table) return { __missingFixture: true };
  if (args && args.ref && Object.prototype.hasOwnProperty.call(table, args.ref)) {
    return table[args.ref];
  }
  if (Object.prototype.hasOwnProperty.call(table, '*')) return table['*'];
  return { __missingFixture: true };
}

function emitJsonl(plan, outPath) {
  const dir = path.dirname(outPath);
  ensureDir(dir);
  const log = jsonlWriter(outPath);
  try {
    for (const step of plan.steps) {
      for (const a of step.actions) {
        if (a.type === 'assignment') {
          log.write({ type: 'assignment', step: step.id, action: a.assignmentId, outputKey: a.outputKey, timestamp: timestamp() });
        } else if (a.type === 'function') {
          log.write({ type: 'function', step: step.id, action: a.functionName, args: a.args, simulatedOutput: a.simulatedOutput, timestamp: timestamp() });
        }
      }
    }
  } finally {
    log.close();
  }
}

function main() {
  const cwd = process.cwd();
  const args = parseArgs(process.argv);
  const repoRoot = cwd; // assume invoked at repo root
  let filePath = args.file;
  if (!filePath) {
    if (!args.workflow) fail('Specify --workflow <name> or --file <path>');
    filePath = path.join(repoRoot, 'ai_instruction_modules', 'ai-workflow-assignments', 'dynamic-workflows', `${args.workflow}.md`);
  }
  if (!fs.existsSync(filePath)) fail(`Workflow file not found: ${filePath}`);
  const content = readFileSafe(filePath);

  // Phase 0: (lightweight) validate — ensure Script exists
  const { lines: scriptLines, offset } = extractScript(content);
  if (!scriptLines.length) fail('No "## Script" section found in workflow file');

  // Phase 1: plan
  const fixtures = args.fixtures ? loadFixtures(args.fixtures) : null;
  const plan = planFromScript(scriptLines, offset, { fixtures, strict: args.strict });
  if (args.strict && plan.errors.length) {
    for (const e of plan.errors) console.error(`ERROR [${e.stepId}] ${e.message} (line ${e.line})`);
    process.exit(2);
  }
  // Initialize logger for actions and warnings/errors
  const wfName = args.workflow ?? path.basename(filePath, '.md');
  const out = args.log ?? (args.dryRun ? path.join(repoRoot, 'logs', `${wfName}-dryrun-${Date.now()}.jsonl`) : null);
  if (out) ensureDir(path.dirname(out));
  const logger = new Logger({ filePath: out, toConsole: !!args.console || !!args.verbose });
  for (const w of plan.warnings) logger.warn({ step: w.stepId, message: w.message, line: w.line });

  // Phase 2: execute or emit
  if (args.dryRun) {
    // Emit actions to logger (file and/or console)
    for (const step of plan.steps) {
      for (const a of step.actions) {
        if (a.type === 'assignment') {
          logger.action({ type: 'assignment', step: step.id, action: a.assignmentId, outputKey: a.outputKey });
        } else if (a.type === 'function') {
          logger.action({ type: 'function', step: step.id, action: a.functionName, args: a.args, simulatedOutput: a.simulatedOutput });
        }
      }
    }
    logger.close();
    if (out) console.log(`Dry-run plan written: ${out}`);
    return;
  }

  // Real mode: iterate plan and log start/end events (no-op execution stub)
  for (const step of plan.steps) {
    for (const a of step.actions) {
      if (a.type === 'assignment') {
        logger.action({ type: 'assignment-start', step: step.id, action: a.assignmentId, outputKey: a.outputKey });
        // TODO: integrate real assignment executors here
        logger.action({ type: 'assignment-end', step: step.id, action: a.assignmentId, outputKey: a.outputKey });
      } else if (a.type === 'function') {
        logger.action({ type: 'function-start', step: step.id, action: a.functionName, args: a.args });
        // TODO: integrate real function execution here
        logger.action({ type: 'function-end', step: step.id, action: a.functionName, args: a.args });
      }
    }
  }
  logger.close();
  if (out) console.log(`Execution log written: ${out}`);
}

main();
