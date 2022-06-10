'                                QBLOCKS.BAS
'
' Press Page Down for information on running and modifying QBlocks.
'
' To run this game, press Shift+F5.
'
' To exit this program, press ALT, F, X.
'
' To get help on a BASIC keyword, move the cursor to the keyword and press
' F1 or click the right mouse button.
'
'                             Suggested Changes
'                             -----------------
'
' There are many ways that you can modify this BASIC game.  The CONST
' statements below these comments and the DATA statements at the end
' of this screen can be modified to change the following:
'
'    Block shapes
'    Block rotation
'    Number of different block shapes
'    Score needed to advance to next level
'    Width of the game well
'    Height of the game well
'    Songs played during game
'
' On the right side of each CONST statement, there is a comment that tells
' you what it does and how big or small you can set the value.  Above the
' DATA statements, there are comments that tell you the format of the
' information stored there.
'
' On your own, you can also add exciting sound and visual effects or make any
' other changes that your imagination can dream up.  By reading the
' Learn BASIC Now book, you'll learn the techniques that will enable you
' to fully customize this game and to create games of your own.
'
' If the game won't run after you have changed it, you can exit without
' saving your changes by pressing Alt, F, X and choosing NO.
'
' If you do want to save your changes, press Alt, F, A and enter a filename
' for saving your version of the program.  Before you save your changes,
' however, you should make sure they work by running the program and
' verifying that your changes produce the desired results.  Also, always
' be sure to keep a backup of the original program.
'
DefInt A-Z

' Here are the BASIC CONST statements you can change.  The comments tell
' you the range that each CONST value can be changed, or any limitations.
Const WELLWIDTH = 10 ' Width of playing field (well).   Range 5 to 13.
Const WELLHEIGHT = 21 ' Height of playing field.  Range 4 to 21.
Const NUMSTYLES = 7 ' Number of unique shapes.  Range 1 to 20.  Make sure you read the notes above the DATA statements at the end of the main program before you change this number!
Const WINGAME = 1000000 ' Points required to win the game.  Range 200 to 9000000.
Const NEXTLEVEL = 300 ' Helps determine when the game advances to the next level.  (Each cleared level gives player 100 points) Range 100 to 2000.
Const BASESCORE = 1000 ' Number of points needed to advance to first level.
Const ROTATEDIR = 1 ' Control rotation of blocks. Can be 1 for clockwise, or 3 for counterclockwise.
' The following sound constants are used by the PLAY command to
' produce music during the game.  To change the sounds you hear, change
' these constants.  Refer to the online help for PLAY for the correct format.
' To completely remove sound from the game set the constants equal to null.
' For example:  PLAYINTRO = ""
Const PLAYCLEARROW = "MBT255L16O4CDEGO6C" ' Tune played when a row is cleared.  Range unlimited.
Const PLAYINTRO = "MBT170O1L8CO2CO1CDCA-A-FGFA-F" ' Song played at game start.  Range unlimited.
Const PLAYGAMEOVER = "MBT255L16O6CO4GEDC" ' Song when the game is lost.  Range unlimited.
Const PLAYNEWBLOCK = "MBT160L28N20L24N5" ' Song when a new block is dropped.  Range unlimited.
Const PLAYWINGAME = "T255L16O6CO4GEDCCDEFGO6CEG" ' Song when game is won.  Range unlimited.

' The following CONST statements should not be changed like the ones above
' because the program relies on them being this value.
Const FALSE = 0 ' 0 means FALSE.
Const TRUE = Not FALSE ' Anything but 0 can be thought of as TRUE.
Const SPACEBAR = 32 ' ASCII value for space character. Drops the shape.
Const DOWNARROW = 80 ' Down arrow key.  Drops the shape.
Const RIGHTARROW = 77 ' Right arrow key.  Moves the shape right.
Const UPARROW = 72 ' Up arrow key.  Rotates the shape.
Const LEFTARROW = 75 ' Left arrow key.  Moves the shape left.
Const DOWNARROW2 = 50 ' 2 key.  Drops the shape.
Const RIGHTARROW2 = 54 ' 6 key.  Moves the shape right.
Const UPARROW2 = 56 ' 8 key.  Rotates the shape.
Const LEFTARROW2 = 52 ' 4 key.  Moves the shape left.
Const UPARROW3 = 53 ' 5 key.  Rotates the shape.
Const QUIT = "Q" ' Q key.  Quits the game.
Const PAUSE = "P" ' P key.  Pauses the game.
Const XMATRIX = 3 ' Width of the matrix that forms each falling unit.  See the discussions in Suggested Changes #2 and #3.
Const YMATRIX = 1 ' Depth of the matrix that forms each falling unit.
Const BYTESPERBLOCK = 76 ' Number of bytes required to store one block in Screen mode 7.
Const BLOCKVOLUME = (XMATRIX + 1) * (YMATRIX + 1) ' Number of blocks in each shape.
Const ELEMENTSPERBLOCK = BLOCKVOLUME * BYTESPERBLOCK \ 2 ' Number of INTEGER array elements needed to store an image of a shape.
Const XSIZE = 13 ' Width, in pixels, of each block.  QBlocks assumes that the entire screen is 25 blocks wide.  Since the screen is 320 pixels wide, each block is approximately 13 pixels wide.
Const YSIZE = 8 ' Height, in pixels, of each block.  Again, QBlocks assumes that screen is 25 blocks high.  At 200 pixels down, each block is exactly 8 pixels high.
Const XOFFSET = 10 ' X position, in blocks, of the well.
Const YOFFSET = 2 ' Y position, in blocks, of the well.
Const WELLX = XSIZE * XOFFSET ' X position, in pixels, of the start of the well.
Const WELLY = YSIZE * YOFFSET ' Y position.
Const TILTVALUE = 9999000 ' Points required for QBlocks to tilt.
Const WELLCOLOR7 = 0 ' Well color for SCREEN 7.
Const WELLCOLOR1 = 0 ' Well color for SCREEN 1.
Const BORDERCOLOR1 = 8 ' Border color for SCREEN 1.
Const BORDERCOLOR7 = 15 ' Border color for SCREEN 7.

