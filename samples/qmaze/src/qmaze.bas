'                                QMAZE.BAS
'
'       Copyright (C) 1990 Microsoft Corporation. All Rights Reserved.
'
' Race through a maze that pits your skill against the clock, or a friend.
' The object is to finish the maze before time runs out or before your
' opponent finishes.
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
' of the main program can be modified to change the following:
'    Songs played during this game
'    Size of the maze game grid
'    How quickly the monsters move
'    Initial time allowed per maze
'    Color of Player 1
'    Color of Player 2
'    Color of the Monsters
'    Maze dimensions at each difficulty level
'    Amount of time path preview is shown
'
' On the right side of each CONST statement, there is a comment that tells
' you what it does and how large or small you can set the value.  Above the
' DATA statements, there are comments that tell you the format of the
' information stored there.
'
' On your own, you can also add exciting sound and visual effects or make any
' other changes that your imagination can dream up.  By reading the
' "Learn BASIC Now" book, you'll learn the techniques that will enable you
' to fully customize this game and to create games of your own.
'
' If the game won't run after you have changed it, you can exit without
' saving your changes by pressing Alt, F, X and choosing NO.
'
' If you do want to save your changes, press Alt, F, A and enter a filename
' for your version of the program.  Before you save your changes,
' however, you should make sure they work by running the program and
' verifying that your changes produce the desired results.  Also, always
' be sure to keep a backup of the original program.
'
DefInt A-Z

' Here are the BASIC CONST statements you can change.
Const BLOCKSIZE = 8 ' Maze grid element size.  Range: 4 to 8.  With a smaller block size a larger maze can be created by modifying the DATA statements at the end of the main program.
Const DEFAULTTIME = 60 ' Seconds allowed to complete a maze at level 1.  Decreases by 5 seconds in each later level.  Range 30 to 100.
Const DEFAULTMONSTERTIME = .5 ' Range: .2 to 3.0   A lower number makes the monsters move faster.
Const SHOWDELAY = .2 ' Seconds that the maze solution will be shown.  Range 0 to 10.
Const DEFAULTPLAYERS = 1 ' Range 1 to 2.
Const DEFAULTLEVEL = 1 ' Range 1 to 5.
Const DEFAULTMONSTERS = 0 ' Range 0 to 10.
Const DEFAULTSHOWMAZE = -1 ' Range 0 (FALSE) or -1 (TRUE).
Const DEFAULTNUMMAZES = 1 ' Range 1 to 10.
Const MAZECOLOR7 = 7 ' Color of the maze (EGA, VGA graphics).  Range: 1 to 15, but not the same as GameBkGround7.
Const PLAYER1COLOR7 = 10 ' Color of player 1 (EGA, VGA graphics).  Range: 1 to 15, but not the same as GameBkGround7.
Const PLAYER2COLOR7 = 13 ' Color of player 2 (EGA, VGA graphics).  Range: 1 to 15, but not the same as GameBkGround7.
Const MONSTERCOLOR7 = 12 ' Color of the monsters (EGA, VGA graphics).  Range: 1 to 15, but not the same as GameBkGround7.
Const MAZECOLOR1 = 3 ' Color of the maze (CGA graphics).  Range 1 to 3, but not the same as GameBkGround1.
Const PLAYER1COLOR1 = 1 ' Color of player 1 (CGA graphics).  Range: 1 to 3, but not the same as GameBkGround1.
Const PLAYER2COLOR1 = 2 ' Color of player 2 (CGA graphics).  Range: 1 to 3, but not the same as GameBkGround1.
Const MONSTERCOLOR1 = 3 ' Color of the monsters (CGA graphics).  Range: 1 to 3, but not the same as GameBkGround1.
' The following sound constants are used by the PLAY command to
' produce music during the game.  To change the sounds you hear, change
' these constants.  Refer to the online help for PLAY for the correct format.
' To completely remove sound from the game set the constants equal to null.
' For example:  STARTOFGAMESOUND = ""
Const STARTOFGAMESOUND = "MBT145O1L8B-O2DL4E-L8O1A-O2CL4D-L8O2CEFE-DO1B-O2CO1B-" ' Played during Displayintro subroutine.
Const ENDOFGAMESOUND = "MBT200O1L6EBAEL7A" ' Played when all the mazes have been played or 'Q' was chosen when the game was paused.
Const ENDOFMAZESOUND = "MBT190n70n60n50n40" ' Played when a maze is completed
Const PLAYERDEATHSOUND = "MBT255o0l10n10l7n7l10n4" ' Played when you lose a life or run out of time.
Const PLAYEROUTSOUND = "MBT140L64n40n35n30" ' Played when a player exits the maze

'The next section contains CONST statements that are not changeable.
Const FALSE = 0 ' FALSE for Boolean operations.
Const TRUE = -1 ' TRUE for Boolean operations.
Const UP2 = 18 ' Keyboard scan code for the E key.
Const DOWN2 = 32 ' Keyboard scan code for the D key.
Const LEFT2 = 31 ' Keyboard scan code for the S key.
Const RIGHT2 = 33 ' Keyboard scan code for the F key.
Const CTOP = 1 ' Keyboard code for up in internal maze directions.
Const CBOTTOM = 2 ' Keyboard code for down in internal maze directions.
Const CLEFT = 3 ' Keyboard code for left in internal maze directions.
Const CRIGHT = 4 ' Keyboard code for right in internal maze directions.
Const MAXMONSTERS = 10 ' Maximum number of monsters.
Const MAXLEVEL = 5 ' Maximum number of levels.
Const MAXMAZES = 10 ' Maximum number of mazes.
Const SCREENWIDTH = 80 ' Text mode screen width.
Const GAMEBKGROUND7 = 1 ' Color to use to erase objects (EGA, VGA graphics).
Const GAMEBKGROUND1 = 0 ' Color to use to erase objects (CGA graphics).  In CGA mode, 0 means the color of the background.

' DECLARE statement tell the main program that subprograms and
' functions exist and defines what data types they use.
DECLARE SUB BustOut (x%, y%)
DECLARE SUB CancelDirection (move AS ANY, direction%)
DECLARE SUB Center (text$, row%)
DECLARE SUB ChangeWall (x%, y%, direction%, RepCh%)
DECLARE SUB ClosePath (move AS ANY)
DECLARE SUB CompleteMaze ()
DECLARE SUB ConvertDirToXY (direction%, xmove%, ymove%)
DECLARE SUB DisplayChanges ()
DECLARE SUB DisplayGameTitle ()
DECLARE SUB DisplayIntro ()
DECLARE SUB DisplayWinner ()
DECLARE SUB DrawMonster (x%, y%, WhatColor%)
DECLARE SUB DrawPlayer (Player%, WhatColor%)
DECLARE SUB GenerateMaze ()
DECLARE SUB GenerateMove (move AS ANY)
DECLARE SUB GetGameOptions ()
DECLARE SUB InitVariables ()
DECLARE SUB Keys (onoff%)
DECLARE SUB MonsterControl ()
DECLARE SUB PlayGame ()
DECLARE SUB PopMove (move AS ANY)
DECLARE SUB PrintBlock (block AS ANY, x%, y%, WhatColor%)
DECLARE SUB PrintMaze ()
DECLARE SUB ProcessPlayerInput (i%)
DECLARE SUB UpdatePosition (Dir%, Plr%)
DECLARE FUNCTION CheckForClosedArea% (move AS ANY)
DECLARE FUNCTION CreatePath% ()
DECLARE FUNCTION GetMonsterDirection% (x%, y%, direction%)
DECLARE FUNCTION NumberOfWalls% (x%, y%)
DECLARE FUNCTION ValidBustDir% (x%, y%)

' This section contains TYPE definitions:
Type MazeType ' This type contains maze information of a single block.
    top As Integer ' Tells if top block side exists.
    Bottom As Integer ' Tells if bottom block side exists.
    Left As Integer ' Tells if left block side exists.
    Right As Integer ' Tells if right block side exists.
End Type

Type MoveType ' MoveType contains information about moves within the maze.
    x As Integer ' X coordinate of a move.
    y As Integer ' Y coordinate of a move.
    direction As Integer ' Direction of a move 1 to 4.
    Spaces As Integer ' Number of hexes to move in a row during maze creation.
    top As Integer ' Tells if top block side exists.
    Bottom As Integer ' Tells if bottom block side exists.
    Left As Integer ' Tells if left block side exists.
    Right As Integer ' Tells if right block side exists.
End Type

Type PlayerType ' This type is used to keep track of information about each player.
    x As Integer ' Player's horizontal position.
    y As Integer ' Player's vertical position.
    PColor As Integer ' Player's color.
    Dead As Integer ' -1 means the player is dead, 0 means the player is alive.
    TimeLeft As Integer ' Temporary time left for each player.
    Done As Integer ' -1 means the player is done with current maze, 0 means the player is not done.
    Score As Long ' Player points.
End Type

Type MonsterType ' This type is used to keep track of information about each monster.
    x As Integer ' Monster's horizontal position.
    y As Integer ' Monster's vertical position.
    direction As Integer ' Monster's direction of movement.
    Active As Integer ' -1 means the monster is active, 0 means the monster is frozen and inactive.
End Type

Clear , , 5120 'Set up a large stack for all key processing.

