#include "script_component.hpp"
/*
 * Author: Eric
 * disables shooting and throwing grenades upon mission start until zeus starts mission.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * <Boolean>
 *
 * Example:
 * call cmf_gameplay_fnc_safeStart
 *
 * public: Yes
*/
SCRIPT(safestart);

if (!isServer) exitWith {};

if !(GVAR(setting_safestart)) exitWith {};

LOG("Enabled safestart");

/* Automatic phases */
missionNameSpace setVariable [QGVAR(safestart_phase), ["Pre-Start", 0], true];
[{ (systemTime select 3) >= 19 }, {
    missionNameSpace setVariable [QGVAR(safestart_phase), ["Briefing", time], true];
}] call CBA_fnc_waitUntilAndExecute;

addMissionEventHandler ["EntityRespawned", {
    params ["_unit", "_body"];

    /* Delete old body */
    deleteVehicle _body;

    /* If the unit is not a player exit */
    if (!isPlayer _unit) exitWith { };

    /* If safestart has been disabled delete this eventHandler */
    if (missionNamespace getVariable [QGVAR(safestart_disable), false]) exitWith {
        removeMissionEventHandler ["EntityRespawned", _thisEventHandler];
        _unit allowDamage true;
    };

    /* Execute code where unit is local */
    [_this, {
        params ["_unit"];

        /* Show hint to player while safestart is active */
        [{
            private _safestartHint = "<t size='1.5' color='#fcba03'>SafeStart</t><br/>";

            /* Safestart Mission Title */
            private _missionData = missionNameSpace getVariable [QEGVAR(common,missionData), []];
            private _hash = [_missionData] call CBA_fnc_hashCreate;

            private _title = [_hash, "M_TITLE", [getMissionConfigValue ['IntelBriefingName', briefingName]] call EFUNC(utility,hexToASCII)] call CBA_fnc_hashGet;
            private _safestartHint = _safestartHint + format["<t size='1' color='#888888'>%1</t><br/>", _title];

            /* Safestart phase */
            private _phase = missionNameSpace getVariable [QGVAR(safestart_phase), ["Pre-Start", 0]];
            private _startTime = _phase select 1;

            _safestartHint = _safestartHint + format [
                "<t align='left'>%1</t> <t align='right' font='PuristaBold'>%2</t><br/>",
                (_phase select 0),
                [(time - _startTime), 'MM:SS'] call BIS_fnc_secondsToString
            ];

            /* Cutoffs */
            private _cutoffPhases = missionNameSpace getVariable [QGVAR(safestart_phaseCutOffs), []];
            {
                if ((_x select 1) > ((time - _startTime))) then {
                    _safestartHint = _safestartHint + format [
                        "<t align='left' color='#888888' size='0.95'>%1 Cut-off</t> <t align='right' color='#888888' size='0.95'>%2</t><br/>",
                        (_x select 0),
                        [(_x select 1) - (time), 'MM:SS'] call BIS_fnc_secondsToString
                    ];
                } else {
                    [] spawn compile (_x select 2);
                    _cutoffPhases deleteAt (_cutoffPhases find _x);
                };
            } forEach _cutoffPhases;
            missionNameSpace setVariable [QGVAR(safestart_phaseCutOffs), _cutoffPhases, true];

            _safestartHint = _safestartHint + "<br/><br/>";

            /* Safestart mission meta */
            _safestartHint = _safestartHint + "<t size='0.9'>";
            private _missionData = missionNameSpace getVariable [QEGVAR(common,missionData), []];
            private _equipment = [_missionData] call CBA_fnc_hashCreate;
            if (([_equipment, "E_MAP", ""] call CBA_fnc_hashGet) != "") then {_safestartHint = _safestartHint + format["<t align='left' color='#888888'>Maps:</t> <t align='right' color='#888888'>%1</t><br/>", [_equipment, "E_MAP"] call CBA_fnc_hashGet]; };
            if (([_equipment, "E_GPS", ""] call CBA_fnc_hashGet) != "") then {_safestartHint = _safestartHint + format["<t align='left' color='#888888'>GPS:</t> <t align='right' color='#888888'>%1</t><br/>", [_equipment, "E_GPS"] call CBA_fnc_hashGet]; };
            if (([_equipment, "E_RADIO", ""] call CBA_fnc_hashGet) != "") then {_safestartHint = _safestartHint + format["<t align='left' color='#888888'>Radios:</t> <t align='right' color='#888888'>%1</t><br/>", [_equipment, "E_RADIO"] call CBA_fnc_hashGet]; };
            if (([_equipment, "E_NVG", ""] call CBA_fnc_hashGet) != "") then {_safestartHint = _safestartHint + format["<t align='left' color='#888888'>NVGs:</t> <t align='right' color='#888888'>%1</t><br/>", [_equipment, "E_NVG"] call CBA_fnc_hashGet]; };
            if (([_equipment, "E_FLASHLIGHT", ""] call CBA_fnc_hashGet) != "") then {_safestartHint = _safestartHint + format["<t align='left' color='#888888'>Flashlights:</t> <t align='right' color='#888888'>%1</t><br/>", [_equipment, "E_FLASHLIGHT"] call CBA_fnc_hashGet]; };
            if (([_equipment, "E_FLARE", ""] call CBA_fnc_hashGet) != "") then {_safestartHint = _safestartHint + format["<t align='left' color='#888888'>Flares:</t> <t align='right' color='#888888'>%1</t><br/>", [_equipment, "E_FLARE"] call CBA_fnc_hashGet]; };
            if (uniform player != '') then {
                _safestartHint = _safestartHint + format["<t align='left'>Uniform:</t> <t align='right'>%1</t><br/>", [configFile >> "CfgWeapons" >> (uniform player)] call BIS_fnc_displayName];
            };
            if (primaryWeapon player != '') then {
                _safestartHint = _safestartHint + format["<t align='left'>Loadout:</t> <t align='right'>%1</t><br/>", [configFile >> "CfgWeapons" >> (primaryWeapon player)] call BIS_fnc_displayName];
            };
            if ([player] call EFUNC(respawn,getLimit) != -1) then {
                _safestartHint = _safestartHint + format["<t align='left'>Respawns:</t> <t align='right'>%1</t><br/>", [player] call EFUNC(respawn,getLimit)];
            };
            _safestartHint = _safestartHint + "<br/>";

            /* Get radio info */
            private _pttAssign = [] call acre_api_fnc_getMultiPushToTalkAssignment;
            {
                _safestartHint = _safestartHint + format[
                    "<t align='left' color='#888888'>%1 Chan %2</t> <t align='right'><t>PTT %3, %4</t></t><br/>",
                    [_x] call acre_api_fnc_getDisplayName,
                    [_x] call acre_api_fnc_getRadioChannel,
                    (_pttAssign find _x) + 1,
                    switch (([_x] call acre_api_fnc_getRadioSpatial)) do { case "LEFT": { "L" }; case "RIGHT": { "R" }; case "CENTER": { "B" }; }
                ];
            } forEach call acre_api_fnc_getCurrentRadioList;
            _safestartHint = _safestartHint + "<br/>";

            /* Group and player info */
            _safestartHint = _safestartHint + format ["<t size='1.3' align='left' color='#237523'>%1</t><br/>", groupId group player];
            {
                _safestartHint = _safestartHint + format[
                    "<t align='left'><t color='#fcba03' size='1'>%1</t>  <t color='#888888' size='0.9'>%2, %3kg</t></t> <t align='right' size='1' color='#fcba03'>%4</t><br/>",
                    name _x,
                    [_x] call EFUNC(organization,getRole),
                    ((loadAbs _x / 10) / 2.205) toFixed 2,
                    switch (rank _x) do {
                        case 'PRIVATE': { "Pvt" };
                        case 'CORPORAL': { "Cpl" };
                        case 'SERGEANT': { "Sgt" };
                        case 'LIEUTENANT': { "Lt" };
                        case 'CAPTAIN': { "Cpt" };
                        case 'MAJOR': { "Maj" };
                        case 'COLONEL': { "Col" };
                        default { "" };
                    }
                ];
            } forEach units group player;

            /* Exit if safestart countdown has been called */
            if (missionNameSpace getVariable [QGVAR(safestart_Countdown), false]) exitWith {};

            /* Show hint if hud isn't disabled */
            if (missionNameSpace getVariable [QEGVAR(menu,hud_show), true]) then {
                hintSilent parseText _safestartHint;
            } else {
                hintSilent "";
            };
        }, 1] call CBAFUNC(addPerFrameHandler);

        /* Make unit invincible */
        _unit allowDamage false;

        /* Add action to block shooting */
        private _action = _unit addAction ["", {
            params ["_target", "_caller", "_actionId"];

            /* Remove action if game has started */
            if ( missionNamespace getVariable [QGVAR(safestart_disable), false] ) exitWith { _target removeAction _actionId };

            /* show message in sidechat */
            ["<t size='0.5' color='#ff6347'>Safestart is active<t>", -1, safezoneY + 0.1] spawn bis_fnc_dynamicText;
        }, "", 0, false, true, "DefaultAction", "!(missionNameSpace getVariable ['"+QGVAR(safestart_disable)+"', false]) && !(missionNamespace getVariable ["QGVAR(safestart_override)", false]) && !(_this getVariable ['ace_dragging_isCarrying', false])"];

        /* Add event to block throwing grenades the vanilla way */
        ["ace_firedPlayer", {
            params ["_unit", "", "_muzzle", "", "", "", "_projectile"];

            /* Remove action if game has started */
            if (missionNamespace getVariable [QGVAR(safestart_disable), false]) exitWith {
                ["ace_firedPlayer", _thisId] call CBA_fnc_removeEventHandler;
                player removeAction _thisArgs;
            };

                /* If the projectile is a grenade delete it */
                if ((configname (inheritsFrom (configFile >> "cfgWeapons" >> "throw" >> _muzzle)) isEqualTo "ThrowMuzzle")) then {
                    _projectile setPos [0,0,0];
                    deleteVehicle _projectile;
                    ["<t size='0.5' color='#ff6347'>Safestart is active<t>", -1, safezoneY + 0.1] spawn bis_fnc_dynamicText;
                };
        }, _action] call CBA_fnc_addEventHandlerArgs;

    }] remoteExec ["call", (_this select 0)];
}];

