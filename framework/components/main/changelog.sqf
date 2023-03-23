"
<t size='1.1'>CMFv2.1.0.0 > CMFv2.1.1.49</t>
This is a full changelog of changes since v2.1.0 as the changes have remained undocumented publicly. For subsequent versions the changelog will only display the new changes from the last version.
<br/>
<t size='1.05'>Added</t>
<t color='#00aa22'>+</t> Added CMF Info Diary, shows general information about the version of CMF used and individual settings
<t color='#00aa22'>+</t> Added safestart mission intro
<t color='#00aa22'>+</t> Added Function to block looting of own body (inline function of cmf_main_fnc_playerInit)
<t color='#00aa22'>+</t> Added function to load state of player before disconnect when reconnecting (inline function of cmf_main_fnc_playerInit)
<t color='#00aa22'>+</t> Added function to get a unit's role (cmf_common_fnc_getRole)
<t color='#00aa22'>+</t> Added function to parse strings with hex codes to ASCII (cmf_utility_fnc_hexToASCII)
<t color='#00aa22'>+</t> Added function to parse CBA Keybinds to human-readable strings (cmf_utility_fnc_keybindToString)
<t color='#00aa22'>+</t> Added function to get the respawn limit (cmf_respawn_fnc_getLimit)
<t color='#00aa22'>+</t> Added function to get the remaining respawns (cmf_respawn_fnc_getRemaining)
<t color='#00aa22'>+</t> Added Player Roster Diary, shows the current player roster and their teams (cmf_gameplay_fnc_roster)
<t color='#00aa22'>+</t> Added Table of Organization and Equipment for Leaders, shows the same as the roster with additional information like individual player equipment and team vehicles (cmf_gameplay_fnc_TOE)
<t color='#00aa22'>+</t> Added function to create ACE Fires on any object (cmf_enhancedVehicles_fnc_fire)
<t color='#00aa22'>+</t> Added chance of fuel leak catching fire in enhancedVehicles (inline function of cmf_enhancedVehicles_fnc_init)
<t color='#00aa22'>+</t> Added lighting crew on fire when vehicle is on fire (inline function of cmf_enhancedVehicles_fnc_init)
<t color='#00aa22'>+</t> Added function to restore acre radio configuration on respawn (inline function of cmf_main_fnc_playerInit)
<t color='#00aa22'>+</t> Added a variable to track if player has fully loaded (cmf_main_player_loaded)
<t color='#00aa22'>+</t> Added Ace interaction actions to organize team for team leaders (cmf_player_fnc_teamActions)
<t color='#00aa22'>+</t> Added so ACRE audio is muted when player is down (inline function of cmf_main_fnc_playerInit)
<t color='#00aa22'>+</t> Added new ""player x has connected"" message for jip and re-jip players (cmf_main_fnc_handleChat)
<t color='#00aa22'>+</t> Added a way to override safestart (cmf_gameplay_safestart_override)
<t color='#00aa22'>+</t> Added AAR component (aar)
<t color='#00aa22'>+</t> Added override of BIS_fnc_endMission to use our own mission ending text and AAR System (cmf_aar_fnc_endMission)
<t color='#00aa22'>+</t> Added button to ping rallypoint-capable units to place a rallypoint (inline function of cmf_respawn_fnc_rallypoint)
<t color='#00aa22'>+</t> Added ACE Arsenal medical and radio sub-categories to the 3den editor (part of cmf_3den_fnc_init)
<t color='#00aa22'>+</t> Added Logistics component (logistics)
<t color='#00aa22'>+</t> Added Function to view crate names (cmf_logistics_fnc_cratePFH)
<t color='#00aa22'>+</t> Added Function to add additional rename and destroy actions to supply crates (cmf_logistics_fnc_crateActions)
<t color='#00aa22'>+</t> Added ""suicide"" bug fix for when player is stuck at [0, 0, 0] (inline function of cmf_menu_fnc_init)
<t color='#00aa22'>+</t> Added function to set config value (cmf_common_fnc_setConfigParam)
<t color='#00aa22'>+</t> Added 3den display to set mission data (inline function of cmf_3den_fnc_setConfig)
<t color='#00aa22'>+</t> Added game type icons:
    ""rsc\data\icon_gametype_empty_ca.paa"", ""rsc\data\icon_gametype_scenario_ca.paa"", ""rsc\data\icon_gametype_qrf_ca.paa"", ""rsc\data\icon_gametype_csar_ca.paa"",
    ""rsc\data\icon_gametype_custom_ca.paa"", ""rsc\data\icon_gametype_assault_ca.paa"", ""rsc\data\icon_gametype_defence_ca.paa"", ""rsc\data\icon_gametype_sandbox_ca.paa"",
    ""rsc\data\icon_gametype_invasion_ca.paa"", ""rsc\data\icon_gametype_training_ca.paa""
