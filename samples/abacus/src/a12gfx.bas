'****************************************************************************'
'
'--------------------------- A 1 2 G F X . B A S ----------------------------'
'------------------ Creates graphics files for ABACUS12.BAS -----------------'
'
'---------------- Copyright (C) 2007 by Bob Seguin (Freeware) ---------------'
'
'****************************************************************************'

DefInt A-Z
DECLARE SUB PutBEAD (col, row, Index)

Dim Shared Box(26000)
Dim Shared Beads(450)
Dim NumBOX(1 To 250)
Dim MenuBOX(400)

Screen 12

GoSub SetPALETTE
MaxWIDTH = 397
MaxDEPTH = 86
x = 0: y = 0
Restore PixDATA
Do
    Read DataSTRING$
    For n = 1 To Len(DataSTRING$)
        Char$ = Mid$(DataSTRING$, n, 1)
        Select Case Char$
            Case "!"
                n = n + 1
                a$ = Mid$(DataSTRING$, n, 1)
                Count = Asc(a$) + 68
            Case "#"
                n = n + 1
                B$ = Mid$(DataSTRING$, n)
                For i = 1 To Len(B$)
                    t$ = Mid$(B$, i, 1)
                    If t$ = "#" Then Exit For
                    c$ = c$ + t$
                Next i
                Count = Val("&H" + c$)
                n = n + Len(c$)
                c$ = ""
            Case Else
                Count = Asc(Char$) - 60
        End Select
        n = n + 1
        Colr = Val("&H" + Mid$(DataSTRING$, n, 1))
        For Reps = 1 To Count
            PSet (x, y), Colr
            x = x + 1
            If x > MaxWIDTH Then x = 0: y = y + 1
        Next Reps
    Next n
Loop Until y > MaxDEPTH 'DATA drawing loop ends here --------------------

Get (10, 60)-(22, 72), Box(): Put (10, 60), Box()
Get (23, 60)-(35, 73), Box(100): Put (23, 60), Box(100)
Get (36, 60)-(48, 73), Box(200): Put (36, 60), Box(200)
Get (49, 60)-(61, 73), Box(300): Put (49, 60), Box(300)
Get (62, 60)-(79, 71), Box(400): Put (62, 60), Box(400)
Get (80, 60)-(97, 71), Box(500): Put (80, 60), Box(500)
Get (0, 0)-(116, 54), Box(1000): Put (0, 0), Box(1000)
Get (120, 0)-(388, 48), Box(3000): Put (120, 0), Box(3000)
Index = 1
For x = 158 To 260 Step 11
    If x < 180 Then Hop = 2 Else Hop = 0
    Get (x + Hop, 50)-(x + 5 + Hop, 60), NumBOX(Index)
    Put (x + Hop, 50), NumBOX(Index)
    Index = Index + 25
Next x
Def Seg = VarSeg(NumBOX(1))
BSave "abanums.bsv", VarPtr(NumBOX(1)), 500
Def Seg
Get (105, 60)-(123, 74), Beads(): Put (105, 60), Beads()
Get (127, 60)-(145, 74), Beads(150): Put (127, 60), Beads(150)
Get (150, 64)-(200, 75), Box(8000): Put (150, 64), Box(8000)
Get (210, 64)-(239, 75), MenuBOX(): Get (245, 64)-(265, 75), MenuBOX(100)
For x = 210 To 265
    For y = 64 To 75
        If Point(x, y) = 7 Then PSet (x, y), 15
    Next y
Next x
Get (210, 64)-(239, 75), MenuBOX(200): Get (245, 64)-(265, 75), MenuBOX(300)
Put (210, 64), MenuBOX(200): Put (245, 64), MenuBOX(300)
Def Seg = VarSeg(MenuBOX(0))
BSave "abamenu.bsv", VarPtr(MenuBOX(0)), 800
Def Seg
Get (271, 64)-(400, 75), Box(9000): Put (271, 64), Box(9000)
Put (398, 76), Box(9000)
Get (0, 76)-(524, 88), Box(9000): Put (0, 76), Box(9000)

'Abacus drawing begins -------
View Screen(200, 149)-(443, 295)
Line (200, 149)-(443, 295), 6, BF
For Reps = 1 To 120
    x = Fix(Rnd * 250) + 200
    y = Fix(Rnd * 164) + 149
    Size = Fix(Rnd * 30) + 1
    Hop = Fix(Rnd * 5) + 2
    For Radius = 1 To Size Step Hop
        Circle (x, y), Radius, 12
    Next Radius
