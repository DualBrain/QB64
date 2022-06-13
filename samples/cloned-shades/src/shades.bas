'Cloned Shades - by @FellippeHeitor - fellippeheitor@gmail.com
'
'(a clone of 'Shades' which was originally developed by
'UOVO - http://www.uovo.dk/ - for iOS)
'
'The goal of this game is to use the arrow keys to choose where
'to lay the next block falling down. If you align 4 blocks of
'the same color shade horizontally, you erase a line. If you
'pile two identical blocks, they will merge to become darker,
'unless they are already the darkest shade available (of 5).
'
'It has a tetris feeling to it, but it's not tetris at all.
'
'The idea is not original, since it's a clone, but I coded it
'from the ground up.
'
'Changes:
'- Beta 1
'       - So far I got the game to work, but I'm running into issues
'         trying to show scores on the screen, mainly because I relied
'         on POINT to check whether I could move blocks down or not.
'       - There's no interface except for the actual gameboard.
'
'- Beta 2
'       - Been discarded. At some point everything was working well but
'         I managed to screw it all up, to the point I made the decision
'         to go back to beta 1 and start over. I like to mention it here
'         because even failure can teach you a lesson, and this one is
'         not one to forget.
'
'- Beta 3
'       - Converted all audio files to .OGG for smaller files and faster
'         loading.
'       - Game window now has an appropriate icon, generated at runtime.
'       - Block movement has been coded again, and now it doesn't rely
'         on POINT to detect blocks touching each other, but it actually
'         evaluates the current Y position. Like it should have been from
'         the start, to be honest.
'       - Redone the merge animation. Still looks the same, but it had to
'         be redone after the new movement routines have been implemented.
'       - Added a background image to the game board ("bg.png"), but uses
'         a gray background in case it cannot be loaded for some reason.
'       - Code is a bit easier to read, after I moved most of the main
'         loop code into separate subroutines.
'       - SCORES ON THE SCREEN!
'
' - Beta 4
'       - Adaptative resolution when the desktop isn't at least 900px tall.
'       - New shades, which are alternated every time a new game is started.
'       - Visual intro, mimicking the original game's.
'       - Improved game performance by selectively limiting the layering of
'         images in SUB UpdateScreen.
'       - Added a "danger mode" visual indication, by turning on a TIMER that
'         overlays a shade of red over the game play, similar to a security
'         alarm.
'       - Added a menu to start the game or change setting or leave.
'       - Settings are now saved to "shades.dat", and include switches for
'         sound and music, as well as a highscore.
'       - Added an end screen, that shows the score, number of merges and
'         number of lines destroyed during game.
'
' - Beta 5
'       - Fixed game starting with the blocks that were put during the menu
'         demonstration.
'       - Fixed the 'danger' warning coming back from the previous game.
'       - Added an option to select shades (GREEN, ORANGE, BLUE, PINK) or
'         to have it AUTOmatically rotate everytime you start the game.
'         (thanks to Clippy for suggesting it)
'       - Added a confirmation message before clearing highscore.
'       - Added a confirmation message before closing the game with ESC.
'       - Fixed a bug with page _DEST that caused scores to be put in
'         OverlayGraphics page instead of InfoScreen while InDanger
'         triggered the ShowAlert sub.
'
' - Beta 6
'       - ESC during the game shows a menu asking user to confirm QUIT or
'         RESUME. The previous behaviour (in beta 5) was to quit to main
'         menu after ESC was hit twice. Now ESC is interpreted as 'oops,
'         I didn't mean to hit ESC'.
'       - A new sound for when a line is destroyed ("line.ogg"); "wind.ogg"
'         is no longer used/needed.
'       - Added a sound to the game over screen ("gameover.ogg").
'       - Fixed menu alignment issues when showing disabled choices.
'       - Changed code to selectively NOT do what can't be done in MAC OS X
'         (so that now we can compile in MAC OS X, tested in El Capitan).
'       - Three lines of code changed to make the code backward compatible
'         with QB64 v0.954 (SDL): BackgroundColor goes back to being a shared
'         LONG instead of a CONST (since SDL won't allow _RGB32 in a CONST)
'         and inside SUB CheckMerge we no longer clear the background using
'         a patch from BgImage using _PUTIMAGE with STEP. Turns out the bug
'         was in QB64, not in my code.
'
' - Beta 7
'       - Fixed a bug that prevented the end screen to be shown because of
'         the InDanger timer still being on.
'       - Added three levels of difficulty, which affect gravity.
'       - Since speed is different, a new soundtrack was added for faster
'         modes ("Crowd_Hammer.ogg" and "Upbeat_Forever.ogg")
'       - Added FILL mode (thanks to Pete for the suggestion), in which instead
'         of an infinite game your goal is to fill the screen with blocks,
'         avoiding merges at all costs, since they make you lose points (which
'         is indicated by a "shock.ogg" sound and visual warning.
'       - Added a new parameter to FUNCTION Menu, Info(), that holds descriptions
'         for menu items. The goal is to be able to show highscores even
'         before starting a game.
'       - Clicking and dragging emulates keystrokes, allowing basic mouse
'         controls (code courtesy of Steve McNeill - Thanks again!)
'
' - Version 1.0
'       - Fixed: Disabling music through settings didn't stop the music. Duh.
'       - Fixed: Shock sound during Fill mode sounded weird because it was being
'         played inside the animation loop, and not once, before animation.
'       - Fixed: BgMusic selection while in Fill mode.
'       - Added: If player takes more than 3 seconds to choose a game mode,
'         a brief description is shown on the screen.
'       - Added: Quick end screen animation.
'       - Countdown to game start with "GET READY" on the screen.
'
$ExeIcon:'./shades.ico'
'Game constants -------------------------------------------------------
'General Use:
Const False = 0
Const True = Not False

'Game definitions:
Const BlockWidth = 150
Const BlockHeight = 64
Const ZENINCREMENT = 1
Const NORMALINCREMENT = 5
Const FLASHINCREMENT = 10
Const ZENMODE = 1
Const NORMALMODE = 2
Const FLASHMODE = 3
Const FILLMODE = 4

'Animations:
Const TopAnimationSteps = 15
Const MergeSteps = 32

'Colors:
Const MaxShades = 4

'Menu actions:
Const PLAYGAME = 3
Const PLAYFILL = 4
Const SETTINGSMENU = 5
Const LEAVEGAME = 7
Const SWITCHSOUND = 1
Const SWITCHMUSIC = 2
Const COLORSWITCH = 3
Const RESETHIGHSCORES = 4
Const MAINMENU = 5

'Misc:
Const FileID = "CLONEDSHADES"

'Type definitions: ----------------------------------------------------
Type ColorRGB
    R As Long
    G As Long
    B As Long
End Type

Type BoardType
    State As Long
    Shade As Long
End Type

Type SettingsFile
    ID As String * 13 '   CLONEDSHADES + CHR$(# of the latest version/beta with new .dat format)
    ColorMode As Long '0 = Automatic, 1 = Green, 2 = Orange, 3 = Blue, 4 = Pink
    SoundOn As _Byte
    MusicOn As _Byte
    HighscoreZEN As Long
    HighscoreNORMAL As Long
    HighscoreFLASH As Long
    HighscoreFILL As Long
End Type

