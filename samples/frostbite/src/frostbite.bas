'Frosbite Tribute
'A clone of Frostbite for the Atari 2600, originally designed
'by Steve Cartwright and published by Activision in 1983.
'
'Fellippe Heitor / @FellippeHeitor / fellippeheitor@gmail.com
'
' - Beta 1: (November 30th, 2015)
'    - Screen layout, with aurora and logo on the bottom.
'    - Ripped hero sprites from youtube gameplays.
'    - Can move around, jump up and down. Still walks on
'      water, though.
'
' - Beta 2: (December 1st, 2015)
'    - Primitive ice blocks are around, and our hero moves
'      along with them.
'    - Blocks are mirrored on the other side when they go
'      offscreen. However, until they are reset on screen,
'      the mirrored blocks aren't "seen" by the code, yet.
'    - Very basic detection of landing safely, to see if
'      the hero will drown.
'    - Drowning/losing lives.
'    - Scores for ice blocks the hero steps on.
'
' - Beta 3: (December 2nd, 2015)
'    - Ripped audio effects. Not required for gameplay, though.
'    - Added a .MirroredPosition variable to IceRows, which
'      now allows the hero to step on any ice block he sees
'      fit.
'    - When temperature reaches 0 degrees, hero loses a life by
'      freezing to death.
'    - Moved drawing routines to subprocedures, to make reading
'      easier.
'
' - Beta 4: (December 3rd 2015)
'    - More code beautification.
'    - Spritesheet no longer necessary; sprites are now created
'      on the fly with pixel data READ from DATA statements
'      (I decided to do so after seeing some code from TrialAndTerror).
'    - WE NOW HAVE AN IGLOO!! With every ice block the Hero steps on
'      a new block is placed on his brand new igloo. After the igloo
'      is finished (that's when the door is placed = 16 ice blocks)
'      the Hero must enter the igloo to end the level.
'    - You can use SPACEBAR to change ice blocks direction, however
'      that'll cost you a piece of your igloo.
'    - Upon entering the igloo, the level is complete. Scores are then
'      calculated. New sound effects are used for that.
'
' - Beta 5: (December 8th, 2015)
'    - Fixed: Temperature timer wasn't reset after setting a new level.
'    - Added: Different block types: DOUBLEBLOCK and MOVINGBLOCK, which can
'      be seen from level 2 onward.
'    - Improved aurora simulation, to better mimick the original game.
'    - Ice blocks now look more like in the original game.
'    - Creatures (fish, birds, crabs and clams) came to life and the
'      hero must now avoid them, except for fish. Fish are good.
'
' - Beta 6 (July 24th, 2016)
'    - Fixed a bug that caused the hero to have infinite lives (thanks
'      to Luke for pointing that out).
'    - Hero earns an extra life every 5,000 points. Lives don't go
'      past a total of 9, for reasons of ATARI. :-)
'    - Fixed: Ice row widths were being wrongly calculated for DOUBLEBLOCK
'      and MOVINGBLOCK.
'    - There is now a day and a night. When the night falls and the Hero
'      finishes building a block, there'll be the flickering of a light
'      source coming from inside the igloo.
'    - Sound files have been embedded into the code, so that they are
'      saved to disk every time the game is run. No more having to
'      download separate files (code adapted from Dav's Qbasic Site,
'      as seen here: http://www.qbasicnews.com/dav/files/basfile.bas)
'    - Aquatic creatures now actually enter the water.
'
'Intended:
' - Fix random level features after level 9 (must be randomized only
'   after a new level is set.
' - Fix bad guys inverting ice row direction when the hero is almost
'   falling off (which makes it take much longer for death)
' - Add a bear.
' - Add CRABs and CLAMs
' - Make creatures faster than ice rows.
' - Add crabs/clams paused movement
' - Make constant speed increase.
'
$Resize:Smooth

$Let INTERNALBUILD = FALSE

'Game constants: --------------------------------------------------------------
Const True = -1
Const False = Not True

'Block types
Const SINGLEBLOCK = 1
Const DOUBLEBLOCK = 2
Const MOVINGBLOCK = 3

'Directions
Const MOVINGLEFT = -1
Const MOVINGRIGHT = 1
Const STOPPED = 0

'Actions
Const WALKING = 1
Const JUMPINGUP = 2
Const JUMPINGDOWN = 3
Const FREEZING = 4
Const DROWNING = 5
Const ENTERINGIGLOO = 6
Const EATINGFISH = 7

'Light conditions/Palette selection
Const DAY = 1
Const NIGHT = 2

Const GROUND = 1
Const SKY = 2
Const BEAR = 3

'Creatures
Const BIRD = 1
Const FISH = 2
Const CRAB = 4
Const CLAM = 8

'Colors
Const UnsteppedBlockColor = _RGB32(208, 208, 208)
Const SteppedBlockColor = _RGB32(73, 134, 213)
Const IglooBlockColor = _RGB32(136, 136, 136)
Const LightInsideColor = _RGB32(217, 134, 69)

'Misc:
Const GAMESTART = -1
Const NEXTLEVEL = 0

Const ONEUPGOAL = 5000

Const FIRST = 48
Const SECOND = 12
Const THIRD = 3

Const HeroStartRow = 95
Const HeroHeight = 36
Const HeroWidth = 30
Const DoorX = 276
Const MaxSpaceBetween = 15

Const InitialTemperature = 45

'Type definitions: ------------------------------------------------------------
Type RowInfo
    Position As Integer
    MirroredPosition As Integer
    Direction As Integer
    State As _Byte ' True when row has been stepped on
End Type

Type CreaturesInfo
    Species As Integer
    X As Integer
    Y As Single
    Direction As Integer
    Number As Integer
    Spacing As Integer
    RowWidth As Integer
    State As _Byte 'Indicates fish in row (11) or fish eaten (00) as in &B110011 = fish, no fish, fish
    Frame As _Byte
End Type

Type HeroInfo
    CurrentRow As Integer
    X As Integer
    Y As Integer
    Direction As Integer
    Face As Integer
    Action As Integer
    Grabbed As _Byte
    Frame As _Byte
End Type

Type LevelInfo
    Speed As Single
    BlockType As _Byte
    CreaturesAllowed As _Byte
End Type

'Game variables: --------------------------------------------------------------
Dim Shared ActualLevel As Integer
Dim Shared AnimationStep As Integer
Dim Shared Aurora(1 To 7) As Long
Dim Shared AuroraH As Integer
Dim Shared IceRows(1 To 4) As Integer
Dim Shared Creatures(1 To 4) As CreaturesInfo
Dim Shared CreatureSprite As Long
Dim Shared CreatureWidth(1 To 8) As Integer
Dim Shared CreditsBarH As Integer
Dim Shared CreditsIMG As Long, CreditY As Integer
Dim Shared FishPoints As Integer
Dim Shared FishSprites(1 To 2) As Long
Dim Shared FramesTimer As Integer
Dim Shared GameBG As Long
Dim Shared GameOver As _Bit
Dim Shared GameScreen As Long
Dim Shared GroundH As Integer
Dim Shared Hero As HeroInfo
Dim Shared HeroFreezingSprite As Long
Dim Shared HeroSprites(1 To 4) As Long
Dim Shared BirdSprites(1 To 2) As Long
Dim Shared IceRow(1 To 4) As RowInfo
Dim Shared IglooPieces As Integer
Dim Shared InGame As _Byte
Dim Shared JustLanded As _Bit
Dim Shared LevelComplete As _Bit
Dim Shared Lives As Integer
Dim Shared MainScreen As Long
Dim Shared MaxLevelCreatures As Integer
Dim Shared NextGoal As Long
Dim Shared NewLevelSet As Single
Dim Shared PointsInThisLevel As Integer
Dim Shared RestoreRowsTimer As Single
Dim Shared RowWidth As Single
Dim Shared Safe As Single
Dim Shared SceneryPalette(1 To 2, 1 To 3) As Long
Dim Shared Score As Long
Dim Shared SkyH As Integer
Dim Shared SpaceBetween As Single
Dim Shared Temperature As Integer
Dim Shared TempTimer As Integer
Dim Shared TimeOfDay As Integer
Dim Shared ThisAurora As Long
Dim Shared ThisLevel As Integer
Dim Shared ThisRowColor As Long
Dim Shared UserWantsToQuit As _Byte
Dim Shared WaterH As Integer

ReDim Shared Levels(0) As LevelInfo
ReDim Shared ThisLevelCreatures(0) As Integer

Dim i As Long

'Variables to hold sounds:
Dim Shared JumpSound As Long
Dim Shared BlockSound As Long
Dim Shared DrowningSound As Long
Dim Shared IglooBlockCountSound As Long
Dim Shared ScoreCountSound As Long
Dim Shared CollectFishSound As Long

'For testing/debugging purposes
$If INTERNALBUILD = TRUE Then
    DIM SHARED Frames AS _UNSIGNED LONG
    DIM SHARED RunStart AS DOUBLE
    RunStart = TIMER
$End If

'Game setup: ------------------------------------------------------------------
RestoreData
SetLevel GAMESTART
ScreenSetup
LoadAssets
SpritesSetup
SetTimers
NewLevelSet = 0

'Main game loop: --------------------------------------------------------------
Do
    CalculateScores
    NewLevelPause
    ComposeScenery
    DrawIgloo
    MoveIceBlocks
    MoveCreatures
    MoveHero
    CheckLanding
    CheckCreatures

    UpdateScreen

    If LevelComplete And IglooPieces > 0 Then _Delay .108
    If LevelComplete And IglooPieces = 0 And Temperature > 0 Then _Delay .05

    ReadKeyboard
    If Not LevelComplete Then _Delay .03
Loop Until UserWantsToQuit
System

'Game data: -------------------------------------------------------------------
AuroraPaletteDATA:
Data 207,199,87
Data 208,161,62
Data 199,141,54
Data 210,95,110
Data 183,101,193
Data 157,111,224
Data 120,116,237

SceneryPaletteDATA: 'Ground, sky and bear
Data 192,192,192,74,74,74
Data 23,68,185,0,36,149
Data 111,111,111,214,214,214

IceRowsDATA:
Data 134,173,212,251

CreaturesDATA:
Data 30,30,30,30

LevelsDATA:
Data 4
Data 1,1,1
Data 1,2,3
Data 1,3,7
Data 1.5,3,15

HeroPalette:
'Total colors, color values (_UNSIGNED LONG)
Data 5,0,4289225241,4291259443,4287072135,4288845861

Hero1:
Data 111111111111111111111111111111
Data 111111111111111111111111111111
Data 111122222222222111111111111111
Data 111122222222222111111111111111
Data 111122222222222222211111111111
Data 111122222222222222211111111111
Data 222222222222222222211111111111
Data 222222222222222222211111111111
Data 222222222222222222222222221111
Data 222222222222222222222222221111
Data 222222222222222222222222221111
Data 222222222222222222222222221111
Data 222222222222222222222222221111
Data 111133333333333333333311111111
Data 111133333333333333333311111111
Data 111133333333333333333333331111
Data 111133333333333333333333331111
Data 111111113333333333333311111111
Data 111111113333333333333311111111
Data 111144444444444444444411111111
Data 111144444444444444444411111111
Data 111144411114444444444444441111
Data 111144411114444444444444441111
Data 111144411114444444444444441111
Data 111144411111111444444444441111
Data 111144444441111444444444441111
Data 111144444441111111144444441111
Data 111144444444444111144444441111
Data 111144444444444111144444441111
Data 111144444444444444444444441111
Data 111111115555555111155555551111
Data 111111115555555111155555551111
Data 111111115555555111155555551111
Data 111111115555555111155555551111
Data 555555555555555555555555555555
Data 555555555555555555555555555555

Hero2:
Data 111122222222222111111111111111
Data 111122222222222111111111111111
Data 111122222222222222111111111111
Data 111122222222222222111111111111
Data 222222222222222222111111111111
Data 222222222222222222111111111111
Data 222222222222222222222222221111
Data 222222222222222222222222221111
Data 222222222222222222222222221111
Data 222222222222222222222222221111
Data 222222222222222222222222221111
Data 111133333333333333333311111111
Data 111133333333333333333311111111
Data 111133333333333333333333331111
Data 111133333333333333333333331111
Data 111111133333333333333311111111
Data 111111133333333333333311111111
Data 111144444444444444444411111111
Data 111144444444444444444411111111
Data 111144411114444444444444441111
Data 111144411114444444444444441111
Data 111144411111111444444444441111
Data 111144411111111444444444441111
Data 111144444444441111444444441111
Data 111144444444441111444444441111
Data 111144444444444444444444441111
Data 111144444444444444444444441111
Data 111144444444444444444444441111
Data 111111111115555555555511111111
Data 111111111115555555555511111111
Data 111111111115555555555511111111
Data 111111111115555555555511111111
Data 111111111115555555555511111111
Data 111111111115555555555511111111
Data 555555555555555555555555555555
Data 555555555555555555555555555555

Hero3:
Data 111112222222222211111111111111
Data 111112222222222211111111111111
Data 111112222222222222221111111111
Data 111112222222222222221111111111
Data 122222222222222222221111111111
Data 122222222222222222221111111111
Data 122222222222222222222222222111
Data 122222222222222222222222222111
Data 122222222222222222222222222111
Data 122222222222222222222222222111
Data 133333333333333333333333333111
Data 133333333333333333333333333111
Data 111113333333333333333333333111
Data 111113333333333333333333111111
Data 111111113333333333333333111111
Data 111114444444444444444444111111
Data 111114444444444444444444111111
Data 111114444111444444444444444411
Data 111114444111444444444444444411
Data 111114444111111111111111444411
Data 111114444111111111111111444411
Data 111114444444444444444444444411
Data 111114444444444444444444444411
Data 111114444444444444444444444411
Data 111114444444444444444444444411
Data 111111111111555551115555111111
Data 111115555555555555555555555511
Data 111115555555555555555555555511
Data 111115555555555555555555555511
Data 111111111111111111111111111111
Data 111111111111111111111111111111
Data 111111111111111111111111111111
Data 111111111111111111111111111111
Data 111111111111111111111111111111
Data 111111111111111111111111111111
Data 111111111111111111111111111111

Hero4:
Data 111111111111111111111111111111
Data 111111111111111111111111111111
Data 111111111111222222111111111111
Data 111111111222222222222111111111
Data 111111111222222222222111111111
Data 111111111222222222222111111111
Data 111111111222222222222111111111
Data 111111111222222222222111111111
Data 111222222222222222222222221111
Data 111222222222222222222222221111
Data 111222222222222222222222221111
Data 111222222222222222222222221111
Data 111222222222222222222222221111
Data 111111333333333333333331111111
Data 111111333333333333333331111111
Data 111111333333333333333331111111
Data 111111333333333333333331111111
Data 111111333333111113333331111111
Data 111111333333111113333331111111
Data 111111333333333333333334441111
Data 111111111444444444444114441111
Data 111114444444444444444114441111
Data 111444444444111444444114441111
Data 111444444444111444444444441111
Data 111444444444444444444444441111
Data 111444444444444444444444441111
Data 111444111444444444444444441111
Data 111444111444111444444441111111
Data 111444111444111444444441111111
Data 111444111444444444444441111111
Data 111111111555555555555111111111
Data 111111111555555555555111111111
Data 111111111555555555555111111111
Data 111111111555111115555111111111
Data 111555555555555555555555551111
Data 111555555555555555555555551111

BirdPalette:
Data 2,0,4286877948

Bird1:
Data 111111111111111111111111111111
Data 111111111111111111111122211111
Data 111111111111111111111122211111
Data 111111111111111111222222222211
Data 111111111111111111222222222211
Data 122222222222222222222211111111
Data 122222222222222222222211111111
Data 111122222222222222111111111111
Data 111111122222222222111111111111
Data 111111122222221111111111111111
Data 111122222222221111111111111111
Data 111122222221111111111111111111
Data 122222222221111111111111111111
Data 122222221111111111111111111111
Data 122222221111111111111111111111

Bird2:
Data 111111111111111111111111111111
Data 122222222222111111112222111111
Data 122222222222111111112222111111
Data 111111111222222211112222222211
Data 111111111222222211112222222211
Data 111111111222222211112222222211
Data 122222222222222222222222111111
Data 122222222222222222222222111111
Data 111112222222222222221111111111
Data 111112222222222222221111111111
Data 111112222222222222221111111111
Data 111111111222222211111111111111
Data 111111111222222211111111111111
Data 111112222111111111111111111111
Data 111112222111111111111111111111

FishPalette:
Data 2,0,4285518447

Fish1:
Data 111111111111111111111111111111
Data 111111111111111111111111111111
Data 122221111122222222221111111111
Data 122221111122222222221111111111
Data 122222221111122222222221111111
Data 122222222222222222222222221111
Data 111122222222222222221122221111
Data 111111112222222222222222221111
Data 111111112222222222222222221111
Data 111111112222222222222222221111
Data 111122222222222222222221111111
Data 122222222222222222222222221111
Data 122222221111122222222222221111
Data 122221111122222222221111111111
Data 122221111122222222221111111111

Fish2:
Data 111111111111111111111111111111
Data 111111111111111111111111111111
Data 111111111111122222111111111111
Data 111111111111122222111111111111
Data 222222211122222222222211111111
Data 222222222222222222222222211111
Data 222222222222222222111222211111
Data 111111222222222222222222211111
Data 111111222222222222222222211111
Data 111111222222222222222222211111
Data 222222222222222222222222211111
Data 222222222222222222222222211111
Data 222222211122222222222211111111
Data 111111111111122222111111111111
Data 111111111111122222111111111111

'------------------------------------------------------------------------------
'Subprocedures start here:
'------------------------------------------------------------------------------
Sub NewLevelPause
    If InGame Then Exit Sub
    If NewLevelSet <> 0 Then
        If Timer - NewLevelSet > 1 Then
            InGame = True
            Timer(TempTimer) On
            NewLevelSet = 0
        End If
    End If
End Sub

'------------------------------------------------------------------------------
Sub ComposeScenery
    Static TemperatureBlink As Integer

    'Game layers: Background, Aurora, Credits (bottom line)
    _PutImage , GameBG, GameScreen
    _PutImage (0, SkyH - AuroraH / 2), ThisAurora, GameScreen
    _PutImage (0, _Height(GameScreen) - CreditsBarH), CreditsIMG, GameScreen, (0, CreditY)-Step(_Width(CreditsIMG), CreditsBarH)

    'Score, temperature and lives:
    Color _RGB32(126, 148, 254), _RGBA32(0, 0, 0, 0)
    _PrintString (72 - (Len(TRIM$(Score)) * _FontWidth), 2), TRIM$(Score)

    Select Case Temperature
        Case 1 TO 5
            TemperatureBlink = TemperatureBlink + 1
            Select Case TemperatureBlink
                Case 7 TO 14
                    If Not LevelComplete And Not GameOver Then
                        Color _RGBA32(0, 0, 0, 0), _RGBA32(0, 0, 0, 0)
                    End If
                Case 15
                    TemperatureBlink = 0
            End Select
        Case Else
            TemperatureBlink = 0
    End Select
    _PrintString (40 - (Len(TRIM$(Temperature)) * _FontWidth), 14), TRIM$(Temperature) + Chr$(248)

    If Lives > 0 Then _PrintString (72 - (Len(TRIM$(Lives)) * _FontWidth), 14), TRIM$(Lives)

    '$IF INTERNALBUILD = TRUE THEN
    '    'Variable watch on screen, for debugging purposes:
    '    COLOR _RGB32(0, 0, 0), _RGBA32(255, 255, 255, 200)
    '    i = 0
    '    crd$ = "Frames=" + TRIM$(Frames) + " FPS=" + TRIM$(_CEIL(Frames / (TIMER - RunStart))): _PRINTSTRING (_WIDTH - (LEN(crd$) * _FONTWIDTH), i), crd$

    '    i = i + 8
    '    crd$ = "ThisLevel=" + TRIM$(ThisLevel): _PRINTSTRING (_WIDTH - (LEN(crd$) * _FONTWIDTH), i), crd$

    '    i = i + 8
    '    crd$ = "ActualLevel=" + TRIM$(ActualLevel): _PRINTSTRING (_WIDTH - (LEN(crd$) * _FONTWIDTH), i), crd$

    '    i = i + 8
    '    crd$ = "PointsInThisLevel=" + TRIM$(PointsInThisLevel): _PRINTSTRING (_WIDTH - (LEN(crd$) * _FONTWIDTH), i), crd$

    '    'FOR j = 1 TO 4
    '    '    i = i + 8
    '    '    crd$ = "Creatures(" + TRIM$(j) + ").species=" + TRIM$(Creatures(j).Species): _PRINTSTRING (_WIDTH - (LEN(crd$) * _FONTWIDTH), i), crd$
    '    'NEXT j
    '$END IF

End Sub

'------------------------------------------------------------------------------
Sub DrawIgloo
    Dim IglooBlink As _Bit
    Dim IglooDoorColor As _Unsigned Long

    If IglooPieces = 0 Then Exit Sub

    Select EveryCase IglooPieces
        Case Is > 0
            Line (232, 57)-Step(32, -9), IglooBlockColor, BF
        Case Is > 1
            Line (264, 57)-Step(32, -9), IglooBlockColor, BF
        Case Is > 2
            Line (296, 57)-Step(32, -9), IglooBlockColor, BF
        Case Is > 3
            Line (328, 57)-Step(32, -9), IglooBlockColor, BF
        Case Is > 4
            Line (328, 48)-Step(32, -9), IglooBlockColor, BF
        Case Is > 5
            Line (296, 48)-Step(32, -9), IglooBlockColor, BF
        Case Is > 6
            Line (264, 48)-Step(32, -9), IglooBlockColor, BF
        Case Is > 7
            Line (232, 48)-Step(32, -9), IglooBlockColor, BF
        Case Is > 8
            Line (232, 39)-Step(32, -9), IglooBlockColor, BF
        Case Is > 9
            Line (264, 39)-Step(32, -9), IglooBlockColor, BF
        Case Is > 10
            Line (296, 39)-Step(32, -9), IglooBlockColor, BF
        Case Is > 11
            Line (328, 39)-Step(32, -9), IglooBlockColor, BF
        Case Is > 12
            Line (248, 31)-Step(49, -9), IglooBlockColor, BF
        Case Is > 13
            Line (297, 31)-Step(49, -9), IglooBlockColor, BF
        Case Is > 14
            Line (265, 25)-Step(65, -9), IglooBlockColor, BF
        Case Is > 15
            IglooDoorColor = _RGB32(0, 0, 0)
            If TimeOfDay = NIGHT Then
                Randomize Timer
                IglooBlink = _Ceil(Rnd * 2) - 2
                If IglooBlink Then
                    IglooDoorColor = LightInsideColor
                End If
            End If
            Line (276, 57)-Step(35, -16), IglooDoorColor, BF
            Line (281, 43)-Step(25, -5), IglooDoorColor, BF
    End Select
End Sub

'------------------------------------------------------------------------------
Sub MoveIceBlocks
    Dim i As Integer
    Dim j As Integer
    Dim x As Integer
    Dim x.m As Integer
    Dim BlockLines As Integer

    'Ice blocks:
    For i = 1 To 4
        If Not IceRow(i).State Then ThisRowColor = UnsteppedBlockColor Else ThisRowColor = SteppedBlockColor

        If InGame And Hero.Action <> DROWNING And Hero.Action <> FREEZING And Hero.Action <> EATINGFISH And Not LevelComplete Then
            IceRow(i).Position = IceRow(i).Position + Levels(PointsInThisLevel).Speed * IceRow(i).Direction
            If IceRow(i).Direction = MOVINGRIGHT Then
                If IceRow(i).Position >= _Width(GameScreen) Then
                    IceRow(i).Position = 0
                    IceRow(i).MirroredPosition = 0
                End If
            End If
            If IceRow(i).Direction = MOVINGLEFT Then
                If IceRow(i).Position < -RowWidth Then
                    IceRow(i).Position = _Width(GameScreen) - 1 - RowWidth
                    IceRow(i).MirroredPosition = 0
                End If
            End If
        End If

        x = IceRow(i).Position

        Select Case Levels(ActualLevel).BlockType
            Case SINGLEBLOCK
                'Draw normal blocks
                For j = -8 To 8
                    BlockLines = j + _Ceil(Rnd(j) * 6)
                    Line (x + BlockLines, IceRows(i) - j)-Step(HeroWidth * 2, 0), ThisRowColor
                    Line (x + BlockLines + HeroWidth * 3.5, IceRows(i) - j)-Step(HeroWidth * 2, 0), ThisRowColor
                    Line (x + BlockLines + HeroWidth * 7, IceRows(i) - j)-Step(HeroWidth * 2, 0), ThisRowColor
                Next j

                If IceRow(i).Direction = MOVINGLEFT Then
                    If IceRow(i).Position < 0 Then
                        IceRow(i).MirroredPosition = _Width(GameScreen) + IceRow(i).Position
                    End If
                Else
                    If IceRow(i).Position + HeroWidth * 7 + HeroWidth * 2 > _Width(GameScreen) Then
                        IceRow(i).MirroredPosition = -_Width(GameScreen) + IceRow(i).Position
                    End If
                End If

                'Draw mirrored blocks
                If IceRow(i).MirroredPosition Then
                    x = IceRow(i).MirroredPosition
                    For j = -8 To 8
                        BlockLines = j + _Ceil(Rnd(j) * 6)
                        Line (x + BlockLines, IceRows(i) - j)-Step(HeroWidth * 2, 0), ThisRowColor
                        Line (x + BlockLines + HeroWidth * 3.5, IceRows(i) - j)-Step(HeroWidth * 2, 0), ThisRowColor
                        Line (x + BlockLines + HeroWidth * 7, IceRows(i) - j)-Step(HeroWidth * 2, 0), ThisRowColor
                    Next j
                End If
            Case DOUBLEBLOCK
                'Draw normal blocks
                For j = -8 To 8
                    BlockLines = j + _Ceil(Rnd(j) * 6)
                    Line (x + BlockLines, IceRows(i) - j)-Step(HeroWidth, 0), ThisRowColor
                    Line (x + BlockLines + HeroWidth * 1.5, IceRows(i) - j)-Step(HeroWidth, 0), ThisRowColor
                    Line (x + BlockLines + HeroWidth * 3, IceRows(i) - j)-Step(HeroWidth, 0), ThisRowColor
                    Line (x + BlockLines + HeroWidth * 4.5, IceRows(i) - j)-Step(HeroWidth, 0), ThisRowColor
                    Line (x + BlockLines + HeroWidth * 6, IceRows(i) - j)-Step(HeroWidth, 0), ThisRowColor
                    Line (x + BlockLines + HeroWidth * 7.5, IceRows(i) - j)-Step(HeroWidth, 0), ThisRowColor
                Next j

                If IceRow(i).Direction = MOVINGLEFT Then
                    If IceRow(i).Position < 0 Then
                        IceRow(i).MirroredPosition = _Width(GameScreen) + IceRow(i).Position
                    End If
                Else
                    If IceRow(i).Position + HeroWidth * 7 + HeroWidth * 2 > _Width(GameScreen) Then
                        IceRow(i).MirroredPosition = -_Width(GameScreen) + IceRow(i).Position
                    End If
                End If

                'Draw mirrored blocks
                If IceRow(i).MirroredPosition Then
                    x = IceRow(i).MirroredPosition
                    For j = -8 To 8
                        BlockLines = j + _Ceil(Rnd(j) * 6)
                        Line (x + BlockLines, IceRows(i) - j)-Step(HeroWidth, 0), ThisRowColor
                        Line (x + BlockLines + HeroWidth * 1.5, IceRows(i) - j)-Step(HeroWidth, 0), ThisRowColor
                        Line (x + BlockLines + HeroWidth * 3, IceRows(i) - j)-Step(HeroWidth, 0), ThisRowColor
                        Line (x + BlockLines + HeroWidth * 4.5, IceRows(i) - j)-Step(HeroWidth, 0), ThisRowColor
                        Line (x + BlockLines + HeroWidth * 6, IceRows(i) - j)-Step(HeroWidth, 0), ThisRowColor
                        Line (x + BlockLines + HeroWidth * 7.5, IceRows(i) - j)-Step(HeroWidth, 0), ThisRowColor
                    Next j
                End If
            Case MOVINGBLOCK
                'Draw normal blocks
                For j = -8 To 8
                    BlockLines = j + _Ceil(Rnd(j) * 6)
                    Line (x + BlockLines + SpaceBetween, IceRows(i) - j)-Step(HeroWidth, 0), ThisRowColor
                    Line (x + BlockLines + HeroWidth * 1.5 - SpaceBetween, IceRows(i) - j)-Step(HeroWidth, 0), ThisRowColor
                    Line (x + BlockLines + HeroWidth * 3 + SpaceBetween, IceRows(i) - j)-Step(HeroWidth, 0), ThisRowColor
                    Line (x + BlockLines + HeroWidth * 4.5 - SpaceBetween, IceRows(i) - j)-Step(HeroWidth, 0), ThisRowColor
                    Line (x + BlockLines + HeroWidth * 6 + SpaceBetween, IceRows(i) - j)-Step(HeroWidth, 0), ThisRowColor
                    Line (x + BlockLines + HeroWidth * 7.5 - SpaceBetween, IceRows(i) - j)-Step(HeroWidth, 0), ThisRowColor
                Next j

                If IceRow(i).Direction = MOVINGLEFT Then
                    If IceRow(i).Position < 0 Then
                        IceRow(i).MirroredPosition = _Width(GameScreen) + IceRow(i).Position
                    End If
                Else
                    If IceRow(i).Position + HeroWidth * 7 + HeroWidth * 2 > _Width(GameScreen) Then
                        IceRow(i).MirroredPosition = -_Width(GameScreen) + IceRow(i).Position
                    End If
                End If

                'Draw mirrored blocks
                If IceRow(i).MirroredPosition Then
                    x = IceRow(i).MirroredPosition
                    For j = -8 To 8
                        BlockLines = j + _Ceil(Rnd(j) * 6)
                        Line (x + BlockLines + SpaceBetween, IceRows(i) - j)-Step(HeroWidth, 0), ThisRowColor
                        Line (x + BlockLines + HeroWidth * 1.5 - SpaceBetween, IceRows(i) - j)-Step(HeroWidth, 0), ThisRowColor
                        Line (x + BlockLines + HeroWidth * 3 + SpaceBetween, IceRows(i) - j)-Step(HeroWidth, 0), ThisRowColor
                        Line (x + BlockLines + HeroWidth * 4.5 - SpaceBetween, IceRows(i) - j)-Step(HeroWidth, 0), ThisRowColor
                        Line (x + BlockLines + HeroWidth * 6 + SpaceBetween, IceRows(i) - j)-Step(HeroWidth, 0), ThisRowColor
                        Line (x + BlockLines + HeroWidth * 7.5 - SpaceBetween, IceRows(i) - j)-Step(HeroWidth, 0), ThisRowColor
                    Next j
                End If
        End Select
    Next i
End Sub

'------------------------------------------------------------------------------
Sub MoveCreatures
    Dim i As Integer
    Dim X As Integer
    Static Floating As Single
    Static FloatStep As Single

    If Not InGame Then Exit Sub

    If FloatStep = 0 Then FloatStep = .1

    'Four rows of creatures:
    For i = 1 To 4
        If Hero.Action <> DROWNING And Hero.Action <> FREEZING And Hero.Action <> EATINGFISH And Not LevelComplete Then
            If Hero.Grabbed And i = Hero.CurrentRow Then
                If Creatures(i).Direction = MOVINGRIGHT Then
                    If Creatures(i).X < _Width(GameScreen) - CreatureWidth(Creatures(i).Species) Then
                        Creatures(i).X = Creatures(i).X + (Levels(PointsInThisLevel).Speed * Creatures(i).Direction) + Creatures(i).Direction
                    End If
                ElseIf Creatures(i).Direction = MOVINGLEFT Then
                    If Creatures(i).X > 0 Then
                        Creatures(i).X = Creatures(i).X + (Levels(PointsInThisLevel).Speed * Creatures(i).Direction) + Creatures(i).Direction
                    End If
                End If
            Else
                Creatures(i).X = Creatures(i).X + (Levels(PointsInThisLevel).Speed * Creatures(i).Direction) + Creatures(i).Direction
            End If

            Floating = Floating + FloatStep
            If Floating > HeroHeight / 4 Then FloatStep = -.1
            If Floating <= 0 Then FloatStep = .1

            'Birds fly linearly. Other creatures are in water, and so they float:
            If Creatures(i).Species <> BIRD Then Creatures(i).Y = Creatures(i).Y + FloatStep

            'Once the creature row leaves screen, it is reset:
            If Creatures(i).Direction = MOVINGRIGHT Then
                If Creatures(i).X >= _Width(GameScreen) Then
                    Creatures(i).Species = 0
                End If
            End If
            If Creatures(i).Direction = MOVINGLEFT Then
                If Creatures(i).X < -Creatures(i).RowWidth Then
                    Creatures(i).Species = 0
                End If
            End If
        End If

        'if a creature has not yet been set (or just been cleared) for this row,
        'we'll generate a new one:
        If Creatures(i).Species = 0 Then MakeCreature i

        X = Creatures(i).X

        'IF X < -Creatures(i).RowWidth THEN EXIT SUB

        Select Case Creatures(i).Species
            Case BIRD: CreatureSprite = BirdSprites(Creatures(i).Frame)
            Case FISH: CreatureSprite = FishSprites(Creatures(i).Frame)
            Case CRAB: CreatureSprite = 0: text$ = "CRAB"
            Case CLAM: CreatureSprite = 0: text$ = "CLAM"
        End Select

        'First creature in row is always drawn at the same position:
        If Creatures(i).State And FIRST Then
            If CreatureSprite < -1 Then
                If Creatures(i).Direction = MOVINGRIGHT Then
                    _PutImage (X, Creatures(i).Y), CreatureSprite, GameScreen, (0, IIF(Creatures(i).Species <> BIRD, -Floating, 0))-Step(_Width(CreatureSprite), _Height(CreatureSprite))
                Else
                    _PutImage (X + CreatureWidth(Creatures(i).Species), Creatures(i).Y)-Step(-CreatureWidth(Creatures(i).Species) - 1, _Height(CreatureSprite) - 1), CreatureSprite, GameScreen, (0, IIF(Creatures(i).Species <> BIRD, -Floating, 0))-Step(_Width(CreatureSprite), _Height(CreatureSprite))
                End If
            Else
                Line (X, Creatures(i).Y)-Step(CreatureWidth(Creatures(i).Species), 8), _RGB32(255, 0, 0), BF
                _PrintString (X, Creatures(i).Y), text$
            End If
        End If

        'Second creature in row (position will be affected by Creatures().Spacing):
        If Creatures(i).Number > 1 And (Creatures(i).State And SECOND) Then
            If CreatureSprite < -1 Then
                If Creatures(i).Direction = MOVINGRIGHT Then
                    _PutImage (X + CreatureWidth(Creatures(i).Species) + Creatures(i).Spacing, Creatures(i).Y), CreatureSprite, GameScreen, (0, IIF(Creatures(i).Species <> BIRD, -Floating, 0))-Step(_Width(CreatureSprite), _Height(CreatureSprite))
                Else
                    _PutImage (X + CreatureWidth(Creatures(i).Species) + Creatures(i).Spacing + CreatureWidth(Creatures(i).Species), Creatures(i).Y)-Step(-CreatureWidth(Creatures(i).Species) - 1, _Height(CreatureSprite) - 1), CreatureSprite, GameScreen, (0, IIF(Creatures(i).Species <> BIRD, -Floating, 0))-Step(_Width(CreatureSprite), _Height(CreatureSprite))
                End If
            Else
                Line (X + CreatureWidth(Creatures(i).Species) + Creatures(i).Spacing, Creatures(i).Y)-Step(CreatureWidth(Creatures(i).Species), 8), _RGB32(255, 0, 0), BF
                _PrintString (X + CreatureWidth(Creatures(i).Species) + Creatures(i).Spacing, Creatures(i).Y), text$
            End If
        End If

        'Third creature in row (always at the same spot)
        If Creatures(i).Number = 3 And (Creatures(i).State And THIRD) Then
            If CreatureSprite < -1 Then
                If Creatures(i).Direction = MOVINGRIGHT Then
                    _PutImage (X + CreatureWidth(Creatures(i).Species) * 2 + Creatures(i).Spacing * 2, Creatures(i).Y), CreatureSprite, GameScreen, (0, IIF(Creatures(i).Species <> BIRD, -Floating, 0))-Step(_Width(CreatureSprite), _Height(CreatureSprite))
                Else
                    _PutImage (X + CreatureWidth(Creatures(i).Species) * 2 + Creatures(i).Spacing * 2 + CreatureWidth(Creatures(i).Species), Creatures(i).Y)-Step(-CreatureWidth(Creatures(i).Species) - 1, _Height(CreatureSprite) - 1), CreatureSprite, GameScreen, (0, IIF(Creatures(i).Species <> BIRD, -Floating, 0))-Step(_Width(CreatureSprite), _Height(CreatureSprite))
                End If
            Else
                Line (X + CreatureWidth(Creatures(i).Species) * 2 + Creatures(i).Spacing * 2, Creatures(i).Y)-Step(CreatureWidth(Creatures(i).Species), 8), _RGB32(255, 0, 0), BF
                _PrintString (X + CreatureWidth(Creatures(i).Species) * 2 + Creatures(i).Spacing * 2, Creatures(i).Y), text$
            End If
        End If
    Next i
