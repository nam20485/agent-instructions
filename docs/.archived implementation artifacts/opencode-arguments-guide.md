# OpenCode Command Arguments Guide

## Overview

OpenCode's custom commands support **named arguments** using placeholder syntax. This guide clarifies how argument substitution works, which differs significantly from how the sparse official documentation might suggest.

## Key Concepts

### Named Arguments Pattern

OpenCode uses a **regex-based pattern** to detect named arguments in command files:

```regex
\$([A-Z][A-Z0-9_]*)
```

**Valid argument names:**
- Must start with a dollar sign (`$`)
- First character after `$` must be an uppercase letter (`A-Z`)
- Subsequent characters can be uppercase letters, numbers, or underscores
- Examples: `$ARGUMENTS`, `$FOO`, `$BAR_123`, `$ISSUE_NUMBER`

**Invalid argument names:**
- `$foo` - lowercase
- `$1BAR` - starts with number
- `$_FOO` - starts with underscore
- `$ARGUMENTS[0]` - array indexing (not supported)

## How It Works

### 1. Argument Detection

When you create a custom command (`.md` file in `~/.config/opencode/command/`), OpenCode:

1. **Scans the file content** for all named argument patterns
2. **Extracts unique argument names** (removes duplicates)
3. **Prompts the user** for each unique argument when the command is invoked

**Example command file:**
```markdown
# My Custom Command

Analyze the issue $ISSUE_NUMBER and check files in $DIRECTORY.
The issue number is $ISSUE_NUMBER again.
```

**Result:** OpenCode prompts for **2 arguments**:
- `ISSUE_NUMBER` (only once, even though it appears twice)
- `DIRECTORY`

### 2. Argument Substitution

Once the user provides values, OpenCode performs **simple string replacement**:

```go
// From internal/tui/page/chat.go
for name, value := range msg.Args {
    placeholder := "$" + name
    content = strings.ReplaceAll(content, placeholder, value)
}
```

**Key behavior:**
- **All occurrences** of each placeholder are replaced
- Replacement is **literal string substitution**
- **No array indexing** - there is no `$ARGUMENTS[0]` or `$ARGUMENTS[1]`
- **No special parsing** - the entire `$NAME` token is replaced with the user's input

### 3. Example Flow

**Command file: `analyze-issue.md`**
```markdown
# Analyze Issue $ISSUE_NUMBER

Fetch the issue details:
```bash
gh issue view $ISSUE_NUMBER --json title,body,comments
```

Search for related code:
```bash
git grep -n "issue.*$ISSUE_NUMBER"
```
```

**User invokes:** `/analyze-issue`

**OpenCode prompts:** 
```
Command Arguments
─────────────────
ISSUE_NUMBER: [user enters "42"]
```

**After substitution:**
```markdown
# Analyze Issue 42

Fetch the issue details:
```bash
gh issue view 42 --json title,body,comments
```

Search for related code:
```bash
git grep -n "issue.*42"
```
```

## Common Misconceptions

### ❌ Array Indexing Does NOT Work

The official docs show examples like:
```markdown
Create a new React component named $ARGUMENTS
```

This might suggest you could use `$ARGUMENTS[0]` to access individual arguments, but **this is incorrect**.

**What happens with `$ARGUMENTS[0]`:**
```markdown
# Command file
/orchestrate-single-update-from-feedback
  - $assignment_inputs = `$ARGUMENTS[0]`
```

**User provides:** `./debriefs`

**Result after substitution:** `./debriefs[0]` (literal `[0]` appended!)

**Why?** OpenCode sees `$ARGUMENTS` as the named argument and replaces it with `./debriefs`. The `[0]` is treated as literal text, not as an index operator.

### ✅ Correct Multi-Argument Pattern

To accept multiple distinct values, use **multiple named arguments**:

```markdown
# Correct approach
/my-command
  - $workflow_name = `$WORKFLOW_NAME`
  - $workflow_assignment = `$ASSIGNMENT_NAME`
  - $assignment_inputs = `$INPUTS_PATH`
```

**User will be prompted for:**
1. `WORKFLOW_NAME`
2. `ASSIGNMENT_NAME`
3. `INPUTS_PATH`

Each gets substituted independently.

## Technical Implementation Details

### Source Code References

**Argument detection:**
```go
// internal/tui/components/dialog/custom_commands.go
var namedArgPattern = regexp.MustCompile(`\$([A-Z][A-Z0-9_]*)`)

matches := namedArgPattern.FindAllStringSubmatch(commandContent, -1)
if len(matches) > 0 {
    // Extract unique argument names
    argNames := make([]string, 0)
    argMap := make(map[string]bool)
    
    for _, match := range matches {
        argName := match[1] // Group 1 is the name without $
        if !argMap[argName] {
            argMap[argName] = true
            argNames = append(argNames, argName)
        }
    }
}
```

**Argument substitution:**
```go
// internal/tui/page/chat.go
content := msg.Content
if msg.Args != nil {
    // Replace all named arguments with their values
    for name, value := range msg.Args {
        placeholder := "$" + name
        content = strings.ReplaceAll(content, placeholder, value)
    }
}
```

**Multi-argument dialog:**
```go
// internal/tui/components/dialog/arguments.go
type MultiArgumentsDialogCmp struct {
    inputs     []textinput.Model  // One input per unique argument
    argNames   []string           // Names extracted from pattern
    content    string             // Original command content
}
```

