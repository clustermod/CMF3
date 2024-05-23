#include "script_component.hpp"
/*
 * Author: Eric
 * Runs checks for a minimal list of required things for Cluster Community Missions
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
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

// Check Kosher Arsenal loadout

/* Check if there exists a ammobox */
private _ammobox = _allObjects findIf {
    [_x, QEFUNC(kosherArsenal,ammobox)] call cmf_3den_fnc_inInit;
} > -1;

// Check for Mission Data
private _missionData = _allObjects findIf {
    (_x get3DENAttribute 'Name') isEqualTo ['cmf_3den_missionDataLogic_old'];
} > -1;

// Check for warning order