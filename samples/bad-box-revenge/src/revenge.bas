'**
'** Revenge of the Bad Boxes! V1.0
'**
'** by Terry Ritchie 02/11/13
'**
'******************************************************************************
'*                          INITIALIZATION SECTION                            *
'******************************************************************************

Const FALSE = 0
Const TRUE = Not FALSE '   boolean truth detectors
Const SWIDTH = 1280 '      width of screen
Const SHEIGHT = 720 '      height of screen

Type BULLET '              the player's bullet
    x As Single '          X location of bullet
    y As Single '          Y location of bullet
    xv As Single '         X velocity of bullet
    yv As Single '         Y velocity of bullet
    live As Integer '      TRUE if bullet active, FALSE otherwise
End Type

Type ENEMY '               the enemies
    x As Single '          X location of enemy or corner of square
    y As Single '          Y location of enemy or corner of square
    xv As Single '         X velocity of enemy
    yv As Single '         Y velocity of enemy
    sx As Single '         rotated X location of corner of square on screen
    sy As Single '         rotated Y location of corner of square on screen
    live As Integer '      TRUE if enemy is active, FALSE otherwise
    angle As Single '      the rotation angle of corner of box
    spin As Single '       the spin rate and direction of enemy
    size As Integer '      the size of the enemy
    good As Integer '      TRUE if good guy, FALSE otherwise
End Type

Type POINT3D '             star 3D location
    x As Single '          X location of star
    y As Single '          Y location of star
    z As Single '          Z loaction of star
End Type

Type SPARK '               explosion sparks
    count As Integer '     sparkle countdown counter
    x As Single '          x location of sparkle
    y As Single '          y location of sparkle
    xdir As Single '       x velocity of sparkle
    ydir As Single '       y velocity of sparkle
    speed As Single '      speed of sparkle
    fade As Integer '      decreases to fade sparkle away
End Type

ReDim sparks(0) As SPARK ' create the sparks array

Dim StarSize% '            the size of the stars
Dim Stars% '               the number of stars on screen
Dim Limit% '               the frames per second the game runs at
Dim MaxBullets%% '         the maximum bullets the player can fire at a time
Dim MaxEnemies%% '         the maximum enemies on the screen at a time
Dim BulletSpeed! '         the speed of the player's bullets
Dim EnemyFrameCount% '     enemy elapsed time counter between enemy appearances
Dim EnemyTimer% '          the minumum amount of time elapsed before another enemy appears
Dim EnemySpeed! '          the maximum speed of the enemies
Dim SpinRate! '            the maximum spin rate of the enemies
Dim PowerLevel% '          the player's current power level
Dim Score%

MaxBullets% = 3 '          set maximum bullets player allowed to fire at a time
MaxEnemies% = 10 '         set maximum enemies alolowed on screen at one time
Stars% = 32 '              set number of stars on the screen
EnemyTimer% = 100 '        set minimum amount of time between enemy appearances
StarSize% = 1 '            set the size of the stars
EnemySpeed! = 1 '          set the maximum speed of the enemies
SpinRate! = 1 '            set the maximum spin rate of the enemies
PowerLevel% = 100 '        set the maximum power level

ReDim StarPos(Stars%) As POINT3D '  create the starfield array
Dim Bullet(MaxBullets%) As BULLET ' create the bullet array
Dim Enemy(25, 4) As ENEMY '         create the enemy array
Dim Centerx%, Centery% '            center X,Y coordinates of screen
Dim Turretx%, Turrety% '            X,Y location of turret opening
Dim Mx%, My% '                      mouse X,Y corrdinates
Dim Fcount% '                       frame counter
Dim Pan! '                          used to pan camera around in starfield
Dim Count% '                        generic counter
Dim Hit% '                          TRUE when player hit by enemy, FALSE otherwise
Dim HitCounter% '                   how long to show turret in hit condition
Dim LevelCounter% '                 how long to wait until advancing to next level
Dim Level% '                        the current level of play

Dim sndBackground& '                background music
Dim sndBullet& '                    bullet sound
Dim sndExplode&(3) '                3 random enemy explosions
Dim sndGameOver& '                  "Game Over" voice
Dim sndGetReady& '                  "Get Ready" voice
Dim sndGo& '                        "Go" voice
Dim sndGoodBye& '                   "Goodbye" voice
Dim sndGreenBox& '                  sound when green box hits player
Dim sndGreenBoxHit& '               sound when player shoots a green box (bad player!)
Dim sndLevelUp& '                   sound when level increases
Dim sndRedBox& '                    sound when red box hits player
Dim sndWarpDriveReady& '            "Warp Drive Ready" voice
Dim DelayStart% '                   used to delay the start of the game (intro)

sndBackground& = _SndOpen("revengebackground.ogg", "VOL,SYNC") ' load sounds into memory
sndBullet& = _SndOpen("revengebullet.ogg", "VOL,SYNC")
sndExplode&(1) = _SndOpen("revengeexplode1.ogg", "VOL,SYNC")
sndExplode&(2) = _SndOpen("revengeexplode2.ogg", "VOL,SYNC")
sndExplode&(3) = _SndOpen("revengeexplode3.ogg", "VOL,SYNC")
sndGameOver& = _SndOpen("revengegameover.ogg", "VOL,SYNC")
sndGetReady& = _SndOpen("revengegetready.ogg", "VOL,SYNC")
sndGo& = _SndOpen("revengego.ogg", "VOL,SYNC")
sndGoodBye& = _SndOpen("revengegoodbye.ogg", "VOL,SYNC")
sndGreenBox& = _SndOpen("revengegreenbox.ogg", "VOL,SYNC")
sndGreenBoxHit& = _SndOpen("revengegreenboxhit.ogg", "VOL,SYNC")
sndLevelUp& = _SndOpen("revengelevelup.ogg", "VOL,SYNC")
sndRedBox& = _SndOpen("revengeredbox.ogg", "VOL,SYNC")
sndWarpDriveReady& = _SndOpen("revengewarpdriveready.ogg", "VOL,SYNC")

Centerx% = SWIDTH \ 2 '     calculate the horizontal center of the screen
Centery% = SHEIGHT \ 2 '    calculate the vertical center of the screen
Turretx% = Centerx% '       set turret X to horizontal center of screen
Turrety% = Centery% - 16 '  set turret Y to vertical center of screen
BulletSpeed! = 10 '         set the bullet speed (higher numbers = faster)
Limit% = 60 '               set the frames per second of game play
Pan! = 20 '                 set the starfield camera angle
LevelCounter% = 1800 '      set how many frames must pass util next level up
Level% = 1 '                set the initial level
DelayStart% = Limit% * 6 '  set the time to delay game (intro)

'******************************************************************************
'*                       MAIN PROGRAM LOOP BEGINS HERE                        *
'******************************************************************************

Randomize Timer '                                                              seed the random number generator

For Count% = 1 To Stars% '                                                     position stars in random 3D space
    StarPos(Count%).x = Rnd * 200 - 100
    StarPos(Count%).y = Rnd * 200 - 100
    StarPos(Count%).z = Count% + .1
Next

