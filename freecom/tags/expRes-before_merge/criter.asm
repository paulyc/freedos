; $Id$
;
;		Critical Error handler
;
; Two macros to customize the assembler process:
;		COMPILE_TO_COM in order to generate a .COM file (Debugging ONLY)
;		COMPILE_STRINGS to include English response strings right into
;			this image
;		NO_RESOURCE_BLOCK omit resource block at the end of the file
;
;	This handler does:
;	1) Probe for Autofail <-> return FAIL for all criterrs
;	2) Display error message:
;	block devices:
;		Error "reading from"|"writing to" drive ?: XXX area: error
;	character devices:
;		Error "reading from"|"writing to" device XXXXXXX: error
;	3) Display user action possebilities:
;		(A)bort (I)gnore (R)etry (F)ail? _
;	4) Get user input & return to caller
;
;	== What to do if neither I,R,nor F are allowed??
;	== Simply return??
;
;	Organization of the strings:
;	+ There may be upto 256 strings, numbered from 0 through N
;	+ The actual "error strings" must be the last ones and their
;	  order must be the same as the code in DI
;	+ All strings are packed together as follows:
;	  (N+1) words	near pointer to character sequence of string #X
;	  character sequences of strings, no obvious order among them required
;	  This block is created by an external tool, like the messages for
;	  FreeCom itself and simply attached to the criterr handler code.
;	+ Within the code procedure ?oString maps BL -> near pointer (BX)
;	  and displays the associated character sequence with ?oBuffer
;	+ Special sequences:
;		%%	--> a single percent sign
;		%#	--> where '#' is a decimal digit --> insert string
;				with number BYTE [?strarg#]
;		%A	--> where 'A' is a capital Latin letter --> insert
;				the buffer at ?strargA
;
;	Possible NLS hazards:
;	+ drive letter is created via "+ 'A'"
;	+ for robustness when displaying the driver's name, characters less
;	  than ' ' are ignored (usually control characters)
;
;	Known Bugs:
;	+ If this module is loaded into memory, but no context is specified,
;	  0000:0000 is used as the pointer to the context. For "autofail" that
;	  means most probably that it is considered to be "true".
;

???start:

%ifdef COMPILE_TO_COM
ORG 100h
jmp short _lowlevel_err_handler
%endif

;; Note: Both I/O functions should use the channel to read/write
;;	the characters. In this case: the BIOS.
;; Sidenote: RBIL states that some BIOSes destroy the BP register.
%macro printALtoConsole 0
	call ?oChar
%endmacro
%macro readALfromConsole 0
	mov ah, 0
	int 16h
%endmacro


LOCAL_BELL	EQU 7

;; Return values
IGNORE		EQU 0
RETRY		EQU 1
ABORT		EQU 2
FAIL		EQU 3

; bitmask of the "allowed action" flags
CodeIgnore	EQU 32
CodeRetry	EQU 16
CodeFail	EQU 8

;; String numbers -- fixed order section
; 0 -> %1: write to
; 1 -> %1: read from 

StrBlockDevice	EQU 2
StrCharDevice	EQU 3

StrArea EQU 4
; StrArea (area of failure)
; + 0 -> DOS
; + 1 -> FAT
; + 2 -> root
; + 3 -> data

; StrActionStrings 8
; + 0 -> Ignore
; + 1 -> Retry
; + 2 -> Abort
; + 3 -> Fail
StrIgnore	EQU 8
StrRetry	EQU 9
StrAbort	EQU 10
StrFail		EQU 11

StrQuestionMark	EQU 12
StrDelimiter	EQU 13
StrKeys			EQU 14		; enumerated valid input keys
		; format:	LK..KA..A
		;	L: BYTE number of K's (== number of A's)
		;	K: BYTE one keystroke
		;	A: BYTE one action code 0..3 (IRAF)
		;	a K's action code is located at the byte pointed to
		;	by the address of K plus LL

StrErrCodes		EQU 15

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;; Entry point

??context	dd 0		;; here a far pointer is placed
						;; pointing to the context of the most current
						;; FreeCOM that uses this handler
;; Structure:
;;	OFFSET	TYPE	Meaning
;;	0		byte	autofail (C-style boolean)

