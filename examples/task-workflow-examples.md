# Task-Based Workflow Examples

## GitHub CLI Commands

### Initial Setup (One-time per repository)
```bash
# Create the assigned:copilot label (only needs to be done once per repo)
gh label create assigned:copilot

# Create the state:in-progress label (only needs to be done once per repo)
gh label create state:in-progress
```

### Working with Issues
```bash
# Find issues assigned to you
gh issue list --label assigned:copilot

# Create an issue with assignment label
gh issue create --title "Task Title" --body "Description" --label assigned:copilot

# Add state:in-progress label to an issue
gh issue edit <issue_number> --add-label state:in-progress

# Remove state:in-progress label when complete
gh issue edit <issue_number> --remove-label state:in-progress
```

## Commit Message Format
```markdown
feat: implement user authentication

- Add Google OAuth integration
- Update user service with token validation
- Add authentication middleware

Closes #123
```
