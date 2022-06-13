'
' Ghost Wizard
' Zack Johnson
' 7DRL 2019   (Mar 2 - Mar 7)
'

Screen _NewImage(480, 320, 32)
_Font 8
_FullScreen _SquarePixels
Randomize Timer


Dim Shared level(300, 300, 3) ' the contents of the level
Dim Shared groundcolor~&(300, 300, 3) ' the color of the ground
Dim Shared seed(300, 300, 3) ' for randomizing various display things
Dim Shared secretstairs(300, 300, 3) ' for revealed staircases
Dim Shared playerx, playery, playerdepth
Dim Shared playerhp, playermp, playerscore
Dim Shared exiting
Dim Shared messages$(7)
Dim Shared spells(9)
Dim Shared feelings(10)
Dim Shared soulattacks ' for tracking Sorrow unlock
Dim Shared currentspell
Dim Shared spellnames$(20)
Dim Shared spellcosts(20)
Dim Shared frame
Dim Shared defaultgroundcolor~&(5)
Dim Shared enemyupdated(31, 31)
Dim Shared groundcolors~&(30)
Dim Shared debugmovement
Dim Shared pitymana
Dim Shared permadeath, difficulty
Dim Shared gameover
Dim Shared lastmove ' for continuous movement

' ======================================================= BEGIN MAIN LOOP

top:

Call titlescreen

startgame:
Cls

Call updateui
Call initialize

Call buildworld
Call updateui

mainloop:

Call displayworld
Call playerinput

If exiting Then
    Color _RGB(255, 255, 255), 0
    System
End If
If gameover Then GoTo top
GoTo mainloop

' ======================================================= END MAIN LOOP

Sub updateui
    ' display messages
    Color _RGB(255, 255, 255), _RGB(0, 0, 0)
    For lop = 1 To 60
        For lopp = 34 To 40
            Call blankspace(lopp, lop)
        Next lopp
    Next lop
    Color _RGB(255, 255, 255), _RGB(0, 0, 0)
    For lop = 1 To 7
        Locate 33 + lop, 1
        Print messages$(lop);
    Next lop
    'display status area
    For lop = 34 To 60
        For lopp = 1 To 33
            Call blankspace(lopp, lop)
        Next lopp
    Next lop
    Color _RGB(255, 255, 255), _RGB(0, 0, 0)
    Locate 2, 40
    Print "Coherence: ";
    Color _RGB(255, 0, 0)
    Locate 2, 51
    Print Str$(playerhp);
    Locate 3, 40
    Color _RGB(255, 255, 255), _RGB(0, 0, 0)
    Print "Influence: ";
    Locate 3, 51
    Color _RGB(0, 0, 255)
    Print Str$(playermp);
    If playermp > balancevar(11) + 30 Then feelings(8) = 1 ' Contentment unlock
    Locate 4, 40
    Color _RGB(255, 255, 255), _RGB(0, 0, 0)
    Print "Knowledge: ";
    Locate 4, 51
    Color _RGB(0, 255, 0)
    Print Str$(playerscore) + "%";
    Locate 6, 40
    Color _RGB(255, 255, 255), _RGB(0, 0, 0)
    Print "Spells:"
    Color _RGB(155, 155, 155), _RGB(0, 0, 0)
    Locate 7, 35
    Print "#1-9 to select"
    Locate 8, 35
    Print "Arrow keys to cast"
    Color _RGB(255, 255, 255), _RGB(0, 0, 0)
    Locate 9, 35
    Print "0 to scry (5 Inf)"
    For lop = 1 To 9
        If spells(lop) > 0 Then
            Locate 10 + lop, 37
            If currentspell = lop Then Color _RGB(255, 255, 255), _RGB(150, 150, 255)
            If currentspell <> lop Then Color _RGB(255, 255, 255), _RGB(0, 0, 0)
            Print Str$(lop) + ". " + spellnames$(spells(lop)) + " (" + LTrim$(Str$(spellcosts(spells(lop)))) + " Inf) ";
        End If
    Next lop

    Color _RGB(100, 100, 100), _RGB(0, 0, 0)
    If playerscore >= 0 Then line1$ = "I don't know who I am."
    If playerscore >= 10 Then line1$ = "I'm a ghost."
    If playerscore >= 20 Then line1$ = "I was a wizard."
    If playerscore >= 30 Then line1$ = "I'm a ghost wizard."

    line2$ = ""
    If playerscore >= 40 Then line2$ = "I don't know where I am."
    If playerscore >= 50 Then line2$ = "This wasn't my home."
    If playerscore >= 60 Then line2$ = "I have to leave."
    If playerscore >= 70 Then line2$ = "Something keeps me here."

    line3$ = ""
    If playerscore >= 80 Then line3$ = "It's... a stone."
    If playerscore >= 90 Then line3$ = "A monument."
    If playerscore >= 100 Then line3$ = "A statue.  Of who I was."

    line4$ = ""
    If playerscore >= 100 Then
        west = 0: north = 0: south = 0: east = 0
        If playerx < 145 Then east = 1
        If playerx > 155 Then west = 1
        If playery < 145 Then south = 1
        If playery > 155 Then north = 1
        If east = 1 Then line4$ = "It's to the east."
        If west = 1 Then line4$ = "It's to the west."
        If north = 1 Then line4$ = "It's to the north."
        If south = 1 Then line4$ = "It's to the south."
        If east = 1 And north = 1 Then line4$ = "It's to the northeast."
        If east = 1 And south = 1 Then line4$ = "It's to the southeast."
        If west = 1 And north = 1 Then line4$ = "It's to the northwest."
        If west = 1 And south = 1 Then line4$ = "It's to the southwest."
        If (north + south + east + west = 0) Then line4$ = "I know what to do."
    End If
    Locate 29, 35
    Print line1$
    Locate 30, 35
    Print line2$
    Locate 31, 35
    Print line3$
    Locate 32, 35
    Print line4$

    ' emotion memories
    showemotions = 0
    For lop = 1 To 9
        If feelings(lop) = 1 Then showemotions = 1
    Next lop
    If showemotions Then
        Color _RGB(100, 100, 100), _RGB(0, 0, 0)
        Locate 21, 35
        Print "I remember"
        If feelings(1) Then
            Color _RGB(60, 60, 60)
            Locate 23, 52
            Print "Fear"
        End If
        If feelings(2) Then
            Color _RGB(255, 60, 60)
            Locate 24, 36
            Print "Anger"
        End If
        If feelings(3) Then
            Color _RGB(255, 60, 255)
            Locate 25, 51
            Print "Shame"
        End If
        If feelings(4) Then
            Color _RGB(255, 0, 255)
            Locate 26, 36
            Print "Disgust"
        End If
        If feelings(5) Then
            Color _RGB(90, 90, 255)
            Locate 26, 47
            Print "Gratitude"
        End If
        If feelings(6) Then
            Color _RGB(30, 30, 255)
            Locate 25, 36
            Print "Melancholy"
        End If
        If feelings(7) Then
            Color _RGB(255, 255, 0)
            Locate 24, 48
            Print "Surprise"
        End If
        If feelings(8) Then
            Color _RGB(60, 255, 60)
            Locate 23, 36
            Print "Contentment"
        End If
    End If


End Sub

Sub playerinput
    exiting = 0
    lastrefresh = Timer

    Do
        contdelay = 0
        k$ = ""
        k$ = InKey$
        If k$ = Chr$(0) + Chr$(72) Then k$ = "uparrow"
        If k$ = Chr$(0) + Chr$(80) Then k$ = "downarrow"
        If k$ = Chr$(0) + Chr$(75) Then k$ = "leftarrow"
        If k$ = Chr$(0) + Chr$(77) Then k$ = "rightarrow"
        If k$ = Chr$(27) Then k$ = "escape"
        ' some day, experiment with this for smooth continuous movement
        'IF _KEYDOWN(87) OR _KEYDOWN(119) THEN ' continuous movement
        '    k$ = "w"
        '_KEYCLEAR
        'END IF

        If Timer > lastrefresh + .25 Then
            Call displayworld
            lastrefresh = Timer
            Call advanceframe
        End If
    Loop Until k$ <> ""
    k$ = LCase$(k$)
    Select Case k$
        Case "w"
            Call moveplayer("up")
        Case "a"
            Call moveplayer("left")
        Case "s"
            Call moveplayer("down")
        Case "d"
            Call moveplayer("right")
        Case "1"
            Call switchspell(1)
        Case "2"
            Call switchspell(2)
        Case "3"
            Call switchspell(3)
        Case "4"
            Call switchspell(4)
        Case "5"
            Call switchspell(5)
        Case "6"
            Call switchspell(6)
        Case "7"
            Call switchspell(7)
        Case "8"
            Call switchspell(8)
        Case "9"
            Call switchspell(9)
        Case "0"
            Call scry
        Case "uparrow"
            Call castspell("up")
        Case "downarrow"
            Call castspell("down")
        Case "leftarrow"
            Call castspell("left")
        Case "rightarrow"
            Call castspell("right")

        Case "escape"
            Color _RGB(255, 0, 0), _RGB(255, 0, 0)
            For lop = 7 To 27
                For lopp = 16 To 18
                    Locate lopp, lop
                    Print Chr$(219)
                Next lopp
            Next lop
            Locate 17, 9
            Color _RGB(255, 255, 255), _RGB(255, 0, 0)
            Print "Really quit?  Y/N"
            g$ = ""
            While g$ = ""
                g$ = InKey$
            Wend
            If UCase$(g$) = "Y" Then exiting = 1
            Call blankspace(17, 17)
            Call displayworld
        Case "x"
            exiting = 1
            '      CASE "k"
            '          playerscore = playerscore + 10
            Call updateui
            '       CASE "v" 'debug
            '           playerhp = 100
            '           playermp = 30
            '           FOR lop = 1 TO 9
            '               spells(lop) = lop
            '           NEXT lop
            '        CASE "z"
            '            playerdepth = playerdepth + 1
            '            CALL displayworld
            '        CASE "i"
            '            playerhp = 1
            '            CALL updateui
            '        CASE "p"
            '            IF debugmovement = 0 THEN debugmovement = 1 ELSE debugmovement = 0
            '            IF debugmovement = 1 THEN CALL message("debug movement ON") ELSE CALL message("debug movement OFF")
    End Select
    _KeyClear

End Sub

Sub scry
    If (playermp < 5) Then
        Call message("Your influence is too weak.")
    Else
        playermp = playermp - 5
        Call message("The veil is parted.")
        For lop = -15 To 15
            For lopp = -15 To 15
                If (lopp <> 0 Or lop <> 0) Then ' skip the center space
                    purp = 150 + Int(Rnd * 100)
                    Call blankspace(17 + lopp, 17 + lop)
                    Locate 17 + lopp, 17 + lop, 0
                    If secretstairs(playerx + lop, playery + lopp, playerdepth) = 1 Then
                        Color _RGB(255, 255, 255), _RGB(purp, 0, purp)
                        Print "!"
                    Else
                        Color _RGB(purp, 0, purp)
                        Print Chr$(219)
                    End If
                End If
            Next lopp
        Next lop
        _Delay 2
    End If
End Sub

Sub displayworld ' update the entire world display

    bl$ = Chr$(219) ' draw the frame
    For lop = 1 To 33
        Color _RGB(255, 255, 255), 0
        Locate lop, 1: Print bl$;
        Locate lop, 33: Print bl$;
        Locate 1, lop: Print bl$;
        Locate 33, lop: Print bl$;
    Next lop
    ' draw the area surrounding the player
    For lop = -15 To 15
        For lopp = -15 To 15
            If (lopp <> 0 Or lop <> 0) Then ' skip the center space
                Call blankspace(17 + lopp, 17 + lop)
                Locate 17 + lopp, 17 + lop, 0
                Call drawspace(playerx + lop, playery + lopp)
            End If
        Next lopp
    Next lop

    ' draw player
    Color _RGBA(255, 255, 255, 128), groundcolor~&(playerx, playery, playerdepth)
    Locate 17, 17: Print Chr$(2);
End Sub

Sub drawspace (x, y)
    contents = level(x, y, playerdepth)
    myseed = seed(x, y, playerdepth)
    stage = (frame + myseed) Mod 20 ' for animated elements
    mygroundcolor~& = groundcolor~&(x, y, playerdepth)

    fg~& = _RGB(255, 255, 255) ' default fg to white
    bg~& = groundcolor~&(x, y, playerdepth) ' default bg to ground color
    char = 65 ' default to a... capital A
    Select Case contents
        Case 0
            char = 32
            fg~& = _RGB(196, 139, 0)
            If myseed = 25 Then ' desert texture 1
                char = 176
                fg~& = _RGB(204, 202, 68)
            End If
            If myseed = 26 Then ' desert texture 2
                char = 177
                fg~& = _RGB(204, 202, 68)
            End If
            If myseed = 61 Then ' obsidian texture 1
                char = 176
                fg~& = _RGB(35, 35, 35)
            End If
            If myseed = 62 Then ' obsidian texture 1
                char = 177
                fg~& = _RGB(35, 35, 35)
            End If
            If myseed > 80 Then ' ice
                If myseed = 81 Then char = 47
                fg~& = _RGB(200, 200, 255)
                bg~& = _RGB(100, 255, 255)
            End If
            If myseed > 50 And myseed < 60 Then ' road
                bg~& = _RGB(126, 81, 9)
                If myseed = 51 Then ' bridge
                    char = 205
                    fg~& = _RGB(126, 81, 9)
                    bg~& = _RGB(110, 44, 0)
                ElseIf myseed > 54 Then ' dirt on road
                    fg~& = _RGB(156, 100, 12)
                    char = 176
                End If
            End If
        Case 1
            char = 65
        Case 2 ' coherence gem
            fg~& = _RGB(255, 0, 0)
            If frame / 2 = Int(frame / 2) Then char = 15 Else char = 42
        Case 3 ' influence gem
            fg~& = _RGB(0, 0, 255)
            If frame / 2 = Int(frame / 2) Then char = 42 Else char = 15
        Case 4 ' spell scroll
            bg~& = _RGB(255, 255, 255)
            fg~& = _RGB(Int(Rnd * 255) + 1, Int(Rnd * 255) + 1, Int(Rnd * 255) + 1)
            char = 156
            If stage > 4 Then char = 155
            If stage > 9 Then char = 231
            If stage > 14 Then char = 251
        Case 5 ' stairs down
            bg~& = _RGB(0, 0, 0)
            fg~& = _RGB(255, 255, 255)
            char = 62
        Case 6 ' stairs up
            fg~& = _RGB(255, 255, 255)
            char = 60
        Case 7 ' memory fragment
            fg~& = _RGB(Int(Rnd * 255) + 1, Int(Rnd * 255) + 1, Int(Rnd * 255) + 1)
            char = 21
        Case 8 ' knowledge gem
            fg~& = _RGB(0, 255, 0)
            If frame / 2 = Int(frame / 2) Then char = 42 Else char = 15
        Case 9 ' influence mote
            char = 250
            fg~& = _RGB(0, 0, 255)
        Case 10 ' tree
            If myseed Mod 3 = 1 Then char = 5
            If myseed Mod 3 = 2 Then char = 6
            If myseed Mod 3 = 0 Then char = 24
            fg~& = _RGB(33, 60 + (myseed * 2), 33)
        Case 11 ' stump
            fg~& = _RGB(160, 160, 160)
            char = 227
        Case 12 ' cactus
            If myseed Mod 3 = 1 Then char = 181
            If myseed Mod 3 = 2 Then char = 216
            If myseed Mod 3 = 0 Then char = 195
            fg~& = _RGB(66, 90 + (myseed * 5), 66)
        Case 50
            bg~& = _RGB(93, 109, 126)
            fg~& = _RGB(103, 119, 136)
            If myseed Mod 4 = 1 Then char = 177 Else char = 32
            If mygroundcolor~& = groundcolors~&(1) Then ' lighter rocks in the desert
                bg~& = _RGB(123, 139, 156)
                fg~& = _RGB(133, 149, 136)

            End If
            If myseed = 0 Then
                char = 219
                fg~& = _RGB(255, 255, 255)
            End If
        Case 51 ' wood wall
            bg~& = _RGB(90, 24, 0)
            fg~& = _RGB(120, 54, 30)
            char = 186
        Case 52 ' gravestone
            char = 241
            bg~& = _RGB(200, 200, 200)
            fg~& = _RGB(255, 255, 255)
        Case 90 ' amphora/pot/urn
            char = 127
            fg~& = _RGB(200, 200, 200)
            If mygroundcolor~& = groundcolors~&(1) Then
                char = 232
                fg~& = _RGB(184, 134, 11)
            End If
            If mygroundcolor~& = groundcolors~&(5) Then ' inside house
                char = 235
                fg~& = _RGB(153, 102, 51)
            End If

            If mygroundcolor~& = groundcolors~&(6) Then
                char = 240
                fg~& = _RGB(200, 200, 200)
            End If
        Case 100 ' scorpion
            If stage Mod 4 = 0 Then fg~& = _RGB(150, 150, 150)
            If stage Mod 4 = 1 Then fg~& = _RGB(180, 180, 180)
            If stage Mod 4 = 2 Then fg~& = _RGB(200, 200, 200)
            If stage Mod 4 = 3 Then fg~& = _RGB(180, 180, 180)
            char = 157
        Case 101 ' lost soul
            If stage Mod 4 = 0 Then fg~& = _RGB(150, 150, 150)
            If stage Mod 4 = 1 Then fg~& = _RGB(180, 180, 180)
            If stage Mod 4 = 2 Then fg~& = _RGB(200, 200, 200)
            If stage Mod 4 = 3 Then fg~& = _RGB(180, 180, 180)
            char = 1
        Case 102 ' snake
            If stage Mod 4 = 0 Then fg~& = _RGB(150, 150, 150)
            If stage Mod 4 = 1 Then fg~& = _RGB(180, 180, 180)
            If stage Mod 4 = 2 Then fg~& = _RGB(200, 200, 200)
            If stage Mod 4 = 3 Then fg~& = _RGB(180, 180, 180)
            char = 115
        Case 103 ' will o the wisp
            fg~& = _RGB(255, 255, 0)
            If stage Mod 3 = 0 Then char = 136
            If stage Mod 3 = 1 Then char = 137
            If stage Mod 3 = 2 Then char = 138
        Case 104 ' rage soul
            fg~& = _RGB(255, 0, 0)
            If stage Mod 3 = 0 Then char = 147
            If stage Mod 3 = 1 Then char = 148
            If stage Mod 3 = 2 Then char = 149
        Case 105 ' spider
            If stage Mod 4 = 0 Then fg~& = _RGB(100, 100, 100)
            If stage Mod 4 = 1 Then fg~& = _RGB(120, 120, 120)
            If stage Mod 4 = 2 Then fg~& = _RGB(150, 150, 150)
            If stage Mod 4 = 3 Then fg~& = _RGB(120, 120, 120)
            char = 15
        Case 106 ' fungus
            bg~& = _RGB(255, 0, 255)
            fg~& = _RGB(255, 255, 0)
            If stage Mod 3 = 0 Then char = 248
            If stage Mod 3 = 1 Then char = 249
            If stage Mod 3 = 2 Then char = 58
        Case 800 ' endgame statue
            fg~& = _RGB(200, 200, 200)
            char = 2
        Case 998 ' water
            fg~& = _RGB(128, 128, 255)
            char = 32
            If stage >= 15 Then char = 126
            If stage >= 17 Then char = 247
        Case 997 ' lava
            fg~& = _RGB(255, 255, 0)
            bg~& = _RGB(255, 102, 0)
            char = 32
            If stage >= 15 Then char = 126
            If stage >= 17 Then char = 247
        Case 999 ' Void Space (twinkles)
            char = 32
            fg~& = _RGB((((x + y) Mod 20) * 12), (((x + y) Mod 20) * 12), 255)
            If stage = 1 Then char = 249
            If stage = 2 Then char = 43
            If stage = 3 Then char = 42
            'IF myseed < 15 THEN char = 32 ' make them sparse
            'char = myseed + 64 + stage
    End Select
    Color fg~&, bg~&
    Print Chr$(char);
