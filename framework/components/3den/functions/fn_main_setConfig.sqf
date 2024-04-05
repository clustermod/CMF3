#include "script_component.hpp"
/*
 * Author: Eric
 * Sets CMF Mission Data
 *
 * Arguments:
 * 0: CMF Menu Index <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [0] call cmf_3den_fnc_setConfig
 *
 * Public: No
 */

params ["_cmfMenu"];

/* Handle player attempting to delete logic */
{
    if ((_x get3DENAttribute 'Name') isEqualTo ['cmf_3den_missionDataLogic_old']) then {
        _x addEventHandler ['UnregisteredFromWorld3DEN', {
            params ['_entity'];
            ['Deleted CMF Mission Data', 1, 1] call BIS_fnc_3DENNotification;
        }];
    };
} forEach (all3DENEntities select 0);

/* Handle Mission Data */
FUNC(setConfig_missionDataHandler) = {
    private _logics = (all3DENEntities select 0) select { (_x get3DENAttribute 'Name') isEqualTo ['cmf_3den_missionDataLogic_old'] };
    private _logic = objNull;
    if (count _logics isEqualTo 0) then {
        _logic = create3DENEntity ['Object', 'Logic', [0,0,0], true];
        _logic set3DENAttribute ['Name', QGVAR(missionDataLogic_old)];
    } else {
        _logic = _logics select 0;
    };

    GVAR(missionDataLogic_old) = _logic;

    _logic addEventHandler ['UnregisteredFromWorld3DEN', {
        params ['_entity'];
        ['Deleted CMF Mission Data', 1, 1] call BIS_fnc_3DENNotification;
    }];

    /* Open mission data display */
    private _display3DEN = uiNamespace getVariable "Display3DEN";
    private _display = _display3DEN createDisplay QGVAR(missionMenu);

    [_display, _logic] spawn {
        params ["_display", "_logic"];

        waitUntil { !isNull _display };

        /* load previous data */
        call compile ((_logic get3DENAttribute "Init") select 0);
        if (!isNil QEGVAR(common,missionData)) then {
            private _hash = [EGVAR(common,missionData)] call CBA_fnc_hashCreate;

            (_display displayCtrl 100) ctrlSetText ([_hash, "M_TITLE", ""] call CBA_fnc_hashGet);
            (_display displayCtrl 101) lbSetCurSel (([_hash, "M_TYPE", [0]] call CBA_fnc_hashGet) select 0);
            (_display displayCtrl 102) ctrlSetText ([_hash, "M_CTYPE", ""] call CBA_fnc_hashGet);
            (_display displayCtrl 200) ctrlSetText ([_hash, "E_MAP", ""] call CBA_fnc_hashGet);
            (_display displayCtrl 201) ctrlSetText ([_hash, "E_GPS", ""] call CBA_fnc_hashGet);
            (_display displayCtrl 202) ctrlSetText ([_hash, "E_RADIO", ""] call CBA_fnc_hashGet);
            (_display displayCtrl 203) ctrlSetText ([_hash, "E_NVG", ""] call CBA_fnc_hashGet);
            (_display displayCtrl 204) ctrlSetText ([_hash, "E_FLASHLIGHT", ""] call CBA_fnc_hashGet);
            (_display displayCtrl 205) ctrlSetText ([_hash, "E_FLARE", ""] call CBA_fnc_hashGet);
        };

        private _btnConfirm = _display displayCtrl 1;
        _btnConfirm ctrlAddEventHandler ["ButtonClick", {
            params ["_ctrl"];

            private _display = ctrlParent _ctrl;

            /* Create Hash Map of values */
            _hash = [];

            /* Mission Title */
            _hash pushBack ["M_TITLE", ctrlText (_display displayCtrl 100)];

            /* Mission Type */
            _hash pushBack ["M_TYPE", [lbCurSel (_display displayCtrl 101), (_display displayCtrl 101) lbData (lbCurSel (_display displayCtrl 101))]];
            _hash pushBack ["M_CTYPE", ctrlText (_display displayCtrl 102)];

            /* Equipment Map */
            _hash pushBack ["E_MAP", ctrlText (_display displayCtrl 200)];

            /* Equipment GPS */
            _hash pushBack ["E_GPS", ctrlText (_display displayCtrl 201)];

            /* Equipment Radio */
            _hash pushBack ["E_RADIO", ctrlText (_display displayCtrl 202)];

            /* Equipment NVG */
            _hash pushBack ["E_NVG", ctrlText (_display displayCtrl 203)];

            /* Equipment Flashlight */
            _hash pushBack ["E_FLASHLIGHT", ctrlText (_display displayCtrl 204)];

            /* Equipment Flare */
            _hash pushBack ["E_FLARE", ctrlText (_display displayCtrl 205)];

            /* Save to logic init */
            GVAR(missionDataLogic_old) set3DENAttribute ["Init", format ["if (!isServer) exitWith { }; missionNamespace setVariable [""%1"", %2, true];", QEGVAR(common,missionData), str _hash]];

            /* Set mission attributes */
            _hash = [_hash] call CBA_fnc_hashCreate;
            private _pictures = [
                "components\3den\data\icon_gametype_scenario_ca.paa",
                "components\3den\data\icon_gametype_custom_ca.paa",
                "components\3den\data\icon_gametype_sandbox_ca.paa",
                "components\3den\data\icon_gametype_training_ca.paa",
                "components\3den\data\icon_gametype_invasion_ca.paa",
                "components\3den\data\icon_gametype_assault_ca.paa",
                "components\3den\data\icon_gametype_defence_ca.paa",
                "components\3den\data\icon_gametype_csar_ca.paa",
                "components\3den\data\icon_gametype_qrf_ca.paa"
            ];
            private _picture = if ((lbCurSel (_display displayCtrl 101)) > count _pictures - 1) then {
                "components\3den\data\icon_gametype_empty_ca.paa"
            } else {
                _pictures select (lbCurSel (_display displayCtrl 101))
            };
            private _gameType = [([_hash, "M_TYPE"] call CBA_fnc_hashGet) select 1, [_hash, "M_CTYPE"] call CBA_fnc_hashGet] select ((([_hash, "M_TYPE"] call CBA_fnc_hashGet) select 1) isEqualTo "custom");
            private _author = profileName;
            private _gameName = [_hash, "M_TITLE"] call CBA_fnc_hashGet;

            set3DENMissionAttributes [
                ["intel", "IntelBriefingName", _gameName],
                ["Scenario", "Author", _author],
                ["Scenario", "OverviewPicture", _picture],
                ["Scenario", "OverviewPictureLocked", _picture],
                ["Scenario", "LoadScreen", _picture]
            ];

            ["Saved Mission Data", 0, 4] call BIS_fnc_3DENNotification;
        }];
    };
};