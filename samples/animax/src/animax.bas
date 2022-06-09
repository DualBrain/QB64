'*****************************************************************************
'-------------------------- A N I M A X ! . B A S ----------------------------
'---------------------- A Graphics/Animation Utility -------------------------
'------------ Copyright (C) 2001-2007 by Bob Seguin (Freeware) ---------------
'*****************************************************************************

DefInt A-Z

DECLARE FUNCTION InitMOUSE ()
DECLARE FUNCTION CancelBOX ()
DECLARE FUNCTION SavePROMPT ()

DECLARE SUB MouseSTATUS (LB, RB, MouseX, MouseY)
DECLARE SUB ShowMOUSE ()
DECLARE SUB HideMOUSE ()
DECLARE SUB LocateMOUSE (x, y)
DECLARE SUB PauseMOUSE (LB, RB, MouseX, MouseY)
DECLARE SUB ClearMOUSE ()
DECLARE SUB MouseDRIVER (LB, RB, Mx, My)
DECLARE SUB PrintSTRING (x, y, Prnt$, Font)
DECLARE SUB DrawSCREEN ()
DECLARE SUB LoadFILE ()
DECLARE SUB SetRECENT (Mode)
DECLARE SUB MenuBAR (InOUT)
DECLARE SUB ToolBAR ()
DECLARE SUB AniFILE (MenuITEM)
DECLARE SUB AniEDIT (MenuITEM)
DECLARE SUB AniCOLOR (MenuITEM)
DECLARE SUB AniSPECIAL (Trick)
DECLARE SUB AniHELP (OnWHAT)
DECLARE SUB WorkAREA ()
DECLARE SUB RunBUTTONS ()
DECLARE SUB LogoFRAME (Frame)
DECLARE SUB ColorBAR ()
DECLARE SUB DisplayERROR (ErrorNUM)
DECLARE SUB DisplayFRAMES ()
DECLARE SUB Interval (Length!)
DECLARE SUB PrintBLURB ()
DECLARE SUB PrintFRAME ()
DECLARE SUB SetXY ()
DECLARE SUB ScaleFRAME ()
DECLARE SUB ScaleUP ()
DECLARE SUB DrawBOX (x1, y1, x2, y2, Mode)

'$DYNAMIC
Dim Shared Box(1 To 26217)
Dim Shared WindowBOX(18800)
Dim Shared FontBOX(4700)
Dim Shared TitleBOX(122)
Dim Shared CopyBOX(1 To 1650)
Dim Shared UndoBOX(1 To 1650)
Dim Shared ItemBOX(1 To 366)
Dim Shared PaletteITEM(1 To 312)
Dim Shared ColorBOX(1 To 672)
Dim Shared ToolBOX(1 To 12)
Dim Shared FBox(1 To 5)
Dim Shared MenuBOX(280)
Dim Shared FChar(1 To 124)
Dim Shared FileNAME$, PrintNAME$
Dim Shared Workdone, Scale, Blurb, WClr
Dim Shared Menu, WorkingTOOL, ExTOOL, Filled
Dim Shared FrameCOUNT, FrameNUM
Scale = 5: ExTOOL = 1

Type RecentTYPE
    PName As String * 8
    FName As String * 130
End Type
Dim Shared Recent(1 To 6) As RecentTYPE
Open "recent.axd" For Random As #1 Len = Len(Recent(1))
For n = 1 To 6
    Get #1, n, Recent(n)
Next n

Def Seg = VarSeg(FontBOX(0))
BLoad "animssr.fnt", VarPtr(FontBOX(0))
Def Seg = VarSeg(ColorBOX(1))
BLoad "anihues.bsv", VarPtr(ColorBOX(1))
Def Seg

Dim Shared MouseDATA$

'Create and load MouseDATA$ for CALL ABSOLUTE routines
Data 55,89,E5,8B,5E,0C,8B,07,50,8B,5E,0A,8B,07,50,8B,5E,08,8B
Data 0F,8B,5E,06,8B,17,5B,58,1E,07,CD,33,53,8B,5E,0C,89,07,58
Data 8B,5E,0A,89,07,8B,5E,08,89,0F,8B,5E,06,89,17,5D,CA,08,00
MouseDATA$ = Space$(57)
For i = 1 To 57
    Read h$
    Hexxer$ = Chr$(Val("&H" + h$))
    Mid$(MouseDATA$, i, 1) = Hexxer$
Next i

Moused = InitMOUSE
If Not Moused Then
    Print "Sorry, cat must have got the mouse."
    Sleep 2
    Close #1
    System
End If

Restore xDATA
For n = 1 To 12: Read ToolBOX(n): Next n
Restore yDATA
For n = 1 To 5: Read FBox(n): Next n

On Error GoTo PathPROB

Screen 12
DrawSCREEN
GoSub Clock
On Timer(1) GoSub Clock
Timer On
ShowMOUSE

Do
    MouseSTATUS LB, RB, MouseX, MouseY
    Select Case MouseY
        Case 0 TO 15
            Select Case MouseX
                Case 623 TO 639
                    If LB = -1 Then
                        HideMOUSE
                        DrawBOX 624, 2, 638, 15, 1
                        ShowMOUSE
                        Interval .1
                        HideMOUSE
                        DrawBOX 624, 2, 638, 15, 0
                        ShowMOUSE
                        Interval .1
                        ExitPROMPT = 10
                        AniFILE ExitPROMPT
                        If ExitPROMPT <> 11 Then Close #1: System
                    End If
                Case Else
                    If Menu Then MenuBAR 0
            End Select
        Case 16 TO 45
            Select Case MouseX
                Case 7 TO 236: MenuBAR 1
                Case 245 TO 600: ToolBAR
                Case Else: If Menu Then MenuBAR 0
            End Select
        Case 57 TO 57 + Scale * 68 - 1
            Select Case MouseX
                Case 167 TO 167 + Scale * 90 - 1
                    WorkAREA
                Case Else
                    If Menu Then MenuBAR 0
            End Select
        Case 400 TO 444
            Select Case MouseX
                Case 0 TO 145: RunBUTTONS
                Case 200 TO 632: ColorBAR
                    If Menu Then MenuBAR 0
                Case Else
                    If Menu Then MenuBAR 0
            End Select
        Case Else
            If Menu Then MenuBAR 0
    End Select

    If Started = 0 Then
        Do
            PauseMOUSE LB, RB, MouseX, MouseY
            Out &H3C7, 0
            For n = 9 To 56
                Box(n) = Inp(&H3C9)
            Next n
            FrameCOUNT = 1
            Box(57) = FrameCOUNT
            HideMOUSE
            Line (30, 194)-(119, 261), 15, BF
            Line (166, 56)-(615, 395), 15, BF
            Get (30, 194)-(119, 261), Box(58)
            FrameNUM = 1
            PrintFRAME
            ShowMOUSE
            Started = 1
            Exit Do
        Loop
    End If

Loop

Close #1
System

Clock:
Hour$ = Mid$(Time$, 1, 2)
If Val(Hour$) >= 12 Then APM$ = " PM" Else APM$ = " AM"
Hour$ = LTrim$(RTrim$(Str$(Val(Hour$) Mod 12)))
If Val(Hour$) = 0 Then Hour$ = "12"
Minute$ = Mid$(Time$, 4, 2)
HideMOUSE
If Hour$ <> OldHOUR$ Then
    Line (566, 456)-(622, 471), 7, BF
    If Len(Hour$) = 2 Then
        PrintSTRING 569, 459, "1", 1
        PrintSTRING 575, 459, Mid$(Hour$, 2, 1), 1
    Else
        PrintSTRING 575, 459, Hour$, 1
    End If
    PrintSTRING 583, 458, ":", 1
    PrintSTRING 599, 459, APM$, 1
    OldHOUR$ = Hour$
End If
Line (587, 456)-(597, 471), 7, BF
If Mid$(Minute$, 1, 1) = "1" Then
    PrintSTRING 587, 459, "1", 1
    PrintSTRING 593, 459, Mid$(Minute$, 2, 1), 1
Else
    PrintSTRING 587, 459, Minute$, 1
End If
ShowMOUSE
Return

PathPROB:
PathERROR = 1
Resume Next

xDATA:
Data 255,280,313,338,363,388,413,438,463,508,533,558

yDATA:
Data 338,268,194,120,50

