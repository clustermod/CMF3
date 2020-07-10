KK_fnc_vectorDirAndUpRelative = {
    private ["_o1","_o2","_v"];
    _o1 = _this select 0;
    _o2 = _this select 1;
    _v = _o2 worldToModelVisual [0,0,0];
    [
        _o2 worldToModelVisual vectorDirVisual _o1 vectorDiff _v,
        _o2 worldToModelVisual vectorUpVisual _o1 vectorDiff _v
    ]
};

private ["_o","_v"];
_o = _this select 0;
_v = _this call KK_fnc_vectorDirAndUpRelative;
_o attachTo [_this select 1];
_o setVectorDirAndUp _v;
