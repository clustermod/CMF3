#include "script_component.hpp"

/* Fix Loading Bug */
call EFUNC(utility,endLoadingScreen);

call FUNC(mapSwitchTextures);
call FUNC(resizeMapMarkers);
call FUNC(hideRespawnMarker);
call FUNC(restrictLauncher);
call FUNC(drinking);
call FUNC(spectator);
call FUNC(setRank);
call FUNC(treatment);