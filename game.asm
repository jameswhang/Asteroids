; #########################################################################
;
;   game.asm - Assembly file for EECS205 Assignment 5/5
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
include \masm32\include\windows.inc
include \masm32\include\masm32.inc
include \masm32\include\winmm.inc
include \masm32\include\user32.inc
includelib \masm32\lib\user32.lib
includelib \masm32\lib\winmm.lib
includelib \masm32\lib\masm32.lib
	
.DATA
;; If you need to, you can place global variables here
nuke_002 EECS205BITMAP <22, 21, 255,, offset nuke_002 + sizeof nuke_002>
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,01ch,01ch,01ch,01ch,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,01ch,01ch,01ch,01ch,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,01ch,01ch,01ch,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,01ch
	BYTE 01ch,01ch,0ffh,0ffh,0ffh,0ffh,01ch,01ch,01ch,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,01ch,01ch,01ch,0ffh,0ffh,0ffh,01ch,01ch,01ch,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,01ch,01ch,01ch,0ffh
	BYTE 0ffh,01ch,01ch,01ch,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,01ch,01ch,01ch,0ffh,01ch,01ch,01ch,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,01ch,01ch,01ch,0ffh,01ch,01ch,01ch
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,01ch
	BYTE 01ch,01ch,0ffh,01ch,01ch,01ch,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,01ch,01ch,01ch,0ffh,01ch,01ch,01ch,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,01ch,01ch,01ch,0ffh,0ffh
	BYTE 01ch,01ch,01ch,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 01ch,01ch,01ch,0ffh,0ffh,0ffh,01ch,01ch,01ch,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,01ch,01ch,01ch,0ffh,0ffh,0ffh,0ffh,01ch,01ch,01ch
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,01ch,01ch,01ch,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,01ch,01ch,01ch,01ch,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 01ch,01ch,01ch,01ch,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,01ch,01ch,01ch,01ch,01ch,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
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

asteroid_002 EECS205BITMAP <13, 14, 255,, offset asteroid_002 + sizeof asteroid_002>
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,049h
	BYTE 049h,024h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,049h,091h,049h,024h,024h,024h
	BYTE 024h,0ffh,0ffh,0ffh,0ffh,0ffh,091h,091h,0b6h,091h,049h,024h,024h,024h,024h,024h
	BYTE 0ffh,0ffh,091h,0b6h,0b6h,091h,091h,091h,049h,049h,024h,049h,024h,024h,0ffh,091h
	BYTE 0b6h,091h,091h,091h,0b6h,091h,091h,049h,049h,049h,024h,0ffh,091h,0b6h,0b6h,091h
	BYTE 049h,091h,0b6h,091h,049h,024h,049h,024h,0ffh,0ffh,091h,0b6h,0b6h,091h,049h,091h
	BYTE 049h,049h,024h,024h,024h,0ffh,0ffh,091h,0b6h,0b6h,0b6h,091h,091h,091h,049h,049h
	BYTE 024h,024h,0ffh,0ffh,0ffh,091h,091h,0b6h,0b6h,0b6h,091h,091h,091h,091h,024h,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,091h,091h,0b6h,0b6h,0b6h,049h,049h,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,091h,091h,091h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
;; SPRITE STRUCTS
ASTEROID_0 SPRITE <offset asteroid_000, 200, 200, 0, 18, 16>
ASTEROID_1 SPRITE <offset asteroid_001, 400, 150, 0, 16, 16>
ASTEROID_2 SPRITE <offset asteroid_002, 140, 50, 0, 18, 16>
FIGHTER SPRITE <offset fighter_000, 350, 300, 0, 22, 19>
NUKE SPRITE <offset nuke_002, 0, 0, 0, 0, 0>

;; Some game-related boolean values
isDead BYTE 0 ;; Checks if there was a collision
doRotate BYTE 1 ;; This rotates the asteroids
gameStarted BYTE 0 ;; Sets to 1 if user does anything
gamePaused BYTE 0 ;; Sets to 1 if the user presses 1
gameOverSoundPlayed BYTE 0;
nukeLaunched BYTE 0;

;; Some game-related dword values
currentScore DWORD 0	;; Score for the game
currentLevel DWORD 1	;; "stage" of the game

;; Strings that appear in the game
boomStr BYTE "Boom!", 0
deadStr BYTE "GAME OVER!", 0
scoreFmtStr BYTE "score: %d", 0
scoreOutStr BYTE 256 DUP(0)
levelFmtStr BYTE "level: %d", 0
levelOutStr BYTE 256 DUP(0)
stopRotateStr BYTE "You don't like these little asteroids moving???", 0
stopRotateInstStr BYTE "Click left button on mouse to keep them still!", 0
keepRotateInstStr BYTE "Click right button on mouse to keep them moving!", 0
keepRotateStr BYTE "You don't like these little asteroids staying still???", 0
instructionStr BYTE "Press the arrow keys to move the fighter jet around!", 0

