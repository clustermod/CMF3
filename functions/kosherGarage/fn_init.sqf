#include "script_component.hpp"
/*
 * Author: Eric
 * Makes the arma garage function multiplayer compatible.
 *
 * Arguments:
 * 0: AddAction Object <OBJECT>
 * 1: Garage Object <OBJECT>
 * 2: Garage Direction <NUMBER> [Default: 0]
 * 3: WhitelistID and Condition <ARRAY> <STRINGS> [Default: []]
 * 4: Clear range <NUMBER> [Default: 8]
 *
 * Return Value:
 * None
 *
 * Example:
 * [this, _myGarageObject, 75, ["myLoadoutID", "TYPE"], 5] call emf_kosherGarage_fnc_init
 *
 * Public: Yes
 */
SCRIPT(init);
if (!isServer) then {};
params["_actionObject", "_garageObject", ["_garageDirection", 0], ["_whitelist", []], ["_clearRange", 8]];

/* Get all available pylon weapons */
if (isNil QGVAR(pylonWeapons)) then {
	call FUNC(getAllPylonWeapons);
};

/* Create an addAction */
[_actionObject, ["<t color='#FF0000'>Open Garage</t>", {
	(_this select 3) params["_garageObject", "_garageDirection", "_whitelist", "_clearRange"];

	/* Create events to check if garage is open */
	[missionNamespace, "garageOpened", {
		missionNamespace setVariable [QGVAR(open), true];
		uiNamespace setVariable [QGVAR(display), (_this select 0)];
		private _display = (_this select 0);

		// make player invincible
		player allowDamage false;

		// Handle whitelist
		private _spawnHandle = _display spawn {
			// FIGURE OUT HOW TO CHECK WHEN LEFT TAB IS CLICKED AND SET DEFAULT SELECTED
			["TabSelectRight", [_this, 1]] call BIS_fnc_garage;

			// Whitelist section
			_this spawn {
		 		private _display = _this;
		 		private _data = missionnamespace getvariable "bis_fnc_garage_data";
		 		private _whitelist = missionNameSpace getVariable [QGVAR(whitelist), []];
				if (count _whitelist isEqualTo 0) exitWith {};

				//////////////////////////// Whitelist vehicles /////////////////////////////
				private _loadingTotal = (count (_data select 0)) + (count (_data select 1)) + (count (_data select 2)) + (count (_data select 3)) + (count (_data select 4)) + (count (_data select 5));
				private _loadingIndex = 0;
				{
					// Get list control for each vehicle class
					private _ctrlList = _display displayctrl (960 + _forEachIndex);
					private _idc = _forEachIndex;
					waitUntil{ lbSize _ctrlList > 0 };

					private _allItems = lbSize _ctrlList;


					// Loop over all listbox items
					private _indexOffset = 0;

					// If the all<types> is in the whitelist whitelist all vehicles from that class
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
							//[((_loadingIndex + _index) / _loadingTotal)] call BIS_fnc_progressLoadingScreen;
							private _configs = (_data select _idc) select (_ctrlList lbValue _index) + 1;

							// loop over all configs for this vehicle
							{
								private _config = [str _x] call BIS_fnc_configPath;
								private _configName = _config select ((count _config) - 1);
								if !(_configName in (_whitelist select 1)) exitWith {
									_ctrlList lbDelete _index;
								};
								_indexOffset = _indexOffset + 1;
							} forEach _configs;
						};
						_loadingIndex = _allItems - 1;
					} else {
						_indexOffset = 1;
					};

					{
						(_display displayCtrl _x) ctrlShow (_indexOffset > 0);
						(_display displayCtrl _x) ctrlEnable (_indexOffset > 0);
					} forEach [(930 + _idc), (860 + _idc), (960 + _idc), (900 + _idc)];
				} forEach _data;

				//QGVAR(init_loadingScreen) call BIS_fnc_endLoadingScreen;

				//////////////////////////// Whitelist right /////////////////////////////
		 		while {true} do {
					// whitelist camos
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

					// whitelist components
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

			// Handle custom interface
            _this call FUNC(garageInterface);

			while{true} do {
				// Remove crew selection
				{
					(_this displayCtrl _x) ctrlShow false;
					(_this displayCtrl _x) ctrlEnable false;
				} forEach [918, 978, 878, 948];

				sleep 0.01;
			};
		};

		// Remove itself when garage is closed
		_thisScriptedEventHandler spawn {
			waitUntil{!(missionNamespace getVariable [QGVAR(open), true])};
			[missionNamespace, "garageOpened", _this] call BIS_fnc_removeScriptedEventHandler;
		};

		private _handles = missionNameSpace getVariable [QGVAR(spawns), []];
		_handles pushBack _spawnHandle;
		missionNameSpace setVariable [QGVAR(spawns), _handles];

	}] call BIS_fnc_addScriptedEventHandler;



	[missionNamespace, "garageClosed", {
		missionNamespace setVariable [QGVAR(open), false];
		uiNamespace setVariable [QGVAR(display), displayNull];

		// make player killable again
		player allowDamage true;

		// Stop the pylon onFrame eventhandler
		[QGVAR(FrameEvent), "onEachFrame"] call BIS_fnc_removeStackedEventHandler;

		// Delete all custom controls
		{
			ctrlDelete (_x select 0);
		} forEach GVAR(loadout_controls);
		GVAR(loadout_controls) = [];

		// Delete previous spawn handles, they are retained for some retarded reason
		private _handles = missionNameSpace getVariable [QGVAR(spawns), []];
		{
			terminate _x;
		} forEach _handles;

		// Get the vehicle
		private _veh = missionNameSpace getVariable "BIS_fnc_garage_center";

		// Create new global vehicle identical to the local vehicle
		private _spawnHandle = _veh spawn FUNC(syncVehicle);

		// Put the spawn handle in an array so it can be terminated manually later
		private _handles = missionNameSpace getVariable [QGVAR(spawns), []];
		_handles pushBack _spawnHandle;
		missionNameSpace setVariable [QGVAR(spawns), _handles];

		// Remove itself
		[missionNamespace, "garageClosed", _thisScriptedEventHandler] call BIS_fnc_removeScriptedEventHandler;
	}] call BIS_fnc_addScriptedEventHandler;



	// While the garage is open do some work
	[_garageDirection, (getPos _garageObject)] spawn {
		params["_garageDirection", "_garagePosition"];
		private _veh = objNull;
		waitUntil{missionNamespace getVariable [QGVAR(open), false]};
		while { missionNamespace getVariable [QGVAR(open), false] } do {
			// Waituntil vehicle is changed
			waitUntil{
				if (isNil { (missionNamespace getVariable "BIS_fnc_arsenal_center") }) exitWith { true };
				(typeof (missionNamespace getVariable "BIS_fnc_arsenal_center")) != (typeof _veh)
			};

			// Get new vehicle
			_veh = (missionNamespace getVariable "BIS_fnc_arsenal_center");
			if (isNil "_veh") exitWith {};

			// Set vehicle direction and position
			_veh setPos _garagePosition;
			_veh setDir _garageDirection;
		};
	};


	// Get whitelist
	if (count _whitelist > 0) then {
		private _loadoutFile = missionNameSpace getVariable ["emf_kosherGarage_loadouts_" + (_whitelist select 0), ""];
		if (FILE_EXISTS(_loadoutFile)) then {
			switch (_whitelist select 1) do {
				case ("TYPE"): {
					private _sqdType = (group player) getVariable [QEGVAR(gameplay, sqd_type), "INF"];
					_whitelist = [_sqdType] call compile(preprocessFileLineNumbers _loadoutFile);
				};
				case ("CALLSIGN"): {
					private _sqdCallsign = (group player) getVariable [QEGVAR(gameplay, sqd_callsign), "A1"];
					_whitelist = [_sqdCallsign] call compile(preprocessFileLineNumbers _loadoutFile);
				};
			};
		};
	};

	// Get all vehicles within 8 meters of the spawn and check if any of them were spawned with the virtual garage
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

	// If there exists a previous virtual garage vehicle use that as center else create a empty helipad
	private "_vehicle";
	if (count _garageObjs > 0) then {
		_vehicle = _garageObjs select 0;
		{ if (_forEachIndex != 0) then { deleteVehicle _x } } forEach _garageObjs;
	} else {
		_vehicle = createVehicle [ "Land_HelipadEmpty_F", (getPos _garageObject), [], 0, "CAN_COLLIDE"];
	};

	// if there is a whitelist select a whitelisted vehicle as default
	if (count _whitelist > 0) then {
		private _ranSel = (selectRandom (_whitelist select 1));

		// If the selection is a Fill type select random from types
		if (_ranSel in ["allCars", "allArmor", "allHelis", "allPlanes", "allNaval", "allTurrets"]) then {
			private _searchClass = "Car";
			switch (_ranSel) do {
			    case ("allArmor"): {
			        _searchClass = "Tank";
			    };
				case ("allHelis"): {
			        _searchClass = "Helicopter";
			    };
				case ("allPlanes"): {
			        _searchClass = "Plane";
			    };
				case ("allNaval"): {
			        _searchClass = "Ship";
			    };
				case ("allTurrets"): {
			        _searchClass = "StaticWeapon";
			    };
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

	missionNameSpace setVariable [QGVAR(whitelist), _whitelist];

	// Open garage
	["Open", [true, _vehicle]] call BIS_fnc_garage;

}, [_garageObject, _garageDirection, _whitelist, _clearRange]]] remoteExec ["addAction", 0, true];
