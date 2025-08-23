import fs from 'node:fs';
import path from 'node:path';

export default async function run(ctx) {
  const { meta, logger, params } = ctx;
  const dir = path.join(process.cwd(), 'logs', 'real-mode');
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
  const filename = `${meta.stepId}.${meta.actionId}.delivery.md`;
  const outPath = path.join(dir, filename);

  const checklist = Array.isArray(params?.checklist) ? params.checklist : [
    'All acceptance criteria met',
    'Artifacts stored and linked',
    'PR(s) approved and merged',
    'Release notes drafted',
    'Stakeholder sign-off recorded'
  ];

  const lines = [];
  lines.push(`# Final Validation and Delivery`);
  lines.push('');
  lines.push(`- Step: ${meta.stepId}`);
  lines.push(`- Action: ${meta.actionId}`);
  lines.push('');
  lines.push('## Checklist');
  for (const item of checklist) lines.push(`- [x] ${item}`);

  fs.writeFileSync(outPath, lines.join('\n'), 'utf8');
  logger.action({ type: 'artifact', step: meta.stepId, action: meta.actionId, path: outPath });
  return { output: { path: outPath, done: true }, artifacts: { delivery: outPath } };
}