[{
    missionNamespace getVariable [QGVAR(safestart_disable), false]
}, {
    [[], { titleText ["Game on!", "PLAIN", 0.2] }] remoteExec ["call", 0];

    /* Renable damage */
    { [_x, true] remoteExec ["allowDamage", 0, true] } forEach allPlayers;

    /* Raise event */
    [QGVAR(safestart_onDisable), []] call CBA_fnc_globalEvent;

    [{
        private _missionData = missionNameSpace getVariable [QEGVAR(common,missionData), []];
        private _hash = [_missionData] call CBA_fnc_hashCreate;

        private _title = [_hash, "M_TITLE", [getMissionConfigValue ['IntelBriefingName', briefingName]] call EFUNC(utility,hexToASCII)] call CBA_fnc_hashGet;
        private _gamemode = ([_hash, "M_TYPE", [-1, getText (getMissionConfig "Header" >> 'GameType')]] call CBA_fnc_hashGet) select 1;

        if (_gamemode isEqualTo "custom") then {
            _gamemode = [_hash, "M_CTYPE", getText (getMissionConfig "Header" >> 'GameType')] call CBA_fnc_hashGet;
        };

        [format ["<t size='1.3' align='left' font='PuristaMedium'> %1: <t color='#fcba03'>%2</t> </t>", toUpper _gamemode, _title], [safeZoneX, safeZoneW - safeZoneX], safezoneH - 0.8, 4] spawn BIS_fnc_dynamicText
    }, [], 3] call CBA_fnc_waitAndExecute;
}] call CBAFUNC(waitUntilAndExecute);
