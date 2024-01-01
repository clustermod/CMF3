# Ambient Combat
Adds ambient sounds of combat as well as optional light flashes on explosion sounds.

## Files
- scripts\ambientCombat.sqf

## Installation
Move the scripts directory into CMF3's rsc directory:
`rsc\scripts\ambientCombat.sqf`

## Usage
Inside initPlayerLocal put:
```
[] call compile preprocessFileLineNumbers "rsc\scripts\ambientCombat";
```
See the script file for more parameters of control.