Type BlockType ' Block datatype.
    X As Integer ' Horizontal location within the well.
    Y As Integer ' Vertical location within the well.
    Style As Integer ' Define shape (and color, indirectly).
    Rotation As Integer ' 4 possible values (0 to 3).
End Type

' SUB and FUNCTION declarations
DECLARE FUNCTION CheckFit ()
DECLARE FUNCTION GameOver ()
DECLARE SUB AddBlockToWell ()
DECLARE SUB CheckForFullRows ()
DECLARE SUB Center (M$, Row)
DECLARE SUB DeleteChunk (Highest%, Lowest%)
DECLARE SUB DisplayIntro ()
DECLARE SUB DisplayGameTitle ()
DECLARE SUB DisplayChanges ()
DECLARE SUB DrawBlock (X, Y, FillColor)
DECLARE SUB InitScreen ()
DECLARE SUB MakeInfoBox ()
DECLARE SUB NewBlock ()
DECLARE SUB PerformGame ()
DECLARE SUB RedrawControls ()
DECLARE SUB Show (b AS BlockType)
DECLARE SUB UpdateScoring ()
DECLARE SUB PutBlock (b AS BlockType)
DECLARE SUB DrawAllShapes ()
DECLARE SUB DrawPattern (Patttern)
DECLARE SUB DrawPlayingField ()

' DIM SHARED indicates that a variable is available to all subprograms.
' Without this statement, a variable used in one subprogram cannot be
' used by another subprogram or the main program.
Dim Shared Level As Integer ' Difficulty level.  0 is slowest, 9 is fastest.
Dim Shared WellBlocks(WELLWIDTH, WELLHEIGHT) As Integer ' 2 dimensional array to hold the falling shapes that have stopped falling and become part of the well.
Dim Shared CurBlock As BlockType ' The falling shape.
Dim Shared BlockShape(0 To XMATRIX, 0 To YMATRIX, 1 To NUMSTYLES) ' Holds the data required to make each shape.  Values determined by the DATA statements at the end of this window.
Dim Shared PrevScore As Long ' Holds the previous level for scoring purposes.
Dim Shared Score As Long ' Score.
Dim Shared ScreenWidth As Integer ' Width of the screen, in character-sized units.
Dim Shared ScreenMode As Integer ' Value of the graphics screen mode used.
Dim Shared WellColor As Integer ' Color inside the well.
Dim Shared BorderColor As Integer ' Color of well border and text.
Dim Shared OldBlock As BlockType ' An image of the last CurBlock.  Used to erase falling units when they move.
Dim Shared TargetTime As Single ' Time to move the shape down again.
Dim Shared GameTiltScore As Long ' Holds the value that this game will tilt at.
Dim Shared Temp(11175) As Integer ' Used by several GET and PUT statements to store temporary screen images.
Dim Shared BlockColor(1 To NUMSTYLES) As Integer ' Block color array
Dim Shared BlockImage((NUMSTYLES * 4 + 3) * ELEMENTSPERBLOCK) As Integer ' Holds the binary image of each rotation of each shape for the PutBlock subprogram to use.
Dim KeyFlags As Integer ' Internal state of the keyboard flags when game starts.  Hold the state so it can be restored when the games ends.
Dim BadMode As Integer ' Store the status of a valid screen mode.


On Error GoTo ScreenError ' Set up a place to jump to if an error occurs in the program.
BadMode = FALSE
ScreenMode = 8
Screen ScreenMode ' Attempt to go into SCREEN 7 (EGA screen).
If BadMode = TRUE Then ' If this attempt failed.
    ScreenMode = 1
    BadMode = FALSE
    Screen ScreenMode ' Attempt to go into SCREEN 1 (CGA screen).
End If
On Error GoTo 0 ' Turn off error handling.

If BadMode = TRUE Then ' If no graphics adapter.
    Cls
    Locate 10, 12: Print "CGA, EGA Color, or VGA graphics required to run QBLOCKS.BAS"
Else
    Randomize Timer ' Create a new sequence of random numbers based on the clock.
    DisplayIntro ' Show the opening screen.

    Def Seg = 0 ' Set the current segment to the low memory area.
    KeyFlags = Peek(1047) ' Read the location that holds the keyboard flag.
    If (KeyFlags And 32) = 0 Then ' If the NUM LOCK key is off
        Poke 1047, KeyFlays Or 32 ' set the NUM LOCK key to on.
    End If
    Def Seg ' Restore the default segment.
    
    ' Read the pattern for each QBlocks shape.
    For i = 1 To NUMSTYLES ' Loop for the each shape
        For j = 0 To YMATRIX ' and for the Y and X dimensions of
            For k = 0 To XMATRIX ' each shape.
                Read BlockShape(k, j, i) ' Actually read the data.
            Next k
        Next j
    Next i
    DrawAllShapes ' Draw all shapes in all four rotations.
    PerformGame ' Play the game until the player quits.
    DisplayChanges ' Show the suggested changes.
   
    Def Seg = 0 ' Set the current segment back to low memory where the keyboard flags are.
    Poke 1047, KeyFlags And 233 ' Set the NUM LOCK key back to where it was at the game start.
    Def Seg ' Restore the current segment back to BASIC's data group area.

    If ScreenMode = 7 Then Palette ' Restore the default color palette if SCREEN 7 was used.

End If

End ' End of the main program code.


' The DATA statements below define the block shapes used in the game.
' Each shape contains 8 blocks (4 x 2).  A "1" means that there
' is a block in that space; "0" means that the block is blank.  The pattern
' for Style 1, for example, creates a shape that is 4 blocks wide.
' To change an existing block's shape, change a "0" to a "1" or a "1" to
' a "0".  To add new shapes, insert new DATA statements with the same format
' as those below, after the last group of DATA statements (style 7).  Be sure
' to change the NUMSTYLES constant at the beginning of this program to reflect
' the new number of block shapes for the game.
' IMPORTANT! Creating a completely blank block will cause QBlocks to fail.

' Data for Style 1: Long
Data 1,1,1,1
Data 0,0,0,0

