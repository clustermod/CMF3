---
hide:
  - footer
  - navigation
  - toc

component_beautified: 3DEN
component: 3den

name_beautified: AddToInit
name: addToInit
description: Adds a line of code to a 3den entity's init
execution: Call
parameters:
    - entity:
        type: Object
        description: 3DEN entity.
    - line:
        type: String
        description: Line to add.
return:
    description: None
examples:
    - '[_entity, "this allowDamage false"] call cmf_3den_fnc_addToInit'
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