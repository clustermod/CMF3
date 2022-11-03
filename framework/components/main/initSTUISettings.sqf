#include "script_component.hpp"
/*
 * Author: Eric
 * Orders the group playerlist by color and leader
 *
 * Public: No
 */
SCRIPT(initSTUISettings);

/* Redefine the namelist function */
STHud_Namelist = {
    params ["_canvas"];

    private _units = [];
    {
    	if (count(_units) >= count(STHud_Namepos)) exitWith {};

    	if (alive(_x) || {!isNil {_x getVariable "sth_name"}}) then {
    		_units pushBack [_x, _x call STHud_Colour_Text];
    	};
    } forEach (units(player));

    private _unitsCount = count(_units);

    // Could expand this to check if the player is a driver, gunner, or commander, but I don't recall what exactly is needed to check to catch multiple turrets etc while excluding FFV.
    if (STHud_ShowBearingInVehicle && {vehicle player != player}) then {
    	private _viewVec = positionCameratoWorld [0,0,0] vectorFromTo (positionCameraToWorld [0,0,50]);
    	private _bearing = ((_viewVec select 0) atan2 (_viewVec select 1) + 360) % 360;

    	private _bearingBase = (str round _bearing);
    	private _bearingPretty = "";

    	switch (count _bearingBase) do
    	{
    		case 1: {_bearingPretty = "00" + _bearingBase};
    		case 2: {_bearingPretty = "0" + _bearingBase};
    		case 3: {_bearingPretty = _bearingBase};
    	};

    	private _bearingColour = [[1,1,1,.9], "STUI_Unconscious_Fade_HUD_Bearing"] call STHud_UnconsciousColourFade;

    	_canvas drawIcon
    	[
    		"#(argb,8,8,3)color(0,0,0,0)", _bearingColour,
    		STHud_Bearing,
    		16, 16, 0,
    		_bearingPretty, STHud_TextShadow, 0.035, STHud_Font, "Center"
    	];
    };

    if (_unitsCount == 1) exitWith {};

    private _fullName = _unitsCount < 7;

    _units = [_units, [], {
    	if ((leader group (_x select 0)) isEqualTo (_x select 0)) exitWith { 0 };
    	if ((assignedTeam leader group (_x select 0)) isEqualTo (assignedTeam (_x select 0))) exitWith { 1 };
    	switch (_x select 1) do {
    		case [1,1,1,1]: { 2 };
    		case [1,1,0.67,1]: { 3 };
    		case [1,0.67,0.67,1]: { 4 };
    		case [0.67,1,0.67,1]: { 5 };
    		case [0.67,0.67,1,1]: { 6 };
    		default { 5 };
    	};
    }] call BIS_fnc_sortBy;

    {
    	_x params ["_unit", "_colour"];
    	private _isUnitSelected = if ([player] call STHUD_IsGroupLeader) then {_unit in (groupSelectedUnits player)} else {false}; // Check if they're leader, if not, ignore.
    	private _selIndicator = "";
    	if (_isUnitSelected) then { _selIndicator = "> " }; // Tried this on the left and right. Being on the left seems to make it 'pop' more.
    	private _icon = [_unit, false] call STHud_Icon;

    	private _finalName = ([_unit, _fullName] call STHud_GetName);

    	if (STHud_NoSquadBarMode) then {_finalName = _selIndicator + _finalName;};

    	if (count (groupSelectedUnits player) > 0 && STHud_NoSquadBarMode) then
    	{
    		private _tempName = vehicleVarName _unit;
    		_unit setVehicleVarName "";
    		private _strName = str(_x);
    		_unit setVehicleVarName _tempName;
    		private _pl = _strName find ":";
    		private _numStr = _strName select [_pl +1,2];
    		if (_numStr find "," > -1 || _numStr find " " > -1) then {_numStr = _numStr select [0,1]};

    		private _selectedUnitsColour = [[1,1,1,1], "STUI_Unconscious_Fade_HUD_SelectedUnits"] call STHud_UnconsciousColourFade;

    		_canvas drawIcon
    		[
    			"#(argb,1,1,1)color(0,0,0,0)", _selectedUnitsColour,
    			STHud_Selectpos select _forEachIndex,
    			1, 1, 0,
    			_numStr, STHud_TextShadow, 0.035, STHud_Font, "Left"
    		];
    	};

    	private _nameColour = [_colour, "STUI_Unconscious_Fade_HUD_Names"] call STHud_UnconsciousColourFade;

    	_canvas drawIcon
    	[
    		_icon, _nameColour,
    		STHud_Namepos select _forEachIndex,
    		16, 16, 0,
    		_finalName, STHud_TextShadow, 0.035, STHud_Font, "Right"
    	];
    } forEach (_units);

    if (count (groupSelectedUnits player) > 0 && STHud_NoSquadBarMode) then
    {
    	private _groupNameColour = [[1,1,1,1], "STUI_Unconscious_Fade_HUD_GroupName"] call STHud_UnconsciousColourFade;

    	_canvas drawIcon
    	[
    		"#(argb,1,1,1)color(0,0,0,0)", _groupNameColour,
    		STHud_GroupNamePos,
    		16, 16, 0,
    		group(player) getVariable ["STMF_GroupID", ""], STHud_TextShadow, 0.035, STHud_Font, "Right"
    	];
    };
};

/* Raise event */
[QGVAR(onSTUIModified), []] call CBA_fnc_localEvent;
