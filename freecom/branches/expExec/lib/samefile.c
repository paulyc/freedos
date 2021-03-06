/*	$id$
	$Locker$	$Name$	$State$

	Return:
		-1: on out-of-memory error
		 0: if both true filenames differ
		 1: if both true filenames are the same

	This file bases on COPY.C of FreeCOM v0.81 beta 1.

	$Log$
	Revision 1.1.4.1  2001/07/05 22:18:34  skaus
	Update #5

	Revision 1.1  2001/04/12 00:33:53  skaus
	chg: new structure
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

#include <assert.h>
#include <stdlib.h>
#include <string.h>

#include <dfn.h>

#include "../include/misc.h"

int samefile(const char * const f1, const char * const f2)
{ char *t1, *t2;
  int differ;

  assert(f1);
  assert(f2);

  t1 = dfntruename(f1);
  t2 = dfntruename(f2);

  if(!t1 || !t2)
    differ = -1;
  else differ = strcmp(t1, t2) == 0;

  myfree(t1);
  myfree(t2);

  return differ;
}
