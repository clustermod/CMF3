params["_obj", "_respawns"];
_obj setVariable["EMF_playerRespawns", _respawns, true];
_obj setVariable["EMF_playerDeaths", 0, true];

[format["Your respawns have been set to: %1", _respawns]] remoteExec ["hint", _obj];
