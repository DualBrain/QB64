Option _Explicit

$ExeIcon:'./assets/images/tttr.ico'

$VersionInfo:FILEVERSION#=1,0,0,0
$VersionInfo:PRODUCTVERSION#=1,0,0,0
$VersionInfo:CompanyName=Fellippe Heitor
$VersionInfo:ProductName=Tic Tac Toe Ring
$VersionInfo:ProductVersion=1.0
$VersionInfo:Comments=Based on 'Rings.' by Gamezaur; Created with QB64.
$VersionInfo:Web=https://github.com/FellippeHeitor/TicTacToeRing
$VersionInfo:InternalName=tictactoering.bas

Const true = -1, false = 0

'Required shared variables for printLarge
Dim Shared charSet(255, 1 To 16, 1 To 8) As _Byte

initializeCharSetPrintLarge

Type object
    x As Single
    y As Single
    xv As Single
    yv As Single
    xa As Single
    ya As Single
    set As String * 6
    size As Single
    start As Single
    duration As Single
    state As _Byte
    text As Integer
    w As Integer
    h As Integer
    r As Integer
    g As Integer
    b As Integer
End Type

Dim canvas As Long
canvas = _NewImage(600, 600, 32)

Screen canvas
_Delay .1
_ScreenMove _Middle
_Title "Tic Tac Toe Ring"
_PrintMode _KeepBackground

Dim peg(0 To 12) As object
Dim del(1 To 9) As object

Dim emptySet$
emptySet$ = MKI$(-1) + MKI$(-1) + MKI$(-1)
peg(0).set = emptySet$

'set pegs positions
Dim spacing As Integer
Dim i As Integer, j As Single, k As Single
setPegs

'set combo messages
Dim megaComboMsg$(1 To 6)
setComboMessages

Dim c(8) As _Unsigned Long
setRingColors

Dim circleImage(1 To i, 1 To 3) As Long
generateRingImages

Dim crownIcon As Long
generateCrownIcon

_Dest _Display
Dim bg As Long, bgWithoutShelf As Long
generateBG

'flash warning
_Dest _Display
_DontBlend
_PutImage (0, 0), bg
_Blend
centerLarge (_Height / 2) - fontHeightLarge(2) / 2, "This game contains bright,", 2
centerLarge (_Height / 2) + fontHeightLarge(2) / 2, "rapidly flashing colors.", 2

Dim music As _Byte, sfx As _Byte
music = true
sfx = true

loadGame

'load sounds
j = Timer
Dim selectSound As Long
selectSound = _SndOpen("assets/sounds/select.ogg")
If selectSound > 0 Then _SndVol selectSound, .3

Dim wooshSound As Long
wooshSound = _SndOpen("assets/sounds/woosh.ogg")
If wooshSound > 0 Then _SndVol wooshSound, .5

Dim woodblock As Long
woodblock = _SndOpen("assets/sounds/woodblock.wav")

Dim track(1 To 1) As Long, mainTrackVolume As Single
track(1) = _SndOpen("assets/music/track1.ogg")
mainTrackVolume = 1
If track(1) > 0 Then _SndVol track(1), mainTrackVolume

Dim comboSound(1 To 8) As Long, a$
Restore comboSoundFiles
For i = 1 To 8
    Read a$
    comboSound(i) = _SndOpen("assets/sounds/" + a$)
Next

comboSoundFiles:
Data do.ogg,re.ogg,mi.ogg,fa.ogg,sol.ogg,la.ogg,si.ogg,do2.ogg

'if loading sounds took more than 2 seconds, no need to pause
j = Timer - j
If j < 2 Then pause 2 - j

Dim thisColor As Integer
doIntro

Randomize Timer

'add divs to bg
bgWithoutShelf = _CopyImage(bg)
_Dest bg
Line (_Width / 2 - (_Width / spacing) * 2, _Height / 2 - (_Height / spacing) * 2)-Step(_Width / spacing * 4, _Height / spacing * 4), _RGB32(0, 50), BF
Line (3 + peg(10).x - (_Width / spacing / 2), 3 + peg(10).y - (_Width / spacing / 2))-(3 + peg(12).x + (_Width / spacing / 2), 3 + peg(12).y + (_Width / spacing / 2)), _RGB32(255, 15), BF
Line (peg(10).x - (_Width / spacing / 2), peg(10).y - (_Width / spacing / 2))-(peg(12).x + (_Width / spacing / 2), peg(12).y + (_Width / spacing / 2)), _RGB32(255, 15), BF

'game
Dim score As _Unsigned Long, visibleScore As _Unsigned Long
Dim highscore As _Unsigned Long, visibleHighScore As _Unsigned Long
Dim level As _Unsigned Long, maxColors As Integer
Dim animation(0 To 8) As object, gameOver As _Byte
Dim particle(5000) As object, pauseGame As _Byte

animation(0).duration = .25 'board flash
For i = 1 To 5
    animation(i).duration = .5 'matches
Next
animation(6).duration = 1 'new set spawn
animation(7).duration = 1 'combo info

Dim multiplier As Integer
multiplier = 1

visibleScore = score
visibleHighScore = highscore
_Dest _Display

Dim button(100) As object
Dim caption(100) As String
Dim totalButtons As Integer
Dim currentButton As Integer

