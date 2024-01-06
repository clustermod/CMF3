#include "script_component.hpp"
/*
 * Author: Eric
 * Get surface paramaters for cmf_vehicles_fnc_offroadPFH
 *
 * Arguments:
 * 0: Surface <STRING>
 *
 * Return Value:
 * Parameters <ARRAY>
 *  - 0: bumpModifier <NUMBER>
 *  - 1: damageModifier <NUMBER>
 *
 * Example:
 * ["GdtRock"] call cmf_vehicles_fnc_getSurfaceParams
 *
 * Public: No
 */
SCRIPT(getSurfaceParams);

params["_surface"];

private _surfaceClass = -1;
private _return = [-1, -1];
switch (_surface) do {
    case ("VRsurface"): { _surfaceClass = "VRsurface" };
    case ("DryGrass"): { _surfaceClass = "grass" };
    case ("WetGrass"): { _surfaceClass = "grass" };
    case ("softsand"): { _surfaceClass = "softsand" };
    case ("desert"): { _surfaceClass = "hardsand" };
    case ("harddirt"): { _surfaceClass = "harddirt" };
    case ("softmud"): { _surfaceClass = "softmud" };
    case ("forest"): { _surfaceClass = "forest" };
    case ("marsh"): { _surfaceClass = "marsh" };
    case ("Gravel"): { _surfaceClass = "gravel" };
    case ("Stony"): { _surfaceClass = "stony" };
    case ("LowQualityRoad"): { _surfaceClass = -1 };
    case ("HighQualityRoad"): { _surfaceClass = -1 };
    case ("Icy"): { _surfaceClass = "icy" };
    case ("SlipperySnow"): { _surfaceClass = "slipperySnow" };
    case ("ThickSoftSnow"): { _surfaceClass = "thickSoftSnow" };
};

if (_surfaceClass isEqualTo -1) then {
    if ((_surface find "rass")    != -1) exitWith { _surfaceClass = "drygrass" };
    if ((_surface find "ield")    != -1) exitWith { _surfaceClass = "drygrass" };
    if ((_surface find "tubble")  != -1) exitWith { _surfaceClass = "drygrass" };
    if ((_surface find "eed")     != -1) exitWith { _surfaceClass = "drygrass" };
    if ((_surface find "level")   != -1) exitWith { _surfaceClass = "drygrass" };
    if ((_surface find "ole")     != -1) exitWith { _surfaceClass = "drygrass" };
    if ((_surface find "rava")    != -1) exitWith { _surfaceClass = "drygrass" };
    if ((_surface find "heat")    != -1) exitWith { _surfaceClass = "drygrass" };

    if ((_surface find "irt")     != -1) exitWith { _surfaceClass = "harddirt" };
    if ((_surface find "terk")    != -1) exitWith { _surfaceClass = "harddirt" };
    if ((_surface find "hiekka")  != -1) exitWith { _surfaceClass = "harddirt" };

    if ((_surface find "orest")   != -1) exitWith { _surfaceClass = "forest"  };
    if ((_surface find "horn")    != -1) exitWith { _surfaceClass = "forest" };
    if ((_surface find "histles") != -1) exitWith { _surfaceClass = "forest" };
    if ((_surface find "eather")  != -1) exitWith { _surfaceClass = "forest" };
    if ((_surface find "ood")     != -1) exitWith { _surfaceClass = "forest" };

    if ((_surface find "each")    != -1) exitWith { _surfaceClass = "softsand" };
    if ((_surface find "olopoust")!= -1) exitWith { _surfaceClass = "softsand" };
    if ((_surface find "and")     != -1) exitWith { _surfaceClass = "softsand" };

    if ((_surface find "Dead")    != -1) exitWith { _surfaceClass = "hardsand" };
    if ((_surface find "esert")   != -1) exitWith { _surfaceClass = "hardsand" };
    if ((_surface find "terk")    != -1) exitWith { _surfaceClass = "hardsand" };

    if ((_surface find "mud")     != -1) exitWith { _surfaceClass = "softmud" };
    if ((_surface find "olcano")  != -1) exitWith { _surfaceClass = "softmud" };
    if ((_surface find "lina")    != -1) exitWith { _surfaceClass = "softmud" };

    if ((_surface find "ock")     != -1) exitWith { _surfaceClass = "stony" };
    if ((_surface find "tony")    != -1) exitWith { _surfaceClass = "stony" };
    if ((_surface find "tone")    != -1) exitWith { _surfaceClass = "stony" };
    if ((_surface find "liff")    != -1) exitWith { _surfaceClass = "stony" };
    if ((_surface find "efault")  != -1) exitWith { _surfaceClass = "stony" };
};

if (_surfaceClass isEqualType "") then {
    private _bump = getNumber (missionConfigFile >> "CfgEnhancedVehicles" >> "surfaceParams" >> _surfaceClass >> "bump");
    private _damage = getNumber (missionConfigFile >> "CfgEnhancedVehicles" >> "surfaceParams" >> _surfaceClass >> "damage");
    _return = [_bump, _damage];
} else {
    _return = [-1, -1];
};

_return;
