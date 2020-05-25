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

SECTION "WRAM Vars", WRAM0[$C000]

SECTION "HRAM Vars", HRAM

hVBlankFlag: db
hCurKeys: db
hNewKeys: db

