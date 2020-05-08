;----------------------
; Utility Subroutines
;----------------------

SECTION "Util Subs", ROM0

; MemCpy assumes:
; hl contains destination address
; de contains source address
; bc contains number of bytes to copy

MemCpy:
.copy
   ld a, [de]
   ld [hli], a
   inc de
   dec bc
   ld a, b
   or c
   jr nz, .copy
   ret

; Read_Pad will set the variable _PAD
; such that bits are as follows:
; 7 - 4: down up left right
; 3 - 0: start select b a

Read_Pad:
  ld a,P1F_BUTTONS
  call .onenibble
  ld b,a  ; B7-4 = 1; B3-0 = unpressed buttons

  ld a,P1F_DPAD
  call .onenibble
  swap a   ; A3-0 = unpressed directions; A7-4 = 1
  xor b    ; A = pressed buttons + directions
  ld b,a   ; B = pressed buttons + directions
  ; check illegal buttons
  and %11000000           ; Up and Down buttons
  cp %11000000
  jr nz, .legalUpDown
  ld a, b
  and %00111111
  ld b, a
.legalUpDown
  and %00110000           ; Left and Right buttons
  cp %00110000
  jr nz, .legalLeftRight
  ld a, b
  and %11001111
.legalLeftRight
  ld a,P1F_NONE
  ld [rP1],a

  ldh a,[hCurKeys]
  xor b    ; A = keys that changed state
  and b    ; A = keys that changed to pressed
  ldh [hNewKeys],a
  ld a,b
  ldh [hCurKeys],a
  ret

.onenibble:
  ldh [rP1],a
  ldh a,[rP1]
  ldh a,[rP1]
  ldh a,[rP1]
  or $F0
  ret

