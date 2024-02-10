# Changelog v2.1.1.59 => v2.1.1.60
## Changed
- Temporarily disabled logistics crate actions as it created a bug where all ace actions were removed from the crate
- Use SETTING Macro in every instance

## Fixed
- Fixed bug where players where unable to take items from cmf logistic crates 

# Changelog v2.1.1.58 => v2.1.1.59
## Changed
- Replaced `CBA_fnc_setVarNet` with vanilla `setVariable` (setVarNet was too unstable)

# Changelog v2.1.1.57 => v2.1.1.58
## Added
- Added new Dynamic group system
- Added new component `map`
- New map tools for mission makers
- Added fuel canisters to vehicle cargo
- Added new `kosherGarage` system
- Added ability to name vehicles
- Added new component: `environment`
- Added AI automatic artillery
- Added SETTING family of macros
- Added more info for zeuses aswell as a keybind to toggle away this info
- Added longest and shortest frametime to ace diagnostic menu
- Added ability to rename vehicles
- Added ability to set vehicles as rallypoints

## Changed
- Moved hideRespawns to new map category
- Moved mapTexture to new map category
- Moved resizeMarkers to new map category
- Changed TO&E and Roster to reflect new dynamic system
- TO&E is no longer restricted to team leaders
- AI will now dissembark from the vehicle if it gets disabled
- Made major improvements to performance
- Towing ropes are now whitelisted from `clearVehicleCargo`
- Changed so kosherAI will take into account if unit already has a role assigned
- Renamed zeus component to `curator`
- Replaced setVariable with CBA_fnc_setNetVar where the variable needed to be global (network optimization)
- Replaced publicVariable with CBA_fnc_publicVariable (network optimization)

## Fixed
- Fixed bug where game would lag heavily during endMission screen
- Fixed bug with clearVehicleCargo
- Fixed offroad bumps bug
- Fixed Bug with vehicle fires
- Fixed twilight times diary record
- Fixed humidity being wrongly displayed
- Fixed Bug with assigning team color on respawn
- Fixed bug with tracers function
- Fixed bug with ACRE PTT assignment

## Removed
- Removed old kosherGarage system
- Removed utility module and moved all it's functions to more appropriate modules

# Changelog v2.1.1.56 => v2.1.1.57
## Added
- New diagnostics module
- New settings system
- Notification function
- New viewdistance system (to fix lag with old one)
- Added a RscImports file for UI to keep all imported classes collected
- Added new logging functions
- Added function to get closest match from a array of numbers
- Added function to add keybinds

## Changed
- Many minor things i no longer remember
- Freezetime is now toggleable
- Safestart will have time frozen until game start
- Changed how keybinds are listed in CMF diary

## Fixed
- Bug where hideHud wouldn't work with hotkey
- Bug with whitelisted URIs

## Removed
- Removed old ACE Medical sub category in favor of ace's own category


<!-- Kept for posterity -->
# Changelog v2.1.0 => v2.1.1
## Added
- Added CMF Info Diary
- Added gamemode and mission name intro
- Added Function to block looting of own body
- Added function to load state of player before disconnect when reconnecting
- Added function to get a unit's role
- Added function to parse strings with hex codes to ASCII
- Added function to parse CBA Keybinds to human-readable strings
- Added function to get the respawn limit
- Added function to get the remaining respawns
- Added Player Roster Diary
- Added Table of Organization & Equipment for Leaders
- Added chance of fuel leak catching fire in enhancedVehicles
- Added function to restore acre radio configuration on respawn
- Added a variable to track if player has fully loaded
- Added Ace interaction actions to organize team for team leaders
- Added so ACRE audio is muted when player is down
- Added new "player x has connected" message for safestart and re-jip
- Added a way to override safestart
- Added text based AAR system
- Added button to ping rallypoint-capable units to place a rallypoint
- Added ACE Arsenal medical and radio sub-categories to the 3den editor
- Added Logistics component
- Added Function to view crate names
- Added "suicide" bug fix when stuck at [0, 0, 0]
- Added function to set config value
- Added 3den display to set mission data
- Added game type icons
- Added setCombatbehaviour "CARELESS" and setCombatMode "BLUE" during safestart, this will stop AI from engaging targets
- Added DHAT and ANVIL to 3DEN Unit Spawner
- Added Function to display changelog on game start
- Added function to automate ACRE2 Babel languages
- Added so crew gets lit on fire if vehicle is on fire
- Added function to silence friendly AI for good (cmf_ai_fnc_silenceAI)
- Added functions to return angle of sun and time of angle of sun (cmf_utility_fnc_sunAngle and cmf_utility_fnc_getTimeOfSunAngle)
- Added diary for environment (weather and time of twilight and sun set/rise)
- Added function to create camerashake when firing from vehicles (cmf_enhancedVehicles_fnc_gunEffectEH)
- Added functions to add, remove or check a line from the 3den entity init
- Added 3den tool to toggle ace carry on objects
- Added 3den tool to toggle ace drag on objects
- Added 3den tool to write warning orders
- Added function to handle AI Panic (retreat or surrender)
- Added function to display treatment information by remote parties
- Added ability to whitelist/blacklist classes and factions in kosherAI
- Added Config entry for adding flashlights in cmf tracers config
- Added logistical crate definers and spawners
- Added Warning Order Function
- Added unconcious timer
- Added hostage follow script

## Changed
- Changed safestart to display meta information before mission start
- Fixed kosher arsenal force close bug
- Moved hydration tab into equipment tab
- Force Primary is no longer true by default in kosher arsenal
- Changed default respawns to 2
- Hearing no longer affects ACRE volume, only in-game volume
- Removed the "Remaining Respawns" message in limitedRespawns
- Fixed bug with "Fix Loading Screen Bug", it should now work again
- Fixed bug with map gesture colors
- Moved all functions in components into a sub directory called "functions"
- Respawns will not be decreased on death during safestart
- Added icons to the 3den CMF Menu
- Renamed Cluster ORBAT unit Spawner to Unit spawner
- Changed kosherArsenal init to use a better method of tracking respawns
- Enable and disable simulation in 3DEN tool has been combined to a toggle tool
- Moved bug fixes into a sub menu
- Fixed dropping while carrying / dragging in safestart phase
- Fixed fortify deploying in safestart phase
- Fixed kosherArsenal Rearm Arsenal Action being accessable from any distance
- Added new KAT Medical items to the medical submenu in ACE arsenal
- Changed getConfigParam to cache config params to a global config CBA Hash
- Added Bodybags to standard medic loadout.
- Changed loadoutfile format to allow for resupply crate generation.
- Moved setRanks into unit constructor
- Reset marker size when the map is closed to fix their scale on GPS or other map controls
- Moved enhancedVehicles Damage Handler and fuel Leak handler to seperate function files (cmf_enhancedVehicles_fnc_damageEH and cmf_enhancedVehicles_fnc_fuelLeakEH)
- Changed transferToServer to use CBA logic in an attempt to enhance performance.
- Renamed 3den functions for better organization.
- Refactored prevent prone to use CBA XEH.
- Changed reinforcing AIs tactic from rush to creep.
- Moved kosherAI into it's own component
- Added crewman, rotary pilot and fixed-wing pilot to possible kosherAI roles
- Majot code cleanup

## Removed
- Removed the "Display Roles" action from CC Menu, it's replaced by the TO&E Diary Entry
- Removed CMF_ORBAT from cmf_config.hpp
- Removed autoinit from enhancedVehicles (replaced by init)