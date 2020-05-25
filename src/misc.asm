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
   ld a, [Player_XPos]
   add c
   ld [Player_XPos], a
   ld a, [Player_YPos]
   add b
   ld [Player_YPos], a
.end:
   ret


Clear_OAM:
   ld hl, wShadowOAM
   ld bc, wShadowOAMEnd - wShadowOAM
.loop:
   xor a
   ld [hli], a
   dec bc
   ld a, b
   or c
   jr nz, .loop
   ret

Hide_OAM:
   ld hl, wShadowOAM
   ld c, (wShadowOAMEnd - wShadowOAM) / 4
.loop:
   xor a
   ld [hl], a
   ld a, l
   or 3
   inc a
   ld l, a
   dec c
   jr nz, .loop
   ret

Clear_Map:
   ld hl, _SCRN0
   ld bc, _SCRN0_END - _SCRN0
.loop:
   xor a
   ld [hli], a
   dec bc
   ld a, b
   or c
   jr nz, .loop
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

