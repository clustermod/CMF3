#if __has_include("..\..\components\diagnostic\script_component.hpp")

#include "..\..\components\diagnostic\script_component.hpp"

class CMF_RscLog {
	idd = -1;
	movingEnable = "true";
	onLoad = QUOTE(_this call FUNC(initDisplayLog))
	class ControlsBackground {
		//class BackgroundDisable: ctrlStaticBackgroundDisable {};
		//class BackgroundDisableTiles: ctrlStaticBackgroundDisableTiles {};
		class Background: ctrlStaticBackground {
			x = CUI_GRID_X - RSCDEBUG_W / 2 * CUI_GRID_W;
			y = CUI_GRID_Y - 13 * CUI_GRID_H;
			w = RSCDEBUG_W * CUI_GRID_W;
			h = RSCDEBUG_H * CUI_GRID_H;
		};

		class TitleHeader: ctrlStaticTitle {
			text = "Mission Script Log";
			x = CUI_GRID_X - RSCDEBUG_W / 2 * CUI_GRID_W;
			y = CUI_GRID_Y - 14 * CUI_GRID_H;
			w = RSCDEBUG_W * CUI_GRID_W;
			h = CUI_GRID_H;
		};
	};
	class Controls {
		class Group: ctrlControlsGroup {
			x = CUI_GRID_X - RSCDEBUG_W / 2 * CUI_GRID_W;
			y = CUI_GRID_Y - 13 * CUI_GRID_H;
			w = RSCDEBUG_W * CUI_GRID_W;
			h = RSCDEBUG_H * CUI_GRID_H - CUI_GRID_H - 3/5 * CUI_GRID_H;
			class Controls {
				class Content: ctrlStructuredText {
					idc = IDC_LOG_TEXT;
					text = "";
					x = 0;
					y = 0;
					w = (RSCDEBUG_W - 0.2) * CUI_GRID_W;
					h = RSCDEBUG_H - 2.2 * CUI_GRID_H;
					style = ST_NO_RECT + ST_MULTI;
					canModify = 0;
					size = 0.7 * CUI_GRID_H;
					shadow = 0;
					colorBackground[] = {0,0,0,0.8};
					class Attributes {
						font = "EtelkaMonospacePro";
					};
				};
			};
		};

		class Close: ctrlButtonClose {
			x = CUI_GRID_X + RSCDEBUG_W / 2 * CUI_GRID_W - 5.2 * CUI_GRID_W;
			y = CUI_GRID_Y + RSCDEBUG_H * CUI_GRID_H - 14.2 * CUI_GRID_H;
			w = 5 * CUI_GRID_W;
			h = CUI_GRID_H;
		};

		class Clear: ctrlButton {
			idc = IDC_LOG_CLEAR;
			text = "CLEAR";
			tooltip = "Clear / Flush log";
			x = CUI_GRID_X + RSCDEBUG_W / 2 * CUI_GRID_W - 10.4 * CUI_GRID_W;
			y = CUI_GRID_Y + RSCDEBUG_H * CUI_GRID_H - 14.2 * CUI_GRID_H;
			w = 5 * CUI_GRID_W;
			h = CUI_GRID_H;
		};
	};
};

#endif