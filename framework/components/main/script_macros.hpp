#include "script_mod.hpp"

#define DOUBLES(var1,var2) var1##_##var2
#define TRIPLES(var1,var2,var3) var1##_##var2##_##var3
#define QUOTE(var1) #var1

#define COMPONENT DOUBLES(PREFIX,MODULE)

#define FORMAT_1(STR,ARG1) format[STR, ARG1]
#define FORMAT_2(STR,ARG1,ARG2) format[STR, ARG1, ARG2]
#define FORMAT_3(STR,ARG1,ARG2,ARG3) format[STR, ARG1, ARG2, ARG3]
#define FORMAT_4(STR,ARG1,ARG2,ARG3,ARG4) format[STR, ARG1, ARG2, ARG3, ARG4]
#define FORMAT_5(STR,ARG1,ARG2,ARG3,ARG4,ARG5) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5]
#define FORMAT_6(STR,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5, ARG6]
#define FORMAT_7(STR,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7]
#define FORMAT_8(STR,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7, ARG8]

#define GVAR(var1) TRIPLES(PREFIX,MODULE,var1)
#define EGVAR(var1,var2) TRIPLES(PREFIX,var1,var2)
#define QGVAR(var1) QUOTE(GVAR(var1))
#define QEGVAR(var1,var2) QUOTE(EGVAR(var1,var2))
#define QQGVAR(var1) QUOTE(QGVAR(var1))
#define QQEGVAR(var1,var2) QUOTE(QEGVAR(var1,var2))

// @TODO: replace ACE, CBA and BIS functions with these macros
#define ACEFUNC(var1,var2) TRIPLES(DOUBLES(ace,var1),fnc,var2)
#define CBAFUNC(var1) TRIPLES(CBA,fnc,var1)
#define BISFUNC(var1) TRIPLES(BIS,fnc,var1)

#define FUNC(var1) TRIPLES(DOUBLES(PREFIX,MODULE),fnc,var1)
#define FUNCMAIN(var1) TRIPLES(PREFIX,fnc,var1)
#define FUNC_INNER(var1,var2) TRIPLES(DOUBLES(PREFIX,var1),fnc,var2)
#define EFUNC(var1,var2) FUNC_INNER(var1,var2)
#define QFUNC(var1) QUOTE(FUNC(var1))
#define QFUNCMAIN(var1) QUOTE(FUNCMAIN(var1))
#define QFUNC_INNER(var1,var2) QUOTE(FUNC_INNER(var1,var2))
#define QEFUNC(var1,var2) QUOTE(EFUNC(var1,var2))
#define QQFUNC(var1) QUOTE(QFUNC(var1))
#define QQFUNCMAIN(var1) QUOTE(QFUNCMAIN(var1))
#define QQFUNC_INNER(var1,var2) QUOTE(QFUNC_INNER(var1,var2))
#define QQEFUNC(var1,var2) QUOTE(QEFUNC(var1,var2))

#ifndef PATHTO_SYS
    #define PATHTO_SYS(var1,var2) components\var1\functions\var2.sqf
#endif

#ifndef PATHTOF_SYS
    #define PATHTOF_SYS(var1,var2) components\var1\var2
#endif

#define DSTRING(var1) QUOTE(TRIPLES(STR,COMPONENT,var1))
#define EDSTRING(var1,var2) QUOTE(TRIPLES(STR,DOUBLES(PREFIX,var1),var2))
#define LSTRING(var1) ([QUOTE(PATHTOF_SYS(MODULE,stringtable.sqf)), DSTRING(var1)] call EFUNC(main,localize))
#define ELSTRING(var1,var2) ([QUOTE(PATHTOF_SYS(var1,stringtable.sqf)), EDSTRING(var1,var2)] call EFUNC(main,localize))

#define ARRAY_FLATTEN(var1) (flatten var1)

#define PREP_SYS(var1) TRIPLES(DOUBLES(PREFIX,MODULE),fnc,var1) = compile preProcessFileLineNumbers 'PATHTO_SYS(MODULE,DOUBLES(fn,var1))'

