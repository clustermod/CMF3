/* 
 * Warning order formatting Glossary:
 * Similar to markdown
 * 
 */

_warno = "
# Situation
My situation description.

## Enemy Composition
- Infantry
- Motorized

## Enemy Capabilities
- Artillery
- Anti-Tank, Medium

## Friendly Composition
- Infantry
- Air

## Friendly Capabilities
- Close Air Support
- Anti-Tank, Light

# Mission
- Objective 1
- Objective 2

# Execution
## Commander's Intent
The overall intent of this operation is to complete Objectives 1 and 2.

## Movement plan
At the task-force leader's discretion

# Administration and Logistics
- No resupply available
Your task-force is supplied with one bus for transport.

# Command and Signal
## Communications table
COMMAND NET - AN/PRC-152 - Chn 1
ALPHA - AN/PRC-152 - Chn 2

## Callsign Table
### COMMAND NET
- Command
- ANVIL
- LOGI
- ENGI
- Alpha

## Rules of Engagement
Do not fire unless fired upon.

## Standard operating procedures
- Red smoke signals enemy
";

/* Formatting data before passing it back */
[
	/* warno file version */
	"1.0",

	/* Data Array */
	[
		_warno
	]
];