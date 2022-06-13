' -----------------------------------------------
' QB64 FlappyBird Clone by Terry Ritchie 02/28/14
'
' This program was created to accompany the QB64
' Game Programming course located at:
' http://www.qb64sourcecode.com
'
' You may not sell or distribute this game! It
' was made for instructional purposes only.
' -----------------------------------------------

'--------------------------------
'- Variable declaration section -
'--------------------------------

CONST FALSE = 0 '            boolean: truth  0
CONST TRUE = NOT FALSE '     boolean: truth -1
CONST LARGE = 0 '            large numbers
CONST SMALL = 1 '            small numbers (not used in current version of game)
CONST GOLD = 0 '             gold medal
CONST SILVER = 1 '           silver medal
CONST LIGHT = 0 '            light colored gold/silver medal
CONST DARK = 1 '             dark colored gold/silver medal

TYPE PARALLAX '              parallax scenery settings
    image AS LONG '          scene image
    x AS INTEGER '           scene image x location
    y AS INTEGER '           scene image y location
    frame AS INTEGER '       current parallax frame
    fmax AS INTEGER '        maximum parallax frames allowed
END TYPE

TYPE INFLIGHT '              flappy bird inflight characterisitcs
    y AS SINGLE '            flappy bird y location
    yvel AS SINGLE '         flappy bird y velocity
    flap AS INTEGER '        wing flap position
    flapframe AS INTEGER '   wing flap frame counter
    angle AS INTEGER '       angle of flappy bird
END TYPE

TYPE PIPE '                  pipe characteristics
    x AS INTEGER '           pipe x location
    y AS INTEGER '           pipe y location
END TYPE

DIM Pipes(3) AS PIPE '       define 3 moving sets of pipes
DIM Pipe&(1) '               pipe images 0=top 1=bottom
DIM PipeImage& '             all three pipes drawn image
DIM Birdie AS INFLIGHT '     bird flight characteristics
DIM Scenery(4) AS PARALLAX ' define 4 moving scenes in parallax
DIM Fbird&(8, 3) '           flapping bird images
DIM Num&(9, 1) '             big and small numeral images
DIM Plaque& '                medal/score plaque
DIM FlappyBird& '            Flappy Bird title image
DIM GameOver& '              Game Over image
DIM GetReady& '              Get Ready image
DIM Medal&(1, 1) '           gold/silver medal images
DIM Finger& '                tap finger image
DIM ScoreButton& '           score button image
DIM ShareButton& '           share button image
DIM StartButton& '           start button image
DIM OKButton& '              OK button image
DIM RateButton& '            RATE button image
DIM MenuButton& '            MENU button image
DIM PlayButton& '            PLAY [|>] button image
DIM PauseButton& '           PAUSE [||] button image
DIM HazardBar& '             Hazard bar parallax image
DIM Clouds& '                Clouds parallax image
DIM City& '                  Cityscape parallax image
DIM Bushes& '                Bushes parallax image
DIM New& '                   red NEW image
DIM Clean& '                 clean playing screen image
DIM HitBird% '               boolean: TRUE if bird hits something
DIM HighScore% '             high score
DIM Score% '                 current score
DIM Paused% '                boolean: TRUE if game paused
DIM Ding& '                  ding sound
DIM Flap& '                  flapping sound
DIM Smack& '                 bird smack sound
DIM Latch% '                 boolean: TRUE if mouse button held down
DIM WinX% '                  stops player from exiting program at will

'------------------------
'- Main Program Section -
'------------------------

SCREEN _NEWIMAGE(432, 768, 32) '                        create 432x768 game screen
_TITLE "FlappyBird" '                                   give window a title
CLS '                                                   clear the screen
_SCREENMOVE _MIDDLE '                                   move window to center of desktop
WinX% = _EXIT '                                         program will handle all window close requests
LOADASSETS '                                            set/load game graphics/sounds/settings
Birdie.flap = 1 '                                       set initial wing position of bird
DO '                                                    BEGIN MAIN GAME LOOP
    _LIMIT 60 '                                         60 frames per second
    UPDATESCENERY '                                     update parallaxing scenery
    _PUTIMAGE (40, 265), FlappyBird& '                  place game title on screen
    _PUTIMAGE (350, 265), Fbird&(2, FLAPTHEBIRD%) '     place flapping bird on screen
    IF BUTTON%(64, 535, StartButton&) THEN PLAYGAME '   if start button pressed play game
    IF BUTTON%(248, 535, ScoreButton&) THEN SHOWSCORE ' if score button pressed show scores
    IF BUTTON%(248, 480, RateButton&) THEN RATEGAME '   if rate button pressed bring up browser
    _DISPLAY '                                          update screen with changes
LOOP UNTIL _KEYDOWN(27) OR _EXIT '                      END MAIN GAME LOOP when ESC pressed or window closed
CLEANUP '                                               clean the computer's RAM before leaving
SYSTEM '                                                return to Windows desktop

