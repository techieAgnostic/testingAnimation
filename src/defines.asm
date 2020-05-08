;----------------
; Definitions
;----------------

P1F_NONE     EQU $30
P1F_BUTTONS  EQU $10
P1F_DPAD     EQU $20

;----------------
; RAM Vars
;----------------

SECTION "ROM Vars", ROM0

dPlayerWidth: db 2
dPlayerHeight: db 2
dPlayerSpriteTiles: db $01, $02, $09, $0A

SECTION "WRAM Vars", WRAM0[$C000]

X: dw
N: dw
ANS: db

rPlayerX: db
rPlayerY: db

SECTION "HRAM Vars", HRAM

hVBlankFlag: db
hCurKeys: db
hNewKeys: db

