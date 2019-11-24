; variables.asm - header file of data segment addresses
;                 to make up for the lack of linking
;
; Generated by genvars.sh

hwndMain                            equ 0x10
hwndBoard                           equ 0x12
hwndInfo                            equ 0x14
hwndCounter                         equ 0x16
hwndInventory                       equ 0x1C
hwndHint                            equ 0x1E
GamePaused                          equ 0x24
PickUpToolSoundKey                  equ 0x336
OpenDoorSoundKey                    equ 0x346
ChipDeathSoundKey                   equ 0x354
LevelCompleteSoundKey               equ 0x363
SocketSoundKey                      equ 0x376
BlockedMoveSoundKey                 equ 0x382
ThiefSoundKey                       equ 0x393
SoundOnSoundKey                     equ 0x39E
PickUpChipSoundKey                  equ 0x3AB
SwitchSoundKey                      equ 0x3BB
SplashSoundKey                      equ 0x3C7
BombSoundKey                        equ 0x3D3
TeleportSoundKey                    equ 0x3DD
TickSoundKey                        equ 0x3EB
ChipDeathByTimeSoundKey             equ 0x3F5
PickUpToolSoundDefault              equ 0x40A
OpenDoorSoundDefault                equ 0x414
ChipDeathSoundDefault               equ 0x41D
LevelCompleteSoundDefault           equ 0x428
SocketSoundDefault                  equ 0x433
BlockedMoveSoundDefault             equ 0x43E
ThiefSoundDefault                   equ 0x447
SoundOnSoundDefault                 equ 0x452
PickUpChipSoundDefault              equ 0x45D
SwitchSoundDefault                  equ 0x468
SplashSoundDefault                  equ 0x471
BombSoundDefault                    equ 0x47C
TeleportSoundDefault                equ 0x485
TickSoundDefault                    equ 0x492
ChipDeathByTimeSoundDefault         equ 0x49D
MidiFileDefault1                    equ 0x4A6
MidiFileDefault2                    equ 0x4B1
MidiFileDefault3                    equ 0x4BC
TileTable                           equ 0x66C
HicolorTiles                        equ 0xA1A
LocolorTiles                        equ 0xA22
MonochromeTiles                     equ 0xA2B
GreatJobChipMsg                     equ 0xC6E
MelindaHerselfMsg                   equ 0xCA8
YouCompletedNLevelsMsg              equ 0xD44
DecadeMessages                      equ 0xEC2
Level50Message                      equ 0xED6
Level60Message                      equ 0xF58
Level70Message                      equ 0xFCB
Level80Message                      equ 0x1045
Level90Message                      equ 0x10C1
Level100Message                     equ 0x113A
Level110Message                     equ 0x11AD
Level120Message                     equ 0x122B
Level130Message                     equ 0x1291
Level140Message                     equ 0x1315
Chipend                             equ 0x1352
Chipend2                            equ 0x135A
GameStatePtr                        equ 0x1680
BlueKeyCount                        equ 0x1682
RedKeyCount                         equ 0x1684
GreenKeyCount                       equ 0x1686
YellowKeyCount                      equ 0x1688
FlipperCount                        equ 0x168A
FireBootCount                       equ 0x168C
IceSkateCount                       equ 0x168E
SuctionBootCount                    equ 0x1690
ChipsRemainingCount                 equ 0x1692
TimeRemaining                       equ 0x1694
TotalScore                          equ 0x1696

; vim: syntax=nasm
