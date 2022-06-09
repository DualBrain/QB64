'/=================================================================\
'  (C) David Joffe 1997
'  DJ Software; April '97                        https://djoffe.com/
'-------------------------------------------------------------------
'  VGA Sokoban v1.0, for QBasic!
'-------------------------------------------------------------------
'  -[ The object of the game: ]----------------------------------
'  You are a Pacman derivative; you must push all the crate-type
'  blocks onto the destination-type blocks. There are 90 levels,
'  which I got from XSokoban, a sokoban for the X Window System.
'  --------------------------------------------------------------
'
'  You can do whatever you want with this program, on the single
'  preferred condition that if you create any derivative works,
'  I would like to be credited, at minimum with a link to my
'  website.
'
'  Please send me bug-reports and any other feedback; i.e. tell
'  me you like it or hate it or have no opinion about it, but just
'  tell me something!
'
'  New levels: I would love it if you create new levels (or even
'  new sprites) if you would send them to me; they will probably
'  be included in later versions, in which case you will get credit.
'
'  The savegame file format is a really tough one to crack, but
'  see if you can give it a go ;-)
'\=================================================================/

$NoPrefix
' Default data type to integer for fastest processing
DefInt A-Z

$Resize:Smooth

' To hold sprites
Dim Graphics(1 To 2000)

' The following piece of code first tries for VGA; if that fails,
' it tries EGA. If that fails, it leaves.
On Error GoTo TryEGA
Screen 13
GoTo GraphicsSuccess

TryEGA:
On Error GoTo NoGraphics
Screen 7
GoTo GraphicsSuccess

NoGraphics:
Color 15, 0: Cls
Print "You don't seem to have graphics capable hardware."
Print "There is a text version available though."
Print
GoTo ContactMessage

GraphicsSuccess:
On Error GoTo 0

' Draw the graphics and GET it
Restore GraphicsData
For i = 0 To 23
    For j = 0 To 10
        For k = 0 To 10
            Read n
            PSet (k, j), n
        Next k
    Next j
    Get (0, 0)-(10, 10), Graphics(i * 80 + 1)
Next i

' Constants
Dim Shared NUMLEVELS
NUMLEVELS = 90

Dim Shared LEVELFILENAME As String
LEVELFILENAME$ = "djsok.dat"
Dim Shared OFSX
OFSX = 6
Dim Shared OFSY
OFSY = 6

' Dimensions of playing area
Dim Shared MAXX
MAXX = 20
Dim Shared MAXY
MAXY = 17
' Set this to 1 to enable cheats; then pressing "$" advances a level
Dim Shared CHEATSENABLED
CHEATSENABLED = 0

' Search string: position of a character in string is used as the
' index for Colour array dereferencing and for how to handle that
' type of character in the game
GameData$ = "€–∆»“∫…ÃµºÕ ªπÀŒ Ë≤"

' Offsets into GameData$ of certain important character types
Dim Shared POSCRATE
POSCRATE = 19
Dim Shared POSSPACE
POSSPACE = 18
Dim Shared POSCRATEATDEST
POSCRATEATDEST = 20
Dim Shared POSDEST
POSDEST = 17
Dim Shared POSHERO
POSHERO = 21

' Certain important character types
CharCrate$ = Mid$(GameData$, POSCRATE, 1)
CharCrateAtDest$ = Mid$(GameData$, POSCRATEATDEST, 1)
CharDest$ = Mid$(GameData$, POSDEST, 1)

' Data structures
Dim TempMap(0 To MAXY + 1) As String * 22
Dim Map(0 To MAXY + 1) As String * 22

' Initialize screen
Color 15: Cls

' Level should be set to 0 here to make entry point level 1
Level = 0
Won = 1

'===========================================================[ BEGIN MAIN ]==
MainLoop:
' Get keypress
a$ = InKey$

' Reset level or advance level
If Won = 1 Or UCase$(a$) = "R" Then
    If (UCase$(a$) <> "R") And (Level >= 1) Then
        Color 15
        Locate 19, 2: Print "Press a key ...";
        While InKey$ = "": Wend
    End If
    If (UCase$(a$) <> "R") Then Level = Level + 1
    If (Level > NUMLEVELS) Then GoTo FinishedGame
    GoSub LoadLevel
    GoSub Drawlevel
    GoTo MovePlayer
End If
 
