<navigation_guide>
# Quick Start: AI Instruction Modules Navigation

This is your **quick reference card** for navigating the AI instruction modules system. Print this, bookmark it, or keep it open while working.

## 🎯 Start Here

**Entry Point:** [ai-core-instructions.md](./ai-core-instructions.md)
- Read the meta-guide section (near the top)
- Identifies which comprehensive guide you need
- Provides overview of the entire system

**Authentication Setup:** [ai-gh-authentication.md](./ai-gh-authentication.md)
- Required for GitHub CLI operations
- Covers both interactive and non-interactive authentication
- Essential for workflow assignments that interact with GitHub

<comprehensive_guides>
## 📚 Three Comprehensive Guides

Choose the guide that matches your current activity:

### 1. 🔧 Workflow Development
**File:** [ai-workflow-development-guide.md](./ai-workflow-development-guide.md)

**Use When:**
- Creating workflow assignments
- Writing dynamic workflow scripts
- Orchestrating workflow execution
- Validating workflow syntax
- Troubleshooting workflow failures

**Quick Access:**
- DSL syntax reference
- Event system (6 types)
- Orchestrator patterns
- Validation procedures

---

### 2. 💻 Application Development
**File:** [ai-application-development-guide.md](./ai-application-development-guide.md)

**Use When:**
- Creating new applications
- Adding features
- Refactoring code
- Reviewing code
- Writing tests

**Quick Access:**
- Tech stack (.NET 9.0+, ASP.NET Core, Blazor)
- Design principles (SOLID, 12-Factor, DDD)
- ASP.NET patterns
- Code quality standards

---

### 3. 🛠️ Development Environment
**File:** [ai-development-environment-guide.md](./ai-development-environment-guide.md)

**Use When:**
- Setting up environments
- Managing terminals
- Writing PowerShell scripts
- Using GitHub CLI
- Pinning tool versions

**Quick Access:**
- Environment types
- Tool versions
- Terminal best practices
- PowerShell patterns
- GitHub CLI commands

---

## 🔍 What's Inside Each Guide?

All guides follow the same structure:

```
1. Purpose & When to Use        ← What this guide covers
2. Quick Reference              ← Fast lookups (versions, patterns, conventions)
3. Canonical Reference Files    ← Links to detailed specs
4. Common Workflows             ← Step-by-step procedures
5. Troubleshooting              ← Common problems and solutions
6. Examples                     ← Practical code samples
7. Summary                      ← Key takeaways
```

## 📖 When to Use Canonical Files

**Comprehensive guides** are for:
- ✅ Quick lookups
- ✅ Common workflows
- ✅ Troubleshooting
- ✅ Code examples
- ✅ Getting oriented

**Canonical files** are for:
- ✅ Complete specifications
- ✅ Detailed requirements
- ✅ Edge cases
- ✅ Advanced configurations
- ✅ Authoritative reference

**Pro tip:** Start with the comprehensive guide, follow links to canonical files when you need more detail.

## 🗺️ Visual Architecture

See complete visual diagrams:
- **Architecture Overview:** [ai-comprehensive-guides-architecture.md](./ai-comprehensive-guides-architecture.md)
- **Mermaid Diagrams:** [ai-comprehensive-guides-diagrams.md](./ai-comprehensive-guides-diagrams.md)
</comprehensive_guides>

<common_scenarios>
## ⚡ Common Scenarios

### "I need to create a new REST API"
1. Open [ai-application-development-guide.md](./ai-application-development-guide.md)
2. Go to "Common Workflows → Creating a New Application"
3. Follow the 8-step procedure
4. Reference canonical files as needed

### "Terminal session is consuming too many resources"
1. Open [ai-development-environment-guide.md](./ai-development-environment-guide.md)
2. Go to "Troubleshooting → Terminal Management Issues"
3. Find your problem and solution
4. Reference [ai-terminal-management.md](./ai-terminal-management.md) for complete specs

### "I need to write a dynamic workflow"
1. Open [ai-workflow-development-guide.md](./ai-workflow-development-guide.md)
2. Check "Quick Reference → DSL Syntax" for syntax overview
3. Go to "Common Workflows → Creating Dynamic Workflow"
4. Reference [dynamic-workflow-syntax.md](./ai-workflow-assignments/dynamic-workflows/dynamic-workflow-syntax.md) for complete DSL