Rem $STATIC
Sub AniCOLOR (MenuITEM)
    Static Mx, My, LB

    Timer Off
    ClearMOUSE
    Select Case MenuITEM
        Case 1
            Def Seg = VarSeg(WindowBOX(0))
            BLoad "anibox2.bsv", VarPtr(WindowBOX(0))
            Def Seg
            HideMOUSE
            Get (181, 90)-(460, 222), WindowBOX(9400)
            Put (181, 90), WindowBOX(), PSet
            ShowMOUSE
            Do
                MouseSTATUS LB, RB, MouseX, MouseY
                If MouseY > 95 And MouseY < 110 Then
                    If MouseX > 437 And MouseX < 453 Then
                        If CancelBOX Then Timer On: Exit Sub
                    End If
                End If
                Select Case MouseX
                    Case 204 TO 274
                        xx = 206
                        Select Case MouseY
                            Case 120 TO 133: ItemNUM = 1: yy = 120: GoSub Itemize
                            Case 134 TO 147: ItemNUM = 2: yy = 134: GoSub Itemize
                            Case 148 TO 161: ItemNUM = 3: yy = 148: GoSub Itemize
                            Case 162 TO 175: ItemNUM = 4: yy = 162: GoSub Itemize
                            Case 176 TO 189: ItemNUM = 5: yy = 176: GoSub Itemize
                            Case Else: GoSub Otherwise
                        End Select
                    Case 290 TO 360
                        xx = 292
                        Select Case MouseY
                            Case 120 TO 133: ItemNUM = 6: yy = 120: GoSub Itemize
                            Case 134 TO 147: ItemNUM = 7: yy = 134: GoSub Itemize
                            Case 148 TO 161: ItemNUM = 8: yy = 148: GoSub Itemize
                            Case 162 TO 175: ItemNUM = 9: yy = 162: GoSub Itemize
                            Case 176 TO 189: ItemNUM = 10: yy = 176: GoSub Itemize
                            Case Else: GoSub Otherwise
                        End Select
                    Case 376 TO 446
                        xx = 378
                        Select Case MouseY
                            Case 120 TO 133: ItemNUM = 11: yy = 120: GoSub Itemize
                            Case 134 TO 147: ItemNUM = 12: yy = 134: GoSub Itemize
                            Case 148 TO 161: ItemNUM = 13: yy = 148: GoSub Itemize
                            Case 162 TO 175: ItemNUM = 14: yy = 162: GoSub Itemize
                            Case 176 TO 189: ItemNUM = 15: yy = 176: GoSub Itemize
                            Case Else: GoSub Otherwise
                        End Select
                    Case Else: GoSub Otherwise
                End Select

                If LB = -1 Then
                    If Item <> 0 Then
                        If Item = 1 Then
                            Palette
                        Else
                            PalSTART = (Item - 2) * 48 + 1
                            Out &H3C8, 0
                            For n = PalSTART To PalSTART + 47
                                Out &H3C9, ColorBOX(n)
                            Next n
                        End If
                        HideMOUSE
                        Put (181, 90), WindowBOX(9400), PSet
                        ShowMOUSE
                        Mx = 0: My = 0
                        PauseMOUSE LB, RB, MouseX, MouseY
                        ClearMOUSE
                        Workdone = 1
                        Timer On
                        Exit Sub
                    End If
                End If
                ClearMOUSE
            Loop
        Case 2
            Def Seg = VarSeg(WindowBOX(0))
            BLoad "anibox3.bsv", VarPtr(WindowBOX(0))
            Def Seg
            HideMOUSE
            Get (181, 90)-(460, 222), WindowBOX(9400)
            Put (181, 90), WindowBOX(), PSet
            ShowMOUSE
            OldCOLOR = 1: SetCOLOR = 1
            ClearMOUSE
            Out &H3C7, 1: Red = Inp(&H3C9): Grn = Inp(&H3C9): Blu = Inp(&H3C9)
            OldRED = Red: OldGRN = Grn: OldBLU = Blu
            GoSub SetSLIDER1: GoSub SetSLIDER2: GoSub SetSLIDER3

            Do
                MouseSTATUS LB, RB, MouseX, MouseY
                Select Case MouseY
                    Case 95 TO 110
                        If MouseX > 437 And MouseX < 453 Then
                            If CancelBOX Then Timer On: Exit Sub
                        End If
                    Case 131 TO 147
                        If MouseX > 191 And MouseX < 450 Then
                            If LB = -1 Then
                                HideMOUSE
                                TryCOLOR = Point(MouseX, MouseY)
                                ShowMOUSE
                                If TryCOLOR <> 0 And TryCOLOR <> 7 Then
                                    If TryCOLOR <> 8 And TryCOLOR <> 15 Then
                                        SetCOLOR = TryCOLOR
                                    End If
                                End If
                            End If
                        End If
                    Case 154 TO 164: Slider = 1: GoSub SetSLIDER 'slider 1
                    Case 166 TO 176: Slider = 2: GoSub SetSLIDER 'slider 2
                    Case 178 TO 188: Slider = 3: GoSub SetSLIDER 'slider 3
                    Case 192 TO 215
                        If LB = -1 Then
                            If MouseX > 356 And MouseX < 403 Then 'Cancel
                                Out &H3C8, OldCOLOR
                                Out &H3C9, OldRED
                                Out &H3C9, OldGRN
                                Out &H3C9, OldBLU
                                HideMOUSE
                                Line (352, 191)-(400, 216), 7, B
                                DrawBOX 353, 192, 399, 215, 1
                                ShowMOUSE
                                Interval .1
                                HideMOUSE
                                Line (352, 191)-(400, 216), 0, B
                                DrawBOX 353, 192, 399, 215, 0
                                ShowMOUSE
                                Interval .1
                                HideMOUSE
                                Put (181, 90), WindowBOX(9400), PSet
                                ShowMOUSE
                                Timer On
                                Exit Sub
                            End If
                            If MouseX > 404 And MouseX < 451 Then 'OK
                                HideMOUSE
                                Line (403, 191)-(451, 216), 7, B
                                DrawBOX 404, 192, 450, 215, 1
                                ShowMOUSE
                                Interval .1
                                HideMOUSE
                                Line (403, 191)-(451, 216), 0, B
                                DrawBOX 404, 192, 450, 215, 0
                                ShowMOUSE
                                Interval .1
                                HideMOUSE
                                Put (181, 90), WindowBOX(9400), PSet
                                ShowMOUSE
                                Workdone = 1
                                Timer On
                                Exit Sub
                            End If
                        End If
                End Select
                If OldCOLOR <> SetCOLOR Then

                    Out &H3C8, OldCOLOR
                    Out &H3C9, OldRED
                    Out &H3C9, OldGRN
                    Out &H3C9, OldBLU

                    Out &H3C7, SetCOLOR
                    Red = Inp(&H3C9)
                    Grn = Inp(&H3C9)
                    Blu = Inp(&H3C9)

                    HideMOUSE
                    Line (402, 155)-(450, 186), SetCOLOR, BF
                    ShowMOUSE

                    GoSub SetSLIDER1
                    GoSub SetSLIDER2
                    GoSub SetSLIDER3
                    OldCOLOR = SetCOLOR
                    OldRED = Red
                    OldGRN = Grn
                    OldBLU = Blu
                End If
                ClearMOUSE
            Loop
    End Select

    Exit Sub

    SetSLIDER:
    If LB Then
        If MouseX > 209 And MouseX < 365 Then
            If MouseX > 358 Then MouseX = 358
            If MouseX < 216 Then MouseX = 216
            SliderVAL = (MouseX - 216) / 9 * 4
            Select Case Slider
                Case 1: Red = SliderVAL: GoSub SetSLIDER1
                Case 2: Grn = SliderVAL: GoSub SetSLIDER2
                Case 3: Blu = SliderVAL: GoSub SetSLIDER3
            End Select
        End If
    End If
    Return

    SetSLIDER1:
    RedX = Red / 4 * 9 + 209
    If RedX <> OldRX Then
        HideMOUSE
        If OldRX Then Put (OldRX, 155), WindowBOX(9300), PSet
        Put (RedX, 155), WindowBOX(9200), PSet
        Line (377, 155)-(390, 165), 7, BF
        PrintSTRING 377, 155, LTrim$(Str$(Red)), 2
        ShowMOUSE
        OldRX = RedX
        GoSub SetCOLOR
    End If
    Return

    SetSLIDER2:
    GrnX = Grn / 4 * 9 + 209
    If GrnX <> OldGX Then
        HideMOUSE
        If OldGX Then Put (OldGX, 167), WindowBOX(9300), PSet
        Put (GrnX, 167), WindowBOX(9200), PSet
        Line (377, 167)-(390, 177), 7, BF
        PrintSTRING 377, 167, LTrim$(Str$(Grn)), 2
        ShowMOUSE
        OldGX = GrnX
        GoSub SetCOLOR
    End If
    Return

    SetSLIDER3:
    BluX = Blu / 4 * 9 + 209
    If BluX <> OldBX Then
        HideMOUSE
        If OldBX Then Put (OldBX, 179), WindowBOX(9300), PSet
        Put (BluX, 179), WindowBOX(9200), PSet
        Line (377, 179)-(390, 189), 7, BF
        PrintSTRING 377, 179, LTrim$(Str$(Blu)), 2
        ShowMOUSE
        OldBX = BluX
        GoSub SetCOLOR
    End If
    Return

    SetCOLOR:
    Out &H3C8, SetCOLOR
    Out &H3C9, Red
    Out &H3C9, Grn
    Out &H3C9, Blu
    Return

    Itemize:
    If Item <> ItemNUM Then
        HideMOUSE
        If Mx Then Put (Mx, My), PaletteITEM(), PSet
        Mx = xx: My = yy
        Get (Mx, My)-(Mx + 72, My + 14), PaletteITEM()
        Put (Mx, My), PaletteITEM(), PReset
        ShowMOUSE
        Item = ItemNUM
    End If
    Return

    Otherwise:
    If Item <> 0 Then
        HideMOUSE
        If Mx Then Put (Mx, My), PaletteITEM(), PSet
        ShowMOUSE
        Item = 0
    End If
    Return

End Sub

