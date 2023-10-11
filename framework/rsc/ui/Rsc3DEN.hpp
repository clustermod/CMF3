/* 3DEN Custom Unit Menu */
class cmf_3den_customUnitMenu {
    idd = -1;
    enableDisplay = 1;
    movingEnable = 1;

    class controlsBackground {
        class Disable: cmf_ctrlStaticBackgroundDisable {};
        class DisableTiles: cmf_ctrlStaticBackgroundDisableTiles {};
    };

    class controls {
        class Background: cmf_ctrlStaticBackground {
            x = (getResolution select 2) * 0.5 * pixelW - (90/2) * GRID_3DEN_W;
            y = 0.5 - (80/2 - 5) * GRID_3DEN_H;
            w = 90 * GRID_3DEN_W;
            h = (80 - 10) * GRID_3DEN_H;
        };

        class BackgroundButtons: cmf_ctrlStaticFooter {
            x = (getResolution select 2) * 0.5 * pixelW - (90/2) * GRID_3DEN_W;
            y = 0.5 + (80/2 - 10 - 2) * GRID_3DEN_H;
            w = 90 * GRID_3DEN_W;
            h = 7 * GRID_3DEN_H;
        };

        class Title: cmf_ctrlStaticTitle {
            text = "Edit: Custom Unit";
            x = (getResolution select 2) * 0.5 * pixelW - (90/2) * GRID_3DEN_W;
            y = 0.5 - (80/2 - 5) * GRID_3DEN_H;
            w = 90 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };

        class roleLabel: cmf_ctrlStatic {
            text = "Role";
            tooltip = "The unit's assigned kosherArsenal role, e.g. RFL";
            x = (getResolution select 2) * 0.5 * pixelW - (90/2 - 1) * GRID_3DEN_W;
            y = 0.5 - (80/2 - 10 - 5) * GRID_3DEN_H;
            w = 49 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };

        class role: cmf_ctrlEdit {
            idc = 100;
            text = "RFL";
            x = (getResolution select 2) * 0.5 * pixelW - (90/2 - 1 - 20) * GRID_3DEN_W;
            y = 0.5 - (80/2 - 10 - 5) * GRID_3DEN_H;
            w = 65 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
            colorDisabled[] = {1, 1, 1, 1};
            colorBackground[] = {0, 0, 0, 0.25};
        };

        class lobbyRoleLabel: cmf_ctrlStatic {
            text = "Lobby Role";
            tooltip = "The unit's role name in the multiplayer lobby, e.g. Rifleman";
            x = (getResolution select 2) * 0.5 * pixelW - (90/2 - 1) * GRID_3DEN_W;
            y = 0.5 - (80/2 - 10 - 5 - 10) * GRID_3DEN_H;
            w = 49 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };

        class lobbyRole: cmf_ctrlEdit {
            idc = 101;
            text = "Rifleman";
            x = (getResolution select 2) * 0.5 * pixelW - (90/2 - 1 - 20) * GRID_3DEN_W;
            y = 0.5 - (80/2 - 10 - 5 - 10) * GRID_3DEN_H;
            w = 65 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
            colorDisabled[] = {1, 1, 1, 1};
            colorBackground[] = {0, 0, 0, 0.25};
        };

        class groupNameLabel: cmf_ctrlStatic {
            text = "Group Name";
            tooltip = "The group name for the unit's group, e.g. ASL";
            x = (getResolution select 2) * 0.5 * pixelW - (90/2 - 1) * GRID_3DEN_W;
            y = 0.5 - (80/2 - 10 - 5 - 10 - 10) * GRID_3DEN_H;
            w = 49 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };

        class groupName: cmf_ctrlEdit {
            idc = 102;
            text = "A1";
            x = (getResolution select 2) * 0.5 * pixelW - (90/2 - 1 - 20) * GRID_3DEN_W;
            y = 0.5 - (80/2 - 10 - 5 - 10 - 10) * GRID_3DEN_H;
            w = 65 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
            colorDisabled[] = {1, 1, 1, 1};
            colorBackground[] = {0, 0, 0, 0.25};
        };

        class groupTypeLabel: cmf_ctrlStatic {
            text = "Group Type";
            tooltip = "The group type for the unit's group, e.g. INF";
            x = (getResolution select 2) * 0.5 * pixelW - (90/2 - 1) * GRID_3DEN_W;
            y = 0.5 - (80/2 - 10 - 5 - 10 - 10 - 10) * GRID_3DEN_H;
            w = 49 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };

        class groupType: cmf_ctrlCombo {
            idc = 103;
            x = (getResolution select 2) * 0.5 * pixelW - (90/2 - 1 - 20) * GRID_3DEN_W;
            y = 0.5 - (80/2 - 10 - 5 - 10 - 10 - 10) * GRID_3DEN_H;
            w = 65 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
            colorDisabled[] = {1, 1, 1, 1};
            colorBackground[] = {0, 0, 0, 1};
        };

        class groupSizeLabel: cmf_ctrlStatic {
            text = "Group Size";
            tooltip = "The group size for the unit's group, e.g. SQD";
            x = (getResolution select 2) * 0.5 * pixelW - (90/2 - 1) * GRID_3DEN_W;
            y = 0.5 - (80/2 - 10 - 5 - 10 - 10 - 10 - 10) * GRID_3DEN_H;
            w = 49 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };

        class groupSize: cmf_ctrlCombo {
            idc = 104;
            x = (getResolution select 2) * 0.5 * pixelW - (90/2 - 1 - 20) * GRID_3DEN_W;
            y = 0.5 - (80/2 - 10 - 5 - 10 - 10 - 10 - 10) * GRID_3DEN_H;
            w = 65 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
            colorDisabled[] = {1, 1, 1, 1};
            colorBackground[] = {0, 0, 0, 1};
        };

        class ButtonOK: cmf_ctrlButtonOK {
            text = "Spawn";
            x = (getResolution select 2) * 0.5 * pixelW + (90/2 - 50 - 2) * GRID_3DEN_W;
            y = 0.5 + (80/2 - 10 - 1) * GRID_3DEN_H;
            w = 25 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };

        class ButtonCancel: cmf_ctrlButtonCancel {
            x = (getResolution select 2) * 0.5 * pixelW + (90/2 - 25 - 1) * GRID_3DEN_W;
            y = 0.5 + (80/2 - 10 - 1) * GRID_3DEN_H;
            w = 25 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };
    };
};

/* 3DEN Add ACRE Rack Menu */
class cmf_3den_addRack {
    idd = -1;
    enableDisplay = 1;
    movingEnable = 1;

    class controlsBackground {
        class Disable: cmf_ctrlStaticBackgroundDisable {};
        class DisableTiles: cmf_ctrlStaticBackgroundDisableTiles {};
    };

    class controls {
        class Background: cmf_ctrlStaticBackground {
            x = (getResolution select 2) * 0.5 * pixelW - (90/2) * GRID_3DEN_W;
            y = 0.5 - (40/2 - 5) * GRID_3DEN_H;
            w = 90 * GRID_3DEN_W;
            h = (40 - 10) * GRID_3DEN_H;
        };

        class BackgroundButtons: cmf_ctrlStaticFooter {
            x = (getResolution select 2) * 0.5 * pixelW - (90/2) * GRID_3DEN_W;
            y = 0.5 + (40/2 - 10 - 2) * GRID_3DEN_H;
            w = 90 * GRID_3DEN_W;
            h = 7 * GRID_3DEN_H;
        };

        class Title: cmf_ctrlStaticTitle {
            text = "Edit: Add ACRE Radio";
            x = (getResolution select 2) * 0.5 * pixelW - (90/2) * GRID_3DEN_W;
            y = 0.5 - (40/2 - 5) * GRID_3DEN_H;
            w = 90 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };

        class radioLabel: cmf_ctrlStatic {
            text = "Radio";
            tooltip = "Radio to add to vehicle";
            x = (getResolution select 2) * 0.5 * pixelW - (90/2 - 1) * GRID_3DEN_W;
            y = 0.5 - (40/2 - 10 - 5) * GRID_3DEN_H;
            w = 49 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };

        class radio: cmf_ctrlCombo {
            idc = 100;
            x = (getResolution select 2) * 0.5 * pixelW - (90/2 - 1 - 20) * GRID_3DEN_W;
            y = 0.5 - (40/2 - 10 - 5) * GRID_3DEN_H;
            w = 65 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
            colorDisabled[] = {1, 1, 1, 1};
            colorBackground[] = {0, 0, 0, 0.25};
        };

        class ButtonOK: cmf_ctrlButtonOK {
            text = "Add";
            x = (getResolution select 2) * 0.5 * pixelW + (90/2 - 50 - 2) * GRID_3DEN_W;
            y = 0.5 + (40/2 - 10 - 2) * GRID_3DEN_H;
            w = 25 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };

        class ButtonCancel: cmf_ctrlButtonCancel {
            x = (getResolution select 2) * 0.5 * pixelW + (90/2 - 25 - 1) * GRID_3DEN_W;
            y = 0.5 + (40/2 - 10 - 2) * GRID_3DEN_H;
            w = 25 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };
    };
};

/* 3DEN Menu */
class cmf_3den_missionMenu {
    idd = -1;
    enableDisplay = 1;
    movingEnable = 1;

    class controlsBackground {
        class Disable: cmf_ctrlStaticBackgroundDisable {};
        class DisableTiles: cmf_ctrlStaticBackgroundDisableTiles {};
    };

    class controls {
        class Background: cmf_ctrlStaticBackground {
            x = (getResolution select 2) * 0.5 * pixelW - (120/2) * GRID_3DEN_W;
            y = 0.5 - (200/2 - 5) * GRID_3DEN_H;
            w = 120 * GRID_3DEN_W;
            h = (200 - 10) * GRID_3DEN_H;
        };

        class BackgroundButtons: cmf_ctrlStaticFooter {
            x = (getResolution select 2) * 0.5 * pixelW - (120/2) * GRID_3DEN_W;
            y = 0.5 + (200/2 - 10 - 2) * GRID_3DEN_H;
            w = 120 * GRID_3DEN_W;
            h = 7 * GRID_3DEN_H;
        };