'-------------------------------------
'- Subroutines and Functions section -
'-------------------------------------

'----------------------------------------------------------------------------------------------------------------------

FUNCTION FLAPTHEBIRD% ()

'*
'* Returns the next index value used in Fbird&() to animate the bird's
'* flapping wings.
'*

SHARED Birdie AS INFLIGHT

Birdie.flapframe = Birdie.flapframe + 1 '     increment frame counter
IF Birdie.flapframe = 4 THEN '                hit limit?
    Birdie.flapframe = 0 '                    yes, reset frame counter
    Birdie.flap = Birdie.flap + 1 '           increment flap counter
    IF Birdie.flap = 4 THEN Birdie.flap = 1 ' reset flap counter when limit hit
END IF
FLAPTHEBIRD% = Birdie.flap '                  return next index value

END SUB

'----------------------------------------------------------------------------------------------------------------------

SUB MOVEPIPES ()

'*
'* Creates and moves the pipe images across the screen.
'*

SHARED Pipes() AS PIPE, Pipe&(), PipeImage&, Paused%, Score%, Ding&

DIM p% ' counter indicating which pipe being worked on

_DEST PipeImage& '                                    work on this image
CLS , _RGBA32(0, 0, 0, 0) '                           clear image with transparent black
_DEST 0 '                                             back to work on screen
DO '                                                  BEGIN PIPE LOOP
    p% = p% + 1 '                                     increment pipe counter
    IF NOT Paused% THEN '                             is game paused?
        Pipes(p%).x = Pipes(p%).x - 3 '               no, move pipe to the left
        IF Pipes(p%).x < -250 THEN '                  hit lower limit?
            Pipes(p%).x = 500 '                       yes, move pipe all the way right
            Pipes(p%).y = -(INT(RND(1) * 384) + 12) ' generate random pipe height position
        END IF
        IF Pipes(p%).x = 101 THEN '                   is pipe crossing bird location?
            _SNDPLAY Ding& '                          play ding sound
            Score% = Score% + 1 '                     increment player score
        END IF
    END IF
    IF Pipes(p%).x > -78 AND Pipes(p%).x < 432 THEN ' is pipe currently seen on screen?
        _PUTIMAGE (Pipes(p%).x, Pipes(p%).y), Pipe&(0), PipeImage& ' place top pipe
        _PUTIMAGE (Pipes(p%).x, Pipes(p%).y + 576), Pipe&(1), PipeImage& ' place bottom pipe
    END IF
LOOP UNTIL p% = 3 '                                   END PIPE LOOP when all pipes moved
_PUTIMAGE (0, 0), PipeImage& '                        place pipe image on screen

END SUB

'----------------------------------------------------------------------------------------------------------------------

SUB FLYBIRDIE ()

'*
'* Controls the flight of bird on screen.
'*

SHARED Birdie AS INFLIGHT, Fbird&(), Paused%, Flap&, HitBird%, Latch%, Smack&

DIM b% '     boolean: TRUE if left mouse button pressed
DIM Angle% ' angle of bird in flight

IF NOT Paused% THEN '                             is game paused?
    WHILE _MOUSEINPUT: WEND '                     no, get latest mouse information
    b% = _MOUSEBUTTON(1) '                        get left mouse button status
    IF NOT b% THEN Latch% = FALSE '               release latch if button let go
    IF NOT HitBird% THEN '                        has bird hit something?
        IF NOT Latch% THEN '                      no, has left button been release?
            IF b% THEN '                          yes, was left button pressed?
                Birdie.yvel = -8 '                yes, reset bird y velocity
                _SNDPLAY Flap& '                  play flap sound
                Latch% = TRUE '                   remember mouse button pressed
            END IF
        END IF
    END IF
    Birdie.yvel = Birdie.yvel + .5 '              bleed off some bird y velocity
    Birdie.y = Birdie.y + Birdie.yvel '           add velocity to bird's y direction
    IF NOT HitBird% THEN '                        has bird hit something?
        IF Birdie.y < -6 OR Birdie.y > 549 THEN ' no, has bird hit top/bottom of screen?
            HitBird% = TRUE '                     yes, remeber bird hit something
            _SNDPLAY Smack& '                     play smack sound
        END IF
    END IF
    IF Birdie.yvel < 0 THEN '                     is bird heading upward?
        Birdie.angle = 1 '                        yes, set angle of bird accordingly
    ELSE
        Angle% = INT(Birdie.yvel * .5) + 1 '      calculate angle according to bird velocity
        IF Angle% > 8 THEN Angle% = 8 '           keep angle within limits
        Birdie.angle = Angle% '                   set bird angle
    END IF
END IF
_PUTIMAGE (100, Birdie.y), Fbird&(Birdie.angle, FLAPTHEBIRD%) ' place bird on screen

END SUB

'----------------------------------------------------------------------------------------------------------------------

SUB UPDATESCORE ()

'*
'* Displays player's score on screen.
'*

SHARED Num&(), Score%

