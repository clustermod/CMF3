params["_unit", "_level", ["_safeStart", false]];
private _heavyMasks = ["G_CBRN_M04", "G_CBRN_M04_Hood", "G_CBRN_M50", "G_CBRN_M50_Hood", "G_RegulatorMask_F", "G_AirPurifyingRespirator_02_Black_F", "G_AirPurifyingRespirator_02_Olive_F", "G_AirPurifyingRespirator_02_Sand_F", "G_AirPurifyingRespirator_01_F", "G_CBRN_S10"];
private _lightMasks = ["G_Respirator_blue_F", "G_Respirator_white_F", "G_Respirator_yellow_F", "rhs_scarf"];
private _heavySuits = ["U_C_CBRN_Suit_01_Blue_F", "U_O_CBRN", "U_B_CBRN", "U_B_CBRN_Suit_01_MTP_F", "U_I_CBRN", "U_B_CBRN_Suit_01_Tropic_F", "U_C_CBRN_Suit_01_White_F", "U_B_CBRN_Suit_01_Wdl_F", "U_I_CBRN_Suit_01_AAF_F", "U_I_E_CBRN_Suit_01_EAF_F"];

private _level_0 = _lightMasks + _heavyMasks;
private _level_1 = _heavySuits + _lightMasks;
private _level_2 = _heavySuits + _heavyMasks;

waitUntil{alive _unit};

private _setDamage =
{
	if (_unit getVariable ["unitIsDirty", false]) exitWith {};
	params["_unit"];
	_unit setVariable ["unitIsDirty", true];

	[_unit] spawn
	{
		params["_unit"];
		if (!(_unit getVariable ["unitIsDirty", true])) exitWith {};
		[_unit, 1] call ace_medical_fnc_adjustPainLevel;
		[_unit, "Cough5", 5] remoteExec ["say3D", 0];
		uisleep 4;
		[_unit, "Cough5", 5] remoteExec ["say3D", 0];
		uisleep 3;
		[_unit, "Cough6", 5] remoteExec ["say3D", 0];
		uisleep 3;
		[_unit, "Cough6", 5] remoteExec ["say3D", 0];
		if (!(_unit getVariable ["unitIsDirty", true])) exitWith {};
		[_unit, true] call ace_medical_status_fnc_setCardiacArrestState;
		[_unit, true, 5, true] call ace_medical_fnc_setUnconscious;
	};


};

if (_safeStart) then
{
	_unit setVariable ["unitIsInSafezone", true];
	private _safeStartFunc =
	{
		_unit setVariable ["unitIsInSafezone", false];
	};

	_startChemical = ["startChemical", "Start chemical", "", _safeStartFunc, {true}] call ace_interact_menu_fnc_createAction;

	[["ACE_ZeusActions"], _startChemical] call ace_interact_menu_fnc_addActionToZeus;
};

while {True} do
{
	waitUntil{!(_unit getVariable ["unitIsInSafezone", false])};

	switch (_level) do {
		case 0:
		{
			if (!(goggles _unit in _level_0)) then
			{
				[_unit] call _setDamage;
			} else {
				_unit setVariable ["unitIsDirty", false];
			};
		};
		case 1:
		{
			if (!(goggles _unit in _level_1 and uniform _unit in _level_1)) then
			{
				[_unit] call _setDamage;
			} else {
				_unit setVariable ["unitIsDirty", false];
			};
		};
		case 2:
		{
			if (!(goggles _unit in _level_2 and uniform _unit in _level_2)) then
			{
				[_unit] call _setDamage;
			} else {
				_unit setVariable ["unitIsDirty", false];
			};
		};
		default
		{
			hint format['[_level : Given value not in range (%1) :: "fn_chemical.sqf"]', str(_level)]
		};
	};
	uisleep 5;
};
