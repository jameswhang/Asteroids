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
;; RETURNS 0 if the user is pressing space key, -1 otherwise
SpaceOn PROC uses ecx
	mov eax, 0
	mov ecx, KeyDown
	cmp ecx, VK_SPACE
	je TRUE
	mov eax, -1 
TRUE:
	ret
SpaceOn ENDP


;; RETURNS 0 if the user is pressing down arrow key, -1 otherwise
DownArrowOn PROC uses ecx esi edi
	mov eax, 0
	mov ecx, KeyDown
	cmp ecx, VK_DOWN
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

;; RETURNS 0 if the user is pressing right arrow key, -1 otherwise
RightArrowOn PROC
	mov eax, 0
	mov ecx, KeyDown
	cmp ecx, VK_RIGHT
	je TRUE
	mov eax, -1
TRUE:
	ret
RightArrowOn ENDP
	
;; RETURNS 0 if the user is pressing left arrow key, -1 otherwise
LeftArrowOn PROC
	mov eax, 0
	mov ecx, KeyDown
	cmp ecx, VK_LEFT
	je TRUE
	mov eax, -1
TRUE:
	ret
LeftArrowOn ENDP

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

;; Moves a sprite up
MoveUp PROC uses ecx sprite:DWORD
	mov ecx, sprite
	sub (SPRITE PTR [ecx]).y_coord, 10
	ret
MoveUp ENDP

;; Moves a sprite down
MoveDown PROC uses ecx sprite:DWORD
	mov ecx, sprite
	add (SPRITE PTR [ecx]).y_coord, 10
	ret
MoveDown ENDP

;; Moves a sprite left
MoveLeft PROC uses ecx sprite:DWORD
	mov ecx, sprite
	sub (SPRITE PTR[ecx]).x_coord, 10
	ret
MoveLeft ENDP

;; Moves a sprite right
MoveRight PROC uses ecx sprite:DWORD
	mov ecx, sprite
	mov eax, (SPRITE PTR [ecx]).x_coord
	cmp eax, 640
	jge AtRightEdge
	add (SPRITE PTR[ecx]).x_coord, 10
AtRightEdge:
	ret
MoveRight ENDP

;; Rotates a sprite in clockwise direction
RotateRight PROC uses edx sprite:PTR EECS205BITMAP
	mov eax, sprite
	add (SPRITE PTR [eax]).rotation, 0001000h
	ret
RotateRight ENDP

;; Checks if there's any collisions
CheckCollision PROC fighter:PTR EECS205BITMAP, asteroid1:PTR EECS205BITMAP, asteroid2:PTR EECS205BITMAP
	
	ret

CheckCollision ENDP



END