' Data for Style 2: L Right
Data 1,1,1,0
Data 0,0,1,0

' Data for Style 3: L Left
Data 0,1,1,1
Data 0,1,0,0

' Data for Style 4: Z Right
Data 1,1,0,0
Data 0,1,1,0

' Data for Style 5: Z Left
Data 0,1,1,0
Data 1,1,0,0

' Data for Style 6: T
Data 1,1,1,0
Data 0,1,0,0

' Data for Style 7: Square
Data 0,1,1,0
Data 0,1,1,0


ScreenError: ' QBlocks uses this error handler to determine the highest available video mode.
BadMode = TRUE
Resume Next

'----------------------------------------------------------------------------
' AddBlockToWell
'
'    After a shape stops falling, put it into the WellBlocks array
'    so later falling shapes know where to stop.
'
'           PARAMETERS:    None.
'----------------------------------------------------------------------------
Sub AddBlockToWell
   
    For i = 0 To XMATRIX ' Loop through all elements in the array.
        For j = 0 To YMATRIX
            If BlockShape(i, j, CurBlock.Style) = 1 Then ' If there is a block in that space.
                Select Case CurBlock.Rotation ' Use the Rotation to determine how the blocks should map into the WellBlocks array.
                    Case 0 ' No rotation.
                        WellBlocks(CurBlock.X + i, CurBlock.Y + j) = CurBlock.Style
                    Case 1 ' Rotated 90 degrees clockwise.
                        WellBlocks(CurBlock.X - j + 2, CurBlock.Y + i - 1) = CurBlock.Style
                    Case 2 ' Rotated 180 degrees.
                        WellBlocks(CurBlock.X - i + 3, CurBlock.Y - j + 1) = CurBlock.Style
                    Case 3 ' Rotated 270 degrees clockwise.
                        WellBlocks(CurBlock.X + j + 1, CurBlock.Y - i + 2) = CurBlock.Style
                End Select
            End If
        Next j
    Next i
End Sub

'----------------------------------------------------------------------------
' Center
'
'    Centers a string of text on a specified row.
'
'           PARAMETERS:    Text$ - Text to display on the screen.
'                          Row   - Row on the screen where the text$ is
'                                  displayed.
'----------------------------------------------------------------------------
Sub Center (text$, Row)

    Locate Row, (ScreenWidth - Len(text$)) \ 2 + 1
    Print text$;

End Sub

'----------------------------------------------------------------------------
' CheckFit
'
'    Checks to see if the shape will fit into its new position.
'    Returns TRUE if it fits and FALSE if it does not fit.
'
'           PARAMETERS:    None
'
'----------------------------------------------------------------------------
Function CheckFit

    CheckFit = TRUE ' Assume the shape will fit.
   
    For i = 0 To XMATRIX ' Loop through all the blocks in the
        For j = 0 To YMATRIX ' shape and see if any would
            ' overlap blocks already in the well.
            If BlockShape(i, j, CurBlock.Style) = 1 Then ' 1 means that space, within the falling shape, is filled with a block.
                Select Case CurBlock.Rotation ' Base the check on the rotation of the shape.
                    Case 0 ' No rotation.
                        NewX = CurBlock.X + i
                        NewY = CurBlock.Y + j
                    Case 1 ' Rotated 90 degrees clockwise, or 270 degrees counterclockwise.
                        NewX = CurBlock.X - j + 2
                        NewY = CurBlock.Y + i - 1
                    Case 2 ' Rotated 180 degrees.
                        NewX = CurBlock.X - i + 3
                        NewY = CurBlock.Y - j + 1
                    Case 3 ' Rotated 270 degrees clockwise, or 90 degrees counterclockwise.
                        NewX = CurBlock.X + j + 1
                        NewY = CurBlock.Y - i + 2
                End Select

                ' Set CheckFit to false if the block would be out of the well.
                If (NewX > WELLWIDTH - 1 Or NewX < 0 Or NewY > WELLHEIGHT - 1 Or NewY < 0) Then
                    CheckFit = FALSE
                    Exit Function

                    ' Otherwise, set CheckFit to false if the block overlaps
                    ' an existing block.
                ElseIf WellBlocks(NewX, NewY) Then
                    CheckFit = FALSE
                    Exit Function
                End If

            End If
        Next j
    Next i

End Function

'----------------------------------------------------------------------------
' CheckForFullRows
'
'    Checks for filled rows.  If a row is filled, delete it and move
'    the blocks above down to fill the deleted row.
'
'           PARAMETERS:   None
'----------------------------------------------------------------------------
Sub CheckForFullRows

    Dim RowsToDelete(WELLHEIGHT) ' Temporary array to track rows that should be deleted.
    NumRowsToDelete = 0
    i = WELLHEIGHT ' Begin scanning from the bottom up.
    Do
        DeleteRow = TRUE ' Assume the row should be deleted.
        j = 0
        Do ' Scan within each row for blocks.
            DeleteRow = DeleteRow * Sgn(WellBlocks(j, i)) ' If any position is blank, DeleteRow is 0 (FALSE).
            j = j + 1
        Loop While DeleteRow = TRUE And j < WELLWIDTH
       
        If DeleteRow = TRUE Then
            ' Walk up the rows and copy them down in the WellBlocks array.
            NumRowsToDelete = NumRowsToDelete + 1 ' Number of rows to delete.
            RowsToDelete(i - NumDeleted) = TRUE ' Mark the rows to be deleted, compensating for rows that have already been deleted below it.
            NumDeleted = NumDeleted + 1 ' Compensates for rows that have been deleted already.
           
            ' Logically delete the row by moving all WellBlocks values down.
            For Row = i To 1 Step -1
                For Col = 0 To WELLWIDTH
                    WellBlocks(Col, Row) = WellBlocks(Col, Row - 1)
                Next Col
            Next Row
        Else ' This row will not be deleted.
            i = i - 1
        End If
    Loop While i >= 1 ' Stop looping when the top of the well is reached.
           
    If NumRowsToDelete > 0 Then
        Score = Score + 100 * NumRowsToDelete ' Give 100 points for every row.
       
        ' Set Highest and Lowest such that any deleted row will initially set them.
        Highest = -1
        Lowest = 100
       
        ' Find where the highest and lowest rows to delete are.
        For i = WELLHEIGHT To 1 Step -1
            If RowsToDelete(i) = TRUE Then
                If i > Highest Then Highest = i
                If i < Lowest Then Lowest = i
            End If
        Next i
        
        If (Highest - Lowest) + 1 = NumRowsToDelete Then ' Only one contiguous group of rows to delete.
            DeleteChunk Highest, Lowest
        Else ' Two groups of rows to delete.
            ' Begin at Lowest and scan down for a row NOT to be deleted.
            ' Then delete everything from Lowest to the row not to be deleted.
            i = Lowest
            Do While i <= Highest
                If RowsToDelete(i) = FALSE Then
                    DeleteChunk i - 1, Lowest
                    Exit Do
                Else
                    i = i + 1
                End If
            Loop
           
            ' Now look for the second group and delete those rows.
            Lowest = i
            Do While RowsToDelete(Lowest) = FALSE
                Lowest = Lowest + 1
            Loop
            DeleteChunk Highest, Lowest
       
        End If
    End If

