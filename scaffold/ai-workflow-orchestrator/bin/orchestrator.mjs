#!/usr/bin/env node
import('../src/cli.mjs').then(m => m.default()).catch(err => {
  console.error(err?.stack || String(err));
  process.exit(1);
});
