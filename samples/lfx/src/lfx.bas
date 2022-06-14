''''''''''''''''''''''''''''''
'LFX by Jon Mark O'Connor    '
'                            '
''''''''''''''''''''''''''''''
'Copyright (C) 1995 DOS World
'Published in Issue #20, March 1995


DECLARE SUB LAYER1 ()        'You don't need
DECLARE SUB LAYER2 ()        'to type in these
DECLARE SUB LETTERS ()       'DECLARE SUBs. They're
DECLARE SUB NORMAL1 ()       'added when you save
DECLARE SUB NORMAL0 ()       'the program.
DECLARE SUB TRANSLATE ()     '

DefInt A-Z 'The program starts here.
Dim P$(122)
Common Shared P$(), P$, SIZE$
Common Shared C1$, C2$, C3$
Common Shared C4$, BGC, DOT$
Common Shared SPACING$, WORD$
Common Shared PFT, PFL
Call LETTERS 'Call letterset.
Screen 9 '''''''''''''''''''''Set screen mode to 9.

EFFECT1:
Line (1, 1)-(338, 72), 4, BF 'Effect background.
Line (140, 3)-(336, 70), 1, BF
WORD$ = "DOS World" 'Word(s) to be converted.
SPACING$ = "L2" 'L decreases spacing; R increases it.
SIZE$ = "24" 'Use increments of four, up to half of resolution.
DOT$ = "N" 'No dot over i and j.
BGC = 4 'Background color.
Call TRANSLATE 'Converts above to a DRAW command.
C1$ = "C14": C2$ = "C 8": C3$ = "C 0": C4$ = "C15" 'Colors.
PFT = 52: PFL = 13: Call LAYER1 'PFT = position from top.
PFT = 52: PFL = 9: Call LAYER1 'PFL = position from left.
PFT = 51: PFL = 10: Call LAYER1 'Increase and decrease
PFT = 51: PFL = 11: Call LAYER1 'PFT and PFL to create depth.

EFFECT2:
Line (3, 78)-(338, 130), 13, B
Line (5, 80)-(336, 128), 7, BF
WORD$ = "DOS World"
SPACING$ = "L1"
SIZE$ = "20"
DOT$ = "N"
BGC = 7
Call TRANSLATE
C1$ = "C 5": C2$ = "C 8": C3$ = "C 8": C4$ = "C 8"
PFT = 117: PFL = 17: Call LAYER1
PFT = 117: PFL = 15: Call LAYER1
PFT = 117: PFL = 13: Call LAYER1
C1$ = "C 5": C2$ = "C 0": C3$ = "C 0": C4$ = "C15"
PFT = 115: PFL = 19: Call LAYER1
PFT = 115: PFL = 18: Call LAYER1

EFFECT3:
Line (3, 136)-(214, 192), 8, BF
Line (3, 136)-(338, 192), 7, B
WORD$ = "embossed glass"
SPACING$ = "L2"
SIZE$ = "16"
DOT$ = "N"
BGC = 8
Call TRANSLATE
C1$ = "C 0": C2$ = "C 0": C3$ = "C 0": C4$ = "C 0"
PFT = 167: PFL = 12: Call LAYER1
C1$ = "C 8": C2$ = "C 7": C3$ = "C15": C4$ = "C 0"
PFT = 167: PFL = 13: Call LAYER2
PFT = 167: PFL = 12: Call LAYER2
PFT = 166: PFL = 13: Call LAYER2
PFT = 167: PFL = 11: Call LAYER2

EFFECT4:
Line (2, 206)-(636, 303), 12, BF
Line (1, 204)-(639, 306), 15, B
Line (19, 280)-(620, 280), 14, B
Line (20, 281)-(619, 281), 0, B
Line (21, 282)-(618, 282), 0, B
WORD$ = "Sugar's Shack"
SPACING$ = "L1"
SIZE$ = "28"
DOT$ = "N"
BGC = 12
Call TRANSLATE
C1$ = "C12": C2$ = "C 4": C3$ = "C 0": C4$ = "C 0"
PFT = 266: PFL = 24: Call LAYER1
C1$ = "C12": C2$ = "C 4": C3$ = "C 0": C4$ = "C 0"
PFT = 265
For XX = 25 To 33 Step 2
    PFL = XX: Call LAYER1
    PFT = PFT - 1
Next
C1$ = "C15": C2$ = "C 6": C3$ = "C 6": C4$ = "C14"
PFT = 259: PFL = 40: Call LAYER1
PFT = 259: PFL = 36: Call LAYER1
PFT = 258: PFL = 38: Call LAYER1

EFFECT5:
Line (402, 4)-(639, 176), 15, B
Line (403, 5)-(638, 175), 11, B
Line (404, 6)-(637, 174), 9, BF
WORD$ = "Lfx"
SPACING$ = "L2"
SIZE$ = "48"
DOT$ = "N"
BGC = 9
Call TRANSLATE
C1$ = "C 0": C2$ = "C 0"
PFT = 123
For XX = 408 To 438 Step 2
    PFL = XX: Call NORMAL1
PFT = PFT - 1: Next XX
PFT = PFT - 1
C1$ = "C15": C2$ = "C 8": C3$ = "C 7": C4$ = "C15"
For XX = 436 To 413 Step -1
    PFL = XX: Call LAYER1
PFT = PFT + 1: Next XX

AUTHOR:
WORD$ = "by Jon Mark O'Connor"
SPACING$ = "R1"
SIZE$ = " 4"
DOT$ = "N"
BGC = 9
Call TRANSLATE
C1$ = "C15": C2$ = "C 0"
PFT = 167: PFL = 440: Call NORMAL1

ALPHABET:
Line (1, 315)-(639, 331), 7, B
Line (2, 316)-(638, 330), 15, BF
WORD$ = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_-+=:;'."
SPACING$ = "R0"
SIZE$ = " 4"
DOT$ = "N"
BGC = 15
Call TRANSLATE
C1$ = "C 1"
PFT = 325: PFL = 5: Call NORMAL0

HITENTER:
Line (2, 337)-(78, 350), 2, BF
WORD$ = "Hit Enter"
SPACING$ = "R1"
SIZE$ = " 4"
DOT$ = "N"
BGC = 2
Call TRANSLATE
C1$ = "C14"
PFT = 346: PFL = 5: Call NORMAL1

INKEY1:
C1$ = "C14"
PFT = 346: PFL = 5: Call NORMAL1
Sleep 1
C1$ = "C10"
PFT = 346: PFL = 5: Call NORMAL1
Sleep 1
A$ = InKey$: If A$ = "" Then GoTo INKEY1
End

'''''''''''''''''''''' SUBS '''''''''''''''''''