' Player pressed nothing
If a$ = "" Then GoTo MainLoop

' Player pressed escape
If a$ = Chr$(27) Then GoTo EndGame
 
' Save game
If UCase$(a$) = "S" Then GoSub SaveGame

' Cheat to advance to next level
If a$ = "$" And CHEATSENABLED = 1 Then Won = 1: GoTo MainLoop

' Load game
If UCase$(a$) = "L" Then GoSub LoadGame

' About
If UCase$(a$) = "A" Then GoSub About

' Up, down, left and right respectively
If a$ = Chr$(0) + "H" Then xd = 0: yd = -1: GoTo MovePlayer
If a$ = Chr$(0) + "P" Then xd = 0: yd = 1: GoTo MovePlayer
If a$ = Chr$(0) + "K" Then xd = -1: yd = 0: GoTo MovePlayer
If a$ = Chr$(0) + "M" Then xd = 1: yd = 0: GoTo MovePlayer
GoTo MainLoop
'=============================================================[ END MAIN ]==

MovePlayer:
' read character directly in front of player
character$ = Mid$(Map$(y + yd), x + xd + 1, 1)
n = InStr(GameData$, character$)
 
' If it's a wall, then leave
graphicsOffset = 0
If n <= 16 Then graphicsOffset = -1: GoTo DrawHero

' If there is a crate in front of us, find the character two positions
' away in front of us
If ((character$ = CharCrate$) Or (character$ = CharCrateAtDest$)) Then
    character2$ = Mid$(Map$(y + yd + yd), x + xd + xd + 1, 1)
    n2 = InStr(GameData$, character2$)
    ' If the character 2 away from us is a wall or a crate, leave
    If n2 <= 16 Or character2$ = CharCrate$ Or character2$ = CharCrateAtDest$ Then GoTo MainLoop
   
    ' Else we can move the crate in front of us
    Locate y + yd + yd + 1, x + xd + xd + 1
    ' If we're moving a crate onto a destination-type block
    If (character2$ = CharDest$) Then
        Mid$(Map$(y + yd + yd), x + xd + xd + 1, 1) = CharCrateAtDest$
        Put ((x + xd + xd - 1) * 11 + OFSX, (y + yd + yd - 1) * 11 + OFSY), Graphics((POSCRATEATDEST - 1) * 80 + 1), PSet
        NumPushes = NumPushes + 1: GoSub ShowNumPushes
        ' If we're moving it from a destination-type block onto another dest-type
        If character$ = CharCrateAtDest$ Then
            Mid$(Map$(y + yd), x + xd + 1, 1) = CharDest$
        Else ' we're moving it onto a dest-type from a space
            Mid$(Map$(y + yd), x + xd + 1, 1) = " "
            NumPlaced = NumPlaced + 1
        End If
        If (NumPlaced = NumCrates) Then Won = 1
    Else ' We're moving the crate onto a blank space
        Mid$(Map$(y + yd + yd), x + xd + xd + 1, 1) = CharCrate$
        Put ((x + xd + xd - 1) * 11 + OFSX, (y + yd + yd - 1) * 11 + OFSY), Graphics((POSCRATE - 1) * 80 + 1), PSet
        NumPushes = NumPushes + 1: GoSub ShowNumPushes
        ' If we're moving a crate off of a destination block
        If character$ = CharCrateAtDest$ Then
            Mid$(Map$(y + yd), x + xd + 1, 1) = CharDest$
            NumPlaced = NumPlaced - 1
        Else ' we're moving a crate off of a space
            Mid$(Map$(y + yd), x + xd + 1, 1) = " "
        End If
    End If
End If

DrawHero:
' Erase our hero
Put ((x - 1) * 11 + OFSX, (y - 1) * 11 + OFSY), Graphics(((InStr(GameData$, Mid$(Map$(y), x + 1, 1))) - 1) * 80 + 1), PSet
' Update hero's location
If (graphicsOffset <> -1) Then
    x = x + xd
    y = y + yd
End If
' Update NumMoves counter
If Not (xd = 0 And yd = 0) Then NumMoves = NumMoves + 1: GoSub ShowNumMoves
' Re-draw our hero
graphicsOffset = 0
If (xd = 0 And yd = 1) Then graphicsOffset = 1
If (xd = -1 And yd = 0) Then graphicsOffset = 2
If (xd = 0 And yd = -1) Then graphicsOffset = 3
Put ((x - 1) * 11 + OFSX, (y - 1) * 11 + OFSY), Graphics((POSHERO + graphicsOffset - 1) * 80 + 1), PSet
GoTo MainLoop

