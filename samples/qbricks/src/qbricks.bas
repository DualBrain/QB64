'                                QBRICKS.BAS
'
'         Copyright (C) 1990 Microsoft Corporation. All Rights Reserved.
'
' Score points in QBricks by deflecting the ball into the brick walls.
' Hit the special bricks or clear all the bricks to advance to the next
' level.
'
' To run this game, press Shift+F5.
'
' To exit this program, press Alt, F, X.
'
' To get help on a BASIC keyword, move the cursor to the keyword and press
' F1 or click the right mouse button.
'
' To view suggestions on changing this game, press Page Down.
'
'
'                             Suggested Changes
'                             -----------------
'
' There are many ways that you can modify this BASIC game.  The CONST
' statements below these comments and the DATA statements at the end
' of this screen can be modified to change the following:
'    Block patterns
'    Length of paddles
'    Number of special bricks
'    Shape of the special bricks
'    End-of-level bonus multiplier
'    Paddle color
'    Ball color
'    Ball speed
'
' On the right side of each CONST statement, there is a comment that tells
' you what it does and how large or small you can set the value.  Above the
' DATA statements, there are comments that tell you the format of the
' information stored there.
'
' On your own, you can also add exciting sounds and visual effects or make any
' other changes that your imagination can dream up.  By reading the
' "Learn BASIC Now" book, you'll learn the techniques that will enable you
' to fully customize this game and to create games of your own.
'
'
' If the game won't run after you have changed it, you can exit without
' saving your changes by pressing Alt, F, X and choosing NO.
'
' If you do want to save your changes, press Alt, F, A and enter a filename
' for your version of the program.  Before you save your changes, however,
' you should make sure they work by running the program and verifying that
' your changes produce the desired results.  Also, always be sure to keep
' a backup of the original program.
'
DefInt A-Z

Const INITIALBALLSPEED = .07 ' Initial speed of the ball in seconds.  Range 0 (fastest) - .20 (slowest)
Const BALLCOLOR = 12 ' Ball color.  Ranges from 1 to 15 but not BGCOLOR.
Const BGCOLOR = 0 ' Background color of the game.  Range 0 to 7.
Const PLAYERCOLOR1 = 2 ' Paddle color for player 1.  Range 1 to 15 but not BGCOLOR.
Const PLAYERCOLOR2 = 3 ' Paddle color for player 2.  Range 1 to 15 but not BGCOLOR.
Const PADDLELENGTH1 = 50 ' Starting paddle length for player 1.  Range 24 to 240.
Const PADDLELENGTH2 = 50 ' Starting paddle length for player 2.  Range 24 to 120.
Const NUMSPECIALBRICKS = 1 ' Number of special bricks in each level.  Range 0 to 50. Higher numbers make the game easier.
Const SPECIALCHAR = 14 ' ASCII value of the special character.  14 is a musical note.  Try 3 for a heart or 2 for a smiley face.
Const BONUSMULTIPLIER = 500 ' Minimum bonus amount for each round.  Range 0 to 1000 in increments of 100.
Const PADDLEHORIZONTALMOVE = 24 ' Number of spaces paddle moves left or right each time the left or right key is pressed.  Range 1 to 30.
Const INITNUMBALLS = 3 ' Initial number of balls.  Range 1 to 50.
Const LEVELNEWBALL = 3 ' Level interval at which an extra ball is awarded.
Const CUTLEVEL = 6 ' Level interval at which the paddle size is reduced.  Range 2 to 10.
Const PADDLECUT = 33 ' The percent that the paddle will be reduced by.  Range 0 to 99. For example, at 33, a paddle that is 50 pixels wide will become 33 pixels wide.
Const DEFAULTPLAYERS = 1 ' Default number of players.  Range 1 or 2.
' The following sound constants are used by the PLAY command to
' produce music during the game.  To change the sounds you hear, change
' these constants.  Refer to the online help for PLAY for the correct format.
' To completely remove sound from the game set the constants equal to null.
' For example:  STARTSOUND = ""
Const STARTSOUND = "MBT180O2L8CDEDCDFECDCL4EL8C" ' Music played when QBricks begins.
Const PADDLEHITSOUND = "MBT120 L64 o3 g" ' Music played when the ball hits the paddle.
Const BLOCKHITSOUND = "MB T255 L8 o" ' Music played when the ball hits a brick.
Const NEXTLEVELSOUND = "MB T240 L2 N30 N34 N38 N45" ' Music played between levels.
Const GAMEOVERSOUND = "T255 L16 O3 C O2 GEDC" ' Music played when the game is over.

' The following are general constants and their values should not be changed.
Const TRUE = -1 ' QuickBASIC Interpreter uses -1 to mean TRUE.
Const FALSE = 0 ' 0 means FALSE.
Const PADDLEVERTICALMOVE = 4 ' Distance paddle moves up or down each time the Up key or Down key is pressed.
Const MAXLEVEL = 5 ' Level when the brick patterns start over.
Const SCREENWIDTH = 40 ' Maximum width of the screen in characters.
Const SCORECOLOR = 15 ' Color of the players' scores, level number and balls left displayed at the bottom of the screen.
Const MAXBLOCKROW = 9 ' Lowest row that has bricks on it.
Const STARTBRICKROW = 2 ' Highest row with bricks on it.
Const BRICKSIZE = 2 ' Width of a brick in character-sized units.
Const PIXELSIZE = 8 ' Number of pixels per brick.
Const MAXROW = 184 ' The highest (in pixels) a paddle can move.
Const MINROW = (MAXBLOCKROW + 2) * 8 ' The lowest (in pixels) a paddle can move.
Const UP1 = 104 ' ASCII code for UP key - Up for player 1.
Const DOWN1 = 112 ' ASCII code for DOWN key - Down for player 1.
Const LEFT1 = 107 ' ASCII code for LEFT key - Left for player 1.
Const RIGHT1 = 109 ' ASCII code for RIGHT key - Right for player 1.
Const UP2 = 101 ' ASCII code for e - Up for player 2.
Const LEFT2 = 115 ' ASCII code for s - Left for player 2.
Const RIGHT2 = 102 ' ASCII code for f - Right for player 2.
Const DOWN2 = 100 ' ASCII code for d - Down for player 2.
Const PAUSE = 112 ' ASCII code for p - Pause.
Const QUIT = 113 ' ASCII code for q - Quit.

