#include "script_component.hpp"

/* Create CMF Info Diary */
[] spawn FUNC(diary);

/* Remove statistics diary */
cmf_player removeDiarySubject "Statistics";

/* Remove team diary */
cmf_player removeDiarySubject "Units";