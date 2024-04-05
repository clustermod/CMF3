---
hide:
  - footer
  - navigation
  - toc

component_beautified: Kosher Arsenal
component: kosherArsenal

name_beautified: Ammobox
name: ammobox
parameters:
    - object:
        type: Object
        description: The object to set as an ammobox
examples:
    - "[_myBox] call cmf_kosherArsenal_fnc_ammobox;"
---

# {{name_beautified}}

<h1 class="function" markdown>{{FUNC(component, name_beautified)}}</h1>


<h2 class="function">Description</h2>
<table class="function-table">
    <tr><th>Description:</th> <td>This function will initialize kosherArsenal for the local player.</td></tr>
    <tr><th>Execution:</th> <td>Call</td></tr>
    <tr><th>Groups:</th> <td>{{component_beautified}}</td></tr>
</table>

<h2 class="function">Syntax</h2>
<table class="function-table">
    <tr><th>Syntax:</th> <td>{{FUNC_SYNTAX(parameters, component, name)}}</td></tr>
    <tr><th>Parameters:</th> <td markdown>
    {{FUNC_PARAMS(parameters)}}
    </td></tr>
    <tr><th>Return Value:</th> <td>None</td></tr>
</table>

<h2 class="function">Examples</h2>
<table class="function-table">
    {{FUNC_EXAMPLES(examples)}}
</table>