SaveGame:
GoSub InputFileName
If filename$ <> "" Then
    filename$ = filename$ + ".sok"
    Open filename$ For Output As #1
    Print #1, Level
    Close
    Locate 19, 1: Print "File "; filename$; " saved ...";
    Sleep 1
    GoSub Drawlevel
End If
GoSub Drawlevel
Return

LoadGame:
GoSub InputFileName
If filename$ <> "" Then
    filename$ = filename$ + ".sok"
    Level = 0
    ' The following error handler is used to determine if a given file
    ' exists.
    On Error GoTo NoFile
    Open filename$ For Input As #1
    ' If file exists:
    If filename$ <> "" Then
        Input #1, Level
        Close
        GoSub LoadLevel
    End If
End If
' Disable the error handler
On Error GoTo 0
GoSub Drawlevel
Return

NoFile:
Locate 19, 1: Print "File not found! Press a key ...";
' Set filename$ to "" so that we know the file doesn't exist
filename$ = ""
' Clear keyboard buffer and wait for keypress
While InKey$ <> "": Wend
While InKey$ = "": Wend
' Go back to the line after the error occured
Resume Next

' Routine to allow user to enter a string of length at most 8 for
' getting filenames
InputFileName:
Color 15
xval = 17
filename$ = ""
Locate 19, 1: Print "Enter filename: _";
EnternameLoop:
s$ = InKey$
If s$ = "" Then GoTo EnternameLoop
' Escape
If s$ = Chr$(27) Then filename$ = "": GoTo sReturn
' Enter
If s$ = Chr$(13) Then GoTo sReturn
' Backspace
If filename$ <> "" And s$ = Chr$(8) Then
    filename$ = Left$(filename$, Len(filename$) - 1)
    Locate 19, xval: Print filename$ + "_ ";
End If
If s$ < "0" Then GoTo EnternameLoop
If s$ > "9" Then
    If s$ < "A" Then GoTo EnternameLoop
    If s$ > "Z" Then
        If s$ < "a" Or s$ > "z" Then GoTo EnternameLoop
    End If
End If
If Len(filename$) = 8 Then GoTo EnternameLoop
filename$ = filename$ + s$
Locate 19, xval: Print filename$ + "_ ";
GoTo EnternameLoop
sReturn:
Return

' Loads levels from the file as it needs them because all the levels
' in memory at once might place a bit of strain on QBasic :-)
LoadLevel:
x = 0
y = 0
xd = 0
yd = 0
NumCrates = 0
NumDestinations = 0
NumPlaced = 0
NumMoves = 0
NumPushes = 0
Won = 0

' Blank out the strings
For i = 0 To MAXY + 1
    TempMap$(i) = String$(MAXX + 2, " ")
    Map$(i) = String$(MAXX + 2, " ")
Next i

Open LEVELFILENAME For Input As #1
Line Input #1, f$
LevelString$ = RTrim$(LTrim$(Str$(Level)))
' Read until we find the string corresponding to the current Level number
While (f$ <> LevelString$) And Not EOF(1)
    Line Input #1, f$
Wend
' If we didn't find it, something went wrong
If f$ <> LevelString$ Then Close: GoTo lReturn

' Read in the level
Line Input #1, f$
count = 1
While f$ <> "~"
    TempMap$(count) = " " + f$
    Line Input #1, f$
    count = count + 1
Wend
Close

' Centre the level vertically
' Adding 0.5 and doing an integer divide effectively rounds upwards
extra = ((MAXY - count) + .5) \ 2
For i = count To 1 Step -1
    TempMap$(i + extra) = TempMap$(i)
Next i
For i = 1 To extra
    TempMap$(i) = String$(MAXX + 2, " ")
Next i
For i = count + extra To MAXY
    TempMap$(i) = String$(MAXX + 2, " ")
Next i
 
