DefInt A-Z
DECLARE SUB PrintSTRING (x, y, Prnt$, Font)
DECLARE SUB Interval (Length!)
DECLARE SUB DrawBOX (x, y, xx, yy, FlipFLOP)

Dim Box(10000)
Dim Shared FontBOX(26000)
Dim TitleBOX(1000)
Dim ExBOX(1000)
Dim ToolBOX(1000)
Dim BBox(400)
Dim CBox(1 To 672)
Type RecentTYPE
    PName As String * 8
    FName As String * 130
End Type
Dim Recent(1 To 6) As RecentTYPE

Restore HueDATA
Index = 1
For DStrings = 1 To 10
    Read h$
    For n = 1 To Len(h$)
        CBox(Index) = Asc(Mid$(h$, n, 1)) - 35
        Index = Index + 1
    Next n
Next DStrings
Def Seg = VarSeg(CBox(1))
BSave "anihues.bsv", VarPtr(CBox(1)), 1344
Def Seg
Open "recent.axd" For Random As #1 Len = Len(Recent(1))
For n = 1 To 6
    Recent(n).PName = Space$(8)
    Recent(n).FName = Space$(130)
    Put #1, n, Recent(n)
Next n
Close #1

Screen 12
GoSub Setpalette
'Create images from DATA
MaxWIDTH = 211
MaxDEPTH = 479
x = 0: y = 0
Restore PixDATA
Do
    Read DataSTRING$
    For n = 1 To Len(DataSTRING$)
        Char$ = Mid$(DataSTRING$, n, 1)
        If Char$ = Chr$(225) Then Char$ = Chr$(160)
        Select Case Char$
            Case "!"
                n = n + 1
                a$ = Mid$(DataSTRING$, n, 1)
                Count = Asc(a$) + 68
            Case "#"
                n = n + 1
                B$ = Mid$(DataSTRING$, n)
                For I = 1 To Len(B$)
                    t$ = Mid$(B$, I, 1)
                    If t$ = "#" Then Exit For
                    c$ = c$ + t$
                Next I
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
Get (16, 10)-(37, 35), ExBOX()
Get (173, 0)-(182, 68), FontBOX()
For x = 295 To 335 Step 10
    Put (x, 0), FontBOX(), PSet
Next x
Get (300, 0)-(337, 67), FontBOX(): Put (300, 0), FontBOX()
Line (295, 0)-(300, 68), 0, BF
For y = 0 To 400 Step 68
    Put (300, y), FontBOX(), PSet
Next y
Get (65, 0)-(116, 203), FontBOX(): Put (65, 0), FontBOX()
Put (337, 0), FontBOX(), PSet
Get (117, 0)-(168, 203), FontBOX(): Put (117, 0), FontBOX()
Put (337, 204), FontBOX(), PSet
Get (169, 0)-(211, 407), FontBOX(): Put (169, 0), FontBOX()
Put (391, 0), FontBOX(), PSet
Get (156, 410)-(201, 477), FontBOX(): Put (156, 410), FontBOX()
For y = 0 To 400 Step 68
    Put (434, y), FontBOX(), PSet
Next y
Get (300, 0)-(300, 407), FontBOX(): Put (390, 0), FontBOX(), PSet
Get (479, 0)-(479, 407), FontBOX(): Put (389, 0), FontBOX(), PSet
Get (149, 304)-(152, 439), FontBOX(): Put (149, 304), FontBOX()
Put (431, 0), FontBOX(), PSet
Get (156, 304)-(162, 407), FontBOX(): Put (156, 304), FontBOX()
Put (330, 304), FontBOX(), PSet
FileNAME$ = "Book" + Space$(4)
For n = 1 To 8
    FontBOX(n) = Asc(Mid$(FileNAME$, n, 1))
Next n
Restore Setpalette
For n = 9 To 56
    Read FontBOX(n)
Next n
FontBOX(57) = 12
Index = 58
x = 300: y = 0
For Index = 58 To 18043 Step 1635
    Get (x, y)-(x + 89, y + 67), FontBOX(Index)
    Put (x, y), FontBOX(Index)
    y = y + 68
    If y > 400 Then x = x + 90: y = 0
Next Index
Def Seg = VarSeg(FontBOX(0))
BSave "book.axb", VarPtr(FontBOX(1)), 19678 * 2&
Def Seg
Get (0, 159)-(30, 174), TitleBOX()
Index = 0
For y = 0 To 160 Step 20
    Get (45, y)-(63, y + 14), ToolBOX(Index)
    Index = Index + 100
Next y
Def Seg = VarSeg(ToolBOX(0))
BSave "anitools.bsv", VarPtr(ToolBOX(0)), 1800
Def Seg
Index = 0
For y = 0 To 80 Step 20
    Get (0, y)-(10, y + 8), BBox(Index)
    Index = Index + 50
Next y
For y = 100 To 120 Step 20
    Get (0, y)-(15, y + 14), BBox(Index)
    Index = Index + 75
    Get (0, 140)-(30, 153), Box() 'minimize/maximize buttons
    Get (22, 0)-(28, 6), Box(150) 'screw
Next y
Line (0, 0)-(64, 174), 0, BF
Get (13, 444)-(54, 453), FontBOX(10000): Put (13, 444), FontBOX(10000)
Get (58, 444)-(87, 453), FontBOX(10200): Put (58, 444), FontBOX(10200)
Get (91, 444)-(133, 453), FontBOX(10400)
Get (110, 444)-(133, 453), FontBOX(10600): Put (91, 444), FontBOX(10400)
Get (54, 453)-(140, 462), FontBOX(10800): Put (54, 453), FontBOX(10800)
Put (53, 453), FontBOX(10600)
Get (13, 453)-(76, 462), FontBOX(11200): Put (13, 453), FontBOX(11200)
Index = 12000
For x = 14 To 104 Step 10
    If x = 24 Then Hop = -1 Else Hop = 0
    Get (x + Hop, 462)-(x + 2 + Hop, 470), FontBOX(Index)
    Put (x + Hop, 462), FontBOX(Index)
    Index = Index + 20
Next x

GoSub GetFONT
Cls

Line (0, 0)-(639, 17), 0, BF
Line (30, 0)-(119, 16), 8, BF
Line (0, 18)-(639, 40), 7, BF
Line (0, 41)-(639, 41), 0
Line (0, 411)-(639, 479), 7, BF
Line (0, 411)-(639, 411), 15
'Tool bar
Line (497, 20)-(497, 38), 8
Line (498, 20)-(498, 38), 15
Line (324, 28)-(326, 30), 0, BF
Line (322, 26)-(328, 32), 0, B
For x = 313 To 558 Step 25
    If x = 488 Then x = 508
    Line (x, 20)-(x + 24, 39), 8, B
    Line (x, 20)-(x + 23, 20), 15
    Line (x, 20)-(x, 38), 15
Next x
'Work area
Line (0, 41)-(150, 479), 7, BF
Line (0, 41)-(150, 41), 8
Line (0, 42)-(150, 42), 15
Line (151, 41)-(151, 410), 0
Line (631, 43)-(639, 479), 7, BF
Line (631, 41)-(639, 41), 8
Line (631, 42)-(639, 42), 15
Line (631, 42)-(631, 411), 15
Line (154, 44)-(629, 409), 0, B
Line (153, 43)-(628, 408), 7, B
PSet (153, 43), 15
PSet (153, 408), 15
PSet (628, 43), 15
PSet (628, 408), 15
'Coordinates box
Line (19, 455)-(129, 473), 8, BF
Line (21, 457)-(129, 471), 15, BF
Line (129, 455)-(129, 473), 15
Line (20, 473)-(129, 473), 15
Line (20, 456)-(128, 472), 7, B
Line (132, 463)-(146, 463), 7
'Status Bar blurbs box
Line (280, 455)-(550, 473), 8, B
Line (281, 473)-(550, 473), 15
Line (550, 455)-(550, 473), 15
'Film strip graphic begins
Line (15, 48)-(134, 407), 0, B
Line (15, 48)-(133, 406), 8, BF
For y = 47 To 404 Step 17
    If y = 268 Then y = 265
    Line (18, y)-(26, y + 5), 0, BF
    Line (19, y + 1)-(26, y + 5), 7, BF
    Line (122, y)-(129, y + 5), 0, BF
    Line (123, y + 1)-(129, y + 5), 7, BF
Next y
Line (12, 44)-(136, 48), 7, BF
Line (12, 407)-(136, 412), 7, BF
For y = 50 To 381 Step 70
    If y = 190 Then y = 198
Next y
'Run control buttons
Line (14, 414)-(135, 434), 0, B
Line (15, 415)-(134, 415), 15
Line (15, 433)-(134, 433), 8
Line (134, 415)-(134, 433), 8
Line (15, 415)-(15, 433), 15
For x = 38 To 110 Step 24
    Line (x, 414)-(x, 433), 8
    Line (x + 1, 415)-(x + 1, 433), 15
Next x
'Clock frame
Line (563, 455)-(625, 473), 8, B
Line (563, 473)-(625, 473), 15
Line (625, 455)-(625, 473), 15
'Frame indicator
Line (2, 191)-(149, 264), 7, BF
Line (2, 190)-(149, 190), 15
Line (3, 265)-(148, 265), 0
Line (2, 191)-(2, 264), 15
Line (149, 190)-(149, 265), 8
Put (6, 194), Box(150), PSet
Put (139, 194), Box(150), PSet
Put (6, 255), Box(150), PSet
Put (139, 255), Box(150), PSet
Line (28, 192)-(121, 263), 8, BF
Line (28, 192)-(121, 263), 15, B
Line (28, 192)-(28, 262), 0
Line (28, 192)-(120, 193), 0, B
Line (30, 194)-(119, 261), 8, BF
Line (124, 220)-(146, 235), 8, BF
Line (124, 220)-(146, 235), 0, B
Line (124, 235)-(146, 235), 15
Line (146, 220)-(146, 235), 15
PrintSTRING 130, 222, "00", 1
'Color bar section
Line (151, 423)-(190, 434), 8, B
Line (151, 434)-(190, 434), 15
Line (190, 423)-(190, 434), 15
Line (152, 424)-(189, 433), 0, BF
CDATA:
Data 0,8,7,15,1,2,3,4,5,6,9,10,11,12,13,14
Restore CDATA
For x = 200 To 612 Step 26
    If x = 304 Then x = 321
    Read Colr
    Line (x, 423)-(x + 23, 434), Colr, BF
    Line (x, 423)-(x + 23, 434), 0, B
    Line (x, 434)-(x + 23, 434), 15
    Line (x + 23, 423)-(x + 23, 434), 15
    If Colr > 9 Then
        Put (x + 8, 413), FontBOX(12020)
        Hop = 1
    Else
        Hop = 0
    End If
    Colr$ = RTrim$(Str$(Colr))
    Num = Val(Right$(Colr$, 1))
    Put (x + 10 + Hop, 413), FontBOX(12000 + Num * 20)
Next x
PSet (14, 437), 15
Draw "D5R34BR53R34U5"
PSet (200, 438), 15
Draw "D4R25BR51R25U4BR20D4R118BR73R118U4"
Put (54, 438), FontBOX(10000)
Put (156, 438), FontBOX(10200)
Put (229, 438), FontBOX(10400)
Put (443, 438), FontBOX(11200)
Put (147, 459), FontBOX(10800)
Line (132, 463)-(142, 463), 15
P$ = "Check here for descriptions of the various functions"
PrintSTRING 290, 458, P$, 1
Put (60, 1), TitleBOX(), PSet
Put (60, 218), TitleBOX(), PSet
For y = 2 To 16 Step 2
    Line (313, y)-(586, y), 8
Next y
Put (592, 2), Box(), PSet
Put (624, 2), BBox(250), PSet
ToolX:
Data 342,366,391,416,441,466,511,536,560
Restore ToolX
For Index = 0 To 800 Step 100
    Read x
    If x = 536 Then y = 23 Else y = 22
    Put (x, y), ToolBOX(Index), PSet
Next Index
Index = 0
For x = 22 To 118 Step 24
    Put (x, 420), BBox(Index), PSet
    Index = Index + 50
Next x
PrintSTRING 19, 24, "File", 1
PrintSTRING 60, 24, "Edit", 1
PrintSTRING 100, 24, "Color", 1
PrintSTRING 148, 24, "Special", 1
PrintSTRING 205, 24, "Help", 1
Line (155, 45)-(626, 406), 7, BF
Line (155, 45)-(626, 406), 15, B
Line (155, 406)-(626, 406), 8
Line (626, 45)-(626, 406), 8
Line (166, 56)-(615, 395), 8, BF
Line (165, 55)-(616, 396), 15, B
Line (165, 55)-(616, 55), 0
Line (165, 55)-(165, 396), 0
For y = 24 To 38
    For x = 30 To 60
        xx = x * 5 + 166
        yy = y * 5 + 56
        Line (xx, y * 5 + 56)-(xx + 4, yy + 4), Point(x + 30, y + 194), BF
    Next x
Next y
Line (169, 59)-(611, 392), 0, B
Line (170, 60)-(610, 391), 0, B
Line (174, 64)-(606, 387), 0, B
Line (175, 65)-(605, 386), 0, B
PrintSTRING 142, 3, "untitled", 0
PrintSTRING 37, 459, "Pixel", 1
PrintSTRING 65, 459, "x:", 1
PrintSTRING 95, 459, "y:", 1
For y = 50 To 338 Step 70
    If y = 190 Then y = 194
    If y = 264 Then y = 268
    Line (30, y)-(119, y + 67), 0, B
    Line (32, y + 2)-(117, y + 65), 0, B
    Line (34, y + 4)-(115, y + 63), 0, B
    Put (60, y + 24), TitleBOX(), PSet
