#include "script_component.hpp"

if (!hasInterface) exitWith {};

LOG_1("Initializing player %1...", (name player));
missionNamespace setVariable [QGVAR(player_initialized), false];

cmf_player = player;

/* Disable removing grass */
tawvd_disablenone = true;

/* Load ace settings */
call compile preprocessFileLineNumbers "components\main\initAceSettings.sqf";

/* Load Shacktack UI changes */
call compile preprocessFileLineNumbers "components\main\initSTUISettings.sqf";

/* Create CMF Info Diary */
[] spawn FUNC(diary);

/* Remove statistics diary */
player removeDiarySubject "Statistics";

/* Remove team diary */
player removeDiarySubject "Units";

/* Remove KP ranks ace interactions */
// @TODO replace spawn
[] spawn {
    while { true } do {
        waitUntil{ !isNil{([(ace_interact_menu_ActSelfNamespace getVariable (typeOf player)), ["ACE_SelfActions","KPR_Admin"]] call ace_interact_menu_fnc_findActionNode)} };
        [(typeOf player), 1, ["ACE_SelfActions", "KPR_Admin"]] call ace_interact_menu_fnc_removeActionFromClass;
        [(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment", "KPR_Check"]] call ace_interact_menu_fnc_removeActionFromClass;
        [(typeOf player), 1, ["ACE_SelfActions", "KPR_Admin", "KPR_UniformManage"]] call ace_interact_menu_fnc_removeActionFromClass;
        [(typeOf player), 1, ["ACE_SelfActions", "KPR_Admin", "KPR_PlayerManage"]] call ace_interact_menu_fnc_removeActionFromClass;
        sleep 10;
    };
};

/* Disable Unsung vietnamese voices */
RUG_DSAI_TerminalDistance = -1;

/* Create ACRE2 Babel handler */
["unit", {
    params ["_player"];

    private _languages = _player getVariable [QGVAR(acre_langs), ["en"]];
    _languages call acre_api_fnc_babelSetSpokenLanguages;
}, true] call CBA_fnc_addPlayerEventHandler;

/* Modify ACEX fortify */
[] call FUNC(fortify);

/* Block looting own corpse */
player addEventHandler ["InventoryOpened", {
    params ["_unit", "_container"];
    _override = false;
    if (name player isEqualTo name _container && !alive _container) then {
        ["<t size='0.5' color='#ff6347'>You can't loot your own corpse<t>", -1, safezoneY + 0.1] spawn bis_fnc_dynamicText;
        _override = true;
    };
    _override
}];

player addEventHandler ["Take", {
	params ["_unit", "_container", "_item"];

    if (name player isEqualTo name _container && !alive _container) then {
        ["<t size='0.5' color='#ff6347'>You can't loot your own corpse<t>", -1, safezoneY + 0.1] spawn bis_fnc_dynamicText;
        player removeMagazine _item;
        player removeItem _item;
    };

    _override;
}];

/* Mute ACRE when player is down */
["ace_unconscious", {
    params ["_unit", "_active"];

    if (_unit != player) exitWith { };

    if (_active) then {
        if (!isNil "acre_api_fnc_setGlobalVolume") then {
            private _acreGlobalVolume = [] call acre_api_fnc_getGlobalVolume;
            if (isNil "_acreGlobalVolume") then { _acreGlobalVolume = 1 };
            private _globalVolume = soundVolume;
            player setVariable [QGVAR(acre_globalVolume), _acreGlobalVolume, true];
            player setVariable [QGVAR(globalVolume), _globalVolume, true];
            [0] call acre_api_fnc_setGlobalVolume;
            0 fadeSound 0.1;
		    0 fadeRadio 0.1;
        };
    } else {
        if (!isNil "acre_api_fnc_setGlobalVolume") then {
            private _acreGlobalVolume = player getVariable [QGVAR(acre_globalVolume), 1];
            private _globalVolume = player getVariable [QGVAR(globalVolume), 1];
            [_acreGlobalVolume] call acre_api_fnc_setGlobalVolume;
            0 fadeSound _globalVolume;
		    0 fadeRadio _globalVolume;
        };
    };
}] call CBA_fnc_addEventHandler;

if (!isNil "acre_api_fnc_setCustomSignalFunc") then {
    [{
        private _coreSignal = _this call acre_sys_signal_fnc_getSignalCore;
        _coreSignal params ["_Px", "_maxSignal"];

        if (player getVariable ["ACE_isUnconscious", false]) then {
            _Px = 0;
        };

        [_Px, _maxSignal]
    }] call acre_api_fnc_setCustomSignalFunc;
};

/* Show changelog */
[] call FUNC(changelog);

/* Player killed event */
player addEventHandler ["Killed", {
    params ["_unit"];
    /* Save loadout */
    player setVariable [QGVAR(player_loadout), getUnitLoadout _unit];

    /* Save group upon player death */
    player setVariable [QGVAR(player_group), (group _unit)];

    /* Save team assigned upon player death */
    player setVariable [QGVAR(player_team), (assignedTeam _unit)];

    /* Set player to fully loaded (first death is automatic so player's can choose their spawn location) */
    player setVariable [QGVAR(player_loaded), true];

    /* Call event script */
    _this execVM "events\onPlayerKilled.sqf"
}];

/* Player respawn event */
player addEventHandler ["Respawn", {
    params ["_unit", "_corpse"];

    /* Make sure player is able to use ACRE */
    player setVariable ["acre_sys_core_isDisabled", false, true];
    player setVariable ["acre_sys_core_isDisabledRadio", false, true];

    /* Load loadout */
    _unit setUnitLoadout (player getVariable [QGVAR(player_loadout),[]]);

    /* Only run if players are not spectating */
    if !((player getVariable[QEGVAR(respawn,respawns), 1]) isEqualTo (player getVariable [QEGVAR(respawn,deaths), 0])) then {
        /* Join previous group */
        [_unit] joinSilent (player getVariable [QGVAR(player_group), (group player)]);

        /* Assign previous team */
        _unit assignTeam (player getVariable [QGVAR(player_team), (assignedTeam player)]);
    };

    /* Restore ACRE radio configurations on respawn */
    [] call cmf_main_fnc_acreRestore;

    /* Call event script */
    _this execVM "events\onPlayerRespawn.sqf"
}];

/* Bring disconnected player back */
// @TODO replace spawn
[] spawn {
    private _disconUnits = missionNameSpace getVariable [QGVAR(disconUnits), createHashMap];
    private _disconUnit = _disconUnits get (getPlayerUID player);
    private _safestartEnabled = ( CONFIG_PARAM_4(SETTINGS,gameplay,safestart,enable) ) isEqualTo 1;
    missionNameSpace setVariable [QGVAR(player_rejip), true, false];

    if (!isNil "_disconUnit") then {
        if ( !_safestartEnabled || missionNamespace getVariable [QEGVAR(gameplay,safestart_disable), false] ) then {
            waitUntil { player getVariable [QGVAR(player_loaded), false] && alive player };
            sleep 0.1;

            /* Set old role (incase they try to rejoin as a different role) */
            [player, (_disconUnit select 0)] call EFUNC(common,setRole);

            /* Set old loadout */
            player setUnitLoadout [(_disconUnit select 3), false];

            /* Join old group */
            [player] joinSilent (_disconUnit select 1);

            /* Attempt to set the same stance as the squad leader */
            switch (unitPos leader (_disconUnit select 1)) do {
                case ("UP"): { player playAction "PlayerStand" };
                case ("MIDDLE"): { player playAction "PlayerCrouch" };
                case ("DOWN"): { player playAction "PlayerProne" };
            };

            /* Set respawns */
            player setVariable [QEGVAR(respawn,respawns), ((_disconUnit select 4) select 0), true];
            player setVariable [QEGVAR(respawn,deaths), ((_disconUnit select 4) select 1), true];

            /* set player position and if leader is in vehicle attempt to move into vehicle cargo */
            if (!isNull leader (_disconUnit select 1)) then {
                player setPosASL getPosASL leader (_disconUnit select 1);
                if (vehicle leader (_disconUnit select 1) != leader (_disconUnit select 1)) then {
                    player moveInCargo vehicle leader (_disconUnit select 1);

                    if (vehicle player == player && (vehicle player) isKindOf "Helicopter") then {
                        private _groundPos = getposATL player;
                        _groundPos set [2, 0];
                        player setPosATL _groundPos;
                    };
                };
            };

            ["<t size='0.5' color='#32cd32'>Loaded pre-disconnect state<t>"] spawn bis_fnc_dynamicText;
        };
    };
};

/* Raise event */
[QGVAR(player_initialized), []] call CBA_fnc_localEvent;

INFO_1("Player %1 Initialized!", (name player));
missionNamespace setVariable [QGVAR(player_initialized), true];