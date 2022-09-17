/*
 * Author: Eric
 * Defines functions for emf
 */
class EMF {

    /* EMF init scripts */
    class init {
        class serverInit {
            file = "emf\EMF_serverInit.sqf";
            preInit = 1;
        };

        class missionInit {
            file = "emf\EMF_missionInit.sqf";
            postInit = 1;
        };

        class modules {
            file = "emf\XEH_MODULE.sqf";
            preInit = 1;
        };
    };

    /* EMF event scripts in events directory */
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
