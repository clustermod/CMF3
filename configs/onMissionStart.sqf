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
// Disable vietnamese voices
RUG_DSAI_TerminalDistance = -1;

// add playerKilled and playerRespawn handlers to server
player addEventHandler ["Killed", {
  _this execVM "events\onPlayerKilled.sqf"
}];

player addEventHandler ["Respawn", {
  _this execVM "events\onPlayerRespawn.sqf"
}];

// Load ace interaction menu
[] spawn emf_aceMenu_fnc_menuinit;

// band aid - remove this once they fix PlayerConnected mission event handler
// https://forums.bistudio.com/topic/143930-general-discussion-dev-branch/page-942#entry3003074
["emf_onMissionStart_opcfix", "onPlayerConnected", {}] call BIS_fnc_addStackedEventHandler;
["emf_onMissionStart_opcfix", "onPlayerConnected"] call BIS_fnc_removeStackedEventHandler;

// add playerKilled and playerRespawn handlers to new players
["INFO", "Registering events...", "onMissionStart"] call EMF_DEBUG;
addMissionEventHandler ["PlayerConnected", {
  private _owner = _this select 4;

  {
    ["INFO", format["Registering events for %1...", (name player)], "onMissionStart"] remoteExecCall ["EMF_DEBUG", 2];

    // Don't allow removing grass in tawd view distance script
    tawvd_disablenone = true;

    // Load ace settings
    call compile(preprocessFileLineNumbers "configs\ace_settings.sqf");

    // Load ace interaction menu
    [] spawn emf_aceMenu_fnc_menuinit;

    // Disable vietnamese voices
    RUG_DSAI_TerminalDistance = -1;

    player addEventHandler ["Killed", {
      // Save loadout
      player setVariable ["emf_onPlayerKilled_loadout", getUnitLoadout player];

      // Save group upon player death
      player setVariable ["EMF_OPK_Group", (group player)];

      // Save team assigned upon player death
      player setVariable ["EMF_OPK_Team", (assignedTeam player)];

      // Call event script
      _this execVM "events\onPlayerKilled.sqf"
    }];

    player addEventHandler ["Respawn", {
      // Load loadout
      player setUnitLoadout (player getVariable ["emf_onPlayerKilled_loadout",[]]);

      // Join previous group
      [player] joinSilent (player getVariable ["EMF_OPK_Group", (group player)]);

      // Assign previous team
      player assignTeam (player getVariable ["EMF_OPK_Team", (assignedTeam player)]);

      // Call event script
      _this execVM "events\onPlayerRespawn.sqf"
    }];
    ["INFO", format["Events registered for %1!", (name player)], "onMissionStart"] remoteExecCall ["EMF_DEBUG", 2];
  } remoteExec ["call", _owner];
}];

// Misc custom eventhandlers
["INFO", "Registering customs events...", "onMissionStart"] call EMF_DEBUG;
[] spawn {
  waitUntil{(missionNamespace getVariable ["EMF_missionSafeStart", false])};
  [[], "events\onGameStart.sqf"] remoteExec ["execVM", 0, true];
};
["INFO", "Custom Events registered", "onMissionStart"] call EMF_DEBUG;

missionNamespace setVariable ["emf_main_loaded", true];
["INFO", "EMF loaded successfully", "onMissionStart"] call EMF_DEBUG;