End Sub

Sub blankspace (col, row)
    Locate col, row, 0
    Color _RGB(0, 0, 0)
    Print Chr$(219);
End Sub

Sub switchspell (which)
    If spells(which) > 0 Then
        currentspell = which
    End If
    If spells(which) = 0 Then
        message ("The memory of that spell is unavailable to you.")
    End If
    Call updateui

End Sub

Sub castspell (dir$)
    If playermp < spellcosts(currentspell) Then
        Call message("You lack the influence to cast that spell.")
        GoTo spellfail
    End If
    If currentspell = 0 Then GoTo spellfail
    playermp = playermp - spellcosts(currentspell)
    Select Case dir$
        Case "up"
            adjx = playerx
            adjy = playery - 1
            screenx = 17
            screeny = 16
            xdir = 0
            ydir = -1
        Case "down"
            adjx = playerx
            adjy = playery + 1
            screenx = 17
            screeny = 18
            xdir = 0
            ydir = 1
        Case "left"
            adjx = playerx - 1
            adjy = playery
            screenx = 16
            screeny = 17
            xdir = -1
            ydir = 0
        Case "right"
            adjx = playerx + 1
            adjy = playery
            screenx = 18
            screeny = 17
            xdir = 1
            ydir = 0
    End Select

    ' blade
    If currentspell = 1 Then
        Call showslashsquare(screenx, screeny, adjx, adjy)
        Call slashsquare(screenx, screeny, adjx, adjy)
    End If
    If currentspell = 2 Then ' throwing dagger
        For lop = 1 To 5
            test = level(playerx + (xdir * lop), playery + (ydir * lop), playerdepth)
            If test = 0 Then
                Call showarrowsquare(17 + (xdir * lop), 17 + (ydir * lop), playerx + (xdir * lop), playery + (ydir * lop))
            Else
                Call showplinksquare(17 + (xdir * lop), 17 + (ydir * lop), playerx + (xdir * lop), playery + (ydir * lop))
                Call plinksquare(17 + (xdir * lop), 17 + (ydir * lop), playerx + (xdir * lop), playery + (ydir * lop))
                Exit For
            End If
        Next lop
    End If
    If currentspell = 3 Then ' candle
        Call showburnsquare(17 + xdir, 17 + ydir, playerx + xdir, playery + ydir)
        Call burnsquare(17 + xdir, 17 + ydir, playerx + xdir, playery + ydir)
        Call showburnsquare(17 + xdir * 2, 17 + ydir * 2, playerx + xdir * 2, playery + ydir * 2)
        Call burnsquare(17 + xdir * 2, 17 + ydir * 2, playerx + xdir * 2, playery + ydir * 2)
    End If
    If currentspell = 4 Then ' fireball
        For lop = 1 To 5
            test = level(playerx + (xdir * lop), playery + (ydir * lop), playerdepth)
            If test = 0 And lop < 5 Then
                Call showfireballsquare(17 + (xdir * lop), 17 + (ydir * lop), playerx + (xdir * lop), playery + (ydir * lop))
            Else
                Call showburnblast(17 + (xdir * lop), 17 + (ydir * lop), playerx + (xdir * lop), playery + (ydir * lop))
                Call burnblast(17 + (xdir * lop), 17 + (ydir * lop), playerx + (xdir * lop), playery + (ydir * lop))
                Exit For
            End If
        Next lop
    End If

    If currentspell = 5 Then
        Call showhammersquare(screenx, screeny, adjx, adjy)
        Call hammersquare(screenx, screeny, adjx, adjy)
    End If

    If currentspell = 6 Then ' bomb
        For lop = 1 To 5
            test = level(playerx + (xdir * lop), playery + (ydir * lop), playerdepth)
            If test = 0 And lop < 5 Then
                Call showbombsquare(17 + (xdir * lop), 17 + (ydir * lop), playerx + (xdir * lop), playery + (ydir * lop))
            Else
                Call showbombblast(17 + (xdir * lop), 17 + (ydir * lop), playerx + (xdir * lop), playery + (ydir * lop))
                Call bombblast(17 + (xdir * lop), 17 + (ydir * lop), playerx + (xdir * lop), playery + (ydir * lop))
                Exit For
            End If
        Next lop
    End If

    If currentspell = 7 Then ' holy water
        Call showspritzsquare(17 + xdir, 17 + ydir, playerx + xdir, playery + ydir)
        Call spritzsquare(17 + xdir, 17 + ydir, playerx + xdir, playery + ydir)
        Call showspritzsquare(17 + xdir * 2, 17 + ydir * 2, playerx + xdir * 2, playery + ydir * 2)
        Call spritzsquare(17 + xdir * 2, 17 + ydir * 2, playerx + xdir * 2, playery + ydir * 2)
        Call showspritzsquare(17 + xdir * 3, 17 + ydir * 3, playerx + xdir * 3, playery + ydir * 3)
        Call spritzsquare(17 + xdir * 3, 17 + ydir * 3, playerx + xdir * 3, playery + ydir * 3)
    End If

    If currentspell = 8 Then ' acid blast
        Call showacidblast(17 + (xdir * 3), 17 + (ydir * 3), playerx + (xdir * 3), playery + (ydir * 3))
        Call acidblast(17 + (xdir * 3), 17 + (ydir * 3), playerx + (xdir * 3), playery + (ydir * 3))
    End If

    If currentspell = 9 Then ' ice beam
        For lop = 1 To 5
            Call showiceballsquare(17 + (xdir * lop), 17 + (ydir * lop), playerx + (xdir * lop), playery + (ydir * lop))
            Call freezesquare(17 + (xdir * lop), 17 + (ydir * lop), playerx + (xdir * lop), playery + (ydir * lop))
        Next lop
    End If
    Call updateui
    Call displayworld
    Call moveenemies
    spellfail:

End Sub

Sub showarrowsquare (screenx, screeny, levelx, levely) ' cosmetic
    Locate screeny, screenx
    Color _RGB(150, 50, 0), groundcolor~&(levelx, levely, playerdepth)
    Print Chr$(250);
    _Delay .09
    Call displayworld
End Sub

Sub showfireballsquare (screenx, screeny, levelx, levely) ' also cosmetic
    Locate screeny, screenx
    Color _RGB(255, 0, 0), groundcolor~&(levelx, levely, playerdepth)
    Print "*";
    _Delay .10
    Call displayworld
End Sub

Sub showiceballsquare (screenx, screeny, levelx, levely) ' also cosmetic
    Locate screeny, screenx
    Color _RGB(200, 255, 255), groundcolor~&(levelx, levely, playerdepth)
    Print "*";
    _Delay .10
    Call displayworld
End Sub


Sub showbombsquare (screenx, screeny, levelx, levely) ' also cosmetic
    Locate screeny, screenx
    Color _RGB(255, 0, 0), groundcolor~&(levelx, levely, playerdepth)
    Print Chr$(235);
    _Delay .15
    Call displayworld
End Sub

Sub showspritzsquare (screenx, screeny, levelx, levely) ' also cosmetic
    Locate screeny, screenx
    Color _RGB(0, 0, 200), groundcolor~&(levelx, levely, playerdepth)
    Print Chr$(176);
    _Delay .10
    Call displayworld
End Sub


Sub showburnsquare (screenx, screeny, levelx, levely) ' also cosmetic
    Color _RGB(255, 0, 0), groundcolor~&(levelx, levely, playerdepth)
    For lop = 1 To 5
        Locate screeny, screenx
        Select Case Int(Rnd * 4)
            Case 0: Print Chr$(200)
            Case 1: Print Chr$(201)
            Case 2: Print Chr$(187)
            Case 3: Print Chr$(188)
        End Select
        _Delay .05
    Next lop
End Sub

Sub showbombblast (screenx, screeny, levelx, levely) ' also cosmetic
    For glop = 1 To 3
        For lop = -2 To 2
            For lopp = -2 To 2
                If (Abs(lop) + Abs(lopp) <= 3) Then
                    Color _RGB(255, 255, 255), _RGB(200, 200, 200)
                    Locate screeny + lop, screenx + lopp
                    Select Case glop
                        Case 1: Print Chr$(178)
                        Case 2: Print Chr$(177)
                        Case 3: Print Chr$(176)
                    End Select
                End If
            Next lopp
        Next lop
        _Delay .1
    Next glop
End Sub

Sub showacidblast (screenx, screeny, levelx, levely) ' also cosmetic
    For glop = 1 To 3
        For lop = -2 To 2
            For lopp = -2 To 2
                If (Abs(lop) + Abs(lopp) <= 3) Then
                    Color _RGB(0, 255, 0), groundcolor~&(levelx + lop, levely + lopp, playerdepth)
                    Locate screeny + lop, screenx + lopp
                    Select Case glop
                        Case 1: Print Chr$(176)
                        Case 2: Print Chr$(177)
                        Case 3: Print Chr$(176)
                    End Select
                End If
            Next lopp
        Next lop
        _Delay .1
    Next glop
End Sub


Sub showburnblast (screenx, screeny, levelx, levely) ' also cosmetic
    For glop = 1 To 5
        For lop = -2 To 2
            For lopp = -2 To 2
                If (Abs(lop) + Abs(lopp) <= 2) Then
                    Color _RGB(255, 0, 0), groundcolor~&(levelx + lop, levely + lopp, playerdepth)
                    Locate screeny + lop, screenx + lopp
                    Select Case Int(Rnd * 4)
                        Case 0: Print Chr$(200)
                        Case 1: Print Chr$(201)
                        Case 2: Print Chr$(187)
                        Case 3: Print Chr$(188)
                    End Select
                End If
            Next lopp
        Next lop
        _Delay .05
    Next glop
End Sub

Sub burnblast (screenx, screeny, levelx, levely) ' also cosmetic
    For lop = -2 To 2
        For lopp = -2 To 2
            If (Abs(lop) + Abs(lopp) <= 2) Then
                Call burnsquare(screenx + lop, screeny + lopp, levelx + lop, levely + lopp)
            End If
        Next lopp
    Next lop
End Sub

Sub bombblast (screenx, screeny, levelx, levely) ' also cosmetic
    For lop = -2 To 2
        For lopp = -2 To 2
            If (Abs(lop) + Abs(lopp) <= 3) Then
                Call hammersquare(screenx + lop, screeny + lopp, levelx + lop, levely + lopp)
            End If
        Next lopp
    Next lop
End Sub

Sub acidblast (screenx, screeny, levelx, levely) ' also cosmetic
    For lop = -2 To 2
        For lopp = -2 To 2
            If (Abs(lop) + Abs(lopp) <= 3) Then
                Call acidsquare(screenx + lop, screeny + lopp, levelx + lop, levely + lopp)
            End If
        Next lopp
    Next lop
End Sub


Sub showhammersquare (screenx, screeny, levelx, levely) ' also cosmetic
    Locate screeny, screenx
    Color _RGB(128, 128, 128), groundcolor~&(levelx, levely, playerdepth)
    Print "+";
    _Delay .15
    Locate screeny, screenx
    Print "*";
    _Delay .15
End Sub

Sub showslashsquare (screenx, screeny, levelx, levely) ' also cosmetic
    Locate screeny, screenx
    Color _RGB(228, 228, 228), groundcolor~&(levelx, levely, playerdepth)
    Print "/";
    _Delay .15
    Locate screeny, screenx
    Print "\";
    _Delay .15
End Sub

Sub showplinksquare (screenx, screeny, levelx, levely) ' also cosmetic
    Locate screeny, screenx
    Color _RGB(150, 50, 0), groundcolor~&(levelx, levely, playerdepth)
    Print "*";
    _Delay .15
End Sub



Sub plinksquare (screenx, screeny, levelx, levely)
    target = level(levelx, levely, playerdepth)
    Select Case target
        Case 10, 11, 12
            Call message("Thwick!")
        Case 50, 51, 52
            Call message("Thunk!")
        Case 90
            Call bustamphora(levelx, levely, playerdepth)
        Case 100
            Call message("The scorpion spirit whiffs out of existence.")
            level(levelx, levely, playerdepth) = 0
        Case 101
            Call message("The lost soul becomes enraged.")
            level(levelx, levely, playerdepth) = 104
        Case 102
            Call message("The echo serpent is rent.")
            level(levelx, levely, playerdepth) = 0
        Case 103
            Call message("The wisp is too quick.")
        Case 104
            Call message("The rage soul utters a final scream.")
            level(levelx, levely, playerdepth) = 0
        Case 105
            Call message("The spider-shadow vanishes into the stone.")
            level(levelx, levely, playerdepth) = 0
        Case 106
            Call message("The psychic fungus is unperturbed.")
        Case 800
            Call message("You can do better than that.")
        Case Else
    End Select
