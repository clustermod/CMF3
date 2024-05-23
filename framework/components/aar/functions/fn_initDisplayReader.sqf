#include "script_component.hpp"
/*
 * Author: Eric
 * Initializes the reader for AARs
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Config <CONFIG>
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cmf_aar_fnc_initDisplayReader
 *
 * Public: No
 */
params ["_display", ["_config", configNull]];

GVAR(readerCurrentIndex) = 0;

private _scroll = {
    params ["_control"];

    if (count GVAR(reports) isEqualTo 0) exitWith {};

    private _totalReports = count GVAR(reports);
    if (ctrlIDC _control isEqualTo IDC_NEXT) then {
        GVAR(readerCurrentIndex) = (_totalReports - 1) min (GVAR(readerCurrentIndex) + 1);
    } else {
        GVAR(readerCurrentIndex) = 0 max (GVAR(readerCurrentIndex) - 1);
    };

    [QGVAR(onReaderChangePage), []] call CBA_fnc_localEvent;
};

[QGVAR(onSubmitReport), {
    private _display = _thisArgs select 0;
    private _ctrlTitle = _display displayCtrl IDC_TABTITLE;

    private _newTotal = count GVAR(reports);
    _ctrlTitle ctrlSetText format ["After Action Report (%1/%2)", GVAR(readerCurrentIndex) + 1, _newTotal];
}, [_display]] call CBA_fnc_addEventHandlerArgs;

[QGVAR(onReaderChangePage), {
    private _display = _thisArgs select 0;
    private _currentReport = GVAR(reports) select GVAR(readerCurrentIndex);

    _currentReport params ["_authorName", "_mission", "_tactical"];
    _authorName = [_authorName, "Anonymous"] select (_authorName isEqualTo "");
    
    (_display displayCtrl IDC_AUTHOR) ctrlSetText _authorname;
    (_display displayCtrl IDC_MISSION) ctrlSetText _mission;
    (_display displayCtrl IDC_TACTICAL) ctrlSetText _tactical;

    private _total = count GVAR(reports);
    private _ctrlTitle = _display displayCtrl IDC_TABTITLE;
    _ctrlTitle ctrlSetText format ["After Action Report (%1/%2)", GVAR(readerCurrentIndex) + 1, _total];
}, [_display]] call CBA_fnc_addEventHandlerArgs;

private _ctrlNext = _display displayCtrl IDC_NEXT;
private _ctrlPrevious = _display displayCtrl IDC_PREVIOUS;

_ctrlNext ctrlAddEventHandler ["ButtonClick", _scroll];
_ctrlPrevious ctrlAddEventHandler ["ButtonClick", _scroll];

if (count GVAR(reports) > 0) then {
    private _total = count GVAR(reports);
    private _ctrlTitle = _display displayCtrl IDC_TABTITLE;
    _ctrlTitle ctrlSetText format ["After Action Report (%1/%2)", GVAR(readerCurrentIndex) + 1, _total];
    [QGVAR(onReaderChangePage), []] call CBA_fnc_localEvent;
};