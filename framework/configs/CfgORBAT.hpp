/*
* Author: Eric
* Defines the standard cluster ORBAT
*/

class CfgORBAT {
    class cluster {
        id = 1;
        idType = 0;
        side = "West";
        colorInisgnia[] = {1, 0, 0, 1};
        commander = "";
        commanderRank = "";
        text = "Cluster community";
        textShort = "Cluster";
        description = "The cluster community ORBAT";

        class phantom {
            side = "West";
            size = "Platoon";
            type = "AviationSupport";
            commander = "";
            commanderRank = "";
            text = "PHANTOM";
            textShort = "PHANTOM";
            color[] = {0,0,1,1};
            description = "A rotary wing light transport / light cas platoon";

            class phantom_1 {
                side = "West";
                size = "Size1";
                type = "AviationSupport";
                commander = "";
                commanderRank = "";
                text = "PHANTOM 1";
                textShort = "PHANTOM 1";
                color[] = {0,0,1,1};
                description = "First PHANTOM Bird";
            };

            class phantom_2 {
                side = "West";
                size = "Size1";
                type = "AviationSupport";
                commander = "";
                commanderRank = "";
                text = "PHANTOM 2";
                textShort = "PHANTOM 2";
                color[] = {0,0,1,1};
                description = "Second PHANTOM Bird";
            };
        };

        class reaper {
            side = "West";
            size = "Platoon";
            type = "CombatAviation";
            commander = "";
            commanderRank = "";
            text = "REAPER";
            textShort = "REAPER";
            color[] = {0,0,1,1};
            description = "A rotary wing cas platoon";

            class reaper_1 {
                side = "West";
                size = "Size1";
                type = "CombatAviation";
                commander = "";
                commanderRank = "";
                text = "REAPER 1";
                textShort = "REAPER 1";
                color[] = {0,0,1,1};
                description = "First REAPER Bird";
            };

            class reaper_2 {
                side = "West";
                size = "Size1";
                type = "AviationSupport";
                commander = "";
                commanderRank = "";
                text = "REAPER 2";
                textShort = "REAPER 2";
                color[] = {0,0,1,1};
                description = "Second REAPER Bird";
            };
        };

        class ugly {
            side = "West";
            size = "Platoon";
            type = "CombatAviation";
            commander = "";
            commanderRank = "";
            text = "UGLY";
            textShort = "UGLY";
            color[] = {0,0,1,1};
            description = "A rotary wing heavy cas platoon";

            class ugly_1 {
                side = "West";
                size = "Size1";
                type = "CombatAviation";
                commander = "";
                commanderRank = "";
                text = "UGLY 1";
                textShort = "UGLY 1";
                color[] = {0,0,1,1};
                description = "First UGLY Bird";
            };

            class ugly_2 {
                side = "West";
                size = "Size1";
                type = "AviationSupport";
                commander = "";
                commanderRank = "";
                text = "UGLY 2";
                textShort = "UGLY 2";
                color[] = {0,0,1,1};
                description = "Second UGLY Bird";
            };
        };

        class hawg {
            side = "West";
            size = "Platoon";
            type = "Fighter";
            commander = "";
            commanderRank = "";
            text = "HAWG";
            textShort = "HAWG";
            color[] = {0.85,0.64,0.12,1};
            description = "A fixed wing ground-attack jet";

            class hawg_1 {
                side = "West";
                size = "Size1";
                type = "Fighter";
                commander = "";
                commanderRank = "";
                text = "HAWG 1";
                textShort = "HAWG 1";
                color[] = {0.85,0.64,0.12,1};
                description = "First HAWG Jet";
            };

            class hawg_2 {
                side = "West";
                size = "Size1";
                type = "Fighter";
                commander = "";
                commanderRank = "";
                text = "HAWG 2";
                textShort = "HAWG 2";
                color[] = {0.85,0.64,0.12,1};
                description = "Second HAWG Jet";
            };
        };