End Sub



Sub slashsquare (screenx, screeny, levelx, levely)
    target = level(levelx, levely, playerdepth)
    Select Case target
        Case 10
            Call message("You reduce the tree to a withered stump.")
            level(levelx, levely, playerdepth) = 11
        Case 11
            If secretstairs(levelx, levely, playerdepth) = 1 Then
                level(levelx, levely, playerdepth) = 5
                Call message("This tree had deep, secret roots.")
            Else
                Call message("You destroy the stump.")
                level(levelx, levely, playerdepth) = 0
            End If
        Case 12
            Call message("The cactus succumbs to the blade.")
            level(levelx, levely, playerdepth) = 0
        Case 50
            Call message("Not sharp enough to cut that.")
        Case 51
            Call message("That would take all day.")
        Case 52
            Call message("Sparks fly as the blade hits the stone.")
        Case 90
            Call bustamphora(levelx, levely, playerdepth)
        Case 100
            Call message("You sever the scorpion spirit's tether.")
            level(levelx, levely, playerdepth) = 0
        Case 101
            Call message("The lost soul becomes enraged.")
            level(levelx, levely, playerdepth) = 104
        Case 102
            Call message("The echo serpent is split.")
            level(levelx, levely, playerdepth) = 0
        Case 103
            If Int(Rnd * 2) = 1 Then
                Call message("The wisp's light is extinguished.")
                level(levelx, levely, playerdepth) = 0
            Else
                Call message("The wisp evades the blade.")
            End If
        Case 104
            Call message("The rage soul is calmed.")
            level(levelx, levely, playerdepth) = 0
        Case 105
            Call message("The spider-shadow leaves itself behind.")
            level(levelx, levely, playerdepth) = 0
        Case 106
            Call message("The psychic fungus immediately refills the void your blade created.")
        Case 800
            Call message("You can do better than that.")
        Case Else
    End Select
End Sub

Sub hammersquare (screenx, screeny, levelx, levely)
    target = level(levelx, levely, playerdepth)
    Select Case target
        Case 10
            Call message("The tree only shudders defiantly.")
        Case 11
            Call message("The stump only becomes harder.")
        Case 12
            Call message("The cactus, its grip on the ground tenuous, falls.")
            level(levelx, levely, playerdepth) = 0
        Case 50
            If secretstairs(levelx, levely, playerdepth) = 1 Then
                level(levelx, levely, playerdepth) = 5
                Call message("The stone had its secrets.")
            Else
                Call message("The void within the stone is revealed.")
                level(levelx, levely, playerdepth) = 0
            End If
        Case 51
            Call message("The wall becomes a floor.")
            level(levelx, levely, playerdepth) = 0
        Case 52
            If secretstairs(levelx, levely, playerdepth) = 1 Then
                level(levelx, levely, playerdepth) = 5
                Call message("It was even deeper than you feared.")
            Else
                Call message("Reverence is a memory you lack.")
                level(levelx, levely, playerdepth) = 0
            End If
            feelings(3) = 1 ' Shame unlock
        Case 90
            Call bustamphora(levelx, levely, playerdepth)
        Case 100
            Call message("The scorpion flattens, dissipates.")
            level(levelx, levely, playerdepth) = 0
        Case 101
            Call message("The lost soul becomes enraged.")
            level(levelx, levely, playerdepth) = 104
        Case 102
            Call message("The echo serpent uncoils.")
            level(levelx, levely, playerdepth) = 0
        Case 103
            If Int(Rnd * 2) = 1 Then
                Call message("The wisp's light is snuffed out.")
                level(levelx, levely, playerdepth) = 0
            Else
                Call message("The wisp evades the hammer.")
            End If
        Case 104
            Call message("The rage soul is calmed.")
            level(levelx, levely, playerdepth) = 0
        Case 105
            Call message("The shadow spider is made even thinner.")
            level(levelx, levely, playerdepth) = 0
        Case 106
            Call message("The psychic fungus bounces back.")
        Case 800
            If (playerscore >= 100) Then

                Call winscreen
            Else
                Call message("You cannot destroy yourself until you know yourself.")
            End If
        Case Else
            If levelx = playerx And levely = playery Then
                Call message("The impact shakes you.")
                Call damageplayer(3, 0)
            End If
    End Select
End Sub


Sub burnsquare (screenx, screeny, levelx, levely)
    target = level(levelx, levely, playerdepth)
    Select Case target
        Case 10
            Call message("The tree becomes coal, then ash.")
            level(levelx, levely, playerdepth) = 0
            groundcolor~&(levelx, levely, playerdepth) = groundcolors~&(2)
        Case 11
            Call message("The stump becomes ash.")
            level(levelx, levely, playerdepth) = 0
            groundcolor~&(levelx, levely, playerdepth) = groundcolors~&(2)
        Case 12
            Call message("The cactus wanted water but you gave it fire.")
            level(levelx, levely, playerdepth) = 0
            groundcolor~&(levelx, levely, playerdepth) = groundcolors~&(2)
        Case 50
            Call message("The stone has seen worse fire than yours.")
        Case 51
            Call message("The wall becomes window, then door, then nothing.")
            level(levelx, levely, playerdepth) = 0
            groundcolor~&(levelx, levely, playerdepth) = groundcolors~&(2)
        Case 90
            Call message("What a waste.")
            level(levelx, levely, playerdepth) = 0
        Case 100
            Call message("The scorpion spirit boils away to nothing.")
            level(levelx, levely, playerdepth) = 0
        Case 101
            Call message("The lost soul becomes inflamed.")
            level(levelx, levely, playerdepth) = 104
        Case 102
            Call message("The echo serpent dissipates.")
            level(levelx, levely, playerdepth) = 0
        Case 103
            Call message("The wisp is illuminated.")
            level(levelx, levely, playerdepth) = 0
        Case 104
            Call message("The rage soul boils over.")
            feelings(2) = 1 ' Anger unlock
            level(levelx, levely, playerdepth) = 0
        Case 105
            Call message("The light was stronger than the shadow.")
            level(levelx, levely, playerdepth) = 0
        Case 106
            Call message("The fungus screams within you as it burns.")
            level(levelx, levely, playerdepth) = 0
            Call damageplayer(1, 0)
        Case 800
            Call message("It feels good, but it is ineffective.")
            'this was too powerful
            'CASE 998
            '    CALL message("The water sublimates.")
            '    level(levelx, levely, playerdepth) = 0
            '    groundcolor~&(levelx, levely, playerdepth) = defaultgroundcolor~&(playerdepth)
        Case Else
            If levelx = playerx And levely = playery Then
                Call message("The flames dance within you.")
                Call damageplayer(3, 0)
            End If
    End Select
    Call displayworld
End Sub

Sub spritzsquare (screenx, screeny, levelx, levely)
    target = level(levelx, levely, playerdepth)
    Select Case target
        Case 10
            Call message("The tree doesn't need your pity.")
        Case 11
            level(levelx, levely, playerdepth) = 10
            Call message("The stump bursts forth with new life.")
        Case 12
            Call message("The cactus appreciates your blessing.")
            feelings(5) = 1 ' Gratitude unlock
        Case 50
            Call message("A tiny amount of erosion occurs.")
        Case 51
            Call message("Drops run down the wall.")
        Case 52
            Call message("It's too late for a baptism.")
        Case 101
            Call message("The lost soul is soothed.")
            level(levelx, levely, playerdepth) = 0
        Case 104
            Call message("The rage soul is calmed.")
            level(levelx, levely, playerdepth) = 0
        Case 997
            Call message("The lava repents.")
            level(levelx, levely, playerdepth) = 0
        Case Else
    End Select
    Call displayworld
End Sub

Sub freezesquare (screenx, screeny, levelx, levely)
    target = level(levelx, levely, playerdepth)
    Select Case target
        Case 10
            Call message("The tree stiffens in anger.")
        Case 11
            Call message("A rime of frost appears on the stump.")
        Case 12
            Call message("That's not really what the cactus had in mind.")
        Case 50
            Call message("Cold doesn't bother the stone.")
        Case 51
            Call message("The wall is sound enough to keep the cold out.")

        Case 100
            Call message("The scorpion slows, then hardens, then fades.")
            level(levelx, levely, playerdepth) = 0
        Case 101
            Call message("The lost soul is soothed by the cold.")
            level(levelx, levely, playerdepth) = 0
        Case 102
            Call message("The snake recoils from the cold and vanishes.")
            level(levelx, levely, playerdepth) = 0
        Case 103
            Call message("The wisp is not cut out for cold weather.")
            level(levelx, levely, playerdepth) = 0
        Case 104
            Call message("The rage soul's ardor is cooled.")
            level(levelx, levely, playerdepth) = 0
        Case 105
            Call message("The spider casts no shadow in winter.")
            level(levelx, levely, playerdepth) = 0
        Case 106
            Call message("The fungus shrinks away from the cold.")
            level(levelx, levely, playerdepth) = 0
        Case 800
            Call message("It can't get any colder.")
        Case 997
            Call message("The lava cools and expands.")
            level(levelx, levely, playerdepth) = 50
            seed(levelx, levely, 3) = Int(Rnd * 20)
        Case 998
            Call message("The water freezes.")
            level(levelx, levely, playerdepth) = 0
            seed(levelx, levely, playerdepth) = Int(Rnd * 2) + 81
            groundcolor~&(levelx, levely, playerdepth) = _RGB(100, 255, 255)
        Case Else
    End Select
    Call displayworld
End Sub


Sub acidsquare (screenx, screeny, levelx, levely)
    target = level(levelx, levely, playerdepth)
    Select Case target
        Case 10
            Call message("The tree is unimpressed.")
        Case 11
            Call message("The stump dissolves.")
            level(levelx, levely, playerdepth) = 0
        Case 12
            Call message("The cactus petrifies.")
            level(levelx, levely, playerdepth) = 50
        Case 50
            Call message("Idiot patterns are etched into the stone.")
        Case 51
            Call message("The wall melts.")
            level(levelx, levely, playerdepth) = 0
        Case 100
            Call message("The scorpion spirit dissolves.")
            level(levelx, levely, playerdepth) = 0
        Case 101
            Call message("The lost soul is obliterated.")
            level(levelx, levely, playerdepth) = 0
        Case 102
            Call message("The echo serpent sizzles and disintegrates.")
            level(levelx, levely, playerdepth) = 0
        Case 103
            Call message("The wisp drips away to nothing.")
            level(levelx, levely, playerdepth) = 0
        Case 104
            Call message("The rage soul is consumed by its own bile.")
            level(levelx, levely, playerdepth) = 0
        Case 105
            Call message("The spider-shadow is etched away.")
            level(levelx, levely, playerdepth) = 0
        Case 106
            Call message("The psychic fungus blackens and shrinks.")
            level(levelx, levely, playerdepth) = 0
        Case 800
            Call message("You etch an insulting moustache onto the statue.")
    End Select
    Call displayworld
End Sub


Sub bustamphora (x, y, depth)
    Call message("The contents spill to meet your needs.")
    healthodds = 30
    If (playerhp < 40) Then healthodds = 50
    If (playerhp < 30) Then healthodds = 60
    If (playerhp < 20) Then healthodds = 80
    If (playerhp < 10) Then healthodds = 100

    manaodds = 50
    If (playermp < 25) Then manaodds = 60
    If (playermp < 20) Then manaodds = 70
    If (playermp < 15) Then manaodds = 80
    If (playermp < 10) Then manaodds = 90
    If (playermp < 5) Then manaodds = 100

    If Int(Rnd * 100) < healthodds Then
        level(x, y, depth) = 2
    ElseIf Int(Rnd * 100) < manaodds Then
        level(x, y, depth) = 3
    Else
        level(x, y, depth) = 8 ' fall back to knowledge gem
    End If
End Sub

