/*
 * Author: Eric
 * Defines Debriefings for game ends
 */

/* Message displayed to players who tried to take the zeus slot when not zeus */
class wrongZeus {
	title = "You're not zeus";
	subtitle = "";
	description = "This slot is reserved for zeus";
	pictureBackground = "";
	picture = "";
	pictureColor[] = {0.0,0.3,0.6,1};
};

/* Message displayed when not enough players to allow using a certain lobby unit */
class notEnoughPlayers {
	title = "Not enough players";
	subtitle = "";
	description = "This slot is limited by amount of players";
	pictureBackground = "";
	picture = "";
	pictureColor[] = {0.0,0.3,0.6,1};
};
