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
