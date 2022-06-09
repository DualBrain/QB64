'-----------------------------------------------------------------------------------------------------
' These are some metacommands and compiler options for QB64 to write modern & type-strict code
'-----------------------------------------------------------------------------------------------------
' This will disable prefixing all modern QB64 calls using a underscore prefix.
$NoPrefix
' Whatever indentifiers are not defined, should default to signed longs (ex. constants and functions).
DefLng A-Z
' All variables must be defined.
Option Explicit
' All arrays must be defined.
Option ExplicitArray
' Array lower bounds should always start from 1 unless explicitly specified.
' This allows a(4) as integer to have 4 members with index 1-4.
Option Base 1
' This game erases arrays and does not redim them. So we use static arrays instead.
'$Static
' This allows the executable window & it's contents to be resized.
$Resize:Smooth
Title "Tic Tac Toe"
'-----------------------------------------------------------------------------------------------------

Const FALSE = 0, TRUE = Not FALSE

Dim Shared SymbolBOX(0 To 6000) As Integer '<---NOTE
Dim Shared curH As Integer: 'Cursor Position Horizontal
Dim Shared curV As Integer: 'Cursor Position Vertical
Dim Shared click As Integer: ' 0=no click, 1=left click, 2=right
' EnableMouse 1 = Turn cursor on, return coordinates
' EnableMouse 0 = Turn cursor off in order to draw stuff, etc.
Dim Shared cC As String: 'User pressed key
' GetUserSignal will set return cC or will return Click

Dim As Integer i, j, k, r, ds, WhoWon, t, TestType, MadeAMove, MovesMade, dd, dz
Dim As String tk, w1, w2, c

' ----------------------------------------------------------
' Title Screen (Main Program)
' -----------------------------------------------------------
Screen 12
AllowFullScreen SquarePixels , Smooth

Randomize Timer
Dim Command As Integer, Hard As Integer
GoSub InitializeScreen
Do
    Do: GetUserSignal: Loop Until click = 1
    GoSub FindClickedCommand
    Select Case Command
        Case 1:
            Hard = FALSE
            WhoWon = 0
            GoSub PlayGame
            GoSub ShowWhoWon
            GoSub InitializeScreen
        Case 2:
            Hard = TRUE
            WhoWon = 0
            GoSub PlayGame
            GoSub ShowWhoWon
            GoSub InitializeScreen
        Case 3:
            GoSub DoHelp
            GoSub InitializeScreen
        Case 4:
            Exit Do
    End Select
Loop
Color 7: Cls
System 0

' ----------------------------------------------------------
' Game Screen
' -----------------------------------------------------------
Dim Shared zX(9) As Integer: ' Where all X's are placed
Dim Shared zO(9) As Integer: ' Where all O's are placed
Dim Shared zE(9) As Integer: ' Where empty squares are
Dim theRow As Integer, theColumn As Integer, theBox As Integer

FindClickedPosition:
Const Delta = 4
theRow = 0: theColumn = 0: theBox = 0
Select Case curH
    Case Is < 170 + Delta: Return
    Case Is < 269 - Delta: theColumn = 1
    Case Is < 269 + Delta: Return
    Case Is < 368 - Delta: theColumn = 2
    Case Is < 368 + Delta: Return
    Case Is < 467 - Delta: theColumn = 3
    Case Else: Return
End Select
Select Case curV
    Case Is < 91 + Delta: Return
    Case Is < 190 - Delta: theRow = 1
    Case Is < 190 + Delta: Return
    Case Is < 289 - Delta: theRow = 2
    Case Is < 289 + Delta: Return
    Case Is < 388 - Delta: theRow = 3
    Case Else: Return
End Select
theBox = (3 * (theRow - 1)) + theColumn
Return

' ----------------------------------------------------------
' Play Game
' -----------------------------------------------------------
PlayGame:
DrawSCREEN 'draw the screen and create X and O symbols.
For i = 1 To 9: zO(i) = FALSE: zX(i) = FALSE: zE(i) = TRUE: Next i
MovesMade = 0
Do
    GetUserSignal
    If click Then
        MadeAMove = FALSE
        GoSub MakeX
        If MadeAMove Then
            WhoWon = 1: GoSub ComputeWin: If WhoWon = 1 Then Return
            t% = 0
            For i = 1 To 9: t% = t% + zX(i): Next i
            If t% = -5 Then WhoWon = 0: Return
            MovesMade = MovesMade + 1
            GoSub MakeO
            WhoWon = 2: GoSub ComputeWin: If WhoWon = 2 Then Return
        End If
    End If
    If cC = "d" Or cC = Chr$(27) Then WhoWon = 3
    If WhoWon > 0 Then Return