' DECLARE statements tell the main program that subprograms and functions
'  exist and defines what data types they use.
DECLARE SUB BallHitPaddle (Player)                  ' Checks to see if the ball hit a paddle.  If it did, deflect the ball.
DECLARE SUB Center (text$, Row)                     ' Centers a line of text on a given row.
DECLARE SUB DisplayChanges ()                       ' Shows what changes can be made to this program.
DECLARE SUB DisplayGameTitle ()                     ' Displays the title of the game.
DECLARE SUB DisplayIntro ()                         ' Shows how to play the game.  Used at the start of the game or when the Help key is pressed.
DECLARE SUB DrawBall (BallX, BallY)                 ' Draws or erases the ball.
DECLARE SUB DrawBrick (BrickX, BrickY, BrickColor)  ' Draws or erases a brick.
DECLARE SUB DrawPaddle (PColor, PlayerNum)          ' Draws or erases a paddle.
DECLARE SUB EraseBall (X, Y)                        ' Erases the ball.
DECLARE SUB EraseBrick (X, Y)                       ' Erases a brick after the ball hits it.  The brick is physically erased by the DrawBrick subprogram.
DECLARE SUB GameOver ()                             ' Checks to see if the game is over.  If it is, ask player if he/she wants to play again.
DECLARE SUB GameParamSetup ()                       ' Determine the speed of the computer, set the graphics mode, etc.
DECLARE SUB GetGameOptions ()                       ' Asks for the number of players.
DECLARE SUB HorizontalScroll (display$, Row)        ' Generic subprogram to move a line of text across the screen.
DECLARE SUB MovePaddle (NewX, NewY, PlayerNum)      ' Moves the paddle(s).  Checks that paddles do not overlap and that paddle is completely on the screen.
DECLARE SUB NewBall ()                              ' Launches a new ball at the start of the game, between levels, or after a ball passes the paddles.
DECLARE SUB NextLevel ()                            ' Adds bonus points, draws new brick pattern, etc. after each level is complete.
DECLARE SUB RedrawPaddles ()                        ' Redraws the paddle(s).
DECLARE SUB SetDefaultPaddle ()                     ' Positions the paddle(s) to initial point.
DECLARE SUB UpdateScreen ()                         ' Redraws the score and levels.  Used after a brick is hit or bonus points awarded.

' Structure used for the paddles and the ball.
Type PositionType
    X As Integer ' Horizontal (X) position of the paddle, in pixels.
    Y As Integer ' Vertical (Y) position of the paddle, in pixels.
    OldX As Integer ' Last X position.  Used to erase the paddle or ball.
    OldY As Integer ' Last Y position.  Used to erase the paddle or ball.
    Size As Integer ' Size of the paddles.
    PColor As Integer ' Color of the ball or the paddle.
    XOffset As Integer ' Increment of horizontal ball movement.
    YOffset As Integer ' Increment of vertical ball movement.
    speed As Single ' Interval, in seconds, between actual ball movements.
    Score As Long ' Score for each player.
    NumBricksHit As Integer ' Number of bricks each player has hit.
End Type

' DIM SHARED indicates that a variable is available to all subprograms.
' Without this statement, a variable used in one subprogram cannot be
' used by another subprogram or the main program.
Dim Shared TempPADDLELENGTH As Integer ' Keeps the true length of the paddle.
Dim Shared ScreenMode As Integer ' Graphics screen mode used.
Dim Shared ScreenWide As Integer ' Width of the screen in characters
Dim Shared GraphicsWidth As Integer ' Width of the screen in pixels.
Dim Shared UsableWidth As Integer ' GraphicsWidth after assuming a small border around the screen.
Dim Shared Ball As PositionType ' Variable for the ball.
Dim Shared Bricks(25, 20) As Integer ' Array to represent all of the bricks on the screen.  The values determine brick color.  Blank spaces are filled with the background color (BgColor).
Dim Shared NumBalls As Integer ' Number of balls left.
Dim Shared Again As Integer ' Flag used to decide if the game should continue.
Dim Shared NeedBall As Integer ' Flag used to determine if a new ball is needed?
Dim Shared Level As Integer ' Current play level.
Dim Shared LevelCount As Long ' Number of bricks hit in the current level.
Dim Shared MAXLEVELCount As Long ' Maximum number of bricks in the current level.
Dim Shared TimeToMoveBall As Single ' Interval, in seconds, between ball movements.
Dim Shared special As String ' Special character.
Dim Shared JustHit As Integer ' Flag used to see if ball hit a paddle so the same paddle cannot hit the ball again until it hits the other paddle, a brick, or bounces off the top.
Dim Shared NumberOfPlayers As Integer ' Number of players.
Dim Shared LastHitBy As Integer ' Which player hit the ball last.
Dim Shared LevelOver As Integer ' Flag that is TRUE when a level is completed.
Dim Shared ActualBallSpeed As Single ' Initial ball speed after determining the machine speed.
Dim Shared Ballshape(20) As Integer ' Array in which the ball image is stored.
Dim Shared EraseBallOK As Integer ' Flag to decide if the ball's last position should be erased.
Dim Shared LastX As Integer ' Flag that determines if the ball has just deflected horizontally off a brick.
Dim Shared LastY As Integer ' Flag that determines if the ball has just deflected vertically off a brick.
Dim BadMode As Integer ' Flag used to determine which graphics mode to use.
Dim KeyFlags As Integer ' Holds the status of various keys, including Num Lock.

Randomize Timer ' Seed the random number generator.

special = "" ' Build the string used to display the special bricks.
For X = 1 To BRICKSIZE
    special = special + Chr$(SPECIALCHAR) ' Add the SPECIALCHAR to the string.
Next X ' Repeat until the loop is done BRICKSIZE times.

' Determine which graphics mode to use.
On Error GoTo ScreenError ' Set up a place to jump to if an error occurs in the program.
BadMode = FALSE ' Assume that the graphics mode is okay.
ScreenMode = 7 ' Set mode to 7 (an EGA mode).
Screen ScreenMode ' Attempt SCREEN 7.
If BadMode = TRUE Then ' If this attempt failed:
    ScreenMode = 1 ' try mode 1 (a CGA mode),
    BadMode = FALSE ' assume that graphics mode is okay,
    Screen ScreenMode ' attempt SCREEN 1.
End If
On Error GoTo 0 ' Turn off error handling.

If BadMode = TRUE Then ' If no graphics adapter...
    Cls
    Locate 11, 13: Print "CGA, EGA Color, or VGA graphics required to run QBRICKS.BAS"