' This section contains COMMON SHARED variables.
Dim Shared MazeWidth As Integer ' Width of maze, in blocks.
Dim Shared MazeHeight As Integer ' Height of maze, in blocks.
Dim Shared PathLength As Integer ' Minimum number of blocks the valid path must be go before trying to turn.
Dim Shared TurnRate As Integer ' Maximum number of blocks the valid path may go before trying to turn
Dim Shared ShowMaze As Integer ' -1 cause the full maze to be shown, 0 causes only the outer edge to be shown.
Dim Shared Level As Integer ' Play level.
Dim Shared AvailMonsters As Integer ' Number of monsters.
Dim Shared NumOfPlayers As Integer ' Number of players.
Dim Shared NumOfMazes As Integer ' Number of mazes to run before completing a level.
Dim Shared MazeTime As Integer ' Time allowed to complete a maze.
Dim Shared StackPointer As Integer ' Points to current place on the stack.
Dim Shared MazeOver As Integer ' -1 means an event has ended one run through a maze.
Dim Shared GameOver As Integer ' -1 means an event has caused the game to end.
Dim Shared MazesFinished As Integer ' Number of mazes completed.
Dim Shared NumMonsters As Integer ' Number of monsters currently on the screen.
Dim Shared MazeColor As Integer ' Color of maze.
Dim Shared GameBkGround As Integer ' Background color.
Dim Shared MonsterColor As Integer ' Color of the monsters.
Dim Shared ScreenMode As Integer ' Screen mode.
Dim Shared EntryX As Integer ' X coordinate of the maze entrance.
Dim Shared EntryY As Integer ' Y coordinate of the maze entrance.
Dim Shared ExitX As Integer ' X coordinate of the maze exit.
Dim Shared ExitY As Integer ' Y coordinate of the maze exit.
Dim Shared StartX As Integer ' X coordinate of the maze.
Dim Shared StartY As Integer ' Y coordinate of the maze.
Dim Shared CountDown As Integer ' Number of seconds left to complete a maze.
Dim Shared MazeError As Integer ' Indicates if a maze error occurred.
Dim Shared MonsterUpdateTime As Single ' Delay between monster movements.
Dim Shared ContinueDirection As Single ' Probability of the monster continuing in the same direction.
Dim Shared Player(1 To 2) As PlayerType ' Information about each player.
Dim Shared PlayerMove(1 To 2) As Integer ' Temporary user move from the queue.
ReDim Shared stackVar(0) As MoveType ' All maze creation moves.
ReDim Shared MazeArray(0, 0) As MazeType ' Maze information.
ReDim Shared Monsters(0) As MonsterType ' Monster information.
Dim KeyFlags As Integer ' Internal state of keyboard flags when game starts. Hold the state so it can be restored when the game ends.
Dim BadMode As Integer ' Store the status of a valid screen mode.

' The module-level code of QMAZE begins here!

Randomize Timer Mod 32768 ' Causes the mazes to be different.

'Determines which graphics mode to use.
On Error GoTo ScreenError ' Set an error trap for testing valid screen mode.
BadMode = FALSE ' Assume the graphics mode is okay.
ScreenMode = 7 ' First try mode 7.
Screen ScreenMode ' Attempt to go into SCREEN 7 (EGA screen).
If BadMode = TRUE Then ' If this attempt failed.
    ScreenMode = 1 ' Try mode 1 - a CGA screen.
    BadMode = FALSE ' Again, assume that graphics mode is okay.
    Screen ScreenMode ' Attempt to go into SCREEN 1.
End If
On Error GoTo 0 ' Turn off error handling.

If BadMode = TRUE Then ' If no graphics adapter...
    Cls
    Locate 10, 13: Print "CGA, EGA Color, or VGA graphics required to run QMAZE.BAS"
Else
    Def Seg = 0 ' Set the current segment to the low memory area.
    KeyFlags = Peek(1047) ' Read the location that stores the keyboard flag.
    Poke 1047, &H0 ' Force them off.
    Def Seg ' Restore the default segment.

    DisplayIntro ' Display the introduction screen now.
    Do
        GetGameOptions ' Get the user choices for game.
        InitVariables ' Initialize keys and variables.
        Do
            Screen ScreenMode ' Set appropriate screen mode.
            Color GameBkGround, 1
            Cls ' Clear the screen.
            GenerateMaze ' Create a new maze.
            PlayGame ' Play the current maze.
            DisplayWinner ' Show who won, etc.
        Loop While Not GameOver

        Locate 22, 11 ' See if player wants to play again.
        Print "Play again? (Y/N)"
        Do
            k$ = UCase$(InKey$) ' Wait for any key to be pressed.
        Loop While (k$ <> "Y" And k$ <> "N")
        If k$ = "Y" Then GameOver = FALSE
    Loop While Not GameOver

    DisplayChanges ' Display suggested changes screen.
    Cls

    Def Seg = 0 ' Restore the previous flag settings.
    Poke 1047, KeyFlags
    Def Seg

End If

End

' The subroutines below are called when the player presses a key to move.

MovePlayer1Up:
PlayerMove(1) = CTOP
ProcessPlayerInput 1
Return

MovePlayer1Down:
PlayerMove(1) = CBOTTOM
ProcessPlayerInput 1
Return

MovePlayer1Left:
PlayerMove(1) = CLEFT
ProcessPlayerInput 1
Return

MovePlayer1Right:
PlayerMove(1) = CRIGHT
ProcessPlayerInput 1
Return

MovePlayer2Up:
PlayerMove(2) = CTOP
ProcessPlayerInput 2
Return

MovePlayer2Down:
PlayerMove(2) = CBOTTOM
ProcessPlayerInput 2
Return

MovePlayer2Left:
PlayerMove(2) = CLEFT
ProcessPlayerInput 2
Return

MovePlayer2Right:
PlayerMove(2) = CRIGHT
ProcessPlayerInput 2
Return

PauseGame:
Keys (2) ' Ensure that no other interrupts happen at the same time.
Timer Off
Sound 1100, .75 ' Tone at 1100 hertz for 75 clock ticks.
Center Space$(13) + "* PAUSED *" + Space$(13), 1 'Display pause message.
While InKey$ = "": Wend ' Wait for a key to be pressed.
Center Space$(36), 1 ' Clear prompt.
Keys (1) ' Allow interrupts to fire normally.
Timer On
Return

QuitGame:
Keys (2) ' Ensure that no other interrupts happen at the same time.
Timer Off
Sound 600, .5
Sound 800, .5
Center Space$(10) + "Really quit? (Y/N)" + Space$(10), 1 ' Display prompt.
Do
    k$ = UCase$(InKey$) ' Wait for desired key to be pressed.
Loop While k$ = ""
Center Space$(39), 1 ' Clear prompt from the screen.

If k$ = "Y" Then GameOver = TRUE
Keys (1) ' Turn keys back on.
Timer On
Return

TimerUpdate:
Sound 500, .1
CountDown = CountDown - 1 ' Reduce the time-left variable by one.
Locate 1, 13: Print CountDown
Return

ScreenError: ' Screen test error handling routine.
BadMode = TRUE
Resume Next

MazeErrorHandler: ' Maze creation error handler.
MazeError = TRUE
Resume Next


' The following Data Statements contain information about the Mazes at
' different levels.  The Data is read in from GetGameOptions.  Each row of
' DATA is information for a level.  The first row for Level one and so
' on.  The entries are read from left to right into the following variables:
' mazeWidth, mazeHeight, pathLength, TurnRate.
'
'           THESE DATA STATEMENTS MAY BE CHANGED WITHIN LIMITS
'
' The first entry is the width of the maze.  Range 20 to 38
' The second entry is the height of the maze. Range 15 to 20
' The third entry is the minimum length of the path.  Range 25 to 60
' The greater the value the  harder the maze is. The smaller the maze
' the shorter the PathLength should be.
'
' WARNING: A Large PathLength with a small maze can cause the maze
' generator to produce an error.
'
' The fourth entry is the turn rate of the correct path. Range 3 to 7.
'
Data 20,20,30,3
Data 25,20,40,3
Data 30,20,50,5
Data 35,20,60,7
Data 35,20,60,5

' The total number of levels can be changed if extra DATA statements are added
' after the existing ones.  They must have the same format as the existing
' DATA statements.  You must also change the constant maxLevel to add
' additional levels.

'---------------------------------------------------------------------------
' BustOut
'
'   Starts at a given block and creates a path (removing walls) until it
'   encounters a block that does not have four walls. Uses the SHARED
'   TurnRate variable to decide how far to go in one direction before turning.
'   This keeps the rest of the maze consistent with the valid path.
'
'       PARAMETERS: X - X coordinate of the starting block
'                   Y - Y coordinate of the starting block
'---------------------------------------------------------------------------
Sub BustOut (x, y)

    BustedOut = FALSE
    currx = x ' Set current X & Y position.
    curry = y
    Do While Not BustedOut
        direction = ValidBustDir(currx, curry) ' Set direction.
        ConvertDirToXY direction, xmove, ymove ' Convert direction to coordinates.
        Spaces = Int(Rnd(1) * TurnRate) + 1
        ValidMove = TRUE
        BlocksOpened = 1
        Do While BlocksOpened <= Spaces And ValidMove
            ChangeWall currx, curry, direction, 0
            currx = currx + xmove
            curry = curry + ymove
            If currx + xmove < 1 Or currx + xmove > MazeWidth Or curry + ymove < 1 Or curry + ymove > MazeHeight Then
                ValidMove = FALSE
            End If
            If MazeArray(currx, curry).top + MazeArray(currx, curry).Bottom + MazeArray(currx, curry).Left + MazeArray(currx, curry).Right <> 3 Then
                ValidMove = FALSE
                BustedOut = TRUE
            End If
            BlocksOpened = BlocksOpened + 1
        Loop
    Loop

End Sub

'--------------------------------------------------------------------------
'
' CancelDirection
'
'   Takes a direction value and cancels it as a valid move
'   direction in the move type variable which is passed to it.
'
'           PARAMETERS:    move      - Allowable directions to move
'                          direction - Direction to cancel legal move
'--------------------------------------------------------------------------
Sub CancelDirection (move As MoveType, direction)

    Select Case direction ' Determine direction.
        Case CTOP
            move.top = 1 ' Cancel move up.
        Case CBOTTOM
            move.Bottom = 1 ' Cancel move down.
        Case CLEFT
            move.Left = 1 ' Cancel move left.
        Case CRIGHT
            move.Right = 1 ' Cancel move right.
    End Select