'Variables ------------------------------------------------------------
'Variables for game control:
Dim Shared Board(1 To 12, 1 To 4) As BoardType
Dim Shared Shades(1 To 5) As ColorRGB, FadeStep As Long
Dim Shared BlockPos(1 To 4) As Long
Dim Shared BlockRows(1 To 12) As Long, BgImage As Long
Dim Shared i As Long, Increment As Long
Dim Shared CurrentRow As Long, CurrentColumn As Long
Dim Shared BlockPut As _Bit, Y As Long, PrevY As Long
Dim Shared CurrentShade As Long, NextShade As Long
Dim Shared AlignedWithRow As _Bit, InDanger As _Bit
Dim Shared GameOver As _Bit, GameEnded As _Bit
Dim Shared PreviousScore As Long, Score As Long
Dim Shared GlobalShade As Long, DemoMode As _Bit
Dim Shared AlertTimer As Long, TotalMerges As Long
Dim Shared TotalLines As Long, Setting As Long
Dim Shared InGame As _Byte, InitialIncrement As Long
Dim Shared GameMode As _Byte, InWatchOut As _Bit

'Variables for screen pages:
Dim Shared InfoScreen As Long
Dim Shared OverlayGraphics As Long
Dim Shared GameScreen As Long
Dim Shared MenuTip As Long
Dim Shared MainScreen As Long
Dim Shared UIWidth As Long
Dim Shared UIHeight As Long

'Variable for sound:
Dim Shared DropSound(1 To 3) As Long, Alarm As Long
Dim Shared LineSound As Long, SplashSound(1 To 4) As Long, Whistle As Long
Dim Shared BgMusic(1 To 4) As Long, GameOverSound As Long
Dim Shared ShockSound As Long

'Other variables
Dim Shared InMenu As _Bit, QuitGame As _Bit
Dim Shared Settings As SettingsFile
Dim Shared BackgroundColor As Long
Dim SettingChoice As Long

'Screen initialization: ------------------------------------------------
'Default window size is 600x800. If the desktop resolution is smaller
'than 900px tall, resize the UI while keeping the aspect ratio.
UIWidth = 600
UIHeight = 800
If InStr(_OS$, "WIN") Then
    If _Height(_ScreenImage) < 900 Then
        UIHeight = _Height(_ScreenImage) - 150
        UIWidth = UIHeight * .75
    End If
End If

InfoScreen = _NewImage(300, 400, 32)
OverlayGraphics = _NewImage(150, 200, 32)
GameScreen = _NewImage(600, 800, 32)
MainScreen = _NewImage(UIWidth, UIHeight, 32)

BgImage = _LoadImage("bg.png", 32)
If BgImage < -1 Then _DontBlend BgImage

BackgroundColor = _RGB32(170, 170, 170)

Screen MainScreen

_Title "Cloned Shades"

If BgImage < -1 Then _PutImage , BgImage, MainScreen

'Coordinates for block locations in the board: ------------------------
Restore BlockPositions
For i = 1 To 4
    Read BlockPos(i)
Next i

Restore RowCoordinates
For i = 1 To 12
    Read BlockRows(i)
Next i

InDanger = False
GameOver = False
GameEnded = False

'Read settings from file "shades.dat", if it exists: ------------------
If _FileExists("shades.dat") Then
    Open "shades.dat" For Binary As #1
    Get #1, , Settings
    Close #1
End If

If Settings.ID <> FileID + Chr$(7) Then
    'Invalid settings file or file doesn't exist: use defaults
    Settings.ID = FileID + Chr$(7)
    Settings.ColorMode = 0
    Settings.SoundOn = True
    Settings.MusicOn = True
    Settings.HighscoreZEN = 0
    Settings.HighscoreNORMAL = 0
    Settings.HighscoreFLASH = 0
    Settings.HighscoreFILL = 0
End If

'RGB data for shades: --------------------------------------------------
SelectGlobalShade

'Since now we already have read the shades' rgb data,
'let's generate the window icon (Windows only):
If InStr(_OS$, "WIN") Then MakeIcon

PrepareIntro

'Load sounds: ---------------------------------------------------------
LoadAssets

Intro

NextShade = _Ceil(Rnd * 3) 'Randomly chooses a shade for the next block

AlertTimer = _FreeTimer
On Timer(AlertTimer, .005) ShowAlert
Timer(AlertTimer) Off

_Dest GameScreen
If BgImage < -1 Then _PutImage , BgImage, GameScreen Else Cls , BackgroundColor
UpdateScreen

Randomize Timer

