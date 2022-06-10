'Lights On
'A game by Fellippe Heitor - @FellippeHeitor - fellippe@qb64.org
'
'Original concept by Avi Olti, Gyora Benedek, Zvi Herman, Revital Bloomberg, Avi Weiner and Michael Ganor
'https://en.wikipedia.org/wiki/Lights_Out_(game)
'
'Assets sources acknowledged inside SUB GameSetup

Option _Explicit

$ExeIcon:'./assets/lightson.ico'
_Icon

Const true = -1, false = Not true

Type obj
    i As Integer
    j As Integer
    x As Integer
    y As Integer
    w As Integer
    h As Integer
    IsOn As _Byte
    lastSwitch As Single
    lastHint As Single
End Type

Randomize Timer

Dim Shared Arena As Long, OverlayScreen As Long, Bg As Long
Dim Shared LightOn(1 To 9) As Long, LightOff(1 To 9) As Long
Dim Shared RestartIcon As Long, MouseCursor As Long
Dim Shared Ding As Long, Piano As Long, Switch As Long, Bonus As Long
Dim Shared Arial As Long, FontHeight As Integer
Dim Shared maxGridW As Integer, maxGridH As Integer
Dim Shared lights(1 To 20, 1 To 20) As obj
Dim Shared start!, moves As Integer, m$
Dim Shared i As Integer, j As Integer, Level As Integer
Dim Shared k As Long, Alpha As Integer
Dim Shared maxW As Integer, maxH As Integer
Dim Shared MinMoves As Integer, Score As _Unsigned Long
Dim Shared TryAgain As _Byte, TutorialMode As _Byte
Dim Shared lightID As Integer
ReDim Shared Button(1 To 1) As obj, Caption(1 To UBound(Button)) As String

'from p5js.bas - sound system
Type new_SoundHandle
    handle As Long
    sync As _Byte
End Type
ReDim Shared loadedSounds(0) As new_SoundHandle

GameSetup
Intro

Do
    SetLevel
    Do
        UpdateScore
        UpdateArena

        _Display

        k = _KeyHit

        If k = 27 Then System

        _Limit 30
    Loop Until Victory

    'Give time for the last set of bulbs to light up
    Dim LastBulbs As Single
    LastBulbs = Timer
    Do
        UpdateArena
        _Display
    Loop Until Timer - LastBulbs > .3

    EndScreen
Loop

Sub Intro
    'Show intro
    If isLoaded(LightOn(1)) And isLoaded(LightOff(1)) Then
        _Dest OverlayScreen
        Cls , 0
        Color _RGB32(255, 255, 255), 0
        _PrintString (_Width / 2 - _PrintWidth("Lights On!") / 2, _Height - FontHeight * 2), "Lights On!"
        _Dest 0

        _PutImage (_Width / 2 - _Width(LightOff(1)) / 2, 0), LightOff(1)
        _Delay .5
        Alpha = 0
        p5play Piano
        _Font 8
        Do
            If Alpha < 255 Then Alpha = Alpha + 5 Else Exit Do
            _SetAlpha Alpha, , OverlayScreen
            _ClearColor _RGB32(0, 0, 0), OverlayScreen
            _SetAlpha Alpha, , LightOn(1)

            _PutImage (_Width / 2 - _Width(LightOn(1)) / 2, 0), LightOn(1)
            _PutImage , OverlayScreen
            Color _RGBA32(255, 255, 255, Alpha), 0
            _PrintString (_Width / 2 - _PrintWidth("Fellippe Heitor, 2017") / 2, _Height - FontHeight * 1.5), "Fellippe Heitor, 2017"

            _Display
            _Limit 20
        Loop

        _Font 16

        If _FileExists("lightson.dat") = false And isLoaded(MouseCursor) Then
            'offer tutorial on the first run
            Dim ii As Integer

            _Dest OverlayScreen
            Cls , 0
            m$ = "Show instructions?"
            Color _RGB32(0, 0, 0), 0
            _PrintString (_Width / 2 - _PrintWidth(m$) / 2 + 1, _Height / 2 - FontHeight * 2 + 1), m$
            Color _RGB32(255, 255, 255), 0
            _PrintString (_Width / 2 - _PrintWidth(m$) / 2, _Height / 2 - FontHeight * 2), m$
            _Dest 0

            Do
                _PutImage (_Width / 2 - _Width(LightOn(1)) / 2, 0), LightOn(1)
                _PutImage , OverlayScreen

                For ii = 4 To 5
                    If Hovering(Button(ii)) Then
                        Line (Button(ii).x + 5, Button(ii).y + 5)-Step(Button(ii).w, Button(ii).h), _RGB32(0, 0, 0), BF
                        Line (Button(ii).x, Button(ii).y)-Step(Button(ii).w, Button(ii).h), _RGB32(255, 255, 255), BF
                    Else
                        Line (Button(ii).x, Button(ii).y)-Step(Button(ii).w, Button(ii).h), _RGBA32(255, 255, 255, 170), BF
                    End If
                    Color _RGB32(0, 0, 0), 0
                    _PrintString (Button(ii).x + Button(ii).w / 2 - _PrintWidth(Caption(ii)) / 2, Button(ii).y + Button(ii).h / 2 - FontHeight / 2), Caption(ii)
                Next

                If _MouseButton(1) Then
                    While _MouseButton(1): ii = _MouseInput: Wend
                    If Hovering(Button(5)) Then
                        Exit Do
                    ElseIf Hovering(Button(4)) Then
                        TutorialMode = true
                        ShowTutorial
                        Open "lightson.dat" For Output As #1
                        Close #1
                        TutorialMode = false
                        Exit Do
                    End If
                End If

                _Display
                _Limit 30
            Loop
        End If
    End If
