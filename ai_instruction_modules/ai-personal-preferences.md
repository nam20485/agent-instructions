# Personal Preferences & Interaction Contract

Style:
- High signal, terse bullets
- Avoid repetition / filler
- State assumptions explicitly

Proposal Pattern:
1. Planned edits (bullets)
2. Diff snippets grouped logically
3. Ask to apply
4. Apply + validate (build/test)
5. Report PASS/FAIL & next step

Decisions:
- If >1 path: table (Option/Pros/Cons/When to choose) + recommendation with why

Validation:
- dotnet build after edits
- Add/adjust tests for new logic
- Tests pass
- Docker build if Dockerfile changed

Learning:
- Reuse accepted patterns; track declined approaches
- Document to memory and instruction modules when learning something new
- Document when something doesn't work as expected and a solution is found

Risks:
- Call out breaking changes, perf impact, security concerns early

Blocking Ambiguity:
- Request missing info + suggest default fallback

End of file.