End Sub

'----------------------------------------------------------------------------
' DeleteChunk
'
'    Deletes a group of one or more rows.
'
'           PARAMETERS:    Highest - Highest row to delete (physically lowest
'                                    on screen).
'                          Lowest  - Lowest row to delete (physically highest
'                                    on screen).
'----------------------------------------------------------------------------
Sub DeleteChunk (Highest, Lowest)
   
    ' GET the image of the row to delete.
    Get (WELLX, Lowest * YSIZE + WELLY)-(WELLX + WELLWIDTH * XSIZE, (Highest + 1) * YSIZE + WELLY - 1), Temp()
    Play PLAYCLEARROW
   
    ' Flash the rows 3 times.
    For Flash = 1 To 3
        Put (WELLX, Lowest * YSIZE + WELLY), Temp(), PReset
        DelayTime! = Timer + .02
        Do While Timer < DelayTime!: Loop
        Put (WELLX, Lowest * YSIZE + WELLY), Temp(), PSet
        DelayTime! = Timer + .02
        Do While Timer < DelayTime!: Loop
    Next Flash
   
    ' Move all the rows above the deleted ones down.
    Get (WELLX, WELLY)-(WELLX + WELLWIDTH * XSIZE, Lowest * YSIZE + WELLY), Temp()
    Put (WELLX, (Highest - Lowest + 1) * YSIZE + WELLY), Temp(), PSet
    'Erase the area above the block which just moved down.
    Line (WELLX, WELLY)-(WELLX + WELLWIDTH * XSIZE, WELLY + (Highest - Lowest + 1) * YSIZE), WellColor, BF
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
    
    Color 7
    Center "The following game characteristics can be easily changed from", 5
    Center "within the QuickBASIC Interpreter.  To change the values of  ", 6
    Center "these characteristics, locate the corresponding CONST or DATA", 7
    Center "statements in the source code and change their values, then  ", 8
    Center "restart the program (press Shift + F5).                      ", 9

    Color 15
    Center "Block shapes                         ", 11
    Center "Block rotation                       ", 12
    Center "Number of different block shapes     ", 13
    Center "Score needed to advance to next level", 14
    Center "Width of the game well               ", 15
    Center "Height of the game well              ", 16
    Center "Songs played during game             ", 17

    Color 7
    Center "The CONST statements and instructions on changing them are   ", 19
    Center "located at the beginning of the main program.                ", 20

    Do While InKey$ = "": Loop ' Wait for any key to be pressed.
    Cls ' Clear screen.

End Sub