Do
    Do 'main game loop
        'read mouse data
        While _MouseInput: Wend

        'read keyboard
        Dim keyb As Long
        keyb = _KeyHit

        If mainTrackVolume > .5 And music Then
            mainTrackVolume = mainTrackVolume - .05
            If track(1) > 0 Then _SndVol track(1), mainTrackVolume
        End If
        'redraw board
        _DontBlend
        _PutImage (0, 0), bg
        _Blend

        'print osd
        Dim enterSettings As _Byte
        createMainScreenButtons
        If Abs(keyb) <> 27 And pauseGame = false And enterSettings = false Then doButtons

        _PutImage (25, 28), crownIcon
        Color _RGB32(200)
        _PrintString (52, 28), Str$(visibleHighScore)

        Color _RGB32(255)
        printLarge 0, 45, Str$(visibleScore), 6

        If multiplier > 1 Then
            _PrintString (52, 132), "x" + LTrim$(Str$(multiplier))
        End If

        drawPegs
        generateNewSets

        If Abs(keyb) <> 27 And pauseGame = false And enterSettings = false Then checkButtons

        Dim prevbt As Integer
        If currentButton <> prevbt Then
            If currentButton > 0 And sfx And selectSound > 0 Then _SndPlayCopy selectSound
            prevbt = currentButton
        End If

        If _MouseButton(1) Then
            'drag?
            Dim dragging As Integer
            Dim mouseDown As _Byte
            If Not mouseDown Then
                'are we beginning to drag a ring or set of rings?
                dragging = 0
                For i = 10 To 12
                    If dist(peg(i).x, peg(i).y, _MouseX, _MouseY) <= 40 And peg(i).set <> emptySet$ Then
                        dragging = i
                        Exit For
                    End If
                Next

                mouseDown = true
            End If
        Else
            If mouseDown Then
                If dragging = 0 Then
                    If enterSettings = false And currentButton = 1 Then
                        enterSettings = true
                        _Continue
                    End If

                    If pauseGame = false And currentButton = 2 Then 'pause
                        pauseGame = true
                        _Continue
                    End If
                End If

                'place rings
                Dim placed As _Byte
                placed = false

                If dragging Then
                    For i = 1 To 9
                        If dist(peg(i).x, peg(i).y, _MouseX, _MouseY) <= 40 Then
                            'check that the chosen peg can hold the current set of rings
                            placed = true
                            For j = 1 To 3
                                If CVI(Mid$(peg(dragging).set, j * 2 - 1, 2)) > 0 And CVI(Mid$(peg(i).set, j * 2 - 1, 2)) > 0 Then
                                    placed = false
                                    Exit For
                                End If
                            Next
                            If placed Then
                                If woodblock > 0 And sfx Then _SndPlayCopy woodblock
                                For j = 1 To 3
                                    If CVI(Mid$(peg(dragging).set, j * 2 - 1, 2)) > 0 Then
                                        Mid$(peg(i).set, j * 2 - 1, 2) = Mid$(peg(dragging).set, j * 2 - 1, 2)
                                    End If
                                Next
                                peg(dragging).set = emptySet$
                                Exit For
                            Else
                                Exit For
                            End If
                        End If
                    Next
                End If

                For j = 1 To 9
                    'prepare backup copies for deletion tagging
                    del(j) = peg(j)
                Next

                'check matches
                Dim r(1 To 3) As Integer, previousScore As _Unsigned Long
                Dim s$, found1 As Integer, found2 As Integer, scored As _Byte
                Dim totalMatches As Integer
                totalMatches = 0
                previousScore = score
                If placed Then
                    'look for 3 same-color rings on peg(i) --> ((o))
                    For j = 1 To 3
                        r(j) = CVI(Mid$(peg(i).set, j * 2 - 1, 2))
                    Next
                    If r(1) = r(2) And r(2) = r(3) Then
                        score = score + 3 * multiplier
                        animation(0).start = Timer
                        animation(5).start = Timer
                        animation(5).x = peg(i).x
                        animation(5).y = peg(i).y
                        animation(5).r = _Red32(c(r(1)))
                        animation(5).g = _Green32(c(r(1)))
                        animation(5).b = _Blue32(c(r(1)))
                        animation(8).r = _Red32(c(r(1)))
                        animation(8).g = _Green32(c(r(1)))
                        animation(8).b = _Blue32(c(r(1)))
                        del(i).set = emptySet$
                        addParticles peg(i).x, peg(i).y, 70, c(r(1))
                        addParticles peg(i).x, peg(i).y, 30, _RGB32(_Red32(c(r(1))) + 30, _Green32(c(r(1))) + 30, _Blue32(c(r(1))) + 30)
                        totalMatches = totalMatches + 1
                    End If

                    'look for line matches |, -, /, \
                    Dim m As Integer, checks As Integer
                    Dim nextPeg(0 To 2) As Integer
                    For m = 1 To 4
                        Select Case m
                            Case 1 'across
                                checks = 3
                                r(1) = 1
                                r(2) = 4
                                r(3) = 7
                                nextPeg(1) = 1
                                nextPeg(2) = 2
                            Case 2 'down
                                checks = 3
                                r(1) = 1
                                r(2) = 2
                                r(3) = 3
                                nextPeg(1) = 3
                                nextPeg(2) = 6
                            Case 3 'diagonal \
                                checks = 1
                                r(1) = 1
                                nextPeg(1) = 4
                                nextPeg(2) = 8
                            Case 4 'diagonal /
                                checks = 1
                                r(1) = 3
                                nextPeg(1) = 2
                                nextPeg(2) = 4
                        End Select

                        For i = 1 To checks
                            'look at each ring on the first peg of each row
                            For j = 1 To 3
                                scored = false
                                s$ = Mid$(peg(r(i)).set, j * 2 - 1, 2)
                                If s$ = MKI$(-1) Then _Continue
                                found1 = InStr(peg(r(i) + nextPeg(1)).set, s$)
                                found2 = InStr(peg(r(i) + nextPeg(2)).set, s$)
                                If found1 > 0 And found2 > 0 Then
                                    'match! clear all rings of the same color in this group of pegs
                                    For k = 0 To 2
                                        found1 = InStr(del(r(i) + nextPeg(k)).set, s$)
                                        Do While found1
                                            Mid$(del(r(i) + nextPeg(k)).set, found1, 2) = MKI$(-1)
                                            addParticles del(r(i) + nextPeg(k)).x, del(r(i) + nextPeg(k)).y, 23, c(CVI(s$))
                                            addParticles del(r(i) + nextPeg(k)).x, del(r(i) + nextPeg(k)).y, 10, _RGB32(_Red32(c(CVI(s$))) + 30, _Green32(c(CVI(s$))) + 30, _Blue32(c(CVI(s$))) + 30)
                                            score = score + multiplier
                                            found1 = InStr(del(r(i) + nextPeg(k)).set, s$)
                                        Loop
                                    Next
                                    scored = true
                                    totalMatches = totalMatches + 1
                                    animation(0).start = Timer
                                    animation(m).start = Timer
                                    animation(m).x = peg(r(i)).x
                                    animation(m).y = peg(r(i)).y
                                    animation(m).r = _Red32(c(CVI(s$)))
                                    animation(m).g = _Green32(c(CVI(s$)))
                                    animation(m).b = _Blue32(c(CVI(s$)))
                                    animation(8).r = _Red32(c(CVI(s$)))
                                    animation(8).g = _Green32(c(CVI(s$)))
                                    animation(8).b = _Blue32(c(CVI(s$)))
                                End If

                                If scored Then Mid$(del(r(i)).set, j * 2 - 1, 2) = MKI$(-1)
                            Next
                        Next
                    Next

                    For j = 1 To 9
                        'perform deletion, if any items were marked = MKI$(-1)
                        peg(j) = del(j)
                    Next

                    If previousScore < score Then
                        If wooshSound > 0 And sfx Then _SndPlayCopy wooshSound

                        multiplier = multiplier + 1

                        If sfx Then
                            If multiplier - 1 <= UBound(comboSound) Then
                                If comboSound(multiplier - 1) > 0 Then
                                    _SndPlayCopy comboSound(multiplier - 1)
                                End If
                            Else
                                If comboSound(UBound(comboSound)) > 0 Then
                                    _SndPlayCopy comboSound(UBound(comboSound))
                                End If
                            End If
                        End If

                        Dim m$(1 To 2)
                        m$(1) = megaComboMsg$(_Ceil(Rnd * UBound(megaComboMsg$)))
                        m$(2) = LTrim$(Str$(multiplier)) + "x combo!"
                        animation(7).start = Timer
                        animation(8).start = Timer
                        animation(8).x = _MouseX
                        animation(8).y = _MouseY
                        animation(8).xa = score - previousScore
                        animation(8).ya = dist(_MouseX, _MouseY, printWidthLarge(Str$(visibleScore), 6) / 2, 45)
                        animation(8).duration = 5
                    Else
                        multiplier = 1
                    End If
                    If score > highscore Then highscore = score
                End If
            End If
            mouseDown = false
            dragging = 0
        End If

        hoverHighlight
        checkAvailableMoves
        drawRings
        doAnimations
        updateScore
        updateParticles

        'update display
        _Display

        If enterSettings Then
            addParticles _MouseX, _MouseY, 30, _RGB32(255)
            addParticles _MouseX, _MouseY, 30, _RGB32(67, 172, 183)
            settingsScreen
            enterSettings = false
        End If

        If pauseGame Then
            addParticles _MouseX, _MouseY, 30, _RGB32(255)
            addParticles _MouseX, _MouseY, 30, _RGB32(67, 172, 183)
            keyb = -27
            pauseGame = false
        End If

        'limit fps
        _Limit 60

        Dim userQuit As _Byte
        userQuit = _Exit
        If keyb = -27 Then Exit Do
    Loop Until gameOver Or userQuit

    saveGame

    If userQuit Then System

    endScreen

Loop

Sub setPegs
    Shared spacing As Integer
    Shared peg() As object
    Shared emptySet$

    Dim l As Single, i As Integer, j As Single, k As Single
    spacing = 6
    l = -(_Height / spacing)
    For i = 1 To 12
        j = j + 1
        If j > 3 Then j = 1: l = l + (_Height / spacing)
        Select Case j
            Case 1: k = -_Width / spacing
            Case 2: k = 0
            Case 3: k = _Width / spacing
        End Select
        peg(i).x = _Width / 2 + k
        peg(i).y = _Height / 2 + l
        peg(i).set = emptySet$
    Next
End Sub

Sub setComboMessages
    Shared megaComboMsg$()
    Dim i As Integer

    Restore megaComboMsgs
    For i = 1 To UBound(megaComboMsg$)
        Read megaComboMsg$(i)
    Next
    megaComboMsgs:
    Data Fantastic,Outstanding,Amazing,Awesome,MEGA,SUPER