'Main game loop: ------------------------------------------------------
Do
    _KeyClear 'Clears keyboard buffer to avoid unwanted ESCs - Thanks, Steve.
    SelectGlobalShade
    Erase Board
    InitialIncrement = 1
    ReDim Choices(1 To 7) As String
    ReDim Info(1 To 7) As String
    ReDim Tips(1 To 7) As Long
    ReDim Tip(1 To 8) As String

    Choices(1) = "Cloned Shades" + Chr$(0)
    Choices(2) = " " + Chr$(0)
    Choices(3) = "Classic Mode"
    HighestOfHighest = Settings.HighscoreZEN
    If Settings.HighscoreNORMAL > HighestOfHighest Then HighestOfHighest = Settings.HighscoreNORMAL
    If Settings.HighscoreFLASH > HighestOfHighest Then HighestOfHighest = Settings.HighscoreFLASH
    If HighestOfHighest > 0 Then Info(3) = "Best: " + TRIM$(HighestOfHighest)
    Tips(3) = _NewImage(320, 130, 32)
    _Dest Tips(3)
    Line (0, 0)-(319, 129), _RGBA32(255, 255, 255, 235), BF
    Line (0, 0)-(319, 129), _RGB32(0, 0, 0), B
    Tip(1) = "Your goal in Classic Mode is to make"
    Tip(2) = "as many points as you can by merging"
    Tip(3) = "same color blocks and by creating"
    Tip(4) = "lines of four blocks of the same shade."
    Tip(5) = "There are three different skills to"
    Tip(6) = "choose from: ZEN, NORMAL and FLASH."
    Tip(8) = "Can you believe your eyes?"
    For i = 1 To UBound(Tip)
        If Len(Tip(i)) Then PrintShadow _Width(Tips(3)) \ 2 - _PrintWidth(Tip(i)) \ 2, (i - 1) * _FontHeight, Tip(i), _RGB32(0, 0, 0)
    Next i
    _Dest GameScreen

    Choices(4) = "Fill Mode"
    If Settings.HighscoreFILL > 0 Then Info(4) = "Best: " + TRIM$(Settings.HighscoreFILL)
    Tips(4) = _NewImage(400, 130, 32)
    _Dest Tips(4)
    Line (0, 0)-(399, 129), _RGBA32(255, 255, 255, 235), BF
    Line (0, 0)-(399, 129), _RGB32(0, 0, 0), B
    Tip(1) = "In Fill Mode you have to tweak your brain"
    Tip(2) = "to do the opposite of what you did in Classic:"
    Tip(3) = "now it's time to pile blocks up and avoid"
    Tip(4) = "merging them at all costs. If you happen"
    Tip(5) = "to forget your goal and end up connecting"
    Tip(6) = "them, an electric response is triggered."
    Tip(8) = "Do you have what it takes?"
    For i = 1 To UBound(Tip)
        If Len(Tip(i)) Then PrintShadow _Width(Tips(4)) \ 2 - _PrintWidth(Tip(i)) \ 2, (i - 1) * _FontHeight, Tip(i), _RGB32(0, 0, 0)
    Next i
    _Dest GameScreen

    Choices(5) = "Settings"
    Choices(6) = " " + Chr$(0)
    Choices(7) = "Quit"

    If Settings.MusicOn And BgMusic(1) Then _SndVol BgMusic(1), .2: _SndLoop BgMusic(1)
    Choice = Menu(3, 7, Choices(), Info(), Tips(), 3)
    Select Case Choice
        Case PLAYGAME
            ReDim Choices(1 To 6) As String
            ReDim Info(1 To 6) As String
            ReDim Tips(1 To 6) As Long

            Choices(1) = "SKILLS" + Chr$(0)
            Choices(2) = "Zen"
            If Settings.HighscoreZEN > 0 Then Info(2) = "Best: " + TRIM$(Settings.HighscoreZEN)
            Choices(3) = "Normal"
            If Settings.HighscoreNORMAL > 0 Then Info(3) = "Best: " + TRIM$(Settings.HighscoreNORMAL)
            Choices(4) = "Flash"
            If Settings.HighscoreFLASH > 0 Then Info(4) = "Best: " + TRIM$(Settings.HighscoreFLASH)
            Choices(5) = " " + Chr$(0)
            Choices(6) = "Go back"

            GameMode = 1 'Default = Zen mode
            Select Case Menu(2, 6, Choices(), Info(), Tips(), 3)
                Case 2: GameMode = ZENMODE: InitialIncrement = ZENINCREMENT
                Case 3: GameMode = NORMALMODE: InitialIncrement = NORMALINCREMENT
                Case 4: GameMode = FLASHMODE: InitialIncrement = FLASHINCREMENT
                Case 6: GameEnded = True
            End Select

            Erase Board
            Score = 0
            PreviousScore = -1
            TotalMerges = 0
            TotalLines = 0
            NextShade = _Ceil(Rnd * 3)
            RedrawBoard

            If Settings.MusicOn And BgMusic(1) Then _SndStop BgMusic(1)
            If Not GameEnded Then ShowGetReady 3
            If Settings.MusicOn And BgMusic(GameMode) Then _SndVol BgMusic(GameMode), .3: _SndLoop BgMusic(GameMode)

            InDanger = False
            InGame = True
            Do While Not GameOver And Not GameEnded
                GenerateNewBlock
                MoveBlock
                CheckDanger
                CheckMerge
                CheckConnectedLines
            Loop
            InGame = False
            If BgMusic(GameMode) Then _SndStop BgMusic(GameMode)
            If BgMusic(4) Then _SndStop BgMusic(4)
            If GameOver Then
                If Settings.SoundOn And GameOverSound Then _SndPlayCopy GameOverSound
                Select Case GameMode
                    Case ZENMODE: If Settings.HighscoreZEN < Score Then Settings.HighscoreZEN = Score
                    Case NORMALMODE: If Settings.HighscoreNORMAL < Score Then Settings.HighscoreNORMAL = Score
                    Case FLASHMODE: If Settings.HighscoreFLASH < Score Then Settings.HighscoreFLASH = Score
                End Select
                ShowEndScreen
            End If
            GameOver = False
            GameEnded = False
        Case PLAYFILL
            'Fill mode is actually just a hack. We play in ZENMODE conditions, but the points are
            'calculated differently. Also, DANGER mode displays a different message/color warning.
            GameMode = FILLMODE
            InitialIncrement = ZENINCREMENT

            Erase Board
            Score = 0
            PreviousScore = -1
            TotalMerges = 0
            TotalLines = 0
            NextShade = _Ceil(Rnd * 3)
            RedrawBoard

            If Settings.MusicOn And BgMusic(1) Then _SndStop BgMusic(1)
            ShowGetReady 3
            If Settings.MusicOn And BgMusic(ZENMODE) Then _SndVol BgMusic(ZENMODE), .3: _SndLoop BgMusic(ZENMODE)

            InDanger = False
            InGame = True
            If Settings.MusicOn And BgMusic(ZENMODE) Then
                If BgMusic(1) Then _SndStop BgMusic(1)
                _SndVol BgMusic(ZENMODE), .3: _SndLoop BgMusic(ZENMODE)
            End If
            Do While Not GameOver And Not GameEnded
                GenerateNewBlock
                MoveBlock
                CheckDanger
                CheckMerge
                CheckConnectedLines
            Loop
            InGame = False
            If BgMusic(ZENMODE) Then _SndStop BgMusic(ZENMODE)
            If BgMusic(4) Then _SndStop BgMusic(4)
            If GameOver Then
                If Settings.SoundOn And LineSound Then _SndPlayCopy LineSound
                If Settings.HighscoreFILL < Score Then Settings.HighscoreFILL = Score
                ShowEndScreen
            End If
            GameOver = False
            GameEnded = False
        Case SETTINGSMENU
            SettingChoice = 1
            Do
                ReDim Choices(1 To 5) As String
                ReDim Info(1 To 5) As String
                ReDim Tips(1 To 5) As Long
                If Settings.SoundOn Then Choices(1) = "Sound: ON" Else Choices(1) = "Sound: OFF"
                If Settings.MusicOn Then Choices(2) = "Music: ON" Else Choices(2) = "Music: OFF"
                Select Case Settings.ColorMode
                    Case 0: Choices(3) = "Color: AUTO"
                    Case 1: Choices(3) = "Color: GREEN"
                    Case 2: Choices(3) = "Color: ORANGE"
                    Case 3: Choices(3) = "Color: BLUE"
                    Case 4: Choices(3) = "Color: PINK"
                End Select
                Choices(4) = "Reset Highscores"
                HighestOfHighest = Settings.HighscoreZEN
                If Settings.HighscoreNORMAL > HighestOfHighest Then HighestOfHighest = Settings.HighscoreNORMAL
                If Settings.HighscoreFLASH > HighestOfHighest Then HighestOfHighest = Settings.HighscoreFLASH
                If Settings.HighscoreFILL > HighestOfHighest Then HighestOfHighest = Settings.HighscoreFILL
                If HighestOfHighest = 0 Then Choices(4) = Choices(4) + Chr$(0)

                Info(4) = "Can't be undone."
                Choices(5) = "Return"

                SettingChoice = Menu(SettingChoice, 5, Choices(), Info(), Tips(), 3)
                Select Case SettingChoice
                    Case SWITCHSOUND
                        Settings.SoundOn = Not Settings.SoundOn
                    Case SWITCHMUSIC
                        Settings.MusicOn = Not Settings.MusicOn
                        If Settings.MusicOn Then
                            If BgMusic(1) Then _SndLoop BgMusic(1)
                        Else
                            If BgMusic(1) Then _SndStop BgMusic(1)
                        End If
                    Case COLORSWITCH
                        Settings.ColorMode = Settings.ColorMode + 1
                        If Settings.ColorMode > 4 Then Settings.ColorMode = 0
                        SelectGlobalShade
                    Case RESETHIGHSCORES
                        ReDim Choices(1 To 2) As String
                        ReDim Info(1 To 2)
                        ReDim Tips(1 To 2) As Long
                        Choices(1) = "Reset"
                        Choices(2) = "Cancel"
                        If Menu(1, 2, Choices(), Info(), Tips(), 3) = 1 Then
                            Settings.HighscoreZEN = 0
                            Settings.HighscoreNORMAL = 0
                            Settings.HighscoreFLASH = 0
                            Settings.HighscoreFILL = 0
                            SettingChoice = SWITCHSOUND
                        End If
                End Select
            Loop Until SettingChoice = MAINMENU
        Case LEAVEGAME
            QuitGame = True
    End Select
Loop Until QuitGame

On Error GoTo DontSave
Open "shades.dat" For Binary As #1
Put #1, , Settings
Close #1

