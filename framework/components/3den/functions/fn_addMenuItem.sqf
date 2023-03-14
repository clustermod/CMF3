#include "script_component.hpp"
/*
 * Author: Eric
 * Adds a menu item at given path
 *
 * Arguments:
 * 0: Path <ARRAY>
 * 1: Name <STRING>
 * 2: Icon (Default: "") <STRING>
 * 3: Action (Default: {}) <CODE>
 * 4: Action Params (Default: []) <ARRAY>
 *
 * Return Value:
 * Item index <NUMBER>
 *
 * Example:
 * [[0, 1], "My Menu", "", { systemChat (_this select 0) }, ["Hello World!"]] call cmf_3den_fnc_addMenuItem
 *
 * Public: Yes
 */
SCRIPT(addMenuItem);

params ["_path", "_name", ["_icon", ""], ["_action", nil], ["_actionParams", []]];

private _ctrlMenuStrip = findDisplay 313 displayCtrl 120;
private _index = _ctrlMenuStrip menuAdd [_path, _name];
_path pushBack _index;

if (_icon != "") then {
    _ctrlMenuStrip menuSetPicture [_path, _icon];
};

if (!isNil "_action") then {
    private _stringAction = toString _action;
    private _stringActionParams = str _actionParams;
    _ctrlMenuStrip menuSetAction [_path, format ["%1 spawn {%2}", _stringActionParams, _stringAction]];
};

_index;
