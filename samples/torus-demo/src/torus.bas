'-----------------------------------------------------------------------------------------------------
'                                TORUS
'   This program draws a Torus figure. The program accepts user input
'   to specify various TORUS parameters. It checks the current system
'   configuration and takes appropriate action to set the best possible
'   initial mode.
'-----------------------------------------------------------------------------------------------------

'-----------------------------------------------------------------------------------------------------
' These are some metacommands and compiler options for QB64 to write modern & type-strict code
'-----------------------------------------------------------------------------------------------------
' This will disable prefixing all modern QB64 calls using a underscore prefix.
$NoPrefix
' Whatever indentifiers are not defined, should default to signed longs (ex. constants and functions).
DefInt A-Z
' All variables must be defined.
Option Explicit
' All arrays must be defined.
Option ExplicitArray
' Array lower bounds should always start from 1 unless explicitly specified.
' This allows a(4) as integer to have 4 members with index 1-4.
Option Base 1
' All arrays should be static by default. Allocate dynamic array using ReDim
'$Static
' This allows the executable window & it's contents to be resized.
$Resize:Smooth
FullScreen SquarePixels , Smooth
Title "Torus"
'-----------------------------------------------------------------------------------------------------

' General purpose constants
Const FALSE = 0, TRUE = Not FALSE
Const BACK = 0
Const TROW = 24, TCOL = 60

' Rotation flags
Const C_RNDM = -1, C_START = 0, C_CONTINUE = 1

' Constants for best available screen mode
Const VGA = 12
Const MCGA = 13
Const EGA256 = 9
Const EGA64 = 8
Const MONO = 10
Const HERC = 3
Const CGA = 1

' User-defined type for tiles - an array of these make a torus
Type Tile
    x1 As Single
    x2 As Single
    x3 As Single
    x4 As Single
    y1 As Single
    y2 As Single
    y3 As Single
    y4 As Single
    z1 As Single
    xc As Single
    yc As Single
    TColor As Integer
End Type

' User-defined type to hold information about the mode
Type Config
    Scrn As Integer
    Colors As Integer
    Atribs As Integer
    XPix As Integer
    YPix As Integer
    TCOL As Integer
    TROW As Integer
End Type

Dim VC As Config

' User-defined type to hold information about current Torus
Type TORUS
    Panel As Integer
    Sect As Integer
    Thick As Single
    XDegree As Integer
    YDegree As Integer
    Bord As String * 3
    Delay As Single
End Type

Dim TOR As TORUS, Max As Integer

' A palette of colors to paint with
Dim Pal(0 To 300) As Long

' Error variables to check screen type
Dim InitRows As Integer, BestMode As Integer, Available As String

' The code of the module-level program begins here
Dim As Integer Tmp, Til
  
' Initialize defaults
TOR.Thick = 3: TOR.Bord = "YES"
TOR.Panel = 8: TOR.Sect = 14
TOR.XDegree = 60: TOR.YDegree = 165

' Get best configuration and set initial graphics mode to it
GetConfig
VC.Scrn = BestMode
             
Do While TRUE ' Loop forever (exit is from within a SUB)

    ' Get Torus definition from user
    TorusDefine

    ' Dynamically dimension arrays
    Do
        Tmp = TOR.Panel
        Max = TOR.Panel * TOR.Sect

        ' Array for indexes
        ReDim Index(0 To Max - 1) As Integer
        ' Turn on error trap for insufficient memory
        On Error GoTo MemErr
        ' Array for tiles
        ReDim T(0 To Max - 1) As Tile
        On Error GoTo 0
    Loop Until Tmp = TOR.Panel

    ' Initialize array of indexes
    For Til = 0 To Max - 1
        Index(Til) = Til
    Next

    ' Calculate the points of each tile on the torus
    Message "Calculating"
    TorusCalc T()

    ' Color each tile in the torus.
    TorusColor T()

    ' Sort the tiles by their "distance" from the screen
    Message "Sorting"
    TorusSort 0, Max - 1

    ' Set the screen mode
    Screen VC.Scrn

    ' Mix a palette of colors
    SetPalette

    ' Set logical window with variable thickness
    ' Center is 0, up and right are positive, down and left are negative
    Window (-(TOR.Thick + 1), -(TOR.Thick + 1))-(TOR.Thick + 1, TOR.Thick + 1)

    ' Draw and paint the tiles, the farthest first and nearest last
    TorusDraw T(), Index()

    ' Rotate the torus by rotating the color palette
    Do While InKey$ = ""
        Delay (TOR.Delay)
        TorusRotate C_CONTINUE
        Limit 30
    Loop
    Screen 0
    Width 80
