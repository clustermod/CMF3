/*
 * Author: Eric
 * Defines functions for CMF
 */
class CMF {

    /* CMF init scripts */
    class init {
        class modules {
            file = "cmf\XEH_MODULE.sqf";
            preInit = 1;
        };
        
        class serverInit {
            file = "cmf\serverInit.sqf";
            preInit = 1;
        };

        class missionInit {
            file = "cmf\missionInit.sqf";
            postInit = 1;
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
