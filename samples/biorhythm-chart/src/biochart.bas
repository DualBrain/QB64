'****************************************************************************'
'------------------------- B I O C H A R T . B A S --------------------------'
'------------- Copyright (C) 2007 by Bob Seguin (Freeware)-------------------'
'****************************************************************************'

DefInt A-Z

Dim Shared NumBOX(300)
Dim Shared Box(12000)
Dim Shared FontBOX(6000)
Dim Shared xBOX(1 To 9)
Def Seg = VarSeg(FontBOX(0))
BLoad "brsmssb.fnt", VarPtr(FontBOX(0))
Def Seg = VarSeg(NumBOX(0))
BLoad "brsnums.bsv", VarPtr(NumBOX(0))
Def Seg

Const Degree! = 3.14159 / 180
Const Physical! = 90 / 23
Const Emotional! = 90 / 28
Const Intellectual! = 90 / 33
Const Intuitive! = 90 / 38

Dim Shared DATE2$, Birthdate$
Dim Shared Hour!
Dim Shared Months(1 To 12) As Integer
Restore MonthDATA
For n = 1 To 12: Read Months(n): Next n
Restore xDATA
For n = 1 To 8: Read xBOX(n): Next n

Screen 12
GoSub SetPALETTE
DATE2$ = Date$

Graphics
Birthday

Do
    k$ = UCase$(InKey$)
    Select Case k$
        Case "B"
            Put (162, 176), Box(), PSet
            B$ = GetDATE$
            If B$ = "NULL" Then
                System
            Else
                Birthdate$ = B$
                ChartBD
            End If
        Case "T"
            Put (162, 181), Box(3500), PSet
            B$ = GetDATE$
            If B$ = "NULL" Then DATE2$ = Date$ Else DATE2$ = B$
            Line (194, 419)-(294, 434), 0, BF
            PrintSTRING 196, 420, "DATE: " + DATE2$
            ChartBD
        Case Chr$(27): Exit Do
    End Select
Loop

System

xDATA:
Data 379,386,402,409,425,432,439,446

MonthDATA:
Data 31,28,31,30,31,30,31,31,30,31,30,31

SetPALETTE:
Restore SetPALETTE
Data 0,0,21,21,8,43,24,10,48,26,11,53
Data 28,12,58,32,13,63,63,63,21,42,42,42
Data 63,0,0,21,31,63,52,41,63,55,55,55
Data 0,0,42,63,21,63,32,32,42,63,63,63
Restore SetPALETTE
Out &H3C8, 0
For n = 1 To 48
    Read Colr
    Out &H3C9, Colr
Next n
Return

Sub Birthday

    Open "brbd.dta" For Binary As #1
    If LOF(1) Then
        Close #1
        Open "brbd.dta" For Input As #1
        Input #1, Birthdate$
        Close #1
    Else
        Close #1
        Put (162, 176), Box(), PSet
        B$ = GetDATE$
        If B$ = "NULL" Then
            System
        Else
            Birthdate$ = B$
        End If
    End If
    ChartBD

End Sub

Sub ChartBD

    Line (220, 89)-(420, 102), 0, BF
    PrintSTRING 240, 89, "For a person born"
    PrintSTRING 340, 89, Birthdate$
    Open "brbd.dta" For Output As #1
    Print #1, Birthdate$
    Close #1
    ChartGFX

    Hour! = Val(Mid$(Time$, 1, 2)) * .83
    Line (310 + Hour!, 110)-(310 + Hour!, 426), 11
    Line (310 + Hour!, 426)-(338, 426), 11
    PSet (310, 410), 7: Draw "D16L12"

    Month$ = Mid$(DATE2$, 1, 2)
    Day$ = Mid$(DATE2$, 4, 2)
    Year$ = Mid$(DATE2$, 7, 4)
    M$ = Mid$(Birthdate$, 1, 2)
    D$ = Mid$(Birthdate$, 4, 2)
    y$ = Mid$(Birthdate$, 7, 4)
    FirstMONTH = Months(Val(M$)) - Val(D$) + 1
    For n = (Val(M$) + 1) To 12
        BalMONTHS = BalMONTHS + Months(n)
        If n = 2 And ((Val(y$) Mod 4) = 0) Then BalMONTHS = BalMONTHS + 1
    Next n
    FirstYEAR = FirstMONTH + BalMONTHS
    For n = (Val(y$) + 1) To (Val(Year$) - 1)
        If n Mod 4 = 0 Then Yr = 366 Else Yr = 365
        TDays = TDays + Yr
    Next n
    TDays = TDays + FirstYEAR

    For n = 1 To Val(Month$) - 1
        Days = Days + Months(n)
        If n = 2 Then
            If Val(Year$) Mod 4 = 0 Then Days = Days + 1
        End If
    Next n

    TDays = TDays + Days + Val(Day$) - 1

    View Screen(10, 110)-(630, 410)

    'EMOTIONAL
    PreviousX = 320 - (((TDays Mod 28) + 28) * 20)
    PreviousY = 260
    C! = 0
    For x = 320 - (((TDays Mod 28) + 28) * 20) To 630 Step 5
        Line (PreviousX, PreviousY)-(x, 260 + Sin(C! * Degree!) * 150), 8
        PreviousX = x
        PreviousY = 260 + Sin(C! * Degree!) * 150
        C! = C! - Emotional!
    Next x

    'INTELLECTUAL
    PreviousX = 320 - (((TDays Mod 33) + 33) * 20)
    PreviousY = 260
    C! = 0
    For x = 320 - (((TDays Mod 33) + 33) * 20) To 630 Step 5
        Line (PreviousX, PreviousY)-(x, 260 + Sin(C! * Degree!) * 150), 6
        PreviousX = x
        PreviousY = 260 + Sin(C! * Degree!) * 150
        C! = C! - Intellectual!
    Next x

    PreviousX = 10
    PreviousY = 260
    C! = 0
    'PHYSICAL
    PreviousX = 320 - (((TDays Mod 23) + 23) * 20)
    PreviousY = 250
    For x = 320 - (((TDays Mod 23) + 23) * 20) To 630 Step 5
        Line (PreviousX, PreviousY)-(x, 260 + Sin(C! * Degree!) * 150), 9
        PreviousX = x
        PreviousY = 260 + Sin(C! * Degree!) * 150
        C! = C! - Physical!
    Next x


    'INTUITIVE
    PreviousX = 320 - (((TDays Mod 38) + 38) * 20)
    PreviousY = 260
    C! = 0
    For x = 320 - (((TDays Mod 38) + 38) * 20) To 630 Step 5
        Line (PreviousX, PreviousY)-(x, 260 + Sin(C! * Degree!) * 150), 13
        PreviousX = x
        PreviousY = 260 + Sin(C! * Degree!) * 150
        C! = C! - Intuitive!
    Next x

    View

