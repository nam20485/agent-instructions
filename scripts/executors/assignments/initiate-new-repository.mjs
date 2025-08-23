import fs from 'node:fs';
import path from 'node:path';

export default async function run(ctx) {
  const { meta, logger, params } = ctx;
  const dir = path.join(process.cwd(), 'logs', 'real-mode');
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
  const filename = `${meta.stepId}.${meta.actionId}.repo.md`;
  const outPath = path.join(dir, filename);

  const repoName = params?.repoName || 'example-repo';
  const docs = Array.isArray(params?.docs) ? params.docs : [];
  const owner = params?.owner || 'nam20485';
  const visibility = params?.visibility || 'public';
  const license = params?.license || 'AGPL-3.0';

  const lines = [];
  lines.push(`# Repository Initialization Plan`);
  lines.push('');
  lines.push(`- Step: ${meta.stepId}`);
  lines.push(`- Action: ${meta.actionId}`);
  lines.push(`- Date: ${new Date().toISOString()}`);
  lines.push('');
  lines.push(`- Owner: ${owner}`);
  lines.push(`- Repository: ${repoName}`);
  lines.push(`- Visibility: ${visibility}`);
  lines.push(`- License: ${license}`);
  lines.push('');
  lines.push('## Documents to copy to docs/');
  if (docs.length === 0) {
    lines.push('- (none provided)');
  } else {
    for (const d of docs) lines.push(`- ${d}`);
  }
  lines.push('');
  lines.push('## Actions (simulated)');
  lines.push('- Create repo from template nam20485/ai-new-app-template');
  lines.push('- Create GitHub Project (Basic Kanban)');
  lines.push('- Import labels (.labels.json)');
  lines.push('- Create milestones per app plan');
  lines.push('- Rename devcontainer + workspace files');

  fs.writeFileSync(outPath, lines.join('\n'), 'utf8');
  logger.action({ type: 'artifact', step: meta.stepId, action: meta.actionId, path: outPath });
  return { output: { path: outPath, repoName, owner }, artifacts: { repo: outPath } };
}
