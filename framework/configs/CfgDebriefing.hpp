/*
 * Author: Eric
 * Defines Debriefings for game ends
 */

/* Message displayed to players who tried to take the zeus slot when not zeus */
class cmf_utility_notZeus {
    title = "You have been blocked from joining this slot";
    subtitle = "";
    description = "This slot is reserved for zeus";
    pictureBackground = "";
    picture = "";
    pictureColor[] = {0.0,0.3,0.6,1};
};

/* Message displayed to players who have blacklisted addons */
class cmf_main_blacklistedAddon {
    title = "Blacklisted addon";
    subtitle = "";
    description = "You have a blacklisted addon, please remove it from your modlist and try again";
    pictureBackground = "";
    picture = "";
    pictureColor[] = {0.0,0.3,0.6,1};
};
