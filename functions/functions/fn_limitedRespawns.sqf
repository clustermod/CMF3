params["_respawns"];

player setVariable["EMF_playerRespawns", (_respawns + 1), true];

player addEventHandler ["Respawn", {
	params ["_unit", "_corpse"];
	_respawns = player getVariable["EMF_playerRespawns", 1];

	if ((player getVariable["EMF_playerDeaths", 0]) == _respawns) then
	{
		[true, true, true] call ace_spectator_fnc_setSpectator;
	} else {
		_pCount = player getVariable["EMF_playerDeaths", 0];
		_pCount = _pCount + 1;
		player setVariable["EMF_playerDeaths", _pCount, true];
		[format["you have %1 respawns left", (_respawns - _pCount)], -1, -1, 5, 1, 0, 9459] spawn bis_fnc_dynamicText;
	};
}];

if (!hasInterface) exitwith {};
waitUntil {
    private _hasCurators = (count allcurators) > 0;
    private _hasInitializedCurators = (count (call BIS_fnc_listCuratorPlayers)) > 0;
    private _curatorsInitialized = !_hasCurators || _hasInitializedCurators;
    ((time > 2) || _curatorsInitialized)
    };

if (player in (call bis_fnc_listcuratorplayers)) then {
	addMissionEventHandler ["Draw3D", {
		{
			_distance = position curatorCamera distance _x;
			if (_distance < 1200) then {
				_respawnsLeft = (_x getVariable ["EMF_playerRespawns",1]) - (_x getVariable["EMF_playerDeaths", 0]);
				if (_respawnsLeft  < 1) then
				{
					_iconPos = [(getPos _x select 0), (getPos _x select 1), (getPos _x select 2) - 0.5];
					drawIcon3D
					["", [1,0,0,0.7], _iconPos, 1, 2, 0, format["%1 Lives: %2", name _x, str _respawnsLeft], 0, 0.05, "PuristaMedium", "center"];
				}
				else
				{
					_iconPos = [(getPos _x select 0), (getPos _x select 1), (getPos _x select 2) - 0.5];
					drawIcon3D
					["", [1,1,1,0.7], _iconPos, 1, 2, 0, format["%1 Lives: %2", name _x, str _respawnsLeft], 0, 0.03, "PuristaMedium", "center"];
				};
			};
		} forEach allPlayers;
	}];
};