DIM s$ ' score in string format
DIM w% ' width of score string
DIM x% ' x location of score digits
DIM p% ' position counter

s$ = LTRIM$(RTRIM$(STR$(Score%))) ' convert score to string
w% = LEN(s$) * 23 '                 calculate width of score
x% = (432 - w%) \ 2 '               calculate x position of score
FOR p% = 1 TO LEN(s$) '             cycle through each position in score string
    _PUTIMAGE (x%, 100), Num&(ASC(MID$(s$, p%, 1)) - 48, LARGE) ' place score digit on screen
    x% = x% + 23 '                  move to next digit position
NEXT p%

END SUB

'----------------------------------------------------------------------------------------------------------------------

SUB READY ()

'*
'* displays instructions to the player and waits for player to start game.
'*

SHARED Fbird&(), Finger&, GetReady&

DIM b% ' boolean: TRUE if left mouse button pressed

DO '                                 BEGIN READY LOOP
    _LIMIT 60 '                      60 frames per second
    UPDATESCENERY '                  move parallax scenery
    _PUTIMAGE (180, 350), Finger& '  place finger instructions on screen
    _PUTIMAGE (85, 225), GetReady& ' place get ready image on screen
    _PUTIMAGE (100, 375), Fbird&(2, FLAPTHEBIRD%) ' place bird on screen
    UPDATESCORE '                    place score on screen
    _DISPLAY '                       update screen with changes
    WHILE _MOUSEINPUT: WEND '        get latest mouse information
    b% = _MOUSEBUTTON(1) '           get status of left mouse button
    IF _EXIT THEN CLEANUP: SYSTEM '  leave game if user closes game window
LOOP UNTIL b% '                      END READY LOOP when left button pressed
_DELAY .2 '                          slight delay to allow mouse button release

END SUB

'----------------------------------------------------------------------------------------------------------------------

SUB PLAYGAME ()

'*
'* Allows player to play the game.
'*

SHARED Pipes() AS PIPE, Birdie AS INFLIGHT, PauseButton&, PlayButton&, Paused%, HitBird%, Score%

RANDOMIZE TIMER '                                seed random number generator
Score% = 0 '                                     reset player score
Birdie.y = 0 '                                   reset bird y location
Birdie.yvel = 0 '                                reset bird y velocity
Birdie.flap = 1 '                                reset bird wing flap index
Pipes(1).x = 500 '                               reset position of first pipe
Pipes(2).x = 749 '                               reset position of second pipe
Pipes(3).x = 998 '                               reset position of third pipe
Pipes(1).y = -(INT(RND(1) * 384) + 12) '         calculate random y position of pipe 1
Pipes(2).y = -(INT(RND(1) * 384) + 12) '         calculate random y position of pipe 2
Pipes(3).y = -(INT(RND(1) * 384) + 12) '         calculate random y position of pipe 3
READY '                                          display instructions to player
DO '                                             BEGIN GAME PLAY LOOP
    _LIMIT 60 '                                  60 frames per second
    UPDATESCENERY '                              move parallax scenery
    MOVEPIPES '                                  move pipes
    UPDATESCORE '                                display player score
    FLYBIRDIE '                                  move and display bird
    CHECKFORHIT '                                check for bird hits
    IF NOT Paused% THEN '                        is game paused?
        IF BUTTON%(30, 100, PauseButton&) THEN ' no, was pause button pressed?
            Paused% = TRUE '                     yes, place game in pause state
        END IF
    ELSE '                                       no, game is not paused
        IF BUTTON%(30, 100, PlayButton&) THEN '  was play button pressed?
            Paused% = FALSE '                    yes, take game out of pause state
        END IF
    END IF
    _DISPLAY '                                   update screen with changes
    IF _EXIT THEN CLEANUP: SYSTEM '              leave game if user closes game window
LOOP UNTIL HitBird% '                            END GAME PLAY LOOP if bird hits something
DO '                                             BEGIN BIRD DROPPING LOOP
    _LIMIT 60 '                                  60 frames per second
    Paused% = TRUE '                             place game in paused state
    UPDATESCENERY '                              draw parallax scenery
    MOVEPIPES '                                  draw pipes
    Paused% = FALSE '                            take game out of pause state
    FLYBIRDIE '                                  move bird on screen
    _DISPLAY '                                   update screen with changes
    IF _EXIT THEN CLEANUP: SYSTEM '              leave game if user closes game window
LOOP UNTIL Birdie.y >= 546 '                     END BIRD DROPPING LOOP when bird hits ground
SHOWSCORE '                                      display player's score plaque
HitBird% = FALSE '                               reset bird hit indicator

END SUB

'----------------------------------------------------------------------------------------------------------------------

SUB CHECKFORHIT ()

'*
'* Detects if bird hits a pipe.
'*

SHARED Pipes() AS PIPE, Birdie AS INFLIGHT, HitBird%, Smack&

DIM p% ' pipe counter

