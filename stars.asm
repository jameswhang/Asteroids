; #########################################################################
;
;   stars.asm - Assembly file for EECS205 Assignment 1
;
;	Written By: James Whang (syw973)
;
; #########################################################################

      .586
      .MODEL FLAT,STDCALL
      .STACK 4096
      option casemap :none  ; case sensitive


include stars.inc

.DATA

	;; If you need to, you can place global variables here

.CODE

DrawStarField proc

	;; Drawing 16-ish stars
	INVOKE DrawStar, 18, 18
	INVOKE DrawStar, 30, 58
	INVOKE DrawStar, 182, 48
	INVOKE DrawStar, 68, 288
	INVOKE DrawStar, 488, 382
	INVOKE DrawStar, 300, 128
	INVOKE DrawStar, 280, 100
	INVOKE DrawStar, 200, 38
	INVOKE DrawStar, 355, 81
	INVOKE DrawStar, 588, 28
	INVOKE DrawStar, 181, 420
	INVOKE DrawStar, 224, 398
	INVOKE DrawStar, 220, 424
	INVOKE DrawStar, 28, 484
	INVOKE DrawStar, 55, 283
	INVOKE DrawStar, 382, 182
	INVOKE DrawStar, 284, 282

	ret  			; Careful! Don't remove this line
DrawStarField endp


AXP	proc a:FXPT, x:FXPT, p:FXPT
	mov eax, a ; put the arguments into registers
	mov edx, x
	mov ecx, p

	imul edx ; fixed point multiplication
	shrd eax, edx, 16 ; shift right by 16 bits to deal with fixed point
	add eax, ecx ; add p

	ret  			; Careful! Don't remove this line	
AXP	endp
	
END