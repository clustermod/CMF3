/*
 * Author: Eric
 * Creates a arsenal at which players can restock on magazines and items.
 *
 * Arguments:
 * 0: obj <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [this] call EMF_fnc_kosherAmmoBox
 *
 * public: Yes
*/

params["_obj"];

// Check if params are set and is of correct type
if (isNil "_obj") exitWith {  ['Object is not set'] call BIS_fnc_error; 'Object is not set' call BIS_fnc_log;};
if (typeName _obj != "OBJECT") exitWith {  ['Object must be type "OBJECT", type %1 supplied', (typeName _obj)] call BIS_fnc_error; ['Object must be type "OBJECT", type %1 supplied', (typeName _obj)] call BIS_fnc_log;};

[_obj] spawn
{
	params["_obj"];

	// Wait until the whitelists has been defined and create an array of allowed items and magazines
	waitUntil{typeName (player getVariable ["EMF_KA_ArsenalKit", false]) != "BOOL"};
	private _arsenalLoadouts = player getVariable "EMF_KA_ArsenalKit";

	[ "AmmoboxInit", [ _obj, false, {(_this distance _target) < 10} ] ] call BIS_fnc_arsenal;

	_obj spawn {
		_this removeAction (_this getvariable "bis_fnc_arsenal_action") ;
		_this addaction [
			 "Rearm at Arsenal",
			 {
			  private _box = _this select 0;
			  private _unit = _this select 1;
			  ["Open",[nil,_box,_unit]] call bis_fnc_arsenal;
				// Define a function to remove all unecessary tabs from the arsenal GUI
			  private _removeCtrl =
			  {
				  {((findDisplay -1) displayCtrl _x) ctrlShow false} forEach [44151, 44150, 44147, 44148, 44149, 44346]; 								  								// Remove Controlbar Controls
				  {((findDisplay -1) displayCtrl _x) ctrlShow false} forEach [965, 963, 964, 994, 1801]; 												  												// Remove Itemlist controls
				  {((findDisplay -1) displayCtrl _x) ctrlShow false} forEach [805, 803, 804]; 												 			  														// Remove ItemlistSort controls
				  {((findDisplay -1) displayCtrl _x) ctrlShow false} forEach [939, 943, 945, 937, 941, 932, 936, 947, 940, 938, 930, 942, 931, 946, 944]; // Remove Category tabs
				  {((findDisplay -1) displayCtrl _x) ctrlShow false} forEach [909, 913, 915, 907, 911, 902, 906, 917, 910, 908, 900, 912, 901, 916, 914]; // Remove floating Icons
				  {((findDisplay -1) displayCtrl _x) ctrlShow false} forEach [839, 843, 845, 837, 841, 832, 836, 847, 840, 838, 830, 842, 831, 846, 844]; // Remove floating Icon backgrounds
			  };

			  call _removeCtrl;
			  (findDisplay -1) displayAddEventHandler ['keydown', '_this select 3'];

				// Create a event handler to
			  private _CtrlDrawEH = _removeCtrl spawn {
					while {!isnull (uinamespace getvariable "RSCDisplayArsenal")} do
					{
						waitUntil {ctrlShown ((findDisplay -1) displayCtrl 847)};
						call _this;
					};
			  };
			// Create an event handler to delete the previous event handler upon arsenal close.
			[missionNamespace, "arsenalClosed", {
				terminate _CtrlDrawEH;
			}] call BIS_fnc_addScriptedEventHandler;

			 },
			 [],
			 6,
			 true,
			 false,
			 "",
			 "
			  _cargo = _target getvariable ['bis_addVirtualWeaponCargo_cargo',[[],[],[],[]]];
			  if ({count _x > 0} count _cargo == 0) then {
			   _target removeaction (_target getvariable ['bis_fnc_arsenal_action',-1]);
			   _target setvariable ['bis_fnc_arsenal_action',nil];
			  };
			  _condition = _target getvariable ['bis_fnc_arsenal_condition',{true}];
			  alive _target && {_target distance _this < 5 && {vehicle _this == _this}} && {call _condition}
			 "
		];
	};

	if (typeName _arsenalLoadouts == "ARRAY") then
	{
		{
			if (player getVariable ["unitTeamRole", 0] == _forEachIndex) then
			{
				[(player getVariable ["unitSquadRole", 0]), _obj, true] execVM (format["rsc\loadouts\%1.sqf", _x]);
			}
		} forEach _arsenalLoadouts;
	} else {
		if (typeName _arsenalLoadouts == "STRING") then
		{
			[(player getVariable ["unitSquadRole", 0]), _obj, true] execVM (format["rsc\loadouts\%1.sqf", _arsenalLoadouts]);
		}
	};
};
