/*
 * Author: Eric
 * Replaces AI's ammunition with tracer rounds.
 *
 * Arguments:
 * 0: side/unit/units <SIDE>/<OBJECT><ARRAY>
 * 1: flashlight <BOOL>
 * 2: magazineType <BOOL>
 *
 * Return Value:
 * Status <BOOL>
 *
 * Example:
 * [east, true, false] call emf_gameplay_fnc_tracers
 *
 * Public: Yes
 */
scriptName "functions\gameplay\fn_tracers.sqf";
EMF_fnc_T_applyTracer = {
	if (!isServer) exitWith {
		["ERR", 'Function not called from server', "tracers", "gameplay"] call EMF_DEBUG;
		false;
	};

	params["_unit", ["_flash", true], ["_randomModel", false]];

	private _isDone = _unit getVariable ["isDone", false];

	if (!_isDone) then
	{
		private _pWeap = primaryWeapon _unit;
		private _supportedMags = [_pWeap] call CBA_fnc_compatibleMagazines;

		private _tracerMags = [];
		{
			if ((getNumber (configfile >> "CfgMagazines" >> _x >> "tracersEvery")) > 0) then {
				_tracerMags pushBack _x;
			};
		} forEach _supportedMags;

		if (count _tracerMags > 0) then
		{
			private _newMagazine = [];
			if (_randomModel) then
			{
				_newMagazine pushBack (_tracerMags select (random (count _tracerMags)));
			} else {
				{
					if ((getText (configfile >> "CfgMagazines" >> _x >> "model")) isEqualTo (getText (configfile >> "CfgMagazines" >> ((primaryWeaponMagazine _unit) select 0) >> "model"))) then
					{
						_newMagazine pushBack _x;
					};
				} forEach _tracerMags;

				if ((count _newMagazine) == 0) then
				{
					_newMagazine pushBack (_tracerMags select 0);
				};
			};
			_newMagazine = _newMagazine select 0;

			private _magReplace = [];
			private _magCount = 1;
			{
				if (_x in _supportedMags) then
				{
					_magReplace = _magReplace + [_x];
					_magCount = _magCount + 1;
				};
			} forEach magazines _unit;

			if (!isNil "_newMagazine") then
			{
				//_unit removeWeapon _pWeap;
				[_unit, _pWeap] call CBA_fnc_removeWeapon;
				{
					[_unit, _x] call CBA_fnc_removeMagazine;
				} forEach _magReplace;

				_unit addMagazines [_newMagazine, _magCount];
				//_unit addWeapon _pWeap;
				[_unit, _pWeap] call CBA_fnc_addWeapon;
			};
			_unit setVariable ["isDone", true];
		};

		if (_flash) then
		{
			private _flashLights = [];
			private _compatMods = [_pWeap] call CBA_fnc_compatibleItems;
			{
				if (isClass(configfile >> "CfgWeapons" >> _x >> "ItemInfo" >> "FlashLight")) then
				{
					if (getNumber(configfile >> "CfgWeapons" >> _x >> "ItemInfo" >> "FlashLight" >> "intensity") != 0) then
					{
						_flashLights pushBack _x;
					};
				};
			} forEach _compatMods;
			if (count _flashLights > 0) then
			{
				_unit addPrimaryWeaponItem (_flashLights select (random (count _flashLights)));
				_unit enableGunLights "ForceOn";
			};
		};
	};
};

params[["_unit", allUnits], ["_applyToZeusSpawn", false], ["_randomModel", false], ["_flash", true], ["_players", false]];

switch (typeName _unit) do {
    case ("SIDE"): {
			private _units = [];
			{
			    if ((side _x) == _unit) then {
						if (_players) then {
							[_x, _flash, _randomModel] call EMF_fnc_T_applyTracer;
						} else {
							if (!isPlayer _x) then {
							  [_x, _flash, _randomModel] call EMF_fnc_T_applyTracer;
							};
						};
						_units pushBack _x;
			    };
			} forEach allUnits;
			EMF_Tracers_randomModel = _randomModel;
			EMF_tracers_flash = _flash;
			publicVariable "EMF_Tracers_randomModel";
			publicVariable "EMF_tracers_flash";
			["Finished applying tracers"] call BIS_fnc_log;
			true;
    };
		case ("ARRAY"): {
			{
				if (_players) then {
					[_x, _flash, _randomModel] call EMF_fnc_T_applyTracer;
				} else {
					if (!isPlayer _x) then {
						[_x, _flash, _randomModel] call EMF_fnc_T_applyTracer;
					};
				};
			} forEach _unit;
			["Finished applying tracers"] call BIS_fnc_log;
			true;
		};
		case ("OBJECT"): {
			if (_players) then {
				[_unit, _flash, _randomModel] call EMF_fnc_T_applyTracer;
			} else {
				if (!isPlayer _unit) then {
					[_unit, _flash, _randomModel] call EMF_fnc_T_applyTracer;
				};
			};
			["Finished applying tracers"] call BIS_fnc_log;
			true;
		};
		default {
			["ERR", format['Unit must be type "OBJECT", "ARRAY" or "SIDE", type %1 supplied', (typeName _unit)], "tracers", "gameplay"] call EMF_DEBUG;
			false;
		};
};

if (_applyToZeusSpawn) then {
	// Add a eventhandler to run the function each time a unit is placed in zeus
	{
		_x addEventHandler ['CuratorObjectPlaced',{
			private _entity = _this select 1;
			[_entity, EMF_tracers_flash, EMF_Tracers_randomModel] remoteExecCall ["EMF_fnc_T_applyTracer", 2, true];
		}];
	} forEach AllCurators;
};
