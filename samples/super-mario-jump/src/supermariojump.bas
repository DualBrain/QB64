$Resize:Smooth

'$INCLUDE:'spritetop.bi'

'*****
'*
'* Super Mario Jump!   - Work in progress -   by Terry Ritchie
'*
'*****

Const FALSE = 0, TRUE = Not FALSE

Type ENEMYINFO
    sprite As Integer '      the assigned sprite number
    kind As Integer '        the type of sprite character (1 - 13)
    action As Integer '      the current sprite action (1=scrolling, 2=falling, 3=dead)
End Type

Type DIFFICULTYINFO
    world As Integer '       current game world
    level As Integer '       current game level
    fps As Integer '         frames per second
    rowspeed As Integer '    maximum row speed
    trampoffset As Integer ' trampoline x offset
    tremaining As Integer '  time remaining
    springs As Integer '     number of springs
End Type

Dim Difficulty As DIFFICULTYINFO
Dim EnemySprite%(13) '       the various scrolling sprites to choose from
Dim Enemy(24) As ENEMYINFO ' the 24 scrolling sprites
Dim Castle& '                the game background
Dim SpriteSheet% '           the spritesheet containing game sprites
Dim Mario% '                 the mario sprite
Dim Row% '                   used to hold row calculations
Dim Column% '                used to hold column calculations
Dim RowSpeed%(3) '           the random speed of each row
Dim RandomEnemy% '           used to select a random sprite
Dim Flag% '                  the flag sprite
Dim LeftTurtleTop% '         the top of left turtle sprite
Dim LeftTurtleBot% '         the bottom of left turtle sprite
Dim RightTurtleTop% '        the top of right turtle sprite
Dim RightTurtleBot% '        the bottom of right turtle sprite
Dim Trampx% '                x location of trampoline
Dim Spring%(3)
Dim Mariox%
Dim Marioy%
Dim MarioXVel!
Dim MarioYVel!
Dim Count%
Dim MarioIsDead%
Dim Players%
Dim LevelComplete%
Dim EnemyCount%
Dim MarioLanded%
Dim Score%
Dim GameFont&
Dim UserExits%

Dim snd1Up&
Dim sndBreakBlock&
Dim sndBump&
Dim sndCoin&
Dim sndDie&
Dim sndFireworks&
Dim sndGameOver&
Dim sndKick&
Dim sndLevelComplete&
Dim sndMainTheme&
Dim sndPowerUp&
Dim sndPowerUpAppears&
Dim sndJump&
Dim sndStageClear&
Dim sndStarMan&
Dim sndStomp&
Dim sndVine&
Dim sndWarning&
Dim sndWorldClear&
Dim sndDead&


Screen _NewImage(320, 240, 32)
_Title "Super Mario Jump!"
_ScreenMove _Middle
_FullScreen _SquarePixels , _Smooth
_MouseHide
_Delay 2

LOADSPRITES
LOADSOUNDS
Do '                                                         come back here until user exits game
    'TITLESCREEN
    Players% = 3
    Difficulty.world = 1
    Difficulty.level = 0
    Score% = 0
    Do '                                                     come back here until game is over
        DRAWSCREEN
        Do '                                                 come back here until level completed or no players left
            STARTLEVEL
            Do '                                             come back here until level completed mario is dead
                _Limit Difficulty.fps
                MOVECHARACTERS
                UPDATESCORE
                MOVEMARIO
                CHECKFORCOLLISIONS
                UPDATETRAMPOLINE
                _Display
            Loop Until MarioIsDead% Or LevelComplete%
            If MarioIsDead% Then KILLMARIO
        Loop Until LevelComplete% Or Players% = 0
        If LevelComplete% Then
            _SndStop sndMainTheme&
            _SndPlay sndLevelComplete&
            Do
                _Limit Difficulty.fps
                MOVECHARACTERS
                UPDATESCORE
                UPDATETRAMPOLINE
                MOVEMARIO
                _Display
            Loop Until _SndPlaying(sndLevelComplete&) = 0
        End If
        MarioLanded% = FALSE
        For Count% = 1 To 24
            SPRITEFREE Enemy(Count%).sprite
        Next Count%
    Loop Until Players% = 0
    _SndPlay sndGameOver&
    UserExits% = TRUE
