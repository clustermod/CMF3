# TODO LIST

## enhancedVehicles (renamed vehicles)
 - [X] Fuel leaks when tank isn't leaking
 - [X] If the leaking vehicle is type car light the crew on fire as well
 - [X] Hard lag when entering a vehicle (issue with viewdistance, just get niggas to unfuck their settings)
 - [X] Offroad should be made clientside for the player, stop it from running for AI aswell
 - [X] Chance of being lit on fire if engine is kill or fuel is kill
 - [X] Move autoinit into init
 - [X] Disable engineOn when vehicle gets disabled
 - [X] Add Portable fuel canisters (and spawn them in vehicles, should add the space i takes to not make vehicle cargo small)
 - [X] Add function to rename vehicle, <s>auto assign name if vehicle is assigned squad</s>

## utility
 - [X] clearVehicleCargo clears ammocrates as well
 - [X] Remove in favor of common or other categories
 
## logistics (new category)
 - [X] Make crate names show when looking at crate (update name in ACE cargo aswell)
 - <s>Set default names for certain crates (fireteam crate, medical crate)</s>
 - [X] Create resupply crates from loadoutfile function.
 - [X] Create a crate spawner
 - [ ] Look into overriding vehicle cargo crate naming <!-- @LIST_TODO: Override cargo names in vehicles to use custom name only -->
 - [ ] Create vehicle spawner with group whitelist <!-- @LIST_TODO: Create vehicle spawner with group whitelist -->

## 3den
 - [X] Finish the mission data tool (split general mission data and warno)
 - [X] Maybe finish the config tool (might be a bit too much work rn)
 - [ ] Add categories and icons for all 3den tools <!-- @LIST_TODO: Add all entity tools -->
 - [ ] Add tool to assign vehicle to group (for TO&E) <!-- @LIST_TODO: Add tool to assign vehicles for TO&E -->
 - [X] Fix Bug where the unitspawner infantry squads prefers to start at charlie rather than alpha
 - [ ] Add icons for HMG, MMG, MAT and HAT and all ground and air vehicles (remove CUP dependency) <!-- @LIST_TODO: Create icons for HMG, MMG, MAT, HAT, Ground - and Air Vehicles -->
 - [X] Add icons for gametypes
 - <s>Add gametype to briefingName (3den name attribute)</s>
 - [X] Add gametype icon to overview picture
 - [ ] Add WARNO situation to overview text <!-- @LIST_TODO: Add situation to overview text when loading mission -->
 - [ ] Create resupply crates from loadoutfile function. <!-- @LIST_TODO: Tool to create supply crates -->
 - [ ] Kosher Arsenal Loadout Tool, change out list classes for custom class inherited from: https://github.com/acemod/ACE3/blob/master/addons/arsenal/ui/RscAttributes.hpp. <!-- @LIST_TODO: Tool to create loadouts -->
	   (CT_LISTNBOX can take a idc on left or right side, put checkbox on right side)
- <s>Move 3DEN Entity Tools to it's own component called 3den_tools</s>
- [X] Extend warno to include a callsign table in Command and Signal
- [X] Create function to display warning order in mission
- [ ] Enable consistent marker in 3den <!-- @LIST_TODO: Enable consistent marker size in 3den -->
- [ ] Checklist and validation when mission gets exported (e.g. warning if no repsawn was added) <!-- @LIST_TODO: Checklist and validation on mission export -->
- [ ] Rename functions again to make more sense and move some of the stuff in init.sqf to 3denInit <!-- @LIST_TODO: Rename functions again to make more sense and move some of the stuff in init.sqf to 3denInit -->

## kosherArsenal
 - [ ] Loadout validity test (so when something is wrong it will throw a proper stacktrace) <!-- @LIST_TODO: Function to verify loadouts (check for errors) -->

## AI
 - [X] Create an eventhandler to put ai in the panic action when on fire
 - [X] Silence AI once and for all
 - [X] Make transferToServer apply to all AI on init (cba_fnc_addEventhandlerToClass)
 - [X] Automatically call artillery on called out units using taskArtillery from lambs
 - [X] Maybe use taskCreep rather than taskRush

