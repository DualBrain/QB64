$NoPrefix
DefInt A-Z
$Resize:Smooth

'declare types
Type bulletType
    row As Integer
    col As Integer
    direction As Integer
    bcolor As Integer
End Type

Type playerType
    row As Integer
    col As Integer
    direction As Integer
    score As Integer
    icon As String * 1
    iconColor As Integer
End Type

'declare constants
Const FALSE = 0, TRUE = Not FALSE

'declare global arrays
Dim Shared arena$(25) 'String representation of playing field.  Used to
'Make creating/drawing the field easier
Dim Shared map(25, 80) 'Represents the screen.  There is 1 array location
'for every screen char.  the value of a element of
'map(row,col) will be one of the following:
'   0 : Nothing there
'   1 : Wall
'   2 : Player
'   3 : bullet
'The use of map() speeds up the game
'considerably, since it has a quick way of
'knowing where things are.


Initialize
DoIntro
DrawScreen
Hunter

System 0

'Add bullet to bullet array
Sub AddBullet (bullet() As bulletType, numBullets, direction, player As playerType)
    If numBullets < 10 Then
        numBullets = numBullets + 1
        bullet(numBullets).row = player.row
        bullet(numBullets).col = player.col
        bullet(numBullets).direction = direction
        bullet(numBullets).bcolor = player.iconColor
        MoveBullet bullet(numBullets)
    End If
End Sub

' Center a text string at row ROW
Sub Center (row, text$)
    Locate row, 41 - Len(text$) / 2
    Print text$;
End Sub

'Goes through bullet array, and removes any bullet with direction of 0,
Sub DeleteBullets (bullet() As bulletType, numBullets)
    top = 0 'num bullets in the new array
    curr = 1 'current index into the array
    While curr <= numBullets
        If bullet(curr).direction = 0 Then
            HideBullet bullet(curr)
        Else
            top = top + 1
            bullet(top).row = bullet(curr).row
            bullet(top).col = bullet(curr).col
            bullet(top).direction = bullet(curr).direction
            bullet(top).bcolor = bullet(curr).bcolor
        End If
        curr = curr + 1
    Wend
    numBullets = top
End Sub

Sub DoIntro
    Width , 25
    View Print
    Locate , , 0

    Color 12, 1
    Cls
    Center 3, "Q u i c k B A S I C   M A Z E    H U N T E R"
    Color 14
    Center 5, "INSTRUCTIONS:  Maze Hunter is a two player game!  Your goal is to hunt down"
    Center 6, "and kill your enemy in the maze. "

    Color 15
    Center 8, "The following keys are used while playing this game"
    Center 10, "Left Player Move Up:    t      Right Player Move Up:    8"
    Center 11, "Left Player Move Left:  f      Right Player Move Left:  4"
    Center 12, "Left Player Move Down:  g      Right Player Move Down:  5"
    Center 13, "Left Player Move Right: h      Right Player Move Right: 6"

    Center 15, "Left Player Shoot Up:    w     Right Player Shoot Up:    p"
    Center 16, "Left Player Shoot Left:  a     Right Player Shoot Left:  l"
    Center 17, "Left Player Shoot Down:  s     Right Player Shoot Down:  ;"
    Center 18, "Left Player Shoot Right: d     Right Player Shoot Right: '"


    Center 22, "[-] Decrease Game Delay   [+] Increase Game Delay   [Esc] Stop play"


    Center 25, "Push Any Key To Continue"
    Color 11
    SparklePause
End Sub

Sub DrawScreen
    Color 14, 1
    Cls
    View Print
    For a = 1 To 25
        Locate a, 1
        Print arena$(a);
    Next a
End Sub

'Prints a space over the location of the bullet
Sub HideBullet (bullet As bulletType)
    Locate bullet.row, bullet.col
    Print " ";
    map(bullet.row, bullet.col) = 0
End Sub

'Draws a space over the player icon, thus hiding it
Sub HidePlayer (player As playerType)
    Locate player.row, player.col
    Print " ";
    map(player.row, player.col) = 0
End Sub