Loop
  
' Restore original rows
Width 80, InitRows

System 0

' Error trap to make torus screen independent
VideoErr:
Select Case BestMode ' Fall through until something works
    Case VGA
        BestMode = MCGA
        Available = "12BD"
    Case MCGA
        BestMode = EGA256
        Available = "12789"
    Case EGA256
        BestMode = CGA
        Available = "12"
    Case CGA
        BestMode = MONO
        Available = "A"
    Case MONO
        BestMode = HERC
        Available = "3"
    Case Else
        Print "Sorry. Graphics not available. Can't run Torus."
        End
End Select
Resume

' Trap to detect 64K EGA
EGAErr:
BestMode = EGA64
Available = "12789"
Resume Next

' Trap to detect insufficient memory for large Torus
MemErr:
Locate 22, 1
Print "Out of memory"
Print "Reducing panels from"; TOR.Panel; "to"; TOR.Panel - 1
Print "Reducing sections from"; TOR.Sect; "to"; TOR.Sect - 1;
Do While InKey$ = "": Loop
TOR.Panel = TOR.Panel - 1
TOR.Sect = TOR.Sect - 1
Resume Next

' Trap to determine initial number of rows so they can be restored
RowErr:
If InitRows = 50 Then
    InitRows = 43
    Resume
Else
    InitRows = 25
    Resume Next
End If

' ============================ CountTiles ==============================
'   Displays number of the tiles currently being calculated or sorted.
' ======================================================================
'
Sub CountTiles (T1 As Integer, T2 As Integer) Static
    ' Erase previous
    Locate TROW - 1, TCOL: Print Space$(19);
    ' If positive, display - give negative values to erase
    If T1 > 0 And T2 > 0 Then
        Locate TROW - 1, TCOL
        Print "Tile ";
        Print Using " ###"; T1;
        Print Using " ###"; T2;
    End If
End Sub

' ============================ DegToRad ================================
'   Convert degrees to radians, since BASIC trigonometric functions
'   require radians.
' ======================================================================
'
Function DegToRad! (Degrees As Single) Static
    DegToRad! = (Degrees * 2 * Pi) / 360
End Function

' ============================ GetConfig ===============================
'   Get the starting number of lines and the video adapter.
' ======================================================================
'
Sub GetConfig Static
    Shared InitRows As Integer, BestMode As Integer, Available As String

    ' Assume 50 line display and fall through error
    ' until we get the actual number
    InitRows = 50
    On Error GoTo RowErr
    Locate InitRows, 1

    ' Assume best possible screen mode
    BestMode = VGA
    Available = "12789BCD"

    On Error GoTo VideoErr
    ' Fall through error trap until a mode works
    Screen BestMode
    ' If EGA, then check pages to see whether more than 64K
    On Error GoTo EGAErr
    If BestMode = EGA256 Then Screen 8, , 1

    On Error GoTo 0

    ' Reset text mode
    Screen 0, , 0
    Width 80, 25
End Sub

' ============================== Inside ================================
'   Finds a point, T.xc and T.yc, that is mathematically within a tile.
'   Then check to see if the point is actually inside. Because of the
'   jagged edges of tiles, the center point is often actually inside
'   very thin tiles. Such tiles will not be painted, This causes
'   imperfections that are often visible at the edge of the Torus.
'
'   Return FALSE if a center point is not found inside a tile.
' ======================================================================
'
Function Inside (T As Tile) Static
    Shared VC As Config
    Dim Highest As Single, Lowest As Single
    Dim As Integer Border, X, YU, YD, H, L, IsUp, IsDown

    Border = VC.Atribs - 1

    ' Find an inside point. Since some tiles are triangles, the
    ' diagonal center isn't good enough. Instead find the center
    ' by drawing a diagonal from the center of the outside to
    ' a bottom corner.
    T.xc = T.x2 + ((T.x3 + (T.x4 - T.x3) / 2 - T.x2) / 2)
    T.yc = T.y2 + ((T.y3 + (T.y4 - T.y3) / 2 - T.y2) / 2)

    ' If we're on a border, no need to fill
    If Point(T.xc, T.yc) = Border Then
        Inside = FALSE
        Exit Function
    End If

    ' Find highest and lowest Y on the tile
    Highest = T.y1
    Lowest = T.y1
    If T.y2 > Highest Then Highest = T.y2
    If T.y2 < Lowest Then Lowest = T.y2
    If T.y3 > Highest Then Highest = T.y3
    If T.y3 < Lowest Then Lowest = T.y3
    If T.y4 > Highest Then Highest = T.y4
    If T.y4 < Lowest Then Lowest = T.y4

    ' Convert coordinates to pixels
    X = PMap(T.xc, 0)
    YU = PMap(T.yc, 1)
    YD = YU
    H = PMap(Highest, 1)
    L = PMap(Lowest, 1)
 
    ' Search for top and bottom tile borders until we either find them
    ' both, or check beyond the highest and lowest points.
 
    IsUp = FALSE
    IsDown = FALSE

    Do
        YU = YU - 1
        YD = YD + 1

        ' Search up
        If Not IsUp Then
            If Point(T.xc, PMap(YU, 3)) = Border Then IsUp = TRUE
        End If

        ' Search down
        If Not IsDown Then
            If Point(T.xc, PMap(YD, 3)) = Border Then IsDown = TRUE
        End If

        ' If top and bottom are found, we're inside
        If IsUp And IsDown Then
            Inside = TRUE
            Exit Function
        End If

    Loop Until (YD > L) And (YU < H)
    Inside = FALSE
