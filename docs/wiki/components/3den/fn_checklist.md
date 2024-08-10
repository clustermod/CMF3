---
hide:
  - footer
  - navigation
  - toc

component_beautified: 3DEN
component: 3den

name_beautified: Checklist
name: checklist
description: Runs checks for a minimal list of required things for Cluster Community Missions
execution: Call
parameters:

return:
    type: Array
    description: Checklist status
examples:
    - "[] call cmf_3den_fnc_checklist;\n*\\ Returned values:\n
\t0: Player Units Present <BOOLEAN>\n
\t1: Zeus Present <BOOLEAN>\n
\t2: Respawn Module Present <BOOLEAN>\n
\t3: Kosher Arsenal Loadout Selected <BOOLEAN>\n
\t4: Kosher Arsenal Ammobox Present <BOOLEAN>\n
\t5: Mission Data Set <BOOLEAN>\n
*\\
"
---

# {{name_beautified}}

<h1 class="function" markdown>{{FUNC(component, name_beautified)}}</h1>


<h2 class="function">Description</h2>
<table class="function-table">
    <tr><th>Description:</th> <td>{{description}}</td></tr>
    <tr><th>Execution:</th> <td>{{execution}}</td></tr>
    <tr><th>Groups:</th> <td>{{component_beautified}}</td></tr>
</table>

<h2 class="function">Syntax</h2>
<table class="function-table">
    <tr><th>Syntax:</th> <td>{{FUNC_SYNTAX(parameters, component, name)}}</td></tr>
    <tr><th>Parameters:</th> <td markdown>
    {{FUNC_PARAMS(parameters)}}
    </td></tr>
    <tr><th>Return Value:</th> <td>{{FUNC_RETURN(return)}}</td></tr>
</table>

<h2 class="function">Examples</h2>
<table class="function-table">
    {{FUNC_EXAMPLES(examples)}}
</table>

<h2 class="function">Additional Information</h2>
!!! info "N/A"

<h2 class="function">Notes</h2>
<div class="function notes" markdown>

Report bugs on the [Issue Tracker]({{config.repo_url}}/issues) and/or discuss them on the [Cluster Community Discord ](#):fontawesome-brands-discord:.<br/>
**Only post proven facts here!**

[Add Note](#){ .md-button }

<!-- 
    TO ADD A NOTE COPY THE FOLLOWING:
!!! note

    Write note content here
    anything written with the current indentation will be added to this note
    ```scilab
        Code blocks should be formatted this way
    ```
 -->

</div>