Next y
FileCOUNT = 0
Def Seg = VarSeg(FontBOX(0))
For y = 0 To 360 Step 120
    Get (0, y)-(639, y + 119), FontBOX()
    Put (0, y), FontBOX()
    FileCOUNT = FileCOUNT + 1
    FileNAME$ = "Animax!" + LTrim$(Str$(FileCOUNT)) + ".BSV"
    BSave FileNAME$, VarPtr(FontBOX(0)), 19681 * 2&
Next y
Def Seg = VarSeg(FontBOX(0))
BLoad "animssb.fnt", VarPtr(FontBOX(0))
BLoad "animssr.fnt", VarPtr(FontBOX(4700))
Def Seg
DrawBOX 100, 100, 378, 216, 0
GoSub BoxTOP
For x = 124 To 284 Step 80
    Line (x, 177)-(x + 70, 200), 0, B
    DrawBOX x + 1, 178, x + 69, 199, 0
Next x
PrintSTRING 112, 107, "Animax!", 0
PrintSTRING 162, 139, "The currently loaded file has been", 1
PrintSTRING 162, 152, "altered. Do you wish to save changes?", 1
PrintSTRING 150, 183, "Yes", 1
PrintSTRING 233, 183, "No", 1
PrintSTRING 303, 183, "Cancel", 1
Put (126, 138), ExBOX(), PSet
Get (100, 100)-(378, 216), Box()
Put (100, 100), Box()
Def Seg = VarSeg(Box(0))
BSave "anibox5.bsv", VarPtr(Box(0)), 16400
Def Seg
DrawBOX 100, 100, 184, 254, 0 '164
PrintSTRING 112, 108, "New", 1
PrintSTRING 112, 122, "Open", 1
PrintSTRING 112, 136, "Save", 1
PrintSTRING 112, 150, "Save As", 1
PrintSTRING 112, 173, "1", 1
PrintSTRING 117, 173, ".", 1
PrintSTRING 112, 187, "2.", 1
PrintSTRING 112, 201, "3.", 1
PrintSTRING 112, 215, "4.", 1
Line (103, 166)-(181, 166), 8
Line (103, 167)-(181, 167), 15
Line (103, 231)-(181, 231), 8
Line (103, 232)-(181, 232), 15
PrintSTRING 112, 238, "Exit", 1
Get (100, 100)-(184, 254), Box(0)
Put (100, 100), Box(0)
DrawBOX 200, 100, 252, 156, 0
PrintSTRING 212, 108, "Undo", 1
PrintSTRING 212, 122, "Copy", 1
PrintSTRING 212, 136, "Paste", 1
Get (200, 100)-(252, 156), Box(3420)
Put (200, 100), Box(3420)
DrawBOX 300, 100, 386, 142, 0
PrintSTRING 312, 108, "Select Palette", 1
PrintSTRING 312, 122, "Edit Colors", 1
Get (300, 100)-(386, 142), Box(4220)
Put (300, 100), Box(4220)
DrawBOX 400, 100, 497, 156, 0
PrintSTRING 412, 108, "Flip Horizontally", 1
PrintSTRING 412, 122, "Flip Vertically", 1
PrintSTRING 412, 136, "Negative Image", 1
Get (400, 100)-(497, 156), Box(5350)
Put (400, 100), Box(5350)
DrawBOX 100, 200, 196, 256, 0
PrintSTRING 112, 208, "Instructions", 1
PrintSTRING 112, 222, "Load Demo File", 1
PrintSTRING 112, 236, "About Animax!", 1
Get (100, 200)-(196, 256), Box(6834)
Put (100, 200), Box(6834)
Def Seg = VarSeg(Box(0))
BSave "animnus.bsv", VarPtr(Box(0)), 16640
Def Seg
'WinicoCL.BSV
DrawBOX 100, 100, 379, 230, 0
DrawBOX 110, 128, 370, 222, 1
GoSub BoxTOP
PrintSTRING 110, 107, "Animax! " + " Instructions", 0
Line (300, 106)-(318, 118), 7, BF
PSet (303, 112), 0
Draw "E5D3R6D4L6D3H5br2p0,0"
Line (325, 106)-(343, 118), 7, BF
PSet (340, 112), 15
Draw "H5D3L6D4R6D3E5bl2p15,15"
Restore HelpDATA
Def Seg = VarSeg(Box(0))
For Page = 1 To 10
    If Page = 2 Then Paint (305, 113), 15, 7
    If Page = 10 Then Paint (338, 113), 0, 7
    Line (111, 129)-(368, 220), 15, BF
    y = 133
    For Reps = 1 To 7
        Font = 1: yy = 0: xx = 0
        If Page = 6 Then
            If Reps = 1 Then Font = 0 Else Font = 1
            If Reps = 2 Then yy = 2
            If Reps = 1 Or Reps = 2 Then xx = -4
            If Reps = 4 Or Reps = 5 Then yy = -5
            Line (143, 162)-(169, 217), 7, BF
            Line (143, 188)-(169, 191), 15, BF
            DrawBOX 145, 164, 167, 185, 0
            DrawBOX 145, 194, 167, 215, 0
            Put (147, 167), ToolBOX(700), PSet
            Put (147, 197), ToolBOX(800), PSet
        End If
        Read h$
        PrintSTRING 124 + xx, y + yy, h$, Font
        y = y + 12
        Get (100, 100)-(379, 230), Box()
        FileNAME$ = "AxHELP" + LTrim$(Str$(Page)) + ".BSV"
        BSave FileNAME$, VarPtr(Box(0)), 18400
    Next Reps
Next Page
Def Seg
DrawBOX 100, 100, 379, 230, 0
GoSub BoxTOP
PrintSTRING 112, 107, "About Animax!", 0
PrintSTRING 124, 135, "Animax! 2.1", 0
PrintSTRING 242, 136, "(Freeware)", 1
PrintSTRING 124, 156, "Program type:", 1
PrintSTRING 242, 155, "Graphics/Animation Utility", 1
PrintSTRING 124, 167, "Program & Graphics by:", 1
PrintSTRING 242, 167, "Bob Seguin 2000 - 2007", 1
PrintSTRING 124, 179, "Language:", 1
PrintSTRING 242, 179, "QBasic 1.1", 1
PrintSTRING 124, 198, "Email:", 1
PrintSTRING 242, 198, "BOBSEG@sympatico.ca", 1
Get (100, 100)-(379, 230), Box()
Def Seg = VarSeg(Box(0))
BSave "axhelp11.bsv", VarPtr(Box(0)), 18400
Def Seg
DrawBOX 100, 100, 379, 178, 0
GoSub BoxTOP
PrintSTRING 110, 107, "Animax!", 0
Put (112, 134), ExBOX(), PSet
DrawBOX 321, 135, 368, 159, 0
Line (320, 134)-(369, 160), 0, B
PrintSTRING 339, 142, "OK", 1
PrintSTRING 152, 135, "Sorry, your file (or its path) could", 1
PrintSTRING 152, 147, "not be found. Please try again.", 1
Get (100, 100)-(379, 178), Box()
Line (142, 135)-(312, 159), 7, BF
PrintSTRING 142, 135, "Sorry, the file name you entered is in", 1
PrintSTRING 142, 147, "use by another file. Please try again.", 1
Get (142, 135)-(312, 159), Box(5535)
Line (142, 135)-(312, 159), 7, BF
PrintSTRING 148, 135, "Sorry, the file you requested is not", 1
PrintSTRING 148, 147, "a properly formatted Animax! file.", 1
Get (142, 135)-(312, 159), Box(6650)
Line (142, 135)-(312, 159), 7, BF
PrintSTRING 142, 135, "Please save the currently loaded file", 1
PrintSTRING 142, 147, "or select 'New' before loading demo.", 1
Get (142, 135)-(312, 159), Box(7765)
Def Seg = VarSeg(Box(0))
BSave "anibox4.bsv", VarPtr(Box(0)), 8880 * 2
Def Seg
Line (100, 100)-(379, 178), 0, BF
DrawBOX 100, 100, 379, 230, 0
GoSub BoxTOP
PrintSTRING 112, 107, "Edit Colors", 0
For x = 272 To 324 Step 51
    DrawBOX x, 202, x + 46, 225, 0
    Line (x - 1, 201)-(x + 47, 226), 0, B
Next x
PrintSTRING 279, 208, "Cancel", 1
PrintSTRING 340, 208, "OK", 1
DrawBOX 320, 164, 370, 197, 1
Line (321, 165)-(369, 196), 1, BF
Restore CDATA
Read a, B, c, d
For y = 140 To 150 Step 10
    For x = 110 To 330 Step 44
        DrawBOX x, y, x + 39, y + 8, 1
        Read Colr
        Line (x + 1, y + 1)-(x + 38, y + 7), Colr, BF
    Next x
Next y
PrintSTRING 110, 125, "Click color to edit", 1
PrintSTRING 110, 164, "R", 1
PrintSTRING 110, 176, "G", 1
PrintSTRING 110, 188, "B", 1
For y = 169 To 193 Step 12
    DrawBOX 125, y - 1, 285, y + 1, 1
    Line (126, y)-(285, y), 0
    PSet (285, y - 1), 8
Next y
PrintSTRING 110, 208, "Adjust sliders, click OK to accept", 1
Get (100, 100)-(379, 230), Box(500)
DrawBOX 100, 300, 115, 308, 0
Line (104, 301)-(104, 307), 15
Line (111, 301)-(111, 307), 8
Get (100, 300)-(115, 308), Box(9700)
Get (144, 189)-(159, 197), Box(9800)
Put (100, 300), Box(9700)
Put (100, 100), Box(500)
Def Seg = VarSeg(Box(0))
BSave "anibox3.bsv", VarPtr(Box(500)), 18800
Def Seg
SelectionDATA:
Data "DOS Default","Crayons","Pastels","Floral","Nature"
Data "Grayscale","Half-Gray","Half-Blue","Half-Violet","Half-Beige"
Data "Metals","Paper & Ink","Wood","People","Military"
DrawBOX 100, 100, 379, 210, 0
GoSub BoxTOP
PrintSTRING 112, 107, "Select Palette", 0
Restore SelectionDATA
For x = 118 To 290 Step 86
    For y = 134 To 200 Step 14
        Line (x, y)-(x + 4, y + 4), 15, B
        Read Selection$
        PrintSTRING x + 11, y - 3, Selection$, 1
    Next y
Next x
Get (100, 100)-(379, 210), Box(500)
Put (100, 100), Box(500)
Def Seg = VarSeg(Box(0))
BSave "anibox2.bsv", VarPtr(Box(500)), 15544
Def Seg
DrawBOX 100, 100, 379, 198, 0
Line (108, 126)-(370, 144), 15, BF
Line (108, 126)-(370, 144), 0, B
Line (108, 146)-(372, 146), 15
Line (372, 126)-(372, 146), 15
GoSub BoxTOP
For x = 274 To 325 Step 51
    DrawBOX x, 160, x + 46, 183, 0
    Line (x - 1, 159)-(x + 47, 184), 0, B
Next x
PrintSTRING 281, 166, "Cancel", 1
PrintSTRING 342, 166, "OK", 1
PrintSTRING 112, 107, "Open", 0
PrintSTRING 114, 160, "File names must be 8 characters", 1
PrintSTRING 114, 171, "or less. You may include a path.", 1
Get (100, 100)-(379, 198), Box(500)
GoSub BoxTOP
PrintSTRING 112, 107, "Save", 0
Get (112, 107)-(156, 118), Box(7500)
GoSub BoxTOP
PrintSTRING 112, 107, "Save As", 0
Get (112, 107)-(156, 118), Box(7800)
Line (100, 100)-(379, 198), 0, BF
Def Seg = VarSeg(Box(0))
BSave "anibox1.bsv", VarPtr(Box(500)), 15200
Def Seg
'Finish up
Line (5, 5)-(634, 474), 8, B
Line (8, 8)-(631, 471), 8, B
Line (200, 180)-(439, 290), 8, B
Line (197, 177)-(442, 293), 8, B
PrintSTRING 247, 212, "The graphics files for ANIMAX!", 1
PrintSTRING 243, 226, "have been successfully created.", 1
PrintSTRING 246, 250, "You can now run the program.", 1

a$ = Input$(1)
End

BoxTOP:
Line (104, 104)-(375, 121), 0, BF
For y = 105 To 121 Step 2
    Line (224, y)-(352, y), 8
Next y
DrawBOX 357, 106, 371, 119, 0
PSet (360, 109), 0
Draw "F7rH7BD7nE7lE7"
Return

GetFONT:
'Stores two fonts in single array (see PrintSTRING sub program).
Index = 2
For y = 206 To 454 Step 14
    For x = 0 To 140 Step 14
        Get (x, y)-(x + 11, y + 11), FontBOX(Index)
        Put (x, y), FontBOX(Index)
        Index = Index + 50
        If Index = 188 * 50 + 2 Then Exit For
    Next x
Next y
FontBOX(0) = 50
FontBOX(1) = 4
FontBOX(4700) = 50
FontBOX(4701) = 4
FontBOTTOM = 211
For Index = 2 To 187 * 50 + 2 Step 50
    GoSub ReduceFONT
Next Index
Def Seg = VarSeg(FontBOX(0))
BSave "animssb.fnt", VarPtr(FontBOX(0)), 9400
BSave "animssr.fnt", VarPtr(FontBOX(4700)), 9400
Def Seg
Return

ReduceFONT:
Line (0, 200)-(20, 220), 0, BF
Put (0, 200), FontBOX(Index)
x1 = -1: x2 = -1
For x = 0 To 20
    For y = 200 To 220
        If Point(x, y) <> 0 And x1 = -1 Then x1 = x
    Next y
