;----------------
; Program Start
;----------------

INCLUDE "src/actor.asm"

SECTION "Program Start", ROM0[$150]
Start:
   ei
   ld a, IEF_VBLANK
   ld [rIE], a
   xor a
   ld [hVBlankFlag], a
   call Wait_VBlank
   xor a
   ldh [rLCDC], a
   call Clear_Map
   call Clear_OAM
   call Load_Tiles
   ; call Load_Map
   ld a, %11100100
   ld [rBGP], a
   ld [rOBP0], a
   xor a
   ld [rSCY], a
   ld [rSCX], a
   ld [rNR52], a
   ld a, LCDCF_ON | LCDCF_OBJON | LCDCF_BGON
   ld [rLCDC], a

   call CopyDMARoutine 

   ld a, 72
   ld [Player_YPos], a
   ld a, 80
   ld [Player_XPos], a
   xor a
   ld [Player_GFXCounter], a
   ld [Player_GFXState], a
   ld [Player_TileData], a
   ld a, HIGH(ActorROM)
   ld [Player_GFXData], a
   ld a, LOW(ActorROM)
   ld [Player_GFXData + 1], a

game_loop:
   call Wait_VBlank
   call Read_Pad
   call PC_Update
   call Clear_OAM
   ld de, wShadowOAM
   ld hl, Player
   call RenderActor
   ld a, HIGH(wShadowOAM)
   call hOAMDMA
   jr game_loop

