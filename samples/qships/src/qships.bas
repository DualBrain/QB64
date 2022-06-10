'                                QSHIPS.BAS
'
'         Copyright (C) 1990 Microsoft Corporation. All Rights Reserved.
'
' QShips puts two players in a ship-to-ship cannon duel.  Adjust your cannon
' fire to the correct angle and velocity to sink your opponent.  An island,
' the shifting wind, and a moving opponent make each shot a new challenge.
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
' statements below these comments can be modified to change the following:
'    Size of the island
'    Number of trees on the island
'    Strength of gravity that affects your shots
'    Default number of hits needed to win the game.
'    Maximum velocity your cannons can fire.
'    Sounds of the cannon firing and the explosions
'
' On the right side of each CONST statement, there is a comment that tells
' you what it does and how big or small you can set the value.
'
' On your own, you can also add exciting sound and visual effects or make
' any other changes that your imagination can dream up.  By reading the
' Learn BASIC Now book, you'll learn the techniques that will enable you
' to fully customize this game and to create games of your own.
'
' If the game won't run after you have changed it, you can exit without
' saving your changes by pressing Alt, F, X and choosing NO.
'
' If you do want to save your changes, press Alt, F, A and enter a filename
' for saving your version of the program.  Before saving your changes,
' however, make sure the program still works by running the program and
' verifying that your changes produce the desired results.  Also, always
' be sure to keep a backup of the original program.
'
DefInt A-Z

Const ISLLENGTH = 80 ' Length of the island.  Range is 40 to 240.  If you make ISLLENGTH too large there will not be any water for your ships!
Const NUMTREES = 3 ' Number of trees on the island.  Range 0 to 10.  If you make this large (or make ISLLENGTH small) there may not be enough room on the island for all the trees.
Const GRAVITY = 9.8 ' Gravity. Range is 1.0 to 50.0. The higher or lower you go, the more difficult to hit your opponent.
Const INITNUMGAMES = 3 ' Default number of hits needed to win the game.  Range from 1 to 99.
Const MAXVELOCITY = 150 ' Maximum velocity of cannon.  Range 50 to 300 for best results.  You may need to increase this if you have also increased GRAVITY above 9.8.
' The following sound constants are used by the PLAY command to
' produce music during the game.  To change the sounds you hear, change
' these constants.  Refer to the online help for PLAY for the correct format.
' To completely remove sound from the game set the constants equal to null.
' For example:  INTROSOUND = ""
Const INTROSOUND = "T160O1L8CDEDCDL4ECC" ' Sound played at the start of the game.
Const CANNONFIRESOUND = "MBo0L32A-L64CL16BL64A+" ' Sound made when a cannon is fired.
Const CANNONHITSOUND = "MBO0L32EFGEFDC" ' Sound made when a cannon ball hits an object.
Const SHIPEXPLOSIONSOUND = "MBO0L16EFGEFDC" ' Sound made when a ship is exploded.

' The following are general constants and their values should not be changed.
Const TRUE = -1
Const FALSE = Not TRUE
Const SHOOTSELF = 1 ' Used to indicate that a player shot him/her self.
Const TREEWIDTH = 16 ' Width of the tree picture (do NOT change).
Const SHIPWIDTH = 16 ' Width of the Ship picture (do NOT change).
Const MOVESHIPBY = 16 ' Distance to move the ship per key press.
Const UP = 0 + 72 ' Two bytes representing Up arrow key. Elevate cannon by 1 degree.
Const DOWN = 0 + 80 ' Two bytes representing Down arrow key. Depress cannon by 1.
Const LEFT = 0 + 75 ' Two bytes representing Left arrow key. Move ship left / speed change.
Const RIGHT = 0 + 77 ' Two bytes representing Right arrow key. Move ship right / speed change.
Const ENTERKEY = 13 ' Single byte ASCII code for Carriage Return (Enter key). Confirm selections.
Const BACKGROUNDCOLOR = 0 ' Black.
Const WATERCOLOR = 1 ' Palette 1, color 1 cyan.
Const ISLANDCOLOR = 2 ' Palette 1, color 2 purple.
Const OBJECTCOLOR = 3 ' Palette 1, color 3 white.

