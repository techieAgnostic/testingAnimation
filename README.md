= tA's terribleAssembly =

just me messing about trying to learn gameboy assembly

currently have an animation engine supporting:
   * arbitary sized frames
   * multiple actors
   * multiple animation states per actor (up to 128)
   * arbitary number of frames
   * arbitary time per frame of animation
   * distinct animation timers per actor
   * distinct colour palletes per tile in frame (limit 2 as per hardware)
   * arbitary position of tiles in the tile bank per actor type
   * arbitary positioning of tiles in each frame, including overlapping

== requisites ==

built using `rgbds`, will need to be installed for makefile to compile

== running ==

simply run `make` in the root directory to build the ROM

will appear as a `.gb` file in `./build`

== actor format ==

each actor has the following header:

```
ActorROM::
.structs:
   dw ActorIdle
   dw VillagerWaving
```

where each pointer under `.structs` is another structure in memory. these pointers may be shared between different actor definitions, however the tilesets for each actor will need to be compatible with the same animation for this to work.

each animation state has the following definition:

```
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
```

the first byte contains the total number of frames this animation will run for, and then each following set of 3 bytes contains:
   * the number of ticks this animation frame persists for
   * a pointer to the frame data

each frame has the following data:

```
.vwFrame01
   db (.vwFrame01End - @) / 4
   db  8, -16,  17, 0
   db  8,  -8,  18, 0
   db  0, -16,  19, OAMF_PAL1
   db  0,  -8,  20, OAMF_PAL1
   db -8, -16,  21, 0
   db -8,  -8,  22, 0
.vwFrame01End
```

the first byte is the number of tiles present in this frame of animation (analogous to the number of lines in the frame struct).

each following line is 4 bytes, pertaining to (respectively):

   * the x offset of this tile
   * the y offset of this tile
   * the tile offset
   * the attributes byte

the position offsets do not need to take into account the gameboys blanket sprite offsets, and the tile offset is zero indexed, and will be added to another offset based on where this actors tiles lie in memory.

the attribute byte is `xor`ed with the defaults in order to facilitate other pallettes or tile flips.
