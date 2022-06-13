DECLARE SUB TimeLoop (VideoX!, VideoY!, VideoAspect!)
DECLARE SUB DrawHands (NewTime$, VideoX!, VideoY!, VideoAspect!, DrawColor!)
DECLARE SUB DrawClockHands (VideoX!, VideoY!, VideoAspect!)
DECLARE SUB DrawBox (VideoWidth!, VideoHeight!, VideoAspect!)
DECLARE SUB SetVideoParameters (VideoType$, VideoWidth!, VideoHeight!, VideoAspect!)
DECLARE SUB SetVideoType (VideoType$)
COMMON SHARED Radian, DrawBright, DrawWhite, DrawBlack

' Analog Clock for QBasic
' by Alan Zeichick copyright (c) 1986, 1992
' Copyright (C) 1992 DOS Resource Guide
' Published in Issue #7, January 1993, page 47
'
' This program may be freely given away,
' but may not be sold without the author's
' express written permission.
 
' This program 1. Initializes some global variables.
'              2. Determines what video is installed.
'              3. Sets up video characteristics for this
'                 display type.
'              4. Calculates an analog clock's parameters.
'              5. Displays an analog clock until a key
'                 is pressed.
 
' First, let's initialize global variables which well use as constants.
' Radian is the conversion factor between degree and radian
' measurements. It will be used when calculating hand positions.
' DrawBlack, DrawWhite, and DrawBright are screen colors.
 
Radian = 3.1415926535# / 180
DrawBlack = 0
DrawWhite = 7
DrawBright = 15

' First, call the routine to tell what video's installed.
' This routine, which uses the VideoModeError error handler
' in the main program, returns the variable VideoType$.
' Possible values are "Text" "CGA" "EGA" and "VGA" which are
' passed to the next variable -- unless the result is "Text"
' in which case the program aborts, with the appropriate
' message.

CALL SetVideoType(VideoType$)

' Oh, yes, we could have handled the "Text" situation in the
' SetVideoParameters subroutine, but it's rude for a subroutine
' to end the main program, as well as hard to debug.

IF VideoType$ = "Text" THEN
   PRINT "Sorry - this program only works on CGA, EGA, and VGA systems."
   END ' Stop the program, and return to DOS.
END IF

' Next, let's call SetVideoParameters. This routine sets the
' proper SCREEN and WIDTH values, and returns three numbers:
'    VideoX (Integer) will be the number of horizontal dots
'    VideoY (Integer) will be the number of vertical dots.
'    VideoAspect (Real) will be the screen's aspect ratio.

CALL SetVideoParameters(VideoType$, VideoX, VideoY, VideoAspect)

' The next routine draws the box for the clock, and the hour tick marks.

CALL DrawBox(VideoX, VideoY, VideoAspect)

' The next routine keeps on drawing the clock's hands until a key is
' pressed, at which time it returns control to the main program.

CALL TimeLoop(VideoX, VideoY, VideoAspect)

END

' Error-handling routines have to be in the main program.
' This one is designed to complement the SetVideoType
' subroutine. If that routine tests a video display type
' that the machine is not equipped for, control branches
' to VideoBailout, which resets the VideoType$ variable to
' indicate that a suitable video mode has not been found.
' It then returns control to SetVideoType, which tests the
' next video setting.

' It would have been desireable to keep this error handler
' in the SetVideoType routine, but QBasic does not permit
' this.

VideoModeError:
   VideoType$ = "Text"
RESUME NEXT

SUB DrawBox (VideoX, VideoY, VideoAspect)

' Let's set up our local constants:
   CenterX = VideoX / 2 ' The horizontal screen center
   CenterY = VideoY / 2 ' The vertical screen center
   TickLength = CenterY * .96 ' Where the video ticks go

' We'll also be using a few local variables:
' TickX will be the horizontal coordinate of the hourly tick mark.
' TickY will be the vertical coordinate of the hourly tick mark.

' First, draw a square around the screen.

LINE (CenterX - CenterY * VideoAspect, 1)-(CenterX + CenterY * VideoAspect, VideoY - 1), DrawWhite, B

' Next, draw in the hour tick marks. Refer to the article for
' details of how the TickX and TickY values are calculated.

FOR HourCounter = 0 TO 11
    TickX = CenterX + TickLength * VideoAspect * SIN(HourCounter * 30 * Radian)
    TickY = CenterY - TickLength * COS(HourCounter * 30 * Radian)
    LINE (TickX - 1, TickY - 1)-(TickX + 1, TickY + 1), DrawWhite, B
    NEXT HourCounter

END SUB

SUB DrawHands (NewTime$, VideoX, VideoY, VideoAspect, DrawColor)

' This subroutine draws the clock hands, based on the time in NewTime$,
' centered in a screen box of size VideoX by VideoY, with an aspect
' ratio of VideoAspect. The clock is drawn in color DrawColor.
' Note how generic this is; that's a benefit of modular programming.

' The following are local constant, relative to the input values:
   CenterX = VideoX / 2 ' The horizontal screen center
   CenterY = VideoY / 2 ' The vertical screen center
   HourLength = CenterY * .6 ' The length of the hour hand
   MinuteLength = CenterY * .8 ' The length of the minute hand
   SecondLength = CenterY * .9 ' The position of the second circle