End Sub

Sub ClickPause
    Do
        k = _KeyHit

        While _MouseInput: Wend
        If _MouseButton(1) Then
            While _MouseButton(1): i = _MouseInput: Wend
            Exit Do
        End If

        _Display
        _Limit 30
    Loop Until k = 27 Or k = 13
End Sub

Sub CenteredText (Text$)
    Dim tWidth As Integer, tHeight As Integer

    tWidth = _PrintWidth(Text$) + 20
    tHeight = FontHeight * 3

    Line (_Width / 2 - tWidth / 2, _Height / 2 - tHeight / 2)-Step(tWidth - 1, tHeight - 1), _RGBA32(255, 255, 255, 200), BF
    Color _RGB32(255, 255, 255), 0
    _PrintString (_Width / 2 - _PrintWidth(Text$) / 2 + 1, _Height / 2 - FontHeight / 2 + 1), Text$
    Color _RGB32(0, 0, 0), 0
    _PrintString (_Width / 2 - _PrintWidth(Text$) / 2, _Height / 2 - FontHeight / 2), Text$
End Sub

Sub StatusText (Text$)
    Color _RGB32(0, 0, 0), _RGB32(255, 255, 255)
    Cls

    _PrintString (_Width / 2 - _PrintWidth(Text$) / 2, _Height - FontHeight * 1.5), Text$
End Sub

