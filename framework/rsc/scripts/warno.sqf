/*
 * Author: Eric
 * Creates a warning order in-game
 *
 */

waitUntil { !isNull player };

/* SITUATION */
private _situation = "After our descalation of combat operations in Angola, the South West People's Organization's (SWAPO) military wing People's Liberation Army of Namibia (PLAN) has stocked up on a substantial amount of
weaponry supplied by the Soviet's. They have started to look more like a conventional army in terms of equipment and have even recieved MIG-21s. Brigadier Rudolf Badenhorst
has in this context launched Operation Protea in an effort to limit enemy capabilities. The operation is split into 2 task forces, alpha and bravo. Your team is in the former as a part of
Battle Group 20.<br/>
<br/>
<font color=""#fcba03"">ENEMY FORCES</font><br/>
- PLAN, 3rd Infantry<br/>
- PLAN, 2nd Artillery<br/>
- PLAN, 1st Anti-Air Brigade<br/>
- PLAN, 3rd armored brigade (unconfirmed)<br/>
- Likely Soviet advisors<br/>
<br/>
<font color=""#fcba03"">ENEMY CAPABILITIES</font><br/>
- Artillery<br/>
- Anti-Tank<br/>
- Anti-Air<br/>
<br/>
<font color=""#fcba03"">FRIENDLY FORCES</font><br/>
- S.A.D.F., 2nd Infantry Regiment<br/>
- S.A.D.F., 3rd Artillery Troop<br/>
- S.A.D.F., 1st Field Engineer Platoon<br/>
- S.A.A.F., 2 Squadron<br/>
<br/>
<font color=""#fcba03"">FRIENDLY CAPABILITIES</font><br/>
- Artillery<br/>
- Emergency Close Air Support
";

/* MISSION */
private _mission = "Recently the enemy has set up anti-air installations close to the angolan border, this is greatly limiting our air capabilities.
Your battle Group is tasked with neutralizing these installations. More specifically, your platoon is tasked with clearing the installations East of Obupala and 
South of Elsaville. Your sister platoons will be responsible for the sectors to your east and west.
";

/* EXECUTION */
private _execution = "<font color=""#fcba03"">COMMANDER'S INTENT</font><br/>
- The desired end state would be for all anti-air installations in your sector to be completly cleared out.<br/>
<br/>
<font color=""#fcba03"">MOVEMENT PLAN.</font><br/>
At task force leader's discretion.
";

/* ADMINISTRATION / LOGISTICS */
private _administration = "- 3rd Artillery Troop will conduct artillery operations with a battery of 3 105mm Howitzers .<br/><br/>
- S.A.A.F., 2 Squadron will provide Close Aire Support in cases of emergency.<br/><br/>
Your platoon has 4 land rovers at your disposal.";

/* COMMAND / SIGNAL */
private _command = "
<font color=""#fcba03"">RADIO COMMUNICATION TABLE</font><br/>
COMMAND NET - SEM-52SL - 46MHz<br/>
<br/>
<font color=""#fcba03"">CALLSIGN TABLE</font><br/>
COMMAND NET<br/>
    ARDVAARK - Company Commander<br/>
    KING FISH 1 - Emergency Close Air Support <br/>
    STEEL RAIN - Artillery<br/>
    VULTURE 1 - 1st Platoon Squad<br/>
    VULTURE 2 - 1st Platoon Squad<br/>
    VULTURE 3 - 1st Platoon Squad<br/>
    VULTURE 4 - 1st Platoon Squad<br/>
    LEOPARD 1 - 2nd Platoon Squad<br/>
    LEOPARD 2 - 2nd Platoon Squad<br/>
    LEOPARD 3 - 2nd Platoon Squad<br/>
    LEOPARD 4 - 2nd Platoon Squad<br/>
<br/>
<font color=""#fcba03"">RULES OF ENGAGEMENT</font><br/>
You are free to engage targets at will after a positive identification has been met.<br/>
<br/>
<font color=""#fcba03"">STANDARD OPERATING PROCEDURES</font><br/>
- Limit damage done to civilian infrastructure.<br/>
- Limit damage done to civilian infrastructure.<br/>
- STEEL RAIN accepts simplified call for fire protocol.<br/>
- KING FISH 1 accepts simplified close air support protocol.<br/>
- Red Smoke signals Enemy Position.<br/>
";

/* Create diaries */
player createDiaryRecord ["Diary", ["Command / Signal", _command]];
player createDiaryRecord ["Diary", ["Administration / Logistics", _administration]];
player createDiaryRecord ["Diary", ["Execution", _execution]];
player createDiaryRecord ["Diary", ["Mission", _mission]];
player createDiaryRecord ["Diary", ["Situation", _situation]];
