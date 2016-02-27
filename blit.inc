; #########################################################################
;
;   blit.inc - Includes for EECS205 Assignment 3
;
;
; #########################################################################


_EECS205BITMAP STRUCT
 dwWidth      DWORD  ?
 dwHeight     DWORD  ?
 bTransparent BYTE   ?
              BYTE   3 DUP(?)
 lpBytes      DWORD  ?
_EECS205BITMAP ENDS

EECS205BITMAP TYPEDEF _EECS205BITMAP

_EECS205RECT STRUCT
 dwLeft   DWORD ?
 dwTop    DWORD ?
 dwRight  DWORD ?
 dwBottom DWORD ?
_EECS205RECT ENDS

EECS205RECT TYPEDEF _EECS205RECT

BasicBlit PROTO STDCALL ptrBitmap:PTR EECS205BITMAP, xcenter:DWORD, ycenter:DWORD

RotateBlit PROTO STDCALL ptrBitmap:PTR EECS205BITMAP, xcenter:DWORD, ycenter:DWORD, angle:FXPT
	   
CheckIntersectRect PROTO STDCALL one:PTR EECS205RECT, two:PTR EECS205RECT