        class Title: cmf_ctrlStaticTitle {
            text = "Edit: Mission Data";
            x = (getResolution select 2) * 0.5 * pixelW - (120/2) * GRID_3DEN_W;
            y = 0.5 - (200/2 - 5) * GRID_3DEN_H;
            w = 120 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };

        class settingsGroup: cmf_RscControlsGroup {
            x = (getResolution select 2) * 0.5 * pixelW - (120/2) * GRID_3DEN_W;
            y = 0.5 - (200/2 - 10 - 5) * GRID_3DEN_H;
            w = 120 * GRID_3DEN_W;
            h = 173 * GRID_3DEN_H;

            class controls {
                class generalLabel: cmf_ctrlStatic {
                    text = "General";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (179/2 - 10 - 5) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class generalSeperator: cmf_ctrlStatic {
                    text = "";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (179/2 - 10 - 5 - 5) * GRID_3DEN_H;
                    w = 87 * GRID_3DEN_W;
                    h = 0.2 * GRID_3DEN_H;
                    colorBackground[] = {1, 1, 1, 0.25};
                };

                class titleLabel: cmf_ctrlStatic {
                    text = "Operation";
                    tooltip = "Operation name";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (179/2 - 10 - 5 - 10) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class title: cmf_ctrlEdit {
                    idc = 100;
                    text = "";
                    onSetFocus = "(_this # 0) ctrlSetTextSelection [0, 999]";
                    onKillFocus = "(_this # 0) ctrlSetTextSelection [0, 0]";
                    onMouseButtonClick = "(_this # 0) ctrlSetTextSelection [0, 999]";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1 - 20) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10) * GRID_3DEN_H;
                    w = 65 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                    colorDisabled[] = {1, 1, 1, 1};
                    colorBackground[] = {0, 0, 0, 0.25};
                };

                class gameTypeLabel: cmf_ctrlStatic {
                    text = "Game Type";
                    tooltip = "Game Type";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class gameType: cmf_ctrlCombo {
                    idc = 101;
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1 - 20) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10) * GRID_3DEN_H;
                    w = 65 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                    colorDisabled[] = {1, 1, 1, 1};
                    colorBackground[] = {0, 0, 0, 1};
                    onLBSelChanged = "(ctrlParent (_this # 0) displayCtrl 102) ctrlEnable (((_this # 0) lbData (_this # 1)) isEqualTo ""custom"");";
                    onLoad = "for '_i' from 0 to lbSize (_this # 0) - 1 do { (_this # 0) lbSetPictureRight [_i, format ['rsc\data\icon_gametype_%1_ca.paa', (_this # 0) lbData _i]] }";
                    class Items {
                        class Scenario {
                            text = "Scenario";
                            data = "scenario";
                            colorPicture[] = {1,1,1,1};
                            default = 1;
                        };
                        class Custom {
                            text = "Custom";
                            data = "custom";
                            colorPicture[] = {1,1,1,1};
                        };
                        class Sandbox {
                            text = "Sandbox";
                            data = "sandbox";
                            colorPicture[] = {1,1,1,1};
                        };
                        class Training {
                            text = "Training";
                            data = "training";
                            colorPicture[] = {1,1,1,1};
                        };
                        class Invasion {
                            text = "Invasion";
                            data = "invasion";
                            colorPicture[] = {1,1,1,1};
                        };
                        class Assault {
                            text = "Assault";
                            data = "assault";
                            colorPicture[] = {1,1,1,1};
                        };
                        class Defence {
                            text = "Defence";
                            data = "defence";
                            colorPicture[] = {1,1,1,1};
                        };
                        class CSAR {
                            text = "CSAR (Combat Search and Rescue)";
                            data = "csar";
                            colorPicture[] = {1,1,1,1};
                        };
                        class QRF {
                            text = "QRF (Quick Reaction Force)";
                            data = "qrf";
                            colorPicture[] = {1,1,1,1};
                        };
                    };
                };

                class gameTypeCustomLabel: cmf_ctrlStatic {
                    text = "Custom";
                    tooltip = "Custom game type (game type must be set to custom)";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 10) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class gameTypeCustom: cmf_ctrlEdit {
                    onLoad = "(_this # 0) ctrlEnable false;";
                    tooltip = "Custom game type (game type must be set to custom)";
                    idc = 102;
                    text = "";
                    onSetFocus = "(_this # 0) ctrlSetTextSelection [0, 999]";
                    onKillFocus = "(_this # 0) ctrlSetTextSelection [0, 0]";
                    onMouseButtonClick = "(_this # 0) ctrlSetTextSelection [0, 999]";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1 - 20) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 10) * GRID_3DEN_H;
                    w = 65 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                    colorDisabled[] = {1, 1, 1, 1};
                    colorBackground[] = {0, 0, 0, 0.25};
                    colorBackgroundDisabled[] = {0, 0, 0, 0.1};
                };

                class equipmentLabel: cmf_ctrlStatic {
                    text = "Equipment";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (179/2 - 10 - 5 - 10 - 10 - 10 - 10) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class equipmentSeperator: cmf_ctrlStatic {
                    text = "";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (179/2 - 10 - 5 - 10 - 10 - 10 - 10 - 5) * GRID_3DEN_H;
                    w = 87 * GRID_3DEN_W;
                    h = 0.2 * GRID_3DEN_H;
                    colorBackground[] = {1, 1, 1, 0.25};
                };

