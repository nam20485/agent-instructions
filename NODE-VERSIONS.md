Node version pinning (`.nvmrc`)
---------------------------------

This repository uses a simple `.nvmrc` file to pin the Node.js version for contributors and CI.

Why pin?
- Reproducible installs across machines and CI
- Deterministic behavior for tools that depend on Node (Corepack, pnpm, npm, dev tooling)

Where to set the pin
- `.nvmrc` (preferred) — simple single-line file containing an exact version (example: `22.18.0`). This repo already includes `22.18.0`.
- `NODE_VERSION_PIN` environment variable — the setup scripts will prefer this if present.
- `package.json` `engines.node` helps express minimum required Node, but does not pin; prefer `.nvmrc` for exact pin.

Using `.nvmrc`
```bash
# Install the version in .nvmrc and make it the default for nvm
nvm install
nvm use
nvm alias default $(cat .nvmrc)
```

Corepack and `packageManager`
- To activate `pnpm`/`yarn` deterministically via Corepack, add a `packageManager` field to `package.json`, for example:

```json
{"packageManager": "pnpm@8.11.0"}
```

Notes
- The repo's `package.json` has an `engines.node` entry but this is a minimum (`>=22`); `.nvmrc` is the canonical exact pin.
- If you need a different Node version for a branch or test, update `.nvmrc` and commit the change so CI and contributors pick it up.
