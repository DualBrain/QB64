'CHDIR ".\samples\pete\rectong"

DECLARE SUB AdvanceRound ()
DECLARE SUB SelectRounds ()
DECLARE SUB ShowControls ()
DECLARE SUB SelectDifficulty ()
DECLARE SUB DoAI ()
DECLARE SUB Player1Miss ()
DECLARE SUB Player2Miss ()
DECLARE SUB MoveBall ()
DECLARE SUB LaunchBall ()
DECLARE SUB DispStats ()
DECLARE SUB DrawBall ()
DECLARE SUB StartGame ()
DECLARE SUB InitCoord ()
DECLARE SUB DrawP2 ()
DECLARE SUB DrawP1 ()
DECLARE SUB LoadGFX ()
DECLARE SUB WipeEffect ()
DECLARE SUB Start2P ()
DECLARE SUB Start1P ()
DECLARE SUB ExitGame ()
DECLARE SUB MeltDown ()
DECLARE SUB FadePAL255 (fadetype!)
DECLARE SUB CenterText (sline!, Text AS STRING)
DECLARE SUB LoadPAL (filename AS STRING)
DECLARE SUB LoadFullBMP (filename AS STRING)

Dim Shared AIserve
Dim Shared butt(4, 32, 48)
Dim Shared ball(12, 12)
Dim Shared buttdir(1)
Dim Shared balldir(1)
Dim Shared rounds, cround
Dim Shared p1score, p2score
Dim Shared p1(1)
Dim Shared p2(1)
Dim Shared ballcor(1)
Dim Shared players
Dim Shared hasball
Dim Shared difflevel

Cls: Screen 13: Palette: Palette 255, 63 + 256 * 63 + 65536 * 63: Color 255

LoadGFX

Do
    InitCoord
    LoadPAL "gfx\title01.pal"
    LoadFullBMP "gfx\title01.rec"
    Do: Loop Until InKey$ = ""
    menusel = 1
    Do
        cround = 1
        Select Case menusel
            Case 1
                CenterText 2, Chr$(16) + "   1 Player  "
                CenterText 4, "    2 Player  "
                CenterText 6, "    Controls  "
                CenterText 8, "  Exit Rectong"
            Case 2
                CenterText 2, "    1 Player  "
                CenterText 4, Chr$(16) + "   2 Player  "
                CenterText 6, "    Controls  "
                CenterText 8, "  Exit Rectong"
            Case 3
                CenterText 2, "    1 Player  "
                CenterText 4, "    2 Player  "
                CenterText 6, Chr$(16) + "   Controls  "
                CenterText 8, "  Exit Rectong"
            Case 4
                CenterText 2, "    1 Player  "
                CenterText 4, "    2 Player  "
                CenterText 6, "    Controls  "
                CenterText 8, Chr$(16) + " Exit Rectong"
        End Select

        key$ = InKey$
        Select Case key$
            Case Chr$(0) + Chr$(72) 'Up
                If menusel > 1 Then menusel = menusel - 1
            Case Chr$(0) + Chr$(80) 'Down
                If menusel < 4 Then menusel = menusel + 1
            Case Chr$(13) 'Enter
                Select Case menusel
                    Case 1
                        players = 1: difflevel = 0: SelectDifficulty: If difflevel = 0 Then Exit Do
                        StartGame
                        Exit Do
                    Case 2
                        players = 2: StartGame: Exit Do
                    Case 3: ShowControls: Exit Do
                    Case 4
                        ExitGame
                End Select
        End Select
    Loop
Loop

Sub AdvanceRound
    cround = cround + 1
    If cround > rounds Then
        Cls
        If p1score > p2score Then winner = 1 Else winner = 2
        If p1score = p2score Then winner = -1
        If winner <> -1 Then
            CenterText 11, "GAME OVER! Player" + Str$(winner) + " is the winner!"
        Else
            CenterText 11, "GAME OVER! Both players tied!"
        End If
        CenterText 13, "Press Enter to continue..."
        Do: Loop Until InKey$ = Chr$(13)
    End If
End Sub

Sub CenterText (sline, Text As String)
    Locate sline, 20 - (Len(Text) / 2)
    Print Text;
End Sub

