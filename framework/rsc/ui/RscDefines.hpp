/*
 * Custom defines for CMF
 */

// Control types
#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_EDIT             2
#define CT_SLIDER           3
#define CT_COMBO            4
#define CT_LISTBOX          5
#define CT_TOOLBOX          6
#define CT_CHECKBOXES       7
#define CT_PROGRESS         8
#define CT_HTML             9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT       11
#define CT_TREE             12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU     14
#define CT_CONTROLS_GROUP   15
#define CT_SHORTCUTBUTTON   16
#define CT_XKEYDESC         40
#define CT_XBUTTON          41
#define CT_XLISTBOX         42
#define CT_XSLIDER          43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT           80
#define CT_OBJECT_ZOOM      81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK        98
#define CT_USER             99
#define CT_MAP              100
#define CT_MAP_MAIN         101
#define CT_LISTNBOX         102

// Static styles
#define ST_POS            0x0F
#define ST_HPOS           0x03
#define ST_VPOS           0x0C
#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_VCENTER        0x0C
#define ST_GROUP_BOX       96
#define ST_GROUP_BOX2      112
#define ST_ROUNDED_CORNER  ST_GROUP_BOX + ST_CENTER
#define ST_ROUNDED_CORNER2 ST_GROUP_BOX2 + ST_CENTER

#define ST_TYPE           0xF0
#define ST_SINGLE         0x00
#define ST_MULTI          0x10
#define ST_TITLE_BAR      0x20
#define ST_PICTURE        0x30
#define ST_FRAME          0x40
#define ST_BACKGROUND     0x50
#define ST_GROUP_BOX      0x60
#define ST_GROUP_BOX2     0x70
#define ST_HUD_BACKGROUND 0x80
#define ST_TILE_PICTURE   0x90
#define ST_WITH_RECT      0xA0
#define ST_LINE           0xB0

#define ST_SHADOW         0x100
#define ST_NO_RECT        0x200
#define ST_KEEP_ASPECT_RATIO  0x800

#define ST_TITLE          ST_TITLE_BAR + ST_CENTER

// Slider styles
#define SL_DIR            0x400
#define SL_VERT           0
#define SL_HORZ           0x400

#define SL_TEXTURES       0x10

// progress bar
#define ST_VERTICAL       0x01
#define ST_HORIZONTAL     0

// Listbox styles
#define LB_TEXTURES       0x10
#define LB_MULTI          0x20

// Tree styles
#define TR_SHOWROOT       1
#define TR_AUTOCOLLAPSE   2

// MessageBox styles
#define MB_BUTTON_OK      1
#define MB_BUTTON_CANCEL  2
#define MB_BUTTON_USER    4

class cmf_ScrollBar {
	color[] = {1,1,1,1};
	colorActive[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.3};
	thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
	arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
	arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
	border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
	shadow = 0;
	scrollSpeed = 0.06;
	width = 0;
	height = 0;
	autoScrollEnabled = 0;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
};

class cmf_RscSlider {
	access = 0;
	type = 43;
    idc = -1;
	style = 1024;
	color[] = {1, 1, 1, 0.8};
	colorActive[] = {1, 1, 1, 1};
	shadow = 0;
	h = 0.025;
    arrowEmpty = "\A3\ui_f\data\GUI\Cfg\Slider\arrowEmpty_ca.paa";
    arrowFull = "\A3\ui_f\data\GUI\Cfg\Slider\arrowFull_ca.paa";
    border = "\A3\ui_f\data\GUI\Cfg\Slider\border_ca.paa";
    thumb = "\A3\ui_f\data\GUI\Cfg\Slider\thumb_ca.paa";
};

class cmf_RscText {
	access = 0;
	type = 0;
	idc = -1;
	style = 0;
	colorBackground[] = { 1, 1, 1, 0.3 };
	colorText[] = {1, 1, 1, 0.5};
	text = "";
	fixedWidth = 0;
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	shadow = 1;
	colorShadow[] = {0, 0, 0, 0.5};
	font = "PuristaMedium";
	SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	linespacing = 1;
};