## kosherAI
 - [ ] Update kosherAI to hash the config data it grabs <!-- @LIST_TODO: Kosher AI should hash any config data it gets -->
 - [X] Sometimes spawns without magazines on dedicated server 
 - [X] Sometimes failes to remove handguns and facewear on dedicated server
 - [X] Switches to binoculars or secondary instead of primary after loadout has ben set

## main
 - [X] hide chat messages:
        replace join messages with: "X joined SIDE in GROUP" before game start and "X re-jipped" after game start. After game on: everything else should only be shown to zeus
 - [X] Chat message needs to handle multi word names (trim away the first and last element in splitString)
 - [X] Call loading bug fix automatically if player is in respawn menu with loading screen
 - [X] Show changelog when a newer version is available for player
 - [X] ACRE2 down mute not working, radio works, but proximity doesn't
 - [X] Make a warning order file (and look into a way of parsing it to display on a webpage)
 - <s>Add https://community.bistudio.com/wiki/BIS_fnc_functionsDebug to debugging</s>
 - [X] Add ScriptError event handler to track script errors in CMF

## aar (new category)
 - <s>Test diagAAR and see if it does what i want</s>
 - [X] AARs should be a part of the game now. submitted AARs should be saved to an array to the target. At the end of the game, everyone gets the chance to write AARs to all, zeus, leader, group or individual players
 - [ ] Fix bug where viewing AARs counts wrongly and going left and right doesn't properly work <!-- @BUG: Reports gets counted wrongly and are not refreshed -->
 - [ ] Show notification in spectator for newly submitted AARs <!-- @LIST_TODO: Notifications for newly submitted AARs -->
 - [ ] Show a count of how many players have submitted an AAR over the amount of players in mission <!-- @LIST_TODO: Show Submitted AAR count / players -->

## Organization (new category)
- [X] Add dynamic orbat system (assign squad, platoon and company automatically)
- <s>Remove roster and only have TO&E </s>
- [ ] Make TO&E static and only update it on JIP <!-- @LIST_TODO: TO&E should be static --> 
- [ ] Weather diary should be static, never update. Only get how it was at mission start <!-- @LIST_TODO: Weather diary should be static -->
- [ ] ORBAT Command & Signal should link to TO&E Diary <!-- @LIST_TODO: Link to TO&E -->
- [ ] Comms plan diary, should auto generate based on player teams, link in Command & Signal <!-- @LIST_TODO: Comms Plan Diary subject -->
- [X] Loop over all squads in 3den and assign them on init
- [ ] Make it possible to assign vehicle to squad with ace interact <!-- @LIST_TODO: Make it possible to assign vehicle to squad with ace interact -->
- [ ] The "must be player group" options don't seem to work, not sure if only in 3den or both in 3den and mission <!-- @BUG: The "must be player group" options don't seem to work -->

