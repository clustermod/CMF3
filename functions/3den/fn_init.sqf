#include "script_component.hpp"
/*
 * Author: Eric
 * 3DEN function init
 *
 * Arguments:
 * 0: Argument Name <TYPE>
 *
 * Return Value:
 * Return Name <TYPE>
 *
 * Example:
 * [] execVM "functions\3den\fn_init.sqf"
 *
 * Public: No
 */

// https://community.bistudio.com/wiki/Category:Command_Group:_GUI_Control_-_Menu

/* Include custom functions */
#include "fn_unitConstructor.sqf"
#include "fn_unitSpawner.sqf"

/* Creates menu in top bar */
disableSerialization;

/* Check if menu already exists and if it does delete it */
private _ctrlMenuStrip = findDisplay 313 displayCtrl 120;
for "_i" from 0 to (_ctrlMenuStrip menuSize []) -1 step 1 do {
    if (_ctrlMenuStrip menuText [_i] isEqualTo "EMF") then {
        _ctrlMenuStrip menuDelete [_i];
    };
};

/* Create EMF menu */
private _indexMain = _ctrlMenuStrip menuAdd [[], "EMF"];

/* Create ORBAT viewer */ // Will need to start scenario to open this
//private _viewORBAT = _ctrlMenuStrip menuAdd [[_indexMain],"View Cluster Community ORBAT"];
//_ctrlMenuStrip menuSetAction [[_indexMain, _viewORBAT], "[((loadConfig (""configs\CfgORBAT.hpp"")) >> ""CfgORBAT"" >> ""cluster"")] call BIS_fnc_ORBATOpen;"];

/* Create unit spawner menu */
private _unitSpawner = _ctrlMenuStrip menuAdd [[_indexMain],"Cluster ORBAT spawner"];

/* Unit sizes (fireteam, squad, platoon, Company) */
private _unitSizes = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner],"Infantry Elements"];
private _fireteamSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _unitSizes],"Fireteam"];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _unitSizes, _fireteamSpawner], "[""FIRETEAM""] spawn emf_3den_fnc_unitSpawner"];
private _squadSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _unitSizes],"Squad"];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _unitSizes, _squadSpawner], "[""SQUAD""] spawn emf_3den_fnc_unitSpawner"];
private _platoonSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _unitSizes],"Platoon"];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _unitSizes, _platoonSpawner], "[""PLATOON""] spawn emf_3den_fnc_unitSpawner"];
private _CompanySpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _unitSizes],"Company"];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _unitSizes, _CompanySpawner], "[""COMPANY""] spawn emf_3den_fnc_unitSpawner"];

/* Air Elements */
private _airUnits = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner],"Air Elements"];
private _phantomSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _airUnits],"Phantom (Light Rotary CAS/Trans)"];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _airUnits, _phantomSpawner], "[""PHANTOM""] spawn emf_3den_fnc_unitSpawner"];
private _reaperSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _airUnits],"Reaper (Rotary CAS)"];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _airUnits, _reaperSpawner], "[""REAPER""] spawn emf_3den_fnc_unitSpawner"];
private _uglySpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _airUnits],"Ugly (Heavy Rotary CAS)"];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _airUnits, _uglySpawner], "[""UGLY""] spawn emf_3den_fnc_unitSpawner"];
private _hawgSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _airUnits],"Hawg (Ground-Attack Jet)"];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _airUnits, _hawgSpawner], "[""HAWG""] spawn emf_3den_fnc_unitSpawner"];
private _pavementSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _airUnits],"Pavement (Fighter / Bomber Jet)"];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _airUnits, _pavementSpawner], "[""PAVEMENT""] spawn emf_3den_fnc_unitSpawner"];

/* Armor Elements */
private _armorUnits = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner],"Armor Elements"];
private _sierraSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _armorUnits],"Sierra (APC)"];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _armorUnits, _sierraSpawner], "[""SIERRA""] spawn emf_3den_fnc_unitSpawner"];
private _mikeSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _armorUnits],"Mike (IFV)"];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _armorUnits, _mikeSpawner], "[""MIKE""] spawn emf_3den_fnc_unitSpawner"];
private _tangoSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _armorUnits],"Tango (MBT)"];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _armorUnits, _tangoSpawner], "[""TANGO""] spawn emf_3den_fnc_unitSpawner"];

/* Support Elements */
private _supportUnits = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner],"Support Elements"];
private _mortarsSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _supportUnits],"Mortars (Mortar Team)"];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _supportUnits, _mortarsSpawner], "[""MORTARS""] spawn emf_3den_fnc_unitSpawner"];
private _romeoSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _supportUnits],"Romeo (Recon / Sniper Team)"];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _supportUnits, _romeoSpawner], "[""ROMEO""] spawn emf_3den_fnc_unitSpawner"];
private _logiSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _supportUnits],"Logi (Logistics Team)"];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _supportUnits, _logiSpawner], "[""LOGI""] spawn emf_3den_fnc_unitSpawner"];
private _engiSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _supportUnits],"Engi (Engineers Team)"];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _supportUnits, _engiSpawner], "[""ENGI""] spawn emf_3den_fnc_unitSpawner"];

/* Weapons Elements */
private _weaponUnits = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner],"Weapons Elements"];
private _mmgSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _weaponUnits],"MMG (Medium Machinegunner Team)"];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _weaponUnits, _mmgSpawner], "[""MMG""] spawn emf_3den_fnc_unitSpawner"];
private _hmgSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _weaponUnits],"HMG (Heavy Machinegunner Team)"];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _weaponUnits, _hmgSpawner], "[""HMG""] spawn emf_3den_fnc_unitSpawner"];
private _matSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _weaponUnits],"MAT (Medium Anti-Tank Team)"];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _weaponUnits, _matSpawner], "[""MAT""] spawn emf_3den_fnc_unitSpawner"];
private _hatSpawner = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner, _weaponUnits],"HAT (Heavy Anti-Tank Team)"];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _weaponUnits, _hatSpawner], "[""HAT""] spawn emf_3den_fnc_unitSpawner"];

/* Custom unit */
private _singleUnit = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner],"Custom Unit"];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _singleUnit], "[""UNIT""] spawn emf_3den_fnc_unitSpawner"];

/* Zeus unit */
private _zeusUnit = _ctrlMenuStrip menuAdd [[_indexMain, _unitSpawner],"Zeus Unit"];
_ctrlMenuStrip menuSetAction [[_indexMain, _unitSpawner, _zeusUnit], "[""ZEUS""] spawn emf_3den_fnc_unitSpawner"];

/* Shortcut to lobby manager */
private _lobbyManager = _ctrlMenuStrip menuAdd [[_indexMain],"Lobby manager"];
_ctrlMenuStrip menuSetAction [[_indexMain, _lobbyManager], "call (uiNamespace getVariable 'CBA_fnc_openLobbyManager')"];