class cmf_RscEdit {
	access = 0;
	type = 2;
	idc = -1;
	style = 0;
	colorBackground[] = {0, 0, 0, 1};
	colorText[] = {0.95, 0.95, 0.95, 1};
	text = "";
	x = 0;
	y = 0;
	h = 0.04;
	w = 0.2;
	colorSelection[] = {
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",
		1
	};
	autocomplete = "";
	size = 0.2;
	font = "PuristaMedium";
	shadow = 2;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	colorDisabled[] = {1, 1, 1, 0.25};
	canModify = 1;
};

class cmf_RscButton {
	access = 0;
	type = 1;
    style = 2;
    idc = -1;
    shadow = 0;
    text = "";
    font = "PuristaMedium";
    sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    offsetX = 0;
    offsetY = 0;
    offsetPressedX = 0;
    offsetPressedY = 0;
    borderSize = 0;
	colorText[] = {1, 1, 1, 1};
	colorDisabled[] = {0.4, 0.4, 0.4, 1};
    colorShadow[] = {0, 0, 0, 0};
    colorBorder[] = {0, 0, 0, 1};
	colorBackground[] = {
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",
		0.7
	};
	colorBackgroundDisabled[] = {0.95, 0.95, 0.95, 1};
	colorBackgroundActive[] = {
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",
		1
	};
	colorFocused[] = {
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])",
		1
	};
	soundEnter[] = {"\A3\ui_f\data\sound\onover", 0.09, 1};
	soundPush[] = {"\A3\ui_f\data\sound\new1", 0, 0};
	soundClick[] = {"\A3\ui_f\data\sound\onclick", 0.07, 1};
	soundEscape[] = {"\A3\ui_f\data\sound\onescape", 0.09, 1};
};

class cmf_RscPicture {
	access = 0;
	type = 0;
	idc = -1;
	style = 48;
	colorBackground[] = {0, 0, 0, 0};
	colorText[] = {1, 1, 1, 1};
	font = "TahomaB";
	sizeEx = 0;
	lineSpacing = 0;
	text = "";
	fixedWidth = 0;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.2;
	h = 0.15;
};

class cmf_RscCombo {
	access = 0;
	type = 4;
	idc = -1;
	style = 16;
	colorSelect[] = {0, 0, 0, 1};
	colorText[] = {0.95, 0.95, 0.95, 1};
	colorBackground[] = {0, 0, 0, 1};
	colorScrollbar[] = {1, 0, 0, 1};
	soundSelect[] = {"", 0.1, 1};
	soundExpand[] = {"", 0.1, 1};
	soundCollapse[] = {"", 0.1, 1};
	maxHistoryDelay = 1;
	class ComboScrollBar: cmf_ScrollBar {
		color[] = {1,1,1,1};
	};
	x = 0;
	y = 0;
	w = 0.12;
	h = 0.035;
	shadow = 0;
	colorSelectBackground[] = {1, 1, 1, 0.7};
	arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa";
	arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
	wholeHeight = 0.3;
	color[] = {1, 1, 1, 1};
	colorActive[] = {1, 0, 0, 1};
	colorDisabled[] = {1, 1, 1, 0.25};
	font = "PuristaMedium";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};

class cmf_RscControlsGroup {
	type = CT_CONTROLS_GROUP;
	idc = -1;
	x = 0;
	y = 0;
	w = 1;
	h = 1;
	deletable = 0;
	fade = 0;
	shadow = 0;
	style = ST_MULTI;
	class VScrollbar: cmf_ScrollBar {
		color[] = {1,1,1,1};
		width = 0.021;
		autoScrollEnabled = 1;
	};
	class HScrollbar: cmf_ScrollBar {
		color[] = {1,1,1,1};
		height = 0.028;
	};
	class Controls {};
};