## gameplay
 - [X] safestart briefing phase isn't showing up at 8pm anymore
 - <s>Replace custom mission name decode function with this: https://cbateam.github.io/CBA_A3/docs/files/strings/fnc_decodeURL-sqf.html#CBA_fnc_decodeURL </s>
 - [X] disable autocombat on all AI when safestart is enabled
 - <s>Craters from artillery rounds</s>
 - [X] Fix bug with environment times for twilight
 - [X] Fix timezone for safestart
 - [X] Freeze time when safestart is enabled (check if freezetime is already enabled, if it isn't do)
 - [X] Add automatic safestart phases: Setup Phase (before 7), Overtime Phase (after 8:30)
 - [X] Add 3d icons for rallypoints in zeus

## respawn
 - [X] Ping SL for rallypoint from respawn menu
 - [ ] Make vehicle into rallypoint <!-- @LIST_TODO: Allow setting a vehicle as the rallypoint -->

## common
 - <s>setCallsign ranks don't work since the playerObject doesn't exist at serverinit, maybe move ranking to player init and just check what ranks should be given based on the group</s>
 - [X] Move ranks to the unit spawner in 3den and remove the CMF_ORBAT section from cmf_config
 - [X] Also add function to set keybinds similar to addSetting

## player
 - <s>Find icons for group ace actions</s>
 - [X] Group ACE actions are kinda broken for team selection, switches when hovered 
 - [X] Make a projectreality camera shake when firing big guns from vehicles
 - <s>Create camera shake when vehicle is hit by big round</s>
 - <s>When close to a ACE fire create an orange tint based on the fire intensity</s>
 - [X] Reset map marker scale when map is closed (to unfuck sizes on ctrlMap controls)
 - [x] Treatment messages for patient (fixed in `KAT - Advanced Medical` in next update)
 - [ ] Change icon for submitting an AAR from spectator <!-- @LIST_TODO: Get a better icon for submitting AARs -->
 - [ ] Add button to view submitted AARs after closing <!-- @LIST_TODO: Add button to spectator and zeus to view submitted AARS -->
 - [X] markerSize does not get size of zeus markers (wtf BI?) 
 - [ ] Add functions to change ACRE volume of players <!-- @LIST_TODO: Function to change acre volume of individual players -->
 - [ ] Add function to change volume of game for only that mission <!-- @LIST_TODO: Function to change game volume for only that mission / session -->

## menu
 - <s>Move safestart into an admin menu</s>
 - [X] Add diagnostics menu with client and server sub-menu
 - [X] Add FPS counter and scripts counters for server and client. https://community.bistudio.com/wiki/diag_activeScripts / https://community.bistudio.com/wiki/diag_fps, https://community.bistudio.com/wiki/getClientState
	For server also add info from monitor (players lobby, players role selection, players briefing, players in-game and players debriefing)
 - [X] Add shortest, average and longest frame time using diag_deltaTime
 - [X] Add a AFK function that attaches the player to the closest player (within a max distance), make player invisible, muted and deaf. If the person attached to dies; player dies

## map (new category)
 - [ ] Create map tools for 3den <!-- @LIST_TODO: Create 3den map tools -->

## cleanup
 - [X] Move images from rsc\data to folders inside components
 - [ ] Add Readme to each module <!-- @LIST_TODO: Add a README to each of the modules -->
 - [ ] Cleanup ui files <!-- @LIST_TODO: Do a big cleanup of all ui classes -->
 - [ ] Follow ACE Code rules and remove sleeps, spawns etc. Get everything unscheduled: 
        https://ace3.acemod.org/wiki/development/arma-3-scheduler-and-our-practices.html <!-- @LIST_TODO: Try to make as much of the code unscheduled as possible -->
 - [ ] Make sure every string is localized <!-- @LIST_TODO: Localize strings -->
 - [ ] Make sure debug is disabled on everything and that there are no unwanted systemchats <!-- @RELEASE_TODO: Disable Debug on all modules -->
 - [X] Replace custom eventhandlers with CBA ones. (basically remove the spawned waitUntils where i can) holy fuck, "retroactivly": https://cbateam.github.io/CBA_A3/docs/files/xeh/fnc_addClassEventHandler-sqf.html#CBA_fnc_addClassEventHandler
 - [X] Replace all eventhandlers with CBA eventhandlers
 - [X] Consider changing vanilla compile with: https://cbateam.github.io/CBA_A3/docs/files/xeh/fnc_compileFunction-sqf.html
 - [ ] Clear scripts, img and loadouts directory of non-cmf files <!-- @RELEASE_TODO: Remove files not required by CMF, maybe move scripts to an extras folder -->
 - [X] Change sound files to .wss file type (arma sound files)
 - [ ] Where script is spawned per unit, instead have one spawn that works with an updated array of units <!-- @LIST_TODO: Where script is spawned per unit, instead have one spawn that works with an updated array of units -->
 - [X] Code optimization<br/>https://community.bistudio.com/wiki/Code_Optimisation#Lazy_Evaluation
https://community.bistudio.com/wiki/Code_Optimisation#if_and_switch
https://community.bistudio.com/wiki/Code_Optimisation#objectParent_and_vehicle
https://community.bistudio.com/wiki/Code_Optimisation#Array_Manipulation
https://community.bistudio.com/wiki/Code_Optimisation#call