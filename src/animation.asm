;----------------
; Animation Subs
;----------------

   struct Actor
   bytes 1, YPos
   bytes 1, XPos
   bytes 1, GFXCounter
   bytes 1, GFXState
   words 1, GFXData
   bytes 1, TileData
   end_struct

SECTION "Actor STructs", WRAM0

   dstruct Actor, Player

SECTION "Animation Variables", WRAM0

wCameraX: dw
wCameraY: dw

wWorkingX: dw
wWorkingY: dw
wWorkingScreenX: db
wWorkingScreenY: db
wWorkingState: db
wWorkingCounter: db
wWorkingData: dw
wWorkingTile: db
wWorkingEnd:

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
   ld a, [hli] ; a <- YPos
   ld [wWorkingScreenY], a
   ld a, [hli] ; a <- XPos
   ld [wWorkingScreenX], a
   push hl
   ld a, [hli] ; a <- GFXCounter
   ld [wWorkingCounter], a
   ld a, [hli] ; a <- GFXState
   ld [wWorkingState], a
   ld a, [hli] ; a <- GFXData(Low)
   ld [wWorkingData+1], a
   ld a, [hli] ; a <- GFXData (High)
   ld [wWorkingData], a
   ld a, [hl] ; a <- TileData
   ld [wWorkingTile], a
; fin loading data
   ld a, [wWorkingData]
   ld l, a
   ld a, [wWorkingData+1]
   ld h, a
; add actor struct offset saved in wWorkingState
   ld a, [wWorkingState]
   rlca                  ; double state offset because of word length
   add a, l
   ld l, a
   adc a, h
   sub l
   ld h, a               ; hl contains state struct pointer
   ld a, [hli]
   ld b, a
   ld a, [hl]
   ld l, b
   ld h, a
   ld a, [hli]           ; a <- state frame limit
   ld b, a
   ld a, [wWorkingCounter]
   inc a
   ld c, a
   ld a, b
   ld b, c
   cp b
   ld a, b
   jr nc, .continueAnimation
   xor a
.continueAnimation
   ; TODO: make counter 0 indexed so doesnt skip first frame
   ld [wWorkingCounter], a
   ld b, h
   ld c, l
   pop hl
   ld [hl], a
   ld h, b
   ld l, c
.loopFrameFind
   ld b, a      ; b <- current frame count
   ld a, [hli]  ; a <- next frame block
   ld c, a
   ld a, b
   ld b, c
   sub b
   jr z, .foundFrame
   jr c, .foundFrame
   inc hl
   inc hl
   jr .loopFrameFind
.foundFrame
   ld a, [hli]
   ld b, a
   ld a, [hl]
   ld h, a
   ld l, b     ; hl <- pointer to frame data
   ld a, [hli]
   ld b, a     ; b <- sprite counter
.spriteLoop
   ; load Y position, then offset by -16
   ld a, [hli]
   ld c, a
   ld a, [wWorkingScreenY]
   add c
   ld c, 16
   add c
   ld [de], a          ; store YPos in shadowOAM
   inc de
   ; load X position, then offset by -8
   ld a, [hli]
   ld c, a
   ld a, [wWorkingScreenX]
   add c
   ld c, 8
   add c
   ld [de], a          ; store YPos in shadowOAM
   inc de
   ; load tile offset, and add to base tile pointer
   ld a, [hli]
   ld c, a
   ld a, [wWorkingTile]
   add c
   ld [de], a
   inc de
   ; load attributes and xor them
   ld a, [hli]
   ld c, a
   ld a, 0    ; TO DO: set base attributes
   xor c
   ld [de], a
   inc de
   ; end of single sprite
   dec b
   jr nz, .spriteLoop
   ret

BUFFER       EQU 160
TRUE         EQU $42
FALSE        EQU $69