End Sub

DefSng A-Z
Sub ChartGFX

    Line (5, 106)-(634, 414), 7, BF
    Line (9, 109)-(631, 170), 1, BF
    Line (9, 170)-(631, 230), 2, BF
    Line (9, 230)-(631, 290), 3, BF
    Line (9, 290)-(631, 350), 2, BF
    Line (9, 350)-(631, 411), 1, BF
    Line (9, 109)-(631, 411), 7, B
    For x = 30 To 610 Step 20
        Line (x, 110)-(x, 410), 7
        If x = 330 Then Paint (x - 10, 260), 7
    Next x
    Line (10, 260)-(630, 260), 7

End Sub

DefInt A-Z
Function GetDATE$
    i = 1: Interval! = .25: Colr = 15
    Do
        Wait &H3DA, 8: Wait &H3DA, 8, 8
        If i < 9 Then Line (xBOX(i) + 1, 201)-(xBOX(i) + 6, 202), Colr, B
        k$ = InKey$
        Select Case k$
            Case "0" To "9"
                If i < 9 Then
                    Line (xBOX(i) + 1, 201)-(xBOX(i) + 6, 202), 15, BF
                    PutNUMS xBOX(i), Val(k$)
                    D$ = D$ + k$
                    i = i + 1
                End If
            Case Chr$(13) 'Enter
                If Len(D$) = 8 Then
                    mm$ = Mid$(D$, 1, 2)
                    dd$ = Mid$(D$, 3, 2)
                    yy$ = Mid$(D$, 5, 4)
                    If Val(mm$) > 0 And Val(mm$) < 13 Then
                        If Val(dd$) > 0 And Val(dd$) < 32 Then
                            If Val(yy$) > 1900 And Val(yy$) < 3000 Then
                                GetDATE$ = mm$ + "-" + dd$ + "-" + yy$
                            Else
                                GetDATE$ = "NULL"
                            End If
                        Else
                            GetDATE$ = "NULL"
                        End If
                    Else
                        GetDATE$ = "NULL"
                    End If
                Else
                    GetDATE$ = "NULL"
                End If
                Exit Function
            Case Chr$(8) 'Backspace
                If i > 1 Then
                    If i < 9 Then Line (xBOX(i), 193)-(xBOX(i) + 6, 202), 15, BF
                    i = i - 1
                    Line (xBOX(i), 193)-(xBOX(i) + 6, 202), 15, BF
                    D$ = Mid$(D$, 1, Len(D$) - 1)
                End If
        End Select

        If Timer > StartTIME! + Interval! Then
            StartTIME! = Timer
            If Colr = 15 Then Colr = 7 Else Colr = 15
        End If

    Loop

End Function

Sub Graphics
    Def Seg = VarSeg(Box(0))
    BLoad "brsheads.bsv", VarPtr(Box(0))
    Def Seg
    Put (78, 32), Box()
    Put (20, 440), Box(7000)
    Put (10, 6), Box(10000)
    Put (500, 6), Box(11200)

    PrintSTRING 196, 420, "DATE: " + DATE2$
    PrintSTRING 342, 420, "TIME: " + Time$
    PrintSTRING 12, 460, "Press [B] to enter a new birth date"
    PrintSTRING 270, 460, "Press [T] to enter a target date"
    PrintSTRING 520, 460, "Press [ESC] to QUIT"

    ChartGFX

    Def Seg = VarSeg(Box(0))
    BLoad "brsinpt.bsv", VarPtr(Box(0))
    Def Seg

End Sub

Sub PrintSTRING (x, y, Prnt$)

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

End Sub

Sub PutNUMS (x, Num)
    Put (x, 191), NumBOX(Num * 30)
End Sub
