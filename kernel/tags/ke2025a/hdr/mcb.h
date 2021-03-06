/****************************************************************/
/*                                                              */
/*                           mcb.h                              */
/*                                                              */
/*     Memory Control Block data structures and declarations    */
/*                                                              */
/*                       November 23, 1991                      */
/*                                                              */
/*                      Copyright (c) 1995                      */
/*                      Pasquale J. Villani                     */
/*                      All Rights Reserved                     */
/*                                                              */
/* This file is part of DOS-C.                                  */
/*                                                              */
/* DOS-C is free software; you can redistribute it and/or       */
/* modify it under the terms of the GNU General Public License  */
/* as published by the Free Software Foundation; either version */
/* 2, or (at your option) any later version.                    */
/*                                                              */
/* DOS-C is distributed in the hope that it will be useful, but */
/* WITHOUT ANY WARRANTY; without even the implied warranty of   */
/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See    */
/* the GNU General Public License for more details.             */
/*                                                              */
/* You should have received a copy of the GNU General Public    */
/* License along with DOS-C; see the file COPYING.  If not,     */
/* write to the Free Software Foundation, 675 Mass Ave,         */
/* Cambridge, MA 02139, USA.                                    */
/****************************************************************/

#ifdef MAIN
#ifdef VERSION_STRINGS
static BYTE *mcb_hRcsId = "$Id$";
#endif
#endif

/*
 * $Log$
 * Revision 1.7  2001/04/15 03:21:50  bartoldeman
 * See history.txt for the list of fixes.
 *
 * Revision 1.6  2000/08/06 04:27:07  jimtabor
 * See history.txt
 *
 * Revision 1.5  2000/08/06 04:18:21  jimtabor
 * See history.txt
 *
 * Revision 1.4  2000/06/21 18:16:46  jimtabor
 * Add UMB code, patch, and code fixes
 *
 * Revision 1.3  2000/05/25 20:56:19  jimtabor
 * Fixed project history
 *
 * Revision 1.2  2000/05/08 04:28:22  jimtabor
 * Update CVS to 2020
 *
 * Revision 1.1.1.1  2000/05/06 19:34:53  jhall1
 * The FreeDOS Kernel.  A DOS kernel that aims to be 100% compatible with
 * MS-DOS.  Distributed under the GNU GPL.
 *
 * Revision 1.2  2000/03/09 06:06:38  kernel
 * 2017f updates by James Tabor
 *
 * Revision 1.1.1.1  1999/03/29 15:39:31  jprice
 * New version without IPL.SYS
 *
 * Revision 1.3  1999/02/01 01:40:06  jprice
 * Clean up
 *
 * Revision 1.2  1999/01/22 04:17:40  jprice
 * Formating
 *
 * Revision 1.1.1.1  1999/01/20 05:51:01  jprice
 * Imported sources
 *
 *
 *         Rev 1.5   04 Jan 1998 23:14:18   patv
 *      Changed Log for strip utility
 *
 *         Rev 1.4   29 May 1996 21:25:16   patv
 *      bug fixes for v0.91a
 *
 *         Rev 1.3   19 Feb 1996  3:15:32   patv
 *      Added NLS, int2f and config.sys processing
 *
 *         Rev 1.2   01 Sep 1995 17:35:42   patv
 *      First GPL release.
 *
 *         Rev 1.1   30 Jul 1995 20:43:50   patv
 *      Eliminated version strings in ipl
 *
 *         Rev 1.0   02 Jul 1995 10:39:46   patv
 *      Initial revision.
 */

#define LARGEST         -1
#define FIRST_FIT       0
#define BEST_FIT        1
#define LAST_FIT        2
#define FIRST_FIT_UO    0x40
#define BEST_FIT_UO     0x41
#define LAST_FIT_UO     0x42
#define FIRST_FIT_U     0x80
#define BEST_FIT_U      0x81
#define LAST_FIT_U      0x82

#define MCB_NORMAL      0x4d
#define MCB_LAST        0x5a

#define DOS_PSP         0x0060  /* 0x0008 What? seg 8 =0:0080 */
#define FREE_PSP        0

#define MCB_SIZE(x)     ((((LONG)(x))<<4)+sizeof(mcb))

typedef UWORD seg;
typedef UWORD offset;

typedef struct
{
  BYTE m_type;                  /* mcb type - chain or end              */
  UWORD m_psp;                  /* owner id via psp segment             */
  UWORD m_size;                 /* size of segment in paragraphs        */
  BYTE m_fill[3];
  BYTE m_name[8];               /* owner name limited to 8 bytes        */
}
mcb;

