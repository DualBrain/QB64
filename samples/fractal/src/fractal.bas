'+---------------+---------------------------------------------------+
'| ###### ###### |     .--. .         .-.                            |
'| ##  ## ##   # |     |   )|        (   ) o                         |
'| ##  ##  ##    |     |--' |--. .-.  `-.  .  .-...--.--. .-.        |
'| ######   ##   |     |  \ |  |(   )(   ) | (   ||  |  |(   )       |
'| ##      ##    |     '   `'  `-`-'  `-'-' `-`-`|'  '  `-`-'`-      |
'| ##     ##   # |                            ._.'                   |
'| ##     ###### |  Sources & Documents placed in the Public Domain. |
'+---------------+---------------------------------------------------+
'|                                                                   |
'| === Fractal.bas ===                                               |
'|                                                                   |
'| == Draws Mandelbrot fractals, displays each for 3 seconds.        |
'| == Be patient, some fractals may start with black areas before    |
'| == the good stuff shows up.                                       |
'| == Press "s" once during calculation to save the picture after    |
'| == calculation is completed.                                      |
'| == Press "i" once will also save the current fractal, but prints  |
'| == the x/y range info into it before doing so.                    |
'|                                                                   |
'+-------------------------------------------------------------------+
'| Done by RhoSigma, R.Heyder, provided AS IS, use at your own risk. |
'| Find me in the QB64 Forum or mail to support@rhosigma-cw.net for  |
'| any questions or suggestions. Thanx for your interest in my work. |
'+-------------------------------------------------------------------+

di& = _ScreenImage
scrX% = _Width(di&)
scrY% = _Height(di&)
_FreeImage di&
si& = _NewImage(scrX%, scrY%, 256)
Screen si&
_Delay 0.2: _ScreenMove _Middle
_Delay 0.2: _FullScreen

nc% = 128
Restore ColorTab
For k% = 0 To (nc% - 1)
    Read r%, g%, b%
    _PaletteColor k%, (r% * 65536) + (g% * 256) + b%
Next k%

Randomize Timer
Dim StdFrac%(scrX% - 1, scrY% - 1)
sd% = 0
pn% = 0
sp% = 0

_MouseHide
Do
    Cls

    If sd% = 0 Then
        x1# = -2.1
        x2# = 0.7
        y1# = -1.18
        y2# = 1.18
    Else
        x% = RangeRand%(0, scrX% - 1)
        y% = RangeRand%(0, scrY% - 1)
        lc% = RangeRand%(32, 48)
        While StdFrac%(x%, y%) < lc%
            x% = RangeRand%(0, scrX% - 1)
            y% = RangeRand%(0, scrY% - 1)
        Wend
        fd% = RangeRand%(1, 10)
        x1# = (2.8 / scrX% * (x% - fd%)) + (-2.1)
        x2# = (2.8 / scrX% * (x% + fd%)) + (-2.1)
        y1# = (2.36 / scrY% * (y% - fd%)) + (-1.18)
        y2# = (2.36 / scrY% * (y% + fd%)) + (-1.18)
    End If

    dx# = (x2# - x1#)
    dy# = (y2# - y1#)

    For y% = 0 To (scrY% - 1)
        b# = y1# + (dy# * (y% / scrY%))
        For x% = 0 To (scrX% - 1)
            a# = x1# + (dx# * (x% / scrX%))
            v# = 0
            c1# = 0.001 'play with it 0.1...0.001
            c2# = 0.005 'play with it 0.5...0.005
            f% = 1
            k% = 0
            While v# < nc% And f% = 1
                tc1# = c1#
                tc2# = c2#
                c1# = (tc1# * tc1#) - (tc2# * tc2#) + a#
                c2# = (2 * tc1# * tc2#) + b#
                v# = (c1# * c1#) + (c2# * c2#)
                k% = k% + 1
                If k% = nc% Then f% = 0
                i$ = InKey$
                Do While _MouseInput
                    mx% = mx% + _MouseMovementX
                    my% = my% + _MouseMovementY
                Loop
                If i$ <> "" Or mx% <> 0 Or my% <> 0 Then
                    If i$ = "s" Then
                        sp% = 1
                    ElseIf i$ = "i" Then
                        sp% = 2
                    Else
                        sp% = 0
                        GoTo exitProgram
                    End If
                End If
            Wend
            If k% = nc% Then
                PSet (x%, y%), 0
                If sd% = 0 Then StdFrac%(x%, y%) = 0
            Else
                PSet (x%, y%), k%
                If sd% = 0 Then StdFrac%(x%, y%) = k%
            End If
        Next x%
        If (y% Mod 10) = 0 Then _Display
    Next y%
    _Display
    If sp% > 0 Then
        If sp% > 1 Then
            Color 32
            Locate 3, 5
            Print Using "X1 = +#.##########"; x1#
            Locate 4, 5
            Print Using "X2 = +#.##########"; x2#
            Locate 5, 5
            Print Using "Y1 = +#.##########"; y1#
            Locate 6, 5
            Print Using "Y2 = +#.##########"; y2#
        End If
        SaveImage si&, "Fractal-" + Right$("0000" + LTrim$(Str$(pn%)), 4)
        pn% = pn% + 1
        sp% = 0
    End If

    sd% = 1
    _Delay 3
    exitProgram:
