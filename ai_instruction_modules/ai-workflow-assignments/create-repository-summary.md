---
description: How to create .ai-repository-summary.md files
scope: repo-summary
context: opt-in
---
# Creating Repository Summary

## Purpose
Create `.ai-repository-summary.md` in repo root to onboard AI agents. Reduces exploration time and errors.

## Constraints
- Max 2 pages (~8-16k tokens)
- Repository-specific only
- Markdown with XML tags

## Process
1. Scan README, build scripts, workflows, config files
2. Validate build/test commands work
3. Create `.ai-repository-summary.md`
4. Iterate as you learn more

## Required Content

**High-Level:** Purpose, tech stack, complexity

**Build & Validation:**
- Bootstrap, build, test, lint commands
- Known issues and workarounds
- Required environment/versions

**Layout:**
- Key directories and files
- Config locations
- Architecture overview