End Sub

Sub setRingColors
    Shared i As Integer
    Shared c() As _Unsigned Long

    i = i + 1: c(i) = _RGB32(0, 78, 249) 'blue
    i = i + 1: c(i) = _RGB32(0, 100, 0) 'green
    i = i + 1: c(i) = _RGB32(222, 61, 44) 'red
    i = i + 1: c(i) = _RGB32(216, 216, 44) 'yellow
    i = i + 1: c(i) = _RGB32(233, 139, 17) 'orange
    i = i + 1: c(i) = _RGB32(222, 105, 161) 'pink
    i = i + 1: c(i) = _RGB32(139, 11, 205) 'purple
    i = i + 1: c(i) = _RGB32(55, 211, 211) 'cyan
End Sub

Sub generateRingImages
    Dim j As Integer, k As Integer
    Shared c() As _Unsigned Long
    Shared circleImage() As Long

    For j = 1 To UBound(c)
        For k = 1 To 3
            circleImage(j, k) = _NewImage(k * 29, k * 29, 32)
            _Dest circleImage(j, k)
            Paint (0, 0), _RGB32(255, 0, 255)
            CircleFill _Width / 2, _Height / 2, k * 14, c(j)
            CircleFill _Width / 2, _Height / 2, k * (8 + k), _RGB32(255, 0, 255)
            _ClearColor _RGB32(255, 0, 255)
        Next
    Next
End Sub

Sub generateCrownIcon
    Shared crownIcon As Long
    Dim i As Integer, j As Integer
    Dim px As Integer

    Restore crownIconData
    crownIcon = _NewImage(24, 14, 32)
    _Dest crownIcon
    For i = 0 To 13
        For j = 0 To 23
            Read px
            Select Case px
                Case 1
                    PSet (j, i), _RGB32(0)
                Case 2
                    PSet (j, i), _RGB32(205, 161, 0)
            End Select
        Next
    Next

    crownIconData:
    Data 0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,0,0,0,1,2,2,1,0,0,0,0,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,0,0,0,1,2,2,1,0,0,0,0,0,0,0,0,0,0
    Data 0,1,1,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,1,1,0
    Data 1,2,2,1,0,0,0,0,0,0,1,2,2,1,0,0,0,0,0,0,1,2,2,1
    Data 1,2,2,1,0,0,0,0,0,0,1,2,2,1,0,0,0,0,0,0,1,2,2,1
    Data 0,1,1,2,1,1,0,0,0,1,2,2,2,2,1,0,0,0,1,1,2,1,1,0
    Data 0,0,1,2,2,2,1,1,0,1,2,2,2,2,1,0,1,1,2,2,2,1,0,0
    Data 0,0,1,2,2,2,2,2,1,2,2,2,2,2,2,1,2,2,2,2,2,1,0,0
    Data 0,0,0,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,0,0,0
    Data 0,0,0,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,0,0,0
    Data 0,0,0,0,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,0,0,0,0
    Data 0,0,0,0,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,0,0,0,0
    Data 0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0
End Sub

Sub generateBG
    Shared bg As Long
    Dim i As Single

    bg = _NewImage(_Width, _Height, 32)
    _Dest bg
    For i = 0 To _Height - 1 Step _Height / 60
        Line (0, 0)-(_Width - 1, i), _RGB32(139, 116, 177, 5), BF
    Next
End Sub

Sub doIntro
    Shared thisColor As Integer
    Shared c() As _Unsigned Long
    Shared circleImage() As Long
    Shared track() As Long
    Shared bg As Long
    Shared music As _Byte

    Dim x As Single, y As Single, j As Integer
    Dim introRings(1 To 30) As object
    Dim i As Integer

    For i = 1 To UBound(introRings)
        introRings(i).xa = Rnd * _Pi(2)
        introRings(i).xv = Rnd * 5
        introRings(i).r = Rnd * 30 + 50
        introRings(i).set = MKI$(-1) + MKI$(-1) + MKI$(_Ceil(Rnd * UBound(c)))
    Next

    addParticles _Width / 2, _Height / 2, 5000, _RGB32(255)

    Dim introTimer As Single
    introTimer = Timer
    If track(1) > 0 And music Then _SndLoop track(1)
    Do
        _DontBlend
        _PutImage (0, 0), bg
        _Blend

        For i = 1 To UBound(introRings)
            introRings(i).xa = introRings(i).xa + .01
            introRings(i).r = introRings(i).r + introRings(i).xv
            x = _Width / 2 + Cos(introRings(i).xa) * introRings(i).r
            y = _Height / 2 + Sin(introRings(i).xa) * introRings(i).r

            For j = 1 To 3
                thisColor = CVI(Mid$(introRings(i).set, j * 2 - 1, 2))
                If thisColor > 0 Then
                    _PutImage (x - (_Width(circleImage(thisColor, j)) / 2), y - (_Height(circleImage(thisColor, j)) / 2)), circleImage(thisColor, j)
                End If
            Next
        Next

        updateParticles

        Line (0, 0)-(_Width - 1, _Height - 1), _RGB32(255, map(Timer - introTimer, 4, 6, 0, 255)), BF

        Color _RGB32(0)
        centerLarge (_Height / 2) - fontHeightLarge(2) + 3, "Tic Tac Toe", 2
        centerLarge (_Height / 2) + 3, "Rings", 7
        centerLarge _Height - fontHeightLarge(2) + 3, "Fellippe Heitor, 2020", 1

        Color _RGB32(255)
        centerLarge (_Height / 2) - fontHeightLarge(2), "Tic Tac Toe", 2
        centerLarge (_Height / 2), "Rings", 7
        centerLarge _Height - fontHeightLarge(2), "Fellippe Heitor, 2020", 1

        Line (0, 0)-(_Width - 1, _Height - 1), _RGB32(255, map(Timer - introTimer, 0, 1.5, 255, 0)), BF
        Line (0, 0)-(_Width - 1, _Height - 1), _RGB32(255, map(Timer - introTimer, 4, 5, 0, 255)), BF
        Line (0, 0)-(_Width - 1, _Height - 1), _RGB32(0, map(Timer - introTimer, 5, 6, 0, 255)), BF

        While _MouseInput: Wend
        _Display
        _Limit 60
    Loop Until Timer - introTimer > 6 Or _KeyHit Or _MouseButton(1)
End Sub


Sub drawPegs
    Shared peg() As object

    Dim i As Integer
    For i = 1 To 9
        CircleFill peg(i).x, peg(i).y, 3, _RGB32(255)
    Next
End Sub

Sub generateNewSets
    Shared peg() As object
    Shared animation() As object
    Shared c() As _Unsigned Long
    Shared emptySet$
    Shared level As _Unsigned Long, maxColors As Integer

    Dim i As Integer
    Dim j As Integer

    'new sets must be generated according to
    'current board's available positions
    If peg(10).set + peg(11).set + peg(12).set = emptySet$ + emptySet$ + emptySet$ Then
        level = level + 1
        maxColors = map(level, 1, 30, 3, UBound(c)) 'as level goes up, add more colors
        If maxColors < 3 Then maxColors = 3
        If maxColors > UBound(c) Then maxColors = UBound(c)

        Dim pegsUsed As String, thisPeg As Integer, newPeg As Integer
        pegsUsed = ""
        For i = 10 To 12
            'reset this peg
            peg(i).set = emptySet$

            'choose an existing peg randomly
            newPeg = _Ceil(Rnd * 9)
            thisPeg = newPeg
            Do
                If InStr(peg(thisPeg).set, MKI$(-1)) > 0 And InStr(pegsUsed, MKI$(thisPeg)) = 0 Then
                    'found a peg with an empty slot or more
                    Exit Do
                End If
                thisPeg = thisPeg + 1
                If thisPeg > 9 Then thisPeg = 1
                If thisPeg = newPeg Then
                    'full circle
                    thisPeg = 0
                    Exit Do
                End If
            Loop

            'store the chosen peg's id
            If thisPeg > 0 Then pegsUsed = pegsUsed + MKI$(thisPeg)

            'generate a set, with random colors
            Do
                For j = 1 To 3
                    If Mid$(peg(thisPeg).set, j * 2 - 1, 2) = MKI$(-1) Then
                        If Rnd * 100 < 30 Then
                            Mid$(peg(i).set, j * 2 - 1, 2) = MKI$(_Ceil(Rnd * maxColors))
                        End If
                    End If
                Next
            Loop While peg(i).set = emptySet$ 'can't be empty
            If InStr(peg(i).set, MKI$(-1)) = 0 Then 'can't be full
                j = _Ceil(Rnd * 3)
                Mid$(peg(i).set, j * 2 - 1, 2) = MKI$(-1)
            End If
        Next
        animation(6).start = Timer
    End If