_lowlevel_err_handler:
	push ds
	push es
	push bp
	push si
	push di
	push cx
	push bx
	push ax

	mov cx, cs
	mov ds, cx		; DS := local code/data segment

			;; free AL
	add al, 'A'		; AL may contain the drive number
	mov BYTE [??strargA], al	;; will be overwritten, if char device
	xor al, al
	mov BYTE [??strargA + 1], al	; end of string

	les bx, [??context]
	or al, [ES:bx]
	je ?noAutoFail
		mov bl, FAIL
		jmp ?iret
?noAutoFail:

	mov es, cx

	shr ah, 1		; Carry := 0-> read; 1->write
	adc al, al		; AL := 0-> read; 1->write
	mov BYTE [??strarg1], al

	mov al, ah
	and al, 3		; AL := 0/1/2/3 -> DOS/FAT/root/data area
	add al, StrArea	;  make it a string#
	mov BYTE [??strarg2], al	;; will be ignored if char device

;;
;; and al, (CodeIgnore or CodeRetry or CodeFail) / 2
;; jz ONLY_ABORT_ALLOWED_AND_NOW??
;;
	mov al, ah
	and al, CodeFail / 2
	mov [??allowFail], al
	mov al, ah
	and al, CodeRetry / 2
	mov [??allowRetry], al
	and ah, CodeIgnore / 2
	mov [??allowIgnore], ah


;; AX is empty now

	mov ah, 0fh		; Get current video mode
	int 10h
	mov BYTE [??actPage], bh
	mov BYTE [??actColour], 255

	mov ax, di		; AL := lobyte(DI) -> error number
	add al, StrErrCodes
	mov BYTE [??strarg3], al

	mov bl, StrBlockDevice		; by default issue block device error
	mov ds, bp					; is still segment of device driver
	test BYTE [si+5], 128		; bit 7 == 1 if block device
	jz ?noCharDevice
			; fetch the name of the character device
		mov cx, 8		; max eight characters to display
		add si, 10		; located at offset 10
		mov di, ??strargA
		mov ah, ' '
		cld
?drvNameGetLoop:
		lodsb
		cmp al, ah
		jnc ?charOK
		mov al, ah
?charOK:
		stosb
		loop ?drvNameGetLoop

			;; Remove trailing whitespaces
		mov cx, 8		; max eight characters to display
		mov al, ah
		std
		dec di			; stosb leaves DI behind the last written byte
		repe scasb
		mov BYTE [ES:di+2], ch	; place termination character
		mov cx, cs
		mov bl, StrCharDevice		; issue device driver message

?noCharDevice:

	cld				; forward direction
	mov ds, cx		; CX is still or again == CS

	call ?oString	; Display the Critical Error message string
	call ?newline
	mov bl, StrAbort
	call ?oString
	mov bl, 0		; try Ignore
	call ?oAction
	mov bl, 1		; try Retry
	call ?oAction
	mov bl, 3		; try Fail
	call ?oAction
	mov bl, StrQuestionMark
	call ?oString
	jmp short ?inputLoop

?inputError:
	mov al, LOCAL_BELL
	printALtoConsole

?inputLoop:
	; Prepare to decode the character
	mov di, [StrKeys * 2 + 1 + ??strings]	; address of enumerated valid keys
	xor ax, ax
	mov al, [di]
	inc di
	mov cx, ax			; number of enumerated keys
	mov bx, ax

	readALfromConsole
	;; special keys (AL == 0) are ignored

;; Decode user input
	repne scasb
	jne ?inputError		; key not found

	mov bl, [bx+di-1]	; action code (DI is one byte too far by SCASB)
	mov al, [bx+??allow]
	or al, al
	jz ?inputError		; not allowed

	;; allowed action code in BL
	call ?newline

?iret:
	pop ax			; preserve AH
	mov al, bl		; action code
	pop bx
	pop cx
	pop di
	pop si
	pop bp
	pop es
	pop ds
	iret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;; procedures

;; dump allowed action #AL

?oAction:
	mov bh, 0
	or bh, [bx+??allow]
	jz ?oRet			; not allowed
	add bl, '5'			; local strarg code
	mov BYTE [??input+3], bl	; construct the temp output buffer
	mov bx, ??input
	jmp short ?oBuffer

;; dump string #BL onto screen
;; IN: BL = string number
;; OUT: BX destroyed

?oString:
	;; make sure BL is within limit
	mov al, BYTE [??strings]
	cmp bl, al
	jc ?oS_idOK
	mov bl, al
?oS_idOK:
	mov bh, 0
	add bx, bx
	mov bx, WORD [bx+??strings+1]
	jmp short ?oBuffer

