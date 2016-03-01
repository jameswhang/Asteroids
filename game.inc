; #########################################################################
;
;   game.inc - Includes for EECS205 Assignment 4/5
;
;
; #########################################################################

;; Library Definitions
MouseInfo STRUCT
 horiz DWORD ?
 vert  DWORD ?
 buttons DWORD ?
MouseInfo ENDS

BMPPTR TYPEDEF PTR EECS205BITMAP

;; Sprite Struct : Keeps track of x,y coordinates and rotation of a sprite
_SPRITE STRUCT
 obj BMPPTR ?  			; pointer to the bitmap data
 x_coord DWORD ? 		; the x-coordinate location
 y_coord DWORD ?		; the y-coordinate location
 rotation FXPT ?		; rotation in fxpt angle
 wide DWORD ?			; the width in px
 height DWORD ?			; the height in px
_SPRITE ENDS	

SPRITE TYPEDEF _SPRITE
SPRITE_PTR TYPEDEF PTR SPRITE

MK_CONTROL  = 0008h  ;; The CTRL key is down.
MK_LBUTTON  = 0001h  ;; The left mouse button is down.
MK_MBUTTON  = 0010h  ;; The middle mouse button is down.
MK_RBUTTON  = 0002h  ;; The right mouse button is down.
MK_SHIFT    = 0004h  ;; The SHIFT key is down.
MK_XBUTTON1 = 0020h  ;; The first X button is down.
MK_XBUTTON2 = 0040h  ;; The second X button is down.

;; Library Functions
BlackStarField	PROTO
DrawStr PROTO myStr:PTR BYTE, x:DWORD, y:DWORD, color:DWORD

;; Sprites
EXTERNDEF asteroid_000:EECS205BITMAP
EXTERNDEF fighter_000:EECS205BITMAP

;; Library Data
EXTERNDEF StarBitmap:EECS205BITMAP
EXTERNDEF MouseStatus:MouseInfo
EXTERNDEF KeyUp:DWORD
EXTERNDEF KeyDown:DWORD
EXTERNDEF KeyPress:DWORD

;; User Defined Functions
GameInit PROTO
GamePlay PROTO