Screen _NewImage(SWIDTH, SHEIGHT, 32) '                                        initiate a graphics screen
_ScreenMove _Middle '                                                          move the screen to the middle of desktop
_FullScreen '                                                                  go full screen
_MouseHide '                                                                   hide the mouse pointer
_Delay 1 '                                                                     wait for screen to go full screen
_SndPlay sndGetReady& '                                                        tell player to "Get Ready"
_Delay 1 '                                                                     wait another second
_SndLoop sndBackground& '                                                      start the background music
Do '                                                                           start the game intro loop
    _Limit Limit% '                                                            set the FPS limit
    Cls '                                                                      clear the screen
    DelayStart% = DelayStart% - 1 '                                            decrement the delay timer
    If DelayStart% < Limit% * 3 Then DRAWSTARS '                               display the starfield after 3 seconds
    If DelayStart% = Limit% * 3 Then _SndPlay sndWarpDriveReady& '             tell the user "Warp Drive Ready"
    While _MouseInput: Wend '                                                  get the latest mouse information
    Mx% = _MouseX '                                                            save the mouse X coordinate
    My% = _MouseY '                                                            save the mouse Y coordinate
    AngleToMouse! = VECTORTOANGLE(Centerx%, Centery%, Mx%, My%) '              get the angle from the mouse to center of screen
    DRAWTURRET AngleToMouse!, Hit% '                                           draw turret with gun pointing toward mouse
    DRAWCROSSHAIRS Mx%, My% '                                                  draw the crosshairs at mouse X,Y
    SHOWSCORE '                                                                show the score
    _Display '                                                                 update screen with all previous changes
Loop Until DelayStart% = 0 '                                                   stop looping when delay time has reached 0
_SndPlay sndGo& '                                                              tell the user "Go"
_SndVol sndBackground&, .75 '                                                  tone down the background music slightly
Do '                                                                           start the main game play loop
    _Limit Limit% '                                                            set the FPS limit
    Cls '                                                                      clear the screen
    DRAWSTARS '                                                                draw the moving starfield
    While _MouseInput: Wend '                                                  get the latest mouse information
    Mx% = _MouseX '                                                            save the mouse X coordinate
    My% = _MouseY '                                                            save the mouse Y coordinate
    AngleToMouse! = VECTORTOANGLE(Centerx%, Centery%, Mx%, My%) '              get the angle from the mouse to center of screen
    If _MouseButton(1) And Fcount% = 0 Then '                                  is player pressing left button and ok to fire?
        FIREBULLET AngleToMouse!, BulletSpeed! '                               yes, fire a bullet toward the crosshairs
        Fcount% = Limit% \ 8 '                                                 calculate how long to wait before another bullet fired
    End If
    DRAWBULLETS '                                                              update any bullets currently flying on screen
    DRAWTURRET AngleToMouse!, Hit% '                                           draw turret with gun pointing toward mouse
    If EnemyFrameCount% = 0 Then '                                             is it time to spawn another enemy?
        MAKEENEMY '                                                            yes, make a new enemy
        EnemyFrameCount% = EnemyTimer% - Int(Rnd(1) * EnemyTimer%) '           calculate how long to wait before spawning another
    End If
    DRAWENEMIES '                                                              update any enemies currently flying on screen
    DRAWCROSSHAIRS Mx%, My% '                                                  draw the crosshair at mouse positon
    CHECKFORCOLLISIONS '                                                       check for collisions between things flying on screen
    UPDATESPARKS '                                                             update any sparks currently flying on screen
    SHOWSCORE '                                                                show the score, level and health meter on screen
    If LevelCounter% = 0 Then '                                                is it time to level up?
        LEVELUP '                                                              yes, increase the level of difficulty
        LevelCounter% = 1800 '                                                 how long to wait until next level up
    Else '                                                                     no
        LevelCounter% = LevelCounter% - 1 '                                    decrement the level counter
    End If
    _Display '                                                                 update the display with all previous chganges
Loop Until PowerLevel% = 0 '                                                   keep playing until player out of power
_SndPlay sndGameOver& '                                                        tell the user "Game Over"
Do: Loop Until Not _SndPlaying(sndGameOver&) '                                 loop until computer is done speaking
Sleep '                                                                        wait for a key press
_SndStop sndBackground& '                                                      stop the background music
_SndPlay sndGoodBye& '                                                         tell the user "Goodbye"
Do: Loop Until Not _SndPlaying(sndGoodBye&) '                                  loop until the computer is done speaking
System '                                                                       return to Windows

'******************************************************************************
'*                        MAIN PROGRAM LOOP ENDS HERE                         *
'******************************************************************************

'******************************************************************************
'*                         SUBROUTINES AND FUNCTIONS                          *
'******************************************************************************

'------------------------------------------------------------------------------------------------------------------------------------------

Sub SHOWSCORE ()

    '**
    '** displays the score, level and power meter on screen
    '**

    Shared PowerLevel% '       need access to power level
    Shared Score% '            need access to player score
    Shared Level% '            need access to current level of play

    Dim Clr~& '                color of power meter
    Dim Red%, Green%, Blue% '  RGB components of color
    Dim s$, l$ '               score and level converted to strings

    If PowerLevel% > 50 Then '                                                     is power level 51% or higher?
        Red% = 0 '                                                                 yes, set color to GREEN
        Green% = 255
        Blue% = 0
    ElseIf PowerLevel% > 25 Then '                                                 no, is power level 26% or higher?
        Red% = 255 '                                                               yes, set color to YELLOW
        Green% = 255
        Blue% = 0
    Else '                                                                         no, we are less than 26% power!
        Red% = 255 '                                                               set color to RED
        Green% = 0
        Blue% = 0
    End If
    Clr~& = _RGB32(Red%, Green%, Blue%) '                                          save power meter color
    Locate 1, 2 '                                                                  locate the cursor
    Print "POWER:"; '                                                              print power meter label
    Line (60, 2)-(264, 12), _RGB32(255, 255, 255), B '                             draw power meter bounding box
    Line (62, 4)-(PowerLevel% * 2 + 62, 10), Clr~&, BF '                           draw power meter
    s$ = Right$("0000" + LTrim$(Str$(Score%)), 4) '                                format the score string
    Locate 1, 74 '                                                                 locate the cursor
    Print "SCORE: "; s$; '                                                         print score label and score
    l$ = Right$("000" + LTrim$(Str$(Level%)), 3) '                                 format the level string
    Locate 1, 148 '                                                                locate the cursor
    Print "LEVEL: "; l$; '                                                         print level label and level

End Sub

'------------------------------------------------------------------------------------------------------------------------------------------