## Best Practices

### 1. Use Descriptive Names

```markdown
# ✅ Good - clear purpose
$ISSUE_NUMBER
$AUTHOR_NAME
$SEARCH_PATTERN
$TARGET_DIRECTORY

# ❌ Bad - unclear meaning
$ARG1
$X
$TEMP
```

### 2. Reuse Arguments for Consistency

```markdown
# Analyze PR $PR_NUMBER

Fetch PR details:
gh pr view $PR_NUMBER

Get PR files:
gh pr diff $PR_NUMBER

Check PR status:
gh pr checks $PR_NUMBER
```

**User only prompted once** for `PR_NUMBER`, but it's used three times.

### 3. Avoid Ambiguous Naming

```markdown
# ❌ Confusing - which is which?
$FILE
$FILE_PATH
$FILEPATH

# ✅ Clear - distinct purposes
$SOURCE_FILE
$DESTINATION_FILE
$CONFIG_FILE
```

### 4. Document Expected Input Format

```markdown
# Update Workflow Assignment

<!-- Expected format for $ASSIGNMENT_NAME: lowercase-kebab-case -->
<!-- Expected format for $DEBRIEF_DIR: relative path like ./debriefs -->

/orchestrate-dynamic-workflow
  - $workflow_name = `single-workflow`
  - $workflow_assignment = `$ASSIGNMENT_NAME`
  - $assignment_inputs = `debrief-directory: $DEBRIEF_DIR`
```

## Limitations

1. **No default values** - User must provide all arguments (can't be empty)
2. **No validation** - OpenCode accepts any string for any argument
3. **No array syntax** - Can't pass multiple values to a single argument
4. **No escape sequences** - Can't include a literal `$FOO` in output
5. **No nested substitution** - Arguments can't reference other arguments

## Comparison to Other Systems

| Feature | OpenCode | Bash | Make |
|---------|----------|------|------|
| Syntax | `$NAME` | `$1`, `$2`, `${VAR}` | `$(VAR)` |
| Indexing | ❌ No | ✅ Yes (`$1`, `$@`) | ❌ No |
| Default values | ❌ No | ✅ Yes (`${1:-default}`) | ✅ Yes |
| Named args | ✅ Yes | ❌ No (positional) | ✅ Yes |
| Validation | ❌ No | ✅ Yes (via script) | ❌ No |

## Troubleshooting

### Problem: `$ARGUMENTS[0]` prints literally

**Symptom:**
```
Expected: ./debriefs
Got: ./debriefs[0]
```

**Cause:** OpenCode replaces `$ARGUMENTS` with the value, leaving `[0]` as literal text.

**Solution:** Remove the `[0]` - use `$ARGUMENTS` alone or use separate named args.

### Problem: Argument not replaced

**Symptom:**
```
Command output still contains: $MY_ARG
```

**Causes:**
1. Argument name doesn't match pattern (lowercase, starts with number, etc.)
2. Typo in argument name (case-sensitive)
3. Extra characters attached (e.g., `$ARG1_` vs `$ARG1 _`)

**Solution:** Verify argument name matches `^[A-Z][A-Z0-9_]*$` pattern.

### Problem: Need to pass complex data structure

**Symptom:**
```
Want to pass: {"key": "value", "items": [1,2,3]}
```

**Limitation:** OpenCode arguments are **strings only**.

**Workaround:** 
1. Pass as JSON string: `$JSON_DATA` → `'{"key":"value"}'`
2. Pass file path: `$CONFIG_FILE` → `./config.json`
3. Use multiple args: `$KEY` → `mykey`, `$VALUE` → `myvalue`

## Examples

### Simple Command

```markdown
# Create Component $COMPONENT_NAME

Create a new React component:
```typescript
// $COMPONENT_NAME.tsx
export const $COMPONENT_NAME = () => {
  return <div>$COMPONENT_NAME Component</div>;
};
```
```

### Complex Multi-Argument Command

```markdown
# Deploy $SERVICE to $ENVIRONMENT

Check current status:
kubectl get deployment $SERVICE -n $ENVIRONMENT

Apply configuration:
kubectl apply -f deployments/$SERVICE-$ENVIRONMENT.yaml

Verify deployment:
kubectl rollout status deployment/$SERVICE -n $ENVIRONMENT
```

### Workflow Orchestration Command

```markdown
# Run Single Workflow Assignment

/orchestrate-dynamic-workflow
  - $workflow_name = `single-workflow`
  - $workflow_assignment = `$ASSIGNMENT_NAME`
  - $assignment_inputs = `$INPUTS_YAML`
```

## Conclusion

OpenCode's argument system is **simple but powerful**:
- Uses named placeholders (not positional)
- Performs literal string replacement (not variable evaluation)
- Prompts for unique arguments (eliminates duplicates)
- Supports any string value (no type checking)

Understanding these fundamentals prevents confusion and enables effective command creation.

## Additional Resources

- [OpenCode Official Docs](https://opencode.ai/docs/commands/#arguments)
- [OpenCode GitHub Repository](https://github.com/opencode-ai/opencode)
- Source file: `internal/tui/components/dialog/custom_commands.go`
- Test file: `internal/tui/components/dialog/custom_commands_test.go`