#define PREP_MODULE(var1) if (((count REQUIRED_MODULES) == 0) || count (REQUIRED_MODULES - EGVAR(main,components)) == 0) then {\
    PREP_SYS(var1)\
} else {\
    FUNC(var1) = { ERROR_2("%1 missing required modules: %2.", QFUNC(var1), REQUIRED_MODULES - EGVAR(main,components)) }\
}
#define PREP_ADDON(var1) if (((count REQUIRED_ADDONS) == 0) || REQUIRED_ADDONS findIf {!isClass(configFile >> "CfgPatches" >> _x)} == -1) then {\
    PREP_MODULE(var1)\
} else {\
    FUNC(var1) = {ERROR_1("%1 missing a required addon.",QFUNC(var1))}\
}

#define PREP(var1) if (!is3DEN) then { PREP_ADDON(var1) } else { PREP_SYS(var1) }
#define IPREP(var1) PREP(var1); if (!is3DEN) then { [] spawn { waitUntil { missionNamespace getVariable [QEGVAR(main,components_initialized), false] }; [true] spawn FUNC(var1)} } else { [true] spawn FUNC(var1) }

#define FILE_EXISTS(FILE) (fileExists (FILE))

#define MISSION_PATH(FILE) (getMissionPath (FILE))

#define CONFIG_PARAM_1(ARG1) ([[QUOTE(ARG1)]] call EFUNC(common,getConfigParam))
#define CONFIG_PARAM_2(ARG1, ARG2) ([[QUOTE(ARG1), QUOTE(ARG2)]] call EFUNC(common,getConfigParam))
#define CONFIG_PARAM_3(ARG1, ARG2, ARG3) ([[QUOTE(ARG1), QUOTE(ARG2), QUOTE(ARG3)]] call EFUNC(common,getConfigParam))
#define CONFIG_PARAM_4(ARG1, ARG2, ARG3, ARG4) ([[QUOTE(ARG1), QUOTE(ARG2), QUOTE(ARG3), QUOTE(ARG4)]] call EFUNC(common,getConfigParam))
#define CONFIG_PARAM_5(ARG1, ARG2, ARG3, ARG4, ARG5) ([[QUOTE(ARG1), QUOTE(ARG2), QUOTE(ARG3), QUOTE(ARG4), QUOTE(ARG5)]] call EFUNC(common,getConfigParam))
#define CONFIG_PARAM_6(ARG1, ARG2, ARG3, ARG4, ARG5, ARG6) ([[QUOTE(ARG1), QUOTE(ARG2), QUOTE(ARG3), QUOTE(ARG4), QUOTE(ARG5), QUOTE(ARG6)]] call EFUNC(common,getConfigParam))
#define CONFIG_PARAM_7(ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7) ([[QUOTE(ARG1), QUOTE(ARG2), QUOTE(ARG3), QUOTE(ARG4), QUOTE(ARG5), QUOTE(ARG6), QUOTE(ARG7)]] call EFUNC(common,getConfigParam))
#define CONFIG_PARAM_8(ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7, ARG8) ([[QUOTE(ARG1), QUOTE(ARG2), QUOTE(ARG3), QUOTE(ARG4), QUOTE(ARG5), QUOTE(ARG6), QUOTE(ARG7), QUOTE(ARG8)]] call EFUNC(common,getConfigParam))

#define CREATE_HASH_FROM_ARRAY(var1) (createHashMapFromArray var1)

#define SCRIPT(NAME) scriptName 'components\MODULE\NAME'
#define ESCRIPT(var1, NAME) scriptName 'var1\MODULE\NAME'

#define IS_META_SYS(VAR,TYPE) (if (isNil {VAR}) then {false} else {(VAR) isEqualType TYPE})
#define IS_ARRAY(VAR)    IS_META_SYS(VAR,[])
#define IS_HASHMAP(VAR)  IS_META_SYS(VAR,createhashMap)
#define IS_BOOL(VAR)     IS_META_SYS(VAR,false)
#define IS_CODE(VAR)     IS_META_SYS(VAR,{})
#define IS_CONFIG(VAR)   IS_META_SYS(VAR,configNull)
#define IS_CONTROL(VAR)  IS_META_SYS(VAR,controlNull)
#define IS_DISPLAY(VAR)  IS_META_SYS(VAR,displayNull)
#define IS_GROUP(VAR)    IS_META_SYS(VAR,grpNull)
#define IS_OBJECT(VAR)   IS_META_SYS(VAR,objNull)
#define IS_SCALAR(VAR)   IS_META_SYS(VAR,0)
#define IS_SCRIPT(VAR)   IS_META_SYS(VAR,scriptNull)
#define IS_SIDE(VAR)     IS_META_SYS(VAR,west)
#define IS_STRING(VAR)   IS_META_SYS(VAR,"STRING")
#define IS_TEXT(VAR)     IS_META_SYS(VAR,text "")
#define IS_LOCATION(VAR) IS_META_SYS(VAR,locationNull)