;; Sounds
UpsetSoundPath BYTE "upset.wav", 0
BombSoundPath BYTE "bomb.wav", 0

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

;; Move all asteroids in a random direction
MoveAsteroids PROC USES ecx
	INVOKE nrandom, 100
	INVOKE MoveAsteroid, OFFSET ASTEROID_0, eax
	INVOKE nrandom, 100
	INVOKE MoveAsteroid, OFFSET ASTEROID_1, eax
	ret
MoveAsteroids ENDP

DrawSpecialAsteroid PROC uses ecx
	INVOKE CalculateTrajectory, OFFSET FIGHTER, OFFSET ASTEROID_2
	mov ecx, OFFSET ASTEROID_2
	INVOKE RotateBlit, (SPRITE PTR [ecx]).obj, (SPRITE PTR [ecx]).x_coord, (SPRITE PTR [ecx]).y_coord, (SPRITE PTR [ecx]).rotation
	ret
DrawSpecialAsteroid ENDP

;; Draws a nuke on the screen
DrawNuke PROC
	cmp nukeLaunched, 1
	jne DONENUKE
	mov ecx, OFFSET NUKE
	sub (SPRITE PTR [ecx]).y_coord, 5
	INVOKE RotateBlit, (SPRITE PTR [ecx]).obj, (SPRITE PTR[ecx]).x_coord, (SPRITE PTR [ecx]).y_coord, (SPRITE PTR [ecx]).rotation

	;; Check if the nuke went out of screen
	;; if so, make nuke disappear
	mov eax, (SPRITE PTR [ecx]).y_coord
	cmp eax, 0
	jg DONENUKE
	mov nukeLaunched, 0
DONENUKE:
	ret
DrawNuke ENDP

;;; Draws all sprites on the screen
DrawAllSprites PROC uses ecx
	mov ecx, OFFSET ASTEROID_0
	INVOKE RotateBlit, (SPRITE PTR [ecx]).obj, (SPRITE PTR [ecx]).x_coord, (SPRITE PTR [ecx]).y_coord, (SPRITE PTR [ecx]).rotation
	mov ecx, OFFSET ASTEROID_1
	INVOKE RotateBlit, (SPRITE PTR [ecx]).obj, (SPRITE PTR [ecx]).x_coord, (SPRITE PTR [ecx]).y_coord, (SPRITE PTR [ecx]).rotation
	mov ecx, OFFSET FIGHTER
	INVOKE RotateBlit, (SPRITE PTR [ecx]).obj, (SPRITE PTR [ecx]).x_coord, (SPRITE PTR [ecx]).y_coord, (SPRITE PTR [ecx]).rotation
	INVOKE DrawNuke

	;; At level 5, special asteroid appears
	cmp currentLevel, 1
	jl DONEDRAWING
	INVOKE DrawSpecialAsteroid

DONEDRAWING:
	ret
DrawAllSprites ENDP

LaunchNuke PROC
	cmp nukeLaunched, 1
	je NUKEDONE
	mov ecx, OFFSET FIGHTER
	mov edx, OFFSET NUKE
	mov eax, (SPRITE PTR [ecx]).x_coord
	mov (SPRITE PTR [edx]).x_coord, eax
	mov eax, (SPRITE PTR [ecx]).y_coord
	mov (SPRITE PTR [edx]).y_coord, eax
	mov nukeLaunched, 1
NUKEDONE:
	ret
LaunchNuke ENDP

DrawScore PROC
	mov eax, currentScore
	push eax
	push offset scoreFmtStr
	push offset scoreOutStr
	call wsprintf
	add esp, 12
	invoke DrawStr, offset scoreOutStr, 80, 10, 0ffh
	mov eax, currentLevel
	push eax
	push offset levelFmtStr
	push offset levelOutStr
	call wsprintf
	add esp, 12
	invoke DrawStr, offset levelOutStr, 80, 25, 0ffh

DrawScore ENDP

GameInit PROC uses ecx edi esi
	INVOKE DrawStarField
	INVOKE DrawAllSprites
	rdtsc
	INVOKE nseed, eax
	ret    
GameInit ENDP

GamePlay PROC uses ecx
	INVOKE ClearScreen ;; Clear the screen first
	INVOKE DrawStarField ;; Draw da star

	cmp gameStarted, 0
	jnz GAMESTARTED
	INVOKE DrawStr, offset instructionStr, 80, 10, 0ffh

