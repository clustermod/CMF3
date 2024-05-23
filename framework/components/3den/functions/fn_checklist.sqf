#include "script_component.hpp"
/*
 * Author: Eric
 * Runs checks for a minimal list of required things for Cluster Community Missions
 *
 * Arguments:
 * None
 *
 * Return Value:
 * List status <ARRAY>
 *  0: PlayerUnits <BOOLEAN>
 *  1: Zeus <BOOLEAN>
 *  2: Respawns <BOOLEAN>
 *  3: Loadout <BOOLEAN>
 *  4: Ammobox <BOOLEAN>
 *  5: Mission Data <BOOLEAN>
 *
 * Example:
 * [] call cmf_3den_fnc_checklist
 *
 * Public: No
 */

private _allEntites = all3DENEntities;
private _allObjects = _allEntites select 0;
private _allSystems = _allEntites select 3;

/* Check if there exists playerunits */
private _playerUnits = _allObjects findIf {
    private _playable = (_x get3DENAttribute "ControlMP") select 0;
    private _player = (_x get3DENAttribute "ControlSP") select 0;
    
    (_player || _playable);
} > -1;

/* Check if there exists a zeus unit */
private _zeus = _allSystems findIf {
    _x isKindOf "ModuleCurator_F"
} > -1;

/* Check if there exists a respawn */
private _respawns = _allSystems findIf {
    _x isKindOf "ModuleRespawnPosition_F"
} > -1;

/* Check if kosher arsenal loadouts are valid */
_initPlayerLocal = preprocessFileLineNumbers "initPlayerLocal.sqf";
_groupDataString = _initPlayerLocal splitString toString [13, 10];

_line = _groupDataString findIf { toUpper "cmf_kosherArsenal_fnc_init" in toUpper _x };
_params = (_groupDataString select _line) regexFind ["\[.*\]"];
_params = ((_params select 0) select 0) select 0;
_params = parseSimpleArray _params;

private _loadoutValid = true;
{
    if (_x isEqualTo "!arsenal_template") exitWith { _loadoutValid = false };
    _loadoutValid = [_x] call EFUNC(kosherArsenal,validateLoadout);
    if (!_loadoutValid) exitWith {};
} forEach (_params select 0);

/* Check if there exists a ammobox */
private _ammobox = _allObjects findIf {
    [_x, QEFUNC(kosherArsenal,ammobox)] call cmf_3den_fnc_inInit;
} > -1;

/* Check if Mission data has been registered */
private _missionData = _allObjects findIf {
    (_x get3DENAttribute 'Name') isEqualTo ['cmf_3den_missionDataLogic_old'];
} > -1;

// Check for warning order

[_playerUnits, _zeus, _respawns, _loadoutValid, _ammobox, _missionData];