End Sub

'------------------------------------------------------------------------------
Sub MakeCreature (RowNumber)
    'Randomly selects a new creature from the current level's array
    Dim NewCreature As Integer

    Randomize Timer
    NewCreature = _Ceil(Rnd * MaxLevelCreatures)
    Creatures(RowNumber).Species = ThisLevelCreatures(NewCreature)

    Do
        Creatures(RowNumber).Direction = Int(Rnd * 3) - 1
    Loop While Creatures(RowNumber).Direction = 0

    If ActualLevel <= 2 Then
        Creatures(RowNumber).Number = ActualLevel
    Else
        Creatures(RowNumber).Number = _Ceil(Rnd * 3)
    End If

    Select Case Creatures(RowNumber).Number
        Case 2: Creatures(RowNumber).Spacing = HeroWidth * 2.5
        Case 3: Creatures(RowNumber).Spacing = HeroWidth * 1
    End Select

    Creatures(RowNumber).RowWidth = (Creatures(RowNumber).Spacing + CreatureWidth(Creatures(RowNumber).Species) * Creatures(RowNumber).Number)

    Select Case Creatures(RowNumber).Direction
        Case MOVINGRIGHT
            Creatures(RowNumber).X = -Creatures(RowNumber).RowWidth - _Ceil(Rnd * 100)
        Case MOVINGLEFT
            Creatures(RowNumber).X = _Width(GameScreen) + _Ceil(Rnd * 100)
    End Select

    If Creatures(RowNumber).Species = BIRD Then
        Creatures(RowNumber).Y = IceRows(RowNumber) - HeroHeight + 6
    Else
        Creatures(RowNumber).Y = IceRows(RowNumber) - HeroHeight + 6
    End If

    'Make all creatures in row visible:
    Creatures(RowNumber).State = 0 Xor FIRST Xor SECOND Xor THIRD
    Creatures(RowNumber).Frame = 1
End Sub

'------------------------------------------------------------------------------
Sub MoveHero
    'Hero:
    If InGame Then

        If Not Hero.Grabbed Then
            Hero.X = Hero.X + Hero.Direction * 3
            If Hero.CurrentRow > 0 And (Hero.Action = STOPPED Or Hero.Action = WALKING) Then
                Hero.X = Hero.X + IceRow(Hero.CurrentRow).Direction * Levels(PointsInThisLevel).Speed
            End If
        Else
            If (Hero.Action = STOPPED Or Hero.Action = WALKING) And Hero.Action <> EATINGFISH Then
                Hero.X = Hero.X + Creatures(Hero.CurrentRow).Direction * Levels(PointsInThisLevel).Speed + Creatures(Hero.CurrentRow).Direction
            End If
        End If

        'Hero can't go past a certain point to the left of the screen if WALKING.
        'However, if he jumps from an ice block, he can stand there:
        'IF Hero.CurrentRow = 0 AND Hero.Action = WALKING AND Hero.Direction = MOVINGLEFT THEN
        '    IF Hero.X > HeroWidth + 3 THEN
        '        Hero.X = Hero.X + Hero.Direction * 3
        '    END IF
        'ELSEIF Hero.CurrentRow = 0 AND Hero.Action = WALKING AND Hero.Direction = MOVINGRIGHT THEN
        'ELSEIF Hero.Action = JUMPINGUP OR Hero.Action = JUMPINGDOWN THEN
        'END IF

        Select Case Hero.Action
            Case JUMPINGUP
                If Hero.CurrentRow = 0 Then Hero.Action = WALKING Else AnimationStep = AnimationStep + 1
                Select Case AnimationStep
                    Case 1 TO 6
                        Hero.Y = Hero.Y - 8
                        Hero.Frame = 3
                    Case 10 TO 12
                        Hero.Y = Hero.Y + 3
                        Hero.Frame = 1
                    Case 13
                        Hero.CurrentRow = Hero.CurrentRow - 1
                        JustLanded = True
                        Hero.Action = STOPPED: Hero.Direction = Hero.Action
                End Select
            Case JUMPINGDOWN
                If Hero.CurrentRow = 4 Then Hero.Action = WALKING Else AnimationStep = AnimationStep + 1
                Select Case AnimationStep
                    Case 1 TO 3
                        Hero.Y = Hero.Y - 3
                        Hero.Frame = 3
                    Case 7 TO 12
                        Hero.Y = Hero.Y + 8
                        Hero.Frame = 1
                    Case 13
                        Hero.CurrentRow = Hero.CurrentRow + 1
                        JustLanded = True
                        Hero.Action = STOPPED: Hero.Direction = Hero.Action
                End Select
            Case ENTERINGIGLOO
                AnimationStep = AnimationStep + 1
                Select Case AnimationStep
                    Case 1 TO 6
                        Hero.Y = Hero.Y - 8
                        Hero.Frame = 3
                        _PutImage (Hero.X, Hero.Y - HeroHeight + AnimationStep)-Step(HeroWidth, HeroHeight - AnimationStep), HeroSprites(Hero.Frame), GameScreen, (0, 0 + AnimationStep * 6)-(HeroWidth, HeroHeight)
                    Case 20
                        LevelComplete = True
                End Select
            Case DROWNING
                AnimationStep = AnimationStep + 1
                Select Case AnimationStep
                    Case 1 TO 5, 11 TO 15, 21 TO 25, 30 TO 35
                        _PutImage (Hero.X, Hero.Y - HeroHeight + AnimationStep)-Step(HeroWidth, HeroHeight - AnimationStep), HeroSprites(Hero.Frame), GameScreen, (0, 0)-(HeroWidth, HeroHeight - AnimationStep)
                    Case 6 TO 10, 16 TO 20, 26 TO 29
                        _PutImage (Hero.X + HeroWidth, Hero.Y - HeroHeight + AnimationStep)-Step(-HeroWidth, HeroHeight - AnimationStep), HeroSprites(Hero.Frame), GameScreen, (0, 0)-(HeroWidth, HeroHeight - AnimationStep)
                    Case 36
                        If Lives <= -1 Then
                            GameOver = True
                            InGame = False
                        Else
                            Timer(TempTimer) On
                            SetLevel ThisLevel
                        End If
                End Select
            Case FREEZING
                AnimationStep = AnimationStep + 1
                'Recolor the hero sprite to show it's freezing
                _Dest HeroFreezingSprite
                For i = 0 To _Width(HeroFreezingSprite) - 1
                    If AnimationStep >= _Height(HeroFreezingSprite) Then Exit For
                    If Point(i, AnimationStep) <> _RGBA32(0, 0, 0, 0) Then
                        PSet (i, AnimationStep), _RGB32(0, 150 - AnimationStep * 3, 219 + AnimationStep)
                    End If
                Next i
                _Dest GameScreen
                Select Case AnimationStep
                    Case 1 TO 5, 11 TO 39
                        _PutImage (Hero.X, Hero.Y - HeroHeight)-Step(HeroWidth - 1, HeroHeight - 1), HeroFreezingSprite, GameScreen
                    Case 6 TO 10
                        _PutImage (Hero.X + HeroWidth, Hero.Y - HeroHeight)-Step(-HeroWidth - 1, HeroHeight - 1), HeroFreezingSprite, GameScreen
                    Case 40
                        _FreeImage HeroFreezingSprite
                        If Lives <= -1 Then
                            GameOver = True
                            InGame = False
                        Else
                            Temperature = InitialTemperature
                            Timer(TempTimer) On
                            SetLevel ThisLevel
                        End If
                End Select
            Case EATINGFISH
                If FishPoints Then
                    Score = Score + 50
                    FishPoints = FishPoints - 50
                Else
                    Hero.Action = STOPPED
                End If
            Case STOPPED
                Hero.Frame = 1
        End Select

        If Hero.X + HeroWidth > _Width Then Hero.X = _Width - HeroWidth
        If Hero.X < 0 Then Hero.X = 0
    End If

    Select Case Hero.Face
        Case MOVINGRIGHT
            _PutImage (Hero.X, Hero.Y - HeroHeight), HeroSprites(Hero.Frame), GameScreen
        Case MOVINGLEFT
            _PutImage (Hero.X + HeroWidth, Hero.Y - HeroHeight)-Step(-HeroWidth - 1, HeroHeight - 1), HeroSprites(Hero.Frame), GameScreen
    End Select
End Sub

'------------------------------------------------------------------------------
Sub CheckLanding
    'Check to see if the hero landed safely:
    Dim i As Integer
    Dim X As Integer
    Dim m.X As Integer

    If Hero.CurrentRow > 0 And (Hero.Action = STOPPED Or Hero.Action = WALKING) Then
        Safe = False
        X = IceRow(Hero.CurrentRow).Position
        m.X = IceRow(Hero.CurrentRow).MirroredPosition
        Select Case Levels(ActualLevel).BlockType
            Case SINGLEBLOCK
                If Hero.X + HeroWidth > X And Hero.X < X + HeroWidth * 2 Then
                    Safe = True
                ElseIf m.X And Hero.X + HeroWidth > m.X And Hero.X < m.X + HeroWidth * 2 Then
                    Safe = True
                ElseIf Hero.X + HeroWidth > X + HeroWidth * 3.5 And Hero.X < X + HeroWidth * 3.5 + HeroWidth * 2 Then
                    Safe = True
                ElseIf m.X And Hero.X + HeroWidth > m.X + HeroWidth * 3.5 And Hero.X < m.X + HeroWidth * 3.5 + HeroWidth * 2 Then
                    Safe = True
                ElseIf Hero.X + HeroWidth > X + HeroWidth * 7 And Hero.X < X + HeroWidth * 7 + HeroWidth * 2 Then
                    Safe = True
                ElseIf m.X And Hero.X + HeroWidth > m.X + HeroWidth * 7 And Hero.X < m.X + HeroWidth * 7 + HeroWidth * 2 Then
                    Safe = True
                End If
            Case DOUBLEBLOCK
                If Hero.X + HeroWidth > X And Hero.X < X + RowWidth Then
                    Safe = True
                ElseIf m.X And Hero.X + HeroWidth > m.X And Hero.X < m.X + RowWidth Then
                    Safe = True
                End If
            Case MOVINGBLOCK
                If Hero.X + HeroWidth > X + BlockLines + SpaceBetween And Hero.X < X + BlockLines + SpaceBetween + HeroWidth Then
                    Safe = True
                ElseIf m.X And Hero.X + HeroWidth > m.X + BlockLines + SpaceBetween And Hero.X < m.X + BlockLines + SpaceBetween + HeroWidth Then
                    Safe = True
                ElseIf Hero.X + HeroWidth > X + BlockLines + HeroWidth * 1.5 - SpaceBetween And Hero.X < X + BlockLines + HeroWidth * 1.5 - SpaceBetween + HeroWidth Then
                    Safe = True
                ElseIf m.X And Hero.X + HeroWidth > m.X + BlockLines + HeroWidth * 1.5 - SpaceBetween And Hero.X < m.X + BlockLines + HeroWidth * 1.5 - SpaceBetween + HeroWidth Then
                    Safe = True
                ElseIf Hero.X + HeroWidth > X + BlockLines + HeroWidth * 3 + SpaceBetween And Hero.X < X + BlockLines + HeroWidth * 3 + SpaceBetween + HeroWidth Then
                    Safe = True
                ElseIf m.X And Hero.X + HeroWidth > m.X + BlockLines + HeroWidth * 3 + SpaceBetween And Hero.X < m.X + BlockLines + HeroWidth * 3 + SpaceBetween + HeroWidth Then
                    Safe = True
                ElseIf Hero.X + HeroWidth > X + BlockLines + HeroWidth * 4.5 - SpaceBetween And Hero.X < X + BlockLines + HeroWidth * 4.5 - SpaceBetween + HeroWidth Then
                    Safe = True
                ElseIf m.X And Hero.X + HeroWidth > m.X + BlockLines + HeroWidth * 4.5 - SpaceBetween And Hero.X < m.X + BlockLines + HeroWidth * 4.5 - SpaceBetween + HeroWidth Then
                    Safe = True
                ElseIf Hero.X + HeroWidth > X + BlockLines + HeroWidth * 6 + SpaceBetween And Hero.X < X + BlockLines + HeroWidth * 6 + SpaceBetween + HeroWidth Then
                    Safe = True
                ElseIf m.X And Hero.X + HeroWidth > m.X + BlockLines + HeroWidth * 6 + SpaceBetween And Hero.X < m.X + BlockLines + HeroWidth * 6 + SpaceBetween + HeroWidth Then
                    Safe = True
                ElseIf Hero.X + HeroWidth > X + BlockLines + HeroWidth * 7.5 - SpaceBetween And Hero.X < X + BlockLines + HeroWidth * 7.5 - SpaceBetween + HeroWidth Then
                    Safe = True
                ElseIf m.X And Hero.X + HeroWidth > m.X + BlockLines + HeroWidth * 7.5 - SpaceBetween And Hero.X < m.X + BlockLines + HeroWidth * 7.5 - SpaceBetween + HeroWidth Then
                    Safe = True
                End If
        End Select
        If Safe Then
            Safe = False
            If IceRow(Hero.CurrentRow).State = False And JustLanded Then
                JustLanded = False
                If BlockSound Then _SndPlayCopy BlockSound
                If IglooPieces < 16 Then IglooPieces = IglooPieces + 1
                IceRow(Hero.CurrentRow).State = True
                RestoreRowsTimer = Timer
                Score = Score + PointsInThisLevel * 10
            End If
        Else
            If Hero.Action <> DROWNING Then
                If DrowningSound Then _SndPlayCopy DrowningSound
                Timer(TempTimer) Off
                Hero.Frame = 4
                Hero.Action = DROWNING
                Hero.Face = STOPPED
                Hero.Direction = STOPPED
                Lives = Lives - 1
                AnimationStep = 0
            End If
        End If
    End If
End Sub

'------------------------------------------------------------------------------
Sub CheckCreatures
    Dim i As Integer
    Dim j As Integer
    Dim X As Integer
    Dim Touched As _Bit
    Dim WhichCreature As _Byte
    Dim EvalCreatures(1 To 3) As Integer

    If Hero.Grabbed Or Hero.CurrentRow = 0 Or (Hero.Action = JUMPINGUP Or Hero.Action = JUMPINGDOWN Or Hero.Action = DROWNING Or Hero.Action = FREEZING) Then Exit Sub
    i = Hero.CurrentRow

    If Creatures(i).Species = 0 Then Exit Sub

    X = Creatures(i).X

    EvalCreatures(1) = Creatures(i).X
    EvalCreatures(2) = X + CreatureWidth(Creatures(i).Species) + Creatures(i).Spacing
    EvalCreatures(3) = X + CreatureWidth(Creatures(i).Species) * 2 + Creatures(i).Spacing * 2

    'Check for first creature in row, left to right:
    If (Creatures(i).State And FIRST) And Hero.X + HeroWidth > EvalCreatures(1) And Hero.X < EvalCreatures(1) + CreatureWidth(Creatures(i).Species) Then
        Touched = True
        WhichCreature = FIRST
    End If

    'Check for second creature in row, left to right:
    If Creatures(i).Number > 1 Then
        If (Creatures(i).State And SECOND) And Hero.X + HeroWidth > EvalCreatures(2) And Hero.X < EvalCreatures(2) + CreatureWidth(Creatures(i).Species) Then
            Touched = True
            WhichCreature = SECOND
        End If
    End If

    'Check for second creature in row, left to right:
    If Creatures(i).Number = 3 Then
        If (Creatures(i).State And THIRD) And Hero.X + HeroWidth > EvalCreatures(3) And Hero.X < EvalCreatures(3) + CreatureWidth(Creatures(i).Species) Then
            Touched = True
            WhichCreature = THIRD
        End If
    End If

    If Touched Then
        If Creatures(i).Species = FISH Then
            Creatures(i).State = Creatures(i).State Xor WhichCreature
            If Hero.Action <> EATINGFISH Then
                If CollectFishSound Then _SndPlayCopy CollectFishSound
                Hero.Frame = 1
                Hero.Action = EATINGFISH
                Hero.Direction = STOPPED
                AnimationStep = 0
                FishPoints = 200
            End If
        Else
            Hero.Grabbed = True
            If IceRow(i).Direction = Creatures(i).Direction Then
                InvertCurrentIceRow
            End If
        End If
    End If
End Sub

'------------------------------------------------------------------------------
Sub UpdateScreen
    _PutImage , GameScreen, MainScreen
    _Display
    $If INTERNALBUILD Then
        Frames = Frames + 1
    $End If
End Sub

'------------------------------------------------------------------------------
Sub ReadKeyboard
    Dim k As Integer

    k = _KeyHit
    Select Case k
        Case Asc("s"), Asc("S")
            $If INTERNALBUILD = TRUE Then
                LevelComplete = True
            $End If
        Case 27
            UserWantsToQuit = True
        Case 13
            If Not InGame Then
                If GameOver Then
                    SetLevel GAMESTART
                Else
                    NewLevelSet = 0
                    Timer(TempTimer) On
                    InGame = True
                End If
                GameOver = False
            End If
        Case 32
            If Not Hero.Grabbed And Hero.CurrentRow > 0 And (Hero.Action = STOPPED Or Hero.Action = WALKING) And InGame Then
                If IglooPieces > 0 Then
                    If IglooPieces < 16 Then IglooPieces = IglooPieces - 1
                    If BlockSound Then _SndPlayCopy BlockSound
                    InvertCurrentIceRow
                End If
            End If
    End Select

    'Check if a movement must be processed:
    If Not InGame Or Hero.Action = DROWNING Or Hero.Action = FREEZING Or Hero.Action = ENTERINGIGLOO Or Hero.Action = EATINGFISH Then Exit Sub

    If Hero.Action = WALKING Then Hero.Action = STOPPED: Hero.Direction = Hero.Action

    'Is the left arrow key down?
    If _KeyDown(19200) Then Hero.Direction = MOVINGLEFT: Hero.Face = Hero.Direction: If Hero.Action = STOPPED Then Hero.Action = WALKING

    'Is the right arrow key down?
    If _KeyDown(19712) Then Hero.Direction = MOVINGRIGHT: Hero.Face = Hero.Direction: If Hero.Action = STOPPED Then Hero.Action = WALKING

    'If the hero has been grabbed by a creature, no jumps are allowed.
    If Hero.Grabbed Then Exit Sub

    'If the hero is already jumping, we have to wait for him to land:
    If Hero.Action <> STOPPED And Hero.Action <> WALKING Then Exit Sub

    'Is the up arrow key down?
    If _KeyDown(18432) Then
        If Hero.CurrentRow > 0 Then
            Hero.Action = JUMPINGUP
            AnimationStep = 0
            If JumpSound Then _SndPlayCopy JumpSound
        ElseIf Hero.CurrentRow = 0 And IglooPieces = 16 Then
            'The igloo has been finished. If the hero is standing under the door,
            'we'll let him in:
            If Hero.X + HeroWidth > DoorX + 5 And Hero.X < DoorX + 17 Then
                If JumpSound Then _SndPlayCopy JumpSound
                Timer(TempTimer) Off
                Hero.Action = ENTERINGIGLOO
                Hero.Direction = STOPPED
                Hero.Face = STOPPED
                Hero.X = DoorX
                AnimationStep = 0
            End If
        End If
    End If

    'Is the down arrow key down?
    If _KeyDown(20480) Then
        If Hero.CurrentRow < 4 Then
            Hero.Action = JUMPINGDOWN
            AnimationStep = 0
            If JumpSound Then _SndPlayCopy JumpSound
        End If
    End If
End Sub

'------------------------------------------------------------------------------
Sub DecreaseTemperature
    Temperature = Temperature - 1
    If Temperature = 0 Then
        If DrowningSound Then _SndPlayCopy DrowningSound
        Timer(TempTimer) Off
        HeroFreezingSprite = _CopyImage(HeroSprites(4))
        _Source HeroFreezingSprite
        Hero.Action = FREEZING
        Hero.Face = STOPPED
        Hero.Direction = STOPPED
        Lives = Lives - 1
        AnimationStep = 0
    End If
End Sub

'------------------------------------------------------------------------------
Function TRIM$ (Value)
    TRIM$ = LTrim$(RTrim$(Str$(Value)))
End Function

'------------------------------------------------------------------------------
Sub UpdateFrames
    Dim PrevDest As Long
    Dim i As _Byte
    Dim AuroraLineColor As _Unsigned Long
    Static AuroraCount As Integer
    Static CreditCount As Integer
    Static CreditUpdate As Integer
    Static BlockCount As Single

    AuroraCount = AuroraCount + 1
    If AuroraCount > 3 Then
        Randomize Timer
        AuroraCount = 0
        PrevDest = _Dest
        _Dest ThisAurora
        For i = 1 To AuroraH Step 2
            Select Case i
                Case 1 TO AuroraH / 3
                    AuroraLineColor = Aurora(_Ceil(Rnd * 3))
                Case AuroraH / 3 + 1 TO (AuroraH / 3) + (AuroraH / 4)
                    AuroraLineColor = Aurora(_Ceil(Rnd * 3) + 3)
                Case Else
                    AuroraLineColor = Aurora(_Ceil(Rnd * 2) + 5)
            End Select
            Line (0, 0)-Step(_Width(ThisAurora), AuroraH - i), AuroraLineColor, BF 'Aurora
        Next i
        _Dest PrevDest
    End If

    If Not InGame Then
        CreditUpdate = CreditUpdate + 1
        If CreditUpdate > 1 Then
            CreditUpdate = 0
            Select Case CreditY
                Case -2
                    CreditCount = CreditCount + 1
                    If CreditCount > 10 Then
                        CreditCount = 0
                        CreditY = CreditY + 1
                    End If
                Case -1 TO 16
                    CreditY = CreditY + 1
                Case 17
                    CreditCount = CreditCount + 1
                    If CreditCount > 15 Then
                        CreditCount = 0
                        CreditY = -2
                    End If
            End Select
        End If
    Else
        CreditY = 17
    End If

    If Hero.Action = WALKING And InGame Then
        If Hero.Frame = 1 Then Hero.Frame = 2 Else Hero.Frame = 1
    End If

    If InGame And Not LevelComplete And (Hero.Action <> DROWNING And Hero.Action <> FREEZING And Hero.Action <> EATINGFISH) Then
        For i = 1 To 4
            If Creatures(i).Frame = 1 Then Creatures(i).Frame = 2 Else Creatures(i).Frame = 1
        Next i
    End If

    If IceRow(1).State And IceRow(2).State And IceRow(3).State And IceRow(4).State And IglooPieces < 16 Then
        If Not LevelComplete Then
            If Timer - RestoreRowsTimer > .3 Then
                For i = 1 To 4
                    IceRow(i).State = False
                Next i
            End If
        End If
    End If

    If InGame And Levels(ActualLevel).BlockType = MOVINGBLOCK And (Hero.Action <> DROWNING And Hero.Action <> FREEZING And Hero.Action <> EATINGFISH) And Not LevelComplete Then
        BlockCount = BlockCount + .5
        If BlockCount > MaxSpaceBetween Then BlockCount = -MaxSpaceBetween
        Select Case BlockCount
            Case -MaxSpaceBetween TO -1
                SpaceBetween = Abs(BlockCount + 1)
            Case 0 TO MaxSpaceBetween
                SpaceBetween = BlockCount
        End Select
    End If
End Sub

'------------------------------------------------------------------------------
Sub SetLevel (TargetLevel)
    Dim CreatureCheck As Integer

    Select Case TargetLevel
        Case GAMESTART
            LevelComplete = False
            ThisLevel = 1
            TimeOfDay = DAY
            Lives = 3
            Score = 0
            Temperature = InitialTemperature
            IglooPieces = 0
            NextGoal = ONEUPGOAL
        Case NEXTLEVEL
            LevelComplete = False
            ThisLevel = ThisLevel + 1
            Temperature = InitialTemperature

            If (ThisLevel - 1) Mod 4 = 0 Then
                If TimeOfDay = DAY Then TimeOfDay = NIGHT Else TimeOfDay = DAY
                DrawScenery
            End If
    End Select

    'Set hero's initial position and state:
    Hero.CurrentRow = 0
    Hero.X = 100
    Hero.Y = HeroStartRow
    Hero.Direction = STOPPED
    Hero.Face = MOVINGRIGHT
    Hero.Action = STOPPED
    Hero.Frame = 1
    Hero.Grabbed = False

    'Levels only have defined conditions up to level 9. After that, conditions are random.
    ActualLevel = ThisLevel
    PointsInThisLevel = ThisLevel
    If ThisLevel > UBound(Levels) Then
        Randomize Timer
        ActualLevel = _Ceil(Rnd * UBound(Levels))
        PointsInThisLevel = UBound(Levels)
    End If

    'Erase existing creatures and fills an array with the ones allowed:
    Erase Creatures
    MaxLevelCreatures = 0
    CreatureCheck = 1
    Do
        If Levels(ActualLevel).CreaturesAllowed And CreatureCheck Then
            MaxLevelCreatures = MaxLevelCreatures + 1
            ReDim _Preserve ThisLevelCreatures(1 To MaxLevelCreatures)
            ThisLevelCreatures(MaxLevelCreatures) = CreatureCheck
        End If
        CreatureCheck = CreatureCheck * 2
        If CreatureCheck > CLAM Then Exit Do
    Loop

    'Set ice rows initial position and direction:
    IceRow(1).Position = 90
    IceRow(1).Direction = MOVINGLEFT
    IceRow(2).Position = 10
    IceRow(2).Direction = MOVINGRIGHT
    IceRow(3).Position = 90
    IceRow(3).Direction = MOVINGLEFT
    IceRow(4).Position = 10
    IceRow(4).Direction = MOVINGRIGHT

    For I = 1 To 4
        IceRow(I).MirroredPosition = 0
        IceRow(I).State = False
    Next I

    Select Case Levels(ActualLevel).BlockType
        Case SINGLEBLOCK: RowWidth = HeroWidth * 9
        Case DOUBLEBLOCK, MOVINGBLOCK: RowWidth = HeroWidth * 8.5
    End Select

    NewLevelSet = Timer
    InGame = False
End Sub

