/* Report bug web link workaround */
class cmf_utility_reportBug {
    idd = -1;
    enableDisplay = 1;
    movingEnable = 1;

    class controls {
        class Background: cmf_ctrlStaticBackground {
            x = (getResolution select 2) * 0.5 * pixelW - (90/2) * GRID_3DEN_W;
            y = 0.5 - (35/2 - 5) * GRID_3DEN_H;
            w = 90 * GRID_3DEN_W;
            h = (35 - 10) * GRID_3DEN_H;
        };

        class BackgroundButtons: cmf_ctrlStaticFooter {
            x = (getResolution select 2) * 0.5 * pixelW - (90/2) * GRID_3DEN_W;
            y = 0.5 + (35/2 - 10 - 2) * GRID_3DEN_H;
            w = 90 * GRID_3DEN_W;
            h = 7 * GRID_3DEN_H;
        };

        class Title: cmf_ctrlStaticTitle {
            text = "CMF: Report Bug";
            x = (getResolution select 2) * 0.5 * pixelW - (90/2) * GRID_3DEN_W;
            y = 0.5 - (35/2 - 5) * GRID_3DEN_H;
            w = 90 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };

		class roleLabel: cmf_ctrlStatic {
			text = "This will open the issue-tracker in your browser.";
            tooltip = "The unit's assigned kosherArsenal role, e.g. RFL";
            x = (getResolution select 2) * 0.5 * pixelW - (90/2 - 1) * GRID_3DEN_W;
            y = 0.5 - (35/2 - 10 - 5) * GRID_3DEN_H;
            w = 80 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };

        class ButtonOK: cmf_ctrlButtonOK {
			text = "Open page";
            url= "https://github.com/clustermod/CMF3/issues";
            x = (getResolution select 2) * 0.5 * pixelW + (90/2 - 25 - 1) * GRID_3DEN_W;
            y = 0.5 + (35/2 - 10 - 1) * GRID_3DEN_H;
            w = 25 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };

        class ButtonCancel: cmf_ctrlButtonCancel {
            x = (getResolution select 2) * 0.5 * pixelW - (90/2 - 1) * GRID_3DEN_W;
            y = 0.5 + (35/2 - 10 - 1) * GRID_3DEN_H;
            w = 25 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };
    };
};

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

/* Viewdistance dialog */
class cmf_viewdistance_dialog {
	idd = 2900;
	movingEnable = false;
	moving = 1;
	onLoad = "";
	onUnload = "";

	class controlsBackground {
		class rscBackground:  cmf_viewdistance_rscFrame {
			idc = 1800;
			x = 7 * GUI_GRID_W + GUI_GRID_X;
			y = 1.1 * GUI_GRID_H + GUI_GRID_Y;
			w = 24.5 * GUI_GRID_W;
			h = 22.4 * GUI_GRID_H;
			colorBackground[] = {0,0,0,0.7};
		};

		class rscTitle:  cmf_viewdistance_rscText {
			idc = 1000;
			text = "VIEW DISTANCE SETTINGS"; //--- ToDo: Localize;
			x = 7 * GUI_GRID_W + GUI_GRID_X;
			y = 0 * GUI_GRID_H + GUI_GRID_Y;
			w = 24.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
		};

		class rscFootHeaderText:  cmf_viewdistance_rscTextRight {
			idc = 1001;
			text = "ON FOOT"; //--- ToDo: Localize;
			x = 7 * GUI_GRID_W + GUI_GRID_X;
			y = 1.4 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0,0,1};
		};