Next Reps
For Reps = 1 To 1200
    x = Fix(Rnd * 250) + 200
    y = Fix(Rnd * 200) + 108
    Grain = Fix(Rnd * 20) + 1
    For xx = x To x + Grain
        If Point(xx, y) = 6 Then PSet (xx, y), 12
    Next xx
Next Reps
View

Put (200, 149), Box(), PSet
Put (431, 149), Box(100), PSet
Put (200, 282), Box(200), PSet
Put (431, 282), Box(300), PSet
Put (202, 193), Box(400), PSet
Put (425, 193), Box(500), PSet

Line (212, 161)-(431, 193), 0, BF
Line (212, 203)-(431, 283), 0, BF

Line (213, 160)-(430, 160), 8
Line (213, 203)-(430, 203), 8
Line (214, 149)-(429, 149), 4
Line (200, 163)-(200, 281), 4
Line (212, 194)-(431, 194), 4
Line (212, 284)-(431, 284), 4
Line (432, 161)-(432, 193), 4
Line (432, 203)-(432, 283), 4
Line (443, 163)-(443, 281), 8
Line (214, 295)-(429, 295), 8

For x = 256 To 410 Step 44
    Line (x - 1, 197)-(x + 1, 199), 14, BF
    Line (x - 1, 200)-(x + 1, 200), 8
    PSet (x - 1, 197), 15
Next x

For x = 223 To 435 Step 22
    For y = 157 To 283
        If Point(x, y) = 0 Then PSet (x, y), 7
    Next y
Next x
View

For x = 214 To 412 Step 22
    For y = 220 To 268 Step 16
        Put (x, y), Beads(), PSet
    Next y
Next x
For x = 214 To 412 Step 22
    Put (x, 162), Beads(150), PSet
Next x

Line (5, 5)-(634, 474), 10, B
Line (7, 7)-(632, 472), 10, B

Put (186, 48), Box(3000), PSet
For x = 186 To 460
    If Point(x, 66) <> 0 Then PSet (x, 66), 7
    If Point(x, 70) <> 0 Then PSet (x, 70), 15
    If Point(x, 74) <> 0 Then PSet (x, 74), 15
    If Point(x, 78) <> 0 Then PSet (x, 78), 7
Next x
Put (296, 96), Box(8000)
Put (210, 124), MenuBOX()
Put (412, 124), MenuBOX(100)
For x = 44 To 476 Step 432
    For y = 42 To 372 Step 110
        Put (x, y), Box(1000)
    Next y
Next x
Put (188, 372), Box(1000)
Put (331, 372), Box(1000)
Put (58, 446), Box(9000)
For x = 220 To 418 Step 22
    Put (x, 320), NumBOX()
Next x
Line (200, 316)-(443, 334), 10, B
For x = 221 To 419 Step 22
    Line (x, 298)-(x + 3, 316), 10, BF
Next x
Line (200, 120)-(443, 138), 10, B

Get (324, 204)-(342, 218), Beads(300)
Get (212, 161)-(431, 330), Box()
PutBEAD 6, 3, 0: PutBEAD 6, 7, 2
Get (324, 204)-(342, 283), Box(14000)
PutBEAD 6, 6, 2: PutBEAD 6, 7, 0
Get (324, 204)-(342, 283), Box(13000)
PutBEAD 6, 5, 2: PutBEAD 6, 6, 0
Get (324, 204)-(342, 283), Box(12000)
PutBEAD 6, 4, 2: PutBEAD 6, 5, 0
Get (324, 204)-(342, 283), Box(11000)
PutBEAD 6, 3, 2: PutBEAD 6, 4, 0
Get (324, 204)-(342, 283), Box(10000)
Get (324, 161)-(342, 193), Box(15000)
PutBEAD 6, 1, 2: PutBEAD 6, 2, 1
Get (324, 161)-(342, 193), Box(16000)
Put (324, 161), Box(15000), PSet
Def Seg = VarSeg(Box(0))
BSave "abasets.bsv", VarPtr(Box(0)), 34002
For y = 0 To 320 Step 160
    Get (0, y)-(639, y + 159), Box()
    FileCOUNT = FileCOUNT + 1
    FileNAME$ = "ABACUS" + LTrim$(RTrim$(Str$(FileCOUNT))) + ".BSV"
    BSave FileNAME$, VarPtr(Box(0)), 52000
    Put (0, y), Box()
Next y
Def Seg