        class pavement {
            side = "West";
            size = "Platoon";
            type = "Fighter";
            commander = "";
            commanderRank = "";
            text = "PAVEMENT";
            textShort = "PAVEMENT";
            color[] = {0.85,0.64,0.12,1};
            description = "A fixed wing air superiority fighter / bomber jet";

            class pavement_1 {
                side = "West";
                size = "Size1";
                type = "Fighter";
                commander = "";
                commanderRank = "";
                text = "PAVEMENT 1";
                textShort = "PAVEMENT 1";
                color[] = {0.85,0.64,0.12,1};
                description = "First PAVEMENT Jet";
            };

            class pavement_2 {
                side = "West";
                size = "Size1";
                type = "Fighter";
                commander = "";
                commanderRank = "";
                text = "PAVEMENT 2";
                textShort = "PAVEMENT 2";
                color[] = {0.85,0.64,0.12,1};
                description = "Second PAVEMENT Jet";
            };
        };

        class coy_hq {
            side = "West";
            size = "Company";
            type = "HQ";
            commander = "";
            commanderRank = "";
            text = "Company HQ";
            textShort = "COY HQ";
            color[] = {0.05,0.05,0.05,1};
            description = "The highest command element that will ever be present in cluster missions. This element will rarely be seen due to the amount of players required for it to be necessary";

            class sierra {
                side = "West";
                size = "Platoon";
                type = "Armored";
                commander = "";
                commanderRank = "";
                text = "SIERRA";
                textShort = "SIERRA";
                color[] = {1,0.54,0,1};
                description = "An armored platoon of APC type armored vehicles. Can be expanded with more platoons if necessary.";

                class sierra_1 {
                    side = "West";
                    size = "Size1";
                    type = "Armored";
                    commander = "";
                    commanderRank = "";
                    text = "SIERRA 1";
                    textShort = "SIERRA 1";
                    color[] = {1,0.54,0,1};
                    description = "First SIERRA Armored vehicle";
                };

                class sierra_2 {
                    side = "West";
                    size = "Size1";
                    type = "Armored";
                    commander = "";
                    commanderRank = "";
                    text = "SIERRA 2";
                    textShort = "SIERRA 2";
                    color[] = {1,0.54,0,1};
                    description = "Second SIERRA Armored vehicle";
                };
            };

            class mike {
                side = "West";
                size = "Platoon";
                type = "Armored";
                commander = "";
                commanderRank = "";
                text = "MIKE";
                textShort = "MIKE";
                color[] = {1,0.54,0,1};
                description = "An armored platoon of IFV type armored vehicles. Can be expanded with more platoons if necessary.";

                class mike_1 {
                    side = "West";
                    size = "Size1";
                    type = "Armored";
                    commander = "";
                    commanderRank = "";
                    text = "MIKE 1";
                    textShort = "MIKE 1";
                    color[] = {1,0.54,0,1};
                    description = "First MIKE Armored vehicle";
                };

                class mike_2 {
                    side = "West";
                    size = "Size1";
                    type = "Armored";
                    commander = "";
                    commanderRank = "";
                    text = "MIKE 2";
                    textShort = "MIKE 2";
                    color[] = {1,0.54,0,1};
                    description = "Second MIKE Armored vehicle";
                };
            };

            class tango {
                side = "West";
                size = "Platoon";
                type = "Armored";
                commander = "";
                commanderRank = "";
                text = "TANGO";
                textShort = "TANGO";
                color[] = {1,0.54,0,1};
                description = "An armored platoon of MBT type armored vehicles. Can be expanded with more platoons if necessary.";

                class tango_1 {
                    side = "West";
                    size = "Size1";
                    type = "Armored";
                    commander = "";
                    commanderRank = "";
                    text = "TANGO 1";
                    textShort = "TANGO 1";
                    color[] = {1,0.54,0,1};
                    description = "First TANGO Armored vehicle";
                };

