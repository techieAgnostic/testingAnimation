;-----------------
; Actor Animation
;-----------------

SECTION "Actor", ROM0

ActorROM::
.structs:
   dw ActorIdle
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