Else
    Def Seg = 0 ' Save the keyboard flags but force them all off for this game.
    KeyFlags = Peek(1047) ' Read the location that stores the keyboard flag.
    Poke 1047, &H0 ' Force them off.
    Def Seg ' Restore the default segment.

    DisplayIntro ' Display the introduction screen now.
    GetGameOptions ' Ask how many players.

    Dim Shared Paddle(NumberOfPlayers) As PositionType ' Array used to represent the paddles.
    Level = 0 ' Start at the first level
    Again = TRUE ' Set the flag used to continue the game.
    NextLevel ' Set up the next level.
    
    Do
        'The code below moves the ball.
        If Timer >= TimeToMoveBall Then ' Time to move the ball again?
            TimeToMoveBall = Timer + Ball.speed ' Decide when to move the ball again.
            LevelOver = FALSE ' Flag that is false unless a level has just been cleared.
            DeflectY = FALSE ' Flag that determines if the ball's vertical direction (Y) should be reversed.
            DeflectX = FALSE

            Ball.X = Ball.X + Ball.XOffset ' Updates the ball's horizontal and vertical location.
            Ball.Y = Ball.Y + Ball.YOffset
 
            ' Horizontally off the screen?
            If Ball.X < 4 Or Ball.X > UsableWidth Then
                DeflectX = TRUE
                LastX = FALSE
                LastY = FALSE
            End If

            ' At the top of the screen?
            If Ball.Y < 4 Then
                DeflectY = TRUE ' Deflect the ball
                JustHit = FALSE ' Allow a paddle to hit the ball
                LastX = FALSE
                LastY = FALSE
            ElseIf Ball.Y > MAXROW Then GameOver 'If not, did the ball just pass the lowest point that the paddles can go?
            End If

            BallX = Ball.X \ 16 ' Determines where the ball is relative to the bricks (20 bricks fit on the 320 pixel screen so each brick is 16 pixels wide).
            BallY = Ball.Y \ 8 ' Similar to above but for the Y direction.  The screen is 200 pixels high.
  
            LevelOver = FALSE ' Assume that the level is not over yet.
  
            If Bricks(BallY, BallX) <> BGCOLOR Then ' Hit a brick?
                ' Yes.  Hit a brick.
                If EraseBallOK Then DrawBall Ball.OldX, Ball.OldY ' Erase the ball.
                EraseBrick BallX, BallY ' Erase the brick.
                EraseBallOK = FALSE ' Since the new ball location was never drawn, EraseBallOK must be FALSE to keep the game from trying to erase it.
                WhereX = Ball.X Mod 16 ' Horizontal position within the brick.
               
                ' If the ball hits the left or right edge, try to bounce by
                '  changing the horizontal offset.  If that just happened,
                '  change the vertical offset instead.
                If (Not LastX And (WhereX = 0 Or WhereX = 12)) Or LastY Then
                    DeflectX = TRUE ' Change X direction.
                    LastX = TRUE ' Mark last deflection as in the X direction.
                Else ' If the ball hit the middle of a block...
                    DeflectY = TRUE ' Change Y direction.
                    LastY = TRUE ' Mark last deflection as in the Y direction.
                End If
            Else
                If EraseBallOK Then DrawBall Ball.OldX, Ball.OldY ' Erase the old position of the ball unless another part of the program said not to erase it.
                DrawBall Ball.X, Ball.Y ' Draw ball in the new location.
                Ball.OldX = Ball.X ' Update the old X and Y positions.
                Ball.OldY = Ball.Y
                EraseBallOK = TRUE ' Assume that it is okay to delete the ball next time.
                LastX = FALSE ' Reset LastX and LastY so they'll be clear next time.
                LastY = FALSE
            End If
           
            ' The FOR...NEXT loop below tests to see if the new ball position
            ' has hit a paddle.  If so, update ball and paddle.
            For Player = 1 To NumberOfPlayers
                BallHitPaddle Player
            Next Player

            ' Change the direction of the ball as appropriate.
            If DeflectY And Not LevelOver Then Ball.YOffset = -Ball.YOffset
            If DeflectX Then Ball.XOffset = -Ball.XOffset
        End If
    
        k$ = InKey$ ' Get keypress.
 
        If Len(k$) > 0 Then ' Only execute the code below if a key was pressed.
            If Asc(k$) = 0 Then ' This returns the ASC code of the left-most character in the string.  It is 0 if the key was an extended ASCII key - like the cursor keys.
                Select Case Asc(LCase$(Right$(k$, 1))) ' Use the right-most character to decide what key was pressed.
                    Case LEFT1
                        MovePaddle -PADDLEHORIZONTALMOVE, 0, 1
                    Case RIGHT1
                        MovePaddle PADDLEHORIZONTALMOVE, 0, 1
                    Case UP1
                        MovePaddle 0, -PADDLEVERTICALMOVE, 1
                    Case DOWN1
                        MovePaddle 0, PADDLEVERTICALMOVE, 1
                End Select
            Else ' The first character was not ASCII 0 so the key was a normal letter or number.
                If NumberOfPlayers = 2 Then ' Only execute if two people are playing.
                    Select Case Asc(LCase$(Right$(k$, 1))) ' Use the ASCII value to evaluate which key was pressed.
                        Case LEFT2 ' The letter s.
                            MovePaddle -PADDLEHORIZONTALMOVE, 0, 2
                        Case RIGHT2 ' The letter f.
                            MovePaddle PADDLEHORIZONTALMOVE, 0, 2
                        Case UP2 ' The letter e.
                            MovePaddle 0, -PADDLEVERTICALMOVE, 2
                        Case DOWN2 ' The letter d.
                            MovePaddle 0, PADDLEVERTICALMOVE, 2
                    End Select
                End If
                Select Case Asc(LCase$(Right$(k$, 1))) 'Regardless of the number of players, check for Quit and Pause.
                    Case PAUSE
                        If ScreenMode <> 1 Then Color 12 + BACKGROUNDCOLOR ' Change colors.

                        Sound 1100, .75 ' Tone at 1100 hertz for 75 clock ticks.
                        Center "* PAUSED *", MINROW \ 8 + 2 ' Display pause message.
                        While InKey$ = "": Wend ' Wait for a keypress.

                        Color BGCOLOR ' Restore normal colors.
                        Center Space$(10), MINROW \ 8 + 2

                        ' Ensures that the ball isn't duplicated if it is directly under the "* PAUSED *" text.
                        If EraseBallOK Then
                            EraseBall Ball.X, Ball.Y
                            DrawBall Ball.X, Ball.Y
                        End If

                        RedrawPaddles ' Draw the paddles again in case the PAUSED message overwrote them.
                    Case QUIT
                        If ScreenMode = 1 Then ' Set the correct color scheme.
                            Color BGCOLOR
                        Else
                            Color 3 + BGCOLOR, BGCOLOR
                        End If

                        Sound 1700, 1 ' Tone at 1700 hertz for 1 clock tick.
                        Sound 1100, .75 ' Tone at 1100 hertz for .75 clock ticks.
                        Center "Really quit? (Y/N) ", (MINROW \ 8 + 2) ' Display prompt.
                        Do
                            k$ = UCase$(InKey$) ' Wait for desired key to be pressed.
                        Loop While k$ = ""
                        Center Space$(19), (MINROW \ 8 + 2) ' Clear prompt off of the screen.

                        If k$ = "Y" Then ' Does player want to quit?
                            Again = FALSE ' Set Again (for ' PLAY AGAIN' ) so that the game will not restart.
                            NumBalls = -1 ' Set number of balls to ending amount.
                        End If

                        ' Ensures that the ball isn't duplicated if it is directly under the "Really Quit? (Y/N)" text.
                        If EraseBallOK Then
                            EraseBall Ball.X, Ball.Y
                            DrawBall Ball.X, Ball.Y
                        End If

                        RedrawPaddles ' Draw paddles again.
                End Select
            End If
        End If
       
        If NeedBall Then ' See if a new ball is needed.
            NeedBall = FALSE ' Reset flag.
            NewBall ' Launch a new ball.
        End If
    Loop While Again
    
    DisplayChanges ' Display suggested changes screen.
    
    Def Seg = 0 ' Restore the previous flag settings.
    Poke 1047, KeyFlags
    Def Seg ' Restore the default segment.

