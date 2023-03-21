# TODO LIST

## enhancedVehicles
 - [X] Fuel leaks when tank isn't leaking
 - [X] If the leaking vehicle is type car light the crew on fire as well
 - [X] Hard lag when entering a vehicle (issue with viewdistance, just get niggas to unfuck their settings)
 - [ ] Offroad should be made clientside for the player, stop it from running for AI aswell
 - [X] Chance of being lit on fire if engine is kill or fuel is kill

## utility
 - [X] clearVehicleCargo clears ammocrates as well
 
## logistics (new category)
 - [X] Make crate names show when looking at crate (update name in ACE cargo aswell)
 - [ ] Make a virtual arsenal crate filling tool (just use kosher arsenal but set the target to the crate rather than the player's inventory containers) 
	   (due to the inherent way kosher arsenal works, the arsenal would be locked to your role)
 - [ ] Set default names for certain crates (fireteam crate, medical crate)
 - [ ] Create resupply crates from loadoutfile function.

## 3den
 - [X] Finish the mission data tool (split general mission data and warno)
 - [ ] Maybe finish the config tool (might be a bit too much work rn)
 - [ ] Add categories and icons for all 3den tools 
 - [ ] Add tool to assign vehicle to group (for TO&E)
 - [ ] Bug where the unitspawner infantry squads prefers to start at charlie rather than alpha
 - [ ] Add icons for HMG, MMG, MAT and HAT and all ground and air vehicles (remove CUP dependency)
 - [X] Add icons for gametypes
 - [ ] <s>Add gametype to briefingName (3den name attribute)</s>
 - [X] Add gametype icon to overview picture
 - [ ] Add WARNO situation to overview text
 - [ ] Create resupply crates from loadoutfile function.
 - [ ] Kosher Arsenal Loadout Tool, change out list classes for custom class inherited from: https://github.com/acemod/ACE3/blob/master/addons/arsenal/ui/RscAttributes.hpp. 
	   (CT_LISTNBOX can take a idc on left or right side, put checkbox on right side)

## kosherArsenal
 - [ ] Loadout validity test (so when something is wrong it will throw a proper stacktrace)

## AI
 - [X] Create an eventhandler to put ai in the panic action when on fire
 - [X] Silence AI once and for all

## main
 - [X] hide chat messages:
        replace join messages with: "X joined SIDE in GROUP" before game start and "X re-jipped" after game start. After game on: everything else should only be shown to zeus
 - [X] Chat message needs to handle multi word names (trim away the first and last element in splitString)
 - [X] Call loading bug fix automatically if player is in respawn menu with loading screen
 - [X] Show changelog when a newer version is available for player
 - [X] ACRE2 down mute not working

## aar (new category)
 - [ ] <s>Test diagAAR and see if it does what i want</s>
 - [X] AARs should be a part of the game now. submitted AARs should be saved to an array to the target. At the end of the game, everyone gets the chance to write AARs to all, zeus, leader, group or individual players

## gameplay
 - [X] safestart briefing phase isn't showing up at 8pm anymore
 - [ ] <s>Replace custom mission name decode function with this: https://cbateam.github.io/CBA_A3/docs/files/strings/fnc_decodeURL-sqf.html#CBA_fnc_decodeURL </s>
 - [X] disable autocombat on all AI when safestart is enabled
 - [X] Freeze time when safestart is enabled (check if freezetime is already enabled, if it isn't do)
 - [ ] <s>Craters from artillery rounds</s>

## respawn
 - [X] Ping SL for rallypoint from respawn menu

## common
 - [ ] <s>setCallsign ranks don't work since the playerObject doesn't exist at serverinit, maybe move ranking to player init and just check what ranks should be given based on the group</s>
 - [X] Move ranks to the unit spawner in 3den and remove the CMF_ORBAT section from cmf_config

## player
 - [ ] <s>Find icons for group ace actions</s>
 - [X] Group ACE actions are kinda broken for team selection, switches when hovered 
 - [ ] Make a projectreality camera shake when firing big guns from vehicles
 - [ ] Create camera shake when vehicle is hit by big round
 - [ ] When close to a ACE fire create an orange tint based on the fire intensity
 - [X] Reset map marker scale when map is closed (to unfuck sizes on ctrlMap controls)

## menu
 - [ ] <s>Move safestart into an admin menu</s>
 - [X] Add diagnostics menu with client and server sub-menu
 - [X] Add FPS counter and scripts counters for server and client. https://community.bistudio.com/wiki/diag_activeScripts / https://community.bistudio.com/wiki/diag_fps, https://community.bistudio.com/wiki/getClientState
	For server also add info from monitor (players lobby, players role selection, players briefing, players in-game and players debriefing)

## cleanup
 - [ ] Make sure every string is localized
 - [ ] Make sure debug is disabled on everything and that there are no unwanted systemchats
 - [ ] Replace custom eventhandlers with CBA ones. (basically remove the spawned waitUntils where i can) holy fuck, "retroactivly": https://cbateam.github.io/CBA_A3/docs/files/xeh/fnc_addClassEventHandler-sqf.html#CBA_fnc_addClassEventHandler
 - [ ] Replace all eventhandlers with CBA eventhandlers
 - [ ] Consider changing vanilla compile with: https://cbateam.github.io/CBA_A3/docs/files/xeh/fnc_compileFunction-sqf.html
 - [ ] Performance testing (try to lower the amount of spawned scripts drastically. rn a dedicated server runs maybe 70-80 spawned scripts, not good)
 - [X] Change sound files to .wss file type (arma sound files)