End Sub

Sub doAnimations
    Dim i As Integer, j As Single, k As Single, l As Single
    Shared animation() As object
    Shared peg() As object
    Shared totalMatches As Integer
    Shared m$(), spacing As Integer
    Shared visibleScore As _Unsigned Long

    For i = 0 To UBound(animation)
        If Timer - animation(i).start <= animation(i).duration Then
            Dim animSize As Single
            animSize = map(Timer - animation(i).start, 0, animation(i).duration, 50, 0)
            Select Case i
                Case 0 'board flash
                    Line (0, 0)-(_Width - 1, _Height - 1), _RGB32(255, map(Timer - animation(i).start, 0, animation(i).duration, 100, 0)), BF
                Case 1 'across
                    For j = 0 To _Width Step _Width / 30
                        For k = 1 To animSize Step 5
                            CircleFill j, animation(i).y, k, _RGB32(animation(i).r, animation(i).g, animation(i).b, 20)
                        Next
                    Next
                Case 2 'down
                    For j = 0 To _Width Step _Width / 30
                        For k = 1 To animSize Step 5
                            CircleFill animation(i).x, j, k, _RGB32(animation(i).r, animation(i).g, animation(i).b, 20)
                        Next
                    Next
                Case 3 'diagonal \
                    For j = 0 To _Width Step _Width / 30
                        For k = 1 To animSize Step 5
                            CircleFill j, j, k, _RGB32(animation(i).r, animation(i).g, animation(i).b, 20)
                        Next
                    Next
                Case 4 'diagonal /
                    For j = 0 To _Width Step _Width / 30
                        For k = 1 To animSize Step 5
                            CircleFill j, _Height - j, k, _RGB32(animation(i).r, animation(i).g, animation(i).b, 20)
                        Next
                    Next
                Case 5 'single peg ((o))
                    For k = 1 To animSize * 2
                        CircleFill animation(i).x, animation(i).y, k, _RGB32(animation(i).r, animation(i).g, animation(i).b, 20)
                    Next
                Case 6 'new peg set
                    For k = 10 To 12
                        Circle (peg(k).x, peg(k).y), animSize * 1.5, _RGB32(255, animSize / 2)
                        Circle (peg(k).x, peg(k).y), animSize, _RGB32(255, animSize)
                    Next
                Case 7 'combo info
                    k = Int(map(animSize, 50, 40, 1, 4))
                    If k < 1 Then k = 1
                    If k > 4 Then k = 4
                    Color _RGB32(0.80)
                    For l = -4 To 4 Step 8
                        If totalMatches > 1 Then
                            printLarge (l + _Width - printWidthLarge(m$(1), k)) / 2, (l + _Height - fontHeightLarge(k)) / 2 - fontHeightLarge(k), m$(1), k
                        End If
                        printLarge (l + _Width - printWidthLarge(m$(2), k)) / 2, (l + _Height - fontHeightLarge(k)) / 2, m$(2), k
                    Next
                    Color _RGB32(255)
                    If totalMatches > 1 Then
                        printLarge (_Width - printWidthLarge(m$(1), k)) / 2, (_Height - fontHeightLarge(k)) / 2 - fontHeightLarge(k), m$(1), k
                    End If
                    printLarge (_Width - printWidthLarge(m$(2), k)) / 2, (_Height - fontHeightLarge(k)) / 2, m$(2), k
                Case 8 'score increase
                    Dim a As Single
                    animation(8).x = lerp(animation(8).x, printWidthLarge(Str$(visibleScore), 6) / 2, .06)
                    animation(8).y = lerp(animation(8).y, 45, .06)
                    a = dist(animation(8).x, animation(8).y, printWidthLarge(Str$(visibleScore), 6) / 2, 45)
                    If a <= 30 Then
                        animation(8).start = 0
                    End If
                    a = map(a, 0, animation(8).ya, 0, 1024)
                    Color _RGB32(animation(8).r, animation(8).g, animation(8).b, a)
                    printLarge 2 + animation(8).x, 2 + animation(8).y, LTrim$(Str$(animation(8).xa)), 4
                    Color _RGB32(255, a)
                    printLarge animation(8).x, animation(8).y, LTrim$(Str$(animation(8).xa)), 4
            End Select
        End If
    Next
End Sub

Sub saveGame
    Shared score As _Unsigned Long, highscore As _Unsigned Long
    Shared level As _Unsigned Long
    Shared gameOver As _Byte
    Shared peg() As object
    Shared music As _Byte, sfx As _Byte

    Dim i As Integer

    Open "tictactoering.dat" For Binary As #1
    Dim signature As String
    signature = "tttring"
    Put #1, 1, signature
    Put #1, , music
    Put #1, , sfx
    Put #1, , score
    Put #1, , highscore
    Put #1, , level
    Put #1, , gameOver
    For i = 1 To 12
        Put #1, , peg(i)
    Next
    Close #1
End Sub

Sub loadGame
    Shared score As _Unsigned Long, highscore As _Unsigned Long
    Shared level As _Unsigned Long
    Shared gameOver As _Byte
    Shared peg() As object
    Shared music As _Byte, sfx As _Byte

    Dim i As Integer

    Open "tictactoering.dat" For Binary As #1
    If LOF(1) Then
        Dim signature As String
        signature = Space$(7)
        Get #1, 1, signature
        If signature <> "tttring" Then
            Close #1
            Exit Sub
        End If
        Get #1, , music
        Get #1, , sfx
        Get #1, , score
        Get #1, , highscore
        Get #1, , level
        Get #1, , gameOver

        If gameOver = false Then
            For i = 1 To 12
                Get #1, , peg(i)
            Next
        Else
            gameOver = false
            score = 0
            level = 0
        End If
    Else
        'user just upgraded from first versions?
        'retrieve their highscore and kill old file
        Close #1
        If _FileExists("tictactoering.score") Then
            Open "tictactoering.score" For Binary As #1
            If LOF(1) Then
                Get #1, 1, score
                Get #1, , highscore
                Get #1, , level
                Get #1, , gameOver

                If gameOver = false Then
                    For i = 1 To 12
                        Get #1, , peg(i)
                    Next
                Else
                    gameOver = false
                    score = 0
                    level = 0
                End If
            End If
            Close #1
            Kill "tictactoering.score"
        End If
    End If
    Close #1
End Sub

Sub addParticles (x As Single, y As Single, total As Integer, c As _Unsigned Long)
    Dim addedP As Integer, p As Integer
    Dim a As Single
    Shared particle() As object

    addedP = 0: p = 0
    Do
        p = p + 1
        If p > UBound(particle) Then Exit Do
        If particle(p).state = true Then _Continue
        addedP = addedP + 1
        particle(p).state = true
        particle(p).x = x
        particle(p).y = y
        a = Rnd * _Pi(2)
        particle(p).xv = Cos(a) * (Rnd * 10)
        particle(p).yv = Sin(a) * (Rnd * 10)
        particle(p).r = _Red32(c)
        particle(p).g = _Green32(c)
        particle(p).b = _Blue32(c)
        particle(p).size = _Ceil(Rnd * 3)
        particle(p).start = Timer
        particle(p).duration = Rnd
    Loop Until addedP >= total
End Sub