Sub moveenemies
    ' move enemies and other autonomous objects near the player
    For lop = -15 To 15
        For lopp = -15 To 15
            enemyupdated(lop + 16, lopp + 16) = 0 ' keeping track of whether we've already moved an enemy to a square
        Next lopp
    Next lop
    For lop = -15 To 15
        For lopp = -15 To 15
            If (lop <> 0 Or lopp <> 0) And enemyupdated(lop + 16, lopp + 16) = 0 Then
                enemyx = playerx + lop
                enemyy = playery + lopp
                contents = level(enemyx, enemyy, playerdepth)
                movement = 0
                Select Case contents
                    Case 100 ' ghost scorpion
                        adj = adjacent(lop, lopp)
                        If adj Then ' attack if in melee range
                            Call message("The scorpion spirit still has a sting.")
                            Call damageplayer(3, 0)
                        Else ' infinite detection range
                            If distance(enemyx, enemyy, playerx, playery) < 10 Then movement = 8 ' move randomly
                            If distance(enemyx, enemyy, playerx, playery) < 5 + difficulty Then movement = 1 ' or seek player if close
                            groundcolorlimit~& = groundcolors~&(1)
                        End If
                    Case 101 ' lost soul
                        adj = adjacent(lop, lopp)
                        If adj Then
                            Call message("The lost soul shares its sorrow.")
                            Call damageplayer(2, 2) 'lowish damage
                            soulattacks = soulattacks + 1
                            If soulattacks >= 3 Then feelings(6) = 1 ' Melancholy unlock
                        Else
                            If distance(enemyx, enemyy, playerx, playery) < 12 Then movement = 9 ' move randomly
                            If distance(enemyx, enemyy, playerx, playery) < 6 + difficulty Then movement = 2 ' or seek player if close
                        End If
                    Case 102 ' snake
                        adj = adjacent(lop, lopp)
                        If adj Then ' attack if in melee range
                            Call message("The echo serpent drains what it can.")
                            Call damageplayer(3, 0)
                        Else
                            If distance(enemyx, enemyy, playerx, playery) < 9 Then movement = 8 ' move randomly sticking to groundcolor
                            If distance(enemyx, enemyy, playerx, playery) < 5 + difficulty Then movement = 1 ' or seek player if close
                            groundcolorlimit~& = groundcolors~&(6)
                        End If
                    Case 103 ' will-o-the-wisp
                        adj = adjacent(lop, lopp)
                        If adj Then ' attack if in melee range
                            Call message("The wisp is hypnotic.")
                            Call damageplayer(1, 1)
                        Else ' always seek player from long range, the forest maze makes this okay
                            If distance(enemyx, enemyy, playerx, playery) < 14 Then
                                movement = 1
                                groundcolorlimit~& = groundcolors~&(3)
                            End If
                        End If
                    Case 104 ' rage soul
                        adj = adjacent(lop, lopp)
                        If adj Then
                            Call message("The rage soul screams incoherently.")
                            Call damageplayer(3, 0)
                        Else ' once it's made, seek the player from infinite range

                            movement = 2 ' or seek player if close
                        End If
                    Case 105 ' spider
                        adj = adjacent(lop, lopp)
                        If adj Then
                            Call message("The spider-shadow bites.")
                            Call damageplayer(5, 2)
                        Else
                            If distance(enemyx, enemyy, playerx, playery) < 13 Then movement = 9 ' move randomly
                            If distance(enemyx, enemyy, playerx, playery) < 8 + difficulty Then movement = 2 ' or seek player if close
                            If distance(enemyx, enemyy, playerx, playery) < 4 Then feelings(1) = 1 ' Fear unlock
                        End If
                    Case 106 ' fungus (doesn't care about adjacency, only hurts you if you step through it
                        If distance(enemyx, enemyy, playerx, playery) < 6 Then movement = 10 ' clone self if you get close

                End Select
                If movement = 1 Then ' basic one space toward player on a specific ground color
                    ' this is done in an extremely stupid (overly deterministic) way because it was done quickly
                    moved = 0
                    If playerx > enemyx And level(enemyx + 1, enemyy, playerdepth) = 0 And groundcolor~&(enemyx + 1, enemyy, playerdepth) = groundcolorlimit~& Then
                        Call moveenemy(enemyx, enemyy, enemyx + 1, enemyy)
                        enemyupdated(lop + 16 + 1, lopp + 16) = 1
                        moved = 1
                    End If
                    If moved = 0 And playerx < enemyx And level(enemyx - 1, enemyy, playerdepth) = 0 And groundcolor~&(enemyx - 1, enemyy, playerdepth) = groundcolorlimit~& Then
                        Call moveenemy(enemyx, enemyy, enemyx - 1, enemyy)
                        enemyupdated(lop + 16 - 1, lopp + 16) = 1
                        moved = 1
                    End If
                    If moved = 0 And playery > enemyy And level(enemyx, enemyy + 1, playerdepth) = 0 And groundcolor~&(enemyx, enemyy + 1, playerdepth) = groundcolorlimit~& Then
                        Call moveenemy(enemyx, enemyy, enemyx, enemyy + 1)
                        enemyupdated(lop + 16, lopp + 16 + 1) = 1
                        moved = 1
                    End If
                    If moved = 0 And playery < enemyy And level(enemyx, enemyy - 1, playerdepth) = 0 And groundcolor~&(enemyx, enemyy - 1, playerdepth) = groundcolorlimit~& Then
                        Call moveenemy(enemyx, enemyy, enemyx, enemyy - 1)
                        enemyupdated(lop + 16, lopp + 16 - 1) = 1
                        moved = 1
                    End If
                    If moved = 0 Then movement = 8 ' if we didn't succeed, then wander
                End If
                If movement = 2 Then ' basic one space toward player
                    moved = 0
                    If playerx > enemyx And level(enemyx + 1, enemyy, playerdepth) = 0 Then
                        Call moveenemy(enemyx, enemyy, enemyx + 1, enemyy)
                        enemyupdated(lop + 16 + 1, lopp + 16) = 1
                        moved = 1
                    End If
                    If moved = 0 And playerx < enemyx And level(enemyx - 1, enemyy, playerdepth) = 0 Then
                        Call moveenemy(enemyx, enemyy, enemyx - 1, enemyy)
                        enemyupdated(lop + 16 - 1, lopp + 16) = 1
                        moved = 1
                    End If
                    If moved = 0 And playery > enemyy And level(enemyx, enemyy + 1, playerdepth) = 0 Then
                        Call moveenemy(enemyx, enemyy, enemyx, enemyy + 1)
                        enemyupdated(lop + 16, lopp + 16 + 1) = 1
                        moved = 1
                    End If
                    If moved = 0 And playery < enemyy And level(enemyx, enemyy - 1, playerdepth) = 0 Then
                        Call moveenemy(enemyx, enemyy, enemyx, enemyy - 1)
                        enemyupdated(lop + 16, lopp + 16 - 1) = 1
                        moved = 1
                    End If
                    If moved = 0 Then movement = 9 ' if we didn't succeed then wander
                End If
                If movement = 8 Then 'wander randomly limited by groundcolor
                    tryx = 0: tryy = 0
                    If Int(Rnd * 2) = 1 Then
                        If Int(Rnd * 2) = 1 Then tryx = -1 Else tryx = 1
                    Else
                        If Int(Rnd * 2) = 1 Then tryy = -1 Else tryy = 1
                    End If
                    If level(enemyx + tryx, enemyy + tryy, playerdepth) = 0 And groundcolor~&(enemyx + tryx, enemyy + tryy, playerdepth) = groundcolorlimit~& Then
                        Call moveenemy(enemyx, enemyy, enemyx + tryx, enemyy + tryy)
                        enemyupdated(lop + 16 + tryx, lopp + 16 + tryy) = 1
                        moved = 1
                    End If
                End If
                If movement = 9 Then 'wander randomly
                    tryx = 0: tryy = 0
                    If Int(Rnd * 2) = 1 Then
                        If Int(Rnd * 2) = 1 Then tryx = -1 Else tryx = 1
                    Else
                        If Int(Rnd * 2) = 1 Then tryy = -1 Else tryy = 1
                    End If
                    If level(enemyx + tryx, enemyy + tryy, playerdepth) = 0 Then
                        Call moveenemy(enemyx, enemyy, enemyx + tryx, enemyy + tryy)
                        enemyupdated(lop + 16 + tryx, lopp + 16 + tryy) = 1
                        moved = 1
                    End If
                End If
                If movement = 10 Then ' clone self in a random direction
                    tryx = 0: tryy = 0
                    If Int(Rnd * 2) = 1 Then
                        If Int(Rnd * 2) = 1 Then tryx = -1 Else tryx = 1
                    Else
                        If Int(Rnd * 2) = 1 Then tryy = -1 Else tryy = 1
                    End If
                    If level(enemyx + tryx, enemyy + tryy, playerdepth) = 0 And (enemyx + tryx <> playerx And enemyy + tryy <> playery) Then
                        Call cloneenemy(enemyx, enemyy, enemyx + tryx, enemyy + tryy)
                        enemyupdated(lop + 16 + tryx, lopp + 16 + tryy) = 1
                    End If
                End If

            End If
        Next lopp
    Next lop
End Sub

Sub moveenemy (fromx, fromy, tox, toy)
    level(tox, toy, playerdepth) = level(fromx, fromy, playerdepth)
    level(fromx, fromy, playerdepth) = 0
    Call displayworld
End Sub

Sub cloneenemy (fromx, fromy, tox, toy)
    level(tox, toy, playerdepth) = level(fromx, fromy, playerdepth)
    Call displayworld
End Sub

Function adjacent (x, y)
    adjacent = 0
    If x = -1 And y = 0 Then adjacent = 1
    If x = 1 And y = 0 Then adjacent = 1
    If y = -1 And x = 0 Then adjacent = 1
    If y = 1 And x = 0 Then adjacent = 1
End Function

Sub addmp (amount)
    Call message("You gain " + Str$(amount) + " Influence.")
    playermp = playermp + amount
End Sub

Sub damageplayer (dmg, mdmg)
    Call displayworld
    If dmg > 0 And mdmg > 0 Then
        flash~& = _RGB(255, 0, 255)
        Call message("You lose " + Str$(dmg) + " Coherence and " + Str$(mdmg) + " Influence.")
    End If
    If dmg > 0 And mdmg = 0 Then
        flash~& = _RGB(255, 0, 0)
        Call message("You lose " + Str$(dmg) + " Coherence.")
    End If
    If mdmg > 0 And dmg = 0 Then
        flash~& = _RGB(0, 0, 255)
        Call message("You lose " + Str$(mdmg) + " Influence.")
    End If
    For grolp = 1 To 3
        Color flash~&
        For lop = 1 To 33
            Locate 1, lop: Print Chr$(219)
            Locate 33, lop: Print Chr$(219)
            Locate lop, 1: Print Chr$(219)
            Locate lop, 33: Print Chr$(219)
        Next lop
        _Delay .05
        Color _RGB(255, 255, 255)
        For lop = 1 To 33
            Locate 1, lop: Print Chr$(219)
            Locate 33, lop: Print Chr$(219)
            Locate lop, 1: Print Chr$(219)
            Locate lop, 33: Print Chr$(219)
        Next lop
        _Delay .05
    Next grolp
    playerhp = playerhp - dmg
    playermp = playermp - mdmg
    If playermp < 0 Then playermp = 0
    If playerhp < 0 Then playerhp = 0
    Call updateui
    If playerhp < 1 Then
        For lop = 1 To 10
            Color _RGBA(255, 0, 0, lop * 25)
            For lopp = 2 To 32
                For loppp = 2 To 32
                    Locate lopp, loppp
                    Print Chr$(219)
                Next loppp
            Next lopp
            _Delay .3
        Next lop
        If permadeath = 2 Then
            Call gameoverscreen
        Else
            Color _RGB(0, 0, 0), _RGB(255, 0, 0)
            Locate 17, 10
            Print "Press any key..."
            While InKey$ = "": Wend
            playerx = 99
            playery = 103
            playerdepth = 1
            level(playerx, playery, 1) = 0
            playerhp = balancevar(10)
            playermp = balancevar(11)
            Call displayworld
            Call updateui
        End If
    End If
End Sub

Sub moveplayer (dir$)
    While Timer < lastmove + .15: Wend
    lastmove = Timer
    If debugmovement = 0 Then
        checkcollision = 1
        distmoved = 1
    Else ' debugging level gen and such
        checkcollision = 0
        distmoved = 5
    End If
    drow = 0
    dcol = 0
    Select Case dir$
        Case "up"
            drow = -1
        Case "down"
            drow = 1
        Case "left"
            dcol = -1
        Case "right"
            dcol = 1
    End Select
    ' check collision here, don't be an idiot
    If checkcollision Then
        newspace = level(playerx + dcol, playery + drow, playerdepth)
        If (newspace > 9 And newspace <> 106) Then ' anything other than blank space probably blocks movement? (fungus and pickups)
            drow = 0
            dcol = 0
            Select Case newspace
                Case 10
                    Call message("The tree forbids you from occupying its space.")
                Case 11
                    Call message("The stump's despair gives you pause.")
                Case 12
                    Call message("The cactus wants water, not company.")
                Case 50
                    Call message("You refuse to be one with the stone.")
                Case 51
                    Call message("The wood remembers, and does not yield.")
                Case 52
                    Call message("You're stuck on this side of the grave.")
                Case 90
                    If groundcolor~&(playerx + dcol, playery + drow, playerdepth) = groundcolors~&(1) Then
                        Call message("The amphora has been ignoring ghosts for centuries.")
                    ElseIf groundcolor~&(playerx + dcol, playery + drow, playerdepth) = groundcolors~&(5) Then
                        Call message("A ceramic vessel.  It regards you without comment.")
                    ElseIf groundcolor~&(playerx + dcol, playery + drow, playerdepth) = groundcolors~&(6) Then
                        Call message("The cairn is unmoved by your attention.")
                    Else
                        Call message("These aren't your bones and they don't care about you.")
                    End If
                Case 100, 101, 102, 103, 104, 105
                    Call message("A Coherence collision.  It hurts.")
                    Call damageplayer(5, 0)
                    Call addmp(3)
                Case 800
                    Call message("It looks just like you.  You hate it.")
                Case 997
                    Call message("You would boil away to nothing.")
                Case 998
                    Call message("Fear grips you as you near the water.")
                Case 999
                    Call message("The void rejects you.")
                Case Else
                    Call message("You cannot move through that.")
            End Select
        End If
    End If
    playerx = playerx + (dcol * distmoved)
    playery = playery + (drow * distmoved)
    moved = 1
    If drow = 0 And dcol = 0 Then moved = 0
    If (playerx < 15) Then playerx = 15 ' just in case something goes super wrong
    If (playerx > 285) Then playerx = 285
    If (playery < 15) Then playery = 15
    If (playery > 285) Then playery = 285
    If newspace = 2 Then ' coherence gem
        playerhp = playerhp + balancevar(1)
        Call message("A cluster of Coherence.")
        level(playerx, playery, playerdepth) = 0
    End If
    If newspace = 3 Then ' influence gem
        playermp = playermp + balancevar(2)
        Call message("An accretion of Influence.")
        level(playerx, playery, playerdepth) = 0
    End If
    If newspace = 7 Then ' knowledge fragment
        Call message("A memory is recovered.")
        playerscore = playerscore + balancevar(3)
        level(playerx, playery, playerdepth) = 0
    End If
    If newspace = 8 Then ' knowledge gem
        Call message("A tiny, fleeting memory.")
        playerscore = playerscore + 1
        level(playerx, playery, playerdepth) = 0
    End If
    If newspace = 9 Then ' influence mote
        playermp = playermp + 3
        Call message("A mote of loose Influence.")
        level(playerx, playery, playerdepth) = 0
    End If
    If newspace = 106 Then ' knowledge gem
        Call message("The psychic fungus bursts wetly beneath you.")
        feelings(4) = 1 ' Disgust unlock
        Call damageplayer(difficulty, 0)
        level(playerx, playery, playerdepth) = 0
    End If

    If newspace = 4 Then ' new spell!
        whichspell = 0
        If (playerdepth = 2) Then
            whichspell = 2 ' dagger
            If (playerx < 120 And playery < 120) Then whichspell = 1 ' blade under mountains
            If (playerx > 150 And playery > 150) Then whichspell = 8 ' acid under town
        End If
        If (playerdepth = 1 And playerx < 150 And playery > 150) Then
            If spells(3) = 0 Then whichspell = 3 Else whichspell = 4 ' candle and fireball in desert
        End If
        If (playerdepth = 1 And playerx > 150 And playery < 150) Then ' hammer and bomb in forest
            If spells(5) = 0 Then whichspell = 5 Else whichspell = 6
        End If
        If (playerdepth = 1 And playerx > 150 And playery > 150) Then whichspell = 7 ' holy water in town
        If (playerdepth = 3) Then whichspell = 9 ' ice in lava zone
        spells(whichspell) = whichspell
        If whichspell = 1 Then currentspell = 1 ' autoselect the blade
        level(playerx, playery, playerdepth) = 0
        Select Case whichspell
            Case 1
                Call message("I remember a sword.  I wasn't great with it.")
            Case 2
                Call message("A bow.  Arrows.  Not my cup of tea.")
            Case 3
                Call message("There was a candle.  I liked it.")
            Case 4:
                Call message("Fireballs!  Those were very good.")
            Case 5:
                Call message("A hammer.  Sometimes the problem was a nail.")
            Case 6:
                Call message("I had bombs.  Crude, but effective.")
            Case 7:
                Call message("Holy water.  More Rebecca's style than mine.")
            Case 8:
                Call message("I could make clouds of acid.  I remember.")
            Case 9:
                Call message("A freezing beam.  I was proud of that.")
        End Select
    End If
    If newspace = 5 Then ' stairs down
        If level(playerx, playery, playerdepth + 1) = 6 Then playerdepth = playerdepth + 1 Else Call message("This passage down is blocked.")
        If playerdepth = 3 Then feelings(7) = 1 ' Surprise unlock
    End If
    If newspace = 6 Then ' stairs up
        level(playerx, playery, playerdepth - 1) = 5 ' let the player come up through stairs they haven't revealed yet
        secretstairs(playerx, playery, playerdepth - 1) = 0 ' prevent scrying weirdness
        playerdepth = playerdepth - 1
    End If
    Call advanceframe
    Call updateui
    If moved And playermp = 0 Then
        pitymana = pitymana + 1
        If pitymana > 9 Then
            Call message("You find a trickle of influence, somewhere deep.")
            playermp = 1
            pitymana = 0
        End If
    End If
    If moved Then Call moveenemies
End Sub

Sub advanceframe
    frame = frame + 1
    If frame = 21 Then frame = 1
End Sub

Sub message (k$)

    If k$ = messages$(7) GoTo skipmessage
    For lop = 1 To 6
        messages$(lop) = messages$(lop + 1)
    Next lop
    messages$(7) = k$
    Call updateui
    skipmessage:
End Sub

Function distance (x, y, x2, y2)
    distance = Int(Sqr((Abs(x - x2) ^ 2) + (Abs(y - y2) ^ 2)))
End Function