' Black out the area outside of the playing arena
For i = 1 To MAXX + 2
    c = 0
    ch$ = Mid$(TempMap$(c), i, 1)
    While ((ch$ = " ") Or (ch$ = "%")) And (c <= MAXY)
        Mid$(TempMap$(c), i, 1) = "%"
        c = c + 1
        ch$ = Mid$(TempMap$(c), i, 1)
    Wend
    c = MAXY + 1
    ch$ = Mid$(TempMap$(c), i, 1)
    While ((ch$ = " ") Or (ch$ = "%")) And (c >= 1)
        Mid$(TempMap$(c), i, 1) = "%"
        c = c - 1
        ch$ = Mid$(TempMap$(c), i, 1)
    Wend
Next i
For i = 0 To MAXY + 1
    c = 1
    ch$ = Mid$(TempMap$(i), c, 1)
    While ((ch$ = " ") Or (ch$ = "%")) And (c <= MAXX + 1)
        Mid$(TempMap$(i), c, 1) = "%"
        c = c + 1
        ch$ = Mid$(TempMap$(i), c, 1)
    Wend
    c = MAXX + 2
    ch$ = Mid$(TempMap$(i), c, 1)
    While ((ch$ = " ") Or (ch$ = "%")) And (c >= 2)
        Mid$(TempMap$(i), c, 1) = "%"
        c = c - 1
        ch$ = Mid$(TempMap$(i), c, 1)
    Wend
Next i

' Interpret the raw data and convert to our own format
For i = 1 To MAXY
    Map$(i) = TempMap$(i)
    For j = 2 To MAXX + 1
        If (Mid$(Map$(i), j, 1) = "@") Then
            Mid$(Map$(i), j, 1) = " "
            x = j - 1
            y = i
        End If
        If (Mid$(Map$(i), j, 1) = "$") Then
            Mid$(Map$(i), j, 1) = CharCrate$
            NumCrates = NumCrates + 1
        End If
        If (Mid$(Map$(i), j, 1) = "*") Then
            Mid$(Map$(i), j, 1) = CharCrateAtDest$
            NumCrates = NumCrates + 1
            NumDestinations = NumDestinations + 1
            NumPlaced = NumPlaced + 1
        End If
        If (Mid$(Map$(i), j, 1) = ".") Then
            Mid$(Map$(i), j, 1) = CharDest$
            NumDestinations = NumDestinations + 1
        End If
     
        ' This is used when the walls look different depending on what walls
        ' are adjacent to them, e.g. ≥,≈,ø, etc.
        ' A binary code is used XXXX where each of the four digits corresponds
        ' to above, right-of, below, and left-of. This will generate a number
        ' from 0 to 15 that is used as the offset into GameData$ to determine
        ' the character used.
        If (Mid$(Map$(i), j, 1) = "#") Then
            code = 0
            If (Mid$(TempMap$(i - 1), j, 1) = "#") Then code = code + 1
            If (Mid$(TempMap$(i), j + 1, 1) = "#") Then code = code + 2
            If (Mid$(TempMap$(i + 1), j, 1) = "#") Then code = code + 4
            If (Mid$(TempMap$(i), j - 1, 1) = "#") Then code = code + 8
            Mid$(Map$(i), j, 1) = Mid$(GameData$, code + 1, 1)
        End If
    Next j
Next i

' If the level is impossible, generate an error message.
If NumCrates < NumDestinations Then
    Screen 0: Width 80, 25
    Color 15, 0: Cls
    Print "Error: Level"; Level; "impossible!"
    Print "Did you fiddle with the level file?"
    Print "Is the level file there?"
    Print "If this wasn't your fault please contact me."
    Print
    GoTo ContactMessage
End If
lReturn:
Return

Drawlevel:
'COLOR 10, 0: CLS
Line (0, 0)-(319, 199), 7, BF

DrawBox 0, 0, 319, 199, 15, 8, -1 ' Entire screen
DrawBox 5, 5, 226, 193, 0, 15, 0 ' Game play arena
DrawBox 232, 5, 316, 193, 15, 8, -1 ' Info area
DrawBox 240, 13, 308, 26, 4, 12, 0 ' Title
DrawBox 234, 35, 314, 58, 8, 15, 0 ' Level number
DrawBox 234, 67, 314, 106, 8, 15, 0 ' Moves/pushes
DrawBox 234, 115, 314, 188, 8, 15, 0 ' Keys
Line (238, 164)-(310, 164), 13
 
Color 12
Locate 3, 32: Print "Sokoban";
 
