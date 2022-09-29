/*
 * Author: Eric
 * Defines functions for CMF
 */
class cmf {
    /* CMF init scripts */
    class init {
        class modules {
            file = "components\main\XEH_MODULE.sqf";
            preInit = 1;
        };
    };

    /* CMF event scripts in events directory */
    class events {
        class preInit {
            file = "events\preInit.sqf";
            preInit = 1;
        };

        class postInit {
            file = "events\postInit.sqf";
            postInit = 1;
        };
    };
};
