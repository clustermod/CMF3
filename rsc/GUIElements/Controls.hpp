class BTN_ToggleResize
{
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

class EDT_MarkerSize
{
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
  sliderStep = 0.05;
  lineSize = 0.05;
};

class ST_MarkerSizeText
{
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