		class rscFootViewText:  cmf_viewdistance_rscTextRight {
			idc = 1002;
			text = "VIEW:"; //--- ToDo: Localize;
			x = 7.5 * GUI_GRID_W + GUI_GRID_X;
			y = 2.7 * GUI_GRID_H + GUI_GRID_Y;
			w = 6.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class rscFootObjText:  cmf_viewdistance_rscTextRight {
			idc = 1003;
			text = "OBJECT:"; //--- ToDo: Localize;
			x = 7.5 * GUI_GRID_W + GUI_GRID_X;
			y = 4.2 * GUI_GRID_H + GUI_GRID_Y;
			w = 6.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class rscFootTerrainText:  cmf_viewdistance_rscTextRight {
			idc = 1005;
			text = "TERRAIN:"; //--- ToDo: Localize;
			x = 7.5 * GUI_GRID_W + GUI_GRID_X;
			y = 7.2 * GUI_GRID_H + GUI_GRID_Y;
			w = 6.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class rscCarHeaderText:  cmf_viewdistance_rscTextRight {
			idc = 1008;
			text = "IN CAR"; //--- ToDo: Localize;
			x = 7 * GUI_GRID_W + GUI_GRID_X;
			y = 8.7 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0,0,1};
		};

		class rscCarViewText:  cmf_viewdistance_rscTextRight {
			idc = 1010;
			text = "VIEW:"; //--- ToDo: Localize;
			x = 7.5 * GUI_GRID_W + GUI_GRID_X;
			y = 10 * GUI_GRID_H + GUI_GRID_Y;
			w = 6.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class rscAirObjText:  cmf_viewdistance_rscTextRight {
			idc = 1011;
			text = "OBJECT:"; //--- ToDo: Localize;
			x = 7.5 * GUI_GRID_W + GUI_GRID_X;
			y = 18.9 * GUI_GRID_H + GUI_GRID_Y;
			w = 6.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class rscCarTerrainText:  cmf_viewdistance_rscTextRight {
			idc = 1012;
			text = "TERRAIN:"; //--- ToDo: Localize;
			x = 7.5 * GUI_GRID_W + GUI_GRID_X;
			y = 14.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 6.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class rscAirHeaderText:  cmf_viewdistance_rscTextRight {
			idc = 1015;
			text = "IN AIR"; //--- ToDo: Localize;
			x = 7 * GUI_GRID_W + GUI_GRID_X;
			y = 16 * GUI_GRID_H + GUI_GRID_Y;
			w = 7 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
			colorBackground[] = {0,0,0,1};
		};

		class rscAirViewText:  cmf_viewdistance_rscTextRight {
			idc = 1016;
			text = "VIEW:"; //--- ToDo: Localize;
			x = 7.5 * GUI_GRID_W + GUI_GRID_X;
			y = 17.4 * GUI_GRID_H + GUI_GRID_Y;
			w = 6.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class rscAirTerrainText:  cmf_viewdistance_rscTextRight {
			idc = 1019;
			text = "TERRAIN:"; //--- ToDo: Localize;
			x = 7.5 * GUI_GRID_W + GUI_GRID_X;
			y = 21.9 * GUI_GRID_H + GUI_GRID_Y;
			w = 6.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class rscCarObjText:  cmf_viewdistance_rscTextRight {
			idc = 1021;
			text = "OBJECT:"; //--- ToDo: Localize;
			x = 7.5 * GUI_GRID_W + GUI_GRID_X;
			y = 11.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 6.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class rscFootSyncText:  cmf_viewdistance_rscTextRight {
			idc = 1403;
			text = "SYNC MODE:"; //--- ToDo: Localize;
			x = 7.5 * GUI_GRID_W + GUI_GRID_X;
			y = 5.7 * GUI_GRID_H + GUI_GRID_Y;
			w = 6.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class rscCarSyncText:  cmf_viewdistance_rscTextRight {
			idc = 1405;
			text = "SYNC MODE:"; //--- ToDo: Localize;
			x = 7.5 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 6.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class rscAirSyncText:  cmf_viewdistance_rscTextRight {
			idc = 1407;
			text = "SYNC MODE:"; //--- ToDo: Localize;
			x = 7.5 * GUI_GRID_W + GUI_GRID_X;
			y = 20.4 * GUI_GRID_H + GUI_GRID_Y;
			w = 6.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
	};

	class controls {
		class rscFootViewSlider:  cmf_viewdistance_rscXSliderH {
			idc = 1900;
			type = 43;
			onSliderPosChanged = "['cmf_viewdistance_foot', _this select 0, _this select 1, 1006, 'cmf_viewdistance_footObj', 1901, 1007, 'cmf_viewdistance_footSyncMode', 'cmf_viewdistance_footSyncPercentage'] call cmf_viewdistance_fnc_onSliderChange";
			x = 14 * GUI_GRID_W + GUI_GRID_X;
			y = 2.7 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class rscFootObjSlider:  cmf_viewdistance_rscXSliderH {
			idc = 1901;
			type = 43;
			onSliderPosChanged = "['cmf_viewdistance_footObj', _this select 0, _this select 1, 1007] call cmf_viewdistance_fnc_onSliderChange";
			x = 14 * GUI_GRID_W + GUI_GRID_X;
			y = 4.2 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class rscCarViewSlider:  cmf_viewdistance_rscXSliderH {
			idc = 1902;
			type = 43;
			onSliderPosChanged = "['cmf_viewdistance_car', _this select 0, _this select 1, 1013, 'cmf_viewdistance_carObj', 1903, 1014, 'cmf_viewdistance_carSyncMode', 'cmf_viewdistance_carSyncPercentage'] call cmf_viewdistance_fnc_onSliderChange";
			x = 14 * GUI_GRID_W + GUI_GRID_X;
			y = 10 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class rscCarObjSlider:  cmf_viewdistance_rscXSliderH {
			idc = 1903;
			type = 43;
			onSliderPosChanged = "['cmf_viewdistance_carObj', _this select 0, _this select 1, 1014] call cmf_viewdistance_fnc_onSliderChange";
			x = 14 * GUI_GRID_W + GUI_GRID_X;
			y = 11.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class rscAirViewSlider:  cmf_viewdistance_rscXSliderH {
			idc = 1904;
			type = 43;
			onSliderPosChanged = "['cmf_viewdistance_air', _this select 0, _this select 1, 1017, 'CHVD_airObj', 1905, 1018, 'cmf_viewdistance_airSyncMode', 'cmf_viewdistance_airSyncPercentage'] call cmf_viewdistance_fnc_onSliderChange";
			x = 14 * GUI_GRID_W + GUI_GRID_X;
			y = 17.4 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class rscAirObjSlider:  cmf_viewdistance_rscXSliderH {
			idc = 1905;
			type = 43;
			onSliderPosChanged = "['cmf_viewdistance_airObj', _this select 0, _this select 1, 1018] call cmf_viewdistance_fnc_onSliderChange";
			x = 14 * GUI_GRID_W + GUI_GRID_X;
			y = 18.9 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class rscFootviewdistance:  cmf_viewdistance_rscEdit {
			idc = 1006;
			onKeyDown = "['cmf_viewdistance_foot', 1900, _this select 0, 'cmf_viewdistance_footObj', 1901, 1007, 'cmf_viewdistance_footSyncMode', 'cmf_viewdistance_footSyncPercentage'] call cmf_viewdistance_fnc_onEBinput";
			maxChars = 5;
			x = 27 * GUI_GRID_W + GUI_GRID_X;
			y = 2.7 * GUI_GRID_H + GUI_GRID_Y;
			w = 3.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class rscFootObjDistance:  cmf_viewdistance_rscEdit {
			idc = 1007;
			onKeyDown = "['cmf_viewdistance_footObj', 1901, _this select 0] call cmf_viewdistance_fnc_onEBinput";
			maxChars = 5;
			x = 27 * GUI_GRID_W + GUI_GRID_X;
			y = 4.2 * GUI_GRID_H + GUI_GRID_Y;
			w = 3.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class rscCarviewdistance:  cmf_viewdistance_rscEdit {
			idc = 1013;
			onKeyDown = "['cmf_viewdistance_car', 1902, _this select 0, 'cmf_viewdistance_carObj', 1903, 1014, 'cmf_viewdistance_carSyncMode', 'cmf_viewdistance_carSyncPercentage'] call cmf_viewdistance_fnc_onEBinput";
			maxChars = 5;
			x = 27 * GUI_GRID_W + GUI_GRID_X;
			y = 10 * GUI_GRID_H + GUI_GRID_Y;
			w = 3.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class rscCarObjDistance:  cmf_viewdistance_rscEdit {
			idc = 1014;
			onKeyDown = "['cmf_viewdistance_carObj', 1903, _this select 0] call cmf_viewdistance_fnc_onEBinput";
			maxChars = 5;
			x = 27 * GUI_GRID_W + GUI_GRID_X;
			y = 11.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 3.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class rscAirviewdistance:  cmf_viewdistance_rscEdit {
			idc = 1017;
			onKeyDown = "['cmf_viewdistance_air', 1904, _this select 0, 'cmf_viewdistance_airObj', 1905, 1018, 'cmf_viewdistance_airSyncMode', 'cmf_viewdistance_airSyncPercentage'] call cmf_viewdistance_fnc_onEBinput";
			maxChars = 5;
			x = 27 * GUI_GRID_W + GUI_GRID_X;
			y = 17.4 * GUI_GRID_H + GUI_GRID_Y;
			w = 3.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class rscAirObjDistance:  cmf_viewdistance_rscEdit {
			idc = 1018;
			onKeyDown = "['cmf_viewdistance_airObj', 1905, _this select 0] call cmf_viewdistance_fnc_onEBinput";
			maxChars = 5;
			x = 27 * GUI_GRID_W + GUI_GRID_X;
			y = 18.9 * GUI_GRID_H + GUI_GRID_Y;
			w = 3.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class rscClose:  cmf_viewdistance_rscButton {
			idc = 1612;
			onButtonClick = "closeDialog 2900";
			text = "Close"; //--- ToDo: Localize;
			x = 7 * GUI_GRID_W + GUI_GRID_X;
			y = 23.53 * GUI_GRID_H + GUI_GRID_Y;
			w = 24.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class footTerrainListbox:  cmf_viewdistance_rscXListBox {
			idc = 1500;
			x = 14 * GUI_GRID_W + GUI_GRID_X;
			y = 7.2 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class carTerrainListbox:  cmf_viewdistance_rscXListBox {
			idc = 1501;
			x = 14 * GUI_GRID_W + GUI_GRID_X;
			y = 14.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class airTerrainListbox:  cmf_viewdistance_rscXListBox {
			idc = 1502;
			x = 14 * GUI_GRID_W + GUI_GRID_X;
			y = 21.9 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class footTerrainEdit:  cmf_viewdistance_rscEdit {
			idc = 1400;
			onKeyDown = "['cmf_viewdistance_footTerrain', 1400, 1500] call cmf_viewdistance_fnc_onEBterrainInput";
			maxChars = 5;
			x = 27 * GUI_GRID_W + GUI_GRID_X;
			y = 7.2 * GUI_GRID_H + GUI_GRID_Y;
			w = 3.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class carTerrainEdit:  cmf_viewdistance_rscEdit {
			idc = 1401;
			onKeyDown = "['cmf_viewdistance_carTerrain', 1401, 1501] call cmf_viewdistance_fnc_onEBterrainInput";
			maxChars = 5;
			x = 27 * GUI_GRID_W + GUI_GRID_X;
			y = 14.5 * GUI_GRID_H + GUI_GRID_Y;
			w = 3.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class airTerrainEdit:  cmf_viewdistance_rscEdit {
			idc = 1402;
			onKeyDown = "['cmf_viewdistance_airTerrain', 1402, 1502] call cmf_viewdistance_fnc_onEBterrainInput";
			maxChars = 5;
			x = 27 * GUI_GRID_W + GUI_GRID_X;
			y = 21.9 * GUI_GRID_H + GUI_GRID_Y;
			w = 3.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class footSyncListbox:  cmf_viewdistance_rscXListBox {
			idc = 1404;
			x = 14 * GUI_GRID_W + GUI_GRID_X;
			y = 5.7 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class carSyncListbox:  cmf_viewdistance_rscXListBox {
			idc = 1406;
			x = 14 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class airSyncListbox:  cmf_viewdistance_rscXListBox {
			idc = 1408;
			x = 14 * GUI_GRID_W + GUI_GRID_X;
			y = 20.4 * GUI_GRID_H + GUI_GRID_Y;
			w = 12.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class footSyncEdit:  cmf_viewdistance_rscEdit {
			idc = 1410;
			maxChars = 4;
			x = 27 * GUI_GRID_W + GUI_GRID_X;
			y = 5.7 * GUI_GRID_H + GUI_GRID_Y;
			w = 3.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class carSyncEdit:  cmf_viewdistance_rscEdit {
			idc = 1409;
			maxChars = 4;
			x = 27 * GUI_GRID_W + GUI_GRID_X;
			y = 13 * GUI_GRID_H + GUI_GRID_Y;
			w = 3.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};

		class airSyncEdit:  cmf_viewdistance_rscEdit {
			idc = 1411;
			maxChars = 4;
			x = 27 * GUI_GRID_W + GUI_GRID_X;
			y = 20.4 * GUI_GRID_H + GUI_GRID_Y;
			w = 3.5 * GUI_GRID_W;
			h = 1 * GUI_GRID_H;
		};
	};
};