End Function

' ============================= Message ================================
'   Displays a status message followed by blinking dots.
' ======================================================================
'
Sub Message (Text As String) Static
    Shared VC As Config

    Locate TROW, TCOL: Print Space$(19);
    Locate TROW, TCOL
    Color 7 ' White
    Print Text;
    Color 23 ' Blink
    Print " . . .";
    Color 7 ' White
End Sub

' ============================ Rotated =================================
'   Returns the Current value adjusted by Inc and rotated if necessary
'   so that it falls within the range of Lower and Upper.
' ======================================================================
'
Function Rotated (Lower As Integer, Upper As Integer, Current As Integer, Inc As Integer)
    ' Calculate the next value
    Current = Current + Inc

    ' Handle special cases of rotating off top or bottom
    If Current > Upper Then Current = Lower
    If Current < Lower Then Current = Upper
    Rotated = Current
End Function

' ============================ SetConfig ===============================
'   Sets the correct values for each field of the VC variable. They
'   vary depending on Mode and on the current configuration.
' ======================================================================
'
Sub SetConfig (mode As Integer) Static
    Shared VC As Config, BestMode As Integer

    Select Case mode
        Case 1 ' Four-color graphics for CGA, EGA, VGA, and MCGA
            If BestMode = CGA Or BestMode = MCGA Then
                VC.Colors = 0
            Else
                VC.Colors = 16
            End If
            VC.Atribs = 4
            VC.XPix = 319
            VC.YPix = 199
            VC.TCOL = 40
            VC.TROW = 25
        Case 2 ' Two-color medium-res graphics for CGA, EGA, VGA, and MCGA
            If BestMode = CGA Or BestMode = MCGA Then
                VC.Colors = 0
            Else
                VC.Colors = 16
            End If
            VC.Atribs = 2
            VC.XPix = 639
            VC.YPix = 199
            VC.TCOL = 80
            VC.TROW = 25
        Case 3 ' Two-color high-res graphics for Hercules
            VC.Colors = 0
            VC.Atribs = 2
            VC.XPix = 720
            VC.YPix = 348
            VC.TCOL = 80
            VC.TROW = 25
        Case 7 ' 16-color medium-res graphics for EGA and VGA
            VC.Colors = 16
            VC.Atribs = 16
            VC.XPix = 319
            VC.YPix = 199
            VC.TCOL = 40
            VC.TROW = 25
        Case 8 ' 16-color high-res graphics for EGA and VGA
            VC.Colors = 16
            VC.Atribs = 16
            VC.XPix = 639
            VC.YPix = 199
            VC.TCOL = 80
            VC.TROW = 25
        Case 9 ' 16- or 4-color very high-res graphics for EGA and VGA
            VC.Colors = 64
            If BestMode = EGA64 Then VC.Atribs = 4 Else VC.Atribs = 16
            VC.XPix = 639
            VC.YPix = 349
            VC.TCOL = 80
            VC.TROW = 25
        Case 10 ' Two-color high-res graphics for EGA or VGA monochrome
            VC.Colors = 0
            VC.Atribs = 2
            VC.XPix = 319
            VC.YPix = 199
            VC.TCOL = 80
            VC.TROW = 25
        Case 11 ' Two-color very high-res graphics for VGA and MCGA
            ' Note that for VGA screens 11, 12, and 13, more colors are
            ' available, depending on how the colors are mixed.
            VC.Colors = 216
            VC.Atribs = 2
            VC.XPix = 639
            VC.YPix = 479
            VC.TCOL = 80
            VC.TROW = 30
        Case 12 ' 16-color very high-res graphics for VGA
            VC.Colors = 216
            VC.Atribs = 16
            VC.XPix = 639
            VC.YPix = 479
            VC.TCOL = 80
            VC.TROW = 30
        Case 13 ' 256-color medium-res graphics for VGA and MCGA
            VC.Colors = 216
            VC.Atribs = 256
            VC.XPix = 639
            VC.YPix = 479
            VC.TCOL = 40
            VC.TROW = 25
        Case Else
            VC.Colors = 16
            VC.Atribs = 16
            VC.XPix = 0
            VC.YPix = 0
            VC.TCOL = 80
            VC.TROW = 25
            VC.Scrn = 0
            Exit Sub
    End Select
    VC.Scrn = mode
