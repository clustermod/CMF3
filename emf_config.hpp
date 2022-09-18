/* Respawn delay (in seconds) */
respawnDelay = 3;

/* Enable Debug console for eric (you can add your own aswell) */
enableDebugConsole[] = {"76561198065818848"};

/* EMF settings */
class EMF {
    class SETTINGS {
        /* Enabled/Disable Auto init modules */
        class init {
            recordAfterAction = 0;
            clearVehicleCargo = 1;
            switchMapTextures = 1;
            hideRespawnMarkers = 1;
            overrideFlashbangs = 1;
            consistentMarkers = 1;
            preventProne = 1;
            forceSkill = 1;
            freezeTime = 0;
            safestart = 0; // ERIC REMEMBER TO SET TO 1
            hearing = 1;
        };

        /* Hearing settings */
        class hearing {
            attenuateHeadgear = 1;
            earplugsVolume = 0.5;
        };

        /* Enhanced Vehicles Settings */
        class enhancedVehicles {
            enableEnhancedVehicles = 1;
            visualEffects = 1;
            soundEffects = 1;
            offroadBumpy = 1;
            offroadDamage = 1;
        };

        /* Safestart settings */
        class safestart {
            delay = 60;
        };

        /* Rallypoint settings */
        class rallypoint {
            cooldown = 300;
            enemyKillRadius = 10;
            rallyObjectClass = "Misc_backpackheap_EP1";
        };
    };
};

/* EMF ORBAT Settings */
class EMF_ORBAT {
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
