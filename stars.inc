; #########################################################################
;
;   stars.inc - Includes for EECS205 Assignment 1
;
;
; #########################################################################

FXPT typedef SDWORD

DrawStar proto stdcall x:DWORD, y:DWORD

DrawStarField proto stdcall
AXP proto stdcall a:FXPT, x:FXPT, p:FXPT