End Sub

' ============================ SetPalette ==============================
'   Mixes palette colors in an array.
' ======================================================================
'
Sub SetPalette Static
    Shared VC As Config, Pal() As Long
    Dim As Integer Index, Bs, Gs, Rs, Hs, HRs, HGs, HBs

    ' Mix only if the adapter supports color attributes
    If VC.Colors Then
        Select Case VC.Scrn
            Case 1, 2, 7, 8
                ' Red, green, blue, and intense in four bits of a byte
                ' Bits: 0000irgb
                ' Change the order of FOR loops to change color mix
                Index = 0
                For Bs = 0 To 1
                    For Gs = 0 To 1
                        For Rs = 0 To 1
                            For Hs = 0 To 1
                                Pal(Index) = Hs * 8 + Rs * 4 + Gs * 2 + Bs
                                Index = Index + 1
                            Next
                        Next
                    Next
                Next
            Case 9
                ' EGA red, green, and blue colors in 6 bits of a byte
                ' Capital letters repesent intense, lowercase normal
                ' Bits:  00rgbRGB
                ' Change the order of FOR loops to change color mix
                Index = 0
                For Bs = 0 To 1
                    For Gs = 0 To 1
                        For Rs = 0 To 1
                            For HRs = 0 To 1
                                For HGs = 0 To 1
                                    For HBs = 0 To 1
                                        Pal(Index) = Rs * 32 + Gs * 16 + Bs * 8 + HRs * 4 + HGs * 2 + HBs
                                        Index = Index + 1
                                    Next
                                Next
                            Next
                        Next
                    Next
                Next
            Case 11, 12, 13
                ' VGA colors in 6 bits of 3 bytes of a long integer
                ' Bits:  000000000 00bbbbbb 00gggggg 00rrrrrr
                ' Change the order of FOR loops to change color mix
                ' Decrease the STEP and increase VC.Colors to get more colors
                Index = 0
                For Rs = 0 To 63 Step 11
                    For Bs = 0 To 63 Step 11
                        For Gs = 0 To 63 Step 11
                            Pal(Index) = (65536 * Bs) + (256 * Gs) + Rs
                            Index = Index + 1
                        Next
                    Next
                Next
            Case Else
        End Select
        ' Assign colors
        If VC.Atribs > 2 Then TorusRotate C_RNDM
    End If
End Sub

' ============================ TileDraw ================================
'   Draw and optionally paint a tile. Tiles are painted if there are
'   more than two atributes and if the inside of the tile can be found.
' ======================================================================
'
Sub TileDraw (T As Tile) Static
    Shared VC As Config, TOR As TORUS
    Dim As Integer Border

    'Set border
    Border = VC.Atribs - 1

    If VC.Atribs = 2 Then
        ' Draw and quit for two-color modes
        Line (T.x1, T.y1)-(T.x2, T.y2), T.TColor
        Line -(T.x3, T.y3), T.TColor
        Line -(T.x4, T.y4), T.TColor
        Line -(T.x1, T.y1), T.TColor
        Exit Sub
    Else
        ' For other modes, draw in the border color
        ' (which must be different than any tile color)
        Line (T.x1, T.y1)-(T.x2, T.y2), Border
        Line -(T.x3, T.y3), Border
        Line -(T.x4, T.y4), Border
        Line -(T.x1, T.y1), Border
    End If

    ' See if tile is large enough to be painted
    If Inside(T) Then
        'Black out the center to make sure it isn't paint color
        PReset (T.xc, T.yc)
        ' Paint tile black so colors of underlying tiles can't interfere
        Paint Step(0, 0), BACK, Border
        ' Fill with the final tile color.
        Paint Step(0, 0), T.TColor, Border
    End If
 
    ' A border drawn with the background color looks like a border.
    ' One drawn with the tile color doesn't look like a border.
    If TOR.Bord = "YES" Then
        Border = BACK
    Else
        Border = T.TColor
    End If

    ' Redraw with the final border
    Line (T.x1, T.y1)-(T.x2, T.y2), Border
    Line -(T.x3, T.y3), Border
    Line -(T.x4, T.y4), Border
    Line -(T.x1, T.y1), Border
