# Changelog v2.1.0 => v2.1.1
\+ Added CMF Info Diary<br/>
\+ Added gamemode and mission name intro<br/>
\+ Added Function to block looting of own body<br/>
\+ Added function to load state of player before disconnect when reconnecting<br/>
\+ Added function to get a unit's role<br/>
\+ Added function to parse strings with hex codes to ASCII<br/>
\+ Added function to parse CBA Keybinds to human-readable strings<br/>
\+ Added function to get the respawn limit<br/>
\+ Added function to get the remaining respawns<br/>
\+ Added Player Roster Diary<br/>
\+ Added Table of Organization & Equipment for Leaders<br/>
\+ Added chance of fuel leak catching fire in enhancedVehicles<br/>
\+ Added function to restore acre radio configuration on respawn<br/>
\+ Added a variable to track if player has fully loaded<br/>
\+ Added Ace interaction actions to organize team for team leaders<br/>
\+ Added so ACRE audio is muted when player is down<br/>
\+ Added new "player x has connected" message for safestart and re-jip<br/>
\+ Added a way to override safestart<br/>
\+ Added text based AAR system<br/>
\+ Added button to ping rallypoint-capable units to place a rallypoint<br/>
\+ Added ACE Arsenal medical and radio sub-categories to the 3den editor<br/>
\+ Added Logistics component<br/>
\+ Added Function to view crate names<br/>
\+ Added "suicide" bug fix when stuck at [0, 0, 0]<br/>
\+ Added function to set config value<br/>
\+ Added 3den display to set mission data<br/>
\+ Added game type icons<br/>
\+ Added setCombatbehaviour "CARELESS" and setCombatMode "BLUE" during safestart, this will stop AI from engaging targets<br/>
\+ Added DHAT and ANVIL to 3DEN Unit Spawner<br/>
\+ Added Function to display changelog on game start<br/>
\+ Added function to automate ACRE2 Babel languages<br/>
\+ Added so crew gets lit on fire if vehicle is on fire<br/>
\+ Added function to silence friendly AI for good (cmf_ai_fnc_silenceAI)<br/>
\+ Added functions to return angle of sun and time of angle of sun (cmf_utility_fnc_sunAngle and cmf_utility_fnc_getTimeOfSunAngle)<br/>
\+ Added diary for environment (weather and time of twilight and sun set/rise)<br/>
\+ Added function to create camerashake when firing from vehicles (cmf_enhancedVehicles_fnc_gunEffectEH)<br/>
\+ Added functions to add, remove or check a line from the 3den entity init<br/>
\+ Added functions to enable / disable carrying and dragging from ACE3<br/>

\~ Changed safestart to display meta information before mission start<br/>
\~ Fixed kosher arsenal force close bug<br/>
\~ Moved hydration tab into equipment tab<br/>
\~ Force Primary is no longer true by default in kosher arsenal<br/>
\~ Changed default respawns to 2<br/>
\~ Hearing no longer affects ACRE volume, only in-game volume<br/>
\~ Removed the "Remaining Respawns" message in limitedRespawns<br/>
\~ Fixed bug with "Fix Loading Screen Bug", it should now work again<br/>
\~ Fixed bug with map gesture colors<br/>
\~ Moved all functions in components into a sub directory called "functions"<br/>
\~ Respawns will not be decreased on death during safestart<br/>
\~ Added icons to the 3den CMF Menu<br/>
\~ Renamed Cluster ORBAT unit Spawner to Unit spawner<br/>
\~ Changed kosherArsenal init to use a better method of tracking respawns<br/>
\~ Enable and disable simulation in 3DEN tool has been combined to a toggle tool<br/>
\~ Moved bug fixes into a sub menu<br/>
\~ Fixed dropping while carrying / dragging in safestart phase<br/>
\~ Fixed fortify deploying in safestart phase<br/>
\~ Fixed kosherArsenal Rearm Arsenal Action being accessable from any distance<br/>
\~ Added new KAT Medical items to the medical submenu in ACE arsenal<br/>
\~ Changed getConfigParam to cache config params to a global config CBA Hash<br/>
\~ Added Bodybags to standard medic loadout.<br/>
\~ Changed loadoutfile format to allow for resupply crate generation.<br/>
\~ Moved setRanks into unit constructor<br/>
\~ Reset marker size when the map is closed to fix their scale on GPS or other map controls<br/>
\~ Moved enhancedVehicles Damage Handler and fuel Leak handler to seperate function files (cmf_enhancedVehicles_fnc_damageEH and cmf_enhancedVehicles_fnc_fuelLeakEH)<br/>
\~ Changed transferToServer to use CBA logic in an attempt to enhance performance.<br/>

\- Removed the "Display Roles" action from CC Menu, it's replaced by the TO&E Diary Entry<br/>
\- Removed CMF_ORBAT from cmf_config.hpp<br/>
\- Removed autoinit from enhancedVehicles (replaced by init)<br/>