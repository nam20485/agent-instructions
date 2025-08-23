import fs from 'node:fs';
import path from 'node:path';

export default async function run(ctx) {
  const { meta, logger, params } = ctx;
  const dir = path.join(process.cwd(), 'logs', 'real-mode');
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
  const filename = `${meta.stepId}.${meta.actionId}.tests.md`;
  const outPath = path.join(dir, filename);

  const cases = Array.isArray(params?.cases) ? params.cases : [
    { name: 'Happy path', steps: ['Do X', 'Expect Y'] },
    { name: 'Edge case', steps: ['Do A', 'Expect B'] }
  ];

  const lines = [];
  lines.push(`# Test Cases`);
  lines.push('');
  lines.push(`- Step: ${meta.stepId}`);
  lines.push(`- Action: ${meta.actionId}`);
  lines.push('');
  for (const c of cases) {
    lines.push(`## ${c.name}`);
    for (const s of (c.steps || [])) lines.push(`- ${s}`);
    lines.push('');
  }

  fs.writeFileSync(outPath, lines.join('\n'), 'utf8');
  logger.action({ type: 'artifact', step: meta.stepId, action: meta.actionId, path: outPath });
  return { output: { path: outPath, count: cases.length }, artifacts: { tests: outPath } };
}