End Sub

' =========================== TorusCalc ================================
'   Calculates the x and y coordinates for each tile.
' ======================================================================
'
Sub TorusCalc (T() As Tile) Static
    Shared TOR As TORUS, Max As Integer
    Dim XSect As Integer, YPanel As Integer
    Dim As Single XRot, YRot, CXRot, SXRot, CYRot, SYRot, XInc, YInc, FirstY
    Dim As Single sx, sy, sz, ssx, ty, tz

    ' Calculate sine and cosine of the angles of rotation
    XRot = DegToRad(TOR.XDegree)
    YRot = DegToRad(TOR.YDegree)
    CXRot = Cos(XRot)
    SXRot = Sin(XRot)
    CYRot = Cos(YRot)
    SYRot = Sin(YRot)

    ' Calculate the angle to increment between one tile and the next.
    XInc = 2 * Pi / TOR.Sect
    YInc = 2 * Pi / TOR.Panel

    ' First calculate the first point, which will be used as a reference
    ' for future points. This point must be calculated separately because
    ' it is both the beginning and the end of the center seam.
    FirstY = (TOR.Thick + 1) * CYRot

    ' Starting point is x1 of 0 section, 0 panel     last     0
    T(0).x1 = FirstY ' +------+------+
    ' Also x2 of tile on last section, 0 panel   ' |      |      | last
    T(TOR.Sect - 1).x2 = FirstY ' |    x3|x4    |
    ' Also x3 of last section, last panel        ' +------+------+
    T(Max - 1).x3 = FirstY ' |    x2|x1    |  0
    ' Also x4 of 0 section, last panel           ' |      |      |
    T(Max - TOR.Sect).x4 = FirstY ' +------+------+
    ' A similar pattern is used for assigning all points of Torus

    ' Starting Y point is 0 (center)
    T(0).y1 = 0
    T(TOR.Sect - 1).y2 = 0
    T(Max - 1).y3 = 0
    T(Max - TOR.Sect).y4 = 0

    ' Only one z coordinate is used in sort, so other three can be ignored
    T(0).z1 = -(TOR.Thick + 1) * SYRot

    ' Starting at first point, work around the center seam of the Torus.
    ' Assign points for each section. The seam must be calculated separately
    ' because it is both beginning and of each section.
    For XSect = 1 To TOR.Sect - 1

        ' X, Y, and Z elements of equation
        sx = (TOR.Thick + 1) * Cos(XSect * XInc)
        sy = (TOR.Thick + 1) * Sin(XSect * XInc) * CXRot
        sz = (TOR.Thick + 1) * Sin(XSect * XInc) * SXRot
        ssx = (sz * SYRot) + (sx * CYRot)

        T(XSect).x1 = ssx
        T(XSect - 1).x2 = ssx
        T(Max - TOR.Sect + XSect - 1).x3 = ssx
        T(Max - TOR.Sect + XSect).x4 = ssx
                                         
        T(XSect).y1 = sy
        T(XSect - 1).y2 = sy
        T(Max - TOR.Sect + XSect - 1).y3 = sy
        T(Max - TOR.Sect + XSect).y4 = sy
                                         
        T(XSect).z1 = (sz * CYRot) - (sx * SYRot)
    Next
  
    ' Now start at the first seam between panel and assign points for
    ' each section of each panel. The outer loop assigns the initial
    ' point for the panel. This point must be calculated separately
    ' since it is both the beginning and the end of the seam of panels.
    For YPanel = 1 To TOR.Panel - 1
        
        ' X, Y, and Z elements of equation
        sx = TOR.Thick + Cos(YPanel * YInc)
        sy = -Sin(YPanel * YInc) * SXRot
        sz = Sin(YPanel * YInc) * CXRot
        ssx = (sz * SYRot) + (sx * CYRot)
       
        ' Assign X points for each panel
        ' Current ring, current side
        T(TOR.Sect * YPanel).x1 = ssx
        ' Current ring minus 1, next side
        T(TOR.Sect * (YPanel + 1) - 1).x2 = ssx
        ' Current ring minus 1, previous side
        T(TOR.Sect * YPanel - 1).x3 = ssx
        ' Current ring, previous side
        T(TOR.Sect * (YPanel - 1)).x4 = ssx

        ' Assign Y points for each panel
        T(TOR.Sect * YPanel).y1 = sy
        T(TOR.Sect * (YPanel + 1) - 1).y2 = sy
        T(TOR.Sect * YPanel - 1).y3 = sy
        T(TOR.Sect * (YPanel - 1)).y4 = sy

        ' Z point for each panel
        T(TOR.Sect * YPanel).z1 = (sz * CYRot) - (sx * SYRot)

        ' The inner loop assigns points for each ring (except the first)
        ' on the current side.
        For XSect = 1 To TOR.Sect - 1

            ' Display section and panel
            CountTiles XSect, YPanel

            ty = (TOR.Thick + Cos(YPanel * YInc)) * Sin(XSect * XInc)
            tz = Sin(YPanel * YInc)
            sx = (TOR.Thick + Cos(YPanel * YInc)) * Cos(XSect * XInc)
            sy = ty * CXRot - tz * SXRot
            sz = ty * SXRot + tz * CXRot
            ssx = (sz * SYRot) + (sx * CYRot)

            T(TOR.Sect * YPanel + XSect).x1 = ssx
            T(TOR.Sect * YPanel + XSect - 1).x2 = ssx
            T(TOR.Sect * (YPanel - 1) + XSect - 1).x3 = ssx
            T(TOR.Sect * (YPanel - 1) + XSect).x4 = ssx

            T(TOR.Sect * YPanel + XSect).y1 = sy
            T(TOR.Sect * YPanel + XSect - 1).y2 = sy
            T(TOR.Sect * (YPanel - 1) + XSect - 1).y3 = sy
            T(TOR.Sect * (YPanel - 1) + XSect).y4 = sy

            T(TOR.Sect * YPanel + XSect).z1 = (sz * CYRot) - (sx * SYRot)
        Next
    Next
    ' Erase message
    CountTiles -1, -1