FOR p% = 1 TO 3 '                                      cycle through all pipe positions
    IF Pipes(p%).x <= 153 AND Pipes(p%).x >= 22 THEN ' is pipe in bird territory?
        IF BOXCOLLISION(105, Birdie.y + 6, 43, 41, Pipes(p%).x, Pipes(p%).y, 78, 432) THEN ' collision?
            HitBird% = TRUE '                          yes, remember bird hit pipe
        END IF
        IF BOXCOLLISION(105, Birdie.y + 6, 43, 41, Pipes(p%).x, Pipes(p%).y + 576, 78, 432) THEN ' collision?
            HitBird% = TRUE '                          yes, remember bird hit pipe
        END IF
    END IF
NEXT p%
IF HitBird% THEN _SNDPLAY Smack& '                     play smack sound if bird hit pipe

END SUB

'----------------------------------------------------------------------------------------------------------------------

SUB RATEGAME ()

'*
'* Allows player to rate game.
'*

SHELL "http://www.qb64.net/forum/index.php?topic=11706.0" ' go to QB64 web site forum area for flappy bird

END SUB

'----------------------------------------------------------------------------------------------------------------------

SUB SHOWSCORE ()

'*
'* Display's current and high scores on score plaque
'*

SHARED Fbird&(), Num&(), Medal&(), FlappyBird&, GameOver&, Plaque&, OKButton&, ShareButton&
SHARED HitBird%, HighScore%, Score%, New&

DIM Ok% '        boolean: TRUE if OK button pressed
DIM Scores%(1) ' current and high scores
DIM sc% '        current score being drawn
DIM x% '         x location of score digits
DIM p% '         digit position counter
DIM ShowNew% '   boolean: TRUE if score is a new high score
DIM s$ '         score in string format

IF Score% > HighScore% THEN '                               is this a new high score?
    OPEN "fbird.sco" FOR OUTPUT AS #1 '                     yes, open score file
    PRINT #1, Score% '                                      save new high score
    CLOSE #1 '                                              close score file
    HighScore% = Score% '                                   remember new high score
    ShowNew% = TRUE '                                       remember this is a new high score
END IF
Scores%(0) = Score% '                                       place score in array
Scores%(1) = HighScore% '                                   place high score in array
Ok% = FALSE '                                               reset OK button status indicator
DO '                                                        BEGIN SCORE LOOP
    _LIMIT 60 '                                             60 frames per second
    IF HitBird% THEN '                                      did bird hit something?
        _PUTIMAGE (75, 200), GameOver& '                    yes, place game over image on screen
    ELSE '                                                  no, bird did not hit anything
        UPDATESCENERY '                                     move parallax scenery
        _PUTIMAGE (40, 200), FlappyBird& '                  place flappy bird title on screen
        _PUTIMAGE (350, 200), Fbird&(2, FLAPTHEBIRD%) '     place flapping bird on screen
    END IF
    _PUTIMAGE (46, 295), Plaque& '                          place plaque on screen
    SELECT CASE HighScore% '                                what is range of high score?
        CASE 25 TO 49 '                                     from 25 to 49
            _PUTIMAGE (85, 360), Medal&(SILVER, LIGHT) '    display a light silver medal
        CASE 50 TO 99 '                                     from 50 to 99
            _PUTIMAGE (85, 360), Medal&(SILVER, DARK) '     display a dark silver medal
        CASE 100 TO 199 '                                   from 100 to 199
            _PUTIMAGE (85, 360), Medal&(GOLD, LIGHT) '      display a light gold medal
        CASE IS > 199 '                                     from 200 and beyond
            _PUTIMAGE (85, 360), Medal&(GOLD, DARK) '       display a dark gold medal
    END SELECT
    FOR sc% = 0 TO 1 '                                      cycle through both scores
        s$ = LTRIM$(RTRIM$(STR$(Scores%(sc%)))) '           convert score to string
        x% = 354 - LEN(s$) * 23 '                           calculate position of score digit
        FOR p% = 1 TO LEN(s$) '                             cycle through score string
            _PUTIMAGE (x%, 346 + sc% * 64), Num&(ASC(MID$(s$, p%, 1)) - 48, LARGE) ' place digit on plaque
            x% = x% + 23 '                                  increment digit position
        NEXT p%
    NEXT sc%
    IF ShowNew% THEN _PUTIMAGE (250, 382), New& '           display red new image if new high score
    IF BUTTON%(64, 535, OKButton&) THEN Ok% = TRUE '        remember if OK button was pressed
    IF BUTTON%(248, 535, ShareButton&) THEN '               was share button pressed?
        SHAREPROGRAM '                                      yes, share program with others
        UPDATESCENERY '                                     draw parallax scenery
        MOVEPIPES '                                         draw pipes
    END IF
    _DISPLAY '                                              update screen with changes
    IF _EXIT THEN CLEANUP: SYSTEM '                         leave game if user closes game window
LOOP UNTIL Ok% '                                            END SCORE LOOP when OK button pressed

END SUB

