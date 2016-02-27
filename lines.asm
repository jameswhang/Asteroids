; #########################################################################
;
;   lines.asm - Assembly file for EECS205 Assignment 2
;	Author: Adel Lahlou - adl538
;
; #########################################################################

      .586
      .MODEL FLAT,STDCALL
      .STACK 4096
      option casemap :none  ; case sensitive

include stars.inc
include lines.inc

.DATA
;;  These are some useful constants (fixed point values that correspond to important angles)
PI_HALF = 102943           	;;  PI / 2
PI =  205887	                ;;  PI 
TWO_PI	= 411774                ;;  2 * PI 
PI_INC_RECIP =  5340353        	;;  256 / PI   (use this to find the table entry for a given angle
	                        ;;              it is easier to use than divison would be)

SIGN_MASK_32 = 7fffffffh			;; used to remove greatest bit
SCREEN_WIDTH = 640
SCREEN_HEIGHT = 480


.CODE

Twos_Complement PROC val:DWORD
	mov eax, val
	not eax
	inc eax
	ret
Twos_Complement ENDP

;; keeps only the least significant bits
INT_TO_FIXED_32 PROC, a:DWORD
	mov eax, a
	shl eax, 16

	ret
INT_TO_FIXED_32 ENDP


;; Throws away the decimal
FIXED_TO_INT_32 PROC, a:DWORD
	mov eax, a
	shr eax, 16

	ret
FIXED_TO_INT_32 ENDP



FixedDiv_32 PROC USES edx ebx, a:FXPT, b:FXPT
	mov edx, 0
	mov eax, 0
	mov ax, WORD PTR a 				;; eax = fraction part 
	mov dx, WORD PTR a + 2			;; dx = integer part

	mov ebx, b

	idiv ebx 						;; eax = fixed point result
	ret 
FixedDiv_32 ENDP



FixedMul_32 PROC USES edx, a:FXPT, b:FXPT
	mov eax, a
	mov edx, b

	imul edx
	shrd eax, edx, 16

	ret
FixedMul_32 ENDP


ABS PROC val:DWORD
	mov eax, val
	cmp eax, 0
	jge FINISH_ABS					;; if negative, return Two's Complement (-val)
	not eax
	inc eax
  FINISH_ABS:
  	ret
ABS ENDP


FixedSin PROC USES edi edx ebx, angle:FXPT
	LOCAL ix:DWORD

	;; move things into registers
	mov edi, angle
	mov ebx, 1 			;; used to keep track of negative. Start off no negative

	;; general strategy, repeatedly modify angle value using identities 
	;; until it's a value we can handle. First we check for negatives

	;; cases
	;; (a) easy case: 0 <= angle  <= PI/2
	;; (b) simple case: -2PI <= angle  < 0
	;; (c) medium case: PI < angle 
	;; (d) bad case : angle >> 2PI


BIG_ANGLE:    ;; make sure the worst case can't happen
	cmp edi, TWO_PI
	jl NEGATIVE_ANGLE
	sub edi, TWO_PI
	jmp BIG_ANGLE

;; add 2 PI until positive
NEGATIVE_ANGLE:
	cmp edi, 0
	jge BINNING
	add edi, TWO_PI
	jmp NEGATIVE_ANGLE

BINNING:
	cmp edi,PI_HALF			;; check easy case      0 <= angle  <= PI/2
	jle FINISH
	
	mov edx, PI 			;; use identity 		sin(x) = sin(PI - x) for (P/2 < X < PI )
	sub edx, edi
	mov edi, edx 			;; esi = PI - angle

	;; angle is now (a) 0 <= angle <= Pi/2 or (b) PI <= angle < 0
	cmp edi, 0
	jge FINISH 		;; handles (a)

	;; use identity sin(x + Pi) = -sin(x)
	add edi, PI 			;; angle is now angle <= PI
	INVOKE Twos_Complement, ebx			;; keep track of whether we need to negate or not
	mov ebx, eax 
	jmp BINNING
FINISH:
	;; craft pointer to ScreenBitsPtr + row * ScreenWidth  + col
	Invoke FixedMul_32, edi, PI_INC_RECIP
    Invoke FIXED_TO_INT_32, eax
    
    mov edx, 0
    mov dx, WORD PTR [SINTAB + 2*eax]
    mov eax, edx
    imul eax, ebx
	ret        	
FixedSin ENDP 
	

FixedCos PROC USES ebx, angle:FXPT
	mov ebx, angle
	add ebx, PI_HALF
	invoke FixedSin, ebx
	
	ret        	
FixedCos ENDP	






;;;;;;;;;;;;;;; DrawLine Functions


PLOT PROC USES ebx edx, x:DWORD, y:DWORD, color:DWORD
	mov edx, 640
	mov eax, y
	imul edx							;; eax = row * 640

	mov edx, ScreenBitsPtr
	mov ebx, color
	add eax, x 							;; eax = row*640 + col
	add eax, edx
	mov BYTE PTR [eax], bl

	ret
PLOT ENDP