Sub DispStats
    Locate 25, 1: Color 255
    Print " 1P:" + Left$(Str$(p1score) + " goals  ", 8) + Space$(4) + "Round:" + Str$(cround) + Space$(3) + " 2P:" + Left$(Str$(p2score) + " Goals  ", 8);
    Line (0, 190)-(320, 190), 255
End Sub

Sub DoAI
    Select Case hasball
        Case 2
            If p2(1) < AIserve Then buttdir(1) = 2
            If p2(1) > AIserve Then buttdir(1) = 1
            If Fix(p2(1)) = Fix(AIserve) Then buttdir(1) = 0
            ballcor(1) = p2(1) + 24
            ballcor(0) = 280
            Exit Sub
        Case 1
            Exit Sub
    End Select

    'THIS LINE DOES PERFECT AI, JUST FOR DEBUGGING:
    'p2(1) = ballcor(1) - 6

    factor = Abs(ballcor(1) - (p2(1) - 24))
    difficulty = Fix(difflevel - (factor / 50))
    If difficulty < 0 Then difficulty = 0

    If Int(Rnd * difficulty) = 0 Then
        If Fix(p2(1)) + 24 > ballcor(1) Then buttdir(1) = 1
        If Fix(p2(1)) + 24 < ballcor(1) Then buttdir(1) = 2
        If Fix(p2(1)) + 24 = ballcor(1) Then buttdir(1) = 0
    Else
        buttdir(1) = 0
    End If
End Sub

Sub DrawBall
    For y = 1 To 12
        For x = 1 To 12
            colr = ball(x, y)
            'IF colr <> 4 THEN
            PSet (ballcor(0) + x - 6, ballcor(1) + y - 6), colr
        Next x
    Next y
    Line (ballcor(0) - 10, ballcor(1) - 13)-(ballcor(0) - 7, ballcor(1) + 15), 0, BF
    Line (ballcor(0) + 7, ballcor(1) - 7)-(ballcor(0) + 10, ballcor(1) + 7), 0, BF
    'LINE (ballcor(0) - 7, ballcor(1) - 15)-(ballcor(0) + 7, ballcor(1) - 13), 0, BF
    'LINE (ballcor(0) - 7, ballcor(1) + 13)-(ballcor(0) + 7, ballcor(1) + 15), 0, BF
    Line (ballcor(0) - 10, 0)-(ballcor(0) + 10, ballcor(1) - 7), 0, BF
    Line (ballcor(0) - 10, ballcor(1) + 7)-(ballcor(0) + 10, 189), 0, BF
End Sub

Sub DrawP1
    Line (0, 0)-(32, p1(1)), 0, BF
    Line (0, p1(1) + 49)-(32, 189), 0, BF
    For y = 1 To 48
        For x = 1 To 32
            colr = butt(p1(0), x, y)
            'IF colr <> 4 THEN
            PSet (x, y + p1(1)), colr
        Next x
    Next y
End Sub

Sub DrawP2
    Line (288, 0)-(320, p2(1)), 0, BF
    Line (288, p2(1) + 49)-(320, 189), 0, BF
    For y = 1 To 48
        For x = 1 To 32
            PSet (320 - x, y + p2(1)), butt(p2(0), x, y)
        Next x
    Next y
End Sub

Sub ExitGame
    Screen 0: Width 80: Color 7, 0: Cls
    Print "Rectong v1.0 (c)2005 Mike Chambers"
    Print "E-mail: half-eaten@yahoo.com"
    Print
    Print "Thanks for playing!"
    End
End Sub

Sub FadePAL255 (fadetype)
    Select Case fadetype
        Case 1
            For fader1 = 0 To 63
                Palette 255, fader1 + 256 * fader1 + 65536 * fader1
                t! = Timer: Do: Loop Until Timer - t! > 0
            Next fader1
        Case 0
            For fader1 = 63 To 0 Step -1
                Palette 255, fader1 + 256 * fader1 + 65536 * fader1
                t! = Timer: Do: Loop Until Timer - t! > 0
            Next fader1
    End Select
End Sub

Sub InitCoord
    p1(0) = 1: p2(0) = 1
    p1(1) = 68: p2(1) = 68
    ballcor(0) = 160: ballcor(1) = 92
    buttdir(0) = 0: buttdir(1) = 0
End Sub

Sub LaunchBall

