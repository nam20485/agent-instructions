import fs from 'node:fs';
import path from 'node:path';
import os from 'node:os';
import { spawn } from 'node:child_process';

function nowIso() { return new Date().toISOString(); }

function ensureDir(p) { if (!fs.existsSync(p)) fs.mkdirSync(p, { recursive: true }); }

function execCmd(cmd, args, options = {}) {
  return new Promise((resolve, reject) => {
    const child = spawn(cmd, args, { stdio: ['ignore', 'pipe', 'pipe'], shell: false, ...options });
    let stdout = '';
    let stderr = '';
    child.stdout.on('data', d => { stdout += d.toString(); });
    child.stderr.on('data', d => { stderr += d.toString(); });
    child.on('error', reject);
    child.on('close', code => {
      if (code === 0) resolve({ stdout, stderr, code });
      else reject(new Error(`${cmd} ${args.join(' ')} failed (code ${code})${stderr ? `: ${stderr.trim()}` : ''}`));
    });
  });
}

async function commandExists(cmd) {
  const probe = process.platform === 'win32' ? ['where', cmd] : ['which', cmd];
  try {
    await execCmd(probe[0], [probe[1]]);
    return true;
  } catch { return false; }
}

async function gh(args, opts) {
  return execCmd('gh', args, opts);
}

async function git(args, cwd) {
  return execCmd('git', args, { cwd });
}

function readJson(p) { return JSON.parse(fs.readFileSync(p, 'utf8')); }
function writeJson(p, obj) { fs.writeFileSync(p, JSON.stringify(obj, null, 2) + '\n', 'utf8'); }