DrawLine PROC USES ebx esi edi ecx edx, x0:DWORD, y0:DWORD, x1:DWORD, y1:DWORD, color:DWORD
	LOCAL ix:DWORD,fixed_inc:FXPT, fixed_j:FXPT

	cmp x0, SCREEN_WIDTH
	jge VALUE_ERROR
	cmp x0, 0
	jl VALUE_ERROR

	cmp x1, SCREEN_WIDTH
	jge VALUE_ERROR
	cmp x1, 0
	jl VALUE_ERROR

	cmp y0, SCREEN_HEIGHT
	jge VALUE_ERROR
	cmp y0, 0
	jl VALUE_ERROR

	cmp y1, SCREEN_HEIGHT
	jge VALUE_ERROR
	cmp y1, 0
	jl VALUE_ERROR



	;; put them in registers so everything is fast
	mov esi, x0
	mov edi, x1
	mov edx, y0
	mov ebx, y1

	;; ABS(x1 - x0)
	mov eax, edi
	sub eax, esi
	Invoke ABS, eax
	mov ecx, eax 			;; ecx = Abs(x1 -x0)

	;; ABS(y1 - y0)
	mov eax, ebx
	sub eax, edx
	Invoke ABS, eax 		;; eax = Abs(y1 -y0)

	mov fixed_j, 100
	mov fixed_inc, 100
	;Invoke PLOT, fixed_j, fixed_inc, color

	cmp eax, ecx
	jl Y_LESS 					;; if(ABS(y1-y0) < ABS(x1 - x0))
	cmp ebx, edx
	jne NOT_SAME_Y 				;; if(y1 != y0)

VALUE_ERROR:
	jmp FINISH_DRAWLINE				;; if it reaches this point, neither specified conditions were found

Y_LESS: 
	mov eax, edi
	sub eax, esi 
	INVOKE INT_TO_FIXED_32, eax
	mov ecx, eax 					;; ecx = INT_TO_FIXED(x1 - x0)

	mov eax, ebx
	sub eax, edx
	INVOKE INT_TO_FIXED_32, eax 	;; eax = INT_TO_FIXED(y1 - y0)

	Invoke FixedDiv_32, eax, ecx
	mov  fixed_inc, eax 		  	;;fixed_inc = INT_TO_FIXED(y1 - y0)/INT_TO_FIXED(x1 - x0)

	cmp esi, edi
	jg X0_GREATER					;; if (x0 > x1)

	INVOKE INT_TO_FIXED_32, edx
	mov fixed_j, eax 				 ;; fixed_j = INT_TO_FIXED(y0)
	jmp FINISH_X0

  X0_GREATER: 
  	xchg esi, edi 					;; swap(x0, x1);
  	INVOKE INT_TO_FIXED_32, ebx
  	mov fixed_j, eax 				;; fixed_j = INT_TO_FIXED(y1)


  FINISH_X0:
  	;; move things into registers to make em fast
  	;; Initialize for for loop

  	mov ecx, esi 						;; i = x0
  	mov ebx, fixed_inc
  	mov edx, fixed_j
  	mov esi, color
  	jmp EVALUATE_X0_TO_X1				;; for(i = x0 to x1)
  X0_TO_X1:
  	INVOKE FIXED_TO_INT_32, edx			;; FIXED_TO_INT_32(fixed_j)
  	INVOKE PLOT, ecx, eax, esi 			;; Plot(i, FIXED_TO_INT_32(fixed_j), c)
  	add edx, ebx						;; fixed_j += fixed_inc
  	inc ecx
  EVALUATE_X0_TO_X1:
  	cmp ecx, edi				
  	jle X0_TO_X1				;; if   i <= x1

  	jmp FINISH_DRAWLINE

NOT_SAME_Y:
	
	; esi, x0
	; edi, x1
	; edx, y0
	; ebx, y1

	mov eax, edi
	sub eax, esi 
	INVOKE INT_TO_FIXED_32, eax
	mov ecx, eax 					;; ecx = INT_TO_FIXED(x1 - x0)

	mov eax, ebx
	sub eax, edx
	INVOKE INT_TO_FIXED_32, eax 	;; eax = INT_TO_FIXED(y1 - y0)

	Invoke FixedDiv_32, ecx, eax
	mov  fixed_inc, eax 		  	;; fixed_inc = INT_TO_FIXED(x1 - x0) / INT_TO_FIXED(y1 - y0)

	cmp edx, ebx
	jg Y0_GREATER					;; if (y0 > y1)

	INVOKE INT_TO_FIXED_32, esi
	mov fixed_j, eax 				 ;; fixed_j = INT_TO_FIXED(x0)
	jmp FINISH_Y0

  Y0_GREATER: 
  	xchg edx, ebx 					;; swap(y0, y1);
  	INVOKE INT_TO_FIXED_32, edi
  	mov fixed_j, eax 				;; fixed_j = INT_TO_FIXED(x1)


  FINISH_Y0:
  	;; move things into registers to make em fast
  	;; Initialize for for loop

  	mov ecx, edx 						;; i = y0
  	mov edi, fixed_inc
  	mov edx, fixed_j
  	mov esi, color
  	jmp EVALUATE_Y0_TO_Y1				;; for(i = y0 to y1)
  Y0_TO_Y1:
  	INVOKE FIXED_TO_INT_32, edx			;; FIXED_TO_INT_32(fixed_j)
  	INVOKE PLOT, eax, ecx, esi 			;; Plot(i, FIXED_TO_INT_32(fixed_j), c)
  	add edx, edi						;; fixed_j += fixed_inc
  	inc ecx
  EVALUATE_Y0_TO_Y1:
  	cmp ecx, ebx				
  	jle Y0_TO_Y1						;; if   i <= y1

  	jmp FINISH_DRAWLINE
FINISH_DRAWLINE:
	ret        	
DrawLine ENDP






;;;;;; STARS ASSIGNMENT FUNCTIONS

END