Loop

MakeX:
GoSub FindClickedPosition
If theBox = 0 Then Return
If Not zE(theBox) Then Return
xo theRow, theColumn, 1: ' Places an X
zX(theBox) = TRUE: zE(theBox) = FALSE
MadeAMove = TRUE
Return

MakeO:
GoSub FindPlaceForO
Sleep 1: While InKey$ <> "": Wend
xo theRow, theColumn, 0: 'Places an O
zO(theBox) = TRUE: zE(theBox) = FALSE
Return

ComputeWin:
If WhoWon = 1 Then
    If XWin(1, 2, 3, 1) Then Return
    If XWin(4, 5, 6, 2) Then Return
    If XWin(7, 8, 9, 3) Then Return
    If XWin(1, 4, 7, 4) Then Return
    If XWin(2, 5, 8, 5) Then Return
    If XWin(3, 6, 9, 6) Then Return
    If XWin(1, 5, 9, 7) Then Return
    If XWin(3, 5, 7, 8) Then Return
Else
    If OWin(1, 2, 3, 1) Then Return
    If OWin(4, 5, 6, 2) Then Return
    If OWin(7, 8, 9, 3) Then Return
    If OWin(1, 4, 7, 4) Then Return
    If OWin(2, 5, 8, 5) Then Return
    If OWin(3, 6, 9, 6) Then Return
    If OWin(1, 5, 9, 7) Then Return
    If OWin(3, 5, 7, 8) Then Return
End If
WhoWon = 0
Return

FindPlaceForO:
' See if there is a win for O. If so, take it.
' See if there is a threat of a win for X. If so, block it.
For TestType% = 1 To 2
    theBox = 0
    For theRow = 1 To 3: For theColumn = 1 To 3
        theBox = theBox + 1
        If zE(theBox) Then
            tk$ = ""
            Select Case theBox
                Case 1: tk$ = "234759"
                Case 2: tk$ = "1358"
                    Case 3: tk$ = "126957"
                    Case 4: tk$ = "1756"
                    Case 5: tk$ = "19283746"
                    Case 6: tk$ = "4539"
                    Case 7: tk$ = "148935"
                    Case 8: tk$ = "2579"
                    Case 9: tk$ = "153678"
                End Select
                For i = 1 To Len(tk$) Step 2
                    j = Val(Mid$(tk$, i, 1))
                    k = Val(Mid$(tk$, i + 1, 1))
                    If TestType% = 1 Then
                        If zO(j) + zO(k) < -1 Then Return
                    Else
                        If zX(j) + zX(k) < -1 Then Return
                    End If
                Next i
            End If
    Next theColumn: Next theRow
Next TestType%
' No move selected above to win or block win, so
If Hard Then
    If MovesMade = 1 Then
        If zE(5) Then
            theRow = 2: theColumn = 2: theBox = 5
        Else
            If Rnd > .5 Then theRow = 1 Else theRow = 3
            If Rnd > .5 Then theColumn = 1 Else theColumn = 3
            theBox = (3 * (theRow - 1)) + theColumn
        End If
        Return
    ElseIf MovesMade = 2 Then
        If zX(5) Then
            tk$ = ""
            If zO(1) And zX(9) Then
                tk$ = "37"
            ElseIf zO(3) And zX(7) Then
                tk$ = "19"
            ElseIf zO(7) And zX(3) Then
                tk$ = "19"
            ElseIf zO(9) And zX(1) Then
                tk$ = "37"
            End If
            If tk$ <> "" Then
                If Rnd > .5 Then
                    theBox = Val(Left$(tk$, 1))
                Else
                    theBox = Val(Left$(tk$, 1))
                End If
                theRow = (theBox + 2) \ 3
                theColumn = theBox - (3 * (theRow - 1))
                Return
            End If
        Else
            Do
                Do: theBox = 2 * Int(1 + (Rnd * 4)): Loop While Not zE(theBox)
                Select Case theBox
                    Case 2: If Not zX(8) Then Exit Do
                    Case 4: If Not zX(6) Then Exit Do
                    Case 6: If Not zX(4) Then Exit Do
                    Case 8: If Not zX(2) Then Exit Do
                End Select
            Loop
            theRow = (theBox + 2) \ 3
            theColumn = theBox - (3 * (theRow - 1))
            Return
        End If
    End If
