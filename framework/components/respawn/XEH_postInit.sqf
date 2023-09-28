#include "script_component.hpp"

GVAR(_SETTING_unconciousTimer) = CONFIG_PARAM_3(SETTINGS,respawn,unconciousTimer);

[
	{ !isNull (findDisplay 49) }, 
	{
		disableSerialization;
		private _ctrl = (findDisplay 49) ctrlCreate ["RscText", -1];
		_ctrl ctrlSetTextColor [1, 0.3, 0.3, 1];
		_ctrl ctrlSetFontHeight (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);

		_ctrl ctrlSetPosition [
			( safeZoneX + ( safeZoneWAbs / 2 )) - ( 0.5 / 2 ),
			(( safeZoneY + safeZoneH ) - 0.1) - 0.1,
			0.5,
			0.1
		];

		_ctrl ctrlShow false;
		_ctrl ctrlCommit 0;

		uiNamespace setVariable [QGVAR(ctrlCounter), _ctrl];
	}
] call CBA_fnc_waitUntilAndExecute;

GVAR(countdownHandler) = scriptNull;
GVAR(respawnState) = false;
GVAR(respawnTimer) = GVAR(_SETTING_unconciousTimer);

[FUNC(respawnButtonPFH)] call CBA_fnc_addPerFrameHandler;
["ace_unconscious", FUNC(unconciousEH)] call CBA_fnc_addEventHandler;
player addEventHandler ["Respawn", FUNC(respawnEH)];