End Sub

'--------------------------------------------------------------------------
' Center
'
'   Centers the given text string on the indicated row.
'
'           PARAMETERS:   text$ - The text to be centered
'                         row   - The screen row to print on
'--------------------------------------------------------------------------
Sub Center (text$, row)

    ' Calculate the starting column. Subtract the string length from
    ' ScreenWidth the divide that value by 2.

    Locate row%, (SCREENWIDTH - Len(text$)) \ 2 + 1

    Print text$; ' Print the text.

End Sub

'---------------------------------------------------------------------------
' ChangeWall
'
'   Replaces a wall given the coordinates and the direction to replace.
'   The routine actually has to replace two walls.  It needs to replace
'   the adjoining wall in the adjoining block.
'
'           PARAMETERS:    x         - X coordinate of the block whose wall
'                                      will be replaced
'                          y         - Y coordinate of the block whose wall
'                                      will be replaced
'                          direction - Direction of the wall to be replaced
'                          repch     - Designates whether to replace or erase
'                                      (1 = replace, 0 = remove)
'---------------------------------------------------------------------------
Sub ChangeWall (x, y, direction, RepCh)

    Select Case direction
        Case CTOP
            MazeArray(x, y).top = RepCh
            MazeArray(x, y - 1).Bottom = RepCh
        Case CBOTTOM
            MazeArray(x, y).Bottom = RepCh
            MazeArray(x, y + 1).top = RepCh
        Case CLEFT
            MazeArray(x, y).Left = RepCh
            MazeArray(x - 1, y).Right = RepCh
        Case CRIGHT
            MazeArray(x, y).Right = RepCh
            MazeArray(x + 1, y).Left = RepCh
    End Select

End Sub

'--------------------------------------------------------------------------
' CheckForClosedArea
'
'   Prevents the path from shutting itself into a closed area from which it
'   might take a while to back its way out of. While this routine does not
'   wholly prevent this, it eliminates many of the possibilities which take
'   time to check. The routine accomplishes this by checking to see if the
'   current move will cause the path to touch itself.  If the path is going
'   to touch, it retraces the path until it comes to the block which was
'   touched.  If any of the blocks along the way back has an untouched block
'   (four walls) on opposite sides of it, it can be assumed that the move has
'   a high chance of causing the path to enclose itself.
'
'           PARAMETERS:    move - Starting location to check path
'--------------------------------------------------------------------------
Function CheckForClosedArea (move As MoveType)

    CheckForClosedArea = FALSE
    
    ConvertDirToXY move.direction, xmove, ymove ' Get the location of where the current move goes.
    currx = move.x + xmove * move.Spaces
    curry = move.y + ymove * move.Spaces
    Touching = FALSE

    'Check to see if moving up or down
    If move.direction = CTOP Or move.direction = CBOTTOM Then
        
        If currx + 1 <= MazeWidth Then ' Check the right side to find if wall is touched.
            If NumberOfWalls(currx + 1, curry) <> 4 Then
                TouchedX = currx + 1
                TouchedY = curry
                Touching = TRUE
            End If
        End If
        
        If currx - 1 >= 1 Then ' Check the left side to find if wall is touched.
            If NumberOfWalls(currx - 1, curry) <> 4 Then
                TouchedX = currx - 1
                TouchedY = curry
                Touching = TRUE
            End If
        End If
        
        For xcheck = -1 To 1 ' Check ahead-left, straight-ahead and ahead-right to find if wall is touched.
            If curry + ymove >= 1 And curry + ymove <= MazeHeight And currx + xcheck >= 1 And currx + xcheck <= MazeWidth Then
                If NumberOfWalls(currx + xcheck, curry + ymove) <> 4 Then
                    TouchedX = currx + xcheck
                    TouchedY = curry + ymove
                    Touching = TRUE
                End If
            End If
        Next xcheck
    End If
    
    
    If move.direction = CLEFT Or move.direction = CRIGHT Then ' Check to see if moving left or right
        
        If curry + 1 <= MazeHeight Then ' Check top to find if wall is touched.
            If NumberOfWalls(currx, curry + 1) <> 4 Then
                TouchedX = currx
                TouchedY = curry + 1
                Touching = TRUE
            End If
        End If
        
        If curry - 1 >= 1 Then ' Check bottom to find if wall is touched.
            If NumberOfWalls(currx, curry - 1) <> 4 Then
                TouchedX = currx
                TouchedY = curry - 1
                Touching = TRUE
            End If
        End If

        
        For ycheck = -1 To 1 ' Check ahead-top, straight-ahead and ahead-bottom to find if wall is touched.
            If currx + xmove >= 1 And currx + xmove <= MazeWidth And curry + ycheck >= 1 And curry + ycheck <= MazeHeight Then
                If NumberOfWalls(currx + xmove, curry + ycheck) <> 4 Then
                    TouchedX = currx + xmove
                    TouchedY = curry + ycheck
                    Touching = TRUE
                End If
            End If
        Next ycheck
    End If
    
    If Not Touching Then Exit Function ' If the wall hasn't been touched, there is no problem.

    ' There was a touch, so check for an untouched box on opposite side for each block in the path.
    SavePointer = StackPointer 'Ensure the move stack is returned to its proper position.
    Dim CheckMove As MoveType
    CheckMove = move
    UntouchedBlocks = FALSE
    FoundTouch = FALSE

    ' Loop until either the block that was touched is found, or we find a block with untouched blocks on opposite sides.
    While Not UntouchedBlocks And Not FoundTouch
        ConvertDirToXY CheckMove.direction, xmove, ymove
        currx = CheckMove.x
        curry = CheckMove.y
        SpacesChecked = 1

        ' Check through all the blocks in one move.
        Do While Not UntouchedBlocks And Not FoundTouch And SpacesChecked <= CheckMove.Spaces
            currx = currx + xmove
            curry = curry + ymove
            
            If currx = TouchedX And curry = TouchedY Then ' Found the place where the wall is touched.
                FoundTouch = TRUE
                Exit Do
            End If
            ' Get the number of walls for each block on all sides of the path block. Edges count as untouched blocks.
            If currx + 1 <= MazeWidth Then
                RightBox = NumberOfWalls(currx + 1, curry)
            Else
                RightBox = 4
            End If
            If currx - 1 >= 1 Then
                LeftBox = NumberOfWalls(currx - 1, curry)
            Else
                LeftBox = 4
            End If
            If curry + 1 <= MazeHeight Then
                BottomBox = NumberOfWalls(currx, curry + 1)
            Else
                BottomBox = 4
            End If
            If curry - 1 >= 1 Then
                TopBox = NumberOfWalls(currx, curry - 1)
            Else
                TopBox = 4
            End If
            
            If RightBox = 4 And LeftBox = 4 Then ' Check to see if opposite blocks are untouched.
                UntouchedBlocks = TRUE
                CheckForClosedArea = TRUE
            End If
            If TopBox = 4 And BottomBox = 4 Then
                UntouchedBlocks = TRUE
                CheckForClosedArea = TRUE
            End If
            SpacesChecked = SpacesChecked + 1
        Loop
        PopMove CheckMove
    Wend
    StackPointer = SavePointer ' Restore the stack to its original place.

End Function

'---------------------------------------------------------------------------
' ClosePath
'
'   Puts back all the walls opened by a given move.  This is used when a
'   move is popped off the stack because it has no more valid directions.
'
'               PARAMETERS:   move - The move to close path from
'--------------------------------------------------------------------------
Sub ClosePath (move As MoveType)

    ConvertDirToXY move.direction, xmove, ymove
    x = move.x
    y = move.y
    For i = 1 To move.Spaces
        ChangeWall x, y, move.direction, 1
        x = x + xmove
        y = y + ymove
        PrintBlock MazeArray(x, y), x, y, MazeColor
    Next i

End Sub

'---------------------------------------------------------------------------
' CompleteMaze
'
'   Finishes breaking out the walls of the maze after a valid path has been
'   found.  It does this by first picking random points along the valid path
'   and calling the BustOut routine from these points. This helps ensure that
'   there will be many alternative accessible paths.  After it chooses the
'   random points, it checks each block in the maze to make sure that it
'   does not have four walls.  If there are blocks with four walls, the
'   BustOut routine is called with this block as a starting point.
'
'                       PARAMETERS:     None
'---------------------------------------------------------------------------
Sub CompleteMaze

    Dim TempMove As MoveType
    SavePointer = StackPointer ' Preserve the stack pointer.
    
    Do While SavePointer > 1 ' Loop from the end of the path back to the beginning.

        'Choose which block on the valid path to start the BustOut routine.
        Interval = TurnRate + Int(Rnd(1) * TurnRate) + 1
        SpacesPassed = 0
        While SpacesPassed < Interval And StackPointer > 1
            PopMove TempMove
            SpacesPassed = SpacesPassed + TempMove.Spaces
        Wend
        If StackPointer <= 1 Then Exit Do
        BustOut TempMove.x, TempMove.y
    Loop

    StackPointer = SavePointer ' Restore the stack pointer.
    For ycheck = 1 To MazeHeight ' Check each block in the maze to ensure that it does not have four walls.
        For xcheck = 1 To MazeWidth
            If MazeArray(xcheck, ycheck).top + MazeArray(xcheck, ycheck).Bottom + MazeArray(xcheck, ycheck).Left + MazeArray(xcheck, ycheck).Right = 4 Then
                BustOut xcheck, ycheck
            End If
        Next xcheck
    Next ycheck

End Sub

