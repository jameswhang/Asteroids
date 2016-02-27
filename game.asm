; #########################################################################
;
;   game.asm - Assembly file for EECS205 Assignment 4/5
;
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
include keys.inc
	
.DATA

	
;; If you need to, you can place global variables here


.CODE

GameInit PROC
	
	ret         ;; Do not delete this line!!!
GameInit ENDP


GamePlay PROC

	ret         ;; Do not delete this line!!!
GamePlay ENDP
	

END