class cmf_RscControlsGroupNoScrollbars: cmf_RscControlsGroup {
	class VScrollbar: VScrollbar {
		width = 0;
	};
	class HScrollbar: HScrollbar {
		height = 0;
	};
};

/////////////////////////////////////////////////// 3DEN Classes ////////////////////////////////////////////////////////////
// \a3\3den\config.cpp

#define GRID_3DEN_W (pixelW * pixelGrid * 0.5)
#define GRID_3DEN_H (pixelH * pixelGrid * 0.5)

class cmf_ctrlDefault {
	access = 0;
	idc = -1;
	style = 0;
	default = 0;
	show = 1;
	fade = 0;
	blinkingPeriod = 0;
	deletable = 0;
	x = 0;
	y = 0;
	w = 0;
	h = 0;
	tooltip = "";
	tooltipMaxWidth = 0.5;
	tooltipColorShade[] = {0,0,0,1};
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {0,0,0,0};
	class ScrollBar {
		width = 0;
		height = 0;
		scrollSpeed = 0.06;
		arrowEmpty = "\a3\3DEN\Data\Controls\ctrlDefault\arrowEmpty_ca.paa";
		arrowFull = "\a3\3DEN\Data\Controls\ctrlDefault\arrowFull_ca.paa";
		border = "\a3\3DEN\Data\Controls\ctrlDefault\border_ca.paa";
		thumb = "\a3\3DEN\Data\Controls\ctrlDefault\thumb_ca.paa";
		color[] = {1,1,1,1};
	};
};

class cmf_ctrlDefaultText: cmf_ctrlDefault {
	sizeEx = "4.32 * (1 / (getResolution select 3)) * pixelGrid * 0.5";
	font = "RobotoCondensedLight";
	shadow = 1;
};

class cmf_ctrlDefaultButton: cmf_ctrlDefaultText {
	soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
	soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
	soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
};

class cmf_ctrlStatic: cmf_ctrlDefaultText {
	type = 0;
	colorBackground[] = {0,0,0,0};
	text = "";
	lineSpacing = 1;
	fixedWidth = 0;
	colorText[] = {1,1,1,1};
	colorShadow[] = {0,0,0,1};
	moving = 0;
	autoplay = 0;
	loops = 0;
	tileW = 1;
	tileH = 1;
	onCanDestroy = "";
	onDestroy = "";
	onMouseEnter = "";
	onMouseExit = "";
	onSetFocus = "";
	onKillFocus = "";
	onKeyDown = "";
	onKeyUp = "";
	onMouseButtonDown = "";
	onMouseButtonUp = "";
	onMouseButtonClick = "";
	onMouseButtonDblClick = "";
	onMouseZChanged = "";
	onMouseMoving = "";
	onMouseHolding = "";
	onVideoStopped = "";
};

