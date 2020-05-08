PlayerGfx::
INCLUDE "res/actors/player.pal.asm" ; CGB palette
    db OAMF_PAL1 ; Additional attr
    dw PlayerTiles

PlayerTiles:
    ; number of tiles:
    db (.displayStructs - .tiles) / 16
.tiles
INCBIN "res/actors/player.2bpp"
.displayStructs
    dw PlayerStandingUp
    dw PlayerWalkingUp
    dw PlayerStandingDown
    dw PlayerWalkingDown
    dw PlayerStandingLeft
    dw PlayerWalkingLeft
    dw PlayerStandingRight
    dw PlayerWalkingRight

PlayerWalkingDown:
    db $20
    db 8
    dw .frame0
    db 8
    dw .frame1
    db 8
    dw .frame0
    db 8
    dw .frame2

.frame0
    db (.frame0End - @) / 4
    db -31, -8,  0, 0
    db -15, -8,  2, 0
    db -31,  0,  4, 0
    db -15,  0,  6, 0
.frame0End

.frame1
    db (.frame1End - @) / 4
    db -31, -8,  8, 0
    db -15, -8, 10, 0
    db -31,  0, 12, 0
    db -15,  0, 14, 0
.frame1End

.frame2
    db (.frame2End - @) / 4
    db -31, -8, 16, 0
    db -15, -8, 18, 0
    db -31,  0, 20, 0
    db -15,  0, 22, 0
.frame2End
