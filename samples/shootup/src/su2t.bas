'CHDIR ".\samples\pete\su2"

' Interesting facts
' Programmed on windows 95 that runs at 50-60 Mhz
' Had to remake all movement just for the bullets
' listen to music while programming
' All remade in a few hours( don't know how long, just one afternoon-not that long)
' Made BY me - Nixon
' Rewrite most of it for a better editor which can load any color and any ASCII char (almost)
' Only spent a few days to finish everything
DECLARE SUB loadmap ()
DECLARE SUB instructions ()
Dim Shared map$(100, 100), bullet(100), bx(100), by(100), bd(100)
DECLARE SUB center (text$)
DECLARE SUB border ()
On Error GoTo fixfile
Print "calculating speed"
maximum = 1D+18
oldtime = Timer
For i = 1 To maximum
    Locate 2, 1: Print Timer
    If Timer >= oldtime + 1 Then speed = i: GoTo speed
Next
speed:

Screen 13
menu:
Cls
Color 4
Print " S H O O T   U P   V 2  "
Print "   ‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€    "
Print "  €€€€€€€€€€€€€€€€€›    "
Print " ≤≤≤≤≤‹‹ﬂ               "
Print "‹≤≤≤≤                 "
Print "≤≤≤≤               "
Print ""
Print ""
Print ""
Color 12
Print "1) The Game"
Print "2) Instructions"
Print "3) Exit"
Do: P$ = InKey$: Loop Until P$ <> ""
If P$ = "1" Then GoTo top
If P$ = "2" Then Call instructions
If P$ = "3" Then Cls: End
GoTo menu
top:
Cls
U$ = Chr$(0) + "H"
D$ = Chr$(0) + "P"
R$ = Chr$(0) + "M"
L$ = Chr$(0) + "K"
Color 15
Print "1)Map 1"
Color 7
Print "2)Map 2"
Color 8
Print "3)Map 3"
Print "4)Map 4"
Color 7
Print "5)Custom"
Color 15
Input "Choice"; pick
If pick = 1 Then file$ = "map"
If pick = 2 Then file$ = "map2"
If pick = 3 Then file$ = "map3"
If pick = 4 Then file$ = "map4"
If pick = 5 Then Input "Map to load(no extensions)"; file$
choice:
Open file$ + ".dat" For Input As #1
Cls
Call border
players = 0
For yy = 1 To 12
    For xx = 1 To 27
        Input #1, map$(xx, yy)
        For i = 1 To 5
            If Mid$(map$(xx, yy), i, 1) = "-" Then B$ = Mid$(map$(xx, yy), 1, i - 1): item2 = Val(Mid$(map$(xx, yy), i + 1, 10))
        Next
        c = Val(B$)
        If c = 0 Or item2 = 0 Or item2 = 255 Or item2 = 32 Then map$(xx, yy) = "0-0"
        Color c: Locate yy + 4, xx + 6: Print Chr$(item2)
        'IF players = 2 AND item2 = 2 THEN map$(xx, yy) = "0-0": LOCATE yy + 4, xx + 6: PRINT " "
        If item2 = 2 Then Color c: Locate yy + 4, xx + 6: Print Chr$(2): c2 = c: p2x = xx: p2y = yy: map$(xx, yy) = "0-0": players = players + 1
        If item2 = 1 Then Color c: Locate yy + 4, xx + 6: Print Chr$(1): c1 = c: p1x = xx: p1y = yy: map$(xx, yy) = "0-0": players = players + 1
Next: Next
Close #1