#define IS_BOOLEAN(VAR)  IS_BOOL(VAR)
#define IS_FUNCTION(VAR) IS_CODE(VAR)
#define IS_INTEGER(VAR)  (if (IS_SCALAR(VAR)) then {floor (VAR) == (VAR)} else {false})
#define IS_NUMBER(VAR)   IS_SCALAR(VAR)

///////////////////////////////////////// DEBUGGING ////////////////////////////////////////

/* -------------------------------------------
Macros: DEBUG_MODE_x
    Managing debugging based on debug level.
    According to the *highest* level of debugging that has been defined *before* script_macros_common.hpp is included,
    only the appropriate debugging commands will be functional. With no level explicitely defined, assume DEBUG_MODE_NORMAL.
    DEBUG_MODE_FULL - Full debugging output.
    DEBUG_MODE_NORMAL - All debugging except <TRACE_n()> and <LOG()> (Default setting if none specified).
    DEBUG_MODE_MINIMAL - Only <ERROR()> and <ERROR_WITH_TITLE()> enabled.
------------------------------------------- */

// If DEBUG_MODE_FULL, then also enable DEBUG_MODE_NORMAL.
#ifdef DEBUG_MODE_FULL
    #define DEBUG_MODE_NORMAL
#endif

// If DEBUG_MODE_NORMAL, then also enable DEBUG_MODE_MINIMAL.
#ifdef DEBUG_MODE_NORMAL
    #define DEBUG_MODE_MINIMAL
#endif

// If no debug modes specified, use DEBUG_MODE_NORMAL (+ DEBUG_MODE_MINIMAL).
#ifndef DEBUG_MODE_MINIMAL
    #define DEBUG_MODE_NORMAL
    #define DEBUG_MODE_MINIMAL
#endif

#define LOG_SYS_FORMAT(LEVEL,MESSAGE) format ['[%1] (%2) %3: %4', toUpper 'PREFIX', 'MODULE', LEVEL, MESSAGE]

// if defined use Synchronus debug (log immediatly instead of queing)
#ifdef DEBUG_SYNCHRONOUS
    #define LOG_RPT(LEVEL,MESSAGE) diag_log text LOG_SYS_FORMAT(LEVEL,MESSAGE)
#else
    #define LOG_RPT(LEVEL,MESSAGE) LOG_SYS_FORMAT(LEVEL,MESSAGE) call CBA_fnc_log
#endif

// if defined should log to systemChat aswell
#ifdef DEBUG_SYSTEMCHAT
    #define LOG_SYS(LEVEL,MESSAGE) LOG_RPT(LEVEL,MESSAGE); systemChat str LOG_SYS_FORMAT(LEVEL,MESSAGE)
#else
    #define LOG_SYS(LEVEL,MESSAGE) LOG_RPT(LEVEL,MESSAGE)
#endif

#define LOG_SYS_FILELINENUMBERS(LEVEL,MESSAGE) LOG_SYS(LEVEL,format [ARR_4('%1 %2:%3',MESSAGE,__FILE__,__LINE__ + 1)])