export default async function run(ctx) {
  const { meta, logger } = ctx;
  const params = ctx.params || {};
  const dir = path.join(process.cwd(), 'logs', 'real-mode');
  ensureDir(dir);
  const filename = `${meta.stepId}.${meta.actionId}.repo.md`;
  const outPath = path.join(dir, filename);

  const repoName = params.repoName || 'example-repo';
  const docs = Array.isArray(params.docs) ? params.docs : [];
  const owner = params.owner || 'nam20485';
  const visibility = (params.visibility || 'public').toLowerCase();
  const license = params.license || 'AGPL-3.0';
  const projectType = (params.projectType || 'v2').toLowerCase(); // 'v2' or 'classic'
  const labelsFile = params.labelsFile; // optional path to labels JSON
  const milestones = Array.isArray(params.milestones) ? params.milestones : null; // optional array
  const confirm = !!params.confirm; // must be true to perform remote operations

  const actionsLog = [];
  function logAction(msg) { actionsLog.push(`- ${msg}`); logger.action({ type: 'note', step: meta.stepId, action: meta.actionId, message: msg }); }
  function logWarn(msg) { logger.warn({ step: meta.stepId, message: msg }); actionsLog.push(`- WARN: ${msg}`); }

  // Always produce an artifact; conditionally perform remote actions when confirm=true
  const repoSlug = `${owner}/${repoName}`;
  const repoUrl = `https://github.com/${repoSlug}`;

  // 1) Preflight checks
  const hasGh = await commandExists('gh');
  if (!hasGh) logWarn('GitHub CLI (gh) not found in PATH; skipping remote actions.');
  const hasGit = await commandExists('git');
  if (!hasGit) logWarn('git not found in PATH; skipping clone/commit/push steps.');

  // 2) Create repository from template (if confirmed)
  if (confirm && hasGh) {
    try {
      // Check if repo exists
      await gh(['repo', 'view', repoSlug]);
      logAction(`Repository already exists: ${repoSlug}`);
    } catch {
      const pubFlag = visibility === 'private' ? '--private' : '--public';
      // Use template repo
      await gh(['repo', 'create', repoSlug, pubFlag, '--template', 'nam20485/ai-new-app-template', '--disable-issues=false', '--license', license, '--add-readme']);
      logAction(`Repository created from template: ${repoSlug}`);
    }
  } else {
    logAction('Repository creation step prepared (set params.confirm=true to execute).');
  }

  // 3) Clone, copy docs, commit & push
  let workDir = null;
  if (confirm && hasGh && hasGit) {
    const tmpBase = path.join(os.tmpdir(), 'init-repo');
    ensureDir(tmpBase);
    workDir = path.join(tmpBase, `${repoName}-${Date.now()}`);
    await gh(['repo', 'clone', repoSlug, workDir]);
    logAction(`Cloned to ${workDir}`);

    if (docs.length > 0) {
      const docsDir = path.join(workDir, 'docs');
      ensureDir(docsDir);
      let copied = 0;
      for (const rel of docs) {
        const src = path.isAbsolute(rel) ? rel : path.join(process.cwd(), rel);
        if (fs.existsSync(src) && fs.statSync(src).isFile()) {
          const dest = path.join(docsDir, path.basename(src));
          fs.copyFileSync(src, dest);
          copied++;
        } else {
          logWarn(`Doc not found or not a file: ${rel}`);
        }
      }
      if (copied > 0) {
        await git(['add', 'docs'], workDir);
        await git(['commit', '-m', 'chore: add app creation plan docs'], workDir).catch(() => null);
        await git(['push'], workDir);
        logAction(`Copied ${copied} doc(s) and pushed to ${repoSlug}`);
      } else {
        logAction('No docs copied.');
      }
    } else {
      logAction('No docs provided to copy.');
    }
  } else {
    logAction('Docs copy and initial commit prepared (set params.confirm=true to execute).');
  }

  // 4) Create GitHub Project (best-effort)
  if (confirm && hasGh) {
    try {
      if (projectType === 'v2') {
        await gh(['project', 'create', '--owner', owner, '--title', repoName]);
        logAction(`Created org project (v2) titled '${repoName}' for owner '${owner}'.`);
      } else {
        await gh(['project', 'create', '--org', owner, '--name', repoName]);
        logAction(`Created classic project named '${repoName}' under org '${owner}'.`);
      }
    } catch (e) {
      logWarn(`Creating project failed (continuing): ${e.message}`);
    }
  } else {
    logAction('Project creation prepared (set params.confirm=true to execute).');
  }

  // 5) Import labels (using local script if present)
  if (confirm && hasGh) {
    try {
      const scriptPath = path.join(process.cwd(), 'scripts', 'import-labels.ps1');
      const lf = labelsFile ? (path.isAbsolute(labelsFile) ? labelsFile : path.join(process.cwd(), labelsFile)) : null;
      if (fs.existsSync(scriptPath)) {
        // Invoke via pwsh if available
        const hasPwsh = await commandExists('pwsh');
        const shell = hasPwsh ? 'pwsh' : (process.platform === 'win32' ? 'powershell' : null);
        if (!shell) throw new Error('PowerShell not available to run import-labels.ps1');
        const args = ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', scriptPath, '-Repo', repoSlug];
        if (lf && fs.existsSync(lf)) { args.push('-LabelsFile', lf); }
        await execCmd(shell, args, { cwd: process.cwd() });
        logAction('Labels imported.');
      } else {
        logWarn('scripts/import-labels.ps1 not found; skipping labels import.');
      }
    } catch (e) {
      logWarn(`Importing labels failed (continuing): ${e.message}`);
    }
  } else {
    logAction('Labels import prepared (set params.confirm=true to execute).');
  }

  // 6) Create milestones (optional)
  if (confirm && hasGh && milestones && milestones.length) {
    try {
      const scriptPath = path.join(process.cwd(), 'scripts', 'create-milestones.ps1');
      if (fs.existsSync(scriptPath)) {
        const hasPwsh = await commandExists('pwsh');
        const shell = hasPwsh ? 'pwsh' : (process.platform === 'win32' ? 'powershell' : null);
        if (!shell) throw new Error('PowerShell not available to run create-milestones.ps1');
        // Pass titles as a single comma-separated argument list
        const titlesArg = milestones.join(',');
        const args = ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', scriptPath, '-Repo', repoSlug, '-Titles', titlesArg];
        await execCmd(shell, args, { cwd: process.cwd() });
        logAction(`Created ${milestones.length} milestone(s).`);
      } else {
        logWarn('scripts/create-milestones.ps1 not found; skipping milestones creation.');
      }
    } catch (e) {
      logWarn(`Creating milestones failed (continuing): ${e.message}`);
    }
  } else if (!milestones || milestones.length === 0) {
    logAction('No milestones provided; skipping milestones creation.');
  } else {
    logAction('Milestones creation prepared (set params.confirm=true to execute).');
  }

  // 7) Rename devcontainer/workspace files and commit
  if (confirm && hasGit && hasGh) {
    try {
      if (!workDir) {
        // If we didn’t clone earlier (e.g., git missing then installed), clone now
        const tmpBase = path.join(os.tmpdir(), 'init-repo');
        ensureDir(tmpBase);
        workDir = path.join(tmpBase, `${repoName}-${Date.now()}`);
        await gh(['repo', 'clone', repoSlug, workDir]);
      }
      let changed = false;
      // Update .devcontainer/devcontainer.json name
      const devc = path.join(workDir, '.devcontainer', 'devcontainer.json');
      if (fs.existsSync(devc)) {
        try {
          const json = readJson(devc);
          const desired = `${repoName}-devcontainer`;
          if (json.name !== desired) {
            json.name = desired;
            writeJson(devc, json);
            changed = true;
            logAction(`Set devcontainer name to ${desired}.`);
          }
        } catch (e) { logWarn(`Failed to update devcontainer.json: ${e.message}`); }
      }
      // Rename *.code-workspace to <repoName>.code-workspace
      const wsDir = workDir;
      const entries = fs.readdirSync(wsDir);
      for (const f of entries) {
        if (f.toLowerCase().endsWith('.code-workspace') && f !== `${repoName}.code-workspace`) {
          const from = path.join(wsDir, f);
          const to = path.join(wsDir, `${repoName}.code-workspace`);
          try { fs.renameSync(from, to); changed = true; logAction(`Renamed workspace file to ${repoName}.code-workspace`); }
          catch (e) { logWarn(`Failed to rename workspace file: ${e.message}`); }
        }
      }
      if (changed) {
        await git(['add', '.'], workDir);
        await git(['commit', '-m', 'chore: rename devcontainer/workspace files'], workDir).catch(() => null);
        await git(['push'], workDir);
        logAction('Pushed renames.');
      } else {
        logAction('No devcontainer/workspace changes needed.');
      }
    } catch (e) {
      logWarn(`Rename/commit step failed (continuing): ${e.message}`);
    }
  } else {
    logAction('Rename/commit step prepared (set params.confirm=true to execute).');
  }

  // Artifact emission (always)
  const lines = [];
  lines.push(`# Repository Initialization`);
  lines.push('');
  lines.push(`- Step: ${meta.stepId}`);
  lines.push(`- Action: ${meta.actionId}`);
  lines.push(`- Date: ${nowIso()}`);
  lines.push('');
  lines.push(`- Owner: ${owner}`);
  lines.push(`- Repository: ${repoName}`);
  lines.push(`- URL: ${repoUrl}`);
  lines.push(`- Visibility: ${visibility}`);
  lines.push(`- License: ${license}`);
  lines.push(`- Confirmed: ${confirm}`);
  lines.push('');
  lines.push('## Documents to copy to docs/');
  if (docs.length === 0) { lines.push('- (none provided)'); }
  else { for (const d of docs) lines.push(`- ${d}`); }
  lines.push('');
  lines.push('## Actions');
  if (actionsLog.length) lines.push(...actionsLog);

  fs.writeFileSync(outPath, lines.join('\n'), 'utf8');
  logger.action({ type: 'artifact', step: meta.stepId, action: meta.actionId, path: outPath });
  return { output: { path: outPath, repoName, owner, url: repoUrl, confirmed: confirm }, artifacts: { repo: outPath } };
}
