# TODO LIST

## enhancedVehicles
 - [X] Fuel leaks when tank isn't leaking
 - [X] If the leaking vehicle is type car light the crew on fire as well
 - [X] Hard lag when entering a vehicle (issue with viewdistance, just get niggas to unfuck their settings)
 - [ ] Offroad should be made clientside for the player, stop it from running for AI aswell
 - [X] Chance of being lit on fire if engine is kill or fuel is kill
 - [X] Move autoinit into init
 - [ ] Disable engineOn when vehicle gets disabled

## utility
 - [X] clearVehicleCargo clears ammocrates as well
 
## logistics (new category)
 - [X] Make crate names show when looking at crate (update name in ACE cargo aswell)
 - [ ] Make a virtual arsenal crate filling tool (just use kosher arsenal but set the target to the crate rather than the player's inventory containers) 
	   (due to the inherent way kosher arsenal works, the arsenal would be locked to your role)
 - [ ] Set default names for certain crates (fireteam crate, medical crate)
 - [X] Create resupply crates from loadoutfile function.
 - [X] Create a crate spawner
 - [ ] Look into overriding vehicle cargo crate naming

## 3den
 - [X] Finish the mission data tool (split general mission data and warno)
 - [ ] Maybe finish the config tool (might be a bit too much work rn)
 - [ ] Add categories and icons for all 3den tools
 - [ ] Add tool to assign vehicle to group (for TO&E)
 - [ ] Fix Bug where the unitspawner infantry squads prefers to start at charlie rather than alpha
 - [ ] Add icons for HMG, MMG, MAT and HAT and all ground and air vehicles (remove CUP dependency)
 - [X] Add icons for gametypes
 - [ ] <s>Add gametype to briefingName (3den name attribute)</s>
 - [X] Add gametype icon to overview picture
 - [ ] Add WARNO situation to overview text
 - [ ] Create resupply crates from loadoutfile function.
 - [ ] Kosher Arsenal Loadout Tool, change out list classes for custom class inherited from: https://github.com/acemod/ACE3/blob/master/addons/arsenal/ui/RscAttributes.hpp. 
	   (CT_LISTNBOX can take a idc on left or right side, put checkbox on right side)
- [ ] Move 3DEN Entity Tools to it's own component called 3den_tools
- [ ] Extend warno to include a callsign table in Command and Signal
- [ ] Create function to display warning order in mission
- [ ] Enable consistent marker in 3den
- [ ] Checklist and validation when mission gets exported (e.g. warning if no repsawn was added)

## kosherArsenal
 - [ ] Loadout validity test (so when something is wrong it will throw a proper stacktrace)

## AI
 - [X] Create an eventhandler to put ai in the panic action when on fire
 - [X] Silence AI once and for all
 - [X] Make transferToServer apply to all AI on init (cba_fnc_addEventhandlerToClass)
 - [ ] Automatically call artillery on called out units using taskArtillery from lambs
 - [X] Maybe use taskCreep rather than taskRush

## kosherAI
 - [ ] Update kosherAI to hash the config data it grabs
 - [ ] Sometimes spawns without magazines on dedicated server
 - [ ] Sometimes failes to remove handguns and facewear on dedicated server
 - [X] Switches to binoculars or secondary instead of primary after loadout has ben set

## main
 - [X] hide chat messages:
        replace join messages with: "X joined SIDE in GROUP" before game start and "X re-jipped" after game start. After game on: everything else should only be shown to zeus
 - [X] Chat message needs to handle multi word names (trim away the first and last element in splitString)
 - [X] Call loading bug fix automatically if player is in respawn menu with loading screen
 - [X] Show changelog when a newer version is available for player
 - [X] ACRE2 down mute not working, radio works, but proximity doesn't
 - [X] Make a warning order file (and look into a way of parsing it to display on a webpage)
 - [ ] Add https://community.bistudio.com/wiki/BIS_fnc_functionsDebug to debugging

## aar (new category)
 - [ ] <s>Test diagAAR and see if it does what i want</s>
 - [X] AARs should be a part of the game now. submitted AARs should be saved to an array to the target. At the end of the game, everyone gets the chance to write AARs to all, zeus, leader, group or individual players
 - [ ] Fix bug where viewing AARs counts wrongly and going left and right doesn't properly work
 - [ ] Show notification in spectator for newly submitted AARs

## gameplay
 - [X] safestart briefing phase isn't showing up at 8pm anymore
 - [ ] <s>Replace custom mission name decode function with this: https://cbateam.github.io/CBA_A3/docs/files/strings/fnc_decodeURL-sqf.html#CBA_fnc_decodeURL </s>
 - [X] disable autocombat on all AI when safestart is enabled
 - [X] Freeze time when safestart is enabled (check if freezetime is already enabled, if it isn't do)
 - [ ] <s>Craters from artillery rounds</s>
 - [ ] Fix bug with environment times for twilight
 - [ ] Fix timezone for safestart

## respawn
 - [X] Ping SL for rallypoint from respawn menu

## common
 - [ ] <s>setCallsign ranks don't work since the playerObject doesn't exist at serverinit, maybe move ranking to player init and just check what ranks should be given based on the group</s>
 - [X] Move ranks to the unit spawner in 3den and remove the CMF_ORBAT section from cmf_config

## player
 - [ ] <s>Find icons for group ace actions</s>
 - [X] Group ACE actions are kinda broken for team selection, switches when hovered 
 - [X] Make a projectreality camera shake when firing big guns from vehicles
 - [ ] <s>Create camera shake when vehicle is hit by big round</s>
 - [ ] <s>When close to a ACE fire create an orange tint based on the fire intensity</s>
 - [X] Reset map marker scale when map is closed (to unfuck sizes on ctrlMap controls)
 - [x] Treatment messages for patient (fixed in `KAT - Advanced Medical` in next update)
 - [ ] Change icon for submitting an AAR from spectator
 - [ ] Add button to view submitted AARs after closing
 - [ ] markerSize does not get size of zeus markers (wtf BI?)

## menu
 - [ ] <s>Move safestart into an admin menu</s>
 - [X] Add diagnostics menu with client and server sub-menu
 - [X] Add FPS counter and scripts counters for server and client. https://community.bistudio.com/wiki/diag_activeScripts / https://community.bistudio.com/wiki/diag_fps, https://community.bistudio.com/wiki/getClientState
	For server also add info from monitor (players lobby, players role selection, players briefing, players in-game and players debriefing)

## cleanup
 - [ ] Add Readme to each module
 - [ ] Follow ACE Code rules and remove sleeps, spawns etc. Get everything unscheduled: https://ace3.acemod.org/wiki/development/arma-3-scheduler-and-our-practices.html
 - [ ] Make sure every string is localized
 - [ ] Make sure debug is disabled on everything and that there are no unwanted systemchats
 - [ ] Replace custom eventhandlers with CBA ones. (basically remove the spawned waitUntils where i can) holy fuck, "retroactivly": https://cbateam.github.io/CBA_A3/docs/files/xeh/fnc_addClassEventHandler-sqf.html#CBA_fnc_addClassEventHandler
 - [ ] Replace all eventhandlers with CBA eventhandlers
 - [ ] Consider changing vanilla compile with: https://cbateam.github.io/CBA_A3/docs/files/xeh/fnc_compileFunction-sqf.html
 - [ ] Performance testing (try to lower the amount of spawned scripts drastically. rn a dedicated server runs maybe 70-80 spawned scripts, not good)
 - [ ] Clear scripts, img and loadouts directory of non-cmf files
 - [X] Change sound files to .wss file type (arma sound files)
 - [ ] Code optimization<br/>https://community.bistudio.com/wiki/Code_Optimisation#Lazy_Evaluation
https://community.bistudio.com/wiki/Code_Optimisation#if_and_switch
https://community.bistudio.com/wiki/Code_Optimisation#objectParent_and_vehicle