Sub updateScore
    Static lastScoreUpdate As Single, lastHighScoreUpdate As Single
    Shared visibleScore As _Unsigned Long, score As _Unsigned Long
    Shared visibleHighScore As _Unsigned Long, highscore As _Unsigned Long
    Shared animation() As object, woodblock As Long
    Shared sfx As _Byte

    If visibleScore < score And Timer - lastScoreUpdate > .05 And animation(8).start = 0 Then
        visibleScore = visibleScore + 1
        If woodblock > 0 And sfx Then _SndPlayCopy woodblock
        lastScoreUpdate = Timer
    End If

    If visibleHighScore < highscore And Timer - lastHighScoreUpdate > .05 And animation(8).start = 0 Then
        visibleHighScore = visibleHighScore + 1
        lastHighScoreUpdate = Timer
    End If
End Sub

Sub updateParticles
    Dim i As Integer
    Shared particle() As object

    For i = 1 To UBound(particle)
        Const gravity = .1
        If particle(i).state Then
            particle(i).xv = particle(i).xv + particle(i).xa
            particle(i).x = particle(i).x + particle(i).xv
            particle(i).yv = particle(i).yv + particle(i).ya + gravity
            particle(i).y = particle(i).y + particle(i).yv

            If particle(i).x > _Width Or particle(i).x < 0 Or particle(i).y > _Height Or particle(i).y < 0 Then
                particle(i).state = false
            Else
                CircleFill particle(i).x, particle(i).y, particle(i).size, _RGB32(particle(i).r, particle(i).g, particle(i).b, map(Timer - particle(i).start, 0, particle(i).duration, 255, 0))
            End If
        End If
    Next
End Sub

Sub hoverHighlight
    Shared peg() As object
    Shared emptySet$
    Shared dragging As Integer

    Static highLit As Integer, glow As Single, glowStep As Single
    Dim halo As Integer
    Dim i As Integer, k As Single, j As Single

    If dragging Then Exit Sub

    For i = 10 To 12
        If peg(i).set = emptySet$ Then _Continue
        If dist(peg(i).x, peg(i).y, _MouseX, _MouseY) <= 40 Then
            k = 0
            If Mid$(peg(i).set, 5, 2) <> MKI$(-1) Then
                halo = 40
            ElseIf Mid$(peg(i).set, 3, 2) <> MKI$(-1) Then
                halo = 25
            Else
                halo = 12
            End If

            If highLit <> i Then
                highLit = i
                glow = 10
                glowStep = .2
            End If

            If glowStep = 0 Then glowStep = .2
            glow = glow + glowStep
            If glow < 8 Then glow = 8: glowStep = glowStep * -1
            If glow > 16 Then glow = 16: glowStep = glowStep * -1

            For j = glow To 8 Step -.5
                k = k + .8
                CircleFill peg(i).x, peg(i).y, halo + k, _RGB32(255, j)
                CircleFill peg(i).x, peg(i).y, (halo / 2) + k, _RGB32(0, j)
            Next

            Exit For
        End If
    Next
End Sub

Sub checkAvailableMoves
    Shared dragging As Integer
    Shared peg() As object
    Shared emptySet$
    Shared gameOver As _Byte
    Shared placed As _Byte

    Dim i As Integer, j As Integer, k As Integer

    If dragging = 0 Then
        If peg(10).set <> emptySet$ Or peg(11).set <> emptySet$ Or peg(12).set <> emptySet$ Then
            gameOver = true 'glass is half empty; consider no more moves
            For i = 10 To 12
                If peg(i).set <> emptySet$ Then
                    'can this set fit the board?
                    For j = 1 To 9
                        placed = true
                        For k = 1 To 3
                            If CVI(Mid$(peg(i).set, k * 2 - 1, 2)) > 0 And CVI(Mid$(peg(j).set, k * 2 - 1, 2)) > 0 Then
                                placed = false
                                Exit For
                            End If
                        Next
                        If placed Then gameOver = false: Exit For
                    Next
                End If
                If gameOver = false Then Exit For 'no need to test further, there's still hope
            Next
        End If

        If gameOver = false Then
            'is board full?
            'that means we used all sets and no matches were found = game over
            Dim board$
            board$ = ""
            For i = 1 To 9
                board$ = board$ + peg(i).set
            Next
            If InStr(board$, MKI$(-1)) = 0 Then gameOver = true
        End If
    End If
End Sub

Sub drawRings
    Dim i As Integer
    Shared peg() As object
    Shared circleImage() As Long
    Shared dragging As Integer
    Shared thisColor As Integer

    Dim x As Single, y As Single
    Dim j As Integer

    For i = 1 To 12
        If i = dragging Then
            x = _MouseX
            y = _MouseY
        Else
            x = peg(i).x
            y = peg(i).y
        End If

        For j = 1 To 3
            thisColor = CVI(Mid$(peg(i).set, j * 2 - 1, 2))
            If thisColor > 0 Then
                _PutImage (x - (_Width(circleImage(thisColor, j)) / 2), y - (_Height(circleImage(thisColor, j)) / 2)), circleImage(thisColor, j)
            End If
        Next
    Next
End Sub

Sub CircleFill (x As Long, y As Long, R As Long, C As _Unsigned Long)
    Dim x0 As Single, y0 As Single
    Dim e As Single

    x0 = R
    y0 = 0
    e = -R
    Do While y0 < x0
        If e <= 0 Then
            y0 = y0 + 1
            Line (x - x0, y + y0)-(x + x0, y + y0), C, BF
            Line (x - x0, y - y0)-(x + x0, y - y0), C, BF
            e = e + 2 * y0
        Else
            Line (x - y0, y - x0)-(x + y0, y - x0), C, BF
            Line (x - y0, y + x0)-(x + y0, y + x0), C, BF
            x0 = x0 - 1
            e = e - 2 * x0
        End If
    Loop
    Line (x - R, y)-(x + R, y), C, BF
End Sub

Function map! (value!, minRange!, maxRange!, newMinRange!, newMaxRange!)
    map! = ((value! - minRange!) / (maxRange! - minRange!)) * (newMaxRange! - newMinRange!) + newMinRange!
End Function

Function lerp! (start!, stp!, amt!)
    Dim mult As Integer
    If start! < stp! Then mult = -1 Else mult = 1
    lerp! = (mult * amt!) * (stp! - start!) + start!
End Function

Function dist! (x1!, y1!, x2!, y2!)
    dist! = _Hypot((x2! - x1!), (y2! - y1!))
End Function

Sub printLarge (x As Single, y As Single, text$, fontSize As Integer)
    Dim i As Long, j As Long, c As Long, char As _Unsigned _Byte

    If fontSize = 0 Then fontSize = 1

    For c = 1 To Len(text$)
        char = Asc(text$, c)
        For i = 1 To 16
            For j = 1 To 8
                If charSet(char, i, j) Then
                    If _PrintMode <> 2 Then
                        Line ((x - fontSize) + j * fontSize + ((c - 1) * (fontSize * 8)), (y - fontSize) + i * fontSize)-Step(fontSize - 1, fontSize - 1), _DefaultColor, BF
                    End If
                Else
                    If _PrintMode = 3 Or _PrintMode = 2 Then
                        Line ((x - fontSize) + j * fontSize + ((c - 1) * (fontSize * 8)), (y - fontSize) + i * fontSize)-Step(fontSize - 1, fontSize - 1), _BackgroundColor, BF
                    End If
                End If
            Next
        Next
    Next
End Sub

Sub centerLarge (y As Single, text$, fontSize As Integer)
    printLarge (_Width - printWidthLarge(text$, fontSize)) / 2, y, text$, fontSize
End Sub

Function fontHeightLarge (fontSize As Integer)
    fontHeightLarge = fontSize * 16
End Function

Function fontWidthLarge (fontSize As Integer)
    fontWidthLarge = fontSize * 8
End Function

Function printWidthLarge (text$, fontSize As Integer)
    printWidthLarge = fontWidthLarge(fontSize) * Len(text$)
End Function