                class tango_2 {
                    side = "West";
                    size = "Size1";
                    type = "Armored";
                    commander = "";
                    commanderRank = "";
                    text = "TANGO 2";
                    textShort = "TANGO 2";
                    color[] = {1,0.54,0,1};
                    description = "Second TANGO Armored vehicle";
                };
            };

            class plt_hq_1 {
                id = 1;
                side = "West";
                size = "Platoon";
                type = "HQ";
                commander = "";
                commanderRank = "";
                text = "%1 Platoon HQ";
                textShort = "%1 PLT HQ";
                color[] = {1,1,0,1};
                description = "Platoon HQ is the second highest command element. Platoons can be infantry, motorized and mechanized elements";

                class mmg {
                    side = "West";
                    size = "Size1";
                    type = "Support";
                    commander = "";
                    commanderRank = "";
                    text = "MMG";
                    textShort = "MMG";
                    color[] = {1,0.54,0,1};
                    description = "A squad level weapons element consisting of a Medium Machinegun team.";
                };

                class hmg {
                    side = "West";
                    size = "Size1";
                    type = "Support";
                    commander = "";
                    commanderRank = "";
                    text = "HMG";
                    textShort = "HMG";
                    color[] = {1,0.54,0,1};
                    description = "A squad level weapons element consisting of a Heavy Machinegun team.";
                };

                class mat {
                    side = "West";
                    size = "Size1";
                    type = "Support";
                    commander = "";
                    commanderRank = "";
                    text = "MAT";
                    textShort = "MAT";
                    color[] = {1,0.54,0,1};
                    description = "A squad level weapons element consisting of a Medium Anti-Tank team.";
                };

                class hat {
                    side = "West";
                    size = "Size1";
                    type = "Support";
                    commander = "";
                    commanderRank = "";
                    text = "HAT";
                    textShort = "HAT";
                    color[] = {1,0.54,0,1};
                    description = "A squad level weapons element consisting of a Heavy Anti-Tank team.";
                };

                class mortars {
                    side = "West";
                    size = "Size1";
                    type = "Mortar";
                    commander = "";
                    commanderRank = "";
                    text = "MORTARS";
                    textShort = "MORTARS";
                    color[] = {1,0.54,0,1};
                    description = "A squad level support element consisting of a mortar team.";
                };

                class romeo {
                    side = "West";
                    size = "Size1";
                    type = "Recon";
                    commander = "";
                    commanderRank = "";
                    text = "ROMEO";
                    textShort = "ROMEO";
                    color[] = {1,0.54,0,1};
                    description = "A squad level recon element consisting of a sniper team.";
                };

                class logi {
                    side = "West";
                    size = "Size1";
                    type = "Support";
                    commander = "";
                    commanderRank = "";
                    text = "LOGI";
                    textShort = "LOGI";
                    color[] = {1,0.54,0,1};
                    description = "A squad level logistics element consisting of a motorized team.";
                };

                class engi {
                    side = "West";
                    size = "Size1";
                    type = "Maintenance";
                    commander = "";
                    commanderRank = "";
                    text = "ENGI";
                    textShort = "ENGI";
                    color[] = {1,0.54,0,1};
                    description = "A squad level engineering element consisting of a motorized team.";
                };

                class asl {
                    side = "West";
                    size = "Squad";
                    type = "Infantry";
                    commander = "";
                    commanderRank = "";
                    text = "Alpha Squadlead";
                    textShort = "ASL";
                    color[] = {1,0,0,1};
                    description = "Alpha squadlead element.";

                    class a1 {
                        side = "West";
                        size = "Fireteam";
                        type = "Infantry";
                        commander = "";
                        commanderRank = "";
                        text = "ALPHA 1";
                        textShort = "A1";
                        color[] = {1,0,0,1};
                        description = "First alpha fireteam";
                    };

