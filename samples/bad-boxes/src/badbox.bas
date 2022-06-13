'**
'** Program Name: Bad Boxes
'** Version     : 1.0
'** Author      : Terry Ritchie
'** Date        : January 23rd, 2013
'** Description : Use your yellow box to capture the green (good) boxes for points while avoiding the red (bad) boxes.
'**
'** Controls    : Use the mouse to move the yellow box around the screen.
'**
'** Notes       : Good luck! The game gets progrssively harder.
'**

'************************************
'*                                  *
'*     INITIALIZATION SECTION       * *********************************************************************************
'*                                  *
'************************************

Const FALSE = 0, TRUE = Not FALSE '   booleans used to test/set for truth
Const SWIDTH = 1280 '                 width of screen
Const SHEIGHT = 720 '                 height of screen
Const MINWIDTH = SWIDTH / 20 '        minimum width of a square box
Const MAXWIDTH = SWIDTH / 10 '        maximum width of a square box
Const MAXBOXES = 100 '                maximum number of boxes to ever appear on screen
Const HEADS = TRUE '                  used in coin toss function
Const TAILS = FALSE '                 used in coin toss function
Const DIFFICULTY = 1 '                difficulty level of game (1 - easy to 10 - HARD!)
Const TEXTWIDTH = SWIDTH / 8 '        the maximum text characters the given screen can have

Type BOX '                            box object (spreadsheet columns)
    Xpos As Single '                  X location of box on screen
    Ypos As Single '                  Y location of box on screen
    Xvel As Single '                  X (horizontal) velocity of box
    Yvel As Single '                  Y (vertical) velocity of box
    Size As Integer '                 length of each side of box
    Colour As _Unsigned Long '        color of box (green = good guy, red = bad guy)
End Type

Dim Box(MAXBOXES) As BOX '            create array (spreadsheet) to hold MAXBOXES rows of information
Dim Saying$(20) '                     sayings the game can display to you while playing
Dim Player As BOX '                   create player character
Dim BoxesOnScreen% '                  total number of boxes currently allowed on screen
Dim Box% '                            a generic counter
Dim maxspeed! '                       the current maximum speed boxes are allowed to obtain
Dim Frame% '                          keeps track of the number of frames that have elapsed
Dim Score% '                          the player's score
Dim GameOver% '                       will go TRUE when the game is over
Dim Boxbackground& '                  background music
Dim Boxgameover& '                    that's it man .. game over man, game over
Dim Boxgreen&(4) '                    green box hit sounds
Dim Boxlevelup& '                     level up sound
Dim Boxquit& '                        laughing demon sound
Dim Boxred& '                         red box hit sound

'************************************
'*                                  *
'*       MAIN CODE SECTION          * *********************************************************************************
'*                                  *
'************************************

Boxbackground& = _SndOpen("boxbackground.ogg", "VOL,SYNC,LEN") ' load the game sounds into memory
Boxgameover& = _SndOpen("boxgameover.ogg", "VOL,SYNC,LEN")
Boxgreen&(1) = _SndOpen("boxgreen1.ogg", "VOL,SYNC,LEN")
Boxgreen&(2) = _SndOpen("boxgreen2.ogg", "VOL,SYNC,LEN")
Boxgreen&(3) = _SndOpen("boxgreen3.ogg", "VOL,SYNC,LEN")
Boxgreen&(4) = _SndOpen("boxgreen4.ogg", "VOL,SYNC,LEN")
Boxlevelup& = _SndOpen("boxlevelup.ogg", "VOL,SYNC,LEN")
Boxquit& = _SndOpen("boxquit.ogg", "VOL,SYNC,LEN")
Boxred& = _SndOpen("boxred.ogg", "VOL,SYNC,LEN")

maxspeed! = 1 '                       start the game with a maximum box speed of 1
BoxesOnScreen% = 20 '                 start the game with 10 boxes on the screen
Level% = 1 '                          start the game at level 1

Player.Xpos = SWIDTH / 2 + 1 '        start player in the center X location of screen
Player.Ypos = SHEIGHT / 2 + 1 '       start player in the center Y location of screen
Player.Size = 10 '                    set player's size
Player.Colour = _RGB32(255, 255, 0) ' set player's color (yellow)

