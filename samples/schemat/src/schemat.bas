WORK_DIR$ = _StartDir$
If Mid$(_OS$, 0, 9) = "[WINDOWS]" Then
    DIR_SEP$ = "\"
Else
    DIR_SEP$ = "/"
End If
Dim C%(2, 1)
Dim E1%(2, 1)
Dim E2%(2, 1)
Dim E4%(2, 2)
Dim E8%(3, 3)
Dim F(12) As String
On Error GoTo 83
g% = FreeFile
Open "SCH.KYS" For Input As #g%
For X = 1 To 12
    Y = X
    If X = 11 Then Y = 30
    If X = 12 Then Y = 31
    Input #g%, F(X)
    KEY Y, F(X)
Next X
Close #g%
'*******************************TITLE SCREEN
83 Cls: Screen 0: Color 3, 0, 1
_FullScreen 'QB64
If _FullScreen = 0 Then _FullScreen _Off 'QB64
Locate 10, 1:
Print "                             SCHEMATIC DESIGN PROGRAM "
Print "                                   Version 1.0 "
Print "                                   GPL Edition"
Print "                     (C) Copyright Leif J. Burrow 1994, 2019"
Print "                           Licensed under GPL 3.0 or later"
Locate 22, 1: Print "                                               Press <B> to begin."
Print "                              Press <F> to set function key macros."
'Accept Input
84 I$ = InKey$: If I$ = "" Then 84
If I$ = "B" Or I$ = "b" Then 85
If I$ = "F" Or I$ = "f" Then 99
GoTo 84

'********************************SETUP
85 S = 8
Screen 2
_FullScreen 'QB64
If _FullScreen = 0 Then _FullScreen _Off 'QB64
Cls
View Print 1 To 3
Line (312, 103)-(314, 103)
Line (316, 103)-(318, 103)
Line (315, 100)-(315, 102)
Line (315, 104)-(315, 106)
Get (312, 100)-(318, 106), C%()
Cls
Line (312, 103)-(314, 103)
Line (312, 104)-(314, 104)
Get (312, 103)-(314, 104), E1%()
Cls
Line (312, 103)-(316, 103)
Line (312, 103)-(312, 105)
Line (316, 103)-(316, 105)
Line (312, 105)-(316, 105)
Get (312, 103)-(316, 105), E2%()
Cls
Line (312, 103)-(312, 107)
Line (312, 103)-(320, 103)
Line (320, 103)-(320, 107)
Line (320, 107)-(312, 107)
Get (312, 103)-(320, 107), E4%()
Cls
Line (312, 103)-(328, 103)
Line (312, 103)-(312, 111)
Line (328, 103)-(328, 111)
Line (328, 111)-(312, 111)
Get (312, 103)-(328, 111), E8%()
Cls
SX = 320
SY = 100
P$ = "Vert"
F$ = "SCHEMAT"
GoSub 10

'*******************************PLACE CURSOR
1 Put (SX - 3, SY - 3), C%(), Xor

'**********************************COMMAND
89 I$ = InKey$: Locate 2, 69: Print Time$: If I$ = "" Then 89
Put (SX - 3, SY - 3), C%(), Xor
If I$ = Chr$(0) + Chr$(77) Then GoSub 4
If I$ = Chr$(0) + Chr$(75) Then GoSub 3
If I$ = Chr$(0) + Chr$(72) Then GoSub 2
If I$ = Chr$(0) + Chr$(80) Then GoSub 5
If I$ = "S" Or I$ = "s" Then 8
If I$ = "H" Or I$ = "h" Then 15
If I$ = "L" Or I$ = "l" Then 14
If I$ = "V" Or I$ = "v" Then 16
If I$ = "E" Or I$ = "e" Then 9
If I$ = "F" Or I$ = "f" Then 74
If I$ = "T" Or I$ = "t" Then 17
If I$ = "U" Or I$ = "u" Then 34
If I$ = "D" Or I$ = "d" Then 36
If I$ = "P" Or I$ = "p" Then 44
If I$ = "C" Or I$ = "c" Then 45
If I$ = "A" Or I$ = "a" Then 46
If I$ = "W" Or I$ = "w" Then 53
If I$ = "I" Or I$ = "i" Then 119
If I$ = "M" Or I$ = "m" Then 62
If I$ = "O" Or I$ = "o" Then 130
If I$ = "B" Or I$ = "b" Then 142
GoTo 1

'******************************** FUNCTIONS ************************************
' CLEAR SCREEN
10 Cls
11 Print "T-Transistor V-IC A-Passive D-Diode P-Photonic C-Connection M-Misc I-Misc2"
Print "B-Tubes O-Logic L-Line F-File W-Write S-Step H-Hor V-Vert|Mode="; P$: Return
Return

'*********************************FILE

'Print Menu
74 Print: Print
Print "Working Directory: " + WORK_DIR$
Print "N-New O-Open S-Save A-Save as P-Print M-Main H-Shell E-End"
75 I$ = InKey$: If I$ = "" Then 75
If I$ = "N" Or I$ = "n" Then 78
If I$ = "O" Or I$ = "o" Then 13
If I$ = "S" Or I$ = "s" Then 12
If I$ = "A" Or I$ = "a" Then 76
If I$ = "P" Or I$ = "p" Then 60
If I$ = "M" Or I$ = "m" Then 77
If I$ = "H" Or I$ = "h" Then 111
If I$ = "E" Or I$ = "e" Then End
GoTo 75