                    class a2 {
                        side = "West";
                        size = "Fireteam";
                        type = "Infantry";
                        commander = "";
                        commanderRank = "";
                        text = "ALPHA 2";
                        textShort = "A2";
                        color[] = {1,0,0,1};
                        description = "Second alpha fireteam";
                    };
                };


                class bsl {
                    side = "West";
                    size = "Squad";
                    type = "Infantry";
                    commander = "";
                    commanderRank = "";
                    text = "Bravo Squadlead";
                    textShort = "BSL";
                    color[] = {0,1,0,1};
                    description = "Bravo squadlead element.";

                    class b1 {
                        side = "West";
                        size = "Fireteam";
                        type = "Infantry";
                        commander = "";
                        commanderRank = "";
                        text = "BRAVO 1";
                        textShort = "B1";
                        color[] = {0,1,0,1};
                        description = "First bravo fireteam";
                    };

                    class b2 {
                        side = "West";
                        size = "Fireteam";
                        type = "Infantry";
                        commander = "";
                        commanderRank = "";
                        text = "BRAVO 2";
                        textShort = "B2";
                        color[] = {0,1,0,1};
                        description = "Second bravo fireteam";
                    };
                };


                class csl {
                    side = "West";
                    size = "Squad";
                    type = "Infantry";
                    commander = "";
                    commanderRank = "";
                    text = "Charlie Squadlead";
                    textShort = "CSL";
                    color[] = {0,0,1,1};
                    description = "Charlie squadlead element.";

                    class c1 {
                        side = "West";
                        size = "Fireteam";
                        type = "Infantry";
                        commander = "";
                        commanderRank = "";
                        text = "CHARLIE 1";
                        textShort = "C1";
                        color[] = {0,0,1,1};
                        description = "First charlie fireteam";
                    };

                    class c2 {
                        side = "West";
                        size = "Fireteam";
                        type = "Infantry";
                        commander = "";
                        commanderRank = "";
                        text = "CHARLIE 2";
                        textShort = "C2";
                        color[] = {0,0,1,1};
                        description = "Second charlie fireteam";
                    };
                };
            };

            class plt_hq_2 {
                id = 2;
                side = "West";
                size = "Platoon";
                type = "HQ";
                commander = "";
                commanderRank = "";
                text = "%1 Platoon HQ";
                textShort = "%1 PLT HQ";
                color[] = {1,1,0,1};
                description = "Platoon HQ second highest command element. There can be more than one platoon per operation. plattons can be infantry, motorized and mechanized elements";

                class mmg {
                    side = "West";
                    size = "Size1";
                    type = "Support";
                    commander = "";
                    commanderRank = "";
                    text = "MMG";
                    textShort = "MMG";
                    color[] = {1,0.54,0,1};
                    description = "A squad level weapons element consisting of a Medium Machinegun team.";
                };

                class hmg {
                    side = "West";
                    size = "Size1";
                    type = "Support";
                    commander = "";
                    commanderRank = "";
                    text = "HMG";
                    textShort = "HMG";
                    color[] = {1,0.54,0,1};
                    description = "A squad level weapons element consisting of a Heavy Machinegun team.";
                };

                class mat {
                    side = "West";
                    size = "Size1";
                    type = "Support";
                    commander = "";
                    commanderRank = "";
                    text = "MAT";
                    textShort = "MAT";
                    color[] = {1,0.54,0,1};
                    description = "A squad level weapons element consisting of a Medium Anti-Tank team.";
                };

                class hat {
                    side = "West";
                    size = "Size1";
                    type = "Support";
                    commander = "";
                    commanderRank = "";
                    text = "HAT";
                    textShort = "HAT";
                    color[] = {1,0.54,0,1};
                    description = "A squad level weapons element consisting of a Heavy Anti-Tank team.";
                };