Color 11
Locate 6, 32: Print "Level:";
Color 9
Locate 10, 32: Print "Moves:";
Color 10
Locate 12, 32: Print "Pushes:";
GoSub ShowNumMoves
GoSub ShowNumPushes
GoSub ShowLevel

Color 14
Locate 16, 31: Print "R  :Reset";
Locate 17, 31: Print "L  :Load";
Locate 18, 31: Print "S  :Save";
Locate 19, 31: Print "A  :About";
Locate 20, 31: Print "Esc:Quit";

Locate 22, 31
Color 12: Print "D";
Color 14: Print "J";
Locate 23, 31
Color 10: Print "S";
Color 11: Print "o";
Color 9: Print "f";
Color 13: Print "t";
Color 12: Print "w";
Color 14: Print "a";
Color 10: Print "r";
Color 11: Print "e";
Color 15
 
' Draw the playing arena
For i = 1 To MAXY
    For j = 2 To MAXX + 1
        ' Ignore "%" signs - they indicate pure black background
        If Mid$(Map$(i), j, 1) <> "%" Then
            Put ((j - 2) * 11 + OFSX, (i - 1) * 11 + OFSY), Graphics((InStr(GameData$, Mid$(Map$(i), j, 1)) - 1) * 80 + 1), PSet
        End If
    Next j
Next i
' Draw the hero, taking into account the direction he's facing
graphicsOffset = 0
If (xd = 0 And yd = 1) Then graphicsOffset = 1
If (xd = -1 And yd = 0) Then graphicsOffset = 2
If (xd = 0 And yd = -1) Then graphicsOffset = 3
Put ((x - 1) * 11 + OFSX, (y - 1) * 11 + OFSY), Graphics((POSHERO + graphicsOffset - 1) * 80 + 1), PSet
Return

ShowLevel:
Color 11
Locate 7, 32: Print Level;
Return

ShowNumMoves:
Color 9
Locate 11, 32: Print NumMoves;
Return

ShowNumPushes:
Color 10
Locate 13, 32: Print NumPushes;
Return

About:
Color 15
Locate 1, 1
Locate 5, 3: Print "€ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ€"
Locate , 3: Print "›                                  ﬁ";: Color 8: Print "€": Color 15
Locate , 3: Print "›       ˛ VGA Sokoban v1.0 ˛       ﬁ";: Color 8: Print "€": Color 15
Locate , 3: Print "›                                  ﬁ";: Color 8: Print "€": Color 15
Locate , 3: Print "›         DJ Software 1997         ﬁ";: Color 8: Print "€": Color 15
Locate , 3: Print "›         (C) David Joffe          ﬁ";: Color 8: Print "€": Color 15
Locate , 3: Print "›                                  ﬁ";: Color 8: Print "€": Color 15
Locate , 3: Print "›     Whipped up in a few hours    ﬁ";: Color 8: Print "€": Color 15
Locate , 3: Print "›            for the Net           ﬁ";: Color 8: Print "€": Color 15
Locate , 3: Print "›                                  ﬁ";: Color 8: Print "€": Color 15
Locate , 3: Print "›    http://www.scorpioncity.com/  ﬁ";: Color 8: Print "€": Color 15
Locate , 3: Print "›                                  ﬁ";: Color 8: Print "€": Color 15
Locate , 3: Print "›                                  ﬁ";: Color 8: Print "€": Color 15
Locate , 3: Print "€‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹€";: Color 8: Print "€": Color 15
Color 8
Locate , 4: Print "€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€";
While InKey$ = "": Wend

' Restore the contents of the screen
GoSub Drawlevel
Return

EndGame:
Screen 0: Width 80, 25
Color 15, 0: Cls
Print "*Sniff* .. I hate goodbyes .. *sob* ..."
Print
Print "Feedback (and bug reports :) welcome!"
Print
GoTo ContactMessage

FinishedGame:
Width 80, 25
Color 15, 0: Cls
Print "You finished the game. Yay!"
Print "I suppose you were expecting something more spectacular then? You must be"
Print "quite disappointed! :-)"
Print
Print "Actually, I would love to know if anyone actually *did* get this far (with-"
Print "out cheating, of course), so let me know!"
Print
GoTo ContactMessage