Loop Until UserExits%


'---------------------------------------------------------------------------------------------------
Sub UPDATESCORE ()
    '******************************************************************************
    ' Display the score on screen                                                 *
    '******************************************************************************

    Shared Difficulty As DIFFICULTYINFO
    Shared Score%

    _PrintString (80, 1), LTrim$(Str$(Difficulty.world)) + "-" + LTrim$(Str$(Difficulty.level))
    _PrintString (136, 1), Right$("000" + LTrim$(Str$(Score%)), 4)
    _PrintString (200, 1), Right$("00" + LTrim$(Str$(Difficulty.tremaining)), 3)

End Sub

'--------------------------------------------------------------------------------------------------

Sub CHECKFORCOLLISIONS ()
    '******************************************************************************
    '* Check for Mario colliding into enemies                                     *
    '******************************************************************************

    Shared Enemy() As ENEMYINFO
    Shared Mario%
    Shared MarioXVel!
    Shared MarioYVel!
    Shared sndStomp&
    Shared sndKick&
    Shared sndPowerUp&
    Shared snd1Up&
    Shared sndPowerUpAppears&
    Shared sndBreakBlock&
    Shared sndFireworks&
    Shared EnemyCount%
    Shared LevelComplete%
    Shared Difficulty As DIFFICULTYINFO
    Shared Score%

    Dim Count%
    Dim Xoffset!
    Dim Yoffset!

    For Count% = 1 To 24
        If Enemy(Count%).action = 1 Then
            If SPRITECOLLIDE(Mario%, Enemy(Count%).sprite) Then
                EnemyCount% = EnemyCount% + 1
                If EnemyCount% = 24 Then LevelComplete% = TRUE
                Enemy(Count%).action = 2
                SPRITEANIMATION Enemy(Count%).sprite, NOANIMATE, FORWARDLOOP
                SPRITEMOTION Enemy(Count%).sprite, DONTMOVE
                Score% = Score% + SPRITESCORE(Enemy(Count%).sprite)
                Yoffset! = SPRITEAY(Enemy(Count%).sprite) - SPRITEAY(Mario%) '      change difficulty here *** need to do ***
                Xoffset! = SPRITEAX(Enemy(Count%).sprite) - SPRITEAX(Mario%)
                If Yoffset! > 0 Then MarioYVel! = -MarioYVel!
                MarioXVel! = MarioXVel! - (Xoffset! / 4)
                Select Case Enemy(Count%).kind
                    Case 1
                        SPRITESET Enemy(Count%).sprite, 12
                        _SndPlayCopy sndStomp&
                    Case 2
                        SPRITESET Enemy(Count%).sprite, 15
                        _SndPlayCopy sndStomp&
                    Case 3
                        SPRITESET Enemy(Count%).sprite, 18
                        _SndPlayCopy sndStomp&
                    Case 4
                        SPRITEFLIP Enemy(Count%).sprite, VERTICAL
                        _SndPlayCopy sndKick&
                    Case 5
                        SPRITEFLIP Enemy(Count%).sprite, VERTICAL
                        _SndPlayCopy sndKick&
                    Case 6
                        SPRITEFLIP Enemy(Count%).sprite, VERTICAL
                        _SndPlayCopy sndKick&
                    Case 7
                        SPRITEFLIP Enemy(Count%).sprite, VERTICAL
                        _SndPlayCopy sndKick&
                    Case 8
                        'SPRITESPINSET Enemy(Count%).sprite, 45
                        _SndPlayCopy sndPowerUp&
                    Case 9
                        'SPRITESPINSET Enemy(Count%).sprite, 45
                        _SndPlayCopy snd1Up&
                    Case 10
                        'SPRITESPINSET Enemy(Count%).sprite, 45
                        _SndPlayCopy sndPowerUpAppears&
                    Case 11
                        'SPRITESPINSET Enemy(Count%).sprite, 45
                        _SndPlayCopy sndPowerUp&
                    Case 12
                        'SPRITESPINSET Enemy(Count%).sprite, 45
                        _SndPlayCopy sndBreakBlock&
                    Case 13
                        'SPRITESPINSET Enemy(Count%).sprite, 10
                        _SndPlayCopy sndFireworks&
                End Select
                Exit For
            End If
        End If
    Next Count%