DontSave:
System

Greens:
Data 245,245,204
Data 158,255,102
Data 107,204,51
Data 58,153,0
Data 47,127,0

Oranges:
Data 255,193,153
Data 255,162,102
Data 255,115,26
Data 230,89,0
Data 128,49,0

Blues:
Data 204,229,255
Data 128,190,255
Data 26,138,255
Data 0,87,179
Data 0,50,102

Pinks:
Data 255,179,255
Data 255,128,255
Data 255,26,255
Data 179,0,178
Data 77,0,76

BlockPositions:
Data 0,151,302,453

RowCoordinates:
Data 735,670,605,540,475,410,345,280,215,150,85,20

'SUBs and FUNCTIONs ----------------------------------------------------

Sub GenerateNewBlock
    Dim LineSize As Long
    Dim LineStart As Long
    Dim LineEnd As Long
    Dim TargetLineStart As Long
    Dim TargetLineEnd As Long
    Dim LeftSideIncrement As Long
    Dim RightSideIncrement As Long

    'Randomly chooses where the next block will start falling down
    CurrentColumn = _Ceil(Rnd * 4)
    CurrentShade = NextShade

    'Randomly chooses the next shade. It is done at this point so
    'that the "next" bar will be displayed correctly across the game screen.
    NextShade = _Ceil(Rnd * 3)

    'Block's Y coordinate starts offscreen
    Y = -48: PrevY = Y

    If DemoMode Then Exit Sub

    'Animate the birth of a new block:
    If Whistle And Settings.SoundOn Then
        _SndPlayCopy Whistle
    End If

    LineSize = 600
    LineStart = 0
    LineEnd = 599
    TargetLineStart = (CurrentColumn * BlockWidth) - BlockWidth
    TargetLineEnd = CurrentColumn * BlockWidth
    LeftSideIncrement = (TargetLineStart - LineStart) / TopAnimationSteps
    RightSideIncrement = (LineEnd - TargetLineEnd) / TopAnimationSteps

    For i = 1 To TopAnimationSteps
        _Limit 120
        If BgImage < -1 Then _PutImage (0, 0)-(599, 15), BgImage, GameScreen, (0, 0)-(599, 15) Else Line (0, 0)-(599, 15), BackgroundColor, BF
        Line (LineStart, 0)-(LineEnd, 15), Shade&(CurrentShade), BF
        LineStart = LineStart + LeftSideIncrement
        LineEnd = LineEnd - RightSideIncrement
        If InKey$ <> "" Then Exit For
        UpdateScreen
    Next i
    If BgImage < -1 Then _PutImage (0, 0)-(599, 15), BgImage, GameScreen, (0, 0)-(599, 15) Else Line (0, 0)-(599, 15), BackgroundColor, BF
End Sub

Sub MoveBlock
    Dim MX As Long, MY As Long, MB As Long 'Mouse X, Y and Button

    Dim k$

    FadeStep = 0
    Increment = InitialIncrement
    If Not DemoMode Then BlockPut = False

    Do: _Limit 60
        'Before moving the block using Increment, check if the movement will
        'cause the block to move to another row. If so, check if such move will
        'cause to block to be put down.
        If ConvertYtoRow(Y + Increment) <> ConvertYtoRow(Y) And Not AlignedWithRow Then
            Y = BlockRows(ConvertYtoRow(Y))
            AlignedWithRow = True
        Else
            Y = Y + Increment
            AlignedWithRow = False
        End If

        CurrentRow = ConvertYtoRow(Y)

        If AlignedWithRow Then
            If CurrentRow > 1 Then
                If Board(CurrentRow - 1, CurrentColumn).State Then BlockPut = True
            ElseIf CurrentRow = 1 Then
                BlockPut = True
            End If
        End If

        If BlockPut Then
            If GameMode = FILLMODE Then Score = Score + 5 Else Score = Score + 2
            DropSoundI = _Ceil(Rnd * 3)
            If DropSound(DropSoundI) And Settings.SoundOn And Not DemoMode Then
                _SndPlayCopy DropSound(DropSoundI)
            End If
            Board(CurrentRow, CurrentColumn).State = True
            Board(CurrentRow, CurrentColumn).Shade = CurrentShade
        End If

        If Board(12, CurrentColumn).State = True And Board(12, CurrentColumn).Shade <> Board(11, CurrentColumn).Shade Then
            GameOver = True
            Exit Do
        End If

        'Erase previous block put on screen
        If BgImage < -1 Then
            _PutImage (BlockPos(CurrentColumn), PrevY)-(BlockPos(CurrentColumn) + BlockWidth, PrevY + Increment), BgImage, GameScreen, (BlockPos(CurrentColumn), PrevY)-(BlockPos(CurrentColumn) + BlockWidth, PrevY + Increment)
        Else
            Line (BlockPos(CurrentColumn), PrevY)-(BlockPos(CurrentColumn) + BlockWidth, PrevY + Increment), BackgroundColor, BF
        End If
        PrevY = Y

        'Show the next shade on the top bar unless in DemoMode
        If FadeStep < 255 And Not DemoMode Then
            FadeStep = FadeStep + 1
            Line (0, 0)-(599, 15), _RGBA32(Shades(NextShade).R, Shades(NextShade).G, Shades(NextShade).B, FadeStep), BF
        End If

        'Draw the current block
        Line (BlockPos(CurrentColumn), Y)-Step(BlockWidth, BlockHeight), Shade&(CurrentShade), BF

        UpdateScreen

        If Not DemoMode And Increment < BlockHeight Then k$ = InKey$

        'Emulate arrow keys if mouse was clicked+held+moved on screen
        'Code courtesy of Steve McNeill:
        While _MouseInput: Wend
        Static OldX, OldY
        MX = _MouseX: MY = _MouseY: MB = _MouseButton(1)


        If MB Then
            If Abs(OldX - MX) > 100 Then
                If OldX < MX Then k$ = Chr$(0) + Chr$(77) Else k$ = Chr$(0) + Chr$(75)
                OldX = MX
            End If
            If Abs(OldY - MY) > 100 Then
                If OldY < MY Then k$ = Chr$(0) + Chr$(80)
                OldY = MY
            End If
        Else
            OldX = MX
            OldY = MY
        End If

        Select Case k$
            Case Chr$(0) + Chr$(80) 'Down arrow
                Increment = BlockHeight
            Case Chr$(0) + Chr$(75) 'Left arrow
                If CurrentColumn > 1 Then
                    If Board(CurrentRow, CurrentColumn - 1).State = False Then
                        If BgImage < -1 Then _PutImage (BlockPos(CurrentColumn), Y)-(BlockPos(CurrentColumn) + BlockWidth, Y + BlockHeight), BgImage, GameScreen, (BlockPos(CurrentColumn), Y)-(BlockPos(CurrentColumn) + BlockWidth, Y + BlockHeight) Else Line (BlockPos(CurrentColumn), Y)-(BlockPos(CurrentColumn) + BlockWidth, Y + BlockHeight), BackgroundColor, BF
                        CurrentColumn = CurrentColumn - 1
                    End If
                End If
            Case Chr$(0) + Chr$(77) 'Right arrow
                If CurrentColumn < 4 Then
                    If Board(CurrentRow, CurrentColumn + 1).State = False Then
                        If BgImage < -1 Then _PutImage (BlockPos(CurrentColumn), Y)-(BlockPos(CurrentColumn) + BlockWidth, Y + BlockHeight), BgImage, GameScreen, (BlockPos(CurrentColumn), Y)-(BlockPos(CurrentColumn) + BlockWidth, Y + BlockHeight) Else Line (BlockPos(CurrentColumn), Y)-(BlockPos(CurrentColumn) + BlockWidth, Y + BlockHeight), BackgroundColor, BF
                        CurrentColumn = CurrentColumn + 1
                    End If
                End If
            Case Chr$(27)
                If GameMode <> FILLMODE Then
                    If BgMusic(GameMode) Then _SndStop BgMusic(GameMode)
                Else
                    If BgMusic(ZENMODE) Then _SndStop BgMusic(ZENMODE)
                End If
                If BgMusic(4) Then _SndStop BgMusic(4)
                ReDim Choices(1 To 2) As String
                ReDim Info(1 To 2) As String
                ReDim Tips(1 To 2) As Long
                Choices(1) = "Quit"
                Choices(2) = "Resume"
                If Menu(1, 2, Choices(), Info(), Tips(), 3) = 1 Then
                    GameEnded = True
                Else
                    If GameMode <> FILLMODE Then
                        If Settings.MusicOn And BgMusic(GameMode) And Not InDanger Then _SndLoop BgMusic(GameMode)
                        If Settings.MusicOn And BgMusic(4) And InDanger Then _SndLoop BgMusic(4)
                    Else
                        If Settings.MusicOn And BgMusic(ZENMODE) And Not InDanger Then _SndLoop BgMusic(ZENMODE)
                        If Settings.MusicOn And BgMusic(4) And InDanger Then _SndLoop BgMusic(4)
                    End If
                End If
                RedrawBoard
                'CASE " "
                '    GameOver = True
        End Select
        If DemoMode Then Exit Sub
    Loop Until BlockPut Or GameEnded Or GameOver