GAMESTARTED:
	cmp isDead, 0
	jnz DEAD

CHECKPAUSE:
	INVOKE PauseGame
	cmp eax, 0
	jne CHECKROTATE
	mov gamePaused, 1
PAUSE:
	cmp gamePaused, 1
	jne CHECKROTATE
	INVOKE ClearScreen
	jmp GAME_END

CHECKROTATE:
	cmp doRotate, 0
	je NOROTATE
	INVOKE RotateRight, offset ASTEROID_0
	INVOKE RotateLeft, offset ASTEROID_1

NOROTATE:
	;; Check if any collision 
  	INVOKE IsGameOver
	cmp eax, 0
	je CHECKNUKE
	mov isDead, 1
	jmp GAME_END

CHECKNUKE:
	add currentScore, 1 ;; Default add 1 per loop
	INVOKE DidNukeHit
	cmp eax, 0
	je NOCOL
	add currentScore, 100 ;; If hit an asteroid, get 100
	INVOKE LevelUp, currentScore
	mov currentLevel, eax
NOCOL:
	INVOKE MoveAsteroids

CHECK_LMOUSE:
	INVOKE LeftMouseOn ; Check if the user pressed left mouse btn 
	cmp eax, 0
	jne CHECK_RMOUSE
	mov gameStarted, 1
	mov doRotate, 0
	INVOKE DrawStr, offset stopRotateStr, 130, 20, 0ffh
	INVOKE DrawStr, offset keepRotateInstStr, 130, 40, 0ffh
CHECK_RMOUSE:
	INVOKE RightMouseOn ; Check if the user pressed right mouse btn
	cmp eax, 0
	jne CHECK_SPACE
	mov gameStarted, 1
	mov doRotate, 1
	INVOKE DrawStr, offset keepRotateStr, 130, 20, 0ffh
	INVOKE DrawStr, offset stopRotateInstStr, 130, 40, 0ffh
CHECK_SPACE:
	INVOKE SpaceOn	;; Check if the user pressed space
	cmp eax, 0
	jl CHECK_ARROWS
	mov gameStarted, 1
	INVOKE DrawStr, offset boomStr, 20, 20, 0ffh
	INVOKE LaunchNuke

CHECK_ARROWS:
	INVOKE UpArrowOn ;; Check if the user pressed up key
	cmp eax, 0
	jl CHECK_DOWNKEY
	mov gameStarted, 1
	INVOKE MoveUp, OFFSET FIGHTER ;; Move the jet up

CHECK_DOWNKEY:
	INVOKE DownArrowOn ;; Check if the user pressed down key
	cmp eax, 0
	jl CHECK_LEFTKEY
	mov gameStarted, 1
	INVOKE MoveDown, OFFSET FIGHTER ;; Move the thing down

CHECK_LEFTKEY:
	INVOKE LeftArrowOn ;; Check if the user pressed left key
	cmp eax, 0
	jl CHECK_RIGHTKEY
	mov gameStarted, 1
	INVOKE MoveLeft, OFFSET FIGHTER ;; Move the thing left

CHECK_RIGHTKEY:
	INVOKE RightArrowOn ;; Check if the user pressed right key
	cmp eax, 0
	jl GAME_END
	mov gameStarted, 1
	INVOKE MoveRight, OFFSET FIGHTER ;; Move the thing right
	jmp GAME_END

DEAD:
	INVOKE DrawStr, offset deadStr, 280, 150, 0ffh ;; Dispay game over string
	;; Upset user
	cmp gameOverSoundPlayed, 1
	je GAME_END
	INVOKE PlaySound, OFFSET UpsetSoundPath, 0, SND_FILENAME
	mov gameOverSoundPlayed, 1
GAME_END:
	INVOKE DrawAllSprites
	INVOKE DrawScore
	ret         ;; Do not delete this line!!!
GamePlay ENDP


;; Checks if the game is over 
IsGameOver PROC 
	INVOKE CheckCollision, OFFSET FIGHTER, OFFSET ASTEROID_0
	cmp eax, 0
	jl GameOver
	INVOKE CheckCollision, OFFSET FIGHTER, OFFSET ASTEROID_1
	cmp eax, 0
	jl GameOver
	mov eax, 0
GameOver:
	ret
IsGameOver ENDP


;; Checks if the nuke hit
DidNukeHit PROC
	INVOKE CheckCollision, OFFSET NUKE, OFFSET ASTEROID_0
	cmp eax, 0
	jl NukeHit
	INVOKE CheckCollision, OFFSET NUKE, OFFSET ASTEROID_1
	cmp eax, 0
	jl NukeHit
	mov eax, 0
NukeHit:
	ret
DidNukeHit ENDP
END