class cmf_ctrlButton: cmf_ctrlDefaultButton {
	type = 1;
	style = "0x02 + 0xC0";
	colorBackground[] = {0,0,0,1};
	colorBackgroundDisabled[] = {0,0,0,0.5};
	colorBackgroundActive[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",1};
	colorFocused[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",1};
	font = "PuristaLight";
	text = "";
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};
	borderSize = 0;
	colorBorder[] = {0,0,0,0};
	colorShadow[] = {0,0,0,0};
	offsetX = 0;
	offsetY = 0;
	offsetPressedX = "pixelW";
	offsetPressedY = "pixelH";
	period = 0;
	periodFocus = 2;
	periodOver = 0.5;
	class KeyHints {
		class A {
			key = "0x00050000 + 0";
			hint = "KEY_XBOX_A";
		};
	};
	onCanDestroy = "";
	onDestroy = "";
	onMouseEnter = "";
	onMouseExit = "";
	onSetFocus = "";
	onKillFocus = "";
	onKeyDown = "";
	onKeyUp = "";
	onMouseButtonDown = "";
	onMouseButtonUp = "";
	onMouseButtonClick = "";
	onMouseButtonDblClick = "";
	onMouseZChanged = "";
	onMouseMoving = "";
	onMouseHolding = "";
	onButtonClick = "";
	onButtonDown = "";
	onButtonUp = "";
};

class cmf_ctrlEdit: cmf_ctrlDefaultText {
	type = 2;
	colorBackground[] = {0,0,0,0.5};
	text = "";
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};
	colorSelection[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",1};
	canModify = 1;
	autocomplete = "";
	onCanDestroy = "";
	onDestroy = "";
	onSetFocus = "";
	onKillFocus = "";
	onKeyDown = "";
	onKeyUp = "";
	onMouseButtonDown = "";
	onMouseButtonUp = "";
	onMouseButtonClick = "";
	onMouseButtonDblClick = "";
	onMouseZChanged = "";
	onMouseMoving = "";
	onMouseHolding = "";
};

class cmf_ctrlCombo: cmf_ctrlDefaultText {
	type = 4;
	style = "0x00 + 0x10 + 0x200";
	colorBackground[] = {0.05,0.05,0.05,1};
	colorSelectBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",1};
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};
	colorSelect[] = {0,0,0,1};
	colorTextRight[] = {1,1,1,1};
	colorSelectRight[] = {1,1,1,0.25};
	colorSelect2Right[] = {1,1,1,1};
	colorPicture[] = {1,1,1,1};
	colorPictureSelected[] = {1,1,1,1};
	colorPictureDisabled[] = {1,1,1,0.25};
	colorPictureRight[] = {1,1,1,1};
	colorPictureRightSelected[] = {1,1,1,1};
	colorPictureRightDisabled[] = {1,1,1,0.25};
	arrowEmpty = "\a3\3DEN\Data\Controls\ctrlCombo\arrowEmpty_ca.paa";
	arrowFull = "\a3\3DEN\Data\Controls\ctrlCombo\arrowFull_ca.paa";
	wholeHeight = "12 * 	5 * (pixelH * pixelGrid * 	0.50)";
	maxHistoryDelay = 1;
	soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1};
	soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1};
	soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1};
	class ComboScrollBar {
		width = 0;
		height = 0;
		scrollSpeed = 0.01;
		arrowEmpty = "\a3\3DEN\Data\Controls\ctrlDefault\arrowEmpty_ca.paa";
		arrowFull = "\a3\3DEN\Data\Controls\ctrlDefault\arrowFull_ca.paa";
		border = "\a3\3DEN\Data\Controls\ctrlDefault\border_ca.paa";
		thumb = "\a3\3DEN\Data\Controls\ctrlDefault\thumb_ca.paa";
		color[] = {1,1,1,1};
	};
	onCanDestroy = "";
	onDestroy = "";
	onSetFocus = "";
	onKillFocus = "";
	onKeyDown = "";
	onKeyUp = "";
	onMouseButtonDown = "";
	onMouseButtonUp = "";
	onMouseButtonClick = "";
	onMouseButtonDblClick = "";
	onMouseZChanged = "";
	onMouseMoving = "";
	onMouseHolding = "";
	onLBSelChanged = "";
};

class cmf_ctrlStaticBackgroundDisable: cmf_ctrlStatic {
	x = -4;
	y = -2;
	w = 8;
	h = 4;
	colorBackground[] = {1,1,1,0.5};
};

class cmf_ctrlStaticBackground: cmf_ctrlStatic {
	colorBackground[] = {0.2,0.2,0.2,1};
};

class cmf_ctrlStaticPictureTile: cmf_ctrlStatic {
	style = 144;
};

class cmf_ctrlStaticFooter: cmf_ctrlStatic {
	colorBackground[] = {0,0,0,0.3};
};

class cmf_ctrlStaticTitle: cmf_ctrlStatic {
	moving = 1;
	colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",1};
	colorText[] = {1,1,1,1};
};

