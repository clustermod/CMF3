if (!isServer) exitWith {};

private _explosions = ["BattlefieldExplosions1_3D", "BattlefieldExplosions2_3D", "BattlefieldExplosions5_3D"];
private _fireFights = ["BattlefieldFirefight1_3D", "BattlefieldFirefight2_3D"];

{
  [_forEachIndex, _explosions, _fireFights] spawn {
    private ["_index","_explosions", "_fireFights"];
    private _flashFunction = {
      private _light = "#lightpoint" createVehicle [0,0,0];
      _light setLightBrightness 0.2;
      _light setLightAttenuation [2,4,4.31918e-005,0];
      _light setLightAmbient [0.41, 0.45, 0.72];
      _light setLightColor [0.41, 0.45, 0.72];
      _light setLightAmbient [0.41,0.45,0.72];
      sleep 0.1;
      deleteVehicle _light;
    };

    _index = _this select 0;
    scriptName format ["initAmbientSounds.sqf: random sound playing - [%1]", _index];
    _explosions = _this select 1;
    _fireFights = _this select 2;
    while {true} do {
      sleep (1 + random 59);
      private ["_sound"];
      _sound = if (random 1 < 0.5) then {
        _explosions call BIS_fnc_selectRandom
      } else {
        _fireFights call BIS_fnc_selectRandom
      };
      [_sound] remoteExec ["playSound", 0, false];
      [_sound] remoteExec ["playSound", 0, false];
      [_sound] remoteExec ["playSound", 0, false];
      [_sound] remoteExec ["playSound", 0, false];

      [] remoteExecCall ["_flashFunction", 0, false];
    };
  };
} forEach [0,1,2];
