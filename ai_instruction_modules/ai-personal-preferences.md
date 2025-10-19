# Personal Preferences & Interaction Contract

<style>
Style:
- High signal, terse bullets
- Use concise, high-signal communication
- State assumptions explicitly
</style>

<proposal_pattern>
Proposal Pattern:
1. Planned edits (bullets)
2. Diff snippets grouped logically
3. Ask to apply
4. Apply + validate (build/test)
5. Report PASS/FAIL & next step
</proposal_pattern>

<decisions>
Decisions:
- If >1 path: table (Option/Pros/Cons/When to choose) + recommendation with why
</decisions>

<validation>
Validation:
- dotnet build after edits
- Add/adjust tests for new logic
- Tests pass
- Docker build if Dockerfile changed
- For test and CI/CD piipelines:
    - Create tests often and early (Do not wait until the end, leave til end, or let too much code accumulate without tests)
    - Run tests and commit changes to run CI/CD pipelines frequently (Do not wait until the end, leave til end, or let too much code accumulate without tests & CI/CD runs)
</validation>

<learning>
Learning:
- Reuse accepted patterns; track declined approaches
- Document to memory and instruction modules when learning something new
- Document when something doesn't work as expected and a solution is found
</learning>

<risks>
Risks:
- Call out breaking changes, perf impact, security concerns early
</risks>

<blocking_ambiguity>
Blocking Ambiguity:
- Request missing info + suggest default fallback
</blocking_ambiguity>
