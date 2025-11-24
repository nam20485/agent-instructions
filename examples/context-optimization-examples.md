# Context Optimization Examples

## Example 1: XML Tags for Structure

```xml
<instructions>
  Your task instructions here
</instructions>

<context>
  Background information here
</context>

<examples>
  <example>
    Input: X
    Output: Y
  </example>
</examples>

<formatting>
  Output format specifications
</formatting>
```

## Example 2: Curated, Diverse Few-Shot Examples

```xml
<examples>
  <example id="basic">
    <input>Simple case scenario</input>
    <output>Expected response</output>
  </example>
  
  <example id="complex">
    <input>Complex case with multiple factors</input>
    <reasoning>Why this approach works...</reasoning>
    <output>Expected response</output>
  </example>
  
  <example id="edge">
    <input>Edge case scenario</input>
    <output>How to handle gracefully</output>
  </example>
</examples>
```

## Example 3: Hierarchical Task Decomposition

```xml
<task_structure>
  <phase_1>
    <goal>Clear, measurable objective</goal>
    <steps>
      <step>Atomic action 1</step>
      <step>Atomic action 2</step>
    </steps>
    <acceptance_criteria>
      <criterion>Testable condition 1</criterion>
      <criterion>Testable condition 2</criterion>
    </acceptance_criteria>
  </phase_1>
  
  <phase_2>
    <!-- Next phase after phase_1 completion -->
  </phase_2>
</task_structure>
```

## Example 4: Tool/Function Descriptions with Examples

```xml
<tool name="search_database">
  <purpose>Query the internal knowledge base for specific information</purpose>
  
  <when_to_use>
    - User asks about historical data
    - Need to verify facts before responding
    - Looking for specific technical specifications
  </when_to_use>
  
  <parameters>
    <param name="query" type="string" required="true">
      Natural language search query (be specific)
    </param>
    <param name="limit" type="int" required="false" default="10">
      Maximum results to return (1-50)
    </param>
  </parameters>
  
  <examples>
    <example>
      <scenario>User asks: "What were our Q3 sales?"</scenario>
      <call>search_database(query="Q3 sales figures 2024", limit=5)</call>
      <reasoning>Specific time period, quantitative data</reasoning>
    </example>
  </examples>
</tool>
```

## Example 5: Before/After Transformation

### Before Optimization:
```
File: rule1.md (50 lines)
"Here are some rules for coding. Try to write good code. 
Don't make mistakes. Be careful with edge cases..."

File: rule2.md (40 lines)
"Additional guidelines. Remember to test. 
Don't forget documentation..."

File: rule3.md (60 lines)
"More instructions about specific scenarios:
- If user asks X, don't do Y
- If system shows Z, avoid A
- Edge case 1: handle carefully
- Edge case 2: be cautious
- Edge case 3: watch out
..." (50 more edge cases)
```

### After Optimization:
```xml
File: comprehensive-instructions.md (1000 lines)

<instructions>
  <core_principles>
    Write idiomatic, well-tested code following project conventions.
    Prioritize readability and maintainability over cleverness.
    Include comprehensive error handling and logging.
  </core_principles>
  
  <workflow>
    1. Analyze requirements and acceptance criteria
    2. Design solution with clear interfaces
    3. Implement with test coverage
    4. Document public APIs and complex logic
    5. Review against style guide
  </workflow>
  
  <examples>
    <example id="basic_function">
      <scenario>Creating a data processing function</scenario>
      <input>
        Requirements: Parse CSV, validate data, return clean records
      </input>
      <output>
        ```python
        def parse_and_validate(csv_path: str) -> List[Record]:
            """Parse CSV and return validated records.
            
            Args:
                csv_path: Path to CSV file
                
            Returns:
                List of validated Record objects
                
            Raises:
                ValidationError: If data fails validation
            """
            # Implementation with error handling
        ```
      </output>
    </example>
    
    <example id="error_handling">
      <!-- Clear example of proper error handling -->
    </example>
    
    <example id="testing">
      <!-- Clear example of test structure -->
    </example>
  </examples>
  
  <formatting>
    Output format: Markdown with code blocks
    Include: Reasoning, implementation, tests
    Structure: Brief explanation → Code → Validation
  </formatting>
</instructions>
```