End Sub

'--------------------------------------------------------------------------------------------------

Sub KILLMARIO ()
    '******************************************************************************
    '* Sadly Mario has died                                                       *
    '******************************************************************************

    Shared Difficulty As DIFFICULTYINFO
    Shared Castle&
    Shared sndMainTheme&
    Shared sndDead&
    Shared Mario%
    Shared Players%

    Dim Count%
    Dim Rotation%

    _SndStop sndMainTheme&
    _SndPlay sndDead&
    SPRITESET Mario%, 7
    SPRITEPUT SPRITEX(Mario%), 232, Mario%
    For Count% = 1 To 3
        For Rotation% = 0 To 359 Step 45
            _Limit Difficulty.fps
            _PutImage , Castle&
            MOVECHARACTERS
            UPDATESCORE
            UPDATETRAMPOLINE
            SPRITEROTATE Mario%, Rotation%
            SPRITEPUT SPRITEX(Mario%), SPRITEY(Mario%), Mario%
            _Display
        Next Rotation%
    Next Count%
    SPRITEROTATE Mario%, 180
    Do
        _Limit Difficulty.fps
        _PutImage , Castle&
        MOVECHARACTERS
        UPDATESCORE
        UPDATETRAMPOLINE
        SPRITEPUT SPRITEX(Mario%), SPRITEY(Mario%), Mario%
        _Display
    Loop Until _SndPlaying(sndDead&) = 0
    SPRITEROTATE Mario%, 0
    Players% = Players% - 1

End Sub

'--------------------------------------------------------------------------------------------------

Sub MOVEMARIO () Static
    '******************************************************************************
    '* Move mario on the screen                                                   *
    '******************************************************************************

    Shared Mario%
    Shared MarioIsDead%
    Shared Spring%()
    Shared MarioXVel!
    Shared MarioYVel!
    Shared sndBump&
    Shared sndMainTheme&
    Shared sndJump&
    Shared LevelComplete%
    Shared MarioLanded%
    Shared Difficulty As DIFFICULTYINFO

    Dim FrameCount%
    Dim ScoreCount%

    If MarioLanded% Then
        SPRITEPUT SPRITEX(Mario%), 232, Mario%
        Exit Sub
    Else
        ScoreCount% = ScoreCount% + 1
        If ScoreCount% >= Difficulty.fps Then
            ScoreCount% = 0
            Difficulty.tremaining = Difficulty.tremaining - 1
        End If
    End If
    If SPRITEX(Mario%) < 8 Or SPRITEX(Mario%) > 311 Then
        _SndPlayCopy sndBump&
        MarioXVel! = -MarioXVel!
    End If
    MarioYVel! = MarioYVel! - .5
    Select Case Abs(MarioYVel!)
        Case Is < 3
            If LevelComplete% Then
                SPRITESET Mario%, 1
            Else
                SPRITESET Mario%, 7
            End If
        Case 3 To 5.9999999
            SPRITESET Mario%, 6
        Case 6 To 8.9999999
            SPRITESET Mario%, 5
        Case 9 To 12
            SPRITESET Mario%, 4
        Case Is > 12
            SPRITESET Mario%, 3
    End Select
    If Sgn(MarioXVel!) = 1 Then
        SPRITEFLIP Mario%, NONE
    Else
        SPRITEFLIP Mario%, HORIZONTAL
    End If
    If MarioYVel! > 15 Then MarioYVel! = 15
    SPRITEPUT SPRITEAX(Mario%) + MarioXVel!, SPRITEAY(Mario%) - MarioYVel!, Mario%
    FrameCount% = FrameCount% + 1
    If FrameCount% = 2 Then
        SPRITESET Spring%(1), 50
        SPRITESET Spring%(2), 50
        SPRITESET Spring%(3), 50
    End If
    If Not LevelComplete% Then
        If FrameCount% > 4 Then
            FrameCount% = 4
            For Count% = 1 To 3
                If SPRITECOLLIDE(Mario%, Spring%(Count%)) Then
                    _SndPlayCopy sndJump&
                    MarioYVel! = Abs(MarioYVel! * 1.1)
                    Offset! = -(SPRITEAX(Spring%(2)) - SPRITEAX(Mario%))
                    MarioXVel! = MarioXVel! + (Offset! / Difficulty.trampoffset) '                      change difficult here
                    FrameCount% = 1
                    SPRITESET Spring%(1), 51
                    SPRITESET Spring%(2), 51
                    SPRITESET Spring%(3), 51
                    Exit Sub
                End If
            Next Count%
        End If
    End If
    If SPRITEY(Mario%) > 232 Then
        If LevelComplete% Then
            MarioLanded% = TRUE
            MarioXVel! = 0
            MarioYVel! = 0
            SPRITESET Mario%, 1
            SPRITEPUT SPRITEX(Mario%), 232, Mario%
        Else
            MarioIsDead% = TRUE
        End If
    End If