'----------------------------------------------------------------------------
' DisplayGameTitle
'
'    Displays title of the game.
'
'           PARAMETERS:    None.
'----------------------------------------------------------------------------
Sub DisplayGameTitle

    Screen 0
    Width 80, 25 ' Set width to 80, height to 25.
    Color 4, 0 ' Set colors for red on black.
    Cls ' Clear the screen.
    ScreenWidth = 80 ' Set screen width variable to match current width.

    ' Draw outline around screen with extended ASCII characters.
    Locate 1, 2
    Print Chr$(201); String$(76, 205); Chr$(187);
    For i% = 2 To 24
        Locate i%, 2
        Print Chr$(186); Tab(79); Chr$(186);
    Next i%
    Locate 25, 2
    Print Chr$(200); String$(76, 205); Chr$(188);

    'Print game title centered at top of screen
    Color 0, 4
    Center "      Microsoft      ", 1
    Center "    Q B L O C K S    ", 2
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
    
    Cls
    DisplayGameTitle
   
    Center "QBlocks challenges you to keep the well from filling.  Do this by", 5
    Center "completely filling rows with blocks, making the rows disappear.  ", 6
    Center "Move and rotate the falling shapes to get them into the best     ", 7
    Center "position.  The game will get faster as you score more points.    ", 8

    Color 4 ' Change foreground color for line to red.
    Center String$(74, 196), 11 ' Put horizontal red line on screen.
    Color 7 ' White (7) letters.        ' Change foreground color back to white
    Center " Game Controls ", 11 ' Display game controls.
    Center "     General                             Block Control      ", 13
    Center "                                     (Rotate)", 15
    Center "   P - Pause                                 " + Chr$(24) + " (or 5)   ", 16
    Center "      Q - Quit                         (Left) " + Chr$(27) + "   " + Chr$(26) + " (Right)   ", 17
    Center "                                    " + Chr$(25), 18
    Center "                                          (Drop)      ", 19
    
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
' DrawAllShapes
'
'    Quickly draws all shapes in all four rotations.  Uses GET
'    to store the images so they can be PUT onto the screen
'    later very quickly.
'
'           PARAMETERS:    None.
'----------------------------------------------------------------------------
Sub DrawAllShapes

    Dim b As BlockType
    Screen ScreenMode ' Set the appropriate screen mode.
   
    ' On EGA and VGA systems, appear to blank the screen.
    If ScreenMode = 7 Then
        Dim Colors(0 To 15) ' DIM an array of 16 elements.  By default, all elements are 0.
        Palette Using Colors() ' Redefine the colors all to 0.
        For i = 1 To NUMSTYLES ' Set block colors EGA, VGA
            BlockColor(i) = ((i - 1) Mod 7) + 1
        Next i
    Else
        For i = 1 To NUMSTYLES 'Set block colors for CGA
            BlockColor(i) = ((i - 1) Mod 3) + 1
        Next i
    End If

    Cls
    Count = 0 ' Count determines how many shapes have been drawn on the screen and vertically where.
    For shape = 1 To NUMSTYLES ' Loop through all shapes.

        RtSide = 4
        Do
            If BlockShape(RtSide - 1, 0, shape) = 1 Or BlockShape(RtSide - 1, 1, shape) = 1 Then Exit Do
            RtSide = RtSide - 1
        Loop Until RtSide = 1

        LtSide = 0
        Do
            If BlockShape(LtSide, 0, shape) = 1 Or BlockShape(LtSide, 1, shape) = 1 Then Exit Do
            LtSide = LtSide + 1
        Loop Until LtSide = 3

        For Rotation = 0 To 3 ' Loop through all rotations.
            b.X = Rotation * 4 + 2 ' Determine where to put the shape.
            b.Y = Count + 2
            b.Rotation = Rotation
            b.Style = shape
            Show b ' Draw the shape.
           
            X = b.X: Y = b.Y
            Select Case Rotation ' Based on Rotation, determine where the shape really is on the screen.
                Case 0 ' No rotation.
                    x1 = X: x2 = X + RtSide: y1 = Y: y2 = Y + 2
                Case 1 ' Rotated 90 degrees clockwise.
                    x1 = X + 1: x2 = X + 3: y1 = Y - 1: y2 = Y + RtSide - 1
                Case 2 ' 180 degrees.
                    x1 = X: x2 = X + 4 - LtSide: y1 = Y: y2 = Y + 2
                Case 3 ' Rotated 270 degrees clockwise.
                    x1 = X + 1: x2 = X + 3: y1 = Y - 1: y2 = Y + 3 - LtSide
            End Select
           
            ' Store the image of the rotated shape into an array for fast recall later.
            Get (x1 * XSIZE, y1 * YSIZE)-(x2 * XSIZE, y2 * YSIZE), BlockImage(((shape - 1) * 4 + Rotation) * ELEMENTSPERBLOCK)
       
        Next Rotation
       
        Count = Count + 5 ' Increase Count by 5 to leave at least one blank line between shapes.
        If Count = 20 Then ' No space for any more shapes.
            Cls
            Count = 0
        End If
   
    Next shape
   
    Cls
   
    ' Changes the color palette if SCREEN is used.
    If ScreenMode = 7 Then
        Palette ' Restore default color settings.
        Palette 6, 14 ' Make brown (6) look like yellow (14).
        Palette 14, 15 ' Make yellow (14) look like bright white (15).
    End If

End Sub

'----------------------------------------------------------------------------
' DrawBlock
'
'    Draws one block of a QBlocks shape.
'
'           PARAMETERS:    X         - Horizontal screen location.
'                          Y         - Vertical screen location.
'                          FillColor - The primary color of the block.
'                                      The top and left edges will be the
'                                      brighter shade of that color.
'----------------------------------------------------------------------------
Sub DrawBlock (X, Y, FillColor)

    Line (X * XSIZE + 2, Y * YSIZE + 2)-((X + 1) * XSIZE - 2, (Y + 1) * YSIZE - 2), FillColor, BF
    Line (X * XSIZE + 1, Y * YSIZE + 1)-((X + 1) * XSIZE - 1, Y * YSIZE + 1), FillColor + 8
    Line (X * XSIZE + 1, Y * YSIZE + 1)-(X * XSIZE + 1, (Y + 1) * YSIZE - 1), FillColor + 8

End Sub

'----------------------------------------------------------------------------
' DrawPattern
'
'    Draws a background pattern that is 32 pixels wide by 20 pixels
'    deep.  Gets the pattern and duplicates it to fill the screen.
'
'           PARAMETERS:    Pattern - Which of the 10 available patterns to
'                                    draw.
'----------------------------------------------------------------------------
Sub DrawPattern (Pattern)

    Cls
    X = 1: Y = 1
    Dim Temp2(215) As Integer ' Create an array to store the image.
   
    ' Draw the pattern specified.
    Select Case Pattern
        Case 0
            j = Y + 21
            For i = X To X + 27 Step 3
                j = j - 2
                Line (i, j)-(i, Y + 19), 12, BF
            Next i
            Line (X, Y)-(X + 30, Y + 19), 4, B
            Line (X + 1, Y + 1)-(X + 31, Y + 18), 4, B
        Case 1
            Line (X, Y)-(X + 8, Y + 12), 1, BF
            Line (X + 9, Y + 8)-(X + 24, Y + 20), 2, BF
            Line (X + 25, Y)-(X + 32, Y + 12), 3, BF
        Case 2
            Line (X, Y)-(X + 29, Y + 18), X / 32 + 1, B
            Line (X + 1, Y + 1)-(X + 28, Y + 17), X / 32 + 2, B
        Case 3
            For i = 0 To 9 Step 2
                Line (X + i, Y + i)-(X + 29 - i, Y + 18 - i), i, B
            Next i
        Case 4
            j = 0
            For i = 1 To 30 Step 3
                Line (X + i, Y + j)-(X + 30 - i, Y + j), i
                Line (X + i, Y + 19 - j)-(X + 30 - i, Y + 19 - j), i
                j = j + 2
            Next i
        Case 5
            Line (X, Y)-(X + 29, Y + 4), 1, BF
            Line (X, Y)-(X + 4, Y + 18), 1, BF
            Line (X + 7, Y + 7)-(X + 29, Y + 11), 5, BF
            Line (X + 7, Y + 7)-(X + 11, Y + 18), 5, BF
            Line (X + 14, Y + 14)-(X + 29, Y + 18), 4, BF
        Case 6
            Line (X + 15, Y)-(X + 17, Y + 19), 1
            Line (X, Y + 9)-(X + 31, Y + 11), 2
            Line (X, Y + 1)-(X + 31, Y + 18), 9
            Line (X + 30, Y)-(X + 1, Y + 19), 10
        Case 7
            For i = 1 To 6
                Circle (X + 16, Y + 10), i, i
            Next i
        Case 8
            For i = X To X + 30 Step 10
                Circle (i, Y + 9), 10, Y / 20 + 1
            Next i
        Case 9
            Line (X + 1, Y)-(X + 1, Y + 18), 3
            Line (X + 1, Y)-(X + 12, Y + 18), 3
            Line (X + 1, Y + 18)-(X + 12, Y + 18), 3
            Line (X + 30, Y)-(X + 30, Y + 18), 3
            Line (X + 30, Y)-(X + 19, Y + 18), 3
            Line (X + 30, Y + 18)-(X + 19, Y + 18), 3
            Line (X + 4, Y)-(X + 26, Y), 1
            Line (X + 4, Y)-(X + 15, Y + 18), 1
            Line (X + 26, Y)-(X + 15, Y + 18), 1
    End Select
   
    Get (0, 0)-(31, 19), Temp2() ' GET the image.
   
    ' Duplicate the image 10 times across by 10 times down.
    For H = 0 To 319 Step 32
        For V = 0 To 199 Step 20
            Put (H, V), Temp2(), PSet
        Next V
    Next H