'----------------------------------------------------------------------------
' ConvertDirToXY
'
'   Converts directions into the horizontal and vertical movements needed
'   to move in a specified direction.
'
'               PARAMETERS:   Direction - Movement direction
'                             xmove     - X coordinate of next position
'                             ymove     - Y coordinate of next position
'----------------------------------------------------------------------------
Sub ConvertDirToXY (direction, xmove, ymove)

    Select Case direction
        Case CTOP
            ymove = -1: xmove = 0
        Case CBOTTOM
            ymove = 1: xmove = 0
        Case CLEFT
            ymove = 0: xmove = -1
        Case CRIGHT
            ymove = 0: xmove = 1
        Case Else
            ymove = 0: xmove = 0
    End Select

End Sub

'---------------------------------------------------------------------------
' CreatePath
'
'   This is the main controlling routine which determines a valid path through
'   the maze.  It contains two main loops.  The outer loop is executed once
'   for each move.  The inner loop is executed once for each block in the move.
'   The basic flow of the loops is as follows.  First, a random move is
'   generated.  The move is then checked to make sure it doesn't run into a
'   wall or try to enclose itself.  If the move passes the tests, it is added
'   to the stack of moves.  If the end of the path is on an edge, and the path
'   has travelled the minimum distance, then the path is done.  If a move does
'   not pass a test, then the move is deleted and the previous move is told
'   that it cannot move in that direction.  If all of the directions have been
'   used up, then that move is removed from the stack, and the move previous
'   to that is told it can't move in that direction.  By doing this, it is
'   assured that the maze will eventually be solved.  However, It may take
'   the maze generator a while to back all the way out of situations where
'   it loops on itself. Routines were added to try to cut down on this
'   happening to some degree of success.  However, small mazes with long
'   minimum path lengths may still take a while to generate.  If an error is
'   generated during maze creation then FALSE is returned by CreatePath,
'   ELSE CreatePath is TRUE.
'
'                       PARAMETERS:   None
'----------------------------------------------------------------------------
Function CreatePath
    
    On Error GoTo MazeErrorHandler ' Initialize error trapping.

    touched = FALSE
    currx = EntryX
    curry = EntryY
    Dim CurrMove As MoveType
    Dim newmove As MoveType
    CurrMove.x = EntryX
    CurrMove.y = EntryY
    finished = FALSE
    TimeOfMaze! = Timer ' Initialize error detection.
    MazeError = FALSE

    ' Loop until an edge is found after travelling the minimum path length .
    While Not finished
        ValidMove = FALSE
        GenerateMove CurrMove 'Get a move to check.
        'Loop until a valid move is generated
        While ValidMove = FALSE
            'Perform Error checking
            If (Timer - TimeOfMaze! > 8) Or (MazeError = TRUE) Then
                CreatePath = FALSE
                Exit Function
            End If

            ConvertDirToXY CurrMove.direction, xmove, ymove
            ValidMove = TRUE
            SpacesChecked = 1
            currx = CurrMove.x
            curry = CurrMove.y

            ' Check each block in the move.
            Do While SpacesChecked <= CurrMove.Spaces And ValidMove
                currx = currx + xmove
                curry = curry + ymove

                ' Ensure no wall was run into.  If it was, change the spaces so move stops at the wall.
                If currx < 1 Or currx > MazeWidth Or curry < 1 Or curry > MazeHeight Then
                    CurrMove.Spaces = SpacesChecked - 1
                    Exit Do
                End If

                ' Check to see if our own path has been run into.
                If NumberOfWalls(currx, curry) <> 4 Then

                    ' If moved one space, then it is not a valid direction, cancel it.
                    If SpacesChecked = 1 Then
                        ValidMove = FALSE
                        CancelDirection CurrMove, CurrMove.direction

                        ' If there are no more directions to choose from, get rid of the last move.
                        If CurrMove.top + CurrMove.Bottom + CurrMove.Left + CurrMove.Right = 4 Then
                            PopMove CurrMove
                            totalpathlen = totalpathlen - CurrMove.Spaces
                            CancelDirection CurrMove, CurrMove.direction
                            ClosePath CurrMove
                        End If
                        GenerateMove CurrMove ' Generate a new move to check.
                    Else
                        ' Change the spaces before crossing out own path.
                        CurrMove.Spaces = SpacesChecked - 1
                        Exit Do
                    End If
                Else
                    SpacesChecked = SpacesChecked + 1
                End If
            Loop

            ' Make sure that the path is not closing itself off.
            If ValidMove And CheckForClosedArea(CurrMove) Then
                ValidMove = FALSE
                CancelDirection CurrMove, CurrMove.direction
                GenerateMove CurrMove
            End If
        Wend

        If StackPointer < PathLength * 10 Then ' Push the move now.
            StackPointer = StackPointer + 1
            stackVar(StackPointer) = CurrMove
        Else
            MazeError = TRUE
        End If

        ' Process the current move here.
        ConvertDirToXY CurrMove.direction, xmove, ymove
        x = CurrMove.x
        y = CurrMove.y
        For i = 1 To CurrMove.Spaces
            ChangeWall x, y, CurrMove.direction, 0
            x = x + xmove
            y = y + ymove
            PrintBlock MazeArray(x, y), x, y, MazeColor ' Show the path block.
        Next i

        currx = CurrMove.x + CurrMove.Spaces * xmove
        curry = CurrMove.y + CurrMove.Spaces * ymove
        newmove.x = currx
        newmove.y = curry
        totalpathlen = totalpathlen + CurrMove.Spaces
        CurrMove = newmove

        ' Check to see if we are at a wall.
        If currx = MazeWidth Or curry = MazeHeight Or currx = 1 Or curry = 1 Then

            ' If so, is it time to exit?
            If totalpathlen >= PathLength Then
                ExitX = currx
                ExitY = curry
                finished = TRUE
                If ExitY = MazeHeight Then
                    MazeArray(ExitX, ExitY).Bottom = 0
                ElseIf ExitY = 1 Then
                    MazeArray(ExitX, ExitY).top = 0
                ElseIf ExitX = MazeWidth Then
                    MazeArray(ExitX, ExitY).Right = 0
                ElseIf ExitX = 1 Then
                    MazeArray(ExitX, ExitY).Left = 0
                End If
            Else
                ' Ensure we turn away from the exit to prevent the path from
                ' closing itself off.  If the path has touched the far wall already
                ' then touching one of the side walls is no problem.
                If currx = 1 Or currx = MazeWidth Then
                    If EntryY = 1 And Not touched Then CancelDirection CurrMove, CTOP
                    If EntryY = MazeHeight And Not touched Then CancelDirection CurrMove, CBOTTOM
                    If EntryX = currx Then
                        If curry > EntryY Then
                            CancelDirection CurrMove, CTOP
                        Else
                            CancelDirection CurrMove, CBOTTOM
                        End If
                    End If
                    If currx = 1 And EntryX = MazeWidth Then touched = 1
                    If currx = MazeWidth And EntryX = 1 Then touched = 1
                End If
                If curry = 1 Or curry = MazeHeight Then
                    If EntryX = 1 And Not touched Then CancelDirection CurrMove, CLEFT
                    If EntryX = MazeWidth And Not touched Then CancelDirection CurrMove, CRIGHT
                    If EntryY = curry Then
                        If currx > EntryX Then
                            CancelDirection CurrMove, CLEFT
                        Else
                            CancelDirection CurrMove, CRIGHT
                        End If
                    End If
                    If curry = 1 And EntryY = MazeHeight Then touched = TRUE
                    If curry = MazeHeight And EntryY = 1 Then touched = TRUE
                End If
            End If
        End If
    Wend

    If Not MazeError Then CreatePath = TRUE Else CreatePath = FALSE
    On Error GoTo 0

End Function

'--------------------------------------------------------------------------
' DisplayChanges
'
'   Displays a list of changes that the player can easily make.
'
'          PARAMETERS:     None
'--------------------------------------------------------------------------
Sub DisplayChanges
    
    DisplayGameTitle ' Display game title.
    
    Color 7 ' Set colors so text prints white.
    Center "The following game characteristics can be easily changed from", 5
    Center "within the QuickBASIC Interpreter.  To change the values of  ", 6
    Center "these characteristics, locate the corresponding CONST or DATA", 7
    Center "statements in the source code and change their values, then  ", 8
    Center "restart the program (press Shift+F5).                        ", 9
   
    Color 15 ' Set foreground color to bright white.
    Center "Songs played during this game           ", 11
    Center "Size of the maze game grid              ", 12
    Center "How quickly the monsters move           ", 13
    Center "Initial time allowed per maze           ", 14
    Center "Color of Player 1                       ", 15
    Center "Color of Player 2                       ", 16
    Center "Color of the Monsters                   ", 17
    Center "Maze dimensions at each difficulty level", 18
    Center "Amount of time path preview is shown    ", 19
   
    Color 7
    Center "The CONST statements and instructions on changing them are   ", 21
    Center "located at the beginning of the main program.                ", 22
    
    Do While InKey$ = "": Loop ' Wait for any key to be pressed.
    Cls ' Clear screen.

End Sub

'---------------------------------------------------------------------------
' DisplayGameTitle
'
'   Displays title of the game.
'
'       PARAMETERS:   None
'---------------------------------------------------------------------------
Sub DisplayGameTitle
    
    Screen 0 ' Set screen mode 0.
    Width SCREENWIDTH, 25 ' Set width to 80, height to 25.
    Color 4, 0 ' Set colors for red on black.
    Cls ' Clear the screen.
    Locate 1, 2
    Print Chr$(201); String$(76, 205); Chr$(187); ' Draw top border.
    For i% = 2 To 24 ' Draw left and right borders.
        Locate i%, 2
        Print Chr$(186); Tab(79); Chr$(186);
    Next i%
    Locate 25, 2
    Print Chr$(200); String$(76, 205); Chr$(188); ' Draw bottom border.

    'Print game title centered at top of screen
    Color 0, 4 ' Set colors to black on red.
    Center "     Microsoft     ", 1 ' Center game title on lines
    Center "     Q M A Z E     ", 2 ' 1 and 2.
    Center "   Press any key to continue   ", 25
    Color 7, 0

End Sub