Sub AniEDIT (MenuITEM)
    Shared Mask, TopLEFTx, TopLEFTy, BottomRIGHTx, BottomRIGHTy
    Static Tx, Ty, Bx, By, CopyFRAME, WDTH, DPTH, MaskedCOPY, Pasted
    Timer Off
    Select Case MenuITEM
        Case 1: Put (30, 194), UndoBOX(), PSet: ScaleUP 'Undo
        Case 2: 'Copy
            HideMOUSE
            If Mask Then
                GoSub AdjustCOORDINATES
                Get (TopLEFTx, TopLEFTy)-(BottomRIGHTx, BottomRIGHTy), CopyBOX()
                Tx = TopLEFTx: Ty = TopLEFTy: Bx = BottomRIGHTx: By = BottomRIGHTy
                WDTH = Bx - Tx: DPTH = By - Ty
                Mask = 0: CopyFRAME = FrameNUM: MaskedCOPY = 1: Pasted = 0
            Else
                Get (30, 194)-(119, 261), CopyBOX()
                Pasted = 0
                Tx = 30: Ty = 194: Bx = 119: By = 261
            End If
            ScaleUP
            ShowMOUSE
        Case 3: 'Paste
            If Pasted = 0 Then
                Get (30, 194)-(119, 261), UndoBOX()
                If CopyFRAME <> FrameNUM Then
                    If MaskedCOPY Then
                        Put (Tx, Ty), CopyBOX(), PSet
                    Else
                        Put (30, 194), CopyBOX(), PSet
                    End If
                    Get (30, 194)-(119, 261), Box(58 + (FrameNUM - 1) * 1635)
                    Workdone = 1
                Else
                    If Mask = 1 Then
                        GoSub AdjustCOORDINATES
                        PWDTH = BottomRIGHTx - TopLEFTx
                        PDPTH = BottomRIGHTy - TopLEFTy
                        If PWDTH < WDTH Then Bx = Tx + PWDTH
                        If PDPTH < DPTH Then By = Ty + PDPTH
                        If PWDTH >= WDTH Then Bx = Tx + WDTH
                        If PDPTH >= DPTH Then By = Ty + DPTH
                        Get (Tx, Ty)-(Bx, By), CopyBOX()
                        Put (TopLEFTx, TopLEFTy), CopyBOX(), PSet
                        Mask = 0: Pasted = 1
                    Else
                        Put (Tx, Ty), CopyBOX(), PSet
                        Pasted = 1
                    End If
                    Get (30, 194)-(119, 261), Box(58 + (FrameNUM - 1) * 1635)
                    Workdone = 1
                End If
            End If
            Get (30, 194)-(119, 261), Box(58 + (FrameNUM - 1) * 1635)
            ScaleUP
    End Select
    Timer On
    Exit Sub

    AdjustCOORDINATES:
    If TopLEFTx > BottomRIGHTx Then Swap TopLEFTx, BottomRIGHTx
    If TopLEFTy > BottomRIGHTy Then Swap TopLEFTy, BottomRIGHTy
    If TopLEFTx < 30 Then TopLEFTx = 30
    If TopLEFTy < 194 Then TopLEFTx = 194
    If BottomRIGHTx > 119 Then BottomRIGHTx = 119
    If BottomRIGHTy > 261 Then BottomRIGHTy = 261
    Return

End Sub

Sub AniFILE (MenuITEM)
    Shared Ky$, OldFILENAME$, OldPRINTNAME$
    Static Cancelled

    OldFILENAME$ = FileNAME$: OldPRINTNAME$ = PrintNAME$

    Timer Off
    Select Case MenuITEM
        Case 1 'New
            If Workdone Then
                Select Case SavePROMPT
                    Case 0 'x-button/Cancel button
                        Timer On: Exit Sub
                    Case 1 'Yes
                        GoSub Yes
                        GoSub NewFILE
                    Case 2 'No
                        GoSub NewFILE
                End Select
            Else
                GoSub NewFILE
            End If

        Case 2 'Open
            If Workdone Then
                Select Case SavePROMPT
                    Case 0
                        Timer On: Exit Sub
                    Case 1
                        GoSub Yes
                End Select
            End If
            Banner = 1
            GoSub GetNAME
            If Cancelled = 1 Then: Cancelled = 0: Timer On: Exit Sub
            LoadFILE

        Case 3 'Save
            If Len(FileNAME$) = 0 Then
                Banner = 2
                GoSub GetNAME
                If Cancelled = 1 Then Cancelled = 0: Timer On: Exit Sub
                GoSub CheckEXISTING
                GoSub BSAVEFile
                Line (140, 0)-(300, 16), 0, BF
                PrintSTRING 142, 3, PrintNAME$, 0
                Workdone = 0
            Else
                GoSub BSAVEFile
                Workdone = 0
            End If

        Case 4 'Save As
            Banner = 3
            GoSub GetNAME
            If Cancelled = 1 Then Cancelled = 0: Timer On: Exit Sub
            GoSub CheckEXISTING
            GoSub BSAVEFile
            Workdone = 0
            Line (140, 0)-(300, 16), 0, BF
            PrintSTRING 142, 3, PrintNAME$, 0

        Case 5 TO 8 'Open from recent list
            For n = 1 To 4
                Get #1, n, Recent(n)
            Next n
            FileNUMBER = MenuITEM - 4
            P$ = RTrim$(Recent(FileNUMBER).PName)
            If Len(P$) Then
                If Workdone Then
                    Select Case SavePROMPT
                        Case 0
                            Timer On: Exit Sub
                        Case 1
                            GoSub Yes
                    End Select
                End If
                FileNAME$ = RTrim$(Recent(FileNUMBER).FName)
                PrintNAME$ = RTrim$(Recent(FileNUMBER).PName)
                LoadFILE
            End If

        Case 9, 10 'Exit (finished)
            If Workdone Then
                Select Case SavePROMPT
                    Case 0
                        If MenuITEM = 11 Then MenuITEM = 12
                        Timer On: Exit Sub
                    Case 1
                        GoSub Yes
                    Case 2
                        If MenuITEM = 9 Then
                            Close #1
                            System
                        Else
                            Timer On: Exit Sub
                        End If
                End Select
            Else
                Close #1
                System
            End If

    End Select

    Timer On
    Exit Sub

    GetNAME:
    Def Seg = VarSeg(WindowBOX(0))
    BLoad "anibox1.bsv", VarPtr(WindowBOX(0))
    Def Seg
    HideMOUSE
    Get (181, 90)-(460, 222), WindowBOX(9400)
    Put (181, 90), WindowBOX(), PSet
    Select Case Banner '1:Open (default), 2:Save, 3:Save As
        Case 2: Put (193, 98), WindowBOX(7000), PSet
        Case 3: Put (193, 98), WindowBOX(7300), PSet
    End Select
    ShowMOUSE

    n$ = "": Ky$ = "": PrintX = 194: CharNUM = 1

    Do
        MouseSTATUS LB, RB, MouseX, MouseY
        HideMOUSE
        Line (PrintX + 2, 120)-(PrintX + 2, 130), 8
        ShowMOUSE
        If Len(Ky$) Then
            Select Case Asc(Ky$)
                Case 8
                    If Len(n$) Then
                        HideMOUSE
                        CharNUM = CharNUM - 1
                        Line (FChar(CharNUM), 120)-(PrintX + 2, 131), 15, BF
                        PrintX = FChar(CharNUM)
                        n$ = Mid$(n$, 1, Len(n$) - 1)
                        Line (PrintX + 2, 120)-(PrintX + 2, 130), 8
                        ShowMOUSE
                    End If
                Case 13
                    GoSub MakeNAME
                    Return
                Case 46, 48 TO 58, 65 TO 90, 92, 95, 97 TO 122, 126
                    If PrintX < 440 Then
                        FChar(CharNUM) = PrintX
                        CharNUM = CharNUM + 1
                        HideMOUSE
                        Line (PrintX + 2, 120)-(PrintX + 2, 130), 15
                        PrintSTRING PrintX, 120, Ky$, 1
                        Line (PrintX + 2, 120)-(PrintX + 2, 130), 8
                        ShowMOUSE
                        n$ = n$ + Ky$
                    End If
            End Select
        End If

        Select Case MouseY
            Case 95 TO 110
                If MouseX > 437 And MouseX < 453 Then
                    If CancelBOX Then Cancelled = 1: Return
                End If
            Case 150 TO 173
                Select Case MouseX
                    Case 355 TO 401 'Cancel
                        If LB = -1 Then
                            HideMOUSE
                            Line (355, 150)-(401, 173), 7, B
                            ShowMOUSE
                            Interval .1
                            HideMOUSE
                            DrawBOX 355, 150, 401, 173, 0
                            ShowMOUSE
                            Interval .1
                            HideMOUSE
                            Put (181, 90), WindowBOX(9400), PSet
                            ShowMOUSE
                            Cancelled = 1
                            ClearMOUSE
                            Return
                        End If
                    Case 406 TO 452 'OK
                        If LB = -1 Then
                            HideMOUSE
                            Line (406, 150)-(452, 173), 7, B
                            ShowMOUSE
                            Interval .1
                            HideMOUSE
                            DrawBOX 406, 150, 452, 173, 0
                            ShowMOUSE
                            Interval .1
                            GoSub MakeNAME
                            Return
                        End If
                End Select
        End Select
        PauseMOUSE LB, RB, MouseX, MouseY
    Loop
    Return

    CheckEXISTING:
    Open FileNAME$ For Binary As #2
    If LOF(2) Then
        Close #2
        DisplayERROR 2
        FileNAME$ = OldFILENAME$
        PrintNAME$ = OldPRINTNAME$
        Timer On
        Exit Sub
    End If
    Close #2
    Return

    BSAVEFile:
    For n = 1 To 8
        Char$ = Mid$(PrintNAME$, n, 1)
        Box(n) = Asc(Char$)
    Next n
    Out &H3C7, 0
    For n = 9 To 56
        Box(n) = Inp(&H3C9)
    Next n
    Box(57) = FrameCOUNT
    Get (30, 194)-(119, 261), Box(58 + (FrameNUM - 1) * 1635)
    Def Seg = VarSeg(Box(1))
    BSave FileNAME$, VarPtr(Box(1)), (57 + Box(57) * 1635) * 2&
    Def Seg
    SetRECENT 1
    Workdone = 0
    Return

    NewFILE:
    HideMOUSE
    Line (30, 194)-(119, 261), 15, BF
    Get (30, 194)-(119, 261), UndoBOX()
    If Scale = 5 Then
        Line (166, 56)-(615, 395), 15, BF
    Else
        Line (166, 56)-(435, 259), 15, BF
    End If
    FrameCOUNT = 1
    For Reps = 1 To 5
        If Reps = 3 Then Reps = 4
        LogoFRAME Reps
    Next Reps
    FileNAME$ = ""
    PrintNAME$ = ""
    Line (140, 0)-(300, 16), 0, BF
    PrintSTRING 142, 3, "untitled", 0
    FrameNUM = 1
    PrintFRAME
    ShowMOUSE
    Palette
    Workdone = 0
    Timer On
    Exit Sub
    Return

    MakeNAME:
    If Len(n$) Then
        For n = Len(n$) To 1 Step -1
            Char$ = Mid$(n$, n, 1)
            If Char$ = "." Then Dot = n
            If Char$ = "\" Then Slash = n: Exit For
        Next n
        If Dot Then n$ = Mid$(n$, 1, Dot - 1)
        If Slash Then Path$ = Mid$(n$, 1, Slash)
        If Slash Then n$ = Mid$(n$, Slash + 1, 8)
        If Len(n$) > 8 Then n$ = Left$(n$, 8)
        Cap$ = UCase$(Mid$(n$, 1, 1))
        LC$ = Mid$(n$, 2)
        PrintNAME$ = Cap$ + LC$ + Space$(8 - Len(n$))
        FileNAME$ = Path$ + n$ + ".AXB"
    Else
        Cancelled = 1
        HideMOUSE
        Put (181, 90), WindowBOX(9400), PSet
        ShowMOUSE
        Return
    End If
    HideMOUSE
    Put (181, 90), WindowBOX(9400), PSet
    ShowMOUSE
    Return

    Yes:
    If Len(FileNAME$) Then
        GoSub BSAVEFile
    Else
        Banner = 2
        GoSub GetNAME
        If Cancelled Then
            Cancelled = 0
            If MenuITEM = 6 Then MenuITEM = 7
            Timer On
            Exit Sub
        End If
        GoSub CheckEXISTING
        GoSub BSAVEFile
    End If
    Return

