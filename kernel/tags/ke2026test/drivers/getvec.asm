;
; File:
;                          getvec.asm
; Description:
;               get an interrupt vector - simple version
;
;                       Copyright (c) 1995
;                       Pasquale J. Villani
;                       All Rights Reserved
;
; This file is part of DOS-C.
;
; DOS-C is free software; you can redistribute it and/or
; modify it under the terms of the GNU General Public License
; as published by the Free Software Foundation; either version
; 2, or (at your option) any later version.
;
; DOS-C is distributed in the hope that it will be useful, but
; WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
; the GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public
; License along with DOS-C; see the file COPYING.  If not,
; write to the Free Software Foundation, 675 Mass Ave,
; Cambridge, MA 02139, USA.
;
; $Header$
;

                %include "..\kernel\segs.inc"

segment	HMA_TEXT

		global	_getvec
_getvec:
                mov     bx,sp
                mov     ax,[ss:bx+2]
  
;
; assembler version - ax = vector number
;       returns vector in dx:ax
;
  
		global	getvec
getvec:
                shl     ax,1                    ; Multiply by 4
                shl     ax,1
                xor     dx,dx                   ; and set segment to 0
                mov     es,dx
                mov     bx,ax
                pushf                           ; Push flags
                cli                             ; Disable interrupts
                mov     ax,[es:bx]
                mov     dx,[es:bx+2]
                popf                            ; Pop flags
                ret

; Log: getvec.asm,v 
;
; Revision 1.1.1.1  2000/05/06 19:34:53  jhall1
; The FreeDOS Kernel.  A DOS kernel that aims to be 100% compatible with
; MS-DOS.  Distributed under the GNU GPL.
;
; Revision 1.3  1999/08/10 17:21:08  jprice
; ror4 2011-01 patch
;
; Revision 1.2  1999/03/29 17:08:31  jprice
; ror4 changes
;
; Revision 1.1.1.1  1999/03/29 15:40:27  jprice
; New version without IPL.SYS
;
; Revision 1.2  1999/01/22 04:16:39  jprice
; Formating
;
; Revision 1.1.1.1  1999/01/20 05:51:00  jprice
; Imported sources
;
;
;   Rev 1.2   29 Aug 1996 13:07:10   patv
;Bug fixes for v0.91b
;
;   Rev 1.1   01 Sep 1995 18:50:40   patv
;Initial GPL release.
;
;   Rev 1.0   02 Jul 1995  8:00:36   patv
;Initial revision.
;
