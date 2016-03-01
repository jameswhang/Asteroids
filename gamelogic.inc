; #########################################################################
;
;   gamelogic.inc - Includes for EECS205 Assignment 4/5
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



RotateLeft proto sprite:DWORD
RotateRight proto sprite:PTR EECS205BITMAP
MoveUp proto sprite:DWORD
MoveDown proto sprite:DWORD
MoveRight proto sprite:DWORD
MoveLeft proto sprite:DWORD

CheckCollision proto fighter:PTR EECS205BITMAP, asteroid0:PTR EECS205BITMAP, asteroid1:PTR EECS205BITMAP
