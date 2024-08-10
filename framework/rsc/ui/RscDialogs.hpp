#include "Rsc3DEN.hpp"

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

/* changelog display */ // @TODO: Make it a fixed height instead of variable
class cmf_main_changelogDisplay {
    idd = -1;
    enableDisplay = 1;
    movingEnable = 1;

    class controlsBackground {
        class Disable: cmf_ctrlStaticBackgroundDisable {};
        class DisableTiles: cmf_ctrlStaticBackgroundDisableTiles {};
    };

    class controls {
        class Background: cmf_ctrlStaticBackground {
            x = (getResolution select 2) * 0.5 * pixelW - (190) * GRID_3DEN_W;
            y = 0.5 - (120 - 5) * GRID_3DEN_H;
            w = 375 * GRID_3DEN_W;
            h = 230 * GRID_3DEN_H;
        };

        class BackgroundButtons: cmf_ctrlStaticFooter {
            x = (getResolution select 2) * 0.5 * pixelW - (190) * GRID_3DEN_W;
            y = 0.5 + (120 - 12) * GRID_3DEN_H;
            w = 375 * GRID_3DEN_W;
            h = 7 * GRID_3DEN_H;
        };

        class Title: cmf_ctrlStaticTitle {
            text = "CMF3: Changelog";
            x = (getResolution select 2) * 0.5 * pixelW - (190) * GRID_3DEN_W;
            y = 0.5 - (120 - 5) * GRID_3DEN_H;
            w = 375 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };
        class scrollbar: cmf_RscControlsGroup {
            x = (getResolution select 2) * 0.5 * pixelW - (190 - 2) * GRID_3DEN_W;
            y = 0.5 - (120 - 12) * GRID_3DEN_H;
            w = 371 * GRID_3DEN_W;
            h = 214 * GRID_3DEN_H;
            class controls {
                class changelogText: cmf_ctrlStaticStructuredText {
                    idc = 100;
                    x = 0;
                    y = 0;
                    w = 371 * GRID_3DEN_W;
                    h = 500 * GRID_3DEN_H;
                    colorBackground[] = {0, 0, 0, 0.5};
                };
            };
        };

        class disable: cmf_viewDistance_rscCheckbox {
            idc = 200;
            text = "";
            x = (getResolution select 2) * 0.5 * pixelW - (190 - 2) * GRID_3DEN_W;
            y = 0.5 + (120 - 11) * GRID_3DEN_H;
            w = 5 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
            onCheckedChanged = "profileNamespace setVariable ['cmf_main_changelog_off', _this # 1];";
        };

        class disableLabel: cmf_ctrlStatic {
            text = "Don't show changelog for subsequent versions";
            x = (getResolution select 2) * 0.5 * pixelW - (190 - 2 - 5) * GRID_3DEN_W;
            y = 0.5 + (120 - 11) * GRID_3DEN_H;
            w = 90 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };

        class ButtonOK: cmf_ctrlButtonOK {
            text = "Close";
            x = (getResolution select 2) * 0.5 * pixelW - (190 - 180) * GRID_3DEN_W;
            y = 0.5 + (120 - 11) * GRID_3DEN_H;
            w = 25 * GRID_3DEN_W;
            h = 5 * GRID_3DEN_H;
        };
    };
};

//#include "common_notification.hpp"
#include "viewdistance_menu.hpp"

/* Include diagnostic component UI elements */
#include "RscDiagnostic.hpp"

/* Include 3den Checklist */
#include "RscMissionChecklist.hpp"

/* Include AAR Reader */
#include "RscAfterActionReader.hpp"