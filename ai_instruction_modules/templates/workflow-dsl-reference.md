# Dynamic Workflow DSL Reference

## Variables
```markdown
`$variable` = <value>                    # Define variable
`${variable}` = <value>                  # Define variable (brace format)
const `$VARIABLE`: <value>               # Define constant
`$variable`                              # Use variable
${variable}                              # Use variable (brace format)
```

## Step References
```markdown
#<step>                                  # Reference output of a step
#<step>.<substep>                        # Reference output of substep/assignment
#events.<event-name>                     # Reference event output (singular)
#events.<event-name>.$assignment_name    # Reference event output (loop)
```

## Functions and Data Structures
```markdown
get-function-name(<parameters>)          # Call a function
[ item1, item2, item3 ]                  # Define a list
$object_variable->property               # Access object property
```

## Control Flow
```markdown
For each $item in $list, you will:       # Iterate over a list
  - indented action 1
  - indented action 2
  
if $variable is true:                    # Conditional (true)
  - indented action
  
if $variable is false:                   # Conditional (false)
  - indented action
```

## Orchestration Directives (Standard Pattern)
```markdown
- assign the agent the 'assignment-id' assignment with input $variable
- wait until the agent finishes the task
- review the work and approve it
- record output as #step.substep
```