<t color='#00aa22'>+</t> Added setCombatbehaviour ""CARELESS"" and setCombatMode ""BLUE"" during safestart, this will stop AI from engaging targets (inline function of cmf_gameplay_fnc_safestart)
<t color='#00aa22'>+</t> Added DHAT and ANVIL to 3DEN Unit Spawner
<t color='#00aa22'>+</t> Added Function to display changelog on game start (inline function of cmf_main_fnc_changelog)
<t color='#00aa22'>+</t> Added function to automate ACRE2 Babel languages (inline function of cmf_main_fnc_playerInit)
<t color='#00aa22'>+</t> (Bugged) Added function to freezeTime during safestart (inline function of cmf_gameplay_fnc_safestart)
<t color='#00aa22'>+</t> Added eventhandler to put AI in panic action when on fire (cmf_ai_fnc_fireEH)
<t color='#00aa22'>+</t> Added function to silence friendly AI for good (cmf_ai_fnc_silenceAI)
<t color='#00aa22'>+</t> Added functions to return angle of sun and time of angle of sun (cmf_utility_fnc_sunAngle and cmf_utility_fnc_getTimeOfSunAngle)
<t color='#00aa22'>+</t> Added diary for environment (weather and time of twilight and sun set/rise)
<t color='#00aa22'>+</t> Added function to create camerashake when firing from vehicles (cmf_enhancedVehicles_fnc_gunEffectEH)
<t color='#00aa22'>+</t> Added functions to add, remove or check a line from the 3den entity init (cmf_3den_fnc_addToinit, cmf_3den_fnc_removeFromInit and cmf_3den_fnc_inInit)
<t color='#00aa22'>+</t> Added functions to enable / disable carrying and dragging from ACE3
<br/>
<t size='1.05'>Changed</t>
<t color='#009eaa'>~</t> Changed safestart to display meta information before mission start
<t color='#009eaa'>~</t> Fixed kosher arsenal force close bug
<t color='#009eaa'>~</t> Moved hydration tab into equipment tab
<t color='#009eaa'>~</t> Force Primary is no longer true by default in kosher arsenal
<t color='#009eaa'>~</t> Changed default respawns to 2
<t color='#009eaa'>~</t> Hearing no longer affects ACRE volume, only in-game volume
<t color='#009eaa'>~</t> Removed the ""Remaining Respawns"" message in limitedRespawns, now a part of safestart meta info
<t color='#009eaa'>~</t> Fixed bug with ""Fix Loading Screen Bug"", it should now work again
<t color='#009eaa'>~</t> Fixed bug with map gesture colors
<t color='#009eaa'>~</t> Moved all functions in components into a sub directory called ""functions""
<t color='#009eaa'>~</t> Respawns will not be decreased on death during safestart
<t color='#009eaa'>~</t> Added icons to the 3den CMF Menu
<t color='#009eaa'>~</t> Renamed Cluster ORBAT unit Spawner to Unit spawner
<t color='#009eaa'>~</t> Changed kosherArsenal init to use a better method of tracking initial respawn
<t color='#009eaa'>~</t> ""Enable"" and ""disable simulation in 3DEN"" tool has been combined to a toggle tool
<t color='#009eaa'>~</t> Moved bug fixes into a sub menu
<t color='#009eaa'>~</t> Fixed dropping while carrying / dragging in safestart phase
<t color='#009eaa'>~</t> Fixed fortify deploying in safestart phase
<t color='#009eaa'>~</t> Fixed kosherArsenal Rearm Arsenal Action being accessable from any distance
<t color='#009eaa'>~</t> Added new KAT Medical items to the medical submenu in ACE arsenal
<t color='#009eaa'>~</t> Changed cmf_common_fnc_getConfigParam to cache config params to a global CBA Hash
<t color='#009eaa'>~</t> Moved submitAAR to aar component
<t color='#009eaa'>~</t> Added Bodybags to standard medic loadout.
<t color='#009eaa'>~</t> Changed loadoutfile format to allow for resupply crate generation.
<t color='#009eaa'>~</t> Moved setRanks into unit constructor.
<t color='#009eaa'>~</t> Reset marker size when the map is closed to fix their scale on GPS or other map controls.
<t color='#009eaa'>~</t> Moved enhancedVehicles Damage Handler and fuel Leak handler to seperate function files (cmf_enhancedVehicles_fnc_damageEH and cmf_enhancedVehicles_fnc_fuelLeakEH).
<t color='#009eaa'>~</t> Changed transferToServer to use CBA logic in an attempt to enhance performance.
<t color='#009eaa'>~</t> Temporarily force disabled offroading.
<t color='#009eaa'>~</t> Renamed 3den functions for better organization.
<t color='#009eaa'>~</t> Refactored Prevent Prone to use CBA XEH.
<t color='#009eaa'>~</t> Changed reinforcing AIs tactic from rush to creep.
<br/>
<t size='1.05'>Removed</t>
<t color='#aa0027'>-</t> Removed the ""Display Roles"" action from CC Menu, it's replaced by the Table of Organization and Equipment Diary Entry and the safestart meta info
<t color='#aa0027'>-</t> Removed CMF_ORBAT from cmf_config.hpp
<t color='#aa0027'>-</t> Removed autoinit from enhancedVehicles (replaced by init)
"