Loop While i$ = "" And mx% = 0 And my% = 0

_FullScreen _Off
_Delay 0.2: Screen 0
_Delay 0.2: _FreeImage si&
System

ColorTab:
Data &H00,&H00,&H00,&H08,&H00,&H10,&H10,&H00,&H20,&H18,&H00,&H30
Data &H20,&H00,&H40,&H28,&H00,&H50,&H30,&H00,&H60,&H38,&H00,&H70
Data &H40,&H00,&H80,&H48,&H00,&H90,&H50,&H00,&HA0,&H58,&H00,&HB0
Data &H60,&H00,&HC0,&H68,&H00,&HD0,&H70,&H00,&HE0,&H78,&H00,&HF0
Data &H80,&H00,&HFF,&H78,&H00,&HFF,&H70,&H00,&HFF,&H68,&H00,&HFF
Data &H60,&H00,&HFF,&H58,&H00,&HFF,&H50,&H00,&HFF,&H48,&H00,&HFF
Data &H40,&H00,&HFF,&H38,&H00,&HFF,&H30,&H00,&HFF,&H28,&H00,&HFF
Data &H20,&H00,&HFF,&H18,&H00,&HFF,&H10,&H00,&HFF,&H08,&H00,&HFF
Data &H00,&H00,&HFF,&H00,&H10,&HFF,&H00,&H20,&HFF,&H00,&H30,&HFF
Data &H00,&H40,&HFF,&H00,&H50,&HFF,&H00,&H60,&HFF,&H00,&H70,&HFF
Data &H00,&H80,&HFF,&H00,&H90,&HFF,&H00,&HA0,&HFF,&H00,&HB0,&HFF
Data &H00,&HC0,&HFF,&H00,&HD0,&HFF,&H00,&HE0,&HFF,&H00,&HF0,&HFF
Data &H00,&HFF,&HFF,&H00,&HFF,&HF0,&H00,&HFF,&HE0,&H00,&HFF,&HD0
Data &H00,&HFF,&HC0,&H00,&HFF,&HB0,&H00,&HFF,&HA0,&H00,&HFF,&H90
Data &H00,&HFF,&H80,&H00,&HFF,&H70,&H00,&HFF,&H60,&H00,&HFF,&H50
Data &H00,&HFF,&H40,&H00,&HFF,&H30,&H00,&HFF,&H20,&H00,&HFF,&H10
Data &H00,&HFF,&H00,&H10,&HFF,&H00,&H20,&HFF,&H00,&H30,&HFF,&H00
Data &H40,&HFF,&H00,&H50,&HFF,&H00,&H60,&HFF,&H00,&H70,&HFF,&H00
Data &H80,&HFF,&H00,&H90,&HFF,&H00,&HA0,&HFF,&H00,&HB0,&HFF,&H00
Data &HC0,&HFF,&H00,&HD0,&HFF,&H00,&HE0,&HFF,&H00,&HF0,&HFF,&H00
Data &HFF,&HFF,&H00,&HFF,&HF0,&H00,&HFF,&HE0,&H00,&HFF,&HD0,&H00
Data &HFF,&HC0,&H00,&HFF,&HB0,&H00,&HFF,&HA0,&H00,&HFF,&H90,&H00
Data &HFF,&H80,&H00,&HFF,&H70,&H00,&HFF,&H60,&H00,&HFF,&H50,&H00
Data &HFF,&H40,&H00,&HFF,&H30,&H00,&HFF,&H20,&H00,&HFF,&H10,&H00
Data &HFF,&H00,&H00,&HFF,&H00,&H08,&HFF,&H00,&H10,&HFF,&H00,&H18
Data &HFF,&H00,&H20,&HFF,&H00,&H28,&HFF,&H00,&H30,&HFF,&H00,&H38
Data &HFF,&H00,&H40,&HFF,&H00,&H48,&HFF,&H00,&H50,&HFF,&H00,&H58
Data &HFF,&H00,&H60,&HFF,&H00,&H68,&HFF,&H00,&H70,&HFF,&H00,&H78
Data &HFF,&H00,&H80,&HF0,&H00,&H78,&HE0,&H00,&H70,&HD0,&H00,&H68
Data &HC0,&H00,&H60,&HB0,&H00,&H58,&HA0,&H00,&H50,&H90,&H00,&H48
Data &H80,&H00,&H40,&H70,&H00,&H38,&H60,&H00,&H30,&H50,&H00,&H28
Data &H40,&H00,&H20,&H30,&H00,&H18,&H20,&H00,&H10,&H10,&H00,&H08

