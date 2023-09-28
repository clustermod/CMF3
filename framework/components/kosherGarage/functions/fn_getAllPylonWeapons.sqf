#include "script_component.hpp"
/*
 * Author: Eric
 * Gets all available pylons in the game and saves them to a variable (this is a very heavy process and is only run once serversided)
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_kosherGarage_fnc_getAllPylonWeapons
 *
 * Public: No
 */

// @TODO replace spawn
_this spawn {
    if(isNil QGVAR(pylonWeapons)) then {
        GVAR(pylonWeapons) = [];

        private _weapons = [];

        /* Get all the air vehicle configs */
        private _arr = ("(
            (getNumber (_x >> 'scope') >= 2) &&
            {
                getNumber (_x >> 'side') == 1 &&
                { getText (_x >> 'vehicleClass') in ['Air'] }
            }
        )" configClasses (configFile >> "CfgVehicles")) apply { configName _x };

        /* Append all the pylon weapons to the _weapons array */
        {
            _weapons append ((_x getCompatiblePylonMagazines 0));
        } forEach _arr;

        /* Flatten the array */
        _weapons = ARRAY_FLATTEN(_weapons);

        /* Push it back to the global array */
        {
            GVAR(pylonWeapons) pushBackUnique [getText (configFile >> "CfgMagazines" >> _x >> "DisplayName"), _x];
        } forEach _weapons;

        /* Sort the array and broadcast it */
        GVAR(pylonWeapons) sort true;
        publicVariable QGVAR(pylonWeapons);

    };
};
