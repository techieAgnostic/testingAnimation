;----------------
; Animation Subs
;----------------

   struct Actor
   bytes 1, YPos
   bytes 1, XPos
   bytes 1, GFXCounter
   bytes 1, GFXState
   bytes 1, TileData
   words 1, GFXData
   end_struct

SECTION "Actor STructs", WRAM0

   dstruct Actor, Player
   dstruct Actor, NPC01
   dstruct Actor, NPC02
   dstruct Actor, NPC03
   dstruct Actor, NPC04
   dstruct Actor, NPC05

SECTION "Animation Variables", HRAM

hCameraX: dw
hCameraY: dw

hWorkingX: dw
hWorkingY: dw
hWorkingScreenX: db
hWorkingScreenY: db
hWorkingState: db
hWorkingCounter: db
hWorkingData: dw
hWorkingTile: db

SECTION "Animations Subs", ROM0

; RenderActor:
;  takes a pointer to an actor struct
;  and renders it to shadow OAM, advancinc
;  the animation frame and constructing
;  each frame as needed.

; initial input:
;  [hl] <- start of Actor Struct in WRAM
; output:
;  an oam object for each line in the frame data,
;  copied to shadowOAM (wShadowOAM)

RenderActor::
   ; @input: hl <- Player
   ; @input: de <- ShadowOAM place
   ; clobbers af, bc, de, hl
   
   ld a, [hli]                                  ; a <- YPos
   ldh [hWorkingScreenY], a
   ld a, [hli]                                  ; a <- XPos
   ldh [hWorkingScreenX], a
   push hl                                      ; save counter pointer on stack
   ld a, [hli]                                  ; a <- GFXCounter
   ldh [hWorkingCounter], a
   ld a, [hli]                                  ; a <- GFXState
   ldh [hWorkingState], a
   ld a, [hli]                                  ; a <- TileData
   ldh [hWorkingTile], a
   ld a, [hli]                                  ; a <- GFXData(Low)
   ld h, [hl]                                   ; a <- GFXData (High)
   ld l, a

   ld a, [hWorkingState]                        ; add actor struct offset saved in wWorkingState
   rlca                                         ; double state offset because of word length
   add a, l
   ld l, a
   adc a, h
   sub l
   ld h, a                                      ; hl contains state struct pointer

   ld a, [hli]                                  ;
   ld h, [hl]                                   ; derefence [hl]
   ld l, a                                      ;

   ld a, [hWorkingCounter]
   inc a
   ld b, a
   ld a, [hli]                                  ; a <- state frame limit
   cp b
   ld a, b
   jr nc, .continueAnimation
   xor a
.continueAnimation
   ldh [hWorkingCounter], a
   ld b, h                                      ;
   ld c, l                                      ; save current hl
   pop hl                                       ; restore counter wram pointer
   ld [hl], a                                   ;
   ld h, b                                      ; restore hl
   ld l, c                                      ;

   ld c, a                                      ; save current frame in c
   xor a                                        ; set a = 0
.loopFrameFind                                  ; 
   ld b, a                                      ; b <- current total
   ld a, [hli]                                  ; a <- next frame tick limit
   add b                                        ; add to limit
   cp c                                         ; compare to limit
   jr nc, .foundFrame                           ; if no carry, cum total > current frame
   inc hl
   inc hl
   jr .loopFrameFind

.foundFrame
   ld a, [hli]
   ld h, [hl]
   ld l, a                                      ; hl <- pointer to frame data
   ld a, [hli]
   ld b, a                                      ; b <- sprite counter

.spriteLoop

   ld a, [hli]                                  ; load Y position, then offset by -16
   ld c, a
   ld a, [hWorkingScreenY]
   add c
   ld c, 16
   add c
   ld [de], a                                   ; store YPos in shadowOAM
   inc de
   
   ld a, [hli]                                  ; load X position, then offset by -8
   ld c, a
   ld a, [hWorkingScreenX]
   add c
   ld c, 8
   add c
   ld [de], a                                   ; store XPos in shadowOAM
   inc de

   ld a, [hli]                                  ; load tile offset, and add to base tile pointer
   ld c, a
   ld a, [hWorkingTile]
   add c
   ld [de], a
   inc de

   ld a, [hli]                                  ; load attributes and xor them
   ld c, a
   ld a, 0                                      ; TO DO: set base attributes
   xor c
   ld [de], a
   inc de
   
   dec b                                        ; end of single sprite
   jr nz, .spriteLoop
   ret
