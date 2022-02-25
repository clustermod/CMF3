/*
 * Author: Eric
 * Executes on mission start
 *
 * Public: No
 */
scriptName "configs\onMissionStart.sqf";
if (!isServer) exitWith {};

missionNamespace setVariable ["emf_main_loaded", false];
["INFO", "EMF initializing...", "onMissionStart"] call EMF_DEBUG;

// Don't allow removing grass in tawd view distance script
tawvd_disablenone = true;
// Remove squad bar from ShackTack User Interface
STHud_NoSquadBarMode = true;
// Disable CTAB on vehicles
cTab_vehicleClass_has_FBCB2 = [];

// add playerKilled and playerRespawn handlers to server
player addEventHandler ["Killed", {
  _this execVM "events\onPlayerKilled.sqf"
}];

player addEventHandler ["Respawn", {
  _this execVM "events\onPlayerRespawn.sqf"
}];

// band aid - remove this once they fix PlayerConnected mission event handler
// https://forums.bistudio.com/topic/143930-general-discussion-dev-branch/page-942#entry3003074
["emf_onMissionStart_opcfix", "onPlayerConnected", {}] call BIS_fnc_addStackedEventHandler;
["emf_onMissionStart_opcfix", "onPlayerConnected"] call BIS_fnc_removeStackedEventHandler;

// add playerKilled and playerRespawn handlers to new players
["INFO", "Registering events...", "onMissionStart"] call EMF_DEBUG;
addMissionEventHandler ["PlayerConnected", {
	params ["_id"];
  ["INFO", "New player connected...", "onMissionStart"] call EMF_DEBUG;
  {
    // Load ace settings
    call compile(preprocessFileLineNumbers "configs\ace_settings.sqf");

    // Load ace interaction menu
    [] call emf_aceMenu_fnc_menuinit;

    player addEventHandler ["Killed", {
      // Save inventory upon player death
      [player, [missionNamespace, "inventory_var"]] call BIS_fnc_saveInventory;

      // Save group upon player death
      player setVariable ["EMF_OPK_Group", (group player)];

      // Save team assigned upon player death
      player setVariable ["EMF_OPK_Team", (assignedTeam player)];

      // Call event script
      _this execVM "events\onPlayerKilled.sqf"
    }];

    player addEventHandler ["Respawn", {
      // Load inventory upon player respawn
      [player, [missionNamespace, "inventory_var"]] call BIS_fnc_loadInventory;

      // Join previous group
      [player] joinSilent (player getVariable ["EMF_OPK_Group", (group player)]);

      // Assign previous team
      player assignTeam (player getVariable ["EMF_OPK_Team", (assignedTeam player)]);

      // Call event script
      _this execVM "events\onPlayerRespawn.sqf"
    }];
  } remoteExec ["call", _id, true];
}];
["INFO", "Events registered", "onMissionStart"] call EMF_DEBUG;

// Misc custom eventhandlers
["INFO", "Registering customs events...", "onMissionStart"] call EMF_DEBUG;
[] spawn {
  waitUntil{(missionNamespace getVariable ["EMF_missionSafeStart", false])};
  [[], "events\onGameStart.sqf"] remoteExec ["execVM", 0, true];
};
["INFO", "Custom Events registered", "onMissionStart"] call EMF_DEBUG;

missionNamespace setVariable ["emf_main_loaded", true];
["INFO", "EMF loaded successfully", "onMissionStart"] call EMF_DEBUG;