' SHELL
111 Print "Diagram will be lost if you have not saved it!"
Print "<C>ontinue or <M>ain Menu"
149 I$ = InKey$: If I$ = "" Then 149
If I$ = "C" Or I$ = "c" Then
    F$ = "SCHEMAT"
    Cls
    Shell
    GoSub 10
    GoTo 1
ElseIf I$ = "m" Or I$ = "m" Then
    GoSub 11
    GoTo 1
Else GoTo 149
End If

' New
78 Print "Diagram will be lost if you have not saved it!"
Print "<C>ontinue or <M>ain Menu"
150 I$ = InKey$: If I$ = "" Then 150
If I$ = "C" Or I$ = "c" Then
    F$ = "SCHEMAT"
    GoSub 10
    GoTo 1
Else GoTo 150
End If

'Load
13 Print: Print: Print
Print "Working Dir: " + WORK_DIR$ + ""
Input "File Name or <M> for Main Menu "; N$
If N$ = "M" Or N$ = "m" Then
    GoSub 11
    GoTo 1
End If
F$ = N$
On Error GoTo 82
' BLOAD F$ + ".SCH" ' QuickBasic
If _FileExists(WORK_DIR$ + DIR_SEP$ + F$ + ".BMP") = 0 Then 82
img& = _LoadImage(WORK_DIR$ + DIR_SEP$ + F$ + ".BMP")
wide% = _Width(img&)
deep% = _Height(img&)
_Source img&
_Dest 0
For Y = 0 To deep% - 1
    For X = 0 To wide% - 1
        PSet (X, Y), Point(X, Y)
    Next
Next
_Source 0
_Dest 0
PSet (0, 0), 1
GoSub 11
GoTo 1
82 Print "File Not Found"
' FOR A = 1 TO 450: NEXT A ' QuickBasic
_Delay 7
GoTo 13

' Save
12 On Error GoTo 151
' PRINT F$; ".SCH": PRINT "DATE: "; DATE$; "       TIME:"; TIME$ ' QuickBasic
Print F$; ".BMP": Print "DATE: "; Date$; "       TIME:"; Time$ ' QB64
' DEF SEG = &HB800 'QuickBasic
' BSAVE F$ + ".SCH", 0, 32768! 'QuickBasic
SaveImage 0, WORK_DIR$ + DIR_SEP$ + F$ + ".BMP"

GoSub 11
GoTo 1

'Save As
76 Print: Print: Print
Print "Working Dir: " + WORK_DIR$ + ""
Input "File Name or <M> for Main Menu "; N$
If N$ = "M" Or N$ = "m" Then
    GoSub 11
    GoTo 1
End If
F$ = N$
GoTo 12

' Print Diagram
60 On Error GoTo 151
Print: Print "<M> for main menu."
Input "Condenced <L> or Full page <K>"; I$
If I$ = "M" Or I$ = "m" Then
    GoSub 11
    GoTo 1
End If
If I$ = "l" Then I$ = "L" Else If I$ = "k" Then I$ = "K"
Print "                               "; F$; ".SCH"
Print "                DATE PRINTED: "; Date$; "   TIME: "; Time$
Def Seg = &HB800
Open "LPT1:" For Output As #2
' WIDTH "LPT1:", 255 - NOT SUPPORTED QB64
Print #2, Chr$(27); "1";
For X = 16112 To 16191
    B = X
    Print #2, Chr$(13);
    Print #2, Chr$(27); I$; Chr$(144); Chr$(1);
    54 Print #2, Chr$(Peek(B)); Chr$(0);
    If B >= 0 And B < 80 Then 55
    If B < 8000 Then B = B + 8112 Else B = B - 8192
    GoTo 54
55 Next X
Close #2
For X = 1 To 34
    LPrint
Next X
GoSub 11
GoTo 1
'error
151 Print "ERROR!"
For X = 1 To 450: Next X
Close #2
GoSub 11
GoTo 1

'Main Menu
77 GoSub 11
GoTo 1

'********************************MOVE CURSOR

' Move up
2 SY = SY - S: If SY <= 24 Then SY = 24
Return

'Move left
3 SX = SX - S: If SX < 4 Then SX = 4
Return

'Move right
4 SX = SX + S: If SX >= 626 Then SX = 626
Return

'Move down
5 SY = SY + S: If SY > 196 Then SY = 196
Return

'*****************************DRAW LINES
'Replace Cursor
14 Print: Print: Print "                              Line"
Put (SX - 3, SY - 3), C%(), Xor

'Start Line
PSet (SX, SY)
LX = SX: LY = SY

'Accept Input
6 I$ = InKey$: If I$ = "" Then 6
If I$ = "L" Or I$ = "l" Then 7
If I$ = Chr$(0) + Chr$(77) Then 'move right
    GoSub 94
    GoSub 4
    GoSub 94
    GoTo 6
End If
If I$ = Chr$(0) + Chr$(75) Then 'move left
    GoSub 94
    GoSub 3
    GoSub 94
    GoTo 6
End If
If I$ = Chr$(0) + Chr$(72) Then 'move up
    GoSub 94
    GoSub 2
    GoSub 94
    GoTo 6
End If
If I$ = Chr$(0) + Chr$(80) Then 'move down
    GoSub 94
    GoSub 5
    GoSub 94
    GoTo 6
End If

GoTo 6

'Cursor
94 Put (SX - 3, SY - 3), C%(), Xor
Return

'Draw Line
7 Put (SX - 3, SY - 3), C%(), Xor
Line (LX, LY)-(SX, SY)
GoSub 11
GoTo 1

'****************************CHANGE STEP
8 If S < 8 Then S = S * 2 Else S = 1
GoTo 1