Sub LEVELUP () Static

    '**
    '** Increases the level of difficulty (a work in progress)
    '**

    Shared StarPos() As POINT3D '  need access to the starfield array
    Shared sndLevelUp& '           need access to the level up sound
    Shared Stars% '                need access to number of stars on screen
    Shared StarSize% '             need access to the size of the stars
    Shared Limit% '                need access to the game FPS limit
    Shared MaxBullets% '           need access to the maximum allowed bullets on screen
    Shared MaxEnemies% '           need access to the maximum number of enemies on screen
    Shared BulletSpeed! '          need access to the bullet speed
    Shared EnemyTimer% '           need access to the enemy timer
    Shared EnemySpeed! '           need access to the enemy speed
    Shared SpinRate! '             need access to the enemy spin rate
    Shared Level% '                need access to the current level of difficulty

    Dim Upper% '                   the upper boundary of the starfield array

    _SndPlay sndLevelUp& '                                                         play the level up sound
    Level% = Level% + 1 '                                                          increment the level
    If Level% Mod 5 = 0 Then StarSize% = StarSize% + 1 '                           increment the star size every five levels
    If StarSize% > 10 Then StarSize% = 10 '                                        keep the maximum star size to 10
    EnemyTimer% = EnemyTimer% - 5 '                                                make the enemies come out quicker
    If EnemyTimer% < Limit% \ 4 Then EnemyTimer% = Limit% \ 4 '                    keep the enemy timer to no less that 1/4 second
    EnemySpeed! = EnemySpeed! + .1 '                                               increase the speed of the enemies
    If EnemySpeed! > 5 Then EnemySpeed! = 5 '                                      keep the maximum enemy speed to 5
    MaxEnemies% = MaxEnemies% + 5 '                                                allow 5 more enemies on the screen
    If MaxEnemies% > 25 Then MaxEnemies% = 25 '                                    keep the maximum enemies on screen to 25
    SpinRate! = SpinRate! + .25 '                                                  increase the spin rate of the enemies
    If SpinRate! > 5 Then SpinRate! = 5 '                                          keep the maximum spin rate to 5
    Stars% = Stars% + 32 '                                                         add 32 more stors to the star field
    If Stars% > 128 Then '                                                         are there more than 128 stars?
        Stars% = 128 '                                                             yes, keep maximum stars to 128
    Else '                                                                         no
        Upper% = UBound(StarPos) '                                                 get the array's upper limit
        ReDim _Preserve StarPos(Stars%) As POINT3D '                               increase the array by 32
        For Count% = Upper% + 1 To Stars% '                                        randomize the 32 new stars added
            StarPos(Count%).x = Rnd * 200 - 100
            StarPos(Count%).y = Rnd * 200 - 100
            StarPos(Count%).z = Count% + .1
        Next
    End If

End Sub

'------------------------------------------------------------------------------------------------------------------------------------------

Sub CHECKFORCOLLISIONS ()

    '**
    '** Checks for collisions between bullets and enemies and enemies and player
    '**

    Shared Enemy() As ENEMY '    need access to the enemy array
    Shared Bullet() As BULLET '  need access to teh bullet array
    Shared MaxEnemies% '         need access to the maximum enemies on screen
    Shared MaxBullets% '         need access to the maximum bullets on screen
    Shared PowerLevel% '         need access to the current player power level
    Shared Centerx%, Centery% '  need access to the center X,Y of the screen
    Shared Hit% '                need access to the player hit indicator
    Shared HitCounter% '         need access to the player hit counter
    Shared Limit% '              need access to the current game FPS
    Shared Score% '              need access to the player's score
    Shared sndExplode&() '       need access to the 3 explosion sounds
    Shared sndGreenBox& '        need access to the green box hitting player sound
    Shared sndRedBox& '          need access to the red box hitting player sound
    Shared sndGreenBoxHit& '     need access to the bullet hitting green box sound (bad player!)

    Dim BulletCount% '           generic counter to cycle through all bullets
    Dim EnemyCount% '            generic counter to cycle through all enemies
    Dim Count% '                 just another generic counter

    Do '                                                                           start the bullet collision loop
        BulletCount% = BulletCount% + 1 '                                          increment the bullet counter
        If Bullet(BulletCount%).live Then '                                        is this bullet live on the screen?
            EnemyCount% = 0 '                                                      reset the enemy counter
            Do '                                                                   start the bullet/enemy collision loop
                EnemyCount% = EnemyCount% + 1 '                                    increment the enemy counter
                If Enemy(EnemyCount%, 0).live Then '                               is this enemy live on the screen?
                    '**
                    '** yes, check for a collision between this bullet and the enemy
                    '**
                    If ROUNDCOLLISION(Bullet(BulletCount%).x, Bullet(BulletCount%).y, 10, Enemy(EnemyCount%, 0).x, Enemy(EnemyCount%, 0).y, Enemy(EnemyCount%, 0).size) Then
                        Enemy(EnemyCount%, 0).live = FALSE '                       a collision! this enemy is now dead
                        Bullet(BulletCount%).live = FALSE '                        this bullet is now dead
                        If Enemy(EnemyCount%, 0).good Then '                       was this a green enemy?
                            Score% = Score% - 10 '                                 yes, take points from player (bad player!)
                            _SndPlay sndGreenBoxHit& '                             play the bullet hitting green box xound
                        Else '                                                     no, this was a red box (good player!)
                            Score% = Score% + 1 '                                  increase the player's score
                            _SndPlay sndExplode&(Int(Rnd(1) * 3) + 1) '            play one of three random explosion sounds
                        End If
                        MAKESPARKS Bullet(BulletCount%).x, Bullet(BulletCount%).y ' make explosion sparks where bullet was
                        Exit Do '                                                  no need to check other enemies
                    End If
                End If
            Loop Until EnemyCount% = MaxEnemies% '                                 keep looping until all enemies checked
        End If
    Loop Until BulletCount% = MaxBullets% '                                        keep looping until all bullets checked
    EnemyCount% = 0 '                                                              reset the enemy counter
    Do '                                                                           start the enemy/player collision loop
        EnemyCount% = EnemyCount% + 1 '                                            increase the enemy counter
        If Enemy(EnemyCount%, 0).live Then '                                       is this enemy live?
            '**
            '** yes, is there a collision between this enemy and the turret?
            '**
            If ROUNDCOLLISION(Centerx%, Centery%, 30, Enemy(EnemyCount%, 0).x, Enemy(EnemyCount%, 0).y, Enemy(EnemyCount%, 0).size) Then
                Enemy(EnemyCount%, 0).live = FALSE '                               a collision! this enemy is dead
                Hit% = TRUE '                                                      set the player hit flag
                HitCounter% = Limit% \ 8 '                                         how long should player be seen as hit?
                MAKESPARKS Enemy(EnemyCount%, 0).x, Enemy(EnemyCount%, 0).y '      make explosion sparks at enemy position
                If Enemy(EnemyCount%, 0).good Then '                               was this a green enemy box?
                    _SndPlay sndGreenBox& '                                        yes, play green box hitting player sound
                    PowerLevel% = PowerLevel% + Enemy(EnemyCount%, 0).size \ 5 '   increase the player's power level based on box size
                    If PowerLevel% > 100 Then PowerLevel% = 100 '                  keep the power level at 100
                Else '                                                             no, this was a red box
                    _SndPlay sndRedBox& '                                          play red box hitting player sound
                    PowerLevel% = PowerLevel% - Enemy(EnemyCount%, 0).size \ 5 '   decrease the player's power level based on box size
                    If PowerLevel% < 0 Then PowerLevel% = 0 '                      keep the power level at 0
                End If
            End If
        End If
    Loop Until EnemyCount% = MaxEnemies% '                                         keep looping until all enemies checked