End Sub

Sub AniHELP (OnWHAT)
    Shared LB
    HideMOUSE
    Get (181, 90)-(460, 220), WindowBOX(9400)
    ShowMOUSE
    Timer Off
    Select Case OnWHAT
        Case 1 'Instructions
            PageNUM = 1
            GoSub PutHELP
            Do
                MouseSTATUS LB, RB, MouseX, MouseY
                If MouseY > 95 And MouseY < 110 Then
                    Select Case MouseX
                        Case 380 TO 400: Button = 1
                        Case 405 TO 425: Button = 2
                        Case 438 TO 452: Button = 3
                    End Select
                    If Button = 3 Then If CancelBOX Then Timer On: Exit Sub
                    If Button = 1 Or Button = 2 Then
                        If LB = -1 Then
                            If Button = 1 And PageNUM > 1 Then PageNUM = PageNUM - 1
                            If Button = 2 And PageNUM < 10 Then PageNUM = PageNUM + 1
                            GoSub PutHELP
                            ClearMOUSE
                        End If
                    End If
                End If
            Loop
        Case 2 'Load Demo
            If Workdone = 0 Then
                PrintNAME$ = "Book"
                FileNAME$ = "Book.AXB"
                LoadFILE
            Else
                DisplayERROR 4
            End If
            ClearMOUSE

        Case 3 'About
            PageNUM = 11
            GoSub PutHELP
            Do
                MouseSTATUS LB, RB, MouseX, MouseY
                If MouseY > 95 And MouseY < 110 Then
                    If MouseX > 437 And MouseX < 453 Then
                        If CancelBOX Then Exit Do
                    End If
                End If
            Loop
    End Select

    Timer On
    Exit Sub

    PutHELP:
    Def Seg = VarSeg(WindowBOX(0))
    FileNAME$ = "AxHELP" + LTrim$(Str$(PageNUM)) + ".BSV"
    BLoad FileNAME$, VarPtr(WindowBOX(0))
    HideMOUSE
    Put (181, 90), WindowBOX(), PSet
    ShowMOUSE
    Return

End Sub

Sub AniSPECIAL (Trick)
    Timer Off
    Get (30, 194)-(119, 261), UndoBOX()
    Select Case Trick
        Case 1 'flip horizontally
            For x = 30 To 75
                Get (x, 194)-(x, 261), WindowBOX(9400)
                Get (149 - x, 194)-(149 - x, 261), WindowBOX(9600)
                Put (149 - x, 194), WindowBOX(9400), PSet
                Put (x, 194), WindowBOX(9600), PSet
            Next x
        Case 2 'flip vertically
            For y = 194 To 227
                Get (30, y)-(119, y), WindowBOX(9400)
                Get (30, 455 - y)-(119, 455 - y), WindowBOX(9600)
                Put (30, 455 - y), WindowBOX(9400), PSet
                Put (30, y), WindowBOX(9600), PSet
            Next y
        Case 3 'negative
            Get (30, 194)-(119, 261), WindowBOX(9400)
            Put (30, 194), WindowBOX(9400), PReset
    End Select
    Workdone = 1
    ScaleUP
    Timer On

End Sub

Function CancelBOX

    MouseSTATUS LB, RB, MouseX, MouseY
    If LB = -1 Then
        HideMOUSE
        DrawBOX 438, 96, 452, 109, 1
        ShowMOUSE
        Interval .1
        HideMOUSE
        DrawBOX 438, 96, 452, 109, 0
        ShowMOUSE
        Interval .1
        HideMOUSE
        Put (181, 90), WindowBOX(9400), PSet
        ShowMOUSE
        Mx = 0: My = 0
        ClearMOUSE
        CancelBOX = 1
    End If

End Function

Sub ClearMOUSE
    Shared LB, RB, MouseX, MouseY

    While LB Or RB
        MouseSTATUS LB, RB, MouseX, MouseY
    Wend

End Sub

Sub ColorBAR
    Shared MouseX, MouseY, LB
    Timer Off
    If LB = -1 Then
        If MouseY > 423 And MouseY < 434 Then
            Select Case MouseX
                Case 201 TO 222: WClr = 0
                Case 227 TO 248: WClr = 8
                Case 253 TO 274: WClr = 7
                Case 279 TO 300: WClr = 15
                Case Else
                    HideMOUSE
                    TC = Point(MouseX, MouseY)
                    ShowMOUSE
                    If TC <> 0 And TC <> 7 And TC <> 8 And TC <> 15 Then
                        If TC <> WClr Then WClr = TC
                    End If
            End Select
        End If
        HideMOUSE
        Line (152, 424)-(189, 433), WClr, BF
        ShowMOUSE
        ClearMOUSE
    End If
    Timer On
End Sub

Sub DisplayERROR (ErrorNUM)

    Def Seg = VarSeg(WindowBOX(0))
    BLoad "anibox4.bsv", VarPtr(WindowBOX(0))
    Def Seg
    HideMOUSE
    Get (181, 90)-(460, 222), WindowBOX(9400)
    Put (181, 90), WindowBOX(), PSet
    Select Case ErrorNUM
        Case 1: 'default - file/path error
        Case 2: Put (223, 125), WindowBOX(5535), PSet 'name in use
        Case 3: Put (223, 125), WindowBOX(6650), PSet 'not Animax! file
        Case 4: Put (223, 125), WindowBOX(7765), PSet 'save before demo
    End Select
    ShowMOUSE

    Do
        MouseSTATUS LB, RB, MouseX, MouseY
        If LB = -1 Then
            Select Case MouseY
                Case 95 TO 110
                    If MouseX > 437 And MouseX < 453 Then
                        If CancelBOX Then Exit Sub
                    End If
                Case 125 TO 149
                    If MouseX > 401 And MouseX < 450 Then
                        HideMOUSE
                        Line (402, 125)-(449, 149), 7, B
                        ShowMOUSE
                        Interval .1
                        HideMOUSE
                        DrawBOX 402, 125, 449, 149, 0
                        ShowMOUSE
                        Interval .1
                        HideMOUSE
                        Put (181, 90), WindowBOX(9400), PSet
                        ShowMOUSE
                        ClearMOUSE
                        Exit Sub
                    End If
            End Select
        End If
    Loop

End Sub

Sub DisplayFRAMES
    HideMOUSE
    For n = FrameNUM - 2 To FrameNUM + 2
        Frame = Frame + 1
        If n < 1 Or n > FrameCOUNT Then
            LogoFRAME Frame
        Else
            Put (30, FBox(Frame)), Box(58 + (n - 1) * 1635), PSet
        End If
    Next n
    PrintFRAME
    ShowMOUSE
End Sub

Sub DrawBOX (x1, y1, x2, y2, Mode)
    If Mode = 1 Then
        Colr1 = 8: Colr2 = 15
    Else
        Colr1 = 15: Colr2 = 8
    End If
    Line (x1, y1)-(x2, y2), Colr1, B
    Line (x1, y2)-(x2, y2), Colr2
    Line (x2, y1)-(x2, y2), Colr2
End Sub

Sub DrawSCREEN
    Shared Tx
    Def Seg = VarSeg(Box(1))
    For y = 0 To 360 Step 120
        Count = Count + 1
        FileNAME$ = "Animax!" + LTrim$(Str$(Count)) + ".BSV"
        BLoad FileNAME$, VarPtr(Box(1))
        Put (0, y), Box()
    Next y
    Def Seg
    Get (60, 218)-(90, 232), TitleBOX()
    Get (30, 194)-(119, 261), UndoBOX()
    Get (30, 194)-(119, 261), CopyBOX()
    'Freehand tool selected
    DrawBOX 338, 20, 362, 39, 1
    WorkingTOOL = 4: ExTOOL = 4
    Tx = 338: FileNAME$ = ""
End Sub

Sub HideMOUSE

    LB = 2
    MouseDRIVER LB, 0, 0, 0