### "What PowerShell naming convention should I use?"
1. Open [ai-development-environment-guide.md](./ai-development-environment-guide.md)
2. Go to "Quick Reference → PowerShell Quick Reference"
3. Find naming conventions (Verb-Noun, PascalCase, etc.)

### "My build is failing with warnings as errors"
1. Open [ai-application-development-guide.md](./ai-application-development-guide.md)
2. Go to "Troubleshooting → Common Build Errors"
3. Find "warnings as errors" issue with solution

## 📋 Canonical Files Reference

### Workflow Development (4 files)
- [ai-workflow-assignments.md](./ai-workflow-assignments.md)
- [orchestrate-dynamic-workflow.md](./ai-workflow-assignments/orchestrate-dynamic-workflow.md)
- [dynamic-workflow-syntax.md](./ai-workflow-assignments/dynamic-workflows/dynamic-workflow-syntax.md)
- [validate-dynamic-workflow-script.md](./ai-workflow-assignments/validate-dynamic-workflow-script.md)

### Application Development (3 files)
- [ai-application-guidelines.md](./ai-application-guidelines.md)
- [ai-design-principles.md](./ai-design-principles.md)
- [ai-instructions-aspnet-guidelines.md](./ai-instructions-aspnet-guidelines.md)

### Environment & Tools (4 files)
- [ai-local-environment.md](./ai-local-environment.md)
- [ai-terminal-management.md](./ai-terminal-management.md)
- [ai-powershell-instructions.md](./ai-powershell-instructions.md)
- [ai-working-command-examples.md](./ai-working-command-examples.md)

## 🎓 Learning Path

### Day 1: Getting Oriented
1. Read [ai-core-instructions.md](./ai-core-instructions.md) meta-guide section
2. Skim all three comprehensive guides (just the "Purpose" sections)
3. Bookmark this quick start guide

### Week 1: Basic Usage
1. Use comprehensive guides for quick reference
2. Follow common workflows for standard tasks
3. Note which canonical files you reference most

### Month 1: Advanced Usage
1. Deep dive into canonical files for your specialty area
2. Understand when to use guides vs canonical files
3. Contribute improvements to guides or files
</common_scenarios>

<pro_tips>
## 💡 Pro Tips

1. **Start broad, go deep:** Begin with comprehensive guide, drill down to canonical files
2. **Bookmark frequently used sections:** Keep quick reference sections handy
3. **Use search:** Ctrl+F within guides to find specific topics quickly
4. **Follow the links:** Guides link to canonical files at the right time
5. **Check examples first:** Sometimes seeing code is faster than reading specs

## 🆘 Need Help?

### Can't find what you need?
1. Check the meta-guide in [ai-core-instructions.md](./ai-core-instructions.md)
2. Search across all three comprehensive guides
3. Look in the visual architecture docs for relationships

### Something unclear?
1. Check the canonical file for detailed specifications
2. Look at examples in the comprehensive guide
3. Review troubleshooting sections

### Still stuck?
1. Check [ai-comprehensive-guides-architecture.md](./ai-comprehensive-guides-architecture.md) for system overview
2. Review [ai-comprehensive-guides-diagrams.md](./ai-comprehensive-guides-diagrams.md) for visual explanations

## 📊 Quick Stats

- **Total Comprehensive Guides:** 3 (1,501 lines)
- **Total Canonical Files:** 11 files
- **Coverage Areas:** Workflow, Application, Environment
- **Common Workflows:** 15 across all guides
- **Troubleshooting Sections:** 12 categories
- **Code Examples:** 16 practical samples

## 🔄 Update Frequency

- **Comprehensive Guides:** Updated when new patterns emerge or workflows change
- **Canonical Files:** Updated when specifications change (single source of truth)
- **This Quick Start:** Updated when guide structure changes

---

**Remember:** This is a hybrid system:
- **Guides** = Navigation + Quick Reference + Workflows
- **Canonical Files** = Complete Specifications + Authority

Use both! Start with guides, reference canonical files for details. 🚀
</pro_tips>
</navigation_guide>
