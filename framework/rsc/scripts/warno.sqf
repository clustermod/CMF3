/*
 * Author: Eric
 * Creates a warning order in-game
 *
 */

waitUntil { !isNull player };

/* SITUATION */
private _situation = "After the failed U.S.M.C. invasion in Northern Estonia the Soviet Union has set it's sights on Finland and have started pushing forces across the border. The Finnish government is forcing the U.S. to take responibility
as we are the reason Finland got pulled into this war in the first place. We have since set up a border-wide blocking force mainly consisting of U.S. Army units. The U.S.M.C. has been planning a counter-attack in conjunction with
Finnish Special Forces aiming to cripple Soviet Operational Command on the Finnish side of the border and opening a corridor of attack for the main U.S. Army and Finnish Army Forces to push through. Due to your achievements during the
failed Estonia campaign your team was marked as Special Operations Capable (SOC) and got moved under the umbrella of Force Recon, changing your standard tasking to Special Reconnaissance and Direct Action operations.<br/>
<br/>
<font color=""#fcba03"">ENEMY FORCES</font><br/>
- 3rd Guards Motor Rifle Division<br/>
- 6th Guards ""Vitebsko-Novgorodskaya"" Motor Rifle Division<br/>
- 3rd Guards Tank Division<br/>
- 12th Artillery Division<br/>
- 7th Guards Cherkassy Airborne Division<br/>
- 600th Military Aviation Regiment<br/>
<br/>
<font color=""#fcba03"">ENEMY CAPABILITIES</font><br/>
- Artillery<br/>
- Close Air Support<br/>
- Anti-Tank<br/>
- Anti-Air<br/>
<br/>
<font color=""#fcba03"">FRIENDLY FORCES</font><br/>
- U.S. Marines, 101st Reconnaissance Battalion<br/>
- U.S. Marines, Combat Logistics Battalion 2<br/>
- U.S. Marines, 6th Engineer Support Battalion<br/>
- U.S. Air Force, 14th Air Division<br/>
- U.S. Navy, Carrier Strike Group 11, U.S.S. Freedom<br/>
- U.S. Navy, Carrier Strike Group 11, U.S.S. Cowpens (CG-63)<br/>
- Finnish Utin Jääkärirykmentti, kaukopartio-osastot (Finnish Jeager Regiment,
  Long Range Reconnaissance battalion)<br/>
<br/>
<font color=""#fcba03"">FRIENDLY CAPABILITIES</font><br/>
- Naval Artillery<br/>
- Emergency Close Air Support<br/>
- Anti-Tank, Light<br/>
- Anti-Air<br/>";

/* MISSION */
private _mission = "- Punch a hole in the north-eastern soviet defensive line<br/>
- Locate the finnish special forces squad (callsign ROMEO 1) and receive
  location of Soviet regional field HQ.<br/>
- Neutralize the Soviet regional field HQ.";

/* EXECUTION */
private _execution = "<font color=""#fcba03"">COMMANDER'S INTENT</font><br/>
- An open assault corridor for our mainline forces to push through and outflank
  Soviet defences.<br/>
- Crippled Soviet Command on the Finnish side of the border.<br/>
<br/>
<font color=""#fcba03"">MOVEMENT PLAN.</font><br/>
1. Perform an Amphibious Landing at LZ Crown with the LAV-25A1.<br/>
2. Secure the LZ and await the LCU to land with your remaining vehicles.<br/>
... At task force leader's discretion.
";

/* ADMINISTRATION / LOGISTICS */
private _administration = "- Combat Logistics battalion 2 will conduct resupply and any reinforcement.<br/><br />
- Carrier Strike Group 11, U.S.S. Cowpens (CG-63) will conduct naval artillery.<br/><br />
- U.S. Air Force, 14th Air Division will conduct ECAS operations.<br/><br/>
- 6th Engineer Support Battalion will conduct repair and refuel operations.<br/><br />
- Battalion Surgeon will provide advanced medical aid and is reachable through command.<br/><br />
Your task-force has a LAV-25A1 for support and an MTVR for transport. The MTVR will be brought to shore by an LCU operated by the Navy personnel from U.S.S. Freedom.";

/* COMMAND / SIGNAL */
private _command = "There is a low civilian presence due to Finnish Evacuations of the border.<br/>
<br/>
<font color=""#fcba03"">RADIO COMMUNICATION TABLE</font><br/>
COMMAND NET - AN/PRC-77 - 30MHz<br/>
<br/>
<font color=""#fcba03"">CALLSIGN TABLE</font><br/>
COMMAND NET<br/>
    COMMAND - Company Commander<br/>
    LOGI - Logistics<br/>
    ENGI - Engineers<br/>
    STEEL RAIN - Naval Artillery<br/>
<br/>
<font color=""#fcba03"">RULES OF ENGAGEMENT</font><br/>
You are free to engage targets at will after a positive identification has been met.<br/>
<br/>
<font color=""#fcba03"">STANDARD OPERATING PROCEDURES</font><br/>
- Limit damage done to civilian infrastructure.<br/>
- Red Smoke signals Enemy Position for ECAS.<br/>
- Blue Smoke signals Friendly Position for ECAS";

/* Create diaries */
player createDiaryRecord ["Diary", ["Command / Signal", _command]];
player createDiaryRecord ["Diary", ["Administration / Logistics", _administration]];
player createDiaryRecord ["Diary", ["Execution", _execution]];
player createDiaryRecord ["Diary", ["Mission", _mission]];
player createDiaryRecord ["Diary", ["Situation", _situation]];