;; dump character sequence pointed to by BX onto screen
;; IN: BX = address
;; OUT: BX destroyed

?oB_bufA:		;; Dump string argument A
	push bx
	mov bx, ??strargA
	call ?oBuffer
	jmp short ?oB_1

?oB_special:
	inc bx
	mov al, [bx]
	or al, al
	je ?oRet
	cmp al, 'A'
	je ?oB_bufA
	cmp al, '1'
	jc ?oB_dump
	cmp al, '9' + 1
	jnc ?oB_dump
		;; display the numbered argument #AL
	push bx
	cbw
	mov bx, ax
	mov bl, [bx+??strarg1-'1']
	call ?oString
?oB_1:
	pop bx
	jmp short ?oB_2
?oB_loop:
	cmp al, '%'
	je ?oB_special
?oB_dump
	printALtoConsole
?oB_2:
	inc bx
?oBuffer:
	mov al, BYTE [BX]
	or al, al
	jnz ?oB_loop
?oRet:
	ret

?newline:
	;; Linefeed
	mov al, 10
	printALtoConsole
	mov al, 13
;;	printALtoConsole

;; Dump character AL onto screen
;; IN: AL = character

?oChar:
	push bx
	mov bx, [??0Earg]
	mov ah, 0eh		; teletype output
	int 10h
	pop bx
	ret


??0Earg:
??actColour	DB 0
??actPage	DB 0

	;; Numerical arguments
??strarg1	DB 0					;; read/write
??strarg2	DB 0					;; area failed on
??strarg3	DB 0					;; error string
??strarg4	DB StrDelimiter			;; delimiter between two action strings
??strarg5	DB StrIgnore
??strarg6	DB StrRetry
??strarg7	DB StrAbort
??strarg8	DB StrFail

	;; alphabetical arguments
??strargA	DB '12345678', 0		;; drive letter or device name string

??allow:
??allowIgnore	DB 0
??allowRetry	DB 0
??allowAbort	DB 1	;; always allowed
??allowFail		DB 0
??input			DB '%4%6', 0		;; temporary storage

%ifndef COMPILE_STRINGS
??strings:
%else
??strings		DB 36	;; number of strings
	;; Here start all the strings!

;; Some strings
;??string1	DB 'Error %1 drive %A: %2 area: %3', 13, 10, 0
;??string2	DB 'Error %1 device %A: %3', 13, 10, 0

DW S0
DW S1
DW S2
DW S3
DW S4
DW S5
DW S6
DW S7
DW S8
DW S9
DW S10
DW S11
DW S12
DW S13
DW S14
DW S15
DW S16
DW S17
DW S18
DW S19
DW S20
DW S21
DW S22
DW S23
DW S24
DW S25
DW S26
DW S27
DW S28
DW S29
DW S30
DW S31
DW S32
DW S33
DW S34
DW S35
DW S36

S0	DB 'reading from', 0
S1	DB 'writing to', 0
S2	DB 'Error %1 drive %A: %2 area: %3', 0
S3	DB 'Error %1 device %A: %3', 0
S4	DB 'DOS', 0
S5	DB 'FAT', 0
S6	DB 'root', 0
S7	DB 'data', 0
S8	DB '(I)gnore', 0
S9	DB '(R)etry', 0
S10	DB '(A)bort', 0
S11	DB '(F)ail', 0
S12	DB '? ', 0
S13	DB ', ', 0
S14	DB  8, 'IiRrAaFf', 0, 0, 1, 1, 2, 2, 3, 3

S15 DB 'write-protection violation attempted', 0
S16 DB 'unknown unit for driver', 0
S17 DB 'drive not ready', 0
S18 DB 'unknown command given to driver', 0
S19 DB 'data error (bad CRC)', 0
S20 DB 'bad device driver request structure length', 0
S21 DB 'seek error', 0
S22 DB 'unknown media type', 0
S23 DB 'sector not found', 0
S24 DB 'printer out of paper', 0
S25 DB 'write fault', 0
S26 DB 'read fault', 0
S27 DB 'general failure', 0
S28 DB '(DOS 3.0+) sharing violation', 0
S29 DB '(DOS 3.0+) lock violation', 0
S30 DB 'invalid disk change', 0
S31 DB '(DOS 3.0+) FCB unavailable', 0
S32 DB '(DOS 3.0+) sharing buffer overflow', 0
S33 DB '(DOS 4.0+) code page mismatch', 0
S34 DB '(DOS 4.0+) out of input', 0
S35 DB '(DOS 4.0+) insufficient disk space', 0
S36	DB 'Unknown error code', 0
%endif