                class equipmentDescription: cmf_ctrlStatic {
                    style = ST_MULTI;
                    onLoad = "(_this # 0) ctrlEnable false;";
                    text = "Generate a Table of Equipment for team leaders (the one shown in safestart). Set to nothing to remove entry from Table of Equipment.";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (179/2 - 10 - 5 - 10 - 10 - 10 - 10 - 6) * GRID_3DEN_H;
                    w = 87 * GRID_3DEN_W;
                    h = 10 * GRID_3DEN_H;
                };

                class mapsLabel: cmf_ctrlStatic {
                    text = "Maps";
                    tooltip = "Who has access to maps";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 10 - 10 - 10 - 10) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class maps: cmf_ctrlEdit {
                    idc = 200;
                    text = "None";
                    tooltip = "None, Leaders, Pilots, Drivers, Leaders and Pilots, All, etc.";
                    onSetFocus = "(_this # 0) ctrlSetTextSelection [0, 999]";
                    onKillFocus = "(_this # 0) ctrlSetTextSelection [0, 0]";
                    onMouseButtonClick = "(_this # 0) ctrlSetTextSelection [0, 999]";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1 - 20) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 10 - 10 - 10 - 10) * GRID_3DEN_H;
                    w = 65 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                    colorDisabled[] = {1, 1, 1, 1};
                    colorBackground[] = {0, 0, 0, 0.25};
                    colorBackgroundDisabled[] = {0, 0, 0, 0.1};
                };

                class gpsLabel: cmf_ctrlStatic {
                    text = "GPS";
                    tooltip = "Who has access to gps's";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 10 - 10 - 10 - 10 - 10) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class gps: cmf_ctrlEdit {
                    idc = 201;
                    text = "None";
                    tooltip = "None, Leaders, Pilots, Drivers, Leaders and Pilots, All, etc.";
                    onSetFocus = "(_this # 0) ctrlSetTextSelection [0, 999]";
                    onKillFocus = "(_this # 0) ctrlSetTextSelection [0, 0]";
                    onMouseButtonClick = "(_this # 0) ctrlSetTextSelection [0, 999]";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1 - 20) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 10 - 10 - 10 - 10 - 10) * GRID_3DEN_H;
                    w = 65 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                    colorDisabled[] = {1, 1, 1, 1};
                    colorBackground[] = {0, 0, 0, 0.25};
                    colorBackgroundDisabled[] = {0, 0, 0, 0.1};
                };

                class radiosLabel: cmf_ctrlStatic {
                    text = "Radios";
                    tooltip = "Who has access to radios";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 10 - 10 - 10 - 10 - 10 - 10) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class radios: cmf_ctrlEdit {
                    idc = 202;
                    text = "None";
                    tooltip = "None, Leaders, Pilots, Drivers, Leaders and Pilots, All, etc.";
                    onSetFocus = "(_this # 0) ctrlSetTextSelection [0, 999]";
                    onKillFocus = "(_this # 0) ctrlSetTextSelection [0, 0]";
                    onMouseButtonClick = "(_this # 0) ctrlSetTextSelection [0, 999]";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1 - 20) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 10 - 10 - 10 - 10 - 10 - 10) * GRID_3DEN_H;
                    w = 65 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                    colorDisabled[] = {1, 1, 1, 1};
                    colorBackground[] = {0, 0, 0, 0.25};
                    colorBackgroundDisabled[] = {0, 0, 0, 0.1};
                };

                class nvgsLabel: cmf_ctrlStatic {
                    text = "NVGs";
                    tooltip = "Who has access to NVGs";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 10 - 10 - 10 - 10 - 10 - 10 - 10) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class nvgs: cmf_ctrlEdit {
                    idc = 203;
                    text = "None";
                    tooltip = "None, Leaders, Pilots, Drivers, Leaders and Pilots, All, etc.";
                    onSetFocus = "(_this # 0) ctrlSetTextSelection [0, 999]";
                    onKillFocus = "(_this # 0) ctrlSetTextSelection [0, 0]";
                    onMouseButtonClick = "(_this # 0) ctrlSetTextSelection [0, 999]";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1 - 20) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 10 - 10 - 10 - 10 - 10 - 10 - 10) * GRID_3DEN_H;
                    w = 65 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                    colorDisabled[] = {1, 1, 1, 1};
                    colorBackground[] = {0, 0, 0, 0.25};
                    colorBackgroundDisabled[] = {0, 0, 0, 0.1};
                };

                class flashlightsLabel: cmf_ctrlStatic {
                    text = "Flashlights";
                    tooltip = "Who has access to flashlights";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 10 - 10 - 10 - 10 - 10 - 10 - 10 - 10) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class flashlights: cmf_ctrlEdit {
                    idc = 204;
                    text = "None";
                    tooltip = "None, Leaders, Pilots, Drivers, Leaders and Pilots, All, etc.";
                    onSetFocus = "(_this # 0) ctrlSetTextSelection [0, 999]";
                    onKillFocus = "(_this # 0) ctrlSetTextSelection [0, 0]";
                    onMouseButtonClick = "(_this # 0) ctrlSetTextSelection [0, 999]";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1 - 20) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 10 - 10 - 10 - 10 - 10 - 10 - 10 - 10) * GRID_3DEN_H;
                    w = 65 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                    colorDisabled[] = {1, 1, 1, 1};
                    colorBackground[] = {0, 0, 0, 0.25};
                    colorBackgroundDisabled[] = {0, 0, 0, 0.1};
                };

                class flaresLabel: cmf_ctrlStatic {
                    text = "Flares";
                    tooltip = "Who has access to flares";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 10 - 10 - 10 - 10 - 10 - 10 - 10 - 10 - 10) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class flares: cmf_ctrlEdit {
                    idc = 205;
                    text = "None";
                    tooltip = "None, Leaders, Pilots, Drivers, Leaders and Pilots, All, etc.";
                    onSetFocus = "(_this # 0) ctrlSetTextSelection [0, 999]";
                    onKillFocus = "(_this # 0) ctrlSetTextSelection [0, 0]";
                    onMouseButtonClick = "(_this # 0) ctrlSetTextSelection [0, 999]";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1 - 20) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 10 - 10 - 10 - 10 - 10 - 10 - 10 - 10 - 10) * GRID_3DEN_H;
                    w = 65 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                    colorDisabled[] = {1, 1, 1, 1};
                    colorBackground[] = {0, 0, 0, 0.25};
                    colorBackgroundDisabled[] = {0, 0, 0, 0.1};
                };
            };
        };

        class ButtonCancel: cmf_ctrlButtonCancel {
            x = (getResolution select 2) * 0.5 * pixelW + (120/2 - 117 - 2) * GRID_3DEN_W;
            y = 0.5 + (200/2 - 10 - 1) * GRID_3DEN_H;
            w = 25 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };

        class ButtonSave: cmf_ctrlButtonOK {
            text = "SAVE";
            x = (getResolution select 2) * 0.5 * pixelW + (120/2 - 25 - 1) * GRID_3DEN_W;
            y = 0.5 + (200/2 - 10 - 1) * GRID_3DEN_H;
            w = 25 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };
    };
};

