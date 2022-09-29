/*
 * Author: Eric
 * Allows you tu drink water to speed up stamina recovery
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

private _canteenItems = [
    ["ACE_Canteen", "Land_Canteen_F", [-0.1, 0.08, -0.05]], ["ACE_Canteen_Half", "Land_Canteen_F", [-0.1, 0.08, -0.05]], ["ACE_WaterBottle", "ACE_WaterBottle_Item", [-0.1, -0.3, 0.2]],
    ["ACE_WaterBottle_Half", "ACE_WaterBottle_Item", [-0.1, -0.3, 0.2]], ["ACE_Can_Franta", "Land_Can_V2_F"], ["ACE_Can_RedGull", "Land_Can_V3_F"], ["ACE_Can_Spirit", "Land_Can_V1_F"]
];

_onDrink = {
    /* Hide binocular and spawn in drinking item */
    private _binocular = binocular player;
    player removeWeapon _binocular;
    private _canteen = "ACE_WaterBottle_Item" createVehicle getPos player;
    _canteen attachTo [player, [-0.1, 0.08, -0.05],"righthandmiddle1"];
    _canteen setVectorUp [0, -1, 0.7];

    /* Play animation */
    player setAnimSpeedCoef 1;
    player playMove "amovpercmstpsoptwbindnon";

    /* Slow it down to elongate drinking animation */
    waitUntil {(animationState player) == "amovpercmstpsnonwnondnon_awoppercmstpsoptwbindnon"};
    sleep 0.85;
    onEachFrame {player setAnimSpeedCoef 0.01};
    sleep 4;

    /* Delete canteen object and give back binocular */
    onEachFrame {};
    player setAnimSpeedCoef 1;
    sleep 0.07;
    deleteVehicle _canteen;
    player addWeapon _binocular;
};