'------------------------------------------------------------------------------
Sub LoadAssets
    'Saves sound files to disk, then loads them with _SNDOPEN:
    'jump.ogg
    A$ = ""
    A$ = A$ + "?MfIC1P00000000000P7[00000000PDQ:^L0N4PM_9WHY=7000002@4[0000"
    A$ = A$ + "000004W00000000^1ldIW=50000000000000N\20040000`L`]TnB\cooooo"
    A$ = A$ + "ooooooooooooooooA>PM_9WHY=g:0000HU6LXibCbM68\UVHFmVLRUfLPT48"
    A$ = A$ + "b0C<b0S<`<38XlDK^U6LbEfLUi6MY00000@05HgKb9FJcUR@3IE00P0000@<"
    A$ = A$ + "<1Ba02=TE100@000PAB:><YI9UBYD6::iQ9U8UD:UBIa`T8VDVHaH<6SaH<6"
    A$ = A$ + "SaH<6SaH<22=TE100@000RB2>>Zi9YVciL66WhXLPVCJ>QcYPLPRA1N>98Lm"
    A$ = A$ + "V<VKVB[Y[iVcYD22=TE100P0004BQD85BQD85BQH86RQH86RQL87bQL8WbYL"
    A$ = A$ + ":X2ZP:X2bP<83bT<YCjT>YCjX>ZSjX>:d2]@;d2]B[4CaD]ESiJ_6d5OciL>"
    A$ = A$ + "WciL>WciL>Wc98d@F500P00048T1I@642Q@85BQD8VRYH:W2bP<P@3IE0008"
    A$ = A$ + "00800000759595;5;7;7=7=9?9?;A=A=A?CACAECEEEEEEGGGIGIGKGMGKGO"
    A$ = A$ + "IQIQKQKOIQKQKQMQMMOQQQQQQQQQQQQQQQOOOOOOOOOOP@3IE008100XSTSU"
    A$ = A$ + "SWRXRXQXRWSX3@XQ\:00T100400898Y8Y8iX9IZIZiJJKJ;J[JKK;;;;;;;3"
    A$ = A$ + "4J8[200010010000000XYYYYYYYYYYYYYYYYYYYYYYYYYYYIIIIIIIIIIIII"
    A$ = A$ + "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII14J8[2009000MLLLLLLTDTD"
    A$ = A$ + "TL\L\L02=TE10P<00P00095;5;7=7=7=7?7?7?7?7A7A9C9C=C?C?P@3IE00"
    A$ = A$ + "0800800000000537577797=9?9E;C;G=G=G?G?GCGGGGGEEEEEEEEEEEEEEE"
    A$ = A$ + "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEP@3IE000100@8MJVUZ182c0IHP@3I"
    A$ = A$ + "E00P0000H4:23a02=TE10001000RQB>8J2]VcgL>>XIiPV:5K>M`9BeVWTKZ"
    A$ = A$ + "H^iL>WciLbVcI<>WciL::WIaPV9dJ>Wc9aPVU2JV@[iL>WW4KN@[Y:]VciL6"
    A$ = A$ + "WcY36WAHL>WcY9]V7TJfH]iL>W5dJJ>ZiBaVciLRD^i9eV;EK>WciL>WciL>"
    A$ = A$ + "WciL>WZGLjL`i4>WciLRJ_iJiV@GL>WciC6W^gL2QciL>WciL>WciL>WciL2"
    A$ = A$ + "2=TE100@0001QQ=66gYPPdWS6865QHJ8Cj1M?j`TP63bY@Z7=jXA:UjP@9E6"
    A$ = A$ + "WD:M22=TE100P00042QD85BQD85BQD85BQD86RQH86bYL:W2ZP:YBZX::Sb\"
    A$ = A$ + "<;cb\<;cb\<[3k\>[3k`@<43a@[d:aB=EKeH=F[iN>W[iPdJUF[eJ]BYD:UB"
    A$ = A$ + "YD:8d@F500P00048T1I@6TAQD85BQH8VbYL:W2ZP:P@3IE000800800000?9"
    A$ = A$ + "?7A7A7A7A7A7A7A7A7A7?7?7A9A9A9A9A;C;C=C?EAEEGIGKIMIMKOKQMQMM"
    A$ = A$ + "OOMOOOMSOMQQUUUUUUUUUUUUUUUUUUUUUUP@3IE0002000P@842QD85BQD8U"
    A$ = A$ + "RaH<7ciP>9D212=TE100P00P00000LDLDLLTLTLTT\T\TdTd\d\ldldld4m4"
    A$ = A$ + "555===E5M5M5e=]5U=U=M=M=U=MEUE]MUU]]U]e]mUU]mmmmmmmmmmmmmmmm"
    A$ = A$ + "mmmee12=TE10P400P>B>B:B:B:B>>>>BBB0Q6bZ00@600@00PRRSRSSSSTTT"
    A$ = A$ + "TTUTVTWUWUXVYVYWYWZX:@XQ\:00040040000000PRVRWRYRWRXRWSXSXTXU"
    A$ = A$ + "YUXVZV[X\Y\[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[;@"
    A$ = A$ + "XQ\:00T000dAbAbAbABABABAbAb18d@F500b000200L<L<TDTL\\\ddldldl"
    A$ = A$ + "d4m4m4m<mD5M5M12=TE100P00P00000000<T<\D\LdLdT4UD]D]DeD]D]D5E"
    A$ = A$ + "mDEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE======12=TE200"
    A$ = A$ + "I000TCZYD[W3B86TiTH@XQ@B4cAaLYCjL>:G<N8TSHDB]7bD<311eR9d9E85"
    A$ = A$ + "D;^FZeaLD]HS]B6B1eR]6;E8USj12=TE80@XI0P37707==07;=0000000000"
    A$ = A$ + "9==0=AA0=?A00000000007==0=A?0=AA0000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "0007==0=AA0=AA0000000000=AA0ACE0ACC0000000000=AA0?CA0ACE0000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "0000000000000000000000000007==0=AA0=AA0000000000=AA0AEC0?AC0"
    A$ = A$ + "000000000=AA0ACC0AEC0000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "10001h0004P525J8[80Ph4007>>@B2BB`C3PSU5llPW6<=1hHI1??Xi1CC00"
    A$ = A$ + "00000000000@bC3NN`c3VV0TdlPW7llPY900000000000008ii1??hi1CC0B"
    A$ = A$ + "NN`c3NN`d40000000000000l<=QY94=QZ90?CCHJ2CCHZ200000000000000"
    A$ = A$ + "000000000000000P000P1L0002`4:3DXQ\R00RC00LhX89100PSTTU5000:B"
    A$ = A$ + "BFF000HIIii100PTUUW70000000000000000000000000000000000000000"
    A$ = A$ + "00000000000000000000000000000000000000000000008000H0700P0<Qb"
    A$ = A$ + "05J8[40PX0007::FF077;;PSSU5@Bbb2PU50==0NJ045108000X0700P0\1="
    A$ = A$ + "UHa1X@3IU004500h`AabBCCDTSSUUVVX877;;==AAFFJJJJRR@cBCCD4NNNN"
    A$ = A$ + "VV`ccccd4RRRRVV0AACC10005h0004P=XY4;>05J8[40P@2007>>FFNNRRRR"
    A$ = A$ + "VVVVZZLL\\ll4555==EEMMihHIii9:::JJZZjjbbBCccCDDDddDEee5JJNNR"
    A$ = A$ + "RRRVVZZ^^@CCDddddDEEEee5JJNRVVVVZZZZ^^`cCDddddDEeeee58:JJJJZ"
    A$ = A$ + "Zjjjj245====EEMMMM1RRRVVVZZ^^^^0CCCCEEEGGGII0VVZZZZ^^bb0DEEE"
    A$ = A$ + "MMMUUU1XZZZjjjj:;3`eeeEfEFFF60^^^^bbbb2000>`10080SP>9SZ\8\AC"
    A$ = A$ + "h2?0DXQ\R00R2000<6VBaD:3S9Q@:4JH<94BQ@VDBYB:UZP@ZDBUB54BUBZD"
    A$ = A$ + "bXD;UJYD54BUBZDZP@ZDBUB100H7h00PMP525J8[40Pl0002SAYH<WciT8TB"
    A$ = A$ + "aH>Wc9A8URaL>WCZD<VciL>WD:I<WciL>YDbH>WciLBYTaL>WciTBYciL>W3"
    A$ = A$ + ":UBYdiL>WC:UB94jL>WD:UBWciL>100@5h0004P=:bVC`81EXQ\B00B500<h"
    A$ = A$ + "hHIYYii9:JJJ99YYiii9JJJJZ99YYii9:JJJJbcccCDDDddDEUWWWWXXXXYY"
    A$ = A$ + "Z:GGAAACCCCCEEbbRRRRVVZZZZ`dddddDEEE5VVVVVVZZ^^`fFEEEeeee5ff"
    A$ = A$ + "ZZZZ^^^^0GGGGGGIIP[[[[[[\\000l4L00P:`6FM4>YXa2\@3IU00T100@H<"
    A$ = A$ + "8T2Q@8U1Q@:42QD:529000H0700P0<Qb05J8[40P`100021SaH<6SaH<f`HH"
    A$ = A$ + "<6SaH<6Sa4W2SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH"
    A$ = A$ + "<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH"
    A$ = A$ + "<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH[eJ]F[E0PQc5>0@"
    A$ = A$ + "IAHSc`:9MFQS6LQ6b:108T000`H@863jT@YT:YD52aH>XDBUFZUR]:4RaP@Y"
    A$ = A$ + "TB]F\5S5?Wc1QB:UJYH:f:N>WC:YD[5SaH\FL]@8UBYF;fR]H\9KQ@:UB]F<"
    A$ = A$ + "6[eHcXD]DZeRaH<6[aRBiBYD[5KaH\FS5QbVK]F<6[eJ]FC:U?gBaF]FSaJ]"
    A$ = A$ + "V<:SB6SaJ]6[eJ]8D:U<6CaD\F[eJB8<6O?6SaJ<W[eTB8<nN<E;aF]F[9UB"
    A$ = A$ + "Y<2I=VZaJ=WC:U@I<fH;ECiL>G000e3>00D9H4d9IDU5Q=J2Gh1P2=TE20@^"
    A$ = A$ + "10022YD<6SiL>WciL>W3BA:6caL>W32Q@842Q@:2aH<VciL@842Q@84BI<6c"
    A$ = A$ + "iL>842Q@84:QB:UbH>Wc1Q@84:UBYDBYDWciP@842QBYD:UB:UjL>742Q@XD"
    A$ = A$ + ":UBYDBYD842Q@842UBYD:UB:UBY@842QBXD:UBYDBYD:52Q@8D:UBYD:UB:U"
    A$ = A$ + "BY@842QBYD:UBYDBYD:52U@YD:UBYD:UB:UBYD:4:UBYD:UBYDBYD:UBUBYD"
    A$ = A$ + ":UBYD:UB:UBYDZD:UBYD:UBYDBYD:UBUBYD:UBYD:UB:UBYD:U:UBYD:UBYD"
    A$ = A$ + "BYD:UBYDYD:UBYD:UB:UBYD:U:UBYD:UBYDBYD:UBYDYD:UBYD:UB:UBYD:U"
    A$ = A$ + "BYBYD:UBYD:000j0700P0<R:]@\Cch:?2L45b`4@5J8[400b000474;]F[eZ"
    A$ = A$ + "<:Wb9UD[3IT6V3:YHWd1QD;F;E681YLB:eYP8TR1YF8SZD:VCJY@;SYD<8f:"
    A$ = A$ + "a@7SaLD>UCU@7S1000PP00`0A8c48@1@16830P3@81Y00X`2<da`514@^4bX"
    A$ = A$ + "03:L<Qc9MJ30044R<3AR8F<8a4Z6XXRY30Ha5H8O0P<dHSd^h2X;3`5d5ge1"
    A$ = A$ + "2QP@@88FL0D09P3>QKh9N3?QK`9XCAUj01000000N00h1008I3P8R8JVSS>l"
    A$ = A$ + "h3@2ATA8Y4C>151000000\30h300895P8R8JVSS>lh3@2ATA8Y4C>1U000@0"
    A$ = A$ + "4000000@04028P0000000@0000028ldIW=504@1:00000000N\20080000`c"
    A$ = A$ + "PYlJId5C:mOMoSeoQmoKooeocl_7oGaobl_Ao_1K=<D1>QHaN=fBHg1LUc2V"
    A$ = A$ + "N1H^\52d<1TnKX9j@]mEEKdaom?OiLWnAeOMCmfbK7GFf_`n?i_VOdLoKNSo"
    A$ = A$ + "M_iSmYlgi=7NmgcloBegcn]n1GWmOaW]dU00`[[6000gYc7GK0CTQ`9NG>O<"
    A$ = A$ + "]1<A627h7017AbB00E1@BZ`4^4N<f:J\F[l:[JA45@ASDa::JeRReJ5a>LG9"
    A$ = A$ + "UA55dZVn?VOC4e:RRZ>_Zi204Y@\1X01R<?BQ@;`124IhI]eT4Q4C`L728Ze"
    A$ = A$ + "R[[R>JHDF8XZ:P>iXMd9X34[8HE5S>9^?n0=PE46[0J1<=1I<Pe<1;\@adJP"
    A$ = A$ + "92PnWAMAV[IZj_DfZ7Vk88Wdo<Z;bL=CEoUbFm`L71iTn70000P3207ATR;R"
    A$ = A$ + "DPYSVciD0RT`B014`AikY`T00X690XfXMeJ20`ZE\cRED3CD3@UTE0Y4G2A5"
    A$ = A$ + "CDQTD2a5C:^l4G0Y94G60F:35\2IE3KdV<5;]`D<=DaBKX:A@4UR>eQEeYXA"
    A$ = A$ + "7H;P3QMFHM;4E53eZFeB4040iI=[RE\4<DE\V=H518>3\dJVPX:RJYe]d9LR"
    A$ = A$ + "XCMHSPA`XXA1K1001@AW::Z8R10ZmWR9`:ZXA[PH@0401EMZe008XZ3E@<80"
    A$ = A$ + "080JdQ>4005]J\51000413FWJ]0FA[8Z2R100@<08:J`ZRASF1a06<NXR65E"
    A$ = A$ + "=ZF0003C51KD]dd0@0E5A<5[QE4D0e004KMXeJE=H<0@0EMXJAD4D]Y00XZA"
    A$ = A$ + "dZ06D^13<00SR>E03REeYFE00<802HJ=[RQZ0PH5[I=1E4D@D@<aBK`dB[HR"
    A$ = A$ + "YXP8fjD[5540X0h0T4PWf`Q96WlFZkW_2Fm:U_eo@O>YY=LHRa9_Ujni[PE_"
    A$ = A$ + "BiKm?dWCjO00000b5@07F@ZVC7a;8EC18B2;RMj;`YCDFP9000JC008SVJA0"
    A$ = A$ + "0D1\eRZX2:8D6A904025P;7AhC5D@Yh`A@F`202@@aZJ@[>DA<HJQe]Re]`B"
    A$ = A$ + ";]`:6FHQPZ96;H5]j@W:6DAAFA6>0\H[XESF5E1oE:2A:14@]CD4CA]UH=3A"
    A$ = A$ + "@Xg:aW5@000]JeX4@0YC[AE010aP5EMR6@00@0aJ\641140`P>Ee8808aeU9"
    A$ = A$ + "92280FDeYXTVTGB[d9HMC314<D3E`4B8X0RFM::2:Fc]8B020H<22jd::ZJD"
    A$ = A$ + "E01010d3AWJ5MH144@@<@DD`d6E;@440@5EDA5[KMSXM<P@T_]D5e6EA5EA1"
    A$ = A$ + "04`ek<DA14[KY02lJ@DA5ED0@\d65UPKooI;g\3P5]XES:0000RZ>E00NJ3]"
    A$ = A$ + "@an[`KnM@cBRm`lAL\3jd6JQRmGQglkPVU4kQiShH7do10000H?E;HQ5@@TR"
    A$ = A$ + "[if6A:`2F0A=08B2F`V02Tb4000e00P8EKI00ZQJX026fJedZXVZX2000;O6"
    A$ = A$ + "F`U2660F:8R;1?F6:U?On\PQ3hJZ6F1\:ReDa4e@4EEe2C3;Ea6\I4=JdX8H"
    A$ = A$ + "3P=:QMheE1\0Kd21EA<\`21XQlkc2V;C@D\Z5Fa6110RmgKZE10@@DD[XFG3"
    A$ = A$ + "R1000\F]jDEE400@A5\`jZEDE1000;F0[ZeBC54@11ajFAA;820PHabTQfR0"
    A$ = A$ + "VZY=IYU2PBbU1<XXA7:R]Z8j`V5;@14ED10```2[H5[8HSf0:ZX^03dUJ=88"
    A$ = A$ + "ZXH8fB4PAkUe`dZf0VFJYUV:80`PXZXR:VH=;E4@EE[Z:800EkoJ7FAd:863"
    A$ = A$ + "R@KI=H10;XXZE7P11aHAd82XOnM88JEdXR100005MXP00hM=D?8QKb5N=OU["
    A$ = A$ + "dUG=O79cAge@cPT^9GjelENT^lZik:I>j?Z9A20RXJMZg:eCM2bTSfB3;8b5"
    A$ = A$ + "L048`nn2f9bDf5VGP0>MWn2Lj000`H]ZH54eJ4;6E]ZeH53R8643E5<a`F3k"
    A$ = A$ + "1E1E453Dk<]X8RLjUoUO3ZH;JD]2Z8FJXZQRe\RJY:8620R8AQ0D10444SH["
    A$ = A$ + "XMifm00PRHEK`6]05D4DA]ZUFH=A15oo053[K3FG451Eh`QR>5dZH4<02ZP:"
    A$ = A$ + "XRE4KdV=AEA@4001;]V=J1Z8XHZ008:P2FgV=]RQ2X0ZHHMKbj6RFiWo[08P"
    A$ = A$ + "PYHCfPP806Fg:V8X2TcR4PZXR1RE\6FJRRZXAW:H4K0jPR002V:FJSFeZFcj"
    A$ = A$ + "RX0:00@3>J@1@@]`Z6fXQeF4`PJ0PJHY06ZQ=HQ?U8X:\PE\P1D4MJM5@000"
    A$ = A$ + "0H@mbZFH:X88R2FJmK[Q1151A@A]d:fXeDVG?9WfP=9:R:000`AX0hSA<d>j"
    A$ = A$ + "NZ]ceU@j3oJg[mL`b`H33]l^7Jh\N9TN=n_VN]W35WeO000BUA6aYLj?cQS;"
    A$ = A$ + "gCUhgb5P8WKiRUc;\P1R<5ARU2aK2000PR00P84UX6\jnNN6LE@4a6a6[XXH"
    A$ = A$ + ":4?Aia``Bicb5P7A0K>3V:RQ5R8HH9FE1?CIeB;0A555\H5E=JeX:F<MJRcK"
    A$ = A$ + ":408h;`b=>8DPTAAAa6`ZX0R8P]ZZF]Zf0008FA[6]:F<08:ZZVfTHElimDA"
    A$ = A$ + "4=Jd8R8F\07c?<]9[<6D5440<08XXZX:J]>EeJ300PPXX:FJ=[HYZ:880H\X"
    A$ = A$ + "ZAEa200P8::J43000D\Z5f@_=B]^@00T1[ZZEE50C\ZHCVZZZHJQYQc3dTDO"
    A$ = A$ + "i8HSYD_0X0PP5FJQeEeP>EeZJ320100FEC40EEmRa0bIB00P=]H0@0[EAa1g"
    A$ = A$ + "oZLOeY03RXfXQE05D@@`06AAYJEA4L1004_Fd820NH3]1eag^hIoG7EOg7;I"
    A$ = A$ + "6g`6JSZSoMecU_>ZUo^?Fb\Ho10000hD2`I@OXLL@FDKm69P`dY000dRKZYB"
    A$ = A$ + "e00@\W00b:eTT;L@;`A@6PGH\]14\`d70A408bZ4SX0;0000]00000J=KTJP"
    A$ = A$ + "8V8XVR8VXRRQ:HJHE]a4DA54UT:028D10D\::00P:00063:0X2HH[]fIJ022"
    A$ = A$ + "8fX6V6PX2:F4[V000F\g6C01000004D[a:Z0PPJGlAR2lP8lY2@XL9Q`?e_@"
    A$ = A$ + "L<9XY1li`Ji4F4d_gAWVBLDSm24;1Q1@=b01Q2^_<=kAWXH56P3RU2G\004@"
    A$ = A$ + "LEEDD5564:\2UEJI2A@`G<>\0P@1@hb9C@HPMJ10V:A>oUckCb^:=Id0000H"
    A$ = A$ + "QL1km6Dh10080>7Hm1^J02V0c]60NI3A`T6_TiWeKo4k:oY`X?9^\\Q8@AS?"
    A$ = A$ + "DmMih_JOU?56m5hQo00000L>0hD000cY000D4=000QF80007;08DWR47300e"
    A$ = A$ + "2hH08Eo20hH0:[4001;<102K099A00D=0000PF00000eF>B5<0343<BaR005"
    A$ = A$ + "00E0@c00b61000104\j>Y008HB3R50PFj>X20P6SAe0008eK;00000000RF7"
    A$ = A$ + "00@Bo=502;P@nYLH94n<8d2H@`l4VU`5PeB3]DMbih7==EAZYF@9@15@;T8Z"
    A$ = A$ + "A0142\480EDQ460JSf4IaX@DL>CF8[45<R:119EA01BHbJCh300@;]d`[OJY"
    A$ = A$ + "aN0CJbjXa0600@00<0000@3HY=d^SM435030000:4?00TD00NJ41RT6OJjNm"
    A$ = A$ + "]obab7o]m<c1:Tf@T8Ya_j^GojOEUoBIkIf5L`o10000Hea1PjF4`L:0005A"
    A$ = A$ + "7008`Y000hH40@M:C\`06`23F0;<d3@`2CK045P44fP0000P620000RFZ615"
    A$ = A$ + "ElZDmLY08Z0@f80P\6000008Pj]000HJjZ00PJYZ600@^nTf100P]VF45000"
    A$ = A$ + "000@a@\E000aJR91@215W2nPU3h`B5VQ:RRC`D^4`1<2bC4R8f0H8XZ:R1ZU"
    A$ = A$ + ":1AAHkN9Z[`h9:HIV`9UJK;i1bDg[2b8C<E0I8FY<6[A>=41@1[?AR8?2500"
    A$ = A$ + "@:>6f_^N7^lY9EJB1_P>^QWQU000@11P1003;QQ9OP\0D0000h40H`00nH41"
    A$ = A$ + "RZF?`dmjd?eXC_V^;3LH\Q0AE[7XiNIjWJD?f^V^T9Tn70000PYS30eD5XML"
    A$ = A$ + "PXVj=0<Q4e4eK00ELC=E;10X770@UZd56`2FBXSHBPlH\hH0082004eWCU89"
    A$ = A$ + "0000]40000d8[X:X86;FEE05AB>K[EA0RZ=XZe:28NEAT^2I@10002PH]F00"
    A$ = A$ + "04kZ4E5XZFZ]X001L?dE1@000000T@c`AB>b4:GR0DFQ8RbU3hChAib@<PbQ"
    A$ = A$ + "WikCV=a:jfJD0QeRXej@3R>@[P>]4I]RHAXa^EGBPVl;L9872fBXXdC5jI<B"
    A$ = A$ + "6AE2Hk4jRfd@6A7QYHb@n\:15;0Nh100a7h0jc20PHS0a000?P30N000`:3f"
    A$ = A$ + "BAY0g0H1\000>N07070LW0D1100000100<]bX\UR25PgFA\N>?oY_;5gIn2="
    A$ = A$ + "ATdFA\N>?oY_;=W<OaV09OZWj=92IVI4ATI283eD_EfB8fI<9XMLQXf:T0XB"
    A$ = A$ + "g>1d5FP9eUD;eS@KP]`W4@X0CV9<9000\6E=H53B4_aRA`4=ZJ=HEE51<5[Z"
    A$ = A$ + "[X60TDehPE<P80F\aRH:RP2800@6DE`Na^PAaA_]ZX08@3H7ZP0X0hED418b"
    A$ = A$ + "PnRZgBK`DEC3\@=aB[PEDe6Ed52[@ESdXb488VA2211@Q4E\^=HR2IcgngBA"
    A$ = A$ + "I^ne6A62BF6NCCTIXA6GR0SM0b<>0I3<`bO0c0B@JS5J5]RRa=`30^5LIC5P"
    A$ = A$ + "U3>006P208G[aV]H4aT4`@<NP3\NX10CadFT5:J2E`DUK2f1_?8J6?l>YgOC"
    A$ = A$ + "]W2L`3@j1`64PUBF1IfJ375`E]H;06400B_Djb<6J104T@\i\P]bB<00nF6?"
    A$ = A$ + "K7[Ig1U@`F7k`F6gffGcY3B2F37`86KRGln>eYj4254:8TP4@Bh>610000fK"
    A$ = A$ + "HH_=HKLVfJeZmAF]gdJFJJ;\AeV\Uff`jfPUZe\5FJMKbdZfPYYE\DcjX4;d"
    A$ = A$ + "I]RF5DeHE=UFAUkBgnj^L7;Q44B@81QEPMgE[6^6QBa2;\<b8;\`AfAVX`FA"
    A$ = A$ + "[XXEdX5=E@AUPHTAFHQ5F3b8;IQ3B[HDDAD5YRRXEAd]BQFYXBGXRH:4M99c"
    A$ = A$ + "C]=Amld8URXZPZ2EdPF=XE3[D@E`2FHNJ;4kRYFgTJ9FH=>`>`>`^;?900F<"
    A$ = A$ + "ebDbET98VPh9`CIL[0`3OkfSBTAQ45R<bD>000PSFKgXFRN0Tm9K8;00P`27"
    A$ = A$ + "iIa83000`kV0%%%0"
    RestoreFile A$, "jump.ogg"

    'block.ogg
    A$ = ""
    A$ = A$ + "?MfIC1P00000000000@N^00000000`PlEPH0N4PM_9WHY=7000002@4[0000"
    A$ = A$ + "000004W00000000^1ldIW=50000000000000ii20040000@DEnC\B\cooooo"
    A$ = A$ + "ooooooooooooooooA>PM_9WHY=g:0000HU6LXibCbM68\UVHFmVLRUfLPT48"
    A$ = A$ + "b0C<b0S<`<38XlDK^U6LbEfLUi6MY00000@05HgKb9FJcUR@3IE00P0000@<"
    A$ = A$ + "<1Ba02=TE100@000PAB:><YI9UBYD6::iQ9U8UD:UBIa`T8VDVHaH<6SaH<6"
    A$ = A$ + "SaH<6SaH<22=TE100@000RB2>>Zi9YVciL66WhXLPVCJ>QcYPLPRA1N>98Lm"
    A$ = A$ + "V<VKVB[Y[iVcYD22=TE100P0004BQD85BQD85BQH86RQH86RQL87bQL8WbYL"
    A$ = A$ + ":X2ZP:X2bP<83bT<YCjT>YCjX>ZSjX>:d2]@;d2]B[4CaD]ESiJ_6d5OciL>"
    A$ = A$ + "WciL>WciL>Wc98d@F500P00048T1I@642Q@85BQD8VRYH:W2bP<P@3IE0008"
    A$ = A$ + "00800000759595;5;7;7=7=9?9?;A=A=A?CACAECEEEEEEGGGIGIGKGMGKGO"
    A$ = A$ + "IQIQKQKOIQKQKQMQMMOQQQQQQQQQQQQQQQOOOOOOOOOOP@3IE008100XSTSU"
    A$ = A$ + "SWRXRXQXRWSX3@XQ\:00T100400898Y8Y8iX9IZIZiJJKJ;J[JKK;;;;;;;3"
    A$ = A$ + "4J8[200010010000000XYYYYYYYYYYYYYYYYYYYYYYYYYYYIIIIIIIIIIIII"
    A$ = A$ + "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII14J8[2009000MLLLLLLTDTD"
    A$ = A$ + "TL\L\L02=TE10P<00P00095;5;7=7=7=7?7?7?7?7A7A9C9C=C?C?P@3IE00"
    A$ = A$ + "0800800000000537577797=9?9E;C;G=G=G?G?GCGGGGGEEEEEEEEEEEEEEE"
    A$ = A$ + "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEP@3IE000100@8MJVUZ182c0IHP@3I"
    A$ = A$ + "E00P0000H4:23a02=TE10001000RQB>8J2]VcgL>>XIiPV:5K>M`9BeVWTKZ"
    A$ = A$ + "H^iL>WciLbVcI<>WciL::WIaPV9dJ>Wc9aPVU2JV@[iL>WW4KN@[Y:]VciL6"
    A$ = A$ + "WcY36WAHL>WcY9]V7TJfH]iL>W5dJJ>ZiBaVciLRD^i9eV;EK>WciL>WciL>"
    A$ = A$ + "WciL>WZGLjL`i4>WciLRJ_iJiV@GL>WciC6W^gL2QciL>WciL>WciL>WciL2"
    A$ = A$ + "2=TE100@0001QQ=66gYPPdWS6865QHJ8Cj1M?j`TP63bY@Z7=jXA:UjP@9E6"
    A$ = A$ + "WD:M22=TE100P00042QD85BQD85BQD85BQD86RQH86bYL:W2ZP:YBZX::Sb\"
    A$ = A$ + "<;cb\<;cb\<[3k\>[3k`@<43a@[d:aB=EKeH=F[iN>W[iPdJUF[eJ]BYD:UB"
    A$ = A$ + "YD:8d@F500P00048T1I@6TAQD85BQH8VbYL:W2ZP:P@3IE000800800000?9"
    A$ = A$ + "?7A7A7A7A7A7A7A7A7A7?7?7A9A9A9A9A;C;C=C?EAEEGIGKIMIMKOKQMQMM"
    A$ = A$ + "OOMOOOMSOMQQUUUUUUUUUUUUUUUUUUUUUUP@3IE0002000P@842QD85BQD8U"
    A$ = A$ + "RaH<7ciP>9D212=TE100P00P00000LDLDLLTLTLTT\T\TdTd\d\ldldld4m4"
    A$ = A$ + "555===E5M5M5e=]5U=U=M=M=U=MEUE]MUU]]U]e]mUU]mmmmmmmmmmmmmmmm"
    A$ = A$ + "mmmee12=TE10P400P>B>B:B:B:B>>>>BBB0Q6bZ00@600@00PRRSRSSSSTTT"
    A$ = A$ + "TTUTVTWUWUXVYVYWYWZX:@XQ\:00040040000000PRVRWRYRWRXRWSXSXTXU"
    A$ = A$ + "YUXVZV[X\Y\[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[;@"
    A$ = A$ + "XQ\:00T000dAbAbAbABABABAbAb18d@F500b000200L<L<TDTL\\\ddldldl"
    A$ = A$ + "d4m4m4m<mD5M5M12=TE100P00P00000000<T<\D\LdLdT4UD]D]DeD]D]D5E"
    A$ = A$ + "mDEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE======12=TE200"
    A$ = A$ + "I000TCZYD[W3B86TiTH@XQ@B4cAaLYCjL>:G<N8TSHDB]7bD<311eR9d9E85"
    A$ = A$ + "D;^FZeaLD]HS]B6B1eR]6;E8USj12=TE80@XI0P37707==07;=0000000000"
    A$ = A$ + "9==0=AA0=?A00000000007==0=A?0=AA0000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "0007==0=AA0=AA0000000000=AA0ACE0ACC0000000000=AA0?CA0ACE0000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "0000000000000000000000000007==0=AA0=AA0000000000=AA0AEC0?AC0"
    A$ = A$ + "000000000=AA0ACC0AEC0000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "10001h0004P525J8[80Ph4007>>@B2BB`C3PSU5llPW6<=1hHI1??Xi1CC00"
    A$ = A$ + "00000000000@bC3NN`c3VV0TdlPW7llPY900000000000008ii1??hi1CC0B"
    A$ = A$ + "NN`c3NN`d40000000000000l<=QY94=QZ90?CCHJ2CCHZ200000000000000"
    A$ = A$ + "000000000000000P000P1L0002`4:3DXQ\R00RC00LhX89100PSTTU5000:B"
    A$ = A$ + "BFF000HIIii100PTUUW70000000000000000000000000000000000000000"
    A$ = A$ + "00000000000000000000000000000000000000000000008000H0700P0<Qb"
    A$ = A$ + "05J8[40PX0007::FF077;;PSSU5@Bbb2PU50==0NJ045108000X0700P0\1="
    A$ = A$ + "UHa1X@3IU004500h`AabBCCDTSSUUVVX877;;==AAFFJJJJRR@cBCCD4NNNN"
    A$ = A$ + "VV`ccccd4RRRRVV0AACC10005h0004P=XY4;>05J8[40P@2007>>FFNNRRRR"
    A$ = A$ + "VVVVZZLL\\ll4555==EEMMihHIii9:::JJZZjjbbBCccCDDDddDEee5JJNNR"
    A$ = A$ + "RRRVVZZ^^@CCDddddDEEEee5JJNRVVVVZZZZ^^`cCDddddDEeeee58:JJJJZ"
    A$ = A$ + "Zjjjj245====EEMMMM1RRRVVVZZ^^^^0CCCCEEEGGGII0VVZZZZ^^bb0DEEE"
    A$ = A$ + "MMMUUU1XZZZjjjj:;3`eeeEfEFFF60^^^^bbbb2000>`10080SP>9SZ\8\AC"
    A$ = A$ + "h2?0DXQ\R00R2000<6VBaD:3S9Q@:4JH<94BQ@VDBYB:UZP@ZDBUB54BUBZD"
    A$ = A$ + "bXD;UJYD54BUBZDZP@ZDBUB100H7h00PMP525J8[40Pl0002SAYH<WciT8TB"
    A$ = A$ + "aH>Wc9A8URaL>WCZD<VciL>WD:I<WciL>YDbH>WciLBYTaL>WciTBYciL>W3"
    A$ = A$ + ":UBYdiL>WC:UB94jL>WD:UBWciL>100@5h0004P=:bVC`81EXQ\B00B500<h"
    A$ = A$ + "hHIYYii9:JJJ99YYiii9JJJJZ99YYii9:JJJJbcccCDDDddDEUWWWWXXXXYY"
    A$ = A$ + "Z:GGAAACCCCCEEbbRRRRVVZZZZ`dddddDEEE5VVVVVVZZ^^`fFEEEeeee5ff"
    A$ = A$ + "ZZZZ^^^^0GGGGGGIIP[[[[[[\\000l4L00P:`6FM4>YXa2\@3IU00T100@H<"
    A$ = A$ + "8T2Q@8U1Q@:42QD:529000H0700P0<Qb05J8[40P`100021SaH<6SaH<f`HH"
    A$ = A$ + "<6SaH<6Sa4W2SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH"
    A$ = A$ + "<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH"
    A$ = A$ + "<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH[eJ]F[E0PQc5>0@"
    A$ = A$ + "IAHSc`:9MFQS6LQ6b:108T000`H@863jT@YT:YD52aH>XDBUFZUR]:4RaP@Y"
    A$ = A$ + "TB]F\5S5?Wc1QB:UJYH:f:N>WC:YD[5SaH\FL]@8UBYF;fR]H\9KQ@:UB]F<"
    A$ = A$ + "6[eHcXD]DZeRaH<6[aRBiBYD[5KaH\FS5QbVK]F<6[eJ]FC:U?gBaF]FSaJ]"
    A$ = A$ + "V<:SB6SaJ]6[eJ]8D:U<6CaD\F[eJB8<6O?6SaJ<W[eTB8<nN<E;aF]F[9UB"
    A$ = A$ + "Y<2I=VZaJ=WC:U@I<fH;ECiL>G000e3>00D9H4d9IDU5Q=J2Gh1P2=TE20@^"
    A$ = A$ + "10022YD<6SiL>WciL>W3BA:6caL>W32Q@842Q@:2aH<VciL@842Q@84BI<6c"
    A$ = A$ + "iL>842Q@84:QB:UbH>Wc1Q@84:UBYDBYDWciP@842QBYD:UB:UjL>742Q@XD"
    A$ = A$ + ":UBYDBYD842Q@842UBYD:UB:UBY@842QBXD:UBYDBYD:52Q@8D:UBYD:UB:U"
    A$ = A$ + "BY@842QBYD:UBYDBYD:52U@YD:UBYD:UB:UBYD:4:UBYD:UBYDBYD:UBUBYD"
    A$ = A$ + ":UBYD:UB:UBYDZD:UBYD:UBYDBYD:UBUBYD:UBYD:UB:UBYD:U:UBYD:UBYD"
    A$ = A$ + "BYD:UBYDYD:UBYD:UB:UBYD:U:UBYD:UBYDBYD:UBYDYD:UBYD:UB:UBYD:U"
    A$ = A$ + "BYBYD:UBYD:000j0700P0<R:]@\Cch:?2L45b`4@5J8[400b000474;]F[eZ"
    A$ = A$ + "<:Wb9UD[3IT6V3:YHWd1QD;F;E681YLB:eYP8TR1YF8SZD:VCJY@;SYD<8f:"
    A$ = A$ + "a@7SaLD>UCU@7S1000PP00`0A8c48@1@16830P3@81Y00X`2<da`514@^4bX"
    A$ = A$ + "03:L<Qc9MJ30044R<3AR8F<8a4Z6XXRY30Ha5H8O0P<dHSd^h2X;3`5d5ge1"
    A$ = A$ + "2QP@@88FL0D09P3>QKh9N3?QK`9XCAUj01000000N00h1008I3P8R8JVSS>l"
    A$ = A$ + "h3@2ATA8Y4C>151000000\30h300895P8R8JVSS>lh3@2ATA8Y4C>1U000@0"
    A$ = A$ + "4000000@04028P0000000@0000028ldIW=504LI;00000000ii20080000@L"
    A$ = A$ + "JCSSJ<UDoo`o1l?3o7`o9lo0oG`o>l_=oCeodm?ND7??<Pbf19XR7NEG??<P"
    A$ = A$ + "bf581El`S?098G7Vg0PV9P`427>Lh`A1]J]X1DeYZR6aAmnhY[mglWA\FMZC"
    A$ = A$ + "]JE[^5HogS0RY=JJ3fPUf<6Z^XE5100eic3CJWQAZ@a<EMnl`TfIHT>D<Cn1"
    A$ = A$ + "8QPT3ck0PVBPT@:ahcUBD5dPEDdXP6dZ:WeK^JgDkEdP>45aWLl;JT3R62FV"
    A$ = A$ + "V93k=cLF@FXUFe2\A100JL3c8eUI4fPN`8mhSKH6Y^<S`6d36Y7og00@d[7m"
    A$ = A$ + "VMc1RMPH7iP3R96;VH<14c\H4?W000XITB88S<]ad6CkE;F=]eZM2F\329T4"
    A$ = A$ + "B115QED6a4S8U8Fe6]52Z=[fPPYHQY2XZXeR5\:JEZ]bcgI:__3>3H3CTb4Z"
    A$ = A$ + "DPZ1l?C;5H_S=\`CjBKEFXKnTS6H=8222P0OR\\ifL`W`G@LKFbTB7Uf2B[]"
    A$ = A$ + ">_Xi[iV9mBEPTG=lM[R>[GdObHl82AaFj<3IlANCT_2iGbc2bA?0HL^OULV7"
    A$ = A$ + "4hbY<\JGf5j]In4A:ndMo6i4RXNTm3Y5]`<?<UJlUaR5=F0[e2XZ1A5[ED1S"
    A$ = A$ + "5\Z2RR5;XA@4[ADaP000NN3EeV0>P>XbOMi=DEK2h0jP:oem^^T4A:UQLXO6"
    A$ = A$ + "\W:7L`17LTH>`>86a<1<a>@<a>h0000<611;R8HDSA\edFKEk<\a`DaZJaZF"
    A$ = A$ + "5ejRXPe=]dd23[KQ=XFPUVFJ5C3e2<@AS8F01AD4iX?J=WcE>XECT31^c`UD"
    A$ = A$ + "R499]<GRc<O8W[9m:NB>NE>fJL@N:M;7WB4>@aPaP6D\82;J5GfaCFgVMEOe"
    A$ = A$ + "[8Y5O9aJ=d?aW`_S_^dW`>b>X9:WC`5OH4_ehGNjCUSVZI1?G??C00G_4j^?"
    A$ = A$ + "MHgY\1Z@4JeTWX2]\Uf<FED^FVdRn7o2OBXb4Jg>;gOA<i9g9GMbK]T?E]g7"
    A$ = A$ + "0hY=<3`480\0EnSVf`<0CP0`2Di?j[j=8Tb<c@I\U:7L`17L`17L@<7LP9@<"
    A$ = A$ + "F<VH7i0000\FA]FE=ZXH=ZEDK`6]Re13;]d2;]A[:H3FcZZUfXYE\2HE\2Pe"
    A$ = A$ + "PZ><0ZREED4AA\ZFd82Fh@WnK6A;iT`?j@aZm1hOJCJF[Mc5O5OhJ[VaU@GI"
    A$ = A$ + "kQ\DjF95@C^VlK7]kF^Da^>:Oge2;57[[jhGgFXSZ8_ZSB2EVF08iDnFb9Qe"
    A$ = A$ + ";<fh6V_C;5[BGC5LTjCWI:U2AU1Y9en5mOo_WV2@12n8`?AoZmI`Men4nmn^"
    A$ = A$ + "mITha`f`^OC[839jHNoO>]7;k@ZbkjEUk=XEAEAD5151A=FIk>UbeM7=0h_="
    A$ = A$ + "dR9STR1D1S\km]QF<ITD<P:HTM_7Pn\iYb1aL`1RM@<78f174S0RIaLPMT30"
    A$ = A$ + "00`6k\edF<Ek\aFk`R53C;=DKd`VEKbdJR56FZ::H]:HA4EaJaJVF5eB1\RE"
    A$ = A$ + "]`d25[JKa2RE@3:GPTRRKOPZhZ]SXF_;aZZf5Ac?Ia;Lk?bBRdkUTB^nDY7["
    A$ = A$ + "EPhS\n^SJbUfE?EfQd9:98N7UQ0^ZYVZbEK=7CWE2bQl9e7]aWlUd?^I`712"
    A$ = A$ + "jM@MKj30X2fS_U9YCA`XaN240Po6GeEBe@4[_;T<_M=LN:?bYLCMd14R3=<J"
    A$ = A$ + "iX[TjdAFloOZLn\TWZP1<FaJD5AWbZh8:C2kb0PGf`<0GP2`2Di_LI3c0L1:"
    A$ = A$ + "0;@UobkKYb17L`17L`17HRMP9P9F<VMT3000`6\5R=8fP5F:Fa`VD[KQ]`4;"
    A$ = A$ + "\I;4[K3Ze`6]`Jf0F1CKd`jFgD\VJ=eB;10]JdXC@4S6]fREaFd06SLdm;OR"
    A$ = A$ + "YGVSU[JDVL22oCELJT=mLZcLQCUQL77_;oj9en:\4;Q^NEZcnj;bOYF<=_Rb"
    A$ = A$ + "469jbg:KBl>H9KoiHAcgeLbKlFGRP<m[GS_=_fBff63]c7W[eZ_DT8JEYMfF"
    A$ = A$ + "K3]ccWG]7@jM>QfeY];eVKQoLnWfZTZ\RjZ@lbbl\`Gf]BKVVoaISD;WIc^]"
    A$ = A$ + "G[b^Co5FSXAEaFA05@D9mMjfWkn^10P7g@5W;@1X26YG>^Q:>GP2@5<B_lEP"
    A$ = A$ + "dJg17L`178f1aL@<78F<28VH7HRMT30000k]HSYHHJWHJZfYfHQ5f\YE=<\V"
    A$ = A$ + "E\Re]^JYUFc`JVH8FHY5Re4aJFHJSZE<<=<43[IE;\ZPF[OObeAR2lTJdhA["
    A$ = A$ + "6R4k3M4ioF`5D3egoAZ:Digboh\RX[b<C3ADj>MbkOFkf5Ue8LM@SYEUQ<4["
    A$ = A$ + "DO5BbZhlOGDn];82?BhD4=ia9dL=<gWm1faTD49d6CeKW6^NJQXa8ih@Hb;0"
    A$ = A$ + "TQ<cF@TNNT_5i0P7949E:F:KXG4RTm`W\mnb`B7MkQ^T4=DLd:RDILJS0F@1"
    A$ = A$ + "4]RbO96W_2A5=1Poe`@P;@3X3Zl7lG331^0=P>XbO`O500fBUHYhP3>h0a4c"
    A$ = A$ + "4k0C0C<c4;P3000X000Q4D@ATT3U1lII5D0N4[;REa6\UFcZ6RQE]d6aB;]Z"
    A$ = A$ + "Y5FgBCC;Da2;@aRF=H]:F@\R6]JdZAAD45DA5Lg;MT_UP6bVD\fGl9=H<P:8"
    A$ = A$ + ":ZJnSo=;]FeAXcAKL;Qn@SFgBGCS7RbMBn`>IbOi[nfGG[[]4RCj7Tj\=Aci"
    A$ = A$ + "AD[MKI_VAiATOT8CHGS7YW_0Imk7LU31baSPS:8cmT_Mbj\n1<>;bAKc:mMm"
    A$ = A$ + "J;K7eZ\lAh[kfjMKO_UJkjgcBg>nXoV7hbJ5MWEnDfFSAaZPR1<5]RbNZO7="
    A$ = A$ + "0hW=Tgh2D0ZPAj1Of@NS;@1X26Y7lg00P41K>b17LM`1aAL4?U[3DDVd1V[H"
    A$ = A$ + "000X000C\a`ZQXFLEad@4Q17>4Qi`C4nPQ;7>LDC<]VJ5[JQUFABA]R>@EEA"
    A$ = A$ + "7H5=jD7ZFQ[K;cT_2d:88HaHE5YQDB9i:kkJKEGC^DT0mF:H20;0@PMKFmOO"
    A$ = A$ + "[D_=7e9E^]_XI1HZ\8^[\R^2F8WNGJYX8gbDehUiQY<D:BC=Cl8\4f0H14g:"
    A$ = A$ + "c5U3FQJHD6Yb8Y@4b0kcY^FK;ib:;ZJ6EGoOi9a1=P00P51B0F=hR5181B;5"
    A$ = A$ + "UG9KnFc_MP3;FQT[BY<J?Oi[Gmf49=oaH5Q5@H0b:0<8L@X8TXjCUlZY?lM1"
    A$ = A$ + "nF3EIY0;P>`J7K=DET2\0j0[MlE00HK`D]e9]JS@3UIJWh4000d000<Bb`bE"
    A$ = A$ + "@FFR>4RH4ZAFg:JVg<cUQ<Ua<C9cIQ]:VfQET<cBk]\=\aB]C@De1Je92PHE"
    A$ = A$ + "55[A[]]eZR:X:T3]3UU`TofhVo]KGl_cmeCT`Tb8a@[``fCTU=62T5`R1<Bb"
    A$ = A$ + "P@0ba14>80`QUa:P@74:AP=aU4PL8B8GfZLPV@9T4P\S^3RlH4fF01cP\84B"
    A$ = A$ + "jPRbb:04Jb@2<P[E\B38=<g]MG1EYVQNe_1\8002582R<3Z4MTD3A62AD@iX"
    A$ = A$ + "@U^=FXS1J\;FjBZTbS]f23eO>FhOWMhHLEed<PB`>\KLYD97WF::]f=^^;Kf"
    A$ = A$ + "]UciWCK=?oZWfS4ic:<6;10;fP=:085RdGjn8<afH2T]\aDoLe00NH6UaFUd"
    A$ = A$ + "d6UF5gQV3cX<fZH>fXeZh\URO300<]A_5fNm2@[03aYV=<E[ZZTBF:000d81"
    A$ = A$ + "0``D<B`n4]gN;HeRmFM=C=]91kSgNkJXNK[gNKZCB94R`U3ONli`Ua[BVNWT"
    A$ = A$ + "cANO1[;FP\2S23\\LS32GL2<iX1iP@IE0X`P`0;35PeFEn\hJ;00aRB5=J[Z"
    A$ = A$ + "F?iQbR4H0TG\\\:0E@LMk]Io4b1eT:=HI0j`07Ed3bbTT];W>bF^Yi>PYaAa"
    A$ = A$ + "1Q1Q1[J_8oB6AAEF`Xe5gdFaBRH5E5EmFB91bBabi00YcUACbmd\DL@X<3dd"
    A$ = A$ + "c7hGlnX4\_k^k6cZlVJ>g5N?<_`bKnXMKZf0e`kb5c@AUW6B`>=gG[T?VN:H"
    A$ = A$ + "]I]=I]IQUVGIIQ6h2O]U[1?AAa4AZ]8@D<DF::lfM]CLhP4fCSRR0BKM[6@Q"
    A$ = A$ + "2TeZ\FSRU1`0JE>aiW;C4M00nG6GODGhY3BH1jbhiEo2AhP466n:00\_faBO"
    A$ = A$ + "[f`R\@ej6N9000:900C0cI<6@YD:hXYUJagXAbdfU3OYajcFmGQEJKEbXUK:"
    A$ = A$ + "A_iU=Bde=ec[\?Mj<ZEGI[1V4eGOAWG<L`@Z4MLXC3o^kVInVOaG7h<RVcoc"
    A$ = A$ + "D32^ZNNbNG=\nCnfh9`27UdfaY1W`HVlBM_@?:C`AO;DOfbSXULalc2e:7Ii"
    A$ = A$ + ":^QdGAbdD>R@o_<7C<<7j]XP2Bh>SYHm`[fg@o@KP^LMeo<4[m5E=lDV]^<6"
    A$ = A$ + "NkX7gk\^Mc[DUg;MgEb6Xo>SBWH:6:iM?<kjm[mXQ;]bW1KWm`fVY2@^\7Zk"
    A$ = A$ + "c^;XBX`md0WgTT]Yo_07GLZ782Sg6RU]@C06^6W7H6YcgFR7>ZdlO?;S\Wkl"
    A$ = A$ + "<1FolIolQOO<hm^UIVCaI8<U_hH:6P[R9I^B\Y\ifP`?[098dRn1cH^jYfh1"
    A$ = A$ + "00>n6YEJC166IQVS1:<g02ndaAX]5Q@@f5iKM4PgUagGl38\19P^<njBM0Y="
    A$ = A$ + "TShEbmme>KKS>D[ZJ^DB::000HHMK`jFdfWA[J8I8SFZfJFX=<ZiaG]Q_feI"
    A$ = A$ + "M]HJe?=WceH?;F^HNKn@QIfSTgYfIIfKWG\LAh;?nVGoQWOcP\LaYY:l0Oie"
    A$ = A$ + "MjUe8;0VnmIj\bcn<]EUE2ig?Ooe?okAEFAfCCTaaRbjUj7GGj]<b0Rm]mQc"
    A$ = A$ + "^7:0:J[k[k\HjgUE=TeemUejbjbjb@Fb@UEbdc9_SlckckcXYc:Q\^^_^C@>"
    A$ = A$ + "abb8757MWEFYc:[\7bhXkl\?kNTS\VCFidk:;nko=SX9goA?MU<]U1[h[k[2"
    A$ = A$ + "00Zlnj]RBIYNA<TRQA>[mi]7B;[9C=eDC5]gEG=5SY^oS?FLU2lacK?0<000"
    A$ = A$ + "0@FGaAFcckcK?IUE20<Vb^fd0la_00LeEnaDAkM5_OIZYhoV=3`7e:1Of73Z"
    A$ = A$ + "^^CSVUg6TeZ\P\l5_cLcoiSblZh:cg\0R8:::j];O]U?A00H_hibXAG5%100"
    RestoreFile A$, "block.ogg"

    'drowning.ogg
    A$ = ""
    A$ = A$ + "?MfIC1P000000000000f^00000000hcK@FF0N4PM_9WHY=7000002@4[0000"
    A$ = A$ + "000004W00000000^1ldIW=50000000000000Hk200400000bibH[B\cooooo"
    A$ = A$ + "ooooooooooooooooA>PM_9WHY=g:0000HU6LXibCbM68\UVHFmVLRUfLPT48"
    A$ = A$ + "b0C<b0S<`<38XlDK^U6LbEfLUi6MY00000@05HgKb9FJcUR@3IE00P0000@<"
    A$ = A$ + "<1Ba02=TE100@000PAB:><YI9UBYD6::iQ9U8UD:UBIa`T8VDVHaH<6SaH<6"
    A$ = A$ + "SaH<6SaH<22=TE100@000RB2>>Zi9YVciL66WhXLPVCJ>QcYPLPRA1N>98Lm"
    A$ = A$ + "V<VKVB[Y[iVcYD22=TE100P0004BQD85BQD85BQH86RQH86RQL87bQL8WbYL"
    A$ = A$ + ":X2ZP:X2bP<83bT<YCjT>YCjX>ZSjX>:d2]@;d2]B[4CaD]ESiJ_6d5OciL>"
    A$ = A$ + "WciL>WciL>Wc98d@F500P00048T1I@642Q@85BQD8VRYH:W2bP<P@3IE0008"
    A$ = A$ + "00800000759595;5;7;7=7=9?9?;A=A=A?CACAECEEEEEEGGGIGIGKGMGKGO"
    A$ = A$ + "IQIQKQKOIQKQKQMQMMOQQQQQQQQQQQQQQQOOOOOOOOOOP@3IE008100XSTSU"
    A$ = A$ + "SWRXRXQXRWSX3@XQ\:00T100400898Y8Y8iX9IZIZiJJKJ;J[JKK;;;;;;;3"
    A$ = A$ + "4J8[200010010000000XYYYYYYYYYYYYYYYYYYYYYYYYYYYIIIIIIIIIIIII"
    A$ = A$ + "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII14J8[2009000MLLLLLLTDTD"
    A$ = A$ + "TL\L\L02=TE10P<00P00095;5;7=7=7=7?7?7?7?7A7A9C9C=C?C?P@3IE00"
    A$ = A$ + "0800800000000537577797=9?9E;C;G=G=G?G?GCGGGGGEEEEEEEEEEEEEEE"
    A$ = A$ + "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEP@3IE000100@8MJVUZ182c0IHP@3I"
    A$ = A$ + "E00P0000H4:23a02=TE10001000RQB>8J2]VcgL>>XIiPV:5K>M`9BeVWTKZ"
    A$ = A$ + "H^iL>WciLbVcI<>WciL::WIaPV9dJ>Wc9aPVU2JV@[iL>WW4KN@[Y:]VciL6"
    A$ = A$ + "WcY36WAHL>WcY9]V7TJfH]iL>W5dJJ>ZiBaVciLRD^i9eV;EK>WciL>WciL>"
    A$ = A$ + "WciL>WZGLjL`i4>WciLRJ_iJiV@GL>WciC6W^gL2QciL>WciL>WciL>WciL2"
    A$ = A$ + "2=TE100@0001QQ=66gYPPdWS6865QHJ8Cj1M?j`TP63bY@Z7=jXA:UjP@9E6"
    A$ = A$ + "WD:M22=TE100P00042QD85BQD85BQD85BQD86RQH86bYL:W2ZP:YBZX::Sb\"
    A$ = A$ + "<;cb\<;cb\<[3k\>[3k`@<43a@[d:aB=EKeH=F[iN>W[iPdJUF[eJ]BYD:UB"
    A$ = A$ + "YD:8d@F500P00048T1I@6TAQD85BQH8VbYL:W2ZP:P@3IE000800800000?9"
    A$ = A$ + "?7A7A7A7A7A7A7A7A7A7?7?7A9A9A9A9A;C;C=C?EAEEGIGKIMIMKOKQMQMM"
    A$ = A$ + "OOMOOOMSOMQQUUUUUUUUUUUUUUUUUUUUUUP@3IE0002000P@842QD85BQD8U"
    A$ = A$ + "RaH<7ciP>9D212=TE100P00P00000LDLDLLTLTLTT\T\TdTd\d\ldldld4m4"
    A$ = A$ + "555===E5M5M5e=]5U=U=M=M=U=MEUE]MUU]]U]e]mUU]mmmmmmmmmmmmmmmm"
    A$ = A$ + "mmmee12=TE10P400P>B>B:B:B:B>>>>BBB0Q6bZ00@600@00PRRSRSSSSTTT"
    A$ = A$ + "TTUTVTWUWUXVYVYWYWZX:@XQ\:00040040000000PRVRWRYRWRXRWSXSXTXU"
    A$ = A$ + "YUXVZV[X\Y\[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[;@"
    A$ = A$ + "XQ\:00T000dAbAbAbABABABAbAb18d@F500b000200L<L<TDTL\\\ddldldl"
    A$ = A$ + "d4m4m4m<mD5M5M12=TE100P00P00000000<T<\D\LdLdT4UD]D]DeD]D]D5E"
    A$ = A$ + "mDEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE======12=TE200"
    A$ = A$ + "I000TCZYD[W3B86TiTH@XQ@B4cAaLYCjL>:G<N8TSHDB]7bD<311eR9d9E85"
    A$ = A$ + "D;^FZeaLD]HS]B6B1eR]6;E8USj12=TE80@XI0P37707==07;=0000000000"
    A$ = A$ + "9==0=AA0=?A00000000007==0=A?0=AA0000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "0007==0=AA0=AA0000000000=AA0ACE0ACC0000000000=AA0?CA0ACE0000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "0000000000000000000000000007==0=AA0=AA0000000000=AA0AEC0?AC0"
    A$ = A$ + "000000000=AA0ACC0AEC0000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "10001h0004P525J8[80Ph4007>>@B2BB`C3PSU5llPW6<=1hHI1??Xi1CC00"
    A$ = A$ + "00000000000@bC3NN`c3VV0TdlPW7llPY900000000000008ii1??hi1CC0B"
    A$ = A$ + "NN`c3NN`d40000000000000l<=QY94=QZ90?CCHJ2CCHZ200000000000000"
    A$ = A$ + "000000000000000P000P1L0002`4:3DXQ\R00RC00LhX89100PSTTU5000:B"
    A$ = A$ + "BFF000HIIii100PTUUW70000000000000000000000000000000000000000"
    A$ = A$ + "00000000000000000000000000000000000000000000008000H0700P0<Qb"
    A$ = A$ + "05J8[40PX0007::FF077;;PSSU5@Bbb2PU50==0NJ045108000X0700P0\1="
    A$ = A$ + "UHa1X@3IU004500h`AabBCCDTSSUUVVX877;;==AAFFJJJJRR@cBCCD4NNNN"
    A$ = A$ + "VV`ccccd4RRRRVV0AACC10005h0004P=XY4;>05J8[40P@2007>>FFNNRRRR"
    A$ = A$ + "VVVVZZLL\\ll4555==EEMMihHIii9:::JJZZjjbbBCccCDDDddDEee5JJNNR"
    A$ = A$ + "RRRVVZZ^^@CCDddddDEEEee5JJNRVVVVZZZZ^^`cCDddddDEeeee58:JJJJZ"
    A$ = A$ + "Zjjjj245====EEMMMM1RRRVVVZZ^^^^0CCCCEEEGGGII0VVZZZZ^^bb0DEEE"
    A$ = A$ + "MMMUUU1XZZZjjjj:;3`eeeEfEFFF60^^^^bbbb2000>`10080SP>9SZ\8\AC"
    A$ = A$ + "h2?0DXQ\R00R2000<6VBaD:3S9Q@:4JH<94BQ@VDBYB:UZP@ZDBUB54BUBZD"
    A$ = A$ + "bXD;UJYD54BUBZDZP@ZDBUB100H7h00PMP525J8[40Pl0002SAYH<WciT8TB"
    A$ = A$ + "aH>Wc9A8URaL>WCZD<VciL>WD:I<WciL>YDbH>WciLBYTaL>WciTBYciL>W3"
    A$ = A$ + ":UBYdiL>WC:UB94jL>WD:UBWciL>100@5h0004P=:bVC`81EXQ\B00B500<h"
    A$ = A$ + "hHIYYii9:JJJ99YYiii9JJJJZ99YYii9:JJJJbcccCDDDddDEUWWWWXXXXYY"
    A$ = A$ + "Z:GGAAACCCCCEEbbRRRRVVZZZZ`dddddDEEE5VVVVVVZZ^^`fFEEEeeee5ff"
    A$ = A$ + "ZZZZ^^^^0GGGGGGIIP[[[[[[\\000l4L00P:`6FM4>YXa2\@3IU00T100@H<"
    A$ = A$ + "8T2Q@8U1Q@:42QD:529000H0700P0<Qb05J8[40P`100021SaH<6SaH<f`HH"
    A$ = A$ + "<6SaH<6Sa4W2SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH"
    A$ = A$ + "<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH"
    A$ = A$ + "<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH[eJ]F[E0PQc5>0@"
    A$ = A$ + "IAHSc`:9MFQS6LQ6b:108T000`H@863jT@YT:YD52aH>XDBUFZUR]:4RaP@Y"
    A$ = A$ + "TB]F\5S5?Wc1QB:UJYH:f:N>WC:YD[5SaH\FL]@8UBYF;fR]H\9KQ@:UB]F<"
    A$ = A$ + "6[eHcXD]DZeRaH<6[aRBiBYD[5KaH\FS5QbVK]F<6[eJ]FC:U?gBaF]FSaJ]"
    A$ = A$ + "V<:SB6SaJ]6[eJ]8D:U<6CaD\F[eJB8<6O?6SaJ<W[eTB8<nN<E;aF]F[9UB"
    A$ = A$ + "Y<2I=VZaJ=WC:U@I<fH;ECiL>G000e3>00D9H4d9IDU5Q=J2Gh1P2=TE20@^"
    A$ = A$ + "10022YD<6SiL>WciL>W3BA:6caL>W32Q@842Q@:2aH<VciL@842Q@84BI<6c"
    A$ = A$ + "iL>842Q@84:QB:UbH>Wc1Q@84:UBYDBYDWciP@842QBYD:UB:UjL>742Q@XD"
    A$ = A$ + ":UBYDBYD842Q@842UBYD:UB:UBY@842QBXD:UBYDBYD:52Q@8D:UBYD:UB:U"
    A$ = A$ + "BY@842QBYD:UBYDBYD:52U@YD:UBYD:UB:UBYD:4:UBYD:UBYDBYD:UBUBYD"
    A$ = A$ + ":UBYD:UB:UBYDZD:UBYD:UBYDBYD:UBUBYD:UBYD:UB:UBYD:U:UBYD:UBYD"
    A$ = A$ + "BYD:UBYDYD:UBYD:UB:UBYD:U:UBYD:UBYDBYD:UBYDYD:UBYD:UB:UBYD:U"
    A$ = A$ + "BYBYD:UBYD:000j0700P0<R:]@\Cch:?2L45b`4@5J8[400b000474;]F[eZ"
    A$ = A$ + "<:Wb9UD[3IT6V3:YHWd1QD;F;E681YLB:eYP8TR1YF8SZD:VCJY@;SYD<8f:"
    A$ = A$ + "a@7SaLD>UCU@7S1000PP00`0A8c48@1@16830P3@81Y00X`2<da`514@^4bX"
    A$ = A$ + "03:L<Qc9MJ30044R<3AR8F<8a4Z6XXRY30Ha5H8O0P<dHSd^h2X;3`5d5ge1"
    A$ = A$ + "2QP@@88FL0D09P3>QKh9N3?QK`9XCAUj01000000N00h1008I3P8R8JVSS>l"
    A$ = A$ + "h3@2ATA8Y4C>151000000\30h300895P8R8JVSS>lh3@2ATA8Y4C>1U000@0"
    A$ = A$ + "4000000@04028P0000000@0000028ldIW=5000<:00000000Hk20080000`@"
    A$ = A$ + "?:JSJ@4B7MeD>mOTo7honmO2oCho7noAo[eoom?PLU`X34P:<_ZRb:X3j8TS"
    A$ = A$ + "c30QIL90d80F_<:\<?EP8HRKU^JL_@hXGDMQH_cjndM[mZKeM_AMO6[P]n5k"
    A$ = A$ + ":@RH`FG0I00E5<9M;<<GMfjDDe`<g13?EQj_?0H>S91P6I0XB5N>jK>^j=NJ"
    A$ = A$ + "dGYCAoj<NjA4a_M]g^go\b8CE=cEn_i>gKbP^Uh9nNabf?0C9<J<1@]0^;VB"
    A$ = A$ + "HDi6GHkl>V?0HcH<0XQ0`Hfb_NnmCCl;^bC^CdO?OcoUbmB2A`ggQ2LdKG<^"
    A$ = A$ + "6d<P;2XlOAn6XhIbbg_V0@Io8<?JFCMMlFWDI0aHkKB7cmQQgJ[E4A4K5lD0"
    A$ = A$ + "`h]FE3Y2555FdZ]RZjRmbRZCE][Ee8RXXXG_N5A0KEE][D]QF;11AJI722R4"
    A$ = A$ + "cj^VSJ<FgjFebE_U0@On4<4SgJZRCUjnn9H86_TLQD6Kn0TWP2f10E9P_0Rc"
    A$ = A$ + "02U[2ZZRGS6E@FI5`2fOU]:R^@0EAaRF<JUT>@AjYFdNPH0AcRRF[Zf@V=Z\"
    A$ = A$ + "7ZaVZ200dG?MF9kWa\:3]\?Oj\BfG3IEFJiImVEb8H9B0K30@]6[:ZH1R8Sa"
    A$ = A$ + "LA@AdZeR2:XZ5AAaHA[jnJYH[a2H:XCN@4=ZJEaFZ6FJSZQ>5000JK3A4^bV"
    A$ = A$ + "XEl`Y]JGbLACLK3A4^bVXEl`Y]JGbLACl?008SZEAMZFKTEbd78SbJU0e=1X"
    A$ = A$ + "4\_WZcPTmmcP5R2\YmmLafgcC5QiLOCL7000]69@T0eJ`HD[JDS0PX6S886S"
    A$ = A$ + ":Z5[00PaJE@4EDk<D<`N<aFK0@=\J2VP200FE3C1K<D;Ra`8Uh2aW73G1h9X"
    A$ = A$ + "0l5@5eJF0RHS0fP5ZX0HY=JQ20HY=::0PEA0@5Ca0e:f\=;VR=R:8PA3000@"
    A$ = A$ + "OG50@\>dP08HH=00@\94EDAa6=5C3KfjHR]40A5eJ6V202Fc:Z088Fa4d120"
    A$ = A$ + "8H008_H900HSV0ZXRE]^Q20HYe5E04a60<]I14[YRR::F5100MJa0PZZRR2X"
    A$ = A$ + "HQQR=JYQnI040610035edFJ1R9FP00R=P0XRJ=3E00eJ680PYe=DajZ5FdY>"
    A$ = A$ + "5;0P>D10@\V20P1Z00P:fjD7aQ00H00@EaRFA7PHEa06E]200j400`j002FH"
    A$ = A$ + "H2VFC4\VH:0PYUF100C[KQ20XED@<0:j@EdY5f4RZ0000hU=TTcTB;B?<CGJ"
    A$ = A$ + "8LJJASLI39i<YdRd3cdU62WVFd8o70000P_10PFHCf?@H@nC@68[5A^_kd9J"
    A$ = A$ + "1KJOKG\c0[m]D8\VikRk000Xe0@1P8QV830D0TfJ70PJ7FD00aN[8fHSmRJe"
    A$ = A$ + "F3@aJ=PJ55100;:ZP5AE00`ZPRX8R`2B107898004Zd4CJDn294GA92abS10"
    A$ = A$ + "488EH2300T01[I55ejf4RYE\100\`V]404\9;<101K10H00[340000@a6E00"
    A$ = A$ + "0D4M20PED;10`2K@10E\A[2VH3P5FJE00\Ze<400KdB10D\A500eZ2H3FHYP"
    A$ = A$ + "Q203007HM300\dd200\>60PRUF700eJF0FJ5;0]::00X3E00`J600Pe0003["
    A$ = A$ + "PP=HZld080LP><00JDD10`JX00Z5F1003[J2VfT8H5E10`j600P>E10@dJ00"
    A$ = A$ + "\F0MX][0800P1PJS2H]00PZ500dY10@aJ10@[61`V0\^800H3V00HJ=300<]"
    A$ = A$ + "1401E\6RQQ=2R200:hS=TSc4EKB[>U;SU\;JP7K87W9ZfTFM:G6;IGd0o700"
    A$ = A$ + "00P?PXXFP8Z91D61\OPDkP];FK:ggMj45HCG14\WcKk>mD8<cggGHB0000X6"
    A$ = A$ + "0R0P0I=@20R5`:0F4[X0PHE00E\HRHW=F5\JW1:HH1CDk=<a>K00\e0E@5`:"
    A$ = A$ + "00RJR0HHS2X0088YdhC10ShLhC8004N2aU`U?T6G80G:;2fP5Z8f2K4DCK@1"
    A$ = A$ + "0a2KQU00HcFH00:f\90200F310000\2J]A00E]I3005K900H=;D00aZf8HH;"
    A$ = A$ + "\:HHCF200fBD04\1300ad:F100C;<0KdFHQPa02=0T30[JC600HY=202:F3a"
    A$ = A$ + "`V<AaVA10\dJ200Je20P2J10`05\^e4Ja90320P50R=JM@dZ20PR>E10`JZ2"
    A$ = A$ + "0XVF10@<\V9HH3V2FJ=A0@`J:0k0HZ200ZZHdY64<<00H3:jD;HA100]80PR"
    A$ = A$ + "e=104aJV00P=SRE\9C1KBE00aV=10``6<100K0100[YZ9hU=<db4dU`UOV?\"
    A$ = A$ + "C2kPLI33]<1M9LiWi3kT`>8oYf0XJe8QXPXX>Y8R<H;E>R8M8E2h87L`1F<7"
    A$ = A$ + "LP5SHVWR1000[X0XHA4@@]F[A=64[XF0[KcZE\ZE<1;\1;<]`PX35SXZHAA0"
    A$ = A$ + "[ePAEa8F1;Qka?A1bR2@\5SRF5[Ha^Wd24`@@D[K2HD9oJ`k4FQ0PXaR61A4"
    A$ = A$ + "E029GNA9iP?eR>e2R00FLRJMOMQ130P2XAS424?HFVLM24bmnDF=:6i4\JY5"
    A$ = A$ + ">hD41PN<GVlk1P@KIQHJaQ:W0^4h0PW0Al[i]<>i;08D\>b0oWB>?m2Q@MGV"
    A$ = A$ + "9Jc>>8eLLBP02FD1[E;REaH`R60A][FJn=\=7hO=Tg:VbV<n8dNeWPbiXne@"
    A$ = A$ + "N[H:KbhS@kEO2:WSjcI0b:e1000NCMbZ0EZ9Q4S;0ce26kcm3J1T6@NKQ4;4"
    A$ = A$ + "kk2\_W;FZVKY\kd100P:0H\2H0<2D2T01;6044`0XH[510A]g2H[YQZfK104"
    A$ = A$ + "03D0``N`N\7<]E5C3300`@104aND\gRZfI00ZJ8:XP5;V:0HHZDNLh195@@R"
    A$ = A$ + "8B9=:0@00[Jc600:FG00D;]14000A5<\9E00[8VRE]V=1VF500[C00A7J10D"
    A$ = A$ + "Ed00HHQ9Re]:HYE41@`JX0PJE[10:f<00R=ZJ00040@0@\R]4\1\ZXf2[00H"
    A$ = A$ + "PeA1@]930D\ZH0PREE1;]`60a00100<00X54KdjPY500HE300\^Y00R=H20Z"
    A$ = A$ + "HS:H3F1\`250@]AD0@7:008J@0@a0\AC1j040h0@5@7X5D40^D`kF005]60@"
    A$ = A$ + "WZ2JEdPXXC00\^0086V00R>000=PXCM2R1003`900ZH8HCF3a`@50``J:0:V"
    A$ = A$ + "F310aB;1H7d;0hI=d:dU^XYm:biZ?33TLTcJXEX;MACkETcEO668i8o70000"
    A$ = A$ + "PO000D914Qmk185H9=X7kGBSU3j3@d2Xgn563k4_]UCHLKgYWbf600020Z04"
    A$ = A$ + "D2T0D040H4SX08Z:HaNE00aNDD5\700e`010`6KE\ad>``2F\c4E\2Z1:XP="
    A$ = A$ + "RZf;0026:0PJe2Xf10HeN45AD;Li`00RDLT0\0P8^HRcQ8\X22^L4P50PADa"
    A$ = A$ + "i`104`A0Q9@\ZE<4eF800F5K00`jFc200000@dYX00PPe105KD00DKd00@`6"
    A$ = A$ + "<E00[IE0@5KdB00Ca2500FZR=Z00Fe`2003KQ:0Pe\VJ30PZfX10PUFJ00XF"
    A$ = A$ + "300;D`dV]0430l006X@A`j0F00P6E00dZ50@\^20H8F2FA3XXCE00=J<0P>4"
    A$ = A$ + "302J10`D0[K8P6800<1<\AE1C00[E104[310@]620HE4A\95\d:0PReE00\^"
    A$ = A$ + "00U:8jVe1P0006P30@`:XR=KcPF5500MXA504aj00RYe10@S1=P10hY=Tdb]"
    A$ = A$ + "`VPilUQ97dd6BJiFHC`Lnb`T3jW:P\\^e0b\\8RjA:S0>@2^4PM1R[iDLATc"
    A$ = A$ + "iTCedALZL`Q5\i0000\80Ra8Z0ZAEA@5\ZJAEeddD=\8RZZY]VfYR98F\J?0"
    A$ = A$ + "2RMZJEKf24a`@\5Feddd005e6D00[R108REA]ZJ]VlFS4YDBMSQQQQQQ:HHc"
    A$ = A$ + "PHZH0ADd20H=:R0HA[=0PF1AA;XX00PRFKS]eY0@]_elMXFc`D5E104FQ020"
    A$ = A$ + "PPQZZE]9@@503j`P]A[54A4A7R10dXC\ZF=H[30\Ee00PXC308:60`:2:jd0"
    A$ = A$ + "RQ<h0PO[L4AA[=Ra0bU49A3F5a00J<FA\]F10@E4PS6`10PX:Pe826N:PU2H"
    A$ = A$ + "0[E0;0D1R>POfnE7mL7@e`:2hCPXU\V9P200:@j=002PYQeD4]0PP6[JKn_="
    A$ = A$ + "3WJ8^gJ0nH33i:1A1nKNIFYLR7KH8G98:`Oc;c:UClce1XfJR0Z200g]AO<8"
    A$ = A$ + "4fF`IP9VR;afgbiidA4kXDURS4GKY0000D1\ZeH]:XFDT40\cZ2P=6f1:H[="
    A$ = A$ + "fZ8Z1Z16ZEEA<00Ca``ddN4A2615D0:Q;335D8Y=Z0RZFJQ00JD1@0=8F0E5"
    A$ = A$ + "\`6D3C;0DAc8PXA0@\E03RE1@@d00XXH\>0E;0\28n1`2A1@A4CeJLVm4HL>"
    A$ = A$ + "PP58f8FA=\@544C;<00e6AAA`V@01;\RUHJSRXZE7808j000M:ZR5dXaR1D3"
    A$ = A$ + "4[JSR:202P3f2MZE@a00R64;6]0PH=:00R=R>EAES2H0MPH1@[1>=TERXC11"
    A$ = A$ + "00P40A47_X1Q2F604=Z0PH]P>04=00J0CO5ZF0@D05=P0>101h`ReXa2f0P2"
    A$ = A$ + "`:P3C50D[RZFc0aJ8:P56VR::Z>E@\H5[20X3;JA3RH0P=00nG3]\ZA:3:l^"
    A$ = A$ + "MIM4dLToJXUE=BI@Qg];[SPVSlO00000NGC0bb041FYm;B;>38b?0XGZ^`2G"
    A$ = A$ + "Pa^Clnf>A^_URSbgC10005P<044E40\Z0XHE5@\Vf206fJW:H5e`Z96ZMXf9"
    A$ = A$ + "0PJ[10XfJ1K]0HXF1@`>E<Dk0eZXf8VZE310<=\301[XH`bb1P2QTRQ308BS"
    A$ = A$ + "b1D>Rb:RTL90P8X=I504\1[20HE;40@]>:0Ze50000@S>00[C=00Zj40@A70"
    A$ = A$ + "0FX:6fP:VFA00aJ:0XfX00PF00<00`?0Ze50`2C;1<1Kf20@=\140DK40`JX"
    A$ = A$ + "00FAaVa2<@Q90R1aoc`V0[208VF754\6:0HSR00Z=9R5f2CDKFD0dR20XPF0"
    A$ = A$ + "0[90PRQ8FcZPQ0080P102:R=[ZH90PP2PPe@00[30ZJJ55KFA`Z00FE10dP1"
    A$ = A$ + "0[10@e2JA1[`001`1REd1RX20X100[300ajX0HYU6HHCZHQH20R=Z08Z=H0P"
    A$ = A$ + "ZFJ108jd8Jd9f20P2hO=dFY4;=YZo6G>aQDc9j[Qf:UHY9Emghb9>TJ>Ao10"
    A$ = A$ + "000h>@P4`n2;m0G;FK\W6@:f56HOWhmmLR<OK12T_;^300P2P2P0=90`>k50"
    A$ = A$ + "aN\C0D33[:0VfJ3Z=fQQJWPmRYJA<10\c4DD\PYmZ5DeN350aNEaD0;2R5AA"
    A$ = A$ + "\70:O>4@YRcU`10P8452c`A@9i:800A4eZ00f\10P=ISZ2P5F10@Y10@]10D"
    A$ = A$ + "\A300;]>:0FHQ20FHE`:6:H=005[20ZJD0XM;`10;E`2C;10aVD10CKf250e"
    A$ = A$ + "6\RJHSfXR]404`6D0@]A04\RU:0HHQRE]52RU0X0;3L5FHSRJQ008F110[;2"
    A$ = A$ + "0H5;E0`dj2FG=`2a40`VE50a6@0@Ed00F[RP=YPQ0080`O10<A=]AA=E10@W"
    A$ = A$ + "00:XZ0H:F00H=CD[I1ZYE00\R00X510@;0PHR:fXZH:o0PA`F78R10d860@7"
    A$ = A$ + "00f6A1`Z66H=C;E3KfD1`B;]@11;4[20H=00e`24Kf2@D000?MfIC1000c50"
    A$ = A$ + "0000000f^000300004he5KN6mooKo3hoTm?4o7go`mO2oKgoUmoKo?`oTie="
    A$ = A$ + "D143n26]7N6^J72Gg@5@<h;HdNhIhZM8lMP0A_f3Tk@ZBU3>@\3>@<kPH4C<"
    A$ = A$ + "c<kP0R1000D1D[FEC0Ck5CK4kDe`dF3D[F]JWA4[EWZj@;8:J`d0;\`23\1;"
    A$ = A$ + "]dD\dPBMaDhh:1=:0D@[6Ea:00G60@DDD44A\AdZAVlk?99L@LnR5G7jh17G"
    A$ = A$ + "`ZYDE14?e78]2R2P89^Y_k:9L@OH4[DVoJjf^0Z_@JdA1fM@lo7h7?diFfO;"
    A$ = A$ + "[4BM\FfaPJAOoSlSBR\G=?84VYPFn;41gO=i3YVkO>=i;6O]jVABD\`>>N_U"
    A$ = A$ + "TW1R4:3[6UTki>ZRXXAD100cWZX5]6[JU0P?f@EUD4D<cB];?knb1N\QZ:Y8"
    A$ = A$ + "XHVUJGNfmU3lO00000N35e9Q8:aH\\=gV;8]58?WggLjR[]LNK?E4i40005P"
    A$ = A$ + ":@Td41@2PAE<0FS55`ZH53K=53K14aRXH_20F\1YaU1P;E02;03QE<AI5P7["
    A$ = A$ + "4BCH25\DF10ZH;A1`6=005MH10M2JeQ6\F04D<000PE500]8Fgj8Z90HJ50@"
    A$ = A$ + "AD10EM20R>=JdQAWR0H[C10\60`0C0`d0C[K==7400PX00ZJ1@dYF0@WF1@a"
    A$ = A$ + "V5DK1Xf00XR>005MP08FE10\@aF2I456:1[YVH:0PQH20FG0D<]R0PJJ5<]`"
    A$ = A$ + ":RH=50dQ20X130FE003AaB[c10000L06FC130@<E0@]00`J00:j0[E3:X28X"
    A$ = A$ + "a0PXe6@E30@D``jd43@74eJR8R2XH90PX1045]0P5RR=2RE=10aZ0XHM104="
    A$ = A$ + "60dReQEA300>a4;]`6`050ed20@A<0RZ>105E`j400P7f@E[BPVCD;Lii7iO"
    A$ = A$ + ">AQ=DeZ4Xi4e2GNnAnWCdO00000N3ES2@I1TC:M0H]OI0afIP5A[18OgAkK;"
    A$ = A$ + "@PlLRcgLj4i6000:P@2BbB@2TPZReH1D[JA0\ADed>CaFk0`2:0HeD==<0e`"
    A$ = A$ + "DaF30@]7`N00K=DAEEECC``20HADAicQ@8\@80`b2Y4@:ai0ATP?5P5LY4`2"
    A$ = A$ + "K@50\1103;D05KYZ000XH;10<\V02f40P5F30edZ6H=<aj620:JE10A;0:J="
    A$ = A$ + "0H50004X301]0P6E3PJ53\`2C4[10Ze50`BC10E=00a2E\A;iG01000A00d2"
    A$ = A$ + "Fe64a2504[Z0P=20ZJSR28FaBA\1;a:Z90FA70PZ>40`:20HX:FJSTA20]4d"
    A$ = A$ + "ZXPe20FE10\>@0DED00C[:H3:HM00MH0@dH0``40`B0[CC00<L0ZXP510d80"
    A$ = A$ + "PQX02F30`BA`J2ZJ00FW0HAE50<=105A=\A]YQ\0L2VZYe]6H500;\D1@\A5"
    A$ = A$ + "0D[:08j0Dd000hQ=dF]5EV\[2YGN>mVULH3]EKAU9kZ@jUWC_I9o300DYBm:"
    A$ = A$ + "[68EKj=bX^BXB2iTBC7Be<EiiiR]_kd5Gc9?Mj>MRb2T:000D0:01@EeRE5<"
    A$ = A$ + "HaPZ6[53H4A@AEKa6\e@5a>0C0`ZJ00F]8=n<02@i2606247dYX0PXZ53XXJ"
    A$ = A$ + "04A5=ZJ]FHW10QRiOA4MRZR00X18[Pk[0F72:jdF[00R630Z:0P]0Hd:R6EM"
    A$ = A$ + "bQ=E9`60\00F3RQ=S8F20FHY28R>D10[30@<\43[[HQ5:0R>=0X130F30Da@"
    A$ = A$ + "=\djl<H0j595aFRJE10DC305KdB01[9VPZZ=;HHcVZHS:0ZJ540\^X0RJ20R"
    A$ = A$ + "U8Vf8gC@00PmN2R=RRX0PE440d10PF10DdPXCE[5544dP1@E410[0HK4\FL2"
    A$ = A$ + "0<0j44E0@\:6@SZ10=20HHYRe=5\V9`:QC=2F8P2HXHJMSYQ10]FQP]EeZ08"
    A$ = A$ + "2J1dC3POf@BEMB\Dj\4Oi`nH7P?K8YZ>9F:MFR_LHO\3`?G3XJE8ZT00PcJa"
    A$ = A$ + "PYS8f17L`1a4;EY@\34CHP9V9NV2000`J@5[eH1;RX0P445[V6P=fKEDA=TR"
    A$ = A$ + "ShB91?F0`:5;35j0dZE`jDAE\260dJ0S8F\P]X3AESZX:F2H2l04d0jDW:8:"
    A$ = A$ + "VOjZhX>YhH:C8V?=]Pem:EgE9R000D:M`Zm`5aU4L\c3G5E@DjI8l;7IW0cP"
    A$ = A$ + "TEIIlDM\X806A@[Z8M`I`AC<F5015@dTI2\1NJ;B<L3V2bYR;aLTnXT32^_:"
    A$ = A$ + "`ZE>fHMnSnl=Z\FlCfISXj2>9V]^:?S3NVI`ZF@[=:0XRPHaJ444A5;8Z:2:"
    A$ = A$ + "J`08o=C0nI3I:RHT5cZ7aEWYVeV3lI3I:RHT5cZ7aEWYVeV3lWJP\B=PjTZg"
    A$ = A$ + "\RZ94E;aKAF5D9P8G3bd8Qd`Rlmie0BK;\HPm]DLdL:PSbim=W:000D[Pa8Z"
    A$ = A$ + ":H`:ZP:R5`J50`8FD<Fa2XZMf[RE33[F5@a2PHSJP]8f300PMRJ1[He4<4[R"
    A$ = A$ + "Ym0PJ7:0f8P96V:06@S6E04MH@E;000PX30[2PPF0D;<0@D;a2[ZH=50\>0R"
    A$ = A$ + "H5C0`J08H=4Kbj6]60[2000P20XA1``614e:F10`ZP=1F30`ZV08j@50dQ0?"
    A$ = A$ + "0P;0@<DE]5PE10\>0HQEE5``J0PHM\dd2\RH0DeR1d10P610D4dYjg9080j@"
    A$ = A$ + "WJ1]00J=0:Z60d10XXeR>EAAa0H]0P6005104a:JE13@0008P6ES=4mPX1d0"
    A$ = A$ + "0RF@76AS10M20:R1@<00<0[]W0@BP=PX:0RY90RH90Ze40\`dDEK@<\V:P:F"
    A$ = A$ + "g0XXA50d10PRPZ6D<0POf@QR8ifTMfEnbIZIgLR?KX@ATLKb>k:Oi<e\K>a?"
    A$ = A$ + "G1RbJAXV810PGbJ;P<2`1d2bcgMde08O1kKYBPI^0C74Kjd5g100PX2ZEEa:"
    A$ = A$ + "FE\VXR08QRa00F3PJ1Ce`dNC`NA1<5K`6;08VfSRXL5EDaT440NL52DHE;`F"
    A$ = A$ + "RQY=H10FR50RY=H0P5H2J43000Zj40\6H=KQea2;00[50\60D3;0@]d2`6ad"
    A$ = A$ + ":60H:F08Ze<0`@=1`D5eV]2UP000H38Xa0VF30e2;0@]>@3ZF720FA3PPe40"
    A$ = A$ + "4C;1@a0;]UXV20iQO206ZZfX=P5FX8PYE55@]10`2[X0P=8H;4aJH@@A780j"
    A$ = A$ + "00@E50;:X3]j<<30oEdYF4a0XZ:0P>005530j0S>@3605=0P6<0ZZ0P88FCA"
    A$ = A$ + "50:010\AAW6<0f20X30@A<P8j`XCSB3:<7=X72iB5000UXXa260S00J<0:R:"
    A$ = A$ + "P8FA5\A4CC0<4=7g3g;0RXHM1<D0NI31IX9IF6MN4o`iJ9\3`U=4TQVTIIdi"
    A$ = A$ + "Al3W[U`>0oY2TA=P:QRjTAT@49^40>R85`AlD<F<a4SHR9VIV9>EY0000SE4"
    A$ = A$ + "@]F1aJ5A<8F44SJ@DedFe4A4eN;ZJZVFC4;]`0CAEEE;8UN2Q^IS:::jDa80"
    A$ = A$ + "hLFYUPH86ZYE]VHP2[@o60=2fF<FE05D9eZH@E@44E@7Z[>`om@CEdQ0HK\1"
    A$ = A$ + "@dP0FeRa@gY>;`G6nDLN[b7oJ;_82o4SoMWL<c>OG;g^h420ifkOioLYA5f<"
    A$ = A$ + "9nfF6Cj>P`BC<@d0SZ[h_eVVeRF=GnFdeiKR<klbT1no8iFd6RVY4\P]6@[2"
    A$ = A$ + "0F1R[KDE@@11]6a80]00nI3mZhTb:6mn<n`iEVcBn\QNELBI5SNO6Ohl:cI9"
    A$ = A$ + "oL58ZW4D[:00`kj41ZF05BiPTmd;Pi19Ph:?W8gc9bL7AHj879`LW8W000`Z"
    A$ = A$ + "26SeJ0SA@:401@`:FE10[A=FECe00[F<04<@]E0`41@E3<=5@@<04S;Oa5P0"
    A$ = A$ + "2[823282R=2PQEE0ad4[HCPE00[H200PA10=R]F50\>aPeQReQ6De10:F50["
    A$ = A$ + "88PH=50[00=hb@]5F8H9:PeE54EM2P6<PeY5HJcHYE551[90XZ30<:0P52f2"
    A$ = A$ + "4E1@1P2C4[KE<40<\`44\20RJ320VFG`V`:VF2XVF11KM:0XC3PJRHMC<00D"
    A$ = A$ + "P115a6@=00330@70H]206HJHM`J0PYUhZV@3HK5=P00028j4D5`X:\Bh7`J4"
    A$ = A$ + "[XPeP0B3D`102PF\10P0`RHM8260d2PXZ2P6<Pe:2j4E]28H=0`d:0XR10HP"
    A$ = A$ + "Y=PQ90a`1XZYHHJM<45@4E@@760[34@\ZZe00h_=LTW8iI;c>oZkQnTg>7Xg"
    A$ = A$ + "6>bCTl\UIWOem@ObKW3dW0::;1ED?eDZJ0A5XhEUBXB2IQLOV_W_?9blY0Yb"
    A$ = A$ + "A4V><5HVCTC000HD1E53Pe:2PE\F`JE44<61SH4D`Pa8fPJCF10[S50Ze]60"
    A$ = A$ + "R=P0RH9FgV5\22:fX2000J50d0j@Ae:20:Z0Fd90XZC0DDDE3[QQe1@\1E0\"
    A$ = A$ + "V0PQY90F2fX=:HY206000P00F[H1F7aBD`dB1@a:0HJ51D\>HH=<A04;=10M"
    A$ = A$ + "2PEE0@D@[F5S0P00e9RXf8FR0PE40dQ1@AA503[QE\V:F30<]20ZR0P610aX"
    A$ = A$ + "J=X00HP24Se9X0PP:0F[0PF0>dWUm@QidP6\5@3H00`Pe9H3P:\2h4nCgmDP"
    A$ = A$ + "F0@e0H005@d0200408H]R]0PXa0RX2PRZ1@7R8j45a0FD0`j00dH0`43KB53"
    A$ = A$ + "58P101E]^e`:20RF36M:0XZZ00J1E000nI3mZ`TB;SNOjbiMT3`I3mZ`TB;S"
    A$ = A$ + "NOjbiMT3`g00@oN9QiMeBXF@F6211kR[mMRF9`N^0Ki2hX9QYSV2<W454H20"
    A$ = A$ + "00P48E\PY5K0De>4DA5;:Z2XXFaREe6K1`dZ88RYJH13C0\JH00P1HZHa0@2"
    A$ = A$ + ":1\2:Y0\04QhAiJCV0HYU2PHQRe\1\@D0\`208h17JCK@<4C0<=@01C@aBC1"
    A$ = A$ + "0[SZF3\60V660H51@E[;0H5`653a@1010P1MP5F2PJSX0Fg4[JMaB[90:F10"
    A$ = A$ + "5MH`XC0@4e2KDa@1@50ZA\RR>A10D]20FH20FG1`JA7HEA10E=0P>00EE0`2"
    A$ = A$ + "4K@A4001>@1Dd1:R1SZ2DHndPXC\>4K50D513j@00E0@1DeP800P0J]PR1@5"
    A$ = A$ + "R>h7@dZJMREE0@e20R20X5041[C\0005PPEdY]20XZ:0Xa08j405D55MR>50"
    A$ = A$ + "\>504=8PXJ04=X3Ae:2@07F[28X30@aH@DDEA300NI3I1`TU?9ekU?Lh?\3Q"
    A$ = A$ + ":K8;0V\l9YN_lQ3oQM8dg00Pf\<KYTBZ4cQD9V3>RHR9V9VHRIa8f1a00008"
    A$ = A$ + "1B:f[H_Y8F4K\XHJHE2:0;52@1[hl4P@\d0[IQE5E\0;=<]^ZESHAED4[P6\"
    A$ = A$ + "H<R5`Z6=ZVjM75aPED4=J0=6g=OmM4S]2J]808_jH:bIiDT<OV3\Z_9IH74Z"
    A$ = A$ + "U4A[1K1SALL^ZYF_DP0\f9Yk3Q6TLFGBKLChD=gJ8FSA<6D0g103kg]AJ=W@"
    A$ = A$ + "AFeTfddaORL]nPZ0P[g3kdVE914Doib_Y2[3PE3W0?;YMoOS=F:<S\BfZR;d"
    A$ = A$ + "^PYM8\V<m[\P8UY7:Hf:2FW0nK3KLPTIJJEob3OL@>a_=\a1BVYYEm;?la1i"
    A$ = A$ + "4o300RZAPX:4eh=RJCX:5YPPdI1FffFHa2g<@B@bE^22Kki>Jj81L`11LD:>"
    A$ = A$ + "h8W:0000989[RJE@]ZEADaJ`ZH\HEaH<6A51A\J:PHA14K=1@]PH76F05K01"
    A$ = A$ + "\00HJJA]PYH0:fX8RHJ2ZHa4D\0ZRED0k]RbQ2:4@8625R893GA\0F3000FJ"
    A$ = A$ + "80FJ:fPE]dD40d20j0`R>E@ajRYQE`J0P>D1@W60MXB2PG2`VE@`:V:0F3K`"
    A$ = A$ + "`D<003000\80fRFC[H:60HE04[Y0HMC@ajRHQE]>00=J1@;2PQY2P5RYe4Y3"
    A$ = A$ + "400400AWZP0PF3P63PF3PF15MH=Hh>SFXJ0D`jD@0`00@@S:80X27VWiU:?7"
    A$ = A$ + "A?_PX1ZZ^2203R6410S0DQN`XC4K0Ae0650a605@3=100Y?YH17=NINgLc]?"
    A$ = A$ + "0A[:PA1@DE1@1\6D<ldIW=5000<U00000000Hk200@0000PUU>KnKl_Ko_ao"
    A$ = A$ + "3moDo3fo9lo>oSdoLHoo@mO@o3`och_=\ZPcHZXU3`Z3K4TSlK3[:h<V:Ji0"
    A$ = A$ + "\j`61i8o6D]0Z6AmDd?8=f?;ab2;8aA>mmm]mM1VC2C7=5HVbL;5000H051S"
    A$ = A$ + "X8F;Z=f962H?6:HE\Ga>503kE\8VfJH[RP5CC15[0XfX]dJ:HE3[HJC6FXF2"
    A$ = A$ + "ZHMC5D;\000]000@Q9;8V_lMG:@30XE50=60\03K2330450X0e2\^J=\62HR"
    A$ = A$ + "50Re]4@]`JPP=H8f\EaV=1DKd00[9:PUF80ZUH=[ZV80Z:000H0@;fV0C1@<"
    A$ = A$ + "=1`J2PHE;1`jPUF3[Q2HQE1`B31@\40ADCKD4??0@0054d9R:0JD0@W20j@0"
    A$ = A$ + "@A5MXH]:0HM0PRF3P>0`FDeXP00P1M280XJ><_4H=RR>]Xe0X50[10[:0RAd"
    A$ = A$ + "H<000hi@d1H0D00[105EK0MRZZ2j01453PF1@43PPXEe600104dQAD<PZR08"
    A$ = A$ + "j40e:R0Re0K2\^0XZZ14A7Z06=0HKMZP5X00NK3elh<:G6mNdm`6\3@]=DcS"
    A$ = A$ + "cXLIdkAg3K`>0m=004QU9gF`L;5W^3Yb178fA>@0a2@\3RAl<50000b0BZQ]"
    A$ = A$ + "R5C<=5eR:Rm070:E4A94FZ@LXB8=Ea6]562Pe\ZE]^QZE1\::8R8Z0ZPZZJ:"
    A$ = A$ + "Z=;86kMnK_:f0J@[>5A<PE00]20J0@4C\>:60X8PAE54A30P2ZjD40@J1_@<"
    A$ = A$ + "D3[S1:XZQfn_]5gAdjd5]MGcJh3B8J100`f=KPda6@?72EcS_38<C0=1:?60"
    A$ = A$ + "P?dUY4RD0Z6KDE@3FD1N2W6;DY[=^\N>o=?7[N@9;6g\H1=0000C66X;P<<h"
    A$ = A$ + "0B=U5b@eL0D35PHOk1D[i6RH0aZZFaJ40[AefXC3RXH`6\F11810NK3I4jH="
    A$ = A$ + ";YN_l@ebi<ef@6Q>FcBZg;?D]L>Co000e2EP\J`;I=@DX88]0W^S4Hj87=G`"
    A$ = A$ + "<GPYS8>E>eDiXLR100081Y\@@\2R1DSEE`H53ZeXRA@Q0`bU:05\lXDF1U2e"
    A$ = A$ + "2[K2H9286:P:6FH=;A4Da4N[F0Fa6E35`D<@bmlPWdWbTPO0D40[R>e:ZD94"
    A$ = A$ + "0@4[Z3d80F[H15aHAE5@d9F7Re8PAC4gEG4Q]>4`00001T?eJ;0XJ`R2PXH0"
    A$ = A$ + "A\XC[e2PF10=2P]44<0[[R08m05<JAaZH@30F50d0PR6S61]R1E3H4015@4a"
    A$ = A$ + "JROge00PPeP53PX08Z6@[0P51]R20BUYc72H\>a00631j0J@QaRE1@[=:F1:"
    A$ = A$ + "2=610Kd060\P6<R1D=74SHgm7l4@S0HE4@aRZF000<60D@5<adjRJ9Bm^P\b"
    A$ = A$ + "0hc=D@XSAdXJIl@mUVSlL354jH4=ZF6?DOYi8o=00dRT`UPHaY_UCTikG0Vm"
    A$ = A$ + "5<W4kP32TZDVYJj00000905XZX2fS:F]JW0fHJ:XF\5K]a`6K10050;2@0X<"
    A$ = A$ + "R8<UB4A2^288;HH=C0;\D1\D043edFH53[0PEC0LJ<=`2KYJE1@\@1\>1@[0"
    A$ = A$ + "PF<J\R0X:2PX08H2H:Re<==Y050DCe6]@DC0E51@30Re9PQHY5FaBe6A1\AD"
    A$ = A$ + "`61@]60HM\IC1C0<00a:0XF7@E[0P=8PHJ=<]A\2:2FC0<4;1<E1`2A]VE`@"
    A$ = A$ + "0D@0@dY]50504]6`F0DE1M0:0f2Pe0PR1`RHE?00hKCVV`Yi3j>:k9d<CFHo"
    A$ = A$ + "I100C382060;082P51]2M4:><H0@@AS51:81H4]630:0HE0d:0X5[3\80Z2P"
    A$ = A$ + "FQbX5MR:08000H0`XZASRKF;QRXAlm10nK3Ml\PHYdkchU:QCi8mf@7?;8F:"
    A$ = A$ + "mn<NYBhD>B_P8;AF9ZCUb[Q9VafIBTB3<8:HaVSVKY<W2<W2h0QaiLO20001"
    A$ = A$ + "0S54EaJ4DCK1eN\Ja0AA\735KD0a>50DK=0`2F=AA1`@@4eF;P]dZ6PJ3f48"
    A$ = A$ + "FaFHS0HE[I1PY=P0F10aZVFJ;]R8:PY000H=0PFD0dZ0PF@S]Z08J=8XEJ28"
    A$ = A$ + "F30;\DE4aB0dQEdYE43P6h6R:C5M8860000010EDeQ>D4SAE;PEe0X6F0HJE"
    A$ = A$ + "\^URe5`RFE`R>1@E4`:RHM22@0:XPR>D]0P604[28J=P6aX3dX2P>00=0XX2"
    A$ = A$ + "P:FWB<080PAd9H<X:0F10d0PFAd1650d2PZ10504\611000<]640A<0Z`?dM"
    A$ = A$ + "G^aQ`1D=n@=0<FdP=P:2PXP8FS0H4E]H=0X2H[E0\60D0aj820:000Z0PQJH"
    A$ = A$ + "CZJP0JD50E3fZ2PH@300NM314n8X@6_T3C>ce=4@hSP2IlB><f1hg@DT8;;Z"
    A$ = A$ + "3QQQ]YSB5aCf1a4;EY@<a4;6C<ce90000`P114SE\82RQ]fIe@\H[EAa`V\d"
    A$ = A$ + "0e6]>H=[J:Z::Jd:JEADA55K4aJ]6]XX2PZ000PAdX8a]f2I5D<H]XJS]6;J"
    A$ = A$ + "<PPH419[Z6ZEP9=FENPPaF\H]ZR110[a28Rh>O2WY]F8al<nYdF>Om:N3Y:M"
    A$ = A$ + "_GICZ2LQ8:M70[5@A4D15QN@7fZ:XE@AD`2@fL9coeob91RLUSKNm0ZGRRAL"
    A$ = A$ + "RoW@02Q@;[J]\@Yg6E6dLh4P4hc8UgkTmg[<C7[f5Kdb[8`f0:@2@88DX5;@"
    A$ = A$ + "FF;\j@TQXlC0nJ39DR7LJD5;_dWIVRb9N]Q4:a3>;ZRUGjc<CAi4MAKVf]^2"
    A$ = A$ + "bHH;EY91KCWnFZ8BW^H>b1RM85RM4QiD<0000P=fK1<E[8H_YYPQQMZHP:26"
    A$ = A$ + "P16PQ2H0H;D1;]Ve0\UFE0[H;\45K41<\D1\0a6<5;14E100D14E[AdZ:2PF"
    A$ = A$ + "0DD1\@aG[4S2PX5@dH000D03CCKDaJ14a0R2PX50]RZXXXR1]6@A1@51`4eJ"
    A$ = A$ + "6Z00002IU=PQ0RJ80F2PR63ReZXHA70RR:PF1@d27Gg?0@;ajZY80F:0R9P:"
    A$ = A$ + "2XF8Ze5;Eh4dLJBm52X`d:N;6Q20J1@E1MPB??XP5\X3`H8TB8;HR:ebn3R:"
    A$ = A$ + "CP504SF0P0heFa9J^4DiJ@Fh1R0P8X110`R6C9PHE0553FW0fJD:d:jd6dY0"
    A$ = A$ + "XA<G2ne;20P7g@<Q9BiR\^f3iXdbI:^QH2MTV9bj6?TSBWa`g000;1kY1TC7"
    A$ = A$ + "=CU3ii2<cZW`dC>5?QI^C5000P4TZHSEDKa>4<]A5\30DE44C[HX>0:;3QU`"
    A$ = A$ + "A:a4E0a4aZF54KbjFc2[KJ;Aa`6=Aaj08FAAA;Zj@3J145E0d2HA1@A;0j4@"
    A$ = A$ + "\ZXaZ0l;LA<`:ZR6S0P10040DM]>Em20J0`Z0f2PF@7P6H7LXh1Ykk4608`Y"
    A$ = A$ + "ZZ:28R:PF0D;4@=]@]1a235@722:6`F0<Dej2200`bJA550Ae0CE0A30::FS"
    A$ = A$ + "XH0Aa0\2`B3PAW0000h9A1FJ021HA38<@P=J21jE3420:0HgJ=600=8604P5"
    A$ = A$ + "3@8P8dQBU6H50F0b_nC26d8H0D00E0[:0ZfJ[:\@2H509QA0HaJZ=2PHPE6@"
    A$ = A$ + "EY6@E1[SH50e:2P5X0Z2P2:JDAP7g@0A<8G@W?U3JXL4RK8P86QLADW?U3JX"
    A$ = A$ + "LTN35ARZZD]JAJ9i:=B\UZlDi@:Yb1AC7V>`Y@HTHR9<CUh>000D0\:F[E4E"
    A$ = A$ + "a>[ZJA]RRH[PYZR:HJe8PMfHR6cn<RRe51\D<@`0CKf2CE0<000\0RPZF[1="
    A$ = A$ + "0XH05EP2caEE@<0X2PF0<5aVD3C5@50003PRXXYgT5i6F1_Lk7jh@8I0;J=2"
    A$ = A$ + "00Hj;]RH0D1S:`?liK6FXTJ1a[`P0N00MP80RX2PF05<PR6AS]60d22F;HD5"
    A$ = A$ + "2EY100>@dJ30RPPR0P2HDaJ5KB65aH];<0gFcOR50K10K=h^490i`@oP0C5T"
    A$ = A$ + "?O7NJ6Tb18fJE\20:0X1@@S1[EAm6MjhaACAD0<5eJ0:NM39@YXj44mYL4j="
    A$ = A$ + "VDg@2D:Z>1AO:7QNS9_Pb2D6IeJDIOjPHYb1RM`1RMPH7HR9<:6c4W:70000"
    A$ = A$ + "06E444aH5ED[JY=X8f\E1C[I3Z8f2a6aJfB3`4K@4<\^R8FA5DA\DSXPP820"
    A$ = A$ + "082H5AWFSP5WHI>M^E:ME5c@>ZG2370Zj4=Z6@a`I]fco[X2f1;WWFLF1Li4"
    A$ = A$ + "JT6VeUOKV3F`k5`4118ok]`C8Td_`G4jUHX5@0fl3I4Dd8TLm?B4@[:VdCVL"
    A$ = A$ + "YNo=CNo?NeL1<@`@[d\7IVC7o]nWAdJ?0_;IN[>Nd0DDMT@\PF4A0\h^J=Ph"
    A$ = A$ + "n3hH_Pc6k?10NK3A:nd=;bBk7jSCL>WXf6RDlYKFTUf?d7WhL>AO3004`n65"
    A$ = A$ + "QJD1DQ1f==\`A;H;W8gbWcDi8RM4QaY34Vc=700008Q@9a6EDA4\HSmP5K\3"
    A$ = A$ + "D`J=F5DE5101k<<1e6\X660VF1<<1X0@4NDF`WE0Q5CDaeQ8ZPA00hNF1GP5"
    A$ = A$ + "AeF0D=PF5@]0`@`V0SAI=PQJJCHH0HX0F;PE14K]8Z6@aPXaPHJ2H:R=[VV0"
    A$ = A$ + "=9M8fPEaZ0ZH1Pe0`:0Pe`V43[0XE4@E40M08ZF[>450<00020VHM410]0f2"
    A$ = A$ + "HE50]ZR>A;0RF0d2H0@3j`6100000@4[A\8AU?7J>nCOL8PR086`FdF01hk`"
    A$ = A$ + "T9DL`C4=H51\Z0X:T8FQ0Pe22PP1D1@50DAkd8>6?@jJPP6aF0D04aP8ZPE4"
    A$ = A$ + "E5A30F3Pe0820VHM5D0400010E5]gfXaW@>JJ5PWf@NbDP51Qb;E=N=7Pd6b"
    A$ = A$ + "CV2\88DNYZa[i0l=00TC?3iUYET4cI:KC1VC7i87URSLP`X3>@lL;E00004@"
    A$ = A$ + "X9YMPEk]A4e>A<E[F@<]gdNCK5C1`:D0`:0h@4R?TBLYT2\dV5`2[ZP1Vf\>"
    A$ = A$ + "@;0Z20082PRR6d:Z0:H0=0F[0X8F3J50550EE0A5@aXC]FmLbZ4`@<\58V0F"
    A$ = A$ + "X0R2PZ505dRe2H51@;0X2XH5=Zf0:[A1]J4<8:6\61@;0XAaJEE1\60d28H0"
    A$ = A$ + "aF7H3H000404dFf8IDPF04=R>@;07<=E2@WPZ1000`WME050@3Pe:PE4E5A;"
    A$ = A$ + "0R2o6miJ30008P>03dAXX15m?FR7D9R>PG<2CRI>B=c5XA<bEe03YOaAU30d"
    A$ = A$ + "2HA1MPF3H=0F;PR=8PeED500004045=JE\1=08J<lHR60he=TT86GW8YDN93"
    A$ = A$ + "GE]3Be=TT86GW8YDN93GE]3B_P\45AIU::fW>hPSLPhDa4c>86a4c4c\3>h0"
    A$ = A$ + "0000`H5`J`H]XRH=K9ZY=Z6VZE]2VVFE]9K`B[J=adB[JJQUVFJHX666V2P5"
    A$ = A$ + "ReeH0430061@[FE=F@0?gXNOonj\O81IO\;0PF^@j_Z7406555;0P68A3>9k"
    A$ = A$ + "`g>PSOLG4ANF04<8J@EDPme`TW?0;inVLgF_XJFdi8cnel=lo5;0]XdoJCS7"
    A$ = A$ + "@gM0eUU_^;ng:6PTDh`OjeRkRZIPJK<ko2@VV5SIfAo3cjUi?0IK=\l22=i9"
    A$ = A$ + "P0=dLd1]VYmgKF9JbB\LWiC00h_=4BjR`\H[TNI_`G>A_=4BjR`\H[TNI_`G"
    A$ = A$ + ">AO3006;mL8P<9^Vkc5\=M8EYb1aL`QDLP`0a>JV200001@A@4\31K\H3H_="
    A$ = A$ + "ZJ_0Fa2HJWH[JJQ2`5236^R95P02:8f\e]1aZf2;A5[KE@UY0>0a25KQHZP1"
    A$ = A$ + ":P60[2HA4`0Z28R1d0X8fX:R220000RJJJCX5@dY1=H@[0XXXA\F0;:0V:8R"
    A$ = A$ + "2RQHMeM770FRUFcD4`D14]0R6@dH=:ZX0R60[28Z02XCK3000lD:bl<J04[Z"
    A$ = A$ + "XH=0:hE@3bJ]10000@^E84^@dX_9IdLb4lMF08m;V:72JR3U677V44m20020"
    A$ = A$ + "Hd:6XNoCD932=2Sd1kO2IZhH3[65lP6aU=00006[C41\8Pe:655E0]ZRRR2P"
    A$ = A$ + "X5<:RA;08J040ldIW=5000<d00000000Hk200D0000@D?]>TLl?8o;co2l?8"
    A$ = A$ + "o;cnoCboKl_9o7`oOlo7oO@oocPOg@8>6g\XXeNiHNXe>0Lg@8>6g\XXeNiH"
    A$ = A$ + "NXe>0l6RBb\XXNDVB2SG:CeZ4T4R;7bCUHcIZBedAYT:1L`124c17AH4000:"
    A$ = A$ + "H@@=RE045k\J7He@<`Z82RJ<ZE0SHED\>:fB5\ZP]`V`B@142RYR=;6:8V0o"
    A$ = A$ + "<Cm:I:hBR>0E5E]20600004E]V:28J\PR1D<AZUh9CCVhkbY1065MX5]0ZR0"
    A$ = A$ + "X10=0jdj4dY0R=XP1d2HAAaH000000E[cT`7?SF3RRZ6A`0J055@C[800000"
    A$ = A$ + "08X3<0R@U3_2ES60K1\5`2P8X100X4]63H04QUh5MJLKN7X530004`:4`XiA"
    A$ = A$ + "`[2:22HU1NcAJL8TWXZ3WaA300H_XaH9^4\FAaZF05EP>NNQ^ji=40CAe5K]"
    A$ = A$ + "dUbUNJ>1i=40CAe5K]dUbUNJ>1gdf>m6;QeQ4\4GY:OjdgLd<E>hPH>hPH>@"
    A$ = A$ + "HV:7UW2000DDeRmPJHHWMF<]7e@DE\HJ:XRXf8P53[PJW=R8F`V]dZFe:fT0"
    A$ = A$ + "R=HED5D0F@EA\9e@0e4@`PZ1D5d::>NdT`PX8j@E10100@0D1;]9d1PZ5@A5"
    A$ = A$ + "SF1\E@[P:8Z6DA0\4`@`6d>2020e0[KQQ1PJ0PF`F1\RXXn<J>HZ02FSP100"
    A$ = A$ + "0000MRP1d0XJ`R64d1J<J5\ZZ4:d`oi000XO42J>8j:nUU@H2]k[0DWHSR9A"
    A$ = A$ + "7RkBLAH2fd60H@FIJ^ZDgfe1Q`80o03J`2P=P2PXJ0EdRX0:N61OJ100<06E"
    A$ = A$ + "M02PF3R63X5SUZQeE3AA\`45]28H05d18\80nM3AXH4R9V6UG:LPEk0`M3AX"
    A$ = A$ + "H4R9V6UG:LPEk0`;X0AVeY8;\;`d17L`A<a<a>`>`<a<a4;FZ000PRP11aZF"
    A$ = A$ + "55\D\1E]ZE<@]A[:ZQ=IQQ]4;4<`ZX6FC1;\R:HQJcHHSFHbKiG;=:R8F1a8"
    A$ = A$ + "2PE44\]eX:X22X2PZ0FWB4GI0PCESgZ=T\neJeR\6km2a>34`i;JDW@OWRRF"
    A$ = A$ + "EED\8H@DJo2FneX`667BVhiRlo\@F@Wg^WkSZ`Tb]nXECd2G^E82V\h]]eQN"
    A$ = A$ + "Y9>Ze41i@=b>geB47Nlgn[KViW083oAVaL;>B[oE300XKioS6>EcXZX8laW]"
    A$ = A$ + "kFkn4d2XH41DE4VA:0P_g@8XT8FLKWN@8Dk0dN3QPBRHa]Mj1Q@]3@G`d_W3"
    A$ = A$ + "`2aE^3>T?CIj`<EYB<fA\HRAL:Y2000PJaNK1edR=HSM0F]5<=\HZVV0RH;<"
    A$ = A$ + "5\`VA5[JM`:RE]UFA\I@\9C1[PI70V2[KE51<0@E0E05E[CA[150a`4`B0<<"
    A$ = A$ + "\aO90H4WgW91J[Y;YeAU:?3:R>D=0H00@1<`64e01=64MJ@E;8RF=J@;P632"
    A$ = A$ + "ZPE1@AdQ10HYeP8P0P=PF0AEED\117Jd4]>Q100Re:F043XRAePH[5d28ZPH"
    A$ = A$ + "3fPL?P100@0]6Q:?VV__7ASMl]6DdD2??2ge@<86`08X91`RLf4==IFY^]f6"
    A$ = A$ + "a500?FYK_jlmO7AS7HE141]:8@aQeJ43X2X:\0g30hi=4a:adFleMn5>WC@N"
    A$ = A$ + "3A\B<]5OMWOQci4l=00X_QdM6S1HgTlLRLKO:f<UY3>h0QY34c>h8WNZ0000"
    A$ = A$ + "0BE9HWMf1H3R531eR5[RQJ5A]g@``F5<\1Dk\XfI;20@i:^0D8\HL4P[@lPF"
    A$ = A$ + "00032ZFc:H2H80:P80:XZeJ5SF11[0HZ2PUR=eZH9P8Z]D\@1;=41\:XH0Ze"
    A$ = A$ + "4K2A;FdY=F3P=86HME0@0004@5aJFP50J1DD<XZ2XEdZZXH@a0Z@2BM20UeR"
    A$ = A$ + "1`08PH3XR6;:0:0R:P0PAK008H=P1D0\5@A0A1]fU^T3F4kV108`:5b<oPSc"
    A$ = A$ + "IdTI>4=8J01`02VWWFWh`H4bWN10g?2_l]nY>\:AkOP10@=>H<5RH]X2HE14"
    A$ = A$ + "55<5@@]6X004LPFEA0K50KoB4W=0nM314ahR57Sb35F2k0`M314ahR57Sb35"
    A$ = A$ + "F2k0`=Q8jCJ=\k`<ERiP3RiPH4kP3RaRa<C\3>00005A=<<4CA]eD0ed`@aZ"
    A$ = A$ + "M6RQmfZZE[K3ZYQeA]D]0`jRHPURHQJHEKD]@@50<GgOBN=1E0[PFKA0AEeZ"
    A$ = A$ + "2fZ2PEdR60`00P4ak0I@>DlRRmmRL6o9344`OF4BLTZNMYBi`D@VfI56n_7E"
    A$ = A$ + ";4=_5VKGUF:YYRDm0`oH>G:JToJ1:bbPLOR00PjATZ865;O3;CMi\:>lOIlk"
    A$ = A$ + "e:CR9YNRc_foN6g_Ddlmf`YT]9Yl6`d]^IEi^VW2;B:MeO2`IA0O7Tj8l4nj"
    A$ = A$ + "C0PWg@B@;]cRSgMOP187Ql6B2JYMFLl^k3<0i8l2ATDZJ=5BgcH9U<PC?gY;"
    A$ = A$ + "^48E4kPSLHV:78V5c17B9?5000XPH55EaJ=6eN54`@ED3<a2:fKaZQ5<E<=`"
    A$ = A$ + "2[JM5;]URJQe]:H=K20`4@<<]1<IZZR0DAA\:P64;2HH0RQJ;@5@@1040Aa6"
    A$ = A$ + ">BaRQbnVF:j3A1aBD<5K@5Xh@dQA5S:HE1\:PReXZ0H4dH9>K:@4mP@:Oabm"
    A$ = A$ + "JDTh`Qk100`FdR0PQ7R6Eo=nNN]U7X5<000002Ja0F@0aHA0K]lh8@Q@EW90"
    A$ = A$ + "0V>Acjajb<h`hISi1V?Ua0=K`A:88>60@0G8QPR4]S?O0:020fJ@4:UCdQ86"
    A$ = A$ + "4]HDE5`B5\RH=`:PJYPHE`6<R6P=O3P_g@2@=nmRW^m@;P=QHkP`N390ehg;"
    A$ = A$ + "Njf3]0f4R]32_PBD45eV1g;0\PCgA>TCTCRLV:a8f17L`1R5Si9QA000XPA\"
    A$ = A$ + "XZRAa8RQEk=DaF[PYmPYQ5`REC430C``:F5\Z=:ZY=JXRUF70@4`ddd6=<mC"
    A$ = A$ + "25E>J97:DPE1EaXA5@0XAjf2EHdH0ED4E1\FaHY0H5@`dFHH0`LH3XVP:2HQ"
    A$ = A$ + "2:H@7X3E5E3J@@30J1455MJ30AajHX8Z9H:PA1D]eYA1d2XR8X0PZe:H0100"
    A$ = A$ + "Q]B=7T<jhkhUBkIA60\2Q7C@A^h03B<\J00@dI22=VjgS`Q9Sl000h9kATlk"
    A$ = A$ + "P988\O10JVYEo^?MJX\Y3PcJ410;P8PX0FAA3:2HAh4ak`Pgg@0[6V;Nk[7H"
    A$ = A$ + "2@i4dg@0[6V;Nk[7H2@i4l6I6TUUeXTaBH^60YRX5F\i81V2h81BEZL8E>h0"
    A$ = A$ + "a>RHaV461000X6[E=H44300F\G`F[F4e`F;HSEC4\7\eD@0\0H;6HE1a2C`B"
    A$ = A$ + ";\1K`ZR0V008H1=R>\ElTHXiokBR^XY0082XXFG@1@;PR0RAdg9;S61\:PRZ"
    A$ = A$ + "6=2TPcj0[2XH@;Pe0FAdHA;8ZZPZ0RH0AdJ101[E4S]28ZlTg;[@S0R:P8PE"
    A$ = A$ + "EK20PH=R806@10E@\eP5bL`01=ZR1400Pl[QhW4::jOlHB0PX540000:5\P6"
    A$ = A$ + "CiaY?0=9l900@LV_^MRWXU9Da8O60000`X=\n;SSok<J2ZTA909[XA<P2PE1"
    A$ = A$ + "]RP]6M8:P8:VO>P[Ohm=TRmADCLLkQc`<0f1Yn6Ban8Z9>^m`IH60kPd5<mJ"
    A$ = A$ + "I?E>h@ZL`1RM@<78VHR5SIa8VhD960000\gR1F1edFk=a6534Kd4C3Kbd`Jf"
    A$ = A$ + "TQHSV6FZZED;<\D@\@EC\9[HJHH:P208RAdXASEDQjbiJQD_dZH7A[FThR`0"
    A$ = A$ + "]c_kD?OU4A3F0=6`:2`cBV:88g7;boL8YkjABXc97OIbe`YUYUK71RTA9_J0"
    A$ = A$ + "751DIEhD8TfnLY7BXiHMXT<0KFR=T8oWSD[dRe@N2ak?928`;@ZTYRbMD;]m"
    A$ = A$ + "AP5KR7j]5lfXNR3`1;NAd=bYh?1X9>OS<_o32K\5<F@@[JUJL;AVY=;7O7P7"
    A$ = A$ + "g@NH9ViRSWeGBT1<7Yh6b3;a<GLl\nBR<Pi8m=0046;cnF^CgAcDi0C\3>@\"
    A$ = A$ + "3>h0CL:>:UD10008@X2\a4E\1D[RY]F\1:5li3>DAiaB8BS@]V=JE`jF1<\:"
    A$ = A$ + "8FXRJQQe]^H98V00X0VRE\1a2@e0FE0aP=ZR1d2X105@=`643@400@1\d`V]"
    A$ = A$ + "41\TY3EdB:ZL@C@EAE;0000R1A5MXJ@d2:H<2XA4]J5@d0F54KXN[10PC=AU"
    A$ = A$ + "4mT;o:Y;K?0fk8m86Ue:oTLVfC000jbdhaA:^7eSEEo:b00`dV6Eb47=9HP>"
    A$ = A$ + "Vf0@@L4>05J2M3]EcNB1\jc>9lb533X0P06dJ@QE1JN0:PH[CE51DD1[8HE1"
    A$ = A$ + "\eXH6m@\eJ3XJ4aT9M00NN39a]X[9>Nj3DfCi=T4gR^VhhY?@I?MCHWDJ5FG"
    A$ = A$ + "1ThdMTCgAC7=WC1BU34c>`4c2TBZ000P2F@5k\aNa2F<15\E4eN3KEe@5CeN"
    A$ = A$ + "DK]3Dk4e`FCED[JHCZ1P100V0VHH366PX45UT>_@lQP2[XX30`6003@43[YV"
    A$ = A$ + "XHYWn@XD=:iA51dXJ04000`XA[80:Pe8P>1[XXXEE>Z[P<F4]20000288j4E"
    A$ = A$ + "0E3H@A1@;jD`PF@4E@04\>a08000PA;80:P51d2F4]XEF^ng>d:0800008J5"
    A$ = A$ + "aPH8i\:^o@@CE4Tb101I=cD97OTaXEU10h@801QJAR`Qe;?0ilfAhMPW3=FE"
    A$ = A$ + "61V<C;1S0J0]R28ZPX0F1aXPf0<4\FE3X2RZYSne0hi=4QB9VC<<cOPB6Si="
    A$ = A$ + "4QB9VC<<cOPB6S_@44YjT51k>M7U:7=MT3>h0a>@\3<aRA<kPHR100054\Ze"
    A$ = A$ + ":6D[P]`2`6\V:FJ326fXe]IK`2[RJYe0;]D@]ZXZYE\`6=<1E104D`D=\VQ0"
    A$ = A$ + "6LD5Ukooh0;C05=R=02080F5]R6<H=>JkZ?SJAL0:F7H0400<H4MZPZaZPE5"
    A$ = A$ + "D`HDDdZV>KX@QHE=80200PXMcTSALFBU37`O>10@BjGCVZVS^2e_gOM?S1@R"
    A$ = A$ + "eUiP;@B]c]b[R?<00QBA5Q3NoRm5AoW2W^Ljf@A^=9A6Th@0J[_3X]cFP[3K"
    A$ = A$ + "c0^QfHJ<RC]TL8AUg]V31TNgRUK\XePGg@2D:DC<4lBK46Se=T0U2e431_d6"
    A$ = A$ + "QahKDP\\>Q2:<4bHgYW:79FZL`1RM@<a8<@<a>`RA<a>b1000X22F<Z114[Q"
    A$ = A$ + "E\5C\HJE\J7F5KFD3K`DD[H0FA4\`BKd`Z6Z8200286FJSZ:ZJ0GX5U4IS0Z"
    A$ = A$ + "HK1\XAQ10o[Fec8ZRAaJ=2R:A=VLlD0V641D0A1@DhnKK[Pl2Rk712@deXQV"
    A$ = A$ + "7W77bKEC^;6W0kU98LDoROM8R:T8D10`2D;8C]_3Wi`cK>QaH]C_E@2nAhBS"
    A$ = A$ + "V@21QBES411L02hmIE]KikP6SQ30FA2L`N[mC7F?0QSlaG@<51K11E5=R:n8"
    A$ = A$ + "[7ElS:00NN31PDZfRQ]76YH>1i=40BYJ;6fNHTRi4l658cJb888ad;]0H;U="
    A$ = A$ + "7LT3LZ4SH7H78<8VHRA\0cD000P:XF;ReXF;8fKR=fXZMH5K]H_YMVfZ6f88"
    A$ = A$ + "X00R6dXZ55MXRRX5A@5;=a6\@03C@D1=6DEDE\886414<XZZeAPQUHcH0RX0"
    A$ = A$ + "VP6S]ReZ:PH>8<GJ`@0GMZX6]X3SR>\Z0R:XHZ\KB<0P[DjmRK\gkRkJ`F;0"
    A$ = A$ + "000kEB@h3NYnYKWh920^CXB55UYBZ88N76`fLTcl1kEU`74`_YTH1Q\[F>6b"
    A$ = A$ + "KL10@UBYDMJ478TA0FmQ`7\_=C7\e2000006MJ1SRA43J0[EADe2X1@A0501"
    A$ = A$ + "=f00?MfIC101jQ?00000000f^00060000h^PXMg4o?co1l?6og`oT@oo5l_7"
    A$ = A$ + "okaoohk=4P;9V=:VFe6@aLVgK80GB<KD<]Z=PRi<o659IFCe0A:UJIgYk`<E"
    A$ = A$ + "cidAY:E>8@Z8NV:7L`QI:000@5\65E\RJE\6ZRPY=FD@]gdNKQPJ;5E\IC5K"
    A$ = A$ + "6edBK0K6;AE10@1<<<\^U:HJ0GDbgGU3bL@leC040ReYR0J0AaP60E1EE0aP"
    A$ = A$ + "2PH0;j41<4\;MR=X5SFaXC3J4E]j0@[0J=X2H5[CD140038RXCK`:0J0[88J"
    A$ = A$ + "AWX5@3H51D8NJ1000\e:0:64E@1`:XeY@76S:J100002M3];Y7emMTaTih?<"
    A$ = A$ + "@0]6141D0[8PFdR:P24B0oF0nEBh@7=@1]80Z06`06]8000008J=6C6=eN5I"
    A$ = A$ + "<IRoA00lS444\gS322h?;000fJE04E3Z6AeH5d:J4@eP:P1\XC9D0hm=4BCA"
    A$ = A$ + "[599GV`>8eg@8=5]FTTLI2kPdUa>]IgY;FZ4c1f1RC5a>@<cRiPH<k8a000P"
    A$ = A$ + ":H[EE]C\aFK]5`FRJMKd0\U6R=HC6f\=H=;EKD5eB[:ZUZXH5a6=<5@00EA4"
    A$ = A$ + "3adj2XZQ2OXTX\T9eTDd^P930J\8HA05kln_YU>lQ?=Ai07I;ehMS4d^J[f>"
    A$ = A$ + "mnQLeElZn;bY8?1M6GD5TZC68BT^T\1<X0P6<BL4Fb\Na>`DciDACVPSbD7E"
    A$ = A$ + "Z<I5o7L:E<aTSn>LjdYOo3f[ofKM>i;Z;8W?i034Rb^BMO4B9S:cQk?Fj8b?"
    A$ = A$ + "c>_[k2[B0C]8W>62654[ESP5D]<9ZMI<F<POg@2RBfK;8hUWTL0^K81A9k]5"
    A$ = A$ + "4lbCB>0_@1BeCFPR5[E20HKC07U:7i0a>hPH>hP3Ri0Q17V>b1000PPaZ6eJ"
    A$ = A$ + "ESH<FE]PJ40@1;5[H5;5aVD\d6]Z]@]URJ3fTZVf2``V0Kb0a`JFJJ2F2HYP"
    A$ = A$ + "XeP6dP60E@D0C5edjRQPP1040;JMW>c>[A\151SP5RK[000PXCD=X2FE@d2R"
    A$ = A$ + "6=H=DeQ6m^:0P0\F;2X8P2@ADZkA]d4>k0Hn0=jiaiORNZahZ:00hTL`Y?hm"
    A$ = A$ + "oaQcT9Z:@Bii7E7]P?4Z`3002UP42B]Gi\d`Bn=0P?6Z3?YC47PiW70bRXE0"
    A$ = A$ + "bH`D6000SXC<P:HE4A5S6=Zg6_X;]`ZJ@01002nA^h0Xn1PWg@8ZTZF@`7J["
    A$ = A$ + ";i<Tg@8ZTZF@`7J[;i<l254:[C41aNZV>:E>8@ZBEZL85796C<CHP9fA>000"
    A$ = A$ + "04`P5e:FA\63adV4\ZY5H=3\UFH=E\Ze5a2[RHH9RJSFH=a0a@105@DdXEE5"
    A$ = A$ + "D=X54]gCB6505@DdQHSA00`HKM:4L@XVZ65<65@5S:H;j4000P_cHYJa:?>e"
    A$ = A$ + "ZY?LHiN_6PXA\1E3Z6A<fRF[:8:0ZYhD1000P5]88Xh8nASH\5@5@5^<H8Po"
    A$ = A$ + "ZHal;W5G1ZPR150@;V09UW[>I`:J]:P2HQ<ae0HMb_odgcYW8FU1`d66jcU^"
    A$ = A$ + "cdj06S^e]=5YC0Fj<AR<EMg:YIS5=8000P4_O6=Zn8W0NP3a\FRn495OX=E<"
    A$ = A$ + "62L8VeBdW8Yh3]YRa`]Q<`JIb31PidAcY0C7=WRi`d1aH23RiP3>00004\g0"
    A$ = A$ + "3K<<`NKDCk]XF]c@]HW9fJS=VfIedZ=:RZ0P:8ZE\VRE]0\Z1ZYE@AdXC[2Z"
    A$ = A$ + "6DE150]R:fH1\1D1KMJA010038ZXaQ?LX@[XAaPZPHSPA\XAE40000\XAE1@"
    A$ = A$ + "aP2X:2:8J554D153J04dI0H[5A`R086]0JD54153X0X08R60<08WJ`2X2P:6"
    A$ = A$ + "=:ZZ0J0SP1<RF000004dR:6E0]PPAeZP:n0=JJ9A>B:@7nP_CLCNPH04]800"
    A$ = A$ + "00H4]011CRo3619TB0PHY\KGko4Mj>hhI2<6Y?72Bfc00:Q6=ZX_YO5DRV;5"
    A$ = A$ + "102YNZNLjmJ0NP3IdHJe14Mi5A<63L8S6C[>PX;_8Rah=V]724[]D=5ShY3R"
    A$ = A$ + "iP34c>`<c<C\3R1000@]a61k]gNK]0fIEaF1CK]A=\JW533`:FXZ=JXRe1a6"
    A$ = A$ + "]A[XE<F00A@D4d9Z:H;2fFiBThR9H0[E;8F004@@d8ZRa1n8n\HY5VaL1dEJ"
    A$ = A$ + "IkC4aZF3XXR513RAdP000`_VVl@H:9JbMPeR4PF8j]`[@@7B@n1e1V;Al_d_"
    A$ = A$ + "?@ID59:>GnJET?=_V;I1i31PV[McOE>gh?i_iYL^m>L\m5lCNh1SEJVOAKkN"
    A$ = A$ + "kV\HYE;klKJU2aL1D5PkjMh4F^AIY`UcXe>[1he=TPXTI\0NiYUcIZ^Q44U<"
    A$ = A$ + "S5`;?YL>3_9c2YjX\Pb0QF[c`@\=W2T:78<V:7LPH78V`8aRA<a>hP;0000S"
    A$ = A$ + "AADD<:RRQmfSEk=4K\gN<@\RMHWYE4KE\Ja6E7:P0082FA\9a2@=0;E`2@1d"
    A$ = A$ + "XZ0R0f8R1AdX08002PRZX132H1D0aJ15@A0E@04AW:2<FWR1A0[P86D]FA1D"
    A$ = A$ + "<HQAjO00\N42JL[U@S<T>dH3R1A0E_[RQ>T9kd004Rl@LNBBol1FF6hNRdT:"
    A$ = A$ + "ITBmRP@f?0LK3678]l4LPobiL;An2TiPhd0Po^kl^OAA57472`D>8@HQR=`A"
    A$ = A$ + "C104oiLX?T_eggQ\Q0QAPS30nN3Q`BFe44lQWQH?]g@8XTE\PTGNJai4m2U1"
    A$ = A$ + "UI=B:bC[aBoIN>aRg73ak4RM52F<aL9fk8W0000D[HE4[XHd^Y:Y1J5IKCDX"
    A$ = A$ + "nLYNM4[J=<\9E\13K@7k=eP@8000QGeJ04E\R2:HDD5=Z2f2RH<0Fd>600@4"
    A$ = A$ + "D`jH8X:X0XJ@[E4=PQPX3XiPJ>JD?<OI<Ed[M97n1J`X0;00004;6SG0DaYP"
    A$ = A$ + "5A[h152F8<8_TL00[Y=PRa6499@fQP=6AUXG0000CPK4VH11025Jm8TQl2hN"
    A$ = A$ + "R<>X2hPB2;@@jcN0P2W8=96]X8EfZD0:1YJGOjSF1L00H8`P5@T=^RVZ0ZE>"
    A$ = A$ + "H4PTRS=428P5@@[8000<5Q=XPRHZ^DEd:P5J1<0fJ000nR3=^DRf4Tlb26S;"
    A$ = A$ + ">dh:9Z98iU5<6^2\1KYBl>RHa?LK[EUZBVHNj2000k]c><4;RmREA5K]HP=H"
    A$ = A$ + "YYHM[[fPJ;D[[FH5[JRUVFA\R5:FgBeVd:820Hg8XXC53F1AD1E9MkW<9XBn"
    A$ = A$ + "f0g0B14h@3BhUGFE=RA<H1AdJP6WJYBiDoOW]<R=21QRT40009eKaY=X0@[S"
    A$ = A$ + "EX3\D@<424AB5562\Z0:<2Q1[8H5[d6\@bH2`T2000`4hRA@K`Bb:fZ9F@BQ"
    A$ = A$ + ";:Y5553VV@QBY2KX4@0ab61A06071000DNUDX=2ZHNk_Bi50P1h4X04daPV8"
    A$ = A$ + "<d6<:Ie2>HJFbmHCB=Ok58N>Hhl]?N_nS:0P]1mZRPH@E4[7DEdRNK70;HFA"
    A$ = A$ + "0FE:nN6WRSUUO=0;PWgchLJ\9le@Rl3PkN1Haf3K]SZ]=\jZQ5\EJ1100PEk"
    A$ = A$ + "1K5a`Fa>kALd>3;9H9>KdhSLD4ED3ED<\^e<=]Re]RYJ5[[a0:Z:6\B95QAF"
    A$ = A$ + "HQ3RCLD\`bI1FFhP`0SL@X`bRBFFhP`Pa1Q2;F0\RZNe@DE<00]5Q1QR:]00"
    A$ = A$ + ";S23<YEL@<:FHYUcYd5Y5:A[BIZXYQfb=NIEhP@aJ@XHdjR5>:<`X`0S\\<b"
    A$ = A$ + "ZTK\:DLPA^a20T5FD20[EEd3:F0TF30FVjnBl?GdN]0@9;@Q16564;\LfFaA"
    A$ = A$ + "Q274^<EDX`AaA>;TGLWFVdA:00la9bFSX7aK5;FG6T1X9gc3`agglalcEN]Z"
    A$ = A$ + "2:V6TU1_HA9[20jKL4A;0h2m4500@aA6E00PEiU`830P<:FP\<\ii^Y175;\"
    A$ = A$ + "\0IA8Y60%%%0"
    RestoreFile A$, "drowning.ogg"

    'iglooblock.ogg
    A$ = ""
    A$ = A$ + "?MfIC1P00000000000@X]00000000TW_AJI0N4PM_9WHY=7000002@4[0000"
    A$ = A$ + "000004W00000000^1ldIW=50000000000000Qf20040000``^4bmB\cooooo"
    A$ = A$ + "ooooooooooooooooA>PM_9WHY=g:0000HU6LXibCbM68\UVHFmVLRUfLPT48"
    A$ = A$ + "b0C<b0S<`<38XlDK^U6LbEfLUi6MY00000@05HgKb9FJcUR@3IE00P0000@<"
    A$ = A$ + "<1Ba02=TE100@000PAB:><YI9UBYD6::iQ9U8UD:UBIa`T8VDVHaH<6SaH<6"
    A$ = A$ + "SaH<6SaH<22=TE100@000RB2>>Zi9YVciL66WhXLPVCJ>QcYPLPRA1N>98Lm"
    A$ = A$ + "V<VKVB[Y[iVcYD22=TE100P0004BQD85BQD85BQH86RQH86RQL87bQL8WbYL"
    A$ = A$ + ":X2ZP:X2bP<83bT<YCjT>YCjX>ZSjX>:d2]@;d2]B[4CaD]ESiJ_6d5OciL>"
    A$ = A$ + "WciL>WciL>Wc98d@F500P00048T1I@642Q@85BQD8VRYH:W2bP<P@3IE0008"
    A$ = A$ + "00800000759595;5;7;7=7=9?9?;A=A=A?CACAECEEEEEEGGGIGIGKGMGKGO"
    A$ = A$ + "IQIQKQKOIQKQKQMQMMOQQQQQQQQQQQQQQQOOOOOOOOOOP@3IE008100XSTSU"
    A$ = A$ + "SWRXRXQXRWSX3@XQ\:00T100400898Y8Y8iX9IZIZiJJKJ;J[JKK;;;;;;;3"
    A$ = A$ + "4J8[200010010000000XYYYYYYYYYYYYYYYYYYYYYYYYYYYIIIIIIIIIIIII"
    A$ = A$ + "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII14J8[2009000MLLLLLLTDTD"
    A$ = A$ + "TL\L\L02=TE10P<00P00095;5;7=7=7=7?7?7?7?7A7A9C9C=C?C?P@3IE00"
    A$ = A$ + "0800800000000537577797=9?9E;C;G=G=G?G?GCGGGGGEEEEEEEEEEEEEEE"
    A$ = A$ + "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEP@3IE000100@8MJVUZ182c0IHP@3I"
    A$ = A$ + "E00P0000H4:23a02=TE10001000RQB>8J2]VcgL>>XIiPV:5K>M`9BeVWTKZ"
    A$ = A$ + "H^iL>WciLbVcI<>WciL::WIaPV9dJ>Wc9aPVU2JV@[iL>WW4KN@[Y:]VciL6"
    A$ = A$ + "WcY36WAHL>WcY9]V7TJfH]iL>W5dJJ>ZiBaVciLRD^i9eV;EK>WciL>WciL>"
    A$ = A$ + "WciL>WZGLjL`i4>WciLRJ_iJiV@GL>WciC6W^gL2QciL>WciL>WciL>WciL2"
    A$ = A$ + "2=TE100@0001QQ=66gYPPdWS6865QHJ8Cj1M?j`TP63bY@Z7=jXA:UjP@9E6"
    A$ = A$ + "WD:M22=TE100P00042QD85BQD85BQD85BQD86RQH86bYL:W2ZP:YBZX::Sb\"
    A$ = A$ + "<;cb\<;cb\<[3k\>[3k`@<43a@[d:aB=EKeH=F[iN>W[iPdJUF[eJ]BYD:UB"
    A$ = A$ + "YD:8d@F500P00048T1I@6TAQD85BQH8VbYL:W2ZP:P@3IE000800800000?9"
    A$ = A$ + "?7A7A7A7A7A7A7A7A7A7?7?7A9A9A9A9A;C;C=C?EAEEGIGKIMIMKOKQMQMM"
    A$ = A$ + "OOMOOOMSOMQQUUUUUUUUUUUUUUUUUUUUUUP@3IE0002000P@842QD85BQD8U"
    A$ = A$ + "RaH<7ciP>9D212=TE100P00P00000LDLDLLTLTLTT\T\TdTd\d\ldldld4m4"
    A$ = A$ + "555===E5M5M5e=]5U=U=M=M=U=MEUE]MUU]]U]e]mUU]mmmmmmmmmmmmmmmm"
    A$ = A$ + "mmmee12=TE10P400P>B>B:B:B:B>>>>BBB0Q6bZ00@600@00PRRSRSSSSTTT"
    A$ = A$ + "TTUTVTWUWUXVYVYWYWZX:@XQ\:00040040000000PRVRWRYRWRXRWSXSXTXU"
    A$ = A$ + "YUXVZV[X\Y\[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[;@"
    A$ = A$ + "XQ\:00T000dAbAbAbABABABAbAb18d@F500b000200L<L<TDTL\\\ddldldl"
    A$ = A$ + "d4m4m4m<mD5M5M12=TE100P00P00000000<T<\D\LdLdT4UD]D]DeD]D]D5E"
    A$ = A$ + "mDEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE======12=TE200"
    A$ = A$ + "I000TCZYD[W3B86TiTH@XQ@B4cAaLYCjL>:G<N8TSHDB]7bD<311eR9d9E85"
    A$ = A$ + "D;^FZeaLD]HS]B6B1eR]6;E8USj12=TE80@XI0P37707==07;=0000000000"
    A$ = A$ + "9==0=AA0=?A00000000007==0=A?0=AA0000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "0007==0=AA0=AA0000000000=AA0ACE0ACC0000000000=AA0?CA0ACE0000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "0000000000000000000000000007==0=AA0=AA0000000000=AA0AEC0?AC0"
    A$ = A$ + "000000000=AA0ACC0AEC0000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "10001h0004P525J8[80Ph4007>>@B2BB`C3PSU5llPW6<=1hHI1??Xi1CC00"
    A$ = A$ + "00000000000@bC3NN`c3VV0TdlPW7llPY900000000000008ii1??hi1CC0B"
    A$ = A$ + "NN`c3NN`d40000000000000l<=QY94=QZ90?CCHJ2CCHZ200000000000000"
    A$ = A$ + "000000000000000P000P1L0002`4:3DXQ\R00RC00LhX89100PSTTU5000:B"
    A$ = A$ + "BFF000HIIii100PTUUW70000000000000000000000000000000000000000"
    A$ = A$ + "00000000000000000000000000000000000000000000008000H0700P0<Qb"
    A$ = A$ + "05J8[40PX0007::FF077;;PSSU5@Bbb2PU50==0NJ045108000X0700P0\1="
    A$ = A$ + "UHa1X@3IU004500h`AabBCCDTSSUUVVX877;;==AAFFJJJJRR@cBCCD4NNNN"
    A$ = A$ + "VV`ccccd4RRRRVV0AACC10005h0004P=XY4;>05J8[40P@2007>>FFNNRRRR"
    A$ = A$ + "VVVVZZLL\\ll4555==EEMMihHIii9:::JJZZjjbbBCccCDDDddDEee5JJNNR"
    A$ = A$ + "RRRVVZZ^^@CCDddddDEEEee5JJNRVVVVZZZZ^^`cCDddddDEeeee58:JJJJZ"
    A$ = A$ + "Zjjjj245====EEMMMM1RRRVVVZZ^^^^0CCCCEEEGGGII0VVZZZZ^^bb0DEEE"
    A$ = A$ + "MMMUUU1XZZZjjjj:;3`eeeEfEFFF60^^^^bbbb2000>`10080SP>9SZ\8\AC"
    A$ = A$ + "h2?0DXQ\R00R2000<6VBaD:3S9Q@:4JH<94BQ@VDBYB:UZP@ZDBUB54BUBZD"
    A$ = A$ + "bXD;UJYD54BUBZDZP@ZDBUB100H7h00PMP525J8[40Pl0002SAYH<WciT8TB"
    A$ = A$ + "aH>Wc9A8URaL>WCZD<VciL>WD:I<WciL>YDbH>WciLBYTaL>WciTBYciL>W3"
    A$ = A$ + ":UBYdiL>WC:UB94jL>WD:UBWciL>100@5h0004P=:bVC`81EXQ\B00B500<h"
    A$ = A$ + "hHIYYii9:JJJ99YYiii9JJJJZ99YYii9:JJJJbcccCDDDddDEUWWWWXXXXYY"
    A$ = A$ + "Z:GGAAACCCCCEEbbRRRRVVZZZZ`dddddDEEE5VVVVVVZZ^^`fFEEEeeee5ff"
    A$ = A$ + "ZZZZ^^^^0GGGGGGIIP[[[[[[\\000l4L00P:`6FM4>YXa2\@3IU00T100@H<"
    A$ = A$ + "8T2Q@8U1Q@:42QD:529000H0700P0<Qb05J8[40P`100021SaH<6SaH<f`HH"
    A$ = A$ + "<6SaH<6Sa4W2SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH"
    A$ = A$ + "<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH"
    A$ = A$ + "<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH[eJ]F[E0PQc5>0@"
    A$ = A$ + "IAHSc`:9MFQS6LQ6b:108T000`H@863jT@YT:YD52aH>XDBUFZUR]:4RaP@Y"
    A$ = A$ + "TB]F\5S5?Wc1QB:UJYH:f:N>WC:YD[5SaH\FL]@8UBYF;fR]H\9KQ@:UB]F<"
    A$ = A$ + "6[eHcXD]DZeRaH<6[aRBiBYD[5KaH\FS5QbVK]F<6[eJ]FC:U?gBaF]FSaJ]"
    A$ = A$ + "V<:SB6SaJ]6[eJ]8D:U<6CaD\F[eJB8<6O?6SaJ<W[eTB8<nN<E;aF]F[9UB"
    A$ = A$ + "Y<2I=VZaJ=WC:U@I<fH;ECiL>G000e3>00D9H4d9IDU5Q=J2Gh1P2=TE20@^"
    A$ = A$ + "10022YD<6SiL>WciL>W3BA:6caL>W32Q@842Q@:2aH<VciL@842Q@84BI<6c"
    A$ = A$ + "iL>842Q@84:QB:UbH>Wc1Q@84:UBYDBYDWciP@842QBYD:UB:UjL>742Q@XD"
    A$ = A$ + ":UBYDBYD842Q@842UBYD:UB:UBY@842QBXD:UBYDBYD:52Q@8D:UBYD:UB:U"
    A$ = A$ + "BY@842QBYD:UBYDBYD:52U@YD:UBYD:UB:UBYD:4:UBYD:UBYDBYD:UBUBYD"
    A$ = A$ + ":UBYD:UB:UBYDZD:UBYD:UBYDBYD:UBUBYD:UBYD:UB:UBYD:U:UBYD:UBYD"
    A$ = A$ + "BYD:UBYDYD:UBYD:UB:UBYD:U:UBYD:UBYDBYD:UBYDYD:UBYD:UB:UBYD:U"
    A$ = A$ + "BYBYD:UBYD:000j0700P0<R:]@\Cch:?2L45b`4@5J8[400b000474;]F[eZ"
    A$ = A$ + "<:Wb9UD[3IT6V3:YHWd1QD;F;E681YLB:eYP8TR1YF8SZD:VCJY@;SYD<8f:"
    A$ = A$ + "a@7SaLD>UCU@7S1000PP00`0A8c48@1@16830P3@81Y00X`2<da`514@^4bX"
    A$ = A$ + "03:L<Qc9MJ30044R<3AR8F<8a4Z6XXRY30Ha5H8O0P<dHSd^h2X;3`5d5ge1"
    A$ = A$ + "2QP@@88FL0D09P3>QKh9N3?QK`9XCAUj01000000N00h1008I3P8R8JVSS>l"
    A$ = A$ + "h3@2ATA8Y4C>151000000\30h300895P8R8JVSS>lh3@2ATA8Y4C>1U000@0"
    A$ = A$ + "4000000@04028P0000000@0000028ldIW=504X8500000000Qf20080000P4"
    A$ = A$ + ";]HhA`dAmlS?<adoFnoKo?gocmo2<H?>`>:DEP<^L@OLPMDXZ0ILm]^eVR88"
    A$ = A$ + "H2b5X10VXeXXRE]R6d^fkmjADdXA`FDD4E]J]lW_AlIaO3Jn<@PR224c<cjR"
    A$ = A$ + "E4CMZ]410@Pm4TJ0@2[3\WPD30BHm]^E;8B9VfXoH1064[PaRE[X2F@[X1=f"
    A$ = A$ + "ZF@7H^GMc_:FSPXE5Dd0ZXED\2Nm0AQbFR8X^2AAS=00lg>m<=TZ2;VFmg>m"
    A$ = A$ + "<=TZ2;VFL0e=ZV46\T13]0@cRZRATKYZ8P>1;Z8H]NOVZPX1Q`DDeeeLW]>4"
    A$ = A$ + "DFDX;`Qod\P>;9\kLMh?=;XcB2k>GO08?1<PQV0PD5823SP2bWUR6SR]DU2n"
    A$ = A$ + "L_51=PXXm>n6?D4:lT9[Ea2`JHn91@R0eY0Q^aPQJZ41ZC12MS13eD7802V0"
    A$ = A$ + "6`@;0TZ0Y4T33[`l8n;5MXA5]6D454SASOJg^\A5mh;AEK[PA;[0<H?A^VMB"
    A$ = A$ + "J4h]nmPm4iJf9YAPgjggZI]1YNCd87Vg00SE0;Z1P5@A;JEEA<\VRQHQH0FC"
    A$ = A$ + "A=0A[ZPkgCS65g4RQ1Pe<1CA5KYU6F[=0@Ml@Pf`BkPkCF7?4X=\d>hnTgbJ"
    A$ = A$ + "R82QPSL]=0@D3ZeHE4KEE]Zg[?>DdXXAD@aZJeZZJ3:R6AA:DK]FL8J4=R2R"
    A$ = A$ + "m_XRH=3K`2MXP0Pne`0>OHIjoGC=f?halW;;@i@oJH0G<d3mo[97G7lHnib9"
    A$ = A$ + "9?n70000P_100<`K0@UB0<>61@Dg4FHdR4O100hhPJ0:S2g60]1^U0HKS790"
    A$ = A$ + "00eF=8:Pa]50<L19^0T4F4F4F9G60am560a=HP0\10005B0DKQBSV0000:X6"
    A$ = A$ + "ZQYU87=\g@555000SaJ10004\HaD@DA5ED@\06VF]ed@A=0508S20E`Hc6A5"
    A$ = A$ + "eDmV5ADC500DAA\e0000`>3C00000EDa``FC3CaD\E100000005;6S002PG5"
    A$ = A$ + "KE3D9QN6VR2000002M001D_Ja=1D00000<<L1@100@]0000H_Z6008ZH]c20"
    A$ = A$ + "B2F3ZX200lT@BN296G94VAHQH928RH@LZ@R;TPlh;0ONliaU3;1P@1UQbSQ7"
    A$ = A$ + "U1hc0D2XLT<[64380008^6Hi60004000L\E[J2P:ZXRJT5J208Q=XFG\U200"
    A$ = A$ + "0PE]VQAFPE10@d\030@5=cI5cXB00002K`D1000\^90000008ZE\5ZQYH;E0"
    A$ = A$ + "0P<WXR200P^Y00POf@BX[e<CmodXf7XFlFDYjac8B2M]VI[oWVHM9@]hJAUZ"
    A$ = A$ + "Wn30000`WP0PJ[D30eCV0_1@X>U08SS108[=B\`eWFhH4XBej93`a0X<;P<["
    A$ = A$ + "]`]1@?PK90f070fUX0FkkW1T4f61@Hc:1Q5A^;^_`147\0K000X500dTf400"
    A$ = A$ + ">:>260eHE;28H`J5D15AA0D\P5;000PHHW]800XFE<2@b47SVJMDM000RH4a"
    A$ = A$ + "H]000HE5DSA\:28000PPJX:0000X00000PHWQ=R0H?000HJWmfI7000PEa@1"
    A$ = A$ + "000A\H0R92f:0000R551000000k\edT8=b>C000TD4F62O:QB1XD:O^2c8=a"
    A$ = A$ + "Y4:G2h32O<9:h`2K20000l08H;\1;M000000`d6\=000FJE[Y0000PE\ID03"
    A$ = A$ + "0XE[>B00\D\60PP]@=16\9;E0000`ZRe000DCKf@1000000adF::Ze\R0000"
    A$ = A$ + "PE]AK00001Kb0000;R^dJ0PO6A2XO^MFjogF8g[UG;JPl@J3AHg<kbeo_=en"
    A$ = A$ + "QJieR6Yeo00000l930TImF0@=U0n00ZC900DKHQ3k`2g`2a]10073PXf44eV"
    A$ = A$ + ">X=`]402l80008[=8bm;8`>Q5Q5QU`W]0;<``N<008_Q8_1;FP=000L3800A"
    A$ = A$ + "AF:00=SH`REDS8FE5Db6DeJ50000<H4e:000PRaZ200H_=VRRREe65\a@500"
    A$ = A$ + "@1005WX54ES>ZZF<A0000k=<D00000@\HH[08RH[00000000P1;00RZ00PRH"
    A$ = A$ + "X000900Pb`1H@S0000aNJ2004II5E1<=6`4000FI\1b@XD:5D28\2:Z@l4T1"
    A$ = A$ + "4@80LQPL@0lnK0a1FRTB9Q`D;0@00Vf2[000060000P=HJ9P]d`0000000`4"
    A$ = A$ + "[1000HHcX00000R5SmX00VSMR00`X\^AISF2000HQeDCK`:00XjHc2008;7S"
    A$ = A$ + "j10BbRFZ0000:J00000004e6bF5000@kJ400NJ31lY9]7lM:Vk]ORMFZY=4`"
    A$ = A$ + "WVdN`gYH^gn9fI9o300::ZDg088c?R8815eF2@=e2h50XV47S08[3HQ[79Fh"
    A$ = A$ + "@R5>]BRlV0X7`nE2PX06Gj1\_AT4F49QEn2F`n4000]<0P<]PZZeZRa:FA48"
    A$ = A$ + "YFS5A\ZaXZ82X08X:DR0:HDAD0410aJ51EEaN31Ea>015A<4A]G]7A051aF\"
    A$ = A$ + "0ZZfJX2He>C4@100[8000XH;P80000:R80RE3a0eFD000P8XHP``bB9<PbAB"
    A$ = A$ + "9D410@`FHJcT@Iakj^3@2aS3\UZ5P0082ZR82f2[KM41e:0082Pe\6FmOmeb"
    A$ = A$ + "?P20ZY=K5000\RYe50000@]UR200:00FaF:00X3=j400EBRJ=Kddd:F30004"
    A$ = A$ + "[SQ1fX00h103KdD1A0\R]4\1;E0000@7jDW000R]58XZ200000R]D0e6]Rb0"
    A$ = A$ + "800R8VFJ;==hD00@\V5F7EEe2;]I@1A40@41`Jd00008JD500h_=45HJ[XHC"
    A$ = A$ + "OmUU0Qc9m]QX0CK55Kj[_\48L>Ygf0K_Y=4cNZL@\DBA0R5PhDHa8V`0a<;V"
    A$ = A$ + "H>R1000HSMfKE4e`ZQ5;HSY9fR]F`Fk<]J_mZmf\5FHSFCE;<5D1C[HE3\d2"
    A$ = A$ + "eBK`6]0C3D10@<:JE\5^Je`LEJ0n^;:7@hJL[o4?YiGKVe:f:fJdY6K5SX\n"
    A$ = A$ + "=HAEa86A[6Efb?\5I9ci38ZJDA<H0LV?Yc7RlRKMUL100<H1E=JEbnT5l49b"
    A$ = A$ + "[6nC@ES:R130dlc`JWEFWML248GgneV:_KVm9e[b90\kRKKBn3[C0TY6U9HL"
    A$ = A$ + ">`h4N3P7G^:8@VJhJLk7008^bC@ESZ86AE4EQLM1b^90%%%0"
    RestoreFile A$, "iglooblock.ogg"

    'scorecount.ogg
    A$ = ""
    A$ = A$ + "?MfIC1P00000000000Pm]000000008h>V@A0N4PM_9WHY=7000002@4[0000"
    A$ = A$ + "000004W00000000^1ldIW=50000000000000fg2004000009ooA4B\cooooo"
    A$ = A$ + "ooooooooooooooooA>PM_9WHY=g:0000HU6LXibCbM68\UVHFmVLRUfLPT48"
    A$ = A$ + "b0C<b0S<`<38XlDK^U6LbEfLUi6MY00000@05HgKb9FJcUR@3IE00P0000@<"
    A$ = A$ + "<1Ba02=TE100@000PAB:><YI9UBYD6::iQ9U8UD:UBIa`T8VDVHaH<6SaH<6"
    A$ = A$ + "SaH<6SaH<22=TE100@000RB2>>Zi9YVciL66WhXLPVCJ>QcYPLPRA1N>98Lm"
    A$ = A$ + "V<VKVB[Y[iVcYD22=TE100P0004BQD85BQD85BQH86RQH86RQL87bQL8WbYL"
    A$ = A$ + ":X2ZP:X2bP<83bT<YCjT>YCjX>ZSjX>:d2]@;d2]B[4CaD]ESiJ_6d5OciL>"
    A$ = A$ + "WciL>WciL>Wc98d@F500P00048T1I@642Q@85BQD8VRYH:W2bP<P@3IE0008"
    A$ = A$ + "00800000759595;5;7;7=7=9?9?;A=A=A?CACAECEEEEEEGGGIGIGKGMGKGO"
    A$ = A$ + "IQIQKQKOIQKQKQMQMMOQQQQQQQQQQQQQQQOOOOOOOOOOP@3IE008100XSTSU"
    A$ = A$ + "SWRXRXQXRWSX3@XQ\:00T100400898Y8Y8iX9IZIZiJJKJ;J[JKK;;;;;;;3"
    A$ = A$ + "4J8[200010010000000XYYYYYYYYYYYYYYYYYYYYYYYYYYYIIIIIIIIIIIII"
    A$ = A$ + "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII14J8[2009000MLLLLLLTDTD"
    A$ = A$ + "TL\L\L02=TE10P<00P00095;5;7=7=7=7?7?7?7?7A7A9C9C=C?C?P@3IE00"
    A$ = A$ + "0800800000000537577797=9?9E;C;G=G=G?G?GCGGGGGEEEEEEEEEEEEEEE"
    A$ = A$ + "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEP@3IE000100@8MJVUZ182c0IHP@3I"
    A$ = A$ + "E00P0000H4:23a02=TE10001000RQB>8J2]VcgL>>XIiPV:5K>M`9BeVWTKZ"
    A$ = A$ + "H^iL>WciLbVcI<>WciL::WIaPV9dJ>Wc9aPVU2JV@[iL>WW4KN@[Y:]VciL6"
    A$ = A$ + "WcY36WAHL>WcY9]V7TJfH]iL>W5dJJ>ZiBaVciLRD^i9eV;EK>WciL>WciL>"
    A$ = A$ + "WciL>WZGLjL`i4>WciLRJ_iJiV@GL>WciC6W^gL2QciL>WciL>WciL>WciL2"
    A$ = A$ + "2=TE100@0001QQ=66gYPPdWS6865QHJ8Cj1M?j`TP63bY@Z7=jXA:UjP@9E6"
    A$ = A$ + "WD:M22=TE100P00042QD85BQD85BQD85BQD86RQH86bYL:W2ZP:YBZX::Sb\"
    A$ = A$ + "<;cb\<;cb\<[3k\>[3k`@<43a@[d:aB=EKeH=F[iN>W[iPdJUF[eJ]BYD:UB"
    A$ = A$ + "YD:8d@F500P00048T1I@6TAQD85BQH8VbYL:W2ZP:P@3IE000800800000?9"
    A$ = A$ + "?7A7A7A7A7A7A7A7A7A7?7?7A9A9A9A9A;C;C=C?EAEEGIGKIMIMKOKQMQMM"
    A$ = A$ + "OOMOOOMSOMQQUUUUUUUUUUUUUUUUUUUUUUP@3IE0002000P@842QD85BQD8U"
    A$ = A$ + "RaH<7ciP>9D212=TE100P00P00000LDLDLLTLTLTT\T\TdTd\d\ldldld4m4"
    A$ = A$ + "555===E5M5M5e=]5U=U=M=M=U=MEUE]MUU]]U]e]mUU]mmmmmmmmmmmmmmmm"
    A$ = A$ + "mmmee12=TE10P400P>B>B:B:B:B>>>>BBB0Q6bZ00@600@00PRRSRSSSSTTT"
    A$ = A$ + "TTUTVTWUWUXVYVYWYWZX:@XQ\:00040040000000PRVRWRYRWRXRWSXSXTXU"
    A$ = A$ + "YUXVZV[X\Y\[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[;@"
    A$ = A$ + "XQ\:00T000dAbAbAbABABABAbAb18d@F500b000200L<L<TDTL\\\ddldldl"
    A$ = A$ + "d4m4m4m<mD5M5M12=TE100P00P00000000<T<\D\LdLdT4UD]D]DeD]D]D5E"
    A$ = A$ + "mDEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE======12=TE200"
    A$ = A$ + "I000TCZYD[W3B86TiTH@XQ@B4cAaLYCjL>:G<N8TSHDB]7bD<311eR9d9E85"
    A$ = A$ + "D;^FZeaLD]HS]B6B1eR]6;E8USj12=TE80@XI0P37707==07;=0000000000"
    A$ = A$ + "9==0=AA0=?A00000000007==0=A?0=AA0000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "0007==0=AA0=AA0000000000=AA0ACE0ACC0000000000=AA0?CA0ACE0000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "0000000000000000000000000007==0=AA0=AA0000000000=AA0AEC0?AC0"
    A$ = A$ + "000000000=AA0ACC0AEC0000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "10001h0004P525J8[80Ph4007>>@B2BB`C3PSU5llPW6<=1hHI1??Xi1CC00"
    A$ = A$ + "00000000000@bC3NN`c3VV0TdlPW7llPY900000000000008ii1??hi1CC0B"
    A$ = A$ + "NN`c3NN`d40000000000000l<=QY94=QZ90?CCHJ2CCHZ200000000000000"
    A$ = A$ + "000000000000000P000P1L0002`4:3DXQ\R00RC00LhX89100PSTTU5000:B"
    A$ = A$ + "BFF000HIIii100PTUUW70000000000000000000000000000000000000000"
    A$ = A$ + "00000000000000000000000000000000000000000000008000H0700P0<Qb"
    A$ = A$ + "05J8[40PX0007::FF077;;PSSU5@Bbb2PU50==0NJ045108000X0700P0\1="
    A$ = A$ + "UHa1X@3IU004500h`AabBCCDTSSUUVVX877;;==AAFFJJJJRR@cBCCD4NNNN"
    A$ = A$ + "VV`ccccd4RRRRVV0AACC10005h0004P=XY4;>05J8[40P@2007>>FFNNRRRR"
    A$ = A$ + "VVVVZZLL\\ll4555==EEMMihHIii9:::JJZZjjbbBCccCDDDddDEee5JJNNR"
    A$ = A$ + "RRRVVZZ^^@CCDddddDEEEee5JJNRVVVVZZZZ^^`cCDddddDEeeee58:JJJJZ"
    A$ = A$ + "Zjjjj245====EEMMMM1RRRVVVZZ^^^^0CCCCEEEGGGII0VVZZZZ^^bb0DEEE"
    A$ = A$ + "MMMUUU1XZZZjjjj:;3`eeeEfEFFF60^^^^bbbb2000>`10080SP>9SZ\8\AC"
    A$ = A$ + "h2?0DXQ\R00R2000<6VBaD:3S9Q@:4JH<94BQ@VDBYB:UZP@ZDBUB54BUBZD"
    A$ = A$ + "bXD;UJYD54BUBZDZP@ZDBUB100H7h00PMP525J8[40Pl0002SAYH<WciT8TB"
    A$ = A$ + "aH>Wc9A8URaL>WCZD<VciL>WD:I<WciL>YDbH>WciLBYTaL>WciTBYciL>W3"
    A$ = A$ + ":UBYdiL>WC:UB94jL>WD:UBWciL>100@5h0004P=:bVC`81EXQ\B00B500<h"
    A$ = A$ + "hHIYYii9:JJJ99YYiii9JJJJZ99YYii9:JJJJbcccCDDDddDEUWWWWXXXXYY"
    A$ = A$ + "Z:GGAAACCCCCEEbbRRRRVVZZZZ`dddddDEEE5VVVVVVZZ^^`fFEEEeeee5ff"
    A$ = A$ + "ZZZZ^^^^0GGGGGGIIP[[[[[[\\000l4L00P:`6FM4>YXa2\@3IU00T100@H<"
    A$ = A$ + "8T2Q@8U1Q@:42QD:529000H0700P0<Qb05J8[40P`100021SaH<6SaH<f`HH"
    A$ = A$ + "<6SaH<6Sa4W2SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH"
    A$ = A$ + "<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH"
    A$ = A$ + "<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH[eJ]F[E0PQc5>0@"
    A$ = A$ + "IAHSc`:9MFQS6LQ6b:108T000`H@863jT@YT:YD52aH>XDBUFZUR]:4RaP@Y"
    A$ = A$ + "TB]F\5S5?Wc1QB:UJYH:f:N>WC:YD[5SaH\FL]@8UBYF;fR]H\9KQ@:UB]F<"
    A$ = A$ + "6[eHcXD]DZeRaH<6[aRBiBYD[5KaH\FS5QbVK]F<6[eJ]FC:U?gBaF]FSaJ]"
    A$ = A$ + "V<:SB6SaJ]6[eJ]8D:U<6CaD\F[eJB8<6O?6SaJ<W[eTB8<nN<E;aF]F[9UB"
    A$ = A$ + "Y<2I=VZaJ=WC:U@I<fH;ECiL>G000e3>00D9H4d9IDU5Q=J2Gh1P2=TE20@^"
    A$ = A$ + "10022YD<6SiL>WciL>W3BA:6caL>W32Q@842Q@:2aH<VciL@842Q@84BI<6c"
    A$ = A$ + "iL>842Q@84:QB:UbH>Wc1Q@84:UBYDBYDWciP@842QBYD:UB:UjL>742Q@XD"
    A$ = A$ + ":UBYDBYD842Q@842UBYD:UB:UBY@842QBXD:UBYDBYD:52Q@8D:UBYD:UB:U"
    A$ = A$ + "BY@842QBYD:UBYDBYD:52U@YD:UBYD:UB:UBYD:4:UBYD:UBYDBYD:UBUBYD"
    A$ = A$ + ":UBYD:UB:UBYDZD:UBYD:UBYDBYD:UBUBYD:UBYD:UB:UBYD:U:UBYD:UBYD"
    A$ = A$ + "BYD:UBYDYD:UBYD:UB:UBYD:U:UBYD:UBYDBYD:UBYDYD:UBYD:UB:UBYD:U"
    A$ = A$ + "BYBYD:UBYD:000j0700P0<R:]@\Cch:?2L45b`4@5J8[400b000474;]F[eZ"
    A$ = A$ + "<:Wb9UD[3IT6V3:YHWd1QD;F;E681YLB:eYP8TR1YF8SZD:VCJY@;SYD<8f:"
    A$ = A$ + "a@7SaLD>UCU@7S1000PP00`0A8c48@1@16830P3@81Y00X`2<da`514@^4bX"
    A$ = A$ + "03:L<Qc9MJ30044R<3AR8F<8a4Z6XXRY30Ha5H8O0P<dHSd^h2X;3`5d5ge1"
    A$ = A$ + "2QP@@88FL0D09P3>QKh9N3?QK`9XCAUj01000000N00h1008I3P8R8JVSS>l"
    A$ = A$ + "h3@2ATA8Y4C>151000000\30h300895P8R8JVSS>lh3@2ATA8Y4C>1U000@0"
    A$ = A$ + "4000000@04028P0000000@0000028ldIW=504@@200000000fg200800000:"
    A$ = A$ + "[k0g80UDogdoil?6Lf_RLf8`?9>5?AKWm[8W=2lCRCaCdfII]R8@`1;T[900"
    A$ = A$ + "a:X6SPJZH=[8_kc:JdX8RPZ:2ZJE=R8JdQ\`OfZJE=NQ[TPY]dFJYY2PYe]^"
    A$ = A$ + "Un11nc3d86m@A?Ka1W0oi1J4SNXXW]hPc;0;[9=JCJ20J205Ka`414Q?EH>L"
    A$ = A$ + "X6ZXXfBAS5\HAWFS5;8FEW:PX6VRe]U6R20Z=gI[FWZR100[K;U0JM3S5^V;"
    A$ = A$ + "\@c7?mkgA?UbGXn4[^Qa2Gc5FXiSWnmkXWBi;DORm=00dZod;SeG200>@d00"
    A$ = A$ + "04C\hf000a8J000a8n;100@H3d;53W1fFP80@BTAIMZN<F_5IT40@`>000@]"
    A$ = A$ + "A:3B2b`ZYYQQQ]Z5E5CK<<0T]000Z008;008Z008;10P:ZQYH5[F\1@1AaDD"
    A$ = A$ + ";6fJ:PJDaHD`R1S8F<ZeRJ0515TbSWhDa4P3OFAi29i`UU:434R8:;7>Pb:8"
    A$ = A$ + "Ja:6]:XXRZJRh`7EMJFeB^?MgK@9P`5\Ba3LHYDbggUb>TFZVE[NKnf?JIAU"
    A$ = A$ + "d346:HiAh82OQhc14W<AgT:B;Z_KnRW^k=QBH9\<LI4T_@B:4;mFYUFFJ?l]"
    A$ = A$ + "@g_kOa8F6eY8\4:7F2O1XR`:^`RccJDa2R11Pbb`16Z3]R5S100J20T0001A"
    A$ = A$ + "5<\IaV\DDA5500P7h@OAT]ZSY7kZE\93U9GP3m5AfZ>VN\[FaV<DVLGA2VcH"
    A$ = A$ + "FT:a5c>MVX0C:5n9@BBDCe2<A1<9cW14<A300\`K3P9Jk10000@=]c@=]8HS"
    A$ = A$ + "53k\HaFk]gZ]fR]:Z5[66HXZZVZJ2F\e`6C3D[Z6E=6S5eZ:Z2:PQQ1fI7ZR"
    A$ = A$ + "ZX::6HJ?00:f;Ha>A\0X:ZRMFDA01A40[H5Kb2;\V8FXVZUFeB[ZP65DD@A\"
    A$ = A$ + "P5[RZFDEAE5EE\[IgM6Zc@URQ7Z9ZYHJ=[H;]@=<TfiXAm\oXJkFd:JWg[ec"
    A$ = A$ + "<AED<`:fT=KQ:RX2P]odjI:9o;b_inB3::XXPP5\hodjIoIBfRlkXcN5=820"
    A$ = A$ + "P1kF?3@4PjIn=Io_GNJP9CZMlC78:82200E00Cb00:5\D:;5L92`:ion\6h_"
    A$ = A$ + "MmB@eH385MPWg@W6V=\HkGk>k\UeRSLN3MJHf`R]O]k\cFF;>bk>M78BR5;5"
    A$ = A$ + "V8IN1P`091Y245`dN1<C2000A5E0DadRmfJHJJ=KfFHcfT=J3Fg:FJXPJHYE"
    A$ = A$ + "\Ze\AKbV]9Kf6\A[IE[HYQRHJ5[KCfBKbV]VE]`DXnMgMgMgMgE5Rle]gNk]"
    A$ = A$ + "gNKflncOncR28VFHE[IE;DP?oi?;0ile]gFVc6FmcOnc2REDeXESFMXESZ0O"
    A$ = A$ + "ncOnc^\N[KM[>imWolW550E<]`ZFcjFaBSWli?oi?3K^e]V;leWo\X2P:VFa"
    A$ = A$ + "jfT=K3F:Omi?3TcgNKYOoi?3li?300F\RZ6]J:YF[eZ0OmIKf2D3;]`B;<=<"
    A$ = A$ + "5EDImFgjF1n\;<KM[cF1%400"
    RestoreFile A$, "scorecount.ogg"

    'fish.ogg
    A$ = ""
    A$ = A$ + "?MfIC1P000000000000A\00000000T\6QNE0N4PM_9WHY=7000002@4[0000"
    A$ = A$ + "000004W00000000^1ldIW=500000000000004a20040000@>R@MaB\cooooo"
    A$ = A$ + "ooooooooooooooooA>PM_9WHY=g:0000HU6LXibCbM68\UVHFmVLRUfLPT48"
    A$ = A$ + "b0C<b0S<`<38XlDK^U6LbEfLUi6MY00000@05HgKb9FJcUR@3IE00P0000@<"
    A$ = A$ + "<1Ba02=TE100@000PAB:><YI9UBYD6::iQ9U8UD:UBIa`T8VDVHaH<6SaH<6"
    A$ = A$ + "SaH<6SaH<22=TE100@000RB2>>Zi9YVciL66WhXLPVCJ>QcYPLPRA1N>98Lm"
    A$ = A$ + "V<VKVB[Y[iVcYD22=TE100P0004BQD85BQD85BQH86RQH86RQL87bQL8WbYL"
    A$ = A$ + ":X2ZP:X2bP<83bT<YCjT>YCjX>ZSjX>:d2]@;d2]B[4CaD]ESiJ_6d5OciL>"
    A$ = A$ + "WciL>WciL>Wc98d@F500P00048T1I@642Q@85BQD8VRYH:W2bP<P@3IE0008"
    A$ = A$ + "00800000759595;5;7;7=7=9?9?;A=A=A?CACAECEEEEEEGGGIGIGKGMGKGO"
    A$ = A$ + "IQIQKQKOIQKQKQMQMMOQQQQQQQQQQQQQQQOOOOOOOOOOP@3IE008100XSTSU"
    A$ = A$ + "SWRXRXQXRWSX3@XQ\:00T100400898Y8Y8iX9IZIZiJJKJ;J[JKK;;;;;;;3"
    A$ = A$ + "4J8[200010010000000XYYYYYYYYYYYYYYYYYYYYYYYYYYYIIIIIIIIIIIII"
    A$ = A$ + "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII14J8[2009000MLLLLLLTDTD"
    A$ = A$ + "TL\L\L02=TE10P<00P00095;5;7=7=7=7?7?7?7?7A7A9C9C=C?C?P@3IE00"
    A$ = A$ + "0800800000000537577797=9?9E;C;G=G=G?G?GCGGGGGEEEEEEEEEEEEEEE"
    A$ = A$ + "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEP@3IE000100@8MJVUZ182c0IHP@3I"
    A$ = A$ + "E00P0000H4:23a02=TE10001000RQB>8J2]VcgL>>XIiPV:5K>M`9BeVWTKZ"
    A$ = A$ + "H^iL>WciLbVcI<>WciL::WIaPV9dJ>Wc9aPVU2JV@[iL>WW4KN@[Y:]VciL6"
    A$ = A$ + "WcY36WAHL>WcY9]V7TJfH]iL>W5dJJ>ZiBaVciLRD^i9eV;EK>WciL>WciL>"
    A$ = A$ + "WciL>WZGLjL`i4>WciLRJ_iJiV@GL>WciC6W^gL2QciL>WciL>WciL>WciL2"
    A$ = A$ + "2=TE100@0001QQ=66gYPPdWS6865QHJ8Cj1M?j`TP63bY@Z7=jXA:UjP@9E6"
    A$ = A$ + "WD:M22=TE100P00042QD85BQD85BQD85BQD86RQH86bYL:W2ZP:YBZX::Sb\"
    A$ = A$ + "<;cb\<;cb\<[3k\>[3k`@<43a@[d:aB=EKeH=F[iN>W[iPdJUF[eJ]BYD:UB"
    A$ = A$ + "YD:8d@F500P00048T1I@6TAQD85BQH8VbYL:W2ZP:P@3IE000800800000?9"
    A$ = A$ + "?7A7A7A7A7A7A7A7A7A7?7?7A9A9A9A9A;C;C=C?EAEEGIGKIMIMKOKQMQMM"
    A$ = A$ + "OOMOOOMSOMQQUUUUUUUUUUUUUUUUUUUUUUP@3IE0002000P@842QD85BQD8U"
    A$ = A$ + "RaH<7ciP>9D212=TE100P00P00000LDLDLLTLTLTT\T\TdTd\d\ldldld4m4"
    A$ = A$ + "555===E5M5M5e=]5U=U=M=M=U=MEUE]MUU]]U]e]mUU]mmmmmmmmmmmmmmmm"
    A$ = A$ + "mmmee12=TE10P400P>B>B:B:B:B>>>>BBB0Q6bZ00@600@00PRRSRSSSSTTT"
    A$ = A$ + "TTUTVTWUWUXVYVYWYWZX:@XQ\:00040040000000PRVRWRYRWRXRWSXSXTXU"
    A$ = A$ + "YUXVZV[X\Y\[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[;@"
    A$ = A$ + "XQ\:00T000dAbAbAbABABABAbAb18d@F500b000200L<L<TDTL\\\ddldldl"
    A$ = A$ + "d4m4m4m<mD5M5M12=TE100P00P00000000<T<\D\LdLdT4UD]D]DeD]D]D5E"
    A$ = A$ + "mDEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE======12=TE200"
    A$ = A$ + "I000TCZYD[W3B86TiTH@XQ@B4cAaLYCjL>:G<N8TSHDB]7bD<311eR9d9E85"
    A$ = A$ + "D;^FZeaLD]HS]B6B1eR]6;E8USj12=TE80@XI0P37707==07;=0000000000"
    A$ = A$ + "9==0=AA0=?A00000000007==0=A?0=AA0000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "0007==0=AA0=AA0000000000=AA0ACE0ACC0000000000=AA0?CA0ACE0000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "0000000000000000000000000007==0=AA0=AA0000000000=AA0AEC0?AC0"
    A$ = A$ + "000000000=AA0ACC0AEC0000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "000000000000000000000000000000000000000000000000000000000000"
    A$ = A$ + "10001h0004P525J8[80Ph4007>>@B2BB`C3PSU5llPW6<=1hHI1??Xi1CC00"
    A$ = A$ + "00000000000@bC3NN`c3VV0TdlPW7llPY900000000000008ii1??hi1CC0B"
    A$ = A$ + "NN`c3NN`d40000000000000l<=QY94=QZ90?CCHJ2CCHZ200000000000000"
    A$ = A$ + "000000000000000P000P1L0002`4:3DXQ\R00RC00LhX89100PSTTU5000:B"
    A$ = A$ + "BFF000HIIii100PTUUW70000000000000000000000000000000000000000"
    A$ = A$ + "00000000000000000000000000000000000000000000008000H0700P0<Qb"
    A$ = A$ + "05J8[40PX0007::FF077;;PSSU5@Bbb2PU50==0NJ045108000X0700P0\1="
    A$ = A$ + "UHa1X@3IU004500h`AabBCCDTSSUUVVX877;;==AAFFJJJJRR@cBCCD4NNNN"
    A$ = A$ + "VV`ccccd4RRRRVV0AACC10005h0004P=XY4;>05J8[40P@2007>>FFNNRRRR"
    A$ = A$ + "VVVVZZLL\\ll4555==EEMMihHIii9:::JJZZjjbbBCccCDDDddDEee5JJNNR"
    A$ = A$ + "RRRVVZZ^^@CCDddddDEEEee5JJNRVVVVZZZZ^^`cCDddddDEeeee58:JJJJZ"
    A$ = A$ + "Zjjjj245====EEMMMM1RRRVVVZZ^^^^0CCCCEEEGGGII0VVZZZZ^^bb0DEEE"
    A$ = A$ + "MMMUUU1XZZZjjjj:;3`eeeEfEFFF60^^^^bbbb2000>`10080SP>9SZ\8\AC"
    A$ = A$ + "h2?0DXQ\R00R2000<6VBaD:3S9Q@:4JH<94BQ@VDBYB:UZP@ZDBUB54BUBZD"
    A$ = A$ + "bXD;UJYD54BUBZDZP@ZDBUB100H7h00PMP525J8[40Pl0002SAYH<WciT8TB"
    A$ = A$ + "aH>Wc9A8URaL>WCZD<VciL>WD:I<WciL>YDbH>WciLBYTaL>WciTBYciL>W3"
    A$ = A$ + ":UBYdiL>WC:UB94jL>WD:UBWciL>100@5h0004P=:bVC`81EXQ\B00B500<h"
    A$ = A$ + "hHIYYii9:JJJ99YYiii9JJJJZ99YYii9:JJJJbcccCDDDddDEUWWWWXXXXYY"
    A$ = A$ + "Z:GGAAACCCCCEEbbRRRRVVZZZZ`dddddDEEE5VVVVVVZZ^^`fFEEEeeee5ff"
    A$ = A$ + "ZZZZ^^^^0GGGGGGIIP[[[[[[\\000l4L00P:`6FM4>YXa2\@3IU00T100@H<"
    A$ = A$ + "8T2Q@8U1Q@:42QD:529000H0700P0<Qb05J8[40P`100021SaH<6SaH<f`HH"
    A$ = A$ + "<6SaH<6Sa4W2SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH"
    A$ = A$ + "<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH"
    A$ = A$ + "<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH<6SaH[eJ]F[E0PQc5>0@"
    A$ = A$ + "IAHSc`:9MFQS6LQ6b:108T000`H@863jT@YT:YD52aH>XDBUFZUR]:4RaP@Y"
    A$ = A$ + "TB]F\5S5?Wc1QB:UJYH:f:N>WC:YD[5SaH\FL]@8UBYF;fR]H\9KQ@:UB]F<"
    A$ = A$ + "6[eHcXD]DZeRaH<6[aRBiBYD[5KaH\FS5QbVK]F<6[eJ]FC:U?gBaF]FSaJ]"
    A$ = A$ + "V<:SB6SaJ]6[eJ]8D:U<6CaD\F[eJB8<6O?6SaJ<W[eTB8<nN<E;aF]F[9UB"
    A$ = A$ + "Y<2I=VZaJ=WC:U@I<fH;ECiL>G000e3>00D9H4d9IDU5Q=J2Gh1P2=TE20@^"
    A$ = A$ + "10022YD<6SiL>WciL>W3BA:6caL>W32Q@842Q@:2aH<VciL@842Q@84BI<6c"
    A$ = A$ + "iL>842Q@84:QB:UbH>Wc1Q@84:UBYDBYDWciP@842QBYD:UB:UjL>742Q@XD"
    A$ = A$ + ":UBYDBYD842Q@842UBYD:UB:UBY@842QBXD:UBYDBYD:52Q@8D:UBYD:UB:U"
    A$ = A$ + "BY@842QBYD:UBYDBYD:52U@YD:UBYD:UB:UBYD:4:UBYD:UBYDBYD:UBUBYD"
    A$ = A$ + ":UBYD:UB:UBYDZD:UBYD:UBYDBYD:UBUBYD:UBYD:UB:UBYD:U:UBYD:UBYD"
    A$ = A$ + "BYD:UBYDYD:UBYD:UB:UBYD:U:UBYD:UBYDBYD:UBYDYD:UBYD:UB:UBYD:U"
    A$ = A$ + "BYBYD:UBYD:000j0700P0<R:]@\Cch:?2L45b`4@5J8[400b000474;]F[eZ"
    A$ = A$ + "<:Wb9UD[3IT6V3:YHWd1QD;F;E681YLB:eYP8TR1YF8SZD:VCJY@;SYD<8f:"
    A$ = A$ + "a@7SaLD>UCU@7S1000PP00`0A8c48@1@16830P3@81Y00X`2<da`514@^4bX"
    A$ = A$ + "03:L<Qc9MJ30044R<3AR8F<8a4Z6XXRY30Ha5H8O0P<dHSd^h2X;3`5d5ge1"
    A$ = A$ + "2QP@@88FL0D09P3>QKh9N3?QK`9XCAUj01000000N00h1008I3P8R8JVSS>l"
    A$ = A$ + "h3@2ATA8Y4C>151000000\30h300895P8R8JVSS>lh3@2ATA8Y4C>1U000@0"
    A$ = A$ + "4000000@04028P0000000@0000028ldIW=5000d;000000004a20080000@e"
    A$ = A$ + "4ACCK\eECm_MocdofloAo[aoImoGoWboQmoLokeoFA?5K<f1S1i9b_KWO:fi"
    A$ = A$ + "<]1ib9m5Zgf_egCUm:0hH`hT`iKHMIKF>X?[XjmonOGE^lX;mD\8NUJ^=mV5"
    A$ = A$ + "OlJadRUO^GQioEJC^9W_og11KT3_njV5alNe^ll\800m1TI104`Vn0BZ0We8"
    A$ = A$ + "Pfdj3PM550DCPT5PC8HiCh<JK=QJZ4567556Z07B0aM@66_4m6oSVYO^GOEi"
    A$ = A$ + "HU@ODjUXa?JV^[gDE9jU:U::;ZGe\\FYjYFBK00i94j0:@Qmg38<204`YYoT"
    A$ = A$ + "Hk850\gBa>K\G]XRVD]0e0]V;Q4h9`a;MLT2gML6DoegEmkEe[GM]O^o[N[S"
    A$ = A$ + "[cl9@knXKi7bGc^OBfmGJlR4@MA91X_I4fBeLM4Alb26S_=4TB58434\JRgO"
    A$ = A$ + "00000NA@B8JGh6KW?K[_]NO7AhFGK@I000e83A6]AQ40`b?C<f^F6S=YckCL"
    A$ = A$ + "lBfXP:;YeQQPAE8h5VD3I^J=MMCB3G?N9njTP;KYC^b>0^W[9ZXB@h0fM>GO"
    A$ = A$ + ":ZXKe060@\8FJ=3A9400JEUaJdD500PV7?A=5UZ200h5L@\]T008[0SlJX10"
    A$ = A$ + "PT:HUT``@00@^U9C76>0`<bRZb8M:B8Kgb=DJ9@EY24eJ<MHTC2085^DDIRI"
    A$ = A$ + "I10;61>IF=20_D@C1cJhDDMIED95UMhDYe<=D2bF\>@Y@8Q\g`BcX191BB24"
    A$ = A$ + "meRXe^Y00^V=i;bf200d<`R5396`5he1g500@2i:6gT509<d4F60P4BPU5o1"
    A$ = A$ + "R5<_591TD00458H`F@T]X9=0l600TA[HK00I@a8`^0`@Id:LJfEYi818DHB9"
    A$ = A$ + "9108\LeLOP[b5A@6_\j7HfX7F@OW53KJ50RFBY0X2hF200PWh`Ne7AMXe97F"
    A$ = A$ + "=8P@>QBdhH:6eO<jEm2aNn2k^\=4eHfaXQI=dPYUN50006VF5c:9Y=ER5Kej"
    A$ = A$ + "D=3ZYUjX6UKcIM\\BfIK;LS\Cc>_]@`R@\BJFZEAeHA@01DDeXE14A4P1\23"
    A$ = A$ + "2e<Hk@KgZJk5YB;25=:^J:PT0`0X`P`d6?HP>AQ1Qm<Dc00eJigNkQ1@:@7U"
    A$ = A$ + "J6Aj3DdMdPDF\nR:@VIJ<f4BXLC1008RJ9B7902=mfUUJ]A>k\CJ@T4[XZg2"
    A$ = A$ + "HFlTTC]RaNN;308XA9;cBf1d00DAQJ5<fHP:SS2UiSA<[296OSZ=CQZP99k4"
    A$ = A$ + "B9TYL>0hb[4f[``HV:=@4APV4jT6BJXGUc6PV^7PfASPh1>CdZ:eKO@QB\aR"
    A$ = A$ + ";5M?;>0100MiLDh;B?EI[<;bA>b2040XZ2gZ:P@8Q`:>`2@40<bBe7E93UYS"
    A$ = A$ + "X;eMJ050NN3UJG9RE21GEM4i4Ug@]aDV4[0B^Zj0b9hCe81AmFKU<b8S40IA"
    A$ = A$ + "IMggVci`;PC4W6e;F8V3RWH7i000044S2F]mMEGSeH=6]D@D4R6;7kc=cf<O"
    A$ = A$ + "8O8O@dL=oP\nGoS2CdBUFDA5ED;6;9;]R56000PYD7ZJ5AY@0000dZAdJ]f0"
    A$ = A$ + "00@XXKd3EDE]5080[3ebF490310PF=HSXXGA200X@K;HWPP00H2\1I76K00P"
    A$ = A$ + "h0H0`^d60@d:m]20mZP064AA40Q3`30H;b4]0\OSk08FZD`1`02:@B9F:D00"
    A$ = A$ + "T5FJA;FbP00=_=0000Xa>4\P100P67R2a=H@038E11<HP[51T@XT14D0@\E]"
    A$ = A$ + "70Xei2\bDB06lA:90`A33000R`5m[]@B;bFS@JM;:>50;0XZ1<iDR:akD<f0"
    A$ = A$ + "NM35EO<\0jQ:6Qj6:ZnHI1d35=3O3000kn=00@kn9fVcDiXDi`PhDiGVCTk2"
    A$ = A$ + "<MXcD00000AfR041CEETD333k<<[A000]VM3k<9[BED4@H>\LI1H4G:QhcW["
    A$ = A$ + "^lJEj7\0D7UB10Q0800iFVEE]5fTQR0000FAWJdZC;2000PXZH;RZF3000PX"
    A$ = A$ + ":h2MX1000LeE:H@[F4008LE2E?0k>aPR61`0F\026\FST80G6hl54GU0hK0_"
    A$ = A$ + ">000E]F``J`Z000D`Fn50n\6I3000F[:b]60PP0<]e0000HEDd\BS10000H4"
    A$ = A$ + "[cN0Pb@Q>dQ>[Y1`000XSeX=L0H`VEE1A000X=6aJF0D0400P:jH8G0F[Z1E"
    A$ = A$ + "E000@`R5\R>:00000TBaE:30HOB8m00HT1CD0000hPHQ1EMG20H1G\061dGG"
    A$ = A$ + "F100A\H10<j5ijS?XaD[>Ql1Bc78K<<XaD[>1?@Hl0ISakN`<0dkL_82`9>h"
    A$ = A$ + "PCLRSV3a;4V\21UTIJ1L100P]fHJJE<=`>3C;F]HHSH3PE\7E]Hed>3;FD\c"
    A$ = A$ + "NK``4e4E\XHMXE7jDdYZ>eZZB8680Q6<kmgk0nnZ@:9R@^\<3BZ8H34Qfmm>"
    A$ = A$ + "V@56H10`fJiKci2000Y8QBT=0TDQB`000R5]R>A;fH0040S:ZSFEE3P8PaH0"
    A$ = A$ + "4AdX09108SG^=;YR4fPEHPe8`fE5g=0hfnK4AAAd<2EPT8b1F60023ch=8m;"
    A$ = A$ + "daHIXP600<>39430lPl820PN[`;F0:;k:ek1f<goh12F97lU;C6F_EhoNnB4"
    A$ = A$ + "006\SaO9=@4DTJGMAa20P0Q0TH1G2hc=D<jVDVbG?4\j^P56;3c=D<JV4RYl"
    A$ = A$ + "eZP5GHQaZ`G200_Y\VY?WJR^40<mgWKnYhMTSV>bAYj0\P8MZCJ7iXY;0000"
    A$ = A$ + "0A;PfJ>4FcG<:RPE@X88:6Z]1WfP78@4H20R:0G2QUQUQ`E@9=[H2Z0:jDSZ"
    A$ = A$ + "REeXF[BMFXU000>02RE]9[ZFc6\@D0<0002JeQ=R6510000aB[XVRXF>6C50"
    A$ = A$ + "00aFDdYN\E@0fT0005JE`8H;:jE00P0SRF101GA[90PSb:hDbf80T9@3\SK4"
    A$ = A$ + "3PeXR000gKIadH0000lRA0Ge0000PXXAA64^e00ffR`:5<T00\k;;dZ00000"
    A$ = A$ + "0R>dXXcZ]100ReKWe\D22700`0e`V6X100000B=j<dX8P]6]JeJP10000[A5"
    A$ = A$ + "552h@47H@11200hf6\XM1000Hb];;30@0@dZPA0;EGCEa002VZJ5`8\\FET<"
    A$ = A$ + "00;F0go2nK39JeiFOeG3>^Vk>W]T<dlK39JeiFOeG3>^Vk>W]T<Ln[00`a@T"
    A$ = A$ + "AeRj=Z42LF60RT8WIYJj8oHi10A>Qe2637i87U200000Z2F\ReH5SPH5aHZZ"
    A$ = A$ + "QJ13410100@3VFU8Ca4Q1DF:;;[h41TPS4Fa6\`2[HHQ5RQ0VXAB5Amm<0H5"
    A$ = A$ + "E5EaJ5=N1`d`B3;5C[;fP128f;GC<]ZH=11000\RZR1Se:J404004;F<H\FA"
    A$ = A$ + "SP@2e:50Se:J440Pl]U<l_\6114;08600SE5M88D[M006_BdEP<4;bJT1000"
    A$ = A$ + "\ZX3@L0P00009NUR>2RLP50000XXSHTAW4C3e10`[FVH[J20>0Xg1000H0@A"
    A$ = A$ + "cPAFP:hPBVI5K;R000000=ZT9KKQO300SEEd4Q000008_\8;Z:J010000@F6"
    A$ = A$ + "_^X2804;60KUZ00@T;=PEEd58P04PD5o[A7PP028FoR2028f:J0HJHPog`Rf"
    A$ = A$ + "7[Lb9@kJKZB>QncHAkSENi4XM]=EaHhMAEI88U5A=51\hdCU3>8F:CWNS:BT"
    A$ = A$ + "823ZTfeM8>000@=HDaJE1S1A\HWQEC[2FDa>eFk`JVHE<]1;]1[S=JMKdB;A"
    A$ = A$ + "mVDg4[X:ZP8JdXA@]9bVlMW8eo69I=ZOEI3Yno?Anj40HYK:TEO:TE0EE]ZZ"
    A$ = A$ + "HaRaY;Q8JDdQXH<02000886]VFgdBUB0D0f4i[FLCP0<T0@C3Fa1U0KSCFX;"
    A$ = A$ + "6@PacU5k;MU=8H`b;6CeT55mB@P4[e=U000P;EGYJ7DFR1000AASR2H00gh]"
    A$ = A$ + "J`NUZF\80@AQ000HTbnC4F8lX\L1oDh];CTT000\<000PGG3m@V000PF222H"
    A$ = A$ + "GVT`PPH_BkJEE5F000`6PAZXP1mP6hQ=d``c^LCKmOgj]j?hkPRVY`6JHhIG"
    A$ = A$ + "]Y]n_KmFm7lM@55PW;308;Z]>00`=Hk=K2\]]W;^LddA28BHQ5FH2C14@0jl"
    A$ = A$ + "90004SE55AaX6aX=200\:RPVJJJ@RUTfE[F^Na@0EAD4U;Q7X\D`0F>4n<44"
    A$ = A$ + "D4DA\Ze\Z8VJ]PZA4A`2610``ZFcBAD4=:P060000<\^=HE4E=\0[KE5@405"
    A$ = A$ + "14<:jDS:26<]^Y8Z2:28h5g2FD3[IQP000LT780:XE;000FA[0230=9H]ZR2"
    A$ = A$ + "6<2FC9P0PEdQ6\8@PZ6]2Ab8XCMJ1;RZ>D5`2HK`JEEdPKdZIY10_m0PH5[i"
    A$ = A$ + "V6RIf30F0X141[J;1C14@Nh1@1ed6]9;0D0P108PHV5HKJ400[XE7F[FS=00"
    A$ = A$ + "9DdZH];RR0HKPCAE0ACE<28Pb\802[FI00o<O01`ZEP0Q1K01eZ;8f2ZP:Sf"
    A$ = A$ + "2D@A040ZXH4K000[e0P?g@1`UT\iWWRUNm19>7Yi6:0^TXiWWRUNm1BL>27]"
    A$ = A$ + "E;`0007<1@LU8\0I[[;G7[R4FHA2;^BIMM0000k<<]g63@E5A\aNe00P]6f;"
    A$ = A$ + "fK_Z:ZZ:8X4BC414PQ1DFnl5T?Ge2[H3IYE\@4De4C9MCRef4e2e0KF\01@1"
    A$ = A$ + "0A;0\I55@=<cRIYe=e1P@G8]6IJWYMZ160IQJ6APk;AEAEa16;^@7JeB2Q@0"
    A$ = A$ + "060cL1ejVFC@00057i07Q:`H<TH[VIZ000DLDLP50YC38ZH_mfZQRZQRNb1U"
    A$ = A$ + "]Z0h2FA]>0@k87HA2H<0@:6[E7J:1WQ1Q180`X022026HM;4180SYd<3Yk=d"
    A$ = A$ + "ZI=HaR530?>IBg26^E]<SZ12PR2>aPGQ0E\9C]EDD8?@g02:8bJe^64XOL>9"
    A$ = A$ + "P:ZX9ZXP=XFEeP8PED@@@@D93FGSP00004Ke:\6F5541A1\aH57HIE0:SHSF"
    A$ = A$ + "a:H72XZJ@F8;[H<H1aJDd2P800P=a0B0NN3e\FFNci2GNh<9e3i=DcJIi=W;"
    A$ = A$ + "\jQcTH?n>Z619@T4mC\kRO1[45KOP85KiFR`ISY`jbU2CT^;0000R5[H=61["
    A$ = A$ + "J\6[JSPMV2R=fZHHa>5A<]a`6[RX:89VfTUV:FcZRUFA<EC[I::6:ZH8VFgZ"
    A$ = A$ + "JJIdl[2\G0\`P`PPUfX=JRX:8TReW0:2XDRUflHoHQT=8;@[2bKYDD0RZ0:T"
    A$ = A$ + "[FeFJcj>7>PMH9D<Dk]IKfZZh]F0@\0000X2VfX=[c55`8P504H<<A8\<:`P"
    A$ = A$ + "e]a<Q8XP``K_a@0h85Q:5FJMMJ51K0C:ZDG99ISH65IAgJ35=HV80X040@f<"
    A$ = A$ + "3A@V8DY\EdDTP438026>nQ0Z0ZmifUASBSj1D\W7Rjka:]\M6]RPR30P\09E"
    A$ = A$ + "054Da>Ke:6XIK4=Ef68AA9K[UUF8:2X0300@Y:IW5c2\EGGK1[9Fe2Hc_V:K"
    A$ = A$ + "]c:fdXcf00A4E7oI1hS=D`cl]Ve=ONUX[8ngaSRi4<f@Q2cgJFehcG9J=2oM"
    A$ = A$ + "mXH>`;400\WBZb9fY;^B4KChD]LS`BVRWHWnJZ0000IDKA@0HcFSB\0<@4e@"
    A$ = A$ + "<I48D1eX_oHiSC45PQ3UbH9:ZJYJYUZJ9FG;;A=ME5ed2[K5;5dZ:2PZZZZ1"
    A$ = A$ + "XGb4@A[>dY6SPXA\1R200`0R]R>eHRXP9Z=ZFc01SONHbE9B068F3KfBD55<"
    A$ = A$ + "H4Ej:G3?\JYQ=H102000b1F:67BY00X8:6VfLY1HgeVmMG488X2YFH3R200:"
    A$ = A$ + "JED5100CB[:XZT9K4304;eXZHg69100`;M8H5[YVHJHYQRXl@A0X0001`ZFG"
    A$ = A$ + "7XA]PA0010D@;adJZYe3f300@7\RF5[>jB7A[80:06<b8743@=jDgP1KK_48"
    A$ = A$ + "cM2@fJFX:P028R8HbU]:XP2ZVKV5JYQHQ103f4K\6S0R00PLDd00?MfIC101"
    A$ = A$ + "U^400000000A\00030000d4gbQi3o3goLm_DoOeoGmOGood\NM3W0RL?DUV5"
    A$ = A$ + ";N_CChL0ZKh4@F^?f]4Rj]jMM6BTS`ceDYP<9@200<G5F8Fh`>T6V<8n5F@?"
    A$ = A$ + "8:`\L\CP=8DPfb>1\1A18cFh0jAD0V5L80T_`700000af\B3SePeT08;B005"
    A$ = A$ + "<`RQH_R98PFDARcKV0^V0RPZ@`6k]86X0RPYID[]a;0XTa=[FSgEC00@;Hh5"
    A$ = A$ + "C_3id:P0XPHA2aL1@4@A=Tha2PRJX2:VF\g0A55A54Uj<<;F=E@0@1XQ0Z98"
    A$ = A$ + "2X0`QS^j5VE7^4amA4S33O]j45MX`JeZ:JdA]eY>]R6=RFE]82H@=D3C\^=H"
    A$ = A$ + "QEA54`PT`Q@@DFYYY9SDD134KYE\1;a4T2KT5`@ZgE5W5PPXFXEa2PQ9BM8O"
    A$ = A$ + ":<`208Q1kLhlUO9818SE5H`bb2I`1>JH010FhB[g:601`0`PU210H00`PZ=V"
    A$ = A$ + "44`0`2XQED0HS=Z82P200Tn<Xi::Z@RReE0024SDZgRR2RRRJPMFOl]E5ha="
    A$ = A$ + "D1\ZVOHhkbdgjRS[V>Rca=D1\:f0QQ_;3O[;>nKj8>oA]5A:T2YR<S@:8R<;"
    A$ = A$ + "ZC=KNWh<jW@<RRF1`7Rn0fIPnY@L4@[01;P`Ghf484;l908:PFmC5A1KOH60"
    A$ = A$ + "0`0:Z5SZRE`8f^J4[eZFa8ZG4E5eRJ36ZRP5eFK\a6KEe0C0<a`6<0ADeS2:"
    A$ = A$ + "2Z8Z9HSER@1E\8VNC3KA5A\J8eUjE4AE1kD[R:RZ8PP:X8DQXE9JJ_MRDDA<"
    A$ = A$ + "E3CeF;RCcHFcBEDc4[4F:6fKYQEDEe8J]@9J@E4K28D:4QYUA`8S5MXH]614"
    A$ = A$ + "f8TL<RX;?T[:b6QA>6I724:jc`?7OKN7igbk7OOn>2Z2P8Z:HYH;4444;581"
    A$ = A$ + ">4Q4J@[5B4<23Pk0`0Fc5UAm1j4`7RKJJ5Kb`jfXJPR@0@2`0<82C00<J0R6"
    A$ = A$ + ">e[7P34MF865<H@4gd9XQ[=hH1fE0oFHonmkg_?0NH37@?OGNbNn@NGk3e[]"
    A$ = A$ + ";A2UcLH37@?OGNbNn@NWG2e[M;A2UClEK@V?YJUJP8R0LbTh5>@_dA4]b0<9"
    A$ = A$ + "Ba8J1V=52CaM\`Q44hdMThJBH2000CK=MR8VRECe>3k@0AaH4A`H@@A14e03"
    A$ = A$ + "K]c@4la\GL5405405EECaD``>DadB=;J6k<\Ha`@<]VJ53\RUF1;]R]d2K6S"
    A$ = A$ + "ZEeR:65D45@P1;KRUQZ4GgFJ03X3A[a008RR6=j@SR8Rd^;J@]NgMBfY5I_J"
    A$ = A$ + "=C]e[15E=Fa:6<664Qd100228F_F=JEDaUF[F]JEEmoB?40C\g6]EKB1ED`\"
    A$ = A$ + "JGW00`j9Q]X:6AESZR540008@DDdQ6MHH=KbjfB;\ZE\d@1070`L6ViZQ::H"
    A$ = A$ + ":FejIA[UI[IoOOc000H0\XZA[VB0\WH:f2\:ZR202RP00fZZJeI5EKSU:eFa"
    A$ = A$ + "800X8jdH0haE\hMc^:_<G7FC;NY5CSmHL3CNc\[bBceY;;N9RQbAhEmDCTY8"
    A$ = A$ + "T4bl92Y\>eE1X>32X6778X\BV`;DHSfZn40Y8Z]2^45@kNY`W1dC@RF0mF0m"
    A$ = A$ + "Qf9030005E4\9E\6aPJD4[X6D4[E=2P2fH[mVFEE4A@9KAe62VB4]@ZQZ9Vb"
    A$ = A$ + "Te4A@Q6H@=Z:ZX02ZJ8fI[]VF0@@E1;F]5SHZX2RZRP9V26fIGYVQ0APXPH3"
    A$ = A$ + "fPY=JY5f2\Ze=\`2eZ2Z65AE[eXPZZA>fB4J5@\]0G:BfF@825SU2U5PKIY@"
    A$ = A$ + "lQXI_W0F@aHdX]`IPE<BH@PQ@Q0X100@P10lR1eZVQ6<P[?=2ANUF6;`6TU5"
    A$ = A$ + "C66HJ3l@0W=ACPNXC15\AaRF4[4223I30<0PC\2JD14`0<jQ20?B:]6K;260"
    A$ = A$ + "H0000\ZB]6ZR0:PXZe5XKMbAh0;03H@004<AbRfX00]G1hc=T=FRH`ZDdcaZ"
    A$ = A$ + "X4U=LAUN^Q\aJ43BUJN>^4UX\QBZNe_7`^W^>c0\Yn2PPPRJDZlSQ44DWj83"
    A$ = A$ + "@98QOB;0V9R0@6g`4\0J000HW5e>\cFe6[Z=FEK\RQXfQ=fKE@5@D459@2dB"
    A$ = A$ + "=;5[:RUeFD[A=FUTIed0E014@PXRA?cabRYe\dd6\dBKQUFJCFJJCFJY=HJY"
    A$ = A$ + "=IJYQE=]`B[JHMC3[RX8:68SMFI<S1<H1BX5]`:]Z[<P@;82fFn=?A\:\TUL"
    A$ = A$ + "WQM6V:4ITAfbS\3`2;\H5<H`8@8QYPFN\a6KI;l2X8X8X88R:FWjDWj455=J"
    A$ = A$ + "@4@\kX:CD;A_MSoVF;C;\IC353@:4Qb0==0I7;4VZ`cN89BR028Hb:fEDECa"
    A$ = A$ + ":FaJF1E=E\4YX8@HN?H^DfU600F0=8A;T\F4;;:P```@S1X36@N0@3@V<ZZM"
    A$ = A$ + "X6R:X2:IgG1o`?20ke@30hK=dJVMU;_EYYO^jD:f^EeV9H[QFc\[LiY:=mc5"
    A$ = A$ + "WYHkFEKVXGe=0R88Ck4]A2@T2Q0d;6E[F?B90J^^0Rbd?P<99Qk<jU@L9^CH"
    A$ = A$ + "b45f9Q400@<F;F4K:I]h``BB<=43@E54[hJ5a:UJ`0fR5AEA5SBAE@0CE=LM"
    A$ = A$ + "PhMR5<R0<`]2K47dVJ0Pe\`V\D]IeZF;[Fa:FZfB6KFC\Y`2[[F513<\D\d`"
    A$ = A$ + "d2C3C3[J5[K5;=bf4dng5>J;R8XFJMKfFJ;]^Y:B8:YDiSdJDXN;da6gdPXZ"
    A$ = A$ + "3MZ3]:F\04?o5803R8;SR:R8:VHJ1fPFAPXJVl@f^91`T220ZJ\^e\Z5VRR2"
    A$ = A$ + "h08bJa0h0OBM2XZZHTEK`FHCfPETf^RO;giaK;4`6@A[6]R1:ki0@Bl4hNi5"
    A$ = A$ + "ZV0=M109:DaPUUaHQdA`89XZ2R8XVFJm<cjFg4333@E5410`REdZAE1@_G9T"
    A$ = A$ + "B=822hc=D<92g;hg:I[TF]M;@c=D<a2g=hg:A[DMJkDbgbXO[MPn]jgZofTX"
    A$ = A$ + "`6PH7LWZeW08DFCE1Yd2EBd000;l00CB0000\cd0C;F\cNK]e63k=]g`6C[f"
    A$ = A$ + "HS=fY=Ha6K]JW=8XHPMVF]e><5AD[A\J[KULFJF00RZMFB`ZMHR8AZ1AH5K`"
    A$ = A$ + "d65[IJYHXV66FZ:JDeZXaJA7F5ALS::Re:J<65E[3MRR5SR=2namg7mkgOF@"
    A$ = A$ + "\H7_Hi5kX5O7;?`\PA:d1Hj5d_of`402C?Q]6[EC9:JUJE1`e]DV;:C^j=Fa"
    A$ = A$ + "[A]LIZUf9b>RJbUEJii9GQTHU5Xa:7S\S0;IWJE4KYa202AXg0Jil1;YY2h9"
    A$ = A$ + "1`=DBIl6T1I8H546QAPUa;^;aa=L3`IWS7odFW:FWeI13lQ9Kkc^HOiP5N0U"
    A$ = A$ + "U3Q;h@h:YHBl]O?Wi5QC\WK?Ab;D[1PgUaOf>n]F2nZjhUFP^<ncfa_eB`GM"
    A$ = A$ + ">NY5a\iXQ0JEW88PB811PT0B000004<]@\I3[IEC[PE5;DEePFAAe:X:R:MG"
    A$ = A$ + "O7=EiMF3Ze:JASE[5E4W:fJD]^FUj]E`B6I;29bNIEnndoFSZ2JePfZX:R:U"
    A$ = A$ + "AM\Z4eY:A5VERU<AfA4;5BTM0aB[8KQEIF\XUIkD9V>mR56I;FGDX2dgMdTl"
    A$ = A$ + "24;000^mJgN000P_a3000P;:00>1%%00"
    RestoreFile A$, "fish.ogg"


    JumpSound = _SndOpen("jump.ogg", "SYNC")
    BlockSound = _SndOpen("block.ogg", "SYNC")
    DrowningSound = _SndOpen("drowning.ogg", "SYNC")
    IglooBlockCountSound = _SndOpen("iglooblock.ogg", "SYNC")
    ScoreCountSound = _SndOpen("scorecount.ogg", "SYNC")
    CollectFishSound = _SndOpen("fish.ogg", "SYNC")
End Sub

'------------------------------------------------------------------------------
Sub ScreenSetup
    GameScreen = _NewImage(400, 300, 32)
    GameBG = _NewImage(400, 300, 32)
    MainScreen = _NewImage(800, 600, 32)
    Screen MainScreen

    _Title "Frostbite Tribute"

    $If WIN Then
        _ScreenMove _Middle
    $End If

    GroundH = _Height(GameScreen) / 3 '1/3 of the GameScreen
    WaterH = (_Height(GameScreen) / 3) * 2 '2/3 of the GameScreen
    SkyH = GroundH / 3 '1/3 of GroundH
    CreditsBarH = _Height(GameScreen) / 15 '1/15 of the GameScreen
    AuroraH = SkyH / 2

    DrawScenery

    ThisAurora = _NewImage(_Width(GameScreen), AuroraH, 32)

    CreditsIMG = _NewImage(_Width(GameScreen), 40, 32)
    _Dest CreditsIMG
    _Font 16
    Color _RGB32(255, 255, 255), _RGBA32(0, 0, 0, 0)
    _PrintString (10, 0), "Copyleft 2016, Fellippe Heitor. ENTER to start."
    For I = 22 To 31
        Line (0, I)-(20, I), Aurora(I Mod 7 + 1)
    Next I
    _PrintString (20, 20), "Frostbite Tribute"
    CreditY = -2

    _Dest GameScreen
    _Font 8

End Sub

'------------------------------------------------------------------------------
Sub RestoreData
    Dim MaxLevels As Integer
    Dim r As Integer, g As Integer, b As Integer
    Dim i As Integer

    Restore AuroraPaletteDATA
    For i = 1 To 7
        Read r, g, b
        Aurora(i) = _RGB32(r, g, b)
    Next i

    Restore SceneryPaletteDATA
    For i = 1 To 3
        Read r, g, b
        SceneryPalette(DAY, i) = _RGB32(r, g, b)

        Read r, g, b
        SceneryPalette(NIGHT, i) = _RGB32(r, g, b)
    Next i

    Restore IceRowsDATA
    For i = 1 To 4
        Read IceRows(i)
    Next i

    Restore LevelsDATA
    Read MaxLevels
    ReDim Levels(1 To MaxLevels) As LevelInfo

    For i = 1 To MaxLevels
        Read Levels(i).Speed
        Read Levels(i).BlockType
        Read Levels(i).CreaturesAllowed
    Next i

    Restore CreaturesDATA
    Read CreatureWidth(FISH)
    Read CreatureWidth(BIRD)
    Read CreatureWidth(CRAB)
    Read CreatureWidth(CLAM)
End Sub

'------------------------------------------------------------------------------
Sub SpritesSetup
    'Generates sprites from pixel DATA:
    Dim ColorIndex As Integer
    Dim ColorsInPalette As Integer
    ReDim SpritePalette(0) As _Unsigned Long
    Dim i As Integer

    'Hero
    For i = 1 To 4
        HeroSprites(i) = _NewImage(30, 36, 32)
    Next i
    Restore HeroPalette
    Read ColorsInPalette
    ReDim SpritePalette(1 To ColorsInPalette) As _Unsigned Long
    For i = 1 To ColorsInPalette
        Read SpritePalette(i)
    Next i

    Restore Hero1: LoadSprite HeroSprites(1), 30, 36, SpritePalette()
    Restore Hero2: LoadSprite HeroSprites(2), 30, 36, SpritePalette()
    Restore Hero3: LoadSprite HeroSprites(3), 30, 36, SpritePalette()
    Restore Hero4: LoadSprite HeroSprites(4), 30, 36, SpritePalette()

    _Icon HeroSprites(1)

    'Bird
    For i = 1 To 2
        BirdSprites(i) = _NewImage(30, 15, 32)
    Next i

    Restore BirdPalette
    Read ColorsInPalette
    ReDim SpritePalette(1 To ColorsInPalette) As _Unsigned Long
    For i = 1 To ColorsInPalette
        Read SpritePalette(i)
    Next i

    Restore Bird1: LoadSprite BirdSprites(1), 30, 15, SpritePalette()
    Restore Bird2: LoadSprite BirdSprites(2), 30, 15, SpritePalette()


    'Fish
    For i = 1 To 2
        FishSprites(i) = _NewImage(30, 15, 32)
    Next i

    Restore FishPalette
    Read ColorsInPalette
    ReDim SpritePalette(1 To ColorsInPalette) As _Unsigned Long
    For i = 1 To ColorsInPalette
        Read SpritePalette(i)
    Next i

    Restore Fish1: LoadSprite FishSprites(1), 30, 15, SpritePalette()
    Restore Fish2: LoadSprite FishSprites(2), 30, 15, SpritePalette()
End Sub

'------------------------------------------------------------------------------
Sub LoadSprite (ImageHandle As Long, ImageWidth As Integer, ImageHeight As Integer, SpritePalette() As Long)
    'Loads a sprite from DATA fields. You must use RESTORE appropriately before calling this SUB.
    Dim i As Integer
    Dim DataLine As String
    Dim Pixel As Integer
    Dim PrevDest As Long

    PrevDest = _Dest
    _Dest ImageHandle

    For i = 0 To ImageHeight - 1
        Read DataLine
        For Pixel = 0 To ImageWidth - 1
            PSet (Pixel, i), SpritePalette(Val(Mid$(DataLine, Pixel + 1, 1)))
        Next Pixel
    Next i

    _Dest PrevDest
End Sub

'------------------------------------------------------------------------------
Sub SetTimers
    TempTimer = _FreeTimer
    On Timer(TempTimer, 1) DecreaseTemperature

    FramesTimer = _FreeTimer
    On Timer(FramesTimer, .1) UpdateFrames
    Timer(FramesTimer) On
End Sub

'------------------------------------------------------------------------------
Sub CalculateScores
    '- Displays the end of game animation ("unbuilds" the igloo
    'and sums total points) AND
    '- Checks for 1-up goals (every 5,000 points).

    If LevelComplete Then
        'Calculate points for each igloo block
        If IglooPieces > 0 Then
            If IglooBlockCountSound Then _SndPlayCopy IglooBlockCountSound
            Score = Score + (PointsInThisLevel * 10)
            IglooPieces = IglooPieces - 1
        End If

        'Calculate points for each degree remaining
        If IglooPieces = 0 And Temperature > 0 Then
            If ScoreCountSound Then _SndPlayCopy ScoreCountSound
            Score = Score + (10 * PointsInThisLevel)
            Temperature = Temperature - 1
        End If

        If IglooPieces = 0 And Temperature = 0 Then SetLevel NEXTLEVEL
    End If

    If Score > NextGoal Then
        NextGoal = NextGoal + ONEUPGOAL
        If Lives < 9 Then Lives = Lives + 1
    End If
End Sub

Sub InvertCurrentIceRow
    If IceRow(Hero.CurrentRow).Direction = MOVINGRIGHT Then
        IceRow(Hero.CurrentRow).Direction = MOVINGLEFT
        If IceRow(Hero.CurrentRow).MirroredPosition Then Swap IceRow(Hero.CurrentRow).Position, IceRow(Hero.CurrentRow).MirroredPosition
    Else
        IceRow(Hero.CurrentRow).Direction = MOVINGRIGHT
        If IceRow(Hero.CurrentRow).MirroredPosition Then Swap IceRow(Hero.CurrentRow).Position, IceRow(Hero.CurrentRow).MirroredPosition
    End If
End Sub

Sub DrawScenery
    Dim PrevDest As Long

    PrevDest = _Dest
    _Dest GameBG
    Line (0, 0)-Step(_Width, GroundH), SceneryPalette(TimeOfDay, GROUND), BF '        Ground/ice
    Line (0, 0)-Step(_Width, SkyH), SceneryPalette(TimeOfDay, SKY), BF '              Sky
    Line (0, GroundH - 2)-Step(_Width, 3), _RGB32(0, 0, 0), BF '                      Black separator
    Line (0, GroundH + 2)-Step(_Width, WaterH), _RGB32(0, 27, 141), BF '              Water
    Line (0, _Height - CreditsBarH)-Step(_Width, CreditsBarH), _RGB32(0, 0, 0), BF '  Credits bar

    _Dest PrevDest
End Sub

Sub RestoreFile (A$, FileName$)
    For i& = 1 To Len(A$) Step 4: B$ = Mid$(A$, i&, 4)
        If InStr(1, B$, "%") Then
            For C% = 1 To Len(B$): F$ = Mid$(B$, C%, 1)
                If F$ <> "%" Then C$ = C$ + F$
            Next: B$ = C$
            End If: For t% = Len(B$) To 1 Step -1
            B& = B& * 64 + Asc(Mid$(B$, t%)) - 48
            Next: X$ = "": For t% = 1 To Len(B$) - 1
            X$ = X$ + Chr$(B& And 255): B& = B& \ 256
    Next: btemp$ = btemp$ + X$: Next
    BASFILE$ = btemp$

    f% = FreeFile
    Open FileName$ For Output As #f%
    Print #f%, BASFILE$;
    Close #f%
End Sub

Function IIF (Condition, IfTrue, IfFalse)
    If Condition Then IIF = IfTrue Else IIF = IfFalse
End Function

