'****************************************************************************'
'
'------------------------- A B A C U S 1 2. B A S ---------------------------'
'--------------- Copyright (C) 2007 by Bob Seguin (Freeware) ----------------'
'
'****************************************************************************'

DefInt A-Z

DECLARE FUNCTION InitMOUSE ()

DECLARE SUB MouseSTATUS (LB, RB, MouseX, MouseY)
DECLARE SUB ShowMOUSE ()
DECLARE SUB HideMOUSE ()
DECLARE SUB ClearMOUSE ()

DECLARE SUB MouseDRIVER (LB, RB, MX, MY)

DECLARE SUB Graphics ()
DECLARE SUB PutBEADS (col, OneVAL)
DECLARE SUB PutNUM (col)
DECLARE SUB Menu (InOUT)
DECLARE SUB ResetABACUS ()

Dim Shared Box(26000)
Dim Shared NumBOX(1 To 250)
Dim Shared MenuBOX(600)
Def Seg = VarSeg(NumBOX(1))
BLoad "abanums.bsv", VarPtr(NumBOX(1))
Def Seg = VarSeg(MenuBOX(0))
BLoad "abamenu.bsv", VarPtr(MenuBOX(0))
Def Seg
Dim Shared Abacus(1 To 10, 1 To 2)

Dim Shared MouseDATA$
Dim Shared LB, RB

'Create and load MouseDATA$ for CALL ABSOLUTE routines
Cheddar:
Data 55,89,E5,8B,5E,0C,8B,07,50,8B,5E,0A,8B,07,50,8B,5E,08,8B
Data 0F,8B,5E,06,8B,17,5B,58,1E,07,CD,33,53,8B,5E,0C,89,07,58
Data 8B,5E,0A,89,07,8B,5E,08,89,0F,8B,5E,06,89,17,5D,CA,08,00
MouseDATA$ = Space$(57)
Restore Cheddar
For i = 1 To 57
    Read h$
    Hexxer$ = Chr$(Val("&H" + h$))
    Mid$(MouseDATA$, i, 1) = Hexxer$
Next i

Moused = InitMOUSE
If Not Moused Then
    Print "Sorry, cat must have got the mouse."
    Sleep 2
    System
End If

Screen 12

GoSub SetPALETTE
Graphics
ShowMOUSE

Do
    k$ = InKey$
    If k$ = Chr$(27) Then System
    MouseSTATUS LB, RB, MouseX, MouseY
    Select Case MouseX
        Case 212 TO 233: col = 1
        Case 234 TO 255: col = 2
        Case 256 TO 277: col = 3
        Case 278 TO 299: col = 4
        Case 300 TO 321: col = 5
        Case 322 TO 343: col = 6
        Case 344 TO 365: col = 7
        Case 366 TO 387: col = 8
        Case 388 TO 409: col = 9
        Case 410 TO 431: col = 10
        Case Else: col = 0
    End Select
    Select Case MouseY
        Case 124 TO 133: Menu 1
        Case 161 TO 176: row = 1
        Case 177 TO 192: row = 2
        Case 202 TO 218: row = 3
        Case 219 TO 234: row = 4
        Case 235 TO 250: row = 5
        Case 251 TO 266: row = 6
        Case 267 TO 282: row = 7
        Case Else: row = 0: Menu 0
    End Select

    If LB = -1 Then
        If col <> 0 Then
            Select Case row
                Case 1: PutBEADS col, 6: Abacus(col, 1) = 5
                Case 2: PutBEADS col, 5: Abacus(col, 1) = 0
                Case 3 TO 7: Sum = row - 3: Abacus(col, 2) = Sum: PutBEADS col, Sum
            End Select
            PutNUM col
        End If
        ClearMOUSE
    End If

Loop

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

Sub ClearMOUSE

    While LB Or RB
        MouseSTATUS LB, RB, MouseX, MouseY
    Wend

End Sub

Sub Graphics

    Def Seg = VarSeg(Box(0))
    For y = 0 To 320 Step 160
        FileCOUNT = FileCOUNT + 1
        FileNAME$ = "ABACUS" + LTrim$(RTrim$(Str$(FileCOUNT))) + ".BSV"
        BLoad FileNAME$, VarPtr(Box(0))
        Put (0, y), Box()
    Next y
    BLoad "abasets.bsv", VarPtr(Box(0))
    Def Seg

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

Sub Menu (InOUT)
    Static MenuITEM

    If InOUT = 0 Then GoSub CloseMENU: Exit Sub

    MouseSTATUS LB, RB, MouseX, MouseY
    Select Case MouseX
        Case 210 TO 238
            If MenuITEM <> 1 Then
                GoSub CloseMENU
                MenuITEM = 1
                GoSub OpenMENU
            End If
        Case 412 TO 432
            If MenuITEM <> 2 Then
                GoSub CloseMENU
                MenuITEM = 2
                GoSub OpenMENU
            End If
        Case Else: GoSub CloseMENU
    End Select

    If LB = -1 Then
        Select Case MenuITEM
            Case 1: ResetABACUS
            Case 2: GoSub CloseMENU: System
        End Select
    End If

    Exit Sub

    OpenMENU:
    HideMOUSE
    Select Case MenuITEM
        Case 1: Put (210, 124), MenuBOX(200), PSet
        Case 2: Put (412, 124), MenuBOX(300), PSet
    End Select
    ShowMOUSE
    Return

    CloseMENU:
    If MenuITEM <> 0 Then
        HideMOUSE
        Select Case MenuITEM
            Case 1: Put (210, 124), MenuBOX(), PSet
            Case 2: Put (412, 124), MenuBOX(100), PSet
        End Select
        ShowMOUSE
        MenuITEM = 0
    End If
    Return

End Sub

Sub MouseDRIVER (LB, RB, MX, MY)

    Def Seg = VarSeg(MouseDATA$)
    mouse = SAdd(MouseDATA$)
    Call ABSOLUTE_MOUSE_EMU(LB, RB, MX, MY)

End Sub

Sub MouseSTATUS (LB, RB, MouseX, MouseY)

    LB = 3
    MouseDRIVER LB, RB, MX, MY
    LB = ((RB And 1) <> 0)
    RB = ((RB And 2) <> 0)
    MouseX = MX
    MouseY = MY

End Sub

Sub PutBEADS (col, BeadVAL)

    PutCOL = col * 22 + 192
    If BeadVAL > 4 Then Hop = -43 Else Hop = 0
    HideMOUSE
    Put (PutCOL, 204 + Hop), Box(BeadVAL * 1000 + 10000), PSet
    ShowMOUSE

End Sub

Sub PutNUM (col)
    Sum = Abacus(col, 1) + Abacus(col, 2)
    HideMOUSE
    Put (col * 22 + 198, 320), NumBOX(Sum * 25 + 1), PSet
    ShowMOUSE
End Sub

Sub ResetABACUS

    HideMOUSE
    Put (212, 161), Box(), PSet
    ShowMOUSE
    Erase Abacus

End Sub

Sub ShowMOUSE
    LB = 1
    MouseDRIVER LB, 0, 0, 0
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
