/*
 * kosherArsenal controls
 */
class cmf_kosherArsenal_forceClose: cmf_RscButton {
    idc = 2055;
    style = "0x02 + 0x40 + 0x80";
    text = "FORCE CLOSE";
    tooltip = "Force closes kosher arsenal (This will strip you naked)";
    w = "(((safezoneW - 2 * (93 * (pixelW * pixelGridNoUIScale * 0.25))) - 6 * ((safezoneW - 2 * (93 * (pixelW * pixelGridNoUIScale * 0.25))) / 100)) / 5)";
    h = "7 * (pixelH * pixelGridNoUIScale * 0.25)";
    x = "4 * ((safezoneW - 2 * (93 * (pixelW * pixelGridNoUIScale * 0.25))) / 100) + 3 * (((safezoneW - 2 * (93 * (pixelW * pixelGridNoUIScale * 0.25))) - 6 * ((safezoneW - 2 * (93 * (pixelW * pixelGridNoUIScale * 0.25))) / 100)) / 5)";
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
class cmf_player_spectatorAAR: cmf_RscButton {
    style = 48;
    x = safeZoneX + safeZoneW * 0.488125;
    y = safeZoneY + safeZoneH * 0.90222223;
    w = safeZoneW * 0.02;
    h = safeZoneH * 0.03;
    text = "a3\ui_f_curator\data\rsccommon\rscattributeinventory\filter_0_ca.paa";
    colorBackground[] = {0,0,0,0};
    colorBackgroundActive[] = {0,0,0,0};
    colorBackgroundDisabled[] = {0,0,0,0};
    colorBorder[] = {0,0,0,0};
    colorDisabled[] = {1,1,1,0.25};
    colorFocused[] = {0,0,0,0};
    colorShadow[] = {0,0,0,0};
    colorText[] = {1,1,1,1};
    font = "PuristaMedium";
    tooltip = "Submit After Action Report";
    onButtonClick = "[] call cmf_utility_fnc_submitAAR";
};

/*
 * kosherArsenalTool module controls
 */
class cmf_kosherArsenalTool_selectRole: cmf_RscCombo {
	x = safeZoneX + safeZoneW * 0.56625;
	y = safeZoneY + safeZoneH * 0.00444445;
	w = safeZoneW * 0.103125;
	h = safeZoneH * 0.02777778;
    style = ST_NO_RECT;
	colorBackground[] = {0,0,0,0.5};
	colorDisabled[] = {0,0,0,0.4};
	colorSelect[] = {1,0,0,1};
	colorSelectBackground[] = {0,0,0,1};
	colorText[] = {1,1,1,1};
	sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8);

    class Items {
    	class Default {
    		text = "DEFAULT";
            data = 0;
    		default = 1;
    	};
        class Rifleman {
    		text = "RFL";
            data = 1;
    		default = 0;
    	};
        class Squadleader {
    		text = "SL";
            data = 2;
    		default = 0;
    	};
        class Medic {
    		text = "MED";
            data = 3;
    		default = 0;
    	};
    };
};

class cmf_kosherArsenalTool_deleteRole: cmf_RscButton {
	x = safeZoneX + safeZoneW * 0.669375;
	y = safeZoneY + safeZoneH * 0.00444445;
	w = safeZoneW * 0.061875;
	h = safeZoneH * 0.02777778;
	style = ST_CENTER;
	text = "Delete Role";
	colorBackground[] = {0,0,0,0.5};
	colorBackgroundActive[] = {0.668,0.1396,0.1396,1};
	colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
	colorBorder[] = {0,0,0,0};
	colorDisabled[] = {0.2,0.2,0.2,1};
	colorFocused[] = {0.2,0.2,0.2,1};
	colorShadow[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8);
};

class cmf_kosherArsenalTool_textRole: cmf_RscEdit {
	x = safeZoneX + safeZoneW * 0.30875;
	y = safeZoneY + safeZoneH * 0.00444445;
	w = safeZoneW * 0.134375;
	h = safeZoneH * 0.02777778;
	style = ST_CENTER + ST_NO_RECT;
	text = "Role name...";
	autocomplete = "";
	colorBackground[] = {0,0,0,0.5};
	colorDisabled[] = {0.2,0.2,0.2,1};
	colorSelection[] = {1,0,0,1};
	colorText[] = {1,1,1,1};
	sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8);
};

class cmf_kosherArsenalTool_addRole: cmf_RscButton {
	x = safeZoneX + safeZoneW * 0.4425;
	y = safeZoneY + safeZoneH * 0.00444445;
	w = safeZoneW * 0.061875;
	h = safeZoneH * 0.02777778;
	style = ST_CENTER;
	text = "Add Role";
	borderSize = 0;
	colorBackground[] = {0,0,0,0.5};
	colorBackgroundActive[] = {0.702,0.702,0.702,1};
	colorBackgroundDisabled[] = {0.949,0.949,0.949,1};
	colorBorder[] = {0,0,0,0};
	colorDisabled[] = {0.2,0.2,0.2,1};
	colorFocused[] = {0.2,0.2,0.2,1};
	colorShadow[] = {0,0,0,0};
	colorText[] = {1,1,1,1};
	sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8);
};