Sub buildworld
    ' set default seeds for random character display
    For lop = 1 To 300
        For lopp = 1 To 300
            For lopth = 1 To 3
                level(lop, lopp, lopth) = 0 ' overwrite data from previous game
                seed(lop, lopp, lopth) = Int(Rnd * 20) + 1
                groundcolor~&(lop, lopp, lopth) = _RGB(0, 0, 0)
                secretstairs(lop, lopp, lopth) = 0
            Next lopth
        Next lopp
    Next lop


    For lop = 1 To 300
        For lopp = 1 To 300
            ' depth 1 features
            If (distance(lop, lopp, 80, 220) < 50) Or (distance(lop, lopp, 40, 195) < 35) Or (distance(lop, lopp, 100, 260) < 35) Then 'Southwestern desert
                seed(lop, lopp, 1) = Int(Rnd * 20) + 20
                If Int(Rnd * 30) = 1 Then level(lop, lopp, 1) = 12 ' sparse cactus
                If (Int(Rnd * 300) < difficulty) Then level(lop, lopp, 1) = 100 ' scorpions everywhere
                groundcolor~&(lop, lopp, 1) = groundcolors~&(1)
            ElseIf distance(lop, lopp, 220, 80) < 52 Or distance(lop, lopp, 200, 30) < 40 Or distance(lop, lopp, 260, 100) < 40 Then ' northeastern forest
                groundcolor~&(lop, lopp, 1) = groundcolors~&(3)
                If (Int(Rnd * 10) < 3 And level(lop, lopp, 1) = 0) Then level(lop, lopp, 1) = 10 ' random trees, thick enough to be a hassle
                If (Int(Rnd * 100) < difficulty + 1 And level(lop, lopp, 1) = 0) Then level(lop, lopp, 1) = 103 ' wisps everywhere
            ElseIf (distance(lop, lopp, 80, 80) < 50) Or (distance(lop, lopp, 40, 105) < 35) Or (distance(lop, lopp, 90, 40) < 35) Then 'northwestern mountains
                groundcolor~&(lop, lopp, 1) = groundcolors~&(6)
                If (Int(Rnd * 100) = 1) Then level(lop, lopp, 1) = 90 ' cairns fairly common in mountains
                If (Int(Rnd * 100) < difficulty + 1) And distance(lop, lopp, 100, 100) > 15 Then level(lop, lopp, 1) = 102 ' snakes everywhere

            Else ' any unspecified territory
                groundcolor~&(lop, lopp, 1) = groundcolors~&(4)
                If (lop < 184 Or lopp < 184) Then ' stuff that's only outside the village
                    If (Int(Rnd * 20) < 1 And level(lop, lopp, 1) = 0) Then level(lop, lopp, 1) = 10 ' very sparse trees
                    If (Int(Rnd * 30) < 1 And level(lop, lopp, 1) = 0) Then level(lop, lopp, 1) = 50 ' even sparser rocks
                End If
            End If
            ' depth 2
            If (Int(Rnd * 60) < difficulty) Then level(lop, lopp, 2) = 105 ' spiders
            If (Int(Rnd * 50) = 1) Then level(lop, lopp, 2) = 90 ' bone piles underground
            level(lop, lopp, 2) = 50
            groundcolor~&(lop, lopp, 2) = _RGB(55, 55, 55)
            groundcolor~&(lop, lopp, 3) = _RGB(25, 25, 25)
            seed(lop, lopp, 3) = Int(Rnd * 5) + 60 ' for ground effects in deepest level
        Next lopp
    Next lop

    ' generate the deepths (probably move this to last once we figure out how we're getting down here
    For lop = 15 To 285 Step 10
        For lopp = 15 To 285
            ' ancient city walls
            If (Int(Rnd * 20) > 1) Then level(lop, lopp, 3) = 50
            If (Int(Rnd * 20) > 1) Then level(lopp, lop, 3) = 50
            seed(lop, lopp, 3) = 0
            seed(lopp, lop, 3) = 0
        Next lopp
    Next lop
    For lop = 16 To 286 Step 10
        For lopp = 16 To 286 Step 10
            If lop = 146 And lopp = 146 Then
                Call stamproom(lop, lopp, 3, "ancient", 30) ' central spell chamber
            Else
                Call stamproom(lop, lopp, 3, "ancient", 0)
            End If
        Next lopp
    Next lop
    lakex = Int(Rnd * 20) + 100
    lakey = Int(Rnd * 20) + 200
    Call stampcircle(lakex, lakey, 3, Int(Rnd * 5) + 5, "lava", 1)
    Call longriver(lakex, lakey, 3, 2, -1, 0, "lava")
    Call longriver(lakex, lakey, 3, 2, 1, 0, "lava")
    Call longriver(lakex, lakey, 3, 2, 0, -1, "lava")
    Call longriver(lakex, lakey, 3, 2, 0, 1, "lava")
    lakex = 200 + Int(Rnd * 20)
    lakey = 100 + Int(Rnd * 20)
    Call stampcircle(lakex, lakey, 3, Int(Rnd * 5) + 5, "lava", 1)
    Call longriver(lakex, lakey, 3, 2, -1, 0, "lava")
    Call longriver(lakex, lakey, 3, 2, 1, 0, "lava")
    Call longriver(lakex, lakey, 3, 2, 0, -1, "lava")
    Call longriver(lakex, lakey, 3, 2, 0, 1, "lava")

    ' generate mountain area
    For lop = 5 To 185 Step 10
        For lopp = 5 To 185 Step 10
            If groundcolor~&(lop + 9, lopp + 9, 1) = groundcolors~&(6) Then
                Call stamproom(lop + 1, lopp + 1, 1, "mountain", 0)
            End If
        Next lopp
    Next lop
    Call stamproom(95, 95, 1, "mountain", 30) ' starting tile
    ' extremely sparse trees in mountains
    For lop = 1 To 200
        For lopp = 1 To 200
            If groundcolor~&(lop, lopp, 1) = groundcolors~&(6) And Int(Rnd * 30) = 1 And level(lop, lopp, 1) = 0 Then level(lop, lopp, 1) = 10
        Next lopp
    Next lop

    ' initial population of caves
    For lop = 15 To 285 Step 10
        For lopp = 15 To 285 Step 10
            Call stamproom(lop, lopp, 2, "cave", 0) ' stamp random cavern tiles
        Next lopp
    Next lop
    Call stamproom(95, 95, 2, "cave", 30) ' cave beneath starting area

    ' giant central lake
    Call stampcircle(150, 150, 1, Int(Rnd * 5) + 10, "water", 1)
    Call stampcircle(140, 150, 1, 4 + Int(Rnd * 3), "water", 0)
    Call stampcircle(150, 140, 1, 4 + Int(Rnd * 3), "water", 0)
    Call stampcircle(160, 150, 1, 4 + Int(Rnd * 3), "water", 0)
    Call stampcircle(150, 160, 1, 4 + Int(Rnd * 3), "water", 0)
    Call stampcircle(142, 142, 1, 4 + Int(Rnd * 3), "water", 0)
    Call stampcircle(142, 158, 1, 4 + Int(Rnd * 3), "water", 0)
    Call stampcircle(158, 142, 1, 4 + Int(Rnd * 3), "water", 0)
    Call stampcircle(158, 142, 1, 4 + Int(Rnd * 3), "water", 0)

    'radiating rivers
    width1 = Int(Rnd * 2) + 2
    Call longriver(150, 150, 1, width1, 0, 1, "water")
    Call longriver(150, 150, 1, 6 - width1, 0, -1, "water")
    width1 = Int(Rnd * 2) + 2
    Call longriver(150, 150, 1, width1, 1, 0, "water")
    Call longriver(150, 150, 1, 6 - width1, -1, 0, "water")

    ' central island, endgame altar
    Call stampcircle(150, 150, 1, 5, "land", 1)
    level(150, 150, 1) = 800
    'northeastern forest
    For lop = 165 To 285 Step 10
        For lopp = 15 To 145 Step 10
            If groundcolor~&(lop, lopp, 1) = groundcolors~&(3) Then Call stamproom(lop, lopp - 10, 1, "forest", 0)
        Next lopp
    Next lop
    ' forest spell shrines
    Call stamproom(185 + Int(Rnd * 3) + 10, 35 + Int(Rnd * 3) + 10, 1, "forest", 30)
    Call stamproom(245 + Int(Rnd * 2) + 10, 85 + Int(Rnd * 4) + 10, 1, "forest", 30)

    ' roads
    leftedge = 80
    rightedge = 224
    topedge = 80
    bottomedge = 224
    For lop = leftedge - 10 - Int(Rnd * 20) To rightedge + 10 + Int(Rnd * 20)
        Call stampmaterial(lop, topedge, 1, "road")
        Call stampmaterial(lop, topedge + 1, 1, "road")
    Next lop
    For lop = leftedge - 10 - Int(Rnd * 20) To rightedge + 10 + Int(Rnd * 20)
        Call stampmaterial(lop, bottomedge, 1, "road")
        Call stampmaterial(lop, bottomedge + 1, 1, "road")
    Next lop
    For lop = topedge - 10 - Int(Rnd * 20) To bottomedge + 10 + Int(Rnd * 20)
        Call stampmaterial(leftedge, lop, 1, "road")
        Call stampmaterial(leftedge + 1, lop, 1, "road")
    Next lop
    For lop = topedge - 10 - Int(Rnd * 20) To bottomedge + 10 + Int(Rnd * 20)
        Call stampmaterial(rightedge, lop, 1, "road")
        Call stampmaterial(rightedge + 1, lop, 1, "road")
    Next lop


    'southwestern desert ruins
    For lop = 6 To 206 Step 10
        For lopp = 156 To 286 Step 10
            If distance(lop, lopp, 1, 300) < 130 And lop <> 76 Then
                If (Int(Rnd * 5) = 1) Then Call stamproom(lop, lopp, 1, "desert", 0)
            End If
        Next lopp
    Next lop
    ' desert spell shrines
    Call stamproom(86 + (Int(Rnd * 2) * 10), 236 + (Int(Rnd * 2) * 10), 1, "desert", 30)
    Call stamproom(36 + (Int(Rnd * 2) * 10), 186 + (Int(Rnd * 2) * 10), 1, "desert", 30)
    ' dagger room
    lop = 86 + (Int(Rnd * 3) * 10)
    lopp = 186 + (Int(Rnd * 3) * 10)
    Call stamproom(lop, lopp, 1, "desert", 31) ' dagger pyramid
    Call stamproom(lop, lopp, 2, "desert", 32) ' beneath dagger pyramid

    'secret staircases
    For lop = 1 To 20
        placed = 0
        While placed = 0
            testx = Int(Rnd * 150) + 75
            testy = Int(Rnd * 150) + 75
            If level(testx, testy, 1) = 0 And groundcolor~&(testx, testy, 1) = groundcolors~&(4) Then
                placed = 1
                'level(testx, testy - 1, 1) = 400
                If Int(Rnd * 2) = 1 Then level(testx, testy, 1) = 10 Else level(testx, testy, 1) = 50 'stairs hidden in a rock or a tree
                secretstairs(testx, testy, 1) = 1
                circsize = 4 + Int(Rnd * 2)
                Call stampcircle(testx, testy, 2, circsize + 2, "rock", 1)
                Call stampcircle(testx, testy, 2, circsize, "emptycave", 1)
                level(testx, testy, 2) = 6
                xoff = Int(Rnd * 2) + 1
                yoff = Int(Rnd * 2) + 1
                If (Int(Rnd * 2) = 1) Then xoff = -xoff
                If (Int(Rnd * 2) = 1) Then yoff = -yoff
                level(testx + xoff, testy + yoff, 2) = 7 ' hide those memories
            End If
        Wend
    Next lop


    ' southeastern village roads
    For lop = 184 To 284 Step 10 ' horizontal roads
        offset = Int((284 - lop) / 5)
        leftend = 174 + offset - Int(Rnd * 8)
        For lopp = leftend To 284
            Call stampmaterial(lopp, lop, 1, "road")
            Call stampmaterial(lopp, lop + 1, 1, "road")
        Next lopp
    Next lop
    For lop = 184 To 284 Step 10 ' vertical roads
        offset = Int((284 - lop) / 5)
        topend = 174 + offset - Int(Rnd * 8)
        For lopp = topend To 284
            Call stampmaterial(lop, lopp, 1, "road")
            Call stampmaterial(lop + 1, lopp, 1, "road")
        Next lopp
    Next lop

    'southeastern village buildings
    For lop = 186 To 286 Step 10
        For lopp = 186 To 286 Step 10
            chance = distance(lop, lopp, 240, 240)
            If (chance < 40 + Int(Rnd * 50)) Then
                Call stamproom(lop, lopp, 1, "town", 0) ' stamp random town rooms
            End If
        Next lopp
    Next lop
    For lop = 216 To 234
        For lopp = 216 To 234
            groundcolor~&(lop, lopp, 1) = groundcolors~&(4)
            seed(lop, lopp, 1) = 1
        Next lopp
    Next lop

    Call stamproom(216, 216, 1, "special", 1) 'cathedral
    Call stamproom(216, 216, 2, "special", 2) 'crypt
    secretstairs(230, 217, 1) = 1 ' tombstone

    spotx = 196 + Int(Rnd * 3) * 10
    spoty = 196 + Int(Rnd * 2) * 10
    Call stamproom(spotx, spoty, 1, "town", 30) ' house with basement
    Call stamproom(spotx, spoty, 2, "town", 31) ' and the basement

    ' debug nonsense
    'level(95, 95, 1) = 7 'scorpion
    'level(215, 212, 1) = 3 'scorpion
    'level(250, 100, 1) = 103


    ' slice off the outside edges with Void Space
    ' shrink in as you go further down
    For lop = 1 To 300
        For lopp = 1 To 300
            For lopth = 1 To 3
                dist = Int(Sqr((Abs(lop - 150) ^ 2) + (Abs(lopp - 150) ^ 2)))
                thresh = 130 + Int(Rnd * 5)
                If lopth = 2 Then thresh = 110 + Int(Rnd * 5)
                If lopth = 3 Then thresh = 90 + Int(Rnd * 5)
                If (dist > thresh) Then level(lop, lopp, lopth) = 999
                If (dist > thresh) Then groundcolor~&(lop, lopp, lopth) = _RGB(0, 0, 0)
            Next lopth
        Next lopp
    Next lop

    placedstairs = 0 ' place stairways from cave level to ancient ruins level
    While placedstairs < 11
        lop = Int(Rnd * 260) + 20
        lopp = Int(Rnd * 260) + 20
        ringu = distance(lop, lopp, 150, 150)
        If ringu > 80 And ringu < 90 And (lop < 130 Or lopp < 130) And (lop < 130 Or lop > 170) And (lopp < 130 Or lopp > 170) Then
            placedstairs = placedstairs + 1
            Call stampcircle(lop, lopp, 2, 4, "rock", 0)
            Call stampcircle(lop, lopp, 2, 3, "emptycave", 1)
            level(lop, lopp, 2) = 5
            Call stampcircle(lop, lopp, 3, 4, "emptyspace", 1)
            level(lop, lopp, 3) = 6
            For gorp = 1 To 8
                xoff = Int(Rnd * 5) - 2
                yoff = Int(Rnd * 5) - 2
                If xoff <> 0 And yoff <> 0 Then
                    level(lop + xoff, lopp + yoff, 3) = 50 ' drop rubble around the stairs
                    seed(lop + xoff, lopp + yoff, 3) = Int(Rnd * 20) + 1 ' make it normal rock if it hits clean ruin rock
                End If
            Next gorp
        End If
    Wend

    ' clear area around player
    For lop = -2 To 2
        For lopp = -2 To 2
            level(playerx + lop, playery + lopp, 1) = 0
            'groundcolor~&(playerx + lop, playery + lopp, 1) = _RGB(166, 116, 0)
        Next lopp
    Next lop


End Sub

Sub longriver (x, y, depth, riverwidth, xdir, ydir, material$)
    wobble = 0
    xpos = x
    ypos = y
    While xpos > 10 And xpos < 290 And ypos > 10 And ypos < 290
        Call stampmaterial(xpos, ypos, depth, material$)
        If (riverwidth > 1) Then
            If xdir = 0 Then Call stampmaterial(xpos - 1, ypos, depth, material$) Else Call stampmaterial(xpos, ypos - 1, depth, material$)
        End If
        If (riverwidth > 2) Then
            If xdir = 0 Then Call stampmaterial(xpos + 1, ypos, depth, material$) Else Call stampmaterial(xpos, ypos + 1, depth, material$)
        End If
        If (riverwidth > 3) Then
            If xdir = 0 Then Call stampmaterial(xpos - 2, ypos, depth, material$) Else Call stampmaterial(xpos, ypos - 2, depth, material$)
        End If
        If (riverwidth > 4) Then
            If xdir = 0 Then Call stampmaterial(xpos + 2, ypos, depth, material$) Else Call stampmaterial(xpos, ypos + 2, depth, material$)
        End If
        Call stampmaterial(xpos, ypos, depth, material$)
        xpos = xpos + xdir
        ypos = ypos + ydir
        wobble = wobble + 1
        If (wobble > Int(Rnd * 3) + 3) Then
            wobble = 0
            If ydir = 0 Then
                If Int(Rnd * 2) = 1 Then ypos = ypos + 1 Else ypos = ypos - 1
            End If
            If xdir = 0 Then
                If Int(Rnd * 2) = 1 Then xpos = xpos + 1 Else xpos = xpos - 1
            End If
        End If
    Wend