Sub GameSetup
    'Acknowledgements:
    '--------------------------------------------------------------------------------------------------------------------
    'Light bulb images from https://blog.1000bulbs.com/home/flip-the-switch-how-an-incandescent-light-bulb-works
    'End level bg from http://blog-sap.com/analytics/2013/06/14/sap-lumira-new-software-update-general-availability-of-cloud-version-and-emeauk-flash-sale-at-bi2013/
    'Ding sound: https://www.freesound.org/people/Flo_Rayen/sounds/191835/
    'Bonus sound: http://freesound.org/people/LittleRobotSoundFactory/sounds/274183/
    'Piano sound: https://www.freesound.org/people/FoolBoyMedia/sounds/352655/
    'Switch sound: https://www.freesound.org/people/Mindloop/sounds/253659/
    'App icon: http://www.iconarchive.com/show/small-n-flat-icons-by-paomedia/light-bulb-icon.html
    'Restart icon: http://www.iconarchive.com/show/windows-8-icons-by-icons8/Computer-Hardware-Restart-icon.html
    'Mouse cursor icon: http://www.iconarchive.com/show/windows-8-icons-by-icons8/Very-Basic-Cursor-icon.html
    '--------------------------------------------------------------------------------------------------------------------

    'Load assets:
    Arena = _NewImage(600, 600, 32)

    'Arial = _LOADFONT("arial.ttf", 24)
    LightOn(1) = loadImage("assets/lighton.png")
    LightOn(2) = loadImage("assets/lighton300.png")
    LightOn(3) = loadImage("assets/lighton120.png")
    LightOn(4) = loadImage("assets/lighton86.png")
    LightOn(5) = loadImage("assets/lighton67.png")
    LightOn(6) = loadImage("assets/lighton60.png")
    LightOn(7) = loadImage("assets/lighton55.png")
    LightOn(8) = loadImage("assets/lighton35.png")
    LightOn(9) = loadImage("assets/lighton30.png")

    LightOff(1) = loadImage("assets/lightoff.png")
    LightOff(2) = loadImage("assets/lightoff300.png")
    LightOff(3) = loadImage("assets/lightoff120.png")
    LightOff(4) = loadImage("assets/lightoff86.png")
    LightOff(5) = loadImage("assets/lightoff67.png")
    LightOff(6) = loadImage("assets/lightoff60.png")
    LightOff(7) = loadImage("assets/lightoff55.png")
    LightOff(8) = loadImage("assets/lightoff35.png")
    LightOff(9) = loadImage("assets/lightoff30.png")

    Bg = loadImage("assets/bg.jpg")
    RestartIcon = loadImage("assets/restart.png")
    MouseCursor = loadImage("assets/mouse.png")

    Ding = loadSound("assets/ding.wav")
    Piano = loadSound("assets/piano.ogg")
    Switch = loadSound("assets/switch.wav")
    Bonus = loadSound("assets/bonus.wav")

    If isLoaded(Bg) Then _SetAlpha 30, , Bg
    If Arial > 0 Then FontHeight = _FontHeight(Arial) Else FontHeight = 16

    If Arial > 0 Then
        _Font Arial
        _Dest OverlayScreen
        _Font Arial
        _Dest 0
    End If

    'Screen setup:
    Screen _NewImage(600, 600 + FontHeight * 2, 32)
    Do Until _ScreenExists: _Limit 30: Loop
    _Title "Lights On" + Chr$(0)

    OverlayScreen = _NewImage(_Width / 2, _Height / 2, 32)

    'Set buttons:
    ReDim Button(1 To 5) As obj, Caption(1 To UBound(Button)) As String

    Dim b As Integer
    b = b + 1: Caption(b) = "Try again"
    Button(b).y = _Height / 2 + FontHeight * 11.5
    Button(b).w = _PrintWidth(Caption(b)) + 40
    Button(b).x = _Width / 2 - 10 - Button(b).w
    Button(b).h = 40

    b = b + 1: Caption(b) = "Next level"
    Button(b).y = _Height / 2 + FontHeight * 11.5
    Button(b).w = _PrintWidth(Caption(b)) + 40
    Button(b).x = _Width / 2 + 10
    Button(b).h = 40

    b = b + 1: Caption(b) = "Restart level"
    If isLoaded(RestartIcon) Then
        Button(b).w = _Width(RestartIcon) + 20
        Button(b).h = FontHeight * 2
        Button(b).x = _Width - Button(b).w - 10
        Button(b).y = _Height - FontHeight - Button(b).h / 2
    Else
        Button(b).h = FontHeight * 2
        Button(b).w = _PrintWidth(Caption(b)) + 20
        Button(b).x = _Width - 10 - Button(b).w
        Button(b).y = _Height - Button(b).h
    End If

    b = b + 1: Caption(b) = "Yes"
    Button(b).y = _Height / 2 - FontHeight / 2
    Button(b).w = _PrintWidth(Caption(b)) + 40
    Button(b).x = _Width / 2 - 10 - Button(b).w
    Button(b).h = 40

    b = b + 1: Caption(b) = "No"
    Button(b).y = _Height / 2 - FontHeight / 2
    Button(b).w = _PrintWidth(Caption(b)) + 40
    Button(b).x = _Width / 2 + 10
    Button(b).h = 40
End Sub

Function loadImage& (file$)
    Dim tempHandle&

    If _FileExists(file$) = 0 Then Exit Function

    tempHandle& = _LoadImage(file$, 32)
    If tempHandle& = -1 Then 'load failed
        tempHandle& = 0
    End If

    loadImage& = tempHandle&
End Function

Function isLoaded%% (imgHandle&)
    isLoaded%% = imgHandle& < -1
End Function

Sub SetLevel
    If Not TryAgain Then Level = Level + 1

    Dim LevelSettings As Integer
    If Level <= 15 Then LevelSettings = Level Else LevelSettings = _Ceil(Rnd * 13) + 2

    Select Case LevelSettings
        Case 1
            maxGridW = 1
            maxGridH = 2
            MinMoves = 2
            lightID = 2
        Case 2
            maxGridW = 2
            maxGridH = 2
            MinMoves = 1
            lightID = 2
        Case 3, 4
            maxGridW = 4
            maxGridH = 5
            MinMoves = 11
            lightID = 3
        Case 5
            maxGridW = 5
            maxGridH = 7
            MinMoves = 65
            lightID = 4
        Case 6
            maxGridW = 10
            maxGridH = 10
            MinMoves = 65
            lightID = 6
        Case 7, 8
            maxGridW = 7
            maxGridH = 9
            MinMoves = 90
            lightID = 5
        Case 9, 10
            maxGridW = 7
            maxGridH = 11
            MinMoves = 130
            lightID = 7
        Case 11, 12
            maxGridW = 9
            maxGridH = 11
            MinMoves = 90
            lightID = 7
        Case 13, 14
            maxGridW = 11
            maxGridH = 17
            MinMoves = 180
            lightID = 8
        Case Else
            maxGridW = 20
            maxGridH = 20
            MinMoves = 230
            lightID = 9
    End Select

    maxW = _Width(Arena) / maxGridW
    maxH = _Height(Arena) / maxGridH

    For i = 1 To maxGridW
        For j = 1 To maxGridH
            lights(i, j).x = i * maxW - maxW
            lights(i, j).y = j * maxH - maxH
            lights(i, j).w = maxW - 1
            lights(i, j).h = maxH - 1
            lights(i, j).i = i
            lights(i, j).j = j
            lights(i, j).IsOn = false
        Next
    Next

    Dim rndState As Integer
    For rndState = 1 To maxGridW / 3
        i = _Ceil(Rnd * maxGridW)
        j = _Ceil(Rnd * maxGridH)
        SetState lights(i, j)
    Next

    start! = Timer
    moves = 0
