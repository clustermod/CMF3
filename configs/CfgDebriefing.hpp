/*
 * Author: Eric
 * Defines Debriefings for game ends
 *
 */

class CfgDebriefing {
	// Kick back to lobby if player is not zeus
	class wrongZeus {
		title = "You're not zeus";
		subtitle = "";
		description = "This slot is reserved for zeus";
		pictureBackground = "";
		picture = "";
		pictureColor[] = {0.0,0.3,0.6,1};
	};

	// Kick back to lobby if not enough players to satisfy role
	class notEnoughPlayers {
		title = "Not enough players";
		subtitle = "";
		description = "This slot is limited by amount of players";
		pictureBackground = "";
		picture = "";
		pictureColor[] = {0.0,0.3,0.6,1};
	};
};