Sub LAYER1
    PSet (PFL + 2, PFT + 5), BGC: Draw C3$ + P$
    PSet (PFL + 0, PFT + 5), BGC: Draw C3$ + P$
    PSet (PFL + 1, PFT + 5), BGC: Draw C3$ + P$
    PSet (PFL + 0, PFT + 4), BGC: Draw C3$ + P$
    PSet (PFL + 1, PFT + 2), BGC: Draw C2$ + P$
    PSet (PFL + 2, PFT + 4), BGC: Draw C1$ + P$
    PSet (PFL + 3, PFT + 3), BGC: Draw C4$ + P$
    PSet (PFL + 3, PFT + 2), BGC: Draw C2$ + P$
    PSet (PFL + 4, PFT + 4), BGC: Draw C2$ + P$
    PSet (PFL + 5, PFT + 2), BGC: Draw C3$ + P$
    PSet (PFL + 5, PFT + 3), BGC: Draw C2$ + P$
    PSet (PFL + 4, PFT + 3), BGC: Draw C1$ + P$
End Sub

Sub LAYER2
    PSet (PFL + 0, PFT + 5), BGC: Draw C4$ + P$
    PSet (PFL + 0, PFT + 3), BGC: Draw C4$ + P$
    PSet (PFL + 2, PFT + 3), BGC: Draw C1$ + P$
    PSet (PFL + 1, PFT + 2), BGC: Draw C1$ + P$
    PSet (PFL + 2, PFT + 4), BGC: Draw C4$ + P$
    PSet (PFL + 3, PFT + 3), BGC: Draw C3$ + P$
    PSet (PFL + 3, PFT + 2), BGC: Draw C1$ + P$
    PSet (PFL + 4, PFT + 4), BGC: Draw C1$ + P$
    PSet (PFL + 5, PFT + 2), BGC: Draw C1$ + P$
    PSet (PFL + 5, PFT + 3), BGC: Draw C2$ + P$
    PSet (PFL + 4, PFT + 3), BGC: Draw C1$ + P$
End Sub