Sub Hunter
    'dimension bullet array and players
    Dim bullet(100) As bulletType
    Dim player1 As playerType
    Dim player2 As playerType

    'initialize players
    player1.icon = Chr$(1)
    player1.row = 12
    player1.col = 2
    player1.direction = 0
    player1.score = 0
    player1.iconColor = 12

    player2.icon = Chr$(2)
    player2.row = 12
    player2.col = 79
    player2.direction = 0
    player2.score = 0
    player2.iconColor = 11

    numBullets = 0

    ShowPlayer player1
    ShowPlayer player2

    finished = FALSE
    tickMax = 25 'delay factor

    Do
        Color 15
        Do 'Do until escape key hit
            Do 'Action Game loop
                tick = (tick + 2) Mod tickMax - 1
                If tick = 0 Then
                    Color 15, 1
                    Center 1, Str$(player2.score) + " > score <" + Str$(player1.score) + " "
                    MovePlayer player1
                    MovePlayer player2
                    MoveBullets bullet(), numBullets
                    DeleteBullets bullet(), numBullets
                Else
                    kbd$ = InKey$
                End If
            Loop While kbd$ = ""

            'handle keystrokes
            Select Case kbd$
                Case "-": GoSub HunterDecreaseGameDelay
                Case "+": GoSub HunterIncreaseGameDelay
                Case "w", "W": AddBullet bullet(), numBullets, 1, player1
                Case "a", "A": AddBullet bullet(), numBullets, 3, player1
                Case "s", "S": AddBullet bullet(), numBullets, 2, player1
                Case "d", "D": AddBullet bullet(), numBullets, 4, player1
                Case "t", "T": If player1.direction = 2 Then player1.direction = 0 Else player1.direction = 1
                Case "f", "F": If player1.direction = 4 Then player1.direction = 0 Else player1.direction = 3
                Case "g", "G": If player1.direction = 1 Then player1.direction = 0 Else player1.direction = 2
                Case "h", "H": If player1.direction = 3 Then player1.direction = 0 Else player1.direction = 4
                Case "p", "P": AddBullet bullet(), numBullets, 1, player2
                Case "l", "l": AddBullet bullet(), numBullets, 3, player2
                Case ";": AddBullet bullet(), numBullets, 2, player2
                Case "'": AddBullet bullet(), numBullets, 4, player2
                Case "8": If player2.direction = 2 Then player2.direction = 0 Else player2.direction = 1
                Case "5": If player2.direction = 1 Then player2.direction = 0 Else player2.direction = 2
                Case "2": If player2.direction = 1 Then player2.direction = 0 Else player2.direction = 2
                Case "4": If player2.direction = 4 Then player2.direction = 0 Else player2.direction = 3
                Case "6": If player2.direction = 3 Then player2.direction = 0 Else player2.direction = 4
                Case Chr$(27): finished = TRUE
                Case Else
            End Select
        Loop Until finished
    Loop Until score1 = 5 Or score2 = 5 Or finished
    Exit Sub

    HunterDecreaseGameDelay:
    If tickMax > 2 Then
        tickMax = tickMax - 1
    End If
    Color 15
    Locate 1, 60
    Print "  Delay ="; tickMax - 1; " "
    Return

    HunterIncreaseGameDelay:
    Color 15
    tickMax = tickMax + 1
    Locate 1, 60
    Print "  Delay ="; tickMax - 1; " "
    Return
End Sub

Sub Initialize
    'insure random maze
    Randomize Timer

    'setup boarder
    arena$(1) = "Ú" + String$(78, "Ä") + "¿"
    arena$(25) = "À" + String$(78, "Ä") + "Ù"
    For a = 2 To 24
        arena$(a) = "³" + Space$(78) + "³"
    Next a

    'draw maze elements
    For a = 1 To 15
        row = Rnd(1) * 20 + 3
        col = Rnd(1) * 70 + 5
        Mid$(arena$(row), col, 1) = Chr$(197)
        Mid$(arena$(row - 1), col, 1) = Chr$(179)
        Mid$(arena$(row + 1), col, 1) = Chr$(179)
        Mid$(arena$(row), col - 1, 1) = Chr$(196)
        Mid$(arena$(row), col - 2, 1) = Chr$(196)
        Mid$(arena$(row), col + 1, 1) = Chr$(196)
        Mid$(arena$(row), col + 2, 1) = Chr$(196)
    Next a

    'Scan through arena$() and where evere there is a wall, put a
    '1 in the map array to indicate it's location.  Put a 0 wherever there
    'is a blank space
    For row = 1 To 25
        For col = 1 To 80
            If Mid$(arena$(row), col, 1) = " " Then
                map(row, col) = 0
            Else
                map(row, col) = 1
            End If
        Next col
    Next row
