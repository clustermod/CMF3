/*
 * Author: Eric
 * initializes an object as a ammobox
 *
 * Arguments:
 * 0: object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [this] call emf_kosherArsenal_fnc_ammobox
 *
 * Public: Yes
 */
params["_object"];

if (_object getVariable ["emf_kosherArsenal_ammoBoxInit", false]) exitWith {false};

  private _onOpen = {
    // Create arsenal object
    private _arsenal = "HeliHEmpty" createVehicleLocal [0,0,0];
    [_arsenal, []] call ace_arsenal_fnc_initBox;

    // Get role and loadout
    private _role = player getVariable ["emf_utilities_setRole_role", "RFL"];
    private _loadout = player getVariable "emf_kosherArsenal_loadout";

    // Load arsenal whitelist
    private _whitelist = [_role, player, true] call compile(preprocessFileLineNumbers _loadout);

    // Get gear from whitelist and check loadout file version (to add backwards compatability)
    private["_permittedGear"];
    _permittedGear = [];
    if (isNil "_whitelist") then {
      _permittedGear 	= player getVariable ["EMF_KA_permittedGear", 0];
    } else {
      _permittedGear 	= (_whitelist select 1);
    };

    // Add items to arsenal
    {
      [_arsenal, _x] call ace_arsenal_fnc_addVirtualItems;
    } forEach _permittedGear;

    // Open arsenal
    [_arsenal, player, false] call ace_arsenal_fnc_openBox;

    waitUntil{!isNull findDisplay 1127001};
    ctrlActivate ((findDisplay 1127001) displayCtrl 2010);

    // Create handler to hide certain ui elements
    private _hideUI = [] spawn {
      while {true} do {
        {
          ((findDisplay 1127001) displayCtrl _x) ctrlShow false;
        } forEach [3, 4, 13, 16, 18, 41, 51, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025, 2026, 2027, 2028, 2029, 2030, 2031, 2032, 2033, 2034, 2035, 2036, 2037, 1003, 1004, 1005];
        sleep 0.1;
      }
    };

    // Kill the hide handler
    ["ace_arsenal_displayClosed", {terminate _thisArgs}, _hideUI] call CBA_fnc_addEventHandlerArgs;
  };

  [_object, ["Rearm at arsenal", _onOpen, [], 6, true, false,"", "_this getVariable ['emf_kosherArsenal_loadout', ''] != ''"]] remoteExec ["addAction", 0, true];
  _object setVariable ["emf_kosherArsenal_ammoBoxInit", true, true];

true;