End Sub

' =========================== TorusColor ===============================
'   Assigns color atributes to each tile.
' ======================================================================
'
Sub TorusColor (T() As Tile) Static
    Shared VC As Config, Max As Integer
    Dim As Integer LastAtr, Atr, Til

    ' Skip first and last atributes
    LastAtr = VC.Atribs - 2
    Atr = 1

    ' Cycle through each attribute until all tiles are done
    For Til = 0 To Max - 1
        If (Atr >= LastAtr) Then
            Atr = 1
        Else
            Atr = Atr + 1
        End If
        T(Til).TColor = Atr
    Next
End Sub

' ============================ TorusDefine =============================
'   Define the attributes of a Torus based on information from the
'   user, the video configuration, and the current screen mode.
' ======================================================================
'
Sub TorusDefine Static
    Shared VC As Config, TOR As TORUS, Available As String
    Dim As Integer Fields, Fld, Ky, Inc, i
    Dim As String K

    ' Constants for key codes and column positions
    Const ENTER = 13, ESCAPE = 27
    Const DOWNARROW = 80, UPARROW = 72, LEFTARROW = 75, RIGHTARROW = 77
    Const COL1 = 20, COL2 = 50, ROW = 9

    ' Display key instructions
    Locate 1, COL1
    Print "UP .............. Move to next field"
    Locate 2, COL1
    Print "DOWN ........ Move to previous field"
    Locate 3, COL1
    Print "LEFT ......... Rotate field value up"
    Locate 4, COL1
    Print "RIGHT ...... Rotate field value down"
    Locate 5, COL1
    Print "ENTER .... Start with current values"
    Locate 6, COL1
    Print "ESCAPE .................. Quit Torus"

    ' Block cursor
    Locate ROW, COL1, 1, 1, 12
    ' Display fields
    Locate ROW, COL1: Print "Thickness";
    Locate ROW, COL2: Print Using "[ # ]"; TOR.Thick;
 
    Locate ROW + 2, COL1: Print "Panels per Section";
    Locate ROW + 2, COL2: Print Using "[ ## ]"; TOR.Panel;

    Locate ROW + 4, COL1: Print "Sections per Torus";
    Locate ROW + 4, COL2: Print Using "[ ## ]"; TOR.Sect;
 
    Locate ROW + 6, COL1: Print "Tilt around Horizontal Axis";
    Locate ROW + 6, COL2: Print Using "[ ### ]"; TOR.XDegree;

    Locate ROW + 8, COL1: Print "Tilt around Vertical Axis";
    Locate ROW + 8, COL2: Print Using "[ ### ]"; TOR.YDegree;

    Locate ROW + 10, COL1: Print "Tile Border";
    Locate ROW + 10, COL2: Print Using "[ & ] "; TOR.Bord;
 
    Locate ROW + 12, COL1: Print "Screen Mode";
    Locate ROW + 12, COL2: Print Using "[ ## ]"; VC.Scrn

    ' Skip field 10 if there's only one value
    If Len(Available$) = 1 Then Fields = 10 Else Fields = 12
 
    ' Update field values and position based on keystrokes
    Do
        ' Put cursor on field
        Locate ROW + Fld, COL2 + 2
        ' Get a key and strip null off if it's an extended code
        Do
            K$ = InKey$
        Loop While K$ = ""
        Ky = Asc(Right$(K$, 1))

        Select Case Ky
            Case ESCAPE
                ' End program
                Cls: System 0
            Case UPARROW, DOWNARROW
                ' Adjust field location
                If Ky = DOWNARROW Then Inc = 2 Else Inc = -2
                Fld = Rotated(0, Fields, Fld, Inc)
            Case RIGHTARROW, LEFTARROW
                ' Adjust field
                If Ky = RIGHTARROW Then Inc = 1 Else Inc = -1
                Select Case Fld
                    Case 0
                        ' Thickness
                        TOR.Thick = Rotated(1, 9, Int(TOR.Thick), Inc)
                        Print Using "#"; TOR.Thick
                    Case 2
                        ' Panels
                        TOR.Panel = Rotated(6, 20, TOR.Panel, Inc)
                        Print Using "##"; TOR.Panel
                    Case 4
                        ' Sections
                        TOR.Sect = Rotated(6, 20, TOR.Sect, Inc)
                        Print Using "##"; TOR.Sect
                    Case 6
                        ' Horizontal tilt
                        TOR.XDegree = Rotated(0, 345, TOR.XDegree, (15 * Inc))
                        Print Using "###"; TOR.XDegree
                    Case 8
                        ' Vertical tilt
                        TOR.YDegree = Rotated(0, 345, TOR.YDegree, (15 * Inc))
                        Print Using "###"; TOR.YDegree
                    Case 10
                        ' Border
                        If VC.Atribs > 2 Then
                            If TOR.Bord = "YES" Then
                                TOR.Bord = "NO"
                            Else
                                TOR.Bord = "YES"
                            End If
                        End If
                        Print TOR.Bord
                    Case 12
                        ' Available screen modes
                        i = InStr(Available$, Hex$(VC.Scrn))
                        i = Rotated(1, Len(Available$), i, Inc)
                        VC.Scrn = Val("&h" + Mid$(Available$, i, 1))
                        Print Using "##"; VC.Scrn
                    Case Else
                End Select
            Case Else
        End Select
        ' Set configuration data for graphics mode
        SetConfig VC.Scrn
        ' Draw Torus if ENTER
    Loop Until Ky = ENTER
 
    ' Remove cursor
    Locate 1, 1, 0
 
    ' Set different delays depending on mode
    Select Case VC.Scrn
        Case 1
            TOR.Delay = .3
        Case 2, 3, 10, 11, 13
            TOR.Delay = 0
        Case Else
            TOR.Delay = .05
    End Select
 
    ' Get new random seed for this torus
    Randomize Timer