'--------------------------------------------------------------------------
' DisplayIntro
'
'   Explains the object of the game and show how to play.
'
'           PARAMETERS:   None
'--------------------------------------------------------------------------
Sub DisplayIntro
    
    DisplayGameTitle ' Display game title
    Color 7 ' Set colors so text prints white.
    Center "Copyright (C) 1990 Microsoft Corporation.  All Rights Reserved.", 4
    Center "You are moving through a maze at breakneck speed, racing the clock or ", 6
    Center "a friend.  The object is to finish the maze before time runs out      ", 7
    Center "or before your opponent finishes.  Monsters can be added to increase  ", 8
    Center "difficulty.  The amount of time allowed to complete the maze increases", 9
    Center "for every monster in the maze.  The player who finishes first wins    ", 10
    Center "the points for the maze.                                              ", 11
    Color 4 ' Change foreground color for line to red.
    Center String$(74, 196), 13 ' Put horizontal red line on screen.
    Color 7 ' Change foreground color back to white.
    Center " Game Controls ", 13 ' Display game controls.
    Center "  General           Player 1 Controls          Player 2 Controls  ", 15
    Center "                         (Up)                       (Up)          ", 17
    Center "  P - Pause               " + Chr$(24) + "                          E            ", 18
    Center "  Q - Quit       (Left) " + Chr$(27) + "   " + Chr$(26) + " (Right)       (Left) S   F (Right)  ", 19
    Center "                        " + Chr$(25) + "                          D          ", 20
    Center "                        (Down)                     (Down)         ", 21

    Play STARTOFGAMESOUND 'Play introductory melody.
    Do 'Wait for any key to be pressed.
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
' DisplayWinner
'
'   Displays a screen between mazes.
'
'           PARAMETERS:  None
'----------------------------------------------------------------------------
Sub DisplayWinner

    Cls ' Clear the screen.
    Line (5, 5)-(315, 195), , B ' Draw a border.
    Diff = NumOfMazes - MazesFinished ' Determine number of mazes remaining.
    Locate 3, 16
    If Diff = 0 Then Print "GAME OVER" Else Print "Maze #"; MazesFinished

    Locate 6, 5
    If Player(1).Done Then ' Display number of seconds player 1 took to complete the maze.
        Print "Player 1 finished in"; MazeTime - Player(1).TimeLeft; "seconds"
    Else
        Print "Player 1 did not finish!"
    End If
 
    Temp = Player(1).TimeLeft - Player(2).TimeLeft
    Locate 10, 5
    If Temp = 0 Then
        If NumOfPlayers = 2 Then ' Message based on number of players.
            Print "Tie maze: nobody wins this round"
        Else
            Print "Player 1 loses this round"
        End If
    Else
        If Sgn(Temp) = 1 Then Win = 1 Else Win = 2 ' Determine who won.
        Print "Player"; Win; "wins maze by"; Abs(Temp); "seconds!"
        Player(Win).Score = Player(Win).Score + Abs(Temp) * 100
    End If
    Locate 13, 9: Print Using "Player 1 score: ###,###"; Player(1).Score
 
    If NumOfPlayers = 2 Then ' For two players.
        Locate 8, 5
        If Player(2).Done Then
            Print "Player 2 finished in"; MazeTime - Player(2).TimeLeft; "seconds"
        Else
            Print "Player 2 did not finish!"
        End If
        Locate 15, 9: Print Using "Player 2 score: ###,###"; Player(2).Score
    End If

    Do: Loop Until InKey$ = "" ' Clear keyboard buffer.
    If Diff > 0 And Not GameOver Then
        Locate 20, 8: Print "Number of mazes left:"; Diff
        Play ENDOFMAZESOUND ' Play maze completion melody.
        Locate 23, 6: Print "<Press Spacebar for next maze>"
        MazesFinished = MazesFinished + 1 ' Add one to the number of mazes completed.
        While InKey$ <> " ": Wend
    Else
        If NumOfPlayers = 2 Then
            Locate 18, 5
            Hold& = Player(1).Score - Player(2).Score
            If Hold& = 0 Then
                Print "EQUAL POINTS - This is a tie game!" ' Announce a tie.
            Else
                If Sgn(Hold&) = 1 Then Win = 1 Else Win = 2
                Print "PLAYER"; Win; "WINS GAME BY"; Abs(Hold&); "POINTS!" ' Announce winner.
            End If
        End If
        GameOver = TRUE
        Play ENDOFGAMESOUND ' Play end-of-game melody.
    End If
    
End Sub

'--------------------------------------------------------------------------
' DrawMonster
'
'   Draws a monster given the color and the x,y coordinate of where it is
'   in the maze.
'
'           PARAMETERS:    X         - X coordinate of the monster
'                          Y         - Y coordinate of the monster
'                          WhatColor - Color of the monster
'--------------------------------------------------------------------------
Sub DrawMonster (x, y, WhatColor)

    Circle (StartX + x * BLOCKSIZE + BLOCKSIZE / 2, StartY + y * BLOCKSIZE + BLOCKSIZE / 2), (BLOCKSIZE / 2 - 2), WhatColor

End Sub

'---------------------------------------------------------------------------
' DrawPlayer
'
'   Draws a player given the color and player.
'
'           PARAMETERS:  Player    - Which player to draw
'                        WhatColor - Player color
'---------------------------------------------------------------------------
Sub DrawPlayer (Player, WhatColor)

    If Player = 1 Then
        Line (StartX + Player(1).x * BLOCKSIZE + BLOCKSIZE / 4 + 1, StartY + Player(1).y * BLOCKSIZE + BLOCKSIZE / 4 + 1)-(StartX + Player(1).x * BLOCKSIZE + BLOCKSIZE * .75 - 1, StartY + Player(1).y * BLOCKSIZE + BLOCKSIZE * .75 - 1), WhatColor, BF
    Else
        Line (StartX + Player(2).x * BLOCKSIZE + BLOCKSIZE / 4, StartY + Player(2).y * BLOCKSIZE + BLOCKSIZE / 4)-(StartX + Player(2).x * BLOCKSIZE + BLOCKSIZE * .75, StartY + Player(2).y * BLOCKSIZE + BLOCKSIZE * .75), WhatColor, B
    End If

End Sub

'----------------------------------------------------------------------------
' GenerateMaze
'
'   Initializes the maze variables and picks a starting point for the maze,
'   then calls two routines which complete the maze.
'
'           PARAMETERS:   None
'---------------------------------------------------------------------------
Sub GenerateMaze
    
    ReDim MazeArray(MazeWidth, MazeHeight) As MazeType 'Make sure the MazeArray is big enough.
    StackPointer = 1
    For i = 1 To MazeWidth ' Initialize the maze so every wall is up.
        For j = 1 To MazeHeight
            MazeArray(i, j).Left = 1: MazeArray(i, j).Right = 1
            MazeArray(i, j).top = 1: MazeArray(i, j).Bottom = 1
        Next j
    Next i
    Cls ' Clear and show the maze grid.
    PrintMaze

    Entrydir = Rnd(1) ' Choose the entry point for the maze.
    Entryside = Rnd(1)
    If Entrydir > .5 Then
        EntryX = Int(Rnd(1) * MazeWidth) + 1
        If Entryside > .5 Then
            EntryY = MazeHeight
            MazeArray(EntryX, EntryY).Bottom = 0
        Else
            EntryY = 1
            MazeArray(EntryX, EntryY).top = 0
        End If
    Else
        EntryY = Int(Rnd(1) * MazeHeight) + 1
        If Entryside > .5 Then
            EntryX = MazeWidth
            MazeArray(EntryX, EntryY).Right = 0
        Else
            EntryX = 1
            MazeArray(EntryX, EntryY).Left = 0
        End If
    End If

    ' With more complex mazes that require more moves, the stack array may
    ' need to be made larger.  Currently, no problems.
    ReDim stackVar(1 To PathLength * 10) As MoveType

    If Not CreatePath Then
        GenerateMaze ' Call GenerateMaze again
    Else
        first! = Timer ' Set up a small delay for user to see path.
        Do: Loop Until Timer > first! + SHOWDELAY
        Cls ' Clear screen from players.
        If ScreenMode = 7 Then Color 14
        Locate 2, 11: Print "Generating maze..."
        CompleteMaze
        Locate 2, 11: Print Space$(20)
    End If

End Sub

'----------------------------------------------------------------------------
' GenerateMove
'
'   Generates a random move for the valid maze path to make. Decides what
'   directions it may move in, then choose one of the directions.  Generate
'   a random number of spaces to move in the given direction based on the
'   turn rate.  A variable of type MoveType will have a value of 1 in a
'   field if a move in that direction is invalid.
'
'           PARAMETERS:  move - User-defined type that contains the current
'                               valid moves for a square
'-----------------------------------------------------------------------------
Sub GenerateMove (move As MoveType)
    
    ' Determine how many directions are valid, and choose one.
    If move.y = 1 Then
        move.top = 1
    ElseIf MazeArray(move.x, move.y - 1).top + MazeArray(move.x, move.y - 1).Bottom + MazeArray(move.x, move.y - 1).Left + MazeArray(move.x, move.y - 1).Right <> 4 Then
        move.top = 1
    End If

    If move.y = MazeHeight Then
        move.Bottom = 1
    ElseIf MazeArray(move.x, move.y + 1).top + MazeArray(move.x, move.y + 1).Bottom + MazeArray(move.x, move.y + 1).Left + MazeArray(move.x, move.y + 1).Right <> 4 Then
        move.Bottom = 1
    End If

    If move.x = 1 Then
        move.Left = 1
    ElseIf MazeArray(move.x - 1, move.y).top + MazeArray(move.x - 1, move.y).Bottom + MazeArray(move.x - 1, move.y).Left + MazeArray(move.x - 1, move.y).Right <> 4 Then
        move.Left = 1
    End If

    If move.x = MazeWidth Then
        move.Right = 1
    ElseIf MazeArray(move.x + 1, move.y).top + MazeArray(move.x + 1, move.y).Bottom + MazeArray(move.x + 1, move.y).Left + MazeArray(move.x + 1, move.y).Right <> 4 Then
        move.Right = 1
    End If


    AvailableMoves = 4 - (move.Left + move.Right + move.top + move.Bottom)
   
    If AvailableMoves = 0 Then
        move.direction = 0
        move.Spaces = 1
        Exit Sub
    End If
   
    NewDirection = Int(Rnd(1) * AvailableMoves) + 1
    
    ' Determine what direction was randomly chosen.
    Counter = 1
    If move.top = 0 Then
        If NewDirection = Counter Then
            move.direction = CTOP
        End If
        Counter = Counter + 1
    End If

    If move.Bottom = 0 Then
        If NewDirection = Counter Then
            move.direction = CBOTTOM
        End If
        Counter = Counter + 1
    End If
   
    If move.Left = 0 Then
        If NewDirection = Counter Then
            move.direction = CLEFT
        End If
        Counter = Counter + 1
    End If
   
    If move.Right = 0 Then
        If NewDirection = Counter Then
            move.direction = CRIGHT
        End If
        Counter = Counter + 1
    End If

    move.Spaces = Int(Rnd(1) * TurnRate) + 1 ' Decide how far to go in the chosen direction