/* 3DEN Menu */
class cmf_3den_warno {
    idd = -1;
    enableDisplay = 1;
    movingEnable = 1;

    class controlsBackground {
        class Disable: cmf_ctrlStaticBackgroundDisable {};
        class DisableTiles: cmf_ctrlStaticBackgroundDisableTiles {};
    };

    class controls {
        class Background: cmf_ctrlStaticBackground {
            x = (getResolution select 2) * 0.5 * pixelW - (120/2) * GRID_3DEN_W;
            y = 0.5 - (200/2 - 5) * GRID_3DEN_H;
            w = 120 * GRID_3DEN_W;
            h = (200 - 10) * GRID_3DEN_H;
        };

        class BackgroundButtons: cmf_ctrlStaticFooter {
            x = (getResolution select 2) * 0.5 * pixelW - (120/2) * GRID_3DEN_W;
            y = 0.5 + (200/2 - 10 - 2) * GRID_3DEN_H;
            w = 120 * GRID_3DEN_W;
            h = 7 * GRID_3DEN_H;
        };

        class Title: cmf_ctrlStaticTitle {
            text = "Edit: Warning Order";
            x = (getResolution select 2) * 0.5 * pixelW - (120/2) * GRID_3DEN_W;
            y = 0.5 - (200/2 - 5) * GRID_3DEN_H;
            w = 120 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };

        class settingsGroup: cmf_RscControlsGroup {
            x = (getResolution select 2) * 0.5 * pixelW - (120/2) * GRID_3DEN_W;
            y = 0.5 - (200/2 - 10 - 5) * GRID_3DEN_H;
            w = 120 * GRID_3DEN_W;
            h = 173 * GRID_3DEN_H;

            class controls {
                class warnoLabel: cmf_ctrlStatic {
                    text = "Warning Order";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class warnoSeperator: cmf_ctrlStatic {
                    text = "";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5) * GRID_3DEN_H;
                    w = 87 * GRID_3DEN_W;
                    h = 0.2 * GRID_3DEN_H;
                    colorBackground[] = {1, 1, 1, 0.25};
                };

                class warnoDescription: cmf_ctrlStatic {
                    style = ST_MULTI;
                    onLoad = "(_this # 0) ctrlEnable false;";
                    text = "Generate a Warning Order following the SMEAC format.";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 6) * GRID_3DEN_H;
                    w = 87 * GRID_3DEN_W;
                    h = 10 * GRID_3DEN_H;
                };

                class situationCatLabel: cmf_ctrlStatic {
                    text = "Situation";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 37) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class situationCatLabelSeperator: cmf_ctrlStatic {
                    text = "";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10) * GRID_3DEN_H;
                    w = 87 * GRID_3DEN_W;
                    h = 0.2 * GRID_3DEN_H;
                    colorBackground[] = {1, 1, 1, 0.25};
                };