End If
' OK, no good move was found. Make a random one
Do: theBox = 1 + Int(Rnd * 9): Loop While Not zE(theBox)
theRow = (theBox + 2) \ 3
theColumn = theBox - (3 * (theRow - 1))
Return

Shuffle:
Do While Len(w1$) < 4
    r% = 1 + Int(Rnd * 4)
    If Mid$(w2$, r%, 1) <> "x" Then
        w1$ = w1$ + Mid$(w2$, r%, 1)
        Mid$(w2$, r%, 1) = "x"
    End If
Loop
Return

ShowWhoWon:
Select Case WhoWon
    Case 0: c$ = "Tie! "
    Case 1: c$ = "YOU WIN! "
    Case 2: c$ = "YOU LOSE! "
    Case 3: c$ = "YOU RESIGNED?"
End Select
If WhoWon < 3 Then Sleep 2: While InKey$ <> "": Wend
Cls
For i = 1 To 30
    Color 1 + Int(Rnd * 15)
    Locate i, i + 20
    Print c$;
Next i
Sleep 3: While InKey$ <> "": Wend
Return

InitializeScreen:
Cls
Color 15
Locate 4, 23: Print "TIC TAC TOE by Paul Meyer & TheBOB"
Locate 6, 27: Print "(C) 2004 - 2007 Dos-Id Games"
Color 3
ds% = 131: dd% = 97: dz% = 75
Line (ds%, 343)-(ds% + dz%, 380), , BF
Line (ds% + (1 * dd%), 343)-(ds% + (1 * dd%) + dz%, 380), , BF
Line (ds% + (2 * dd%), 343)-(ds% + (2 * dd%) + dz%, 380), , BF
Line (ds% + (3 * dd%), 343)-(ds% + (3 * dd%) + dz%, 380), , BF
Locate 23, 19: Print " Easy ";
Locate , 31: Print " Hard ";
Locate , 43: Print " Info ";
Locate , 55: Print " Quit "
Return

FindClickedCommand:
Command = 0
Select Case curV
    Case Is < 343: Return
    Case Is > 380: Return
End Select
Select Case curH
    Case Is < 130: Return
    Case Is < 205: Command = 1
    Case Is < 227: Return
    Case Is < 303: Command = 2
    Case Is < 325: Return
    Case Is < 400: Command = 3
    Case Is < 421: Return
    Case Is < 497: Command = 4
End Select
Return


DoHelp:
Cls
Color 2
Locate 3, 1
Print "Credits"
Print "-------"
Print "This game was created by Paul Meyer in the year 2007."
Print: Print "Graphics by TheBob"
Print: Print "Improved mouse driver, modularity, machine play-to-win";
Print " by QBasic Mac"
Print: Print "History:"
Print "http://www.network54.com/Forum/190883/message/1175106480"
Print
Print "This is freeware, you may change this as much as you want"
Print "as long as you don't claim it as yours."
Print
Print
Print "About"
Print "-----"
Print "This is just a simple TIC TAC TOE game with mouse drivers."
Print "This game was created in QuickBasic."
Call GetUserSignal
Cls
Return

Sub DrawSCREEN
    Dim x As Integer, y As Integer
    Static Finished As Integer
    Cls
    Out &H3C8, 0: Out &H3C9, 0: Out &H3C9, 0: Out &H3C9, 18
    Out &H3C8, 4: Out &H3C9, 63: Out &H3C9, 0: Out &H3C9, 0
    Out &H3C8, 9: Out &H3C9, 0: Out &H3C9, 12: Out &H3C9, 48
    Out &H3C8, 11: Out &H3C9, 0: Out &H3C9, 18: Out &H3C9, 54
    Color 7: Locate 3, 31: Print "T I C - T A C - T O E"
    Line (170, 90)-(490, 410), 0, BF
    Line (160, 81)-(479, 399), 1, BF
    Line (155, 76)-(483, 404), 8, B
    Line (152, 73)-(487, 407), 8, B
    Line (160, 81)-(160, 399), 9
    Line (160, 81)-(479, 81), 9
    Line (371, 92)-(372, 393), 0, B
    Line (271, 92)-(272, 392), 0, B
    Line (171, 191)-(472, 192), 0, B
    Line (171, 291)-(472, 292), 0, B
    Line (369, 90)-(370, 390), 13, B
    Line (269, 90)-(270, 390), 13, B
    Line (169, 189)-(470, 190), 13, B
    Line (169, 289)-(470, 290), 13, B
    Line (5, 5)-(634, 474), 8, B
    Line (10, 10)-(629, 469), 8, B
    If Finished Then Exit Sub
    Finished = TRUE
    For x = 194 To 500
        For y = 32 To 46
            If Point(x, y) = 8 Then PSet (x, y), 7
        Next y
    Next x
    PSet (188, 108), 0
    Draw "E3 F30 E30 F6 G30 F30 G6 H30 G30 H6 E30 H30 E3 BF2 P0,0"
    PSet (186, 106), 10
    Draw "E3 F30 E30 F6 G30 F30 G6 H30 G30 H6 E30 H30 E3 BF2 P10,10"
    Circle (322, 141), 31, 0
    Circle (322, 141), 37, 0
    Paint Step(0, 35), 0
    PSet Step(0, -35), 0
    Circle (320, 139), 31, 4
    Circle (320, 139), 37, 4
    Paint Step(0, 35), 4
    PSet Step(0, -35), 1
    Get Step(-40, -40)-Step(81, 81), SymbolBOX()
    Get (179, 98)-(260, 178), SymbolBOX(3000)
    xo 1, 1, 2: xo 1, 2, 2
