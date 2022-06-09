$NoPrefix
DefLng A-Z
Option Explicit
Option ExplicitArray

$Resize:Smooth

Const FALSE = 0, TRUE = Not FALSE ' Boolean constants

' Set maximum number of iterations per point:
Const MAXLOOP = 30, MAXSIZE = 1000000

Dim i As Long
Dim PaletteArray(15)
For i = 0 To 15: PaletteArray(i) = i: Next i

FullScreen SquarePixels , Smooth

Dim As Long WLeft, WRight, WTop, WBottom

' Call WindowVals to get coordinates of window corners:
WindowVals WLeft, WRight, WTop, WBottom

Dim As Long EgaMode, ColorRange, VLeft, VRight, VTop, VBottom
' Call ScreenTest to find out if this is an EGA machine
' and get coordinates of viewport corners:
ScreenTest EgaMode, ColorRange, VLeft, VRight, VTop, VBottom

' Define viewport and corresponding window:
View (VLeft, VTop)-(VRight, VBottom), 0, ColorRange
Window (WLeft, WTop)-(WRight, WBottom)

Locate 24, 10: Print "Press any key to quit.";

Dim As Long XLength, YLength, ColorWidth
XLength = VRight - VLeft
YLength = VBottom - VTop
ColorWidth = MAXLOOP \ ColorRange

Dim As Long Y, LogicY, OldColor, X, LogicX, MandelX, MandelY, RealNum, ImagNum, PColor

' Loop through each pixel in viewport and calculate
' whether or not it is in the Mandelbrot Set:
For Y = 0 To YLength ' Loop through every line
    ' in the viewport.
    LogicY = PMap(Y, 3) ' Get the pixel's view
    ' y-coordinate.
    PSet (WLeft, LogicY) ' Plot leftmost pixel in the line.
    OldColor = 0 ' Start with background color.

    For X = 0 To XLength ' Loop through every pixel
        ' in the line.
        LogicX = PMap(X, 2) ' Get the pixel's view
        ' x-coordinate.
        MandelX& = LogicX
        MandelY& = LogicY
        ' Do the calculations to see if this point
        ' is in the Mandelbrot Set:
        For i = 1 To MAXLOOP
            RealNum& = MandelX& * MandelX&
            ImagNum& = MandelY& * MandelY&
            If (RealNum& + ImagNum&) >= MAXSIZE Then Exit For
            MandelY& = (MandelX& * MandelY&) \ 250 + LogicY
            MandelX& = (RealNum& - ImagNum&) \ 500 + LogicX
        Next i

        ' Assign a color to the point:
        PColor = i \ ColorWidth

        ' If color has changed, draw a line from
        ' the last point referenced to the new point,
        ' using the old color:
        If PColor <> OldColor Then
            Line -(LogicX, LogicY), (ColorRange - OldColor)
            OldColor = PColor
        End If

        If InKey$ <> "" Then End
    Next X

    ' Draw the last line segment to the right edge
    ' of the viewport:
    Line -(LogicX, LogicY), (ColorRange - OldColor)

    ' If this is an EGA machine, shift the palette after
    ' drawing each line:
    If EgaMode Then ShiftPalette
Next Y

Do
    ' Continue shifting the palette
    ' until the user presses a key:
    If EgaMode Then ShiftPalette
    Limit 10
Loop While InKey$ = ""

Screen 0, 0 ' Restore the screen to text mode,
Width 80 ' 80 columns.
End

BadScreen: ' Error handler that is invoked if
EgaMode = FALSE ' there is no EGA graphics card
Resume Next

' ====================== ShiftPalette =====================
'    Rotates the palette by one each time it is called
' =========================================================
Sub ShiftPalette Static
    Shared PaletteArray(), ColorRange
    Dim i As Long

    For i = 1 To ColorRange
        PaletteArray(i) = (PaletteArray(i) Mod ColorRange) + 1
    Next i
    Palette Using PaletteArray(0)

End Sub

' ======================= ScreenTest ======================
'    Uses a SCREEN 8 statement as a test to see if user has
'    EGA hardware. If this causes an error, the EM flag is
'    set to FALSE, and the screen is set with SCREEN 1.
'    Also sets values for corners of viewport (VL = left,
'    VR = right, VT = top, VB = bottom), scaled with the
'    correct aspect ratio so viewport is a perfect square.
' =========================================================
Sub ScreenTest (EM, CR, VL, VR, VT, VB) Static
    EM = TRUE
    On Error GoTo BadScreen
    Screen 8, 1
    On Error GoTo 0

    If EM Then ' No error, SCREEN 8 is OK.
        VL = 110: VR = 529
        VT = 5: VB = 179
        CR = 15 ' 16 colors (0 - 15)

    Else ' Error, so use SCREEN 1.
        Screen 1, 1
        VL = 55: VR = 264
        VT = 5: VB = 179
        CR = 3 ' 4 colors (0 - 3)
    End If

End Sub

' ======================= WindowVals ======================
'     Gets window corners as input from the user, or sets
'     values for the corners if there is no input
' =========================================================
Sub WindowVals (WL, WR, WT, WB) Static
    Dim Resp As String

    Cls
    Print "This program prints the graphic representation of"
    Print "the complete Mandelbrot Set. The default window"
    Print "is from (-1000,625) to (250,-625). To zoom in on"
    Print "part of the figure, input coordinates inside"
    Print "this window."
    Print "Press <ENTER> to see the default window or"
    Print "any other key to input window coordinates: ";
    Locate , , 1
    Resp$ = Input$(1)

    ' User didn't press ENTER, so input window corners:
    If Resp$ <> Chr$(13) Then
        Print
        Input "x-coordinate of upper-left corner: ", WL
        Do
            Input "x-coordinate of lower-right corner: ", WR
            If WR <= WL Then
                Print "Right corner must be greater than left corner."
            End If
        Loop While WR <= WL
        Input "y-coordinate of upper-left corner: ", WT
        Do
            Input "y-coordinate of lower-right corner: ", WB
            If WB >= WT Then
                Print "Bottom corner must be less than top corner."
            End If
        Loop While WB >= WT

        ' User pressed ENTER, so set default values:
    Else
        WL = -1000
        WR = 250
        WT = 625
        WB = -625
    End If
End Sub

