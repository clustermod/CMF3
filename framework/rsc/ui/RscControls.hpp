/*
 * kosherArsenal controls
 */
class cmf_kosherArsenal_forceClose: cmf_RscButton {
    idc = 2055;
    style = "0x02 + 0x40 + 0x80";
    text = "FORCE CLOSE";
    tooltip = "Force closes kosher arsenal (This will strip you naked)";
    w = "(((safezoneW - 2 * (93 * (pixelW * pixelGridNoUIScale * 0.25))) - 7 * ((safezoneW - 2 * (93 * (pixelW * pixelGridNoUIScale * 0.25))) / 100)) / 6)";
    h = "7 * (pixelH * pixelGridNoUIScale * 0.25)";
    x = "4 * ((safezoneW - 2 * (93 * (pixelW * pixelGridNoUIScale * 0.25))) / 100) + 3 * (((safezoneW - 2 * (93 * (pixelW * pixelGridNoUIScale * 0.25))) - 7 * ((safezoneW - 2 * (93 * (pixelW * pixelGridNoUIScale * 0.25))) / 100)) / 6)";
    y = "0";
    colorBackground[] = {0.85,0,0,0.8};
    colorBackgroundActive[] = {0.95,0,0,1};
    colorBackgroundDisabled[] = {0,0,0,0.5};
    colorBorder[] = {0,0,0,0};
    colorDisabled[] = {1,1,1,0.25};
    colorShadow[] = {0,0,0,0};
    colorText[] = {1,1,1,1};
    font = "PuristaLight";
    onButtonClick = "_this spawn{ private _result = ['Are you sure? This will delete your current loadout.', 'Confirm', true, true, (findDisplay 1127001)] call BIS_fnc_guiMessage; if (_result) then { [player] call cmf_kosherArsenal_fnc_forceClose } };";
    sizeEx = "5 * (pixelH * pixelGridNoUIScale * 0.25)";
};

/*
 * Spectator controls
 */
class CMF_reportsGroup: RscControlsGroupNoScrollbars {
    style = 16;
    x = "((15.5 * (((safezoneW / safezoneH) min 1.2) / 40)) + (safezoneX + (safezoneW - ((safezoneW / safezoneH) min 1.2))/2))";
    y = "safezoneY + safezoneH - (4.38 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
    w = "(8.6 * (((safezoneW / safezoneH) min 1.2) / 40))";
    h = 2.6;

    class controls {
        class reportsGroupBackground: ctrlStaticBackground {
            x = "(0.6 * (((safezoneW / safezoneH) min 1.2) / 40))";
            y = "(0.4 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
            w = "(7.5 * (((safezoneW / safezoneH) min 1.2) / 40))";
            h = "(2 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
            colorBackground[] = {0.0, 0, 0, 0.0};
        };

        class submitReport: RscButton {
            style = 48;
            text = "a3\ui_f\data\igui\cfg\simpletasks\types\interact_ca.paa";
            tooltip = "Submit Report";
            x = "(2.2 * (((safezoneW / safezoneH) min 1.2) / 40))";
            y = "(0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
            w = "(1.63 * (((safezoneW / safezoneH) min 1.2) / 40))";
            h = "(1.37 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
            colorBackground[] = {0, 0, 0, 0};
            colorBackgroundActive[] = {0, 0, 0, 0};
            colorBackgroundDisabled[] = {0, 0, 0, 0};
            colorBorder[] = {0, 0, 0, 1};
            colorDisabled[] = {1, 1, 1, 0.25};
            colorFocused[] = {0, 0, 0, 0};
            colorShadow[] = {0, 0, 0, 0};
            colorText[] = {1, 1, 1, 1};
            offsetPressedX = 0;
            offsetPressedY = 0;
            offsetX = 0;
            offsetY = 0;
            onButtonClick = "_this call cmf_aar_fnc_submitAAR";
        };

        class readReports: submitReport {
            text = "a3\ui_f\data\igui\cfg\simpletasks\types\documents_ca.paa";
            tooltip = "Read Reports";
            x = "(4.5 * (((safezoneW / safezoneH) min 1.2) / 40))";
            y = "(0.8 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
            w = "(1.63 * (((safezoneW / safezoneH) min 1.2) / 40))";
            h = "(1.37 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25))";
            onButtonClick = "findDisplay 60000 createDisplay ""CMF_RscAfterActionReader""";
        };
    };
};