End Sub

Sub MoveBullet (bullet As bulletType)
    'Move the bullet based on the direction.
    Select Case bullet.direction
        Case 0
        Case 1 'up
            Select Case map(bullet.row - 1, bullet.col)
                Case 0, 2, 3
                    HideBullet bullet
                    bullet.row = bullet.row - 1
                    ShowBullet bullet
                Case 1
                    bullet.direction = 0
            End Select
        Case 2 'down
            Select Case map(bullet.row + 1, bullet.col)
                Case 0, 2, 3
                    HideBullet bullet
                    bullet.row = bullet.row + 1
                    ShowBullet bullet
                Case 1
                    bullet.direction = 0
            End Select
        Case 3 'left
            Select Case map(bullet.row, bullet.col - 1)
                Case 0, 2, 3
                    HideBullet bullet
                    bullet.col = bullet.col - 1
                    ShowBullet bullet
                Case 1
                    bullet.direction = 0
            End Select
        Case 4 'right
            Select Case map(bullet.row, bullet.col + 1)
                Case 0, 2, 3
                    HideBullet bullet
                    bullet.col = bullet.col + 1
                    ShowBullet bullet
                Case 1
                    bullet.direction = 0
            End Select
    End Select
End Sub

'Move every bullet in the bullet array
Sub MoveBullets (bullet() As bulletType, numBullets)
    a = 1
    While a <= numBullets
        MoveBullet bullet(a)
        a = a + 1
    Wend
    Delay .03
End Sub

'based on the direction of the player, move the player
Sub MovePlayer (player As playerType)
    'if bullet hit the player, inc score
    If map(player.row, player.col) = 3 Then
        player.score = player.score + 1
        Beep
    End If

    Select Case player.direction
        Case 0 'no motion
            ShowPlayer player
        Case 1 'up
            Select Case map(player.row - 1, player.col)
                Case 0 'nothing
                    HidePlayer player
                    player.row = player.row - 1
                    ShowPlayer player
                Case 1, 2 'wall,enemy
                    player.direction = 0
                Case 3 'bullet
                    player.score = player.score + 1
                    Beep
            End Select
        Case 2 'down
            Select Case map(player.row + 1, player.col)
                Case 0 'nothing
                    HidePlayer player
                    player.row = player.row + 1
                    ShowPlayer player
                Case 1, 2 'wall,enemy
                    player.direction = 0
                Case 3 'bullet
                    player.score = player.score + 1
                    Beep
            End Select
        Case 3 'left
            Select Case map(player.row, player.col - 1)
                Case 0 'nothing
                    HidePlayer player
                    player.col = player.col - 1
                    ShowPlayer player
                Case 1, 2 'wall,enemy
                    player.direction = 0
                Case 3 'bullet
                    player.score = player.score + 1
                    Beep
            End Select
        Case 4 'right
            Select Case map(player.row, player.col + 1)
                Case 0 'nothing
                    HidePlayer player
                    player.col = player.col + 1
                    ShowPlayer player
                Case 1, 2 'wall,enemy
                    player.direction = 0
                Case 3 'bullet
                    player.score = player.score + 1
                    Beep
            End Select
    End Select

    Delay .003
End Sub

'print the bullet char at bullet location
Sub ShowBullet (bullet As bulletType)
    Color bullet.bcolor
    Locate bullet.row, bullet.col
    Print Chr$(4);
    map(bullet.row, bullet.col) = 3
End Sub

'show player icon in player color at player location
Sub ShowPlayer (player As playerType)
    Color player.iconColor
    Locate player.row, player.col
    Print player.icon;
    map(player.row, player.col) = 2
End Sub

Sub SparklePause
    a$ = "*    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    "

    While InKey$ = ""
        'print horizontal sparkles
        For a = 1 To 5
            Locate 1, 1
            Print Mid$(a$, a, 80);
            Locate 20, 1
            Print Mid$(a$, 6 - a, 80);

            'print vertical sparkles
            For b = 2 To 19
                c = (a + b) Mod 5
                If c = 1 Then
                    Locate b, 80
                    Print "*";
                    Locate 21 - b, 1
                    Print "*";
                Else
                    Locate b, 80
                    Print " ";
                    Locate 21 - b, 1
                    Print " ";
                End If
            Next b
            Delay .06
        Next a
    Wend
End Sub