End Sub

'--------------------------------------------------------------------------------------------------

Sub LOADSOUNDS ()
    '******************************************************************************
    '* Load the game sounds                                                       *
    '******************************************************************************

    Shared snd1Up&
    Shared sndBreakBlock&
    Shared sndBump&
    Shared sndCoin&
    Shared sndDie&
    Shared sndFireworks&
    Shared sndGameOver&
    Shared sndKick&
    Shared sndLevelComplete&
    Shared sndMainTheme&
    Shared sndPowerUp&
    Shared sndPowerUpAppears&
    Shared sndJump&
    Shared sndStageClear&
    Shared sndStarMan&
    Shared sndStomp&
    Shared sndVine&
    Shared sndWarning&
    Shared sndWorldClear&
    Shared sndDead&

    snd1Up& = _SndOpen("mario1up.ogg", "VOL,SYNC")
    sndBreakBlock& = _SndOpen("mariobreakblock.ogg", "VOL,SYNC")
    sndBump& = _SndOpen("mariobump.ogg", "VOL,SYNC")
    sndCoin& = _SndOpen("mariocoin.ogg", "VOL,SYNC")
    sndDie& = _SndOpen("mariodie.ogg", "VOL,SYNC")
    sndFireworks& = _SndOpen("mariofireworks.ogg", "VOL,SYNC")
    sndGameOver& = _SndOpen("mariogameover.ogg", "VOL,SYNC")
    sndKick& = _SndOpen("mariokick.ogg", "VOL,SYNC")
    sndLevelComplete& = _SndOpen("mariolevelcomplete.ogg", "VOL,SYNC")
    sndMainTheme& = _SndOpen("mariomaintheme.ogg", "VOL,SYNC")
    sndPowerUp& = _SndOpen("mariopowerup.ogg", "VOL,SYNC")
    sndPowerUpAppears& = _SndOpen("mariopowerupappears.ogg", "VOL,SYNC")
    sndJump& = _SndOpen("mariosmalljump.ogg", "VOL,SYNC")
    sndStageClear& = _SndOpen("mariostageclear.ogg", "VOL,SYNC")
    sndStarMan& = _SndOpen("mariostarman.ogg", "VOL,SYNC")
    sndStomp& = _SndOpen("mariostomp.ogg", "VOL,SYNC")
    sndVine& = _SndOpen("mariovine.ogg", "VOL,SYNC")
    sndWarning& = _SndOpen("mariowarning.ogg", "VOL,SYNC")
    sndWorldClear& = _SndOpen("marioworldclear.ogg", "VOL,SYNC")
    sndDead& = _SndOpen("marioyouredead.ogg", "VOL,SYNC")

End Sub

'--------------------------------------------------------------------------------------------------