End If

End


' The following is the data for all 5 of the brick patterns used in the game.
' The data for each pattern must be 7 rows by 20 columns (delimited by commas).
' A "0" is used for a blank brick.  Any other number represents a color
' code for that brick (range 1 - 15).

' Data for Screen 1
Data 4,5,3,3,3,3,0,0,0,0,0,0,0,0,3,3,3,3,5,4
Data 0,4,5,3,3,3,2,2,0,0,0,0,2,2,3,3,3,5,4,0
Data 0,0,4,5,3,3,3,2,3,0,0,3,2,3,3,3,5,4,0,0
Data 0,0,4,5,3,3,3,3,3,3,3,3,3,3,3,3,5,4,0,0
Data 0,0,0,0,4,5,5,3,3,3,3,3,5,5,5,4,0,0,0,0
Data 0,0,0,0,0,0,4,5,5,3,3,5,5,4,0,0,0,0,0,0
Data 0,0,0,0,0,0,0,4,4,4,4,4,4,0,0,0,0,0,0,0

' Data for Screen 2
Data 1,1,1,1,1,0,0,0,1,1,1,1,0,0,0,1,1,1,1,1
Data 9,9,9,9,9,0,0,0,9,9,9,9,0,0,0,9,9,9,9,9
Data 5,5,5,5,5,0,0,0,5,5,5,5,0,0,0,5,5,5,5,5
Data 13,13,13,13,13,0,0,0,13,13,13,13,0,0,0,13,13,13,13,13
Data 3,3,3,3,3,0,0,0,3,3,3,3,0,0,0,3,3,3,3,3
Data 11,11,11,11,11,0,0,0,11,11,11,11,0,0,0,11,11,11,11,11
Data 11,11,11,11,11,0,0,0,11,11,11,11,0,0,0,11,11,11,11,11

' Data for Screen 3
Data 1,1,8,8,8,1,1,0,0,5,5,0,0,1,1,8,8,8,1,1
Data 5,1,1,8,1,1,5,0,0,5,5,0,0,5,1,1,8,1,1,5
Data 0,5,1,1,1,5,0,0,5,5,5,5,0,0,5,1,1,1,5,0
Data 0,5,5,1,5,5,0,0,5,1,1,5,0,0,5,5,1,5,5,0
Data 0,0,5,1,5,0,0,5,5,1,1,5,5,0,0,5,1,5,0,0
Data 0,0,0,5,0,0,0,5,1,8,8,1,5,0,0,0,5,0,0,0
Data 0,0,0,5,0,0,1,1,8,8,8,8,1,1,0,0,5,0,0,0

' Data for Screen 4
Data 5,2,14,9,0,0,0,0,9,14,14,9,0,0,0,0,9,14,2,5
Data 5,5,2,14,14,0,0,14,14,2,2,14,14,0,0,14,14,2,5,5
Data 0,5,5,2,2,9,9,2,2,9,9,2,2,9,9,2,2,5,5,0
Data 0,0,5,5,5,5,5,9,9,5,5,9,9,5,5,5,5,5,0,0
Data 0,5,5,2,2,9,9,2,2,9,9,2,2,9,9,2,2,5,5,0
Data 5,5,2,14,14,0,0,14,14,2,2,14,14,0,0,14,14,2,5,5
Data 5,2,14,9,0,0,0,0,9,14,14,9,0,0,0,0,9,14,2,5

' Data for Screen 5
Data 0,0,0,1,0,0,0,1,0,0,0,0,1,0,0,0,1,0,0,0
Data 1,0,1,9,1,0,1,9,1,0,0,1,9,1,0,1,9,1,0,1
Data 9,1,9,5,9,1,9,5,9,1,1,9,5,9,1,9,5,9,1,9
Data 5,9,5,13,5,9,5,13,5,9,9,5,13,5,9,5,13,5,9,5
Data 13,5,13,4,13,5,13,4,13,5,5,13,4,13,5,13,4,13,5,13
Data 4,13,4,0,4,13,4,0,4,13,13,4,0,4,13,4,0,4,13,4
Data 0,4,0,0,0,4,0,0,0,4,4,0,0,0,4,0,0,0,4,0


ScreenError: ' Screen test error-handling routine.
BadMode = TRUE
Resume Next

'----------------------------------------------------------------------------
' BallHitPaddle
'
'    Deflects the ball if the ball hits the paddle.
'
'           PARAMETERS:   Player - Which player's paddle to check
'----------------------------------------------------------------------------
Sub BallHitPaddle (Player)
   
    ' Checks if the paddle and the ball overlap.
    If Abs(Paddle(Player).Y - Ball.Y) < 8 And Ball.X >= Paddle(Player).X And Ball.X <= Paddle(Player).X + Paddle(Player).Size Then
        DrawPaddle Paddle(Player).PColor, Player
       
        ' Players can only hit the ball once before the ball must hit the top,
        ' a brick, or another paddle.
       
        If EraseBallOK Then DrawBall Ball.X, Ball.Y ' Erase the ball if appropriate.
        EraseBallOK = FALSE ' Make sure that main ball control section does not try to erase a ball that was already erased.
       
        If JustHit <> Player Then
            Ball.YOffset = -Ball.YOffset ' Deflect the ball.
            JustHit = Player ' JustHit assures that the same player doesn't hit the ball more than once before the ball hits a brick, the top, or the other paddle.
            LastHitBy = Player ' Used to assign scores properly.
            Play PADDLEHITSOUND
            DrawPaddle Paddle(Player).PColor, Player
            LastX = FALSE
            LastY = FALSE
        End If
    End If

End Sub

'----------------------------------------------------------------------------
' Center
'
'    Centers a string of text on a specified row.
'
'           PARAMETERS:   Row   - Row (line) to put the text on
'                         Text$ - Text to be centered
'----------------------------------------------------------------------------
Sub Center (text$, Row)

    Locate Row, (ScreenWide \ 2) - Len(text$) \ 2 + 1 ' Calculate the position on the screen where the text should be centered
    Print text$;

End Sub