For Box% = 1 To BoxesOnScreen% '      cycle through the array of current boxes on screen
    RANDOMBOX Box% '                  assign random properties to each box
Next Box%

Saying$(1) = "Here we go!" '                                 the twenty taunts the computer can say
Saying$(2) = "Off to a good start!"
Saying$(3) = "Feeling boxed in yet?"
Saying$(4) = "Ok, you're better than average..."
Saying$(5) = "Here, have some more boxes!"
Saying$(6) = "Come on, die already!"
Saying$(7) = "Getting tired yet?"
Saying$(8) = "Your momma wears combat boots!"
Saying$(9) = "We're coming to get you Barbara..."
Saying$(10) = "WooHoo! Sideways baby!"
Saying$(11) = "Ok, you might be a little awesome."
Saying$(12) = "Are you a machine?"
Saying$(13) = "You have got to be cheating!"
Saying$(14) = "You are a box evading god!"
Saying$(15) = "How are you still alive??"
Saying$(16) = "You should take up boxing .. get it?"
Saying$(17) = "You have cat like reflexes!"
Saying$(18) = "This is simply incredible!"
Saying$(19) = "You must have robot in your family tree!"
Saying$(20) = "O . M . G . !!!"

Screen _NewImage(SWIDTH, SHEIGHT, 32) '                                   display a graphics screen
_ScreenMove _Middle '                                                     move the graphics screen to the middle of the desktop
_FullScreen '                                                             go to full screen mode
_MouseHide '                                                              hide the mouse pointer from the player
_MouseMove Player.Xpos - Player.Size / 2, Player.Ypos - Player.Size / 2 ' move the mouse pointer to the player's position

_SndLoop Boxbackground& '                                                 start the background music
_SndVol Boxbackground&, .25 '                                             turn the background music down to one quarter

Do '                                                                      ** START OF MAIN PROGRAM LOOP **
    _Limit 120 '                                                          limit the game to 120 frames per second
    Cls '                                                                 clear the screen
    Frame% = Frame% + 1 '                                                 increment the frame counter
    If Frame% = Int(1000 / DIFFICULTY) Then '                             has this difficulty number of frames passed?
        _SndPlayCopy Boxlevelup& '                                        play level up sound
        Frame% = 0 '                                                      yes, reset the frame counter
        Level% = Level% + 1 '                                             increment to the next game level
        maxspeed! = maxspeed! + .1 '                                      increase the speed the boxes are allowed to achieve
        Player.Size = Player.Size + 2 '                                   increase the size of the player's box
        If Player.Size > 30 Then Player.Size = 30 '                       but don't let the player get larger than 30 pixels
        BoxesOnScreen% = BoxesOnScreen% + 1 '                             add another box to the screen
        If BoxesOnScreen% > MAXBOXES Then '                               have we exceeded the maximum number of boxes allowed?
            BoxesOnScreen% = MAXBOXES '                                   yes, don't exceed the maximum number of boxes
        Else '                                                            no, we have not exceeded the maximum boxes allowed
            RANDOMBOX BoxesOnScreen% '                                    assign random properties to this new box
        End If
    End If
    UPDATEPLAYER '                                                        update the player's position on the screen
    For Box% = 1 To BoxesOnScreen% '                                      cycle through all the boxes currently on the screen
        MOVEBOX Box% '                                                    update this box's position on the screen
        CHECKFORCOLLISION Box% '                                          check for a collision between this box and the player
    Next Box%
    DISPLAYSCORE '                                                        update the score and other on screen information
    _Display '                                                            display all changes that have been made in this frame
Loop Until InKey$ = Chr$(27) Or GameOver% '                               end game when player hits red box or presses ESC key
'                                                                         ** END OF MAIN PROGRAM LOOP **
_SndStop Boxbackground& '                                                 stop the background music from playing
_SndPlayCopy Boxred& '                                                    make one last red box hit sound
_Delay 2 '                                                                wait two seconds for defeat to sink in :)
_SndPlay Boxgameover& '                                                   play the game over sound clip from aliens
Do: Loop Until Not _SndPlaying(Boxgameover&) '                            wait until the game over sound clip has finished
_SndPlay Boxquit& '                                                       let the little demon make his snarky laugh
_Delay 2 '                                                                wait another two seconds
End '                                                                     ** END OF PROGRAM **

