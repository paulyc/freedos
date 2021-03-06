/*	$id$
	$Locker$	$Name$	$State$

 * Name: ltrimcl() - left trims a string by removing leading spaces
 	The string itself is not changed.
 * Input: str - a pointer to a string
 * Output: returns a trimmed copy of str

	$Log$
	Revision 1.1  2001/04/29 11:33:51  skaus
	chg: default heap size (tools\ptchsize) set to 6KB
	chg: error displaying functions centralized into lib\err_fcts.src
	add: displayError()
	chg: all errors are displayed through functions void error_*()
	bugfix: somtimes error messages are not displayed (see displayError())
	bugfix: docommand(): type:file must pass ":file" to TYPE
	bugfix: error_sfile(): string _SFILE_
	bugfix: error message on empty redirection
	bugfix: comma and semicolon ';' are recognized as argument seperators
		of internal commands

 */

#include "../config.h"

#include <assert.h>
#include <ctype.h>
#include <string.h>

#include "../include/cmdline.h"

char *ltrimcl(const char *str)
{ char c;

  assert(str);

  while ((c = *str++) != '\0' && isargdelim(c))
    ;

  return (char *)str - 1;		/* strip const */
}