End Sub

'--------------------------------------------------------------------------
' GetGameOptions
'
'   Prompts for and saves various game parameters.
'
'           PARAMETERS:   None
'--------------------------------------------------------------------------
Sub GetGameOptions

    Screen 0 ' Set screen mode 0.
    Width SCREENWIDTH, 25 ' Set width to 80, height to 25.,
    Color 7, 0 ' Set colors to white on black.
    Cls ' Clear the screen.
    Locate 7, 20: Print "Default is"; DEFAULTPLAYERS
    Color 15
    Do ' Get the number of Players.
        Locate 6, 23: Print Space$(50)
        Locate 6, 23
        Input "How many players? (1 or 2) ", InputHold$
    Loop Until InputHold$ = "1" Or InputHold$ = "2" Or Len(InputHold$) = 0
    NumOfPlayers = Val(InputHold$)
    If NumOfPlayers = 0 Then NumOfPlayers = DEFAULTPLAYERS

    Color 7
    Locate 10, 20: Print "Default is"; DEFAULTLEVEL
    Color 15 ' Change foreground color to bright white.
    Do ' Get the difficulty level.
        Locate 9, 23: Print Space$(50)
        Locate 9, 23
        Input "Difficulty level? (1 to 5) ", InputHold$
        Level = Val(Left$(InputHold$, 1))
    Loop Until (Level > 0 And Level <= MAXLEVEL And Len(InputHold$) < 2) Or (Len(InputHold$) = 0)
    If Level = 0 Then Level = DEFAULTLEVEL

    Color 7 ' Change foreground color back to white.
    Locate 13, 20: Print "Default is"; DEFAULTNUMMAZES
    Color 15
    Do ' Get number of mazes to create.
        Locate 12, 23: Print Space$(50)
        Locate 12, 23
        Input "Play how many mazes? (1 to 10) ", InputHold$
        NumOfMazes = Val(Left$(InputHold$, 2))
    Loop Until (NumOfMazes > 0 And NumOfMazes <= MAXMAZES And Len(InputHold$) < 3) Or (Len(InputHold$) = 0)
    If NumOfMazes = 0 Then NumOfMazes = DEFAULTNUMMAZES

    Color 7 ' Change foreground color back to white.
    Locate 16, 20: Print "Default is"; DEFAULTMONSTERS
    Color 15
    Do ' Get number of monsters; allow for 0 entry.
        Locate 15, 23: Print Space$(50)
        Locate 15, 23
        Input "How many monsters? (0 to 10) ", InputHold$
        AvailMonsters = Val(Left$(InputHold$, 2))
        If AvailMonsters = 0 And InputHold$ <> "0" Then AvailMonsters = -1
    Loop Until (AvailMonsters > -1 And AvailMonsters <= MAXMONSTERS And Len(InputHold$) < 3) Or (Len(InputHold$) = 0)
    If Len(InputHold$) = 0 Then AvailMonsters = DEFAULTMONSTERS

    Color 7 ' Change foreground color back to white.
    Locate 19, 20: Print "Default is ";
    If DEFAULTSHOWMAZE Then Print "YES" Else Print "NO"
    Color 15
    Do ' Get visible or invisible maze choice
        Locate 18, 23: Print Space$(40)
        Locate 18, 23
        Print "Visible mazes? (Y or N) ";
        Input "", InputHold$
        InputHold$ = UCase$(InputHold$)
    Loop Until (InputHold$ = "Y") Or (InputHold$ = "N") Or (Len(InputHold$) = 0)
    If InputHold$ = "N" Then
        ShowMaze = FALSE
    ElseIf InputHold$ = "Y" Then
        ShowMaze = TRUE
    Else
        ShowMaze = DEFAULTSHOWMAZE ' Use the default.
    End If

End Sub

'---------------------------------------------------------------------------
' GetMonsterDirection
'
'   Decides which direction a monster should move given its current position
'   and the direction it had been moving.  Currently, the direction is chosen
'   as follows: Determine how many directions the monster has a choice of
'   moving. Based on this, determine a percentage which is the likelihood
'   of continuing in the same direction.  If the monster isn't to move in the
'   same direction, a new direction is chosen (it may be the same direction
'   that it was moving before).  This routine decides how smart the monsters
'   will be.
'
'           PARAMETERS:      X         - X coordinate of the monster
'                            Y         - Y coordinate of the monster
'                            direction - Current direction of the monster
'                                        movement
'---------------------------------------------------------------------------
Function GetMonsterDirection (x, y, direction)

    NewDirection = FALSE ' Assume it's not changing direction.

    ' Determine how many directions are available.
    AvailableDirections = 4 - NumberOfWalls(x, y)
    If (x = ExitX And y = ExitY) Or (x = EntryX And y = EntryY) Then
        AvailableDirections = AvailableDirections - 1
    End If

    ' Decides the percentage of whether the monster will continue in the same direction.
    ContinueDirection = 1 - (AvailableDirections - 1) * .25
    Select Case direction
        Case CTOP
            If MazeArray(x, y).top = 0 And y > 1 And Rnd(1) < ContinueDirection Then GetMonsterDirection = direction
        Case CBOTTOM
            If MazeArray(x, y).Bottom = 0 And y < MazeHeight And Rnd(1) < ContinueDirection Then GetMonsterDirection = direction
        Case CLEFT
            If MazeArray(x, y).Left = 0 And x > 1 And Rnd(1) < ContinueDirection Then GetMonsterDirection = direction
        Case CRIGHT
            If MazeArray(x, y).Right = 0 And x < MazeWidth And Rnd(1) < ContinueDirection Then GetMonsterDirection = direction
        Case Else
            NewDirection = TRUE
    End Select

    If Not NewDirection Then Exit Function ' If monster doesn't change direction.

    NewDirection = Int(Rnd(1) * AvailableDirections) + 1 ' Pick a new direction.
    Counter = 1
    If MazeArray(x, y).top = 0 And y > 1 Then
        If NewDirection = Counter Then GetMonsterDirection = CTOP
        Counter = Counter + 1
    End If
    If MazeArray(x, y).Bottom = 0 And y < MazeHeight Then
        If NewDirection = Counter Then GetMonsterDirection = CBOTTOM
        Counter = Counter + 1
    End If
    If MazeArray(x, y).Left = 0 And x > 1 Then
        If NewDirection = Counter Then GetMonsterDirection = CLEFT
        Counter = Counter + 1
    End If
    If MazeArray(x, y).Right = 0 And x < MazeWidth Then
        If NewDirection = Counter Then GetMonsterDirection = CRIGHT
        Counter = Counter + 1
    End If

End Function

'---------------------------------------------------------------------------
' InitVariables
'
'   Initializes player keys and game variables.
'
'           PARAMETERS:      None
'---------------------------------------------------------------------------
Sub InitVariables

    KEY 15, Chr$(0) + Chr$(25) ' P key (Pause)
    KEY 16, Chr$(0) + Chr$(16) ' Q key (Quit)
    KEY 21, Chr$(128) + Chr$(72) ' Extended Up key for player 1.
    KEY 22, Chr$(128) + Chr$(75) ' Extended Left key for player 1.
    KEY 23, Chr$(128) + Chr$(77) ' Extended Right key for player 1.
    KEY 24, Chr$(128) + Chr$(80) ' Extended Down key for player 1.

    'ON KEY (X) indicates what subroutine to jump to when KEY (X) is pressed.
    On Key(11) GoSub MovePlayer1Up
    On Key(12) GoSub MovePlayer1Left
    On Key(13) GoSub MovePlayer1Right
    On Key(14) GoSub MovePlayer1Down
    On Key(15) GoSub PauseGame ' Pause the game.
    On Key(16) GoSub QuitGame ' Quit the game.
    On Key(21) GoSub MovePlayer1Up
    On Key(22) GoSub MovePlayer1Left
    On Key(23) GoSub MovePlayer1Right
    On Key(24) GoSub MovePlayer1Down
    On Timer(1) GoSub TimerUpdate 'Timer interrupts every second.

    If NumOfPlayers = 2 Then
        KEY 17, Chr$(0) + Chr$(UP2) 'Up for player 2.
        KEY 18, Chr$(0) + Chr$(DOWN2) 'Down for player 2.
        KEY 19, Chr$(0) + Chr$(LEFT2) 'Left for player 2.
        KEY 20, Chr$(0) + Chr$(RIGHT2) 'Right for player 2.
        On Key(17) GoSub MovePlayer2Up '17 is the UP for player 2.
        On Key(18) GoSub MovePlayer2Down '18 is the DOWN key for player 2.
        On Key(19) GoSub MovePlayer2Left '19 is the LEFT key for player 2.
        On Key(20) GoSub MovePlayer2Right '20 is the RIGHT key for player 2.
    End If

    For i = 1 To 2 ' Initialize player variables.
        Player(i).Score = 0
        Player(i).TimeLeft = 0
        Player(i).Done = FALSE
    Next i
                                      
    If ScreenMode = 7 Then ' Set up correct screen colors for mode 7.
        MazeColor = MAZECOLOR7
        Player(1).PColor = PLAYER1COLOR7
        Player(2).PColor = PLAYER2COLOR7
        MonsterColor = MONSTERCOLOR7
        GameBkGround = GAMEBKGROUND7
    Else
        MazeColor = MAZECOLOR1 ' Set up correct screen colors for mode 1.
        Player(1).PColor = PLAYER1COLOR1
        Player(2).PColor = PLAYER2COLOR1
        MonsterColor = MONSTERCOLOR1
        GameBkGround = GAMEBKGROUND1
    End If
    GameOver = FALSE
    MazesFinished = 1
    MazeTime = DEFAULTTIME + AvailMonsters * 5 - (Level - 1) * 5 ' Number of seconds to finish all mazes.  Allow 5 more seconds for each monster.
    MonsterUpdateTime = DEFAULTMONSTERTIME
    Restore ' Restore and reread DATA statements.
    For i = 1 To Level
        Read MazeWidth, MazeHeight, PathLength, TurnRate
    Next
    StartX = (300 / BLOCKSIZE - MazeWidth) / 2 * BLOCKSIZE + 1
    StartY = (180 / BLOCKSIZE - MazeHeight) / 2 * BLOCKSIZE + 1
    
