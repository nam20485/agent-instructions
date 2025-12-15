---
description: Formatting standards for AI instruction modules
scope: formatting-standards
context: opt-in
---
# Instructions Format

## Principles

1. **XML Tags:** Wrap sections in semantic tags (`<persona>`, `<workflow>`, etc.)
2. **Markdown:** H1 title, H2 sections, `-` lists, triple-backtick code
3. **Concision:** Target 8-16k tokens, max 32k
4. **Positive:** "Do X" not "Don't do Y"
5. **Examples:** Few-shot for complex behaviors

## XML Rules

- Lowercase with underscores: `<core_behaviors>`
- Always close: `</tag>`
- Common: `<persona>`, `<hierarchy>`, `<workflow>`, `<constraints>`, `<validation>`

## Markdown Rules

- H1: File title (one per file)
- H2: Major sections
- Links: Relative internal (`./file.md`), absolute external

## Checklist

- [ ] YAML front matter
- [ ] H1 title
- [ ] XML-wrapped sections
- [ ] Positive instructions
- [ ] Under 32k tokens