End Sub

Sub EndScreen
    UpdateArena
    _Dest 0
    _PutImage (0, 0), Arena

    Dim EndAnimationStep As Integer, FinalBonus As _Byte
    Dim SlideOpen As Integer, SlideVelocity As Single
    Dim Snd1 As _Byte, Snd2 As _Byte, Snd3 As _Byte
    Dim FinalLamp1!, FinalLamp2!, FinalLamp3!
    Dim SkipEndAnimation As _Byte
    Dim BgXOffset As Single, BgYOffset As Single
    Dim BgXSpeed As Single, BgYSpeed As Single

    Snd1 = false: Snd2 = false: Snd3 = false
    FinalBonus = false

    If isLoaded(LightOn(3)) Then _SetAlpha 255, , LightOn(3)

    Alpha = 0
    TryAgain = false
    EndAnimationStep = 1
    SkipEndAnimation = false

    BgXSpeed = .5
    BgYSpeed = .3
    If isLoaded(Bg) Then
        BgXOffset = _Width(Bg) - _Width * 1.5
        BgYOffset = _Height(Bg) - _Height * 1.5
    End If

    p5play Piano
    Do
        While _MouseInput: Wend

        If EndAnimationStep < 70 Then
            _Dest OverlayScreen
            Cls , 0
            m$ = "Level" + Str$(Level) + " - All Lights On!"
            Color _RGB32(0, 0, 0), 0
            _PrintString (_Width / 2 - _PrintWidth(m$) / 2 + 1, _Height / 2 - 80 - FontHeight + 1), m$
            Color _RGB32(255, 255, 255), 0
            _PrintString (_Width / 2 - _PrintWidth(m$) / 2, _Height / 2 - 80 - FontHeight), m$

            m$ = "Moves used:" + Str$(moves)
            Color _RGB32(0, 0, 0), 0
            _PrintString (_Width / 2 - _PrintWidth(m$) / 2 + 1, _Height / 2 + FontHeight * 2.5 + 1), m$
            Color _RGB32(255, 255, 255), 0
            _PrintString (_Width / 2 - _PrintWidth(m$) / 2, _Height / 2 + FontHeight * 2.5), m$

            m$ = "Score:" + Str$(Score)
            Color _RGB32(0, 0, 0), 0
            _PrintString (_Width / 2 - _PrintWidth(m$) / 2 + 1, _Height / 2 + FontHeight * 3.5 + 1), m$
            Color _RGB32(255, 255, 255), 0
            _PrintString (_Width / 2 - _PrintWidth(m$) / 2, _Height / 2 + FontHeight * 3.5), m$
        End If

        _Dest 0

        BgXOffset = BgXOffset + BgXSpeed
        BgYOffset = BgYOffset + BgYSpeed
        If isLoaded(Bg) Then
            If BgXOffset < 0 Or BgXOffset + _Width - 1 > _Width(Bg) Then BgXSpeed = BgXSpeed * -1
            If BgYOffset < 0 Or BgYOffset + _Height - 1 > _Height(Bg) Then BgYSpeed = BgYSpeed * -1
            _PutImage (0, 0)-Step(_Width - 1, _Height - 1), Bg, , (BgXOffset, BgYOffset)-Step(_Width - 1, _Height - 1)
        End If
        Select Case EndAnimationStep
            Case 1
                If Alpha < 255 Then Alpha = Alpha + 10 Else EndAnimationStep = 2: SlideOpen = 0: SlideVelocity = 30: Alpha = 0
                If Not isLoaded(Bg) Then
                    Line (0, 0)-(_Width, _Height), _RGBA32(255, 255, 0, Alpha), BF
                    Line (0, 0)-(_Width, _Height), _RGBA32(255, 255, 255, Alpha), BF
                End If
                _PutImage , OverlayScreen
            Case 2
                If Not isLoaded(Bg) Then Line (0, 0)-(_Width, _Height), _RGBA32(255, 255, 255, 30), BF
                SlideVelocity = SlideVelocity - .2
                If SlideVelocity < 1 Then SlideVelocity = 1
                If SlideOpen < 600 Then
                    SlideOpen = SlideOpen + SlideVelocity
                Else
                    SlideOpen = 600
                    EndAnimationStep = 3
                    i = _Width / 2 - (SlideOpen / 3.5)
                    j = _Height / 2 - SlideOpen / 5 + FontHeight * 1.5
                End If

                _PutImage , OverlayScreen
                Dim b As Integer
                b = map(SlideOpen, 0, 600, 255, 0)
                Line (0, _Height / 2 - 125 + FontHeight * 1.5)-Step(SlideOpen, 130), _RGB32(255, 255, 255), BF
                Line (0, _Height / 2 - 120 + FontHeight * 1.5)-Step(SlideOpen, 120), _RGB32(b * 1.5, b * 1.5 - 50, 0), BF
            Case Is >= 3
                EndAnimationStep = EndAnimationStep + 1
                If Not isLoaded(Bg) Then Line (0, 0)-(_Width, _Height), _RGBA32(255, 255, 255, 40), BF
                _PutImage , OverlayScreen
                Line (0, _Height / 2 - 125 + FontHeight * 1.5)-Step(SlideOpen, 130), _RGB32(255, 255, 255), BF
                Line (0, _Height / 2 - 120 + FontHeight * 1.5)-Step(SlideOpen, 120), _RGB32(b, b - 20, 0), BF

                If isLoaded(LightOff(3)) Then
                    _PutImage (i, j), LightOff(3)
                    _PutImage (i + SlideOpen / 5, j), LightOff(3)
                    _PutImage (i + (SlideOpen / 5) * 2, j), LightOff(3)
                End If

                If EndAnimationStep >= 3 Then
                    If MinMoves <= MinMoves * 3 Then
                        If Snd1 = false Then p5play Ding: Snd1 = true
                        If EndAnimationStep = 4 Then FinalLamp1! = Timer: Score = Score + 20

                        If EndAnimationStep <= 20 Then
                            Score = Score + 10
                            If Not SkipEndAnimation Then p5play Switch
                        End If

                        If isLoaded(LightOn(3)) Then
                            _SetAlpha constrain(map(Timer - FinalLamp1!, 0, .3, 0, 255), 0, 255), , LightOn(3)
                            _PutImage (i, j), LightOn(3)
                        Else
                            Line (i, j)-Step(SlideOpen / 5, SlideOpen / 5), _RGB32(111, 227, 39), BF
                            Line (i, j)-Step(SlideOpen / 5, SlideOpen / 5), _RGB32(0, 0, 0), B
                        End If
                    End If
                End If

                If EndAnimationStep > 20 Then
                    If moves <= MinMoves * 2 Then
                        If Snd2 = false Then p5play Ding: Snd2 = true
                        If EndAnimationStep = 21 Then FinalLamp2! = Timer: Score = Score + 20

                        If EndAnimationStep <= 40 Then
                            Score = Score + 10
                            If Not SkipEndAnimation Then p5play Switch
                        End If

                        If isLoaded(LightOn(3)) Then
                            _SetAlpha constrain(map(Timer - FinalLamp2!, 0, .3, 0, 255), 0, 255), , LightOn(3)
                            _PutImage (i + SlideOpen / 5, j), LightOn(3)
                        Else
                            Line (i + SlideOpen / 5, j)-Step(SlideOpen / 5, SlideOpen / 5), _RGB32(111, 227, 39), BF
                            Line (i + SlideOpen / 5, j)-Step(SlideOpen / 5, SlideOpen / 5), _RGB32(0, 0, 0), B
                        End If
                    End If
                End If

                If EndAnimationStep > 40 Then
                    If moves <= MinMoves Then
                        If Snd3 = false Then p5play Ding: Snd3 = true
                        If EndAnimationStep = 41 Then FinalLamp3! = Timer: Score = Score + 20

                        If EndAnimationStep <= 60 Then
                            Score = Score + 10
                            If Not SkipEndAnimation Then p5play Switch
                        End If

                        If isLoaded(LightOn(3)) Then
                            _SetAlpha constrain(map(Timer - FinalLamp3!, 0, .3, 0, 255), 0, 255), , LightOn(3)
                            _PutImage (i + (SlideOpen / 5) * 2, j), LightOn(3)
                        Else
                            Line (i + (SlideOpen / 5) * 2, j)-Step(SlideOpen / 5, SlideOpen / 5), _RGB32(111, 227, 39), BF
                            Line (i + (SlideOpen / 5) * 2, j)-Step(SlideOpen / 5, SlideOpen / 5), _RGB32(0, 0, 0), B
                        End If
                    End If
                End If

                If EndAnimationStep > 60 Then
                    If FinalBonus = false Then
                        FinalBonus = true
                        If moves < MinMoves Then
                            Score = Score + 50
                            p5play Bonus
                        End If
                    Else
                        If moves < MinMoves Then
                            m$ = "Strategy master! +50 bonus points!"
                            Color _RGB32(0, 0, 0), 0
                            _PrintString (_Width / 2 - _PrintWidth(m$) / 2 + 1, _Height / 2 + FontHeight * 9.5 + 1), m$
                            Color _RGB32(255, 255, 255), 0
                            _PrintString (_Width / 2 - _PrintWidth(m$) / 2, _Height / 2 + FontHeight * 9.5), m$
                        End If
                    End If
                End If
        End Select

        'Buttons
        If EndAnimationStep > 60 Then
            Dim ii As Integer
            For ii = 1 To 2
                If Hovering(Button(ii)) Then
                    Line (Button(ii).x + 5, Button(ii).y + 5)-Step(Button(ii).w, Button(ii).h), _RGB32(0, 0, 0), BF
                    Line (Button(ii).x, Button(ii).y)-Step(Button(ii).w, Button(ii).h), _RGB32(255, 255, 255), BF
                Else
                    Line (Button(ii).x, Button(ii).y)-Step(Button(ii).w, Button(ii).h), _RGBA32(255, 255, 255, 20), BF
                End If
                'COLOR _RGB32(255, 255, 255), 0
                '_PRINTSTRING (Button(ii).x + Button(ii).w / 2 - _PRINTWIDTH(Caption(ii)) / 2 + 1, Button(ii).y + Button(ii).h / 2 - FontHeight / 2 + 1), Caption(ii)
                Color _RGB32(0, 0, 0), 0
                _PrintString (Button(ii).x + Button(ii).w / 2 - _PrintWidth(Caption(ii)) / 2, Button(ii).y + Button(ii).h / 2 - FontHeight / 2), Caption(ii)
            Next
        End If

        _Display

        k = _KeyHit

        If k = 13 And EndAnimationStep > 60 Then Exit Do
        If k = 27 Then System

        If _MouseButton(1) And EndAnimationStep > 60 Then
            While _MouseButton(1): ii = _MouseInput: Wend
            If Hovering(Button(1)) Then
                TryAgain = true
                Exit Do
            ElseIf Hovering(Button(2)) Then
                Exit Do
            End If
        ElseIf _MouseButton(1) Then
            SkipEndAnimation = true
        End If

        If Not SkipEndAnimation Then _Limit 30
    Loop