End Sub

'----------------------------------------------------------------------------
' DrawPlayingField
'
'    Draws the playing field, including the well, the title, the
'    score/level box, etc.
'
'           PARAMETERS:   None
'----------------------------------------------------------------------------
Sub DrawPlayingField
   
    Select Case ScreenMode ' Choose the screen colors based on the current mode.
        Case 7
            WellColor = WELLCOLOR7
            BorderColor = BORDERCOLOR7

        Case Else ' Setup for SCREEN 1.
            WellColor = WELLCOLOR1
            BorderColor = BORDERCOLOR1
    End Select
   
    ScreenWidth = 40 ' Set to proper width and colors.
   
    ' Draw the background pattern.
    DrawPattern Level
  
    ' Draw the well box.
    Line (WELLX - 1, WELLY - 5)-(WELLX + WELLWIDTH * XSIZE + 1, WELLY + WELLHEIGHT * YSIZE + 1), WellColor, BF
    Line (WELLX - 1, WELLY - 5)-(WELLX + WELLWIDTH * XSIZE + 1, WELLY + WELLHEIGHT * YSIZE + 1), BorderColor, B
   
    ' Draw the title box.
    Line (XSIZE, WELLY - 5)-(XSIZE * 8, WELLY + 12), WellColor, BF
    Line (XSIZE, WELLY - 5)-(XSIZE * 8, WELLY + 12), BorderColor, B
   
    ' Draw the scoring box.
    Line (XSIZE, WELLY + 20)-(WELLX - 2 * XSIZE, 78), WellColor, BF
    Line (XSIZE, WELLY + 20)-(WELLX - 2 * XSIZE, 78), BorderColor, B
                                         
    MakeInfoBox ' Draw the Information Box.

    Color 12
    Locate 3, 5: Print "QBLOCKS" ' Center the program name on line 2.
    Color BorderColor

    ' Draw the scoring area.
    Locate 6, 4: Print "Score:";
    Locate 7, 4: Print Using "#,###,###"; Score
    Locate 9, 4: Print Using "Level: ##"; Level

End Sub

'----------------------------------------------------------------------------
' GameOver
'
'    Ends the game and asks the player if he/she wants to play
'    again.  GameOver returns TRUE if the player wishes to stop
'    or FALSE if the player wants another game.
'
'           PARAMETERS:   None
'----------------------------------------------------------------------------
Function GameOver
   
    Play PLAYGAMEOVER ' Play the game over tune.
    MakeInfoBox

    Do While InKey$ <> "": Loop ' Clear the keyboard buffer.

    ' Put Game Over messages into the InfoBox.
    Locate 14, 4: Print "Game Over"
    Locate 17, 6: Print "Play"
    Locate 18, 5: Print "again?"
    Locate 20, 6: Print "(Y/N)"
    
    ' Wait for the player to press either Y or N.
    Do
        a$ = UCase$(InKey$) ' UCASE$ assures that the key will be uppercase.  This eliminates the need to check for y and n in addition to Y and N.
    Loop Until a$ = "Y" Or a$ = "N"
   
    If a$ = "Y" Then ' If player selects "Y",
        GameOver = FALSE ' game is not over,
    Else ' otherwise
        GameOver = TRUE ' the game is over.
    End If
  
End Function

'----------------------------------------------------------------------------
' InitScreen
'
'    Draws the playing field and ask for the desired starting level.
'
'           PARAMETERS:   None
'----------------------------------------------------------------------------
Sub InitScreen

    DrawPlayingField ' Draw playing field assuming Level 0.

    ' Prompt for starting level.
    Color 12 ' Change foreground color to bright red.
    Locate 14, 5: Print "Select";
    Locate 16, 5: Print "start";
    Locate 18, 5: Print "level?";
    Locate 20, 5: Print "(0 - 9)";
    Color BorderColor ' Restore the default text color to BorderColor (white).
    Level = TRUE ' Use level as flag as well as a real value.  Level remain TRUE if Q (Quit) is pressed instead of a level.
   
    ' Get a value for Level or accept a Q.
    Do
        a$ = UCase$(InKey$)
    Loop While (a$ > "9" Or a$ < "0") And a$ <> "Q"
   
    If a$ = "Q" Then
        Exit Sub
    Else
        Level = Val(a$)
    End If

    If Level > 0 Then DrawPlayingField ' Draw new playing field because the background pattern depends on the level.
    RedrawControls ' Draw the controls.

End Sub

'----------------------------------------------------------------------------
' MakeInfoBox
'
'    Draws the information box.
'
'           PARAMETERS:   None
'----------------------------------------------------------------------------
Sub MakeInfoBox

    Line (WELLX - 9 * XSIZE, 90)-(WELLX - 2 * XSIZE, 185), WellColor, BF ' Clear the Info area.
    Line (WELLX - 9 * XSIZE, 90)-(WELLX - 2 * XSIZE, 185), BorderColor, B ' Draw a border around it.