Sub STARTLEVEL ()
    '******************************************************************************
    '* Mario climbing sequence                                                    *
    '******************************************************************************

    Shared Difficulty As DIFFICULTYINFO
    Shared MarioXVel!
    Shared MarioYVel!
    Shared Mario%
    Shared Castle&
    Shared sndWorldClear&
    Shared sndMainTheme&
    Shared sndVine&
    Shared sndBump&
    Shared MarioIsDead%

    Dim Mariox%
    Dim Marioy%
    Dim Door%

    _SndPlayCopy sndWorldClear&
    MarioIsDead% = FALSE
    Door% = Int(Rnd(1) * 2) + 1
    Marioy% = 232
    If Door% = 1 Then
        SPRITEFLIP Mario%, HORIZONTAL
        Mariox% = 41
        MarioXVel! = 2
        SPRITESPEEDSET Mario%, 1
        SPRITEDIRECTIONSET Mario%, 270
    Else
        SPRITEFLIP Mario%, NONE
        Mariox% = 279
        MarioXVel! = -2
        SPRITESPEEDSET Mario%, 1
        SPRITEDIRECTIONSET Mario%, 90
    End If
    MarioYVel! = 3
    SPRITEPUT Mariox%, Marioy%, Mario%
    SPRITEMOTION Mario%, MOVE
    SPRITEANIMATESET Mario%, 2, 4
    SPRITEANIMATION Mario%, ANIMATE, FORWARDLOOP
    For Count% = 1 To 28
        _Limit Difficulty.fps
        _PutImage , Castle&
        MOVECHARACTERS
        UPDATETRAMPOLINE
        UPDATESCORE
        SPRITEPUT MOVE, MOVE, Mario%
        _Display
    Next Count%
    SPRITESET Mario%, 8
    SPRITEANIMATESET Mario%, 8, 9
    SPRITEDIRECTIONSET Mario%, 0
    SPRITESPEEDSET Mario%, 2
    _SndPlayCopy sndVine&
    For Count% = 1 To 96
        _Limit Difficulty.fps
        _PutImage , Castle&
        MOVECHARACTERS
        UPDATETRAMPOLINE
        UPDATESCORE
        SPRITEPUT MOVE, MOVE, Mario%
        _Display
    Next Count%
    SPRITEANIMATION Mario%, NOANIMATE, FORWARDLOOP
    SPRITEMOTION Mario%, DONTMOVE
    SPRITESET Mario%, 6
    If Door% = 1 Then SPRITEFLIP Mario%, NONE
    _SndPlayCopy sndBump&
    _SndLoop sndMainTheme&

End Sub

'--------------------------------------------------------------------------------------------------

Sub MOVECHARACTERS ()
    '******************************************************************************
    '* Move thge enemy characters around the screen                               *
    '******************************************************************************

    Shared Enemy() As ENEMYINFO ' the 24 scrolling sprites
    Shared RowSpeed%()
    Shared Castle&

    Dim Row% '                   used to hold row calculations
    Dim Count%
    Dim Dir%
    Dim Rot!

    _PutImage , Castle&
    For Count% = 1 To 24
        If Enemy(Count%).action = 1 Then
            If SPRITEX(Enemy(Count%).sprite) < 24 Then
                SPRITEMOTION Enemy(Count%).sprite, DONTMOVE
                SPRITEPUT 294, SPRITEY(Enemy(Count%).sprite), Enemy(Count%).sprite
                SPRITEMOTION Enemy(Count%).sprite, MOVE
            ElseIf SPRITEX(Enemy(Count%).sprite) > 294 Then
                SPRITEMOTION Enemy(Count%).sprite, DONTMOVE
                SPRITEPUT 24, SPRITEY(Enemy(Count%).sprite), Enemy(Count%).sprite
                SPRITEMOTION Enemy(Count%).sprite, MOVE
            Else
                SPRITEPUT MOVE, MOVE, Enemy(Count%).sprite
            End If
        ElseIf Enemy(Count%).action = 2 Then '                     falling
            If SPRITEY(Enemy(Count%).sprite) > 250 Then
                Enemy(Count%).action = 3
            Else
                Row% = Int((Count% - 1) / 8) + 1
                If Row% = 1 Or Row% = 3 Then Dir% = -1 Else Dir% = 1
                If Enemy(Count%).kind > 7 Then
                    Rot! = SPRITEROTATION(Enemy(Count%).sprite)
                    Rot! = Rot! + (Dir% * 45)
                    If Rot! > 359 Then Rot! = Rot! - 360
                    If Rot! < 0 Then Rot! = Rot! + 360
                    SPRITEROTATE Enemy(Count%).sprite, Rot!
                End If
                SPRITEPUT SPRITEX(Enemy(Count%).sprite) + (RowSpeed%(Row%) * Dir%), SPRITEAY(Enemy(Count%).sprite) * 1.1, Enemy(Count%).sprite
            End If
        End If
    Next Count%

