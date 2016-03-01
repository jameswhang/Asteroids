; #########################################################################
;
;   game.asm - Assembly file for EECS205 Assignment 4/5
;   Author: James Whang (syw973)
;           sungyoonwhang2017@u.northwestern.edu
;
; #########################################################################

      .586
      .MODEL FLAT,STDCALL
      .STACK 4096
      option casemap :none  ; case sensitive

include stars.inc
include lines.inc
include blit.inc
include game.inc
include gamelogic.inc
include keys.inc
	
.DATA
;; If you need to, you can place global variables here

fighter_000 EECS205BITMAP <44, 37, 255,, offset fighter_000 + sizeof fighter_000>
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,049h,0b6h,049h,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h
	BYTE 0ffh,0e0h,0e0h,080h,080h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0e0h,0e0h,0e0h,080h,080h
	BYTE 080h,080h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,091h,049h,013h,049h,00ah,024h,049h,024h,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,049h,091h,049h,013h,0ffh,00ah,024h,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,091h
	BYTE 013h,013h,0ffh,00ah,00ah,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,091h,013h,013h,013h,00ah
	BYTE 00ah,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,0b6h,013h,013h,013h,00ah,00ah,091h,024h,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,049h,091h,0b6h,049h,013h,013h,00ah,024h,091h,049h,024h,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,091h,091h
	BYTE 0b6h,049h,0ffh,024h,091h,049h,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,049h,091h,091h,0b6h,091h,091h
	BYTE 049h,049h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,049h,049h,091h,091h,091h,049h,049h,049h,049h,024h,024h
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0e0h,0e0h,080h,0ffh,0ffh
	BYTE 0ffh,049h,091h,049h,049h,091h,049h,049h,024h,024h,049h,024h,0ffh,0ffh,0ffh,080h
	BYTE 080h,080h,080h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0e0h,0ffh,0e0h,0e0h,080h,080h,0ffh,049h,091h,091h,0b6h
	BYTE 091h,049h,049h,024h,049h,049h,049h,049h,024h,0ffh,0e0h,080h,080h,080h,080h,080h
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0e0h,049h,049h,049h,024h,080h,0ffh,049h,091h,0b6h,0b6h,091h,091h,049h,049h
	BYTE 049h,049h,049h,049h,024h,0ffh,0e0h,024h,024h,024h,024h,080h,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,091h,091h
	BYTE 091h,049h,024h,049h,091h,091h,0b6h,091h,091h,091h,049h,049h,049h,049h,049h,049h
	BYTE 049h,024h,091h,049h,049h,049h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,091h,091h,091h,049h,024h,0ffh
	BYTE 049h,0b6h,091h,091h,091h,091h,049h,049h,049h,049h,049h,049h,024h,0e0h,091h,049h
	BYTE 049h,049h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,091h,091h,091h,049h,024h,0e0h,0ffh,049h,049h,091h
	BYTE 091h,091h,049h,049h,049h,049h,024h,024h,0e0h,080h,091h,049h,049h,049h,024h,024h
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0b6h,091h,091h,091h,049h,024h,0e0h,0e0h,049h,091h,049h,049h,049h,049h,024h
	BYTE 024h,024h,049h,024h,080h,080h,091h,049h,049h,049h,024h,024h,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,049h,049h,049h
	BYTE 049h,024h,024h,0e0h,0e0h,0b6h,049h,0b6h,0b6h,091h,080h,049h,049h,049h,024h,049h
	BYTE 080h,080h,049h,024h,024h,024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,091h,091h,091h,091h,091h,049h,024h
	BYTE 0e0h,0b6h,049h,091h,0b6h,091h,080h,049h,049h,024h,024h,049h,080h,091h,049h,049h
	BYTE 049h,049h,049h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,049h,0b6h,091h,091h,091h,091h,091h,049h,024h,0e0h,0b6h,049h,0b6h
	BYTE 091h,049h,080h,024h,024h,049h,024h,049h,080h,091h,049h,049h,049h,049h,049h,024h
	BYTE 024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,049h
	BYTE 0b6h,091h,091h,000h,091h,091h,049h,024h,0e0h,0b6h,091h,049h,0b6h,091h,080h,049h
	BYTE 049h,024h,049h,049h,080h,091h,049h,049h,000h,049h,049h,024h,024h,024h,024h,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,091h,049h,0b6h,091h,000h,0fch
	BYTE 000h,091h,049h,024h,0e0h,0b6h,091h,049h,091h,091h,080h,049h,024h,024h,049h,049h
	BYTE 080h,091h,049h,000h,090h,000h,049h,024h,024h,024h,049h,024h,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,091h,0b6h,091h,049h,0b6h,000h,0fch,000h,0fch,000h,049h,024h
	BYTE 0e0h,0b6h,091h,049h,0b6h,049h,080h,024h,049h,024h,049h,049h,080h,091h,000h,090h
	BYTE 000h,090h,000h,024h,024h,024h,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0b6h,091h,049h,0e0h,0b6h,000h,000h,000h,000h,000h,049h,024h,080h,0b6h,091h,091h
	BYTE 049h,091h,080h,049h,024h,049h,049h,049h,080h,091h,000h,000h,000h,000h,000h,024h
	BYTE 024h,024h,049h,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,091h,0e0h,0e0h,080h
	BYTE 0b6h,091h,091h,091h,091h,091h,049h,024h,080h,0b6h,091h,0b6h,091h,049h,080h,024h
	BYTE 049h,049h,049h,049h,080h,091h,049h,049h,049h,049h,049h,024h,024h,080h,080h,080h
	BYTE 049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0e0h,080h,080h,0ffh,0ffh,049h,049h,049h
	BYTE 049h,049h,024h,0e3h,0b6h,0b6h,091h,091h,0b6h,091h,024h,049h,049h,049h,049h,049h
	BYTE 024h,0e3h,024h,024h,024h,024h,024h,024h,0ffh,0ffh,080h,080h,080h,080h,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0e0h,080h,0ffh,0ffh,0ffh,0e0h,0ffh,0e0h,0e0h,0e0h,0e0h,080h,080h
	BYTE 0ffh,0b6h,049h,049h,049h,0b6h,091h,024h,024h,024h,024h,024h,0ffh,0e0h,0e0h,080h
	BYTE 080h,080h,080h,080h,080h,0ffh,0ffh,0ffh,080h,080h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0e0h,0e0h,0e0h,0e0h,080h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0b6h,091h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0e0h,080h,080h,080h,080h,080h
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,091h,024h
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,091h,024h,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,091h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0e0h,024h,080h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,080h,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh

asteroid_000 EECS205BITMAP <56, 53, 255,, offset asteroid_000 + sizeof asteroid_000>
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,024h,024h,024h,024h,024h,049h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,024h,024h,024h,024h,049h,049h,049h,049h,024h
	BYTE 024h,024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,024h,024h,024h,024h,049h
	BYTE 049h,049h,049h,049h,024h,024h,024h,024h,024h,024h,024h,024h,024h,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,049h,049h,049h,049h,049h,049h,049h,049h,049h,024h,024h,024h,024h,024h,024h
	BYTE 024h,024h,024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,049h,091h,091h,049h,049h,049h,049h,049h
	BYTE 049h,049h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,049h,049h,091h
	BYTE 091h,049h,049h,049h,049h,049h,024h,024h,024h,049h,049h,024h,024h,024h,024h,024h
	BYTE 024h,049h,049h,024h,024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,049h,049h,091h,091h,091h,091h,049h,049h,049h,049h,049h,049h,024h,024h
	BYTE 024h,024h,049h,049h,049h,024h,024h,024h,000h,024h,049h,024h,024h,024h,024h,024h
	BYTE 024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,049h,091h,091h,091h,091h,049h,091h
	BYTE 049h,049h,049h,049h,049h,024h,024h,024h,024h,024h,024h,049h,049h,024h,024h,024h
	BYTE 024h,000h,024h,024h,024h,024h,024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,049h
	BYTE 091h,091h,091h,091h,091h,049h,024h,049h,091h,049h,049h,049h,049h,024h,024h,024h
	BYTE 024h,024h,024h,049h,049h,049h,024h,024h,024h,024h,024h,024h,024h,049h,024h,024h
	BYTE 024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,091h,049h,091h,091h,0b6h,091h,091h,049h,049h,049h,024h,024h
	BYTE 049h,049h,049h,049h,049h,024h,024h,024h,024h,024h,024h,024h,049h,049h,049h,049h
	BYTE 024h,024h,049h,049h,024h,024h,024h,024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h,0b6h,0b6h
	BYTE 091h,091h,049h,049h,049h,049h,049h,049h,049h,091h,091h,049h,049h,024h,024h,024h
	BYTE 024h,024h,024h,024h,024h,049h,049h,049h,049h,049h,049h,024h,024h,024h,024h,024h
	BYTE 024h,024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,091h,0b6h,0b6h,0b6h,0b6h,091h,049h,049h,049h,049h,049h,049h,049h
	BYTE 091h,091h,091h,091h,049h,049h,024h,024h,024h,024h,024h,024h,024h,024h,049h,049h
	BYTE 049h,024h,024h,024h,024h,024h,024h,049h,049h,049h,024h,024h,024h,024h,024h,024h
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h,0b6h,0b6h,0b6h
	BYTE 091h,049h,049h,049h,049h,049h,049h,049h,049h,091h,091h,091h,049h,049h,049h,024h
	BYTE 024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,049h,049h,049h
	BYTE 024h,024h,049h,024h,024h,024h,024h,024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,091h,0b6h,0b6h,091h,0b6h,0b6h,091h,049h,049h,049h,049h,049h,049h,049h
	BYTE 049h,091h,091h,091h,091h,049h,049h,049h,024h,024h,024h,024h,024h,024h,024h,024h
	BYTE 024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,049h,024h
	BYTE 024h,024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h,0b6h,091h,091h,0b6h
	BYTE 091h,091h,091h,091h,049h,049h,049h,049h,049h,049h,091h,091h,091h,091h,049h,049h
	BYTE 049h,049h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h
	BYTE 024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,091h,0b6h,091h,091h,091h,091h,0b6h,091h,091h,091h,091h,091h,091h,091h
	BYTE 091h,049h,049h,091h,091h,091h,091h,049h,049h,049h,049h,024h,024h,024h,024h,024h
	BYTE 024h,024h,024h,024h,024h,049h,049h,049h,024h,024h,024h,024h,024h,024h,024h,024h
	BYTE 024h,049h,049h,024h,024h,0ffh,0ffh,0ffh,0ffh,091h,0b6h,0b6h,091h,091h,091h,091h
	BYTE 091h,091h,091h,091h,0b6h,0b6h,091h,091h,091h,091h,049h,049h,049h,091h,091h,049h
	BYTE 049h,049h,049h,049h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,049h,049h
	BYTE 049h,024h,024h,024h,024h,049h,024h,024h,024h,024h,049h,049h,024h,024h,0ffh,0ffh
	BYTE 0ffh,091h,0b6h,0b6h,091h,091h,091h,091h,091h,091h,091h,049h,091h,0b6h,091h,091h
	BYTE 091h,091h,091h,049h,049h,049h,091h,049h,049h,049h,049h,049h,024h,024h,024h,024h
	BYTE 024h,049h,049h,049h,049h,049h,049h,049h,049h,049h,049h,024h,024h,049h,024h,024h
	BYTE 024h,024h,049h,049h,024h,024h,0ffh,0ffh,091h,0b6h,0b6h,0b6h,091h,091h,091h,091h
	BYTE 091h,091h,091h,091h,049h,091h,091h,0b6h,0b6h,091h,091h,049h,049h,049h,091h,091h
	BYTE 049h,049h,049h,049h,024h,024h,024h,024h,049h,049h,049h,049h,049h,049h,049h,091h
	BYTE 091h,049h,049h,049h,024h,024h,049h,024h,024h,024h,024h,049h,024h,024h,0ffh,0ffh
	BYTE 091h,0b6h,0b6h,0b6h,091h,091h,091h,091h,091h,091h,0b6h,091h,091h,091h,091h,091h
	BYTE 0b6h,0b6h,091h,091h,091h,091h,091h,091h,091h,049h,049h,049h,024h,024h,024h,024h
	BYTE 049h,049h,049h,049h,049h,049h,024h,024h,091h,091h,049h,049h,024h,024h,049h,049h
	BYTE 024h,024h,024h,049h,049h,024h,0ffh,0ffh,091h,0b6h,0b6h,0b6h,091h,091h,091h,0b6h
	BYTE 0b6h,091h,091h,091h,091h,091h,091h,091h,091h,091h,091h,091h,0b6h,091h,091h,091h
	BYTE 091h,091h,091h,049h,049h,024h,024h,024h,024h,049h,049h,049h,049h,024h,049h,049h
	BYTE 049h,091h,091h,049h,049h,024h,049h,049h,024h,024h,024h,024h,049h,024h,0ffh,0ffh
	BYTE 0ffh,091h,0b6h,0b6h,0b6h,091h,0b6h,0b6h,0b6h,091h,091h,049h,091h,091h,091h,091h
	BYTE 091h,091h,091h,0b6h,091h,091h,091h,049h,091h,091h,049h,049h,049h,024h,024h,024h
	BYTE 024h,049h,049h,049h,049h,024h,024h,049h,049h,049h,091h,049h,049h,024h,049h,049h
	BYTE 049h,024h,024h,024h,024h,024h,0ffh,0ffh,0ffh,091h,0b6h,0b6h,0b6h,091h,0b6h,0b6h
	BYTE 091h,0b6h,0b6h,091h,049h,091h,091h,091h,091h,091h,0b6h,0b6h,091h,091h,091h,049h
	BYTE 091h,091h,091h,049h,049h,049h,024h,024h,024h,049h,049h,049h,049h,024h,024h,024h
	BYTE 049h,024h,024h,049h,049h,049h,049h,049h,049h,049h,024h,024h,024h,024h,024h,0ffh
	BYTE 0ffh,091h,0b6h,0b6h,0b6h,091h,0b6h,091h,049h,091h,0b6h,0b6h,091h,091h,091h,091h
	BYTE 091h,091h,091h,0b6h,091h,091h,091h,049h,091h,091h,091h,091h,049h,049h,024h,024h
	BYTE 049h,049h,049h,049h,049h,049h,049h,024h,024h,024h,049h,049h,049h,049h,049h,049h
	BYTE 049h,049h,024h,024h,024h,024h,024h,0ffh,0ffh,0ffh,091h,0b6h,0b6h,091h,0b6h,091h
	BYTE 049h,091h,091h,0b6h,091h,091h,091h,091h,091h,091h,0b6h,0b6h,0b6h,091h,091h,049h
	BYTE 049h,091h,091h,091h,049h,049h,024h,024h,049h,049h,049h,049h,024h,049h,049h,049h
	BYTE 049h,049h,049h,049h,049h,049h,049h,049h,049h,024h,024h,024h,024h,024h,024h,0ffh
	BYTE 0ffh,0ffh,091h,0b6h,0b6h,0b6h,0b6h,091h,049h,049h,091h,0b6h,091h,091h,091h,091h
	BYTE 091h,091h,091h,0b6h,0b6h,091h,091h,091h,049h,049h,049h,049h,049h,024h,024h,049h
	BYTE 049h,049h,049h,049h,024h,024h,049h,049h,049h,049h,049h,049h,049h,049h,049h,049h
	BYTE 024h,024h,024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,091h,0b6h,0b6h,0b6h,0b6h,0b6h
	BYTE 091h,049h,049h,091h,091h,091h,091h,091h,091h,091h,091h,0b6h,0b6h,091h,091h,049h
	BYTE 049h,049h,049h,091h,049h,049h,049h,049h,049h,049h,049h,049h,024h,024h,024h,049h
	BYTE 049h,049h,049h,049h,024h,024h,024h,024h,024h,024h,024h,024h,024h,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,091h,0b6h,0b6h,0b6h,0b6h,091h,091h,091h,091h,091h,091h,091h,091h
	BYTE 091h,091h,091h,091h,0b6h,0b6h,091h,049h,049h,049h,049h,049h,049h,049h,049h,049h
	BYTE 024h,024h,024h,049h,024h,024h,024h,049h,049h,024h,024h,024h,024h,024h,024h,024h
	BYTE 024h,049h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,091h,0b6h,0b6h,0b6h
	BYTE 0b6h,091h,091h,091h,091h,091h,091h,091h,091h,091h,091h,091h,0b6h,0b6h,091h,049h
	BYTE 049h,049h,049h,049h,049h,049h,049h,049h,049h,024h,024h,024h,024h,024h,024h,049h
	BYTE 024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h,0b6h,0b6h,091h,091h,091h,091h,091h,091h,091h
	BYTE 091h,091h,091h,091h,091h,0b6h,091h,049h,049h,049h,049h,049h,049h,049h,091h,091h
	BYTE 049h,049h,024h,024h,024h,024h,049h,049h,024h,024h,024h,024h,049h,049h,024h,024h
	BYTE 024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h
	BYTE 0b6h,0b6h,091h,091h,091h,091h,091h,091h,091h,091h,091h,091h,091h,091h,091h,049h
	BYTE 049h,049h,049h,091h,049h,024h,049h,091h,049h,049h,024h,024h,024h,024h,049h,024h
	BYTE 024h,024h,049h,049h,049h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h,0b6h,0b6h,0b6h,091h,091h,0b6h,0b6h,091h
	BYTE 0b6h,091h,091h,091h,091h,091h,091h,049h,049h,049h,049h,091h,049h,024h,049h,091h
	BYTE 049h,049h,024h,024h,024h,049h,024h,024h,024h,024h,049h,049h,024h,024h,024h,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h
	BYTE 0b6h,0b6h,0b6h,0b6h,0b6h,0b6h,091h,091h,091h,091h,091h,091h,091h,091h,091h,091h
	BYTE 049h,049h,049h,091h,091h,049h,024h,049h,049h,049h,024h,024h,049h,024h,024h,024h
	BYTE 024h,024h,049h,049h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h,0b6h,0b6h,0b6h,091h,091h,091h
	BYTE 091h,091h,091h,091h,091h,091h,091h,091h,049h,049h,049h,091h,091h,091h,049h,049h
	BYTE 049h,049h,024h,049h,049h,024h,024h,024h,024h,049h,024h,024h,024h,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,091h,0b6h,0b6h,0b6h,091h,091h,091h,0b6h,0b6h,091h,091h,091h,0b6h,091h,091h
	BYTE 091h,091h,049h,049h,091h,091h,091h,049h,049h,049h,049h,049h,024h,024h,024h,024h
	BYTE 024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h,0b6h,0b6h,0b6h,091h,049h
	BYTE 091h,0b6h,091h,091h,091h,091h,091h,091h,091h,091h,091h,049h,049h,091h,049h,049h
	BYTE 049h,049h,049h,049h,024h,024h,024h,024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,091h,0b6h,0b6h,0b6h,091h,049h,049h,091h,091h,091h,091h,091h,091h,091h
	BYTE 091h,091h,091h,091h,091h,091h,049h,049h,049h,024h,049h,049h,049h,024h,024h,024h
	BYTE 024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h,0b6h,0b6h,091h
	BYTE 091h,091h,091h,091h,091h,091h,0b6h,091h,091h,091h,091h,091h,091h,049h,049h,049h
	BYTE 049h,049h,049h,049h,049h,024h,024h,024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,091h,091h,0b6h,0b6h,0b6h,0b6h,0b6h,0b6h,091h,091h,0b6h,0b6h,091h
	BYTE 091h,091h,091h,091h,091h,049h,049h,049h,049h,049h,049h,049h,049h,049h,024h,024h
	BYTE 024h,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,091h,091h
	BYTE 091h,0b6h,0b6h,0b6h,0b6h,0b6h,0b6h,0b6h,091h,091h,091h,091h,091h,049h,049h,049h
	BYTE 049h,049h,091h,091h,091h,049h,024h,024h,024h,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,091h,091h,0b6h,0b6h,0b6h,0b6h
	BYTE 0b6h,091h,091h,091h,091h,049h,049h,049h,024h,091h,091h,091h,091h,091h,049h,024h
	BYTE 049h,091h,049h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,091h,091h,0b6h,0b6h,0b6h,0b6h,091h,091h,091h,091h,049h,024h
	BYTE 049h,049h,049h,049h,091h,091h,091h,049h,091h,049h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h
	BYTE 0b6h,0b6h,091h,091h,091h,091h,091h,024h,049h,049h,049h,049h,049h,049h,091h,091h
	BYTE 091h,049h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h,0b6h,0b6h,091h,091h,0b6h,091h,024h
	BYTE 024h,049h,049h,049h,049h,049h,091h,091h,091h,049h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 091h,0b6h,0b6h,0b6h,091h,091h,091h,091h,024h,024h,024h,049h,049h,049h,091h,091h
	BYTE 091h,049h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h,0b6h,0b6h,091h,0b6h,091h
	BYTE 091h,091h,024h,024h,049h,049h,024h,091h,091h,049h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,091h,0b6h,0b6h,0b6h,0b6h,0b6h,091h,091h,091h,024h,024h,024h,091h,091h
	BYTE 091h,049h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h,0b6h,0b6h,0b6h
	BYTE 0b6h,0b6h,091h,091h,091h,091h,091h,091h,049h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,091h,0b6h,0b6h,0b6h,091h,091h,091h,091h,091h,091h,091h,049h,049h
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,091h,0b6h,0b6h
	BYTE 091h,091h,091h,091h,091h,049h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,091h,091h,091h,091h,049h,049h,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh 
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh 
	BYTE 049h,049h,049h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh

asteroid_001 EECS205BITMAP <32, 32, 255,, offset asteroid_001 + sizeof asteroid_001>
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,091h,049h,091h,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,091h,0b6h,091h,049h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 091h,0b6h,091h,049h,049h,024h,024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h
	BYTE 0b6h,091h,091h,091h,049h,049h,024h,024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h
	BYTE 0b6h,091h,091h,091h,049h,091h,049h,024h,024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h
	BYTE 0b6h,091h,091h,091h,091h,049h,091h,049h,024h,049h,049h,024h,024h,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h
	BYTE 0b6h,091h,091h,091h,049h,024h,049h,091h,024h,024h,049h,049h,024h,024h,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h
	BYTE 0b6h,091h,091h,091h,049h,024h,049h,091h,049h,024h,049h,049h,024h,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h
	BYTE 091h,0b6h,0b6h,091h,049h,049h,024h,049h,024h,024h,049h,024h,024h,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h,0b6h
	BYTE 049h,091h,0b6h,091h,091h,049h,049h,049h,024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h,0b6h,091h
	BYTE 091h,049h,091h,091h,049h,049h,049h,024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h,0b6h,091h,091h
	BYTE 091h,091h,091h,091h,049h,049h,024h,024h,049h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h,0b6h,0b6h,091h,0b6h
	BYTE 0b6h,091h,091h,049h,049h,024h,024h,049h,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h,0b6h,0b6h,091h,0b6h,0b6h
	BYTE 091h,091h,049h,049h,049h,024h,024h,049h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,091h,091h,091h,091h,0b6h,0b6h,0b6h,091h,091h,0b6h,091h
	BYTE 091h,091h,049h,049h,024h,024h,024h,024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,091h,091h,091h,091h,0b6h,0b6h,0b6h,0b6h,0b6h,0b6h,091h,091h,091h,091h
	BYTE 091h,049h,049h,049h,049h,024h,024h,049h,024h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,091h,0b6h,0b6h,091h,091h,091h,0b6h,0b6h,0b6h,0b6h,091h,091h,091h,091h,091h
	BYTE 091h,049h,049h,049h,049h,024h,024h,091h,049h,024h,024h,024h,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,091h,0b6h,091h,0b6h,0b6h,0b6h,0b6h,0b6h,091h,091h,091h,091h,091h,091h,049h
	BYTE 091h,049h,049h,049h,049h,024h,049h,091h,091h,049h,024h,024h,024h,0ffh,0ffh,0ffh
	BYTE 091h,0b6h,0b6h,0b6h,0b6h,091h,091h,091h,0b6h,0b6h,091h,091h,091h,091h,049h,049h
	BYTE 049h,091h,049h,049h,024h,024h,049h,049h,091h,091h,049h,024h,024h,0ffh,0ffh,0ffh
	BYTE 091h,0b6h,0b6h,0b6h,091h,091h,049h,091h,091h,0b6h,091h,091h,0b6h,091h,049h,049h
	BYTE 049h,049h,049h,024h,024h,049h,049h,049h,091h,091h,049h,024h,024h,024h,0ffh,0ffh
	BYTE 0ffh,091h,0b6h,0b6h,091h,091h,049h,049h,091h,0b6h,091h,091h,091h,091h,091h,049h
	BYTE 049h,049h,049h,024h,024h,049h,049h,049h,091h,091h,049h,024h,049h,024h,0ffh,0ffh
	BYTE 0ffh,0ffh,091h,0b6h,0b6h,091h,091h,049h,049h,091h,091h,0b6h,091h,091h,091h,049h
	BYTE 049h,049h,049h,024h,024h,049h,049h,049h,091h,049h,049h,049h,024h,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,091h,0b6h,0b6h,091h,091h,091h,091h,0b6h,091h,091h,091h,091h,091h
	BYTE 049h,049h,049h,049h,024h,024h,049h,091h,049h,049h,049h,091h,049h,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,091h,0b6h,0b6h,091h,091h,0b6h,091h,0b6h,0b6h,091h,091h,091h,091h
	BYTE 049h,049h,049h,049h,024h,024h,024h,049h,049h,049h,091h,049h,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,091h,0b6h,0b6h,0b6h,091h,091h,091h,0b6h,0b6h,091h,091h,049h
	BYTE 049h,049h,091h,049h,049h,049h,049h,049h,049h,091h,091h,049h,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,091h,0b6h,0b6h,0b6h,091h,091h,091h,091h,091h,049h,049h
	BYTE 049h,024h,049h,091h,049h,049h,049h,049h,091h,091h,049h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,091h,0b6h,0b6h,0b6h,091h,091h,091h,091h,049h
	BYTE 049h,049h,024h,049h,091h,091h,091h,091h,091h,049h,049h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,091h,091h,0b6h,0b6h,091h,091h,091h
	BYTE 091h,091h,091h,091h,091h,049h,049h,049h,049h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,091h,0b6h,0b6h,091h
	BYTE 091h,049h,049h,049h,049h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,091h,091h,049h
	BYTE 049h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh

;; SPRITE STRUCTS
ASTEROID_0 SPRITE <offset asteroid_000, 200, 200, 0>
ASTEROID_1 SPRITE <offset asteroid_001, 400, 350, 0>
FIGHTER SPRITE <offset fighter_000, 350, 300, 0, 22, 19>

boomStr BYTE "Boom!", 0
testStr BYTE "Test!", 0
instructionStr BYTE "Press up/down arrow key to move the fighter jet!", 0

.CODE

;; Clears the screen
ClearScreen PROC uses ecx  edx
	mov eax, 640
	imul eax, 480
	mov ecx, 0
	mov edx, ScreenBitsPtr
clearingScreen:
	cmp ecx, eax
	jge doneClearing
	mov BYTE PTR [edx], 000h
	add ecx, 1
	add edx, 1
	jmp clearingScreen
doneClearing:
	ret
ClearScreen ENDP


;;; Draws all sprites on the screen
DrawAllSprites PROC uses ecx
	mov ecx, OFFSET ASTEROID_0
	INVOKE RotateBlit, (SPRITE PTR [ecx]).obj, (SPRITE PTR [ecx]).x_coord, (SPRITE PTR [ecx]).y_coord, (SPRITE PTR [ecx]).rotation
	mov ecx, OFFSET ASTEROID_1
	INVOKE RotateBlit, (SPRITE PTR [ecx]).obj, (SPRITE PTR [ecx]).x_coord, (SPRITE PTR [ecx]).y_coord, (SPRITE PTR [ecx]).rotation
	mov ecx, OFFSET FIGHTER
	INVOKE RotateBlit, (SPRITE PTR [ecx]).obj, (SPRITE PTR [ecx]).x_coord, (SPRITE PTR [ecx]).y_coord, (SPRITE PTR [ecx]).rotation
	ret