End Sub

Sub stampmaterial (x, y, depth, material$)
    Select Case material$
        Case "emptycave"
            level(x, y, depth) = 0
        Case "land"
            level(x, y, depth) = 0
            groundcolor~&(x, y, depth) = defaultgroundcolor~&(depth)
        Case "water"
            level(x, y, depth) = 998
            groundcolor~&(x, y, depth) = _RGB(0, 0, 255)
        Case "rock"
            level(x, y, depth) = 50
        Case "lava"
            level(x, y, depth) = 997
        Case "road"
            If (level(x, y, depth) = 998) Then
                level(x, y, depth) = 0
                seed(x, y, depth) = 51
            Else
                groundcolor~&(x, y, depth) = _RGB(126, 81, 9)
                level(x, y, depth) = 0
                seed(x, y, depth) = Int(Rnd * 7) + 52
            End If
    End Select
End Sub

Sub stampcircle (x, y, depth, radius, material$, messy)
    For lop = -radius To radius
        For lopp = -radius To radius
            xpos = x + lop
            ypos = y + lopp
            dist = Int(Sqr((Abs(xpos - x) ^ 2) + (Abs(ypos - y) ^ 2)))
            thresh = radius
            If messy And Int(Rnd * 2) = 1 Then thresh = radius - 1
            If dist < thresh Then
                Call stampmaterial(xpos, ypos, depth, material$)
            End If
        Next lopp
    Next lop
End Sub


Sub initialize
    playerx = 99
    playery = 103
    playerhp = balancevar(10)
    playermp = balancevar(11)
    playerdepth = 1
    For lop = 1 To 9
        spells(lop) = 0
        feelings(lop) = 0
    Next lop
    gameover = 0
    exiting = 0
    currentspell = 0
    ' spelldata
    spellnames$(1) = "Sword"
    spellcosts(1) = 1
    spellnames$(2) = "Bow"
    spellcosts(2) = 1
    spellnames$(3) = "Candle"
    spellcosts(3) = 3
    If difficulty = 1 Then spellcosts(3) = 2
    spellnames$(4) = "Fireball"
    spellcosts(4) = 5
    If difficulty = 1 Then spellcosts(4) = 3
    spellnames$(5) = "Hammer"
    spellcosts(5) = 3
    If difficulty = 1 Then spellcosts(5) = 2
    spellnames$(6) = "Bomb"
    spellcosts(6) = 5
    If difficulty = 1 Then spellcosts(6) = 3
    spellnames$(7) = "Holy Water"
    spellcosts(7) = 1
    spellnames$(8) = "Acid"
    spellcosts(8) = 3
    If difficulty = 1 Then spellcosts(8) = 2
    spellnames$(9) = "Ice"
    spellcosts(9) = 3
    pitymana = 0

    ' default ground colors for things left behind
    defaultgroundcolor~&(1) = _RGB(166, 116, 0)
    groundcolors~&(1) = _RGB(214, 212, 68) ' desert
    groundcolors~&(2) = _RGB(99, 99, 99) ' ash
    groundcolors~&(3) = _RGB(17, 120, 100) ' forest
    groundcolors~&(4) = _RGB(39, 174, 96) ' riverbank/town
    groundcolors~&(5) = _RGB(220, 154, 130) ' house floor
    groundcolors~&(6) = _RGB(154, 125, 10) ' mountain ground

End Sub
Function balancevar (x)
    If x = 1 Then balancevar = 3 ' coherence gem
    If x = 2 Then balancevar = 10 ' influence gem
    If x = 3 Then balancevar = 10 ' recovered memory
    If x = 10 Then balancevar = 70 - (difficulty * 10) ' starting HP
    If x = 11 Then balancevar = 60 - (difficulty * 10) ' starting MP
End Function

