;-----------------
; Actor Animation
;-----------------

SECTION "Actor", ROM0

ActorROM::
.structs:
   dw ActorIdle
   dw VillagerWaving
ActorIdle::
   db 60
   db 15
   dw .framePa
   db 15
   dw .frameRe
   db 15
   dw .frameCi
   db 15
   dw .frameVo
.framePa
   db (.framePaEnd - @) / 4
   db -8, -8,  1, 0
   db -8,  0,  2, 0
   db  0, -8,  9, 0
   db  0,  0, 10, 0
.framePaEnd

.frameRe
   db (.frameReEnd - @) / 4
   db -8, -8,  3, 0
   db -8,  0,  4, 0
   db  0, -8, 11, 0
   db  0,  0, 12, 0
.frameReEnd

.frameCi
   db (.frameCiEnd - @) / 4
   db -8, -8,  5, 0
   db -8,  0,  6, 0
   db  0, -8, 13, 0
   db  0,  0, 14, 0
.frameCiEnd

.frameVo
   db (.frameVoEnd - @) / 4
   db -8, -8,  7, 0
   db -8,  0,  8, 0
   db  0, -8, 15, 0
   db  0,  0, 16, 0
.frameVoEnd

VillagerWaving::
   db 90
   db 15
   dw .vwFrame01
   db 15
   dw .vwFrame02
   db 15
   dw .vwFrame03
   db 15
   dw .vwFrame04
   db 15
   dw .vwFrame05
   db 15
   dw .vwFrame06
.vwFrame01
   db (.vwFrame01End - @) / 4
   db  8, -16,  17, 0
   db  8,  -8,  18, 0
   db  0, -16,  19, 0
   db  0,  -8,  20, 0
   db -8, -16,  21, 0
   db -8,  -8,  22, 0
.vwFrame01End

.vwFrame02
   db (.vwFrame02End - @) / 4
   db  8, -16,  17, 0
   db  8,  -8,  18, 0
   db  0, -16,  23, 0
   db  0,  -8,  24, 0
   db -8, -16,  21, 0
   db -8,  -8,  22, 0
.vwFrame02End

.vwFrame03
   db (.vwFrame03End - @) / 4
   db  8, -16,  25, 0
   db  8,  -8,  26, 0
   db  0, -16,  23, 0
   db  0,  -8,  24, 0
   db -8, -16,  21, 0
   db -8,  -8,  22, 0
.vwFrame03End

.vwFrame04
   db (.vwFrame04End - @) / 4
   db  8, -16,  17, 0
   db  8,  -8,  18, 0
   db  0, -16,  23, 0
   db  0,  -8,  24, 0
   db -8, -16,  21, 0
   db -8,  -8,  22, 0
.vwFrame04End

.vwFrame05
   db (.vwFrame05End - @) / 4
   db  8, -16,  17, 0
   db  8,  -8,  18, 0
   db  0, -16,  19, 0
   db  0,  -8,  20, 0
   db -8, -16,  21, 0
   db -8,  -8,  22, 0
.vwFrame05End

.vwFrame06
   db (.vwFrame06End - @) / 4
   db  8, -16,  29, 0
   db  8,  -8,  30, 0
   db  0, -16,  27, 0
   db  0,  -8,  28, 0
   db -8, -16,  21, 0
   db -8,  -8,  22, 0
.vwFrame06End
