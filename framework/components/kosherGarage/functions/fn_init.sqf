#include "script_component.hpp"
/*
 * Author: Eric
 * Makes the arma garage function multiplayer compatible.
 *
 * Arguments:
 * 0: AddAction Object <OBJECT>
 * 1: Garage Object <OBJECT>
 * 2: Garage Direction <NUMBER> [Default: 0]
 * 3: WhitelistID<STRING> [Default: "ALL"]
 * 4: Clear range <NUMBER> [Default: 8]
 *
 * Return Value:
 * None
 *
 * Example:
 * [this, _myGarageObject, 75, "myLoadoutID", 5] call cmf_kosherGarage_fnc_init
 *
 * Public: Yes
 */
SCRIPT(init);
if (!isServer) exitWith {};

// @TODO replace spawn
_this spawn {
	params["_actionObject"];

	/* Get all available pylon weapons */
	if (isNil QGVAR(pylonWeapons)) then {
		call FUNC(getAllPylonWeapons);
	};

	/* Create an addAction */
	[_actionObject, [LSTRING(open_garage), {
		(_this select 3) params["_actionObject", "_garageObject", ["_garageDirection", 0], ["_whitelist", nil], ["_clearRange", 8]];

		/* Create events to check if garage is open */
		[missionNamespace, "garageOpened", {
			missionNamespace setVariable [QGVAR(open), true];
			uiNamespace setVariable [QGVAR(display), (_this select 0)];
			private _display = (_this select 0);

			/* Make player temporarily invincible, if they are kileld while in the garage the game breaks */
			player allowDamage false;

			/* Handle whitelists */
			private _spawnHandle = _display spawn {

				/* Remove vehicles, camos and components that aren't whitelisted */
				_this spawn {
					private _display = _this;
					private _data = missionnamespace getvariable "bis_fnc_garage_data";
					private _whitelist = missionNameSpace getVariable [QGVAR(whitelist), nil];
					if (isNil "_whitelist") exitWith {};

					//////////////////////////// Whitelist vehicles /////////////////////////////
					{
						/* Get the list control for the current vehicle type */
						private _ctrlList = _display displayctrl (960 + _forEachIndex);
						private _idc = _forEachIndex;
						waitUntil{ lbSize _ctrlList > 0 };

						private _allItems = lbSize _ctrlList;


						private _indexOffset = 0;

						/* If the all<types> is in the whitelist whitelist all vehicles from that class */
						if !(
							((_idc == 0) && "allCars" in (_whitelist select 1)) ||
							((_idc == 1) && "allArmor" in (_whitelist select 1)) ||
							((_idc == 2) && "allHelis" in (_whitelist select 1)) ||
							((_idc == 3) && "allPlanes" in (_whitelist select 1)) ||
							((_idc == 4) && "allNaval" in (_whitelist select 1)) ||
							((_idc == 5) && "allTurrets" in (_whitelist select 1))
						) then {
							for "_i" from 0 to _allItems - 1 do {
								private _index = 0 + _indexOffset;
								private _configs = (_data select _idc) select (_ctrlList lbValue _index) + 1;

								/* loop over all configs for this vehicle */
								{
									private _config = [str _x] call BIS_fnc_configPath;
									private _configName = _config select ((count _config) - 1);
									if !(_configName in (_whitelist select 1)) exitWith {
										_ctrlList lbDelete _index;
									};
									_indexOffset = _indexOffset + 1;
								} forEach _configs;
							};
						} else {
							_indexOffset = 1;
						};

						{
							(_display displayCtrl _x) ctrlShow (_indexOffset > 0);
							(_display displayCtrl _x) ctrlEnable (_indexOffset > 0);
						} forEach [(930 + _idc), (860 + _idc), (960 + _idc), (900 + _idc)];
					} forEach _data;

					//////////////////////////// Whitelist right /////////////////////////////
					while {true} do {
						/* Whitelist camos/textures */
						private _ctrlList = _display displayctrl 980;
						if (lbSize _ctrlList > 0) then {
							private _allItems = lbSize _ctrlList;
							private _indexOffset = 0;

							for "_i" from 0 to _allItems - 1 do {
								private _index = 0 + _indexOffset;

								private _configName = _ctrlList lbData _index;
								if (!(_configName in (_whitelist select 4)) && ((_whitelist select 4) select 0) != "ALL") then {
									_ctrlList lbDelete _index;
								} else {
									_indexOffset = _indexOffset + 1;
								};
							};
						};

						/* Whitelist components */
						private _ctrlList = _display displayctrl 979;
						if (lbSize _ctrlList > 0) then {
							private _allItems = lbSize _ctrlList;
							private _indexOffset = 0;

							for "_i" from 0 to _allItems - 1 do {
								private _index = 0 + _indexOffset;

								private _configName = _ctrlList lbData _index;
								if (!(_configName in (_whitelist select 5)) && ((_whitelist select 5) select 0) != "ALL") then {
									_ctrlList lbDelete _index;
								} else {
									_indexOffset = _indexOffset + 1;
								};
							};
						};

						sleep 0.1;
					};
				};

				/* Add a custom interface for selecting pylons */
				_this call FUNC(garageInterface);

				/* Remove the crew selection tab */
				while{ true } do {
					{
						(_this displayCtrl _x) ctrlShow false;
						(_this displayCtrl _x) ctrlEnable false;
					} forEach [918, 978, 878, 948];

					sleep 0.01;
				};
			};

			/* Remove this eventHandler when the garage is closed */
			_thisScriptedEventHandler spawn {
				waitUntil{ !(missionNamespace getVariable [QGVAR(open), true]) };
				[missionNamespace, "garageOpened", _this] call BIS_fnc_removeScriptedEventHandler;
			};

			/* Raise event */
			[QGVAR(onOpen), [_display]] call CBA_fnc_localEvent;

			private _handles = missionNameSpace getVariable [QGVAR(spawns), []];
			_handles pushBack _spawnHandle;
			missionNameSpace setVariable [QGVAR(spawns), _handles];
		}] call BIS_fnc_addScriptedEventHandler;

		/* Create event to check if the garage is closed */
		[missionNamespace, "garageClosed", {
			missionNamespace setVariable [QGVAR(open), false];
			uiNamespace setVariable [QGVAR(display), displayNull];

			/* Make player take damage again */
			player allowDamage true;

			/* Stop the custom interface event handler */
			[QGVAR(FrameEvent), "onEachFrame"] call BIS_fnc_removeStackedEventHandler;

			/* Delete all custom controls */
			{
				ctrlDelete (_x select 0);
			} forEach GVAR(loadout_controls);
			GVAR(loadout_controls) = [];

			/* Cleanup any remaining script handles */
			private _handles = missionNameSpace getVariable [QGVAR(spawns), []];
			{
				terminate _x;
			} forEach _handles;

			/* Get the selected vehicle */
			private _veh = missionNameSpace getVariable "BIS_fnc_garage_center";

			/* Respawn it as a global vehicle */
			private _spawnHandle = _veh spawn FUNC(syncVehicle);

			/* pushback the script handle incase it fails so it can be terminated manually later */
			private _handles = missionNameSpace getVariable [QGVAR(spawns), []];
			_handles pushBack _spawnHandle;
			missionNameSpace setVariable [QGVAR(spawns), _handles];

			/* Remove this event handler */
			[missionNamespace, "garageClosed", _thisScriptedEventHandler] call BIS_fnc_removeScriptedEventHandler;

			/* Raise event */
			[QGVAR(onClose), []] call CBA_fnc_localEvent;
		}] call BIS_fnc_addScriptedEventHandler;

		/* Set the direction and position of newly selected vehicles */
		[_garageDirection, (getPos _garageObject)] spawn {
			params["_garageDirection", "_garagePosition"];
			private _veh = objNull;
			waitUntil{missionNamespace getVariable [QGVAR(open), false]};
			while { missionNamespace getVariable [QGVAR(open), false] } do {
				/* wait until a new vehicle is selected */
				waitUntil{
					if (isNil { (missionNamespace getVariable "BIS_fnc_arsenal_center") }) exitWith { true };
					(typeof (missionNamespace getVariable "BIS_fnc_arsenal_center")) != (typeof _veh)
				};

				/* Get the newly selected vehicle */
				_veh = (missionNamespace getVariable "BIS_fnc_arsenal_center");
				if (isNil "_veh") exitWith {};

				/* Set the position and direction */
				_veh setPos _garagePosition;
				_veh setDir _garageDirection;

				/* Raise event */
				[QGVAR(onSelect), [_veh]] call CBA_fnc_localEvent;
			};
		};


		/* Parse the whitelist */
		if (!isNil "_whitelist") then {
			private _whitelistsArray = missionNamespace getVariable [QGVAR(whitelists), createHashMap];
			private _loadoutFile = _whitelistsArray getOrDefault [_whitelist, ""];
			if (FILE_EXISTS(_loadoutFile)) then {
				_whitelist = [player] call compile(preprocessFileLineNumbers _loadoutFile);
			} else {
				_whitelist = nil;
				WARNING("The kosherGarage whitelist does not exist");
			};
		};

		/* Get all vehicles within 8 meters of the spawn center and check if any of them were spawned with the virtual garage */
		private _objs = (getPos _garageObject) nearEntities [["Air", "Car", "Tank", "Ship", "staticWeapon"], _clearRange];
		reverse _objs;
		private _garageObjs = [];
		{
			if (_x getVariable [QGVAR(vehicle), false]) then {
				_garageObjs pushBack _x;
			} else {
				deleteVehicle _x;
			};
		} forEach _objs;

		/* If there exists a previous virtual garage vehicle use that as center else create a empty helipad */
		private "_vehicle";
		if (count _garageObjs > 0) then {
			_vehicle = _garageObjs select 0;
			{ if (_forEachIndex != 0) then { deleteVehicle _x } } forEach _garageObjs;
		} else {
			_vehicle = createVehicle [ "Land_HelipadEmpty_F", (getPos _garageObject), [], 0, "CAN_COLLIDE"];
		};

		/* if there is a whitelist select a whitelisted vehicle as the default vehicle */
		if (!isNil "_whitelist") then {
			private _ranSel = (selectRandom (_whitelist select 1));

			/* If the selection is a Fill type select random from types */
			if (_ranSel in ["allCars", "allArmor", "allHelis", "allPlanes", "allNaval", "allTurrets"]) then {
				private _searchClass = "Car";
				switch (_ranSel) do {
					case ("allArmor"): { _searchClass = "Tank" };
					case ("allHelis"): { _searchClass = "Helicopter" };
					case ("allPlanes"): { _searchClass = "Plane" };
					case ("allNaval"): { _searchClass = "Ship" };
					case ("allTurrets"): { _searchClass = "StaticWeapon" };
				};

				_ranSel = selectRandom ((format["(
					(getNumber (_x >> 'scope') >= 2) &&
					{
						getNumber (_x >> 'side') == 1 &&
						{ (configName _x) isKindOf '%1' }
					}
				)", _searchClass] configClasses (configFile >> "CfgVehicles")) apply {configName _x});
			};

			uinamespace setvariable ["bis_fnc_garage_defaultClass", _ranSel];
		};

		if (isNil "_whitelist") then {
		    missionNameSpace setVariable [QGVAR(whitelist), nil];
		} else {
			missionNameSpace setVariable [QGVAR(whitelist), _whitelist];
		};

		/* Open garage UI */
		["Open", [true, _vehicle]] call BIS_fnc_garage;

	}, _this]] remoteExec ["addAction", 0, true];
};