/*
 * 3den module controls
 */
class cmf_3den_customUnit: cmf_RscControlsGroupNoScrollbars {
    moving = 1;
	x = safeZoneX + safeZoneW * 0.31875;
	y = safeZoneY + safeZoneH * 0.32222223;
	w = safeZoneW * 0.3625;
	h = safeZoneH * 0.35444445;

    class controls {
        class background: cmf_RscText {
			x = 0;
			y = 0;
			w = 0.87878788;
			h = 0.64444446;
			colorBackground[] = {0.2,0.2,0.2,1};
		};

        class toolBar: cmf_RscText {
			x = 0;
			y = 0;
			w = 0.87878788;
			h = 0.04444446;
			text = "Edit: Custom Unit";
			colorBackground[] = {0.6,0.4,0,1};
			colorText[] = {1,1,1,1};
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
		};

        class role_descriptor: cmf_RscText {
			x = 0.05757578;
			y = 0.09267681;
			w = 0.21212122;
			h = 0.06666668;
			style = ST_RIGHT;
			text = "Unit Role:";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
		};

        class lobby_role_descriptor: cmf_RscText {
			x = 0.05757578;
			y = 0.18156569;
			w = 0.21212122;
			h = 0.06666668;
			style = ST_RIGHT;
			text = "Unit Lobby Role:";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
		};

        class group_name_descriptor: cmf_RscText {
			x = 0.05757578;
			y = 0.27045458;
			w = 0.21212122;
			h = 0.06666668;
			style = ST_RIGHT;
			text = "Group Name:";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
		};

        class group_type_descriptor: cmf_RscText {
			x = 0.05757578;
			y = 0.35934346;
			w = 0.21212122;
			h = 0.06666668;
			style = ST_RIGHT;
			text = "Group Type:";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
		};

        class group_size_descriptor: cmf_RscText {
			x = 0.05757578;
			y = 0.44823235;
			w = 0.21212122;
			h = 0.06666668;
			style = ST_RIGHT;
			text = "Group Size:";
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
		};

        class btn_spawn: cmf_RscButton {
            idc = 200;
			x = 0.60303032;
			y = 0.53712123;
			w = 0.21212122;
			h = 0.06666668;
			style = ST_CENTER;
			text = "SPAWN";
			colorBackground[] = {0.102,0.102,0.102,1};
			colorBackgroundActive[] = {0,0.5,0,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
		};

        class btn_cancel: cmf_RscButton {
            idc = 201;
			x = 0.05757578;
			y = 0.53712123;
			w = 0.21212122;
			h = 0.06666668;
			style = ST_CENTER;
			text = "CANCEL";
			colorBackground[] = {0.102,0.102,0.102,1};
			colorBackgroundActive[] = {0.7,0,0,1};
			colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
			colorBorder[] = {0,0,0,0};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorFocused[] = {0.2,0.2,0.2,1};
			colorShadow[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
		};

        class role_input: cmf_RscEdit {
			idc = 100;
			x = 0.30000001;
			y = 0.09267681;
			w = 0.51515152;
			h = 0.06666668;
			text = "RFL";
			colorBackground[] = {0.102,0.102,0.102,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelection[] = {1,0,0,1};
			colorText[] = {1,1,1,1};
		};

        class lobby_role_input: cmf_RscEdit {
			idc = 101;
			x = 0.30000001;
			y = 0.18156569;
			w = 0.51515152;
			h = 0.06666668;
			text = "Rifleman";
			colorBackground[] = {0.102,0.102,0.102,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelection[] = {1,0,0,1};
			colorText[] = {1,1,1,1};
		};

        class group_name_input: cmf_RscEdit {
			idc = 102;
			x = 0.30000001;
			y = 0.27045458;
			w = 0.51515152;
			h = 0.06666668;
			text = "TANGO";
			colorBackground[] = {0.102,0.102,0.102,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelection[] = {1,0,0,1};
			colorText[] = {1,1,1,1};
		};

        class group_size_input: cmf_RscCombo {
			idc = 104;
			x = 0.30000001;
			y = 0.44823235;
			w = 0.51515152;
			h = 0.06666668;
			colorBackground[] = {0.102,0.102,0.102,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {0.302,0.302,0.302,1};
			colorSelectBackground[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
		};

        class group_type_input: cmf_RscCombo {
			idc = 103;
			x = 0.30000001;
			y = 0.35934346;
			w = 0.51515152;
			h = 0.06666668;
			colorBackground[] = {0.102,0.102,0.102,1};
			colorDisabled[] = {0.2,0.2,0.2,1};
			colorSelect[] = {0.302,0.302,0.302,1};
			colorSelectBackground[] = {0,0,0,1};
			colorText[] = {1,1,1,1};
		};
    };
};
