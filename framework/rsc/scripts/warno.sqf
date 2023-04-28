/*
 * Author: Eric
 * Creates a warning order in-game
 *
 */

waitUntil { !isNull player };

/* SITUATION */
private _situation = "While West-German and U.S. forces were conducting the annual exercise Reforger in West-Germany East-German and Soviet Forces launched an attack on the British controlled West-German region of Celle.
This attack was completly unseen by Army Intelligence as it is the dumbest time to launch an attack into West-Germany with West-German, British and U.S. Forces literally training for a simulated attack by East-German and Soviet forces.
Regardless the attack was launched and coalition forces are scrambling to set up defensive lines and pull in supply. A U.S. reconnaissance team has spotted Soviet troops staging for an assault at Eschede. Due to the presence of 
Amphibious Vehicles it is believed their target will be the City of Celle. <br/>
<br/>
<font color=""#fcba03"">ENEMY FORCES</font><br/>
- N.V.A., 1st Motor Rifle Regiment<br/>
- N.V.A., 8th Motor Rifle Regiment<br/>
- N.V.A., 9th Panzer Division<br/>
- N.V.A., Kampfhubschraubergeschwader 3<br/>
- U.S.S.R., 1st Motor Rifle Regiment<br/>
- U.S.S.R., 7th Motor Rifle Regiment<br/>
- U.S.S.R., 16th Armoured Division<br/>
<br/>
<font color=""#fcba03"">ENEMY CAPABILITIES</font><br/>
- Artillery<br/>
- Anti-Tank<br/>
- Anti-Air<br/>
<br/>
<font color=""#fcba03"">FRIENDLY FORCES</font><br/>
- F.R.G., 3rd Aufklärungslehrbataillon<br/>
- F.R.G., Panzerbataillon 114<br/>
- F.R.G., Panzergrenadierbrigade 35<br/>
- U.S., 1st Armored Division<br/>
- U.S., 3rd Infantry Division<br/>
<br/>
<font color=""#fcba03"">FRIENDLY CAPABILITIES</font><br/>
- Artillery<br/>
- Anti-Tank, Medium
";

/* MISSION */
private _mission = "Delay the enemy until U.S. forces can reinforce Hehlentor.
";

/* EXECUTION */
private _execution = "<font color=""#fcba03"">COMMANDER'S INTENT</font><br/>
- Prevent the enemy from capturing Celle and keep them North of the Aller River<br/>
<br/>
<font color=""#fcba03"">EXECUTION</font><br/>
Setup for an ambush at Ambush Point (AP) Bravo and interdict the enemy vehicles on Main Supply Route (MSR) Newport until 2nd Platoon is setup at Vorwerk. Once 2nd platoon is setup fall back to Battle Point (BP) Delta and 
get set to disrupt the enemy formation as they push Hehlentor. Once the enemy starts utilizing Alternate Supply Route (ASR) Prince fall back to Battle Point (BP) Echo and contain the enemy North-East of Vorwerk. 2nd Platoon 
will have fallen back as well at this point. Keep delaying the enemy for as long as possible while keeping your fallback route to Battle Point (BP) Foxtrot open. Once the fallback route is close to being compromised fallback 
to Battle Point (BP) Foxtrot. Defend from Battle Point (BP) Foxtrot until unfeasible and pull in the defensive line to Hehlentor proper defending the town until unfeasible or U.S. Reinforcements have arrived.
<br/>
<font color=""#fcba03"">MOVEMENT PLAN</font><br/>
1. Move along MSR Nixon to MSR Wilson.<br/>
2. Move from MSR Wilson to the Staging Area in Hehlentor.<br/>
3. See execution above...
";

/* ADMINISTRATION / LOGISTICS */
private _administration = "- Battalion HQ will provide Artillery by 3 120mm Mortars.<br/><br/>
- There are 4 Fireteam Crates and 2 Medical crates available at the Staging Area in Hehlentor.<br/><br/>
Your Platoon has 1 MTVR at your disposal. You will be escorted to Hehlentor by 1 M113 from 2nd Platoon";

/* COMMAND / SIGNAL */
private _command = "
There is no civilian presence.<br/><br/>
<font color=""#fcba03"">RADIO COMMUNICATION TABLE</font><br/>
COMMAND NET - SEM-70 - 30MHz<br/>
<br/>
<font color=""#fcba03"">CALLSIGN TABLE</font><br/>
COMMAND NET<br/>
    COMMAND - battalion Command<br/>
    STEEL RAIN - Artillery<br/>
<br/>
<font color=""#fcba03"">RULES OF ENGAGEMENT</font><br/>
You are free to engage targets at will after a positive identification has been met.<br/>
<br/>
<font color=""#fcba03"">STANDARD OPERATING PROCEDURES</font><br/>
- STEEL RAIN accepts simplified radio protocol.
";

/* Create diaries */
player createDiaryRecord ["Diary", ["Command / Signal", _command]];
player createDiaryRecord ["Diary", ["Administration / Logistics", _administration]];
player createDiaryRecord ["Diary", ["Execution", _execution]];
player createDiaryRecord ["Diary", ["Mission", _mission]];
player createDiaryRecord ["Diary", ["Situation", _situation]];
