import fs from 'node:fs';
import path from 'node:path';

export default async function run(ctx) {
  const { meta, logger } = ctx;
  const dir = path.join(process.cwd(), 'logs', 'real-mode');
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
  const filename = `${meta.stepId}.${meta.actionId}.plan.md`;
  const outPath = path.join(dir, filename);
  const content = `# App Plan\n\n- Goal: draft plan for step ${meta.stepId}\n- Action: ${meta.actionId}\n- Date: ${new Date().toISOString()}\n\nSections to complete:\n- Scope\n- Milestones\n- Risks\n- Open Questions\n`;
  fs.writeFileSync(outPath, content, 'utf8');
  logger.action({ type: 'artifact', step: meta.stepId, action: meta.actionId, path: outPath });
  return { output: { path: outPath, summary: 'App plan draft created' }, artifacts: { plan: outPath } };
}