'----------------------------------------------------------------------------
' DisplayChanges
'
'    Displays list of changes that the player can easily make.
'
'           PARAMETERS:   None
'----------------------------------------------------------------------------
Sub DisplayChanges

    DisplayGameTitle ' Print game title.
    
    Color 7 ' White text.
    Center "The following game characteristics can be easily changed from", 5
    Center "within the QuickBASIC Interpreter.  To change the values of  ", 6
    Center "these characteristics, locate the corresponding CONST or DATA", 7
    Center "statements in the source code and change their values, then  ", 8
    Center "restart the program (press Shift+F5).                        ", 9

    Color 15
    Center "Block patterns               ", 11
    Center "Length of paddles            ", 12
    Center "Number of special bricks     ", 13
    Center "Shape of the special bricks  ", 14
    Center "End-of-level bonus multiplier", 15
    Center "Paddle color                 ", 16
    Center "Ball color                   ", 17
    Center "Ball speed                   ", 18

    Color 7 ' White letters.
    Center "The CONST statements and instructions on changing them are   ", 20
    Center "located at the beginning of the main program.                ", 21

    Do While InKey$ = "": Loop ' Wait for any keypress.
    Cls

End Sub

'----------------------------------------------------------------------------
' DisplayGameTitle
'
'    Displays the title of the game.
'
'           PARAMETERS:   None
'----------------------------------------------------------------------------
Sub DisplayGameTitle
    
    Screen 0 ' Set Screen mode 0.
    Width 80, 25 ' Set width to 80, height to 25.
    Color 4, 0 ' Set colors for red on black.
    Cls ' Clear the screen.
    ScreenWide = 80 ' Set screen width variable to match current width.

    ' Draw an outline around screen with extended ASCII characters.
    Locate 1, 2
    Print Chr$(201); String$(76, 205); Chr$(187); ' Draw top border.
    For X = 2 To 24 ' Draw left and right borders.
        Locate X, 2
        Print Chr$(186); Tab(79); Chr$(186);
    Next X
    Locate 25, 2
    Print Chr$(200); String$(76, 205); Chr$(188); ' Draw bottom border.

    ' Print game title centered at top of screen.
    Color 0, 4 ' Set colors to black (0) on red (4) letters.
    Center "     Microsoft     ", 1 ' Center game title on lines
    Center "   Q B R I C K S   ", 2 ' 1 and 2.
    Center "   Press any key to continue   ", 25 ' Center prompt on line 25.
    Color 7, 0

End Sub

'----------------------------------------------------------------------------
' DisplayIntro
'
'    Explains the object of the game and how to play.
'
'           PARAMETERS:   None
'----------------------------------------------------------------------------
Sub DisplayIntro

    DisplayGameTitle ' Display game title.

    Color 7
    Center "Copyright (C) 1990 Microsoft Corporation.  All Rights Reserved.", 4
    Center "Score points by deflecting the ball into the brick walls. In a      ", 6
    Center "two-player game, the player to hit the ball last gets the points.   ", 7
    Center "Hit the special bricks (" + Chr$(SPECIALCHAR) + ") or clear all the bricks to advance to    ", 8
    Center "the next level.  Ball speed increases every level and the paddles(s)", 9
    Center "shorten after a certain level.  Bonus balls are awarded for clearing", 10
    Center "several levels. The game ends when all balls have been played.      ", 11

    Color 4
    Locate 13, 4
    Print String$(74, 196) ' Put horizontal red line on screen.
    Color 7 ' Change foreground color back to white.
    Center " Game Controls ", 13 ' Display game controls.
    Center "General               Player 1               Player 2    ", 15
    Center "                        (Up)                   (Up)      ", 17
    Center "P - Pause                " + Chr$(24) + "                      E       ", 18
    Center "    Q - Quit        (Left) " + Chr$(27) + "   " + Chr$(26) + " (Right)   (Left) S   F (Right)  ", 19
    Center "                         " + Chr$(25) + "                      D       ", 20
    Center "                       (Down)                 (Down)     ", 21

    Play STARTSOUND ' Play melody for introduction.
    Do ' Wait for any key to be pressed.
        kbd$ = UCase$(InKey$)
    Loop While kbd$ = ""
    If kbd$ = "Q" Then 'Allow player to quit now
        Cls
        Locate 10, 30: Print "Really quit? (Y/N)";
        Do
            kbd$ = UCase$(InKey$)
        Loop While kbd$ = ""
        If kbd$ = "Y" Then
            Cls
            End
        End If
    End If

End Sub

'----------------------------------------------------------------------------
' DrawBall
'
'    Draws or erases the ball.  By default, PUT replaces the new graphic
'    image with whatever was already on the screen.  The first PUT statement
'    draws the object; the second PUT statement to the same location erases
'    the object without affecting any other objects.
'
'           PARAMETERS:   BallX     - X (horizontal) location of the ball, in pixels
'                         BallY     - Y (vertical) location of the ball, in pixels
'----------------------------------------------------------------------------
Sub DrawBall (BallX, BallY)

    Put (BallX, BallY), Ballshape()

End Sub

'----------------------------------------------------------------------------
' DrawBrick
'
'    Draws or erases a brick.
'
'           PARAMETERS:   BrickX     - X location of the brick, in logical units
'                         BrickY     - Y location of the ball, in screen rows
'                         BrickColor - Color to draw the brick
'----------------------------------------------------------------------------
Sub DrawBrick (BrickX, BrickY, BrickColor)
  
    ' Calculate screen locations from the logical location of the brick.
    X = BrickX * PIXELSIZE * BRICKSIZE
    Y = BrickY * PIXELSIZE
    Size = BRICKSIZE * PIXELSIZE

    ' Decide if erasing or drawing a brick.
    If BrickColor = BGCOLOR Then
        Line (X, Y)-(X + Size, Y + PIXELSIZE - 1), BGCOLOR, BF
    Else ' Draw the brick...
        Line (X + 1, Y + 1)-(X + Size - 1, Y + PIXELSIZE - 1), 15, B
        Paint (X + 2, Y + 2), BrickColor, 15
        Line (X + 1, Y + PIXELSIZE - 1)-(X + Size - 1, Y + PIXELSIZE - 1), 7
        Line (X + Size - 1, Y + 1)-(X + Size - 1, Y + PIXELSIZE - 1), 7
    End If

End Sub

'----------------------------------------------------------------------------
' DrawPaddle
'
'    Draws or erases a paddle.
'
'           PARAMETERS:   PColor - Paddle color.  Erases the paddle if PColor is set to
'                                  the background color (BgColor)
'                         Player - Which paddle to affect
'----------------------------------------------------------------------------
Sub DrawPaddle (PColor, Player)

    Line (Paddle(Player).X, Paddle(Player).Y)-(Paddle(Player).X + Paddle(Player).Size, Paddle(Player).Y + 1), PColor, BF

End Sub