hp1 = 5
hp2 = 5
Do
    P$ = InKey$: If P$ = Chr$(27) Then End
    For find = 1 To 20
        If Mid$(map$(p1x, p1y), find, 1) = "-" Then legn = find
    Next
    If Mid$(map$(p1x, p1y), legn + 2, 4) = "178" Then Locate p1y + 4, p1x + 6: Color Val(Mid$(map$(p1x, p1y), 1, legn)): Print Chr$(178)
    If P$ <> "" And map$(p1x, p1y) = "0-0" Then Locate p1y + 4, p1x + 6: Print " "
    If P$ = U$ And map$(p1x, p1y - 1) = "0-0" And p1y <> 1 Or P$ = U$ And Mid$(map$(p1x, p1y - 1), legn + 2, 3) = "178" And p1y <> 1 Then Color 15: p1y = p1y - 1: Color c1: Locate p1y + 4, p1x + 6: Print Chr$(1)
    If P$ = D$ And map$(p1x, p1y + 1) = "0-0" And p1y <> 12 Or P$ = D$ And Mid$(map$(p1x, p1y + 1), legn + 2, 3) = "178" And p1y <> 12 Then Color 15: p1y = p1y + 1: Color c1: Locate p1y + 4, p1x + 6: Print Chr$(1)
    If P$ = R$ And map$(p1x + 1, p1y) = "0-0" And p1x <> 27 Or P$ = R$ And Mid$(map$(p1x + 1, p1y), legn + 2, 3) = "178" And p1x <> 27 Then Color 15: p1x = p1x + 1: Color c1: Locate p1y + 4, p1x + 6: Print Chr$(1)
    If P$ = L$ And map$(p1x - 1, p1y) = "0-0" And p1x <> 1 Or P$ = L$ And Mid$(map$(p1x - 1, p1y), legn + 2, 3) = "178" And p1x <> 1 Then Color 15: p1x = p1x - 1: Color c1: Locate p1y + 4, p1x + 6: Print Chr$(1)
    Color c1: Locate p1y + 4, p1x + 6: Print Chr$(1)

    If P$ = "p" And map$(p1x, p1y - 1) = "0-0" Or P$ = "p" And Mid$(map$(p1x, p1y - 1), legn + 2, 3) = "178" Then
        For i = 1 To 100
            If bullet(i) = 0 Then bullet(i) = 1: bd(i) = 0: by(i) = p1y: bx(i) = p1x: GoTo continue
        Next
    End If

    If P$ = ";" And map$(p1x, p1y + 1) = "0-0" Or P$ = ";" And Mid$(map$(p1x, p1y + 1), legn + 2, 3) = "178" Then
        For i = 1 To 100
            If bullet(i) = 0 Then bullet(i) = 1: bd(i) = 1: by(i) = p1y: bx(i) = p1x: GoTo continue
        Next
    End If

    If P$ = "'" And map$(p1x + 1, p1y) = "0-0" Or P$ = "'" And Mid$(map$(p1x + 1, p1y), legn + 2, 3) = "178" Then
        For i = 1 To 100
            If bullet(i) = 0 Then bullet(i) = 1: bd(i) = 2: by(i) = p1y: bx(i) = p1x: GoTo continue
        Next
    End If

    If P$ = "l" And map$(p1x - 1, p1y) = "0-0" Or P$ = "l" And Mid$(map$(p1x - 1, p1y), legn + 2, 3) = "178" Then
        For i = 1 To 100
            If bullet(i) = 0 Then bullet(i) = 1: bd(i) = 3: by(i) = p1y: bx(i) = p1x: GoTo continue
        Next
    End If
 
    For find = 1 To 20
        If Mid$(map$(p1x, p1y), find, 1) = "-" Then legn = find
    Next

    If Mid$(map$(p2x, p2y), legn + 2, 4) = "178" Then Locate p2y + 4, p2x + 6: Color Val(Mid$(map$(p2x, p2y), 1, legn)): Print Chr$(178)
    If P$ <> "" And map$(p2x, p2y) = "0-0" Then Locate p2y + 4, p2x + 6: Print " "
    If P$ = "t" And map$(p2x, p2y - 1) = "0-0" And p2y <> 1 Or P$ = "t" And Mid$(map$(p2x, p2y - 1), legn + 2, 3) = "178" And p2y <> 1 Then Color 7: p2y = p2y - 1: Color c2: Locate p2y + 4, p2x + 6: Print Chr$(2)
    If P$ = "g" And map$(p2x, p2y + 1) = "0-0" And p2y <> 12 Or P$ = "g" And Mid$(map$(p2x, p2y + 1), legn + 2, 3) = "178" And p2y <> 12 Then Color 7: p2y = p2y + 1: Color c2: Locate p2y + 4, p2x + 6: Print Chr$(2)
    If P$ = "h" And map$(p2x + 1, p2y) = "0-0" And p2x <> 27 Or P$ = "h" And Mid$(map$(p2x + 1, p2y), legn + 2, 3) = "178" And p2x <> 27 Then Color 7:: p2x = p2x + 1: Color c2: Locate p2y + 4, p2x + 6: Print Chr$(2)
    If P$ = "f" And map$(p2x - 1, p2y) = "0-0" And p2x <> 1 Or P$ = "f" And Mid$(map$(p2x - 1, p2y), legn + 2, 3) = "178" And p2x <> 1 Then Color 7:: p2x = p2x - 1: Color c2: Locate p2y + 4, p2x + 6: Print Chr$(2)
    Color c2: Locate p2y + 4, p2x + 6: Print Chr$(2)

    If P$ = "w" And map$(p2x, p2y - 1) = "0-0" Or P$ = "w" And Mid$(map$(p2x, p2y - 1), legn + 2, 3) = "178" Then
        For i = 1 To 100
            If bullet(i) = 0 Then bullet(i) = 1: bd(i) = 0: by(i) = p2y: bx(i) = p2x: GoTo continue
        Next
    End If

    If P$ = "s" And map$(p2x, p2y + 1) = "0-0" Or P$ = "s" And Mid$(map$(p2x, p2y + 1), legn + 2, 3) = "178" Then
        For i = 1 To 100
            If bullet(i) = 0 Then bullet(i) = 1: bd(i) = 1: by(i) = p2y: bx(i) = p2x: GoTo continue
        Next
    End If

    If P$ = "d" And map$(p2x + 1, p2y) = "0-0" Or P$ = "d" And Mid$(map$(p2x + 1, p2y), legn + 2, 3) = "178" Then
        For i = 1 To 100
            If bullet(i) = 0 Then bullet(i) = 1: bd(i) = 2: by(i) = p2y: bx(i) = p2x: GoTo continue
        Next
    End If

    If P$ = "a" And map$(p2x - 1, p2y) = "0-0" Or P$ = "a" And Mid$(map$(p2x - 1, p2y), legn + 2, 3) = "178" Then
        For i = 1 To 100
            If bullet(i) = 0 Then bullet(i) = 1: bd(i) = 3: by(i) = p2y: bx(i) = p2x: GoTo continue
        Next
    End If

    continue:
    For i = 1 To 100
        If bullet(i) = 1 Then
            Locate by(i) + 4, bx(i) + 6: Print " "
            For find = 1 To 20
                If Mid$(map$(bx(i), by(i)), find, 1) = "-" Then leg = find
            Next
            If Mid$(map$(bx(i), by(i)), leg + 2, 4) = "178" Then Locate by(i) + 4, bx(i) + 6: Color Val(Mid$(map$(bx(i), by(i)), 1, leg)): Print Chr$(178)

            If Mid$(map$(bx(i), by(i)), leg + 2, 4) = "176" Then Locate by(i) + 4, bx(i) + 6: Color Val(Mid$(map$(bx(i), by(i)), 1, leg)): Print Chr$(Val(Mid$(map$(bx(i), by(i)), leg + 1, Len(map$(bx(i), by(i))))))
            If bd(i) = 0 Then by(i) = by(i) - 1
            If bd(i) = 1 Then by(i) = by(i) + 1
            If bd(i) = 2 Then bx(i) = bx(i) + 1
            If bd(i) = 3 Then bx(i) = bx(i) - 1
            If by(i) = 0 Or by(i) = 13 Then bullet(i) = 0
            If bx(i) = 0 Or bx(i) = 28 Then bullet(i) = 0
            If map$(bx(i), by(i)) <> "0-0" Then
                bullet(i) = 0
                For find = 1 To 20
                    If Mid$(map$(bx(i), by(i)), find, 1) = "-" Then leg = find
                Next
                If Mid$(map$(bx(i), by(i)), leg + 2, 4) = "177" Then map$(bx(i), by(i)) = "0-0": Locate by(i) + 4, bx(i) + 6: Print " "
                If Mid$(map$(bx(i), by(i)), leg + 2, 4) = "176" Then bullet(i) = 1
                If Mid$(map$(bx(i), by(i)), leg + 2, 4) = "178" Then bullet(i) = 1

            End If
            If bx(i) = p1x And by(i) = p1y Then bullet(i) = 0: hp1 = hp1 - 1
            If bx(i) = p2x And by(i) = p2y Then bullet(i) = 0: hp2 = hp2 - 1
            If bullet(i) = 1 Then Locate by(i) + 4, bx(i) + 6: Color 15: Print Chr$(248)
        End If
    Next

    Color c1: Locate p1y + 4, p1x + 6: Print Chr$(1): Color c2: Locate p2y + 4, p2x + 6: Print Chr$(2)
    Locate 19, 6: Color 12: Print "P1 Health"
    If hp1 = 5 Then Locate 20, 6: Color 4: Print "    "
    If hp1 = 4 Then Locate 20, 6: Color 4: Print "    ∞"
    If hp1 = 3 Then Locate 20, 6: Color 4: Print "   ∞ ∞"
    If hp1 = 2 Then Locate 20, 6: Color 4: Print "  ∞ ∞ ∞"
    If hp1 = 1 Then Locate 20, 6: Color 4: Print " ∞ ∞ ∞ ∞"
    If hp1 = 0 Then Locate 20, 6: Color 4: Print "∞ ∞ ∞ ∞ ∞": GoTo again

    Locate 19, 26: Color 12: Print "P2 Health"
    If hp2 = 5 Then Locate 20, 26: Color 4: Print "    "
    If hp2 = 4 Then Locate 20, 26: Color 4: Print "    ∞"
    If hp2 = 3 Then Locate 20, 26: Color 4: Print "   ∞ ∞"
    If hp2 = 2 Then Locate 20, 26: Color 4: Print "  ∞ ∞ ∞"
    If hp2 = 1 Then Locate 20, 26: Color 4: Print " ∞ ∞ ∞ ∞"
    If hp2 = 0 Then Locate 20, 26: Color 4: Print "∞ ∞ ∞ ∞ ∞": GoTo again

    For i = 1 To speed: Next
