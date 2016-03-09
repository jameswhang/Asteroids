; #########################################################################
;
;   gamelogic.inc - Includes for EECS205 Assignment 5/5
;
;
; #########################################################################

LeftMouseOn proto
RightMouseOn proto

SpaceOn proto
DownArrowOn proto
DownArrowOff proto
UpArrowOn proto
UpArrowOff proto
LeftArrowOn proto
RightArrowOn proto

PauseGame proto

CheckCollision proto obj:PTR EECS205BITMAP, obj2: PTR EECS205BITMAP
MoveAsteroid proto obj:PTR EECS205BITMAP, dir: DWORD
LevelUp proto score:DWORD

RotateLeft proto sprite:DWORD
RotateRight proto sprite:PTR EECS205BITMAP
MoveUp proto sprite:DWORD
MoveDown proto sprite:DWORD
MoveRight proto sprite:DWORD
MoveLeft proto sprite:DWORD

