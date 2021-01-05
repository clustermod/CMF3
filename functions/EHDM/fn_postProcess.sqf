/*
 * Author: Eric
 * Handle postprocess effects
 *
 * Arguments:
 * 0: playerDamage <NUMBER>
 *
 * Return Value:
 * Boolean
 *
 * Example:
 * [1] call EMF_fnc_postProcess
 *
 * Public: No
 */
params["_playerDamage"];

switch (_playerDamage) do
{
	case 0:
	{
		// Minor
		[] spawn
		{
			cutText ["", "BLACK OUT", 1];
			uisleep 0.2;
			[1, "BLACK", 0.3, 0.3] call BIS_fnc_fadeEffect;

			"RadialBlur" ppEffectEnable true;
			"RadialBlur" ppEffectAdjust[0.05,0,0,0];
			"RadialBlur" ppEffectCommit 2;
			uisleep 1;
			"RadialBlur" ppEffectAdjust[0,0.02,0,0];
			"RadialBlur" ppEffectCommit 2;
			uisleep 0.7;
			"RadialBlur" ppEffectEnable false;
		};
	};
	case 1:
	{
		// Medium
		[] spawn
		{
			cutText ["", "BLACK OUT", 1];
			uisleep 0.3;
			[1, "BLACK", 1, 0.3] call BIS_fnc_fadeEffect;

			"RadialBlur" ppEffectEnable true;
			"RadialBlur" ppEffectAdjust[0.05,0,0,0];
			"RadialBlur" ppEffectCommit 2;
			uisleep 1;
			[0, "BLACK", 2, 0.6] call BIS_fnc_fadeEffect;
			uisleep 0.6;
			[1, "BLACK", 2, 0.3] call BIS_fnc_fadeEffect;
			uisleep 0.3;
			"RadialBlur" ppEffectAdjust[0,0.02,0,0];
			"RadialBlur" ppEffectCommit 2;
			uisleep 0.7;
			"RadialBlur" ppEffectEnable false;
		};
	};
	case 2:
	{
		// Severe
		[] spawn
		{
			cutText ["", "BLACK OUT", 1];
			uisleep 0.4;
			[1, "BLACK", 2, 0.3] call BIS_fnc_fadeEffect;

			"RadialBlur" ppEffectEnable true;
			"RadialBlur" ppEffectAdjust[0.05,0,0,0];
			"RadialBlur" ppEffectCommit 2;
			uisleep 1;
			[0, "BLACK", 2, 0.6] call BIS_fnc_fadeEffect;
			uisleep 0.6;
			[1, "BLACK", 2, 0.3] call BIS_fnc_fadeEffect;
			uisleep 0.3;
			"RadialBlur" ppEffectAdjust[0,0.02,0,0];
			"RadialBlur" ppEffectCommit 2;
			uisleep 0.7;
			"RadialBlur" ppEffectAdjust[0.02,0,0,0];
			"RadialBlur" ppEffectCommit 2;
			uisleep 2;
			"RadialBlur" ppEffectAdjust[0.01,0.01,0.01,0];
			"RadialBlur" ppEffectCommit 2;
			uisleep 0.3;
			"RadialBlur" ppEffectEnable false;
		};
	};
};