Sub initializeCharSetPrintLarge
    Dim char, row, column
    Restore charSet8x16
    For char = 0 To 255
        For row = 1 To 16
            For column = 1 To 8
                Read charSet(char, row, column)
            Next
        Next
    Next

    charSet8x16:
    Data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,0,-1,0,0,0,0,0,0,-1,-1,0,-1,0,0,-1,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,-1,-1,-1,-1,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,0,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,-1,-1,0,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,-1,-1,-1,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,-1,-1,-1,0,0,-1,-1,-1,-1,-1,-1,0,0,-1,-1,-1,-1,-1,-1,0,0,-1,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    Data 0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,-1,-1,-1,-1,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,-1,-1,-1,-1,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
    Data -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,0,0,0,0,-1,0,0,-1,0,0,0,0,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,0,0,-1,-1,0,0,-1,-1,0,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,0,-1,-1,0,0,-1,-1,0,0,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,0,-1,0,0,0,-1,-1,0,0,-1,0,0,-1,-1,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,0
    Data -1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,-1,-1,-1,-1,-1,-1,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1
    Data 0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,-1,-1,-1,-1,-1,-1,0,0,-1,-1,-1,-1,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,-1,-1,0,0,-1,-1,-1,-1,0,0,-1,-1,-1,0,0,-1,-1,-1,0,0,-1,-1,-1,-1,0,0,-1,-1,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,-1,0,0,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,-1,-1,-1,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,-1,-1,-1,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,0,0,-1,-1,-1
    Data -1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,-1,-1,-1,-1,-1,-1,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,-1,-1,-1,-1,-1,-1,0,0,0,-1,-1,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,0,-1,-1,0,-1,-1,0,-1,-1,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1
    Data 0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,-1,-1,-1,-1,-1,-1,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,-1,-1,-1,-1
    Data -1,-1,0,0,0,-1,-1,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,-1,-1,-1,-1,-1,-1,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,-1,-1,-1,-1,-1,-1,0,0,0,-1,-1,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,-1,-1,-1,-1,-1,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,0,-1,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0
    Data -1,-1,-1,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,-1,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,-1,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,0,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,-1,-1,-1,-1,-1,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,-1,-1,-1,-1,-1,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,0,-1,0,-1,-1,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,-1,-1
    Data -1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,-1,0,-1,-1,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,-1,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,-1,0,-1,-1,0,-1,-1,0,-1,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,-1,0,0,-1,-1,-1,-1,-1,-1,-1,-1,0,0,-1,-1,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1
    Data -1,0,0,0,0,-1,-1,-1,-1,-1,-1,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,-1,0,-1,-1,0,-1,-1,0,-1,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,0,0
    Data 0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0
    Data 0,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0
    Data -1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0
    Data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,0
    Data -1,-1,0,-1,-1,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,0,-1
    Data -1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,0,-1,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,-1,-1,0
    Data 0,-1,-1,0,0,0,-1,0,0,-1,-1,0,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,0,-1,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,-1,0,0,-1,-1,0,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,0,0,-1,-1,0,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,0,-1,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,0,-1,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,-1,-1,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0
    Data -1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,-1,-1,0,0
    Data 0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,-1,-1,-1,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,-1,0,0,-1,-1,0,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,-1,0,-1,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,-1,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,-1,0,0,-1,-1,0,-1,-1,-1,-1,0,-1,-1,0,-1,-1
    Data -1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,0,-1,-1,0,0,-1,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0
    Data -1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,-1,0,-1,-1,0,-1,-1,0,-1,-1,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,-1,-1,-1,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,0,0,-1,-1
    Data -1,-1,-1,-1,0,0,-1,0,-1,-1,0,-1,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1
    Data -1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,-1,0,-1,-1,0,-1,-1,0,-1,0,-1,-1,0,-1,-1,0,-1,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,-1,0,-1,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,0
    Data 0,-1,-1,0,-1,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0
    Data 0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,-1,-1
    Data 0,0,0,0,0,0,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,-1,-1,0,-1,-1
    Data 0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,-1,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,-1,-1,-1,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1
    Data 0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,-1,-1,-1,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,-1,-1,0,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,-1,0,-1,-1,0,-1,-1,0,-1,0,-1,-1,0,-1,-1,0
    Data -1,0,-1,-1,0,-1,-1,0,-1,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,-1,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,-1,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,-1
    Data -1,-1,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,-1,-1,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,-1,-1,-1,0,0,0,-1,-1,-1,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,-1,-1,-1,-1,-1,-1,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,-1,-1,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,-1,0,-1,-1,0,-1,-1,0,-1,0,-1,-1,0,-1,-1,0,-1,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,0,-1,-1,-1,0,0,0,0,0,-1,-1,-1,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,0,0,0,0
    Data 0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,-1,-1,0,-1,-1,0,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,0,-1,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1
    Data 0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    Data -1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1
    Data -1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,-1,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,0,-1,-1,0,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0
    Data -1,-1,-1,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0
    Data -1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1
    Data -1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1
    Data -1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,0,0,-1,-1,0,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,-1,-1,-1,-1,-1,-1,0,0,0,0,-1,-1,0,0,0,0,-1,-1,-1,-1,-1,-1,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,-1,-1,0,0,0,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,-1,-1,-1,-1,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1
    Data 0,0,0,0,-1,-1,-1,-1,-1,-1,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1
    Data -1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,-1,-1,0,-1,-1,0,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,-1,-1,0,-1,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,-1,-1,0,-1,-1,0,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,-1,0,0,-1,-1,0,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,-1
    Data -1,0,-1,-1,0,-1,-1,-1,-1,0,-1,-1,0,0,-1,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0
    Data -1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,-1,-1,-1,0,0,-1,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,-1,-1,0,-1,-1,0,0,-1,-1,-1,0,-1,0,0,-1,-1,-1,-1,0,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,-1,-1,0,0,-1,-1,0,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,-1,-1,0,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,-1,0,-1,0,0,0,-1,0,0,0,0,0,-1,0,0,0,-1,0,-1,0,0,0,-1,0,0,0,0,0,-1,0,0,0,-1,0,-1,0,0,0,-1,0,0,0,0,0,-1,0,0,0,-1,0,-1,0,0,0,-1,0,0,0,0,0,-1,0,0,0,-1,0,-1,0,0,0,-1,0,0,0,0,0,-1,0,0,0,-1,0,-1,0,0,0,-1,0,0,0,0,0,-1,0,0,0,-1,0,-1,0,0,0,-1,0,0,0,0,0,-1,0,0,0,-1,0,-1,0,0,0,-1,0,0,0,-1,0,-1,0,-1,0,-1,-1,0,-1,0,-1,0,-1,0,0,-1,0,-1,0,-1,0,-1,-1,0,-1,0,-1,0,-1,0,0,-1,0,-1,0,-1,0,-1,-1,0,-1,0,-1,0,-1,0,0,-1,0,-1,0,-1,0,-1,-1,0,-1,0,-1,0,-1,0,0,-1,0,-1,0,-1,0,-1,-1,0,-1,0,-1,0,-1,0,0,-1,0,-1,0,-1,0,-1,-1,0,-1,0,-1,0,-1,0,0,-1,0,-1,0,-1,0,-1,-1,0,-1,0,-1,0,-1,0,0,-1,0,-1,0,-1,0,-1,-1,0,-1,0,-1,0,-1,0,-1,-1,0,-1,-1,-1,0,-1,0,-1,-1,-1,0,-1,-1
    Data -1,-1,-1,0,-1,-1,-1,0,-1,0,-1,-1,-1,0,-1,-1,-1,-1,-1,0,-1,-1,-1,0,-1,0,-1,-1,-1,0,-1,-1,-1,-1,-1,0,-1,-1,-1,0,-1,0,-1,-1,-1,0,-1,-1,-1,-1,-1,0,-1,-1,-1,0,-1,0,-1,-1,-1,0,-1,-1,-1,-1,-1,0,-1,-1,-1,0,-1,0,-1,-1,-1,0,-1,-1,-1,-1,-1,0,-1,-1,-1,0,-1,0,-1,-1,-1,0,-1,-1,-1,-1,-1,0,-1,-1,-1,0,-1,0,-1,-1,-1,0,-1,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0
    Data 0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,-1,-1,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1
    Data 0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,-1,-1,-1,-1,0,-1,-1,0,0,0,0,0,0,-1,-1,0,-1,-1,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1
    Data -1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,-1,-1,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,-1,-1,-1,-1,0,-1,-1,0,0,0,0,0,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1
    Data -1,0,0,0,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0
    Data -1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0
    Data 0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,-1,0,0,-1,-1,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,-1,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1
    Data -1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,-1,-1,-1,-1,0,-1,-1,-1,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,-1,-1,-1,-1,0,-1,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,-1,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,-1,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0
    Data -1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,-1,-1,-1,-1,0,-1,-1,-1,0,0,0,0,0,0,0,0,-1,-1,-1,-1,0,-1,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1
    Data -1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,-1,-1,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1
    Data 0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
    Data -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1
    Data -1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,-1,-1,0,-1,-1,0,-1,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,-1,0,0,0,-1,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    Data 0,0,0,0,-1,-1,-1,0,-1,-1,0,-1,-1,0,-1,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1
    Data 0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,-1,-1,-1,0,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,-1,-1,0,0,0,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,0,-1,-1,0,-1,-1,0,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,0,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,-1,-1,-1,-1,-1,-1,0,-1
    Data -1,0,-1,-1,0,-1,-1,-1,-1,0,-1,-1,0,-1,-1,-1,-1,-1,-1,0,0,-1,-1,0,-1,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1
    Data -1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,-1,-1,-1,-1,-1,-1,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,-1,-1,0,-1,-1,0,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,-1,-1,0,-1,-1,0,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0,-1,-1,0,0,-1,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,0,-1,-1,-1,-1,0,0,0,0,0,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,-1,-1,0,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,0,0,0,-1,-1,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,0,0,0,-1,-1,0,0,-1,0,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,0,0,0,-1,-1,-1,-1,-1,0,0,0,-1,-1,-1,-1,-1,0,0,0,-1,-1,-1,-1,-1,0,0,0,-1,-1,-1,-1,-1,0,0,0,-1,-1,-1,-1,-1,0,0,0,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