Sub stamproom (x, y, depth, type$, which)
    Dim townrooms$(40, 8)
    townrooms$(0, 1) = "........"
    townrooms$(0, 2) = "........"
    townrooms$(0, 3) = "........"
    townrooms$(0, 4) = "........"
    townrooms$(0, 5) = "........"
    townrooms$(0, 6) = "........"
    townrooms$(0, 7) = "........"
    townrooms$(0, 8) = "........"
    townrooms$(1, 1) = "SSSSSsSS"
    townrooms$(1, 2) = "SttttttS"
    townrooms$(1, 3) = "st.tt.tS"
    townrooms$(1, 4) = "St....tS"
    townrooms$(1, 5) = "SttO.ttS"
    townrooms$(1, 6) = "st....ts"
    townrooms$(1, 7) = "Stt..ttS"
    townrooms$(1, 8) = "SSs..sSS"
    townrooms$(2, 1) = "........"
    townrooms$(2, 2) = ".WWWWWW."
    townrooms$(2, 3) = ".W,,,,W."
    townrooms$(2, 4) = ".W,l,,W."
    townrooms$(2, 5) = ".WWWWWW."
    townrooms$(2, 6) = "....O..."
    townrooms$(2, 7) = ".t....t."
    townrooms$(2, 8) = "..t..t.."
    townrooms$(3, 1) = "WWWW.tt."
    townrooms$(3, 2) = "W,pW.tt."
    townrooms$(3, 3) = "Wl,W...."
    townrooms$(3, 4) = "WWWW.WWW"
    townrooms$(3, 5) = ".....WlW"
    townrooms$(3, 6) = ".t.WWW,W"
    townrooms$(3, 7) = ".t.W,ppW"
    townrooms$(3, 8) = "...WWWWW"
    townrooms$(4, 1) = "WWWWWWWW"
    townrooms$(4, 2) = "W,,,P,,W"
    townrooms$(4, 3) = "W,,,,,,W"
    townrooms$(4, 4) = "WW,WWWWW"
    townrooms$(4, 5) = "W,,,W..."
    townrooms$(4, 6) = "W,l,W..."
    townrooms$(4, 7) = "Wp,,W..."
    townrooms$(4, 8) = "WWWWW..."
    townrooms$(5, 1) = "WWWWWWWW"
    townrooms$(5, 2) = "Wl,,,,pW"
    townrooms$(5, 3) = "W,,W,,,W"
    townrooms$(5, 4) = "WWWW,,,W"
    townrooms$(5, 5) = "W,,,,,,W"
    townrooms$(5, 6) = "W,,W,lpW"
    townrooms$(5, 7) = "WWWWWWWW"
    townrooms$(5, 8) = "........"
    townrooms$(6, 1) = "........"
    townrooms$(6, 2) = "WWWWWWWW"
    townrooms$(6, 3) = "W,,P,,,W"
    townrooms$(6, 4) = "W,,,l,,W"
    townrooms$(6, 5) = "WWWWWWWW"
    townrooms$(6, 6) = "..T..T.."
    townrooms$(6, 7) = "..T..T.."
    townrooms$(6, 8) = "..T..T.."
    townrooms$(7, 1) = "SSSSSSSS"
    townrooms$(7, 2) = "SP,,,,PS"
    townrooms$(7, 3) = "S,,O,,,S"
    townrooms$(7, 4) = "SP,,O,PS"
    townrooms$(7, 5) = "SSSSSSSS"
    townrooms$(7, 6) = "..S..S.."
    townrooms$(7, 7) = "........"
    townrooms$(7, 8) = "..S..S.."

    townrooms$(30, 1) = "WWWWWWWW" ' basement house
    townrooms$(30, 2) = "W,,,,,>W"
    townrooms$(30, 3) = "W,,WWWWW"
    townrooms$(30, 4) = "W,,W...."
    townrooms$(30, 5) = "WW,W.TT."
    townrooms$(30, 6) = "W,,W.TT."
    townrooms$(30, 7) = "W,,W...."
    townrooms$(30, 8) = "WWWW...."
    townrooms$(31, 1) = "SSSSSSSS" ' under it
    townrooms$(31, 2) = "S.....<S"
    townrooms$(31, 3) = "S...SSSS"
    townrooms$(31, 4) = "S...SSSS"
    townrooms$(31, 5) = "S.O....S"
    townrooms$(31, 6) = "S.OO.!.S"
    townrooms$(31, 7) = "S......S"
    townrooms$(31, 8) = "SSSSSSSS"

    If type$ = "town" Then
        forcemode = 0
        If which > 0 Then forcemode = 1 ' don't rotate prefab bits
        If which = 0 Then which = Int(Rnd * 7) + 1
        mode = Int(Rnd * 8) + 1 ' which rotation
        If forcemode = 1 Then mode = 1
        For lop = 1 To 8
            For lopp = 1 To 8
                If mode = 1 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(townrooms$(which, lop), lopp, 1))
                If mode = 2 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(townrooms$(which, 9 - lop), lopp, 1))
                If mode = 3 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(townrooms$(which, lop), 9 - lopp, 1))
                If mode = 4 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(townrooms$(which, 9 - lop), 9 - lopp, 1))
                If mode = 5 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(townrooms$(which, lopp), lop, 1))
                If mode = 6 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(townrooms$(which, 9 - lopp), lop, 1))
                If mode = 7 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(townrooms$(which, lopp), 9 - lop, 1))
                If mode = 8 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(townrooms$(which, 9 - lopp), 9 - lop, 1))
            Next lopp
        Next lop
    End If

    Dim desertrooms$(40, 9)
    desertrooms$(0, 1) = "........."
    desertrooms$(0, 2) = "........."
    desertrooms$(0, 3) = "........."
    desertrooms$(0, 4) = "........."
    desertrooms$(0, 5) = "........."
    desertrooms$(0, 6) = "........."
    desertrooms$(0, 7) = "........."
    desertrooms$(0, 8) = "........."
    desertrooms$(0, 9) = "........."

    desertrooms$(1, 1) = "..k...k.."
    desertrooms$(1, 2) = ".SSssssSa"
    desertrooms$(1, 3) = ".S......."
    desertrooms$(1, 4) = "ks....k.."
    desertrooms$(1, 5) = ".sa......"
    desertrooms$(1, 6) = ".s......."
    desertrooms$(1, 7) = "kS..k...."
    desertrooms$(1, 8) = ".S......."
    desertrooms$(1, 9) = "........."

    desertrooms$(2, 1) = ".s..s...."
    desertrooms$(2, 2) = "......k.."
    desertrooms$(2, 3) = ".SSSS...."
    desertrooms$(2, 4) = ".SAAS..k."
    desertrooms$(2, 5) = ".S..S...."
    desertrooms$(2, 6) = ".SssS.k.."
    desertrooms$(2, 7) = "........."
    desertrooms$(2, 8) = ".s..s..k."
    desertrooms$(2, 9) = "........."

    desertrooms$(3, 1) = "SSSSSSSSS"
    desertrooms$(3, 2) = "S..k....S"
    desertrooms$(3, 3) = "S.SSSSS.S"
    desertrooms$(3, 4) = "S.SaaaS.S"
    desertrooms$(3, 5) = "SkSaaas.S"
    desertrooms$(3, 6) = "S.SaaaSkS"
    desertrooms$(3, 7) = "S.SSSSS.S"
    desertrooms$(3, 8) = "S...k...S"
    desertrooms$(3, 9) = "SSSSSSSSS"

    desertrooms$(4, 1) = ".......c."
    desertrooms$(4, 2) = "....cc.k."
    desertrooms$(4, 3) = ".cc......"
    desertrooms$(4, 4) = "k.sSSSSs."
    desertrooms$(4, 5) = "..sSSSSs."
    desertrooms$(4, 6) = "...aAa..."
    desertrooms$(4, 7) = ".......c."
    desertrooms$(4, 8) = "..c.k.c.."
    desertrooms$(4, 9) = ".c......."

    desertrooms$(5, 1) = "...s...cc"
    desertrooms$(5, 2) = "..s....cc"
    desertrooms$(5, 3) = "...s....."
    desertrooms$(5, 4) = ".k..sa..."
    desertrooms$(5, 5) = ".....s..."
    desertrooms$(5, 6) = "..c.k.s.s"
    desertrooms$(5, 7) = ".c.c...s."
    desertrooms$(5, 8) = "..c......"
    desertrooms$(5, 9) = ".....k..."


    desertrooms$(30, 1) = ".cSSSSSc."
    desertrooms$(30, 2) = "c.S.!.S.c"
    desertrooms$(30, 3) = ".k...cck."
    desertrooms$(30, 4) = "..S...Sc."
    desertrooms$(30, 5) = ".c..cc..."
    desertrooms$(30, 6) = "..S.c.S.c"
    desertrooms$(30, 7) = ".k..cc.k."
    desertrooms$(30, 8) = "..S...S.."
    desertrooms$(30, 9) = "c...cc..c"

    desertrooms$(31, 1) = "..cccc..."
    desertrooms$(31, 2) = ".cc..cc.."
    desertrooms$(31, 3) = ".c.S.Scc."
    desertrooms$(31, 4) = ".cSS>SSc."
    desertrooms$(31, 5) = "cc.SSScc."
    desertrooms$(31, 6) = ".c..S.c.."
    desertrooms$(31, 7) = "..cc...c."
    desertrooms$(31, 8) = "..c.cc.c."
    desertrooms$(31, 9) = "........."

    desertrooms$(32, 1) = "SSSS.SSSS"
    desertrooms$(32, 2) = "SSS...SSS"
    desertrooms$(32, 3) = "SS.....SS"
    desertrooms$(32, 4) = "S...<...S"
    desertrooms$(32, 5) = "SS.....SS"
    desertrooms$(32, 6) = "SSS.!.SSS"
    desertrooms$(32, 7) = "SSSS.SSSS"
    desertrooms$(32, 8) = "SSSSSSSSS"
    desertrooms$(32, 9) = "........."

    If type$ = "desert" Then
        forcemode = 0
        If which > 0 Then forcemode = 1 ' don't rotate prefab bits
        If which = 0 Then which = Int(Rnd * 5) + 1
        mode = Int(Rnd * 8) + 1 ' which rotation
        If forcemode = 1 Then mode = 1
        For lop = 1 To 9
            For lopp = 1 To 9
                If mode = 1 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(desertrooms$(which, lop), lopp, 1))
                If mode = 2 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(desertrooms$(which, 10 - lop), lopp, 1))
                If mode = 3 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(desertrooms$(which, lop), 10 - lopp, 1))
                If mode = 4 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(desertrooms$(which, 10 - lop), 10 - lopp, 1))
                If mode = 5 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(desertrooms$(which, lopp), lop, 1))
                If mode = 6 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(desertrooms$(which, 10 - lopp), lop, 1))
                If mode = 7 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(desertrooms$(which, lopp), 10 - lop, 1))
                If mode = 8 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(desertrooms$(which, 10 - lopp), 10 - lop, 1))
            Next lopp
        Next lop
    End If

    Dim caverooms$(40, 10)
    caverooms$(0, 1) = ".........."
    caverooms$(0, 2) = ".........."
    caverooms$(0, 3) = ".........."
    caverooms$(0, 4) = ".........."
    caverooms$(0, 5) = ".........."
    caverooms$(0, 6) = ".........."
    caverooms$(0, 7) = ".........."
    caverooms$(0, 8) = ".........."
    caverooms$(0, 9) = ".........."
    caverooms$(0, 10) = ".........."

    caverooms$(1, 1) = "SSSS...SSS"
    caverooms$(1, 2) = "SS......SS"
    caverooms$(1, 3) = "S........S"
    caverooms$(1, 4) = ".........S"
    caverooms$(1, 5) = ".........."
    caverooms$(1, 6) = ".........."
    caverooms$(1, 7) = ".........S"
    caverooms$(1, 8) = "SS.......S"
    caverooms$(1, 9) = "SS......SS"
    caverooms$(1, 10) = "SSS....SSS"

    caverooms$(2, 1) = "SSSSSSSSSS"
    caverooms$(2, 2) = "SSSSSSSSSS"
    caverooms$(2, 3) = "SSSSSSSSSS"
    caverooms$(2, 4) = "sSSSSSSSs."
    caverooms$(2, 5) = "...sSs...."
    caverooms$(2, 6) = ".........s"
    caverooms$(2, 7) = "SSS...sSSS"
    caverooms$(2, 8) = "SSSSSSSSSS"
    caverooms$(2, 9) = "SSSSSSSSSS"
    caverooms$(2, 10) = "SSSSSSSSSS"

    caverooms$(3, 1) = "SSSSSSSSSS"
    caverooms$(3, 2) = "SSSSSSSSSS"
    caverooms$(3, 3) = "SSSSSSSSSS"
    caverooms$(3, 4) = "SSSs...SsS"
    caverooms$(3, 5) = "Ss......SS"
    caverooms$(3, 6) = "S........S"
    caverooms$(3, 7) = "Ss.......S"
    caverooms$(3, 8) = "SS......sS"
    caverooms$(3, 9) = "SSSs...sSS"
    caverooms$(3, 10) = "SSSS.sSSSS"

    caverooms$(4, 1) = "SSSS..SSSS"
    caverooms$(4, 2) = "SSSs..sSSS"
    caverooms$(4, 3) = "SSS....SSS"
    caverooms$(4, 4) = "SSs.ss.sSS"
    caverooms$(4, 5) = ".........."
    caverooms$(4, 6) = "....ss...."
    caverooms$(4, 7) = "SSSSSSSSSS"
    caverooms$(4, 8) = "SSSSSSSSSS"
    caverooms$(4, 9) = "SSSSSSSSSS"
    caverooms$(4, 10) = "SSSSSSSSSS"

    caverooms$(5, 1) = "SSSSSSSSSS"
    caverooms$(5, 2) = "SSSSSsSSSS"
    caverooms$(5, 3) = "SSSSSSSSSS"
    caverooms$(5, 4) = "SSSSSSSSSS"
    caverooms$(5, 5) = "SSsSSSSsSS"
    caverooms$(5, 6) = "SSSSSSSSSS"
    caverooms$(5, 7) = "SSSSSSSSsS"
    caverooms$(5, 8) = "SSSSSSSSSS"
    caverooms$(5, 9) = "SSSssssSSS"
    caverooms$(5, 10) = "SSs....sSS"

    caverooms$(6, 1) = "SSSS.SSSSS"
    caverooms$(6, 2) = "SSSS.SSSSS"
    caverooms$(6, 3) = "SSSS..SSSS"
    caverooms$(6, 4) = "SSSSS..SSS"
    caverooms$(6, 5) = "sSSSSS...."
    caverooms$(6, 6) = "sssssSSSSS"
    caverooms$(6, 7) = "S...sSSSSS"
    caverooms$(6, 8) = "S...sSSSSS"
    caverooms$(6, 9) = "Ss..sSSSSS"
    caverooms$(6, 10) = "SSSSSSSSSS"

    caverooms$(7, 1) = "SSSS.SSSSS"
    caverooms$(7, 2) = "SSSS.SSSSS"
    caverooms$(7, 3) = "SSSs.SSSSS"
    caverooms$(7, 4) = "SSss.sSSSS"
    caverooms$(7, 5) = ".....ssSSS"
    caverooms$(7, 6) = "SSSs......"
    caverooms$(7, 7) = "SSSss.ssSS"
    caverooms$(7, 8) = "SSSSS.sSSS"
    caverooms$(7, 9) = "SSSSS.SSSS"
    caverooms$(7, 10) = "SSSSS.SSSS"


    caverooms$(30, 1) = "SSSSSSSSSS"
    caverooms$(30, 2) = "SSSSSSSSSS"
    caverooms$(30, 3) = "SSSs:::sSS"
    caverooms$(30, 4) = "SSs::!:sSS"
    caverooms$(30, 5) = "SS::::::SS"
    caverooms$(30, 6) = "SS::<:::SS"
    caverooms$(30, 7) = "SSs::::sSS"
    caverooms$(30, 8) = "SSSs::sSSS"
    caverooms$(30, 9) = "SSSSSSSSSS"
    caverooms$(30, 10) = "SSSSSSSSSS"


    If type$ = "cave" Then
        forcemode = 0
        If which > 0 Then forcemode = 1 ' don't rotate prefab bits
        If which = 0 Then which = Int(Rnd * 7) + 1
        mode = Int(Rnd * 8) + 1 ' which rotation
        If forcemode = 1 Then mode = 1
        For lop = 1 To 10
            For lopp = 1 To 10
                If mode = 1 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(caverooms$(which, lop), lopp, 1))
                If mode = 2 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(caverooms$(which, 11 - lop), lopp, 1))
                If mode = 3 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(caverooms$(which, lop), 11 - lopp, 1))
                If mode = 4 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(caverooms$(which, 11 - lop), 11 - lopp, 1))
                If mode = 5 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(caverooms$(which, lopp), lop, 1))
                If mode = 6 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(caverooms$(which, 11 - lopp), lop, 1))
                If mode = 7 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(caverooms$(which, lopp), 11 - lop, 1))
                If mode = 8 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(caverooms$(which, 11 - lopp), 11 - lop, 1))
            Next lopp
        Next lop
    End If

    Dim mountainrooms$(40, 9)
    mountainrooms$(0, 1) = "........."
    mountainrooms$(0, 2) = "........."
    mountainrooms$(0, 3) = "........."
    mountainrooms$(0, 4) = "........."
    mountainrooms$(0, 5) = "........."
    mountainrooms$(0, 6) = "........."
    mountainrooms$(0, 7) = "........."
    mountainrooms$(0, 8) = "........."
    mountainrooms$(0, 9) = "........."
    mountainrooms$(1, 1) = "........."
    mountainrooms$(1, 2) = "..ss....."
    mountainrooms$(1, 3) = ".sSSs...."
    mountainrooms$(1, 4) = ".sSSs...."
    mountainrooms$(1, 5) = "..ss....."
    mountainrooms$(1, 6) = ".....ss.."
    mountainrooms$(1, 7) = "....sSSs."
    mountainrooms$(1, 8) = "....sSSs."
    mountainrooms$(1, 9) = ".....ss.."
    mountainrooms$(2, 1) = ".ssss...."
    mountainrooms$(2, 2) = "sSSSSs..."
    mountainrooms$(2, 3) = "sSSSSs..."
    mountainrooms$(2, 4) = "sSSSs...."
    mountainrooms$(2, 5) = "sSSs....."
    mountainrooms$(2, 6) = ".ss......"
    mountainrooms$(2, 7) = "........."
    mountainrooms$(2, 8) = "........."
    mountainrooms$(2, 9) = "........."
    mountainrooms$(3, 1) = ".ss......"
    mountainrooms$(3, 2) = ".SS......"
    mountainrooms$(3, 3) = ".SSs....."
    mountainrooms$(3, 4) = ".SSs....."
    mountainrooms$(3, 5) = ".SSs....."
    mountainrooms$(3, 6) = ".SSs....."
    mountainrooms$(3, 7) = ".SSs....."
    mountainrooms$(3, 8) = ".SS......"
    mountainrooms$(3, 9) = ".ss......"


    mountainrooms$(30, 1) = "........."
    mountainrooms$(30, 2) = "...s....."
    mountainrooms$(30, 3) = "..sSSs..."
    mountainrooms$(30, 4) = ".sSSSSSs."
    mountainrooms$(30, 5) = "sSSSSSSS."
    mountainrooms$(30, 6) = ".sSS>SSs."
    mountainrooms$(30, 7) = "........."
    mountainrooms$(30, 8) = "........."
    mountainrooms$(30, 9) = "........."


    If type$ = "mountain" Then
        forcemode = 0
        If which > 0 Then forcemode = 1 ' don't rotate prefab bits
        If which = 0 Then which = Int(Rnd * 3) + 1

        mode = Int(Rnd * 8) + 1 ' which rotation
        If forcemode = 1 Then mode = 1
        For lop = 1 To 9
            For lopp = 1 To 9
                If mode = 1 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(mountainrooms$(which, lop), lopp, 1))
                If mode = 2 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(mountainrooms$(which, 10 - lop), lopp, 1))
                If mode = 3 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(mountainrooms$(which, lop), 10 - lopp, 1))
                If mode = 4 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(mountainrooms$(which, 10 - lop), 10 - lopp, 1))
                If mode = 5 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(mountainrooms$(which, lopp), lop, 1))
                If mode = 6 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(mountainrooms$(which, 10 - lopp), lop, 1))
                If mode = 7 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(mountainrooms$(which, lopp), 10 - lop, 1))
                If mode = 8 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(mountainrooms$(which, 10 - lopp), 10 - lop, 1))
            Next lopp
        Next lop
    End If

    Dim ancientrooms$(40, 9)
    ancientrooms$(0, 1) = "........."
    ancientrooms$(0, 2) = "........."
    ancientrooms$(0, 3) = "........."
    ancientrooms$(0, 4) = "........."
    ancientrooms$(0, 5) = "........."
    ancientrooms$(0, 6) = "........."
    ancientrooms$(0, 7) = "........."
    ancientrooms$(0, 8) = "........."
    ancientrooms$(0, 9) = "........."

    ancientrooms$(1, 1) = "....R...."
    ancientrooms$(1, 2) = "....R...."
    ancientrooms$(1, 3) = "....r...."
    ancientrooms$(1, 4) = "....R...."
    ancientrooms$(1, 5) = "RRrRRRrRR"
    ancientrooms$(1, 6) = "....R...."
    ancientrooms$(1, 7) = "....r...."
    ancientrooms$(1, 8) = ".9..R...."
    ancientrooms$(1, 9) = "....R...."
    ancientrooms$(2, 1) = "........."
    ancientrooms$(2, 2) = "........."
    ancientrooms$(2, 3) = "..RRRRR.."
    ancientrooms$(2, 4) = "..R...R.."
    ancientrooms$(2, 5) = "..R.9.R.."
    ancientrooms$(2, 6) = "..R...R.."
    ancientrooms$(2, 7) = "..RRrRR.."
    ancientrooms$(2, 8) = "........."
    ancientrooms$(2, 9) = "........."
    ancientrooms$(3, 1) = "........."
    ancientrooms$(3, 2) = "....9...."
    ancientrooms$(3, 3) = "........."
    ancientrooms$(3, 4) = "....R...."
    ancientrooms$(3, 5) = "...RRR..."
    ancientrooms$(3, 6) = "....R...."
    ancientrooms$(3, 7) = "........."
    ancientrooms$(3, 8) = "........."
    ancientrooms$(3, 9) = "........."
    ancientrooms$(4, 1) = "........."
    ancientrooms$(4, 2) = "........."
    ancientrooms$(4, 3) = "........."
    ancientrooms$(4, 4) = "........."
    ancientrooms$(4, 5) = "....9...."
    ancientrooms$(4, 6) = "........."
    ancientrooms$(4, 7) = "........."
    ancientrooms$(4, 8) = "........."
    ancientrooms$(4, 9) = "........."

    ancientrooms$(30, 1) = "R...R...R"
    ancientrooms$(30, 2) = "........."
    ancientrooms$(30, 3) = "..R.R.R.."
    ancientrooms$(30, 4) = "........."
    ancientrooms$(30, 5) = "R.R.!.R.R"
    ancientrooms$(30, 6) = "........."
    ancientrooms$(30, 7) = "..R.R.R.."
    ancientrooms$(30, 8) = "........."
    ancientrooms$(30, 9) = "R...R...R"


    If type$ = "ancient" Then
        forcemode = 0
        If which > 0 Then forcemode = 1 ' don't rotate prefab bits
        If which = 0 Then which = Int(Rnd * 4) + 1

        mode = Int(Rnd * 8) + 1 ' which rotation
        If forcemode = 1 Then mode = 1
        For lop = 1 To 9
            For lopp = 1 To 9
                If mode = 1 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(ancientrooms$(which, lop), lopp, 1))
                If mode = 2 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(ancientrooms$(which, 10 - lop), lopp, 1))
                If mode = 3 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(ancientrooms$(which, lop), 10 - lopp, 1))
                If mode = 4 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(ancientrooms$(which, 10 - lop), 10 - lopp, 1))
                If mode = 5 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(ancientrooms$(which, lopp), lop, 1))
                If mode = 6 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(ancientrooms$(which, 10 - lopp), lop, 1))
                If mode = 7 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(ancientrooms$(which, lopp), 10 - lop, 1))
                If mode = 8 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(ancientrooms$(which, 10 - lopp), 10 - lop, 1))
            Next lopp
        Next lop
    End If


    Dim forestrooms$(40, 10)
    forestrooms$(0, 1) = "''''''''''"
    forestrooms$(0, 2) = "''''''''''"
    forestrooms$(0, 3) = "''''''''''"
    forestrooms$(0, 4) = "''''''''''"
    forestrooms$(0, 5) = "''''''''''"
    forestrooms$(0, 6) = "''''''''''"
    forestrooms$(0, 7) = "''''''''''"
    forestrooms$(0, 8) = "''''''''''"
    forestrooms$(0, 9) = "''''''''''"
    forestrooms$(0, 10) = "''''''''''"

    forestrooms$(1, 1) = "''''TT''''"
    forestrooms$(1, 2) = "''''TT''''"
    forestrooms$(1, 3) = "''''TTT'''"
    forestrooms$(1, 4) = "'''''TTT''"
    forestrooms$(1, 5) = "TTT'''TTTT"
    forestrooms$(1, 6) = "TTTT'''TTT"
    forestrooms$(1, 7) = "''TTT'''''"
    forestrooms$(1, 8) = "'''TTT''''"
    forestrooms$(1, 9) = "''''TT''''"
    forestrooms$(1, 10) = "''''TT''''"

    forestrooms$(2, 1) = "''''TT''''"
    forestrooms$(2, 2) = "''''tt''''"
    forestrooms$(2, 3) = "''''''''''"
    forestrooms$(2, 4) = "'''TTT''''"
    forestrooms$(2, 5) = "TTTtttTTTT"
    forestrooms$(2, 6) = "TTTtttTTTT"
    forestrooms$(2, 7) = "'''TTT''''"
    forestrooms$(2, 8) = "''''''''''"
    forestrooms$(2, 9) = "'''''tt'''"
    forestrooms$(2, 10) = "''''TT''''"


    forestrooms$(30, 1) = "''''TT''''"
    forestrooms$(30, 2) = "''''TT''''"
    forestrooms$(30, 3) = "''tTTtT'''"
    forestrooms$(30, 4) = "'TTtttTtT'"
    forestrooms$(30, 5) = "TTtSSStTTT"
    forestrooms$(30, 6) = "TttS!SttTT"
    forestrooms$(30, 7) = "'tt...tt''"
    forestrooms$(30, 8) = "''Tt.tT'''"
    forestrooms$(30, 9) = "'''TtTt'''"
    forestrooms$(30, 10) = "''''TT''''"


    If type$ = "forest" Then
        forcemode = 0
        If which > 0 Then forcemode = 1 ' don't rotate prefab bits
        If which = 0 Then which = Int(Rnd * 2) + 1
        mode = Int(Rnd * 8) + 1 ' which rotation
        If forcemode = 1 Then mode = 1
        For lop = 1 To 10
            For lopp = 1 To 10
                If mode = 1 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(forestrooms$(which, lop), lopp, 1))
                If mode = 2 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(forestrooms$(which, 11 - lop), lopp, 1))
                If mode = 3 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(forestrooms$(which, lop), 11 - lopp, 1))
                If mode = 4 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(forestrooms$(which, 11 - lop), 11 - lopp, 1))
                If mode = 5 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(forestrooms$(which, lopp), lop, 1))
                If mode = 6 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(forestrooms$(which, 11 - lopp), lop, 1))
                If mode = 7 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(forestrooms$(which, lopp), 11 - lop, 1))
                If mode = 8 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(forestrooms$(which, 11 - lopp), 11 - lop, 1))
            Next lopp
        Next lop
    End If

    Dim specialrooms$(40, 20)
    specialrooms$(0, 1) = "...................."
    specialrooms$(0, 2) = "...................."
    specialrooms$(0, 3) = "...................."
    specialrooms$(0, 4) = "...................."
    specialrooms$(0, 5) = "...................."
    specialrooms$(0, 6) = "...................."
    specialrooms$(0, 7) = "...................."
    specialrooms$(0, 8) = "...................."
    specialrooms$(0, 9) = "...................."
    specialrooms$(0, 10) = "...................."
    specialrooms$(0, 11) = "...................."
    specialrooms$(0, 12) = "...................."
    specialrooms$(0, 13) = "...................."
    specialrooms$(0, 14) = "...................."
    specialrooms$(0, 15) = "...................."
    specialrooms$(0, 16) = "...................."
    specialrooms$(0, 17) = "...................."
    specialrooms$(0, 18) = "...................."
    specialrooms$(0, 19) = "...................."
    specialrooms$(0, 20) = "...................."

    specialrooms$(1, 1) = "......WWWWWWW......."
    specialrooms$(1, 2) = "......W,,,,,W.G....."
    specialrooms$(1, 3) = "......W,,,,,W......."
    specialrooms$(1, 4) = "..WWWWWWWWW,WWWWW..."
    specialrooms$(1, 5) = "..W,,,,,SSS,W,,,W..."
    specialrooms$(1, 6) = "..W,,,W,S!S,W,,,W..."
    specialrooms$(1, 7) = "..W,,,W,SSS,W,,,W..."
    specialrooms$(1, 8) = "..W,,,W,,l,,W,,,W..."
    specialrooms$(1, 9) = "..W,,,W,,,,,,,,,W..."
    specialrooms$(1, 10) = "..WWWWW,l,l,WWWWW..."
    specialrooms$(1, 11) = "......W,,,,,W......."
    specialrooms$(1, 12) = ".SSSS.W,l,l,W.G.G.G."
    specialrooms$(1, 13) = ".S.>S.W,,,,,W......."
    specialrooms$(1, 14) = ".SSSS.W,l,l,W.G.G..."
    specialrooms$(1, 15) = "......W,,,,,W......."
    specialrooms$(1, 16) = "..G.G.W,,,,,W.G.G.G."
    specialrooms$(1, 17) = "......WWWWWWW......."
    specialrooms$(1, 18) = "..G.G.........G.G..."
    specialrooms$(1, 19) = "...................."
    specialrooms$(1, 20) = "...................."

    specialrooms$(2, 1) = "ss..sSSSSSSSSSSSSSSS"
    specialrooms$(2, 2) = "s..sSSSSSSSS..<..SSS"
    specialrooms$(2, 3) = "..sSSSSSSSS.......SS"
    specialrooms$(2, 4) = ".sSSSSSSSSS..@.@..SS"
    specialrooms$(2, 5) = "sSSSSSSSSSSS..@..SSS"
    specialrooms$(2, 6) = "SSSSSSSsSSSSSSSSSSSS"
    specialrooms$(2, 7) = "SSSSSSSSSSSSSSSSSSSS"
    specialrooms$(2, 8) = "SSSSsSSSSSSSsSSSSSSS"
    specialrooms$(2, 9) = "SSSSSSSSSSSSSSSsSSSS"
    specialrooms$(2, 10) = "SSSSSS.A.A.A.SSSSSSS"
    specialrooms$(2, 11) = "SS...........SSSSSSS"
    specialrooms$(2, 12) = "SS.SSS.A.A.A.SSSSSSS"
    specialrooms$(2, 13) = "SS.<SSSSSSSSSSSSSSSS"
    specialrooms$(2, 14) = "SSSSSSSSSSSSSSSSSSSS"
    specialrooms$(2, 15) = "SSSSSSSSSSSSSSSSSSSS"
    specialrooms$(2, 16) = "SSSSSSSSSSSSSSSSSSSS"
    specialrooms$(2, 17) = "SSSSSSSSSSSSSSSSSSSs"
    specialrooms$(2, 18) = "SSSSSSSSSSSSSSSSSSs."
    specialrooms$(2, 19) = ".SSSSSSSSSSSSSSSs..s"
    specialrooms$(2, 20) = "..SSSSSSSSSSSSSSs.ss"



    If type$ = "special" Then
        forcemode = 0
        If which > 0 Then forcemode = 1 ' don't rotate prefab bits
        If which = 0 Then which = Int(Rnd * 2) + 1
        mode = Int(Rnd * 8) + 1 ' which rotation
        If forcemode = 1 Then mode = 1
        For lop = 1 To 20
            For lopp = 1 To 20
                If mode = 1 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(specialrooms$(which, lop), lopp, 1))
                If mode = 2 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(specialrooms$(which, 21 - lop), lopp, 1))
                If mode = 3 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(specialrooms$(which, lop), 21 - lopp, 1))
                If mode = 4 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(specialrooms$(which, 21 - lop), 21 - lopp, 1))
                If mode = 5 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(specialrooms$(which, lopp), lop, 1))
                If mode = 6 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(specialrooms$(which, 21 - lopp), lop, 1))
                If mode = 7 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(specialrooms$(which, lopp), 21 - lop, 1))
                If mode = 8 Then Call stampchar(x - 1 + lopp, y - 1 + lop, depth, Mid$(specialrooms$(which, 21 - lopp), 21 - lop, 1))
            Next lopp
        Next lop
    End If