Next x
For x = 20 To 0 Step -1
    For y = 200 To 220
        If Point(x, y) <> 0 And x2 = -1 Then x2 = x
    Next y
Next x
Get (x1, 200)-(x2 + 1, FontBOTTOM), FontBOX(Index)
Return

Setpalette:
Data 0,0,0,21,21,21,13,9,20,0,0,0,63,0,0,11,11,23,63,61,60,42,42,42,21
Data 21,21,63,43,0,43,30,60,0,63,63,59,55,59,0,0,42,58,54,54,63,63,63
Restore Setpalette
Out &H3C8, 0
For n = 1 To 48
    Read Intensity: Out &H3C9, Intensity
Next n
Return

HelpDATA:
Data "Animax is designed for the creation of animated"
Data "sequences for use in QBasic programs. The images"
Data "produced by this program are 90 pixels wide by"
Data "68 pixels deep. This size is entirely appropriate"
Data "since most animation is used in only small areas of"
Data "a larger image -- for example, a fire crackling in"
Data "in a fireplace or an animated character sprite."
Data "The frame you are working on is displayed in"
Data "the film gate to the left of the screen. Work is"
Data "done in the large center screen work area. The"
Data "icons across the top of this work area allow"
Data "you to select a variety of useful drawing tools"
Data "while the run controls on the lower left allow"
Data "manipulation of the frames created."
Data "Certain drawing functions (Box, Circle, Elipse,"
Data "Line and Mask) can only be used at three times"
Data "magnification. For these operations, the work"
Data "area will switch automatically to this reduced"
Data "size when the tool is selected."
Data "NOTE: Watch the status window at the bottom of"
Data "the screen for the tool/run control's description."
Data "It is important to keep in mind when working,"
Data "that you are actually drawing the small frame"
Data "on the left, not the large image in the work"
Data "area. After certain operations, the large drawing"
Data "area will switch from a relatively detailed image"
Data "to a magnified image of the frame. Aliasing will"
Data "become more pronounced. This is normal."
Data "To create a new frame, simply go to the last frame"
Data "in the sequence and press the frame advance"
Data "button. There are a total of 16 frames possible in"
Data "an Animax! (.AXB) file. This should be sufficient"
Data "for any animated action cycle. .AXB files are"
Data "BSAVE'd for rapid loading. When opening or sav-"
Data "ing, the extension .AXB is added automatically."
Data "Specialty Tools:"
Data "Right-click anywhere in work area to 'pick up' color.",""
Data "ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿToggles between 3x and 5x magnifi-"
Data "ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿcation of the frame being worked on."
Data "ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿClick any color in the image and all"
Data "ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿinstances of it change to pen color."
Data "Copy and Paste can be used with or without the"
Data "Mask tool. If you click Copy without masking, the"
Data "entire frame is copied and can be pasted into an-"
Data "other frame. If you copy a masked area it can only"
Data "be pasted to the same location in another frame."
Data "You can also locate a pasted image using a mask,"
Data "but only from and to the frame being worked on."
Data "In order to use .AXB files, you must first understand"
Data "how these files are structured. Information is held"
Data "in an integer array. The first 8 integers hold the"
Data "ASCII values of the file's name. The next 48 hold"
Data "the palette (RGB) intensity values in order from"
Data "attribute 0 to 15. Element 57 holds the number of"
Data "frames in the total sequence (1-16)."
Data "From element 58 to the end of the file is individual"
Data "frame information at 1635 integers per frame. For"
Data "example, Array(58) will PUT the first frame,"
Data "Array(1693) the second, etc. The minimum array"
Data "size necessary for a 16 frame sequence is 26217.",""
Data "Formula: ArraySIZE = 8 + 48 + 1 + Frames * 1635"
Data "Animax! can also be used as a drawing utility for"
Data "detailed SCREEN 12 images involving custom colors,"
Data "or to refine existing images created elsewhere."
Data "If you understand the structure of the .AXB file"
Data "you can GET images to an array in 90x68 'chunks'"
Data "and save them with the extension .AXB, then load"
Data "the file in Animax! to refine these images."
HueDATA:
Data "###b8bM#M88b##Gbb#8b8MMM88<#M##?#bP#bC#b##M8#bbb###bSbWGWVVbMMbbbZbbMMM"
Data "M88<MbMCWCbZMbSGbMMWBBbbb###bbMbb##b##M#bL8bBWMMM88<b##M##[MbI#AMWb88bb"
Data "bb###bb#8b8#C##8#ZZb8CbMMM88<WMCMC8bP?bC#b##M8#bbb###___[[[WWWSSSOOOKKK"
Data "MMM888GGGCCC???;;;777333bbb###bb##S###bb##___ZZZMMM88<UUUPPPKKKFFFAAA<<"
Data "<bbb###bb##S###bb##?Ib;E_MMM88<7A[3=W/9S+5O'1K#-Gbbb###bb##S###bb##bIb_"
Data "E_MMM88<[A[W=WS9SO5OK1KG-Gbbb###bb##S###bb##bUP_RMMMM88<\OJWJETGBQD?NA<"
Data "K>9bbb###_[_UQUUIFK:<bZMbUCMMM88<bM#ZC#]C8Z9/NOU:<Gbbb###/PS7/M##Cb//__"
Data "_bZbMMM88<UZbZbZbb]bZN]M;WG3bbb###bZR]M?WG7M8'WIII15MMM88<ZUKPKASIAE;=U"
Data "QOIECbbb###_ZG_PASS]#8M[C<Q<7MMM88<G59=-/b]WbZSbUMbOGbbb###ZZb88M##bb##"
Data "ZUMSMCMMM88<MC8C8-WWBMM8CC-88-bbb"
PixDATA:
Data "@7=8@7=8J7?0b7!O5?7>8?7>8I7=0?F=0Y7@0@7Š5=2€5>7?8>7?8H7=0?F=0=F=0W7>0=F"
Data ">0@7Š5=2v5=7E5=7@8=7@8H7=0>F=0>F=0V7>0=F?0@7‰5?2r5=2=E>6=7=2C5F8H7=0=F"
Data "=0?F=0U7>0=F?0A7ˆ5@2q5?E?6D5=7@8=7@8I7=0?F=0V7=0=F?0B7!=2>1=2?E@6=EC2>7"
Data "?8>7?8J7?0V7A0C7Œ2=7=1l2AEA6=7B2?7>8?7>8f7=0=F?0D7Œ2>6=7i2=1=2AEA6=EB2"
Data "@7=8@7=8e7=0=F?0E72>6=7i2=7AEB6=7A2n7=0=F?0F7…5D2?6=7g5=2BE?6=D>6=EA5"
Data "N7=8L0=8I7=0=F?0G7„3E2@6f3=1=2AEA6=D>6=7@3M7=0MF=0=8H7@0H7„3E2=7?6=1e3"
Data "=2=7AE?6=D=6=D>6=E@3L7=8OF=0=8F7@0I7ƒ3F2=7?6=7e3=2BE@6=D=6=D>6=7?3L7=0"
Data "DF?0DF=0=8F7>0K7‚3G2=7@6d3=1=2BE?6=D=6=D=6=D=6=E?3L7=0DF?0DF=0=8W7‚3H2"
Data "@6=1c3=2=7BE@6>D=6=D>6=7>3L7=0DF?0DF=0=8W7=3=2?3=2=3?2=3=2?3=2=3?2=3=2"
Data "?3=2=3?2=3=2?3=2=3?2=3=2?3=2=3?2=3=2=3=2?3=2=3?2=3=2?3=2=3I2@6=7=2=3?2"
Data "=3=2?3=2=3?2=3=2=3=2=3?2=3=2?3=2=3?2=3=2?3>2BEA6=D=6=D?6=E=2=3L7=0DF?0"
Data "DF=0=8W7C2?3C2?3C2?3C2?3C2?3E2?3P2@6=7>2?3C2?3A2?3C2?3A2=1=2BEB6>D@6>2"
Data "L7=0DF?0DF=0=8W7=3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3"
Data "=2=3=2A3=2=3=2=3=2=3=2A3=2=3=2=3B2=9D2=7@6=2A3=2=3=2=3=2A3=2=3=2A3=2=3"
Data "=2=3=2A3=2=3=2=3=2=7BE?6=D?6>D?6=7=3L7=0DF?0DF=0=8W7>3?2C3?2C3?2C3?2C3"
Data "?2E3?2C3D2=9F2@6=1B3?2C3=2C3?2C3@2CE@6=D>6=D=6=D>6=E=3L7=0DF?0DF=0=8W7"
Data ">3=2=3=2C3=2=3=2C3=2=3=2C3=2=3=2C3=2=3=2E3=2=3=2C3=2=3A2=9G2@6=7B3=2=3"
Data "=2C3=2C3=2=3=2C3=2=3=1=2BE@6>D?6>D?6=3?7>8G7=0DF?0DF=0=8W7>3?2C3?2C3?2"
Data "C3?2C3?2E3?2C3B2=9H2@6=7B3?2C3=2C3?2C3@2BEA6>D>6=D=6=D>6@7?8F7=0DF?0DF"
Data "=0=8F7I0@7=3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2"
Data "A3=2=3=2=3=2=3=2A3=2=3A2=9>2=9E2=7@6=1@3=2=3=2=3=2A3=2=3=2A3=2=3=2=3=2"
Data "A3=2=3=1=2=7BEA6=D=6=D>6=D=6=D>6?7@8E7=0DF?0DF=0=8F7=0G7=0@7=3>2=3>2A3"
Data ">2=3>2A3>2=3>2A3>2=3>2A3>2=3>2A3=2=3>2=3>2A3B2=9>2=9G2@6=1@3>2=3>2A3?2"
Data "A3>2=3>2A3>2=1=2DE?6=D=6>D>6=D=6=D>6?7A8D7=0DF?0DF=0=8F7=0G7=0@7=3=2?3"
Data "=2A3=2?3=2A3=2?3=2A3=2?3=2A3=2?3=2A3=2=3=2?3=2A3A2=9K2@6=7@3=2?3=2A3=2"
Data "=3=2A3=2?3=2A3=2=3>2EE?6=D=6>D>6=D=6=D=6?7B8C7=0DF?0DF=0=8F7=0G7=0@7>2"
Data "?3?2=3?2?3?2=3?2?3?2=3?2?3?2=3?2?3?2=3A2?3?2=3B2=9?2=9H2@6=7=1=3?2?3?2"
Data "=3?2=3?2=3?2?3?2=3?2=3=1=2EE?6=D=6=D=6=D>6=D>6?7A8D7=0DF?0DF=0=8F7=0G7"
Data "=0@7z3@2=9C2=9E2=7@6=1]3=2=1FE?6=D=6>D>6=D>6?7@8E7=0OF=0=8F7=0G7=0@7z3"
Data "?2=9?2=9?2=9G2@6=7^3=1=2FE?6>D=6=D>6=D=6?7?8F7=0OF=0=8F7=0G7=0@7y3@2=9"
Data ">2=9?2=9H2@6=7=1^3=2FE?6=D=6>D>6=D=6?7>8G7=0DF?0DF=0=8F7=0G7=0@7C3>2=3"
Data "[2O3@2=9B2=9I2A6=7^3=1=2FE?6=D=6>D?6L7=0DF?0DF=0=8F7=0G7=0@7B3?2=3\2L3"
Data "=2=3?2=9?2=9>2=9J2=E@6=7_3=2FE@6>D=6=D>6L7=0DF?0DF=0=8F7=0G7=0@7B3?2=3"
Data "\2L3=2=3B2=9?2=9G2=1=2?E@6=2^3=1=2FE?6=D=6>D>6L7=0DF?0DF=0=8F7=0G7=0@7"
Data "E2=3m2=3A2=9K2=1=2BE>6=1`2FE@6>D=6=D=6L7=0OF=0=8F7=0G7=0@7F2=3l2=3D2=9"
Data "G2=1=2DE=6=7_2=1=2EE@6=D=6=D>6L7=8=0MF>0=8F7I0@7F2=3l2=3O2=1=2EE=7=1a2"
Data "FE@6=D=6=D=6M7O0=8X7A4A2=3B2B9>2>9=2=9>2C9B2I4>2=3B2=9G2=1=2EE=7b4=1=2"
Data "EEA6=D>6N7N8Y7A4A2=3^2H4>2=3A2=9G2=1=2=7EE=7=6=7`4=1=2FE@6=D>6}7>9?3=2"
Data "=9?2=3D2=9=2>9=2=9?2>9=2>9=2=9=2=9D2E9?3>2=3@2=9H2=1=7EE=7?6a9=1=2EEA6"
Data "=D=6}7>4?3=9@2=3E2>9=2B9=2=9=2=9>2?9D2D4?3>2=3?2=9H2=1=2EE=7@6=7`4=3=2"
Data "FE@6=D=6}7>4?3=9=2=9>2=3_2D4?3>2=3K2=1=2EE=7B6_4>3=1=2EEB6}7>4?3=2=9?2"
Data "=3`2C4?3>2=3J2=1=2EE=7C6=7^4?3=2FEA6=8@7=8w7>4?3=2=9?2=3`2C4?3>2=3I2=1"
Data "=2EE=7E6^4?3=1=2EEA6>8?7>8i7A0D7>4?3=9@2=3a2B4?3>2=3H2=1=2EE=7F6=7\4A3"
Data "=2EEA6?8>7?8f7>0A7>0B7>4?3=9@2=3a2B4?3>2=3G2=1=2=7DE=7H6\4A3=1=2EE@6@8"
Data "=7@8d7=0E7=0A7>4?3=9A2=3a2A4?3>2=3G2=1=7DE?D=6>DD6=7[4B3=2EE@6F8c7=0E7"
Data "=0A7>4?3B2=3a2A4?3>2=3F2=1=2DE@7H6[4B3=1=2EE?6@8=7@8c7=0G7=0@7>4?3B2=3"
Data "b2@4?3>2=3E2=1=2EE=7AD=6=D>6>D=6=D>6=7Y4D3=2EE?6?8>7?8d7=0G7=0@7>4?3B2"
Data "=3b2@4?3>2=3D2=1=2EEA7I6Y4D3=1=2EE>6>8?7>8e7=0G7=0@7>4?3B2=3c2>4@3>2=3"
Data "C2=1=2EEC7H6=7X4E3=2EE>6=8@7=8f7=0G7=0@7>4?3B2=3c2>4@3>2=3B2=1=2EED7I6"
Data "W4F3=1=2DE>6l7=0G7=0@7>4?3B2=3d2=4@3>2=3A2=1=2=7DEE7I6=7V4G3=2EE=6m7=0"
Data "E7=0A7>4?3@2>1=3c1=2=4@3>2=3A2=1=7DE>7=DA7=D=7=D=6>D?6=DB6V4G3=1=2EEm7"
Data "=0E7=0A7>4?3?2=1e3>2=4@3>2=3@2=1=2DE=D=7?D=7?D=7@D=6=D=6?DA6=7U4H3=2EE"
Data "n7>0A7>0B7>4?3?2=1e2?4@3>2=3?2=1=2DEI7J6T4I3=1=2DEp7A0D7>4?3>2=1>3d7?4"
Data "@3>2=3>2=1=2EEI7J6=7S4J3=2DE}7>4?3>2=1=3=7dE?4@3>2=3=2=1=2EEK7J6S4J3=1"
Data "=2CE}7>4?3=2=1>3dE=7?4@3>2=3=1=2EEL7J6=7Q4L3=2CE}7>4@3=1>3dE=7>4A3>2>3"
Data "=2DEM7J6=7Q4L3=1=2BE}7>4?3=2=1>3dE=1>4A3>2=1=2DE=7[E=7Q4M3=2BE}7>4?3=2"
Data "=1>3dE?4A3=2=1>3?E=7`E=7Q4M3=1=2AE}7>4?3=2?3dE=1>4B3=1>3=7=E=7aE=7P4O3"
Data "=2AE>7=8@7=8u7>4C3dE=7>4B3=1?3cE=7P4O3=1=2>3>E>7=8?7>8h7@0E7>4@3=2>3=7"
Data "cE=7=1=4B3=1=2>3cE=7=2O4P3=1=2?3>7=8>7?8g7=0@7=0D7>4D3=7cE=2=4C3=1?3cE"
Data "=2N4R3=1=2>3>7=8=7@8f7=0B7=0C7>4A3=2?3cE>2C3?2=3=7bE>2M4R3>1=2=3>7B8f7"
Data "=0B7=0C7>4B3>2>3d2E3g2M4T3=1=2>7=8=7@8e7=0D7=0B7>4D3?2—3e4>3>7=8>7?8e7"
Data "=0D7=0B7!O4>7=8?7>8e7=0D7=0B7!O4>7=8@7=8e7=0D7=0B7!O5m7=0D7=0B7!O5n7=0"
Data "B7=0C7!O5n7=0B7=0C75>2Š5o7=0@7=0D75=2=C=7=1ˆ5p7@0E7€2>6=C=7=1†2}7€2A6"
Data "=7…2}7€2C6=7ƒ2}7€2D6p2=E=6M2}7~5>2D6m5=1=7>E>6L5}7}3?2D6m3=7?E?6K3}7}3"
Data "?2D6l3=1=7?E@6J3>7=8@7=8u7}3?2D6l3=7?EA6=7I3>7>8?7=8u7}3?2D6l3=7?E?6=D"
Data ">6I3>7?8>7=8o7=0A7|3@2D6k3=1@E@6=D>6H3>7@8=7=8n7=0B7=3=2?3=2=3?2=3=2?3"
Data "=2=3?2=3=2?3=2=3?2=3=2?3=2=3?2=3=2?3=2=3?2=3=2=3=2?3=2=3?2=3A2D6=3=2=3"
Data "?2=3=2?3=2=3?2=3=2?3=2=3?2=3=2=3=2=3?2=3=2?3=2=3?2=3=2=3=7@EA6=D=6=E=3"
Data "?2=3=2?3=2=3>7B8m7=0C7C2?3C2?3C2?3C2?3C2?3E2?3B2D6?2?3C2?3C2?3A2?3C2?3"
Data ">2=1=7?E@6=D>6=D=6=E?3C2>7@8=7=8l7=0D7=3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2"
Data "=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2=3=2A3A2D6=3=2A3=2=3=2=3=2A3=2"
Data "=3=2=3=2A3=2=3=2A3=2=3=2=3=2A3=2=7@E?6=D=6=D>6=D=E=7?3=2=3=2=3=2=3>7?8"
Data ">7=8k7=0E7>3?2C3?2C3?2C3?2C3?2E3?2B3A2D6=2C3?2C3?2C3=2C3?2C3=7@E@6=D=6"
Data "=D=6=D>6@3?2>3>7>8?7=8j7=0F7>3=2=3=2C3=2=3=2C3=2=3=2C3=2=3=2C3=2=3=2E3"
Data "=2=3=2B3A2D6=2C3=2=3=2C3=2=3=2C3=2C3=2=3=2B3=1AE>6=D>6=D=6=D=6=D=6=E?3"
Data "=2=3=2>3>7=8@7=8i7=0G7>3?2C3?2C3?2C3A2A3?2E3?2A3?2=9>2D6=2C3?2C3?2C3=2"
Data "C3?2B3=7@E@6=D>6>D?6>E>3?2>3p7=0H7=3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2"
Data "A3B2@3=2=3=2=3=2A3=2=3=2=3=2=3=2@3>2=9?2D6=3=2A3=2=3=2=3=2A3=2=3=2=3=2"
Data "A3=2=3=2A3=2=3=2=3=2@3=1=7@E?6=D=6=D>6>D@6=7=2=3=2=3=2=3o7=0I7=3>2=3>2"
Data "A3>2=3>2A3>2=3>2=3G2?3>2=3>2A3=2=3>2=3>2@3>2=9?2D6>2A3>2=3>2A3>2=3>2A3"
Data "?2A3>2=3>2@3=7AE@6>D>6=D=6=D@6>2=3>2=3n7=0J7=3=2?3=2A3=2?3=2A3=2=3K2?3"
Data "=2?3=2A3=2=3=2?3=2?3>2=9@2D6=3=2A3=2?3=2A3=2?3=2A3=2=3=2A3=2?3=2?3=1=7"
Data "BE@6>D>6=D=6=D?6=E?3=2=3m7=0K7>2?3?2=3?2?3?2=3S2?3?2=3A2?3?2=3>2=9@2D6"
Data "=3?2=3?2?3?2=3?2?3?2=3?2=3?2=3?2?3@2=7DE?6=D=6=D>6=D=6=D?6=7>3>2l7=0L7"
Data "K3T2R3C2D6f3=1=7EE?6=D=6=D>6>D?6=E@3}7G3Y2P3>2=9=2=9?2D6f3=7FE@6>D?6>D"
Data "?6=7?3}7F3Q2>9C2P3>2=9=2=9?2D6f3=7GE@6>D>6=D=6=D>6=E?3}7C3>2=3L2>9=2=9"
Data "G2O3>2=9@2=1>E=CA6f3>2GE?6=D=6=D>6=D=6=D>6=E>3}7B3?2=3H2>9=2=9K2N3>2=9"
Data "=2=9?2=7AE=C>6g3=1=2FE@6=D=6=D>6=D=6=D=6=E=7=3}7B3?2=3D2?9C2>9H2M3>2=9"
Data "=2=9?2=7DEI6[3=1=2FE@6>D?6>D>6=E=3}7E2=3A2>9C2=9=2>9\2=9=2=9?2=1EEI6=7"
Data "[2=1FE@6=D=6=D?6>D>6=7KF=0d7?0B7F2=3E2@9`2=9=2=9?2=7EE=D=6=D=6CD?6]2FE"
Data "@6=D=6=D>6=D?6=E=FI7=8=0c7=0>F=0B7F2=3D2=9E2>9=2=9W2=9A2=7DEK6=7[2=1=2"
Data "FE@6=D=6=D>6=D>6=E=FI7=8=0b7=0>F?0A7A4A2=3J2=9=2=9L2I4>2=9=2=9?2=1EE?D"
Data "=6>D>6>D=6?D>6\4=1FEA6=D=6=D@6=E=FI7=8=0a7=0?F>7>0@7A4A2=3F2=9=2=9P2I4"
Data ">2=9A2=7EEL6=7\4=2FE@6=D>6=D@6=F?7>0@7>0>7=8=0^7>F=0@F?7>0?7>9?3A2=3C2"
Data "?9S2=1D9@3@2=9?2=7DE=6GD=6=D=6=D>6\9=1=2FE@6=D=6=D@6=F@7>0>7>0?7=8=0\7"
Data "?F=0?F=0=7=F?7>0>7>4?3=9@2=3A2=9X2D4@3C2=1EEN6=7\4=1=2EEA6=D=6=D?6=FA7"
Data "@0@7=8=0\7>F=0@F?7=F?7>0=7>4?3=9@2=3^2=1C4@3C2=7EEO6\4=1=2FEA6=D@6=FB7"
Data ">0A7=8=0[7>F>0=F=0>7=FC7=0=7>4?3A2=3_2C4@3C2=7DEP6=7[4=3=1=2FE@6=D@6=F"
Data "A7@0@7=8=0[7>F=7?0?7=FA7>0=7>4?3=9@2=3_2C4@3B2=1EEQ6[4>3=1FEE6=F@7>0>7"
Data ">0?7=8=0[7>F?7=0@7=F?7>0>7>4?3=9@2=3_2=1B4@3B2=7DEAD>6>D>6>D=6>D=6?D>6"
Data "=7Y4@3=2FED6=F?7>0@7>0>7=8=0[7>F@7=0B7>0?7>4?3=9@2=3`2B4@3B2=7DES6Y4@3"
Data "=1=2FEC6=FI7=8=0[7>FA7=0@7>0@7>4?3=9A2=3_2=1A4@3A2=1EEHD=6>D=6>D=6=D?6"
Data "=7X4A3=2FEC6=FI7=8=0[7>FB7=0>7>0A7>4?3B2=3`2A4@3A2=7DEU6W4B3=1=2FEB6=F"
Data "J8=0[7>FC7?0B7>4?3B2=3Z2?1>7B4@3A2=7DEED=6AD=6=D>6>D=6=D>6=7V4C3=1=2FE"
Data "A6L0Y7BFJ7>4?3B2=3V2?1?7>E=7B4@3@2=1EEV6V4D3=2FEA6}7>4?3B2=3R2?1?7BE=7"
Data "A4A3@2=1DE>6>DS6=7T4E3=1=2FE@6}7>4?3B2=3N2?1?7GE=7@4A3@2=7DEX6T4F3=1=2"
Data "FE?6}7>4?3Q2?1?7KE=7@4A3?2=1=7CE=FX6=7S4G3=1=2EE?6}7>4?3N2>1?7OE=7@4A3"
Data "?2=1CE=7=E=6>D=6=D>6=DA6=D=6=D=6>D?6=DB6R4I3=2FE>6}7>4?3L2=1>7TE@4A3?2"
Data "=7CE=7=E>D=6>D=6?D=6?D=6@D=6=D=6?DA6=7Q4I3=1=2FE=6K0=Fm7>4?3I2=1>7RE@F"
Data "=7@4A3>2=1=7CE=7=EZ6Q4J3=1=2EE=6=0J8=F[7>0=F>0=F>0=F>0=F>0@7>4?3?2=3A2"
Data "=1>7RE?7=EAF@4A3>2=1CE?7Z6=7O4L3=2FE=0=8H7>F[7=0H7=0@7>4?3@2=3=2=1>7QE"
Data "D7AF=7?4A3>2=1CE?7[6O4L3=1=2EE=0=8H7>F[7=FH7=F@7>4?3?2=1=3=7OEI7=EAF?4"
Data "A3=2=1=7BE@7=EZ6=7N4M3=1=2DE=0=8H7>F[7=0H7=0@7>4@3=2=1=3=7LEN7AF=7>4A3"
Data "=2=1=7BE@7=EZ6=7M4O3=1=2CE=0=8?7>0@7>0=7>F[7=0H7=0@7>4?3=2>3>7HE=7=EA7"
Data "PE=7>4A3=2=1BE=7_E=7M4P3=2CE=0=8@7>0>7>0>7>F[7=FH7=F@7>4?3=2=1=3>7CE=7"
Data "=E>7XE=7>4A3=2=1fE=7M4P3=1=2BE=0=8A7@0?7>F[7=0H7=0@7>4?3=2=1=3>7cE=7>4"
Data "A3=2=1=3eE=7M4Q3=1=2AE=0=8B7>0@7>F[7=0H7=0@7>4@3=2=3>7cE=7>4B3=1>3=E=7"
Data "bE=7L4S3=1=2@E=0=8A7@0?7>F[7=FH7=F@7>4@3=2>3=7cE=7=2=4B3=1?3cE=7=2K4S3"
Data "=1=2>E>3=0=8@7>0>7>0>7>F[7=0H7=0@7>4A3=2=3>7cE=2=4C3=1?3cE=2K4T3=1>2>3"
Data "=0=8?7>0@7>0=7>F[7=0H7=0@7>4A3=2>3=7cE>2C3=2=1>3cE>2I4V3=1>2=3=0=8H7>F"
Data "[7=FH7=F@7>4B3>2>3d2D3>2=3=1d2I4W3>1=3=0=8JF[7=0H7=0@7>4D3?2m3?2c3I4Z3"
Data "LF[7>0=F>0=F>0=F>0=F>0@7!H4C3}7!O4}7!O5}7!O5}7!O5}7s5=D—5KF=0KF^7r5=7=2"
Data "—5=FI7=8=0=FI7=8M7I0@7r2=7=2E6Ž2=FI7=8=0=F>7E8>7=8M7D0@F=0@7r2=7=2E6=D"
Data "2=FI7=8=0=F>7E8>7=8M7>0?F?0@F=0@7r2=7=2E6=72=FI7=8=0=F>7=8CF=8=F=7=8"
Data "M7>0>F@0@F=0@7r2=7=2E6=E2=FI7=8=0=F>7=8=FB7=8=F=7=8M7>0=F=0=F?0@F=0@7"
Data "r5=7=2F65=FI7=8=0=F>7=8=FB7=8=F=7=8M7A0=F>0@F=0@7r3=7=2F63=FI7=8=0=F"
Data ">7=8=FB7=8=F=7=8M7B0=7=0@F=0@7r3=7=2F63=FI7=8=0=F>7=8=FB7=8=F=7=8M7C0"
Data "=7@F=0@7\3=2Q3=7=2F63=F@7A8=F?7=8=0=F>7=8=FB7=8=F=7=8M7=0CF=0=F=0=F=0"
Data "@7Z3@2P3=7=2F63=F@7A8=F?7=8=0=F>7=8=FB7=8=F=7=8M7=0DF>0=F=0@7Y3A2=7O3"
Data "=7=2F63=FA7AF?7=8=0=F>7E8=F=7=8M7=0CF?0=F=0@7=3=2?3=2=3?2=3=2?3=2=3?2"
Data "=3=2?3=2=3C2=6=2=3?2=3=2?3=2=3?2=3=2=3=2=7=2F6=3=2=3?2=3=2?3=2=3?2=3=2"
Data "?3=2=3?2=3=2?3=2=3?2=3=2=3=2=3?2=3=2?3=2=3?2=3=2=6=D=3=2=3?2=3=2?3=2=3"
Data "?2=3=2?3=2=3=FI7=8=0=FI7=8M7=0GF=0@7C2?3C2?3J2>7=2?3C2?3@2=1=2FE?2?3C2"
Data "?3C2?3C2?3A2?3C2?3=2=E>6=7>2?3C2?3C2=FJ8=0=FJ8M7I0@7=3=2=3=2=3=2A3=2=3"
Data "=2=3=2A3=2=3H2=6A3=2=3=2=3=2A3=2=3=2=1=2FE=3=2A3=2=3=2=3=2A3=2=3=2=3=2"
Data "A3=2=3=2=3=2A3=2=3=2A3=2=3=2=3=2A3@6=7A3=2=3=2=3=2A3=2=3=2=3=2=3}7>3?2"
Data "C3?2C3I2=6=7A3?2E3=1=2FE=2C3?2C3?2C3?2C3=2C3?2A3=EB6=7@3?2C3?2>3}7>3=2"
Data "=3=2C3=2=3=2B3J2=7=6A3=2=3=2E3=1=2FE=2C3=2=3=2C3=2=3=2C3=2=3=2C3=2C3=2"
Data "=3=2A3E6=7>3=2=3=2C3=2=3=2>3}7>3?2C3?2A3L2=6A3?2E3=1=2DE=C=E=2C3?2C3?2"
Data "C3?2C3=2C3?2@3=E?6=DC6=7?2C3?2>3}7=3=2=3=2=3=2A3=2=3=2=3=2>3N2>7?3=2=3"
Data "=2=3=2A3=2=3=2=1=2FE=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2A3"
Data "=2=3=2=3=2>3=2A6>DC6=7=3=2A3=2=3=2=3=2=3}7=3>2=3>2A3>2=3>2=3F2=9E2=6?3"
Data ">2=3>2A3=2=3=2=1=2FE>2A3>2=3>2A3>2=3>2A3>2=3>2A3?2A3>2=3>2=3=2=E@6=D>6"
Data "=DC6=7=2A3>2=3>2=3=8?FC8=FN8=F=8]7=3=2?3=2A3=2?3G2=9F2=6=7>3=2?3=2A3=2"
Data "=3=2=1=2FE=3=2A3=2?3=2A3=2?3=2A3=2?3=2A3=2=3=2A3=2?3=2=3=2@6=D=6>D=6>D"
Data "C6=7@3=2?3=2=3AFB8=FN8=F=8]7>2?3?2=3?2>3F2>9G2=7=6?2?3?2=3A2=1=2FE=3?2"
Data "=3?2?3?2=3?2?3?2=3?2?3?2=3?2=3?2=3?2?3?2A6>D=6>D=6>DC6=7?2?3>2AFU8=F=8"
Data "]7H3F2>9J2=6=1J3=1=2FEo3=E@6=D>6=D>6=DG6=7B3AFU8=F=8M7=0F7=0@7G3E2>9?2"
Data ">9G2>7J3=1=2FEn3=2B6>D=6>D=6>DG6=7@3=F?8=F=8?F>8=F=8@F>8?F>8>F=8>F=8=F"
Data "=8M7=0F7=0@7E3E2=9A2=9J2=6=1I3=1=2FEn3=ED6=D>6>D=6>DF6=7?3=F?8=F=8@F=8"
Data "=F=8AF=8@F=8>F=8>F=8=F=8L7?0>7=F>7=F>7=0=F=0?7D3E2=9@2=9L2>7I3=1=2FEm3"
Data "=2@6=DA6>D>6=D>6>DE6=7>3AF=8@F=8=F=8AF=8@F=8>F=8>F=8=F=8L7?0=7BF=7=0=F"
Data "=0?7B3=2=3C2=9@2=9B2>9F2=7=6I3=1=2FEm3=EA6=D=6=D@6=D>6>D>6>DD6=7=3AF=8"
Data "@F=8=F=8AF=8@F=8>F=8>F=8=F=8L7?0=7=0=F>0=F=0=7=0=F=0?7B3=2=3B2=9?2>9B2"
Data "=9I2=6=7H3=1=2FES6U3=2A6=D=6=D>6=D?6>D>6>D>6=DD6=7AF=8=F>8=F=8=F=8=F=8"
Data "=F=8=F@8=F?8=F?8=F=8K7=0=F?0=7=0>7=0=7=0?F=0>7C2=3E2=9A2=9=2=9J2=7=6H2"
Data "=1=2FES6=7T2=EB6=D>6=D=6=D@6>D>6=D>6>DC6=F?8=F=8=F>8=F=8=F=8=F=8=F=8=F"
Data ">8?F?8=F?8=F=8K7=0=F?0B7=0?F=0>7C2=3G2=9=2=9N2=7=6=7G2=1=2FE>D=6@D=6=D"
Data "=6=D=6=D=6CD?6T2=E@6=D>6>D@6=D@6=D>6>D>6>DA6=F?8=F=8=F>8=F=8=F=8=F=8=F"
Data "=8=F=8=F>8=F?8=F?8=F=8J7=0=FA0@7=0AF=0=7C2=3H2=9P2=1=6G2=1=2FET6=7R2?E"
Data "@6>D>6>D=6=D=6=D@6>D>6>DC6=F?8=F=8=F>8=F=8=F=8=F=8=F=8=F=8@F=8>F=8>F?8"
Data "J7C0@7=0AF=0=7A4>2=3E2?9P2=1=6=E=1F4=1=2FE?D>6?D=6?D=6>D>6>D=6?D>6Q4=2"
Data "@EA6>D>6=D@6=D@6>D>6=DB6=F?8=F=8=F>8=F=8=F=8=F=8=F=8=F=8@F=8>F=8>F?8J7"
Data "C0@7=0AF=0=7A4>2=3C2>9Q2>1=2=E>6F4=1=2FEU6=7P4BEB6=D>6>D=6=D=6>D@6=D>6"
Data ">D@6=F?8=F=8=F>8=F=8=F=8=F=8=F=8=F=8@F=8>F=8>F=8=F=8K7A0B7=0?F=0>7>9?3"
Data ">2=3C2=9Q2=1=2@E=6F9=1=2FE=D=6>D=6=D?6GD=6=D=6=D>6O9=2DEA6>D>6=D@6=D@6"
Data ">DB6=F?8=F=8=F>8=F=8=F=8=F=8=F=8=F>8?F=8>F=8>F=8=F=8L7?0D7?0?7>4?3>2=3"
Data "W2>1=2BE=6C4>3=1=2FEV6=7M4=2FEB6=D>6>D=6=D=6>DF6\8]7>4?3>2=3V2=1=2EEC4"
Data ">3=1=2FE>D=6>D=6>DO6M4IEA6>D>6=D@6=DE6}0>4?3>2=3T2>1=2GEB4>3=1=2FEW6=7"
Data "K4=2=7IEB6>D=6>D?6>DC6}0>4?3>2=3S2=1=2HE=7B4>3=1=2FEX6K4=1>2JEB6=D>6>D"
Data "F6}0>4?3>2=3Q2>1=2HED4>3=1=2FEBD=6@D>6>D>6>D=6>D=6?D>6=7K4=1>2KEA6>D>6"
Data "=D>6=DB6}0>4?3>2=3P2=1=2HE=6E4>3=1=2FEY6L4>1>2JEE6>D=6>D@6}0>4?3>2=3N2"
Data ">1=2GE?6=7D4>3=1=2FE=D=6LD=6>D=6>D=6=D?6=7M4=1>2KEE6=DB6}0>4?3>2=3M2=1"
Data "=2FEC6D4>3=1=2FEZ6N4>1=2KEE6>D@6}0>4?3>2=3K2>1=2FE>6>D=6=D>6=7C4>3=1=2"
Data "FE=D=6HD=6AD=6=D>6>D=6=D>6=7O4=1>2KEI6}0>4?3>2=3J2=1=2FEG6C4>3=1=2FE[6"
Data "P4>1=2KEH6}0=4@3>2=3H2>1=2FEH6=7B4>3=1=2FE>D=6>D=6>DS6=7O4>3=1>2KEF6}0"
Data "=4@3>2=3G2=1=2FE>7I6B4>3=1=2FE\6O4?3>1=2LED6}0=4@3>2=3E2>1=2FE?7I6=7A4"
Data ">3=1=2FE\6=7N4A3=1>2KEC6}0=4@3>2=3D2=1=2FE?7=D=7=D=6>D?6=DB6A4>3=1=2FE"
Data "A6>D=6=D>6=DA6=D=6=D=6>D?6=DB6M4C3=1>3LEA6}0=4@3>2=3B2>1=2EE=D=7?D=7@D"
Data "=6=D=6?DA6=7@4>3=1=2FE@6>D=6>D=6?D=6?D=6@D=6=D=6?DA6=7L4D3>1>2KE@6}0=4"
Data "@3>2=3A2=1=2FEE7J6@4>3=1=2FE^6L4F3>1>2JE?6}0=4@3>2=3?2>1=2FEF7J6=7?4>3"
Data "=1=2DE=C_6=7J4I3>1=2JE>6}0=4@3>2=3>2=1=2FEI7J6?4>3=1=2DE=C`6J4K3=1>2HE"
Data ">6}0=4@3>2=3>1=2FEJ7J6=7>4>3=1=2DE=7`6=7I4L3>1=2HE=6}0A3>2>3=2EEL7J6=7"
Data ">4>3=1=2DE=7`6=7H4O3=1>2GE}0A3>2=1=3=7cE=7>4>3=1=2CE>7`E=7H4P3>1=2FE}0"
Data "A3=2=1>3=7>E=7`E=7>4>3=1=2BE>7aE=7H4R3=1>2DE}0B3=1?3=E=7aE=7>4>3=1=2>3"
Data "@E=7bE=7G4T3>1=2CE}0B3=1?3cE=7>4>3=1=2?3=7=E=7cE=7G4V3=1>2AE}0B3=1=2>3"
Data "cE=7=2=4>3>1A3dE=7=2F4W3>1=2?E=3}0C3=1?3cE=2=4?3=1=2@3eE=2E4Z3=1@3}0C3"
Data "=1>2=3cE>2@3=1=2@3dE>2D4Z3=2>1>3}0E3g2A3=1=2@3e2C4\3>2>1}0p3>4@3=1@2e3"
Data "d4>3=2}0r4A3>1C3‹4}0!O4!e0g5!e0g5!e0g5>FH0>F=0>FF0>F=0>FF0>FG0?FG0>FG0"
Data ">FI0>FG0>Fs0g5>FH0>F=0>FF0>F=0>FE0@FE0>F=0>F=0>FB0@FF0>FH0>FI0>FG0@Fc0"
Data "g5>FH0>F=0>FE0CFC0BFE0?F=0>FC0@FF0>FH0>FI0>FH0>Fd0g2>FW0>F=0>FD0@FJ0>F"
Data "E0>FU0>FI0>FG0@FH0>FU0g2>FW0>F=0>FE0?FI0>FF0>FU0>FI0>FW0>FU0g2>FW0>F=0"
Data ">FF0?FG0>FF0BFR0>FI0>FU0BFS0g2>FV0CFE0@FE0>F=0?FC0>F=0>FS0>FI0>FW0>FU0"
Data "g5Y0>F=0>FD0BFD0>F=0>F=0>FB0>F=0>FS0>FI0>FW0>FU0g3>FW0>F=0>FE0@FI0?FD0"
Data "AFR0>FI0>Fr0g3h0>Fp0>FI0>Fr0g3Ÿ0>FG0>Fs0g3!e0g3!e0=3=2=3?2=3=2?3=2=3?2"
Data "=3=2?3=2=3?2=3=2?3=2=3?2=3=2?3=2=3!e0?2?3C2?3C2?3C2?3C2i0>FF0@FG0>FG0@F"
Data "F0@FH0>FE0BFE0@FT0=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2"
Data "=3i0>FE0>F>0>FD0@FF0>F>0>FD0>F>0>FF0?FE0>FH0>F>0>FS0=2C3?2C3?2C3?2C3?2"
Data ">3i0>FE0>F>0>FF0>FJ0>FH0>FF0?FE0>FH0>FW0=2C3=2=3=2C3=2=3=2C3=2=3=2C3=2"
Data "=3=2>3h0>FF0>F>0>FF0>FJ0>FH0>FE0@FE0AFE0>FW0=2C3?2C3?2C3?2C3?2>3h0>FF0"
Data ">F>0>FF0>FI0>FG0?FF0@FE0>F>0>FD0AFT0=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3"
Data "=2=3=2A3=2=3=2=3=2=3J0?FV0>FG0>F>0>FF0>FH0>FJ0>FD0>F=0>FI0>FD0>F>0>FS0"
Data ">2A3>2=3>2?3=E=7>2=3>2A3>2=3>2A3>2=3>2=3g0>FG0>F>0>FF0>FG0>FK0>FD0BFH0"
Data ">FD0>F>0>FS0=3=2A3=2?3=2?3>6=C=E=7=3=2A3=2?3=2A3=2?3=2=3f0>FH0>F>0>FF0"
Data ">FF0>FH0>F>0>FG0>FE0>F>0>FD0>F>0>FS0=3?2=3?2?3?2=EA6=C=E=7=2=3?2?3?2=3"
Data "?2?3>2=0>FU0>FH0>FI0@FG0>FF0BFE0@FH0>FF0@FF0@FT0J3F6=C=E=7L3>F!c0I3=EI6"
Data "=C=E=7I3!e0I3N6=C=E=7E3!e0H3=2@6=DM6=E=7B3!e0H3=EA6?DL6=C=7@3!=0AF_0G3"
Data "=2E6>DM6=7>3BFE0@FF0@FŒ0@FF0?F?0?FC0>FT0G2=EC6=D?6?DJ6=C=7=2@0>FD0>F>0"
Data ">FD0>F>0>FŠ0>F>0>FE0>FA0>FC0>FT0G2=E?6=D@6?DO6=7?0>FE0>F>0>FD0>F>0>Fc0"
Data ">FS0>FL0>FD0>F>0@F=0>FA0@FS0F2=EA6?D@6@DL6?0>FE0>F>0>FD0>F>0>FD0>FI0>F"
Data "I0>FU0>FK0>FD0>F=0>F=0>F=0>FA0@FS0E4=2=E?6=D@6?DA6?DI6>0>FG0@FF0AFa0>F"
Data "G0BFF0>FI0>FE0>F=0>F=0>F=0>F@0>F>0>FR0E4=EA6?D@6?DA6?DF6>0>FF0>F>0>FH0"
Data ">F`0>FY0>FG0>FF0>F>0CF@0>F>0>FR0E9E6?D@6?DA6?DC6=0>FG0>F>0>FH0>Fa0>FG0"
Data "BFF0>FH0>FG0>FH0BFR0D4=2@6=DC6?D@6?DH6=0>FG0>F>0>FD0>F>0>Fb0>FU0>FV0?F"
Data "F0>F@0>FQ0D4B6?DC6?D@6?DE6=0>FH0@FF0@FE0>FI0>FJ0>FS0>FJ0>FJ0@FB0>F@0>F"
Data "Q0C4=2@6=D@6?DC6?D@6?DB6t0>F«0C4=EA6?D@6?DC6>DG6!e0B4=2@6=D@6@D?6?DB6?D"
Data "D6!e0B4=EA6?DA6?D?6?DB6?DA6!e0A4=2E6@D@6?D?6?DG6!e0A4=EI6?D@6?D?6?DD6AF"
Data "F0AFD0AFE0BFD0BFE0AFD0>F?0>FC0>FK0>FE0>F>0>FD0>FW0@4=2?EJ6?D@6?D?6?DA6"
Data ">F>0>FD0>F?0>FC0>F>0>FD0>FH0>FH0>F?0>FC0>F?0>FC0>FK0>FE0>F=0>FE0>FW0@4"
Data "=7BEJ6?D@6?DD6>F>0>FD0>FH0>F?0>FC0>FH0>FH0>FH0>F?0>FC0>FK0>FE0@FF0>FW0"
Data "@4FEQ6?DA6>F>0>FD0>FH0>F?0>FC0>FH0>FH0>FH0>F?0>FC0>FK0>FE0?FG0>FW0?4=2"
Data "IEV6AFE0>FH0>F?0>FC0AFE0AFE0>F=0@FC0CFC0>FK0>FE0?FG0>FW0>4=2=7KET6>F>0"
Data ">FD0>FH0>F?0>FC0>FH0>FH0>F?0>FC0>F?0>FC0>FK0>FE0@FF0>FW0>4=2OEQ6>F>0>F"
Data "D0>FH0>F?0>FC0>FH0>FH0>F?0>FC0>F?0>FC0>FH0>F=0>FE0>F=0>FE0>FW0=4>2REN6"
Data ">F>0>FD0>F?0>FC0>F>0>FD0>FH0>FH0>F>0?FC0>F?0>FC0>FH0>F=0>FE0>F>0>FD0>F"
Data "W0=4=1@2REK6AFF0AFD0AFE0BFD0>FI0BFC0>F?0>FC0>FI0?FF0>F?0>FC0BFS0>4?1?2"
Data "SEH6!e0A4?1@2REE6!e0B4>3?1@2QEC6!e0A4B3?1@2QE@6!e0A4E3?1@2NE@6!e0@4I3?1"
Data "@2ME>6>F@0>FB0>F?0>FD0AFD0BFE0AFD0BFE0@FE0BFD0>F?0>FC0>F@0>FB0>FD0>FM0"
Data "@4L3?1@2LE>F@0>FB0?F>0>FC0>F?0>FC0>F?0>FC0>F?0>FC0>F?0>FC0>F>0>FF0>FF0"
Data ">F?0>FC0>F@0>FB0>FD0>FM0?4P3@1?2IE?F>0?FB0?F>0>FC0>F?0>FC0>F?0>FC0>F?0"
Data ">FC0>F?0>FC0>FJ0>FF0>F?0>FD0>F>0>FD0>F>0>F>0>FN0?4T3?1?2FE?F>0?FB0@F=0"
Data ">FC0>F?0>FC0>F?0>FC0>F?0>FC0>F?0>FC0>FJ0>FF0>F?0>FD0>F>0>FD0>F>0>F>0>F"
Data "N0>4X3?1?2CEDFB0@F=0>FC0>F?0>FC0BFD0>F?0>FC0BFE0@FG0>FF0>F?0>FD0>F>0>F"
Data "D0>F>0>F>0>FN0>4[3?1?2>E>3DFB0>F=0@FC0>F?0>FC0>FH0>F?0>FC0>F?0>FG0>FF0"
Data ">FF0>F?0>FE0@FF0DFO0=4^3?1>2?3>F=0>F=0>FB0>F>0?FC0>F?0>FC0>FH0>F=0@FC0"
Data ">F?0>FG0>FF0>FF0>F?0>FE0@FF0DFO0J4T3>1?3>F=0>F=0>FB0>F>0?FC0>F?0>FC0>F"
Data "H0>F>0?FC0>F?0>FC0>F>0>FF0>FF0>F?0>FF0>FH0>F>0>FP0^4A3=2?1>F@0>FB0>F?0"
Data ">FD0AFD0>FI0AFD0>F?0>FD0@FG0>FG0AFG0>FH0>F>0>FP0g4y0>F¦0g5!e0g5!e0g5!e0"
Data "g5’0>F0g5>F@0>FB0>F@0>FB0DFB0?FG0>FH0?FH0@FS0>FV0>FW0g2>F@0>FB0>F@0>F"
Data "H0>FB0>FH0>FI0>FG0>F>0>FS0>FU0>FW0g2=0>F>0>FD0>F>0>FH0>FC0>FH0>FI0>F0"
Data ">FW0g2>0@FF0@FH0>FD0>FI0>FH0>Fr0@FE0AFT0g2?0>FH0>FH0>FE0>FI0>FH0>Fu0>F"
Data "D0>F>0>FS0g5>0@FG0>FG0>FF0>FJ0>FG0>Fr0AFD0>F>0>FS0g3=0>F>0>FF0>FF0>FG0"
Data ">FJ0>FG0>Fq0>F>0>FD0>F>0>FS0g3>F@0>FE0>FE0>FH0>FK0>FF0>Fq0>F>0>FD0>F>0"
Data ">FS0g3>F@0>FE0>FE0DFB0>FK0>FF0>Fr0AFD0AFT0g3f0>FW0>Fœ0g3f0?FU0?FU0CF|0"
Data "=3=2=3?2=3=2?3=2=3?2=3=2?3=2=3?2=3=2?3=2=3?2=3=2?3=2=3!e0?2?3C2?3C2?3C2"
Data "?3C2!e0=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2=3!e0=2C3?2"
Data "C3?2C3?2C3?2>3N0>FS0>FU0>FH0>FH0>FH0>FH0>Fe0=2C3=2=3=2C3=2=3=2C3=2=3=2"
Data "C3=2=3=2>3N0>FR0>FV0>Fd0>FH0>Fe0=2C3?2C3?2C3?2C3?2>3N0>FR0>FV0>Fd0>FH0"
Data ">Fe0=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2=3=0@FF0AFE0@F"
Data "E0?FH0AFD0AFE0>FH0>FH0>F=0>FE0>FH0CFR0>2A3>2=3>2A3>2=3>2A3>2=3>2A3>2=3"
Data ">2=3>F>0>FD0>F>0>FD0>F>0>FD0>FH0>F>0>FD0?F=0>FD0>FH0>FH0@FF0>FH0>F=0>F"
Data "=0>FQ0=3=2A3=2?3=2A3=2?3=2A3=2?3=2A3=2?3=2=3>FH0>F>0>FD0BFD0>FH0>F>0>F"
Data "D0>F>0>FD0>FH0>FH0?FG0>FH0>F=0>F=0>FQ0=3?2=3?2?3?2=3?2?3?2=3?2?3?2=3?2"
Data "?3>2>FH0>F>0>FD0>FH0>FH0>F>0>FD0>F>0>FD0>FH0>FH0@FF0>FH0>F=0>F=0>FQ0g3"
Data ">F>0>FD0>F>0>FD0>F>0>FD0>FH0>F>0>FD0>F>0>FD0>FH0>FH0>F=0>FE0>FH0>F=0>F"
Data "=0>FQ0g3=0@FF0AFE0@FE0>FI0AFD0>F>0>FD0>FH0>FH0>F>0>FD0>FH0>F=0>F=0>FQ0"
Data "g3x0>F`0>F0g3t0AFa0>F0g3!e0K3Q6=C=E=7@3!e0J2=7T6=C=7>2!Q0@5?0C2B0J2X6"
Data "=7!Q0@5?0C2B0I2=7?6=D=6=DS60>F{0@5?0C4B0I4?6=D=6=D=6?D=6>D>6=DJ60>F{0"
Data "@5?0C4B0H4=7Z6AFF0@FE0AFF0AFD0?FH0?FF0?FG0>F>0>FD0>F>0>FD0>F=0>F=0>FB0"
Data ">F=0>F@0@5?0C9B0H9[6?F=0>FD0>F>0>FD0>F>0>FD0>F>0>FD0>FH0>F=0>FE0>FH0>F"
Data ">0>FD0>F>0>FD0>F=0>F=0>FB0>F=0>F@0@2?0C4B0G4=7?6MD=6=D=6=D=6=DA6>F>0>F"
Data "D0>F>0>FD0>F>0>FD0>F>0>FD0>FI0>FG0>FH0>F>0>FE0@FE0DFC0?FA0@2?0C4B0G4\6"
Data ">F>0>FD0>F>0>FD0>F>0>FD0>F>0>FD0>FJ0>FF0>FH0>F>0>FE0@FE0DFC0?FA0@2?0C4"
Data "B0F4=7?6ED=6?D=6ED=6=D@6>F>0>FD0>F>0>FD0>F>0>FD0>F>0>FD0>FH0>F=0>FE0>F"
Data "H0>F=0?FF0>FG0>F>0>FC0>F=0>F@0@2?0C4B0F4]6>F>0>FE0@FE0AFF0AFD0>FI0?FG0"
Data ">FH0AFF0>FG0>F>0>FC0>F=0>F@0@5?0C4B0E4=7?6=D>6=D=6HD=6BD=6=D@6X0>FL0>F"
Data "¡0@3?0C4B0E4^6X0>FL0>F¡0@3?0C4B0D4=7?6=D>6>D=6BD=6>D=6?D=6?DD6!Q0@3?0C4"
Data "B0D4_6!Q0@3?0C4B0C4=7_6Z0>FT0>F—0=7?3?0C4B0C4@6?D=6=D=6?D=6>D=6=D>6>D=6"
Data "@D=6=D=6=DA6Y0>FG0>FI0>FU0=7I0=7>0=7G0=7>0=7G0=7H0>7B0=E=2=3=2?0C4B0B4"
Data "=7`6Y0>FG0>FI0>FH0?F=0>FC0=7I0=7>0=7G0=7>0=7F0?7F0=7>0=7>0=7>0=6>2=3?0"
Data "C4B0B4@6=D=6ED=6>D=6@D>6ADC6Y0>FG0>FI0>FG0>F=0?FD0=7I0=7>0=7F0B7D0=7=0"
Data "=7=0=7F0>7>0=7?0=6=7>3?0C4B0A4=7a6=0>F=0>FD0AFF0>FG0>FI0>FU0=7X0=7>0=7"
Data "E0=7=0=7K0=7@0=6=E>3?0C4B0A4@6=D=6@D=6=D>6=D>6?DN6=0>F=0>FG0>FE0>FH0>F"
Data "J0>FT0=7X0=7>0=7F0>7J0=7A0>6>3?0C4B0@4=7b6=0>F=0>FF0>FG0>FG0>FI0>FU0=7"
Data "X0=7>0=7G0>7H0=7B0>6=7=3?0C4B0@4c6=0>F=0>FE0>FH0>FG0>FI0>FU0=7W0B7F0=7"
Data "=0=7F0=7>0>7?0=D>6=3?0C4B0?4=7c6>0?FE0>FI0>FG0>FI0>Fr0=7>0=7E0=7=0=7=0"
Data "=7E0=7>0=7>0=7>0=D>6=2?0C4B0?4d6>0>FF0AFF0>FG0>FI0>FU0=7X0=7>0=7F0?7J0"
Data ">7?0=6=D=6=7?0C4B0>4=7d6>0>FV0>FF0>FH0>F‚0=7P0=D>6=7?0B4=3B0>4=7d6?F!N0"
Data "=D>6=E?0B4=3B0>4=7_EA6!Q0=6=D=6=E?0B4=3B0>4=7bE>6!Q0=6=D=6=E?0B4=3B0>4"
Data "=7dE!Q0@6?0B4=3B0>4=7dE=0=7H0=7J0=7H0=7’0=7G0?7A0=D?6?0B4=3B0=4=2=7dE=7"
Data "=0=7G0=7I0=7J0=7H0=7=0=7‚0=7F0=7?0=7@0=D?6?0B4=3B0=4=2eE=7=0=7G0=7I0=7"
Data "J0=7I0=7ƒ0=7F0=7?0=7@0=6=D>6?0B4=3B0>2cE>3=0=7V0=7J0=7H0=7=0=7I0=7s0=7"
Data "G0=7?0=7@0=D?6?0B4=3B0c2@3=0=7V0=7J0=7X0=7s0=7G0=7?0=7@0=6=D>6?0B4=3B0"
Data "=4c2?3=7=0=7=0=7S0=7J0=7V0A7S0>7W0=7H0=7?0=7@0=D?6?0C4B0`4C2=7>0=7T0=7"
Data "J0=7X0=7r0=7H0=7?0=7@0=D?6?0C4B0g4=7>0=7T0=7J0=7X0=7q0=7I0=7?0=7@0=6=D"
Data ">6?0C5B0g5=0>7=0=7S0=7J0=7e0=7V0=7I0=7J0?7A0=6=D>6?0C5B0g5X0=7J0=7d0=7"
Data "|0@6?0C5B0g5Y0=7H0=7¦0@6?0C5B0g5!Q0@6?0C5B0g5!Q0@6?0C2B0g2!Q0@6?0C2B0g2"
Data ">0=7H0?7G0?7I0=7F0A7F0?7F0A7F0?7G0?7]0@6?0C2B0g2?7G0=7?0=7E0=7?0=7G0>7"
Data "F0=7I0=7?0=7I0=7E0=7?0=7E0=7?0=7\0@6?0C2B0g2>0=7K0=7I0=7G0>7F0=7I0=7L0"
Data "=7F0=7?0=7E0=7?0=7\0@6?0C5B0g5>0=7K0=7I0=7F0=7=0=7F0@7F0=7L0=7F0=7?0=7"
Data "E0=7?0=7E0=7J0=7C0=E?6?0C3B0g3>0=7J0=7H0>7G0=7=0=7F0=7?0=7E0@7H0=7H0?7"
Data "G0@7\0=E?6?0C3B0g3>0=7I0=7K0=7E0=7>0=7J0=7E0=7?0=7G0=7G0=7?0=7I0=7\0=E"
Data "?6?0C3B0g3>0=7H0=7L0=7E0A7I0=7E0=7?0=7F0=7H0=7?0=7I0=7\0>E>6?0C3B0g3>0"
Data "=7G0=7I0=7?0=7H0=7F0=7?0=7E0=7?0=7F0=7H0=7?0=7E0=7?0=7\0?E=6?0C3B0g3>0"
Data "=7G0A7F0?7I0=7G0?7G0?7G0=7I0?7G0?7F0=7J0=7C0?E=6?0>3=2=3?2B0=3=2=3?2=3"
Data "=2?3=2=3?2=3=2?3=2=3?2=3=2?3=2=3?2=3=2?3=2=3!H0=7D0?E=6?0@2?3B0?2?3C2?3"
Data "C2?3C2?3C2!Q0@E?0=2=3=2@3B0=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2"
Data "=3=2=3=2=3!Q0@E?0>2A3B0=2C3?2C3?2C3?2C3?2>3!Q0@E?0=3=2A3B0=2C3=2=3=2C3"
Data "=2=3=2C3=2=3=2C3=2=3=2>3!Q0@E?0>2A3B0=2C3?2C3?2C3?2C3?2>3g0?7I0@7F0=7F0"
Data "@7G0@7E0@7F0A7E0A7@0@E?0=2=3=2@3B0=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2"
Data "=3=2A3=2=3=2=3=2=3f0=7?0=7F0>7@0>7D0=7F0=7?0=7E0=7@0=7D0=7?0=7E0=7I0=7"
Data "D0@E?0=3>2@3B0>2A3>2=3>2A3>2=3>2A3>2=3>2A3>2=3>2=3?0=7T0=7M0=7F0=7B0=7"
Data "C0=7=0=7E0=7?0=7E0=7I0=7@0=7D0=7I0=7D0@E?0>3=2@3B0=3=2A3=2?3=2A3=2?3=2"
Data "A3=2?3=2A3=2?3=2=3>0=7V0=7L0=7E0=7?0?7>0=7B0=7=0=7E0=7?0=7E0=7I0=7@0=7"
Data "D0=7I0=7D0=3?E?0>3?2=3=2B0=3?2=3?2?3?2=3?2?3?2=3?2?3?2=3?2?3>2=0=7H0A7"
Data "G0=7J0=7F0=7>0=7>0=7>0=7A0=7?0=7D0@7F0=7I0=7@0=7D0@7F0@7A0@3?0C3B0g3=7"
Data "Z0=7H0=7G0=7>0=7>0=7>0=7A0=7?0=7D0=7?0=7E0=7I0=7@0=7D0=7I0=7D0=2?3?0C3"
Data "B0g3=0=7H0A7G0=7I0=7G0=7?0>7=0?7A0A7D0=7?0=7E0=7I0=7@0=7D0=7I0=7D0=1=2"
Data ">3?0C3B0g3>0=7V0=7W0=7H0=7A0=7C0=7?0=7E0=7@0=7D0=7?0=7E0=7I0=7D0=3=1>2"
Data "?0C3B0g3?0=7T0=7K0=7H0>7G0=7A0=7C0@7G0@7E0@7F0A7E0=7D0=4?3?0C3B0g3w0A7"
Data "‘0?4=3?0C3B0K3Q6=C=E=7@3!Q0@4?0C2B0J2=7T6=C=7>2!Q0@5?0C2B0J2X6=7!Q0@5?0"
Data "C2B0I2=7?6=D=6=DS6!Q0@5?0C4B0I4?6=D=6=D=6?D=6>D>6=DJ6=0@7E0=7@0=7D0=7L0"
Data "=7F0=7?0=7E0=7I0=7A0=7C0=7@0=7E0@7E0A7F0@7@0@5?0C4B0H4=7Z6=7@0=7D0=7@0"
Data "=7D0=7L0=7F0=7>0=7F0=7I0=7A0=7C0>7?0=7D0=7@0=7D0=7@0=7D0=7@0=7?0@5?0C9"
Data "B0H9[6=7I0=7@0=7D0=7L0=7F0=7=0=7G0=7I0>7?0>7C0>7?0=7D0=7@0=7D0=7@0=7D0"
Data "=7@0=7?0@2?0?4@3B0G4=7?6MD=6=D=6=D=6=DA6=7I0=7@0=7D0=7L0=7F0>7H0=7I0>7"
Data "?0>7C0=7=0=7>0=7D0=7@0=7D0=7@0=7D0=7@0=7?0@2?0?4@3B0G4\6=7>0?7D0B7D0=7"
Data "L0=7F0>7H0=7I0=7=0=7=0=7=0=7C0=7=0=7>0=7D0=7@0=7D0A7E0=7@0=7?0@2?0?4@3"
Data "B0F4=7?6ED=6?D=6ED=6=D@6=7@0=7D0=7@0=7D0=7L0=7F0=7=0=7G0=7I0=7=0=7=0=7"
Data "=0=7C0=7>0=7=0=7D0=7@0=7D0=7I0=7@0=7?0@2?0?4@3B0F4]6=7@0=7D0=7@0=7D0=7"
Data "I0=7>0=7F0=7>0=7F0=7I0=7>0=7>0=7C0=7?0>7D0=7@0=7D0=7I0=7>0=7=0=7?0@5?0"
Data "?4@3B0E4=7?6=D>6=D=6HD=6BD=6=D@6=7?0>7D0=7@0=7D0=7I0=7>0=7F0=7?0=7E0=7"
Data "I0=7>0=7>0=7C0=7?0>7D0=7@0=7D0=7I0=7?0>7?0@3?0?4@3B0E4^6=0?7=0=7D0=7@0"
Data "=7D0=7J0>7G0=7@0=7D0A7E0=7A0=7C0=7@0=7E0@7E0=7J0@7@0@3?0?4@3B0D4=7?6=D"
Data ">6>D=6BD=6>D=6?D=6?DD6!M0=7?0@3?0>4A3B0D4_6!Q0@3?0>4A3B0C4=7_6!Q0@3?0>4"
Data "A3B0C4@6?D=6=D=6?D=6>D=6=D>6>D=6@D=6=D=6=DA6!Q0=3=2=3=2?0>4A3B0B4=7`6!Q0"
Data "?2=3?0>4A3B0B4@6=D=6ED=6>D=6@D>6ADC6A7F0?7F0A7E0=7@0=7D0=7A0=7C0=7E0=7"
Data "?0=7A0=7C0=7A0=7C0C7C0>7H0=7D0=3=2>3?0>4A3B0A4=7a6=7@0=7D0=7?0=7G0=7G0"
Data "=7@0=7D0=7A0=7C0=7E0=7?0=7A0=7C0=7A0=7I0=7C0=7I0=7D0=2?3?0>4A3B0A4@6=D"
Data "=6@D=6=D>6=D>6?DN6=7@0=7D0=7K0=7G0=7@0=7E0=7?0=7E0=7?0=7?0=7A0=7?0=7E0"
Data "=7?0=7I0=7D0=7I0=7D0=2?3?0>4A3B0@4=7b6=7@0=7D0=7K0=7G0=7@0=7E0=7?0=7E0"
Data "=7?0=7?0=7B0=7=0=7G0=7=0=7I0=7E0=7J0=7C0=2?3?0=4B3B0@4c6A7F0?7H0=7G0=7"
Data "@0=7E0=7?0=7E0=7?0=7?0=7C0=7I0=7I0=7F0=7J0=7C0=3=2>3?0=4B3B0?4=7c6=7@0"
Data "=7H0=7G0=7G0=7@0=7F0=7=0=7G0=7=0=7=0=7=0=7C0=7=0=7H0=7H0=7G0=7K0=7B0>2"
Data ">3?0=4B3B0?4d6=7@0=7H0=7G0=7G0=7@0=7F0=7=0=7G0=7=0=7=0=7=0=7B0=7?0=7G0"
Data "=7G0=7H0=7K0=7B0=3=2>3?0=4B3B0>4=7d6=7@0=7D0=7?0=7G0=7G0=7@0=7G0=7I0=7"
Data "?0=7B0=7A0=7F0=7F0=7I0=7L0=7A0=3?2?0=4B3B0>4=7d6=7@0=7E0?7H0=7H0@7H0=7"
Data "I0=7?0=7B0=7A0=7F0=7F0C7C0=7L0=7A0@3?0=4B3B0>4=7_EA6º0=7R0@3?0=4B3B0>4"
Data "=7bE>6º0>7Q0@3?0=4B3B0>4=7dE!Q0=E?3?0C3B0>4=7dE!Q0=E=7>3?0C3B0=4=2=7dE"
Data "L0=7!@0=6=E>3?0C3B0=4=2eE>7I0=7=0=7T0=7W0=7[0=7T0=7Q0>6=7=2?0C3B0>2cE>3"
Data "=0=7H0=7?0=7T0=7V0=7[0=7S0=7R0>6=E=2?0C3B0c2@3=0=7€0=7[0=7S0=7R0>6=E=7"
Data "?0C4B0=4c2?3=0=7s0?7F0@7G0?7G0@7F0?7F0>7I0@7@0>6=E=7?0C4B0`4C2=0=7v0=7"
Data "E0=7?0=7E0=7?0=7E0=7?0=7E0=7?0=7E0=7I0=7?0=7@0?6=7?0C4B0g4=0=7s0@7E0=7"
Data "?0=7E0=7I0=7?0=7E0A7E0=7I0=7?0=7@0?6=7x0=7r0=7?0=7E0=7?0=7E0=7I0=7?0=7"
Data "E0=7I0=7I0=7?0=7@0?6=7x0=7r0=7?0=7E0=7?0=7E0=7?0=7E0=7?0=7E0=7?0=7E0=7"
Data "I0=7?0=7@0?6=7?0j5G0=7s0@7E0@7G0?7G0@7F0?7F0=7J0@7@0?6=7?0j5G0=7!J0=7@0"
Data "?6=7?0j5F0>7V0B7¦0@7A0?6=7?0j5![0?6=7?0j5![0?6=7?0j2![0?6=7?0j2F0=7I0=7"
Data "I0=7I0=7I0=7˜0?6=7?0j2F0=7e0=7I0=7˜0?6=7?0j2F0=7e0=7I0=7˜0?6=7?0j5F0=7"
Data "=0>7F0=7I0=7I0=7>0=7F0=7I0?7=0>7D0=7=0>7G0?7F0@7G0@7E0>7C0?6=7?0j3F0>7"
Data ">0=7E0=7I0=7I0=7=0=7G0=7I0=7>0=7>0=7C0>7>0=7E0=7?0=7E0=7?0=7E0=7?0=7E0"
Data "=7D0?6=7?0j3F0=7?0=7E0=7I0=7I0>7H0=7I0=7>0=7>0=7C0=7?0=7E0=7?0=7E0=7?0"
Data "=7E0=7?0=7E0=7D0=E>6=7?0j3F0=7?0=7E0=7I0=7I0=7=0=7G0=7I0=7>0=7>0=7C0=7"
Data "?0=7E0=7?0=7E0=7?0=7E0=7?0=7E0=7D0>E=6=7?0j3F0=7?0=7E0=7I0=7I0=7>0=7F0"
Data "=7I0=7>0=7>0=7C0=7?0=7E0=7?0=7E0=7?0=7E0=7?0=7E0=7D0>E=6=7?0j3F0=7?0=7"
Data "E0=7I0=7I0=7?0=7E0=7I0=7>0=7>0=7C0=7?0=7F0?7F0@7G0@7E0=7D0?E=7?0?2=3=2"
Data "?3=2=3?2=3=2?3=2=3?2=3=2?3=2=3?2=3=2?3=2=3?2=3=2=3b0=70=7M0=7N0?E=7?0"
Data "?3C2?3C2?3C2?3C2?3?2b0=70=7M0=7N0?E=7?0@3=2=3=2=3=2A3=2=3=2=3=2A3=2=3"
Data "=2=3=2A3=2=3=2=3=2A3=2=3![0?E=7?0A3?2C3?2C3?2C3?2C3=2![0?E=7?0A3=2=3=2"
Data "C3=2=3=2C3=2=3=2C3=2=3=2C3=2¸0=7U0=7D0?E=7?0A3?2C3?2C3?2C3?2C3=2·0=7H0"
Data "=7J0=7C0?E=7?0@3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3=2=3=2A3=2=3T0"
Data "=7ž0=7H0=7J0=7C0?E=7?0@3>2=3>2A3>2=3>2A3>2=3>2A3>2=3>2A3>2T0=7ž0=7H0=7"
Data "J0=7C0=E>3=7?0@3=2?3=2A3=2?3=2A3=2?3=2A3=2?3=2A3=2=3G0>7G0>7H0=7?0=7E0"
Data "=7?0=7E0=7>0=7>0=7C0=7>0=7G0=7>0=7E0@7G0=7H0=7J0=7C0=2?3?0=2=3?2?3?2=3"
Data "?2?3?2=3?2?3?2=3?2?3?2=3?2=3F0=7>0=7F0=7I0=7?0=7E0=7?0=7E0=7>0=7>0=7C0"
Data "=7>0=7G0=7>0=7H0=7F0=7I0=7K0=7B0>2>3?0j3G0=7H0=7I0=7?0=7F0=7=0=7F0=7=0"
Data "=7=0=7=0=7D0>7H0=7>0=7G0=7H0=7H0=7J0=7C0>1>3?0j3H0=7G0=7I0=7?0=7F0=7=0"
Data "=7F0=7=0=7=0=7=0=7D0>7H0=7>0=7F0=7I0=7H0=7J0=7C0@3?0j3F0=7>0=7F0=7I0=7"
Data ">0>7G0=7H0=7?0=7D0=7>0=7H0>7F0=7J0=7H0=7J0=7C0@3?0j3G0>7H0=7I0>7=0=7G0"
Data "=7H0=7?0=7D0=7>0=7H0=7G0@7G0=7H0=7J0=7C0@4?0j3œ0=7W0=7G0=7I0=7K0A3=7=E"
Data "S6L3š0>7‚0?2=7V6=7K2!b0=2=7>E>6?D=6@D=6=D=6=D=6=D=6CD?6K2!b0=7?E=6=DU6"
Data "=7I2=5!b0=7?E>6@D>6?D=6?D=6>D>6>D=6?D>6J4T0?8G0?8E0=8E0=8C0?8G0?8A0=8F0"
Data "?8=0=8G0=8?0?8A0=8A0=8>0=8W0=7=E=C=EX6=7I4G0>7>0=7D0=8=0=8G0=8=0=8E0=8"
Data "E0=8C0=8=0=8G0=8=0=8A0=8F0=8K0=8?0=8=0=8A0=8A0=8>0=8W0=7>C=E>6>D=6>D=6"
Data "=D?6GD=6=D=6=D>6I9F0=7>0>7E0=8=0=8=0=8=0=8=0?8?0=8?0?8=0?8=0>8=0>8=0?8"
Data "=0=8=0?8?0=8=0=8=0?8=0?8?0=8?0?8=0=8=0?8=0>8?0=8?0=8=0=8=0=8=0?8=0?8?0"
Data "=8=0=8=0?8=0=8=0?8=0>8=0>8=0?8R0=7>C=E=6=DW6=7H4T0>8>0=8=0=8=0=8=0=8?0"
Data "=8?0=8=0=8=0=8=0=8=0=8>0=8>0=8=0=8=0=8=0=8A0?8=0=8=0=8=0=8=0=8?0=8?0=8"
Data "=0=8=0=8=0=8=0=8=0=8@0>8>0=8=0=8=0=8=0=8=0=8=0=8=0=8?0?8?0=8=0=8=0=8=0"
Data "=8=0=8>0=8>0=8=0=8R0=7>C=E>6?D=6>D=6>DO6H4T0=8=0=8=0=8=0=8=0=8=0=8?0=8"
Data "?0=8=0=8=0=8=0=8=0=8>0=8>0=8=0=8=0=8=0?8?0=8?0?8=0=8=0=8?0=8?0=8=0=8=0"
Data "=8=0=8=0=8=0=8@0=8?0=8>0=8>0?8=0=8=0=8?0=8?0?8=0=8=0?8=0=8>0=8>0?8R0=7"
Data ">C=E=6=DX6=7G4T0=8=0=8=0=8=0=8=0=8=0=8?0=8=0=8=0=8=0=8=0=8=0=8=0=8>0=8"
Data ">0=8=0=8=0=8?0=8?0=8?0=8?0=8=0=8?0=8=0=8=0=8=0=8=0=8=0=8=0=8=0=8@0=8?0"
Data "=8=0=8=0=8=0=8?0=8=0=8?0=8?0=8=0=8=0=8=0=8?0=8>0=8>0=8T0=7>C=E[6G4T0=8"
Data "=0=8=0?8=0=8=0=8?0?8=0?8=0=8=0=8=0>8=0=8>0?8=0=8=0?8?0=8?0?8=0=8=0=8?0"
Data "?8=0?8=0=8=0?8=0=8@0=8?0=8=0=8=0=8=0?8=0?8?0=8?0?8=0=8=0?8=0>8=0>8=0?8"
Data "R0=7>C=E>6CD=6@D>6>D>6>D=6>D=6?D>6=7F4!b0=7>C=E=6=DZ6F4!b0=7>C=E?6=D=6"
Data "LD=6>D=6>D=6=D?6=7E4T0?8=0=8S0=8?0=8C0>8K0=8H0>8J0?8J0=8=0=8E0=8V0=7>C"
Data "=E]6E4T0=8=0=8=0=8S0=8?0=8C0=8=0=8V0=8=0=8J0=8=0=8J0=8G0=8V0=7>C=E>6>D"
Data "=6HD=6AD=6=D>6>D=6=D>6=7D4T0=8?0?8=0?8=0?8=0?8=0?8=0?8=0?8=0=8=0?8?0=8"
Data "=0=8=0>8=0?8=0=8=0=8=0=8=0=8=0?8=0?8?0=8=0=8=0>8=0?8=0?8?0=8?0?8=0?8=0"
Data ">8=0?8=0=8=0?8=0?8=0>8=0?8=0?8M0=7>C=E^6D4T0=8?0=8=0=8?0=8=0=8=0=8=0=8"
Data "=0=8=0=8=0=8?0=8=0=8=0=8=0=8=0=8=0=8?0=8=0=8=0=8@0=8=0=8=0=8=0=8=0=8=0"
Data "=8=0=8=0=8=0=8?0?8=0=8>0=8=0=8?0=8?0=8?0=8=0=8=0=8=0=8=0=8>0=8=0=8=0=8"
Data "=0=8=0=8?0=8=0=8>0=8=0=8=0=8O0=7>C=E?6>D=6>D=6>DS6=7C4T0=8?0=8=0=8=0?8"
Data "=0=8=0=8=0=8=0=8=0?8=0?8=0=8=0=8=0=8=0?8?0=8=0=8=0=8>0?8=0=8=0=8=0=8=0"
Data "=8=0=8=0=8=0=8=0=8?0=8=0=8=0=8>0?8=0?8?0=8?0=8=0=8=0=8=0=8=0=8>0=8=0=8"
Data "=0=8=0=8=0=8=0?8=0=8>0?8=0?8M0=7>C=E>6=D\6C4T0=8=0=8=0=8=0=8=0=8=0=8=0"
Data "=8=0=8=0=8=0=8=0=8?0=8=0=8=0=8=0=8=0=8=0=8A0=8=0=8=0=8>0=8=0=8=0=8=0=8"
Data "=0=8=0=8=0=8=0=8=0=8=0=8?0=8=0=8=0=8>0=8?0=8=0=8?0=8=0=8=0=8=0=8=0=8=0"
Data "=8=0=8>0=8=0=8=0=8=0=8=0=8=0=8=0=8=0=8>0=8A0=8M0=7>C=E_6=7B4T0?8=0=8=0"
Data "=8=0?8=0=8=0=8=0?8=0?8=0?8=0?8=0=8=0?8?0>8>0=8>0?8>0=8=0=8>0=8=0=8=0=8"
Data "=0?8?0=8=0=8=0=8>0?8=0?8?0?8=0?8=0?8=0=8>0?8=0=8=0=8=0=8=0?8=0>8=0?8=0"
Data "?8M0=7>C=ED6>D=6=D>6=DA6=D=6=D=6>D?6=DB6B4f0=8j0=8ˆ0=7>C>EB6>D=6>D=6?D"
Data "=6?D=6@D=6=D=6?DA6=7A4d0>8i0>8‰0=7>C>E`6A4T0?8C0=8E0?8C0?8C0=8=0=8C0?8"
Data "C0?8C0?8C0?8C0?8m0=7>C>E`6=7@4T0=8=0=8C0=8G0=8E0=8C0=8=0=8C0=8E0=8G0=8"
Data "C0=8=0=8C0=8=0=8m0=7>C>Ea6@4T0=8=0=8C0=8G0=8E0=8C0=8=0=8C0=8E0=8G0=8C0"
Data "=8=0=8C0=8=0=8m0=7=E=C>Ea6=7?4T0=8=0=8C0=8E0?8C0?8C0?8C0?8C0?8D0=8D0?8"
Data "C0?8m0=7=E=C>Ea6=7?4T0=8=0=8C0=8E0=8G0=8E0=8E0=8C0=8=0=8D0=8D0=8=0=8E0"
Data "=8m0=7=E=C>E=6`E=7?4T0=8=0=8C0=8E0=8G0=8E0=8E0=8C0=8=0=8D0=8D0=8=0=8E0"
Data "=8m0=7eE=7?4T0?8C0=8E0?8C0?8E0=8C0?8C0?8D0=8D0?8C0?8m0=7eE=7?4!b0=7eE=7"
Data "?4!b0=7eE=7=2>4!b0=3fE=2>4!b0?3dE>2=4!b0B3c2=4!b0=3A2c3=4!b0E3a4!b0j4#1B2#0"

Sub DrawBOX (x, y, xx, yy, FlipFLOP)
    Colr1 = 15: Colr2 = 8
    If FlipFLOP Then Colr1 = 8: Colr2 = 15
    Line (x, y)-(xx, yy), 7, BF
    Line (x, y)-(xx, yy), Colr1, B
    Line (xx, y)-(xx, yy), Colr2
    Line (x, yy)-(xx, yy), Colr2
End Sub

Sub Interval (Length!)
    StartTIME! = Timer
    Do
        If Timer < StartTIME! Then Exit Do
    Loop While Timer < StartTIME! + Length!
End Sub

Sub PrintSTRING (x, y, Prnt$, Font)

    Offset = Font * 4700 '3 fonts in 1 array with 4700 offset
    For n = 1 To Len(Prnt$)
        Char$ = Mid$(Prnt$, n, 1)
        If Char$ = " " Or Char$ = Chr$(255) Then
            x = x + 3 'FontBOX(Offset + 1)
        Else
            Index = (Asc(Char$) - 33) * FontBOX(Offset) + 2 + Offset
            Put (x, y), FontBOX(Index)
            x = x + FontBOX(Index)
        End If
    Next n

End Sub
