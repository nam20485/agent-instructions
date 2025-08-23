import fs from 'node:fs';
import path from 'node:path';

export default async function run(ctx) {
  const { meta, logger, params } = ctx;
  const dir = path.join(process.cwd(), 'logs', 'real-mode');
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
  const filename = `${meta.stepId}.${meta.actionId}.merge.md`;
  const outPath = path.join(dir, filename);

  const prNumber = params?.prNumber || 1;
  const strategy = params?.strategy || 'squash';
  const message = params?.message || 'Auto-merged via orchestrator (simulated)';

  const content = `# Merge Summary\n\n- Step: ${meta.stepId}\n- Action: ${meta.actionId}\n- PR: #${prNumber}\n- Strategy: ${strategy}\n- Message: ${message}\n- Date: ${new Date().toISOString()}\n`;

  fs.writeFileSync(outPath, content, 'utf8');
  logger.action({ type: 'artifact', step: meta.stepId, action: meta.actionId, path: outPath });
  return { output: { path: outPath, prNumber, strategy }, artifacts: { merge: outPath } };
}