class cmf_ctrlStaticBackgroundDisableTiles: cmf_ctrlStaticPictureTile {
	x = -4;
	y = -2;
	w = 8;
	h = 4;
	text = "\a3\3DEN\Data\Displays\Display3DENEditAttributes\backgroundDisable_ca.paa";
	tileW = "8 / (32 * pixelW)";
	tileH = "4 / (32 * pixelH)";
	colorText[] = {1,1,1,0.05};
};

class cmf_ctrlButtonOK: cmf_ctrlButton {
	default = 1;
	idc = 1;
	text = "OK";
};

class cmf_ctrlButtonCancel: cmf_ctrlButton {
	idc = 2;
	text = "CANCEL";
};

/////////////////////////////////// Viewdistance defines ////////////////////////////////////////////
#define GUI_GRID_X (0)
#define GUI_GRID_Y (0)
#define GUI_GRID_W (0.025)
#define GUI_GRID_H (0.04)
#define GUI_GRID_WAbs (1)
#define GUI_GRID_HAbs (1)

class  cmf_viewDistance_rscXSliderH {
	style = "0x400	+ 0x10";
	shadow = 0;
	x = 0;
	y = 0;
	h = 0.029412;
	w = 0.40000001;
	color[] = {1,1,1,0.60000002};
	colorActive[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.2};
	arrowEmpty = "\A3\ui_f\data\gui\cfg\slider\arrowEmpty_ca.paa";
	arrowFull = "\A3\ui_f\data\gui\cfg\slider\arrowFull_ca.paa";
	border = "\A3\ui_f\data\gui\cfg\slider\border_ca.paa";
	thumb = "\A3\ui_f\data\gui\cfg\slider\thumb_ca.paa";
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.64999998};
};

class  cmf_viewDistance_rscCheckbox {
	type = 77;
	style = 0;
	checked = 0;
	x = "0.375 * safezoneW + safezoneX";
	y = "0.36 * safezoneH + safezoneY";
	w = "0.025 * safezoneW";
	h = "0.04 * safezoneH";
	color[] = {1,1,1,0.69999999};
	colorFocused[] = {1,1,1,1};
	colorHover[] = {1,1,1,1};
	colorPressed[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.2};
	colorBackground[] = {0,0,0,0};
	colorBackgroundFocused[] = {0,0,0,0};
	colorBackgroundHover[] = {0,0,0,0};
	colorBackgroundPressed[] = {0,0,0,0};
	colorBackgroundDisabled[] = {0,0,0,0};
	textureChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	textureFocusedChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureFocusedUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	textureHoverChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureHoverUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	texturePressedChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	texturePressedUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	textureDisabledChecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_checked_ca.paa";
	textureDisabledUnchecked = "\A3\Ui_f\data\GUI\RscCommon\RscCheckBox\CheckBox_unchecked_ca.paa";
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.64999998};
	soundEnter[] = {"", 0.1, 1};
	soundPush[] = {"", 0.1, 1};
	soundClick[] = {"", 0.1, 1};
	soundEscape[] = {"", 0.1, 1};
};