End Sub

Sub CheckMerge
    'Check if a block merge will be required:
    Dim YStep As Long, AnimationLimit As Long
    Dim WatchOutColor As _Bit, PreviousDest As Long
    Dim DangerMessage$

    Merged = False

    AnimationLimit = 60 'Default for NORMALINCREMENT
    Select Case InitialIncrement
        Case ZENINCREMENT: AnimationLimit = 30
        Case FLASHINCREMENT: AnimationLimit = 90
    End Select

    If BlockPut And CurrentRow > 1 Then
        Do
            If Board(CurrentRow, CurrentColumn).Shade = Board(CurrentRow - 1, CurrentColumn).Shade Then
                'Change block's color and the one touched to a darker shade, if it's not the darkest yet
                If GameMode = FILLMODE Then Score = Score - 5 - CurrentShade * 2 Else Score = Score + CurrentShade * 2
                If Score < 0 Then Score = 0
                If CurrentShade < 5 Then
                    Merged = True
                    TotalMerges = TotalMerges + 1
                    i = CurrentShade
                    RStep = (Shades(i).R - Shades(i + 1).R) / MergeSteps
                    GStep = (Shades(i).G - Shades(i + 1).G) / MergeSteps
                    BStep = (Shades(i).B - Shades(i + 1).B) / MergeSteps
                    YStep = (BlockHeight) / MergeSteps

                    RToGo = Shades(i).R
                    GToGo = Shades(i).G
                    BToGo = Shades(i).B

                    ShrinkingHeight = BlockHeight * 2

                    If SplashSound(CurrentShade) And Settings.SoundOn And Not DemoMode And Not GameMode = FILLMODE Then
                        _SndPlayCopy SplashSound(CurrentShade)
                    ElseIf Settings.SoundOn And GameMode = FILLMODE Then
                        If ShockSound Then _SndPlayCopy ShockSound
                    End If

                    For Merge = 0 To MergeSteps: _Limit AnimationLimit
                        RToGo = RToGo - RStep
                        GToGo = GToGo - GStep
                        BToGo = BToGo - BStep

                        ShrinkingHeight = ShrinkingHeight - YStep

                        If BgImage < -1 Then
                            _PutImage (BlockPos(CurrentColumn), BlockRows(CurrentRow))-(BlockPos(CurrentColumn) + BlockWidth, BlockRows(CurrentRow) + BlockHeight * 2 + 1), BgImage, GameScreen, (BlockPos(CurrentColumn), BlockRows(CurrentRow))-(BlockPos(CurrentColumn) + BlockWidth, BlockRows(CurrentRow) + BlockHeight * 2 + 1)
                        Else
                            Line (BlockPos(CurrentColumn), BlockRows(CurrentRow))-Step(BlockWidth, BlockHeight * 2 + 1), BackgroundColor, BF
                        End If

                        'Draw the merging blocks:
                        Line (BlockPos(CurrentColumn), BlockRows(CurrentRow) + (BlockHeight * 2) - ShrinkingHeight - 1)-Step(BlockWidth, ShrinkingHeight + 2), _RGB32(RToGo, GToGo, BToGo), BF
                        If GameMode = FILLMODE Then
                            InWatchOut = True
                            PreviousDest = _Dest
                            _Dest OverlayGraphics
                            If WatchOutColor Then Cls , _RGB(255, 255, 0) Else Cls , _RGBA32(0, 0, 0, 100)
                            WatchOutColor = Not WatchOutColor
                            DangerMessage$ = "WATCH OUT!"
                            PrintShadow _Width \ 2 - _PrintWidth(DangerMessage$) \ 2, _Height \ 2 - _FontHeight \ 2, DangerMessage$, _RGB32(255, 255, 255)
                            _Dest PreviousDest
                        End If
                        UpdateScreen
                    Next Merge
                    InWatchOut = False

                    Board(CurrentRow, CurrentColumn).State = False
                    Board(CurrentRow - 1, CurrentColumn).Shade = i + 1
                Else
                    Exit Do
                End If
            Else
                Exit Do
            End If
            CurrentRow = CurrentRow - 1
            CurrentShade = CurrentShade + 1
            Y = BlockRows(CurrentRow)
            PrevY = Y
            CheckDanger
        Loop Until CurrentRow = 1 Or CurrentShade = 5
    End If
    _KeyClear
End Sub

Sub CheckConnectedLines
    'Check for connected lines with the same shade and
    'compute the new score, besides generating the disappearing
    'animation:
    Dim WatchOutColor As _Bit, PreviousDest As Long
    Dim DangerMessage$

    Matched = False
    Do
        CurrentMatch = CheckMatchingLine%
        If CurrentMatch = 0 Then Exit Do

        Matched = True
        If GameMode = FILLMODE Then Score = Score - 40 Else Score = Score + 40
        If Score < 0 Then Score = 0

        MatchLineStart = BlockRows(CurrentMatch) + BlockHeight \ 2

        If LineSound And Settings.SoundOn And Not DemoMode And Not GameMode = FILLMODE Then
            _SndPlayCopy LineSound
        ElseIf Settings.SoundOn And GameMode = FILLMODE Then
            If ShockSound Then _SndPlayCopy ShockSound
        End If

        For i = 1 To BlockHeight \ 2
            _Limit 60
            If BgImage < -1 Then
                _PutImage (0, MatchLineStart - i)-(599, MatchLineStart + i), BgImage, GameScreen, (0, MatchLineStart - i)-(599, MatchLineStart + i)
            Else
                Line (0, MatchLineStart - i)-(599, MatchLineStart + i), BackgroundColor, BF
            End If
            If GameMode = FILLMODE Then
                InWatchOut = True
                PreviousDest = _Dest
                _Dest OverlayGraphics
                If WatchOutColor Then Cls , _RGB(255, 255, 0) Else Cls , _RGBA32(0, 0, 0, 100)
                WatchOutColor = Not WatchOutColor
                DangerMessage$ = "ARE YOU CRAZY?!"
                PrintShadow _Width \ 2 - _PrintWidth(DangerMessage$) \ 2, _Height \ 2 - _FontHeight \ 2, DangerMessage$, _RGB32(255, 255, 255)
                _Dest PreviousDest
            End If
            UpdateScreen
        Next i
        InWatchOut = False

        DestroyLine CurrentMatch
        TotalLines = TotalLines + 1
        RedrawBoard

        DropSoundI = _Ceil(Rnd * 3)
        If DropSound(DropSoundI) And Settings.SoundOn And Not DemoMode Then
            _SndPlayCopy DropSound(DropSoundI)
        End If
        If DemoMode Then DemoMode = False
    Loop
