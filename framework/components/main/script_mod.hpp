#define FRAMEWORK CMF3
#define FRAMEWORK_BEAUTIFIED Cluster Mission Framework (CMF3)
#define PREFIX cmf

#include "script_version.hpp"

#define VERSION     MAJOR.MINOR
#define VERSION_STR (str MAJOR)+"."+(str MINOR)+"."+(str PATCHLVL)+"."+(str BUILD)
#define VERSION_AR  MAJOR,MINOR,PATCHLVL,BUILD

#define REQUIRED_VERSION 2.08
#define REQUIRED_CBA_VERSION {3,15,6}
