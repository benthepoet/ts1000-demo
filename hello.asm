;
; To assembly this, either use the zxasm.bat file:
;
; zxasm hello
;
; or... assemble with the following options:
;
; tasm -80 -b -s hello.asm hello.p
;
;==============================================
;    ZX81 assembler 'Hello World' 
;==============================================
;
;defs
#include "zx81defs.asm"
;EQUs for ROM routines
#include "zx81rom.asm"
;ZX81 char codes/how to survive without ASCII
#include "charcodes.asm"
;system variables
#include "zx81sys.asm"

;the standard REM statement that will contain our 'hex' code
#include "line1.asm"

;------------------------------------------------------------
; code starts here and gets added to the end of the REM 
;------------------------------------------------------------
	ld de, $0408
	xor a
	add a, $04
l0
	ret z
	call print_set
	call dispstring
	inc d
	inc e
	dec a
	jp l0

print_set
	push af
	push de
	ld hl,(D_FILE)
	inc hl
	xor a
	add a, d
	ld d, $00
	add hl, de
	ld e, $21
l1
	jp z, l1end
	add hl, de
	dec a
	jr l1
l1end
	pop de
	pop af
	ret

;Subroutines	
;display a string
dispstring
;write directly to the screen
	;ld hl,(D_FILE)
	;add hl,bc	
	push af
	push de
	ld de,hello_txt
loop2
	ld a,(de)
	cp $ff
	jp z,loop2End
	ld (hl),a
	inc hl
	inc de
	jr loop2
loop2End	
	pop de
	pop af
	ret	
;include our variables
#include "vars.asm"

; ===========================================================
; code ends
; ===========================================================
;end the REM line and put in the RAND USR line to call our 'hex code'
#include "line2.asm"

;display file defintion
#include "screen.asm"               

;close out the basic program
#include "endbasic.asm"
						
