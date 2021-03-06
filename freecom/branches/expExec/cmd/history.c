/*	$id$
	$Locker$	$Name$	$State$

	command line history

	This file bases on HISTORY.C of FreeCOM v0.81 beta 1.

	$Log$
	Revision 1.1.4.1  2001/07/05 22:18:34  skaus
	Update #5

	Revision 1.1  2001/04/12 00:09:06  skaus
	chg: New structure
	chg: If DEBUG enabled, no available commands are displayed on startup
	fix: PTCHSIZE also patches min extra size to force to have this amount
	   of memory available on start
	bugfix: CALL doesn't reset options
	add: PTCHSIZE to patch heap size
	add: VSPAWN, /SWAP switch, .SWP resource handling
	bugfix: COMMAND.COM A:\
	bugfix: CALL: if swapOnExec == ERROR, no change of swapOnExec allowed
	add: command MEMORY
	bugfix: runExtension(): destroys command[-2]
	add: clean.bat
	add: localized CRITER strings
	chg: use LNG files for hard-coded strings (hangForEver(), init.c)
		via STRINGS.LIB
	add: DEL.C, COPY.C, CBREAK.C: STRINGS-based prompts
	add: fixstrs.c: prompts & symbolic keys
	add: fixstrs.c: backslash escape sequences
	add: version IDs to DEFAULT.LNG and validation to FIXSTRS.C
	chg: splitted code apart into LIB\*.c and CMD\*.c
	bugfix: IF is now using error system & STRINGS to report errors
	add: CALL: /N
	
 */

#include "../config.h"

#include <stdlib.h>

#include "../include/command.h"
#include "../include/context.h"
#include "../strings.h"
#include "../err_fcts.h"

int cmd_history(char *param)
{
	if(param && *param) {
		unsigned long x;

		x = atol(param);
		if(x < 10 || x > 32768U) {
			error_history_size(param);
			return 1;
		}
		CTXT_INFO(CTXT_TAG_HISTORY, sizemax) = (unsigned)x;
		ctxtCreate();
		return 0;
	}

	return ctxtView(CTXT_TAG_HISTORY, TEXT_HISTORY_EMPTY);
}
