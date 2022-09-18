#include "script_component.hpp"
/*
 * Author: Eric
 * A tool for creating whitelists for kosherArsenal
 *
 * Arguments:
 * 0: Argument Name <TYPE>
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_3den_fnc_kosherArsenalTool
 *
 * Public: No
 */

// arsenal data (hashmap)
// [["roleName", [[backpacks], [vests], [uniforms], [facewear], [magazines], [weapons], [grenades], [items], {code to execute}]]]

// Define some tracker variables
/*GVAR(kosherArsenal_ctrls) = [];
GVAR(kosherArsenal_unit) = objNull;
GVAR(kosherArsenal_leftPanelFilled) = -1;
GVAR(kosherArsenal_rightPanelFilled) = -1;
GVAR(kosherArsenal_displayOpened) = -1;
GVAR(kosherArsenal_ctrlEvents) = []*/

if (isNil QGVAR(kosherArsenal_ctrlEvents)) then {
    GVAR(kosherArsenal_ctrlEvents) = [];
};

// Add subcategories for ace items
call compile preprocessFileLineNumbers "cmf\ace_settings.sqf";

cmf_3den_fnc_kosherArsenalTool = {
    // spawn a unit and open arsenal on it
    private _unit = create3DENEntity ["Object", "B_Soldier_F", (screenToWorld [0.5, 0.5])];
    _unit setUnitLoadout [[],[],[],[],[],[],"","",[],["ItemMap","","","ItemCompass","ItemWatch",""]];
    _unit switchMove "amovpercmstpsnonwnondnon";
    _unit enableSimulation true;

    GVAR(kosherArsenal_unit) = _unit;

    // Left panel filled eventhandler
    ["ace_arsenal_leftPanelFilled", GVAR(kosherArsenal_leftPanelFilled)] call CBA_fnc_removeEventHandler;
    GVAR(kosherArsenal_leftPanelFilled) = ["ace_arsenal_leftPanelFilled", {
        params ["_display"];

        private _ctrl = _display displayCtrl 13;

        private _rows = (lbSize _ctrl);
        for "_row" from 1 to (_rows - 1) step 1 do {
            _ctrl lbSetPicture [_row, "rsc\data\icon_checkbox_empty_ca.paa"];
        };

        private _ctrlEH = _ctrl ctrlAddEventHandler ["MouseButtonDblClick", {
            params ["_ctrl"];

            private _selectedIndex = lbCurSel _ctrl;

            if ((_ctrl lbPicture _selectedIndex) isEqualTo toLower (MISSION_PATH("rsc\data\icon_checkbox_empty_ca.paa"))) then {
                _ctrl lbSetPicture [_selectedIndex, "rsc\data\icon_checkbox_checked_ca.paa"];
            } else {
                _ctrl lbSetPicture [_selectedIndex, "rsc\data\icon_checkbox_empty_ca.paa"];
            };
        }];

        GVAR(kosherArsenal_ctrlEvents) pushBack [_ctrl, ["MouseButtonDblClick", _ctrlEH]];
    }] call CBA_fnc_addEventHandler;

    // Right panel filled eventhandler
    ["kosherArsenal_rightPanelFilled", GVAR(kosherArsenal_rightPanelFilled)] call CBA_fnc_removeEventHandler;
    GVAR(kosherArsenal_rightPanelFilled) = ["ace_arsenal_rightPanelFilled", {
        params ["_display"];

        private _ctrl = _display displayCtrl 14; // 14 and 15

        // LISTNBOX
        [_display, format["Loaded new right window"]] call ace_arsenal_fnc_message;
        if !(ace_arsenal_currentLeftPanel in [2002, 2004, 2006]) then {
            _ctrl = _display displayCtrl 15;

            private _ctrlMinus = (ctrlParent _ctrl) displayCtrl 101;
            private _ctrlPlus = (ctrlParent _ctrl) displayCtrl 102;

            _ctrlMinus ctrlSetBackgroundColor [0,0,0,0];
            _ctrlMinus ctrlSetTextColor [0,0,0,0];
            _ctrlPlus ctrlSetBackgroundColor [0,0,0,0];
            _ctrlPlus ctrlSetTextColor [0,0,0,0];
            _ctrlMinus ctrlRemoveAllEventHandlers "ButtonClick";
            _ctrlPlus ctrlRemoveAllEventHandlers "ButtonClick";

            private _rowsCols = (lnbSize _ctrl);

            for "_row" from 0 to ((_rowsCols select 0) - 1) step 1 do {
                _ctrl lnbSetPicture [[_row, 2], "rsc\data\icon_checkbox_empty_ca.paa"];
                _ctrl lnbSetColor [[_row, 2], [0,0,0,0]];
            };

        // LISTBOX
        } else {
            private _rows = (lbSize _ctrl);
            for "_row" from 1 to (_rows - 1) step 1 do {
                _ctrl lbSetPicture [_row, "rsc\data\icon_checkbox_empty_ca.paa"];
            };

            private _ctrlEH = _ctrl ctrlAddEventHandler ["MouseButtonDblClick", {
                params ["_ctrl"];

                private _selectedIndex = lbCurSel _ctrl;

                if ((_ctrl lbPicture _selectedIndex) isEqualTo toLower (MISSION_PATH("rsc\data\icon_checkbox_empty_ca.paa"))) then {
                    _ctrl lbSetPicture [_selectedIndex, "rsc\data\icon_checkbox_checked_ca.paa"];
                } else {
                    _ctrl lbSetPicture [_selectedIndex, "rsc\data\icon_checkbox_empty_ca.paa"];
                };
            }];
            GVAR(kosherArsenal_ctrlEvents) pushBack [_ctrl, ["MouseButtonDblClick", _ctrlEH]];
        };


    }] call CBA_fnc_addEventHandler;

    // display opened eventhandler
    ["ace_arsenal_displayOpened", GVAR(kosherArsenal_displayOpened)] call CBA_fnc_removeEventHandler;
    GVAR(kosherArsenal_displayOpened) = ["ace_arsenal_displayOpened", {
        params ["_display"];

        {
            ctrlDelete _x;
        } forEach GVAR(kosherArsenal_ctrls);

        {
            _x params ["_ctrl", "_event"];
            _ctrl ctrlRemoveEventHandler _event;
        } forEach GVAR(kosherArsenal_ctrlEvents);

        /* Create default whitelist hashmap */
        GVAR(kosherArsenal_whitelist) = createHashMapFromArray [
            ["DEFAULT", [[],[],[],[],[],[],[],["ACE_adenosine", "ACE_fieldDressing", "ACE_elasticBandage", "ACE_packingBandage", "ACE_quikclot", "ACE_epinephrine", "ACE_Flashlight_MX991", "ACE_MapTools", "ACE_morphine", "ACE_splint", "ACE_tourniquet", "ItemMap", "ItemCompass", "ItemWatch", "ACE_CableTie"],{}]],
            ["RFL", [[],[],[],[],[],[],[],[],{}]],
            ["SL", [[],[],[],[],[],[],[],[],{}]],
            ["MED", [[],[],[],[],[],[],[],["ACE_personalAidKit", "ACE_plasmaIV", "ACE_plasmaIV_250", "ACE_plasmaIV_500", "ACE_surgicalKit", "kat_chestSeal", "kat_larynx", "kat_stethoscope", "kat_amiodarone", "kat_lidocaine", "kat_IO_FAST", "kat_IV_16", "KAT_Empty_bloodIV_500", "KAT_Empty_bloodIV_250", "kat_AED"],{ player setVariable ["ace_medical_medicclass", 2, true]; }]]
        ];

        GVAR(kosherArsenal_ctrls) = [];
        private _selectCtrl = (_display ctrlCreate ["cmf_kosherArsenalTool_selectRole", -1]);
        private _deleteCtrl = (_display ctrlCreate ["cmf_kosherArsenalTool_deleteRole", -1]);
        private _textCtrl = (_display ctrlCreate ["cmf_kosherArsenalTool_textRole", -1]);
        private _addCtrl = (_display ctrlCreate ["cmf_kosherArsenalTool_addRole", -1]);
        GVAR(kosherArsenal_ctrls) = [_selectCtrl,_deleteCtrl,_textCtrl,_addCtrl];

        _textCtrl ctrlAddEventHandler ["SetFocus", {
            params ["_ctrl"];

            _ctrl ctrlSetText "";
        }];

    }] call CBA_fnc_addEventHandler;

    // display closed eventhandler
    ["ace_arsenal_displayClosed", {

        {
            ctrlDelete _x;
        } forEach GVAR(kosherArsenal_ctrls);

        {
            _x params ["_ctrl", "_event"];
            _ctrl ctrlRemoveEventHandler _event;
        } forEach GVAR(kosherArsenal_ctrlEvents);

        ["ace_arsenal_leftPanelFilled", GVAR(kosherArsenal_leftPanelFilled)] call CBA_fnc_removeEventHandler;
        ["kosherArsenal_rightPanelFilled", GVAR(kosherArsenal_rightPanelFilled)] call CBA_fnc_removeEventHandler;
        ["ace_arsenal_displayOpened", GVAR(kosherArsenal_displayOpened)] call CBA_fnc_removeEventHandler;
        ["ace_arsenal_displayClosed", _eventId] call CBA_fnc_removeEventHandler;

        delete3DENEntities [GVAR(kosherArsenal_unit)];
    }] call CBA_fnc_addEventHandler;

    // open arsenal
    [_unit, _unit, true] call ace_arsenal_fnc_openBox;
};
