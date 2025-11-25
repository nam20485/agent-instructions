# Context Delivery Strategies

This document outlines three approaches for delivering instruction context to AI agents, ranging from simple parameterization to full RAG-based retrieval.

**Related:** [optimization-strategies-gpt51.md](../optimization-strategies-gpt51.md)

---

## Overview

| Strategy   | Name             | Effort     | Effectiveness | Best For                      |
| ---------- | ---------------- | ---------- | ------------- | ----------------------------- |
| **Plan A** | Branch Parameter | ~1 hour    | Low-Medium    | Testing branches before merge |
| **Plan B** | Dynamic Loader   | ~2-4 hours | Medium        | Multi-environment deployments |
| **Plan C** | RAG-Based MCP    | ~2-3 weeks | High          | Large corpus, semantic search |

---

## Plan A: Branch Parameter

### Summary
Parameterize the branch name in the entry point file, allowing agents to fetch instructions from any branch without code changes to the canonical repository.

### Current State
The loading protocol in `.github/copilot-instructions.md` uses hardcoded URLs:
```
https://raw.githubusercontent.com/nam20485/agent-instructions/main/...
```

### Proposed Change
Add a `<branch>` configuration element and use it in all URL constructions:

```xml
<instruction_source>
  <repository>
    <name>nam20485/agent-instructions</name>
    <url>https://github.com/nam20485/agent-instructions/tree/{branch}</url>
    <branch>main</branch>  <!-- Change to 'optimization' to test that branch -->
  </repository>
</instruction_source>

<loading_protocol>
  <algorithm name="url_translation">
    <step>Start with branch from config: {branch}</step>
    <step>Construct base: https://raw.githubusercontent.com/nam20485/agent-instructions/{branch}/</step>
    <step>Append file path to base URL</step>
  </algorithm>
</loading_protocol>
```

### Implementation
1. Edit `.github/copilot-instructions.md` to add `<branch>` element
2. Update URL examples to use `{branch}` placeholder
3. Document that changing `<branch>main</branch>` to `<branch>optimization</branch>` switches the source

### Where to Specify
**Client side** - The requesting agent's entry point file determines which branch to fetch. The remote repository is stateless and simply serves files.

### Pros
- Simple, immediate implementation
- No infrastructure changes required
- Easy to understand and modify
- Reversible (just change branch name back)

### Cons
- Requires manual edit to switch branches
- No validation that branch exists
- Could accidentally leave on wrong branch

### Use Cases
- Testing optimized instructions before merging to `main`
- Running experimental instruction sets
- A/B testing different instruction versions

---

## Plan B: Dynamic Loader

### Summary
Create a loader script that reads branch configuration from environment variables or parameters, constructing URLs dynamically at runtime.

### Architecture
```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│  Environment    │────▶│  Loader Script  │────▶│  GitHub Raw     │
│  Variable or    │     │  (PowerShell)   │     │  Content        │
│  Parameter      │     │                 │     │                 │
│                 │     │  Constructs     │     │  Serves files   │
│  INSTRUCTION_   │     │  URLs from      │     │  from specified │
│  BRANCH=opt     │     │  branch param   │     │  branch         │
└─────────────────┘     └─────────────────┘     └─────────────────┘
```

### Implementation Sketch
```powershell
# scripts/load-instructions.ps1
param(
    [string]$Branch = $env:INSTRUCTION_BRANCH ?? "main",
    [string[]]$Files = @("ai-core-instructions.md", "ai-workflow-assignments.md")
)

$baseUrl = "https://raw.githubusercontent.com/nam20485/agent-instructions/$Branch/ai_instruction_modules"

foreach ($file in $Files) {
    $url = "$baseUrl/$file"
    $content = Invoke-RestMethod -Uri $url
    # Process or output content
}
```

### Where to Specify
**Either side:**
- Client can set `INSTRUCTION_BRANCH` env var
- Or pass `-Branch optimization` parameter
- Default falls back to `main`

### Pros
- No file edits needed to switch branches
- Can be automated in CI/CD pipelines
- Supports environment-specific configurations
- Could add branch validation

### Cons
- Requires loader script infrastructure
- More complex than Plan A
- Agents need to know to use the loader

### Use Cases
- CI/CD pipelines testing different instruction versions
- Multi-environment deployments (dev/staging/prod)
- Automated branch switching based on context

---

## Plan C: RAG-Based MCP Server

### Summary
Convert the instruction corpus into vector embeddings stored in a database, then expose semantic search via an MCP (Model Context Protocol) server. Agents query for relevant context rather than loading everything upfront.

### Architecture
```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│   Agent (Chat)  │────▶│   MCP Server    │────▶│  Vector DB      │
│                 │     │  (instructions) │     │  (embeddings)   │
│  "How do I      │     │                 │     │                 │
│   create a PR?" │     │  Tools:         │     │  - Chunked docs │
│                 │◀────│  - search()     │◀────│  - Metadata     │
│  [Relevant      │     │  - get_file()   │     │  - Similarity   │
│   context]      │     │  - list_topics()│     │                 │
└─────────────────┘     └─────────────────┘     └─────────────────┘
```