'----------------------------------------------------------------------------------------------------------------------

SUB SHAREPROGRAM ()

'*
'* Allows player to share program with others
'*

SHARED Fbird&(), FlappyBird&, OKButton&

DIM Message& ' composed message to player's friend(s)
DIM Ok% '      boolean: TRUE if OK button pressed

Message& = _NEWIMAGE(339, 174, 32) '                   create image to hold message to player
_CLIPBOARD$ = "I just discovered a great game! You can download it here: http:\\www.qb64sourcecode.com\fbird.exe"
_PRINTMODE _KEEPBACKGROUND '                           printed text will save background
LINE (58, 307)-(372, 453), _RGB32(219, 218, 150), BF ' clear plaque image
COLOR _RGB32(210, 170, 79) '                           compose message to player on plaque
_PRINTSTRING (66, 316), "The following message has been copied"
COLOR _RGB32(82, 55, 71)
_PRINTSTRING (65, 315), "The following message has been copied"
COLOR _RGB32(210, 170, 79)
_PRINTSTRING (66, 331), "to your computer's clipboard:"
COLOR _RGB32(82, 55, 71)
_PRINTSTRING (65, 330), "to your computer's clipboard:"
COLOR _RGB32(210, 170, 79)
_PRINTSTRING (66, 351), "'I just discovered a great game! You"
COLOR _RGB32(82, 55, 71)
_PRINTSTRING (65, 350), "'I just discovered a great game! You"
COLOR _RGB32(210, 170, 79)
_PRINTSTRING (66, 366), "can download it here:"
COLOR _RGB32(82, 55, 71)
_PRINTSTRING (65, 365), "can download it here:"
COLOR _RGB32(210, 170, 79)
_PRINTSTRING (66, 381), "www.qb64sourcecode.com\fbird.exe'"
COLOR _RGB32(82, 55, 71)
_PRINTSTRING (65, 380), "www.qb64sourcecode.com\fbird.exe'"
COLOR _RGB32(210, 170, 79)
_PRINTSTRING (66, 401), "Create an email for your friends and"
COLOR _RGB32(82, 55, 71)
_PRINTSTRING (65, 400), "Create an email for your friends and"
COLOR _RGB32(210, 170, 79)
_PRINTSTRING (66, 416), "paste this message into it! Go ahead,"
COLOR _RGB32(82, 55, 71)
_PRINTSTRING (65, 415), "paste this message into it! Go ahead,"
COLOR _RGB32(210, 170, 79)
_PRINTSTRING (66, 431), "do it now before you change your mind!"
COLOR _RGB32(82, 55, 71)
_PRINTSTRING (65, 430), "do it now before you change your mind!"
_PUTIMAGE , _DEST, Message&, (46, 295)-(384, 468) '    place message in image
DO '                                                   BEGIN SHARE LOOP
    _LIMIT 60 '                                        60 frames per second
    UPDATESCENERY '                                    move parallax scenery
    _PUTIMAGE (40, 200), FlappyBird& '                 place flappy bird title on screen
    _PUTIMAGE (350, 200), Fbird&(2, FLAPTHEBIRD%) '    place flapping bird on screen
    _PUTIMAGE (46, 295), Message& '                    place message on plaque
    IF BUTTON%(156, 535, OKButton&) THEN Ok% = TRUE '  remeber if OK button pressed
    _DISPLAY '                                         update screen with changes
    IF _EXIT THEN CLEANUP: SYSTEM '                    leave game if user closes game window
LOOP UNTIL Ok% '                                       END SHRE LOOP when OK button pressed
_FREEIMAGE Message& '                                  message image no longer needed

END SUB

'----------------------------------------------------------------------------------------------------------------------

FUNCTION BUTTON% (xpos%, ypos%, Image&)

'*
'* Creates a button on the screen the player can click with the mouse button.
'*
'* xpos%  - x coordinate position of button on screen
'* ypos%  - y coordinate position of button on screen
'* Image& - button image
'*
'* Returns: boolean: TRUE  if button pressed
'*                   FALSE if button not pressed
'*

DIM x% ' current mouse x coordinate
DIM y% ' current mouse y coordinate
DIM b% ' boolean: TRUE if left mouse button pressed

_PUTIMAGE (xpos%, ypos%), Image& '                      place button image on the screen
WHILE _MOUSEINPUT: WEND '                               get latest mouse information
x% = _MOUSEX '                                          get current mouse x coordinate
y% = _MOUSEY '                                          get current mouse y coordinate
b% = _MOUSEBUTTON(1)
IF b% THEN '                                            is left mouse button pressed?
    IF x% >= xpos% THEN '                               yes, is mouse x within lower limit of button?
        IF x% <= xpos% + _WIDTH(Image&) THEN '          yes, is mouse x within upper limit of button?
            IF y% >= ypos% THEN '                       yes, is mouse y within lower limit of button?
                IF y% <= ypos% + _HEIGHT(Image&) THEN ' yes, is mouse y within upper limit of button?
                    BUTTON% = TRUE '                    yes, remember that button was clicked on
                    _DELAY .2 '                         slight delay to allow button to release
                END IF
            END IF
        END IF
    END IF