End Sub

'------------------------------------------------------------------------------------------------------------------------------------------

Sub MAKESPARKS (x%, y%)

    '**
    '** Initiates explosion sparks at the X,Y coordinate given
    '**

    Shared sparks() As SPARK '        need access to the aprk array

    Dim cleanup%, count%, topspark% ' local variables

    cleanup% = TRUE '                                                              assume array will need cleaned
    For count% = 1 To UBound(sparks) '                                             cycle through the spark array
        If sparks(count%).count <> 0 Then '                                        is this spark active?
            cleanup% = FALSE '                                                     yes, the array is in use, no cleanup
            Exit For '                                                             exit the FOR/NEXT loop
        End If
    Next count%
    If cleanup% Then ReDim sparks(0) As SPARK '                                    reset the array is cleanup needed
    topspark% = UBound(sparks) '                                                   get the upper boundary of spark array
    ReDim _Preserve sparks(topspark% + 11) As SPARK '                              add more sparks to the spark array
    For count% = 1 To 10 '                                                         cycle through the new sparks
        sparks(topspark% + count%).count = 32 '                                    spark frames to live
        sparks(topspark% + count%).x = x% '                                        set the spark X starting point
        sparks(topspark% + count%).y = y% '                                        set the spark Y starting point
        sparks(topspark% + count%).fade = 255 '                                    set the intensity of the spark
        sparks(topspark% + count%).speed = Int(Rnd(1) * 6) + 6 '                   set the velocity of the spark
        sparks(topspark% + count%).xdir = Rnd(1) - Rnd(1) '                        set the X vector of the spark
        sparks(topspark% + count%).ydir = Rnd(1) - Rnd(1) '                        set the Y vector of the spark
    Next count%

End Sub

'------------------------------------------------------------------------------------------------------------------------------------------

Sub UPDATESPARKS ()

    '**
    '** Updates any sparks currently on the screen
    '**

    Shared sparks() As SPARK '    need access to the spark array

    Dim count%, fade1%, fade2% '  local variables

    For count% = 1 To UBound(sparks) '                                                         cycle through the spark array
        If sparks(count%).count > 0 Then '                                                     is this spark alive?
            fade1% = sparks(count%).fade / 2 '                                                 yes, calculate how much to fade the spark
            fade2% = sparks(count%).fade / 4
            PSet (sparks(count%).x, sparks(count%).y), _RGB(sparks(count%).fade, sparks(count%).fade, sparks(count%).fade) ' draw the spark
            PSet (sparks(count%).x + 1, sparks(count%).y), _RGB(fade1%, fade1%, fade1%)
            PSet (sparks(count%).x - 1, sparks(count%).y), _RGB(fade1%, fade1%, fade1%)
            PSet (sparks(count%).x, sparks(count%).y + 1), _RGB(fade1%, fade1%, fade1%)
            PSet (sparks(count%).x, sparks(count%).y - 1), _RGB(fade1%, fade1%, fade1%)
            PSet (sparks(count%).x + 1, sparks(count%).y + 1), _RGB(fade2%, fade2%, fade2%)
            PSet (sparks(count%).x - 1, sparks(count%).y - 1), _RGB(fade2%, fade2%, fade2%)
            PSet (sparks(count%).x - 1, sparks(count%).y + 1), _RGB(fade2%, fade2%, fade2%)
            PSet (sparks(count%).x + 1, sparks(count%).y - 1), _RGB(fade2%, fade2%, fade2%)
            sparks(count%).fade = sparks(count%).fade - 8 '                                    decrease the intensity level of this spark
            sparks(count%).x = sparks(count%).x + sparks(count%).xdir * sparks(count%).speed ' update the X location of this spark
            sparks(count%).y = sparks(count%).y + sparks(count%).ydir * sparks(count%).speed ' update the Y location of this spark
            sparks(count%).speed = sparks(count%).speed / 1.1 '                                slow the spark down a bit
            sparks(count%).count = sparks(count%).count - 1 '                                  decrement this spark's life meter
        End If
    Next count%

End Sub

'------------------------------------------------------------------------------------------------------------------------------------------

Sub DRAWENEMIES ()

    '**
    '** Draws any live enemies on the screen
    '**

    Shared Enemy() As ENEMY '  need access to the enemy array
    Shared MaxEnemies% '       need access to the maximum enemies on screen
    Shared EnemyFrameCount% '  need access tot he enemy frame counter

    Dim Count% '               generic counter
    Dim Red%, Green%, Blue% '  color components

    Do '                                                                                    start the enemy check loop
        Count% = Count% + 1 '                                                               increment the enemy counter
        If Enemy(Count%, 0).live Then '                                                     is this enemy live on screen?
            If Enemy(Count%, 0).good Then '                                                 yes, is it a good enemy (GREEN)?
                Red% = 0 '                                                                  yes, set color to GREEN
                Green% = 255
                Blue% = 0
            Else '                                                                          no, this is a bad enemy (RED)
                Red% = 255 '                                                                set color to RED
                Green% = 0
                Blue% = 0
            End If
            Enemy(Count%, 0).x = Enemy(Count%, 0).x + Enemy(Count%, 0).xv '                 update enemy center X location
            Enemy(Count%, 0).y = Enemy(Count%, 0).y + Enemy(Count%, 0).yv '                 update enemy center Y location
            Enemy(Count%, 1).x = Enemy(Count%, 0).x '                                       set upper left corner X location
            Enemy(Count%, 1).y = Enemy(Count%, 0).y - Enemy(Count%, 0).size '               set upper left corner Y location
            Enemy(Count%, 1).angle = Enemy(Count%, 1).angle + Enemy(Count%, 0).spin '       update angle to account for spin
            Enemy(Count%, 2).x = Enemy(Count%, 0).x + Enemy(Count%, 0).size '               set upper right corner X location
            Enemy(Count%, 2).y = Enemy(Count%, 0).y '                                       set upper right corner Y location
            Enemy(Count%, 2).angle = Enemy(Count%, 2).angle + Enemy(Count%, 0).spin '       update angle to account for spin
            Enemy(Count%, 3).x = Enemy(Count%, 0).x '                                       set lower right corner X location
            Enemy(Count%, 3).y = Enemy(Count%, 0).y + Enemy(Count%, 0).size '               set lower right corner Y location
            Enemy(Count%, 3).angle = Enemy(Count%, 3).angle + Enemy(Count%, 0).spin '       update angle to account for spin
            Enemy(Count%, 4).x = Enemy(Count%, 0).x - Enemy(Count%, 0).size '               set lower left corner X location
            Enemy(Count%, 4).y = Enemy(Count%, 0).y '                                       set lower left corner Y location
            Enemy(Count%, 4).angle = Enemy(Count%, 4).angle + Enemy(Count%, 0).spin '       update angle to account for spin
            For Rotate% = 1 To 4 '                                                          cyle through all four corner points
                Enemy(Count%, Rotate%).sx = Enemy(Count%, Rotate%).x '                      set the screen X location
                Enemy(Count%, Rotate%).sy = Enemy(Count%, Rotate%).y '                      set the screen Y location
                '**
                '** calculate the new X,Y screen coordinate of corner
                '**
                ROTATEPOINT Enemy(Count%, Rotate%).sx, Enemy(Count%, Rotate%).sy, Enemy(Count%, 0).x, Enemy(Count%, 0).y, Enemy(Count%, Rotate%).angle
            Next Rotate%
            '**
            '** draw the box by connecting lines between the four corners
            '**
            Line (Enemy(Count%, 1).sx, Enemy(Count%, 1).sy)-(Enemy(Count%, 2).sx, Enemy(Count%, 2).sy), _RGB32(Red%, Green%, Blue% + Count%)
            Line -(Enemy(Count%, 3).sx, Enemy(Count%, 3).sy), _RGB32(Red%, Green%, Blue% + Count%)
            Line -(Enemy(Count%, 4).sx, Enemy(Count%, 4).sy), _RGB32(Red%, Green%, Blue% + Count%)
            Line -(Enemy(Count%, 1).sx, Enemy(Count%, 1).sy), _RGB32(Red%, Green%, Blue% + Count%)
            Paint (Enemy(Count%, 0).x, Enemy(Count%, 0).y), _RGB32(Red%, Green%, Blue%), _RGB32(Red%, Green%, Blue% + Count%)
        End If
    Loop Until Count% = MaxEnemies% '                                                       keep looping until all enemies updated
    EnemyFrameCount% = EnemyFrameCount% - 1 '                                               decrement the enemy frame counter
    If EnemyFrameCount% < 0 Then EnemyFrameCount% = 0 '                                     keep the frame counter at 0