End Sub

Function InitMOUSE

    LB = 0
    MouseDRIVER LB, 0, 0, 0
    InitMOUSE = LB

End Function

DefSng A-Z
Sub Interval (Length!)

    OldTIMER! = Timer
    Do
        If Timer < OldTIMER! Then Exit Do
    Loop Until Timer > OldTIMER! + Length!

End Sub

DefInt A-Z
Sub LoadFILE
    Shared PathERROR, OldFILENAME$, OldPRINTNAME$


    Open FileNAME$ For Binary As #2
    If LOF(2) Then
        FileEXISTS = 1
    Else
        FileEXISTS = 0
        SetRECENT 2
    End If
    Close #2

    If FileEXISTS = 0 Then
        DisplayERROR 1
        GoSub NoFILE
    End If

    Open FileNAME$ For Binary As #2
    PathERROR = 0
    If PathERROR Then
        Close #2
        DisplayERROR 1
        GoSub NoFILE
    Else
        t$ = " "
        Get #2, , t$
        If (LOF(2) - 7) / 2 >= 1692 And t$ = Chr$(253) Then
            Close #2
            SetRECENT 1
            Def Seg = VarSeg(Box(1))
            BLoad FileNAME$, VarPtr(Box(1))
            Def Seg
            Workdone = 0
        Else
            DisplayERROR 3
            GoSub NoFILE
        End If
    End If

    Line (166, 56)-(166 + Scale * 90 - 1, 56 + Scale * 68 - 1), 8, BF

    PrintNAME$ = ""
    For n = 1 To 8
        PrintNAME$ = PrintNAME$ + Chr$(Box(n))
    Next n
    OldPRINTNAME$ = PrintNAME$
    HideMOUSE
    Line (140, 0)-(300, 16), 0, BF
    PrintSTRING 142, 3, PrintNAME$, 0
    ShowMOUSE
    Out &H3C8, 0
    For n = 9 To 56
        Out &H3C9, Box(n)
    Next n
    FrameCOUNT = Box(57)
    HideMOUSE
    LogoFRAME 1
    LogoFRAME 2
    For Reps = 0 To FrameCOUNT - 1
        Put (30, FBox(Reps + 3)), Box(58 + Reps * 1635), PSet
        If Reps = 2 Then Exit For
    Next Reps
    If FrameCOUNT < 3 Then LogoFRAME 5
    If FrameCOUNT < 2 Then LogoFRAME 4
    Get (30, 194)-(119, 261), UndoBOX()
    FrameNUM = 1
    PrintFRAME
    ScaleUP
    ShowMOUSE

    Exit Sub

    NoFILE:
    FileNAME$ = OldFILENAME$
    PrintNAME$ = OldPRINTNAME$
    Exit Sub
    Return

End Sub

Sub LocateMOUSE (x, y)

    LB = 4
    Mx = x
    My = y
    MouseDRIVER LB, 0, Mx, My

End Sub

Sub LogoFRAME (Frame)
    Line (30, FBox(Frame))-(119, FBox(Frame) + 67), 8, BF
    Line (30, FBox(Frame))-(119, FBox(Frame) + 67), 0, B
    Line (32, FBox(Frame) + 2)-(117, FBox(Frame) + 65), 0, B
    Line (34, FBox(Frame) + 4)-(115, FBox(Frame) + 63), 0, B
    Put (60, FBox(Frame) + 24), TitleBOX(), PSet
End Sub

Sub MenuBAR (InOUT)
    Shared LB, MouseX
    Static Mx, Mxx, OldIy, MenuRIGHT, MenuBOTTOM

    If InOUT = 0 Then GoSub EraseBUTTON: Exit Sub
    If Menu > 5 Then
        Timer Off
        Do
            MouseSTATUS LB, RB, MouseX, MouseY
            If MouseY > MenuBOTTOM Then GoSub CloseMENU: Exit Sub
            Select Case MouseX
                Case Mx TO MenuRIGHT
                    Select Case MouseY
                        Case Is < 20: GoSub CloseMENU: Exit Sub
                        Case 20 TO 46
                            If MouseX < Mx Or MouseX > Mxx Then GoSub CloseMENU: Exit Sub
                        Case 47 TO 60: ItemNUM = 1: Iy = 47: GoSub LightITEM
                        Case 61 TO 74: ItemNUM = 2: Iy = 61: GoSub LightITEM
                        Case 75 TO 88
                            If Menu <> 30 Then
                                ItemNUM = 3: Iy = 75: GoSub LightITEM
                            End If
                        Case 89 TO 102
                            If Menu = 10 Then
                                ItemNUM = 4: Iy = 89: GoSub LightITEM
                            End If
                        Case 112 TO 125
                            If Menu = 10 Then
                                ItemNUM = 5: Iy = 112: GoSub LightITEM
                            End If
                        Case 126 TO 139
                            If Menu = 10 Then
                                ItemNUM = 6: Iy = 126: GoSub LightITEM
                            End If
                        Case 140 TO 153
                            If Menu = 10 Then
                                ItemNUM = 7: Iy = 140: GoSub LightITEM
                            End If
                        Case 154 TO 167
                            If Menu = 10 Then
                                ItemNUM = 8: Iy = 154: GoSub LightITEM
                            End If
                        Case 177 TO 190
                            If Menu = 10 Then
                                ItemNUM = 9: Iy = 177: GoSub LightITEM
                            End If
                    End Select
                    If LB = -1 Then GoSub SelectITEM
                Case Else
                    GoSub CloseMENU: Exit Sub
            End Select
        Loop
        GoSub CloseMENU
        Exit Sub
    Else
        Select Case MouseX
            Case 7 TO 47: MenuNUM = 1: ItemX = 7: ItemXX = 47: GoSub Button
            Case 48 TO 87: MenuNUM = 2: ItemX = 48: ItemXX = 87: GoSub Button
            Case 88 TO 135: MenuNUM = 3: ItemX = 88: ItemXX = 135: GoSub Button
            Case 136 TO 193: MenuNUM = 4: ItemX = 136: ItemXX = 193: GoSub Button
            Case 194 TO 235: MenuNUM = 5: ItemX = 194: ItemXX = 235: GoSub Button
        End Select
        If LB = -1 Then
            Menu = Menu * 10
            GoSub DropMENU
        End If
    End If

    Exit Sub

    Button:
    If Menu <> MenuNUM Then
        GoSub EraseBUTTON
        Mx = ItemX: Mxx = ItemXX
        GoSub RaiseBUTTON
        Menu = MenuNUM
    End If
    Return

    RaiseBUTTON:
    HideMOUSE
    Line (Mx, 20)-(Mxx, 39), 15, B
    Line (Mx, 39)-(Mxx, 39), 8
    Line (Mxx, 20)-(Mxx, 39), 8
    ShowMOUSE
    Return

    EraseBUTTON:
    If Menu Then
        HideMOUSE
        Line (Mx, 20)-(Mxx, 39), 7, B
        ShowMOUSE
    End If
    Menu = 0
    Timer On
    Return

    DropMENU:
    If Menu > 5 Then
        Def Seg = VarSeg(WindowBOX(0))
        BLoad "animnus.bsv", VarPtr(WindowBOX(0))
        Def Seg
        Select Case Menu
            Case 10: Index = 0
            Case 20: Index = 3420
            Case 30: Index = 4220
            Case 40: Index = 5350
            Case 50: Index = 6834
        End Select
        HideMOUSE
        Line (Mx, 20)-(Mxx, 39), 8, B
        Line (Mx, 39)-(Mxx, 39), 15
        Line (Mxx, 20)-(Mxx, 39), 15
        Get (Mx, 40)-(Mx + WindowBOX(Index), 194), WindowBOX(9400)
        Put (Mx, 40), WindowBOX(Index), PSet
        If Menu = 10 Then
            num = 1
            For y = 113 To 155 Step 14
                x = 30
                Name$ = RTrim$(Recent(num).PName)
                For n = 1 To Len(Name$)
                    Char$ = Mid$(Name$, n, 1)
                    PrintSTRING x, y, Char$, 1
                    If x > 76 Then
                        PrintSTRING x, y, "...", 1
                        Exit For
                    End If
                Next n
                num = num + 1
            Next y
        End If
        ShowMOUSE
        MenuRIGHT = WindowBOX(Index) + Mx
        MenuBOTTOM = WindowBOX(Index + 1) + 39
        ClearMOUSE
    End If
    Return

    CloseMENU:
    HideMOUSE
    Put (Mx, 40), WindowBOX(9400), PSet
    ShowMOUSE
    GoSub EraseBUTTON
    Return

    LightITEM:
    If Item <> ItemNUM Then
        GoSub DeLIGHT
        Ix = Mx + 3: Ixx = MenuRIGHT - 4
        GoSub HiLIGHT
        Item = ItemNUM
        OldIy = Iy
    End If
    Return

    SelectITEM:
    MenuNUM = Menu
    GoSub CloseMENU
    Selection = MenuNUM + Item
    Select Case Selection
        Case 11 TO 19: AniFILE Selection - 10
        Case 21 TO 23: AniEDIT Selection - 20
        Case 31, 32: AniCOLOR Selection - 30
        Case 41 TO 43: AniSPECIAL Selection - 40
        Case 51 TO 53: AniHELP Selection - 50
    End Select
    Exit Sub
    Return

    HiLIGHT:
    HideMOUSE
    Get (Ix, Iy)-(Ixx, Iy + 13), ItemBOX()
    Put (Ix, Iy), ItemBOX(), PReset
    ShowMOUSE
    Return

    DeLIGHT:
    If Ix Then
        HideMOUSE
        Put (Ix, OldIy), ItemBOX(), PSet
        ShowMOUSE
    End If
    Return

End Sub