End Sub

'--------------------------------------------------------------------------------------------------

Sub DRAWSCREEN ()
    '******************************************************************************
    '* Draw the play screen                                                       *
    '******************************************************************************

    Shared EnemySprite%() '       the various scrolling sprites to choose from
    Shared Enemy() As ENEMYINFO ' the 24 scrolling sprites
    Shared RowSpeed%() '          the random speed of each row
    Shared Castle& '              the game background
    Shared Trampx% '              x location of trampoline
    Shared UserExits%
    Shared LevelComplete%
    Shared EnemyCount%
    Shared Difficulty As DIFFICULTYINFO

    Dim Count% '                  generic counter
    Dim Row% '                    used to hold row calculations
    Dim Column% '                 used to hold column calculations

    Randomize Timer

    Difficulty.level = Difficulty.level + 1
    If Difficulty.level = 4 Then
        Difficulty.level = 1
        Difficulty.world = Difficulty.world + 1
    End If
    Difficulty.fps = 14 + (Difficulty.world * Difficulty.level)
    If Difficulty.fps > 30 Then Difficulty.fps = 30
    Difficulty.rowspeed = (Difficulty.world * Difficulty.level) - 1
    If Difficulty.rowspeed > 10 Then Difficulty.rowspeed = 10
    Difficulty.trampoffset = 13 - (Difficulty.world * Difficulty.level)
    If Difficulty.trampoffset < 3 Then Difficulty.trampoffset = 3
    Difficulty.tremaining = 120

    UserExits% = FALSE
    LevelComplete% = FALSE
    EnemyCount% = 0
    _PutImage , Castle&
    For Count% = 1 To 24
        If Count% < 4 Then RowSpeed%(Count%) = Int(Rnd(1) * Difficulty.rowspeed) + 1 '                      change difficulty here
        Enemy(Count%).kind = Int(Rnd(1) * 13) + 1
        Enemy(Count%).sprite = SPRITECOPY(EnemySprite%(Enemy(Count%).kind))
        Enemy(Count%).action = 1
        If Enemy(Count%).kind = 12 Then
            SPRITESCORESET Enemy(Count%).sprite, Int(Rnd(1) * 10) + 1
        Else
            SPRITESCORESET Enemy(Count%).sprite, 1
        End If
        Row% = Int((Count% - 1) / 8) + 1
        Column% = Count% - ((Row% - 1) * 8)
        SPRITESPEEDSET Enemy(Count%).sprite, RowSpeed%(Row%)
        If Row% = 2 Then
            If Enemy(Count%).kind <> 12 Then SPRITEFLIP Enemy(Count%).sprite, HORIZONTAL
            SPRITEDIRECTIONSET Enemy(Count%).sprite, 90
        Else
            SPRITEFLIP Enemy(Count%).sprite, NONE
            SPRITEDIRECTIONSET Enemy(Count%).sprite, 270
        End If
        SPRITEPUT (32 * Column%) + 16, (32 * Row%) - 8, Enemy(Count%).sprite
        SPRITEMOTION Enemy(Count%).sprite, MOVE
    Next Count%
    Trampx% = 128
    UPDATETRAMPOLINE

End Sub

'--------------------------------------------------------------------------------------------------

