---
hide:
  - footer
  - navigation
  - toc

component_beautified: 3DEN
component: 3den

name_beautified: IconViewer
name: iconViewer
description: Opens a dialog where you can see all textures in arma 3 and copy out their path.
execution: Call
parameters:
    - mode:
        type: String
        description: Operation Mode.
    - arguments:
        type: Any
        description: Arguments for the operation mode.
return:
    description: None
examples:
    - '["onload"] call cmf_3den_fnc_iconViewer'
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