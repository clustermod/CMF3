#include "script_component.hpp"

private _category = "Player";

[
	QGVAR(setting_switchMapTextures),
	"CHECKBOX",
	"Switch Map Textures",
	_category
] call EFUNC(common,addSetting);

[
	QGVAR(setting_hideRespawnMarkers),
	"CHECKBOX",
	"Hide Respawn Markers",
	_category
] call EFUNC(common,addSetting);

[
	QGVAR(setting_consistentMarkers),
	"CHECKBOX",
	"Consistent Marker Size",
	_category
] call EFUNC(common,addSetting);

[
	QGVAR(setting_restrictLauncher),
	"CHECKBOX",
	"Restrict Launcher Access",
	_category
] call EFUNC(common,addSetting);