### Components

#### 1. Chunking & Embedding Pipeline
- Split markdown files into semantic chunks (~500-1000 tokens each)
- Preserve metadata (file path, section headers, scope)
- Generate embeddings using OpenAI/Anthropic/local model
- Store in vector database

#### 2. Vector Database Options
| Option              | Hosted     | Cost | Complexity |
| ------------------- | ---------- | ---- | ---------- |
| **Chroma**          | Local/Self | Free | Low        |
| **pgvector**        | Self       | Free | Medium     |
| **Pinecone**        | Cloud      | $$   | Low        |
| **Azure AI Search** | Cloud      | $$$  | Medium     |

#### 3. MCP Server Tools
```typescript
interface InstructionMCPServer {
  // Semantic search across all instructions
  search(query: string, topK?: number): SearchResult[];
  
  // Get specific file by path
  getFile(path: string): string;
  
  // List available topics/categories  
  listTopics(): Topic[];
  
  // Get instructions related to a given file
  getRelated(path: string): string[];
  
  // Get all files matching a scope (e.g., "workflow", "testing")
  getByScope(scope: string): string[];
}

interface SearchResult {
  content: string;
  filePath: string;
  section: string;
  score: number;
  metadata: Record<string, string>;
}
```

### Effort Breakdown

| Component                     | Effort         | Complexity  |
| ----------------------------- | -------------- | ----------- |
| Chunking + embedding pipeline | 2-3 days       | Medium      |
| Vector DB setup               | 1-2 days       | Low-Medium  |
| MCP server with search tools  | 3-5 days       | Medium      |
| Integration + testing         | 2-3 days       | Medium      |
| **Total**                     | **~2-3 weeks** | Medium-High |

### Effectiveness Assessment

**Context Reduction:**
- Current auto-load: ~59KB (~15,000 tokens)
- With RAG: ~2-5KB per query (~500-1,500 tokens)
- **Reduction: 90-95%** of base context

**Search Quality:**
- Semantic search finds relevant content even without exact keyword match
- Example: "How do I handle PR comments?" → finds `ai-pr-comment-protocol.md`
- Can rank by relevance, recency, or custom scoring

### Recommended Hybrid Approach

Keep a **minimal core** auto-loaded (~20KB):
- `ai-core-instructions.md` - Essential behaviors
- `ai-personal-preferences.md` - Interaction contract
- `ai-quick-reference.md` - Cheat sheet

Use **RAG for everything else**:
- Workflow assignments
- Tech-specific guides (ASP.NET, PowerShell, etc.)
- Examples and templates
- Troubleshooting guides

This gives agents baseline knowledge to know *what to ask for*.

### Pros
- Massive context reduction (90%+)
- Semantic search capability
- Scales to any corpus size
- New files automatically indexed
- Can support multiple instruction sets/versions

### Cons
- Significant implementation effort
- Retrieval quality depends on chunking/embedding strategy
- Adds latency (~100-300ms per search)
- Requires infrastructure (DB, server)
- Agent doesn't "know" system upfront - must query

### Quick Win: File-Based MCP First
Before full RAG, build a simpler MCP server (~1 week):
1. List available instruction files with descriptions
2. Return file contents on request
3. Basic keyword/fuzzy search (no embeddings)

This proves the concept before investing in vector infrastructure.

### Use Cases
- Large instruction corpora (100+ files)
- Dynamic/frequently updated instructions
- Multi-tenant instruction systems
- Context-sensitive instruction delivery

---

## Comparison Matrix

| Aspect                  | Plan A      | Plan B        | Plan C           |
| ----------------------- | ----------- | ------------- | ---------------- |
| **Implementation Time** | 1 hour      | 2-4 hours     | 2-3 weeks        |
| **Context Reduction**   | 0%          | 0%            | 90%+             |
| **Branch Switching**    | Manual edit | Env var/param | N/A (serves all) |
| **Search Capability**   | None        | None          | Semantic         |
| **Infrastructure**      | None        | Script        | DB + Server      |
| **Maintenance**         | Low         | Low           | Medium           |
| **Scalability**         | Limited     | Limited       | High             |

---

## Recommendation

### Short Term (Now)
Implement **Plan A** to enable testing the `optimization` branch without merging.

### Medium Term (Next Sprint)
Consider **Plan B** if you need automated branch switching for CI/CD.

### Long Term (When Corpus Grows)
Invest in **Plan C** when:
- Corpus exceeds ~150KB auto-loaded
- You need semantic search capability
- Multiple instruction versions need to coexist
- Context window pressure becomes critical

---

## Implementation Status

| Plan   | Status       | Date | Notes                                       |
| ------ | ------------ | ---- | ------------------------------------------- |
| Plan A | 🔄 Pending    | -    | Awaiting approval                           |
| Plan B | 📋 Documented | -    | Future consideration                        |
| Plan C | 📋 Documented | -    | Aligns with Strategy C1 in optimization doc |

---

*Last Updated: 2025-11-24*