Sub UPDATETRAMPOLINE () Static
    '******************************************************************************
    '* Draw the trampoline                                                        *
    '******************************************************************************

    Shared LeftTurtleTop% '  the top of left turtle sprite
    Shared LeftTurtleBot% '  the bottom of left turtle sprite
    Shared RightTurtleTop% ' the top of right turtle sprite
    Shared RightTurtleBot% ' the bottom of right turtle sprite
    Shared Spring%() '       the trampoline springs
    Shared Trampx%

    Dim OldTrampx%

    While _MouseInput: Wend
    Trampx% = Int(_MouseX * .85) - 8
    If OldTrampx% = Trampx% Then
        SPRITEANIMATION LeftTurtleTop%, NOANIMATE, FORWARDLOOP
        SPRITEANIMATION LeftTurtleBot%, NOANIMATE, FORWARDLOOP
        SPRITEANIMATION RightTurtleTop%, NOANIMATE, FORWARDLOOP
        SPRITEANIMATION RightTurtleBot%, NOANIMATE, FORWARDLOOP
    Else
        SPRITEANIMATION LeftTurtleTop%, ANIMATE, FORWARDLOOP
        SPRITEANIMATION LeftTurtleBot%, ANIMATE, FORWARDLOOP
        SPRITEANIMATION RightTurtleTop%, ANIMATE, FORWARDLOOP
        SPRITEANIMATION RightTurtleBot%, ANIMATE, FORWARDLOOP
        OldTrampx% = Trampx%
    End If
    SPRITEPUT Trampx%, 216, LeftTurtleTop%
    SPRITEPUT Trampx%, 232, LeftTurtleBot%
    SPRITEPUT Trampx% + 16, 232, Spring%(1)
    SPRITEPUT Trampx% + 32, 232, Spring%(2)
    SPRITEPUT Trampx% + 48, 232, Spring%(3)
    SPRITEPUT Trampx% + 64, 216, RightTurtleTop%
    SPRITEPUT Trampx% + 64, 232, RightTurtleBot%

End Sub

'--------------------------------------------------------------------------------------------------