End Sub

'------------------------------------------------------------------------------------------------------------------------------------------

Sub MAKEENEMY ()

    '**
    '** creates a new enemy on screen
    '**

    Shared Enemy() As ENEMY '    need access to the enemy array
    Shared Centerx%, Centery% '  need access to the center X,Y of screen
    Shared MaxEnemies% '         need access to maximum enemies on screen
    Shared EnemySpeed! '         need access to enemy speed
    Shared SpinRate! '           need access to spin rate
    Shared PowerLevel% '         need access to player power level

    Dim Count% '                 generic counter
    Dim AngleToCenter! '         holds the angle from new enemy to center of screen
    Dim EnemySize% '             the enemy size to create

    Do '                                                                           start loop to cycle through enemy array
        Count% = Count% + 1 '                                                      increment the enemy counter
        If Not Enemy(Count%, 0).live Then '                                        is this position in array not being used?
            Enemy(Count%, 0).live = TRUE '                                         yes, mark this position as now a live enemy
            If Int(Rnd(1) * (PowerLevel% \ 4)) = 1 Then '                          randomly determine if good or bad enemy
                Enemy(Count%, 0).good = TRUE '                                     good enemy (GREEN), remember
            Else '                                                                 bad enemy (RED)
                Enemy(Count%, 0).good = FALSE '                                    remember
            End If
            Select Case Int(Rnd(1) * 4) + 1 '                                      randomly choose which side of screen to start at
                Case 1 '                                                           start from the top
                    Enemy(Count%, 0).x = Int(Rnd(1) * SWIDTH) '                    choose a random X start location
                    Enemy(Count%, 0).y = 0 '                                       set Y location to top of screen
                Case 2 '                                                           start from the right
                    Enemy(Count%, 0).x = SWIDTH '                                  set X location to right of screen
                    Enemy(Count%, 0).y = Int(Rnd(1) * SHEIGHT) '                   choose a random Y start location
                Case 3 '                                                           start from the bottom
                    Enemy(Count%, 0).x = Int(Rnd(1) * SWIDTH) '                    choose a random X start location
                    Enemy(Count%, 0).y = SHEIGHT '                                 set Y location to bottom of screen
                Case 4 '                                                           start from the left
                    Enemy(Count%, 0).x = 0 '                                       set X location to left of screen
                    Enemy(Count%, 0).y = Int(Rnd(1) * SHEIGHT) '                   choose a random Y start location
            End Select
            AngleToCenter! = VECTORTOANGLE(Centerx%, Centery%, Enemy(Count%, 0).x, Enemy(Count%, 0).y) - 180 ' get angle between enemy and turret
            ANGLETOVECTOR AngleToCenter!, Enemy(Count%, 0).xv, Enemy(Count%, 0).yv ' set enemy vectors according to angle
            Enemy(Count%, 0).xv = Enemy(Count%, 0).xv * EnemySpeed! '              set X vector speed
            Enemy(Count%, 0).yv = Enemy(Count%, 0).yv * EnemySpeed! '              set Y vector speed
            Enemy(Count%, 0).spin = (Rnd(1) - Rnd(1)) * SpinRate! '                set enemy spin rate
            EnemySize% = Int(Rnd(1) * 30) + 30 '                                   set random enemy size from 30 to 60
            Enemy(Count%, 0).size = EnemySize% '                                   remember enemy size
            Enemy(Count%, 1).angle = 0 '                                           upper left corner has angle of 0
            Enemy(Count%, 2).angle = 90 '                                          upper right corner has angle of 90
            Enemy(Count%, 3).angle = 180 '                                         lower right corner has angle of 180
            Enemy(Count%, 4).angle = 270 '                                         lower left corner has angle of 270
            Exit Sub '                                                             no need to check enemy array any further
        End If
    Loop Until Count% = MaxEnemies% '                                              keep looping until all enemy array positions checked

End Sub

'------------------------------------------------------------------------------------------------------------------------------------------

Sub DRAWSTARS ()
    '**
    '** This subroutine was supplied by harixxx on (4-23-2010) on the QB64.NET web site
    '**

    Shared StarPos() As POINT3D
    Shared Pan!
    Shared StarSize%
    Shared Stars%

    Dim Count%

    Pan! = Pan! + .1
    For Count% = 1 To Stars% '------------------------------------------- draw stars
        S = StarSize% - StarPos(Count%).z * .01 '------------------------ star size
        px = StarPos(Count%).x * 25 / StarPos(Count%).z * 30 + SWIDTH \ 2 '----- star x
        py = StarPos(Count%).y * 25 / StarPos(Count%).z * 30 + SHEIGHT \ 2 '----- star y
        bri = 255 - StarPos(Count%).z / 100 * 255 '----------------- star color
        Line (px, py)-Step(S, S), _RGB32(bri, bri, bri), BF

        StarPos(Count%).x = StarPos(Count%).x + Sin(Pan * .15) * .12 '--------- 3d panning rotation
        StarPos(Count%).y = StarPos(Count%).y + Sin(Pan * .14) * .15
        StarPos(Count%).z = StarPos(Count%).z + Sin(Pan * .12) * .25

        If StarPos(Count%).x > 25 Then StarPos(Count%).x = StarPos(Count%).x - 50 '--- set 3d position limit
        If StarPos(Count%).x < -25 Then StarPos(Count%).x = StarPos(Count%).x + 50
        If StarPos(Count%).y > 25 Then StarPos(Count%).y = StarPos(Count%).y - 50
        If StarPos(Count%).y < -25 Then StarPos(Count%).y = StarPos(Count%).y + 50
        If StarPos(Count%).z > 100 Then StarPos(Count%).z = StarPos(Count%).z - 100
        If StarPos(Count%).z < 1 Then StarPos(Count%).z = StarPos(Count%).z + 100
    Next Count%

