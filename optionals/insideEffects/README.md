# Inside Effects
Adds more effects for inside combat. When a firearm is fired inside a building it will create sparks and smoke. It also adds a louder, more reverbareted sound.

## Files
- scripts\insideEffects.sqf
- sounds\shot_inside.ogg

## Installation
Move both the scripts and sounds directory into CMF3's rsc directory:
`rsc\scripts\ambientCombat.sqf` and `rsc\sounds\shot_inside.ogg`

## Usage
Inside initPlayerLocal put:
```
call compile preprocessFileLineNumbers "rsc\scripts\insideEffects.sqf";
```