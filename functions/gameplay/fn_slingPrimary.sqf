#include "script_component.hpp"
/*
 * Author: Eric
 * allow player to sling primary.
 *
 * Arguments:
 * 0: Unit <OBJECT/ARRAY/STRING>
 *
 * Return Value:
 * <Boolean>
 *
 * Example:
 * ["BREACHER"] call emf_gameplay_fnc_slingPrimary
 *
 * public: Yes
*/
scriptName "functions\gameplay\fn_slingPrimary.sqf";

// WaitUntil player is ingame
if (!hasInterface) exitWith {};
waitUntil {time > 0};
waitUntil {!isNull player};
waitUntil {(!(isNull (findDisplay 46)))};

// Create function to handle slinging primary
EMF_fnc_SP_slingPrimaryWeapon = {
weapHolder = "Weapon_Empty" createVehicle getPosATL player;

// cargo holder to hold the firearm
weapHolder attachTo [player,[-0.1,-0.18,0.12],"pelvis"];
weapHolder setVariable ["AA_Holster",true,true];
weapHolder enableSimulation false;

// Return weapon to hands action
backWeaponAction = player addAction ["Take weapon back",{
player action ["TakeWeapon", weapHolder, ((weaponCargo weapHolder) select 0)];
if (primaryWeapon player != "") then {
waitUntil {(count (magazinesAmmoCargo weapHolder) != 0)};
{player addMagazine [_x select 0, _x select 1];} forEach (magazinesAmmoCargo weapHolder);
clearMagazineCargoGlobal weapHolder;
clearItemCargoGlobal weapHolder;
clearBackpackCargoGlobal weapHolder;
};
},[],1,false,false,"",'(vehicle player == player) && (count (weaponCargo weapHolder) != 0) && (_this == player)'];

  // sling weapon action
player addAction ["Put weapon on back",{
	player action ["PutWeapon", weapHolder, primaryWeapon player];
	waitUntil {(count (magazinesAmmoCargo weapHolder) != 0)};
	{player addMagazine [_x select 0, _x select 1];} forEach (magazinesAmmoCargo weapHolder);
	clearMagazineCargoGlobal weapHolder;
	clearItemCargoGlobal weapHolder;
	clearBackpackCargoGlobal weapHolder;
	},[],1,false,false,"",'(vehicle player == player) && (count (weaponCargo weapHolder) == 0) && (player hasWeapon (primaryWeapon player)) && (_this == player)'];
};

params["_unit"];

if (isNil "_unit") exitWith {  ['Unit is not set'] call BIS_fnc_error; 'Unit is not set' call BIS_fnc_log;};

switch (typeName _unit) do {
    case ("ARRAY"): {
			{
        // Call it on mission join
        [] call EMF_fnc_SP_slingPrimaryWeapon;

        // Attach handler
        addMissionEventHandler ["EachFrame",{weapHolder setVectorDirAndUp [(player selectionPosition "spine3") vectorFromTo (player selectionPosition "rfemur"),[-0.1,-0.5,1]];}];
        player addEventHandler ["AnimDone", {if (count (weaponCargo weapHolder) > 0) then {player setUserActionText [backWeaponAction, (getText (configfile >> "CfgWeapons" >> ((weaponCargo weapHolder) select 0) >> "displayName"))];}}];

        // Handle vehicles
        player addEventHandler ["GetInMan", {if (!isNil "weapHolder") then {detach weapHolder; weapHolder setPos [0,0,0]}}];
        player addEventHandler ["GetOutMan", {if (!isNil "weapHolder") then {weapHolder attachTo [player,[-0.1,-0.18,0.12],"pelvis"];}}];

        // Add it if player respawns
        player addEventHandler ["Respawn",{player call EMF_fnc_SP_slingPrimaryWeapon;}];
			} forEach _unit;
			true;
    };
		case ("OBJECT"): {
      // Call it on mission join
      [] call EMF_fnc_SP_slingPrimaryWeapon;

      // Attach handler
      addMissionEventHandler ["EachFrame",{weapHolder setVectorDirAndUp [(_unit selectionPosition "spine3") vectorFromTo (_unit selectionPosition "rfemur"),[-0.1,-0.5,1]];}];
      _unit addEventHandler ["AnimDone", {if (count (weaponCargo weapHolder) > 0) then {_unit setUserActionText [backWeaponAction, (getText (configfile >> "CfgWeapons" >> ((weaponCargo weapHolder) select 0) >> "displayName"))];}}];

      // Handle vehicles
      _unit addEventHandler ["GetInMan", {if (!isNil "weapHolder") then {detach weapHolder; weapHolder setPos [0,0,0]}}];
      _unit addEventHandler ["GetOutMan", {if (!isNil "weapHolder") then {weapHolder attachTo [_unit,[-0.1,-0.18,0.12],"pelvis"];}}];

      // Add it if player respawns
      _unit addEventHandler ["Respawn",{_unit call EMF_fnc_SP_slingPrimaryWeapon;}];
			true;
		};
		case ("STRING"): {
			if ((player getVariable ["emf_utilities_setRole_role", "RFL"]) == _unit) then {
        // Call it on mission join
        [] call EMF_fnc_SP_slingPrimaryWeapon;

        // Attach handler
        addMissionEventHandler ["EachFrame",{weapHolder setVectorDirAndUp [(player selectionPosition "spine3") vectorFromTo (player selectionPosition "rfemur"),[-0.1,-0.5,1]];}];
        player addEventHandler ["AnimDone", {if (count (weaponCargo weapHolder) > 0) then {player setUserActionText [backWeaponAction, (getText (configfile >> "CfgWeapons" >> ((weaponCargo weapHolder) select 0) >> "displayName"))];}}];

        // Handle vehicles
        player addEventHandler ["GetInMan", {if (!isNil "weapHolder") then {detach weapHolder; weapHolder setPos [0,0,0]}}];
        player addEventHandler ["GetOutMan", {if (!isNil "weapHolder") then {weapHolder attachTo [player,[-0.1,-0.18,0.12],"pelvis"];}}];

        // Add it if player respawns
        player addEventHandler ["Respawn",{player call EMF_fnc_SP_slingPrimaryWeapon;}];
			};
		};
		default {
			["ERR", format['Unit must be type "OBJECT", "ARRAY" or "STRING", type %1 supplied', (typeName _unit)], "slingprimary", "gameplay"] call EMF_DEBUG;
			false;
		};
};
