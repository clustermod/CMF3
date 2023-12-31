#include "script_component.hpp"

/* Print a warning if mission is run in singleplayer */
if (is3DENPreview && { !is3DENMultiplayer }) then {
    "CBA_diagnostic_Error" cutRsc ["CBA_diagnostic_Error", "PLAIN"];
    private _control = uiNamespace getVariable "CBA_diagnostic_Error";

    _control ctrlSetStructuredText composeText [
        lineBreak, parseText "<t align='center' size='1.65'>CMF: Singleplayer<\t>", lineBreak, lineBreak,
        "Certain parts of CMF might not work in a singleplayer enviroment. Any testing should be done in a multiplayer enviroment!"
    ];
};