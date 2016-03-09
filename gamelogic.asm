; #########################################################################
;
;   gamelogic.asm - Assembly file for EECS205 Assignment 5/5
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

;; Temporary EECS205RECT Structs used in CheckCollision
OBJ1_POS EECS205RECT <0, 0, 0, 0>
OBJ2_POS EECS205RECT <0, 0, 0, 0>

.CODE
;; Returns 0 if the user is pressing left mouse key, -1 otherwise
LeftMouseOn PROC uses ecx
	mov eax, 0
	mov ecx, MouseStatus.buttons
	cmp ecx, MK_LBUTTON
	je TRUE
	mov eax, -1
TRUE:
	ret
LeftMouseOn ENDP

;; Returns 0 if the user is pressing right mouse key, -1 otherwise
RightMouseOn PROC uses ecx
	mov eax, 0
	mov ecx, MouseStatus.buttons
	cmp ecx, MK_RBUTTON
	je TRUE
	mov eax, -1
TRUE:
	ret
RightMouseOn ENDP

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

;; Returns 0 if the user pressed the p key
PauseGame PROC 
	mov eax, 0
	mov ecx, KeyDown
	cmp ecx, VK_P
	je TRUE
	mov eax, -1
TRUE:
	ret
PauseGame ENDP

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

;; RETURNS 0 if the user is pressing.dwRight arrow key, -1 otherwise
RightArrowOn PROC
	mov eax, 0
	mov ecx, KeyDown
	cmp ecx, VK_RIGHT
	je TRUE
	mov eax, -1
TRUE:
	ret
RightArrowOn ENDP
	
;; RETURNS 0 if the user is pressing.dwLeft arrow key, -1 otherwise
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

;; Moves a SPRITE up
MoveUp PROC uses ecx sprite:DWORD
	mov ecx, sprite
	mov eax, (SPRITE PTR [ecx]).y_coord
	cmp eax, 0
	jle AtTopEdge
	sub (SPRITE PTR [ecx]).y_coord, 10
AtTopEdge:
	ret
MoveUp ENDP

;; Moves a sprite down
MoveDown PROC uses ecx sprite:DWORD
	mov ecx, sprite
	mov eax, (SPRITE PTR [ecx]).y_coord
	cmp eax, 450
	jge AtBottomEdge
	add (SPRITE PTR [ecx]).y_coord, 10
AtBottomEdge:
	ret
MoveDown ENDP

;; Moves a sprite left
MoveLeft PROC uses ecx sprite:DWORD
	mov ecx, sprite
	mov eax, (SPRITE PTR [ecx]).x_coord
	cmp eax, 0 ;; Make sure I'm not going over the line
	jle AtLeftEdge
	sub (SPRITE PTR[ecx]).x_coord, 10
AtLeftEdge:
	ret
MoveLeft ENDP

;; Moves a sprite right
MoveRight PROC uses ecx sprite:DWORD
	mov ecx, sprite
	mov eax, (SPRITE PTR [ecx]).x_coord
	cmp eax, 640 ;; Make sure I'm not going over the line
	jge AtRightEdge
	add (SPRITE PTR[ecx]).x_coord, 10
AtRightEdge:
	ret
MoveRight ENDP

;; Rotates a sprite in clockwise direction
RotateRight PROC uses edx sprite:PTR EECS205BITMAP
	mov eax, sprite
	add (SPRITE PTR [eax]).rotation, 00001000h
	ret
RotateRight ENDP

;; Rotates a sprite in anticlockwise direction
RotateLeft PROC uses edx sprite:PTR EECS205BITMAP
	mov eax, sprite
	sub (SPRITE PTR [eax]).rotation, 00001000h
	ret
RotateLeft ENDP

;; Updates positions of sprites
CalculatePosition PROC sprite:PTR EECS205BITMAP, pos: PTR EECS205RECT
	mov eax, sprite
	mov ecx, pos
	mov edx, (SPRITE PTR [eax]).x_coord
	mov edi, (SPRITE PTR [eax]).wide
	mov (EECS205RECT PTR [ecx]).dwLeft, edx
	mov (EECS205RECT PTR [ecx]).dwRight, edx
	sub (EECS205RECT PTR [ecx]).dwLeft, edi
	add (EECS205RECT PTR [ecx]).dwRight, edi

	mov edx, (SPRITE ptr [eax]).y_coord
	mov edi, (SPRITE ptr [eax]).height
	mov (EECS205RECT PTR [ecx]).dwTop, edx
	mov (EECS205RECT PTR [ecx]).dwBottom, edx
	sub (EECS205RECT PTR [ecx]).dwTop, edi
	add (EECS205RECT PTR [ecx]).dwBottom, edi 
	ret
CalculatePosition ENDP

;; Checks if there's any collisions. Returns -1 if there's a collision. 0 otherwise
CheckCollision PROC obj1: PTR EECS205BITMAP, obj2: PTR EECS205BITMAP
	INVOKE CalculatePosition, obj1, OFFSET OBJ1_POS
	INVOKE CalculatePosition, obj2, OFFSET OBJ2_POS
	INVOKE CheckIntersectRect, OFFSET OBJ1_POS, OFFSET OBJ2_POS
	ret
CheckCollision ENDP

;; Launches a missile


END
