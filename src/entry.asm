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
   call Load_Map
   ld a, %11100100
   ld [rBGP], a
   ld [rOBP0], a
   ld a, %11000100
   ld [rOBP1], a
   xor a
   ld [rSCY], a
   ld [rSCX], a
   ld [rNR52], a

   call CopyDMARoutine 

   ld a, $3F
   ld [Player_YPos], a
   ld a, $3A
   ld [Player_XPos], a
   ld a, $FF
   ld [Player_GFXCounter], a
   ld a, 1
   ld [Player_GFXState], a
   xor a
   ld [Player_TileData], a
   ld a, HIGH(ActorROM)
   ld [Player_GFXData+1], a
   ld a, LOW(ActorROM)
   ld [Player_GFXData], a

   ld a, $71
   ld [NPC01_YPos], a
   ld a, $8C
   ld [NPC01_XPos], a
   ld a, 20
   ld [NPC01_GFXCounter], a
   ld a, 1
   ld [NPC01_GFXState], a
   xor a
   ld [NPC01_TileData], a
   ld a, HIGH(ActorROM)
   ld [NPC01_GFXData+1], a
   ld a, LOW(ActorROM)
   ld [NPC01_GFXData], a

   ld a, $15
   ld [NPC02_YPos], a
   ld a, $1C
   ld [NPC02_XPos], a
   ld a, 30
   ld [NPC02_GFXCounter], a
   ld a, 1
   ld [NPC02_GFXState], a
   xor a
   ld [NPC02_TileData], a
   ld a, HIGH(ActorROM)
   ld [NPC02_GFXData+1], a
   ld a, LOW(ActorROM)
   ld [NPC02_GFXData], a

   ld a, $29
   ld [NPC03_YPos], a
   ld a, $90
   ld [NPC03_XPos], a
   ld a, 40
   ld [NPC03_GFXCounter], a
   ld a, 1
   ld [NPC03_GFXState], a
   xor a
   ld [NPC03_TileData], a
   ld a, HIGH(ActorROM)
   ld [NPC03_GFXData+1], a
   ld a, LOW(ActorROM)
   ld [NPC03_GFXData], a

   ld a, $71
   ld [NPC04_YPos], a
   ld a, $4F
   ld [NPC04_XPos], a
   ld a, 50
   ld [NPC04_GFXCounter], a
   ld a, 1
   ld [NPC04_GFXState], a
   xor a
   ld [NPC04_TileData], a
   ld a, HIGH(ActorROM)
   ld [NPC04_GFXData+1], a
   ld a, LOW(ActorROM)
   ld [NPC04_GFXData], a

   ld a, $4A
   ld [NPC05_YPos], a
   ld a, $67
   ld [NPC05_XPos], a
   ld a, $FF
   ld [NPC05_GFXCounter], a
   ld a, 1
   ld [NPC05_GFXState], a
   xor a
   ld [NPC05_TileData], a
   ld a, HIGH(ActorROM)
   ld [NPC05_GFXData+1], a
   ld a, LOW(ActorROM)
   ld [NPC05_GFXData], a

   ld a, LCDCF_ON | LCDCF_OBJON | LCDCF_BGON
   ld [rLCDC], a

game_loop:
   call Hide_OAM
   call Read_Pad
   call PC_Update
   ld de, wShadowOAM
   ld hl, Player
   call RenderActor
   ld hl, NPC01
   call RenderActor
   ld hl, NPC02
   call RenderActor
   ld hl, NPC03
   call RenderActor
   ld hl, NPC04
   call RenderActor
   ld hl, NPC05
   call RenderActor
   call Wait_VBlank
   ld a, HIGH(wShadowOAM)
   call hOAMDMA
   jr game_loop

