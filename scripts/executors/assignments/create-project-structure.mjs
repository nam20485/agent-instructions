import fs from 'node:fs';
import path from 'node:path';

export default async function run(ctx) {
  const { meta, logger, params } = ctx;
  const dir = path.join(process.cwd(), 'logs', 'real-mode');
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
  const filename = `${meta.stepId}.${meta.actionId}.structure.md`;
  const outPath = path.join(dir, filename);

  const spec = params && typeof params === 'object' ? params : {};
  const dirs = Array.isArray(spec.dirs) ? spec.dirs : ['src', 'tests', 'docs'];
  const files = spec.files && typeof spec.files === 'object' ? spec.files : { 'README.md': '# Project\n' };

  const lines = [];
  lines.push(`# Project Structure Plan`);
  lines.push('');
  lines.push(`- Step: ${meta.stepId}`);
  lines.push(`- Action: ${meta.actionId}`);
  lines.push(`- Date: ${new Date().toISOString()}`);
  lines.push('');
  lines.push('## Directories');
  for (const d of dirs) lines.push(`- ${d}`);
  lines.push('');
  lines.push('## Files');
  for (const [f, v] of Object.entries(files)) lines.push(`- ${f} (${v.length} chars)`);
  lines.push('');
  if (spec.notes) {
    lines.push('## Notes');
    lines.push(String(spec.notes));
    lines.push('');
  }

  fs.writeFileSync(outPath, lines.join('\n'), 'utf8');
  logger.action({ type: 'artifact', step: meta.stepId, action: meta.actionId, path: outPath });
  return { output: { path: outPath, dirs, files }, artifacts: { structure: outPath } };
}
