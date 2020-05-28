;----------------
; Program Start
;----------------

INCLUDE "src/actor.asm"

SECTION "Program Start", ROM0[$150]
Start:
   ld a, IEF_VBLANK
   ld [rIE], a
   ei
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
   ld [rOBP1], a
   xor a
   ld [rSCY], a
   ld [rSCX], a
   ld [rNR52], a

   call CopyDMARoutine 

   ld a, 72
   ld [Player_YPos], a
   ld a, 80
   ld [Player_XPos], a
   ld a, $FF
   ld [Player_GFXCounter], a
   xor a
   ld [Player_GFXState], a
   ld [Player_TileData], a
   ld a, HIGH(ActorROM)
   ld [Player_GFXData+1], a
   ld a, LOW(ActorROM)
   ld [Player_GFXData], a

   ld a, LCDCF_ON | LCDCF_OBJON | LCDCF_BGON
   ld [rLCDC], a

game_loop:
   call Hide_OAM
   call Read_Pad
   call PC_Update
   call Wait_VBlank
   ld de, wShadowOAM
   ld hl, Player
   call RenderActor
   ld a, HIGH(wShadowOAM)
   call hOAMDMA
   jr game_loop