Sub MouseDRIVER (LB, RB, Mx, My)

    Def Seg = VarSeg(MouseDATA$)
    mouse = SAdd(MouseDATA$)
    Call ABSOLUTE_MOUSE_EMU(LB, RB, Mx, My)

End Sub

Sub MouseSTATUS (LB, RB, MouseX, MouseY)

    LB = 3
    MouseDRIVER LB, RB, Mx, My
    LB = ((RB And 1) <> 0)
    RB = ((RB And 2) <> 0)
    MouseX = Mx
    MouseY = My

End Sub

Sub PauseMOUSE (L, R, x, y)
    Shared Ky$

    Do
        Ky$ = InKey$
        MouseSTATUS LB, RB, MouseX, MouseY
    Loop Until LB <> L Or R <> OldRB Or MouseX <> x Or MouseY <> y Or Ky$ <> ""

End Sub

Sub PrintBLURB
    Static OldBLURB
    Shared ButtonsUP
    Timer Off
    If Blurb <> OldBLURB Then
        Line (281, 456)-(549, 471), 7, BF
        Select Case Blurb
            Case 1: B$ = "Rewind to first frame"
            Case 2: B$ = "Play"
            Case 3: B$ = "Fast forward to last frame"
            Case 4: B$ = "Back one frame"
            Case 5: B$ = "Frame advance (forward one frame)"
            Case 6, 7
                If ButtonsUP = 0 Then OldBLURB = Blurb: Exit Sub
                If Blurb = 7 Then B$ = "Outlined" Else B$ = "Filled"
            Case 8: B$ = "Pixel tool: precisely color individual pixels"
            Case 9: B$ = "Freehand drawing tool"
            Case 10: B$ = "Box tool"
            Case 11: B$ = "Circle tool"
            Case 12: B$ = "Elipse tool"
            Case 13: B$ = "Line tool"
            Case 14: B$ = "Floodfill (paint) tool"
            Case 15: B$ = "Mask tool"
            Case 16: B$ = "Zoom tool: toggles between 3x and 5x magnification"
            Case 17: B$ = "Color-swap tool: changes selected color to pen color"
        End Select
        PrintSTRING 288, 459, B$, 1
    End If
    OldBLURB = Blurb
    Timer On
End Sub

Sub PrintFRAME
    If FrameNUM < 10 Then
        Frame$ = "0" + LTrim$(Str$(FrameNUM))
    Else
        Frame$ = LTrim$(Str$(FrameNUM))
    End If
    Line (125, 221)-(145, 234), 8, BF
    PrintSTRING 130, 222, Frame$, 1
End Sub

Sub PrintSTRING (x, y, Prnt$, Font)

    If Font = 0 Then
        Def Seg = VarSeg(FontBOX(0))
        BLoad "animssb.fnt", VarPtr(FontBOX(0))
        Def Seg
    End If

    For i = 1 To Len(Prnt$)
        Char$ = Mid$(Prnt$, i, 1)
        If Char$ = " " Then
            x = x + FontBOX(1)
        Else
            Index = (Asc(Char$) - 33) * FontBOX(0) + 2
            Put (x, y), FontBOX(Index)
            x = x + FontBOX(Index)
        End If
    Next i

    If Font = 0 Then
        Def Seg = VarSeg(FontBOX(0))
        BLoad "animssr.fnt", VarPtr(FontBOX(0))
        Def Seg
    End If

End Sub

Sub RunBUTTONS
    Shared MouseX, MouseY, LB
    Timer Off
    If MouseY < 414 Or MouseY > 434 Then
        Button = 0
    Else
        Select Case MouseX
            Case 15 TO 38: Bx = 15: Button = 1
            Case 39 TO 62: Bx = 39: Button = 2
            Case 63 TO 86: Bx = 63: Button = 3
            Case 87 TO 110: Bx = 87: Button = 4
            Case 111 TO 134: Bx = 111: Button = 5
            Case Else: Button = 0
        End Select
    End If

    Blurb = Button
    PrintBLURB

    If LB = -1 Then
        If Button Then
            HideMOUSE
            DrawBOX Bx, 415, Bx + 23, 434, 1
            ShowMOUSE
            If Button <> 2 Then
                Get (30, 194)-(119, 261), Box(58 + (FrameNUM - 1) * 1635)
            End If
            Select Case Button
                Case 1: FrameNUM = 1: DisplayFRAMES: ScaleUP 'rewind to first frame
                Case 2 'play
                    For Frames = 1 To 5
                        If Frames = 3 Then Frames = 4
                        LogoFRAME Frames
                    Next Frames
                    OldFRAMENUM = FrameNUM
                    For n = 1 To FrameCOUNT
                        For Delay = 1 To 5
                            Wait &H3DA, 8
                            Wait &H3DA, 8, 8
                        Next Delay
                        Put (30, 194), Box(58 + (n - 1) * 1635), PSet
                        FrameNUM = n
                        PrintFRAME
                        Interval .05
                    Next n
                    Interval .5
                    FrameNUM = OldFRAMENUM
                    DisplayFRAMES
                Case 3: FrameNUM = FrameCOUNT: DisplayFRAMES: ScaleUP 'go to last frame
                Case 4 'back one frame
                    If FrameNUM > 1 Then
                        FrameNUM = FrameNUM - 1
                        DisplayFRAMES
                        Get (30, 194)-(119, 261), UndoBOX()
                        ScaleUP
                    End If
                Case 5 'frame advance
                    If FrameNUM < 16 Then
                        If FrameNUM = FrameCOUNT Then
                            FrameCOUNT = FrameCOUNT + 1
                            Line (30, 194)-(119, 261), 15, BF
                            Get (30, 194)-(119, 261), Box(58 + (FrameCOUNT - 1) * 1635)
                            Workdone = 1
                        End If
                        FrameNUM = FrameNUM + 1
                        DisplayFRAMES
                        Get (30, 194)-(119, 261), UndoBOX()
                        ScaleUP
                    End If
            End Select
            Interval .1
            HideMOUSE
            DrawBOX Bx, 415, Bx + 23, 434, 0
            ShowMOUSE
            ClearMOUSE
        End If
    End If
    Timer On
End Sub

Function SavePROMPT
    Timer Off
    HideMOUSE
    Def Seg = VarSeg(WindowBOX(0))
    BLoad "anibox5.bsv", VarPtr(WindowBOX(0))
    Def Seg
    Get (181, 90)-(460, 222), WindowBOX(9400)
    Put (181, 90), WindowBOX(), PSet
    ShowMOUSE
    Beep

    Do
        MouseSTATUS LB, RB, MouseX, MouseY
        Select Case MouseY
            Case 95 TO 110
                If MouseX > 437 And MouseX < 453 Then
                    If CancelBOX Then SavePROMPT = 0: Timer On: Exit Function
                End If
            Case 168 TO 189
                Select Case MouseX
                    Case 205 TO 272 'Yes
                        If LB Then
                            HideMOUSE
                            Line (205, 168)-(272, 189), 7, B
                            Get (222, 172)-(255, 184), ItemBOX()
                            Put (223, 173), ItemBOX(), PSet
                            ShowMOUSE
                            Interval .1
                            HideMOUSE
                            Line (205, 168)-(272, 189), 15, B
                            Line (272, 168)-(272, 189), 8
                            Line (205, 189)-(272, 189), 8
                            Put (222, 172), ItemBOX(), PSet
                            ShowMOUSE
                            Interval .1
                            SavePROMPT = 1
                            HideMOUSE
                            Put (181, 90), WindowBOX(9400), PSet
                            ShowMOUSE
                            Timer On
                            Exit Function
                        End If
                    Case 285 TO 353 'No
                        If LB Then
                            HideMOUSE
                            Line (285, 168)-(353, 189), 7, B
                            ShowMOUSE
                            Interval .1
                            HideMOUSE
                            DrawBOX 285, 168, 353, 189, 0
                            ShowMOUSE
                            Interval .1
                            SavePROMPT = 2
                            HideMOUSE
                            Put (181, 90), WindowBOX(9400), PSet
                            ShowMOUSE
                            Timer On
                            Exit Function
                        End If
                    Case 366 TO 434 'Cancel
                        If LB = -1 Then
                            HideMOUSE
                            Line (366, 168)-(434, 189), 7, B
                            ShowMOUSE
                            Interval .1
                            HideMOUSE
                            DrawBOX 366, 168, 434, 189, 0
                            ShowMOUSE
                            Interval .1
                            SavePROMPT = 0
                            HideMOUSE
                            Put (181, 90), WindowBOX(9400), PSet
                            ShowMOUSE
                            Timer On
                            Exit Function
                        End If
                End Select
        End Select
        PauseMOUSE LB, RB, MouseX, MouseY
    Loop

End Function

Sub ScaleFRAME
    HideMOUSE
    Timer Off
    Line (155, 45)-(626, 406), 8, BF
    If Scale = 5 Then
        Line (157, 47)-(626, 406), 0, B
        Line (156, 46)-(625, 405), 7, BF
        Line (156, 46)-(625, 405), 15, B
        Line (156, 405)-(625, 405), 8
        Line (625, 46)-(625, 405), 8

        Line (165, 55)-(616, 396), 15, B
        Line (165, 55)-(165, 395), 8
        Line (165, 55)-(615, 55), 8
        Line (166, 56)-(615, 395), 8, BF
    Else
        Line (157, 47)-(446, 270), 0, B
        Line (156, 46)-(445, 269), 7, BF
        Line (156, 46)-(445, 269), 15, B
        Line (156, 269)-(445, 269), 8
        Line (445, 46)-(445, 269), 8

        Line (166, 56)-(435, 259), 8, BF
        Line (165, 55)-(436, 260), 15, B
        Line (165, 55)-(435, 55), 8
        Line (165, 55)-(165, 259), 8
    End If
    ShowMOUSE
    ScaleUP
    Timer On