ContactMessage:
Print "Try e-mail me (David Joffe) at ";: Color 14: Print "djoffe@icon.co.za";: Color 15: Print "; if that's become out-"
Print "dated, have a look at:"
Color 14
Print "http://www.scorpioncity.com/"
Color 15
Print
Print "I have other stuff at the above URL, with source code etc, so check it out!"
Print
Print "Also, if you make any new levels, I'd love to see them! Maybe I'll add them"
Print "to the game for for a future re-release/re-write, in which case I'll give"
Print "you appropriate credit; I'll give each level a 'Creator' field."
Print
Print "The 90 default levels in this version I got from XSokoban, a version of"
Print "Sokoban for the X Window System."
Print
Print "Cheers from everyone here (just me :) at ";
Color 12: Print "-+ D";
Color 14: Print "J";
Print " ";
Color 10: Print "S";
Color 11: Print "o";
Color 9: Print "f";
Color 13: Print "t";
Color 12: Print "w";
Color 14: Print "a";
Color 10: Print "r";
Color 11: Print "e +-"
Color 15

Print
Print " - David Joffe"
End

GraphicsData:
'0
Data 15,15,15,15,15,15,15,15,15,15,15
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,00,00,00,00,00,00,00,00,00,00
'1
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,00,00,00,00,00,00,00,00,00,00
'2
Data 15,15,15,15,15,15,15,15,15,15,15
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,00,00,00,00,00,00,00,00,00,00
'3
Data 15,07,07,07,07,07,07,07,07,07,15
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,00,00,00,00,00,00,00,00,00,00
'4
Data 15,15,15,15,15,15,15,15,15,15,15
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
'5
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
'6
Data 15,15,15,15,15,15,15,15,15,15,15
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,00
'7
Data 15,07,07,07,07,07,07,07,07,07,15
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,00
'8
Data 15,15,15,15,15,15,15,15,15,15,15
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 00,00,00,00,00,00,00,00,00,00,00
'9
Data 15,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 00,00,00,00,00,00,00,00,00,00,00
'10
Data 15,15,15,15,15,15,15,15,15,15,15
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 00,00,00,00,00,00,00,00,00,00,00
'11
Data 15,07,07,07,07,07,07,07,07,07,15
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 00,00,00,00,00,00,00,00,00,00,00
'12
Data 15,15,15,15,15,15,15,15,15,15,15
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
'13
Data 15,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 07,07,07,07,07,07,07,07,07,07,00
Data 15,07,07,07,07,07,07,07,07,07,00
'14
Data 15,15,15,15,15,15,15,15,15,15,15
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,00
'15
Data 15,07,07,07,07,07,07,07,07,07,15
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 07,07,07,07,07,07,07,07,07,07,07
Data 15,07,07,07,07,07,07,07,07,07,00
' Destination
Data 00,00,00,00,00,00,00,00,00,00,08
Data 00,08,08,08,08,08,08,08,08,08,07
Data 00,08,08,08,08,08,08,08,08,08,07
Data 00,08,08,00,08,08,08,00,08,08,07
Data 00,08,08,08,00,08,00,08,08,08,07
Data 00,08,08,08,08,00,08,08,08,08,07
Data 00,08,08,08,00,08,00,08,08,08,07
Data 00,08,08,00,08,08,08,00,08,08,07
Data 00,08,08,08,08,08,08,08,08,08,07
Data 00,08,08,08,08,08,08,08,08,08,07
Data 08,07,07,07,07,07,07,07,07,07,07
' Blank
Data 08,08,08,08,08,08,08,08,08,08,08
Data 08,08,08,08,08,08,08,08,08,08,08
Data 08,08,08,08,08,08,08,08,08,08,08
Data 08,08,08,08,08,08,08,08,08,08,08
Data 08,08,08,08,08,08,08,08,08,08,08
Data 08,08,08,08,08,08,08,08,08,08,08
Data 08,08,08,08,08,08,08,08,08,08,08
Data 08,08,08,08,08,08,08,08,08,08,08
Data 08,08,08,08,08,08,08,08,08,08,08
Data 08,08,08,08,08,08,08,08,08,08,08
Data 08,08,08,08,08,08,08,08,08,08,08
' Crate
Data 08,08,08,08,08,08,08,08,08,08,08
Data 08,15,15,15,15,15,15,15,15,15,08
Data 08,15,12,12,12,12,12,12,12,04,08
Data 08,15,12,12,12,12,12,12,12,04,08
Data 08,15,12,12,12,12,12,12,12,04,08
Data 08,15,12,12,12,12,12,12,12,04,08
Data 08,15,12,12,12,12,12,12,12,04,08
Data 08,15,12,12,12,12,12,12,12,04,08
Data 08,15,12,12,12,12,12,12,12,04,08
Data 08,15,04,04,04,04,04,04,04,04,08
Data 08,08,08,08,08,08,08,08,08,08,08
'Crate at destination
Data 0,0,0,0,0,0,0,0,0,0,0
Data 0,12,12,12,12,12,12,12,12,12,7
Data 0,12,4,4,4,4,4,4,4,0,7
Data 0,12,4,4,4,4,4,4,4,0,7
Data 0,12,4,4,4,4,4,4,4,0,7
Data 0,12,4,4,4,4,4,4,4,0,7
Data 0,12,4,4,4,4,4,4,4,0,7
Data 0,12,4,4,4,4,4,4,4,0,7
Data 0,12,4,4,4,4,4,4,4,0,7
Data 0,12,0,0,0,0,0,0,0,0,7
Data 7,7,7,7,7,7,7,7,7,7,7
'Hero
Data 08,08,08,14,14,14,14,14,08,08,08
Data 08,14,14,14,14,14,14,14,14,14,08
Data 08,14,14,14,14,14,00,00,14,14,08
Data 14,14,14,14,14,14,00,00,14,14,14
Data 14,14,14,14,14,14,14,14,14,14,14
Data 14,14,14,14,08,08,08,08,08,08,08
Data 14,14,14,14,14,14,08,08,08,08,08
Data 14,14,14,14,14,14,14,14,08,08,08
Data 08,14,14,14,14,14,14,14,14,14,08
Data 08,14,14,14,14,14,14,14,14,08,08
Data 08,08,08,14,14,14,14,14,08,08,08

