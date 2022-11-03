/*
 * Author: Eric
 * Settings for enhanced vehicles
 */

class CfgEnhancedVehicles {
  damageModifier = 100;
  damageSpeed = 55;
  bumpSpeed = 10;

  class surfaceParams {
    class VRsurface {
      bump = 5;
      damage = 0;
    };
    class grass {
      bump = 100;
      damage = 5;
    };
    class softsand {
      bump = 50;
      damage = 5;
    };
    class hardsand {
      bump = 70;
      damage = 5;
    };
    class harddirt {
      bump = 80;
      damage = 15;
    };
    class softmud {
      bump = 40;
      damage = 5;
    };
    class forest {
      bump = 125;
      damage = 25;
    };
    class marsh {
      bump = 20;
      damage = 1;
    };
    class gravel {
      bump = 120;
      damage = 0;
    };
    class stony {
      bump = 120;
      damage = 80;
    };
    class icy {
      bump = 20;
      damage = 0;
    };
    class slipperySnow {
      bump = 80;
      damage = 5;
    };
    class thickSoftSnow {
      bump = 50;
      damage = 5;
    };
    class drygrass {
      bump = 100;
      damage = 5;
    };
  };
};
