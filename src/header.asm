;-----------------
; Gameboy Header
;-----------------

SECTION "Header", ROM0[$100]

; Jump to the "Start" label
; which we must define ourselves

EntryPoint:
  nop
  jp Start;

; ROM Header $104 to $150
RomHeader:
; Nintendo Logo $104-$133
  db $CE,$ED,$66,$66,$CC,$0D,$00,$0B,$03,$73,$00,$83,$00,$0C,$00,$0D
  db $00,$08,$11,$1F,$88,$89,$00,$0E,$DC,$CC,$6E,$E6,$DD,$DD,$D9,$99
  db $BB,$BB,$67,$63,$6E,$0E,$EC,$CC,$DD,$DC,$99,$9F,$BB,$B9,$33,$3E
; Title (11 characters) $134-$13E
  db "ANIMATION",$00,$00
; Manufacturer Code (4 characters) $13F-$142
  db "LATA"
; CGB Flag $143
  db $00
; Licensee Code (2 characters) $144-$145
  db "00"
; SGB Flag $146
  db $00
; Cartridge Type $147
  db $00
; ROM Size $148
  db $00
; RAM Size $149
  db $00
; Destination Code $14A
  db $01
; Depreciated Licensee Code $14B
  db $33
; Version Number $14C
  db $00
; Header Checksum $14D
  db $00
; Global Checksum $14E-$14F
  db $00, $00