End Sub

Sub ScaleUP
    Timer Off
    HideMOUSE
    For y = 0 To 67
        For x = 0 To 89
            Line (x * Scale + 166, y * Scale + 56)-(x * Scale + 166 + Scale - 1, y * Scale + 56 + Scale - 1), Point(x + 30, y + 194), BF
        Next x
    Next y
    ShowMOUSE
    Timer On
End Sub

Sub SetRECENT (Mode)

    For n = 1 To 6
        Get #1, n, Recent(n)
    Next n

    If Mode = 1 Then

        For n = 6 To 2 Step -1 'shift file names down one
            Recent(n) = Recent(n - 1)
        Next n
        Recent(1).PName = PrintNAME$ 'add new name to top slot
        Recent(1).FName = FileNAME$

    Else 'file to be removed from recent list

        For n = 1 To 6
            If UCase$(RTrim$(Recent(n).FName)) = UCase$(FileNAME$) Then
                Recent(n).PName = Space$(8)
                Recent(n).FName = Space$(130)
            End If
        Next n
        FileNAME$ = OldFILENAME$
        PrintNAME$ = OldPRINTNAME$
    End If

    For n = 1 To 5 'replace duplicates with blanks
        For nn = n + 1 To 6
            If UCase$(RTrim$(Recent(nn).PName)) = UCase$(RTrim$(Recent(n).PName)) Then
                Recent(nn).PName = Space$(8)
                Recent(nn).FName = Space$(130)
            End If
        Next nn
    Next n

    For n = 1 To 5 'move all names to top of list, blanks to bottom
        If Len(RTrim$(Recent(n).PName)) = 0 Then
            Hop = 1
            Do
                If Len(RTrim$(Recent(n + Hop).PName)) <> 0 Then
                    Swap Recent(n), Recent(n + Hop)
                    Exit Do
                End If
                Hop = Hop + 1
                If Hop + n > 6 Then Exit Do
            Loop
        End If
    Next n

    For n = 1 To 6 'put new list configuration in file
        Put #1, n, Recent(n)
    Next n

End Sub

Sub SetXY
    Shared MouseX, MouseY
    Static ExX, ExY
    If MouseX > 165 And MouseX < 165 + Scale * 90 Then
        If MouseY > 55 And MouseY < 55 + Scale * 68 Then
            If MouseX <> ExX Or MouseY <> ExY Then
                PixelX = (MouseX - 166) \ Scale
                PixelY = (MouseY - 55) \ Scale
                Wait &H3DA, 8
                Wait &H3DA, 8, 8
                Line (71, 459)-(91, 470), 15, BF
                PrintSTRING 71, 459, Str$(PixelX), 1
                Line (102, 459)-(122, 470), 15, BF
                PrintSTRING 102, 459, Str$(PixelY), 1
                ExX = PixelX: ExY = PixelY
            End If
        End If
    End If
End Sub

Sub ShowMOUSE

    LB = 1
    MouseDRIVER LB, 0, 0, 0

End Sub

Sub ToolBAR
    Shared MouseX, MouseY, LB, ButtonsUP

    Timer Off
    If MouseY < 20 Or MouseY > 40 Then
        Tool = -5
    Else
        Select Case MouseX
            Case 255 TO 279: Tool = 1
            Case 280 TO 304: Tool = 2
            Case 313 TO 337: Tool = 3
            Case 338 TO 362: Tool = 4
            Case 363 TO 387: Tool = 5: ChangeSCALE = 1: xx = 364
            Case 388 TO 412: Tool = 6: ChangeSCALE = 1: xx = 389
            Case 413 TO 437: Tool = 7: ChangeSCALE = 1: xx = 414
            Case 438 TO 462: Tool = 8: ChangeSCALE = 1
            Case 463 TO 487: Tool = 9
            Case 508 TO 532: Tool = 10: ChangeSCALE = 1
            Case 533 TO 557: Tool = 11: If LB = -1 Then GoSub Mag
            Case 558 TO 582: Tool = 12
            Case Else: Tool = -5
        End Select
    End If

    Blurb = Tool + 5
    PrintBLURB

    If LB = -1 Then
        If Tool > 2 Then
            If Tool <> WorkingTOOL Then
                HideMOUSE
                DrawBOX ToolBOX(WorkingTOOL), 20, ToolBOX(WorkingTOOL) + 24, 39, 0
                WorkingTOOL = Tool
                DrawBOX ToolBOX(WorkingTOOL), 20, ToolBOX(WorkingTOOL) + 24, 39, 1
                ShowMOUSE
                w = WorkingTOOL
                If w = 5 Or w = 6 Or w = 7 Then
                    HideMOUSE
                    Get (xx, 21)-(xx + 22, 38), ItemBOX()
                    Put (281, 21), ItemBOX(), PSet
                    Put (256, 21), ItemBOX(), PSet
                    Paint (267, 30), 0
                    DrawBOX 280, 20, 304, 39, Filled + 1
                    DrawBOX 255, 20, 279, 39, Filled
                    ShowMOUSE
                    ButtonsUP = 1
                Else
                    If WorkingTOOL <> 1 And WorkingTOOL <> 2 Then
                        HideMOUSE
                        Line (254, 20)-(312, 39), 7, BF
                        ButtonsUP = 0
                        ShowMOUSE
                    End If
                End If
            End If
        Else
            If ButtonsUP = 1 Then
                If Tool = 1 Then Filled = 1 Else Filled = 0
                HideMOUSE
                DrawBOX ToolBOX(1), 20, ToolBOX(1) + 24, 39, Filled
                DrawBOX ToolBOX(2), 20, ToolBOX(2) + 24, 39, Filled + 1
                ShowMOUSE
            End If
        End If
        If ChangeSCALE = 1 Then
            If Scale = 5 Then
                Scale = 3
                ScaleFRAME
            End If
        End If
        ExTOOL = WorkingTOOL
        GoSub CloseUP
    End If

    Exit Sub

    CloseUP:
    ClearMOUSE
    Timer On
    Exit Sub
    Return

    Mag:
    If Scale = 3 Then
        w = WorkingTOOL
        If w = 5 Or w = 6 Or w = 7 Or w = 8 Or w = 10 Then
            HideMOUSE
            DrawBOX ToolBOX(WorkingTOOL), 20, ToolBOX(WorkingTOOL) + 24, 39, 0
            WorkingTOOL = 4
            DrawBOX ToolBOX(WorkingTOOL), 20, ToolBOX(WorkingTOOL) + 24, 39, 1
            Line (254, 20)-(312, 39), 7, BF
            ButtonsUP = 0
            ShowMOUSE
        End If
    End If
    If Scale = 3 Then Scale = 5 Else Scale = 3
    HideMOUSE
    DrawBOX ToolBOX(11), 20, ToolBOX(11) + 24, 39, 1
    ScaleFRAME
    DrawBOX ToolBOX(11), 20, ToolBOX(11) + 24, 39, 0
    ShowMOUSE
    GoSub CloseUP
    Return

End Sub

