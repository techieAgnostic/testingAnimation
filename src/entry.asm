;----------------
; Program Start
;----------------

BUFFER       EQU 160
TRUE         EQU $42
FALSE        EQU $69

SECTION "Program Start", ROM0[$150]
Start:
   ei
   ld a, IEF_VBLANK
   ld [rIE], a
   xor a
   ld [hVBlankFlag], a
   call Wait_VBlank
   xor a
   ldh [rLCDC], a
   call Clear_Map
   call Load_Tiles
   ; call Load_Map
   ld a, %11100100
   ld [rBGP], a
   ld [rOBP0], a
   xor a
   ld [rSCY], a
   ld [rSCX], a
   ld [rNR52], a
   ld a, LCDCF_ON | LCDCF_OBJON | LCDCF_BGON
   ld [rLCDC], a

   call CopyDMARoutine 

   ld a, 72
   ld [rPlayerX], a
   ld a, 88
   ld [rPlayerY], a

;----
; Testing
;----
   ld a, HIGH(ANS)
   ld h, a
   ld a, LOW(ANS)
   ld l, a

; Case One: Camera@E100 vs Actor@E195 (Pass)
   ld a, $E1
   ld [N], a
   ld a, $E1
   ld [X], a
   ld a, $00
   ld [N+1], a
   ld a, $95
   ld [X+1], a
   call CheckBoundry

; Case One: Camera@E095 vs Actor@E120 (Pass)
   ld a, $E0
   ld [N], a
   ld a, $E1
   ld [X], a
   ld a, $95
   ld [N+1], a
   ld a, $20
   ld [X+1], a
   call CheckBoundry

; Case One: Camera@E100 vs Actor@E1FF (Fail)
   ld a, $E1
   ld [N], a
   ld a, $E1
   ld [X], a
   ld a, $00
   ld [N+1], a
   ld a, $FF
   ld [X+1], a
   call CheckBoundry

; Case One: Camera@E1F0 vs Actor@E2DE (Fail)
   ld a, $E1
   ld [N], a
   ld a, $E2
   ld [X], a
   ld a, $F0
   ld [N+1], a
   ld a, $DE
   ld [X+1], a
   call CheckBoundry

game_loop:
   call Wait_VBlank
   call Read_Pad
   call PC_Update
   call Player_To_OAM
   ld a, HIGH(wShadowOAM)
   call hOAMDMA
   jr game_loop

CheckBoundry::
;-----
; Check if word X is within BUFFER ahead of N
; BUFFER is always <= 255
; hl contains address to save result to
;-----
   ;= load high bytes
   ld a, [N]
   ld b, a
   ld a, [X]
   sub b
   ;= if carry is set, N is behind X, so skip
   jr c, .skipRender
   ld b, a
   ld a, 2
   cp b
   ;= if the difference is 2 or greater
   ;= we are not within BUFFER, so skip
   jr c, .skipRender
   jr z, .skipRender
   dec a
   cp b
   ;= if the high byte differ by 1, we
   ;= need to check over a a page
   jr z, .swap
   ;= load the low bytes
   ld a, [N+1]
   ld b, a
   ld a, [X+1]
   sub b
   ld b, a
   ld a, BUFFER
   cp b
   ;= if the difference is greater than
   ;= the buffer, skip
   jr c, .skipRender
   jr .render
.swap
   ;= load the low bytes in the opposite order
   ld a, [X+1]
   ld b, a
   ld a, [N+1]
   sub b
   ld b, a
   ld a, $FF - BUFFER
   cp b
   ;= if they differ by the inverse of the buffer
   ;= they will not be within the gap between pages
   jr nc, .skipRender
.render
   ;= success, do rendering stuff
   ; beep boop rendering stuff
   ld a, TRUE
   ld [hli], a
   ret
.skipRender
   ;= failure, skip this one
   ; doing other stuff here
   ld a, FALSE
   ld [hli], a
   ret
