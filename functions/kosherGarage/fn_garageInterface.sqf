#include "script_component.hpp"
/*
 * Author: Eric
 * Creates a custom interface for kosherGarage
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_kosherGarage_fnc_garageInterface
 *
 * Public: No
 */
SCRIPT(garageInterface);

/* Spawn the interface script handle */
private _handle = _this spawn {
    private _display = _this;
    private _veh = objNull;
    while { missionNamespace getVariable [QGVAR(open), false] } do {
        /* waitUntil a vehicle is spawned */
        waitUntil{
            if (isNil { (missionNamespace getVariable "BIS_fnc_arsenal_center") }) exitWith { true };
            (typeof (missionNamespace getVariable "BIS_fnc_arsenal_center")) != (typeof _veh)
        };

        /* Get the spawned vehicle */
        _veh = (missionNamespace getVariable "BIS_fnc_arsenal_center");
        if (isNil "_veh") exitWith {};
        private _ctrls = [];

        /* Delete old loadout controls */
        if(isNil QGVAR(pylon_controls)) then {
            GVAR(pylon_controls) = [];
        };

        {
            ctrlDelete (_x select 0);
        } forEach GVAR(pylon_controls);
        GVAR(pylon_controls) = [];

        /* Get the vehicle's current pylon loadout */
        private _pylons = (configProperties [configFile >> "CfgVehicles" >> typeOf _veh >> "Components" >> "TransportPylonsComponent" >> "Pylons"]) apply {configName _x};
        reverse _pylons;

        /* Get the last used pylon loadout */
        private _last_loadout = (uiNamespace getVariable format [QGVAR(loadout) + "_%1", typeOf _veh]);

        /* Create ui elements for each pylon */
        {
            /* Create a combobox for the pylon magazines */
            private _ctrl = _display ctrlCreate ["RscCombo", -1];
            _ctrl setVariable ["test","worked!"];
            _ctrl ctrlSetTooltip "Select Weapon";
            _ctrl ctrlSetBackgroundColor [0,0,0,0.8];
            _ctrl ctrlSetFade 0.2;
            _ctrl ctrlCommit 0;

            _veh animateBay [_forEachIndex, 1];

            /* Set the pylon loadout to use the last loadout */
            if(!isNil "_last_loadout") then {
                _veh setPylonLoadOut [_forEachIndex+1, _last_loadout select _forEachIndex,true];
            };

            /* Get the current pylon and it's current magazine */
            private _ctrl_index = _forEachIndex;
            private _pylonName = _x;
            private _current_wep = (getPylonMagazines (_veh)) select _ctrl_index;
            if (isNil "_current_wep") then {
                _current_wep = "";
            };

            private _selected = -1;

            /* Add the pylon magazines to the selection if they are whitelisted */
            private _whitelist = missionNameSpace getVariable [QGVAR(whitelist), [[],[],true,[]]];
			private _pylonOptions = [];
			if (!isNil "_whitelist") then {
				if (count (_whitelist select 3) > 0) then {
                    if (((_whitelist select 3) select 0) != "ALL") then {
                        _pylonOptions = [];
                        {
                            private _pylon = _x;
                        	if (_whitelist select 2) then {
                        		if (_pylon in (_veh getCompatiblePylonMagazines _pylonName)) then {
                        			_pylonOptions pushBack ((GVAR(pylonWeapons) select {(_x select 1) isEqualTo _pylon}) select 0);
                        		};
                        	} else {
                        		_pylonOptions pushBack ((GVAR(pylonWeapons) select {(_x select 1) isEqualTo _pylon}) select 0);
                        	};
                        } forEach (_whitelist select 3);
                    } else {
                        if (_whitelist select 2) then {
                            {
                                private _pylon = _x;
                                _pylonOptions pushBack ((GVAR(pylonWeapons) select {(_x select 1) isEqualTo _pylon}) select 0);
                                copyToClipboard str _pylonOptions;
                            } forEach (_veh getCompatiblePylonMagazines _pylonName);
                        } else {
                            _pylonOptions = GVAR(pylonWeapons);
                        };
                    };
				};
			} else {
                _pylonOptions = GVAR(pylonWeapons);
            };

            /* If there are no pylon magazines available for the pylon hide the combobox */
            if (count _pylonOptions > 0) then {

                /* Add an option to select no pylon */
                _ctrl lbAdd "None";
                _ctrl lbSetData [0, format["%1^%2","",_ctrl_index+1]];

                /* pushback the pylon magazines to the combobox */
                {
                    _ctrl lbAdd (_x select 0);
                    _ctrl lbSetData [_forEachIndex+1, format["%1^%2",_x select 1,_ctrl_index+1]];

                    if (_current_wep isEqualTo (_x select 1)) then {
                        _selected = _forEachIndex + 1;
                    };
                } forEach _pylonOptions;

                /* If the current pylon magazine isn't whitelisted select a new whitelisted one */
                if (count (_pylonOptions select {(_x select 1) isEqualTo _current_wep}) == 0) then {
                    private _randomWeapon = selectRandom _pylonOptions;
                    _selected = _pylonOptions find _randomWeapon;
                    _veh setPylonLoadout [_pylonName, _selected, true];
                };

                _ctrl lbSetCurSel _selected;

                /* Handle pylon change */
                _ctrl ctrlAddEventHandler ["LBSelChanged",{
                    private _veh = BIS_fnc_arsenal_center;
                    private _ctrl = _this select 0;
                    private _index = _this select 1;
                    private _str = (_ctrl lbData _index) splitString "^";
                    private _pylon_index = parseNumber (_str select 1);
                    private _class = (_str select 0);

                    if (_index == 0) then {
                        _veh setPylonLoadout [(parseNumber (_str select 0)), "",true];
                    } else {
                        _veh setPylonLoadout [_pylon_index, _class,true];
                    };

                    /* Save the current pylon loadout */
                    uiNamespace setVariable [format [QGVAR(loadout) + "_%1",typeOf _veh], getPylonMagazines _veh];

                    /* Play a sound when pylon is changed */
                    playSound3D [MISSION_PATH(format["rsc\sounds\%1.ogg",selectRandom["impact_drive_1", "impact_drive_2"]]), _veh, false ,getPos _veh, 2];

                    /* Raise event */
                    [QGVAR(onPylonChanged), [_pylon_index, _class]] call CBA_fnc_localEvent;
                }];

                /* Fade pylon combobox's when not moused over */
                _ctrl ctrlAddEventHandler ["MouseEnter",{
                    (_this select 0) ctrlSetFade 0;
                    (_this select 0) ctrlCommit 0;
                }];

                _ctrl ctrlAddEventHandler ["MouseExit",{
                    (_this select 0) ctrlSetFade 0.5;
                    (_this select 0) ctrlCommit 0;
                }];

                /* Get the pylon offsets */
                private _offset = getArray (configfile >> "CfgVehicles" >> typeOf _veh >> "Components" >> "TransportPylonsComponent" >> "pylons" >> _x >> "UIposition");
                private _offset_final = +_offset;
                private _pos_offset = [-0.33,-0.33,-0.5];
                private _multiplier = [12,12];

                switch (typeOf _veh) do {
                    case 'B_Plane_CAS_01_dynamicLoadout_F': {
                        _offset_final = [_offset select 1,_offset select 0];
                        _pos_offset = [-0.26,-0.36,-0.5];
                        _multiplier = [25,15];
                    };
                    case 'B_Heli_Light_01_dynamicLoadout_F': {
                        _offset_final = [-(_offset select 0),(_offset select 1)];
                        _pos_offset = [0.32,-0.5,-0.5];
                        _multiplier = [6,6];
                    };
                    case 'B_Heli_Attack_01_dynamicLoadout_F': {
                        _offset_final = [-(_offset select 0),(_offset select 1)];
                        _pos_offset = [0.33,-0.4,-0.5];
                        _multiplier = [6,15];
                    };
                    case 'O_Heli_Attack_02_dynamicLoadout_F': {
                        _offset_final = [-(_offset select 0),(_offset select 1)];
                        _pos_offset = [0.33,-0.33,-0.5];
                        _multiplier = [13,13];
                    };
                    case 'B_T_UAV_03_dynamicLoadout_F': {
                        _offset_final = [-(_offset select 0),-(_offset select 1)];
                        _pos_offset = [0.31,0.33,-0.5];
                        _multiplier = [10,10];
                    };
                    case 'O_Heli_Light_02_dynamicLoadout_F': {
                        _offset_final = [-(_offset select 0),(_offset select 1)];
                        _pos_offset = [0.31,-0.8,-1.6];
                        _multiplier = [9,1];
                    };
                    case 'I_Heli_light_03_dynamicLoadout_F': {
                        _offset_final = [-(_offset select 0),(_offset select 1)];
                        _pos_offset = [0.33,-3,-0.5];
                        _multiplier = [9,1];
                    };
                    case 'I_Plane_Fighter_03_dynamicLoadout_F': {
                        _offset_final = [-(_offset select 1),(_offset select 0)];
                        _pos_offset = [0.29,-0.33,-0.5];
                        _multiplier = [15,25];
                    };
                    case 'B_UAV_02_dynamicLoadout_F': {
                        _offset_final = [-(_offset select 1),(_offset select 0)];
                        _pos_offset = [0.28,-0.22,-0.8];
                        _multiplier = [25,15];
                    };
                    case 'O_Plane_CAS_02_dynamicLoadout_F': {
                        _offset_final = [-(_offset select 1),(_offset select 0)];
                        _pos_offset = [0.28,-0.32,-0.8];
                        _multiplier = [24,100];
                    };
                    case 'O_T_VTOL_02_infantry_dynamicLoadout_F': {
                        _offset_final = [-(_offset select 1),(_offset select 0)];
                        _pos_offset = [0.28,-0.32,-1.3];
                        _multiplier = [40,20];
                    };
                    case 'O_T_VTOL_02_vehicle_dynamicLoadout_F': {
                        _offset_final = [-(_offset select 1),(_offset select 0)];
                        _pos_offset = [0.28,-0.32,-1.3];
                        _multiplier = [40,20];
                    };
                };

                /* Save ui element to variable so it can be accessed later */
                _ctrls pushBack [
                    _ctrl,
                    _offset_final,
                    _pos_offset,
                    _multiplier
                ];
            } else {
                _veh setPylonLoadout [_pylonName, "", true];
                _ctrl ctrlShow false;
                _ctrl ctrlEnable false;
            };
        } forEach _pylons;

        GVAR(pylon_controls) = _ctrls;
        [QGVAR(FrameEvent), "onEachFrame"] call BIS_fnc_removeStackedEventHandler;

        /* If there are ui elements move them to roughly align with the pylons */
        if ((count _ctrls) != 0) then {
            [QGVAR(FrameEvent), "onEachFrame", {
                private _ctrls = GVAR(pylon_controls);
                private _veh = (missionNamespace getVariable "BIS_fnc_arsenal_center");

                private _width = 0.14;
                private _height = 0.05;
                private _boost = 0;

                private _mouse = getMousePosition;

                {
                    private _ctrl = _x select 0;
                    private _offset = _x select 1;
                    private _pos_offset = _x select 2;
                    private _multiplier = _x select 3;
                    private _offset_x = _offset select 0;
                    private _offset_y = _offset select 1;

                    _offset_x = _offset_x + (_pos_offset select 0);
                    _offset_y = _offset_y + (_pos_offset select 1);

                    _offset_x = _offset_x * 1;
                    _offset_y = -_offset_y * 1;

                    _offset_x = _offset_x * (_multiplier select 0);
                    _offset_y = _offset_y * (_multiplier select 1);

                    private _pos = worldToScreen (_veh modelToWorld [_offset_x,_offset_y,(_pos_offset select 2)]);
                    if (count _pos isEqualTo 0) exitWith {};

                    private _pos_x = (_pos select 0) - _width/2;
                    private _pos_y = (_pos select 1) - _height/2;

                    private _dist = 1 - (_mouse distance _pos);

                    if(_dist > 0.94) then {
                        _boost = 0;
                    } else {
                        _boost = 0;
                    };

                    _ctrl ctrlSetPosition [_pos_x,_pos_y - _boost,_width,_height];
                    _ctrl ctrlCommit 0;

                } forEach _ctrls;

            }] call BIS_fnc_addStackedEventHandler;
        };
    };
};

/* pushback the handle so it can be terminated when the garage is closed */
private _handles = missionNameSpace getVariable [QGVAR(spawns), []];
_handles pushBack _handle;
missionNameSpace setVariable [QGVAR(spawns), _handles];
