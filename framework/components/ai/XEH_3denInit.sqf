#include "script_component.hpp"

waitUntil { !isNil { missionNameSpace getVariable QEGVAR(3den,menu_entity) } };

private _path = missionNameSpace getVariable QEGVAR(3den,menu_entity);

private _preventProneAction = [
	"Toggle preventProne",
	"a3\ui_f\data\igui\cfg\simpletasks\types\rearm_ca.paa",
	{
		if (count get3DENSelected "object" == 0) exitWith {
			["No Objects selected", 0, 1] call BIS_fnc_3DENNotification;
		};

		private _command = toString { this setVariable [QEGVAR(utility,preventProne_disable), false] };
		{
			if !([_x, _command] call EFUNC(3den,inInit)) then {
				[_x, _command] call EFUNC(3den,addToInit);
			} else {
				[_x, _command] call EFUNC(3den,removeFromInit);
			};
		} forEach get3DENSelected "object";

		["Toggled preventProne on selected units", 0, 1] call BIS_fnc_3DENNotification;
	}
];

[
	_path, 
	"AI",
	"a3\3den\data\displays\display3den\toolbar\open_ca.paa",
	{},
	[],
	[
		_preventProneAction
	]
] call EFUNC(3den,addMenuItem);