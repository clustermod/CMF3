if (!hasInterface) exitWith {};

ms_isSuppressor = {
    params ["_class", ["_threshold", 0.9]];

    if (_class isEqualTo "") exitWith { false };

    private _hash = missionNamespace getVariable ["ms_insideParticles_muzzleHash", [] call CBA_fnc_hashCreate];
    private _value = [_hash, _class] call CBA_fnc_hashGet;

    if (!isNil "_value") exitWith { _value < _threshold };

    private _value = getNumber (configFile >> "CfgWeapons" >> _class >> "ItemInfo" >> "AmmoCoef" >> "audibleFire");

    _hash = [_hash, _class, _value] call CBA_fnc_hashSet;
    ms_insideParticles_muzzleHash = _hash;
    publicVariable "ms_insideParticles_muzzleHash";

    _value < _threshold;
};

ms_inBuilding = {
    params ["_unit"];

    lineIntersectsSurfaces [
        getPosWorld _unit,
        getPosWorld _unit vectorAdd [0, 0, 50],
        _unit, objNull, true, 1, "GEOM", "NONE"
    ] select 0 params ["","","","_house"];

    if (isNil "_house") exitWith { false };
    if (_house isKindOf "House") exitWith { true };
    false;
};

ms_insideParticles_playSound = {
    params ["_unit"];

    private _sources = [];
    for "_i" from 1 to 2 do {
        private _index = _sources pushBack ("Land_HelipadEmpty_F" createVehicleLocal (_unit modelToWorld [0.2,1,0]));
        (_sources select _index) setPos [((_unit modelToWorld [0.2,1,0]) select 0), ((_unit modelToWorld [0.2,1,0]) select 1), 1.5];
    };

    _sources spawn {
        {
            _x say3D ["cmf_shot_inside", 100];
            sleep 0.01;
        } forEach _this;
        sleep 3;
        {
            deleteVehicle _x;
        } forEach _this;
    };
};

ms_insideParticles_spawnParticles = {
    params ["_unit", ["_threshold", 3]];

    private _oldParticles = missionNamespace getVariable ["ms_insideParticles_activeParticles", []];
    
    /* Exit if there already are particles on this position */
    if ((_oldParticles findIf { (_x select 0) distance _unit < _threshold }) > -1) exitWith {};

    /* Create particle sources */
    private _position = getPos _unit;
    private _positionASL = getPosASL _unit;
    private _smoke = "#particlesource" createVehicleLocal _position;
    private _sparks = "#particlesource" createVehicleLocal _position;
    _smoke setPosASL (_unit modelToWorldWorld [0, [1, 2.5] select (_unit isEqualTo player), 0]);
    _sparks setPosASL _positionASL;
    _oldParticles pushBack [_position, [_smoke, _sparks]];
    ms_insideParticles_activeParticles = _oldParticles;

    _smoke setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,12,13,0],"","Billboard",1,10,[0,0,1.2],[0,0,0],0,0.051,0.04,0,[1.6,3.5,3.5,3.5,3.5],[[0.305037,0.301192,0.3,0.0005],[0.385799,0.385799,0.385799,0.0005],[0.581936,0.581936,0.581936,0.005],[1,1,1,0.05],[0,0,0,0]],[1000,0],0.001,0.008,"","","",0,false,0,[[0,0,0,0],[0,0,0,0.0435224],[0,0,0,0.139667],[0,0,0,0],[0,1,1,0]]];
    _smoke setParticleCircle [1.5,[0,0,0]];
    _smoke setDropInterval 0.6;
    _sparks setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16,0,12,0],"","Billboard",1,20,[0,0,1.2],[0,0,0],0,10.071,7.9,0,[0.005,0.005,0.005,0.005,0.005,0.005,0.005,0.005,0.005,0],[[1,1,1,-6.5],[1,1,1,-6],[1,1,1,-5.5],[1,1,1,-4.5]],[1000],1,0,"","","",0,false,0,[[20000,13000,8000,0.5]]];
    _sparks setParticleRandom [1,[2,2,1],[0,0,0],0,0,[0,0.15,0.15,0],0,0,1,0];
    _sparks setDropInterval 0.2;

    [{
        deleteVehicle _this;
    }, _smoke, 50] call CBA_fnc_waitAndExecute;
    [{
        deleteVehicle (_this select 1);
        private _oldParticles = missionNamespace getVariable ["ms_insideParticles_activeParticles", []];
        _oldParticles deleteAt (_oldParticles find [(_this select 2), [(_this select 0), (_this select 1)]]);
        ms_insideParticles_activeParticles = _oldParticles;
    }, [_smoke, _sparks, _position], 65] call CBA_fnc_waitAndExecute;
};

private _fired = {
    params ["_unit"];

    /* Add eventhandler */
    _unit addEventHandler ["Fired", {
        params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

        /* Determine if unit is inside a building */
        if !([_unit] call ms_inBuilding) exitWith { };

        /* Play sound if weapon is unsuppressed */
        private _accessory = (_unit weaponAccessories _muzzle) select 0;
        if !([_accessory] call ms_isSuppressor) then {
            [_unit] call ms_insideParticles_playSound;
        };

        /* Spawn Particles */
        [_unit] call ms_insideParticles_spawnParticles;
    }];
};

["CAManBase", "init", _fired, true, [], true] call CBA_fnc_addClassEventHandler;