/* -------------------------------------------
Macro: LOG()
    Log a debug message into the RPT log.
    Only run if <DEBUG_MODE_FULL> is defined.
Parameters:
    MESSAGE - Message to record <STRING>
------------------------------------------- */
#ifdef DEBUG_MODE_FULL
    #define LOG(MESSAGE) LOG_SYS('LOG',MESSAGE)
    #define LOG_1(MESSAGE,ARG1) LOG(FORMAT_1(MESSAGE,ARG1))
    #define LOG_2(MESSAGE,ARG1,ARG2) LOG(FORMAT_2(MESSAGE,ARG1,ARG2))
    #define LOG_3(MESSAGE,ARG1,ARG2,ARG3) LOG(FORMAT_3(MESSAGE,ARG1,ARG2,ARG3))
    #define LOG_4(MESSAGE,ARG1,ARG2,ARG3,ARG4) LOG(FORMAT_4(MESSAGE,ARG1,ARG2,ARG3,ARG4))
    #define LOG_5(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5) LOG(FORMAT_5(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5))
    #define LOG_6(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6) LOG(FORMAT_6(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6))
    #define LOG_7(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7) LOG(FORMAT_7(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7))
    #define LOG_8(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8) LOG(FORMAT_8(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8))
#else
    #define LOG(MESSAGE) /* disabled */
    #define LOG_1(MESSAGE,ARG1) /* disabled */
    #define LOG_2(MESSAGE,ARG1,ARG2) /* disabled */
    #define LOG_3(MESSAGE,ARG1,ARG2,ARG3) /* disabled */
    #define LOG_4(MESSAGE,ARG1,ARG2,ARG3,ARG4) /* disabled */
    #define LOG_5(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5) /* disabled */
    #define LOG_6(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6) /* disabled */
    #define LOG_7(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7) /* disabled */
    #define LOG_8(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8) /* disabled */
#endif

/* -------------------------------------------
Macro: INFO()
    Record a message without file and line number in the RPT log.
Parameters:
    MESSAGE - Message to record <STRING>
------------------------------------------- */
#define INFO(MESSAGE) LOG_SYS('INFO',MESSAGE)
#define INFO_1(MESSAGE,ARG1) INFO(FORMAT_1(MESSAGE,ARG1))
#define INFO_2(MESSAGE,ARG1,ARG2) INFO(FORMAT_2(MESSAGE,ARG1,ARG2))
#define INFO_3(MESSAGE,ARG1,ARG2,ARG3) INFO(FORMAT_3(MESSAGE,ARG1,ARG2,ARG3))
#define INFO_4(MESSAGE,ARG1,ARG2,ARG3,ARG4) INFO(FORMAT_4(MESSAGE,ARG1,ARG2,ARG3,ARG4))
#define INFO_5(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5) INFO(FORMAT_5(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5))
#define INFO_6(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6) INFO(FORMAT_6(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6))
#define INFO_7(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7) INFO(FORMAT_7(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7))
#define INFO_8(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8) INFO(FORMAT_8(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8))

/* -------------------------------------------
Macro: WARNING()
    Record a non-critical error in the RPT log.
    Only run if <DEBUG_MODE_NORMAL> or higher is defined.
Parameters:
    MESSAGE - Message to record <STRING>
------------------------------------------- */
#ifdef DEBUG_MODE_NORMAL
    #define WARNING(MESSAGE) LOG_SYS('WARNING',MESSAGE)
    #define WARNING_1(MESSAGE,ARG1) WARNING(FORMAT_1(MESSAGE,ARG1))
    #define WARNING_2(MESSAGE,ARG1,ARG2) WARNING(FORMAT_2(MESSAGE,ARG1,ARG2))
    #define WARNING_3(MESSAGE,ARG1,ARG2,ARG3) WARNING(FORMAT_3(MESSAGE,ARG1,ARG2,ARG3))
    #define WARNING_4(MESSAGE,ARG1,ARG2,ARG3,ARG4) WARNING(FORMAT_4(MESSAGE,ARG1,ARG2,ARG3,ARG4))
    #define WARNING_5(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5) WARNING(FORMAT_5(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5))
    #define WARNING_6(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6) WARNING(FORMAT_6(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6))
    #define WARNING_7(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7) WARNING(FORMAT_7(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7))
    #define WARNING_8(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8) WARNING(FORMAT_8(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8))
#else
    #define WARNING(MESSAGE) /* disabled */
    #define WARNING_1(MESSAGE,ARG1) /* disabled */
    #define WARNING_2(MESSAGE,ARG1,ARG2) /* disabled */
    #define WARNING_3(MESSAGE,ARG1,ARG2,ARG3) /* disabled */
    #define WARNING_4(MESSAGE,ARG1,ARG2,ARG3,ARG4) /* disabled */
    #define WARNING_5(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5) /* disabled */
    #define WARNING_6(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6) /* disabled */
    #define WARNING_7(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7) /* disabled */
    #define WARNING_8(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8) /* disabled */
