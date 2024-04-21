STHud_Namelist = {
    params ["_canvas"];

    /* Create new column for name positions */
    private _uiXDist = ((STHud_Namepos select 6) select 0) - ((STHud_Namepos select 0) select 0);
    for "_i" from count STHud_Namepos - 6 to count STHud_Namepos - 1 do {
        private _prevColX = (STHud_Namepos select _i) select 0;
        private _prevColY = (STHud_Namepos select _i) select 1;
        STHud_Namepos pushBack [_prevColX + _uiXDist, _prevColY];
    };

    /* Create new column for selection positions */
    for "_i" from count STHud_Selectpos - 6 to count STHud_Selectpos - 1 do {
        private _prevColX = (STHud_Selectpos select _i) select 0;
        private _prevColY = (STHud_Selectpos select _i) select 1;
        STHud_Selectpos pushBack [_prevColX + _uiXDist, _prevColY];
    };

    /* Get all units including children and parent groups */
    private _allUnits = [];
    if ([group player] call cmf_organization_fnc_groupIsRegistered) then {
        private _groupData = [group player] call cmf_organization_fnc_groupGetData;
        private _parentData = [(_groupData select 2)] call cmf_organization_fnc_groupGetData;

        /* Add parent if is less than level 2 */
        if ( !isNull (_groupData select 2) && { _parentData select 0 < 2 }) then {
            _allUnits append units (_groupData select 2);

            /* Add children of parent */
            {
                private _childData = [_x] call cmf_organization_fnc_groupGetData;

                _allUnits append units _x;
            } forEach (_parentData select 3);
        } else {
            /* Add own group */
            _allUnits append units player;
        };

        /* Add children */
        {
            private _childData = [_x] call cmf_organization_fnc_groupGetData;

            if (_childData select 0 <= 0) then {
                _allUnits append units _x;
            };
        } forEach (_groupData select 3);
    } else {
        _allUnits append units player;
    };

    private _units = [] call CBA_fnc_hashCreate;
    private _unitsCount = 0;
    {
        if (alive _x || {!isNil {_x getVariable "sth_name"}}) then {
            _oldUnits = [_units, group _x, []] call CBA_fnc_hashGet;
            _oldUnits pushBack [_x, _x call STHud_Colour_Text];
            _units = [_units, group _x, _oldUnits] call CBA_fnc_hashSet;

            _unitsCount = _unitsCount + 1;
        };
    } forEach _allUnits;


    // Could expand this to check if the player is a driver, gunner, or commander, but I don't recall what exactly is needed to check to catch multiple turrets etc while excluding FFV.
    if (STHud_ShowBearingInVehicle && {vehicle player != player}) then {
        private _viewVec = positionCameratoWorld [0,0,0] vectorFromTo positionCameraToWorld [0,0,50];
        private _bearing = ((_viewVec select 0) atan2 (_viewVec select 1) + 360) % 360;

        private _bearingBase = (str round _bearing);
        private _bearingPretty = "";

        switch (count _bearingBase) do
        {
            case 1: {_bearingPretty = "00" + _bearingBase};
            case 2: {_bearingPretty = "0" + _bearingBase};
            case 3: {_bearingPretty = _bearingBase};
        };

        private _bearingColour = [[1,1,1,.9], "STUI_Unconscious_Fade_HUD_Bearing"] call STHud_UnconsciousColourFade;

        _canvas drawIcon
        [
            "#(argb,8,8,3)color(0,0,0,0)", _bearingColour,
            STHud_Bearing,
            16, 16, 0,
            _bearingPretty, STHud_TextShadow, 0.035, STHud_Font, "Center"
        ];
    };

    if (_unitsCount isEqualTo 1) exitWith {};

    private _fullName = _unitsCount < 7;
    private _playerGroupData = [group player] call cmf_organization_fnc_groupGetData;

    private _unitIndex = 0;
    {
        private _group = _x;
        private _groupUnits = [_units, _group, []] call CBA_fnc_hashGet;
        private _groupName = (_group getVariable ["cmf_organization_groupName", [groupId _group]]) select 0;
        private _groupData = [_group] call cmf_organization_fnc_groupGetData;
        
        _groupUnits = [_groupUnits, [], {
            if (leader group (_x select 0) isEqualTo (_x select 0)) exitWith { 0 };
            if (assignedTeam leader group (_x select 0) isEqualTo assignedTeam (_x select 0)) exitWith { 1 };

            switch (_x select 1) do {
                case [1,1,1,1]: { 2 };
                case [1,1,0.67,1]: { 3 };
                case [1,0.67,0.67,1]: { 4 };
                case [0.67,1,0.67,1]: { 5 };
                case [0.67,0.67,1,1]: { 6 };
                default { 5 };
            };
        }] call BIS_fnc_sortBy;

        /* Don't display parent group above squadlevel*/
        if (_playerGroupData select 0 > 1 && { _group isEqualTo (_playerGroupData select 2) }) then {
            continue;
        };

        /* Draw group on new column */
        if (_playerGroupData select 0 < 2) then {
            if (_unitIndex != 0 && { _unitIndex % 6 isNotEqualTo 0 }) then {
                _unitIndex = _unitIndex + (6 - _unitIndex % 6);
            };
        };

        _groupColor = [1, 1, 1, 1];

        /* Fade unit name if not in player group */
        if (_group isNotEqualTo group player) then {
            _groupColor set [3, 0.75];
        };

        /* Add Group name */
        if (_unitIndex > count STHud_Namepos - 1) exitWith {};
        _canvas drawIcon [
            "#(argb,1,1,1)color(0,0,0,0)", _groupColor,
            STHud_Namepos select _unitIndex,
            16, 16, 0,
            _groupName, STHud_TextShadow, 0.035, STHud_Font, "Right"
        ];
        _unitIndex = _unitIndex + 1;

        {
            _x params ["_unit", "_colour"];

            if (_unitIndex > count STHud_Namepos - 1) exitWith {};

            private _isUnitSelected = if ([player] call STHUD_IsGroupLeader) then {_unit in groupSelectedUnits player} else {false}; // Check if they're leader, if not, ignore.
            private _selIndicator = "";
            if _isUnitSelected then { _selIndicator = "> " }; // Tried this on the left and right. Being on the left seems to make it 'pop' more.
            private _icon = [_unit, false] call STHud_Icon;

            private _finalName = ([_unit, _fullName] call STHud_GetName);

            if STHud_NoSquadBarMode then {_finalName = _selIndicator + _finalName;};

            if (count (groupSelectedUnits player) > 0 && STHud_NoSquadBarMode && { _unit in units player }) then {
                private _tempName = vehicleVarName _unit;
                _unit setVehicleVarName "";
                private _strName = str _x;
                _unit setVehicleVarName _tempName;
                private _pl = _strName find ":";
                private _numStr = _strName select [_pl +1,2];
                if (_numStr find "," > -1 || _numStr find " " > -1) then {_numStr = _numStr select [0,1]};

                private _selectedUnitsColour = [[1,1,1,1], "STUI_Unconscious_Fade_HUD_SelectedUnits"] call STHud_UnconsciousColourFade;

                /* Fade unit name if not in player group */
                if !(_unit in units player) then {
                    _selectedUnitsColour set [3, 0.75];
                };

                _canvas drawIcon
                [
                    "#(argb,1,1,1)color(0,0,0,0)", _selectedUnitsColour,
                    STHud_Selectpos select _unitIndex,
                    1, 1, 0,
                    _numStr, STHud_TextShadow, 0.035, STHud_Font, "Left"
                ];
            };

            private _nameColour = [_colour, "STUI_Unconscious_Fade_HUD_Names"] call STHud_UnconsciousColourFade;

            /* Fade unit name if not in player group */
            if !(_unit in units player) then {
                _nameColour set [3, 0.75];
            };
            
            _canvas drawIcon
            [
                _icon, _nameColour,
                STHud_Namepos select _unitIndex,
                16, 16, 0,
                _finalName, STHud_TextShadow, 0.035, STHud_Font, "Right"
            ];
            _unitIndex = _unitIndex + 1;
        } forEach _groupUnits;
    } forEach ([_units] call CBA_fnc_hashKeys);

    if (count (groupSelectedUnits player) > 0 && STHud_NoSquadBarMode) then
    {
        private _groupNameColour = [[1,1,1,1], "STUI_Unconscious_Fade_HUD_GroupName"] call STHud_UnconsciousColourFade;

        _canvas drawIcon
        [
            "#(argb,1,1,1)color(0,0,0,0)", _groupNameColour,
            STHud_GroupNamePos,
            16, 16, 0,
            group player getVariable ["STMF_GroupID", ""], STHud_TextShadow, 0.035, STHud_Font, "Right"
        ];
    };
};