Sub LETTERS
    P$(32) = "BR4" 'space
    P$(33) = "BR1BD1U1BU2U5BD7BR3" '!
    P$(34) = "BR0BU7D2BR2U2BD7BR3" '"
    P$(35) = "BD1BR1U8D2L1R5L1U2D8U2L4R5BR2BD1" '#
    P$(36) = "BD1BR3U8D8BL3BU5U1E1R3F1BD1BL5F1R3F1D1G1L3H1BR7BD1" '$
    P$(37) = "BD1U1E6U1BL5BD2U1R1D1L1BD4BR4R1D1L1U1BD1BR5" '%
    P$(38) = "BR1BU2BL1E3U1H1L1G1D1F6BU1BL5BU3G2D1F1R3E3BD2BR2" '&
    P$(39) = "BR2BU7D1G1BD5BR4" ''
    P$(40) = "BR1BD1BU2U4E2G2D4F2BU1BR4" '(
    P$(41) = "BR2BD1BU2U4H2F2D4G2BU1BR5" ')
    P$(42) = "BR2BU2U6D3L2R4BL4BD2E4BL4F4BD3BR4" '*
    P$(43) = "BR2BD1U7D3L2R5BD3BR3" '+
    P$(44) = "BD1U1R1D2G1BU3BR4" ',
    P$(45) = "BR1BU3R3L3BD3BR5" '-
    P$(46) = "BD1BR1L1BU1BR4" '.
    P$(47) = "BR1E5G5BR7" '/
    P$(48) = "BD1BU1U6E1R2F1D6G1L2H1BR6" '0
    P$(49) = "BD1BR2U7BL1E1D1BD6BR3" '1
    P$(50) = "BR1BU6E1R2F1D2G4D1R4BU1BR3" '2
    P$(51) = "BU6E1R2F1D2G1L2R2F1D2G1L2H1BR7" '3
    P$(52) = "BU3E4D8U4L4R5BD3BR3" '4
    P$(53) = "BR1BU3U4R4L4D4E1R2F1D3G1L2H1BR7" '5
    P$(54) = "BR1BD1BU4U3E1R2F1H1L2G1D6F1R2E1U3H1L2G1BD3BR6" '6
    P$(55) = "BR1BU7R4D3G4D1BU1BR7" '7
    P$(56) = "BR1BU6E1R2F1D2G1L2R2F1D2G1L2H1U2E1H1U2BD6BR7" '8
    P$(57) = "BR1BU4U2E1R2F1D6G1L2H1BU4F1R3BD3BR3" '9
    P$(58) = "BR1U1BU2U1BD4BR3" ':
    P$(59) = "BD1BR1BU1U1BU2U1BD4G1BU1BR6" ';
    P$(60) = "BU3E3G3F3BR3" '<
    P$(61) = "BU3R4BD2L4BR7BD1" '=
    P$(62) = "BU6BR1F3G3BR5" '>
    P$(63) = "BR1BU5U1E1R2F1D2G1D1BD2D1BU1BR3" '?
    P$(64) = "BD1BU1U6E1R3F1D5L2H1U2E1R1D3BD3L3H1F1R3E1BR3" '@
    P$(65) = "BD1U7E1R3F1D3L5R5D4BR4BU1" 'A
    P$(66) = "BD1U8R4F1D2G1L4R4F1D2G1L4BU1BR9" 'B
    P$(67) = "BD1BU1U6E1R3F1BD6G1L3H1F1R3BR4BU1" 'C
    P$(68) = "BD1U8R4F1D6G1L4BR9BU1 " 'D
    P$(69) = "BD1U8R4L4D4R3L3D4R4BU1BR4" 'E
    P$(70) = "BD1U8R5L5D4R4L4D4BR8BU1" 'F
    P$(71) = "BD1BU1U6E1R3F1BD6G1L3H1F1R3E1U3L2R2D3BR4" 'G
    P$(72) = "BD1U8D4R4U4D8BR4BU1" 'H
    P$(73) = "BD1BR3U8L1R2L1D8L1R2BR4BU1" 'I
    P$(74) = "BD1BU1F1R2E1U7L1R2L1D7BR5" 'J
    P$(75) = "BD1BU8D8U4R1E4G4F4BR4BU1" 'K
    P$(76) = "BD1BU8D8R4BU1BR4" 'L
    P$(77) = "BD1U7E1R2F1D7U7E1R2F1D7BU1BR4" 'M
    P$(78) = "BD1U8F7D1U8D8BR4BU1" 'N
    P$(79) = "BD1BU1U6E1R3F1BD6G1L3H1BR5U6D6BR4" 'O
    P$(80) = "BD1U8R4F1D2G1L4D4BR9BU1" 'P
    P$(81) = "BD1BU1U6E1R3F1BD6G1L3H1BR5U6BL3BD5F3BG3BR7BU5" 'Q
    P$(82) = "BD1U8R4F1D2G1L4R1F4BR4BU1" 'R
    P$(83) = "BD1BU5U2E1R3F1BD2BL5F1R3F1D2G1L3H1BR9" 'S
    P$(84) = "BR3BD1BU8L4R6L3D8BR6BU1" 'T
    P$(85) = "BD1BU1U7D7F1R3E1U7D7BR4" 'U
    P$(86) = "BD1BU8D5F2D1U1E2U5D5BR5BD2" 'V
    P$(87) = "BD1BU1U7D7F1R2E1U7D7F1R2E1U7D7BD1BR4BU1" 'W
    P$(88) = "BD1BU8D1F3E3U1D1G6D1U1E3F3D1BU1BR5" 'X
    P$(89) = "BL1BU5U2D2F3E3U2D2G3D3BU1BR7" 'Y
    P$(90) = "BU7R5D2G5D1R5BR4BU1" 'Z
    P$(91) = "BR1BD1BR3L3U8R3BR3BD7" '[
    P$(92) = "BU5F5BR3" '\
    P$(93) = "BD1R3U8L3BR2BD7BR4" ']
    P$(94) = "BR1BU5E2F2BD5BR2" '^
    P$(95) = "BD1R4BU1BL2BR5" '_
    P$(96) = "BR2BU7D1F1BD5BR2" '`
    P$(97) = "U2E1R3U1H1L2G1E1R2F1D4G1L2H1F1BR2E1U2D3BR4BU1" 'a
    P$(98) = "BD1U8D8R3E1U4H1L2G1D4BR8" 'b
    P$(99) = "BR0U4E1R2F1BD4G1L2H1F1R2E1BR4" 'c
    P$(100) = "U4E1R2F1H1L2G1D4F1R2E1U7D7D1BU1BR4" 'd
    P$(101) = "U4E1R2F1D2L4D2F1R2E1BR4" 'e
    P$(102) = "BR1BD1U7E1R2F1H1L2G1D3L1R3BD3BR5" 'f
    P$(103) = "U4E1R2F1D4G1L2H1BD3F1R2E1U3BR4" 'g
    P$(104) = "BU7D8U5E1R2F1D5BU1BR4" 'h
    P$(105) = "BR3BD1U6BU2BD7BR4" 'i
    P$(106) = "BR1BD1U6BU2BD7D3G1L2BU4BR8" 'j
    P$(107) = "BD1BU8D8U3E3G3F3BU1BR3" 'k
    P$(108) = "BR1BD1U8L1R1D8L1R2BR4BU1" 'l
    P$(109) = "BD1U6D1E1R1F1D5U5E1R1F1D5BU1BR4" 'm
    P$(110) = "BD1U6D1E1R2F1D5U4BD3BR4" 'n
    P$(111) = "U4E1R2F1D4G1L2H1BR8" 'o
    P$(112) = "U4E1R2F1D4G1L2H1D4U4BR8" 'p
    P$(113) = "U4E1R2F1D4G1L2H1BR4D4L1R2L1U4BR5" 'q
    P$(114) = "BD1U6D1E1R2F1H1L2G1U1D6BU1BR7" 'r
    P$(115) = "BU3U1E1R2F1H1L2G1D1F1R2F1D1G1L2H1BR8" 's
    P$(116) = "BR1BU7D2L2R4L2D5F1R1E1BR4" 't
    P$(117) = "U5D5F1R2E1U5D5BR4" 'u
    P$(118) = "BD1BU6D3F2D1U1E2U3D3BD2BR4" 'v
    P$(119) = "BD1BU6D5F1R1E1U4D4F1R1E1U5D5BR4" 'w
    P$(120) = "BD1BU6D1F2E2U1D1G4D1U1E2F2D1BU1BR4" 'x
    P$(121) = "BU5D5F1R2E1U5D8G1L2H1BU3BR8" 'y
    P$(122) = "BU5R4D1G4D1R4BU1BR4" 'z
End Sub

Sub NORMAL0
    PSet (PFL + 0, PFT + 0), BGC: Draw C1$ + P$
End Sub

Sub NORMAL1
    PSet (PFL + 0, PFT + 1), BGC: Draw C2$ + P$
    PSet (PFL + 1, PFT + 0), BGC: Draw C1$ + P$
    PSet (PFL + 2, PFT + 0), BGC: Draw C1$ + P$
End Sub

Sub TRANSLATE
    SPACING$ = "B" + UCase$(SPACING$)
    SIZE$ = "S" + UCase$(SIZE$)
    P$(105) = "BR0BD1U6BU2BD7BR4" 'i
    P$(106) = "BR1BD1U6BU2BD7D3G1L2BU4BR8" 'j
    If DOT$ = "Y" Then P$(105) = "BR0BD1U6BU1U1BD7BR4" 'Dot over i.
    If DOT$ = "Y" Then P$(106) = "BR1BD1U6BU1U1BD7D3G1L2BU4BR8" 'Dot over j.
    P$ = SIZE$
    For J = 1 To Len(WORD$)
        P$ = P$ + P$(Asc(Mid$(WORD$, J, 1))) + SPACING$
    Next J
End Sub

