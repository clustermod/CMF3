#include "script_component.hpp"

waitUntil { !isNil QEGVAR(3den,menu_entity) };

private _path = EGVAR(3den,menu_entity);

private _createVehicleSpawner = [
    "Create Vehicle spawner",
    "a3\ui_f_curator\data\rsccommon\rscattributerespawnposition\guer_ca.paa",
    {
        ["Settings", [["EDIT", ["Spawner Type", "The whitelist to use for this spawner."], [""]]], {
            (_this select 0) params [["_type", ""]];

            private _position = screenToWorld [0.5, 0.5];

            private _spawnerpadVar = (all3DENEntities select 0) select { (_x get3DENAttribute 'Name') isEqualTo ['cmf_3den_missionDataLogic_old'] };
            for "_y" from 1 to 9001 do {
                _spawnerpadVar = QGVAR(spawnpad_) + str(_y);
                if ((all3DENEntities select 0) findIf { [_spawnerpadVar] isEqualTo (_x get3DENAttribute 'Name')} isEqualTo -1) exitWith {};
            };

            private _spawner = create3DENEntity ["Object", "Land_InfoStand_V2_F", _position, true];
            _spawner set3DENAttribute ["Rotation", [0, 0, 270]];

            _position set [0, (_position select 0) - 6];
            private _spawnerPad = create3DENEntity ["Object", "Land_HelipadEmpty_F", _position, true];
            _spawnerPad set3DENAttribute ["Name", _spawnerpadVar];
            
            add3DENConnection ["Sync", [_spawnerPad], _spawner];

            _spawner set3DENAttribute ["Init", [
                format ["[this, %1, ""%2""] call %3;", _spawnerpadVar, _type, QUOTE(FUNC(init))]
            ] joinString endl];

            ["Created vehicle spawner", 0, 1] call BIS_fnc_3DENNotification;
        }, {}, []] call zen_dialog_fnc_create;
    }
];

[
    _path,
    QUOTE(MODULE_BEAUTIFIED),
    "a3\3den\data\displays\display3den\toolbar\open_ca.paa",
    {},
    [],
    [
        _createVehicleSpawner
    ]
] call EFUNC(3den,addMenuItem);