End Sub

Sub LoadFullBMP (filename As String)
    Def Seg = &HB800
    ff = FreeFile
    Open filename For Binary As #ff
    For sposy = 1 To 200
        aget$ = Space$(320): Get #ff, , aget$
        For sposx = 1 To 320
            PSet (sposx, sposy), Asc(Mid$(aget$, sposx, 1))
        Next sposx
    Next sposy
    Close #ff
End Sub

Sub LoadGFX
    For loader = 1 To 4
        ff = FreeFile
        nm$ = Right$("0" + Mid$(Str$(loader), 2), 2)
        Open "gfx\butt" + nm$ + ".rec" For Binary As #ff
        For loady = 1 To 48
            ain$ = Space$(32): Get #ff, , ain$
            For loadx = 1 To 32
                butt(loader, loadx, loady) = Asc(Mid$(ain$, loadx, 1))
            Next loadx
        Next loady
        Close #ff
    Next loader

    Open "gfx\ball00.rec" For Binary As #ff
    For loady = 1 To 12
        ain$ = Space$(12): Get #ff, , ain$
        For loadx = 1 To 12
            ball(loadx, loady) = Asc(Mid$(ain$, loadx, 1))
        Next loadx
    Next loady
    Close #ff

End Sub

Sub LoadPAL (filename As String)
    ff = FreeFile
    Palette 255, 63 + 256 * 63 + 65536 * 63
    Open filename For Binary As #ff
    S$ = Space$(28): Get #ff, , S$
    For n = 1 To 255
        inpt$ = Space$(4)
        a$ = Space$(1)
        B$ = Space$(1)
        c$ = Space$(1)
        d$ = Space$(1)
        Get #ff, , inpt$
        a$ = Left$(inpt$, 1)
        B$ = Mid$(inpt$, 2, 1)
        c$ = Mid$(inpt$, 3, 1)

        rat = (255 / 63)
        r& = Asc(a$) / rat
        g& = Asc(B$) / rat
        B& = Asc(c$) / rat
        Palette n, r& + 256 * g& + 65536 * B&
    Next n
    Close #ff
End Sub

Sub MeltDown
    Do
        For psy = 1 To 200
            For psx = 1 To 320
                colr = Point(psx, psy)
                Line (psx, psy + Int(Rnd * 3))-(psx, psy + Int(Rnd * 30) + 8), colr
            Next psx
            Line (1, psy)-(320, psy), 0
            t! = Timer: Do: Loop Until Timer - t! > 0
        Next psy
    Loop Until InKey$ <> "" Or which = 4
End Sub

Sub MoveBall
    If hasball <> 0 Then Exit Sub

    ballcor(0) = ballcor(0) + balldir(0)
    ballcor(1) = ballcor(1) + balldir(1)

    'Check ball hitting stuff
    p1top = p1(1)
    p1bot = p1(1) + 48
    p2top = p2(1)
    p2bot = p2(1) + 48

    If balldir(1) = 0 Then fact = 1

    If ballcor(0) <= 32 Then 'if within X range of player 1 butt
        If ballcor(1) >= p1top And ballcor(1) <= p1bot Then
            yfactor = ((ballcor(1) - p1top) - 24)
            If yfactor <> 0 Then yfactor = yfactor / 25 Else yfactor = 0
            If balldir(1) = 0 Then fact = 1

            balldir(0) = -balldir(0)
            balldir(1) = yfactor '* fact
        End If
    End If

    If ballcor(0) >= 288 Then 'if within X range of player 1 butt
        If ballcor(1) >= p2top And ballcor(1) <= p2bot Then
            yfactor = ((ballcor(1) - p2top) - 24)
            If yfactor <> 0 Then yfactor = yfactor / 25 Else yfactor = 0

            balldir(0) = -balldir(0)
            balldir(1) = yfactor '* balldir(1)
        End If
    End If
    'End ball checking

    If ballcor(1) <= 7 Then ballcor(1) = 7: balldir(1) = -balldir(1)
    If ballcor(1) >= 183 Then ballcor(1) = 183: balldir(1) = -balldir(1)

    'Check for player missing ball
    If ballcor(0) < 25 Then Player1Miss 'If player 1 misses the ball
    If ballcor(0) > 295 Then Player2Miss 'If player 2 misses the ball
    'End check