'----------------------------------------------------------------------------
' EraseBall
'
'    Erases the ball by drawing a square filled with the background color
'    over the ball.
'
'           PARAMETERS:   X - X (horizontal) location of the ball, in pixels
'                         Y - Y (vertical) location of the ball, in pixels
'----------------------------------------------------------------------------
Sub EraseBall (X, Y)

    Line (X, Y)-(X + 2, Y + 2), BGCOLOR, BF

End Sub

'----------------------------------------------------------------------------
' EraseBrick
'
'    Logically erases a brick struck by the ball.  Calls DrawBrick
'    to physically erase the brick.
'
'           PARAMETERS:   X - Logical horizontal location (column) of the brick
'                         Y - Logical vertical location (row) of the brick
'----------------------------------------------------------------------------
Sub EraseBrick (X, Y)

    If LevelOver = TRUE Then Exit Sub ' Just to be sure a new level does not
    ' immediately erase bricks.

    BrickHit = Bricks(Y, X) ' Store the value of the brick that was hit in case it was a special brick.
    LevelCount = LevelCount + BrickHit ' Add the brick color value to the LevelCount total.  This is necessary to know when to stop a round if no special bricks are used.
    Bricks(Y, X) = BGCOLOR ' Logically erase the brick.
    DrawBrick X, Y, BGCOLOR ' Physically erase the brick.
               
    Octave$ = Str$(Y Mod 7)
    Play BLOCKHITSOUND + Octave$ + " c"

    ' Score the hit.
    Paddle(LastHitBy).Score = Paddle(LastHitBy).Score + 10 * Y
    Paddle(LastHitBy).NumBricksHit = Paddle(LastHitBy).NumBricksHit + 1
    UpdateScreen
    JustHit = FALSE ' Set JustHit to FALSE to allow a paddle to hit the ball.

    ' See if the brick was a special brick or all the bricks have been hit.
    If BrickHit = 1000 Or LevelCount = MAXLEVELCount Then
        NextLevel ' Go to next level
        LevelOver = TRUE
    End If

End Sub

'----------------------------------------------------------------------------
' GameOver
'
'    Checks to see if the game should be considered over.  If yes, end game.
'
'           PARAMETERS:   None
'----------------------------------------------------------------------------
Sub GameOver

    DrawBall Ball.X, Ball.Y ' Ensure that the ball is fully erased.

    NumBalls = NumBalls - 1 ' Reduce the number of balls remaining by one.
    UpdateScreen ' Update display to show correct number of balls remaining.

    If NumBalls < 1 Then ' If player has no more balls left,
        Play GAMEOVERSOUND
        DrawBall Ball.X, Ball.Y ' Erases the ball that was just drawn.
        DrawBall Ball.OldX, Ball.OldY ' Erases the last real ball position.
       
        ' Set up information for a one player print out
        Locate 25, 1: Print Space$(SCREENWIDTH);
        DrawPaddle BGCOLOR, 1 ' Erase paddle 1.
        Play1Bricks$ = "Bricks hit:" + Right$((Space$(2) + Str$(Paddle(1).NumBricksHit)), 4)
        Play1Score$ = "Score:" + Right$((Space$(9) + Str$(Paddle(1).Score)), 9)
        
        If NumberOfPlayers = 1 Then
            Center "Player 1 stats", MAXBLOCKROW + 6 ' Print the statistics.
            Center Play1Bricks$, MAXBLOCKROW + 8
            Center Play1Score$, MAXBLOCKROW + 10
            End$ = ""
        Else ' Generate strings for the 2 player statistics.
            Play2Bricks$ = Play1Bricks$ + "     Bricks hit:" + Right$((Space$(2) + Str$(Paddle(2).NumBricksHit)), 4)
            Play2Score$ = Play1Score$ + "     Score:" + Right$((Space$(9) + Str$(Paddle(2).Score)), 9)
            DrawPaddle BGCOLOR, 2 ' Erase paddle 2.
    
            WhoWon$ = "Tie Game.  Nobody" ' Assume tie game.
            If Paddle(1).Score > Paddle(2).Score Then ' Player 1 won.
                WhoWon$ = "Player 1"
            ElseIf Paddle(1).Score < Paddle(2).Score Then 'Player 2 won.
                WhoWon$ = "Player 2"
            End If
       
            Center "Player 1 stats" + Space$(6) + "Player 2 stats ", MAXBLOCKROW + 6
            Center Play2Bricks$, MAXBLOCKROW + 8 ' Print the two-player stats.
            Center Play2Score$, MAXBLOCKROW + 10
            End$ = WhoWon$ + " is the winner!" ' Display winner.
        End If
    
        Center End$, MAXBLOCKROW + 2 ' Show winner if two-player game, otherwise print a space.
        Center "Last level played: " + Str$(Level), MAXBLOCKROW + 4 ' Show the last level.
        Center "Play again? (Y/N)", 24 ' Center prompt for Play Again.

        Do
            k$ = UCase$(InKey$) ' Accept a key from the player.
        Loop While k$ <> "Y" And k$ <> "N" ' Wait for either Y or N.

        Again = FALSE

        If k$ = "Y" Then ' Does user wish to play again?
            Again = TRUE ' Yes, restart game.
            Level = 0
            NextLevel
        End If
        NeedBall = FALSE ' Not out of balls.
    Else
        NeedBall = TRUE ' Out of balls.
    End If

End Sub

'----------------------------------------------------------------------------
' GameParamSetup
'
'     Initializes game values and player paddle values before game begins.
'
'           PARAMETERS:    None
'----------------------------------------------------------------------------
Sub GameParamSetup

    Paddle(1).PColor = PLAYERCOLOR1 ' Set up paddle colors for player 1.
    TempPADDLELENGTH = PADDLELENGTH1 ' Store the length of the paddle.

    If NumberOfPlayers = 2 Then ' Do only if there are two players.
        Paddle(2).PColor = PLAYERCOLOR2 ' Set up paddle colors for player 2.
        TempPADDLELENGTH = PADDLELENGTH2 ' Store the length of the paddle.
    End If

    ScreenWide = SCREENWIDTH ' Make the ScreenWide variable equal to the true SCREENWIDTH.
    GraphicsWidth = ScreenWide * PIXELSIZE ' Determine how many pixels wide the screen is.
    UsableWidth = GraphicsWidth - 7
    Ball.PColor = BALLCOLOR ' Set the color, speed, and number of balls.
    NumBalls = INITNUMBALLS
    
    ' Determine machine performance in a generic manner...
    X! = Timer
    For g! = 1 To 500
    Next g!
    X! = Timer - X!
    Select Case X!
        Case 0 TO .39 ' For 386-type machines.
            ActualBallSpeed = INITIALBALLSPEED
        Case Is < .5 ' For PC/AT-type machines.
            ActualBallSpeed = INITIALBALLSPEED / 2
        Case Else ' For XT-type machines.
            ActualBallSpeed = 0
    End Select
    Ball.speed = ActualBallSpeed ' Set the actual start-up speed.

    For Indx = 1 To NumberOfPlayers ' Set scores and paddle sizes to initial values.
        Paddle(Indx).Size = TempPADDLELENGTH
        Paddle(Indx).Score = 0
        Paddle(Indx).NumBricksHit = 0
    Next Indx

    Screen ScreenMode ' Use the best graphics mode available.
    If ScreenMode = 7 Then
        Color BGCOLOR, BGCOLOR ' Set appropriate colors.
    Else
        Color BGCOLOR
    End If

    Cls ' Draw the ball and store it in an array for fast animation.
    Line (50, 49)-(50, 51), Ball.PColor
    Line (49, 50)-(51, 50), Ball.PColor
    Get (49, 49)-(51, 51), Ballshape()
    
