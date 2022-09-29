class BTN_ToggleResize {
  onLoad="if (profileNamespace getVariable ['EMF_RMM_Enabled', true]) then {(_this select 0) ctrlSetTextColor [1, 1, 1, 1]} else {(_this select 0) ctrlSetTextColor [0.5, 0.5, 0.5, 1]};";
  type = 1;
  idc = 9005;
  x = safeZoneX + safeZoneW * 0.89;
  y = safeZoneY + safeZoneH * 0.05333334;
  w = safeZoneW * 0.09;
  h = safeZoneH * 0.02;
  style = 0;
  text = "Toggle Consistent Marker size";
  borderSize = 0;
  colorBackground[] = {0.123,0.123,0.123,0.5};
  colorBackgroundActive[] = {0.5902,0.5902,0.5902,0.5};
  colorBackgroundDisabled[] = {0.2,0.2,0.2,1};
  colorBorder[] = {0,0,0,0};
  colorDisabled[] = {0.2,0.2,0.2,1};
  colorFocused[] = {0.2,0.2,0.2,1};
  colorShadow[] = {0,0,0,1};
  colorText[] = {1,1,1,1};
  font = "PuristaMedium";
  offsetPressedX = 0;
  offsetPressedY = 0;
  offsetX = 0;
  offsetY = 0;
  sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65);
  soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1.0};
  soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1.0};
  soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1.0};
  soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1.0};
  onButtonClick = "profileNamespace setVariable ['EMF_RMM_Enabled', !(profileNamespace getVariable ['EMF_RMM_Enabled', false])]; if (profileNamespace getVariable ['EMF_RMM_Enabled', true]) then {(_this select 0) ctrlSetTextColor [1, 1, 1, 1]} else {(_this select 0) ctrlSetTextColor [0.5, 0.5, 0.5, 1]};";

};

class EDT_MarkerSize {
  onLoad="(_this select 0) sliderSetPosition (profileNamespace getVariable ['EMF_RMM_SIZE', 0.2]);";
  type = 43;
  idc = 9006;
  x = safeZoneX + safeZoneW * 0.89;
  y = safeZoneY + safeZoneH * 0.09;
  w = safeZoneW * 0.09;
  h = safeZoneH * 0.015;
  style = 1024;
  arrowEmpty = "\A3\ui_f\data\GUI\Cfg\Slider\arrowEmpty_ca.paa";
  arrowFull = "\A3\ui_f\data\GUI\Cfg\Slider\arrowFull_ca.paa";
  border = "\A3\ui_f\data\GUI\Cfg\Slider\border_ca.paa";
  color[] = {1,1,1,1};
  colorActive[] = {1,1,1,1};
  thumb = "\A3\ui_f\data\GUI\Cfg\Slider\thumb_ca.paa";
  onSliderPosChanged = "profileNamespace setVariable ['EMF_RMM_SIZE', (_this select 1)];";
  sliderPosition = 0.2;
  sliderRange[] = {0.05,2};
  sliderStep = 0.001;
  lineSize = 0.05;
};

class ST_MarkerSizeText {
  type = 0;
  idc = 0;
  x = safeZoneX + safeZoneW * 0.89;
  y = safeZoneY + safeZoneH * 0.067;
  w = safeZoneW * 0.09;
  h = safeZoneH * 0.03;
  style = 2;
  text = "Marker Size";
  colorBackground[] = {1,1,1,0};
  colorText[] = {1,1,1,1};
  font = "PuristaMedium";
  sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7);
};

class emf_arsenalForceCloseButton {
  access = 0;
  idc = 2055;
  style = "0x02 + 0x40 + 0x80";
  text = "FORCE CLOSE";
  tooltip = "Force closes kosher arsenal (This will strip you naked)";
  type = 1;
  w = "(((safezoneW - 2 * (93 * (pixelW * pixelGridNoUIScale * 0.25))) - 6 * ((safezoneW - 2 * (93 * (pixelW * pixelGridNoUIScale * 0.25))) / 100)) / 5)";
  h = "7 * (pixelH * pixelGridNoUIScale * 0.25)";
  x = "4 * ((safezoneW - 2 * (93 * (pixelW * pixelGridNoUIScale * 0.25))) / 100) + 3 * (((safezoneW - 2 * (93 * (pixelW * pixelGridNoUIScale * 0.25))) - 6 * ((safezoneW - 2 * (93 * (pixelW * pixelGridNoUIScale * 0.25))) / 100)) / 5)";
  y = "0";
  blinkingPeriod = 0;
  borderSize = 0;
  colorBackground[] = {0.85,0,0,0.8};
  colorBackgroundActive[] = {0.95,0,0,1};
  colorBackgroundDisabled[] = {0,0,0,0.5};
  colorBorder[] = {0,0,0,0};
  colorDisabled[] = {1,1,1,0.25};
  colorFocused[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",1};
  colorShadow[] = {0,0,0,0};
  colorText[] = {1,1,1,1};
  default = 0;
  deletable = 0;
  fade = 0;
  font = "PuristaLight";
  offsetPressedX = "pixelW";
  offsetPressedY = "pixelH";
  offsetX = 0;
  offsetY = 0;
  onButtonClick = "[] spawn{private _result = ['Are you sure? This will delete your current loadout.', 'Confirm', true, true, (findDisplay 1127001)] call BIS_fnc_guiMessage; if (_result) then {[player] execVM 'functions\kosherArsenal\fn_forceClose.sqf'}};";
  onButtonDown = "";
  onButtonUp = "";
  onCanDestroy = "";
  onDestroy = "";
  onKeyDown = "";
  onKeyUp = "";
  onKillFocus = "";
  onMouseButtonClick = "";
  onMouseButtonDblClick = "";
  onMouseButtonDown = "";
  onMouseButtonUp = "";
  onMouseEnter = "";
  onMouseExit = "";
  onMouseHolding = "";
  onMouseMoving = "";
  onMouseZChanged = "";
  onSetFocus = "";
  period = 0;
  periodFocus = 2;
  periodOver = 0.5;
  shadow = 1;
  shortcuts[] = {"0x0E"};
  show = 1;
  sizeEx = "5 * (pixelH * pixelGridNoUIScale * 0.25)";
  soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
  soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
  soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
  soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
  tooltipColorBox[] = {0,0,0,0};
  tooltipColorShade[] = {0,0,0,1};
  tooltipColorText[] = {1,1,1,1};
  tooltipMaxWidth = 0.5;
  class Scrollbar {
    arrowEmpty = "\a3\3DEN\Data\Controls\ctrlDefault\arrowEmpty_ca.paa";
    arrowFull = "\a3\3DEN\Data\Controls\ctrlDefault\arrowFull_ca.paa";
    border = "\a3\3DEN\Data\Controls\ctrlDefault\border_ca.paa";
    color[] = {1,1,1,1};
    height = 0;
    scrollSpeed = 0.06;
    thumb = "\a3\3DEN\Data\Controls\ctrlDefault\thumb_ca.paa";
    width = 0;
  };
}