End Sub

Sub pause (duration As Single)
    Dim j As Single
    j = Timer
    Do
        _Display
        _Limit 30
    Loop Until Timer - j > duration Or _KeyHit
End Sub

Sub endScreen
    Shared gameOver As _Byte, keyb As Long
    Shared animation() As object, peg() As object
    Shared bg As Long, bgWithoutShelf As Long
    Shared m$(), emptySet$
    Shared userQuit As _Byte
    Shared score As _Unsigned Long, visibleScore As _Unsigned Long
    Shared level As _Unsigned Long

    Dim k As Integer, i As Integer

    If gameOver Or keyb = -27 Then
        'flash and screenshot
        Dim screenshot As Long, screenshot2 As Long
        screenshot = _CopyImage(_Display)

        animation(0).start = Timer
        Do
            Dim screenshotSize As Integer, zoomOut As Integer
            zoomOut = 200
            screenshotSize = map(Timer - animation(0).start, 0, .5, _Width, _Width - zoomOut)
            If screenshotSize < _Width - zoomOut Then screenshotSize = _Width - zoomOut
            Cls
            _PutImage (0, 0), bgWithoutShelf
            _PutImage ((_Width - screenshotSize) / 2, 0)-Step(screenshotSize, screenshotSize), screenshot
            If Timer - animation(0).start < .3 Then
                Line (0, 0)-(_Width - 1, _Height - 1), _RGB32(255, map(Timer - animation(0).start, 0, .3, 0, 255)), BF
            End If
            updateParticles
            _Display
            _Limit 60
        Loop Until Timer - animation(0).start > .75

        If gameOver Then
            m$(1) = "Game Over"
            Color _RGB32(255)
            k = 4
            printLarge (_Width - printWidthLarge(m$(1), k)) / 2, _Height - fontHeightLarge(k) * 2.5, m$(1), k
        End If

        screenshot2 = _CopyImage(_Display)

        'end screen buttons
        Shared currentButton As Integer
        Shared totalButtons As Integer
        Shared button() As object, caption() As String

        currentButton = 0
        totalButtons = 2
        For i = 1 To 2
            button(i).h = _FontHeight + 10
            button(i).w = _PrintWidth("  Continue  ")
        Next

        Dim startX As Integer
        startX = (_Width - button(1).w * totalButtons) / 2
        For i = 1 To totalButtons
            button(i).y = _Height - fontHeightLarge(3) * 2
            button(i).x = startX
            startX = startX + button(i).w
        Next

        If gameOver Then
            caption(1) = "Restart"
            caption(2) = "Quit"
        Else
            caption(1) = "Continue"
            caption(2) = "Restart"
        End If

        Do
            Shared mainTrackVolume As Single, track() As Long, music As _Byte
            If music Then
                If mainTrackVolume < 1 Then
                    mainTrackVolume = mainTrackVolume + .05
                    If track(1) > 0 Then _SndVol track(1), mainTrackVolume
                End If
            End If

            keyb = _KeyHit
            While _MouseInput: Wend
            Dim mx As Integer, my As Integer
            mx = _MouseX
            my = _MouseY

            _PutImage (0, 0), screenshot2
            doButtons
            Dim mouseDown As _Byte
            checkButtons

            Dim prevbt As Integer
            If currentButton <> prevbt Then
                Shared selectSound As Long, sfx As _Byte
                If currentButton > 0 And sfx And selectSound > 0 Then _SndPlayCopy selectSound
                prevbt = currentButton
            End If

            Select Case keyb
                Case 19200 'left
                    currentButton = 1
                Case 19712 'right
                    currentButton = 2
                Case -13
                    mouseDown = true
                Case -27
                    Exit Do
            End Select

            If _MouseButton(1) Then
                mouseDown = true
            Else
                If mouseDown Then
                    Select Case currentButton
                        Case 1
                            keyb = -121
                            Exit Do
                        Case 2
                            keyb = -110
                            Exit Do
                    End Select
                    addParticles mx, my, 30, _RGB32(255)
                    addParticles mx, my, 30, _RGB32(122, 89, 144)
                End If
                mouseDown = false
            End If

            updateParticles

            userQuit = _Exit
            _Display
            _Limit 30
        Loop Until keyb = -13 Or keyb = -27 Or keyb = -110 Or keyb = -78 Or keyb = -121 Or keyb = -89 Or userQuit

        If (gameOver And (keyb = -110 Or keyb = -78)) Or userQuit Then System

        If (gameOver And (keyb = -13 Or keyb = -121 Or keyb = -89)) Or (gameOver = false And (keyb = -110 Or keyb = -78)) Then
            If track(1) > 0 And music Then _SndStop track(1): _SndLoop track(1) 'restart main track
            gameOver = false
            score = 0
            visibleScore = 0
            level = 0
            animation(0).start = Timer
            For i = 1 To 12
                peg(i).set = emptySet$
            Next
        Else
            'bring screenshot back to front
            animation(0).start = Timer
            Do
                zoomOut = 200
                screenshotSize = map(Timer - animation(0).start, 0, .5, _Width - zoomOut, _Width)
                If screenshotSize > _Width Then screenshotSize = _Width
                Cls
                _PutImage (0, 0), bgWithoutShelf
                _PutImage ((_Width - screenshotSize) / 2, 0)-Step(screenshotSize, screenshotSize), screenshot
                If Timer - animation(0).start <= .3 Then
                    Line (0, 0)-(_Width - 1, _Height - 1), _RGB32(255, map(Timer - animation(0).start, 0, .3, 0, 255)), BF
                End If
                _Display
                _Limit 60
            Loop Until Timer - animation(0).start > .5
        End If

        _FreeImage screenshot
        _FreeImage screenshot2
        _KeyClear
        currentButton = 0
    End If
End Sub