End Sub

Sub UpdateArena
    Dim imgWidth As Integer, imgHeight As Integer
    Dim FoundHover As _Byte

    imgHeight = lights(1, 1).h
    imgWidth = imgHeight

    _Dest Arena
    Cls
    For i = 1 To maxGridW
        For j = 1 To maxGridH
            If isLoaded(LightOff(lightID)) Then
                _PutImage (lights(i, j).x + lights(i, j).w / 2 - imgWidth / 2, lights(i, j).y), LightOff(lightID)
            End If
            If lights(i, j).IsOn Then
                If isLoaded(LightOn(lightID)) Then
                    If Timer - lights(i, j).lastSwitch < .3 Then
                        _SetAlpha constrain(map(Timer - lights(i, j).lastSwitch, 0, .3, 0, 255), 0, 255), , LightOn(lightID)
                    Else
                        _SetAlpha 255, , LightOn(lightID)
                    End If
                    _PutImage (lights(i, j).x + lights(i, j).w / 2 - imgWidth / 2, lights(i, j).y), LightOn(lightID)
                Else
                    Line (lights(i, j).x, lights(i, j).y)-Step(lights(i, j).w, lights(i, j).h), _RGB32(111, 227, 39), BF
                End If
            End If
            If Hovering(lights(i, j)) And FoundHover = false And TutorialMode = false Then
                FoundHover = true
                Line (lights(i, j).x, lights(i, j).y)-Step(lights(i, j).w, lights(i, j).h), _RGBA32(255, 255, 255, 100), BF
                CheckState lights(i, j)
            End If
            Line (lights(i, j).x, lights(i, j).y)-Step(lights(i, j).w, lights(i, j).h), , B
        Next
    Next
    _Dest 0
    _PutImage (0, 0), Arena
