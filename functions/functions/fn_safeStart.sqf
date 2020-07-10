if (isNil EMF_fnc_safeStartDisable) then
{
	EMF_fnc_safeStartDisable = false;
	publicVariable "EMF_fnc_safeStartDisable";
};

if (!isNull (getAssignedCuratorLogic player)) then
{
_safestart = ["_safestart", "Start Game", "", {EMF_fnc_safeStartDisable = false}, {true}] call ace_interact_menu_fnc_createAction;

[["ACE_ZeusActions"], _safestart] call ace_interact_menu_fnc_addActionToZeus;
};

player allowDamage false;
_EHID = player addEventHandler ["FiredMan", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];
	deleteVehicle _projectile;
}];

waitUntil{EMF_fnc_safeStartDisable};

player removeEventHandler ["firedman", _EHID];
player allowDamage true;
hintSilent "Game started, Weapons hot!";