Color 11
Locate 14, 23: Print "The graphics files for ABACUS12.BAS"
Locate 15, 26: Print "have been successfully created."
Locate 17, 27: Print "You can now run the program."
Line (120, 140)-(520, 340), 10, B
Line (124, 144)-(516, 336), 10, B

a$ = Input$(1)

System

SetPALETTE:
Data 20,0,24,0,0,42,0,0,45,10,0,50
Data 55,0,0,50,0,0,40,0,0,42,42,42
Data 30,0,0,20,10,55,25,5,29,40,30,63
Data 45,0,0,63,0,0,60,45,20,63,63,63
Restore SetPALETTE
Out &H3C8, 0
For n = 1 To 48
    Read Intensity
    Out &H3C9, Intensity
Next n
Return

PixDATA:
Data "#21F#0=9>B=9–0=9>B=9}0=3?9=3@0=3?9=3H0?9=3@0=3?9!0=3AB=3V0UB=9_0=3AB=3"
Data "b0=9JB=3E0=3IB=9G0=9IB=3T0=9GB=9!W0=9CBT0=3YB=9=3Z0=9CB_0=9NBD0=3KBG0=9"
Data "JB=3P0=3MB=3R0@AN0@A`0BAx0=3EB=9S0]B=3V0=3EB=9\0=9PB=9C0KB=9G0=9KBO0=9"
Data "OBQ0BAM0@A`0BAw0=9GBS0^B=9T0=9GBZ0=9SB=3B0KB=9G0=9KBN0QBQ0CAL0@A`0@AJ0"
Data "JA[0=3JBR0LB=9OBQ0=3JBX0VBB0KB=9G0=3JB=9M0RB=3O0EAK0@A`0@AJ0JAZ0=9KB=3"
Data "Q0=9JB=9?0=3LB=9O0=9KB=3V0WB=3A0=9JB=9H0JB=9L0=9LB=9>0?9=3N0kAF0PAB0JA"
Data "Z0MBQ0=9JB=9A0=3KB=3N0MBT0=3NB=9=3>0=3=9@B=3A0=9JB=9H0JB=9K0=3KB=3U0lA"
Data "F0PAB0JAZ0=9LB=9P0=9JB=9C0KBN0=9LB=9S0LB=3N0=9JB=9H0JB=9K0KB=3V0lAF0PA"
Data "B0@AB0@A[0MB=3O0=9JB=9C0=3JBO0MB=3Q0KB=3P0=9JB=9H0JB=9J0=3KBV0mAF0PAB0"
Data "@AB0@A[0=3MBO0=9JB=3D0JBO0=3MBP0=9JBR0=9JB=3H0JB=9J0KB=3U0FA>0@AD0DA=0"
Data "CAP0@A@0>AB0@AB0@AB0@AA0AAR0=9LB=9N0=9JBE0=3IBP0=9LB=9N0=3JBS0=9JBI0JB"
Data "=9J0KBV0EA?0@AC0DA?0BAP0@A@0>AB0@AB0@AB0@A@0BAS0MB=3M0=9JBF0IBQ0MB=3M0"
Data "JBT0=9JBI0JB=3I0=3KBU0EA@0BA@0DA@0BAP0@A>0BA@0@AB0@AB0@A?0AAU0NBM0=3JB"
Data "F0IBQ0NBL0=3IB=9T0=3JBI0JBJ0LBT0EAA0BA@0CAB0AAP0@A>0BA@0@AA0AAB0@A>0BA"
Data "T0=9NB=9M0JBE0=3IBP0=9NB=9K0JBV0JBI0JBJ0KB=9T0DAJ0DA\0@A@0@A@0@A?0CAB0"
Data "HAT0PB=3L0JBE0IB=9P0PB=3J0JBV0JBI0JBJ0KB=3T0CAJ0DA]0@A@0@A@0@A>0DAB0HA"
Data "S0RBL0JBD0=3IBP0RBI0=3JBV0JBI0JBJ0KBU0fAP0@AH0JAD0FAR0=3RB=9K0JBD0IB=3"
Data "O0=3RB=9H0JB=9V0JBI0JBJ0KBU0fAP0@AH0IAE0FAR0TBK0JBB0=3IB=3P0TBH0JBW0JB"
Data "I0JBJ0KB]0^AJ0ZAi0VBJ0JB@0=3JBQ0VBG0JBW0JBI0JBJ0KB]0^AJ0YAi0=3VB=9I0JB"
Data "=9LB=3Q0=3VB=9F0JBW0JBI0JBJ0KB]0@AX0>AJ0VA@0PAT0FB=0MB=3H0YB=9S0FB=0MB"
Data "=3E0JBW0JBI0JBJ0KB]0@AX0>AJ0VA@0PAS0=9EB=3=0=3MBH0\B=3O0=9EB=3=0=3MBE0"
Data "JB=9V0JBI0JBJ0KB]0@AX0>AP0@A@0@A@0@A@0RAP0=3EB=9?0MB=9G0^B=3L0=3EB=9?0"
Data "MB=9D0KBV0JBI0JBJ0KB]0@AX0>AP0@A@0@A@0@A@0RAP0FB@0=3MB=3F0_B=9K0FB@0=3"
Data "MB=3C0KBV0JBI0JBJ0KB]0^AP0@A@0@A@0@AD0@AB0DAO0=9EB=3A0=9MBF0JB=9QB=9I0"
Data "=9EB=3A0=9MBC0KBV0JBI0JBJ0KB]0^AP0@A@0@A@0@AD0@AB0CAO0=3EB=9C0MB=9E0JB"
Data "@0=3=9MB=9G0=3EB=9C0MB=9B0KB=9U0JBI0JBJ0KB]0^AP0@A@0@A@0@AD0LAP0FB>0?B"
Data "=9>0=3MB=3D0JBC0=9LBG0FB>0?B=9>0=3MB=3A0LBU0JB=3H0JBJ0KB]0^AP0@A@0@A@0"
Data "@AD0KAP0=9EB=3=0AB=3>0NBD0JBD0=3KB=9E0=9EB=3=0AB=3>0NBA0MBT0JB=9H0JBJ0"
Data "KB]0@AX0>AP0@A@0@A@0@AF0FAR0=3EB=9=0=9BB>0=3MB=9C0JBE0=3KBD0=3EB=9=0=9"
Data "BB>0=3MB=9@0MB=9S0KBH0JBJ0KB]0@AX0>AP0@A@0@A@0@AF0FAR0FB=0=9DB>0=9MB=3"
Data "B0JBF0KBD0FB=0=9DB>0=9MB=3?0=3MB=9R0KBH0JBJ0KB]0^AO0AAH0@AD0HAQ0=9EB=3"
Data "=9FB>0NBB0JBF0=3JBC0=9EB=3=9FB>0NB@0NB=9Q0KBH0JBJ0KB]0^AN0BAH0@AD0HAP0"
Data "=3EB>9HB=0=9NB@0=3JBG0JBB0=3EB>9HB=0=9NB?0PB=3O0KB=3G0JBI0=9KB]0^AM0CA"
Data "D0bAF0FB=9JB=0NB=9?0=9JBG0JBB0FB=9JB=0NB=9>0=3QB=9M0LBF0=3JB=3H0KB=9]0"
Data "^AL0DAD0bAE0=9VB=3NB?0=9JBF0=9JBA0=9VB=3NB?0UB=9=3?0=3>9=3A0MBC0=3LB=9"
Data "H0KB=3]0@AX0>AL0CAE0NAF0DAF0=3kB>0=9JB=3E0KB@0=3kB>0=3]BA0OB=3=0=3OB=9"
Data "H0KB^0@AX0>AL0BAF0NAF0DAF0YB=0NB=9=0=9JB=9D0=3JB=9@0YB=0NB=9>0=9[B=9A0"
Data "eB=9G0=9JB=9^0^AL0BAs0FB=9=3MB=9=0=9NB=0=9JB=9C0=3KB=3?0FB=9=3MB=9=0=9"
Data "NB?0[BB0=3dB=9F0=3KB_0^AL0AAs0=3FB?0KB=3?0MB=9=0=9JB=9B0=9KB=9?0=3FB?0"
Data "KB=3?0MB=9@0YBD0dB=9E0=3KB=9_0^AR0dAJ0FB=3@0=9HBA0=3KB=9>0=9JB=9?0=3=9"
Data "MB@0FB=3@0=9HBA0=3KB=9B0WB=3D0dB=9>0?9>3=9LB=9`0^AR0dAJ0EB=9B0=9FBC0JB"
Data "=3?0aBA0EB=9B0=9FBC0JB=3D0=9TB=9E0=3SB=9=0JB=9>0RBi0@AF0BAX0dAJ0=9DBD0"
Data "=3DBD0=3GB=9A0`BB0=9DBD0=3DBD0=3GB=9G0=9SBG0=9QB=3=0=3KB>0PB=9j0@AF0BA"
Data "X0dAK0CB=3F0AB=9F0=9EB=9B0^B=3D0CB=3F0AB=9F0=9EB=9J0=9PBI0OB=3?0=9KB>0"
Data "=3NB=9k0@AF0BAX0@AD0@AD0@AD0@AK0=9BBH0?B=9H0DB=3C0=3[B=3F0=9BBH0?B=9H0"
Data "DB=3M0=9MB=3J0=9KB=3A0=9JB=3?0LB=9m0@AF0BAX0@AD0@AD0@AD0@AL0ABY0=9BBF0"
Data "=3VB=9K0ABY0=9BBR0=3IB=9M0=9FB=3D0=3IBB0=3HB=3]0tAF0@AD0@AD0@AD0@AL0=3"
Data "?B=9Z0ABr0=3?B=9Z0AB!J0tAF0@AD0@AD0@AD0@AM0?B[0=3?Bt0?B[0=3?B!K0tAF0@A"
Data "D0@AD0@AD0@A#124#0tAF0@AD0@AD0@AD0@A#134#0BAF0BAX0@AD0@AD0@AD0@A#134#0"
Data "BAF0BAX0@AD0@AD0@AD0@Aq0@FD0>FB0@FC0@FE0>FB0BFB0@FB0BFB0@FC0@F!T0DAF0BA"
Data "X0@AD0@AD0@AD0@Ap0>F>0>FA0@FA0>F>0>FA0>F>0>FC0?FB0>FE0>F>0>FE0>FA0>F>0"
Data ">FA0>F>0>F!S0DAF0BAX0@AD0@AD0@AD0@Ap0>F>0>FC0>FE0>FE0>FC0?FB0>FE0>FH0>F"
Data "B0>F>0>FA0>F>0>F#127#0>F>0>FC0>FE0>FE0>FB0@FB0AFB0>FH0>FB0>F>0>FA0>F>0"
Data ">F#127#0>F>0>FC0>FD0>FD0?FC0@FB0>F>0>FA0AFD0>FD0@FC0AF#127#0>F>0>FC0>F"
Data "C0>FG0>FA0>F=0>FF0>FA0>F>0>FC0>FC0>F>0>FE0>F#127#0>F>0>FC0>FB0>FH0>FA0"
Data "BFE0>FA0>F>0>FB0>FD0>F>0>FE0>F#127#0>F>0>FC0>FA0>FE0>F>0>FD0>FB0>F>0>F"
Data "A0>F>0>FB0>FD0>F>0>FA0>F>0>F#128#0@FD0>FA0BFB0@FE0>FC0@FC0@FC0>FE0@FC0"
Data "@F!N0VF=EG6>0@6@C?6=E?6>FA6K0B6>F?6H0=6>5A4=6I0=1>3A9=1#10B#0HE>8JE>6=C"
Data "=6AC=6>0F6>E>6BE>6K4?6=FAE>6F0=6=C>5D4=6E0=1=2>3D9=1#109#0?E>8BE=8>6=8"
Data "BE>8BEH6BC>6=F>E>6@E>8=EN6=F>8@E>6E0>6=C>5@4=D=F=D>4=6C0>1=2>3@9=B=F=B"
Data ">9=1#108#0>E@6=E@8@6@8=E@6AEECG6?E=6AE=6=F>E>6=F>EB6=F>E>6=F=E=6=FAE=6"
Data "D0>6>C=5A4?F?4=6A0>1>2=3A9?F?9=1#107#0>E@6=EB6AC=6=E@6AEA6=F=EB6=F=E>6"
Data ">C=6AE>8EE=8>E@6>E=8EE>8>ED0=6>C>5A4=D=F=D?4=CA0=1>2>3A9=B=F=B?9=2#107#0"
Data "?E>6=F>EACA6?E>6=FAE?6@EB6@E?6AE>6DE?6BE?6DE>6>EC0>6>C>5H4=C?0>1>2>3H9"
Data "=2A0=B@0=Bf0=BF0A7>0A7>0?7>0A7=0A7B0@7>0=7@0=7=0=7=0A7f0=BC0=B[0=B\0=B"
Data "V0BE>8=E@6>C>6=E>8EE>6=E>8=E=8AC=6=8=E>8=E>6AE=6=FEE=6=F=E@8>E=6=FDE>6"
Data ">EC0>6>C?5F4>C?0>1>2?3F9>2@0=BA0=Bg0=BE0=7@0=7=0=7A0=7?0=7=0=7C0=7C0=7"
Data "@0=7=0=7@0=7=0=7?0=7D0>B>0=B=0=BD0=B>0=BM0=BC0=B[0=B\0=BA0=BP0?E>8=E>6"
Data "=ED6=E>6=E>8EE>6=ED6=E>6BE=8AE>8>E>8?E=8@6=8?E>8>E>8AE=8C0=C=6?C>5G4=C"
Data "?0=2=1?2>3G9=2@0=BA0=Bg0=BE0=7@0=7=0=7A0=7A0=7C0=7C0=7@0=7=0=7@0=7=0=7"
Data "?0=7C0=B>0>B>0=BD0=B>0=BM0=BC0=B[0=B\0=BA0=BP0?E>6=8>E=F=EAC=6=F?E=8>6"
Data "BE>8?E=8=6>C=6=C=6=C=6=8?E>8?E>8@E=6=F=E=8>6?8>C@6?8>6=8=E=6=F@E=8=6C0"
Data "=5>6>C>5E4=5>C?0=3>1>2>3E9=3>2@0=BA0=B>0?B>0@B?0?B>0=B=0>B?0?B?0>B?0?B"
Data "?0=BE0=7@0=7=0=7A0=7A0=7C0=7C0=7@0=7=0=7@0=7=0=7?0=7J0>B>0?B>0>B=0>B>0"
Data "?B>0=B=0>B@0=B?0?B>0@B?0?B?0?B>0=B?0=B>0>B@0=B>0@B?0?B?0@B>0?B?0>B@0=B"
Data "=0>B>0>B=0?B=0>BH0?E?6>8>EB6>E>8>C=6AE@6=E=8FC=8=E@6>E>6BE=8N6=8BE>6C0"
Data "=C?6>C>5=4=5A4=5>C=6?0=2?1>2>3=9=3A9=3>2=1@0=BA0=BA0=B=0=B?0=BA0=B=0>B"
Data ">0=B=0=B?0=B=0=B>0=B=0=B?0=B>0=BE0A7>0@7?0?7>0@7@0=7C0=7@0=7=0=7@0=7=0"
Data "=7?0=7J0=B>0=B?0=B=0=B>0=B>0=B?0=B=0>B>0=B?0=BB0=B=0=B?0=BA0=B=0=B?0=B"
Data "=0=B?0=B=0=B>0=B?0=B>0=B?0=BA0=B=0=B?0=B=0=B?0=B=0=B>0=B?0>B>0=B=0=B>0"
Data "=B>0=B>0=BG0?E>C?6>8?6=C>6>8A6AE@6=EH6=E@6>E>6=8>E?8>CK8?6?8>E=8>6D0=5"
Data "?6>C>5=4=5=4@5=C=6A0=3?1>2>3=9=3=9@3=2=1A0=BA0=B>0@B=0=B?0=B>0@B=0=B?0"
Data "=B=0AB>0=B?0AB>0=BE0=7@0=7=0=7E0=7=0=7C0=7C0=7@0=7=0=7@0=7=0=7?0=7J0=B"
Data ">0=B?0=B=0=B>0=B>0=B?0=B=0=B?0=B>0=B@0@B=0=B?0=B>0@B=0=BA0=B?0=B>0=B@0"
Data "=B?0=B?0=B>0@B=0=B?0=B=0AB>0=BA0=B?0=B=0=B>0=B>0=B>0=BG0>E=8I6CCBE>6=F"
Data "BE>6=FBE>6=F>E?6>8A6K0B6>8?6D0=6=C?6?C?5=C=5?C=6A0=1=2?1?2?3=2=3?2=1A0"
Data "=B>0=B>0=B=0=B?0=B=0=B?0=B=0=B?0=B=0=B?0=B=0=BC0=B>0=BB0=BE0=7@0=7=0=7"
Data "E0=7=0=7C0=7C0=7>0=7=0=7=0=7@0=7=0=7?0=7J0=B>0=B?0=B=0=B>0=B>0=B?0=B=0"
Data "=B?0=B>0=B?0=B?0=B=0=B?0=B=0=B?0=B=0=BA0=B?0=B?0=B?0=B?0=B?0=B=0=B?0=B"
Data "=0=B?0=B=0=BC0=B@0=B?0=B=0=B>0=B>0=B>0=BG0=E=8@C>6=C=6>C>8E6=8XEi0=5=C"
Data "@6=C=6BC=6C0=3=2@1=2=1B2=1B0=B>0=B>0=B=0=B?0=B=0=B?0=B=0=B?0=B=0=B?0=B"
Data "=0=B?0=B=0=B>0=B=0=B?0=B>0=BE0=7@0=7=0=7A0=7?0=7=0=7C0=7C0=7?0>7=0=7@0"
Data "=7=0=7?0=7J0=B>0=B?0=B=0=B>0=B>0=B?0=B=0=B?0=B=0=B@0=B?0=B=0=B?0=B=0=B"
Data "?0=B=0=B?0=B=0=B>0>B=0=B>0=B=0=B@0=B?0=B=0=B?0=B=0=B?0=B=0=B?0=B=0=B>0"
Data "=B?0=B?0=B=0=B>0=B>0=B>0=BU0F6=8=EV8j0=6=5=CF6E0=1=3=2F1C0=B?0>B?0@B=0"
Data "@B?0@B=0=B?0=B>0?B?0>B?0?B?0=BE0=7@0=7=0A7>0?7>0A7?0=7D0@7?0@7>0=7?0=7"
Data "K0=B>0?B?0=B>0=B>0?B>0=B?0=B=0=BA0@B=0@B?0@B>0?B?0>B=0=B>0>B>0=B@0@B?0"
Data "@B>0@B>0?B?0>B>0=B=0=B?0=B>0=B=0=B>0=B>0=B«0=6>C?6=C>6I0=1>2?1=2>1E0=B"
Data "I0=B_0=Bm0=7Ÿ0=BK0=B!r0=BH0=B^0=B!R0=BG0@B#1AE#0ABn0=Be0=BC0=BQ0=B‹0=B"
Data "e0=BB0=BD0=BR0=B@0=BK0=BA0=BW0=BA0=B=0=Bh0=B=0=Br0=BC0=BH0=BD0=BO0=BQ0"
Data "=BS0=Bs0=Bn0=BB0=BA0=B>0=BI0=B@0=BK0=BA0=B]0=BN0=BW0=B=0=Br0=BC0=BH0=B"
Data "D0=BO0=BQ0=BS0=Bs0=Bn0=BB0=BA0=B>0=BI0=B@0=BK0=BA0=B]0=BN0=BW0=B=0=BB0"
Data "?B>0>BB0?BC0?B?0?B>0?B=0>B>0@B>0=B>0?B>0>B>0?BB0>B=0=B?0=B=0>B>0?B>0>B"
Data "=0=B>0?B>0=BB0?B>0=B=0>BB0=B=0>B?0?B>0=B>0=B>0=BA0>B>0?BB0=B?0=B>0>B?0"
Data "?BC0?B>0=B=0>BC0?B>0@B?0?B?0?B>0=B?0=B>0>BE0=B?0=B=0=B>0>B>0=B=0>BA0=B"
Data "=0>B>0>B=0>B=0@B>0=B?0=B@0=B>0=B>0=B>0=B>0?B>0@B>0=B=0>B?0?B>0?B=0>B?0"
Data "?B@0=B>0@B=0=B=0>B>0?B?0?B>0>B@0?B?0?B>0?B=0>B@0=B>0@B>0=B?0=B=0=BF0=B"
Data "A0=B?0=B=0=B?0=B=0=B>0=B>0=B=0=B?0=B=0=B=0=B?0=B=0=B>0=B?0=BA0=B>0=B?0"
Data "=B=0=B>0=B?0=B=0=B>0=BA0=B=0=BA0=B?0=B=0>B>0=BA0>B>0=B=0=B?0=B=0=B>0=B"
Data ">0=BA0=B>0=B?0=BA0=B?0=B=0=B>0=B=0=B?0=BE0=B=0>B>0=BE0=B=0=B?0=BA0=B=0"
Data "=B?0=B=0=B?0=B=0=B>0=BD0=B?0=B=0=B=0=B>0=B=0=B=0=BB0>B>0=B=0=B>0=B>0=B"
Data "?0=BA0=B@0=B>0=B>0=B>0=B=0=B?0=B=0=B?0=B=0>B>0=B=0=B?0=B=0=B>0=B>0=B=0"
Data "=B?0=B?0=B=0=B?0=B=0=B=0=B>0=B?0=B=0=B?0=B=0=B@0=B?0=B=0=B?0=B=0=B>0=B"
Data ">0=B?0=B>0=BA0=B?0=B=0=BC0@BA0=BA0=B?0=B=0=B>0=B>0=B=0=B?0=B=0=B=0AB=0"
Data "=B>0ABA0=B>0=B?0=B=0=B>0=B?0=B=0=B>0=B>0@B=0=BA0=B?0=B=0=B?0=BA0=B?0=B"
Data "=0=B?0=B=0=B=0=B=0=B=0=BA0=B>0=B?0=BA0=B?0=B>0=B?0ABB0@B=0=B?0=BB0@B=0"
Data "=B?0=B>0@B=0=BA0=B?0=B>0=BG0=B=0=B>0=B>0=B?0=B=0=BB0=B?0=B=0=B>0=B>0=B"
Data "?0=B@0=B@0=B?0=B=0=B=0=B=0=B=0AB=0=B?0=B=0=B?0=B=0=B?0=B=0=B>0=B>0=B=0"
Data "AB?0=B=0=B?0=B=0=B=0=B>0AB=0=BA0=B@0=BA0=B?0=B=0=B>0=B>0=B>0=B?0=BA0=B"
Data "?0=B=0=BB0=B?0=BA0=BA0=B?0=B=0=B>0=B>0=B=0=B?0=B=0=B=0=BA0=B>0=BE0=B>0"
Data "=B?0=B=0=B>0=B?0=B=0=B>0=B=0=B?0=B=0=BA0=B?0=B=0=B?0=BA0=B?0=B=0=B?0=B"
Data "=0=B=0=B=0=B=0=BA0=B>0=B?0=BA0=B?0=B?0=B>0=BE0=B?0=B=0=B?0=BA0=B?0=B=0"
Data "=B?0=B=0=B?0=B=0=BA0=B?0=B?0=BF0=B=0=B>0=B?0=B>0=B=0=BB0=B?0=B=0=B>0=B"
Data ">0=B?0=B@0=B@0=B?0=B=0=B=0=B=0=B=0=BA0=B?0=B=0=B?0=B=0=B?0=B=0=B>0=B>0"
Data "=B=0=BC0=B=0=B?0=B=0=B=0=B>0=BA0=BA0=B@0=BA0=B?0=B=0=B>0=B>0=B>0=B?0=B"
Data "A0=B?0=B=0=BB0=B?0=BA0=B?0=B=0=B?0=B=0=B>0=B>0=B=0=B?0=B=0=B=0=B?0=B=0"
Data "=B>0=B?0=BA0=B>0=B>0>B=0=B>0=B?0=B=0=B>0=B=0=B?0=B=0=BA0=B?0=B=0=B?0=B"
Data "A0=B?0=B=0=B?0=B>0=B?0=BB0=B>0=B?0=BA0=B>0>B=0=B>0=B=0=B?0=BA0=B?0=B=0"
Data "=B?0=BA0=B?0=B=0=B?0=B=0=B?0=B=0=B?0=B=0=B>0>B=0=B>0=BF0=B?0=B=0=B>0=B"
Data "=0=B=0=BB0=B?0=B=0=B>0=B>0=B?0=B?0=B@0=BA0=B?0=B>0=B?0=B=0=B?0=B=0=B?0"
Data "=B=0=B?0=B=0=B>0=B>0=B=0=B?0=B?0=B=0=B?0=B=0=B=0=B>0=B?0=B=0=B?0=B=0=B"
Data "@0=B?0=B=0=B?0=B=0=B>0=B>0=B=0=B@0=BB0?B>0=BC0@BB0?B?0?B>0=B>0=B>0=B=0"
Data "@B>0=B>0?B?0=B>0?BC0=B>0>B=0=B>0=B>0?B>0=B>0=B>0@B=0=BB0?B>0=B?0=BA0=B"
Data "?0=B>0?B?0=B?0=BC0=B>0?BC0>B=0=B>0>B?0?BC0@B=0=B?0=BB0@B=0@B?0@B>0?B?0"
Data ">B=0=B>0>B?0=BC0=B?0=B>0>B>0=B>0=BA0=B?0=B>0=B>0=B=0@B>0=B=0=B@0=BA0=B"
Data "?0=B?0?B>0@B>0=B?0=B>0?B>0=B>0=B>0=B>0?B>0=B=0=B>0@B=0=B=0=B?0?B?0?B?0"
Data "=B=0=B>0?B?0?B>0=B>0=B>0=B=0=Bq0=B!v0=Bd0=B´0"

Sub PutBEAD (col, row, Index)

    If row < 3 Then Hop = 0 Else Hop = 10
    PutCOL = col * 22 + 192
    PutROW = row * 16 + 146 + Hop
    PutINDEX = Index * 150
    Put (PutCOL, PutROW), Beads(PutINDEX), PSet

End Sub
