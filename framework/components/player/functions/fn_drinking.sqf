#include "script_component.hpp"
/*
 * Author: Eric
 * Allows players to drink to speed up stamina recovery
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_player_fnc_drinking
 *
 * Public: No
 */
SCRIPT(drinking);

// @TODO Move function declerations outside and pass them as args
[{ alive player && !isNull player }, {
    GVAR(drinking_hydrationItems) = [
        ["ACE_Canteen", ["Land_Canteen_F", 0.2, 15]], ["ACE_Canteen_Half", ["Land_Canteen_F", 0.2, 15]], ["ACE_WaterBottle", ["Land_BottlePlastic_V2_F", 0.2, 15]], ["ACE_WaterBottle_Half", ["Land_BottlePlastic_V2_F", 0.2, 15]],
        ["ACE_Can_Franta", ["Land_Can_V2_F", 0.1, 5]], ["ACE_Can_RedGull", ["Land_Can_V3_F", 0.1, 8]], ["ACE_Can_Spirit", ["Land_Can_V1_F", 0.1, 5]]
    ];

    /* Drink function */
    GVAR(drinking_fnc_consume) = {
        private _item = _this select 2;
        private _stanceIndex = ["STAND", "CROUCH", "PRONE"] find stance player;
        private _itemData = [[GVAR(drinking_hydrationItems)] call CBA_fnc_hashCreate, _item] call CBA_fnc_hashGet;
        private _objClass = _itemData select 0;
        private _replacementItem = getText (configFile >> "CfgWeapons" >> _item >> "acex_field_rations_replacementItem");
        private _animation = (getArray (configFile >> "CfgWeapons" >> _item >> "acex_field_rations_consumeAnims")) select _stanceIndex;
        private _sound = (getArray (configFile >> "CfgWeapons" >> _item >> "acex_field_rations_consumeSounds")) select _stanceIndex;

        /* Play animation */
        [player, _animation, 1] call ace_common_fnc_doAnimation;
        waitUntil {toUpper(animationState player) isEqualTo toUpper _animation};

        /* If unit is prone don't use any physical objects */
        private ["_baseObj", "_drinkObj"];
        if (_stanceIndex isEqualTo 2) then {
            /* Create physical objects */
            _baseObj = objNull;
            _drinkObj = objNull;
        } else {
            /* Create physical objects */
            _baseObj = "Land_Can_V2_F" createVehicle getPos player;
            _baseObj hideObjectGlobal true;
            _drinkObj = _objClass createVehicle getPos player;

            _drinkObj attachTo [_baseObj, [0, 0, 0]];
            _baseObj attachTo [player, [-0.03, 0.0, -0.15], "righthandmiddle1"];
        };

        /* Play the sound and animate the physical object */
        playSound _sound;
        sleep 1;
        for "_i" from 0 to 0.7 step 0.03 do {
            private _rotation = [[-0.003, 0.007, 0.999], [-0.070, -0.997, 0.001], _i, 2.5] call BIS_fnc_interpolateVectorConstant;
            _baseObj setVectorUp _rotation;
            private _position = [[-0.03, 0.0, -0.15], [-0.03, (_itemData select 1), -0.02], _i, 0.4] call BIS_fnc_interpolateVectorConstant;
            _baseObj attachTo [player, _position, "righthandmiddle1"];

            sleep 0.03;
        };
        _baseObj setVectorUp [-0.070, -0.997, 0.001];

        private _oldFactor = ace_advanced_fatigue_recoveryFactor;
        ace_advanced_fatigue_recoveryFactor = (_itemData select 2);

        sleep 5;
        ace_advanced_fatigue_recoveryFactor = _oldFactor;

        for "_i" from 0.7 to 0 step -0.03 do {
            private _rotation = [[-0.003, 0.007, 0.999], [-0.070, -0.997, 0.001], _i, 2] call BIS_fnc_interpolateVectorConstant;
            _baseObj setVectorUp _rotation;
            private _position = [[-0.03, 0.0, -0.15], [-0.03, (_itemData select 1), -0.02], _i, 0.4] call BIS_fnc_interpolateVectorConstant;
            _baseObj attachTo [player, _position, "righthandmiddle1"];
            sleep 0.03;
        };
        _baseObj setVectorUp [-0.003, 0.007, 0.999];

        if (["Can", _animation] call BIS_fnc_inString) then {
            sleep 0.3;
            {
                detach _x;
                _x setVectorUp [-0.003, 0.700, 0.999];
            } forEach attachedObjects _baseObj;
            deleteVehicle _baseObj;
        } else {
            sleep 0.5;
            for "_i" from 0 to 0.3 step 0.03 do {
                private _rotation = [[-0.003, 0.007, 0.999], [-0.003, 0.400, 0.999], _i, 1] call BIS_fnc_interpolateVectorConstant;
                _baseObj setVectorUp _rotation;
                sleep 0.03;
            };
            deleteVehicle _drinkObj;
            deleteVehicle _baseObj;
        };

        /* Remove and replace item with replacementItem */
        player removeItem _item;
        if (_replacementItem != "") then {
            player addItem _replacementItem;
        };
    };

    private _condition = {
        (((items player) findIf {_x in ([[GVAR(drinking_hydrationItems)] call CBA_fnc_hashCreate] call CBA_fnc_hashKeys)}) != -1)
        && vehicle player isEqualTo player
        && !visibleMap
    };

    private _children = {
        params ["_target"];

        private _actions = [];
        private _hydrationItems = [];
        {
            if ((_x in ([[GVAR(drinking_hydrationItems)] call CBA_fnc_hashCreate] call CBA_fnc_hashKeys)) && !(_x in _hydrationItems)) then {
                private _displayName = getText (configFile >> "CfgWeapons" >> _x >> "displayName");
                private _icon = getText (configFile >> "CfgWeapons" >> _x >> "picture");
                private _action = [format [QGVAR(drinking_)+"%1", _x], format[LSTRING(drink_from), _displayName], _icon, { _this spawn GVAR(drinking_fnc_consume) }, { true }, {}, _x] call ace_interact_menu_fnc_createAction;
                _actions pushBack [_action, [], _target];
                _hydrationItems pushBack _x;
            };
        } forEach (items player);

        _actions;
    };

    private _action = [QGVAR(drinking_menu), LSTRING(hydration), "rsc\data\icon_ace_hydration_ca.paa", {}, _condition, _children] call ace_interact_menu_fnc_createAction;
    [typeOf player, 1, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToClass;
}] call CBA_fnc_waitUntilAndExecute;