'************************************
'*                                  *
'*  SUBROUTINE & FUNCTION SECTION   * *********************************************************************************
'*                                  *
'************************************

'------------------------------------------------------------------------------------------------------------

Sub DISPLAYSCORE ()

    '**
    '** Displays the score, level and computer sayings on the screen during game play
    '**

    Shared Score%
    Shared Level%
    Shared Saying$()

    Dim Lvl% ' will hold a copy of the value of Level%

    Locate 1, 2 '                                    place the cursor at row 1, column 2
    Print "SCORE:"; Score%; '                        print the score at this location
    Locate 1, TEXTWIDTH - 9 '                        place the cursor at row 1, 9 places from the right side of screen
    Print "LEVEL:"; Level%; '                        print the current level player is on
    Lvl% = Level% '                                  get a copy of the level number
    If Lvl% > 20 Then Lvl% = 20 '                    if the level is greater than 20 then keep the level at 20
    Locate 1, (TEXTWIDTH - Len(Saying$(Lvl%))) / 2 ' locate the cursor at row 1, centered in the row for current saying
    Print Saying$(Lvl%); '                           print the current computer saying

End Sub

'------------------------------------------------------------------------------------------------------------

Function BOXCOLLISION (Box1X!, Box1Y!, Box1Width!, Box1Height!, Box2X!, Box2Y!, Box2Width!, Box2Height!)

    '**
    '** Tests two rectangular areas for collision
    '**

    If Box1X! <= Box2X! + Box2Width! Then
        If Box1X! + Box1Width! >= Box2X! Then
            If Box1Y! <= Box2Y! + Box2Height! Then
                If Box1Y! + Box1Height! >= Box2Y! Then
                    BOXCOLLISION = TRUE
                End If
            End If
        End If
    End If

End Function

'------------------------------------------------------------------------------------------------------------

Sub CHECKFORCOLLISION (Box%)

    '**
    '** Checks for a collision between this box (Box%) and the player's box
    '**

    Shared Player As BOX
    Shared Box() As BOX
    Shared Boxgreen&()
    Shared Score%
    Shared GameOver%
    '
    '** Check for a box collision between this box and the player
    '
    If BOXCOLLISION(Player.Xpos - Player.Size / 2, Player.Ypos - Player.Size / 2, Player.Size, Player.Size, Box(Box%).Xpos, Box(Box%).Ypos, Box(Box%).Size, Box(Box%).Size) Then
        If Box(Box%).Colour = _RGB32(0, 255, 0) Then '    there was a collision, was it with a green box?
            _SndPlayCopy Boxgreen&(Int(Rnd(1) * 4) + 1) ' play one of four random green box hit sounds
            Score% = Score% + 1 '                         yes, add a point to the player's score
            RANDOMBOX Box% '                              have this box appear randomly some where else
        Else '                                            no, the player hit a red box!
            GameOver% = TRUE '                            the game is now over :(
        End If
    End If

End Sub

'------------------------------------------------------------------------------------------------------------

Sub UPDATEPLAYER ()

    '**
    '** Updates the player's location based on mouse location and draw's the player's box
    '**

    Shared Player As BOX

    While _MouseInput: Wend ' get the latest mouse location
    Player.Xpos = _MouseX '   set player X position to mouse X location
    Player.Ypos = _MouseY '   set player Y position to mouse Y location
    '
    '** Draw the player's box
    '
    Line (Player.Xpos - Player.Size / 2, Player.Ypos - Player.Size / 2)-(Player.Xpos + Player.Size / 2, Player.Ypos + Player.Size / 2), Player.Colour, BF

End Sub

'------------------------------------------------------------------------------------------------------------