class  cmf_viewDistance_rscButton {
	type = 16;
	style = "0x02 + 0xC0";
	default = 0;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.095588997;
	h = 0.039216001;
	animTextureNormal = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDisabled = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureOver = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
	animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";
	animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";
	colorBackground[] = {0,0,0,0.80000001};
	colorBackgroundFocused[] = {1,1,1,1};
	colorBackground2[] = {0.75,0.75,0.75,1};
	color[] = {1,1,1,1};
	colorFocused[] = {0,0,0,1};
	color2[] = {0,0,0,1};
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,0.25};
	period = 1.2;
	periodFocus = 1.2;
	periodOver = 1.2;
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.64999998};
	font = "PuristaLight";
	class TextPos {
		left = "0.25 * (((safezoneW / safezoneH) min 1.2) / 40)";
		top = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) - (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)) / 2";
		right = 0.0049999999;
		bottom = 0;
	};

	class Attributes {
		font = "PuristaLight";
		color = "#E5E5E5";
		align = "left";
		shadow = "false";
	};

	class ShortcutPos {
		left = "(6.25 * (((safezoneW / safezoneH) min 1.2) / 40)) - 0.0225 - 0.005";
		top = 0.0049999999;
		w = 0.022500001;
		h = 0.029999999;
	};

	soundEnter[] = {
		"\A3\ui_f\data\sound\RscButtonMenu\soundEnter",
		0.090000004,
		1
	};
	soundPush[] = {
		"\A3\ui_f\data\sound\RscButtonMenu\soundPush",
		0.090000004,
		1
	};
	soundClick[] = {
		"\A3\ui_f\data\sound\RscButtonMenu\soundClick",
		0.090000004,
		1
	};
	soundEscape[] = {
		"\A3\ui_f\data\sound\RscButtonMenu\soundEscape",
		0.090000004,
		1
	};
	textureNoShortcut = "#(argb,8,8,3)color(0,0,0,0)";
	class HitZone {
		left = 0;
		top = 0;
		right = 0;
		bottom = 0;
	};

	class AttributesImage {
		font = "PuristaMedium";
		color = "#E5E5E5";
		align = "left";
	};
};

class  cmf_viewDistance_rscText {
	type = 0;
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.30000001;
	style = 0;
	shadow = 0;
	colorShadow[] = {0,0,0,0.5};
	font = "PuristaMedium";
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,0};
	linespacing = 1;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.64999998};
	text = "";
};

class  cmf_viewDistance_rscTextRight {
	type = 0;
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.30000001;
	style = 0x01;
	shadow = 0;
	colorShadow[] = {0,0,0,0.5};
	font = "PuristaMedium";
	size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,0};
	linespacing = 1;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.64999998};
	text = "";
};

class  cmf_viewDistance_rscFrame {
	type = 0;
	idc = -1;
	style = 0;
	shadow = 1;
	colorBackground[] = {0, 0, 0, 0};
	colorText[] = {1, 1, 1, 1};
	font = "PuristaMedium";
	sizeEx = 0.02;
	text = "";
};

class  cmf_viewDistance_rscXListBox {
	deletable = 0;
	fade = 0;
	idc = -1;
	type = 42;
	x = 0.1;
	y = 0.1;
	color[] = {1, 1, 1, 0.6};
	colorActive[] = {1, 1, 1, 1};
	colorDisabled[] = {1, 1, 1, 0.25};
	colorSelect[] = {0.95, 0.95, 0.95, 1};
	colorText[] = {1, 1, 1, 1};
	soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect", 0.09, 1};
	colorPicture[] = {1, 1, 1, 1};
	colorPictureSelected[] = {1, 1, 1, 1};
	colorPictudeDisabled[] = {1, 1, 1, 0.25};
	tooltipColorText[] = {1, 1, 1, 1};
	tooltipColorBox[] = {1, 1, 1, 1};
	tooltipColorShade[] = {0, 0, 0, 0.65};
	style = "0x400 + 0x02 +	0x10";
	shadow = 2;
	arrowEmpty = "\A3\ui_f\data\gui\cfg\slider\arrowEmpty_ca.paa";
	arrowFull = "\A3\ui_f\data\gui\cfg\slider\arrowFull_ca.paa";
	border = "\A3\ui_f\data\gui\cfg\slider\border_ca.paa";
	w = 0.14706;
	h = 0.039216;
	font = "PuristaMedium";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	colorPictureDisabled[] = {1, 1, 1, 1};
};

class  cmf_viewDistance_rscEdit {
	type = 2;
	style = "0x40";
	autocomplete = "";
	font = "PuristaMedium";
	shadow = 2;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	colorBackground[] = {0,0,0,1};
	colorText[] = {0.94999999,0.94999999,0.94999999,1};
	colorDisabled[] = {1,1,1,0.25};
	colorSelection[] = {
		"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])",
		"(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])",
		1
	};
	canModify = 1;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.64999998};
	text = "";
};
