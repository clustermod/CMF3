class CMF {
    class SETTINGS {
        class player {
            switchMapTextures = 1;
            hideRespawnMarkers = 1;
            consistentMarkers = 1;
            restrictLauncher = 1;

            /* Hearing settings */
            class hearing {
                enable = 1;
                attenuateHeadgear = 1;
                earplugsVolume = 0.5;
            };
        };

        /* Gameplay settings */
        class gameplay {
            overrideFlashbangs = 1;

            /* safestart settings */
            class safestart {
                enable = 1;
                delay = 0;
            };

            /* tracers settings */
            class tracers {
                enable = 1;
                side[] = {"east"};
            };
        };

        /* Rallypoint settings */
        class rallypoint {
            cooldown = 300;
            enemyKillRadius = 10;
            rallyObjectClass = "Misc_backpackheap_EP1";
        };

        /* ai settings */
        class ai {
            transferToServer = 1;
            reinforce = 1;
            reinforceRange = 300;
            preventProne = 1;
            forceSkill = 1;
        };

        /* Utility settings */
        class utility {
            clearVehicleCargo = 1;
            freezeTime = 1;
        };

        /* Enhanced Vehicles Settings */
        class enhancedVehicles {
            enable = 1;
            visualEffects = 1;
            soundEffects = 1;
            offroadBumpy = 0;
            offroadDamage = 0;
        };

        blacklistedAddons[] = {};
    };
};

/* Disable forced complex flightmodel */
forceRotorLibSimulation = 0;

/* Respawn delay (in seconds) */
respawnDelay = 3;

/* Enable Debug console for eric (you can add your own aswell) */
enableDebugConsole[] = {"76561198065818848"};

/* CMF ORBAT Settings */
class CMF_ORBAT {
    class SIZES {
        class BAT {
            leadRank = "COLONEL";
            generalRank = "MAJOR";
        };
        class COY {
            leadRank = "CAPTAIN";
            generalRank = "CAPTAIN";
        };
        class PLT {
            leadRank = "LIEUTENANT";
            generalRank = "LIEUTENANT";
        };
        class SQD {
            leadRank = "SERGEANT";
            generalRank = "CORPORAL";
        };
        class FT {
            leadRank = "CORPORAL";
            generalRank = "PRIVATE";
        };
    };

    class TYPES {
        class INF {};
        class ARMOR {};
        class TRANS {};
        class CAS {};
        class LOGI {};
        class WEAPONS {};
        class SUPPORT {};
        class MECH {};
        class MOTOR {};
        class HQ {};
    };
};
