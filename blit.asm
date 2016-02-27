; #########################################################################
;
;   blit.asm - Assembly file for EECS205 Assignment 3
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

.DATA
  OFFSET_TO_LPBYTES = 12
  SCREEN_WIDTH = 640
  SCREEN_HEIGHT = 480

  ;; If you need to, you can place global variables here

.CODE

;; Performs 16.16 fixed point multiplication
_FixedMul_32 PROC USES edx, a:FXPT, b:FXPT
  mov eax, a
  mov edx, b

  imul edx
  shrd eax, edx, 16       ;; eax <= { edx{31:16}, eax{31, 16} 
                ;; returns msb of integer and fraction parts
  ret
_FixedMul_32 ENDP

;; Throws away the decimal
FIXED_32_TO_INT PROC, a:DWORD
  mov eax, a
  shr eax, 16

  ret
FIXED_32_TO_INT ENDP


;; Modifies one byte in back buffer that represents screen
BIT_PLOT PROC USES ebx edx, x:DWORD, y:DWORD, color:DWORD
  mov edx, SCREEN_WIDTH         ;; edx = 640
  mov eax, y              ;; eax = row
  imul edx              ;; eax = row * 640

  mov edx, ScreenBitsPtr
  mov ebx, color
  add eax, x              ;; eax = row*640 + col
  add eax, edx            ;; eax = ScreenBitsPtr + row*ScreenWidth + col
  mov BYTE PTR [eax], bl        ;; move 1 byte for color into buffer

  ret
BIT_PLOT ENDP


;; keeps only the least significant bits
INT2FXPT PROC, a:DWORD
  mov eax, a
  sal eax, 16

  ret
INT2FXPT ENDP


BasicBlit PROC USES ebx ecx edx esi edi, ptrBitmap:PTR EECS205BITMAP, xcenter:DWORD, ycenter:DWORD
  LOCAL bmapIndex:DWORD, dwWidth : DWORD, dwHeight : DWORD, color : BYTE, bTransparent : BYTE,
        xstart : DWORD, ystart : DWORD

  mov edx, ptrBitmap
  mov ebx, xcenter
  mov ecx, ycenter
  mov al, (EECS205BITMAP PTR[edx]).bTransparent
  mov bTransparent, al

  mov eax, (EECS205BITMAP PTR[edx]).dwWidth
  mov dwWidth, eax
  sar eax, 1                                                ;; eax = dwWidth/2

  sub ebx, eax                                              ;; ebx = xcenter - dwWidth/2 = screenx
  mov xstart, ebx

  mov eax, (EECS205BITMAP PTR[edx]).dwHeight
  mov dwHeight,eax 
  sar eax, 1                                                ;; eax = dwHeight/2

  sub ecx, eax                                              ;; ecx = ycenter - dwWidth/2 = screeny
  mov ystart, ecx

  mov edi, 0                                                ;; ybm = 0
  mov edx, (EECS205BITMAP PTR[edx]).lpBytes                 ;; edx = ptrBitmap->lpBytes
  jmp OUTER_CHECK

  OUTER_FOR:
      mov esi, 0                                                ;; xbm = 0
      mov ebx, xstart                                           ;; screenx = xstart
      jmp INNER_CHECK

    INNER_FOR:
      mov eax, edi                                          ;; eax = ybm
      imul eax, dwWidth                                     ;; eax = ybm * dwWidth // avoid overwriting edx, might be an issue

      add eax, esi                                          ;; eax = ybm * dwWidth + xbm
      add eax, edx                                          ;; eax = &ptrBitmap->lpyBytes[ybm * dwWidth + xbm]

      ;; skip if transparent
      mov al, BYTE PTR [eax]                             ;; color = ptrBitmap->lpyBytes[ybm * dwWidth + xbm]
      cmp al, bTransparent
      je NO_PLOT

      ;;skip if out of x bounds
      cmp ebx, 0
      jl NO_PLOT
      cmp ebx, SCREEN_WIDTH
      jge NO_PLOT

      ;;skip if out of y bounds
      cmp ecx, SCREEN_HEIGHT
      jge NO_PLOT
      cmp ecx, 0
      jl NO_PLOT

      movzx eax, al
      INVOKE BIT_PLOT, ebx, ecx, eax

    NO_PLOT:
      inc esi                                           ;; xbm++
      inc ebx                                           ;; screenx++

    INNER_CHECK:
      cmp esi, dwWidth
      jl INNER_FOR

    inc edi                                       ;; ybm++
    inc ecx                                       ;; screeny++

  OUTER_CHECK:
    cmp edi, dwHeight
    jl OUTER_FOR

  ret
BasicBlit ENDP



RotateBlit PROC USES ebx ecx edx esi edi, lpBmp:PTR EECS205BITMAP, xcenter:DWORD, ycenter:DWORD, angle:FXPT
  LOCAL cosA: FXPT 
  LOCAL sinA: FXPT 
  LOCAL shiftX: DWORD
  LOCAL shiftY: DWORD
  LOCAL dstWidth: DWORD
  LOCAL dstHeight: DWORD
  LOCAL srcX: DWORD
  LOCAL srcY: DWORD
  LOCAL screenX: DWORD
  LOCAL screenY: DWORD

  INVOKE FixedCos, angle
  mov ebx, eax                                          
  mov cosA, ebx

  INVOKE FixedSin, angle
  mov ecx, eax                                         
  mov sinA, ecx

  mov esi, lpBmp                                          
  mov edx, (EECS205BITMAP PTR[esi]).dwWidth              
  mov edi, (EECS205BITMAP PTR[esi]).dwHeight              

  ;; Calculate shiftX
  mov eax, (EECS205BITMAP PTR[esi]).dwWidth
  sal eax, 16
  sar ebx, 1     
  imul ebx     
  mov shiftX, edx
  mov eax, (EECS205BITMAP PTR[esi]).dwHeight
  sal eax, 16
  sar ecx, 1                                              ;; ecx = sinA/2
  imul ecx                                                ;; edx = dwHeight * sinA/2              
  sub shiftX, edx                                         ;; shiftX = dwWidth * cosA/2 - dwHeight * sinA/2

  ;; Calculate shiftY
  mov edx, (EECS205BITMAP PTR[esi]).dwWidth
  mov ebx, cosA
  mov ecx, sinA
  mov eax, (EECS205BITMAP PTR[esi]).dwHeight
  sal eax, 16                                         
  sar ebx, 1                                               
  imul ebx                                                
  mov shiftY, edx   
  mov eax, (EECS205BITMAP PTR[esi]).dwWidth
  sal eax, 16                                               ;; eax = dwWidth
  sar ecx, 1                                                ;; ecx = sinA/2
  imul ecx                                                  ;; edx = dwHeight * sinA/2 
  add shiftY, edx                                           ;; shiftY = dwWidth * cosA/2 - dwHeight * sinA/2

  ;; CALCULATE dstWidth and dstHeight
  mov edi, (EECS205BITMAP PTR[esi]).dwHeight
  add edi, (EECS205BITMAP PTR[esi]).dwWidth
  mov dstWidth, edi
  mov dstHeight, edi

  ;; initialization for outer loop
  neg edi
  jmp OUTER_LOOP_CHECK

  OUTER_LOOP:
    ;; inner loop initialization
    mov ecx, dstHeight
    neg ecx
    jmp INNER_LOOP_CHECK

    INNER_LOOP:
      ;; calculate srcX
      INVOKE INT2FXPT, edi
      imul cosA
      mov srcX, edx

      INVOKE INT2FXPT, ecx
      imul sinA
      add srcX, edx


      ;; calculate srcY
      INVOKE INT2FXPT, ecx
      imul cosA
      mov srcY, edx

      INVOKE INT2FXPT, edi
      imul sinA
      sub srcY, edx

      ;; checking conditions 
      mov eax, xcenter
      add eax, edi
      sub eax, shiftX

      cmp eax, 0
      jl NO_PLOT
      cmp eax, 639
      jge NO_PLOT
      mov screenX, eax

      mov eax, ycenter
      add eax, ecx
      sub eax, shiftY

      cmp eax, 0
      jl NO_PLOT
      cmp eax, 479
      jge NO_PLOT
      mov screenY, eax

      mov eax, srcX
      cmp eax, 0
      jl NO_PLOT
      cmp eax, (EECS205BITMAP PTR[esi]).dwWidth
      jge NO_PLOT

      mov eax, srcY
      cmp eax, 0
      jl NO_PLOT
      cmp eax, (EECS205BITMAP PTR[esi]).dwHeight
      jge NO_PLOT


      mov eax, srcY
      imul (EECS205BITMAP PTR[esi]).dwWidth
      add eax, srcX
      add eax, (EECS205BITMAP PTR[esi]).lpBytes
      mov al, BYTE PTR [eax]

      ;; compare to transparent
      cmp al, (EECS205BITMAP PTR[esi]).bTransparent
      je NO_PLOT

      movzx eax, al
      INVOKE BIT_PLOT, screenX, screenY, eax

      NO_PLOT:

      inc ecx
    INNER_LOOP_CHECK:
      cmp ecx, dstHeight
      jl INNER_LOOP

    inc edi
  OUTER_LOOP_CHECK:
    cmp edi, dstWidth
    jl OUTER_LOOP

  ret 
RotateBlit ENDP


CheckIntersectRect PROC USES ecx edx one:PTR EECS205RECT, two:PTR EECS205RECT
  mov esi, one
  mov edi, two
  mov ecx, (EECS205RECT PTR[esi]).dwLeft 
  mov edx, (EECS205RECT PTR[edi]).dwRight 
  cmp ecx, edx
  jg NO_INTERSECT

  mov ecx, (EECS205RECT PTR[esi]).dwRight
  mov edx, (EECS205RECT PTR[edi]).dwLeft
  cmp ecx, edx 
  jl NO_INTERSECT

  mov ecx, (EECS205RECT PTR[esi]).dwTop 
  mov edx, (EECS205RECT PTR[edi]).dwBottom
  cmp ecx, edx 
  jg NO_INTERSECT

  mov ecx, (EECS205RECT PTR[esi]).dwBottom
  mov edx, (EECS205RECT PTR[edi]).dwTop
  cmp ecx, edx
  jl NO_INTERSECT

mov eax, -1
jmp RETURN

NO_INTERSECT:
  mov eax, 0

RETURN:
ret 
CheckIntersectRect ENDP



END
