; #########################################################################
;
;   gamelogic.asm - Assembly file for EECS205 Assignment 4/5
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
include keys.inc
include game.inc

.DATA


.CODE
;; RETURNS 0 if the user is pressing down arrow key, -1 otherwise
DownArrowOn PROC uses ecx esi edi
	mov eax, 0
	mov ecx, KeyDown
	cmp ecx, VK_A
	je TRUE
	mov eax, -1
TRUE:
	ret
DownArrowOn ENDP

;; RETURNS 0 if the user released the down arrow key, -1 otherwise
DownArrowOff PROC uses ecx esi edi
	mov eax, 0
	mov ecx, KeyUp
	cmp ecx, VK_DOWN
	je TRUE
	mov eax, -1
TRUE:
	ret
DownArrowOff ENDP

;; RETURNS 0 if the user is pressing up arrow key, -1 otherwise
UpArrowOn PROC uses ecx esi edi
	mov eax, 0
	mov ecx, KeyDown
	cmp ecx, VK_UP
	je TRUE
	mov eax, -1
TRUE:
	ret
UpArrowOn ENDP

;; RETURNS 0 if the user released up arrow key, -1 otherwise
UpArrowOff PROC uses ecx esi edi
	mov eax, 0
	mov ecx, KeyUp
	cmp ecx, VK_UP
	je TRUE
	mov eax, -1
TRUE:
	ret
UpArrowOff ENDP

;; Rotates a sprite to the right
RotateRight PROC sprite:PTR SPRITEINFO
	mov eax, OFFSET sprite
	add (SPRITEINFO PTR [eax]).x_coord, 10

RotateRight ENDP



END