End Sub

Sub UpdateScore
    Dim seconds%
    Color _RGB32(0, 0, 0), _RGB32(255, 255, 255)
    Cls

    If Timer > start! Then
        seconds% = Timer - start!
    Else
        seconds% = 86400 - start: start! = Timer
    End If

    m$ = "Level:" + Str$(Level) + " (" + LTrim$(Str$(maxGridW)) + "x" + LTrim$(Str$(maxGridH)) + ")    Moves:" + Str$(moves) + "    Time elapsed:" + Str$(seconds%) + "s"
    _PrintString (10, _Height - FontHeight * 1.5), m$

    If Hovering(Button(3)) Then
        Line (Button(3).x, Button(3).y)-Step(Button(3).w - 1, Button(3).h - 1), _RGB32(127, 127, 127), BF
        If _MouseButton(1) Then
            While _MouseButton(1): i = _MouseInput: Wend
            If Hovering(Button(3)) Then
                TryAgain = true: SetLevel
            End If
        End If
    End If

    If isLoaded(RestartIcon) Then
        _PutImage (Button(3).x + Button(3).w / 2 - _Width(RestartIcon) / 2, Button(3).y + Button(3).h / 2 - _Height(RestartIcon) / 2), RestartIcon
    Else
        Color _RGB32(0, 0, 0), 0
        _PrintString (Button(3).x + Button(3).w / 2 - _PrintWidth(Caption(3)) / 2, Button(3).y + Button(3).h / 2 - FontHeight / 2), Caption(3)
    End If
