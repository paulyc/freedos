/*
    This file is part of SUPPL - the supplemental library for DOS
    Copyright (C) 1996-2000 Steffen Kaiser

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Library General Public
    License as published by the Free Software Foundation; either
    version 2 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Library General Public License for more details.

    You should have received a copy of the GNU Library General Public
    License along with this library; if not, write to the Free
    Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/
/* $RCSfile$
   $Locker$	$Name$	$State$

ob(ject): suppl_log_item_enabled
su(bsystem): debug
ty(pe): 
sy(nopsis): 
sh(ort description): Check if an item is enabled
he(ader files): 
lo(ng description): Checks if 1) logging is enabled at all, 2) the nesting
	level permits logging, 3) the function name logging is passed, and 4)
	if the item is enabled according the given list.
pr(erequistes): str != NULL && list != NULL
va(lue): 0: disabled
	\item else: enabled
re(lated to):  suppl_log_match_list
se(condary subsystems): 
xr(ef): 
im(port): 
fi(le): 
in(itialized by): 
wa(rning): 
bu(gs): 
co(mpilers): 

*/

#include "initsupl.loc"

#ifndef _MICROC_
#include <string.h>
#endif
#include <portable.h>

#include "suppldbg.loc"

#ifdef RCS_Version
static char const rcsid[] = 
	"$Id$";
#endif

int suppl_log_item_enabled(suppl_log_list_t *list
	, suppl_log_csptr_t str)
{	return S(enabled)			/* logging enabled at all */
	 && suppl_l_nestlevel <= S(maxdepth)
	 && suppl_l_fct_enabled
	 && suppl_log_match_list(list, str);
}