End Sub

'----------------------------------------------------------------------------
' GetGameOptions
'
'    Asks how many people will be playing.
'
'           PARAMETERS:   None
'----------------------------------------------------------------------------
Sub GetGameOptions

    Color 7 ' Set colors for screen to be cleared.
    Cls

    Locate 9, 32: Print "Default is"; DEFAULTPLAYERS
    Color 15
    Do
        Locate 8, 24: Print Space$(50)
        Locate 8, 24
        Input "How many players? (1 or 2) ", PaddleHold$
    Loop Until PaddleHold$ = "1" Or PaddleHold$ = "2" Or Len(PaddleHold$) = 0
    NumberOfPlayers = Val(PaddleHold$)
    If NumberOfPlayers = 0 Then NumberOfPlayers = DEFAULTPLAYERS

End Sub

'----------------------------------------------------------------------------
' HorizontalScroll
'
'     Displays a string moving across the screen at a given line.
'
'           PARAMETERS:    M$  - String to be displayed
'                          Row - Screen row where string is displayed
'----------------------------------------------------------------------------
Sub HorizontalScroll (M$, Row)

    M$ = Space$(ScreenWide + 2) + M$ ' Add ending spaces for display.
    For i = 1 To Len(M$) - 1 ' Loop through the message in m$.
        Locate Row, 1 ' Position the message on passed row value.
        Print Mid$(M$, Len(M$) - i, ScreenWide - 1) ' Use the MID$() function to print a SCREENWIDTH-1 character piece of the entire message.  The piece is determined by the value of X.
        Delay! = Timer + .05 ' Delay the printing of each letter by .1 second.
        Do While Timer < Delay!: k$ = InKey$: Loop ' Clears keyboard buffer.
    Next i
    RedrawPaddles ' In case the text covered the paddle(s).

End Sub

'----------------------------------------------------------------------------
' MovePaddle
'
'     Checks to see if the paddle can be displayed at the new location.  If so, draw it.
'
'           PARAMETERS:    NewX      - X offset from current paddle position
'                          NewY      - Y offset from current paddle position
'                          PlayerNum - Which player's paddle to move
'----------------------------------------------------------------------------
Sub MovePaddle (NewX, NewY, PlayerNum)

    ' Use temporary variables in case the paddle cannot move to the new location.
    TempX = Paddle(PlayerNum).X + NewX ' Set temporary variables in case the paddle
    TempY = Paddle(PlayerNum).Y + NewY '  cannot move to the new location
    
    OppOver = FALSE ' Assume that paddles do not overlap.
    OppUnder = FALSE
   
    If NumberOfPlayers = 2 Then
        OppNum = 3 - PlayerNum ' Get number of opponent.
       
        ' Is opponent under this paddle?
        If TempX >= Paddle(OppNum).X And TempX <= (Paddle(OppNum).X + Paddle(OppNum).Size - 1) Then
            OppUnder = TRUE
        End If
       
        ' Or above this paddle?
        If TempX <= Paddle(OppNum).X And (TempX + Paddle((PlayerNum)).Size - 1) >= Paddle(OppNum).X Then
            OppOver = TRUE
        End If
       
        ' Cannot move vertically into the other paddle.
        If NewX = 0 And TempY = Paddle(OppNum).Y And (OppOver Or OppUnder) Then Exit Sub
       
        ' Cannot move horizontally into the other paddle
        If NewY = 0 And TempY = Paddle(OppNum).Y And OppUnder Then TempX = Paddle(OppNum).X + Paddle(OppNum).Size
        If NewY = 0 And TempY = Paddle(OppNum).Y And OppOver Then TempX = Paddle(OppNum).X - Paddle(OppNum).Size
    End If

    ' Do not move paddle if new position is out of bounds.
    If TempY > MAXROW Or TempY < MINROW Then Exit Sub
    If TempX < 1 Then TempX = 1
    If TempX + Paddle(PlayerNum).Size >= GraphicsWidth Then TempX = GraphicsWidth - Paddle(PlayerNum).Size
        
    ' Erase old paddle location, update the paddle location, and draw the paddle at the new location.
    DrawPaddle BGCOLOR, PlayerNum
    Paddle(PlayerNum).OldX = Paddle(PlayerNum).X
    Paddle(PlayerNum).OldY = Paddle(PlayerNum).Y
    Paddle(PlayerNum).X = TempX
    Paddle(PlayerNum).Y = TempY
    BallHitPaddle PlayerNum ' Check to see if the paddle is hitting the ball now.
    DrawPaddle Paddle(PlayerNum).PColor, PlayerNum

End Sub

'----------------------------------------------------------------------------
' NewBall
'
'     Launches a new ball at the start of the game, to start a new
'     level, or when a player misses the ball.
'
'           PARAMETERS:    None
'----------------------------------------------------------------------------
Sub NewBall

    ' Set the new location of the ball.
    Ball.X = Int(Rnd(1) * 20) * 4 + 120 ' Make the ball roughly centered.
    Ball.Y = MINROW - 8
    Ball.OldX = Ball.X
    Ball.OldY = Ball.Y

    Ball.XOffset = 4 ' Set the offsets of the ball.
    Ball.YOffset = 4
   
    ' Determine left or right movement.
    If Rnd(1) > .5 Then Ball.XOffset = -Ball.XOffset

    SetDefaultPaddle

    DrawBall Ball.X, Ball.Y ' Draw the ball.
    UpdateScreen ' Update information displayed on the screen.
    JustHit = FALSE ' Have not hit anything yet.

    For Indx = 1 To 2 ' Generate two beeps.
        Sound 300, .4
        Restart& = Timer + .9 ' Calculate amount of time to wait before starting ball moving.
        Do
            ClearKeyBuffer$ = InKey$ ' Clear the keyboard buffer.
        Loop While Timer < Restart&
    Next Indx

    ' Two quick beeps to warn the player(s) that the round is about to start.
    Sound 300, .4
    Sound 400, .2
   
    Do While InKey$ <> "": Loop ' Clear the keyboard buffer just in case.
   
    EraseBall Ball.X, Ball.Y ' Erase the ball.
    EraseBallOK = FALSE ' Be sure that the ball updating code does not try to erase a ball that wasn't drawn.