End Sub

Function Victory%%
    Dim i As Integer, j As Integer
    For i = 1 To maxGridW
        For j = 1 To maxGridH
            If lights(i, j).IsOn = false Then Exit Function
        Next
    Next

    Victory%% = true
End Function

Sub CheckState (object As obj)
    Dim i As Integer

    If _MouseButton(1) Then
        While _MouseButton(1): i = _MouseInput: Wend
        If Hovering(object) Then
            p5play Switch
            moves = moves + 1
            SetState object
        End If
    End If
End Sub

Sub SetState (object As obj)
    Dim ioff As Integer, joff As Integer
    ioff = -1
    joff = 0
    If object.i + ioff > 0 And object.i + ioff < maxGridW + 1 And object.j + joff > 0 And object.j + joff < maxGridH + 1 Then
        lights(object.i + ioff, object.j + joff).IsOn = Not lights(object.i + ioff, object.j + joff).IsOn
        lights(object.i + ioff, object.j + joff).lastSwitch = Timer
    End If

    ioff = 1
    joff = 0
    If object.i + ioff > 0 And object.i + ioff < maxGridW + 1 And object.j + joff > 0 And object.j + joff < maxGridH + 1 Then
        lights(object.i + ioff, object.j + joff).IsOn = Not lights(object.i + ioff, object.j + joff).IsOn
        lights(object.i + ioff, object.j + joff).lastSwitch = Timer
    End If

    ioff = 0
    joff = -1
    If object.i + ioff > 0 And object.i + ioff < maxGridW + 1 And object.j + joff > 0 And object.j + joff < maxGridH + 1 Then
        lights(object.i + ioff, object.j + joff).IsOn = Not lights(object.i + ioff, object.j + joff).IsOn
        lights(object.i + ioff, object.j + joff).lastSwitch = Timer
    End If

    ioff = 0
    joff = 1
    If object.i + ioff > 0 And object.i + ioff < maxGridW + 1 And object.j + joff > 0 And object.j + joff < maxGridH + 1 Then
        lights(object.i + ioff, object.j + joff).IsOn = Not lights(object.i + ioff, object.j + joff).IsOn
        lights(object.i + ioff, object.j + joff).lastSwitch = Timer
    End If
End Sub

Function Hovering%% (object As obj)
    While _MouseInput: Wend
    Hovering%% = _MouseX > object.x And _MouseX < object.x + object.w And _MouseY > object.y And _MouseY < object.y + object.h
End Function

Sub MoveMouse (sx As Integer, sy As Integer, dx As Integer, dy As Integer)
    Dim stepX As Single, stepY As Single
    Dim i As _Byte

    Const maxSteps = 30

    stepX = (dx - sx) / maxSteps
    stepY = (dy - sy) / maxSteps

    For i = 1 To maxSteps
        sx = sx + stepX
        sy = sy + stepY
        UpdateArena
        _PutImage (sx, sy), MouseCursor
        _Display
        _Limit 30
    Next
End Sub