                class mortars {
                    side = "West";
                    size = "Size1";
                    type = "Mortar";
                    commander = "";
                    commanderRank = "";
                    text = "MORTARS";
                    textShort = "MORTARS";
                    color[] = {1,0.54,0,1};
                    description = "A squad level support element consisting of a mortar team.";
                };

                class romeo {
                    side = "West";
                    size = "Size1";
                    type = "Recon";
                    commander = "";
                    commanderRank = "";
                    text = "ROMEO";
                    textShort = "ROMEO";
                    color[] = {1,0.54,0,1};
                    description = "A squad level recon element consisting of a sniper team.";
                };

                class logi {
                    side = "West";
                    size = "Size1";
                    type = "Support";
                    commander = "";
                    commanderRank = "";
                    text = "LOGI";
                    textShort = "LOGI";
                    color[] = {1,0.54,0,1};
                    description = "A squad level logistics element consisting of a motorized team.";
                };

                class engi {
                    side = "West";
                    size = "Size1";
                    type = "Maintenance";
                    commander = "";
                    commanderRank = "";
                    text = "ENGI";
                    textShort = "ENGI";
                    color[] = {1,0.54,0,1};
                    description = "A squad level engineering element consisting of a motorized team.";
                };

                class asl {
                    side = "West";
                    size = "Squad";
                    type = "Infantry";
                    commander = "";
                    commanderRank = "";
                    text = "Alpha Squadlead";
                    textShort = "ASL";
                    color[] = {1,0,0,1};
                    description = "Alpha squadlead element.";

                    class a1 {
                        side = "West";
                        size = "Fireteam";
                        type = "Infantry";
                        commander = "";
                        commanderRank = "";
                        text = "ALPHA 1";
                        textShort = "A1";
                        color[] = {1,0,0,1};
                        description = "First alpha fireteam";
                    };

                    class a2 {
                        side = "West";
                        size = "Fireteam";
                        type = "Infantry";
                        commander = "";
                        commanderRank = "";
                        text = "ALPHA 2";
                        textShort = "A2";
                        color[] = {1,0,0,1};
                        description = "Second alpha fireteam";
                    };
                };


                class bsl {
                    side = "West";
                    size = "Squad";
                    type = "Infantry";
                    commander = "";
                    commanderRank = "";
                    text = "Bravo Squadlead";
                    textShort = "BSL";
                    color[] = {0,1,0,1};
                    description = "Bravo squadlead element.";

                    class b1 {
                        side = "West";
                        size = "Fireteam";
                        type = "Infantry";
                        commander = "";
                        commanderRank = "";
                        text = "BRAVO 1";
                        textShort = "B1";
                        color[] = {0,1,0,1};
                        description = "First bravo fireteam";
                    };

                    class b2 {
                        side = "West";
                        size = "Fireteam";
                        type = "Infantry";
                        commander = "";
                        commanderRank = "";
                        text = "BRAVO 2";
                        textShort = "B2";
                        color[] = {0,1,0,1};
                        description = "Second bravo fireteam";
                    };
                };


                class csl {
                    side = "West";
                    size = "Squad";
                    type = "Infantry";
                    commander = "";
                    commanderRank = "";
                    text = "Charlie Squadlead";
                    textShort = "CSL";
                    color[] = {0,0,1,1};
                    description = "Charlie squadlead element.";

                    class c1 {
                        side = "West";
                        size = "Fireteam";
                        type = "Infantry";
                        commander = "";
                        commanderRank = "";
                        text = "CHARLIE 1";
                        textShort = "C1";
                        color[] = {0,0,1,1};
                        description = "First charlie fireteam";
                    };

                    class c2 {
                        side = "West";
                        size = "Fireteam";
                        type = "Infantry";
                        commander = "";
                        commanderRank = "";
                        text = "CHARLIE 2";
                        textShort = "C2";
                        color[] = {0,0,1,1};
                        description = "Second charlie fireteam";
                    };
                };
            };
        };
    };
};