Loop

again:
For i = 1 To 100: bullet(i) = 0: Next
Locate 22, 15: Input "Again y/N"; choice$
If choice$ = "y" Then GoTo top
If choice$ = "Y" Then GoTo top
GoTo menu

fixfile:
Color 4
center "File does not exist"
center "Try typing 'map'"
center "Press [Enter]"
Do: P$ = InKey$: Loop Until P$ = Chr$(13)
GoTo top

Sub border
    Color 4
    center "Shoot Up V 2"
    center ""
    center ""
    Color 7
    center "±±±±±±±±±±±±±±±±±±±±±±±±±±±±±"
    center "±                           ±"
    center "±                           ±"
    center "±                           ±"
    center "±                           ±"
    center "±                           ±"
    center "±                           ±"
    center "±                           ±"
    center "±                           ±"
    center "±                           ±"
    center "±                           ±"
    center "±                           ±"
    center "±                           ±"
    center "±±±±±±±±±±±±±±±±±±±±±±±±±±±±±"
    'LOCATE 5, 7: PRINT "#"
End Sub

Sub center (text$)
    Print Tab(20 - (Int(Len(text$) / 2))); text$
End Sub

Sub instructions
    Cls
    Color 4
    center " I N S T R U C T I O N S "
    Color 12
    center "- - - - - - - - - - - - -"
    Print ""
    Print ""
    Color 4
    Print "CONTROLS"
    Color 12
    Print "Each player has 8 keys which are used. Four are used for movement and the other used for shooting. The keys are"
    Print "       Player 1       "
    Print "Movement      Shooting"
    Print "                 P     "
    Print "                         "
    Print "              l   ' "
    Print "                         "
    Print "                 ;   "

    Print "       Player 2"
    Print "Movement      Shooting"
    Print "   t              w   "
    Print ""
    Print " f   h          a   d "
    Print ""
    Print "   g              s "
    Color 4
    Print "Press [Anykey] to continue"
    Do: Loop Until InKey$ <> ""
    Color 4
    Print "WALLS"
    Color 12
    Print "These are things that can not be walked through or over. They can be anything other than a fake, breakable, water."
    Color 8
    Print "1,f,7,a,A,"; Chr$(4); ","; Chr$(219)
    Print ""
    Color 4
    Print "Players"
    Color 12
    Print "They can be any color. but you can tell the difference between each."
    Color 8
    Print "Player 1 :"; Chr$(1)
    Print "Player 2 :"; Chr$(2)
    Print ""
    Color 4
    Print "Fakes"
    Color 12
    Print "These can be any color. You can walk over them and shoot over them."
    Color 8
    Print "A fake "; Chr$(178)
    Print ""
    Color 4
    Print "Breakables"
    Color 12
    Print "These can be any color. You can not walk on them but can be destroyed by"
    Print "bullets to clear a way."
    Color 8
    Print "A Breakable "; Chr$(177)
    Color 4
    Print "Press [Anykey] to continue"
    Do: Loop Until InKey$ <> ""
    Color 4
    Print "Water"
    Color 12
    Print "Water can be any color. It can not be walked on yet you can shoot a bullet over it without effect to the bullet."
    Color 8
    Print "A water "; Chr$(176)
    Print ""
    Print ""
    Print ""
    Print ""
    Print ""
    Print ""
    Print ""
    Print ""
    Print ""
    Print ""
    Print ""
    Print ""
    Print ""
    Print ""
    Print ""
    Print ""
    Print ""
    Print "Press [Anykey] to continue"
    Do: Loop Until InKey$ <> ""

End Sub

Sub loadmap
    'INPUT "open"; file$
    'OPEN file$ FOR INPUT AS #1
End Sub