End Sub

'----------------------------------------------------------------------------
' NewBlock
'
'    Initializes a new falling shape about to enter the well.
'
'           PARAMETERS:   None
'----------------------------------------------------------------------------
Sub NewBlock

    CurBlock.Style = Int(Rnd(1) * NUMSTYLES) + 1 ' Randomly pick a block style.
    CurBlock.X = (WELLWIDTH \ 2) - 1 ' Put the new shape in the horizontal middle of the well
    CurBlock.Y = 0 ' and at the top of the well.
    CurBlock.Rotation = 0 ' Begin with no rotation.

    Play PLAYNEWBLOCK

End Sub

'----------------------------------------------------------------------------
' PerformGame
'
'    Continues to play the game until the player quits.
'
'           PARAMETERS:   None
'----------------------------------------------------------------------------
Sub PerformGame

    Do ' Loop for repetitive games
        a$ = ""
        Erase WellBlocks ' Set all the elements in the WellBlocks array to 0.
        Score = 0 ' Clear initial score.
        Level = 0 ' Assume Level 0.
        PrevScore = BASESCORE - NEXTLEVEL ' Set score needed to get to first level
        GameTiltScore = WINGAME ' Set the initial win game value.
       
        InitScreen ' Prepare the screen and get the difficulty level.
        If Level = -1 Then Exit Sub ' Player pressed Q instead of a level.
       
        TargetTime = Timer + 1 / (Level + 1) ' TargetTime is when the falling shape will move down again.
        Do ' Create new falling shapes until the game is over.
            DoneWithThisBlock = FALSE ' This falling shape is not done falling yet.
            NewBlock ' Create a new falling unit.
            If CheckFit = FALSE Then Exit Do ' If it does not fit, then the game is over.
            PutBlock CurBlock ' Display the new shape.
           
            Do ' Continue dropping the falling shape.
                OldBlock = CurBlock ' Save current falling shape for possible later use.
                Do ' Loop until enough time elapses.
                   
                    ValidEvent = TRUE ' Assume a key was pressed.
                    ans$ = UCase$(InKey$)

                    If ans$ = PAUSE Or ans$ = QUIT Then
                        MakeInfoBox
                   
                        ' SELECT CASE will do different actions based on the
                        ' value of the SELECTED variable.
                        Select Case ans$
                            Case PAUSE
                                Sound 1100, .75
                                Locate 16, 6: Print "GAME";
                                Locate 18, 5: Print "PAUSED";
                                Do While InKey$ = "": Loop ' Wait until another key is pressed.
                            Case QUIT
                                ' Play sounds to tell the player that Q was pressed.
                                Sound 1600, 1
                                Sound 1000, .75
                               
                                ' Confirm that the player really wants to quit.
                                Locate 15, 5: Print "Really";
                                Locate 17, 6: Print "quit?";
                                Locate 19, 6: Print "(Y/N)";
                                Do
                                    a$ = UCase$(InKey$)
                                Loop Until a$ <> ""
                                If a$ = "Y" Then Exit Sub
                        End Select
                        RedrawControls ' Redraw controls if either Q or P is pressed.
                   
                    Else ' A key was pressed but not Q or P.
                        ans = Asc(Right$(Chr$(0) + ans$, 1)) ' Convert the key press to an ASCII code for faster processing.
                        Select Case ans
                            Case DOWNARROW, DOWNARROW2, SPACEBAR ' Drop shape immediately.
                                Do ' Loop to drop the falling unit one row at a time.
                                    CurBlock.Y = CurBlock.Y + 1
                                Loop While CheckFit = TRUE ' Keep looping while the falling unit isn't stopped.
                                CurBlock.Y = CurBlock.Y - 1 ' Went one down too far, restore to previous.
                                TargetTime = Timer - 1 ' Ensure that the shape falls immediately.
                            Case RIGHTARROW, RIGHTARROW2
                                CurBlock.X = CurBlock.X + 1 ' Move falling unit right.
                            Case LEFTARROW, LEFTARROW2
                                CurBlock.X = CurBlock.X - 1 ' Move falling unit left.
                            Case UPARROW, UPARROW2, UPARROW3
                                CurBlock.Rotation = ((CurBlock.Rotation + ROTATEDIR) Mod 4) ' Rotate falling unit.
                            Case Else
                                ValidEvent = FALSE
                        End Select

                        If ValidEvent = TRUE Then
                            If CheckFit = TRUE Then ' If the move is valid and the shape fits in the new position,
                                PutBlock OldBlock ' erase the shape from its old position
                                PutBlock CurBlock ' and display it in the new position.
                                OldBlock = CurBlock
                            Else
                                CurBlock = OldBlock ' If it does not fit then reset CurBlock to the OldBlock.
                            End If
                        End If
                    End If

                Loop Until Timer >= TargetTime ' Keep repeating the loop until it is time to drop the shape.  This allows many horizontal movements and rotations per vertical step.
               
                TargetTime = Timer + 1 / (Level + 1) ' The player has less time between vertical movements as the skill level increases.
                CurBlock.Y = CurBlock.Y + 1 ' Try to drop the falling unit one row.

                If CheckFit = FALSE Then ' Cannot fall any more.
                    DoneWithThisBlock = TRUE ' Done with this block.
                    CurBlock = OldBlock
                End If
               
                PutBlock OldBlock ' Erase the falling shape from the old position,
                PutBlock CurBlock ' and display it in the new position.
                OldBlock = CurBlock

            Loop Until DoneWithThisBlock ' Continue getting keys and moving shapes until the falling shape stops.
           
            AddBlockToWell ' Shape has stopped so logically add it to the well.
            CheckForFullRows ' Check to see if a row(s) is now full.  If so, deletes it.
            UpdateScoring ' Use the UpdateScoring subprogram to add to the score.

            If Score >= GameTiltScore Then ' See if the score has hit the tilt score.

                Play PLAYWINGAME
                MakeInfoBox
                Locate 13, 5: Print Using "#######"; Score
                Play PLAYWINGAME

                If GameTiltScore = TILTVALUE Then ' If the player has tilted the game.
                    Locate 15, 4: Print "GAME TILT"
                    Locate 17, 5: Print "You are"
                    Locate 18, 4: Print "Awesome!"
                    Locate 20, 4: Print "Press any"
                    Locate 21, 6: Print "key..."
                    Play PLAYWINGAME
                    Do While InKey$ = "": Loop
                    Exit Sub
                Else ' If they just met the WINGAME value.
                    Locate 15, 4: Print "YOU WON!"
                    Locate 17, 5: Print "Want to"
                    Locate 18, 4: Print "continue"
                    Locate 20, 6: Print "(Y/N)"

                    Do ' DO loop to wait for the player to press anything.
                        a$ = UCase$(InKey$) ' The UCASE$ function assures that a$ always has an uppercase letter in it.
                    Loop Until a$ <> ""
        
                    If a$ <> "Y" Then Exit Do ' Exit this main loop if the player pressed anything but Y.

                    GameTiltScore = TILTVALUE ' Reset to the tilt value.

                    RedrawControls
                End If
            End If

        Loop ' Unconditional loop.  Each game is stopped by the EXIT DO command at the top of this loop that executes when a new block will not fit in the well.
    Loop Until GameOver ' GameOver is always TRUE (-1) unless the user presses X or the well is full.