'======================================================================
Function RangeRand% (low%, high%)
    RangeRand% = Int(Rnd(1) * (high% - low% + 1)) + low%
End Function

'======================================================================
Sub SaveImage (image As Long, filename As String)
    bytesperpixel& = _PixelSize(image&)
    If bytesperpixel& = 0 Then Print "Text modes unsupported!": End
    If bytesperpixel& = 1 Then bpp& = 8 Else bpp& = 24
    x& = _Width(image&)
    y& = _Height(image&)
    b$ = "BM????QB64????" + MKL$(40) + MKL$(x&) + MKL$(y&) + MKI$(1) + MKI$(bpp&) + MKL$(0) + "????" + MKL$(0) + MKL$(0) + MKL$(0) + MKL$(0) 'partial BMP header info(???? to be filled later)
    If bytesperpixel& = 1 Then
        For c& = 0 To 255 ' read BGR color settings from JPG image + 1 byte spacer(CHR$(0))
            cv& = _PaletteColor(c&, image&) ' color attribute to read.
            b$ = b$ + Chr$(_Blue32(cv&)) + Chr$(_Green32(cv&)) + Chr$(_Red32(cv&)) + Chr$(0) 'spacer byte
        Next
    End If
    Mid$(b$, 11, 4) = MKL$(Len(b$)) ' image pixel data offset(BMP header)
    lastsource& = _Source
    _Source image&
    If ((x& * 3) Mod 4) Then padder$ = Space$(4 - ((x& * 3) Mod 4))
    For py& = y& - 1 To 0 Step -1 ' read JPG image pixel color data
        r$ = ""
        For px& = 0 To x& - 1
            c& = Point(px&, py&)
            If bytesperpixel& = 1 Then r$ = r$ + Chr$(c&) Else r$ = r$ + Left$(MKL$(c&), 3)
        Next px&
        d$ = d$ + r$ + padder$
    Next py&
    _Source lastsource&
    Mid$(b$, 35, 4) = MKL$(Len(d$)) ' image size(BMP header)
    b$ = b$ + d$ ' total file data bytes to create file
    Mid$(b$, 3, 4) = MKL$(Len(b$)) ' size of data file(BMP header)
    If LCase$(Right$(filename$, 4)) <> ".bmp" Then ext$ = ".bmp"
    f& = FreeFile
    Open filename$ + ext$ For Output As #f&: Close #f& ' erases an existing file
    Open filename$ + ext$ For Binary As #f&
    Put #f&, , b$
    Close #f&
End Sub

