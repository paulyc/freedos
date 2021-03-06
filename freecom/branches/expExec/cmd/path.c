/*
 *  PATH.C - path command.
 *
 */

#include "../config.h"

#include <assert.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../include/cmdline.h"
#include "../include/command.h"
#include "../include/context.h"
#include "../strings.h"

#define PATHVAR    "PATH"

int cmd_path(char *param)
{	char *p;

	/* >>PATH ;<< must remove the string entirely */
	if(!param || !*(p = ltrimcl(param)) && !strchr(param, ';')) {
		p = getEnv(PATHVAR);
		displayString(p? TEXT_MSG_PATH: TEXT_MSG_PATH_NONE, p);
		return 0;
	}

	rtrimcl(p);			/* remove trailing spaces */
	return chgEnvRemove(PATHVAR, p);
}