Sub WorkAREA
    Shared LB, RB, MouseX, MouseY
    Shared Mask, TopLEFTx, TopLEFTy, BottomRIGHTx, BottomRIGHTy
    If Scale = 3 Then Adjust = 2 Else Adjust = 0

    If RB Then
        HideMOUSE
        WClr = Point(MouseX, MouseY)
        Line (152, 424)-(189, 433), WClr, BF
        ShowMOUSE
    End If

    SetXY

    GoSub SetPIXEL
    Select Case WorkingTOOL
        Case 3 'Pixel tool
            If LB Then
                HideMOUSE
                Get (30, 194)-(119, 261), UndoBOX()
                PSet (PixelX + 29, PixelY + 193), WClr
                x = PixelX * Scale + 161 + Adjust
                y = PixelY * Scale + 51 + Adjust
                Line (x, y)-(x + Scale - 1, y + Scale - 1), WClr, BF
                ClearMOUSE
                ShowMOUSE
                Workdone = 1
            End If
        Case 4 'Freehand tool
            If LB Then
                Timer Off
                OldPIXELx = PixelX: OldPIXELy = PixelY
                OldMOUSEx = MouseX: OldMOUSEy = MouseY
                HideMOUSE
                Get (30, 194)-(119, 261), UndoBOX()
                ShowMOUSE
                While LB
                    MouseSTATUS LB, RB, MouseX, MouseY
                    GoSub SetPIXEL
                    View Screen(166, 56)-(166 + Scale * 90 - 1, 56 + Scale * 68 - 1)
                    Line (OldMOUSEx - 2, OldMOUSEy - 2)-(MouseX - 2, MouseY - 2), WClr
                    Line (OldMOUSEx - 1, OldMOUSEy - 1)-(MouseX - 1, MouseY - 1), WClr
                    Line (OldMOUSEx, OldMOUSEy)-(MouseX, MouseY), WClr
                    View Screen(30, 194)-(119, 261)
                    Line (OldPIXELx + 29, OldPIXELy + 193)-(PixelX + 29, PixelY + 193), WClr
                    ShowMOUSE
                    PauseMOUSE LB, RB, MouseX, MouseY
                    OldPIXELx = PixelX: OldPIXELy = PixelY
                    OldMOUSEx = MouseX: OldMOUSEy = MouseY
                Wend
                Timer On
                View
                ScaleUP
                Workdone = 1
            End If
        Case 5 'Box tool
            If LB Then
                Timer Off
                GoSub SetPIXEL
                HideMOUSE
                Get (166, 56)-(435, 259), WindowBOX()
                Get (30, 194)-(119, 261), WindowBOX(14000)
                Get (30, 194)-(119, 261), UndoBOX()
                ShowMOUSE
                LocateMOUSE ScalePIXELx, ScalePIXELy
                TopLEFTx = PixelX
                TopLEFTy = PixelY
                TopLEFTxx = ScalePIXELx + 2
                TopLEFTyy = ScalePIXELy + 2
                While LB
                    MouseSTATUS LB, RB, MouseX, MouseY
                    GoSub SetPIXEL
                    HideMOUSE
                    View Screen(166, 56)-(435, 259)
                    Put (166, 56), WindowBOX(), PSet
                    Line (TopLEFTxx, TopLEFTyy)-(ScalePIXELx + 4, ScalePIXELy + 2), WClr, B
                    Line (TopLEFTxx + 1, TopLEFTyy + 1)-(ScalePIXELx + 3, ScalePIXELy + 3), WClr, B
                    Line (TopLEFTxx + 2, TopLEFTyy + 2)-(ScalePIXELx + 2, ScalePIXELy + 4), WClr, B
                    View Screen(30, 194)-(119, 261)
                    Put (30, 194), WindowBOX(14000), PSet
                    Line (TopLEFTx + 29, TopLEFTy + 193)-(PixelX + 29, PixelY + 193), WClr, B
                    ShowMOUSE
                    PauseMOUSE LB, RB, MouseX, MouseY
                Wend
                If Filled = 1 Then
                    HideMOUSE
                    View Screen(30, 194)-(119, 261)
                    Line (TopLEFTx + 29, TopLEFTy + 193)-(PixelX + 29, PixelY + 193), WClr, BF
                    ShowMOUSE
                End If
                View
                ScaleUP
                Workdone = 1
                Timer On
            End If
        Case 6, 7 'Circle/Elipse tools
            If LB Then
                Timer Off
                HideMOUSE
                Get (166, 56)-(435, 259), WindowBOX()
                Get (30, 194)-(119, 261), WindowBOX(14000)
                Get (30, 194)-(119, 261), UndoBOX()
                ShowMOUSE
                View Screen(166, 56)-(435, 259)
                GoSub SetPIXEL
                CircleXX = ScalePIXELx + 3
                CircleYY = ScalePIXELy + 2
                CircleX = PixelX
                CircleY = PixelY
                While LB
                    MouseSTATUS LB, RB, MouseX, MouseY
                    GoSub SetPIXEL
                    Radius = Sqr((ScalePIXELx - CircleXX) ^ 2 + (ScalePIXELy - CircleYY) ^ 2)
                    LilRADIUS = Radius / 3
                    If WorkingTOOL = 6 Then
                        Elipse! = 1
                    Else
                        If ScalePIXELx > CircleXX Then
                            Adjacent = ScalePIXELx - CircleXX
                        Else
                            Adjacent = CircleXX - ScalePIXELx
                        End If
                        If ScalePIXELy > CircleYY Then
                            Opposite = ScalePIXELy - CircleYY
                        Else
                            Opposite = CircleYY - ScalePIXELy
                        End If
                        Elipse! = Opposite / (Adjacent + .01)
                    End If
                    HideMOUSE
                    View Screen(166, 56)-(435, 259)
                    Put (166, 56), WindowBOX(), PSet
                    Circle (CircleXX, CircleYY), Radius, WClr, , , Elipse!
                    Circle (CircleXX, CircleYY), Radius + 1, WClr, , , Elipse!
                    Circle (CircleXX, CircleYY), Radius + 2, WClr, , , Elipse!
                    View Screen(30, 194)-(119, 261)
                    Put (30, 194), WindowBOX(14000), PSet
                    Circle (CircleX + 29, CircleY + 193), LilRADIUS, WClr, , , Elipse!
                    ShowMOUSE
                    PauseMOUSE LB, RB, MouseX, MouseY
                Wend
                If Filled = 1 Then
                    HideMOUSE
                    View Screen(30, 194)-(119, 261)
                    For Radii = LilRADIUS To 1 Step -1
                        Circle (CircleX + 29, CircleY + 193), Radii, WClr, , , Elipse!
                        If Radii = LilRADIUS Then
                            If LilRADIUS > 2 Then
                                Circle (CircleX + 29, CircleY + 194), Radii, WClr, 0, 3.14259, Elipse!
                            End If
                        Else
                            If LilRADIUS > 2 Then
                                Circle (CircleX + 29, CircleY + 194), Radii, WClr, , , Elipse!
                            End If
                        End If
                    Next Radii
                    If LilRADIUS = 1 Then PSet (CircleX + 29, CircleY + 193), WClr
                    If LilRADIUS = 2 Then
                        Line (CircleX + 28, CircleY + 192)-(CircleX + 30, CircleY + 194), WClr, BF
                    End If
                    ShowMOUSE
                End If
                View
                ScaleUP
                Workdone = 1
                Timer On
            End If
        Case 8 'Line tool
            If LB Then
                Timer Off
                GoSub SetPIXEL
                HideMOUSE
                Get (166, 56)-(435, 259), WindowBOX()
                Get (30, 194)-(119, 261), WindowBOX(14000)
                Get (30, 194)-(119, 261), UndoBOX()
                ShowMOUSE
                LocateMOUSE ScalePIXELx, ScalePIXELy
                LEFTx = PixelX
                LEFTy = PixelY
                LEFTxx = ScalePIXELx + 3
                LEFTyy = ScalePIXELy + 3
                While LB
                    MouseSTATUS LB, RB, MouseX, MouseY
                    GoSub SetPIXEL
                    HideMOUSE
                    View Screen(166, 56)-(435, 259)
                    Put (166, 56), WindowBOX(), PSet
                    Line (LEFTxx - 1, LEFTyy - 1)-(ScalePIXELx - 1, ScalePIXELy - 1), WClr
                    Line (LEFTxx, LEFTyy)-(ScalePIXELx, ScalePIXELy), WClr
                    Line (LEFTxx + 1, LEFTyy + 1)-(ScalePIXELx + 1, ScalePIXELy + 1), WClr
                    View Screen(30, 194)-(119, 261)
                    Put (30, 194), WindowBOX(14000), PSet
                    Line (LEFTx + 29, LEFTy + 193)-(PixelX + 28, PixelY + 192), WClr
                    ShowMOUSE
                    PauseMOUSE LB, RB, MouseX, MouseY
                Wend
                View
                ScaleUP
                Workdone = 1
                Timer On
            End If
        Case 9 'Paint tool
            If LB Then
                Timer Off
                HideMOUSE
                Get (30, 194)-(119, 261), UndoBOX()
                If Scale = 5 Then
                    View Screen(166, 56)-(615, 395)
                Else
                    View Screen(166, 56)-(435, 259)
                End If
                Paint (MouseX, MouseY), WClr
                View Screen(30, 194)-(119, 261)
                Paint (PixelX + 29, PixelY + 193), WClr
                ClearMOUSE
                View
                ShowMOUSE
                Workdone = 1
                Timer On
                Interval .2
            End If
        Case 10 'Mask tool
            If LB = -1 Then
                Timer Off
                HideMOUSE
                ScaleUP
                Get (166, 56)-(435, 259), WindowBOX()
                Get (30, 194)-(119, 261), UndoBOX()
                ShowMOUSE
                TopLEFTx = MouseX: If TopLEFTx < 166 Then TopLEFTx = 166
                TopLEFTy = MouseY: If TopLEFTy < 56 Then TopLEFTy = 56
                While LB = -1
                    MouseSTATUS LB, RB, MouseX, MouseY
                    HideMOUSE
                    Put (166, 56), WindowBOX(), PSet
                    If MouseX > 435 Then MouseX = 435
                    If MouseY > 259 Then MouseY = 259
                    If MouseX < 166 Then MouseX = 166
                    If MouseY < 56 Then MouseY = 56
                    Line (TopLEFTx, TopLEFTy)-(MouseX, MouseY), 0, B
                    Line (TopLEFTx, TopLEFTy)-(MouseX, MouseY), 15, B , &HCCCC
                    ShowMOUSE
                Wend
                CopyWIDTH = Int((MouseX - TopLEFTx) / 3)
                CopyDEPTH = Int((MouseY - TopLEFTy) / 3)
                TopLEFTx = (TopLEFTx - 166) / 3 + 30: TopLEFTy = (TopLEFTy - 56) / 3 + 194
                BottomRIGHTx = TopLEFTx + CopyWIDTH: BottomRIGHTy = TopLEFTy + CopyDEPTH
                Mask = 1
                Timer On
            End If
        Case 12 'Swap colors tool
            If LB Then
                HideMOUSE
                Get (30, 194)-(119, 261), UndoBOX()
                RefCOLOR = Point(MouseX, MouseY)
                For x = 30 To 119
                    For y = 194 To 261
                        If Point(x, y) = RefCOLOR Then PSet (x, y), WClr
                    Next y
                Next x
                ScaleUP
                Workdone = 1
                ShowMOUSE
            End If
    End Select

    Exit Sub

    SetPIXEL:
    PixelX = Int((MouseX - 167) / Scale) + 1
    PixelY = Int((MouseY - 57) / Scale) + 1
    ScalePIXELx = PixelX * Scale + 161
    ScalePIXELy = PixelY * Scale + 51
    Return

End Sub
 
Sub ABSOLUTE_MOUSE_EMU (AX%, BX%, CX%, DX%)
    Select Case AX%
        Case 0
            AX% = -1
        Case 1
            _MouseShow
        Case 2
            _MouseHide
        Case 3
            While _MouseInput
            Wend
            BX% = -_MouseButton(1) - _MouseButton(2) * 2 - _MouseButton(3) * 4
            CX% = _MouseX
            DX% = _MouseY
        Case 4
            _MouseMove CX%, DX% 'Not currently supported in QB64 GL
    End Select
End Sub