DrawAllSprites ENDP


GameInit PROC uses ecx edi esi
	INVOKE DrawStarField
	INVOKE DrawAllSprites
	ret         ;; Do not delete this line!!!
GameInit ENDP


GamePlay PROC uses ecx
	INVOKE ClearScreen ;; Clear the screen first
	INVOKE DrawStarField ;; Draw da stars
	INVOKE DrawStr, offset instructionStr, 80, 10, 0ffh

	INVOKE RotateRight, offset ASTEROID_0
	INVOKE RotateLeft, offset ASTEROID_1
;	INVOKE CheckCollision ;; Check if any collision 
	

	INVOKE SpaceOn	;; Check if the user pressed space
	cmp eax, 0
	jl CHECK_ARROWS
	INVOKE DrawStr, offset boomStr, 20, 20, 0ffh
	;INVOKE DrawAllSprites

CHECK_ARROWS:
	INVOKE UpArrowOn ;; Check if the user pressed up key
	cmp eax, 0
	jl CHECK_DOWNKEY
	INVOKE MoveUp, OFFSET FIGHTER ;; Move the jet up

CHECK_DOWNKEY:
	INVOKE DownArrowOn ;; Check if the user pressed down key
	cmp eax, 0
	jl CHECK_LEFTKEY
	INVOKE MoveDown, OFFSET FIGHTER ;; Move the thing down

CHECK_LEFTKEY:
	INVOKE LeftArrowOn ;; Check if the user pressed left key
	cmp eax, 0
	jl CHECK_RIGHTKEY
	INVOKE MoveLeft, OFFSET FIGHTER ;; Move the thing left

CHECK_RIGHTKEY:
	INVOKE RightArrowOn ;; Check if the user pressed right key
	cmp eax, 0
	jl GAME_END
	INVOKE MoveRight, OFFSET FIGHTER ;; Move the thing right

GAME_END:
	INVOKE DrawAllSprites
	ret         ;; Do not delete this line!!!
GamePlay ENDP



END