#endif

/* -------------------------------------------
Macro: ERROR()
    Record a critical error in the RPT log.
Parameters:
    MESSAGE -  Message to record <STRING>
------------------------------------------- */
#define ERROR(MESSAGE) LOG_SYS('ERROR',MESSAGE)
#define ERROR_1(MESSAGE,ARG1) ERROR(FORMAT_1(MESSAGE,ARG1))
#define ERROR_2(MESSAGE,ARG1,ARG2) ERROR(FORMAT_2(MESSAGE,ARG1,ARG2))
#define ERROR_3(MESSAGE,ARG1,ARG2,ARG3) ERROR(FORMAT_3(MESSAGE,ARG1,ARG2,ARG3))
#define ERROR_4(MESSAGE,ARG1,ARG2,ARG3,ARG4) ERROR(FORMAT_4(MESSAGE,ARG1,ARG2,ARG3,ARG4))
#define ERROR_5(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5) ERROR(FORMAT_5(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5))
#define ERROR_6(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6) ERROR(FORMAT_6(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6))
#define ERROR_7(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7) ERROR(FORMAT_7(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7))
#define ERROR_8(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8) ERROR(FORMAT_8(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8))

/* -------------------------------------------
Macro: ERROR_MSG()
    Record a critical error in the RPT log and display on screen error message.
    Newlines (\n) in the MESSAGE will be put on separate lines.
Parameters:
    MESSAGE -  Message to record <STRING>
------------------------------------------- */
#define ERROR_MSG(MESSAGE) ['PREFIX', 'COMPONENT', nil, MESSAGE, __FILE__, __LINE__ + 1] call CBA_fnc_error
#define ERROR_MSG_1(MESSAGE,ARG1) ERROR_MSG(FORMAT_1(MESSAGE,ARG1))
#define ERROR_MSG_2(MESSAGE,ARG1,ARG2) ERROR_MSG(FORMAT_2(MESSAGE,ARG1,ARG2))
#define ERROR_MSG_3(MESSAGE,ARG1,ARG2,ARG3) ERROR_MSG(FORMAT_3(MESSAGE,ARG1,ARG2,ARG3))
#define ERROR_MSG_4(MESSAGE,ARG1,ARG2,ARG3,ARG4) ERROR_MSG(FORMAT_4(MESSAGE,ARG1,ARG2,ARG3,ARG4))
#define ERROR_MSG_5(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5) ERROR_MSG(FORMAT_5(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5))
#define ERROR_MSG_6(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6) ERROR_MSG(FORMAT_6(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6))
#define ERROR_MSG_7(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7) ERROR_MSG(FORMAT_7(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7))
#define ERROR_MSG_8(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8) ERROR_MSG(FORMAT_8(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8))

/* -------------------------------------------
Macro: ERROR_WITH_TITLE()
    Record a critical error in the RPT log.
    The title can be specified (in <ERROR()> the heading is always just "ERROR")
    Newlines (\n) in the MESSAGE will be put on separate lines.
Parameters:
    TITLE - Title of error message <STRING>
    MESSAGE -  Body of error message <STRING>
------------------------------------------- */
#define ERROR_WITH_TITLE(TITLE,MESSAGE) ['PREFIX', 'COMPONENT', TITLE, MESSAGE, __FILE__, __LINE__ + 1] call CBA_fnc_error
#define ERROR_WITH_TITLE_1(TITLE,MESSAGE,ARG1) ERROR_WITH_TITLE(TITLE,FORMAT_1(MESSAGE,ARG1))
#define ERROR_WITH_TITLE_2(TITLE,MESSAGE,ARG1,ARG2) ERROR_WITH_TITLE(TITLE,FORMAT_2(MESSAGE,ARG1,ARG2))
#define ERROR_WITH_TITLE_3(TITLE,MESSAGE,ARG1,ARG2,ARG3) ERROR_WITH_TITLE(TITLE,FORMAT_3(MESSAGE,ARG1,ARG2,ARG3))
#define ERROR_WITH_TITLE_4(TITLE,MESSAGE,ARG1,ARG2,ARG3,ARG4) ERROR_WITH_TITLE(TITLE,FORMAT_4(MESSAGE,ARG1,ARG2,ARG3,ARG4))
#define ERROR_WITH_TITLE_5(TITLE,MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5) ERROR_WITH_TITLE(TITLE,FORMAT_5(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5))
#define ERROR_WITH_TITLE_6(TITLE,MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6) ERROR_WITH_TITLE(TITLE,FORMAT_6(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6))
#define ERROR_WITH_TITLE_7(TITLE,MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7) ERROR_WITH_TITLE(TITLE,FORMAT_7(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7))
#define ERROR_WITH_TITLE_8(TITLE,MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8) ERROR_WITH_TITLE(TITLE,FORMAT_8(MESSAGE,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8))

