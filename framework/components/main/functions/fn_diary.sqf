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

waitUntil{ missionNamespace getVariable ["cmf_main_server_initialized", false] };
waituntil {!isNull player && alive player};

/* Create subject */
player createDiarySubject ["cmf_diary", "CMF"];

addMissionEventHandler ["Map", {
	params ["_mapIsOpened"];

    if (!_mapIsOpened) then {
        /* Remove outdated roster */
        {
            player removeDiaryRecord ["cmf_diary", _x select 8]
        } forEach (player allDiaryRecords "cmf_diary");
    } else {
		/* Credits */
		player createDiaryRecord ["cmf_diary", ["Credits", "<br/><font size='13'>Cluster Mod Team:<br/>  - </font><font size='13' color='#fcba03'>Eric</font>"]];

		/* List CMF Keybinds */
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
				_keybindString = _keybindString + format ["<font size='13'> %1: <font color='#fcba03'>%2</font><br/>", _keybindTitle, _keybindKeys];
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
		player createDiaryRecord ["cmf_diary", ["Keybinds", _keybindString]];

		/* List loaded CMF Components */
		private _componentString = "<br/>";

		{
			_componentString = _componentString + format["<font size='13'> - </font><font size='13' color='#fcba03'>%1</font><br/>", _x]
		} forEach GVAR(components);

		player createDiaryRecord ["cmf_diary", ["Components", _componentString]];

		/* List version number for CMF and it's dependencies */
		private _versionString = "<br/>";

		private _cmfVersion = ["CMF3", missionNamespace getVariable "cmf_main_version"];
		private _cbaVersion = ["CBA3", getText (configFile >> "CfgPatches" >> "cba_main" >> "versionStr")];
		private _aceVersion = ["ACE3", getText (configFile >> "CfgPatches" >> "ace_main" >> "versionStr")];
		private _zenVersion = ["ZEN3", getText (configFile >> "CfgPatches" >> "zen_main" >> "versionStr")];

		{
			_versionString = _versionString + format["<font size='13'>%1 VERSION:</font><font size='13' color='#fcba03'>  %2</font><br/>", _x select 0, _x select 1]
		} forEach [_cmfVersion, _cbaVersion, _aceVersion, _zenVersion];

		player createDiaryRecord ["cmf_diary", ["Version", _versionString]];
    };
}];