'****************************ERASE BLOCK
'Print Menu
9 Print: Print: Print
Print "E-Erase M-Main Menu"

'Select Cursor
If S = 1 Then 95
If S = 2 Then 96
If S = 4 Then 97
If S = 8 Then 98

'Place Cursor
95 Put (SX, SY), E1%(), Xor
GoTo 100
96 Put (SX, SY), E2%(), Xor
GoTo 100
97 Put (SX, SY), E4%(), Xor
GoTo 100
98 Put (SX, SY), E8%(), Xor

'Accept Input
100 I$ = InKey$: If I$ = "" Then 100
If I$ = Chr$(0) + Chr$(77) Then 101
If I$ = Chr$(0) + Chr$(75) Then 102
If I$ = Chr$(0) + Chr$(72) Then 103
If I$ = Chr$(0) + Chr$(80) Then 104
If I$ = "M" Or I$ = "m" Then 107
If I$ = "E" Or I$ = "e" Then 106
GoTo 100

'Move Right
101 GoSub 105
GoSub 4
GoSub 105
GoTo 100

'Move Left
102 GoSub 105
GoSub 3
GoSub 105
GoTo 100

'Move Up
103 GoSub 105
GoSub 2
GoSub 105
GoTo 100

'Move Down
104 GoSub 105
GoSub 5
GoSub 105
GoTo 100

'Cursor
105 If S = 1 Then Put (SX, SY), E1%(), Xor
If S = 2 Then Put (SX, SY), E2%(), Xor
If S = 4 Then Put (SX, SY), E4%(), Xor
If S = 8 Then Put (SX, SY), E8%(), Xor
Return

'Erase
106 Line Step(0, 0)-Step(S * 2, S), 0, BF
Line (0, 0)-(0, 0), 1
GoSub 105
GoTo 100

'Main Menu
107 GoSub 105
GoSub 11
GoTo 1

'*****************************CHANGE POLARIZATION
'To Horizontal
15 P$ = "Hor"
Locate 2
Print "B-Tubes O-Logic L-Line F-File W-Write S-Step H-Hor V-Vert|Mode="; P$; ""
GoTo 1

' To Vertical
16 P$ = "Vert"
Locate 2
Print "B-Tubes O-Logic L-Line F-File W-Write S-Step H-Hor V-Vert|Mode="; P$; ""
GoTo 1

'***************************WRITE INFO
53 View Print
Locate Int(SY / 8) + 1, Int(SX / 8) + 1
Input ; "", U$
View Print 1 To 3
GoSub 11
GoTo 1

'*****************************CHANGE FUNCTION KEYS
' List Fkeys
99 Cls: Screen 0: Color 3, 0, 1
_FullScreen 'QB64
If _FullScreen = 0 Then _FullScreen _Off 'QB64
For X = 1 To 12
    Print "                    Function Key #"; X; ": "; F(X)
Next X
Print "                   Type 13 As Key# For Help."
Print "                TYPE 14 As Key# To Print Fkeys"

'Get New Fkeys
Input "ENTER KEY# ", X
If X = 13 Then 110
If X = 14 Then 117
Input "ENTER KEY SEQUENCE: ", S$
F(X) = S$
Input "ENTER ANOTHER? (Y/N): ", R$
If R$ = "Y" Or R$ = "y" Then 99

'Save Fkeys To Disk
Input "ENTER DRIVE LETTER: ", D$ 'QuickBasic
Open D$ + "SCH.KYS" For Output As #1 'QuickBasic
For X = 1 To 12
    Print #1, F(X)
Next X
Close #1

' Set Fkeys
For X = 1 To 12
    Y = X
    If X = 11 Then Y = 30
    If X = 12 Then Y = 31
    KEY Y, F(X)
Next X
KEY Off
GoTo 85

' Print Fkeys
117 For X = 1 To 12
    LPrint "                    Function Key #"; X; ": "; F(X)
    LPrint
Next X
GoTo 99

'************************ COMPONENTS ************************

'**********************TRANSISTOR
'Print Menu
17 Locate 1, 1
Print "N-NPN P-PNP U-UJT C-CUJT D-PUT S-SCR R-CSCR W-SCS O-SUS B-SBS T-Triac J-N JFET"
Print "F-P JFET G-N Mosfet E-P Mosfet M-Main Menu                                    "

' Accept Input
18 I$ = InKey$: If I$ = "" Then 18
If I$ = "M" Or I$ = "m" Then 19 'MAIN MENU
If I$ = "N" Or I$ = "n" Then 20 'NPN
If I$ = "P" Or I$ = "p" Then 21 'PNP
If I$ = "U" Or I$ = "u" Then 22 'UJT
If I$ = "C" Or I$ = "c" Then 23 'CUJT
If I$ = "D" Or I$ = "d" Then 24 'PUT
If I$ = "R" Or I$ = "r" Then 24 'CSCR
If I$ = "S" Or I$ = "s" Then 25 'SCR
If I$ = "W" Or I$ = "w" Then 26 'SCS
If I$ = "O" Or I$ = "o" Then 27 'SUS
If I$ = "B" Or I$ = "b" Then 28 'SBS
If I$ = "T" Or I$ = "t" Then 29 'TRIAC
If I$ = "J" Or I$ = "j" Then 30 'N-JFET
If I$ = "F" Or I$ = "f" Then 31 'P-JFET
If I$ = "G" Or I$ = "g" Then 32 'N-MOSFET
If I$ = "E" Or I$ = "e" Then 33 'P-MOSFET
GoTo 18