End Sub

' =========================== TorusDraw ================================
'   Draws each tile of the torus starting with the farthest and working
'   to the closest. Thus nearer tiles overwrite farther tiles to give
'   a three-dimensional effect. Notice that the index of the tile being
'   drawn is actually the index of an array of indexes. This is because
'   the array of tiles is not sorted, but the parallel array of indexes
'   is. See TorusSort for an explanation of how indexes are sorted.
' ======================================================================
'
Sub TorusDraw (T() As Tile, Index() As Integer)
    Shared Max As Integer
    Dim Til As Integer

    For Til = 0 To Max - 1
        TileDraw T(Index(Til))
    Next
End Sub

' =========================== TorusRotate ==============================
'   Rotates the Torus. This can be done more successfully in some modes
'   than in others. There are three methods:
'
'     1. Rotate the palette colors assigned to each attribute
'     2. Draw, erase, and redraw the torus (two-color modes)
'     3. Rotate between two palettes (CGA and MCGA screen 1)
'
'   Note that for EGA and VGA screen 2, methods 1 and 2 are both used.
' ======================================================================
'
Sub TorusRotate (First As Integer) Static
    Shared VC As Config, TOR As TORUS, Pal() As Long, Max As Integer
    Shared T() As Tile, Index() As Integer, BestMode As Integer
    Dim As Integer FirstClr, LastClr, LastAtr, Work, Atr, i, Toggle

    ' For EGA and higher rotate colors through palette
    If VC.Colors Then

        ' Argument determines whether to start at next color, first color,
        ' or random color
        Select Case First
            Case C_RNDM
                FirstClr = Int(Rnd * VC.Colors)
            Case C_START
                FirstClr = 0
            Case Else
                FirstClr = FirstClr - 1
        End Select

        ' Set last color to smaller of last possible color or last tile
        If VC.Colors > Max - 1 Then
            LastClr = Max - 1
        Else
            LastClr = VC.Colors - 1
        End If

        ' If color is too low, rotate to end
        If FirstClr < 0 Or FirstClr >= LastClr Then FirstClr = LastClr

        ' Set last attribute
        If VC.Atribs = 2 Then
            ' Last for two-color modes
            LastAtr = VC.Atribs - 1
        Else
            ' Smaller of last color or next-to-last attribute
            If LastClr < VC.Atribs - 2 Then
                LastAtr = LastClr
            Else
                LastAtr = VC.Atribs - 2
            End If
        End If

        ' Cycle through attributes, assigning colors
        Work = FirstClr
        For Atr = LastAtr To 1 Step -1
            Palette Atr, Pal(Work)
            Work = Work - 1
            If Work < 0 Then Work = LastClr
        Next

    End If

    ' For two-color screens, the best we can do is erase and redraw the torus
    If VC.Atribs = 2 Then

        ' Set all tiles to color
        For i = 0 To Max - 1
            T(i).TColor = Toggle
        Next
        ' Draw Torus
        TorusDraw T(), Index()
        ' Toggle between color and background
        Toggle = (Toggle + 1) Mod 2

    End If

    ' For CGA or MCGA screen 1, toggle palettes using the COLOR statement
    ' (these modes do not allow the PALETTE statement)
    If VC.Scrn = 1 And (BestMode = CGA Or BestMode = MCGA) Then
        Color , Toggle
        Toggle = (Toggle + 1) Mod 2
        Exit Sub
    End If
