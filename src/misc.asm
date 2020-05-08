Player_To_OAM:
; -- first loop --
   ld hl, wShadowOAM
   ld a, [dPlayerHeight]
   ld b, a
   ld d, 16
   ld a, [rPlayerY]
   add d ; d has the base Y value (counting offsets)
   ld d, a
.fouter
   ld a, [dPlayerWidth]
   ld c, a ; c is finner counter
.finner
   ld a, d
   ld [hl], a
   ld a, 4
   call .add4hl
; end of finner loop
   dec c
   jr nz, .finner
   ld a, d
   ld d, 8
   add d
   ld d, a
; end of fouter loop
   dec b
   jr nz, .fouter
; -- second loop --
   ld hl, wShadowOAM+1
   ld a, [dPlayerHeight]
   ld b, a
.souter
   ld d, 8
   ld a, [rPlayerX]
   add d
   ld d, a
   ld a, [dPlayerWidth]
   ld c, a
.sinner
   ld a, d
   ld [hl], a
   add 8
   ld d, a
   ld a, 4
   call .add4hl
   dec c
   jr nz, .sinner
   dec b
   jr nz, .souter
; -- third loop --
   ld hl, wShadowOAM+2
   ld de, dPlayerSpriteTiles
   ld a, [dPlayerHeight]
   ld b, a
   ld a, [dPlayerWidth]
   ld c, a
   xor a
.tloop1
   add b
   dec c
   jr nz, .tloop1
   ld c, a
.tloop2
   ld a, [de]
   ld [hl], a
   ld a, 4
   call .add4hl
   inc de
   dec c
   jr nz, .tloop2
; -- fourth loop --
   ld hl, wShadowOAM+3
   ld a, [dPlayerHeight]
   ld b, a
   ld a, [dPlayerWidth]
   ld c, a
   xor a
.lloop1
   add b
   dec c
   jr nz, .lloop1
   ld c, a
.lloop2
   xor a
   ld [hl], a
   ld a, 4
   call .add4hl
   dec c
   jr nz, .lloop2
   ret

.add4hl:
   add a, l ; a = low + old_l
   ld l, a  ; a = low + old_l = new_l
   adc a, h ; a = new_l + old_h + carry
   sub l    ; a = old_h + carry
   ld h, a
   ret

PC_Update:
   ld b, 0
   ld c, 0
   ld a, [hCurKeys]
   and %10000000
   cp %10000000 ; 0 if down pressed
   jr nz, .up
   ld b, 1
.up:
   ld a, [hCurKeys]
   and %01000000
   cp %01000000 ; 0 if up pressed
   jr nz, .left
   ld b, 255
.left:
   ld a, [hCurKeys]
   and %00100000
   cp %00100000 ; 0 if down pressed
   jr nz, .right
   ld c, 255
.right:
   ld a, [hCurKeys]
   and %00010000
   cp %00010000 ; 0 if up pressed
   jr nz, .last
   ld c, 1
.last:
   ld a, [rPlayerX]
   add c
   ld [rPlayerX], a
   ld a, [rPlayerY]
   add b
   ld [rPlayerY], a
.end:
   ret


Clear_Map:
   xor a
   ld hl, _SCRN0
   ld bc, _SCRN0_END - _SCRN0
.loop:
   ld [hli], a
   dec bc
   ld a, b
   or c
   jr z, .loop
   ret

Load_Tiles:
   ld hl, _BGTILES
   ld de, parecivo_tile_data
   ld bc, parecivo_tile_data_size
   call MemCpy
   ld hl, _VRAM
   ld de, parecivo_tile_data
   ld bc, parecivo_tile_data_size
   call MemCpy
   ret

Load_Map:
   ld hl, _SCRN0
   ld de, Map
   ld bc, Map_Size
   call MemCpy
   ret