END IF

END FUNCTION

'----------------------------------------------------------------------------------------------------------------------

SUB UPDATESCENERY ()

'*
'* Updates the moving parallax scenery
'*

SHARED Scenery() AS PARALLAX, Clean&, HazardBar&, Paused%

DIM c% ' scenery index indicator

_PUTIMAGE , Clean& '                                              clear screen with clean image
DO '                                                              BEGIN SCENERY LOOP
    c% = c% + 1 '                                                 increment index value
    IF NOT Paused% THEN '                                         is game in paused state?
        Scenery(c%).frame = Scenery(c%).frame + 1 '               no, update frame counter of current scenery
        IF Scenery(c%).frame = Scenery(c%).fmax THEN '            frame counter hit limit?
            Scenery(c%).frame = 0 '                               yes, reset frame counter
            Scenery(c%).x = Scenery(c%).x - 1 '                   move scenery 1 pixel to left
            IF Scenery(c%).x = -432 THEN '                        scenery hit lower limit?
                Scenery(c%).x = 0 '                               yes, reset scenery to start position
            END IF
        END IF
    END IF
    _PUTIMAGE (Scenery(c%).x, Scenery(c%).y), Scenery(c%).image ' place current scenery on screen
LOOP UNTIL c% = 3 '                                               END SCENERY LOOP when all scenery updated
IF NOT Paused% THEN '                                             is game in paused state?
    Scenery(4).x = Scenery(4).x - 3 '                             no, move hazard bar 3 pixels to left
    IF Scenery(4).x = -21 THEN Scenery(4).x = 0 '                 reset to start position if lower limit hit
END IF
_PUTIMAGE (Scenery(4).x, Scenery(4).y), HazardBar& '              place hazard bar on screen

END SUB

'----------------------------------------------------------------------------------------------------------------------

SUB LOADASSETS ()

'*
'* Loads game graphics, sounds and initial settings.
'*

SHARED Scenery() AS PARALLAX, Birdie AS INFLIGHT, Pipes() AS PIPE, Pipe&(), Fbird&()
SHARED Num&(), Medal&(), Plaque&, FlappyBird&, GameOver&, GetReady&, Finger&
SHARED ScoreButton&, ShareButton&, StartButton&, OKButton&, RateButton&, MenuButton&
SHARED PlayButton&, PauseButton&, HazardBar&, Clouds&, City&, Bushes&, New&, Clean&
SHARED HighScore%, PipeImage&, Ding&, Flap&, Smack&

DIM Sheet& '    sprite sheet image
DIM x% '        generic counter
DIM y% '        generic counter
DIM PipeTop& '  temporary top of pipe image
DIM PipeTube& ' temporary pipe tube image

Ding& = _SNDOPEN("fbding.ogg", "VOL,SYNC") '         load game sounds
Flap& = _SNDOPEN("fbflap.ogg", "VOL,SYNC")
Smack& = _SNDOPEN("fbsmack.ogg", "VOL,SYNC")
Sheet& = _LOADIMAGE("fbsheet.png", 32) '             load sprite sheet
FOR y% = 0 TO 2 '                                          cycle through bird image rows
    FOR x% = 0 TO 7 '                                      cycle through bird image columns
        Fbird&(x% + 1, y% + 1) = _NEWIMAGE(53, 53, 32) '   create image holder then get image
        _PUTIMAGE , Sheet&, Fbird&(x% + 1, y% + 1), (x% * 53, y% * 53)-(x% * 53 + 52, y% * 53 + 52)
    NEXT x%
NEXT y%
FOR x% = 0 TO 9 '                                          cycle trough 9 numeral images
    Num&(x%, 0) = _NEWIMAGE(21, 30, 32) '                  create image holder for big
    Num&(x%, 1) = _NEWIMAGE(18, 21, 32) '                  create image holder for small
    _PUTIMAGE , Sheet&, Num&(x%, 0), (x% * 21, 159)-(x% * 21 + 20, 188) ' get images
    _PUTIMAGE , Sheet&, Num&(x%, 1), (x% * 18 + 210, 159)-(x% * 18 + 227, 179)