End Sub

'--------------------------------------------------------------------------
' Keys
'
'   Turns key event-processing on, off, or temporarily stops.
'
'           PARAMETERS:   onoff - If it's 1 = enable, 2 = disable, 3 = stop.
'--------------------------------------------------------------------------
Sub Keys (onoff)

    For i = 11 To 24 ' Loop through all defined keys.
        Select Case onoff
            Case 1
                Key(i) On
            Case 2
                Key(i) Off
            Case 3
                Key(i) Stop
        End Select
    Next i

End Sub

'----------------------------------------------------------------------------
' MonsterControl
'
'   Controls, checks and updates the monsters.  Checks
'   to see if any of the players have moved into any of the monsters.
'
'               PARAMETERS:   None
'----------------------------------------------------------------------------
Sub MonsterControl Static

    If UBound(Monsters) <> AvailMonsters Then ' Initialize monster array.
        ReDim Monsters(1 To AvailMonsters) As MonsterType
        NumMonsters = 0
    End If

    Keys (3) ' Temporarily stop arrow keys processing.
    For i = 1 To NumMonsters ' Check for players hitting monsters.
        For j = 1 To NumOfPlayers
            If Monsters(i).x = Player(j).x And Monsters(i).y = Player(j).y And Monsters(i).Active Then
                Player(j).Dead = TRUE
                Play PLAYERDEATHSOUND
                DrawPlayer j, GameBkGround
            End If
        Next j
    Next i
    Keys (1) ' Enable key event-processing.

    If NumMonsters < AvailMonsters Then ' Add another monster to the maze if there isn't the right number.
        NumMonsters = NumMonsters + 1
        If NumMonsters Mod 3 = 1 Then ' Add every third one at the exit of the maze.
            Monsters(NumMonsters).x = ExitX
            Monsters(NumMonsters).y = ExitY
        Else
            ' Choose a point along the last 80 percent of the valid path to place the monster.
            RandomPlace = Int(Rnd(1) * (StackPointer - StackPointer * .2)) + StackPointer * .2
            Monsters(NumMonsters).x = stackVar(RandomPlace).x
            Monsters(NumMonsters).y = stackVar(RandomPlace).y
        End If
        Monsters(NumMonsters).Active = TRUE
    End If
    If Timer - LastUpdate! < MonsterUpdateTime Then Exit Sub
    LastUpdate! = Timer

    For i = 1 To NumMonsters ' Move the monsters.
        If Monsters(i).Active Then
            Dir = GetMonsterDirection(Monsters(i).x, Monsters(i).y, Monsters(i).direction)
            Monsters(i).direction = Dir
            DrawMonster Monsters(i).x, Monsters(i).y, GameBkGround ' Erase current position.
            ConvertDirToXY Dir, xmove, ymove
            Monsters(i).x = Monsters(i).x + xmove
            Monsters(i).y = Monsters(i).y + ymove
            DrawMonster Monsters(i).x, Monsters(i).y, MonsterColor
        End If
    Next i

    Keys (3) ' Temporarily stop arrow keys processing.
    For i = 1 To NumMonsters ' Check for monsters hitting players.
        For j = 1 To NumOfPlayers
            If Monsters(i).x = Player(j).x And Monsters(i).y = Player(j).y And Monsters(i).Active Then
                Player(j).Dead = TRUE ' Kill the player
                Play PLAYERDEATHSOUND ' Play death melody.
                DrawPlayer j, GameBkGround
            End If
        Next j
    Next i
    Keys (1) ' Enable key event-processing.

End Sub

'---------------------------------------------------------------------------
' NumberOfWalls
'
'   Returns the number of walls in a given block.
'
'           PARAMETERS:    X - X coordinate of the maze square to be checked
'                          Y - Y coordinate of the maze square to be checked
'---------------------------------------------------------------------------
Function NumberOfWalls (x, y)

    NumberOfWalls = MazeArray(x, y).top + MazeArray(x, y).Bottom + MazeArray(x, y).Left + MazeArray(x, y).Right

End Function

'--------------------------------------------------------------------------
' PlayGame
'
'   Loops until a given maze is exited or the game is ended.
'   The basic flow of the routine is to update all of the various things like
'   monsters, scores, and checks to see if somebody was killed.
'
'               PARAMETERS:    None
'--------------------------------------------------------------------------
Sub PlayGame

    PrintMaze ' Show the maze.

    If ExitY = MazeHeight Then ' Print the exit path markers.
        Line (StartX + ExitX * BLOCKSIZE, StartY + ExitY * BLOCKSIZE + BLOCKSIZE - 1)-(StartX + ExitX * BLOCKSIZE, StartY + ExitY * BLOCKSIZE + BLOCKSIZE + 2), 12, BF
        Line (StartX + ExitX * BLOCKSIZE + BLOCKSIZE, StartY + ExitY * BLOCKSIZE + BLOCKSIZE - 1)-(StartX + ExitX * BLOCKSIZE + BLOCKSIZE, StartY + ExitY * BLOCKSIZE + BLOCKSIZE + 2), 12, BF
    ElseIf ExitY = 1 Then
        Line (StartX + ExitX * BLOCKSIZE, StartY + ExitY * BLOCKSIZE - 2)-(StartX + ExitX * BLOCKSIZE, StartY + ExitY * BLOCKSIZE + 1), 12, BF
        Line (StartX + ExitX * BLOCKSIZE + BLOCKSIZE, StartY + ExitY * BLOCKSIZE - 2)-(StartX + ExitX * BLOCKSIZE + BLOCKSIZE, StartY + ExitY * BLOCKSIZE + 1), 12, BF
    ElseIf ExitX = MazeWidth Then
        Line (StartX + ExitX * BLOCKSIZE + BLOCKSIZE - 1, StartY + ExitY * BLOCKSIZE)-(StartX + ExitX * BLOCKSIZE + BLOCKSIZE + 2, StartY + ExitY * BLOCKSIZE), 12, BF
        Line (StartX + ExitX * BLOCKSIZE + BLOCKSIZE - 1, StartY + ExitY * BLOCKSIZE + BLOCKSIZE)-(StartX + ExitX * BLOCKSIZE + BLOCKSIZE + 2, StartY + ExitY * BLOCKSIZE + BLOCKSIZE), 12, BF
    ElseIf ExitX = 1 Then
        Line (StartX + ExitX * BLOCKSIZE - 2, StartY + ExitY * BLOCKSIZE)-(StartX + ExitX * BLOCKSIZE + 1, StartY + ExitY * BLOCKSIZE), 12, BF
        Line (StartX + ExitX * BLOCKSIZE - 2, StartY + ExitY * BLOCKSIZE + BLOCKSIZE)-(StartX + ExitX * BLOCKSIZE + 1, StartY + ExitY * BLOCKSIZE + BLOCKSIZE), 12, BF
    End If
    
    For i = 1 To NumOfPlayers ' Initialize needed values.
        Player(i).x = EntryX
        Player(i).y = EntryY
        Player(i).TimeLeft = 0
        Player(i).Done = FALSE
        Player(i).Dead = FALSE
        DrawPlayer i, Player(i).PColor ' Draw player(s).
    Next i
    CountDown = MazeTime ' Set time allowed to solve maze.
    MazeOver = FALSE
    Locate 1, 3: Print "Time left:"; CountDown; ' Display time left.
    Locate 1, 31: Print "Maze:"; MazesFinished; ' Display mazes finished.
    
    If NumOfPlayers = 1 Then ' Different for one or two players.
        Line (191, 194)-(194, 197), Player(1).PColor, BF
        Locate 25, 15
    Else
        Locate 25, 3: Print "Player 2:";
        Line (93, 193)-(98, 198), Player(2).PColor, B
        Line (275, 193)-(278, 196), Player(1).PColor, BF
        Locate 25, 26
    End If
    Print "Player 1:";
    Sound 500, 3 ' 500Hz tone for 3 clock ticks.
    Keys (1) ' Enable key event-processing.
    Timer On

    ' This is the loop which runs until quit, both players are out, or time's up.
    Do
        Do: Loop Until InKey$ = "" ' Clear keyboard buffer.
        If AvailMonsters > 0 Then MonsterControl

        For i = 1 To NumOfPlayers ' Check to see if any of the players have been killed in the last update.
            If Player(i).Dead Then
                Player(i).Dead = FALSE
                Player(i).x = EntryX
                Player(i).y = EntryY
                DrawPlayer i, Player(i).PColor
            End If
        Next i

        If NumOfPlayers = 2 And Player(1).Done And Player(2).Done Then
            MazeOver = TRUE
        ElseIf NumOfPlayers = 1 And Player(1).Done Then
            MazeOver = TRUE
        End If
    Loop Until MazeOver Or GameOver Or CountDown = 0
    Timer Off
    Keys (2) ' Disable key event-processing.
    