End Sub

Function ConvertYtoRow (CurrentY)
    'Returns the row on the board through which the block is currently
    'passing.

    If CurrentY >= -48 And CurrentY <= 20 Then
        ConvertYtoRow = 12
    ElseIf CurrentY > 20 And CurrentY <= 85 Then
        ConvertYtoRow = 11
    ElseIf CurrentY > 85 And CurrentY <= 150 Then
        ConvertYtoRow = 10
    ElseIf CurrentY > 150 And CurrentY <= 215 Then
        ConvertYtoRow = 9
    ElseIf CurrentY > 215 And CurrentY <= 280 Then
        ConvertYtoRow = 8
    ElseIf CurrentY > 280 And CurrentY <= 345 Then
        ConvertYtoRow = 7
    ElseIf CurrentY > 345 And CurrentY <= 410 Then
        ConvertYtoRow = 6
    ElseIf CurrentY > 410 And CurrentY <= 475 Then
        ConvertYtoRow = 5
    ElseIf CurrentY > 475 And CurrentY <= 540 Then
        ConvertYtoRow = 4
    ElseIf CurrentY > 540 And CurrentY <= 605 Then
        ConvertYtoRow = 3
    ElseIf CurrentY > 605 And CurrentY <= 670 Then
        ConvertYtoRow = 2
    ElseIf CurrentY > 670 And CurrentY <= 735 Then
        ConvertYtoRow = 1
    End If
End Function

Function ConvertXtoCol (CurrentX)
    'Returns the column on the board being currently hovered

    If CurrentX >= BlockPos(1) And CurrentX < BlockPos(2) Then
        ConvertXtoCol = 1
    ElseIf CurrentX >= BlockPos(2) And CurrentX < BlockPos(3) Then
        ConvertXtoCol = 2
    ElseIf CurrentX >= BlockPos(3) And CurrentX < BlockPos(4) Then
        ConvertXtoCol = 3
    ElseIf CurrentX >= BlockPos(4) Then
        ConvertXtoCol = 4
    End If
End Function


Function Shade& (CurrentShade)
    Shade& = _RGB32(Shades(CurrentShade).R, Shades(CurrentShade).G, Shades(CurrentShade).B)
End Function

Function CheckMatchingLine%

    Dim i As Long
    Dim a.s As Long, b.s As Long, c.s As Long, d.s As Long
    Dim a As Long, b As Long, c As Long, d As Long

    For i = 1 To 12
        a.s = Board(i, 1).State
        b.s = Board(i, 2).State
        c.s = Board(i, 3).State
        d.s = Board(i, 4).State

        a = Board(i, 1).Shade
        b = Board(i, 2).Shade
        c = Board(i, 3).Shade
        d = Board(i, 4).Shade

        If a.s And b.s And c.s And d.s Then
            If a = b And b = c And c = d Then
                CheckMatchingLine% = i
                Exit Function
            End If
        End If

    Next i
    CheckMatchingLine% = 0

End Function

Sub DestroyLine (LineToDestroy As Long)

    Dim i As Long
    Select Case LineToDestroy
        Case 1 To 11
            For i = LineToDestroy To 11
                Board(i, 1).State = Board(i + 1, 1).State
                Board(i, 2).State = Board(i + 1, 2).State
                Board(i, 3).State = Board(i + 1, 3).State
                Board(i, 4).State = Board(i + 1, 4).State

                Board(i, 1).Shade = Board(i + 1, 1).Shade
                Board(i, 2).Shade = Board(i + 1, 2).Shade
                Board(i, 3).Shade = Board(i + 1, 3).Shade
                Board(i, 4).Shade = Board(i + 1, 4).Shade
            Next i
            For i = 1 To 4
                Board(12, i).State = False
                Board(12, i).Shade = 0
            Next i
        Case 12
            For i = 1 To 4
                Board(12, i).State = False
                Board(12, i).Shade = 0
            Next i
    End Select

End Sub

Sub RedrawBoard
    Dim i As Long, CurrentColumn As Long
    Dim StartY As Long, EndY As Long

    If BgImage < -1 Then _PutImage , BgImage, GameScreen Else Cls , BackgroundColor

    For i = 1 To 12
        For CurrentColumn = 4 To 1 Step -1
            StartY = BlockRows(i)
            EndY = StartY + BlockHeight

            If Board(i, CurrentColumn).State = True Then
                Line (BlockPos(CurrentColumn), StartY)-(BlockPos(CurrentColumn) + BlockWidth, EndY), Shade&(Board(i, CurrentColumn).Shade), BF
            End If
        Next CurrentColumn
    Next i

End Sub

Sub ShowScore
    Dim ScoreString As String
    Dim ModeHighScore As Long

    If Score = PreviousScore Then Exit Sub
    PreviousScore = Score

    ScoreString = "Score:" + Str$(Score)

    Select Case GameMode
        Case ZENMODE: ModeHighScore = Settings.HighscoreZEN
        Case NORMALMODE: ModeHighScore = Settings.HighscoreNORMAL
        Case FLASHMODE: ModeHighScore = Settings.HighscoreFLASH
        Case FILLMODE: ModeHighScore = Settings.HighscoreFILL
    End Select

    _Dest InfoScreen
    Cls , _RGBA32(0, 0, 0, 0)

    '_FONT 16
    PrintShadow 15, 15, ScoreString, _RGB32(255, 255, 255)

    _Font 8
    If Score < ModeHighScore Then
        PrintShadow 15, 32, "Highscore: " + TRIM$(ModeHighScore), _RGB32(255, 255, 255)
    ElseIf Score > ModeHighScore And ModeHighScore > 0 Then
        PrintShadow 15, 32, "You beat the highscore!", _RGB32(255, 255, 255)
    End If
    _Font 16
    _Dest GameScreen

End Sub

Sub MakeIcon
    'Generates the icon that will be placed on the window title of the game
    Dim Icon As Long
    Dim PreviousDest As Long
    Dim i As Long
    Const IconSize = 16

    Icon = _NewImage(IconSize, IconSize, 32)
    PreviousDest = _Dest
    _Dest Icon

    For i = 1 To 5
        Line (0, i * (IconSize / 5) - (IconSize / 5))-(IconSize, i * (IconSize / 5)), Shade&(i), BF
    Next i

    _Icon Icon
    _FreeImage Icon

    _Dest PreviousDest
End Sub