???ende:

%ifndef NO_RESOURCE_BLOCK
;; Include resource block
	dd	???ende - ???start		;; Length of this resource
	dw 1						;; major resource ID
%ifndef COMPILE_STRINGS
	dw 0						;; minor resource ID criter without strings
%else
	dw 2						;; criter with strings
%endif
	db 'FREECOM '				;; cookie
%endif

???endRes:
%if ???endRes - ???ende != 16
%error "resource block wrong"
%endif

END

;Quote from RBIL
;--------D-24---------------------------------
;INT 24 C - DOS 1+ - CRITICAL ERROR HANDLER
;Notes:  invoked when a critical (usually hardware) error is encountered by DOS
;          (see #02543); should never be called directly
;        when DOS terminates a program, it copies the previous value of the
;          INT 24 vector out of the PSP (see #01378) and into the interrupt
;          vector table
;SeeAlso: INT 21/AH=95h
;
;(Table 02543)
;Values critical error handler is called with:
;        AH = type and processing flags (see #02544)
;        AL = drive number if AH bit 7 clear
;        BP:SI -> device driver header (see #01646 at INT 21/AH=52h)
;                (BP:[SI+4] bit 15 set if character device)
;        DI low byte contains error code if AH bit 7 set (see #02545)
;        STACK:  DWORD   return address for INT 24 call
;                WORD    flags pushed by INT 24
;                WORD    original AX on entry to INT 21
;                WORD    BX
;                WORD    CX
;                WORD    DX
;                WORD    SI
;                WORD    DI
;                WORD    BP
;                WORD    DS
;                WORD    ES
;                DWORD   return address for INT 21 call
;                WORD    flags pushed by INT 21
;Return: AL = action code (see #02546)
;        SS,SP,DS,ES,BX,CX,DX preserved
;Notes:  the only DOS calls the handler may make are INT 21/AH=01h-0Ch,30h,59h
;        if the handler returns to the application by popping the stack, DOS
;          will be in an unstable state until the first call with AH > 0Ch
;        for DOS 3.1+, IGNORE (AL=00h) is turned into FAIL (AL=03h) on network
;          critical errors
;        if IGNORE specified but not allowed, it is turned into FAIL
;        if RETRY specified but not allowed, it is turned into FAIL
;        if FAIL specified but not allowed, it is turned into ABORT
;        (DOS 3.0+) if a critical error occurs inside the critical error
;          handler, the DOS call is automatically failed (AL set to 03h and
;          the INT 24 call skipped)
;
;Bitfields for critical error type and processing flags:
;Bit(s)  Description     (Table 02544)
; 7      clear = disk I/O error
;        set   = -- if block device, bad FAT image in memory
;                -- if char device, error code in DI
; 6      unused
; 5      Ignore allowed (DOS 3.0+)
; 4      Retry allowed (DOS 3.0+)
; 3      Fail allowed (DOS 3.0+)
; 2-1    disk area of error
;        00 = DOS area   01 = FAT
;        10 = root dir   11 = data area
; 0      set if write, clear if read
;SeeAlso: #02545,#02546
;
;(Table 02545)
;Values for critical error code:
; 00h    write-protection violation attempted
; 01h    unknown unit for driver
; 02h    drive not ready
; 03h    unknown command given to driver
; 04h    data error (bad CRC)
; 05h    bad device driver request structure length
; 06h    seek error
; 07h    unknown media type
; 08h    sector not found
; 09h    printer out of paper
; 0Ah    write fault
; 0Bh    read fault
; 0Ch    general failure
; 0Dh    (DOS 3.0+) sharing violation
; 0Eh    (DOS 3.0+) lock violation
; 0Fh    invalid disk change
; 10h    (DOS 3.0+) FCB unavailable
; 11h    (DOS 3.0+) sharing buffer overflow
; 12h    (DOS 4.0+) code page mismatch
; 13h    (DOS 4.0+) out of input
; 14h    (DOS 4.0+) insufficient disk space
;SeeAlso: #02544,#02546
;
;(Table 02546)
;Values for critical error handler action code:
; 00h    ignore error and continue processing request
; 01h    retry operation
; 02h    terminate program as though INT 21/AH=4Ch called (INT 20h for DOS 1.x)
; 03h    fail system call in progress (DOS 3+)
;SeeAlso: #02544,#02546
;
;~