NEXT x%
Plaque& = _NEWIMAGE(339, 174, 32) '                        define remaining image sizes
FlappyBird& = _NEWIMAGE(288, 66, 32)
GameOver& = _NEWIMAGE(282, 57, 32)
GetReady& = _NEWIMAGE(261, 66, 32)
PipeTop& = _NEWIMAGE(78, 36, 32)
PipeTube& = _NEWIMAGE(78, 36, 32)
Pipe&(0) = _NEWIMAGE(78, 432, 32)
Pipe&(1) = _NEWIMAGE(78, 432, 32)
PipeImage& = _NEWIMAGE(432, 596, 32)
Medal&(0, 0) = _NEWIMAGE(66, 66, 32)
Medal&(0, 1) = _NEWIMAGE(66, 66, 32)
Medal&(1, 0) = _NEWIMAGE(66, 66, 32)
Medal&(1, 1) = _NEWIMAGE(66, 66, 32)
Finger& = _NEWIMAGE(117, 147, 32)
ScoreButton& = _NEWIMAGE(120, 42, 32)
ShareButton& = _NEWIMAGE(120, 42, 32)
StartButton& = _NEWIMAGE(120, 42, 32)
OKButton& = _NEWIMAGE(120, 42, 32)
RateButton& = _NEWIMAGE(120, 42, 32)
MenuButton& = _NEWIMAGE(120, 42, 32)
PlayButton& = _NEWIMAGE(39, 42, 32)
PauseButton& = _NEWIMAGE(39, 42, 32)
HazardBar& = _NEWIMAGE(462, 24, 32)
Clouds& = _NEWIMAGE(864, 120, 32)
City& = _NEWIMAGE(864, 57, 32)
Bushes& = _NEWIMAGE(864, 27, 32)
New& = _NEWIMAGE(48, 21, 32)
_PUTIMAGE , Sheet&, Plaque&, (0, 189)-(338, 362) '         grab images from sprite sheet
_PUTIMAGE , Sheet&, FlappyBird&, (0, 363)-(287, 428)
_PUTIMAGE , Sheet&, GameOver&, (588, 246)-(869, 302)
_PUTIMAGE , Sheet&, GetReady&, (588, 303)-(847, 368)
_PUTIMAGE , Sheet&, Medal&(0, 0), (339, 327)-(404, 392)
_PUTIMAGE , Sheet&, Medal&(0, 1), (405, 327)-(470, 392)
_PUTIMAGE , Sheet&, Medal&(1, 0), (339, 261)-(404, 326)
_PUTIMAGE , Sheet&, Medal&(1, 1), (405, 261)-(470, 326)
_PUTIMAGE , Sheet&, Finger&, (471, 246)-(587, 392)
_PUTIMAGE , Sheet&, ScoreButton&, (288, 417)-(407, 458)
_PUTIMAGE , Sheet&, ShareButton&, (408, 417)-(527, 458)
_PUTIMAGE , Sheet&, StartButton&, (528, 417)-(647, 458)
_PUTIMAGE , Sheet&, OKButton&, (424, 204)-(543, 245)
_PUTIMAGE , Sheet&, RateButton&, (544, 204)-(663, 245)
_PUTIMAGE , Sheet&, MenuButton&, (664, 204)-(783, 245)
_PUTIMAGE , Sheet&, PlayButton&, (784, 204)-(822, 245)
_PUTIMAGE , Sheet&, PauseButton&, (823, 204)-(861, 245)
_PUTIMAGE , Sheet&, HazardBar&, (288, 393)-(749, 416)
_PUTIMAGE (0, 0)-(431, 119), Sheet&, Clouds&, (424, 0)-(855, 119)
_PUTIMAGE (432, 0)-(863, 119), Sheet&, Clouds&, (424, 0)-(855, 119)
_PUTIMAGE (0, 0)-(431, 56), Sheet&, City&, (424, 120)-(855, 176)
_PUTIMAGE (432, 0)-(863, 56), Sheet&, City&, (424, 120)-(855, 176)
_PUTIMAGE (0, 0)-(431, 26), Sheet&, Bushes&, (424, 177)-(855, 203)
_PUTIMAGE (432, 0)-(863, 26), Sheet&, Bushes&, (424, 177)-(855, 203)
_PUTIMAGE , Sheet&, New&, (289, 363)-(336, 383)
_PUTIMAGE , Sheet&, PipeTop&, (339, 189)-(416, 224)
_PUTIMAGE , Sheet&, PipeTube&, (339, 225)-(416, 260)
_PUTIMAGE (0, 431)-(77, 395), PipeTop&, Pipe&(0) '         create bottom of upper tube image
_PUTIMAGE (0, 0), PipeTop&, Pipe&(1) '                     create top of lower tube image
FOR y% = 0 TO 395 STEP 36 '                                cycle through tube body of pipes
    _PUTIMAGE (0, y% + 35)-(77, y%), PipeTube&, Pipe&(0) ' draw tube on upper pipe image
    _PUTIMAGE (0, 36 + y%), PipeTube&, Pipe&(1) '          draw tube on lower pipe image