Sub CheckDanger
    'Checks if any block pile is 11 blocks high, which
    'means danger, which means player needs to think faster,
    'which means we'll make him a little bit more nervous by
    'switching our soothing bg song to a fast paced circus
    'like melody.
    If Board(11, 1).State Or Board(11, 2).State Or Board(11, 3).State Or Board(11, 4).State Then
        If Settings.SoundOn And Not InDanger And Not DemoMode Then
            If Alarm Then _SndPlayCopy Alarm
            If Settings.MusicOn Then
                If GameMode <> FILLMODE Then
                    If BgMusic(GameMode) Then _SndStop BgMusic(GameMode)
                Else
                    If BgMusic(ZENMODE) Then _SndStop BgMusic(ZENMODE)
                End If
                If BgMusic(4) Then _SndLoop BgMusic(4)
            End If
            Timer(AlertTimer) On
        End If
        InDanger = True
    Else
        If Settings.MusicOn And InDanger And Not DemoMode Then
            If BgMusic(4) Then _SndStop BgMusic(4)
            If GameMode <> FILLMODE Then
                If BgMusic(GameMode) Then _SndLoop BgMusic(GameMode)
            Else
                If BgMusic(ZENMODE) Then _SndLoop BgMusic(ZENMODE)
            End If
            Timer(AlertTimer) Off
            _Dest OverlayGraphics
            Cls , _RGBA32(0, 0, 0, 0)
            _Dest GameScreen
        End If
        InDanger = False
    End If
End Sub

Sub LoadAssets
    'Loads sound files at startup.
    Dim i As _Byte

    LineSound = _SndOpen("line.ogg", "SYNC")
    GameOverSound = _SndOpen("gameover.ogg", "SYNC")
    Whistle = _SndOpen("whistle.ogg", "SYNC,VOL")
    If Whistle Then _SndVol Whistle, 0.02

    Alarm = _SndOpen("alarm.ogg", "SYNC")
    ShockSound = _SndOpen("shock.ogg", "SYNC")

    For i = 1 To 3
        If Not DropSound(i) Then DropSound(i) = _SndOpen("drop" + TRIM$(i) + ".ogg", "SYNC")
    Next i

    For i = 1 To 4
        If Not SplashSound(i) Then SplashSound(i) = _SndOpen("water" + TRIM$(i) + ".ogg", "SYNC")
    Next i

    BgMusic(1) = _SndOpen("Water_Prelude.ogg", "SYNC,VOL")
    BgMusic(2) = _SndOpen("Crowd_Hammer.ogg", "SYNC,VOL")
    BgMusic(3) = _SndOpen("Upbeat_Forever.ogg", "SYNC,VOL")
    BgMusic(4) = _SndOpen("quick.ogg", "SYNC,VOL")
    If BgMusic(1) Then _SndVol BgMusic(1), .2
    If BgMusic(4) Then _SndVol BgMusic(4), .8

End Sub

Sub UpdateScreen
    'Display the gamescreen, overlay and score layers
    If Not DemoMode Then ShowScore

    _PutImage , GameScreen, MainScreen
    If InMenu Or InDanger Or InWatchOut Then
        _PutImage , OverlayGraphics, MainScreen
        If MenuTip Then
            _PutImage (_Width(MainScreen) \ 2 - _Width(MenuTip) \ 2, _Height(MainScreen) \ 2 - _Height(MenuTip) \ 2), MenuTip, MainScreen
        End If
    End If

    If Not InMenu Then _PutImage , InfoScreen, MainScreen
    _Display
End Sub

Sub PrintShadow (x%, y%, Text$, ForeColor&)
    'Shadow:
    Color _RGBA32(170, 170, 170, 170), _RGBA32(0, 0, 0, 0)
    _PrintString (x% + 1, y% + 1), Text$

    'Text:
    Color ForeColor&, _RGBA32(0, 0, 0, 0)
    _PrintString (x%, y%), Text$
End Sub

Sub SelectGlobalShade
    If Settings.ColorMode = 0 Then
        GlobalShade = (GlobalShade) Mod MaxShades + 1
    Else
        GlobalShade = Settings.ColorMode
    End If
    Select Case GlobalShade
        Case 1: Restore Greens
        Case 2: Restore Oranges
        Case 3: Restore Blues
        Case 4: Restore Pinks
    End Select

    For i = 1 To 5
        Read Shades(i).R
        Read Shades(i).G
        Read Shades(i).B
    Next i

End Sub

Sub PrepareIntro
    'The intro shows the board about to be cleared,
    'which then happens after assets are loaded. The intro
    'is generated using the game engine.

    'DemoMode prevents sounds to be played
    DemoMode = True

    _Dest InfoScreen
    _Font 16
    LoadingMessage$ = "Cloned Shades"
    PrintShadow _Width \ 2 - _PrintWidth(LoadingMessage$) \ 2, _Height \ 2 - _FontHeight, LoadingMessage$, _RGB32(255, 255, 255)

    _Font 8
    LoadingMessage$ = "loading..."
    PrintShadow _Width \ 2 - _PrintWidth(LoadingMessage$) \ 2, _Height \ 2, LoadingMessage$, _RGB32(255, 255, 255)

    _Font 16
    _Dest GameScreen

    'Setup the board to show an "about to merge" group of blocks
    'which will end up completing a dark line at the bottom.
    Board(1, 1).State = True
    Board(1, 1).Shade = 5
    Board(1, 2).State = True
    Board(1, 2).Shade = 5
    Board(1, 3).State = True
    Board(1, 3).Shade = 4
    Board(1, 4).State = True
    Board(1, 4).Shade = 5
    Board(2, 3).State = True
    Board(2, 3).Shade = 3
    Board(3, 3).State = True
    Board(3, 3).Shade = 2
    Board(4, 3).State = True
    Board(4, 3).Shade = 2

    CurrentColumn = 3
    CurrentRow = 4
    CurrentShade = 2
    Y = BlockRows(CurrentRow)
    PrevY = Y
    BlockPut = True

    RedrawBoard
    Board(4, 3).State = False

    UpdateScreen
    If InStr(_OS$, "WIN") Then _ScreenMove _Middle
End Sub

Sub Intro
    'The current board setup must have been prepared using PrepareIntro first.

    'Use the game engine to show the intro:
    CheckMerge
    CheckConnectedLines

    'Clear the "loading..." text
    _Dest InfoScreen
    Cls , _RGBA32(0, 0, 0, 0)
    _Dest GameScreen

End Sub

Sub HighLightCol (Col As Long)

    _Dest OverlayGraphics
    Cls , _RGBA32(0, 0, 0, 0)
    Line (BlockPos(Col), 16)-Step(BlockWidth, _Height(0)), _RGBA32(255, 255, 255, 150), BF
    _Dest GameScreen

End Sub

Sub ShowAlert
    Static FadeLevel
    Dim DangerMessage$
    Dim PreviousDest As Long

    If InMenu Or InWatchOut Then Exit Sub

    If FadeLevel > 100 Then FadeLevel = 0
    FadeLevel = FadeLevel + 1
    PreviousDest = _Dest
    _Dest OverlayGraphics
    If GameMode = FILLMODE Then Cls , _RGBA32(0, 255, 0, FadeLevel) Else Cls , _RGBA32(255, 0, 0, FadeLevel)
    If GameMode = FILLMODE Then DangerMessage$ = "BE EXTRA CAREFUL!" Else DangerMessage$ = "DANGER!"
    PrintShadow _Width \ 2 - _PrintWidth(DangerMessage$) \ 2, _Height \ 2 - _FontHeight \ 2, DangerMessage$, _RGB32(255, 255, 255)
    _Dest PreviousDest
End Sub