Data 08,08,08,14,14,14,14,14,08,08,08
Data 08,14,14,14,14,14,14,14,14,14,08
Data 08,14,14,14,14,14,14,14,14,14,08
Data 14,14,14,14,14,14,14,14,14,14,14
Data 14,14,14,14,14,08,14,14,14,14,14
Data 14,14,14,14,14,08,14,14,14,14,14
Data 14,14,00,00,14,08,08,14,14,14,14
Data 14,14,00,00,14,08,08,14,14,14,14
Data 08,14,14,14,14,08,08,08,14,14,08
Data 08,14,14,14,14,08,08,08,14,08,08
Data 08,08,08,14,14,08,08,08,08,08,08

Data 08,08,08,14,14,14,14,14,08,08,08
Data 08,14,14,14,14,14,14,14,14,14,08
Data 08,14,14,00,00,14,14,14,14,14,08
Data 14,14,14,00,00,14,14,14,14,14,14
Data 14,14,14,14,14,14,14,14,14,14,14
Data 08,08,08,08,08,08,08,14,14,14,14
Data 08,08,08,08,08,14,14,14,14,14,14
Data 08,08,08,14,14,14,14,14,14,14,14
Data 08,14,14,14,14,14,14,14,14,14,08
Data 08,08,14,14,14,14,14,14,14,14,08
Data 08,08,08,14,14,14,14,14,08,08,08

Data 08,08,08,08,08,08,14,14,08,08,08
Data 08,08,14,08,08,08,14,14,14,14,08
Data 08,14,14,08,08,08,14,14,14,14,08
Data 14,14,14,14,08,08,14,00,00,14,14
Data 14,14,14,14,08,08,14,00,00,14,14
Data 14,14,14,14,14,08,14,14,14,14,14
Data 14,14,14,14,14,08,14,14,14,14,14
Data 14,14,14,14,14,14,14,14,14,14,14
Data 08,14,14,14,14,14,14,14,14,14,08
Data 08,14,14,14,14,14,14,14,14,14,08
Data 08,08,08,14,14,14,14,14,08,08,08

Sub DrawBox (x1, y1, x2, y2, col1, col2, bgfill)
    If (bgfill <> -1) Then
        Line (x1, y1)-(x2, y2), bgfill, BF
    End If
    Line (x1, y1)-(x2, y1), col1
    Line (x1, y1)-(x1, y2), col1
    Line (x2, y1)-(x2, y2), col2
    Line (x1, y2)-(x2, y2), col2
End Sub