Sub LOADSPRITES ()
    '******************************************************************************
    '* Load sprites and set up animation characteristics of each                  *
    '******************************************************************************

    Shared EnemySprite%()
    Shared Castle&
    Shared SpriteSheet%
    Shared Mario%
    Shared Flag%
    Shared LeftTurtleTop%
    Shared LeftTurtleBot%
    Shared RightTurtleTop%
    Shared RightTurtleBot%
    Shared Spring%()
    Shared GameFont&

    Dim Count%

    GameFont& = _LoadFont("pressstart2p.ttf", 12, "MONOSPACE")
    _PrintMode _KeepBackground
    _Font GameFont&
    Castle& = _LoadImage("castle.png", 32)
    SpriteSheet% = SPRITESHEETLOAD("sprites.png", 16, 16, _RGB32(0, 255, 0))
    Mario% = SPRITENEW(SpriteSheet%, 1, DONTSAVE) '            mario
    SPRITECOLLIDETYPE Mario%, PIXELDETECT
    Flag% = SPRITENEW(SpriteSheet%, 45, DONTSAVE) '            flag
    Spring%(1) = SPRITENEW(SpriteSheet%, 50, DONTSAVE) '       left spring
    SPRITECOLLIDETYPE Spring%(1), BOXDETECT
    Spring%(2) = SPRITECOPY(Spring%(1)) '                      middle spring
    SPRITECOLLIDETYPE Spring%(2), BOXDETECT
    Spring%(3) = SPRITECOPY(Spring%(1)) '                      right spring
    SPRITECOLLIDETYPE Spring%(3), BOXDETECT
    LeftTurtleTop% = SPRITENEW(SpriteSheet%, 37, DONTSAVE) '   top of left turtle
    SPRITEANIMATESET LeftTurtleTop%, 37, 38
    SPRITEANIMATION LeftTurtleTop%, ANIMATE, FORWARDLOOP
    LeftTurtleBot% = SPRITENEW(SpriteSheet%, 46, DONTSAVE) '   bottom of left turtle
    SPRITEANIMATESET LeftTurtleBot%, 46, 47
    SPRITEANIMATION LeftTurtleBot%, ANIMATE, FORWARDLOOP
    RightTurtleTop% = SPRITENEW(SpriteSheet%, 39, DONTSAVE) '  top of right turtle
    SPRITEANIMATESET RightTurtleTop%, 39, 40
    SPRITEANIMATION RightTurtleTop%, ANIMATE, FORWARDLOOP
    RightTurtleBot% = SPRITENEW(SpriteSheet%, 48, DONTSAVE) '  bottom of right turtle
    SPRITEANIMATESET RightTurtleBot%, 48, 49
    SPRITEANIMATION RightTurtleBot%, ANIMATE, FORWARDLOOP
    EnemySprite%(1) = SPRITENEW(SpriteSheet%, 10, DONTSAVE) '  brown mushroom
    SPRITEANIMATESET EnemySprite%(1), 10, 11
    SPRITEANIMATION EnemySprite%(1), ANIMATE, FORWARDLOOP
    EnemySprite%(2) = SPRITENEW(SpriteSheet%, 13, DONTSAVE) '  blue mushroom
    SPRITEANIMATESET EnemySprite%(2), 13, 14
    SPRITEANIMATION EnemySprite%(2), ANIMATE, FORWARDLOOP
    EnemySprite%(3) = SPRITENEW(SpriteSheet%, 16, DONTSAVE) '  gray mushroom
    SPRITEANIMATESET EnemySprite%(3), 16, 17
    SPRITEANIMATION EnemySprite%(3), ANIMATE, FORWARDLOOP
    EnemySprite%(4) = SPRITENEW(SpriteSheet%, 19, DONTSAVE) '  black helmet
    SPRITEANIMATESET EnemySprite%(4), 19, 20
    SPRITEANIMATION EnemySprite%(4), ANIMATE, FORWARDLOOP
    EnemySprite%(5) = SPRITENEW(SpriteSheet%, 21, DONTSAVE) '  blue helmet
    SPRITEANIMATESET EnemySprite%(5), 21, 22
    SPRITEANIMATION EnemySprite%(5), ANIMATE, FORWARDLOOP
    EnemySprite%(6) = SPRITENEW(SpriteSheet%, 23, DONTSAVE) '  gray helmet
    SPRITEANIMATESET EnemySprite%(6), 23, 24
    SPRITEANIMATION EnemySprite%(6), ANIMATE, FORWARDLOOP
    EnemySprite%(7) = SPRITENEW(SpriteSheet%, 25, DONTSAVE) '  spikey
    SPRITEANIMATESET EnemySprite%(7), 25, 26
    SPRITEANIMATION EnemySprite%(7), ANIMATE, FORWARDLOOP
    EnemySprite%(8) = SPRITENEW(SpriteSheet%, 27, DONTSAVE) '  red mushroom
    EnemySprite%(9) = SPRITENEW(SpriteSheet%, 28, DONTSAVE) '  star
    SPRITEANIMATESET EnemySprite%(9), 28, 31
    SPRITEANIMATION EnemySprite%(9), ANIMATE, BACKFORTHLOOP
    EnemySprite%(10) = SPRITENEW(SpriteSheet%, 32, DONTSAVE) ' flower
    SPRITEANIMATESET EnemySprite%(10), 32, 35
    SPRITEANIMATION EnemySprite%(10), ANIMATE, BACKFORTHLOOP
    EnemySprite%(11) = SPRITENEW(SpriteSheet%, 36, DONTSAVE) ' green mushroom
    EnemySprite%(12) = SPRITENEW(SpriteSheet%, 41, DONTSAVE) ' question box
    SPRITEANIMATESET EnemySprite%(12), 41, 43
    SPRITEANIMATION EnemySprite%(12), ANIMATE, BACKFORTHLOOP
    EnemySprite%(13) = SPRITENEW(SpriteSheet%, 44, DONTSAVE) ' bullet bill
    For Count% = 1 To 13
        SPRITECOLLIDETYPE EnemySprite%(Count%), PIXELDETECT
    Next Count%

End Sub

'--------------------------------------------------------------------------------------------------

'$INCLUDE:'sprite.bi'