/* -------------------------------------------
Macro: MESSAGE_WITH_TITLE()
    Record a single line in the RPT log.
Parameters:
    TITLE - Title of log message <STRING>
    MESSAGE -  Body of message <STRING>
------------------------------------------- */
#define MESSAGE_WITH_TITLE(TITLE,MESSAGE) LOG_SYS_FILELINENUMBERS(TITLE,MESSAGE)

/* -------------------------------------------
Macro: RETDEF()
    If a variable is undefined, return the default value. Otherwise, return the
    variable itself.
Parameters:
    VARIABLE - the variable to check
    DEFAULT_VALUE - the default value to use if variable is undefined
------------------------------------------- */
#define RETDEF(VARIABLE,DEFAULT_VALUE) (if (isNil {VARIABLE}) then [{DEFAULT_VALUE}, {VARIABLE}])

/* -------------------------------------------
Macro: RETNIL()
    If a variable is undefined, return the value nil. Otherwise, return the
    variable itself.
Parameters:
    VARIABLE - the variable to check
------------------------------------------- */
#define RETNIL(VARIABLE) RETDEF(VARIABLE,nil)

/* -------------------------------------------
Macros: TRACE_n()
    Log a message and 1-8 variables to the RPT log.
    Only run if <DEBUG_MODE_FULL> is defined.
    TRACE_1(MESSAGE,A) - Log 1 variable.
    TRACE_2(MESSAGE,A,B) - Log 2 variables.
    TRACE_3(MESSAGE,A,B,C) - Log 3 variables.
    TRACE_4(MESSAGE,A,B,C,D) - Log 4 variables.
    TRACE_5(MESSAGE,A,B,C,D,E) - Log 5 variables.
    TRACE_6(MESSAGE,A,B,C,D,E,F) - Log 6 variables.
    TRACE_7(MESSAGE,A,B,C,D,E,F,G) - Log 7 variables.
    TRACE_8(MESSAGE,A,B,C,D,E,F,G,H) - Log 8 variables.
    TRACE_9(MESSAGE,A,B,C,D,E,F,G,H,I) - Log 9 variables.
Parameters:
    MESSAGE -  Message to add to the trace [String]
    A..H - Variable names to log values of [Any]
------------------------------------------- */
#define PFORMAT_1(MESSAGE,A) \
    format ['%1: A=%2', MESSAGE, RETNIL(A)]
#define PFORMAT_2(MESSAGE,A,B) \
    format ['%1: A=%2, B=%3', MESSAGE, RETNIL(A), RETNIL(B)]
#define PFORMAT_3(MESSAGE,A,B,C) \
    format ['%1: A=%2, B=%3, C=%4', MESSAGE, RETNIL(A), RETNIL(B), RETNIL(C)]
#define PFORMAT_4(MESSAGE,A,B,C,D) \
    format ['%1: A=%2, B=%3, C=%4, D=%5', MESSAGE, RETNIL(A), RETNIL(B), RETNIL(C), RETNIL(D)]
#define PFORMAT_5(MESSAGE,A,B,C,D,E) \
    format ['%1: A=%2, B=%3, C=%4, D=%5, E=%6', MESSAGE, RETNIL(A), RETNIL(B), RETNIL(C), RETNIL(D), RETNIL(E)]
#define PFORMAT_6(MESSAGE,A,B,C,D,E,F) \
    format ['%1: A=%2, B=%3, C=%4, D=%5, E=%6, F=%7', MESSAGE, RETNIL(A), RETNIL(B), RETNIL(C), RETNIL(D), RETNIL(E), RETNIL(F)]