' Main Menu
19 GoSub 11
GoTo 1

' NPN
20 V$ = "D3 L6 R12 L2 D6 U6 L7 D2 L2 R4 L1 D1 L2 R1 D3"
H$ = "R6 U4 D8 U2 R4 U2 D4 R1 U4 D2 R1 U1 D2 R1 U2 D1 R4 BU5 L9"
GoTo 58

' PNP
21 V$ = "D3 R10 L20 BD1 BR 16 D6 R2 BL18 R6 U3 L2 R4 L1 U1 L2 R1 U1"
H$ = "R6 U4 D8 U2 R3 U1 D2 R1 U2 R1 U1 D4 R1 U4 D2 R5 BU5 L11 R11"
GoTo 58

' Unijunction Transistor
22 V$ = "G3 D1 L2 R4 L1 D1 L2 R1 D2 L7 R14 L2 D4 BL10 U4 D4"
H$ = "F4 U1 D2 R1 U2 D1 R3 U3 D6 U1 R8 BU4 L8 R8"
GoTo 58

' Complementary Unijunction Transistor
23 V$ = "G3 D1 R1 L3 D1 L1 R5 L2 D2 R7 L14 R2 D4 U4 R10 D4"
H$ = "F3 R2 U1 D2 R1 U2 R1 U1 D4 U2 R4 U4 D1 R7 L7 D7 U1 R7"
GoTo 58

'Programmable Unijunction Transistor
24 V$ = "D3 L4 R8 E3 G3 L1 D1 L6 R1 D1 R4 L1 D1 L2 R1 D2 L2 R4 L2 D2 BR20"
H$ = "R6 U2 H2 F2 D4 R1 U4 D1 R1 D2 R1 U2 D1 R4 U1 D2 U1 R4"
GoTo 58

' SCR
25 V$ = "D3 L4 R8 L1 D1 L6 R1 D1 R4 L1 D1 L2 R1 D1 L4  R8 L2 D3 U3 L3 G3"
H$ = "R6 U2 D4 R1 U4 D1 R1 D2 R1 U2 D1 R4 U2 D4 F2 H2 U2 R4"
GoTo 58

' Silicon Controlled Switch
26 V$ = "D3 L4 R8 E3 G3 L1 D1 L6 R1 D1 R4 L1 D1 L2 R1 D2 L3 R6 L2 D3 U3 L2 G3"
H$ = "R6 U2 H2 F2 D4 R1 U4 D1 R1 D2 R1 U2 D1 R4 U2 D4 F2 H2 U2 R4"
GoTo 58

' Silicon Unilateral Switch
27 V$ = "D3 R6 G6 U6 L6 R6 D6 L3 R6 L3 D3"
H$ = "D12 H6 R12 L12 U3 D6 U3 L6"
GoTo 58

' Silicon Bilateral Switch
28 If P$ = "Vert" Then 59
H$ = "D12 U6 L9 R15 L6 U3 L6 R11 D1 G5 L6 E6 U3"
GoTo 58

' Triac
29 If P$ = "Hor" Then 59
V$ = "D4 G3 H3 R12 L3 D1 F3 L6 E3 G3 D3 U3 L6 G3"
GoTo 58

' N-jfet
30 V$ = "D3 D1 L2 R4 L1 D1 L2 R1 D2 L7 R16 D1 L16 R2 D4 U4 R11 D4"
H$ = "R6 U3 D6 R1 U6 D1 R1 D4 R1 U4 D2 R3 U5 D10 U2 R6 L6 U6 R6"
GoTo 58

' P-jfet
31 V$ = "D3 L1 R2 D1 R1 L4 R2 D2 L5 R10 D1 L10 R2 D3 L6 R6 U3 R6 D3 R6"
H$ = "R4 U1 D2 R1 U2 R1 U1 D4 R1 U4 D2 R4 U5 D10 U2 R6 L6 U6 R6"
GoTo 58

' N-mosfet
32 V$ = "D2 R7 BD2 R3 D2 L1 D5 R4 L4 U5 L2 U2 BL3 D2 L1 D2 L2 R4 L2 D1 L1 R2 L1 D2 L6 R6 U5 L2 U2 R3 BL6 D2 L3 U2 R3 D2 L2 D5 L4"
H$ = "R5 U7 BR2 U3 R3 D2 R9 U4 D4 L9 D2 L3 BD3 R3 D1 R3 U1 D2 R1 U2 R1 U1 D4 R1 U4 D2 R3 D6 U6 L9 D2 L3 U3 BD6 D3 R3 U3 L3 D3 R3 U1 R9 D4"
GoTo 58

' P-mosfet
33 V$ = "D2 R7 BD2 R3 D2 L1 D5 R4 L4 U5 L2 U2 BL3 D2 L1 D2 L2 R4 L2 D1 L1 R2 L1 D2 L6 R6 U5 L2 U2 R3 BL6 D2 L3 U2 R3 D2 L2 D5 L4"
H$ = "R5 U7 BR2 U3 R3 D2 R9 U4 D4 L9 D2 L3 BD3 R3 D1 R3 U2 D4 R1 U4 D1 R1 D2 R1 U2 D1 R3 D6 U6 L9 D2 L3 U3 BD6 D3 R3 U3 L3 D3 R3 U1 R9 D4"
GoTo 58

'***************************INTEGRATED CIRCUITS

' Information
34 Print: Print
Print "NUMBER OF PINS";: Input P
If P <= 2 Then 35
P = P / 2

' Position
View Print
X = Int(SY / 8) + 1: Y = Int(SX / 8) + 1
Locate X, Y

