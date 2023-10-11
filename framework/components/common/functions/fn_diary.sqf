#include "script_component.hpp"
/*
 * Author: Eric
 * Creates a diary entry containing information about the installed version of CMF
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] spawn cmf_main_fnc_diary
 *
 * Public: No
 */

[{ missionNamespace getVariable [QEGVAR(main,server_initialized), false] && (!isNull player && alive player) }, {
    /* Create subject */
    player createDiarySubject [QGVAR(diary), QUOTE(FRAMEWORK)];

    addMissionEventHandler ["Map", {
        params ["_mapIsOpened"];

        if (!_mapIsOpened) then {
            /* Remove outdated info */
            {
                player removeDiaryRecord [QGVAR(diary), _x select 8]
            } forEach (player allDiaryRecords QGVAR(diary));
        } else {
            /* Credits */
            player createDiaryRecord [QGVAR(diary), ["Credits", "<br/><font size='13'>Cluster Mod Team:<br/>  - </font><font size='13' color='#fcba03'>Eric</font>"]];

            /* List CMF Keybinds */
            // @TODO: Make more modular
            private _keybindString = "<br/><font size='13'>";
            {
                private _category = _x select 0;
                _keybindString = _keybindString + format ["%1:<br/>", _category];
                {
                    private _keybindTitle = "";
                    private _keybindKeys = "Failed to get keybind";
                    private _keybind = [_category, _x] call CBA_fnc_getKeybind;
                    if (!isNil "_keybind") then {
                        _keybindTitle = (_keybind select 2);
                        _keybindKeys = [(_keybind select 5)] call FUNC(keybindToString);
                    };
                    _keybindString = _keybindString + format ["<font size='13'>  %1: <font color='#fcba03'>%2</font><br/>", _keybindTitle, _keybindKeys];
                } forEach (_x select 1);
                _keybindString = _keybindString + "<br/>";
            } forEach [
                ["CMF: Common", [
                    "cmf_menu_toggleHUD"
                ]],
                ["CMF: Viewdistance", [
                    "cmf_viewdistance_open_settings",
                    "cmf_viewdistance_dec_viewdistance",
                    "cmf_viewdistance_inc_viewdistance",
                    "cmf_viewdistance_dec_terrain_quality",
                    "cmf_viewdistance_inc_terrain_quality"
                ]]
            ];
            player createDiaryRecord [QGVAR(diary), ["Keybinds", _keybindString]];

            /* List CMF Settings */
            private _clientSettings = "<br/><font size='13'>";
            {
                _clientSettings = _clientSettings + format ["%1:<br/>", _x];

                private _settingsArr = [GVAR(clientSettings), _x] call CBA_fnc_hashGet;
                {
                    private _title = [_x select 1, (_x select 1) select 0] select ((_x select 1) isEqualType []);
                    _clientSettings = _clientSettings + format [
                        "<font size='13'>  %1: <font color='#fcba03'>%2</font><br/>",
                        _title, 
                        str (missionNamespace getVariable [_x select 0, ""])
                    ];
                } forEach _settingsArr;
                _clientSettings = _clientSettings + "<br/>";
            } forEach ([GVAR(clientSettings)] call CBA_fnc_hashKeys);
            
            player createDiaryRecord [QGVAR(diary), ["Client Settings", _clientSettings]];

            private _missionSettings = "<br/><font size='13'>";
            {
                _missionSettings = _missionSettings + format ["%1:<br/>", _x];

                private _settingsArr = [GVAR(missionSettings), _x] call CBA_fnc_hashGet;
                {
                    private _title = [_x select 1, (_x select 1) select 0] select ((_x select 1) isEqualType []);
                    _missionSettings = _missionSettings + format [
                        "<font size='13'>  %1: <font color='#fcba03'>%2</font><br/>",
                        _title, 
                        str (missionNamespace getVariable [_x select 0, ""])
                    ];
                } forEach _settingsArr;
                _missionSettings = _missionSettings + "<br/>";
            } forEach ([GVAR(missionSettings)] call CBA_fnc_hashKeys);

            player createDiaryRecord [QGVAR(diary), ["Mission Settings", _missionSettings]];

            /* List loaded CMF Components */
            private _componentString = "<br/>";

            {
                _componentString = _componentString + format["<font size='13'> - </font><font size='13' color='#fcba03'>%1</font><br/>", _x]
            } forEach EGVAR(main,components);

            player createDiaryRecord [QGVAR(diary), ["Components", _componentString]];

            /* List version number for CMF and it's dependencies */
            private _versionString = "<br/>";

            private _cmfVersion = ["CMF3", missionNamespace getVariable QEGVAR(main,version)];
            private _cbaVersion = ["CBA3", getText (configFile >> "CfgPatches" >> "cba_main" >> "versionStr")];
            private _aceVersion = ["ACE3", getText (configFile >> "CfgPatches" >> "ace_main" >> "versionStr")];
            private _zenVersion = ["ZEN3", getText (configFile >> "CfgPatches" >> "zen_main" >> "versionStr")];

            {
                _versionString = _versionString + format["<font size='13'>%1 VERSION:</font><font size='13' color='#fcba03'>  %2</font><br/>", _x select 0, _x select 1]
            } forEach [_cmfVersion, _cbaVersion, _aceVersion, _zenVersion];

            player createDiaryRecord [QGVAR(diary), ["Version", _versionString]];
        };
    }];
}] call CBA_fnc_waitUntilAndExecute;

