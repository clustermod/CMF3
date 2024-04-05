#include "script_component.hpp"
/*
 * Author: Eric
 * Draws route between two points on the map following roads. Should be used as event
 * 
 * Arguments:
 * 0: startPos <ARRAY>
 * 1: endPos <ARRAY>
 * 2: Color (optional, default: "ColorRed") <STRING>
 * 3: Style (optional, default "dotted") <STRING>
 * 4: Name (optional) <STRING>
 * 5: textPos (optional, default: 0.5) <NUMBER>
 * 6: Text Effects <ARRAY>
 *	- 0: Text Size (optional, default: 0.5) <NUMBER>
 *	- 1: Text Offset (optional, default: 15) <NUMBER>
 *	- 2: Text Color (optional, default: Color) <STRING>
 *	- 3: Text Alpha (optional, default: 1) <NUMBER>
 * 
 * Return Value:
 * Marker composition <ARRAY>
 * 
 * Example:
 * [pos1, pos2, "MSR CHARLIE"] call cmf_map_fnc_drawRoute
 * 
 * Public: No
 */

_this spawn {
    params ["_startPos", "_endPos", ["_color", "ColorRed"], ["_style", "dots"], ["_name", ""], ["_textPos", 0.5], ["_textEffect", []]];
    private _start = diag_tickTime;

    /* Create Road map */
    private _roadMap = [];
    private _nextRoads = [];
    private _finishedRoads = [];
    private _firstRoad = [_startPos, 100] call BIS_fnc_nearestRoad;
    _nextRoads pushBack _firstRoad;
        
    private _iterationCounter = 0;
    while { count _nextRoads > 0 && { _iterationCounter < 1000 } } do {
        private _nextRoad = _nextRoads deleteAt 0;
        private _connectedRoads = roadsConnectedTo [_nextRoad, true];
        
        {
            private _distance = _x distance _nextRoad;
            _roadMap pushBack [_nextRoad, _x, _distance];
            
            if ((_finishedRoads find _x) isEqualTo -1) then {
                _nextRoads pushBack _x;
            };
            
        } foreach _connectedRoads;
        
        _finishedRoads pushBack _nextRoad;
        _iterationCounter = _iterationCounter + 1;
    };

    LOG_1("RoadMap: %1",_roadMap);
    
    /* Run A* Algorithm */
    private _startRoad = [_startPos, 100] call BIS_fnc_nearestRoad;
    private _destinationRoad = [_endPos, 100] call BIS_fnc_nearestRoad;
    LOG(str _startRoad);

    private _distanceArray = [];
    private _workQueue = [];

    _distanceArray pushBack [_startRoad, 0, objNull];
    LOG(str _distanceArray);

    private _visitedRoads = [];
    _visitedRoads pushBack _startRoad;
    _workQueue pushBack [0, _startRoad];

    _iterationCounter = 0;
    private _targetReached = false;
    while { count _workQueue > 0 && { _iterationCounter < 10000 && { !_targetReached } } } do {
        private _workItem = _workQueue deleteAt 0;
        private _actualRoad = _workItem select 1;
        if (_actualRoad isEqualTo _destinationRoad) then { _targetReached = true };
        
        private _connRoads = _roadMap select { (_x select 0) isEqualTo _actualRoad && { !((_x select 1) in _visitedRoads) } };
        {
            private _road = _x select 0;
            private _connRoad = _x select 1;
            private _connDistance = _x select 2;
            
            _visitedRoads pushBack _connRoad;
            
            /* Find Parent in Distance Array */
            private _parent = _distanceArray select {(_x select 0 IsEqualTo _road)} select 0;
            private _parentDistance = _parent select 1;
            private _heuretic = _connRoad distance _destinationRoad;
            
            private _roadDistance = _connDistance + _parentDistance + _heuretic;
            
            _distanceArray pushBack [_connRoad, _roadDistance, _road];
            _workQueue pushBack [_roadDistance, _connRoad];
            
        } foreach _connRoads;
        
        _iterationCounter = _iterationCounter + 1;
        if (count _workQueue  > 0) then { _workQueue sort true };
    };

    /* Find shortest path */
    private _destinationPath = [];
    private _destinationLength = 0;

    private _startNode = _distanceArray select 0;
    private _selectedNode = (_distanceArray select { _x select 0 isEqualTo _destinationRoad }) select 0;
    private _destinationLength = _selectedNode select 1;

    if (isNil "_selectedNode") exitWith { systemChat "unable to calculate route" };

    LOG_3("StartNode: %1, SelectNode: %2, DestinationLength: %3",_startNode,_selectedNode,_destinationLength);

    /* Get path */
    while { !(_selectedNode isEqualTo _startNode) } do {
        private _nodeRoad = _selectedNode select 0;
        _destinationPath pushBack _nodeRoad;
        private _nodeParent = _selectedNode select 2;
        
        _selectedNode = (_distanceArray select { _x select 0 isEqualTo _nodeParent }) select 0;
    };

    _destinationPath pushBack (_startNode select 0);

    /* Create route marker */
    _destinationPath = (_destinationPath apply { getPosATL _x });
    reverse _destinationPath; // The start and end position is reversed
    switch (toUpper _style) do {
        case "DOTS": {
            {
                private "_marker";
                for "_y" from 1 to 9001 do {
                    _marker = format [QGVAR(markerID_%1), str _y];
                    if (markerShape _marker isEqualTo "") exitWith {};
                };

                createMarkerLocal [_marker, _x];
                _marker setMarkerShapeLocal "ICON";
                _marker setMarkerTypeLocal "hd_dot";
                _marker setMarkerColorLocal _color;
            } forEach _destinationPath;
        };
        case "BORDER": {
            private _pathSize = count _destinationPath - 1;
            private _textStartPos = floor (_pathSize * _textPos);
            private _textEndPos = (floor (_pathSize * _textPos) + 1) min _pathSize;

            _textEffect params [["_textSize", 0.5], ["_textOffset", 15], ["_textColor", _color], ["_textAlpha", 1]];
            ["cmf_map_drawBorder", [
                _destinationPath,
                5,
                [_color, 1],
                [
                    [_textStartPos, _textEndPos, _name, _textSize, _textOffset, _textColor, _textAlpha]
                ]
            ]] call CBA_fnc_globalEventJIP;
        };

        default { };
    };
    
    _stop = diag_tickTime;
    LOG_2("Time: %1, Count DestinationPath: %2",_stop - _start,count _destinationPath);
}