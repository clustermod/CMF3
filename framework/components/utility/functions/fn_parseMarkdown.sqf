/*
 * Author: Eric
 * Parses markdown into structured text or diary text
 * 
 * Arguments:
 * 0: Text to parse <STRING>
 * 1: Is Diary Structured Text [Default: false] <BOOLEAN>
 * 2: Custom Style <CBAHASH>
 * 
 * Return Value:
 * Structured Text <TEXT>
 * 
 * Example:
 * [_myMarkdown] call cmf_utility_fnc_parsemarkdown
 * 
 * Public: Yes
 */
params ["_input", ["_diary", false], "_style"];

/* Set default style if no style is specified */ // style array: [structured text replacement, string modifier]
if (isNil "_style") then {
	_style = [] call CBA_fnc_hashCreate;
	_style = [_style, "HEADER1", [["color", "#fcba03"]]] call CBA_fnc_hashSet;
	_style = [_style, "HEADER2", [["color", "#fcba03"], { toUpper _this }]] call CBA_fnc_hashSet;
	_style = [_style, "HEADER3", ["color", "#fcba03"]] call CBA_fnc_hashSet;
	_style = [_style, "HEADER4", []] call CBA_fnc_hashSet;
};

private _styleParse = {
	params ["_string", "_styleHash", "_modifier"];

	private _styleTags = [
		["color", ["t", "font"]]
	] call CBA_fnc_hashCreate;

	{
		private _key = _x;
		private _val = _y;

		private _tag = [_styleTags, _x, ""] call CBA_fnc_hashGet;

		if (_tag != "") then {

		};

	} forEach createHashMapFromArray _styleHash;
};

private _isheader = {
	private _index = 0;
	while { (_this select _index ) isEqualTo "#" } do {
		_index = _index + 1;
	};

	private _return = "";
	switch (_index) do {
		case 1: { _return = "HEADER1" };
		case 2: { _return = "HEADER2" };
		case 3: { _return = "HEADER3" };
		case 4: { _return = "HEADER4" };
	};

	_return;
};

_parsedText = _input splitString toString [13,10];
{
	private _line = _x;
	if ((_x call _isHeader) != "") then {
		
	};
} forEach _parsedText;

_parsedText joinString "<br/>";
parseText _parsedText;