End Sub

'--------------------------------------------------------------------------
' PopMove
'
'   Removes the previous path move from the top of the stack and returns it.
'
'               PARAMETERS:    move - The previous move that will be returned
'                                     from the top of stackVar array
'--------------------------------------------------------------------------
Sub PopMove (move As MoveType)

    If StackPointer <> 0 Then
        move = stackVar(StackPointer)
        StackPointer = StackPointer - 1
    Else
        MazeError = TRUE
    End If

End Sub

'---------------------------------------------------------------------------
' PrintBlock
'
'   Prints the walls of a given block in the color specified and uses the
'   background color to print walls that have been removed.
'
'       PARAMETERS: block     - Block to draw
'                   X         - X coordinate of the block to be drawn
'                   Y         - Y coordinate of the block to be drawn
'                   whatColor - Color of the block to be drawn
'---------------------------------------------------------------------------
Sub PrintBlock (block As MazeType, x, y, WhatColor)

    ActualX = StartX + x * BLOCKSIZE
    ActualY = StartY + y * BLOCKSIZE
    If block.top = 1 Then
        Line (ActualX, ActualY)-(ActualX + BLOCKSIZE, ActualY), WhatColor
    Else
        Line (ActualX + 1, ActualY)-(ActualX + BLOCKSIZE - 1, ActualY), GameBkGround
    End If

    If block.Bottom = 1 Then
        Line (ActualX, ActualY + BLOCKSIZE)-(ActualX + BLOCKSIZE, ActualY + BLOCKSIZE), WhatColor
    Else
        Line (ActualX + 1, ActualY + BLOCKSIZE)-(ActualX + BLOCKSIZE - 1, ActualY + BLOCKSIZE), GameBkGround
    End If

    If block.Left = 1 Then
        Line (ActualX, ActualY)-(ActualX, ActualY + BLOCKSIZE), WhatColor
    Else
        Line (ActualX, ActualY + 1)-(ActualX, ActualY + BLOCKSIZE - 1), GameBkGround
    End If

    If block.Right = 1 Then
        Line (ActualX + BLOCKSIZE, ActualY)-(ActualX + BLOCKSIZE, ActualY + BLOCKSIZE), WhatColor
    Else
        Line (ActualX + BLOCKSIZE, ActualY + 1)-(ActualX + BLOCKSIZE, ActualY + BLOCKSIZE - 1), GameBkGround
    End If

End Sub

'---------------------------------------------------------------------------
' PrintMaze
'
'   Prints out the entire maze or just the outside edge.
'
'               PARAMETERS:  None
'---------------------------------------------------------------------------
Sub PrintMaze

    If ShowMaze Then ' Print the whole maze.
        For i = 1 To MazeHeight
            For j = 1 To MazeWidth
                PrintBlock MazeArray(j, i), j, i, MazeColor
            Next j
        Next i
    Else ' Print just the outside edge of the maze.
        For i = 1 To MazeWidth
            PrintBlock MazeArray(i, 1), i, 1, MazeColor
            PrintBlock MazeArray(i, MazeHeight), i, MazeHeight, MazeColor
        Next i
        For j = 1 To MazeHeight
            PrintBlock MazeArray(1, j), 1, j, MazeColor
            PrintBlock MazeArray(MazeWidth, j), MazeWidth, j, MazeColor
        Next j
    End If

End Sub

'---------------------------------------------------------------------------
' ProcessPlayerInput
'
'   Processes the player input.
'
'               PARAMETERS:   i  -   Player number to be processed
'---------------------------------------------------------------------------
Sub ProcessPlayerInput (i)

    Keys (3) ' Temporarily stop arrow keys processing.
    If PlayerMove(i) <> 0 And Not Player(i).Done And Not Player(i).Dead Then 'Only if player input and not done

        ValMove = FALSE ' Check for valid direction.
        Select Case PlayerMove(i)
            Case CTOP
                If MazeArray(Player(i).x, Player(i).y).top = 0 And Player(i).y > 1 Then ValMove = TRUE
            Case CBOTTOM
                If MazeArray(Player(i).x, Player(i).y).Bottom = 0 And Player(i).y < MazeHeight Then ValMove = TRUE
            Case CLEFT
                If MazeArray(Player(i).x, Player(i).y).Left = 0 And Player(i).x > 1 Then ValMove = TRUE
            Case CRIGHT
                If MazeArray(Player(i).x, Player(i).y).Right = 0 And Player(i).x < MazeWidth Then ValMove = TRUE
        End Select

        If ValMove Then
            UpdatePosition PlayerMove(i), i
        Else
            Select Case PlayerMove(i) ' If invalid, check maze exit
                Case CTOP
                    If MazeArray(Player(i).x, Player(i).y).top = 0 And Player(i).y = 1 Then ValMove = TRUE
                Case CBOTTOM
                    If MazeArray(Player(i).x, Player(i).y).Bottom = 0 And Player(i).y = MazeHeight Then ValMove = TRUE
                Case CLEFT
                    If MazeArray(Player(i).x, Player(i).y).Left = 0 And Player(i).x = 1 Then ValMove = TRUE
                Case CRIGHT
                    If MazeArray(Player(i).x, Player(i).y).Right = 0 And Player(i).x = MazeWidth Then ValMove = TRUE
            End Select

            If Player(i).x <> ExitX Or Player(i).y <> ExitY Then ValMove = FALSE

            If ValMove Then
                Player(i).Done = TRUE
                Player(i).TimeLeft = CountDown
                UpdatePosition PlayerMove(i), i
                Play PLAYEROUTSOUND ' Play the melody for when the player exits the maze.

            End If
        End If
        PlayerMove(i) = 0 ' Clear player move.
    End If
    Keys (1) ' Enable key event-processing.

End Sub

'-------------------------------------------------------------------------
' UpdatePosition
'
'   Updates the player's coordinates and moves the player.  Also draws the
'   blocks of the maze around the player.  This allows the player
'   to see one space in any direction when travelling through an invisible
'   maze.
'
'           PARAMETERS:   Dir - Direction of travel
'                         Plr - Player number whose position is being shown
'-------------------------------------------------------------------------
Sub UpdatePosition (Dir, Plr)

    DrawPlayer Plr, GameBkGround ' Draw player.
    ConvertDirToXY Dir, xmove, ymove
    Player(Plr).x = Player(Plr).x + xmove
    Player(Plr).y = Player(Plr).y + ymove

    If Not ShowMaze Then
        If Player(Plr).x >= 1 And Player(Plr).x <= MazeWidth And Player(Plr).y >= 1 And Player(Plr).y <= MazeHeight Then
            PrintBlock MazeArray(Player(Plr).x, Player(Plr).y), Player(Plr).x, Player(Plr).y, MazeColor
            If Player(Plr).x - 1 > 0 Then PrintBlock MazeArray(Player(Plr).x - 1, Player(Plr).y), (Player(Plr).x - 1), Player(Plr).y, MazeColor
            If Player(Plr).x + 1 <= MazeWidth Then PrintBlock MazeArray(Player(Plr).x + 1, Player(Plr).y), (Player(Plr).x + 1), Player(Plr).y, MazeColor
            If Player(Plr).y - 1 > 0 Then PrintBlock MazeArray(Player(Plr).x, Player(Plr).y - 1), Player(Plr).x, (Player(Plr).y - 1), MazeColor
            If Player(Plr).y + 1 <= MazeHeight Then PrintBlock MazeArray(Player(Plr).x, Player(Plr).y + 1), Player(Plr).x, (Player(Plr).y + 1), MazeColor
        End If
    End If
    DrawPlayer Plr, Player(Plr).PColor ' Draw player.

End Sub

'-------------------------------------------------------------------------
' ValidBustDir
'
'   Returns the direction of a wall to remove.  Ensures that no
'   walls on the edge of the maze are broken out.
'
'           PARAMETERS:  X - X coordinate of the block being checked for
'                            removal
'                        Y - Y coordinate of the block being checked for
'                            removal
'-------------------------------------------------------------------------
Function ValidBustDir (x, y)

    Dim BreakableWalls As MazeType
    BreakableWalls = MazeArray(x, y)
    If x = 1 Then BreakableWalls.Left = 0
    If x = MazeWidth Then BreakableWalls.Right = 0
    If y = 1 Then BreakableWalls.top = 0
    If y = MazeHeight Then BreakableWalls.Bottom = 0

    AvailableMoves = BreakableWalls.Left + BreakableWalls.Right + BreakableWalls.top + BreakableWalls.Bottom
    NewDirection = Int(Rnd(1) * AvailableMoves) + 1
    Counter = 1
    If BreakableWalls.top = 1 Then
        If NewDirection = Counter Then ValidBustDir = CTOP
        Counter = Counter + 1
    End If
    If BreakableWalls.Bottom = 1 Then
        If NewDirection = Counter Then ValidBustDir = CBOTTOM
        Counter = Counter + 1
    End If
    If BreakableWalls.Left = 1 Then
        If NewDirection = Counter Then ValidBustDir = CLEFT
        Counter = Counter + 1
    End If
    If BreakableWalls.Right = 1 Then
        If NewDirection = Counter Then ValidBustDir = CRIGHT
        Counter = Counter + 1
    End If

End Function

