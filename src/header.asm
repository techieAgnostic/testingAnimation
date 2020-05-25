;-----------------
; Gameboy Header
;-----------------

SECTION "Entry", ROM0[$100]
  di
  jp Start;

  ; Reserve space for header
  ds $150 - @, 0