Sub ShowGetReady (CountDown As _Byte)
    Dim Message$, i As _Byte, i$, iSnd As _Byte
    Dim PreviousDest As Long

    PreviousDest = _Dest
    DemoMode = True: InMenu = True
    _Dest OverlayGraphics
    Message$ = "GET READY"
    For i = CountDown To 1 Step -1
        Cls , _RGBA32(255, 255, 255, 200)
        PrintShadow _Width \ 2 - _PrintWidth(Message$) \ 2, _Height \ 2 - _FontHeight \ 2, Message$, _RGB32(0, 0, 0)
        If i = 1 Then i$ = "GO!" Else i$ = TRIM$(i)
        PrintShadow _Width \ 2 - _PrintWidth(i$) \ 2, _Height \ 2 - _FontHeight \ 2 + _FontHeight, i$, Shade&(5)
        UpdateScreen
        iSnd = _Ceil(Rnd * 3): If DropSound(iSnd) Then _SndPlayCopy DropSound(iSnd)
        _Delay .5
    Next i
    _Dest PreviousDest
    DemoMode = False: InMenu = False
End Sub

Function Menu (CurrentChoice As _Byte, MaxChoice As _Byte, Choices() As String, Info() As String, Tips() As Long, TipTime As Double)
    'Displays Choices() on the screen and lets the player choose one.
    'Uses OverlayGraphics page to display options.
    'Player must use arrow keys to make a choice then ENTER.

    Dim Choice As _Byte, PreviousChoice As _Byte
    Dim ChoiceWasMade As _Bit
    Dim k$, i As Long
    Dim ChooseColorTimer As Long
    Dim ItemShade As Long
    Dim ThisItemY As Long
    Dim ThisTime As Double, StartTime As Double, TipShown As _Bit

    DemoMode = True
    InMenu = True
    Choice = CurrentChoice

    If Not InGame Then
        ChooseColorTimer = _FreeTimer
        On Timer(ChooseColorTimer, 3.5) SelectGlobalShade
        Timer(ChooseColorTimer) On
    End If

    If Not InGame Then Erase Board: BlockPut = True

    StartTime = Timer
    Do
        _Limit 30

        'Use the game engine while the menu is displayed, except while InGame:
        If Not InGame Then
            If BlockPut Then
                GenerateNewBlock: BlockPut = False
            Else
                MoveBlock
            End If
        End If

        GoSub ShowCurrentChoice
        ThisTime = Timer
        If ThisTime - StartTime >= TipTime And Not TipShown Then
            'TipTime has passed since the user selected the current choice, so
            'if Tips(Choice) contains an image, it is _PUTIMAGEd on the screen.
            If Tips(Choice) < -1 Then
                MenuTip = Tips(Choice)
                TipShown = True
            End If
        End If

        k$ = InKey$
        Select Case k$
            Case Chr$(0) + Chr$(80) 'Down arrow
                Do
                    Choice = (Choice) Mod MaxChoice + 1
                Loop While Right$(Choices(Choice), 1) = Chr$(0)
                StartTime = Timer
                TipShown = False
                MenuTip = False
            Case Chr$(0) + Chr$(72) 'Up arrow
                Do
                    Choice = (Choice + MaxChoice - 2) Mod MaxChoice + 1
                Loop While Right$(Choices(Choice), 1) = Chr$(0)
                StartTime = Timer
                TipShown = False
                MenuTip = False
            Case Chr$(13) 'Enter
                ChoiceWasMade = True
                MenuTip = False
            Case Chr$(27) 'ESC
                ChoiceWasMade = True
                Choice = MaxChoice
        End Select
    Loop Until ChoiceWasMade

    If Not InGame Then Timer(ChooseColorTimer) Free
    InMenu = False
    DemoMode = False
    _Dest OverlayGraphics
    Cls , _RGBA32(255, 255, 255, 100)
    _Dest GameScreen

    MenuTip = False
    For i = 1 To MaxChoice
        If Tips(i) < -1 Then _FreeImage Tips(i)
    Next i

    Menu = Choice
    Exit Function

    ShowCurrentChoice:
    If Choice = PreviousChoice Then Return
    _Dest OverlayGraphics
    Cls , _RGBA32(255, 255, 255, 100)

    'Choices ending with CHR$(0) are shown as unavailable/grey.
    ThisItemY = (_Height(OverlayGraphics) / 2) - (((_FontHeight * MaxChoice) + _FontHeight) / 2)
    For i = 1 To MaxChoice
        ThisItemY = ThisItemY + _FontHeight
        If i = Choice Then
            ItemShade = Shade&(5)
            PrintShadow (_Width(OverlayGraphics) \ 2) - (_PrintWidth("> " + Choices(i)) \ 2), ThisItemY, Chr$(16) + Choices(i), ItemShade
        Else
            If Right$(Choices(i), 1) = Chr$(0) Then
                ItemShade = _RGB32(255, 255, 255)
                PrintShadow (_Width(OverlayGraphics) \ 2) - (_PrintWidth(Left$(Choices(i), Len(Choices(i)) - 1)) \ 2), ThisItemY, Left$(Choices(i), Len(Choices(i)) - 1), ItemShade
            Else
                ItemShade = Shade&(4)
                PrintShadow (_Width(OverlayGraphics) \ 2) - (_PrintWidth(Choices(i)) \ 2), ThisItemY, Choices(i), ItemShade
            End If
        End If
        If Len(Info(i)) And i = Choice Then
            _Font 8
            Color Shade&(5)
            _PrintString ((_Width(OverlayGraphics) \ 2) - (_PrintWidth(Info(i)) \ 2), _Height(OverlayGraphics) - 8), Info(i)
            _Font 16
        End If
    Next i
    _Dest GameScreen
    UpdateScreen
    PreviousChoice = Choice
    Return

End Function

Sub ShowEndScreen
    Dim Message$(1 To 10), k$, i As Long
    Dim MessageColor As Long

    If InDanger Then
        Timer(AlertTimer) Off
        InDanger = False
    End If

    _Dest OverlayGraphics
    Cls , _RGBA32(255, 255, 255, 150)

    If GameMode = FILLMODE And Score > 0 Then Message$(1) = "YOU WIN!" Else Message$(1) = "GAME OVER"
    Message$(3) = "Your score:"
    Message$(4) = TRIM$(Score)
    Message$(5) = "Merged blocks:"
    Message$(6) = TRIM$(TotalMerges)
    Message$(7) = "Lines destroyed:"
    Message$(8) = TRIM$(TotalLines)
    Message$(10) = "Press ENTER..."

    MessageColor = Shade&(5)
    For i = 1 To UBound(Message$)
        If i > 1 Then _Font 8: MessageColor = _RGB(0, 0, 0)
        If i = UBound(Message$) Then _Font 16: MessageColor = Shade&(5)
        PrintShadow (_Width(OverlayGraphics) \ 2) - (_PrintWidth(Message$(i)) \ 2), i * 16, Message$(i), MessageColor
    Next i

    _Dest MainScreen

    For i = 1 To _Height(MainScreen) / 2 Step BlockHeight / 2
        _Limit 60
        _PutImage , GameScreen
        _PutImage (0, _Height(MainScreen) / 2 - i)-(599, _Height(MainScreen) / 2 + i), OverlayGraphics
        _Display
    Next i

    _PutImage , GameScreen
    _PutImage , OverlayGraphics
    _Display
    _Dest GameScreen

    _KeyClear
    k$ = "": While k$ <> Chr$(13): _Limit 30: k$ = InKey$: Wend

End Sub

Function TRIM$ (Number)
    TRIM$ = LTrim$(RTrim$(Str$(Number)))
End Function