End Sub

Sub Player1Miss
    AdvanceRound
    If cround > rounds Then Cls: Exit Sub
    p2score = p2score + 1
    hasball = 2: Cls
    CenterText 11, "PLAYER 1 MISSED THE BALL!"
    CenterText 13, "Next round: Player 2 starts."
    CenterText 14, "Press ENTER when ready."
    Do: Loop Until InKey$ = Chr$(13)
    InitCoord
    Randomize Timer
    AIserve = Int(Rnd * 130) + 5
    Cls
End Sub

Sub Player2Miss
    AdvanceRound
    If cround > rounds Then Cls: Exit Sub
    p1score = p1score + 1
    hasball = 1: Cls
    CenterText 11, "PLAYER 2 MISSED THE BALL!"
    CenterText 13, "Next round: Player 1 starts."
    CenterText 14, "Press ENTER when ready."
    Do: Loop Until InKey$ = Chr$(13)
    InitCoord
    Cls
End Sub

Sub SelectDifficulty
    Cls
    menusel = 4
    CenterText 6, "Select difficulty"
    CenterText 8, " Too simple!"
    CenterText 9, "    Easy    "
    CenterText 10, " Pretty easy"
    CenterText 11, "   Average  "
    CenterText 12, "    Hard    "
    CenterText 13, "   Harder   "
    CenterText 14, " Good luck!!"

    Do
        key$ = InKey$
        update = 0
        Select Case key$
            Case Chr$(0) + Chr$(72) 'Up
                If menusel > 1 Then menusel = menusel - 1: update = 1
            Case Chr$(0) + Chr$(80) 'Down
                If menusel < 7 Then menusel = menusel + 1: update = 1
            Case Chr$(13) 'Enter
                Select Case menusel
                    Case 1: difflevel = 12
                    Case 2: difflevel = 11
                    Case 3: difflevel = 6
                    Case 4: difflevel = 4
                    Case 5: difflevel = 3
                    Case 6: difflevel = 2
                    Case 7: difflevel = 1
                End Select
                Exit Sub
            Case Chr$(27) 'Return to main menu
                Exit Sub
        End Select

        Locate 6 + menusel, 13: Print " ";
        Locate 7 + menusel, 13: Print Chr$(16);
        Locate 8 + menusel, 13: Print " ";
    Loop
End Sub

Sub SelectRounds
    Cls
    menusel = 1
    rounds = 3
    CenterText 11, " Rounds: 3"
    CenterText 13, " Let's go!"
    Do
        key$ = InKey$
        update = 0
        Select Case key$
            Case Chr$(0) + Chr$(72) 'Up
                If menusel > 1 Then menusel = menusel - 1: update = 1
            Case Chr$(0) + Chr$(80) 'Down
                If menusel < 2 Then menusel = menusel + 1: update = 1
            Case Chr$(13) 'Enter
                Select Case menusel
                    Case 1
                        rounds = rounds + 1
                        If rounds = 10 Then rounds = 1
                        CenterText 11, " Rounds:" + Str$(rounds)
                    Case 2
                        Exit Sub
                End Select

            Case Chr$(27) 'Return to main menu
                Exit Sub
        End Select

        Select Case menusel
            Case 1: Locate 11, 14: Print Chr$(16);: Locate 13, 14: Print " ";
            Case 2: Locate 13, 14: Print Chr$(16);: Locate 11, 14: Print " ";
        End Select
    Loop
End Sub

Sub ShowControls
    Cls
    CenterText 2, "RECTONG CONTROLS"
    CenterText 6, "Player 1 controls:"
    CenterText 7, "A - Move up"
    CenterText 8, "Z - Move down"
    CenterText 9, "X - Stop moving"
    CenterText 10, "S - Serve ball"
    CenterText 12, "Player 2 controls:"
    CenterText 13, "Up arrow - Move up"
    CenterText 14, "Down arrow - Move down"
    CenterText 15, "End - Stop moving"
    CenterText 16, "\ - Serve ball"
    CenterText 20, "Escape exits an active game."
    CenterText 24, "Press ENTER to continue..."
    Do: Loop Until InKey$ = Chr$(13)
    Cls
End Sub

