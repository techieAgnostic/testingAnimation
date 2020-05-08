;--------------------
; Video Subroutines
;--------------------

SECTION "VBlank Int", ROM0[$40]
   ld a, 1
   ld [hVBlankFlag], a
   reti

SECTION "Vid Subs", ROM0

Wait_VBlank::
   ld   hl, hVBlankFlag  ; hl=pointer to vblank_flag
.wait:                   ; wait...
   halt                  ; suspend CPU - wait for ANY interrupt
   nop
   xor a
   cp   a,[hl]           ; vblank flag still zero?
   jr   z, .wait         ; wait more if zero
   ld   [hl],a           ; set vblank_flag back to zero
   ret

