#include "script_component.hpp"

GVAR(rallypoints) = [];

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
GVAR(respawnTimer) = SETTING(unconciousTimer);

[FUNC(respawnButtonPFH)] call CBA_fnc_addPerFrameHandler;
["ace_unconscious", FUNC(unconciousEH)] call CBA_fnc_addEventHandler;
cmf_player addEventHandler ["Respawn", FUNC(respawnEH)];

/* Block looting own corpse */
cmf_player addEventHandler ["InventoryOpened", {
    params ["_unit", "_container"];
    _override = false;
    if (name cmf_player isEqualTo name _container && { !alive _container }) then {
        ["<t size='0.5' color='#ff6347'>You can't loot your own corpse<t>", -1, safezoneY + 0.1] spawn bis_fnc_dynamicText;
        _override = true;
    };
    _override
}];

cmf_player addEventHandler ["Take", {
    params ["_unit", "_container", "_item"];

    if (name cmf_player isEqualTo name _container && { !alive _container }) then {
        ["<t size='0.5' color='#ff6347'>You can't loot your own corpse<t>", -1, safezoneY + 0.1] spawn bis_fnc_dynamicText;
        cmf_player removeMagazine _item;
        cmf_player removeItem _item;
    };
}];

/* Bring disconnected player back */
private _disconUnits = missionNameSpace getVariable [QGVAR(disconUnits), createHashMap];
private _disconUnit = _disconUnits get (getPlayerUID cmf_player);

if (!isNil "_disconUnit" && { !ESETTING(gameplay,safestart) || missionNamespace getVariable [QEGVAR(gameplay,safestart_disable), false] }) then {
    GVAR(player_rejip) = true;

    [{ cmf_player getVariable [QGVAR(player_loaded), false] && { alive cmf_player } }, {
        [{
            /* Set old role (incase they try to rejoin as a different role) */
            [cmf_player, (_this select 0)] call EFUNC(common,setRole);

            /* Set old loadout */
            cmf_player setUnitLoadout [(_this select 3), false];

            /* Join old group */
            [cmf_player] joinSilent (_this select 1);

            /* Attempt to set the same stance as the squad leader */
            switch (unitPos leader (_this select 1)) do {
                case ("UP"): { cmf_player playAction "PlayerStand" };
                case ("MIDDLE"): { cmf_player playAction "PlayerCrouch" };
                case ("DOWN"): { cmf_player playAction "PlayerProne" };
            };

            /* Set respawns */
            player setVariable [QEGVAR(respawn,respawns), ((_disconUnit select 4) select 0), true];
            player setVariable [QEGVAR(respawn,deaths), ((_disconUnit select 4) select 1), true];

            /* set player position and if leader is in vehicle attempt to move into vehicle cargo */
            if (!isNull leader (_this select 1)) then {
                cmf_player setPosASL getPosASL leader (_this select 1);
                if (vehicle leader (_this select 1) != leader (_this select 1)) then {
                    cmf_player moveInCargo vehicle leader (_this select 1);

                    if (!isNull objectParent cmf_player && { (objectParent cmf_player) isKindOf "Helicopter" }) then {
                        private _groundPos = getposATL cmf_player;
                        _groundPos set [2, 0];
                        cmf_player setPosATL _groundPos;
                    };
                };
            };

            ["<t size='0.5' color='#32cd32'>Loaded pre-disconnect state<t>"] spawn bis_fnc_dynamicText;
        }, [], 0.1] call CBA_fnc_waitAndExecute;
    }, _disconUnit] call CBA_fnc_waitUntilAndExecute;
};