#define PFORMAT_7(MESSAGE,A,B,C,D,E,F,G) \
    format ['%1: A=%2, B=%3, C=%4, D=%5, E=%6, F=%7, G=%8', MESSAGE, RETNIL(A), RETNIL(B), RETNIL(C), RETNIL(D), RETNIL(E), RETNIL(F), RETNIL(G)]
#define PFORMAT_8(MESSAGE,A,B,C,D,E,F,G,H) \
    format ['%1: A=%2, B=%3, C=%4, D=%5, E=%6, F=%7, G=%8, H=%9', MESSAGE, RETNIL(A), RETNIL(B), RETNIL(C), RETNIL(D), RETNIL(E), RETNIL(F), RETNIL(G), RETNIL(H)]
#define PFORMAT_9(MESSAGE,A,B,C,D,E,F,G,H,I) \
    format ['%1: A=%2, B=%3, C=%4, D=%5, E=%6, F=%7, G=%8, H=%9, I=%10', MESSAGE, RETNIL(A), RETNIL(B), RETNIL(C), RETNIL(D), RETNIL(E), RETNIL(F), RETNIL(G), RETNIL(H), RETNIL(I)]


#ifdef DEBUG_MODE_FULL
    #define TRACE_1(MESSAGE,A) LOG_SYS_FILELINENUMBERS('TRACE',PFORMAT_1(str diag_frameNo + ' ' + (MESSAGE),A))
    #define TRACE_2(MESSAGE,A,B) LOG_SYS_FILELINENUMBERS('TRACE',PFORMAT_2(str diag_frameNo + ' ' + (MESSAGE),A,B))
    #define TRACE_3(MESSAGE,A,B,C) LOG_SYS_FILELINENUMBERS('TRACE',PFORMAT_3(str diag_frameNo + ' ' + (MESSAGE),A,B,C))
    #define TRACE_4(MESSAGE,A,B,C,D) LOG_SYS_FILELINENUMBERS('TRACE',PFORMAT_4(str diag_frameNo + ' ' + (MESSAGE),A,B,C,D))
    #define TRACE_5(MESSAGE,A,B,C,D,E) LOG_SYS_FILELINENUMBERS('TRACE',PFORMAT_5(str diag_frameNo + ' ' + (MESSAGE),A,B,C,D,E))
    #define TRACE_6(MESSAGE,A,B,C,D,E,F) LOG_SYS_FILELINENUMBERS('TRACE',PFORMAT_6(str diag_frameNo + ' ' + (MESSAGE),A,B,C,D,E,F))
    #define TRACE_7(MESSAGE,A,B,C,D,E,F,G) LOG_SYS_FILELINENUMBERS('TRACE',PFORMAT_7(str diag_frameNo + ' ' + (MESSAGE),A,B,C,D,E,F,G))
    #define TRACE_8(MESSAGE,A,B,C,D,E,F,G,H) LOG_SYS_FILELINENUMBERS('TRACE',PFORMAT_8(str diag_frameNo + ' ' + (MESSAGE),A,B,C,D,E,F,G,H))
    #define TRACE_9(MESSAGE,A,B,C,D,E,F,G,H,I) LOG_SYS_FILELINENUMBERS('TRACE',PFORMAT_9(str diag_frameNo + ' ' + (MESSAGE),A,B,C,D,E,F,G,H,I))
#else
    #define TRACE_1(MESSAGE,A) /* disabled */
    #define TRACE_2(MESSAGE,A,B) /* disabled */
    #define TRACE_3(MESSAGE,A,B,C) /* disabled */
    #define TRACE_4(MESSAGE,A,B,C,D) /* disabled */
    #define TRACE_5(MESSAGE,A,B,C,D,E) /* disabled */
    #define TRACE_6(MESSAGE,A,B,C,D,E,F) /* disabled */
    #define TRACE_7(MESSAGE,A,B,C,D,E,F,G) /* disabled */
    #define TRACE_8(MESSAGE,A,B,C,D,E,F,G,H) /* disabled */
    #define TRACE_9(MESSAGE,A,B,C,D,E,F,G,H,I) /* disabled */
#endif
