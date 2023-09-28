// @TODO: replace cmf_config with some ingame config thing (copy how cba does it, each of the modules define themselves the possible settings and then you set them ingame)
#define TRUE 1
#define FALSE 0

class CMF {
    class SETTINGS {
        class player {
            switchMapTextures = TRUE;
            hideRespawnMarkers = TRUE;
            consistentMarkers = TRUE;
            restrictLauncher = TRUE;

            /* Hearing settings */
            class hearing {
                enable = TRUE;
                attenuateHeadgear = TRUE;
                earplugsVolume = 0.5;
            };
        };

        /* Respawn settings */
        class respawn {
            unconciousTimer = 300; 
        }

        /* Gameplay settings */
        class gameplay {
            overrideFlashbangs = TRUE;

            /* safestart settings */
            class safestart {
                enable = TRUE;
                delay = 5;
            };

            /* tracers settings */
            class tracers {
                enable = FALSE;
                flashlight = TRUE;
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
            transferToServer = TRUE;
            reinforce = FALSE;
            reinforceRange = 300;
            preventProne = TRUE;
            forceSkill = TRUE;
        };

        /* Utility settings */
        class utility {
            clearVehicleCargo = TRUE;
            freezeTime = TRUE;
        };

        /* Enhanced Vehicles Settings */
        class enhancedVehicles {
            enable = TRUE;
            visualEffects = TRUE;
            soundEffects = TRUE;
            offroadBumpy = FALSE;
            offroadDamage = FALSE;
        };

        blacklistedAddons[] = {"TF21_ChemlightDrop"};
    };
};

/* Disable forced complex flightmodel */
forceRotorLibSimulation = 0;

/* Respawn delay (in seconds) */
respawnDelay = 3;

/* Enable Debug console for eric (you can add your own aswell) */
enableDebugConsole[] = {"76561198065818848"};