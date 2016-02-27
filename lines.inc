; #########################################################################
;
;   lines.inc - Includes for EECS205 Assignment 2
;
;
; #########################################################################

externdef SINTAB:WORD
externdef ScreenBitsPtr:DWORD

FixedSin proto angle:FXPT
FixedCos proto angle:FXPT
DrawLine proto x0:DWORD, y0:DWORD, x1:DWORD, y1:DWORD, color:DWORD
