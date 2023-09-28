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
	_style = [
		["H1", [["color", "#fcba03"], ["size", "20"]]],
		["H2", [["color", "#fcba03"], ["size", "17"]]],
		["H3", [["color", "#fcba03"], ["size", "15"]]],
		["Bold", [["face", "PuristaSemiBold"]]],
		["Italic", [["face", "PuristaLight"]]]
	];
};

_style = createHashMapFromArray _style;
private _parsedStyles = createHashMap;
{
	private _key = _x;
	private _value = _y;

	private _parsed = "";
	if (_diary) then {
		_parsed = "<font";
		{
			_parsed = _parsed + format [" %1=""%2""", _x, _y];
		} forEach createHashMapFromArray _y;
		_parsed = _parsed + ">$1</font>";
	} else {
		_parsed = "<t";
		{
			_parsed = _parsed + format [" %1=""%2""", _x, _y];
		} forEach createHashMapFromArray _y;
		_parsed = _parsed + ">$1</t>";
	};

	_parsedStyles set [_key, _parsed];
} forEach _style;

/* Remove Comments */
_input = _input regexReplace ["[\s|.](<!--[^>]*-->)", ""];

/* Bold */
_input = _input regexReplace ["\*\*([\S\s]*?)\*\*", _parsedStyles getOrDefault ["Bold", "$1"]];

/* Italic */
_input = _input regexReplace ["\*([\S\s]*?)\*", _parsedStyles getOrDefault ["Italic", "$1"]];

/* H1 */
_input = _input regexReplace ["\n# (.*?)\n", "\n"+(_parsedStyles getOrDefault ["H1", "$1"])+"\n"];

/* H2 */
_input = _input regexReplace ["\n## (.*?)\n", "\n"+(_parsedStyles getOrDefault ["H2", "$1"])+"\n"];

/* H3 */
_input = _input regexReplace ["\n### (.*?)\n", "\n"+(_parsedStyles getOrDefault ["H3", "$1"])+"\n"];

/* List */
_input = _input regexReplace ["\n- ", "\n• "];

/* Hide ignore characters */
_input = _input regexReplace ["\\(.)", "$1"];

/* Breaks */
_input = _input regexReplace ["(\r\n|\r|\n)", "<br/>"];

_input