                class situationLabel: cmf_ctrlStatic {
                    text = "Situation";
                    tooltip = "The current situation, basically your backstory and what is happening in your world";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 3) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class situation: cmf_ctrlEdit {
                    style = ST_MULTI;
                    idc = 300;
                    text = "";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 2) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 5 - 3) * GRID_3DEN_H;
                    w = 86 * GRID_3DEN_W;
                    h = 20 * GRID_3DEN_H;
                    colorDisabled[] = {1, 1, 1, 1};
                    colorBackground[] = {0, 0, 0, 0.25};
                    colorBackgroundDisabled[] = {0, 0, 0, 0.1};
                };

                class enemyCompositionLabel: cmf_ctrlStatic {
                    text = "Enemy Forces";
                    tooltip = "The composition of the enemy (Infantry, Armored, Mechanized, etc.)";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 3 - 30) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class enemyComposition: cmf_ctrlEdit {
                    style = ST_MULTI;
                    idc = 301;
                    text = "";
                    tooltip = "Format as a list (put everything on a new line with a dash infront of it, example: - Infantry), leave empty to ommit from WARNO";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 2) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 5 - 3 - 30) * GRID_3DEN_H;
                    w = 86 * GRID_3DEN_W;
                    h = 20 * GRID_3DEN_H;
                    colorDisabled[] = {1, 1, 1, 1};
                    colorBackground[] = {0, 0, 0, 0.25};
                    colorBackgroundDisabled[] = {0, 0, 0, 0.1};
                };

                class enemyCapabilitiesLabel: cmf_ctrlStatic {
                    text = "Enemy Capabilities";
                    tooltip = "The capabilities of the enemy (Anti-Tank, Anti-Air, Close Air Support, Artillery, etc.)";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 3 - 30 - 30) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class enemyCapabilities: cmf_ctrlEdit {
                    style = ST_MULTI;
                    idc = 302;
                    text = "";
                    tooltip = "Format as a list (put everything on a new line with a dash infront of it, example: - Infantry), leave empty to ommit from WARNO";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 2) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 5 - 3 - 30 - 30) * GRID_3DEN_H;
                    w = 86 * GRID_3DEN_W;
                    h = 20 * GRID_3DEN_H;
                    colorDisabled[] = {1, 1, 1, 1};
                    colorBackground[] = {0, 0, 0, 0.25};
                    colorBackgroundDisabled[] = {0, 0, 0, 0.1};
                };

                class friendlyCompositionLabel: cmf_ctrlStatic {
                    text = "Friendly Forces";
                    tooltip = "The Composition of friendlies (Alpha, LOGI, ENGI, etc.)";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 3 - 30 - 30 - 30) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class friendlyComposition: cmf_ctrlEdit {
                    style = ST_MULTI;
                    idc = 303;
                    text = "";
                    tooltip = "Format as a list (put everything on a new line with a dash infront of it, example: - Infantry), leave empty to ommit from WARNO";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 2) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 5 - 3 - 30 - 30 - 30) * GRID_3DEN_H;
                    w = 86 * GRID_3DEN_W;
                    h = 20 * GRID_3DEN_H;
                    colorDisabled[] = {1, 1, 1, 1};
                    colorBackground[] = {0, 0, 0, 0.25};
                    colorBackgroundDisabled[] = {0, 0, 0, 0.1};
                };

                class friendlycapabilitiesLabel: cmf_ctrlStatic {
                    text = "Friendly Capabilities";
                    tooltip = "The capabilities of friendlies (Anti-Tank, Anti-Air, Close Air Support, Artillery, etc.)";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 3 - 30 - 30 - 30 - 30) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class friendlycapabilities: cmf_ctrlEdit {
                    style = ST_MULTI;
                    idc = 304;
                    text = "";
                    tooltip = "Format as a list (put everything on a new line with a dash infront of it, example: - Close Air Support), leave empty to ommit from WARNO";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 2) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 5 - 3 - 30 - 30 - 30 - 30) * GRID_3DEN_H;
                    w = 86 * GRID_3DEN_W;
                    h = 20 * GRID_3DEN_H;
                    colorDisabled[] = {1, 1, 1, 1};
                    colorBackground[] = {0, 0, 0, 0.25};
                    colorBackgroundDisabled[] = {0, 0, 0, 0.1};
                };

                class missionCatLabel: cmf_ctrlStatic {
                    text = "Mission";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 37) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 5 - 3 - 30 - 30 - 30 - 30 - 25) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class missionCatSeperator: cmf_ctrlStatic {
                    text = "";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 5 - 3 - 30 - 30 - 30 - 30 - 30) * GRID_3DEN_H;
                    w = 87 * GRID_3DEN_W;
                    h = 0.2 * GRID_3DEN_H;
                    colorBackground[] = {1, 1, 1, 0.25};
                };

                class missionLabel: cmf_ctrlStatic {
                    text = "Mission";
                    tooltip = "A description of objectives";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 5 - 3 - 30 - 30 - 30 - 30 - 30 - 3) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class mission: cmf_ctrlEdit {
                    style = ST_MULTI;
                    idc = 305;
                    text = "";
                    tooltip = "Format as a list (put everything on a new line with a dash infront of it, example: - MSR King secured and cleared of enemy contacts), leave empty to ommit from WARNO";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 2) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 5 - 3 - 30 - 30 - 30 - 30 - 30 - 8) * GRID_3DEN_H;
                    w = 86 * GRID_3DEN_W;
                    h = 20 * GRID_3DEN_H;
                    colorDisabled[] = {1, 1, 1, 1};
                    colorBackground[] = {0, 0, 0, 0.25};
                    colorBackgroundDisabled[] = {0, 0, 0, 0.1};
                };

                class executionCatLabel: cmf_ctrlStatic {
                    text = "Execution";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 36) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 5 - 3 - 30 - 30 - 30 - 30 - 30 - 8 - 25) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class executionCatSeperator: cmf_ctrlStatic {
                    text = "";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 5 - 3 - 30 - 30 - 30 - 30 - 30 - 8 - 30) * GRID_3DEN_H;
                    w = 87 * GRID_3DEN_W;
                    h = 0.2 * GRID_3DEN_H;
                    colorBackground[] = {1, 1, 1, 0.25};
                };

                class executionLabel: cmf_ctrlStatic {
                    text = "Execution";
                    tooltip = "A detailed plan of events, usually you can leave this blank";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 5 - 3 - 30 - 30 - 30 - 30 - 30 - 8 - 30 - 3) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class execution: cmf_ctrlEdit {
                    style = ST_MULTI;
                    idc = 306;
                    text = "";
                    tooltip = "Format as a list (put everything on a new line with a dash infront of it), leave empty to ommit from WARNO";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 2) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 5 - 3 - 30 - 30 - 30 - 30 - 30 - 8 - 30 - 3 - 5) * GRID_3DEN_H;
                    w = 86 * GRID_3DEN_W;
                    h = 20 * GRID_3DEN_H;
                    colorDisabled[] = {1, 1, 1, 1};
                    colorBackground[] = {0, 0, 0, 0.25};
                    colorBackgroundDisabled[] = {0, 0, 0, 0.1};
                };

                class coIntentLabel: cmf_ctrlStatic {
                    text = "Commander's Intent";
                    tooltip = "A description of objectives";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 5 - 3 - 30 - 30 - 30 - 30 - 30 - 8 - 30 - 3 - 30) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class coIntent: cmf_ctrlEdit {
                    style = ST_MULTI;
                    idc = 307;
                    text = "";
                    tooltip = "Format as a list (put everything on a new line with a dash infront of it, example: - Objective 1 Cleared of enemies), leave empty to ommit from WARNO";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 2) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5  - 10 - 10 - 5 - 3 - 30 - 30 - 30 - 30 - 30 - 8 - 30 - 3 - 5 - 30) * GRID_3DEN_H;
                    w = 86 * GRID_3DEN_W;
                    h = 20 * GRID_3DEN_H;
                    colorDisabled[] = {1, 1, 1, 1};
                    colorBackground[] = {0, 0, 0, 0.25};
                    colorBackgroundDisabled[] = {0, 0, 0, 0.1};
                };

                class moPlanLabel: cmf_ctrlStatic {
                    text = "Movement Plan";
                    tooltip = "Planned movement of task force";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 5 - 3 - 30 - 30 - 30 - 30 - 30 - 8 - 30 - 3 - 30 - 30) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class moPlan: cmf_ctrlEdit {
                    style = ST_MULTI;
                    idc = 308;
                    text = "";
                    tooltip = "Format as a list (put everything on a new line with a dash infront of it, example: - Move To Waypoint 2), leave empty to ommit from WARNO";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 2) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 5 - 3 - 30 - 30 - 30 - 30 - 30 - 8 - 30 - 3 - 5 - 30 - 30) * GRID_3DEN_H;
                    w = 86 * GRID_3DEN_W;
                    h = 20 * GRID_3DEN_H;
                    colorDisabled[] = {1, 1, 1, 1};
                    colorBackground[] = {0, 0, 0, 0.25};
                    colorBackgroundDisabled[] = {0, 0, 0, 0.1};
                };

                class administrationCatLabel: cmf_ctrlStatic {
                    text = "Administration / Logistics";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 27) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 5 - 3 - 30 - 30 - 30 - 30 - 30 - 8 - 30 - 3 - 5 - 30 - 30 - 25) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class administrationCatSeperator: cmf_ctrlStatic {
                    text = "";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 5 - 3 - 30 - 30 - 30 - 30 - 30 - 8 - 30 - 3 - 5 - 30 - 30 - 30) * GRID_3DEN_H;
                    w = 87 * GRID_3DEN_W;
                    h = 0.2 * GRID_3DEN_H;
                    colorBackground[] = {1, 1, 1, 0.25};
                };

                class administrationLabel: cmf_ctrlStatic {
                    text = "Administration and Logistics";
                    tooltip = "Capabilities available to your team, logistics and assets (vehicles available to players)";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 5 - 3 - 30 - 30 - 30 - 30 - 30 - 8 - 30 - 3 - 30 - 30 - 30 - 7) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class administration: cmf_ctrlEdit {
                    style = ST_MULTI;
                    idc = 309;
                    text = "";
                    tooltip = "Format as a list (except assets) (put everything on a new line with a dash infront of it, example: - No Resupply), leave empty to ommit from WARNO";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 2) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 5 - 3 - 30 - 30 - 30 - 30 - 30 - 8 - 30 - 3 - 5 - 30 - 30 - 30 - 7) * GRID_3DEN_H;
                    w = 86 * GRID_3DEN_W;
                    h = 20 * GRID_3DEN_H;
                    colorDisabled[] = {1, 1, 1, 1};
                    colorBackground[] = {0, 0, 0, 0.25};
                    colorBackgroundDisabled[] = {0, 0, 0, 0.1};
                };

                class commandCatLabel: cmf_ctrlStatic {
                    text = "Command / Signal";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 31) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 5 - 3 - 30 - 30 - 30 - 30 - 30 - 8 - 30 - 3 - 5 - 30 - 30 - 30 - 7 - 25) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class commandCatSeperator: cmf_ctrlStatic {
                    text = "";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 5 - 3 - 30 - 30 - 30 - 30 - 30 - 8 - 30 - 3 - 5 - 30 - 30 - 30 - 7 - 30) * GRID_3DEN_H;
                    w = 87 * GRID_3DEN_W;
                    h = 0.2 * GRID_3DEN_H;
                    colorBackground[] = {1, 1, 1, 0.25};
                };

                class commoLabel: cmf_ctrlStatic {
                    text = "Table of Communication";
                    tooltip = "Radio channels/FREQs and their purpose";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 5 - 3 - 30 - 30 - 30 - 30 - 30 - 8 - 30 - 3 - 30 - 30 - 30 - 7 - 30 - 7) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class commo: cmf_ctrlEdit {
                    style = ST_MULTI;
                    idc = 310;
                    text = "";
                    tooltip = "Format as: NET - RADIO - CHANNEL (Example: COMMAND NET - AN/PRC-152 - Chan 2), leave empty to ommit from WARNO";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 2) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 5 - 3 - 30 - 30 - 30 - 30 - 30 - 8 - 30 - 3 - 5 - 30 - 30 - 30 - 7 - 30 - 7) * GRID_3DEN_H;
                    w = 86 * GRID_3DEN_W;
                    h = 20 * GRID_3DEN_H;
                    colorDisabled[] = {1, 1, 1, 1};
                    colorBackground[] = {0, 0, 0, 0.25};
                    colorBackgroundDisabled[] = {0, 0, 0, 0.1};
                };

                class ROELabel: cmf_ctrlStatic {
                    text = "Rules of Engagement";
                    tooltip = "";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 5 - 3 - 30 - 30 - 30 - 30 - 30 - 8 - 30 - 3 - 5 - 30 - 30 - 30 - 7 - 30 - 7 - 25) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class ROE: cmf_ctrlEdit {
                    style = ST_MULTI;
                    idc = 311;
                    text = "";
                    tooltip = "";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 2) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 5 - 3 - 30 - 30 - 30 - 30 - 30 - 8 - 30 - 3 - 5 - 30 - 30 - 30 - 7 - 30 - 7 - 30) * GRID_3DEN_H;
                    w = 86 * GRID_3DEN_W;
                    h = 20 * GRID_3DEN_H;
                    colorDisabled[] = {1, 1, 1, 1};
                    colorBackground[] = {0, 0, 0, 0.25};
                    colorBackgroundDisabled[] = {0, 0, 0, 0.1};
                };

                class SOPLabel: cmf_ctrlStatic {
                    text = "Standard Operating Procedures";
                    tooltip = "";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 1) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 5 - 3 - 30 - 30 - 30 - 30 - 30 - 8 - 30 - 3 - 5 - 30 - 30 - 30 - 7 - 30 - 7 - 30 - 25) * GRID_3DEN_H;
                    w = 49 * GRID_3DEN_W;
                    h = 5 * GRID_3DEN_H;
                };

                class SOP: cmf_ctrlEdit {
                    style = ST_MULTI;
                    idc = 312;
                    text = "";
                    tooltip = "Format as a list (put everything on a new line with a dash infront of it, example: - Red Smoke for CAS), leave empty to ommit from WARNO";
                    x = (getResolution select 2) * 0.5 * pixelW - (165/2 - 2) * GRID_3DEN_W;
                    y = 0.5 - (178/2 - 10 - 5 - 10 - 10 - 5 - 3 - 30 - 30 - 30 - 30 - 30 - 8 - 30 - 3 - 5 - 30 - 30 - 30 - 7 - 30 - 7 - 30 - 30) * GRID_3DEN_H;
                    w = 86 * GRID_3DEN_W;
                    h = 20 * GRID_3DEN_H;
                    colorDisabled[] = {1, 1, 1, 1};
                    colorBackground[] = {0, 0, 0, 0.25};
                    colorBackgroundDisabled[] = {0, 0, 0, 0.1};
                };
            }
        }

        class ButtonOK: cmf_ctrlButtonCancel {
            x = (getResolution select 2) * 0.5 * pixelW + (120/2 - 117 - 2) * GRID_3DEN_W;
            y = 0.5 + (200/2 - 10 - 1) * GRID_3DEN_H;
            w = 25 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };

        class ButtonCancel: cmf_ctrlButtonOK {
            text = "SAVE";
            x = (getResolution select 2) * 0.5 * pixelW + (120/2 - 25 - 1) * GRID_3DEN_W;
            y = 0.5 + (200/2 - 10 - 1) * GRID_3DEN_H;
            w = 25 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };
    };
};