Sub settingsScreen
    Shared gameOver As _Byte, keyb As Long
    Shared animation() As object, peg() As object
    Shared bg As Long, bgWithoutShelf As Long
    Shared m$(), emptySet$
    Shared userQuit As _Byte
    Shared score As _Unsigned Long, visibleScore As _Unsigned Long
    Shared level As _Unsigned Long

    'flash and screenshot
    Dim screenshot As Long
    screenshot = _CopyImage(_Display)

    animation(0).start = Timer
    Do
        Dim screenshotSize As Integer, zoomOut As Integer
        zoomOut = 400
        screenshotSize = map(Timer - animation(0).start, 0, .5, _Width, _Width - zoomOut)
        If screenshotSize < _Width - zoomOut Then screenshotSize = _Width - zoomOut
        Cls
        _PutImage (0, 0), bgWithoutShelf
        _PutImage (0, (_Height - screenshotSize) / 2)-Step(screenshotSize, screenshotSize), screenshot
        If Timer - animation(0).start < .3 Then
            Line (0, 0)-(_Width - 1, _Height - 1), _RGB32(255, map(Timer - animation(0).start, 0, .3, 0, 255)), BF
        End If

        updateParticles
        _Display
        _Limit 60
    Loop Until Timer - animation(0).start > .75

    Shared button() As object
    Shared caption() As String
    Shared totalButtons As Integer
    Shared currentButton As Integer

    'settings buttons
    Shared music As _Byte, sfx As _Byte
    Dim i As Integer
    currentButton = 0
    totalButtons = 4
    For i = 1 To totalButtons - 1
        button(i).h = _FontHeight + 10
        button(i).w = _PrintWidth("  ENOUGH WIDTH FOR ALL CHOICES  ")
    Next

    caption(3) = "Return to game"

    Dim startY As Integer
    startY = (_Height - button(1).h * totalButtons - 1) / 2
    For i = 1 To totalButtons - 1
        button(i).y = startY
        button(i).x = _Width - _Width / 3 - button(i).w / 2
        startY = startY + button(i).h
    Next

    button(4).x = 0
    button(4).y = (_Height - screenshotSize) / 2
    button(4).w = screenshotSize
    button(4).h = screenshotSize

    Do
        Cls
        _PutImage (0, 0), bgWithoutShelf
        _PutImage (0, (_Height - screenshotSize) / 2)-Step(screenshotSize, screenshotSize), screenshot

        Dim mx As Integer, my As Integer
        While _MouseInput: Wend
        mx = _MouseX
        my = _MouseY
        keyb = _KeyHit
        userQuit = _Exit

        If music Then
            caption(1) = "Music: ON"
        Else
            caption(1) = "Music: OFF"
        End If

        If sfx Then
            caption(2) = "Sound effects: ON"
        Else
            caption(2) = "Sound effects: OFF"
        End If

        doButtons
        Dim mouseDown As _Byte
        checkButtons

        Dim prevbt As Integer
        If currentButton <> prevbt Then
            Shared selectSound As Long
            If currentButton > 0 And sfx And selectSound > 0 Then _SndPlayCopy selectSound
            prevbt = currentButton
        End If

        Select Case keyb
            Case 18432 'up
                currentButton = currentButton - 1
                If currentButton < 1 Then currentButton = 1
            Case 20480 'down
                currentButton = currentButton + 1
                If currentButton > totalButtons Then currentButton = totalButtons
            Case 19200 'left
                If currentButton < 4 Then currentButton = 4
            Case 19712 'right
                If currentButton = 4 Then currentButton = 1
            Case -13
                mouseDown = true
                If currentButton > 0 Then
                    mx = button(currentButton).x + button(currentButton).w / 2
                    my = button(currentButton).y + button(currentButton).h / 2
                End If
            Case -27
                Exit Do
        End Select

        If _MouseButton(1) Then
            mouseDown = true
        Else
            If mouseDown Then
                Select Case currentButton
                    Case 1
                        music = Not music
                        Shared track() As Long
                        If track(1) > 0 And music Then _SndLoop track(1)
                        If track(1) > 0 And music = false Then _SndStop track(1)
                    Case 2
                        sfx = Not sfx
                        Shared wooshSound As Long
                        If wooshSound > 0 And sfx Then _SndPlayCopy wooshSound
                    Case 3, 4
                        Exit Do
                End Select
                addParticles mx, my, 30, _RGB32(255)
                addParticles mx, my, 30, _RGB32(67, 172, 183)
            End If
            mouseDown = false
        End If

        'game title
        Color _RGB32(0)
        centerLarge (_Height / 7) + 3, "Settings", 4
        centerLarge (_Height - _Height / 4) - fontHeightLarge(2) + 3, "Tic Tac Toe", 2
        centerLarge (_Height - _Height / 4) + 3, "Rings", 7

        Color _RGB32(255)
        centerLarge (_Height / 7), "Settings", 4
        centerLarge (_Height - _Height / 4) - fontHeightLarge(2), "Tic Tac Toe", 2
        centerLarge (_Height - _Height / 4), "Rings", 7

        updateParticles

        _Display
        _Limit 30
    Loop Until userQuit

    If (gameOver And (keyb = -110 Or keyb = -78)) Or userQuit Then System

    'bring screenshot back to front
    animation(0).start = Timer
    Do
        zoomOut = 200
        screenshotSize = map(Timer - animation(0).start, 0, .5, _Width - zoomOut, _Width)
        If screenshotSize > _Width Then screenshotSize = _Width
        Cls
        _PutImage (0, 0), bgWithoutShelf
        _PutImage (0, (_Height - screenshotSize) / 2)-Step(screenshotSize, screenshotSize), screenshot
        If Timer - animation(0).start <= .3 Then
            Line (0, 0)-(_Width - 1, _Height - 1), _RGB32(255, map(Timer - animation(0).start, 0, .3, 0, 255)), BF
        End If
        _Display
        _Limit 60
    Loop Until Timer - animation(0).start > .5

    _FreeImage screenshot
    _KeyClear
    currentButton = 0
End Sub

Sub createMainScreenButtons
    Shared totalButtons As Integer
    Shared caption() As String
    Shared button() As object
    Shared currentButton As Integer

    totalButtons = 1
    caption(1) = "Settings"
    button(1).h = _FontHeight + 10
    button(1).w = _PrintWidth(caption(1) + "    ")
    button(1).y = _Height - button(1).h - 1
    button(1).x = _Width - button(1).w - 1

    'caption(2) = CHR$(221) + CHR$(222)
    'button(2).h = _FONTHEIGHT + 10
    'button(2).w = _PRINTWIDTH(caption(2) + "    ")
    'button(2).y = 0
    'button(2).x = button(1).x - button(2).w
End Sub

Sub doButtons
    Shared totalButtons As Integer
    Shared caption() As String
    Shared button() As object
    Shared currentButton As Integer
    Dim i As Integer

    For i = 1 To totalButtons
        Line (button(i).x, button(i).y)-Step(button(i).w, button(i).h), _RGB32(255), B
        If i = currentButton Then
            Line (button(currentButton).x, button(currentButton).y)-Step(button(currentButton).w, button(currentButton).h), _RGB32(255, 80), BF
            Color _RGB32(0)
            Dim shadowDepth As Integer
            shadowDepth = 2
            _PrintString (button(i).x + (button(i).w - _PrintWidth(caption(i))) / 2 + shadowDepth, button(i).y + button(i).h / 2 - _FontHeight / 2 + shadowDepth), caption(i)
        End If
        Color _RGB32(255)
        _PrintString (button(i).x + (button(i).w - _PrintWidth(caption(i))) / 2, button(i).y + button(i).h / 2 - _FontHeight / 2), caption(i)
    Next
End Sub

Sub checkButtons
    Shared totalButtons As Integer
    Shared caption() As String
    Shared button() As object
    Shared currentButton As Integer
    Dim i As Integer
    Static lastMouseX As Integer, lastMouseY As Integer

    If _MouseX <> lastMouseX Or _MouseY <> lastMouseY Then
        lastMouseX = _MouseX
        lastMouseY = _MouseY

        currentButton = 0
        For i = 1 To totalButtons
            If _MouseX > button(i).x And _MouseX < button(i).x + button(i).w And _MouseY > button(i).y And _MouseY < button(i).y + button(i).h Then
                currentButton = i
                Exit For
            End If
        Next
    End If
End Sub