End Sub

Sub EnableMouse (c%)
    Static Status As Integer
    Dim As String m, n, H
    Dim As Integer i

    If Status = 0 And c% = 0 Then Exit Sub
    Static Mx As String
    If Mx = "" Then
        m$ = "58E85080585080585080850815510C358508058508085080850815C00"
        n$ = "595BECB70BEAB70BE8BFBE6B7B8E7D33BEC978BEA97BE89FBE697DA80"
        Mx = Space$(57)
        For i% = 1 To 57
            H$ = Chr$(Val("&H" + Mid$(m$, i%, 1) + Mid$(n$, i%, 1)))
            Mid$(Mx, i%, 1) = H$
        Next i%
    End If
    If c% = 0 Then
        Call Absolute(2, click, curH, curV, SAdd(Mx))
        Status = 0
        Exit Sub
    End If
    If Status = 0 Then Call Absolute(1, click, curH, curV, SAdd(Mx))
    Status = 1
    Call Absolute(3, click, curH, curV, SAdd(Mx))
End Sub

Sub GetUserSignal
    Dim As Integer k

    Do
        If 0 Then ' Set to 1 for Debugging printout, otherwise 0
            Locate 2, 1
            Print click; "<Click"
            Print curH; "ch (Horizontal)"
            Print curV; "cv (Verticle)"
        End If
        EnableMouse 1
        If click > 0 Then
            k% = click
            While click <> 0: EnableMouse 1: Wend
            click = k%
            Exit Do
        End If
        cC = InKey$
    Loop While cC = ""
    EnableMouse 0
End Sub

Function OWin% (b1 As Integer, b2 As Integer, b3 As Integer, l As Integer)
    If zO(b1) = 0 Or zO(b2) = 0 Or zO(b3) = 0 Then Exit Function
    Winner l
    OWin% = -1
End Function

Sub Winner (Lineup As Integer)
    Select Case Lineup
        Case 1: Line (200, 140)-(440, 142), 14, BF: Line (200, 143)-(440, 144), 0, B
        Case 2: Line (200, 240)-(440, 242), 14, BF: Line (200, 243)-(440, 244), 0, B
        Case 3: Line (200, 340)-(440, 342), 14, BF: Line (200, 343)-(440, 344), 0, B
        Case 4: Line (220, 120)-(222, 360), 14, BF: Line (223, 120)-(223, 360), 0
        Case 5: Line (320, 120)-(322, 360), 14, BF: Line (323, 120)-(323, 360), 0
        Case 6: Line (420, 120)-(422, 360), 14, BF: Line (423, 120)-(423, 360), 0
        Case 7: PSet (200, 120), 14: Draw "F240 d H240 d F240 d H240 d C0 F240 d H240"
        Case 8: PSet (440, 120), 14: Draw "G240 d E240 d G240 d E240 d C0 G240 d E240"
    End Select
End Sub

Sub xo (Row As Integer, Col As Integer, symbol As Integer)
    Dim Index As Integer, x As Integer, y As Integer
    x = (Col - 1) * 100 + 180
    y = (Row - 1) * 100 + 100
    Index = symbol * 3000
    If Index < 6000 Then
        Put (x, y), SymbolBOX(Index), PSet
    Else
        Line (x, y)-(x + 80, y + 80), 1, BF
    End If
End Sub

Function XWin% (b1 As Integer, b2 As Integer, b3 As Integer, l As Integer)
    If zX(b1) = 0 Or zX(b2) = 0 Or zX(b3) = 0 Then Exit Function
    Winner l
    XWin% = -1
End Function