'Declarations of all the FUNCTION and SUB procedures called in this program.
DECLARE FUNCTION MoveShip (PlayerNum, SeaLevel())
DECLARE FUNCTION SinkShip (x, y)
DECLARE FUNCTION PlotShot (startX, startY, angle#, velocity)
DECLARE FUNCTION GetPlayerCommand (PlayerNum, SeaLevel())
DECLARE SUB Center (text$, row)
DECLARE SUB ClearArea (startRow, startCol, endRow, endCol)
DECLARE SUB CyclePalette ()
DECLARE SUB DisplayChanges ()
DECLARE SUB DisplayGameTitle ()
DECLARE SUB DisplayIntro ()
DECLARE SUB DrawIsland (SeaLevel())
DECLARE SUB DrawWaves (offset, hmult, tmult, SeaLevel())
DECLARE SUB DrawWind ()
DECLARE SUB GetGameOptions ()
DECLARE SUB GetShotParams (PlayerNum, NewAngle#, NewVelocity)
DECLARE SUB InitializeVariables ()
DECLARE SUB MakeBattleField (SeaLevel())
DECLARE SUB PlaceShips (SeaLevel())
DECLARE SUB PlayGame ()
DECLARE SUB PlotAngle (col, angle#, PlayerNum)
DECLARE SUB PlotBattleField (SeaLevel())
DECLARE SUB PlotVelocity (col, velocity, PlayerNum)
DECLARE SUB CannonHit (x, y, theColor)
DECLARE SUB UpdateScores (Record(), PlayerNum, Results)

' SHARED (global) variable declarations for use in this program.
Dim Shared ShipX(1 To 2) As Integer ' x coordinate for ships.
Dim Shared ShipY(1 To 2) As Integer ' y coordinate for ships.
Dim Shared TotalShots(1 To 2) As Integer ' Total shots fired for each player.
Dim Shared TotalWins(1 To 2) As Integer ' Total points for each player.
Dim Shared TheAngle#(1 To 2) ' Angle each player used in last shot.
Dim Shared TheVelocity(1 To 2) As Integer ' Velocity each player used in last shot.
Dim Shared Player$(1 To 2) ' Player name of each player.
Dim Shared Pi# ' Pi (3.1415....) used in calculations
Dim Shared TreePic1(1 To 20) As Integer ' Holds the bottom of the palm tree picture.
Dim Shared TreePic2(1 To 36) As Integer ' Holds the top of the palm tree picture.
Dim Shared ShipPic(1 To 36) As Integer ' Holds the ship picture.
Dim Shared Shot&(1 To 2) ' Holds the cannon ball picture.
Dim Shared ScreenHeight As Integer ' Screen height in pixels.
Dim Shared ScreenWidth As Integer ' Screen width in pixels.
Dim Shared NumGames As Integer ' Number of games to play.
Dim Shared Wind As Integer ' Wind speed; used in shot calculations.
Dim Shared ScreenMode As Integer ' BASIC screen ScreenMode number.
Dim Shared MaxCol As Integer ' Screen maximum number of columns.
Dim Shared IStart As Integer ' Island starting x coordinate.
Dim Shared IEnd As Integer ' Island ending x coordinate.
Dim Shared Delay As Integer ' Delay factor for explosions
' Module-level variables (not known in procedures)
Dim KeyFlags As Integer
Dim BadMode As Integer

' The values below are loaded into arrays, then used in graphics PUT
' statement to display pictures of ships, trees, cannon shots.
' DO NOT CHANGE THE VALUE OF THIS DATA
ShipPicData:
Data 32,16,0,192,0,192,768,192,3840,192,16128,195
Data -256,195,-253,-16189,-241,-3901,-193,-829,-1,-61,0,195
Data 0,195,-21846,-21846,-21926,-23126,-21931,21930,23125,21925,0,0

TreePic1Data:
Data 16,16,-32760,-32760,-32758,-32760,-32760,-32758,-32760,-32760
Data -32758,-32760,-32760,-32758,-24024,-30584,8226,-30072,0,0

TreePic2Data:
Data 32,16,0,2,0,-32758,0,10272,-32766,2720,-24566,640
Data 10792,-32766,10912,-24566,2688,10280,2176,10400,512,2688,2562,512
Data -30198,522,-24024,-32598,10784,-24416,2208,10368,2176,640,0,0

ShotData:
Data 196614,3210288&


' The module-level code of the QSHIPS program begins here!

' Use error trap to test for Screen Mode 1 (320x200 graphics, 40-column text)
On Error GoTo ScreenError ' If mode 1 not available, BadMode
BadMode = FALSE ' is set TRUE in error handler. Other-
ScreenMode = 1 ' wise, screen mode 1 is set.
Screen ScreenMode ' Attempt to go into SCREEN 1.

On Error GoTo 0 ' Turn off error trapping for now.

If BadMode = TRUE Then ' If mode 1 wasn't found...
    Cls
    Locate 11, 13
    Print "CGA, EGA Color, or VGA graphics required to run QSHIPS.BAS"
Else ' Make sure NUM LOCK isn't on.
    Def Seg = 0 ' Set segment to low memory
    KeyFlags = Peek(1047) ' Check address of NUM LOCK status
    If KeyFlags And 32 Then ' If it was turned on,
        Poke 1047, KeyFlags And 223 ' Turn it off
    End If
    Def Seg ' Reset segment to DGROUP (default data segment)

    DisplayIntro ' Display game rules.
    GetGameOptions ' Get player's names and length of game.
    InitializeVariables ' Initialize starting variables.
    PlayGame
    DisplayChanges ' Reset normal screen mode and end.

    If KeyFlags And 32 Then ' Restore the previous flag settings.
        Def Seg = 0
        Poke 1047, KeyFlags Or 32
        Def Seg
    End If
End If

End


ScreenError: ' Screen mode error handler starts here.
BadMode = TRUE ' Set the flag indicating there was an error.
Resume Next ' Ignore the error, by executing next statement.

'--------------------------------------------------------------------------
' CannonHit
'
'    A cannon shot has hit the water, island, or a ship.  What has been
'    hit is determined;  if the shot hit a solid object there is a small
'    explosion, then water / debris is thrown into the air.
'
'             PARAMETERS:   x        - x coordinate of the hit
'                           y        - y coordinate of the hit
'                           theColor - Indicates what has been hit
'--------------------------------------------------------------------------
Sub CannonHit (x, y, theColor)

    fragments = 11 ' Assume shell hit water - splash.
    Select Case Delay ' Base number of cycles in explosion
        Case 500: cycles = 8 '   on machine speed
        Case 200: cycles = 5
        Case 50: cycles = 3
    End Select
    offset = ScreenHeight / 10

    If theColor <> WATERCOLOR Then ' If shell hit solid object - explode.
        Play CANNONHITSOUND
        radius = ScreenHeight / 70 ' Set up and create explosion illusion.
        increment# = 1.2
        For Counter# = 0 To radius Step increment#
            Circle (x, y), Counter#, ISLANDCOLOR
        Next Counter#
        For Counter# = radius To 0 Step (-1 * increment#) ' Repaint with the
            Circle (x, y), Counter#, BACKGROUNDCOLOR ' object now missing.
        Next Counter#
    End If

    'Throw water or debris into the air.
    Dim xpos(1 To fragments), ypos(1 To fragments)
    radius# = .5
    Play CANNONHITSOUND
    For j = -3 To 3 Step 3
        Line (x, y)-(x + j, y - offset), theColor ' Create debris
    Next j

    ' water / debris flies around for a short time
    For kt = 1 To cycles
        For i = 1 To fragments
            xpos(i) = x + (((10 * Rnd) - 5) / 5) * (offset / 2) + (2 * kt) / cycles
            ypos(i) = y - (Rnd + 1) * offset + (3 * kt) / cycles
        Next i
        For i = 1 To fragments
            Circle (xpos(i), ypos(i)), radius#, theColor
        Next i
        For j = -3 To 3 Step 3
            Line (x, y)-(x + j, y - offset), BACKGROUNDCOLOR
        Next j
        For i = 1 To fragments
            Circle (xpos(i), ypos(i)), radius#, BACKGROUNDCOLOR
        Next i
    Next kt

End Sub

'----------------------------------------------------------------------------
' Center
'
'    Centers the given text string on the indicated row.
'
'             PARAMETERS:   text$   - The text to center
'                           row     - The screen row to print on
'----------------------------------------------------------------------------
Sub Center (text$, row)

    Locate row%, 40 - Len(text$) \ 2 + 1 'Calculate column to start at.
    Print text$; 'Print the string.

End Sub

'----------------------------------------------------------------------------
' ClearArea
'
'    Prints spaces over the a rectangular area of the screen to
'      clear any text that may be in that area.
'
'             PARAMETERS:   startRow  - Top row of rectangle to clear
'                           startCol  - Left side
'                           endRow    - Bottom row, must be <= startRow
'                           endCol    - Right side, must be <= endCol
'----------------------------------------------------------------------------
Sub ClearArea (startRow, startCol, endRow, endCol)

    For row = startRow To endRow
        Locate row, startCol ' Set spot for printing to
        Print Space$(endCol - startCol + 1) ' begin, then print blank spaces.
    Next row

End Sub

'--------------------------------------------------------------------------
' CyclePalette
'
'    Changes the screen colors to make the flashing effect when
'    a cannon ball explodes.  If you wish you can try different
'    colors to change the way the flashing effect looks.
'
'             PARAMETERS:   None
'--------------------------------------------------------------------------
Sub CyclePalette

    ' If you wish to change the colors used by the screen flash, change only
    ' the first argument (the foreground) in the COLOR statements below -
    ' leave the second argument (background) as "ISLANDCOLOR".
    Color 12, ISLANDCOLOR
    For g! = 1 To Delay: Next g! 'delay loop
    Color 14, ISLANDCOLOR
    For g! = 1 To Delay: Next g! 'delay loop
    Color 0, 1 'Return the screen colors to normal.

End Sub

'----------------------------------------------------------------------------
' DisplayChanges
'
'   Displays game characteristics that you can easily change via
'   CONST and DATA statements.
'
'             PARAMETERS:   None
'----------------------------------------------------------------------------
Sub DisplayChanges

    DisplayGameTitle 'Print game title.
    
    Color 7
    Center "The following game characteristics can be easily changed from", 5
    Center "within the QuickBASIC Interpreter.  To change the values of  ", 6
    Center "these characteristics, locate the corresponding CONST or DATA", 7
    Center "statements in the source code and change their values, then  ", 8
    Center "restart the program (press Shift + F5).                      ", 9
    Color 15
    Center "Size of the island                            ", 11
    Center "Number of trees on the island                 ", 12
    Center "Strength of gravity that affects your shots   ", 13
    Center "Maximum velocity your cannons can fire        ", 14
    Center "Default number of hits needed to win the game ", 15
    Center "Sounds of the cannon firing and the explosions", 16
    Color 7
    Center "The CONST statements and instructions on changing them are   ", 18
    Center "located at the beginning of the main program.                ", 19

    Do While InKey$ = "": Loop 'Wait for any keypress.
    Cls

End Sub

'----------------------------------------------------------------------------
' DisplayGameTitle
'
'    Displays game title and draws a screen border for use in the
'    introduction and suggested changes screens.
'
'             PARAMETERS:   None
'----------------------------------------------------------------------------
Sub DisplayGameTitle

    Screen 0 ' Set the screen to a normal 80x25 text mode, clear it and add blue background.
    Width 80, 25
    Color 4, 0
    Cls

    ' Draw outline around screen with extended ASCII characters.
    Locate 1, 2
    Print Chr$(201); String$(76, 205); Chr$(187); ' top border
    For x% = 2 To 24 ' left and right borders
        Locate x%, 2
        Print Chr$(186); Tab(79); Chr$(186);
    Next x%
    Locate 25, 2
    Print Chr$(200); String$(76, 205); Chr$(188); 'bottom border

    'Print game title centered at top of screen
    Color 0, 4
    Center "      Microsoft      ", 1
    Center "     Q S H I P S     ", 2
    Center "   Press any key to continue   ", 25
    Color 7, 0

End Sub

'----------------------------------------------------------------------------
' DisplayIntro
'
'    Displays game introduction screen which explains game objective and
'    game keyboard controls
'
'             PARAMETERS:   None
'----------------------------------------------------------------------------
Sub DisplayIntro
    
    DisplayGameTitle ' Display game title.

    Color 7 ' Print game introduction and objectives.
    Center "Copyright (C) 1990 Microsoft Corporation.  All Rights Reserved.", 4
    Center "Each player's mission is to destroy the opponent's ship by varying the     ", 6
    Center "angle and speed of your cannon, taking into account wind speed and terrain.", 7
    Center "The wind speed is shown by a directional arrow on the playing field, its   ", 8
    Center "length relative to its strength.  With each turn, you may EITHER move your ", 9
    Center "ship to avoid your opponent's cannon fire OR shoot your cannon.            ", 10
    
    Color 4 'Print game controls.
    Center String$(74, 196), 12
    Color 7
    Center " Game Controls ", 12
    Center "    General              Shooting Cannon                  Moving Ship     ", 13
    Center "S - Shoot cannon    " + Chr$(24) + " - Increase cannon angle          " + Chr$(27) + " - Move ship left ", 15
    Center "M - Move ship       " + Chr$(25) + " - Decrease cannon angle          " + Chr$(26) + " - Move ship right", 16
    Center "Q - Quit game       " + Chr$(26) + " - Increase cannon velocity                          ", 17
    Center "                        for Player 1, decrease                            ", 18
    Center "                        cannon velocity for Player 2                      ", 19
    Center "                    " + Chr$(27) + " - Decrease cannon velocity                          ", 20
    Center "                        for Player 1, increase                            ", 21
    Center "                        cannon velocity for Player 2                      ", 22
    Center "                    Enter - Fire cannon                                   ", 23
    
    Play INTROSOUND 'Play melody while waiting to continue.
                        
    Do 'Wait for key press before continuing
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

'--------------------------------------------------------------------------
' DrawIsland
'
'    Draws an island between the two ships.  The island is made
'    by drawing increasingly taller lines (based on the sea level)
'    for the left side of the island, and then increasingly shorter
'    lines for the right side.  Trees are then placed. Note that the
'    seaLevel() array was loaded with values at the start of PlayGame.
'
'             PARAMETERS:   seaLevel()      - Water level at each point
'--------------------------------------------------------------------------
Sub DrawIsland (SeaLevel())

    ' Calculate a random-sized island (iScale#), and place it between the ships (iStart, iEnd).
    iScale# = (Int(((SeaLevel(0) - 60) / 3) * Rnd) + Int((SeaLevel(0) - 60) / 3)) / (ISLLENGTH / 2)
    IStart = ((ShipX(2) - (ShipX(1) + SHIPWIDTH)) - ISLLENGTH - 6) * Rnd + ShipX(1) + SHIPWIDTH + 3
    IEnd = IStart + ISLLENGTH

    ' Draw the island by extending lines from the water level (seaLevel()) sloping up on the left side and down on the right.
    For Counter = IStart To IEnd
        If Counter < (IStart + IEnd) / 2 Then
            yoffset = iScale# * (Counter - IStart)
        Else
            yoffset = iScale# * (IEnd - Counter)
        End If
        y1 = SeaLevel(Counter) + yoffset
        y2 = SeaLevel(Counter) - yoffset
        Line (Counter, y1)-(Counter, y2), ISLANDCOLOR
    Next Counter

    ' Place the trees.  Determine position depending on the island size (iScale#).  The pictures that make up the tree image are
    ' held in the global arrays treePic1() and treePic2().  These arrays were loaded with treePic DATA in the InitializeVariables
    ' SUB procedure. A BASIC graphics PUT statement is used to draw the tree pictures.
    For Counter = 1 To NUMTREES
        xpos = IStart + 6 + (Counter - 1) * (ISLLENGTH / NUMTREES)
        subtot# = 0: trend = 10
        For j = xpos To xpos + trend
            If j < (IStart + IEnd) / 2 Then
                yoffset = iScale# * (j - IStart)
            Else
                yoffset = iScale# * (IEnd - j)
            End If
            subtot# = subtot# + SeaLevel(j) - yoffset
        Next j
        ypos = subtot# / (trend + 1) - 28
        Put (xpos, ypos), TreePic2(), PSet
        Put (xpos + 4, ypos + TREEWIDTH), TreePic1(), PSet
    Next Counter

End Sub

'--------------------------------------------------------------------------
' DrawWaves
'
'    Uses the BASIC CIRCLE statement to draw arcs (partial circles)
'    to make waves in the water.
'
'             PARAMETERS:   offset     - Increasing value move wave left.
'                           hmult      - Increasing value moves wave down.
'                           tmult      - Increasing value moves wave up.
'                           seaLevel() - Ocean level at each point.
'--------------------------------------------------------------------------
Sub DrawWaves (offset, hmult, tmult, SeaLevel())

    radius = ScreenWidth / 80 ' Size of a wave

    ' Move across the screen from right to left drawing waves.
    For i = ScreenWidth / offset To ScreenWidth - ScreenWidth / offset Step ScreenWidth / 5

        ' Calculate vertical position of wave and draw the arcs to create it.
        ypos = (hmult * ScreenHeight + tmult * SeaLevel(i)) / (hmult + tmult)
        Circle (i, ypos), radius, ISLANDCOLOR, 5 * Pi# / 4, 2 * Pi#
        Circle (i + 2 * radius, ypos), radius, ISLANDCOLOR, Pi#, Pi# * 2
        Circle (i + 4 * radius, ypos), radius, ISLANDCOLOR, Pi#, 7 * Pi# / 4

    Next i

End Sub

'--------------------------------------------------------------------------
' DrawWind
'
'    Draws an arrow in the direction of the wind.  The length of
'    the arrow depends on the strength of the wind.
'
'             PARAMETERS:   None
'--------------------------------------------------------------------------
Sub DrawWind

    WindTmp = Wind
    If WindTmp = 0 Then WindTmp = 1 ' Ensure that Wind won't ever be zero.

    WindLineLength = WindTmp * (ScreenWidth / 80) ' Calculate the length of the arrow.
    x1 = ScreenWidth / 2 - WindLineLength / 2
    x2 = x1 + WindLineLength
    ' SGN(WindTmp) returns -1 if WindTmp is negative, 1 if it is positive.
    ArrowDir = -2 * Sgn(WindTmp) ' Figure out the arrowhead direction.
    Line (x1, 16)-(x2, 16), ISLANDCOLOR ' Draw the wind arrow line.
    Line (x2, 16)-(x2 + ArrowDir, 14), ISLANDCOLOR
    Line (x2, 16)-(x2 + ArrowDir, 18), ISLANDCOLOR

End Sub

'--------------------------------------------------------------------------
' GetGameOptions
'
'    Prompts for and saves the Player names for each player and
'    the number of points to play to.  GetGameOptions does not call
'    any other SUB or FUNCTION procedures.
'
'             PARAMETERS:   None
'--------------------------------------------------------------------------
Sub GetGameOptions

    Screen 0
    Width 80
    Cls

    ' player1$ defaults to "Player 1"
    Color 7: Center "Default is 'Player 1'", 9
    Color 15: Locate 8, 30
    Line Input "Name of Player 1: "; Player$(1)
    If Player$(1) = "" Then
        Player$(1) = "Player 1"
    Else
        Player$(1) = Left$(Player$(1), 10)
    End If

    ' player2$ defaults to "Player 2"
    Color 7: Center "Default is 'Player 2'", 12
    Color 15: Locate 11, 30
    Line Input "Name of Player 2: "; Player$(2)
    If Player$(2) = "" Then
        Player$(2) = "Player 2"
    Else
        Player$(2) = Left$(Player$(2), 10)
    End If

    ' Number of games defaults to INITNUMGAMES
    Color 7: Center "Default is" + Str$(INITNUMGAMES), 15
    Do
        Color 15: Locate 14, 27: Print Space$(50);
        Locate 14, 27
        Input "Play to how many points"; NumHold$
        NumGames = Val(Left$(NumHold$, 2))
    Loop Until NumGames > 0 And Len(NumHold$) < 3 Or Len(NumHold$) = 0
    If NumGames = 0 Then NumGames = INITNUMGAMES

    Color 7 ' Restore color

End Sub

'--------------------------------------------------------------------------
' GetPlayerCommand
'
'     Displays a menu on the active players side of the screen and gets the
'     player's selection.  If the selection is a valid menu option, then
'     the appropriate SUB is called to handle the command.  If the choice
'     is invalid the SUB InvalidKeyHit is called.  This process is repeated
'     until the player actually shoots, moves, or quits the game.
'
'             PARAMETERS:   playerNum  - The active player
'                           seaLevel() - Passed on to other SUB procedures
'--------------------------------------------------------------------------
Function GetPlayerCommand (PlayerNum, SeaLevel())

    ' As long as the player has not shot or moved he/she can keep selecting.
    finished = FALSE
    Do: Loop While InKey$ <> "" ' Flush keyboard buffer before turn

    xpos = ShipX(PlayerNum) ' Determine this player's ship location.
    ypos = ShipY(PlayerNum)
    If PlayerNum = 1 Then ' Determine where to put the menu
        MenuCol = 3 ' depending on whose turn it is.
        startCol = 30
        endCol = 40
    Else
        MenuCol = 25
        startCol = 1
        endCol = 24
    End If

    ' If the player fires the shot "starts" from above his/her ship, so the
    '   yShotPosition is calculated to enforce this.
    YShotPos = ypos - 3

    Do While Not finished
        ' Print the player's score and label the wind indicator.
        Locate 1, 1: Print Player$(1)
        Locate 1, (MaxCol - Len(Player$(2))): Print Player$(2)
        Locate 1, 19: Print "Wind";
        Locate 2, 1: Print "Hits:"; TotalWins(1);
        Locate 2, MaxCol - 6 - Len(Str$(TotalWins(2))): Print "Hits:"; TotalWins(2);

        Call DrawWind ' Draw the wind indicator.

        ' Clear the area where the menu will appear and print the menu with a box.
        Call ClearArea(4, MenuCol, 8, MenuCol + 12)
        Line (MenuCol * 8 - 2, 28)-(MenuCol * 8 + 87, 60), , B
        Locate 5, MenuCol + 2: Print "S = Shoot"
        Locate 6, MenuCol + 2: Print "M = Move "
        Locate 7, MenuCol + 2: Print "Q = Quit "
        
        Do ' Get the player's selection.
            kbd$ = UCase$(InKey$)
        Loop Until kbd$ <> ""
        Call ClearArea(4, MenuCol, 8, MenuCol + 12)

        Select Case kbd$
            Case "Q" ' Q = QUIT
                Sound 600, .5 ' Make sure the player really wants to quit.
                Sound 800, .5
                Locate 5, 11: Print "Really quit? (Y/N)";
                Do
                    kbd$ = UCase$(InKey$)
                Loop While kbd$ = ""
                If kbd$ = "Y" Then ' If players want to quit, then
                    Call DisplayChanges ' remind them of changes they can
                    End ' make to the program.
                Else
                    Call ClearArea(5, 1, 5, 40)
                End If

            Case "M" ' M = MOVE
                If MoveShip(PlayerNum, SeaLevel()) Then
                    finished = TRUE ' Player moved - his/her turn is over.
                    GetPlayerCommand = FALSE
                End If

            Case "S", Chr$(ENTERKEY) ' S = SHOOT (or Enter key)
                ' Get desired angle & velocity.
                Call GetShotParams(PlayerNum, angle#, velocity)

                ' Player 2 is actually shooting from the other direction so we need to turn the angle 180 degrees.
                If PlayerNum = 2 Then angle# = 180 - angle#

                ' Clear the text on the upper area of the screen so the cannon shot can go off the top of the screen.
                View Print 1 To 7 ' Set text viewport to rows 1-7.
                Cls 2 ' Clear the text viewport.
                View Print ' Reset text viewport to whole screen.

                ' Plot the shot on the screen.
                playerHit = PlotShot(xpos, YShotPos, angle#, velocity)
                TotalShots(PlayerNum) = TotalShots(PlayerNum) + 1

                ' Determine what happened by the value returned from PlotShot FUNCTION..
                If playerHit = PlayerNum Then
                    GetPlayerCommand = SHOOTSELF ' Player shot himself/herself.
                ElseIf playerHit <> 0 Then
                    GetPlayerCommand = TRUE ' Play shot opponent.
                Else
                    GetPlayerCommand = FALSE ' Player missed.
                End If
                finished = TRUE ' Player has fired - his/her turn is over.
            Case Else ' Some other key was pressed.
                Beep
        End Select
    Loop

End Function

'--------------------------------------------------------------------------
' GetShotParams
'
'    Prompts for and records the angle and velocity the player wishes to use
'    for shooting his/her cannon.  The main loop keeps checking for and
'    recording player changes to angle and velocity until the player hits
'    Enter to fire the cannon.  If the player hits an invalid key then a
'    message is displayed about how to get help.  Help will be displayed if
'    the player enters "h" or "H".
'
'             PARAMETERS:   playerNum   - Which player is firing
'                           newAngle#   - The new angle to use
'                           newVelocity - The new shot speed to use
'--------------------------------------------------------------------------
Sub GetShotParams (PlayerNum, NewAngle#, NewVelocity)

    'Clear the upper left and right corners of the screen
    If PlayerNum = 1 Then
        locateCol = 1
        locateCol2 = 26
        ArrowAffect = 1 ' Direction wind arrow will point and
        Call ClearArea(2, 1, 6, 16) ' direction that velocity meter will extend.
        Call ClearArea(1, 26, 6, 40)
    Else
        locateCol = 30
        locateCol2 = 1
        ArrowAffect = -1
        Call ClearArea(1, 1, 6, 16)
        Call ClearArea(2, 26, 6, 40)
    End If

    ' Display the shooting instructions in the upper corner on the non-firing players side of the screen.
    Locate 2, locateCol2: Print "Change angle "
    Locate 3, locateCol2: Print "with  and ."
    Locate 4, locateCol2: Print "Change speed "
    Locate 5, locateCol2: Print "with " + Chr$(26) + " and " + Chr$(27) + "."
    Locate 6, locateCol2: Print "ENTER to fire."

    ' Show the angle and velocity of the players last shot.  The angle and velocity defaults to 45 degrees and velocity of 50 meters/ second if the player has not fired yet.
    Call PlotAngle(locateCol, TheAngle#(PlayerNum), PlayerNum)
    Call PlotVelocity(locateCol, TheVelocity(PlayerNum), PlayerNum)

    ' Get the players input.  Either change cannon angle using the Up and
    ' Down arrows, change the shot velocity using the Right and Left arrow
    ' or fire the cannon with the Enter key.  Note that the left
    ' and right arrow key affect is reversed for the second player.
    Do While Not finished
        Do ' Get key pressed.
            kbd$ = InKey$
        Loop While kbd$ = ""

        cursorkey = Asc(Right$(kbd$, 1))
        Select Case cursorkey
            Case LEFT, RIGHT ' Change the velocity level indicator.
                If cursorkey = RIGHT Then
                    increment = 1 * ArrowAffect
                Else
                    increment = -1 * ArrowAffect
                End If
                If (increment < 0 And TheVelocity(PlayerNum) > 0) Or (increment > 0 And TheVelocity(PlayerNum) < MAXVELOCITY) Then
                    TheVelocity(PlayerNum) = TheVelocity(PlayerNum) + increment
                    Call PlotVelocity(locateCol, TheVelocity(PlayerNum), PlayerNum)
                Else
                    Beep
                    Do
                        temp$ = InKey$
                    Loop While temp$ <> ""
                End If
            Case UP, DOWN ' Change angle in trajectory display.
                If cursorkey = UP Then
                    increment = 1
                Else
                    increment = -1
                End If
                If (increment < 0 And TheAngle#(PlayerNum) > 0) Or (increment > 0 And TheAngle#(PlayerNum) < 90) Then
                    TheAngle#(PlayerNum) = TheAngle#(PlayerNum) + increment
                    Call PlotAngle(locateCol, TheAngle#(PlayerNum), PlayerNum)
                Else
                    Beep
                    Do
                        temp$ = InKey$
                    Loop While temp$ <> ""
                End If
            Case ENTERKEY
                finished = TRUE ' Fire cannon when Enter key is pressed.
                NewAngle# = TheAngle#(PlayerNum)
                NewVelocity = TheVelocity(PlayerNum)
            Case Else ' Any other key is invalid.
                Beep
        End Select
    Loop
      
End Sub

'--------------------------------------------------------------------------
' InitializeVariables
'
'    SHARED variables are initialized and graphics pictures loaded from
'    DATA statements.
'
'             PARAMETERS:   None
'--------------------------------------------------------------------------
Sub InitializeVariables

    Pi# = 4 * Atn(1#) ' Calculate PI to 14 decimal places.

    ScreenWidth = 320 ' Width and height for SCREEN 1 (320x200).
    ScreenHeight = 200
    MaxCol = 40
    ' Loading picture data from the DATA statements into the respective arrays.
    Restore ShipPicData
    For Counter = 1 To 36
        Read ShipPic(Counter) ' ship picture
    Next Counter
    For Counter = 1 To 20
        Read TreePic1(Counter) ' bottom of palm tree
    Next Counter
    For Counter = 1 To 36
        Read TreePic2(Counter) ' top of palm tree
    Next Counter
    For Counter = 1 To 2
        Read Shot&(Counter) ' shot
    Next Counter

    'Determine machine performance in a generic manner...
    x! = Timer
    For g! = 1 To 500
    Next g!
    x! = Timer - x!
    Select Case x!
        Case 0 TO .18 'For 386 type machines.
            Delay = 500
        Case Is < .45 'For PC/AT type machines.
            Delay = 200
        Case Else 'For XT type machines.
            Delay = 50
    End Select

End Sub

'--------------------------------------------------------------------------
' MakeBattleField
'
'    Generates the sea at each point on the screen, storing
'    the values in the array seaLevel().  The level of
'    the ocean is generated from left side of the screen to
'    the right.  The variable "motion" affects the "trend" of
'    sea level, generating up and down "slopes."
'
'             PARAMETERS:   SeaLevel()     - The height of the sea
'--------------------------------------------------------------------------
Sub MakeBattleField (SeaLevel())

    increment = 1
    range = 5
    SeaLevel(0) = ScreenHeight - (45 + Int((ScreenHeight / 8) * Rnd + 1))
    ' When the following loop ends, each element of the seaLevel() array has a
    ' value to be used in drawing the ocean surface.
    For Counter = 1 To ScreenWidth
        Motion = Int(range * Rnd + 1)
        Select Case Motion
            Case 1 TO range / 2
                If Motion < range / 2 - 1 Then
                    trend = trend + increment
                Else
                    trend = trend - increment
                End If
            Case range / 2 + 1 TO range / 2 + 2
                trend = 1 * Sgn(Wind)
            Case range / 2 + 3
                trend = 0
            Case Else
                trend = -1 * Sgn(Wind)
        End Select
        Select Case trend ' Set values in seaLevel based on trend generated above
            Case Is < 0
                SeaLevel(Counter) = SeaLevel(Counter - 1) - 1 ' if trend is negative
            Case Is > 0
                SeaLevel(Counter) = SeaLevel(Counter - 1) + 1 ' if trend is positive
            Case Else
                SeaLevel(Counter) = SeaLevel(Counter - 1) ' if trend is zero
        End Select
        If SeaLevel(Counter) > SeaLevel(0) + range Then SeaLevel(Counter) = SeaLevel(Counter - 1) - 3
        If SeaLevel(Counter) < SeaLevel(0) - range Then SeaLevel(Counter) = SeaLevel(Counter - 1) + 3
        If Counter > range And Counter < ScreenWidth - range Then
            diff = SeaLevel(Counter - 4) - SeaLevel(Counter - 1)
            If Abs(diff) > range Then
                trend = -increment * Sgn(diff)
            End If
        End If
    Next Counter
    ' When this SUB ends the values in SeaLevel array are known in the caller. They
    ' are passed to PlotBattleField and used in LINE statements to draw the ocean
    ' surface and fill the ocean with color down to the bottom of the screen with
    ' WATERCOLOR. DrawWaves uses the SeaLevel values in calculating the positions
    ' for drawing waves.

End Sub

'--------------------------------------------------------------------------
' MoveShip
'
'    Allows player to move ship using Left and Right arrow keys.  As long
'    as they do not actually move the ship, they can change their mind
'    and go back to the main menu to shoot.
'
'             PARAMETERS:   playerNum  - The player who is moving
'                           seaLevel() - Used to fix area after move
'--------------------------------------------------------------------------
Function MoveShip (PlayerNum, SeaLevel())

    finished = FALSE ' TRUE if player presses Enter.
    MoveShip = FALSE ' TRUE if player moves ship. If FALSE
    ' player can go back and shoot.

    ' Print instructions for moving.
    Locate 5, 2: Print "To move your ship, press either the"
    Locate 6, 2: Print Chr$(26) + " or " + Chr$(27) + " arrow keys, then press Enter."

    ' Loop until the player hits enter to indicate they are done moving.
    '   If they have not actually moved then they can still do something else.
    Do While Not finished
        Do ' Get player's selection.
            kbd$ = InKey$
        Loop While kbd$ = ""
        cursorkey = Asc(Right$(kbd$, 1))
        Select Case cursorkey
            Case LEFT ' Move ship to left.
                MoveShip = TRUE
                moveit = -MOVESHIPBY
            Case RIGHT ' Move ship to right.
                MoveShip = TRUE
                moveit = MOVESHIPBY
            Case ENTERKEY ' End move by pressing Enter key.
                finished = TRUE
            Case Else ' Any other key is invalid.
                Beep
                moveit = 0
        End Select

        If Not finished Then ' Move ship.
            xpos = ShipX(PlayerNum) + moveit
            ' Move ship only if it can be moved in that direction.
            If (xpos > 3 And xpos < IStart - MOVESHIPBY - 3) Or (xpos > IEnd + 3 And xpos < ScreenWidth - SHIPWIDTH - 3) Then
                ypos = SeaLevel(xpos) - 9
                ' blank out current position
                Put (ShipX(PlayerNum), ShipY(PlayerNum)), ShipPic(), Xor
                If moveit > 0 Then ' clean up the water using seaLevel()
                    For i = ShipX(PlayerNum) To xpos - 1
                        Line (i, SeaLevel(i))-(i, SeaLevel(i) + SHIPWIDTH), WATERCOLOR
                    Next i
                Else
                    For i = ShipX(PlayerNum) To ShipX(PlayerNum) - moveit
                        Line (i, SeaLevel(i))-(i, SeaLevel(i) + SHIPWIDTH), WATERCOLOR
                    Next i
                End If
                Put (xpos, ypos), ShipPic(), PSet ' Put ship in new position.
                ShipX(PlayerNum) = xpos
                ShipY(PlayerNum) = ypos
            Else
                Beep
            End If
        End If
    Loop

    Call ClearArea(5, 1, 6, 40)

End Function

'--------------------------------------------------------------------------
' PlaceShips
'
'    Computes new locations and place ships there.
'
'             PARAMETERS:   seaLevel() - Needed to find shipY()
'--------------------------------------------------------------------------
Sub PlaceShips (SeaLevel())
    
    ' Calculate random position for ships on either side of the screen.
    ShipX(1) = Int(((ScreenWidth - ISLLENGTH) / 2 - SHIPWIDTH - 6) * Rnd) + 3
    ShipY(1) = SeaLevel(ShipX(1)) - 12
    ShipX(2) = ScreenWidth - Int(((ScreenWidth - ISLLENGTH) / 2 - SHIPWIDTH - 6) * Rnd) - SHIPWIDTH - 3
    ShipY(2) = SeaLevel(ShipX(2)) - 12
    
    For Counter = 1 To 2 ' Place the ship images from shipPic() and fix the water to look good.
        Put (ShipX(Counter), ShipY(Counter)), ShipPic(), PSet
        For FixTerrain = ShipX(Counter) To ShipX(Counter) + SHIPWIDTH
            Line (FixTerrain, ShipY(Counter) + 2 * SHIPWIDTH)-(FixTerrain, ShipY(Counter) + SHIPWIDTH), WATERCOLOR
        Next FixTerrain
    Next Counter

End Sub

'--------------------------------------------------------------------------
' PlayGame
'
'    This is the main driver for QSHIPS.
'    This SUB procedure contains three nested loops.  The outermost loop
'    will ask the players if they wish to play again each time
'    someone wins.  The second loop will continue to generate a new
'    battle field and wind speed each round until someone scores
'    enough points to win.  The inner most loop gets and executes
'    each players commands for that round, ending when one player is
'    sunk.
'
'             PARAMETERS:   None
'--------------------------------------------------------------------------
Sub PlayGame

    'Set up arrays to hold the height of the water/terrain at each point.
    Dim SeaLevel(0 To ScreenWidth)
    Randomize (Timer)
    Counter = 0

    'The main loop of the game.  Keeps going until users select to quit.
    Do
        Center "Creating game battleground, please wait.", 22

        ' Initialize score.
        For i = 1 To 2
            TotalShots(i) = 0
            TotalWins(i) = 0
        Next i

        firstPlayer = Int(2 * Rnd + 1) ' Randomly determine first player.

        'This loop gets and executes the players commands until the 'play to' score has been met.
        Do Until TotalWins(1) >= NumGames Or TotalWins(2) >= NumGames

            For i = 1 To 2 ' Reset initial cannon angle and speed.
                TheAngle#(i) = 45
                TheVelocity(i) = 50
            Next i

            ' Calculate wind for this round.  To have the wind speed change after each shot, move the next four lines to down below the statement "DO WHILE directHit = FALSE."
            Wind = Int(11 * Rnd + 1) - 6
            If (Int(4 * Rnd + 1) = 1) Then ' Every once in a while, make it 10 times stronger.
                Wind = Wind + Sgn(Wind) * 10
            End If

            Call MakeBattleField(SeaLevel()) ' Generate and plot a new battle field.
            Do ' Flush keyboard buffer
                kbd$ = InKey$
            Loop Until kbd$ = ""
            Screen ScreenMode
            Color 0, 1 ' Set CGA palette to palette #1.
            Cls ' Clear screen for new round.
            Call PlotBattleField(SeaLevel()) ' Draw ocean, waves, ships, island, trees.
            
            Do ' This section will get and execute commands until one player is blown up or the players quit.
                Counter = Counter + 1
                                          
                ' Get and execute a player's command, returning an integer that tells if someone has been hit.
                directHit = GetPlayerCommand(firstPlayer, SeaLevel())

                If directHit <> FALSE Then
                    If directHit = SHOOTSELF Then ' SHOOTSELF is constant value 1.
                        TotalWins(Abs(firstPlayer - 3)) = TotalWins(Abs(firstPlayer - 3)) + 1
                    Else
                        TotalWins(firstPlayer) = TotalWins(firstPlayer) + 1
                    End If
                    If directHit = TRUE Then Counter = Counter + 1
                End If
                
                firstPlayer = Abs(firstPlayer - 3) ' Change firstPlayer so turns alternate
                ' between players while there hasn't
            Loop While directHit = FALSE ' been a direct hit.
            ' When this loop is exited one player or the other has been sunk.  We now go back to the outer loop to make a new battle field.

        Loop ' Repeat until totalwins are finally met

        Color 1, 1
        Cls ' Display game over info.
        Locate 3, 15: Print "GAME OVER!"
        diff = TotalWins(1) - TotalWins(2) ' If diff is negative, player2 won
        If diff > 0 Then ofst = 1 Else ofst = 2 ' more games, otherwise player1 won more.

        Locate 7, 4 ' If player2 won more, display absolute value of difference:
        Print Player$(ofst) + " won by" + Str$(Abs(diff)) + " point(s)."
        Locate 11, 2: Print "Player:       Hits:      Shots Fired:"
        Locate 12, 2: Print "-------       -----      ------------"

        For j = 1 To 2
            Locate 13 + j, 2: Print Player$(j)
            Locate 13 + j, 17: Print TotalWins(j)
            Locate 13 + j, 32: Print TotalShots(j)
        Next j
        
        Locate 20, 11: Print "Play again? (Y/N) " 'See if the players wish to play again.
        Do
            StillPlay$ = UCase$(InKey$)
        Loop While StillPlay$ <> "Y" And StillPlay$ <> "N"

    Loop While StillPlay$ = "Y" 'Repeat while players still want to play game.

End Sub

'--------------------------------------------------------------------------
' PlotAngle
'
'    Plots the angle (from 0-90 degrees) indicator that is displayed while
'    a player is adjusting the angle of his/her shot.
'
'             PARAMETERS:   col       - What column to start at
'                           newAngle# - The angle to plot
'                           OldAngle# - The old angle plotted
'                           playerNum - Which player is adjusting
'--------------------------------------------------------------------------
Sub PlotAngle (col, NewAngle#, PlayerNum)
    
    radius = 28.57143 ' Assumes a screen height of 200 and width of 320.
    YCenter = 34.28572

    If PlayerNum = 1 Then ' Set placement of drawing according
        XCenter = 78.57143 ' to whose turn it is.
        XIncrement = radius
        xoffset = -1
    Else
        XCenter = 228.5714
        XIncrement = -radius
        xoffset = 1
    End If
    
    ' Erase the previous arc.
    Line (XCenter, YCenter)-(XCenter + XIncrement, YCenter - radius * .8333333), BACKGROUNDCOLOR, BF
    ' Draw new pie-slice representing trajectory.
    If PlayerNum = 1 Then
        Circle (XCenter, YCenter), radius, OBJECTCOLOR, -.00001, -Pi# / 2
    Else
        Circle (XCenter, YCenter), radius, OBJECTCOLOR, -Pi# / 2, -Pi#
    End If
    ' Draw line representing the angle of the shot.
    Line (XCenter, YCenter)-(XCenter + Cos((NewAngle# * (Pi# / 180))) * XIncrement, YCenter - Sin((NewAngle# * (Pi# / 180))) * (radius * .8333333)), OBJECTCOLOR
    ' Fill bottom with magenta if appropriate.
    If NewAngle# > 1 Then Paint (XCenter + XIncrement + xoffset, YCenter - 1), ISLANDCOLOR, OBJECTCOLOR

    Locate 3, col ' Print the angle beside the indicator.
    Print Using "Angle: ##"; NewAngle#

End Sub

'--------------------------------------------------------------------------
' PlotBattlefield
'
'    Plots the sea level stored in the array seaLevel().  A line of color
'    WATERCOLOR is drawn from the bottom of the screen straight up to the
'    y coordinate stored in seaLevel().  This process is repeated for each
'    x coordinate on the screen.  PlotBattleField then adds waves, ships,
'    and an island to complete the battle field.
'
'             PARAMETERS:   seaLevel()      - The height of the sea
'--------------------------------------------------------------------------
Sub PlotBattleField (SeaLevel())

    For Counter = 1 To ScreenWidth ' Draw the sea.
        Line (Counter, ScreenHeight)-(Counter, SeaLevel(Counter)), WATERCOLOR
    Next Counter
    
    Call DrawWaves(10, 4, 1, SeaLevel()) ' Call WaveSub to add in the waves.
    Call DrawWaves(20, 2, 1, SeaLevel())
    Call DrawWaves(30, 1, 1, SeaLevel())
    Call DrawWaves(40, 3, 1, SeaLevel())
    Call DrawWaves(50, 7, 1, SeaLevel())
    
    Call PlaceShips(SeaLevel()) ' Place ships in battlefield.
    Call DrawIsland(SeaLevel()) ' Place the island.

End Sub

'--------------------------------------------------------------------------
' PlotShot
'
'    Plots the trajectory of a shot on the screen based on indicated angle
'    and velocity, adjusting for wind speed and direction.  As the cannon
'    ball trajectory is plotted we check to see if the shot has hit
'    anything.  If the shot goes off the top of the screen we keep track
'    of it in case it comes down back on the screen.  If the shot goes off
'    the side of the screen then we assume it missed and quit plotting.
'
'             PARAMETERS:   startX   - The x coordinate shot from
'                           startY   - The y coordinate shot from
'                           angle#   - The angle of the cannon
'                           velocity - The starting velocity
'--------------------------------------------------------------------------
Function PlotShot (startX, startY, angle#, velocity)

    Const cSeconds = 3.5 ' Avg # seconds cannon ball in air

    Play CANNONFIRESOUND
    
    If velocity < 2 Then ' If a shot is too slow then the cannon ball blows the shooter up!
        PlotShot = SinkShip(startX, startY)
    Else

        ' Calculate the starting variables for plotting the trajectory.
        angle# = angle# / 180 * Pi# ' Convert degree angle to radians.
        InitialXVelocity# = Cos(angle#) * velocity
        InitialYVelocity# = Sin(angle#) * velocity

        PlotShot = 0 ' Assume no ship destroyed
        NEEDERASE = FALSE ' TRUE if we need to erase a previous shot

        t1# = Timer

        ' While the shot is on the screen and has not hit anything we plot its
        ' trajectory.
        Do

            ' Calculate shot's current position.
            x = startX + (InitialXVelocity# * t#) + (.5 * (Wind / 5) * t# * t#)
            y = startY + (-(InitialYVelocity# * t#) + (.5 * GRAVITY * t# * t#)) * (ScreenHeight / 350)

            ' Erase the old image of the shot if we need to do so.
            If NEEDERASE Then ' Shot& is an array holding data
                Put (Oldx, Oldy), Shot&(), Xor ' used to draw the projectile.
            End If ' XOR causes erasing by
            ' redrawing in background color

            ' Check to see if shot has gone off the side of the screen.  If
            ' so, flag to exit the loop now so we don't try to plot the point
            ' or look at a point off of the screen.
            If (x >= ScreenWidth - 3) Or (x <= 3) Or (y >= ScreenHeight - 3) Then
                Exit Do
            End If

            ' Check to see if the shot hit anything: Use the POINT statement
            ' to get the color of the points around the shot, then compare the
            ' color to ISLANDCOLOR, WATERCOLOR, OBJECTCOLOR to see what was hit.
            ' If we get a hit, we have to exit immediately, otherwise we could
            ' get several hits at the current location.
            For lookX = -1 To 1
                For lookY = -1 To 1
                    If Point(x + lookX, y + lookY) <> BACKGROUNDCOLOR Then
                        If Point(x + lookX, y + lookY) = OBJECTCOLOR Then
                            PlotShot = SinkShip(x, y) ' hit a ship
                            Exit Do
                        ElseIf Point(x + lookX, y + lookY) = ISLANDCOLOR Then
                            Call CannonHit(x, y, ISLANDCOLOR) ' hit the island
                            Exit Do
                        ElseIf Point(x + lookX, y + lookY) = WATERCOLOR Then
                            Call CannonHit(x, y, WATERCOLOR) ' hit the water
                            Exit Do
                        End If
                    End If
                Next
            Next

            ' If the shot has not hit anything, plot it.
            If y > 0 Then
                Put (x, y), Shot&(), PSet
                Oldx = x
                Oldy = y
                NEEDERASE = TRUE
            Else
                NEEDERASE = FALSE
            End If

            ' Wait till time for next position to be drawn (.05 time units)
            Do
                ' If midnight rollover occurred, adjust starting time
                If Timer < t1# Then
                    t1# = t1# - 86400
                End If

                t2# = (Timer - t1#) * 8 / cSeconds
            Loop While t2# - t# < .05
            t# = t2#
        Loop
    End If
    
End Function

'--------------------------------------------------------------------------
' PlotVelocity
'
'    Plots the shot velocity indicator used when a player is entering the
'    parameters for a shot.
'
'             PARAMETERS:   col         - Where to plot
'                           newVelocity - The velocity to indicate
'                           playerNum   - Which player is firing
'--------------------------------------------------------------------------
Sub PlotVelocity (col, NewVelocity, PlayerNum)
    
    margin = 33.33333 ' Assumes a 320x200 screen dimension.
    YHeight = 5
    YCenter = 50
    XWidth = 106.66667#
    
    If PlayerNum = 1 Then ' Put the indicator on the firing players side of the screen.
        XCenter = .66666
        XIncrement = XWidth
        xoffset = -1
    Else
        XCenter = 236.6667
        XIncrement = -XWidth
        xoffset = 1
    End If

    ' Plot the current velocity on indicator.  ISLANDCOLOR is used to paint the current velocity.
    Line (XCenter, YCenter)-(XCenter + XIncrement * (NewVelocity / MAXVELOCITY) + xoffset, YCenter - YHeight), ISLANDCOLOR, BF
    Line (XCenter + XIncrement * (NewVelocity / MAXVELOCITY), YCenter)-(XCenter + XIncrement + xoffset, YCenter - YHeight), BACKGROUNDCOLOR, BF
    ' Draw box around velocity indicator.
    Line (XCenter + xoffset, YCenter + 1)-(XCenter + XIncrement, YCenter - YHeight - 1), OBJECTCOLOR, B
    ' Put strip of grey at current velocity.
    Line (XCenter + XIncrement * (NewVelocity / MAXVELOCITY) + xoffset, YCenter)-(XCenter + XIncrement * (NewVelocity / MAXVELOCITY) + xoffset, YCenter - YHeight), OBJECTCOLOR
    
    Locate 5, col ' Print current velocity as numerical value also.
    Print Using "Speed:###"; NewVelocity

End Sub

'--------------------------------------------------------------------------
' SinkShip
'
'    Causes the ship that has been hit to explode in a large explosion and
'    then sink.  The explosion is created using a series of circle
'    statements.  The sinking ship is done using the BASIC graphics PUT
'    statement with the XOR option.
'
'             PARAMETERS:   x    -  x coordinate of shot
'                           y    -  y coordinate of shot
'--------------------------------------------------------------------------
Function SinkShip (x, y)

    XWidth = 8
    YHeight = 10
    
    Call CannonHit(x, y, ISLANDCOLOR) ' Do a normal cannon ball explosion.
                                       
    Call CyclePalette ' Flash the screen.
    If x < ScreenWidth / 2 Then playerHit = 1 Else playerHit = 2 ' Determine the player hit.

    Play SHIPEXPLOSIONSOUND

    ' Create the base of the explosion using expanding circles and the "stem" of the mushroom cloud using lines.
    For blast = 1 To XWidth
        Circle (ShipX(playerHit) + SHIPWIDTH / 2, ShipY(playerHit) + YHeight), blast, ISLANDCOLOR, , , -1.57
        Line (ShipX(playerHit) + SHIPWIDTH / 2 - 3.5, ShipY(playerHit) + YHeight - blast)-(ShipX(playerHit) + SHIPWIDTH / 2 + 3.5, ShipY(playerHit) + YHeight - blast), ISLANDCOLOR
    Next blast
   
    Call CyclePalette
   
    ' Create the top of the mushroom cloud using expanding circles while clearing the bottom of the cloud off.
    For Cloud = 1 To SHIPWIDTH
        If Cloud < (XWidth) Then Circle (ShipX(playerHit) + SHIPWIDTH / 2, ShipY(playerHit) + YHeight), (XWidth + 1) - Cloud, BACKGROUNDCOLOR, , , -1.57
        Circle (ShipX(playerHit) + SHIPWIDTH / 2, ShipY(playerHit)), Cloud, ISLANDCOLOR, , , -1.57
    Next Cloud
       
    Call CyclePalette
    
    For Cloud = SHIPWIDTH To 1 Step -1 ' Slowly erase the top of the cloud.
        Circle (ShipX(playerHit) + SHIPWIDTH / 2, ShipY(playerHit)), Cloud, BACKGROUNDCOLOR, , , -1.57
    Next Cloud
    SinkShip = playerHit

    xcol = ShipX(playerHit)
    origycol = ShipY(playerHit)
    ycol = origycol
    i = 1

    ' Sink the ship using the PUT statement to slowly lower the ship image and drawing lines in WATERCOLOR over the image so it seems to submerge.
    Do While i <= SHIPWIDTH And ycol + SHIPWIDTH < ScreenHeight
        Put (xcol, ycol), ShipPic(), Xor
        ycol = ycol + 1
        If ycol + SHIPWIDTH < ScreenHeight Then
            Line (xcol, ycol - 1)-(xcol + SHIPWIDTH, ycol - 1), BACKGROUNDCOLOR
            Put (xcol, ycol), ShipPic(), PSet
            For j = 0 To i
                Line (xcol, origycol + j + SHIPWIDTH)-(xcol + SHIPWIDTH, origycol + j + SHIPWIDTH), WATERCOLOR
            Next j
        End If
        i = i + 1
    Loop

End Function