Sub StartGame
    SelectRounds
    p1score = 0
    p2score = 0
    cround = 0

    quitgame = 0
    hasball = 1 'who starts with the ball

    WipeEffect
    LoadPAL "gfx\palette.pal": Palette 4, 0: Palette 255, 63 + 256 * 63 + 65536 * 63
    LaunchBall
    Do Until quitgame = 1 Or cround > rounds
        Select Case hasball
            Case 1
                ballcor(0) = 40
                ballcor(1) = p1(1) + 24
            Case 2
                ballcor(0) = 280
                ballcor(1) = p2(1) + 24
        End Select

        Select Case hasball
            Case 1
                CenterText 2, "Player 1 has the ball!"
                CenterText 3, "Press S to serve."
                p1(0) = 4
                p2(0) = 1
            Case 2
                CenterText 2, "Player 2 has the ball!"
                If players = 2 Then
                    CenterText 3, "Press \ to throw."
                Else
                    CenterText 3, "Get ready, player 1!"
                End If
                p2(0) = 4
                p1(0) = 1
            Case Else
                p1(0) = 1
                p2(0) = 1
        End Select

        DrawP1
        DrawP2
        If hasball = 0 Then DrawBall

        DispStats

        skip = skip + 1
        If skip And 1 Then Wait &H3DA, 8: Wait &H3DA, 8, 8

        key$ = InKey$
        Select Case key$
            Case Chr$(27) 'Escape key
                CenterText 12, "Exit to main menu? (Y/N)"
                Do
                    Select Case LCase$(InKey$)
                        Case "y"
                            quitgame = 1: Exit Do
                        Case "n"
                            Exit Do
                    End Select
                Loop
                CenterText 12, "                        "

            Case "a", "A" 'Up P1
                If buttdir(0) = 0 Or buttdir(0) = 2 Then buttdir(0) = 1 Else buttdir(0) = 0

            Case "z", "Z" 'Down P1
                If buttdir(0) = 0 Or buttdir(0) = 1 Then buttdir(0) = 2 Else buttdir(0) = 0

            Case "x", "X" 'Stops P1 movement
                buttdir(0) = 0

            Case "s", "S" 'Shoot ball P1
                If hasball = 1 Then
                    CenterText 2, Space$(24): CenterText 3, Space$(24)
                    hasball = 0
                    balldir(0) = 1
                    balldir(1) = 0
                End If

            Case Chr$(0) + Chr$(79) 'Stops P2 movement
                buttdir(1) = 0

            Case "\" 'Shoot ball P2
                If hasball = 2 And players = 2 Then
                    CenterText 2, Space$(24): CenterText 3, Space$(24)
                    hasball = 0
                    balldir(0) = -1
                    balldir(1) = 0
                End If

            Case Chr$(0) + Chr$(72) 'Up P2
                If players = 2 Then If buttdir(1) = 0 Or buttdir(1) = 2 Then buttdir(1) = 1 Else buttdir(1) = 0

            Case Chr$(0) + Chr$(80) 'Down P2
                If players = 2 Then If buttdir(1) = 0 Or buttdir(1) = 1 Then buttdir(1) = 2 Else buttdir(1) = 0
        End Select

        If players = 1 Then DoAI
        If hasball = 2 And players = 1 And Fix(AIserve) = Fix(p2(1)) Then
            CenterText 2, Space$(24): CenterText 3, Space$(24)
            hasball = 0
            balldir(0) = -1
            balldir(1) = 0
        End If

        Select Case buttdir(0)
            Case 1
                If p1(1) > 1 Then p1(1) = p1(1) - 1

            Case 2
                If p1(1) < 138 Then p1(1) = p1(1) + 1
        End Select

        Select Case buttdir(1)
            Case 1
                If p2(1) > 1 Then p2(1) = p2(1) - 1

            Case 2
                If p2(1) < 138 Then p2(1) = p2(1) + 1
        End Select

        MoveBall
    Loop
    Cls: Exit Sub
End Sub

Sub WipeEffect
    For xeff = 0 To 160 Step .01
        Line (160 + xeff, 0)-(160 + xeff, 200), 0
        Line (160 - xeff, 0)-(160 - xeff, 200), 0
        't! = TIMER: DO: LOOP UNTIL TIMER - t! > 0
    Next xeff
End Sub