' Top
Print "Ú";
For A = 1 To P: Print "ÄÁ";
Next A
Print "¿"

' MIDDLE
X = X + 1
Locate X, Y
Print "³ ^";
For A = 1 To P - 1: Print "  ";
Next A
Print "³"

' BOTTOM
X = X + 1
Locate X, Y
Print "À";
For A = 1 To P
    Print "ÄÂ";
Next A

Print "Ù"
View Print 1 To 3
GoSub 11
GoTo 1

'**************************Information Error Trap
35 If PN$ = "N" Or PN$ = "n" Then 24

'********************************DIODES

' PRINT MENU
36 Print "D-STND  Z-ZENER  T-TUNNEL  H-THYRECTOR  I-DIAC TRIGGER  M-MENU"
Print

'Accept Input
37 I$ = InKey$: If I$ = "" Then 37
If I$ = "D" Or I$ = "d" Then 38
If I$ = "Z" Or I$ = "z" Then 39
If I$ = "T" Or I$ = "t" Then 40
If I$ = "H" Or I$ = "h" Then 41
If I$ = "I" Or I$ = "i" Then 42
If I$ = "M" Or I$ = "m" Then 43
GoTo 37

'Standard
38 V$ = "D3 L4 R8 L1 D1 L6 R1 D1 R4 L1 D1 L2 R1 D2 L3 R6 L3 D3"
H$ = "R6 U4 D8 R1 U8 D1 R1 D6 R1 U6 D1 R1 D4 R1 U4 D2 R4 U3 D6 U3 R6"
GoTo 58

'Zener
39 V$ = "D3 L4 R8 L1 D1 L6 R1 D1 R4 L1 D1 L2 R1 D2 L4 U1 D1 R8 D1 U1 L4 D3"
H$ = "R6 U4 D8 R1 U8 D1 R1 D6 R1 U6 D1 R1 D4 R1 U4 D2 R5 U3 L2 R2 D6 R2 L2 U3 R6"
GoTo 58

'Tunnel
40 V$ = "D3 L4 R8 L1 D1 L6 R1 D1 R4 L1 D1 L2 R1 D2 L4 U1 D1 R8 U1 D1 L4 D3"
H$ = "R6 U4 D8 R1 U8 D1 R1 D6 R1 U6 D1 R1 D4 R1 U4 D2 R4 U3 L2 R2 D6 L2 R2 U3 R6"
GoTo 58

'Thyrector
41 V$ = "D3 L3 R6 L3 D1 L2 R4 L2 D1 L1 R2 L1 D2 L2 BL5 U2 D2 L4 R4 BR5 R4 L2 D2 L1 R2 L1 D1 L2 R4 L2 D1 L3 R6 L3 D3"
H$ = "R6 U3 D6 R1 U6 D1 R1 D4 R1 U4 D1 R1 D2 R1 U2 D1 R4 U2 D4 BD3 L4 R4 D3 U3 BU5 R4 U1 D2 R1 U2 R1 U1 D4 R1 U4 R1 U1 D6 R1 U6 D3 R4"
GoTo 58

'Diac Trigger
42 V$ = "L8 R17 L4 D3 L3 R6 L1 D1 L4 R1 D1 R2 L1 D2 R6 BL21 R7 U2 L1 R2 U1 R1 L4 U1 L1 R6 L3 U3"
H$ = "D8 U16 D5 R4 U4 D8 R1 U8 D1 R1 D4 R1 U4 D1 R1 D2 R1 U2 D1 R5 U6 BD20 U6 L5 U1 D2 L1 U2 L1 U1 D4 L1 U4 L1 U1 D6 L1 U6 D3 L4"
GoTo 58

'Main Menu
43 GoSub 11
GoTo 1

'****************************PASSIVE COMPONENTS

' Print menu
46 Print " C-Capacitor  R-Resistor  O-Coil  M-Main Menu"
Print
'Accept Input
47 I$ = InKey$: If I$ = "" Then 47
If I$ = "C" Or I$ = "c" Then 48
If I$ = "R" Or I$ = "r" Then 49
If I$ = "O" Or I$ = "o" Then 50
If I$ = "M" Or I$ = "m" Then 52
GoTo 47

'Capacitor
48 V$ = "D3 R6 L12 BD2 D3 U3 R12 D3 U3 L6 D6"
H$ = "R6 D3 U6 BR6 R4 L4 D6 R4 L4 U3 R10"
GoTo 58

'Resistor
49 V$ = "D3 G2 F4 G4 F4 G2 D3"
H$ = "R6 E3 F6 E6 F6 E6 F6 E3 R6"
GoTo 58

'Coil
'Determine Polarization
50 If P$ = "Vert" Then
    'Draw Vertical Coil
    Draw "BM " + Str$(SX) + ", " + Str$(SY) + "D3"
    SY = SY + 5
    For X = 1 To 3
        Circle (SX, SY), 3
        SY = SY + 3
    Next X
    Draw "BM " + Str$(SX) + ", " + Str$(SY) + " D3"
    SY = SY + 3
    GoSub 11
    GoTo 1
Else
    'Draw Horizontal Coil
    Draw "BM " + Str$(SX) + ", " + Str$(SY) + " R6"
    SX = SX + 11
    For X = 1 To 3
        Circle (SX, SY), 6
        SX = SX + 6
    Next X
    SX = SX + 2
    Draw "BM " + Str$(SX) + ", " + Str$(SY) + " R6"
    SX = SX + 6
    GoSub 11
    GoTo 1
End If

'Main Menu
52 GoSub 11
GoTo 1