Sub MOVEBOX (Box%)

    '**
    '** Moves the current box (Box%) to it's new location
    '**

    Shared Box() As BOX
    Shared Score%
    Shared Boxred&

    Box(Box%).Xpos = Box(Box%).Xpos + Box(Box%).Xvel ' update the X position of this box
    Box(Box%).Ypos = Box(Box%).Ypos + Box(Box%).Yvel ' update the Y position of this box
    '
    '** Check to see if the box has gone off screen
    '
    If (Box(Box%).Xpos < -Box(Box%).Size) Or Box(Box%).Xpos > SWIDTH Or Box(Box%).Ypos < -Box(Box%).Size Or Box(Box%).Ypos > SHEIGHT Then
        If Box(Box%).Colour = _RGB32(0, 255, 0) Then ' was this a green box that flew off the screen?
            'Score% = Score% - 1 '                     yes, subtract from player's score if green box missed
            _SndPlayCopy Boxred& '                     play a red box hit sound if a green box is missed
        End If
        RANDOMBOX Box% '                               have this box appear randomly some where else
    End If
    '
    '** Draw this box at it's new location
    '
    Line (Box(Box%).Xpos, Box(Box%).Ypos)-(Box(Box%).Xpos + Box(Box%).Size, Box(Box%).Ypos + Box(Box%).Size), Box(Box%).Colour, BF

End Sub

'------------------------------------------------------------------------------------------------------------

Sub RANDOMBOX (Box%)

    '**
    '** Sets a box's (Box%) attributes with random values
    '**

    Shared Box() As BOX
    Shared maxspeed!
    Shared Level%

    Box(Box%).Size = Int(Rnd(1) * (MAXWIDTH - MINWIDTH)) + MINWIDTH ' create random sized box between min and max
    If COINTOSS = HEADS Then '                                        let's create a horizontal moving box
        Box(Box%).Ypos = Int(Rnd(1) * (SHEIGHT - Box(Box%).Size)) '   find a random Y start position for this box
        Box(Box%).Xvel = Rnd(1) * maxspeed! '                         create a random X motion factor for this box
        If Level% < 10 Then '                                         if the player is below level 10
            Box(Box%).Yvel = 0 '                                      then there will be no Y motion for this box
        Else '                                                        otherwise
            Box(Box%).Yvel = Rnd(1) * maxspeed! '                     let's add some Y motion to the box
        End If
        If COINTOSS = HEADS Then '                                    this box will appear from the left side
            Box(Box%).Xpos = -Box(Box%).Size '                        position the box off the screen to the left
        Else '                                                        this box will appear from the right side
            Box(Box%).Xpos = SWIDTH '                                 position the box off the screen to the right
            Box(Box%).Xvel = -Box(Box%).Xvel '                        we need to reverse the X motion factor
        End If
    Else '                                                            let's create a vertical moving box
        Box(Box%).Xpos = Int(Rnd(1) * (SWIDTH - Box(Box%).Size)) '    find a random X start position for this box
        Box(Box%).Yvel = Rnd(1) * maxspeed! '                         create a random Y motion factor for this box
        If Level% < 10 Then '                                         if the player is below level 10
            Box(Box%).Xvel = 0 '                                      then there will be no X motion for this box
        Else '                                                        otherwise
            Box(Box%).Xvel = Rnd(1) * maxspeed! '                     let's add some X motion to the box
        End If
        If COINTOSS = HEADS Then '                                    this box will appear from the top of the screen
            Box(Box%).Ypos = -Box(Box%).Size '                        position the box off the screen at the top
        Else '                                                        this box will appear from the bottom of the screen
            Box(Box%).Ypos = SHEIGHT '                                position the box off the screen at the bottom
            Box(Box%).Yvel = -Box(Box%).Yvel '                        we need to reverse the Y motion factor
        End If
    End If
    If COINTOSS = HEADS Then '                                        let's determine the color of the box randomly
        Box(Box%).Colour = _RGB32(255, 0, 0) '                        set it to red
    Else
        Box(Box%).Colour = _RGB32(0, 255, 0) '                        set it to green
    End If

End Sub

'------------------------------------------------------------------------------------------------------------

Function COINTOSS ()

    '**
    '** Simulates a coin toss with a 50/50 outcome. HEADS = TRUE, TAILS = FALSE
    '**

    Randomize Timer '                 seed the random number generator

    If Int(Rnd(1) * 2) + 1 = 1 Then ' if we get a random number of 1
        COINTOSS = HEADS '            return COINTOSS as HEADS (or TRUE)
    Else '                            the random number must have been 2
        COINTOSS = TAILS '            return COINTOSS as TAILS (or FALSE)
    End If

End Function

'------------------------------------------------------------------------------------------------------------