/* Set icon dynamically */
STHud_IsAttendant = {
    params ["_type", "_unit"];
    (getNumber(configFile >> "CfgVehicles" >> _type >> "attendant") isEqualTo 1) || (_unit getVariable ["ace_medical_medicClass", 0] > 0);
};

STHud_IsEngineer = {
    params ["_type", "_unit"];
    (getNumber(configFile >> "CfgVehicles" >> _type >> "engineer") isEqualTo 1) || (_unit getVariable ["ACE_IsEngineer", 0] > 0);
};

STHud_IsEOD = {
    params ["_type", "_unit"];
    (getNumber(configFile >> "CfgVehicles" >> _type >> "canDeactivateMines") isEqualTo 1) || (_unit getVariable ["ACE_IsEOD", 0] > 0);
};

STHud_Icon = {
    params ["_unit", ["_disableVehicleIcons", true]];

    //checking if the player is in a vehicle and if vehicle role icons are disabled
    //we only want to change the role icon next to their name on the HUD
    if (vehicle _unit != _unit && !_disableVehicleIcons) exitWith {
        //selecting this specific _unit from vehicle crew array and determining role
        private _crewInfo = ((fullCrew (vehicle _unit)) select {_x select 0 isEqualTo _unit}) select 0;
        _crewInfo params ["", "_role", "_index", "_turretPath", "_isTurret"];
        if (_role isEqualTo "cargo") exitWith {
            "a3\ui_f\data\igui\cfg\commandbar\imagecargo_ca.paa"
        };

        if (_role isEqualTo "driver") exitWith {
            if (vehicle _unit isKindOf "Air") then {
                //no suitable icons for this so we are using a resized one
                "@stui\addons\grouphud\imagepilot_ca.paa"
            } else {
                "a3\ui_f\data\igui\cfg\commandbar\imagedriver_ca.paa"
            };
        };

        //FFV
        if (_role isEqualTo "turret" && _isTurret) exitWith {
            "a3\ui_f\data\igui\cfg\simpletasks\types\rifle_ca.paa"
        };

        //gunners and sometimes copilots
        if (_role isEqualTo "gunner" || (_role isEqualTo "turret" && !_isTurret)) exitWith {
            "a3\ui_f\data\igui\cfg\commandbar\imagegunner_ca.paa"
        };

        if (_role isEqualTo "commander") exitWith {
            "a3\ui_f\data\igui\cfg\commandbar\imagecommander_ca.paa"
        };
    };

    if (leader(_unit) isEqualTo _unit) exitWith {
        "\A3\ui_f\data\map\vehicleicons\iconManLeader_ca.paa";
    };

    private _type = typeof(_unit);
    private _isatd = player getVariable ("isatd_"+_type);
    _isatd = [_type, _unit] call STHud_IsAttendant;
    player setVariable ["isatd_" + _type, _isatd];
    if (_isatd) exitWith {
        "\A3\ui_f\data\map\vehicleicons\iconManMedic_ca.paa";
    };

    private _type = typeof(_unit);
    private _iseng = player getVariable ("iseng_"+_type);
    _iseng = [_type, _unit] call STHud_IsEngineer;
    player setVariable ["iseng_" + _type, _iseng];
    if (_iseng) exitWith {
        "\A3\ui_f\data\map\vehicleicons\iconManEngineer_ca.paa";
    };

    private _type = typeof(_unit);
    private _isEOD = player getVariable ("isEOD_"+_type);
    _isEOD = [_type, _unit] call STHud_IsEOD;
    player setVariable ["isEOD_" + _type, _isEOD];
    if (_isEOD) exitWith {
        "\A3\ui_f\data\map\vehicleicons\iconManExplosive_ca.paa";
    };

    private _prim = primaryWeapon(_unit);
    private _ismg = player getVariable ("ismg_" + _prim);
    if (isNil {_ismg}) then {
        _ismg = _prim call STHud_IsMG;
        player setVariable ["ismg_" + _prim, _ismg];
    };

    if (_ismg) exitWith {
        "\A3\ui_f\data\map\vehicleicons\iconManMG_ca.paa";
    };

    private _BadArr = ["UK3CB_BAF_L16_Tripod", "UK3CB_BAF_L111A1", "UK3CB_BAF_L134A1", "UK3CB_BAF_M6", "UK3CB_BAF_Tripod"];
    private _sec = secondaryWeapon(_unit);
    private _isat = player getVariable ("isat_"+_sec);
    if (isNil {_isat}) then {
        if ((_BadArr find _sec) <= 0) then {
            _isat = _sec call STHud_IsAT;
        };
        player setVariable ["isat_"+_sec, _isat];
    };
    if (_isat and !_ismg and !_isEOD and !_isatd and !_iseng) exitWith {
        "\A3\ui_f\data\map\vehicleicons\iconManAT_ca.paa";
    };

    STHud_BGIcon;
};