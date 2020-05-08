;----------------
; Animation Subs
;----------------

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
   hWorkingTile: dw
hWorkingEnd:

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

; load world X and Y to temp RAM
   ld a, [hli]
   ld [hWorkingX], a
   ld a, [hli]
   ld [hWorkingX+1], a
   ld a, [hli]
   ld [hWorkingY], a
   ld a, [hli]
   ld [hWorkingY+1], a
; done loading X and Y
; figure out if within 256 of camera
; ---------
; first compare upper byte of XXYY
; if this is more than 1 away, break
   ld a, [hCameraX]
   ld b, a
   ld a, [hWorkingX]
; b = camera byte
; a = actor byte
; work out if actor minus camera is <= 1
  sub b
; ---------

.skipRendering
