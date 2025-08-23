import fs from 'node:fs';
import path from 'node:path';

export default async function run(ctx) {
  const { meta, logger, params } = ctx;
  const dir = path.join(process.cwd(), 'logs', 'real-mode');
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
  const filename = `${meta.stepId}.${meta.actionId}.result.md`;
  const outPath = path.join(dir, filename);

  const title = params?.title || 'Task Execution Summary';
  const notes = params?.notes || '';
  const steps = Array.isArray(params?.steps) ? params.steps : ['Implement feature', 'Run local validation'];

  const lines = [];
  lines.push(`# ${title}`);
  lines.push('');
  lines.push(`- Step: ${meta.stepId}`);
  lines.push(`- Action: ${meta.actionId}`);
  lines.push(`- Date: ${new Date().toISOString()}`);
  lines.push('');
  lines.push('## Steps Performed');
  for (const s of steps) lines.push(`- ${s}`);
  if (notes) {
    lines.push('');
    lines.push('## Notes');
    lines.push(String(notes));
  }

  fs.writeFileSync(outPath, lines.join('\n'), 'utf8');
  logger.action({ type: 'artifact', step: meta.stepId, action: meta.actionId, path: outPath });
  return { output: { path: outPath, steps }, artifacts: { result: outPath } };
}
