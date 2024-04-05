#include "script_component.hpp"
/*
 * Author: Eric
 * Create player actions for sharing the map
 * 
 * Arguments:
 * None
 * 
 * Return Value:
 * Actions <ARRAY>
 *	- 0: Path <ARRAY>
 *	- 1: Action <ARRAY>
 * 
 * Example:
 * call cmf_map_fnc_shareMapActions
 * 
 * Public: No
 */

/* Look at open map action */
private _lookAtMapAction = [QGVAR(lookAtMap), "Look at Map", "", {
    private _hasMap = "ItemMap" in assignedItems cmf_player;
    if (!_hasMap) then {
        cmf_player linkItem "ItemMap";
    };

    openMap [true, false];

    if (!_hasMap) then {
        [{ !visibleMap }, {
            cmf_player unlinkItem "ItemMap";
        }] call CBA_fnc_waitUntilAndExecute;
    };
}, { _target getVariable [QGVAR(visibleMap), false] }] call ace_interact_menu_fnc_createAction;

["CAManBase", 0, ["ACE_MainActions"], _lookAtMapAction, true] call ace_interact_menu_fnc_addActionToClass;

/* Drop map action */
private _readAction = [QGVAR(openMap), "Open Map", "", {
    private _hasMap = "ItemMap" in assignedItems cmf_player;
    if (!_hasMap) then {
        cmf_player linkItem "ItemMap";
    };

    openMap [true, false];

    if (!_hasMap) then {
        [{ !visibleMap }, {
            cmf_player unlinkItem "ItemMap";
        }] call CBA_fnc_waitUntilAndExecute;
    };
}, { true }] call ace_interact_menu_fnc_createAction;

["Land_Map_blank_F", 0, ["ACE_MainActions"], _readAction] call ace_interact_menu_fnc_addActionToClass;

private _pickUpAction = [QGVAR(takeMap), "Take Map", "", {
    cmf_player linkItem "ItemMap";
    deleteVehicle _target;
}, { !("ItemMap" in assignedItems cmf_player) }] call ace_interact_menu_fnc_createAction;

["Land_Map_blank_F", 0, ["ACE_MainActions"], _pickUpAction] call ace_interact_menu_fnc_addActionToClass;


private _action = [QGVAR(placeMap), "Put Map On Ground", "", {
    private _positionASL = cmf_player modelToWorldVisualWorld [0, 1, 0];

    private _map = "Land_Map_blank_F" createVehicle ASLToAGL _positionASL;
    _map setPosASL _positionASL;
    _map allowDamage false;

    cmf_player unlinkItem "ItemMap";
}, { "ItemMap" in assignedItems cmf_player }] call ace_interact_menu_fnc_createAction;

_action;