/*
 * Author: Eric
 * Gives players a limited amount of lives which if all are spent will set player as a spectator.
 *
 * Arguments:
 * 0: Respawns <NUMBER>
 *
 * Return Value:
 * <Boolean>
 *
 * Example:
 * [5] call EMF_fnc_limitedRespawns
 *
 * public: No
*/

params["_respawns", "_teamLimit"];

// Check if params are set and is of correct type
if (isNil "_respawns") exitWith {  ['Respawns is not set'] call BIS_fnc_error; 'Respawns is not set' call BIS_fnc_log; false;};
if (typeName _respawns != "SCALAR") exitWith {  ['Object must be type "SCALAR", type %1 supplied', (typeName _respawns)] call BIS_fnc_error; ['Respawns must be type "SCALAR", type %1 supplied', (typeName _respawns)] call BIS_fnc_log; false;};

// If player is not in supplied team don't run
if (player getVariable ["unitTeamRole", 0] == _teamLimit) then {

	// Set the amount of allowed respawns
	player setVariable["EMF_playerRespawns", (_respawns + 1), true];

	// Create a event handler for player respawns
	player addEventHandler ["Respawn", {
		_respawns = player getVariable["EMF_playerRespawns", 1];

		// Check if player has spent all respawns
		if ((player getVariable["EMF_playerDeaths", 0]) == _respawns) then
		{
			[true, true, true] call ace_spectator_fnc_setSpectator;
		} else {
			private _pCount = player getVariable["EMF_playerDeaths", 0];
			private _pCount = _pCount + 1;
			// Decrement player respawns by 1
			player setVariable["EMF_playerDeaths", _pCount, true];
			[format["you have %1 respawns left", (_respawns - _pCount)], -1, -1, 5, 1, 0, 9459] spawn bis_fnc_dynamicText;
		};
	}];
};
// Create a 3D widget for zeus units to see remaining lives on all playerUnits
if (!hasInterface) exitwith {};

// Wait until zeus module is initialized
waitUntil {
    private _hasCurators = (count allcurators) > 0;
    private _hasInitializedCurators = (count (call BIS_fnc_listCuratorPlayers)) > 0;
    private _curatorsInitialized = !_hasCurators || _hasInitializedCurators;
    ((time > 2) || _curatorsInitialized)
    };

// Get the respawns left for all players in mission and create 3D widget displaying the remaining respawns
if (player in (call bis_fnc_listcuratorplayers)) then {
	addMissionEventHandler ["Draw3D", {
		{
			private _distance = position curatorCamera distance _x;
			if (_distance < 1200) then {
				private _respawnsLeft = (_x getVariable ["EMF_playerRespawns",1]) - (_x getVariable["EMF_playerDeaths", 0]);
				if (_respawnsLeft  < 1) then
				{
					private _iconPos = [(getPos _x select 0), (getPos _x select 1), (getPos _x select 2) - 0.5];
					drawIcon3D
					["", [1,0,0,0.7], _iconPos, 1, 2, 0, format["%1 Lives: %2", name _x, str _respawnsLeft], 0, 0.05, "PuristaMedium", "center"];
				}
				else
				{
					private _iconPos = [(getPos _x select 0), (getPos _x select 1), (getPos _x select 2) - 0.5];
					drawIcon3D
					["", [1,1,1,0.7], _iconPos, 1, 2, 0, format["%1 Lives: %2", name _x, str _respawnsLeft], 0, 0.03, "PuristaMedium", "center"];
				};
			};
		} forEach allPlayers;
	}];
};
true;
