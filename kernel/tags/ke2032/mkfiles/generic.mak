# These are generic definitions

#**********************************************************************
#* TARGET    : we create a %TARGET%.sys file
#* TARGETOPT : options, handled down to the compiler
#**********************************************************************

TARGETOPT=-1-

!if $(XCPU) == 186
TARGETOPT=-1
!endif
!if $(XCPU) == 386
TARGETOPT=-3
!endif

!if $(XFAT) == 32
ALLCFLAGS=$(ALLCFLAGS) -DWITHFAT32
!endif

NASM=$(XNASM)
!if $(XCPU) == 386
NASMFLAGS   = $(NASMFLAGS) -i../hdr/ -DI386
!else
NASMFLAGS   = $(NASMFLAGS) -i../hdr/
!endif

LINK=$(XLINK)

INITPATCH=@rem

!include "..\mkfiles\$(COMPILER).mak"

THETARGET=$(TARGET)$(XCPU)$(XFAT)
RM=..\utils\rmfiles

.asm.obj :
	$(NASM) -D$(COMPILER) $(NASMFLAGS) -f obj $*.asm

#               *Implicit Rules*
.c.obj :
	$(CC) $(CFLAGS) $*.c

.cpp.obj :
	$(CC) $(CFLAGS) $*.cpp