End Sub

'----------------------------------------------------------------------------
' PutBlock
'
'    Uses very fast graphics PUT command to draw the shape.
'
'           PARAMETERS:    B - Block to be put onto the screen.
'----------------------------------------------------------------------------
Sub PutBlock (b As BlockType)
   
    Select Case b.Rotation ' Base exact placement on the rotation.
        Case 0 ' No rotation.
            x1 = b.X: y1 = b.Y
        Case 1 ' Rotated 90 degrees clockwise, or 270 degrees counterclockwise.
            x1 = b.X + 1: y1 = b.Y - 1
        Case 2 ' Rotated 180 degrees.
            x1 = b.X: y1 = b.Y
        Case 3 ' Rotated 270 degrees clockwise, or 90 degrees counterclockwise.
            x1 = b.X + 1: y1 = b.Y - 1
    End Select
   
    ' Actually PUT the rotated shape on the screen.  The XOR option makes the
    ' new image blend with whatever used to be there in such a way that
    ' identical colors cancel each other out.  Therefore, one PUT with the XOR
    ' option can draw an object while the second PUT to that same location
    ' erases it without affecting anything else near it.  Often used for animation.

    Put (x1 * XSIZE + WELLX, y1 * YSIZE + WELLY), BlockImage(((b.Style - 1) * 4 + b.Rotation) * ELEMENTSPERBLOCK), Xor ' XOR mixes what used to be there on the screen with the new image.  Two identical colors cancel each other.

End Sub

'----------------------------------------------------------------------------
' RedrawControls
'
'    Puts control keys information into the information box.
'
'           PARAMETERS:   None
'----------------------------------------------------------------------------
Sub RedrawControls
  
    ' Draw the InfoBox and erase anything that used to be in it.
    MakeInfoBox

    ' Print the key assignments within the Info Box.
    Color BorderColor
    Locate 13, 4: Print "Controls"
    Locate 14, 4: Print "--------"
    Locate 15, 4: Print Chr$(24) + " = Turn"
    Locate 16, 4: Print Chr$(27) + " = Left"
    Locate 17, 4: Print Chr$(26) + " = Right"
    Locate 18, 4: Print Chr$(25) + " = Drop"
    Locate 20, 4: Print "P = Pause"
    Locate 21, 4: Print "Q = Quit"

End Sub

'----------------------------------------------------------------------------
' Show
'
'    Draws the falling shape one block at a time.  Only used by
'    DisplayAllShapes.  After that, PutBlock draws all falling
'    shapes.
'
'           PARAMETERS:    B - Block to be put onto the screen.
'----------------------------------------------------------------------------
Sub Show (b As BlockType)
                                                 
    ' Loop through all possible block locations.
    For i = 0 To XMATRIX
        For j = 0 To YMATRIX
           
            If BlockShape(i, j, b.Style) = 1 Then ' 1 means there is a block there.
                Select Case b.Rotation ' Exact screen position is determined by the rotation.
                    Case 0 ' No rotation.
                        DrawBlock b.X + i, b.Y + j, BlockColor(b.Style)
                    Case 1 ' Rotated 90 degrees clockwise, or 270 degrees counterclockwise.
                        DrawBlock b.X - j + 2, b.Y - 1 + i, BlockColor(b.Style)
                    Case 2 ' Rotated 180 degrees.
                        DrawBlock b.X + 3 - i, b.Y - j + 1, BlockColor(b.Style)
                    Case 3 ' Rotated 270 degrees clockwise, or 90 degrees counterclockwise.
                        DrawBlock b.X + j + 1, b.Y - i + 2, BlockColor(b.Style)
                End Select
            End If
        Next j
    Next i

End Sub

'---------------------------------------------------------------------------
' UpdateScoring
'
'    Puts the new score on the screen.  Checks if the new score forces
'    a new level.  If so, change the background pattern to match the
'    new level.
'
'           PARAMETERS:     None
'----------------------------------------------------------------------------
Sub UpdateScoring
   
    ' Increase the level if the score is high enough and the level is not
    ' maximum already.
    If Level < 9 And Score >= (NEXTLEVEL * (Level + 1) + PrevScore) Then
   
        ' Store the entire well image to quickly PUT it back after the
        ' background changes.
        Get (WELLX, WELLY)-(WELLX + WELLWIDTH * XSIZE, WELLY + WELLHEIGHT * YSIZE), Temp()
       
        PrevScore = Score ' Save previous Score for next level.
        Level = Level + 1
        DrawPlayingField ' Draw playing field again, this time with the new background pattern.
        Put (WELLX, WELLY), Temp() ' Restore the image of the old well.
   
        RedrawControls ' Show the controls again.
    End If

    Locate 7, 4: Print Using "#,###,###"; Score ' Print the score and level.
    
End Sub