End Sub

'------------------------------------------------------------------------------------------------------------------------------------------

Sub DRAWBULLETS ()

    '**
    '** draws current live bullets on screen
    '**

    Shared Bullet() As BULLET '  need access to bullet array
    Shared Fcount% '             need access to bullet frame counter
    Shared MaxBullets% '         need access to maximum bullets allowed

    Dim Count% '                 generic counter

    Do '                                                                           start loop to cycle through bullet array
        Count% = Count% + 1 '                                                      increment the bullet counter
        If Bullet(Count%).live Then '                                              is this bullet live?
            Bullet(Count%).x = Bullet(Count%).x + Bullet(Count%).xv '              update bullet X location
            Bullet(Count%).y = Bullet(Count%).y + Bullet(Count%).yv '              update bullet Y location
            If Bullet(Count%).x <= 5 Or Bullet(Count%).x >= SWIDTH - 5 Then '      has bullet X gone off screen?
                Bullet(Count%).live = FALSE '                                      yes, this bullet is now dead
            End If
            If Bullet(Count%).y <= 5 Or Bullet(Count%).y >= SHEIGHT - 5 Then '     has bullet Y gone off screen?
                Bullet(Count%).live = FALSE '                                      yes, this bullet is now dead
            End If
            If Bullet(Count%).live Then '                                          is the bullet still alive?
                CIRCLES Bullet(Count%).x, Bullet(Count%).y, 10, _RGB32(126, 126, 126), 0, 0, 0 '           yes, draw bullet
                Paint (Bullet(Count%).x, Bullet(Count%).y), _RGB32(126, 126, 126), _RGB32(126, 126, 126) ' paint the bullet
            End If
        End If
    Loop Until Count% = MaxBullets% '                                              keep looping until all bullets checked
    Fcount% = Fcount% - 1 '                                                        decrement the bullet frame counter
    If Fcount% < 0 Then Fcount% = 0 '                                              keep bullet frame counter to 0

End Sub

'------------------------------------------------------------------------------------------------------------------------------------------

Sub FIREBULLET (Angle!, Speed!)

    '**
    '** creates a new bullet
    '**

    Shared Bullet() As BULLET '  need access to bullet array
    Shared Centerx%, Centery% '  need access to the center of screen
    Shared MaxBullets% '         need access to the maximum number of bullets allowed
    Shared sndBullet& '          need access to the bullet fired sound

    Dim Count% '                 generic counter

    Do '                                                                           start looping through bullet array
        Count% = Count% + 1 '                                                      increment the bullet counter
        If Not Bullet(Count%).live Then '                                          can this position be used for a bullet?
            _SndPlay sndBullet& '                                                  yes, play the bullet fired sound
            Bullet(Count%).live = TRUE '                                           mark this array position with active bullet
            Bullet(Count%).x = Centerx% '                                          set the X location of bullet
            Bullet(Count%).y = Centery% '                                          set the Y location of bullet
            ANGLETOVECTOR Angle!, Bullet(Count%).xv, Bullet(Count%).yv '           set bullet X,Y vectors according to current turret angle
            Bullet(Count%).xv = Bullet(Count%).xv * Speed! '                       set the bullet X vecotr speed
            Bullet(Count%).yv = Bullet(Count%).yv * Speed! '                       set the bullet Y vector speed
            Exit Sub '                                                             no need to check bullet array any further
        End If
    Loop Until Count% = MaxBullets% '                                              keep looping until all bullets checked

End Sub

'------------------------------------------------------------------------------------------------------------------------------------------

Sub DRAWTURRET (Angle!, Hit%)

    '**
    '** draws the player's turret
    '**

    Shared Centerx%, Centery% '  need access to center X,Y of screen
    Shared Turretx%, Turrety% '  need access to turret X,Y location
    Shared Hit% '                need access to turret hit flag
    Shared HitCounter% '         need access to hit counter

    Dim tx!, ty! '               turret X,Y location
    Dim Red%, Green%, Blue% '    color components

    If Hit% Then '                                                                 was the turret hit?
        HitCounter% = HitCounter% - 1 '                                            yes, decrement the hit counter
        If HitCounter% < 0 Then '                                                  is the hit counter now less than 0?
            Hit% = FALSE '                                                         reset the hit flag
            HitCounter% = 0 '                                                      reset the hit counter
        End If
        Red% = 255 '                                                               set turret color to bright white
        Green% = 255
        Blue% = 255
    Else '                                                                         no, turret was not hit
        Red% = 127 '                                                               set the turret color to standard gray
        Green% = 127
        Blue% = 127
    End If
    tx! = Turretx% '                                                               get turret X location
    ty! = Turrety% '                                                               get turret Y location
    ROTATEPOINT tx!, ty!, Centerx%, Centery%, Angle! '                             rotate the barrel around turret
    CIRCLES Centerx%, Centery%, 30, _RGB32(Red%, Green%, Blue%), 0, 0, 0 '         draw the turret
    CIRCLES tx!, ty!, 13, _RGB32(Red%, Green%, Blue%), 0, 0, 0 '                   draw the turret barrel
    Paint (Centerx%, Centery%), _RGB32(Red% \ 2, Green% \ 2, Blue% \ 2), _RGB32(Red%, Green%, Blue%) ' paint the turret

End Sub

'------------------------------------------------------------------------------------------------------------------------------------------

Sub DRAWCROSSHAIRS (mx%, my%)

    '**
    '** draws the cross hairs at the current mouse location
    '**

    CIRCLES mx%, my%, 17, _RGB32(255, 255, 255), 0, 0, 0 '                         draw the cross hairs
    CIRCLES mx%, my%, 16, _RGB32(127, 127, 127), 0, 0, 0
    CIRCLES mx%, my%, 15, _RGB32(32, 32, 32), 0, 0, 0
    Line (mx% - 16, my%)-(mx% + 16, my%), _RGB32(32, 32, 32)
    Line (mx% - 8, my%)-(mx% + 8, my%), _RGB32(64, 64, 64)
    Line (mx% - 2, my%)-(mx% + 2, my%), _RGB32(128, 128, 128)
    Line (mx%, my% - 16)-(mx%, my% + 16), _RGB32(32, 32, 32)
    Line (mx%, my% - 8)-(mx%, my% + 8), _RGB32(64, 64, 64)
    Line (mx%, my% - 2)-(mx%, my% + 2), _RGB32(128, 128, 128)

End Sub

'------------------------------------------------------------------------------------------------------------------------------------------

Sub ANGLETOVECTOR (An!, x1!, y1!) '                                                                                           ANGLETOVECTOR

    '**
    '** Computes the angle from vectors passed in.
    '**
    '**       315  000  045
    '**           \ | /       Angles must be passed based
    '**       270 --+-- 090   on the diagram to the left
    '**           / | \
    '**       225  180  135
    '**
    '** INPUT : An! - the angle to convert to a vector
    '**
    '** OUTPUT: x1! - the horizontal vector
    '**         y1! - the vertical vector
    '**
    '** REFERENCE: http://www.idevgames.com/forums/thread-9221.html
    '**

    x1! = XVELOCITY(An!, 1) ' compute the horizontal vector based on angle and speed of 1
    y1! = YVELOCITY(An!, 1) ' compute the vertical vector based on angle and speed of 1

