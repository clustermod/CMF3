/*
 * Author: Eric
 * Creates a warning order in-game
 *
 */

waitUntil { !isNull player };

/* SITUATION */
private _situation = "A week ago Egyption forces pushed across the Suez canal attempting to retake the Sinai Desert. They were pushed back
and are now in a defensive posture on the Egyptian side of the canal. The upper brass wants all combat effective forces to take the initiative and push the goys
back and take full control of the sueaz canal. Your Battalion is tasked with the assault of the important trade town of El-Qantara.<br/>
<br/>
<font color=""#fcba03"">ENEMY FORCES</font><br/>
- E.A.F., 107th Airborne Brigade<br/>
- E.A.F., 4th Armored Division<br/>
<br/>
<font color=""#fcba03"">ENEMY CAPABILITIES</font><br/>
- Artillery<br/>
- Anti-Tank<br/>
- Anti-Air<br/>
<br/>
<font color=""#fcba03"">FRIENDLY FORCES</font><br/>
- I.D.F., Infantry Corps, 1st ""Golani"" Brigade<br/>
- I.D.F., Armored Corps, 401st ""I'Kvot Ha-Barzel"" Armor Brigade<br/>
- I.D.F., Artillery Coprs, 215th ""Pillar of Fire"" Artillery Regiment<br/>
- I.A.F., 253rd ""Negev"" Squadron<br/>
<br/>
<font color=""#fcba03"">FRIENDLY CAPABILITIES</font><br/>
- Artillery<br/>
- Close Air Support
";

/* MISSION */
private _mission = "- Assault Egyptian held El-Qantara<br/>
- Locate and clear Egyptian Supply Depot
";

/* EXECUTION */
private _execution = "<font color=""#fcba03"">COMMANDER'S INTENT</font><br/>
- The desired end state would be for the streets to be relativly safe from enemy fire.<br/>
- If able, locate and destroy the Egyptian Supply depot within the city.<br/>
<br/>
<font color=""#fcba03"">MOVEMENT PLAN.</font><br/>
1. Move north and stage at the makeshift bridge.<br/>
2. Cross the makeshift bridge and make your way south towards the city center.<br/>
... At platoon leader's discretion.
";

/* ADMINISTRATION / LOGISTICS */
private _administration = "- 215th Artillery REgiment will conduct artillery operations with a battery of 3 105mm Howitzers .<br/><br/>
- I.A.F., 253rd Squadron will provide Close Air Support with 1 F-4 Phantom.<br/><br/>
Your platoon has 1 M60A1 and 1 M37-B1 at your disposal.";

/* COMMAND / SIGNAL */
private _command = "
There is a light Civilian Presence.<br/><br/>
<font color=""#fcba03"">RADIO COMMUNICATION TABLE</font><br/>
COMMAND NET - AN/PRC-77 - 30MHz<br/>
<br/>
<font color=""#fcba03"">CALLSIGN TABLE</font><br/>
COMMAND NET<br/>
    COMMAND - Company Commander<br/>
    HAWG 1 - Close Air Support<br/>
    STEEL RAIN - Artillery<br/>
<br/>
<font color=""#fcba03"">RULES OF ENGAGEMENT</font><br/>
You are free to engage targets at will after a positive identification has been met.<br/>
<br/>
<font color=""#fcba03"">STANDARD OPERATING PROCEDURES</font><br/>
- STEEL RAIN accepts simplified radio protocol.<br/>
- HAWG 1 accepts simplified radio protocol.
";

/* Create diaries */
player createDiaryRecord ["Diary", ["Command / Signal", _command]];
player createDiaryRecord ["Diary", ["Administration / Logistics", _administration]];
player createDiaryRecord ["Diary", ["Execution", _execution]];
player createDiaryRecord ["Diary", ["Mission", _mission]];
player createDiaryRecord ["Diary", ["Situation", _situation]];