' The following are local variables:
' HourX = 0 is the horizontal coordinate of the hour hand's far end
' HourY = 0 is the vertical coordinate of the hour hand's far end
' MinuteX is the horizontal coordinate of the minute hand's far end
' MinuteY is the vertical coordinate of the minute hand's far end
' SecondX is the horizontal coordinate of the second circle's center
' SecondY is the vertical coordinate of the second circle's far end
' NewSecond is the numeric value of the seconds, from NewTime$
' NewMinute is the numeric value of the minutes plus NewSecond/60
' NewHour is the numeric value of the hour plus NewMinute/60

' Let's dismantle the time into component parts, and add in the
' fractional part of the hours and minutes.

NewSecond = VAL(MID$(NewTime$, 7, 2))
NewMinute = VAL(MID$(NewTime$, 4, 2)) + NewSecond / 60
NewHour = VAL(MID$(NewTime$, 1, 2)) + NewMinute / 60

' Calculate the new X and Y positions of the circle center.
' They are calculated just like the hourly tick marks in DrawBox.
' The constant '6' indicates that one second equals 6 degrees.
' Note that we're multiplying by a Radian conversion factor.
  
SecondX = CenterX + VideoAspect * SIN(NewSecond * 6 * Radian) * SecondLength
SecondY = CenterY - COS(NewSecond * 6 * Radian) * SecondLength
CIRCLE (SecondX, SecondY), 4, DrawColor

' Draw a line for the minute hand. We calculate the end point
' the same way we calculated the second hand's center, but this
' time we draw a line connecting it to the screen's center.
  
MinuteX = CenterX + VideoAspect * SIN(NewMinute * 6 * Radian) * MinuteLength
MinuteY = CenterY - COS(NewMinute * 6 * Radian) * MinuteLength
LINE (CenterX, CenterY)-(MinuteX, MinuteY), DrawColor
  
' Do the same thing for the hour hand.
' The constant this time is '30' since one hour equals 30 degrees.
 
HourX = CenterX + VideoAspect * SIN(NewHour * 30 * Radian) * HourLength
HourY = CenterY - COS(NewHour * 30 * Radian) * HourLength
LINE (CenterX, CenterY)-(HourX, HourY), DrawColor

END SUB

SUB SetVideoParameters (VideoType$, VideoX, VideoY, VideoAspect)

' This subroutine makes sure that the screen is set in the proper
' mode for the desired graphics capability (as discovered in
' SetVideoType). You can find out more details about the SCREEN
' command by checking in QBasic's online help under SCREEN, and then
' under SCREEN MODES.

' There are two local constants; you should substitute your own
' screen measurements for them.
ScreenX = 10 ' Your monitor's width, in inches or millimeters
ScreenY = 7 ' Your monitor's height, in the same units as ScreenX

' This case statement sets the screen area appropriately for the
' prediscovered resolution, and then sets the variables VideoX and
' VideoY to be the correct horizontal and vertical resolution,
' in pixels.

SELECT CASE VideoType$
   CASE "CGA"
      SCREEN 1
      VideoX = 320
      VideoY = 200
   CASE "EGA"
      SCREEN 9
      VideoX = 640
      VideoY = 350
   CASE "VGA"
      SCREEN 11
      VideoX = 640
      VideoY = 480
END SELECT

CLS

' This next statement calculates the proper screen aspect ratio,
' depending on your screen's pixel resolution (figured in the CASE
' statement above) and your screen's physical width and height
' (assigned to ScreenX and ScreenY above).

VideoAspect = (ScreenY / ScreenX) * (VideoX / VideoY)

END SUB

SUB SetVideoType (VideoType$)
'
' This subroutine tests the screen's graphics capability.
' It returns one of four values, Text, CGA, EGA, or VGA.
' It requires the labeled statements VideoModeError (in the main
' program) in order to test for SCREEN error conditions.
' I would be nice if VideoModeError could be inside the subroutine,
' but QBasic does not permit this.

' First, set up the error trap.

ON ERROR GOTO VideoModeError

' Make assumptions by assigning VideoType$ to the desired video
' type, and then test that assumption with the SCREEN statement.
' If the assumption is invalid, a program error will occur, and
' ON ERROR will execute the code at VideoModeError.

VideoType$ = "VGA"
SCREEN 11
IF VideoType$ = "Text" THEN
   VideoType$ = "EGA"
   SCREEN 9
   IF VideoType$ = "Text" THEN
      VideoType$ = "CGA"
      SCREEN 1
      END IF
   END IF

' Since we're done, let's turn off error trapping.

ON ERROR GOTO 0

END SUB

SUB TimeLoop (VideoX, VideoY, VideoAspect)

' This subroutine is the "tick-tock" part of the clock.
' It starts the loop by drawing the hands (calling DrawHands with
' the color DrawBright). Then, it waits for the time to change,
' calls DrawHands with the old time with DrawBlack to erase the hands.
' This loop continues until the user presses a key on the keyboard.

WHILE INKEY$ = ""

   ' Find out what time it is.

   NewTime$ = TIME$

   ' Draw in the hands, in color "DrawBright."

   CALL DrawHands(NewTime$, VideoX, VideoY, VideoAspect, DrawBright)
   
   ' Sit in an endless loop until the clock changes

   WHILE TIME$ = NewTime$: WEND
 
   ' Erase the hands by drawing them in color "DrawBlack."

   CALL DrawHands(NewTime$, VideoX, VideoY, VideoAspect, DrawBlack)
 
   ' Go back around the loop to draw the next minute.

   WEND

END SUB