End Sub

'------------------------------------------------------------------------------------------------------------------------------------------

Function VECTORTOANGLE (x1c!, y1c!, x2!, y2!) '                                                                               VECTORTOANGLE

    '**
    '** Computes the angle to a point from a second originating point (center).
    '**
    '**       315  000  045
    '**           \ | /       Angles will be returned based
    '**       270 --+-- 090   on the diagram to the left
    '**           / | \
    '**       225  180  135
    '**
    '** INPUT : x1c! - the X coordinate of the point of reference (center point)
    '**         y1c! - the Y coordinate of the point of reference (center point)
    '**         x2!  - the X coordinate of the point being resolved
    '**         y2!  - the Y coordinate of the point being resolved
    '**
    '** OUTPUT: VECTORTOANGLE - the angle resolved from the point position in relation to the reference (center) point
    '**
    '** NOTES : QB64 does not have an ATN2() function, so ATN() must be used instead taking into account
    '**         which of the 4 quadrants the point being resolved lies in. This work is based off Galleon's
    '**         getangle# function found at: http://www.qb64.net/forum/index.php?topic=3934.0
    '**
    '** REFERENCE: http://msdn.microsoft.com/en-us/library/system.math.atan2.aspx
    '**

    If y2! = y1c! Then
        If x1c! = x2! Then Exit Function
        If x2! > x1c! Then VECTORTOANGLE = 90 Else VECTORTOANGLE = 270
        Exit Function
    End If
    If x2! = x1c! Then
        If y2! > y1c! Then VECTORTOANGLE = 180
        Exit Function
    End If
    If y2! < y1c! Then
        If x2! > x1c! Then
            VECTORTOANGLE = Atn((x2! - x1c!) / (y2! - y1c!)) * -57.2957795131
        Else
            VECTORTOANGLE = Atn((x2! - x1c!) / (y2! - y1c!)) * -57.2957795131 + 360
        End If
    Else
        VECTORTOANGLE = Atn((x2! - x1c!) / (y2! - y1c!)) * -57.2957795131 + 180
    End If

End Function

'------------------------------------------------------------------------------------------------------------------------------------------

Function ROUNDCOLLISION (Round1X!, Round1Y!, Round1Radius!, Round2X!, Round2Y!, Round2Radius!) '                             ROUNDCOLLISION

    '**
    '** Detects if two circular areas are in collision by first checking the object's bounding box for a collision.
    '** If a bounding box collision has occurred then a more accurate circular collision is checked for.
    '**
    '** INPUT : Round1X!      - the center X location of object 1
    '**         Round1Y!      - the center Y location of object 1
    '**         Round1Radius! - the radius of object 1's bounding circle
    '**         Round2X!      - the center X location of object 2
    '**         Round2Y!      - the center Y location of object 2
    '**         Round2Radius! - the radius of object 2's bounding circle
    '**
    '** OUTPUT: ROUNDCOLLISION - 0 (FALSE) for no collision, -1 (TRUE) for collision
    '**
    '** USES  : BOXCOLLISION - used to check for bounding box collision first, for function speed.
    '**

    If BOXCOLLISION(Round1X! - Round1Radius!, Round1Y! - Round1Radius!, 2 * Round1Radius!, 2 * Round1Radius!, Round2X! - Round2Radius!, Round2Y! - Round2Radius, 2 * Round2Radius!, 2 * Round2Radius!) Then
        If Sqr((Round1X! - Round2X!) ^ 2 + (Round1Y! - Round2Y!) ^ 2) < Round1Radius! + Round2Radius! Then ROUNDCOLLISION = -1
    End If

End Function

'------------------------------------------------------------------------------------------------------------------------------------------

Function BOXCOLLISION (Box1X!, Box1Y!, Box1Width!, Box1Height!, Box2X!, Box2Y!, Box2Width!, Box2Height!) '                     BOXCOLLISION

    '**
    '** Detects if two bounding box areas are in collision
    '**
    '** INPUT : Box1X!      - upper left corner X location of bounding box 1
    '**         Box1Y!      - upper left corner Y location of bounding box 1
    '**         Box1Width!  - the width of bounding box 1
    '**         Box1Height! - the height of bounding box 1
    '**         Box2X!      - upper left corner X location of bounding box 2
    '**         Box2Y!      - upper left corner Y location of bounding box 2
    '**         Box2Width!  - the width of bounding box 2
    '**         Box2Height! - the height of bounding box 2
    '**
    '** OUTPUT: BOXCOLLISION - 0 (FALSE) for no collision, -1 (TRUE) for collision
    '**

    If Box1X! <= Box2X! + Box2Width! Then
        If Box1X! + Box1Width! >= Box2X! Then
            If Box1Y! <= Box2Y! + Box2Height! Then
                If Box1Y! + Box1Height! >= Box2Y! Then
                    BOXCOLLISION = -1
                End If
            End If
        End If
    End If

End Function

'------------------------------------------------------------------------------------------------------------------------------------------

Sub ROTATEPOINT (PointX!, PointY!, CenterX!, CenterY!, Angle!) '                                                                ROTATEPOINT

    '**
    '** Plots a point on a circle's circumference given the point's current location, the center of rotation
    '** and the angle to move the point to using the parametric equation for a circle.
    '**
    '**       315  000  045
    '**           \ | /       Angles must be passed in based
    '**       270 --+-- 090   on the diagram to the left
    '**           / | \
    '**       225  180  135
    '**
    '** INPUT : PointX!  - the current X location of the point
    '**         PointY!  - the current Y location of the point
    '**         CenterX! - the X center of rotation (the middle of the circle)
    '**         CenterY! - the Y center of location (the middle of the circle)
    '**         Angle!   - the angle to rotate the point to
    '**
    '** OUTPUT: PointX!  - will be modified to contain the new X location of the point (see warning)
    '**         PointY!  - will be modified to contain the new Y location of the point (see warning)
    '**
    '** USES  : ANGLETORADIAN - function to return the radian that equates to the angle passed in
    '**                         based on the diagram above.
    '**
    '** WARNING: This subroutine modifies the PointX! and PointY! values passed in. This means the variables you used
    '**          to pass this information will be modfied as well. If you need to retain your variable's original
    '**          values then you need to take steps to save these values before passing them to this subroutine.
    '**
    '** REFERENCE: http://stackoverflow.com/questions/839899/how-do-i-calculate-a-point-on-a-circles-circumference
    '**

    Dim Radius! ' the calculated distance from current point location to center of rotation

    Radius! = Sqr((CenterX! - PointX!) ^ 2 + (CenterY! - PointY!) ^ 2) '                     calculate the point to center of rotation distance
    PointX! = CenterX! + Radius! * Cos(ANGLETORADIAN(Angle! - 90)) '                              calculate the point's new X location
    PointY! = CenterY! + Radius! * Sin(ANGLETORADIAN(Angle! - 90)) '                              calculate the point's new Y location

End Sub