'*****************************     MISC PARTS

'Print Menu
62 Print "V-Variable Arrow  A-Antenna  B-Box  G-Ground  C-Chassis Gnd.  S-Switch  X-Xtal"
Print "L-Left Arrow  R-Right Arrow  U-Up Arrow  D-Down Arrow  P-Push Btn  M-Main Menu  "

'Accept Input
63 I$ = InKey$: If I$ = "" Then 63
If I$ = "V" Or I$ = "v" Then 64
If I$ = "A" Or I$ = "a" Then 65
If I$ = "B" Or I$ = "b" Then 66
If I$ = "G" Or I$ = "g" Then 67
If I$ = "C" Or I$ = "c" Then 68
If I$ = "S" Or I$ = "s" Then 69
If I$ = "L" Or I$ = "l" Then 70
If I$ = "R" Or I$ = "r" Then 71
If I$ = "U" Or I$ = "u" Then 72
If I$ = "D" Or I$ = "d" Then 73
If I$ = "X" Or I$ = "x" Then 80
If I$ = "M" Or I$ = "m" Then 81
If I$ = "P" Or I$ = "p" Then 118
GoTo 63

'Main Menu
81 GoSub 11
GoTo 1

'Variable Arrow
64 V$ = "H16 R3 L3 D3"
H$ = "E14 D3 U3 L3"
GoTo 58

'Antenna
65 If P$ = "Hor" Then 59
V$ = "U9 G6 R12 H6"
GoTo 58

'Box
66 V$ = "R96 D32 L96 U32"
H$ = V$
GoTo 58

'Ground
67 If P$ = "Hor" Then 59
V$ = "D3 L3 R6 L1 BD2 L4 R1 BD2 R2"
GoTo 58

'Chassis Ground
68 If P$ = "Hor" Then 59
V$ = "D6 U3 L6 D3 U3 R12 D3"
GoTo 58

'Switch
69 Circle (SX, SY), 4
V$ = "D8"
H$ = "BU4 R16"
GoTo 58

'Left Arrow
70 V$ = "E2 G2 F2 H2 R7"
H$ = V$
GoTo 58

'Right Arrow
71 V$ = "R7 H2 F2 G2"
H$ = V$
GoTo 58

'Up Arrow
72 V$ = "U5 G2 E2 F2"
H$ = V$
GoTo 58

'Down Arrow
73 V$ = "D5 H2 F2 E2"
H$ = V$
GoTo 58

'Crystal
80 V$ = "D3 R3 L6 BD2 R6 D2 L6 U2 D2 BD2 R6 L3 D3"
H$ = "R6 U3 D6 BR4 U6 R4 D6 L4 BR8 U6 D3 R6"
GoTo 58

'Push Button
118 V$ = "D3 L6 R12"
H$ = "R6 D3 U6"
GoTo 58


'*********************  MISC PARTS #2

'Print Menu
119 Print "A-AC Plug  E-Meter  L-Lamp  B-Battery  S-Speaker  P-Piezo Buzzer  O-Op Amp"
Print "M-Main Menu"

' Accept Input
120 I$ = InKey$: If I$ = "" Then 120
If I$ = "A" Or I$ = "a" Then 121
If I$ = "E" Or I$ = "e" Then 122
If I$ = "L" Or I$ = "l" Then 123
If I$ = "B" Or I$ = "b" Then 124
If I$ = "S" Or I$ = "s" Then 125
If I$ = "P" Or I$ = "p" Then 126
If I$ = "M" Or I$ = "m" Then 129
If I$ = "O" Or I$ = "o" Then 139
GoTo 120

' AC Plug
121 V$ = "BU11 D3 R2 L3 U3 D3 L5 U3 L1 D3 L3 R1 D1 F2 D5 U5 F3 R1 E3 D5 U5 E2 U1"
H$ = V$
GoTo 58

'Meter
122 V$ = "R6 U3 R14 D3 R6 L6 D6 L14 U6 D3 R14 L4 H4"
H$ = V$
GoTo 58

'Lamp
123 V$ = "D4 F6 E2 U2 L2 G6 D4"
H$ = "R7 E3 H1 L2 D1 F3 R7"
GoTo 58

'Battery
124 V$ = "D3 L4 L6 R6 D2 R6 U8 L6 D2 U2 R6 E6 D21 H6"
H$ = "R6 U3 D3 L2 D3 R8 U3 L2 R2 D3 F6 L21 E6"
GoTo 58

'Speaker
125 V$ = "R6 D4 L6 R6 D2 R6 U8 L6 D2 U2 R6 E6 D21 H6"
H$ = "D3 L4 U3 D3 L2 D3 R8 U3 L2 R2 D3 F6 L21 E6"
GoTo 58

'Piezo Buzzer
'Determine Polarization
126 If P$ = "Hor" Then
    'Draw Vertical
    Draw "BD3 R6 BR22 R6"
    CX = SX + 13
    Circle (SX, CY), 10
    Circle (SX, CY), 3
    GoSub 11
    GoTo 1
Else
    'Draw Horizontal
    Draw "BR2 D3 BD10 D3"
    CY = SY + 5
    Circle (SX, CY), 10
    Circle (SX, CY), 3
    GoSub 11
    GoTo 1
End If

'Operational Amplifier
139 V$ = "D3 G6 R3 D3 U3 R6 D3 U3 R3 H6"
H$ = ""
GoTo 58

'Main Menu
129 GoSub 11
GoTo 1


'****************************** LOGIC

'Display Menu
130 Print "A-And N-Nand I=Inverter O-Or R-Nor E-Ex-or M-Main Menu"
Print

