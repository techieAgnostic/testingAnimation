;------------------
; DMA Subroutines
;------------------

; In order to use, simply put your destination
; address into the `a` register, and call `hOAMDMA`

; Here we copy our DMA Routine into
; HRAM, which it needs to be in so
; it can function.

; Note: we can only copy into HRAM
; while the screen /ISN'T/ updating

SECTION "OAM DMA Routine", ROM0

; A DMA Transfor takes 160 microseconds
; to complete, which is 40 machine cycles.
; here we copy the high bit of our destination
; address (stored in a) to the DMA register
; then wait the time needed for the copy to
; complete.

DMARoutine:
   ldh [rDMA], a
   ld a, 40
.wait
   dec a
   jr nz, .wait
   ret
.end

CopyDMARoutine:
   ld hl, DMARoutine
   ld b, DMARoutine.end - DMARoutine
   ld c, LOW(hOAMDMA)
.copy
   ld a, [hli]
   ldh [c], a
   inc c
   dec b
   jr nz, .copy
   ret

; We reserve space in HRAM to keep our
; DMA routine.

SECTION "OAM DMA", HRAM
hOAMDMA:
   ds DMARoutine.end - DMARoutine

; We also reserve space to have a copy
; of OAM that we can write to at any time
; The DMA will then mirror this data to
; the real OAM.

SECTION "Shadow OAM", WRAM0,ALIGN[8]
wShadowOAM::
   ds 4*40
wShadowOAMEnd::