'------------------------------------------------------------------------------------------------------------------------------------------

Function YVELOCITY (Angle!, Speed!) '                                                                                             YVELOCITY

    '**
    '** Returns the Y velocity (vector) based on angle and speed
    '**
    '**       315  000  045
    '**           \ | /       Angles must be passed in based
    '**       270 --+-- 090   on the diagram to the left
    '**           / | \
    '**       225  180  135
    '**
    '** INPUT : Angle! - the angle the object is traveling in. (0 to 360)
    '**         Speed! - the speed the object is moving at.
    '**
    '** OUTPUT: YVELOCITY - the computed Y velocity (vector) value.
    '**
    '** USES  : ANGLETORADIAN - function to return the radian that equates to the angle passed in
    '**                         based on the diagram above.
    '**
    '** REFERENCE: http://www.rodedev.com/tutorials/gamephysics/
    '**

    YVELOCITY = Speed! * Sin(ANGLETORADIAN(Angle! - 90))

End Function

'------------------------------------------------------------------------------------------------------------------------------------------

Function XVELOCITY (Angle!, Speed!) '                                                                                             XVELOCITY

    '**
    '** Returns the X velocity (vector) based on angle and speed
    '**
    '**       315  000  045
    '**           \ | /       Angles must be passed in based
    '**       270 --+-- 090   on the diagram to the left
    '**           / | \
    '**       225  180  135
    '**
    '** INPUT : Angle! - the angle the object is traveling in. (0 to 360)
    '**         Speed! - the speed the object is moving at.
    '**
    '** OUTPUT: XVELOCITY - the computed X velocity (vector) value.
    '**
    '** USES  : ANGLETORADIAN - function to return the radian that equates to the angle passed in
    '**                         based on the diagram above.
    '**
    '** REFERENCE: http://www.rodedev.com/tutorials/gamephysics/
    '**

    XVELOCITY = Speed! * Cos(ANGLETORADIAN(Angle! - 90))

End Function

'------------------------------------------------------------------------------------------------------------------------------------------

Function ANGLETORADIAN (Angle!) '                                                                                             ANGLETORADIAN

    '**
    '** Converts an angle to radian translating to the following:
    '**
    '**  1.75ã     0/2ã      0.25ã
    '**        315  000  045
    '**            \ | /             Inner number = degrees
    '**   1.5ã 270 --+-- 090 0.5ã
    '**            / | \             Outer number = radians
    '**        225  180  135
    '**  1.25ã       ã       0.75ã
    '**
    '** INPUT : Angle! - the angle value passed in. (0 to 360)
    '**
    '** OUTPUT: ANGLETORADIAN - the radian that matches the angle passed in. (0 to 2ã)
    '**

    ANGLETORADIAN = Angle! / 57.2957795131

End Function

'------------------------------------------------------------------------------------------------------------------------------------------

Function RADIANTOANGLE (Radian!) '                                                                                            RADIANTOANGLE

    '**
    '** Converts a radian to angle translated to the following:
    '**
    '**  1.75ã     0/2ã      0.25ã
    '**        315  000  045
    '**            \ | /             Inner number = degrees
    '**   1.5ã 270 --+-- 090 0.5ã
    '**            / | \             Outer number = radians
    '**        225  180  135
    '**  1.25ã       ã       0.75ã
    '**
    '** INPUT : Radian! - the radian value passed in. (0 to 2ã)
    '**
    '** OUTPUT: RADIANTOANGLE - the angle that matches the radian passed in. (0 to 360)
    '**

    RADIANTOANGLE = Radian! * 57.2957795131

End Function

'------------------------------------------------------------------------------------------------------------------------------------------

Sub CIRCLES (cx%, cy%, r!, c~&, s!, e!, a!) '                                                                                       CIRCLES

    '**
    '** Draws circles much the same as the native QB64 CIRCLE command with some variations (see notes)
    '**
    '** SYNTAX: CIRCLES x%, y%, radius!, color~&, start_radian!, end_radian!, aspect_ratio!
    '**
    '**   x%            - center X coordinate of circle
    '**   y%            - center Y coordinate of circle
    '**   radius!       - the radius of the circle
    '**   color~&       - the circle's color
    '**   start_radian! - the radian on circle circumference to begin drawing at
    '**   end_radian!   - the radian on circle circumference to end drawing at
    '**   aspect_ratio! - the aspect ratio of the circle
    '**
    '** NOTES :
    '**                 0/2ã                    Unlike the native CIRCLE command, the CIRCLES command has been
    '**              *********   ~~\            designed to emulate the coordinate systems of the other commands
    '**           ***    |    ***    \          in this library. Start and end radians have been rotated 90 degrees
    '**         **       |       **    \        counter-clockwise and the circle is drawn in a clockwise fashion.
    '**        *         |         *    |
    '**       *          |          *   V       Just as with the native CIRCLE command, supplying a negative value for
    '**      *           |    r!     *          either or both radians will result in a line being drawn from the
    '** 1.5ã *-----------+-----------* 0.5ã     center of the circle to the radian.
    '**      *        cx%,cy%        *
    '**       *          |          *
    '**        *         |         *
    '**         **       |       **
    '**           ***    |    ***
    '**              *********
    '**                  ã
    '**

    Dim s%, e%, nx%, ny%, xr!, yr!, st!, en!, asp! '     local variables used
    Dim stepp!, c!

    st! = s! '                                           copy start radian to local variable
    en! = e! '                                           copy end radian to local variable
    asp! = a! '                                          copy aspect ratio to local variable
    If asp! <= 0 Then asp! = 1 '                         keep aspect ratio between 0 and 4
    If asp! > 4 Then asp! = 4
    If asp! < 1 Then xr! = r! * asp! * 4 Else xr! = r! ' calculate x/y radius based on aspect ratio
    If asp! > 1 Then yr! = r! * asp! Else yr! = r!
    If st! < 0 Then s% = -1: st! = -st! '                remember if line needs drawn from center to start radian
    If en! < 0 Then e% = -1: en! = -en! '                remember if line needs drawn from center to end radian
    If s% Then '                                         draw line from center to start radian?
        nx% = cx% + xr! * Cos(st! - 1.5707963) '         yes, compute starting point on circle's circumference
        ny% = cy% + yr! * Sin(st! - 1.5707963) '         (rotated 90 degrees counter-clockwise)
        Line (cx%, cy%)-(nx%, ny%), c~& '                draw line from center to radian
    End If
    If en! <= st! Then en! = en! + 6.2831852 '           come back around to proper location (draw counterclockwise)
    stepp! = 0.159154945806 / r!
    c! = st! '                                           cycle from start radian to end radian
    Do
        nx% = cx% + xr! * Cos(c! - 1.5707963) '          compute next point on circle's circumfrerence
        ny% = cy% + yr! * Sin(c! - 1.5707963) '          (rotated 90 degrees counter-clockwise)
        PSet (nx%, ny%), c~& '                           draw the point
        c! = c! + stepp!
    Loop Until c! >= en!
    If e% Then Line -(cx%, cy%), c~& '                   draw line from center to end radian if needed

End Sub

'----------------------------------------------------------------------------------------------------------------------

