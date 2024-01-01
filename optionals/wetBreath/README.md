# Wet Breath
Creates a condensated breath effect for cold missions. Activates at a regular interval to simulate breathing or when people speak with ACRE.

## Files
- scripts\breath.sqf

## Installation
Move the scripts directory into CMF3's rsc directory:
`rsc\scripts\breath.sqf`

## Usage
Inside initPlayerLocal put:
```
call compile preprocessFileLineNumbers "rsc\scripts\breath.sqf";
```