#
# makefile for DOS-C boot
#
# $Id$
#


!include "..\mkfiles\generic.mak"

production:     b_fat12.bin b_fat16.bin b_fat32.bin

b_fat12.bin:    boot.asm
		$(NASM) -dISFAT12 boot.asm -ob_fat12.bin

b_fat16.bin:    boot.asm
		$(NASM) -dISFAT16 boot.asm -ob_fat16.bin

b_fat32.bin:    boot32.asm
		$(NASM) boot32.asm -ob_fat32.bin

clobber:        clean
		-$(RM) b_fat12.bin b_fat16.bin b_fat32.bin status.me

clean:
		-$(RM) *.lst *.map *.bak *.obj


# Log: makefile,v 
#
# Revision 1.3  1999/04/23 03:44:17  jprice
# Ported to NASM by ror4. Improvements
#
# Revision 1.2  1999/04/01 07:23:20  jprice
# New boot loader
#
# Revision 1.1.1.1  1999/03/29 15:39:39  jprice
# New version without IPL.SYS
#
# Revision 1.3  1999/02/09 04:49:17  jprice
# Make makefile use common config.mak file
#
# Revision 1.2  1999/01/21 05:03:58  jprice
# Formating.
#
# Revision 1.1.1.1  1999/01/20 05:51:00  jprice
# Imported sources
#
#
#   Rev 1.3   10 Jan 1997  4:51:54   patv
#Changed to use FreeDOS exe2bin and support new boot code
#
#   Rev 1.2   17 Dec 1996 12:52:32   patv
#Converted to FreeDOS exe2bin.
#
#   Rev 1.1   29 Aug 1996 13:06:50   patv
#Bug fixes for v0.91b
#
#   Rev 1.0   02 Jul 1995  9:11:26   patv
#Initial revision.
#