End Sub

Sub stampchar (x, y, depth, char$)
    Select Case char$
        Case "." ' enforced nothing
            level(x, y, depth) = 0
            If depth = 3 Then ' fungus in the deepths
                If Int(Rnd * 50) = 1 Then
                    level(x, y, depth) = 106
                End If
            End If
            If depth = 2 Then ' spiders and cairns
                If Int(Rnd * 50) = 1 Then
                    level(x, y, depth) = 105
                ElseIf (Int(Rnd * 50) = 1) Then
                    level(x, y, depth) = 90
                End If
            End If
        Case ":" ' supernothing
            level(x, y, depth) = 0
        Case "," ' wood floor
            level(x, y, depth) = 0
            groundcolor~&(x, y, depth) = groundcolors~&(5)
        Case ">"
            level(x, y, depth) = 5
            groundcolor~&(x, y, depth) = _RGB(0, 0, 0)
        Case "<"
            level(x, y, depth) = 6
            groundcolor~&(x, y, depth) = _RGB(0, 0, 0)
        Case "@"
            level(x, y, depth) = 7
        Case "!" ' spell
            level(x, y, depth) = 4
        Case "9" ' influence mote
            chance = 10
            If difficulty = 2 Then chance = 7
            If difficulty = 3 Then chance = 4
            If Int(Rnd * 10) + 1 <= chance Then level(x, y, depth) = 9
        Case "T" 'tree
            level(x, y, depth) = 10
        Case "t" ' 50% tree
            If Int(Rnd * 2) = 1 Then level(x, y, depth) = 10
        Case "A" 'amphora
            level(x, y, depth) = 90
        Case "a" ' 25% amphora
            If (Int(Rnd * 2) = 1) Then level(x, y, depth) = 90 Else level(x, y, depth) = 0 '' since this is possibly overwriting a desert ruin
        Case "P" 'amphora in house
            level(x, y, depth) = 90
            groundcolor~&(x, y, depth) = groundcolors~&(5)
        Case "p" ' 25% amphora in house
            If (Int(Rnd * 2) = 1) Then level(x, y, depth) = 90 Else level(x, y, depth) = 0 '' since this is possibly overwriting a desert ruin
            groundcolor~&(x, y, depth) = groundcolors~&(5)
        Case "C" 'cactus
            level(x, y, depth) = 12
        Case "c" ' 50% cactus
            If Int(Rnd * 2) = 1 Then level(x, y, depth) = 12 Else level(x, y, depth) = 0 '' since this is possibly overwriting a desert ruin
        Case "S" ' stone
            level(x, y, depth) = 50
        Case "s" ' 50% stone
            If Int(Rnd * 2) = 1 Then level(x, y, depth) = 50 Else level(x, y, depth) = 0 '' since we fill in the caves fully in the beginning...
        Case "R" ' stone in ruins
            level(x, y, depth) = 50
            seed(x, y, depth) = 0
        Case "r" ' 50% stone     in ruins
            If Int(Rnd * 2) = 1 Then
                level(x, y, depth) = 50
                seed(x, y, depth) = 0
            End If
        Case "W" ' wood wall
            level(x, y, depth) = 51
            groundcolor~&(x, y, depth) = groundcolors~&(5)
        Case "w" ' 50% wood wall
            If Int(Rnd * 2) = 1 Then level(x, y, depth) = 51
            groundcolor~&(x, y, depth) = groundcolors~&(5)
        Case "G" ' gravestone
            level(x, y, depth) = 52
        Case "L" ' lost soul (indoors)
            level(x, y, depth) = 101
            groundcolor~&(x, y, depth) = groundcolors~&(5)
        Case "l" ' lost soul          (indoors)
            If Int(Rnd * 2) = 1 Then level(x, y, depth) = 101
            groundcolor~&(x, y, depth) = groundcolors~&(5)
        Case "O" ' lost soul (outdoors)
            level(x, y, depth) = 101
        Case "o" ' lost soul          (outdoors)
            If Int(Rnd * 2) = 1 Then level(x, y, depth) = 101
        Case "K" ' scorpion
            level(x, y, depth) = 100
        Case "k" ' 50% scorpion
            If Int(Rnd * 2) = 1 Then level(x, y, depth) = 100

    End Select
End Sub

Sub drawline (row, line$)
    For lop = 1 To 60
        Locate row + 2, lop
        Select Case Mid$(line$, lop, 1)

            Case "X"
                Color _RGB(255, 255, 255), _RGB(0, 0, 0)
                Print Chr$(219);
            Case "R"
                Color _RGB(255, 0, 0), _RGB(0, 0, 0)
                Print Chr$(219);
            Case "W"
                Color _RGB(155, 155, 155), _RGB(0, 0, 0)
                Print Chr$(219);
            Case Else
        End Select
    Next lop
End Sub

Sub titlescreen
    Color _RGB(255, 255, 255), _RGB(0, 0, 0)
    Cls

    Call drawline(2, "....WWWWWWWWWWWW............................................")
    Call drawline(3, "....WWWWWWWWWWWW................XX..X..X...XX....XX..XXXXX..")
    Call drawline(4, "..WWWWWWWWWWWWWWWW.............X..X.X..X..X..X..X......X....")
    Call drawline(5, "..WWWWWWWWWWWWWWWW............X.....XXXX.X....X..XX....X....")
    Call drawline(6, "..WWWW..WWWW..WWWW............X..XX.X..X.X....X....X...X....")
    Call drawline(7, "..WWWW..WWWW..WWWW.............X..X.X..X..X..X..X..X...X....")
    Call drawline(8, "..WWWWWWWWWWWWWWWW..............XX..X..X...XX....XX....X....")
    Call drawline(9, "..WWWWWWWWWWWWWWWW..........................................")
    Call drawline(10, "..WWWW........WWWW.....X.....X.XXX.XXXX...X...XXXX..XXX.....")
    Call drawline(11, "..WWWW........WWWW.....X.....X..X.....X..X.X..X...X.X..X....")
    Call drawline(12, "..WWWWWW....WWWWWW.....X..X..X..X....X..X...X.XXXX..X...X...")
    Call drawline(13, "..WWWWWW....WWWWWW......X.X.X...X...X...XXXXX.X.X...X...X...")
    Call drawline(14, "..WWWWWWWWWWWWWWWW......X.X.X...X..X....X...X.X..X..X..X....")
    Call drawline(15, "..WWWWWWWWWWWWWWWW.......X.X...XXX.XXXX.X...X.X...X.XXX.....")
    Call drawline(16, "....WWWWWWWWWWWW............................................")
    Call drawline(17, "....WWWWWWWWWWWW............................................")

    If permadeath = 0 Then permadeath = 1 ' initialize these
    If difficulty = 0 Then difficulty = 2
    Color _RGB(255, 255, 255), _RGB(0, 0, 0)

    inputtop:
    fore~& = _RGB(255, 255, 255)
    unselectedback~& = _RGB(0, 0, 0)
    selectedback~& = _RGB(50, 50, 255)
    Locate 25, 3
    If permadeath = 1 Then Color fore~&, selectedback~& Else Color fore~&, unselectedback~&
    Print " (A) Adventure Mode "
    Locate 26, 3
    If permadeath = 2 Then Color fore~&, selectedback~& Else Color fore~&, unselectedback~&
    Print " (R) Roguelike Mode "

    Locate 25, 27
    If difficulty = 1 Then Color fore~&, selectedback~& Else Color fore~&, unselectedback~&
    Print " (1) Easy "
    Locate 26, 27
    If difficulty = 2 Then Color fore~&, selectedback~& Else Color fore~&, unselectedback~&
    Print " (2) Medium "
    Locate 27, 27
    If difficulty = 3 Then Color fore~&, selectedback~& Else Color fore~&, unselectedback~&
    Print " (3) Hard "

    Color _RGB(255, 255, 255), _RGB(0, 0, 0)

    Locate 25, 45
    Print "(P) Play"
    Locate 26, 45
    Print "(Q) Quit"
    k$ = ""
    While k$ = ""
        k$ = UCase$(InKey$)
        Select Case k$
            Case "A"
                permadeath = 1
            Case "R"
                permadeath = 2
            Case "1"
                difficulty = 1
            Case "2"
                difficulty = 2
            Case "3"
                difficulty = 3
            Case "Q"
                System
            Case "P"
                Exit Sub
        End Select
    Wend
    GoTo inputtop
End Sub


Sub gameoverscreen
    Cls

    Call drawline(2, "....WWWWWWWWWWWW............................................")
    Call drawline(3, "....WWWWWWWWWWWW...............RR....R...R...R.RRRR.........")
    Call drawline(4, "..WWWWWWWWWWWWWWWW............R..R..R.R..RR.RR.R............")
    Call drawline(5, "..WWWWWWWWWWWWWWWW...........R.....R...R.R.R.R.RRRR.........")
    Call drawline(6, "..WWWW..WWWW..WWWW...........R..RR.RRRRR.R...R.R............")
    Call drawline(7, "..WWWW..WWWW..WWWW............R..R.R...R.R...R.R............")
    Call drawline(8, "..WWWWWWWWWWWWWWWW.............RR..R...R.R...R.RRRR.........")
    Call drawline(9, "..WWWWWWWWWWWWWWWW..........................................")
    Call drawline(10, "..WWWWWW....WWWWWW............RR...R...R.RRRR.RRRR..........")
    Call drawline(11, "..WWWWWW....WWWWWW...........R..R..R...R.R....R...R.........")
    Call drawline(12, "..WWWW........WWWW..........R....R.R...R.RRRR.RRRR..........")
    Call drawline(13, "..WWWW........WWWW..........R....R..R.R..R....R.R...........")
    Call drawline(14, "..WWWWWWWWWWWWWWWW...........R..R...R.R..R....R..R..........")
    Call drawline(15, "..WWWWWWWWWWWWWWWW............RR.....R...RRRR.R...R.........")
    Call drawline(16, "....WWWWWWWWWWWW............................................")
    Call drawline(17, "....WWWWWWWWWWWW............................................")

    Locate 25, 22
    Print "Press any key..."
    While InKey$ = "": Wend
    gameover = 1

End Sub

Sub winscreen
    Color _RGB(255, 255, 255), _RGB(0, 0, 0)
    Cls
    Call drawline(2, "............................................................")
    Call drawline(3, "...........X...X...XX...X..X.....X.....X...XX...X...X..X....")
    Call drawline(4, "...........X...X..X..X..X..X.....X.....X..X..X..XX..X..X....")
    Call drawline(5, "............X.X..X....X.X..X.....X..X..X.X....X.X.X.X..X....")
    Call drawline(6, ".............X...X....X.X..X......X.X.X..X....X.X..XX..X....")
    Call drawline(7, ".............X....X..X..X..X......X.X.X...X..X..X...X.......")
    Call drawline(8, ".............X.....XX....XX........X.X.....XX...X...X..X....")
    Call drawline(9, "............................................................")
    Call drawline(10, "............................................................")
    Call drawline(11, "............................................................")
    Call drawline(12, "..WWWWWW....WWWW............................................")
    Call drawline(13, "..WWWWWW....WWWW............................................")
    Call drawline(14, "....WWWWWWWWWW......WW......................................")
    Call drawline(15, "....WWWWWWWWWW......WW......................................")
    Call drawline(16, "WW..WWWWWWWWWWWW..WWWWWW..WW................................")
    Call drawline(17, "WW..WWWWWWWWWWWW..WWWWWW..WW................................")

    Color _RGB(255, 255, 255)
    Locate 22, 20
    Print "Thank you for playing!"
    Locate 24, 22
    Print "Press any key..."
    While InKey$ = "": Wend
    gameover = 1
End Sub