End Sub

' ============================ TorusSort ===============================
'   Sorts the tiles of the Torus according to their Z axis (distance
'   from the "front" of the screen). When the tiles are drawn, the
'   farthest will be drawn first, and nearer tiles will overwrite them
'   to give a three-dimensional effect.
'
'   To make sorting as fast as possible, the Quick Sort algorithm is
'   used. Also, the array of tiles is not actually sorted. Instead a
'   parallel array of tile indexes is sorted. This complicates things,
'   but makes the sort much faster, since two-byte integers are swapped
'   instead of 46-byte Tile variables.
' ======================================================================
'
Sub TorusSort (Low As Integer, High As Integer)
    Shared T() As Tile, Index() As Integer
    Dim Partition As Single
    Dim As Integer RandIndex, i, j

    If Low < High Then
        ' If only one, compare and swap if necessary
        ' The SUB procedure only stops recursing when it reaches this point
        If High - Low = 1 Then
            If T(Index(Low)).z1 > T(Index(High)).z1 Then
                CountTiles High, Low
                Swap Index(Low), Index(High)
            End If
        Else
            ' If more than one, separate into two random groups
            RandIndex = Int(Rnd * (High - Low + 1)) + Low
            CountTiles High, Low
            Swap Index(High), Index(RandIndex%)
            Partition = T(Index(High)).z1
            ' Sort one group
            Do
                i = Low: j = High
                ' Find the largest
                Do While (i < j) And (T(Index(i)).z1 <= Partition)
                    i = i + 1
                Loop
                ' Find the smallest
                Do While (j > i) And (T(Index(j)).z1 >= Partition)
                    j = j - 1
                Loop
                ' Swap them if necessary
                If i < j Then
                    CountTiles High, Low
                    Swap Index(i), Index(j)
                End If
            Loop While i < j

            ' Now get the other group and recursively sort it
            CountTiles High, Low
            Swap Index(i), Index(High)
            If (i - Low) < (High - i) Then
                TorusSort Low, i - 1
                TorusSort i + 1, High
            Else
                TorusSort i + 1, High
                TorusSort Low, i - 1
            End If
        End If
    End If
End Sub