End Sub

'----------------------------------------------------------------------------
' NextLevel
'
'     Prepares to begin a new level by awarding bonus points, drawing new brick
'     walls, etc.
'
'           PARAMETERS:    None
'----------------------------------------------------------------------------
Sub NextLevel
   
    Level = Level + 1
    If Level = 1 Then ' First round.
        GameParamSetup
    Else
        Play NEXTLEVELSOUND
        LevelEnd$ = " Level" + Str$(Level - 1) + " completed! " + Str$((Level - 1) * BONUSMULTIPLIER) + " Bonus Points! "
        HorizontalScroll LevelEnd$, 15 ' Display prompt saying level is complete.
        Ball.speed = Int(ActualBallSpeed * (.95 ^ Level) * 100 + .5) / 100 ' Increase ball speed.
        
        For Indx = 1 To (BONUSMULTIPLIER * (Level - 1)) \ 100 ' Add bonus points.
            Paddle(LastHitBy).Score = Paddle(LastHitBy).Score + 100
            UpdateScreen
            Sound (Indx * 25 + 15), 1 / Indx * 18.2 ' Play the sound while adding bonus.
            PauseLen# = Timer + 1 / Indx
            While Timer < PauseLen#: Wend
        Next Indx
        EraseBallOK = TRUE
    End If

    Cls

    For Y = 0 To 25 ' Clear bricks in the array.
        For X = 0 To 20
            Bricks(Y, X) = BGCOLOR
        Next X
    Next Y
    
    If Level Mod CUTLEVEL = 0 Then ' See if it is time to shorten the paddles.
        TempPADDLELENGTH = TempPADDLELENGTH * ((100 - PADDLECUT) / 100) ' Decrease paddle size.
        If TempPADDLELENGTH < 8 Then TempPADDLELENGTH = 8 ' But no shorter than 8 pixels.
        
        For Indx = 1 To NumberOfPlayers ' Set both paddles to the same length.
            Paddle(Indx).Size = TempPADDLELENGTH
        Next Indx
    End If
   
    ' See if it is time for a bonus ball.
    If Level Mod LEVELNEWBALL = 0 Then NumBalls = NumBalls + 1
    If Level Mod MAXLEVEL = 1 Then Restore ' Have all designs been shown ?

    MAXLEVELCount = 0 ' Reset brick counting variables.
    LevelCount = 0
    
    For Y = STARTBRICKROW To MAXBLOCKROW - 1 ' Draw new brick pattern.
        For X = 0 To 19
            Read C ' Get data for new block.
            Bricks(Y, X) = (C Mod 32) + BGCOLOR
            If Bricks(Y, X) <> BGCOLOR Then
                MAXLEVELCount = MAXLEVELCount + (C Mod 32) ' Add the value to MAXLEVELCount so that the end of the level can be detected if there are no special bricks.
               
                ' Draw the brick using the correct number of colors for this screen mode.
                If ScreenMode = 1 Then
                    DrawBrick X, Y, Bricks(Y, X) Mod 3 + 1
                Else
                    DrawBrick X, Y, Bricks(Y, X) Mod 16
                End If
            End If
        Next X
    Next Y

    ' Put the special bricks on the screen, replacing existing bricks.
    Indx = 1
    Do While Indx <= NUMSPECIALBRICKS
        Do
            ' Select random X and Y positions of the special brick.
            XRandom = Int(Rnd(1) * 20)
            YRandom = Int(Rnd(1) * 5) + STARTBRICKROW
        Loop While Bricks(YRandom, XRandom) = BGCOLOR Or Bricks(YRandom, XRandom) = 1000 ' Make sure the special brick goes into an existing bricks that has not already been used by another special brick.

        If ScreenMode <> 1 Then Color 14 ' Set color of special bricks.
        Locate YRandom + 1, XRandom * BRICKSIZE + 1 ' Move cursor to location of brick.
        Print special; ' Print the special brick.
        Bricks(YRandom, XRandom) = 1000 ' Put 1000 into the Bricks array where the special brick is so that EraseBrick can detect when a special brick is hit.
        Indx = Indx + 1
    Loop
   
    NewBall ' Get a new ball.

End Sub

'----------------------------------------------------------------------------
' RedrawPaddles
'
'     Draws the paddles.
'
'           PARAMETERS:    None
'----------------------------------------------------------------------------
Sub RedrawPaddles

    For paddles = 1 To NumberOfPlayers
        DrawPaddle Paddle(paddles).PColor, paddles
    Next paddles

End Sub

'----------------------------------------------------------------------------
' SetDefaultPaddle
'
'     Puts the paddle(s) into their respective starting places.
'
'           PARAMETERS:    None
'----------------------------------------------------------------------------
Sub SetDefaultPaddle

    For i = 1 To NumberOfPlayers ' Clear the current paddles.
        DrawPaddle BGCOLOR, i
    Next i

    If NumberOfPlayers = 2 Then ' Set the default position of the paddle(s).
        For PaddleNumber = 1 To NumberOfPlayers
            Paddle(PaddleNumber).X = (((GraphicsWidth - 80) \ PaddleNumber) - TempPADDLELENGTH) ' Sets the horizontal position of the paddle(s).
            Paddle(PaddleNumber).Y = MAXROW
        Next PaddleNumber
    Else
        Paddle(1).X = (GraphicsWidth - TempPADDLELENGTH) / 2
        Paddle(1).Y = MAXROW
    End If

    RedrawPaddles ' Show them again.

End Sub

'----------------------------------------------------------------------------
' UpdateScreen
'
'    Puts new scores, levels, and ball counts on the screen.
'
'           PARAMETERS:    None
'----------------------------------------------------------------------------
Sub UpdateScreen

    If ScreenMode <> 1 Then Color SCORECOLOR ' Set screen color for messages.
    Locate 25, 1

    ' Display the data a little differently for one-player and two-player games.
    If NumberOfPlayers = 1 Then
        Print Using "Balls:###"; NumBalls;
        Print Using " Level:###"; Level;
        If Paddle(1).Score > 9999000 Then Paddle(1).Score = 0
        Print Using " Player 1:#,###,###"; Paddle(1).Score;
    Else
        If Paddle(2).Score > 999000 Then Paddle(2).Score = 0
        Print Using "Play2:###,###"; Paddle(2).Score;
        Print Using " B:###"; NumBalls;
        Print Using " L:###"; Level;
        If Paddle(1).Score > 999000 Then Paddle(1).Score = 0
        Print Using " Play1:###,###"; Paddle(1).Score;
    End If

End Sub

