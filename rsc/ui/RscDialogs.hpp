/* After Action Playback Controller */
class emf_afterActionReport_controller {
	idd = -1;
    enableSimulation = 1;

	class Controls {
		class playback_slider: emf_RscSlider {
            idc = 200;
			x = safeZoneX + safeZoneW * 0.075625;
			y = safeZoneY + safeZoneH * 0.95777778;
			w = safeZoneW * 0.89875;
			h = safeZoneH * 0.01777778;
			color[] = {1,1,1,1};
			colorActive[] = {1,1,1,1};
            sliderStep = 0.01;
            sliderPosition = 0;
		};

		class playback_time: emf_RscText {
            idc = 201;
			x = safeZoneX + safeZoneW * 0.0295;
			y = safeZoneY + safeZoneH * 0.95777778;
			w = safeZoneW * 0.046;
			h = safeZoneH * 0.01777778;
			text = "00:00:00";
			colorBackground[] = {0,0,0,1};
			color[] = {1,1,1,1};
			colorActive[] = {1,1,1,1};
            sliderStep = 0.01;
            sliderPosition = 0;
		};

		class pause_icon: emf_RscPicture {
			idc = 301;
			x = safeZoneX + safeZoneW * 0.479375;
			y = safeZoneY + safeZoneH * 0.91222223;
			w = safeZoneW * 0.020625;
			h = safeZoneH * 0.03555556;
			text = "rsc\data\icon_pause_ca.paa";
			colorBackground[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorFocused[] = {0.2,0.2,0.2,0};
			colorText[] = {1,1,1,1};
		};

		class pause: emf_RscButton {
			idc = 300;
			x = safeZoneX + safeZoneW * 0.479375;
			y = safeZoneY + safeZoneH * 0.91222223;
			w = safeZoneW * 0.020625;
			h = safeZoneH * 0.03555556;
			style = ST_CENTER + ST_PICTURE;
			text = "";
			colorBackground[] = {0,0,0,0};
			colorBackgroundActive[] = {0,0,0,0};
			colorBackgroundDisabled[] = {0,0,0,0};
			colorFocused[] = {0.2,0.2,0.2,0};
			colorText[] = {1,1,1,0};
		};
	};
};

/* 3DEN Custom Unit Menu */
class emf_3den_customUnitMenu {
    idd = -1;
    enableDisplay = 1;
    movingEnable = 1;

    class controlsBackground {
        class Disable: emf_ctrlStaticBackgroundDisable {};
        class DisableTiles: emf_ctrlStaticBackgroundDisableTiles {};
    };

    class controls {
        class Background: emf_ctrlStaticBackground {
            x = (getResolution select 2) * 0.5 * pixelW - (90/2) * GRID_3DEN_W;
            y = 0.5 - (80/2 - 5) * GRID_3DEN_H;
            w = 90 * GRID_3DEN_W;
            h = (80 - 10) * GRID_3DEN_H;
        };

        class BackgroundButtons: emf_ctrlStaticFooter {
            x = (getResolution select 2) * 0.5 * pixelW - (90/2) * GRID_3DEN_W;
            y = 0.5 + (80/2 - 10 - 2) * GRID_3DEN_H;
            w = 90 * GRID_3DEN_W;
            h = 7 * GRID_3DEN_H;
        };

        class Title: emf_ctrlStaticTitle {
            text = "Edit: Custom Unit";
            x = (getResolution select 2) * 0.5 * pixelW - (90/2) * GRID_3DEN_W;
            y = 0.5 - (80/2 - 5) * GRID_3DEN_H;
            w = 90 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };

		class roleLabel: emf_ctrlStatic {
			text = "Role";
            tooltip = "The unit's assigned kosherArsenal role, e.g. RFL";
            x = (getResolution select 2) * 0.5 * pixelW - (90/2 - 1) * GRID_3DEN_W;
            y = 0.5 - (80/2 - 10 - 5) * GRID_3DEN_H;
            w = 49 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };

		class role: emf_ctrlEdit {
			idc = 100;
			text = "RFL";
            x = (getResolution select 2) * 0.5 * pixelW - (90/2 - 1 - 20) * GRID_3DEN_W;
            y = 0.5 - (80/2 - 10 - 5) * GRID_3DEN_H;
            w = 65 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
			colorDisabled[] = {1, 1, 1, 1};
            colorBackground[] = {0, 0, 0, 0.25};
        };