'Accept Input
131 I$ = InKey$: If I$ = "" Then 131
If I$ = "A" Or I$ = "a" Then 132
If I$ = "N" Or I$ = "n" Then 133
If I$ = "I" Or I$ = "i" Then 134
If I$ = "O" Or I$ = "o" Then 135
If I$ = "R" Or I$ = "r" Then 136
If I$ = "E" Or I$ = "e" Then 137
If I$ = "M" Or I$ = "m" Then 138
GoTo 131

'And Gate
132 V$ = "D3 G6 D3 R2 D3 U3 R8 D3 U3 R2 U3 H6 L1 U3"
H$ = "R6 U2 R10 F3 R6 L6 D1 G3 L10 U2 L6 R6 U3"
GoTo 58

'Nand Gate
133 V$ = "BD5 G6 D3 R2 D3 U3 R8 D3 U3 R2 U3 H6 L2 U2 R4 D2 L2 U5"
H$ = "R6 U2 R10 F3 R2 U1 R4 D2 L4 U1 BR4 R6 BL12 D1 G3 L10 U2 L6 R6 U3"
GoTo 58

'Inverter
134 V$ = "D3 L2 D2 R4 U2 L2 BD2 G6 R6 D3 U3 R6 H6"
H$ = ""
GoTo 58

'Or Gate
135 V$ = "D3 G8 D3 U2 R4 D3 U3 R8 D3 U3 R4 D2 U3 H8 L1 U3"
H$ = "R6 U2 L3 R3 R10 F3 R6 L6 D1 G3 L10 L3 R3 U2 L6 R6 U3"
GoTo 58

'Nor Gate
136 V$ = "D3 L2 D2 R4 U2 L2 BD2 G8 D3 U2 R4 D3 U3 R8 D3 U3 R4 D2 U3 H8"
H$ = "R6 U2 L3 R13 F3 R3 U2 R2 D2 R6 L6 D2 L2 U2 L3 D1 G3 L13 R3 U4 D2 L6"
GoTo 58

'Ex-or Gate
137 V$ = "D3 L2 D2 R4 U2 L2 BD2 G8 D3 U2 R4 D7 U3 L3 D2 U2 R14 D2 U2 L11 U4 R8 D7 U7 R4 D2 U3 H8"
H$ = "R6 U2 L3 R3 D7 L3 R3 U5 R6 U2 L3 R13 F3 R3 U2 R2 D4 L2 U2 BR2 R6 BL11 D1 G3 L13 R3 U2 L12 R12 U3"
GoTo 58

'Main Menu
138 GoSub 11
GoTo 1

'****************************TUBES

'Print Menu
142 Print "F-Filament C-Cathode P-Plate G-Grid M-Main Menu"
Print

'Accept Input
143 I$ = InKey$: If I$ = "" Then 143
If I$ = "F" Or I$ = "f" Then 144
If I$ = "P" Or I$ = "p" Then 145
If I$ = "C" Or I$ = "c" Then 146
If I$ = "G" Or I$ = "g" Then 147
If I$ = "M" Or I$ = "m" Then 148

'Filament
144 V$ = "U6 E3 F3 D6"
H$ = "R12 F3 G3 L12"
GoTo 58

'Cathode
145 V$ = "U6 R12 D2"
H$ = "L12 U6 R2"
GoTo 58

'Plate
146 V$ = "D6 L6 R12"
H$ = "L12 U3 D6"
GoTo 58

'Grid
147 V$ = "R2 BR4 R2 BR4 R2"
H$ = "D3 BD3 D3 BD3 D3"
GoTo 58

'Main Menu
148 GoSub 11
GoTo 1

'*****************************PHOTONIC
44 V$ = "G2 E2 F2 E2 F2 H2 D5 BL4 U5"
H$ = "F2 G2 F2 G2 E2 L10 BU4 R10"
GoTo 58

'*****************************CONNECTION
45 Circle (SX, SY), 4
GoTo 1

'*****************************DRAW SHAPE
58 If P$ = "Hor" Then
    Draw "BM " + Str$(SX) + ", " + Str$(SY) + " BD3 BR3 X" + VarPtr$(H$)
Else
    Draw "BM " + Str$(SX) + ", " + Str$(SY) + " BD3 BR3 X" + VarPtr$(V$)
End If
GoSub 11
GoTo 1

'*****************************Display Component Not Availiable In This Polarization
59 Print: Print "Sorry, this component isn't available in this mode."
' FOR A = 1 to 450 : NEXT A 'QUICK BASIC
_Delay 7 'QB64
GoSub 11
GoTo 1

'****************************   HELP   ***************************

'***************************** FUNCTION KEYS

' print choices
110 Cls
Locate 10, 1
Print "                                    Would you like "
Print "                                 <D>irections or a"
Print "                                 <K>ey List"
Print
Print "                       Type the letter in the <> of your choice "
112 I$ = InKey$
If I$ = "D" Or I$ = "d" Then 113
If I$ = "K" Or I$ = "k" Then 115
GoTo 112
113 Cls
Print " ****************************************************************************"
Print " *                                   HELP                                   *"
Print " *                           FUNCTION KEYS MACROS                           *"
Print " ****************************************************************************"
Print "       By setting function key macros, you can save time by only having"
Print "    press one key for things that usually take more."
Print "       The computer will ask you to enter the number of the key you would"
Print "    like to set.  Next it will ask you for the key sequence. This is the"
Print "    keys you would normally have to type for whatever you want the key to"
Print "    do."
Print "       Next you will be asked for a drive letter. This is to tell the"
Print "    computer what drive to save the macros on, so that tyhey will be ready"
Print "    the next time you run the program. This must be on the same disk as"
Print "    Schemat."
Print "       The chart at the top tells you what the macros are already set at."
Locate 23, 1
Print "                                               Press <D> when done reading."
114 I$ = InKey$
If I$ = "D" Or I$ = "d" Then 115
GoTo 114