Sub ShowTutorial
    Dim i As Integer, j As Integer
    Dim mx As Integer, my As Integer
    Dim StepNumber As Integer, TotalSteps As Integer

    Level = 2
    SetLevel
    TotalSteps = 5

    StatusText "Tutorial Mode - Click to proceed"
    UpdateArena
    StepNumber = StepNumber + 1
    CenteredText "(" + LTrim$(Str$(StepNumber)) + "/" + LTrim$(Str$(TotalSteps)) + ") Your goal is to turn all light bulbs on."

    mx = 400
    my = 400
    _PutImage (mx, my), MouseCursor

    _Display
    ClickPause
    If k = 27 Then Level = 0: Exit Sub

    For i = 1 To maxGridW
        For j = 1 To maxGridH
            lights(i, j).IsOn = false
        Next
    Next

    UpdateArena
    StepNumber = StepNumber + 1
    CenteredText "(" + LTrim$(Str$(StepNumber)) + "/" + LTrim$(Str$(TotalSteps)) + ") However, you can't simply switch a light bulb on or off directly."

    mx = 400
    my = 400
    _PutImage (mx, my), MouseCursor

    _Display

    ClickPause
    If k = 27 Then Level = 0: Exit Sub

    UpdateArena
    StepNumber = StepNumber + 1
    CenteredText "(" + LTrim$(Str$(StepNumber)) + "/" + LTrim$(Str$(TotalSteps)) + ") You click a light bulb to turn the surrounding ones on/off."
    _PutImage (mx, my), MouseCursor
    _Display

    ClickPause
    If k = 27 Then Level = 0: Exit Sub

    MoveMouse mx, my, lights(2, 2).x + lights(2, 2).w / 2, lights(2, 2).y + lights(2, 2).h / 2
    SetState lights(2, 2)
    p5play Switch
    Do
        UpdateArena
        _PutImage (mx, my), MouseCursor
        _Display
    Loop Until Timer - lights(2, 1).lastSwitch > .3

    UpdateArena
    _PutImage (mx, my), MouseCursor
    StepNumber = StepNumber + 1
    CenteredText "(" + LTrim$(Str$(StepNumber)) + "/" + LTrim$(Str$(TotalSteps)) + ") Continue until all light bulbs are on."
    _Display

    ClickPause
    If k = 27 Then Level = 0: Exit Sub

    MoveMouse mx, my, lights(3, 2).x + lights(3, 2).w / 2, lights(3, 2).y + lights(3, 2).h / 2
    SetState lights(3, 2)
    p5play Switch
    Do
        UpdateArena
        _PutImage (mx, my), MouseCursor
        _Display
    Loop Until Timer - lights(3, 1).lastSwitch > .3

    UpdateArena
    StepNumber = StepNumber + 1
    _PutImage (mx, my), MouseCursor
    CenteredText "(" + LTrim$(Str$(StepNumber)) + "/" + LTrim$(Str$(TotalSteps)) + ") Simple right? Click to start."
    _Display

    ClickPause

    Level = 0
    Exit Sub
End Sub

'functions below are borrowed from p5js.bas:
Function map! (value!, minRange!, maxRange!, newMinRange!, newMaxRange!)
    map! = ((value! - minRange!) / (maxRange! - minRange!)) * (newMaxRange! - newMinRange!) + newMinRange!
End Function

Function min! (a!, b!)
    If a! < b! Then min! = a! Else min! = b!
End Function

Function max! (a!, b!)
    If a! > b! Then max! = a! Else max! = b!
End Function

Function constrain! (n!, low!, high!)
    constrain! = max(min(n!, high!), low!)
End Function

Function loadSound& (file$)
    If _FileExists(file$) = 0 Then Exit Function
    Dim tempHandle&, setting$
    Static totalLoadedSounds As Long

    setting$ = "vol"

    Select Case UCase$(Right$(file$, 4))
        Case ".WAV", ".OGG", ".AIF", ".RIF", ".VOC"
            setting$ = "vol,sync,len,pause"
        Case ".MP3"
            setting$ = "vol,pause,setpos"
    End Select

    tempHandle& = _SndOpen(file$, setting$)
    If tempHandle& > 0 Then
        totalLoadedSounds = totalLoadedSounds + 1
        ReDim _Preserve loadedSounds(totalLoadedSounds) As new_SoundHandle
        loadedSounds(totalLoadedSounds).handle = tempHandle&
        loadedSounds(totalLoadedSounds).sync = InStr(setting$, "sync") > 0
        loadSound& = tempHandle&
    End If
End Function

Sub p5play (soundHandle&)
    Dim i As Long
    For i = 1 To UBound(loadedSounds)
        If loadedSounds(i).handle = soundHandle& Then
            If loadedSounds(i).sync Then
                _SndPlayCopy soundHandle&
            Else
                If Not _SndPlaying(soundHandle&) Then _SndPlay soundHandle&
            End If
        End If
    Next
End Sub

