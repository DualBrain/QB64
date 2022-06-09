$NoPrefix
DefLng A-Z
Option Explicit
Option ExplicitArray

$Resize:Smooth

Screen 12
FullScreen SquarePixels , Smooth

Dim As Single x, y

Window (-5, 0)-(5, 10)
Randomize Timer
Color 10
Do
    Select Case Rnd
        Case Is < .01
            x = 0
            y = .16 * y
        Case .01 TO .08
            x = .2 * x - .26 * y
            y = .23 * x + .22 * y + 1.6
        Case .08 TO .15
            x = -.15 * x + .28 * y
            y = .26 * x + .24 * y + .44
        Case Else
            x = .85 * x + .04 * y
            y = -.04 * x + .85 * y + 1.6
    End Select
    PSet (x, y)
Loop Until InKey$ = Chr$(27)

System 0