'Key List
115 Cls
Print "                             Main Menu"
Print "                             ÄÄÄÄÄÄÄÄÄ"
Print "T-Transistor U-IC A-Passive D-Diode P-Photonic C-Connection M-Misc I-Misc2"
Print "B-Tubes O-Logic F-File W-Write S-Step H-Hor V-Vert"
Print
Print "                            Transistor Menu"
Print "                            ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
Print "N-NPN P-PNP C-CUJT D-PUT S-SCR R-CSR W-WCS O-SUS B-SBS T-Triac J-N JFET"
Print "F-P JFET G-N MOSFET E-P MOSFET"
Print
Print "                         Passive Component Menu"
Print "                         ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
Print "                      C-Capacitor R-Resistor O-Coil"
Print
Print "                           Miscellaneous"
Print "                           ÄÄÄÄÄÄÄÄÄÄÄÄÄ"
Print "V-Variable Arrow A-Antenna B-Box G-Ground C-Chassis Ground S-Switch X-XTAL"
Print "L-Left Arrow R-Right Arrow U-Up Arrow P-Push Button"
Print
Print "                               FILE"
Print "                               ÄÄÄÄ"
Print "N-New O-Open S-Save A-Save As P-Print M-Main Menu H-Shell E-End"
Print "                                                 Press <D> when done reading."
116 I$ = InKey$: If I$ = "" Then 116
If I$ = "d" Or I$ = "d" Then 140
GoTo 116
140 Cls
Print
Print "                          Miscellaneous 2"
Print "                          ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
Print "A-Ac Plug  E-Meter  L-Lamp  B-Battery  S-Speaker  P-Piezo Buzzer  O-Op Amp"
Print
Print "                                LOGIC"
Print "                                ÄÄÄÄÄ"
Print "             A-And  N-Nand  I-Inverter  O-Or  R-Nor  E-Ex-or"
Print
Print "                                TUBES"
Print "                                ÄÄÄÄÄ"
Print "               F-Filament  C-Cathode  P-Plate  G-Grid"
Print
Print "                           ASCII SYMBOLS"
Print "                           ÄÄÄÄÄÄÄÄÄÄÄÄÄ"
Print
Print "Press and hold the <Alt> button, and type the numberr of the character"
Print "that you would like to type."
Print
Print "   Some usefull caracters are:"
Print "                               234 ê   179 ³   180 ´"
Print "                               191 ¿   192 À   193 Á"
Print "                               194 Â   195 Ã   196 Ä"
Print "                               197 Å"
Locate 23, 50: Print "Press <D> when done reading."
141 I$ = InKey$: If I$ = "" Then 141
If I$ = "D" Or I$ = "d" Then 99
GoTo 141

' FROM https://www.qb64.org/wiki/SAVEIMAGE
' License: "This SUB program can also be Included with any program!"
Sub SaveImage (image As Long, filename As String)
    bytesperpixel& = _PixelSize(image&)
    If bytesperpixel& = 0 Then Print "Text modes unsupported!": End
    If bytesperpixel& = 1 Then bpp& = 8 Else bpp& = 24
    x& = _Width(image&)
    y& = _Height(image&)
    b$ = "BM????QB64????" + MKL$(40) + MKL$(x&) + MKL$(y&) + MKI$(1) + MKI$(bpp&) + MKL$(0) + "????" + String$(16, 0) 'partial BMP header info(???? to be filled later)
    If bytesperpixel& = 1 Then
        For c& = 0 To 255 ' read BGR color settings from JPG image + 1 byte spacer(CHR$(0))
            cv& = _PaletteColor(c&, image&) ' color attribute to read.
            b$ = b$ + Chr$(_Blue32(cv&)) + Chr$(_Green32(cv&)) + Chr$(_Red32(cv&)) + Chr$(0) 'spacer byte
        Next
    End If
    Mid$(b$, 11, 4) = MKL$(Len(b$)) ' image pixel data offset(BMP header)
    lastsource& = _Source
    _Source image&
    If ((x& * 3) Mod 4) Then padder$ = String$(4 - ((x& * 3) Mod 4), 0)
    For py& = y& - 1 To 0 Step -1 ' read JPG image pixel color data
        r$ = ""
        For px& = 0 To x& - 1
            c& = Point(px&, py&) 'POINT 32 bit values are large LONG values
            If bytesperpixel& = 1 Then r$ = r$ + Chr$(c&) Else r$ = r$ + Left$(MKL$(c&), 3)
        Next px&
        d$ = d$ + r$ + padder$
    Next py&
    _Source lastsource&
    Mid$(b$, 35, 4) = MKL$(Len(d$)) ' image size(BMP header)
    b$ = b$ + d$ ' total file data bytes to create file
    Mid$(b$, 3, 4) = MKL$(Len(b$)) ' size of data file(BMP header)
    If LCase$(Right$(filename$, 4)) <> ".bmp" Then ext$ = ".BMP"
    f& = FreeFile
    Open filename$ + ext$ For Output As #f&: Close #f& ' erases an existing file
    Open filename$ + ext$ For Binary As #f&
    Put #f&, , b$
    Close #f&
End Sub

