---
hide:
  - footer
  - navigation
  - toc

component_beautified: Kosher Arsenal
component: kosherArsenal

name_beautified: Init
name: init
parameters:
    - loadouts:
        type: Array
        description: An array containing the filenames for loadouts to load (ommit .sqf from the filename).
    - forcePrimary:
        type: Boolean
        description: (Optional, default true) When true will force the unit to select a primary weapon before exiting the arsenal.
examples:
    - '[["exampleLoadout"], true, false, true] call cmf_kosherArsenal_fnc_init;'
    - "// Defines loadout files for team 0 and 1.\n[[\"exampleLoadout0\", \"exampleLoadout1\"], false] call cmf_kosherArsenal_fnc_init;"
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