		class lobbyRoleLabel: emf_ctrlStatic {
			text = "Lobby Role";
            tooltip = "The unit's role name in the multiplayer lobby, e.g. Rifleman";
            x = (getResolution select 2) * 0.5 * pixelW - (90/2 - 1) * GRID_3DEN_W;
            y = 0.5 - (80/2 - 10 - 5 - 10) * GRID_3DEN_H;
            w = 49 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };

		class lobbyRole: emf_ctrlEdit {
			idc = 101;
			text = "Rifleman";
            x = (getResolution select 2) * 0.5 * pixelW - (90/2 - 1 - 20) * GRID_3DEN_W;
            y = 0.5 - (80/2 - 10 - 5 - 10) * GRID_3DEN_H;
            w = 65 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
			colorDisabled[] = {1, 1, 1, 1};
            colorBackground[] = {0, 0, 0, 0.25};
        };

		class groupNameLabel: emf_ctrlStatic {
			text = "Group Name";
            tooltip = "The group name for the unit's group, e.g. ASL";
            x = (getResolution select 2) * 0.5 * pixelW - (90/2 - 1) * GRID_3DEN_W;
            y = 0.5 - (80/2 - 10 - 5 - 10 - 10) * GRID_3DEN_H;
            w = 49 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };

		class groupName: emf_ctrlEdit {
			idc = 102;
			text = "A1";
            x = (getResolution select 2) * 0.5 * pixelW - (90/2 - 1 - 20) * GRID_3DEN_W;
            y = 0.5 - (80/2 - 10 - 5 - 10 - 10) * GRID_3DEN_H;
            w = 65 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
			colorDisabled[] = {1, 1, 1, 1};
            colorBackground[] = {0, 0, 0, 0.25};
        };

		class groupTypeLabel: emf_ctrlStatic {
			text = "Group Type";
            tooltip = "The group type for the unit's group, e.g. INF";
            x = (getResolution select 2) * 0.5 * pixelW - (90/2 - 1) * GRID_3DEN_W;
            y = 0.5 - (80/2 - 10 - 5 - 10 - 10 - 10) * GRID_3DEN_H;
            w = 49 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };

		class groupType: emf_ctrlCombo {
			idc = 103;
            x = (getResolution select 2) * 0.5 * pixelW - (90/2 - 1 - 20) * GRID_3DEN_W;
            y = 0.5 - (80/2 - 10 - 5 - 10 - 10 - 10) * GRID_3DEN_H;
            w = 65 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
			colorDisabled[] = {1, 1, 1, 1};
            colorBackground[] = {0, 0, 0, 1};
        };

		class groupSizeLabel: emf_ctrlStatic {
			text = "Group Size";
            tooltip = "The group size for the unit's group, e.g. SQD";
            x = (getResolution select 2) * 0.5 * pixelW - (90/2 - 1) * GRID_3DEN_W;
            y = 0.5 - (80/2 - 10 - 5 - 10 - 10 - 10 - 10) * GRID_3DEN_H;
            w = 49 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };

		class groupSize: emf_ctrlCombo {
			idc = 104;
            x = (getResolution select 2) * 0.5 * pixelW - (90/2 - 1 - 20) * GRID_3DEN_W;
            y = 0.5 - (80/2 - 10 - 5 - 10 - 10 - 10 - 10) * GRID_3DEN_H;
            w = 65 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
			colorDisabled[] = {1, 1, 1, 1};
            colorBackground[] = {0, 0, 0, 1};
        };

        class ButtonOK: emf_ctrlButtonOK {
			text = "Spawn";
            x = (getResolution select 2) * 0.5 * pixelW + (90/2 - 50 - 2) * GRID_3DEN_W;
            y = 0.5 + (80/2 - 10 - 1) * GRID_3DEN_H;
            w = 25 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };

        class ButtonCancel: emf_ctrlButtonCancel {
            x = (getResolution select 2) * 0.5 * pixelW + (90/2 - 25 - 1) * GRID_3DEN_W;
            y = 0.5 + (80/2 - 10 - 1) * GRID_3DEN_H;
            w = 25 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };
    };
};