NEXT y%
_FREEIMAGE PipeTop& '                                      temporary image no longer needed
_FREEIMAGE PipeTube& '                                     temporary image no longer needed
_FREEIMAGE Sheet& '                                        sprite sheet no longer needed
Clean& = _NEWIMAGE(432, 768, 32) '                         create clean image holder
_DEST Clean& '                                             work on clean image
CLS , _RGB32(84, 192, 201) '                               clear image with sky blue color
LINE (0, 620)-(431, 767), _RGB32(219, 218, 150), BF '      create brown ground portion of image
LINE (0, 577)-(431, 595), _RGB32(100, 224, 117), BF '      create green grass portion of image
_DEST 0 '                                                  back to work on screen
Scenery(1).image = Clouds& '                               set scenery parallax information
Scenery(1).y = 457
Scenery(1).fmax = 8
Scenery(2).image = City&
Scenery(2).y = 510
Scenery(2).fmax = 4
Scenery(3).image = Bushes&
Scenery(3).y = 550
Scenery(3).fmax = 2
Scenery(4).image = HazardBar&
Scenery(4).y = 596
IF _FILEEXISTS("fbird.sco") THEN '                         does high score file exist?
    OPEN "fbird.sco" FOR INPUT AS #1 '                     yes, open high score file
    INPUT #1, HighScore% '                                 get high score from file
    CLOSE #1 '                                             close high score file
END IF

END SUB

'----------------------------------------------------------------------------------------------------------------------

FUNCTION BOXCOLLISION% (Box1X%, Box1Y%, Box1Width%, Box1Height%, Box2X%, Box2Y%, Box2Width%, Box2Height%)

'**
'** Detects if two bounding box areas are in collision
'**
'** INPUT : Box1X%      - upper left corner X location of bounding box 1
'**         Box1Y%      - upper left corner Y location of bounding box 1
'**         Box1Width%  - the width of bounding box 1
'**         Box1Height% - the height of bounding box 1
'**         Box2X%      - upper left corner X location of bounding box 2
'**         Box2Y%      - upper left corner Y location of bounding box 2
'**         Box2Width%  - the width of bounding box 2
'**         Box2Height% - the height of bounding box 2
'**
'** OUTPUT: BOXCOLLISION - 0 (FALSE) for no collision, -1 (TRUE) for collision
'**

IF Box1X% <= Box2X% + Box2Width% - 1 THEN '              is box1 x within lower limit of box2 x?
    IF Box1X% + Box1Width% - 1 >= Box2X% THEN '          yes, is box1 x within upper limit of box2 x?
        IF Box1Y% <= Box2Y% + Box2Height% - 1 THEN '     yes, is box1 y within lower limit of box2 y?
            IF Box1Y% + Box1Height% - 1 >= Box2Y% THEN ' yes, is box1 y within upper limit of box2 y?
                BOXCOLLISION% = TRUE '                   yes, then a collision occured, return result
            END IF
        END IF
    END IF
END IF

END FUNCTION

'----------------------------------------------------------------------------------------------------------------------

SUB CLEANUP ()

'*
'* Removes all game assets from the computer's RAM.
'*

SHARED Fbird&(), Pipe&(), Num&(), Medal&(), Plaque&, FlappyBird&, GameOver&, GetReady&
SHARED Finger&, ScoreButton&, ShareButton&, StartButton&, OKButton&, RateButton&
SHARED MenuButton&, PlayButton&, PauseButton&, HazardBar&, Clouds&, City&, Bushes&
SHARED New&, Clean&, PipeImage&, Ding&, Flap&, Smack&

DIM x% '              generic counter
DIM y% '              generic counter

_SNDCLOSE Ding& '                           remove game sounds from RAM
_SNDCLOSE Flap&
_SNDCLOSE Smack&
FOR y% = 0 TO 2 '                           cycle through bird image rows
    FOR x% = 0 TO 7 '                       cycle through bird image columns
        _FREEIMAGE Fbird&(x% + 1, y% + 1) ' remove bird image from RAM
    NEXT x%
NEXT y%
FOR x% = 0 TO 9 '                           cycle trough 9 numeral images
    _FREEIMAGE Num&(x%, 0) '                remove large numeral image from RAM
    _FREEIMAGE Num&(x%, 1) '                remove small numeral image from RAM
NEXT x%
_FREEIMAGE Plaque& '                        remove all remaining images from RAM
_FREEIMAGE FlappyBird&
_FREEIMAGE GameOver&
_FREEIMAGE GetReady&
_FREEIMAGE Pipe&(0)
_FREEIMAGE Pipe&(1)
_FREEIMAGE PipeImage&
_FREEIMAGE Medal&(0, 0)
_FREEIMAGE Medal&(0, 1)
_FREEIMAGE Medal&(1, 0)
_FREEIMAGE Medal&(1, 1)
_FREEIMAGE Finger&
_FREEIMAGE ScoreButton&
_FREEIMAGE ShareButton&
_FREEIMAGE StartButton&
_FREEIMAGE OKButton&
_FREEIMAGE RateButton&
_FREEIMAGE MenuButton&
_FREEIMAGE PlayButton&
_FREEIMAGE PauseButton&
_FREEIMAGE HazardBar&
_FREEIMAGE Clouds&
_FREEIMAGE City&
_FREEIMAGE Bushes&
_FREEIMAGE New&
_FREEIMAGE Clean&

END SUB

'----------------------------------------------------------------------------------------------------------------------

