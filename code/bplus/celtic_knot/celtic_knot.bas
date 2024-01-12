
Option _Explicit ' b+ changing avatar challenge entry #3 2021-05-26
_Title "Celtic Space Ship Knot 2"
Const xmax = 720
Const ymax = 720
Const cx = 360
Const cy = 360
Dim As Long temp, CSK

Screen _NewImage(xmax, ymax, 32)
_Delay .25
_ScreenMove _Middle

Dim As _Unsigned Long sc1, sc2, sc3 ' ship colors
sc1 = _RGB32(255, 255, 0)
sc2 = _RGB32(200, 0, 0) ' horiontal
sc3 = _RGB32(0, 0, 160) ' vertical
Dim a, x, y, b, c, dc, db
dc = -2 / 45: db = 1 / 45
c = 240: b = 60
_MouseHide
Do
    Line (0, 0)-(xmax, ymax), &H09220044, BF
    a = a + _Pi(2 / 360): b = b + db: c = c + dc
    If b < 60 Then b = 60: db = -db
    If b > 120 Then b = 120: db = -db
    If c < 120 Then c = 120: dc = -dc
    If c > 240 Then c = 240: dc = -dc

    x = cx + 120 * Cos(a): y = cy + 120 * Sin(a)
    drawShip x, y, sc1
    x = cx + c * Cos(a + _Pi(2 / 3)): y = cy + b * Sin(a + _Pi(2 / 3))
    drawShip x, y, sc2
    x = cx + b * Cos(a + _Pi(4 / 3)): y = cy + c * Sin(a + _Pi(4 / 3))
    drawShip x, y, sc3
    _Display
    _Limit 60
Loop Until _KeyDown(27)

Sub drawShip (x, y, colr As _Unsigned Long) 'shipType     collisions same as circle x, y radius = 30
    Static ls
    Dim light As Long, r As Long, g As Long, b As Long
    r = _Red32(colr): g = _Green32(colr): b = _Blue32(colr)
    fellipse x, y, 6, 15, _RGB32(r, g - 120, b - 100)
    fellipse x, y, 18, 11, _RGB32(r, g - 60, b - 50)
    fellipse x, y, 30, 7, _RGB32(r, g, b)
    For light = 0 To 5
        fcirc x - 30 + 11 * light + ls, y, 1, _RGB32(ls * 50, ls * 50, ls * 50)
    Next
    ls = ls + 1
    If ls > 5 Then ls = 0
End Sub

' ======== helper subs for drawShip that you can use for other things specially fcirc = fill_circle  x, y, radius, color

Sub fellipse (CX As Long, CY As Long, xr As Long, yr As Long, C As _Unsigned Long)
    If xr = 0 Or yr = 0 Then Exit Sub
    Dim h2 As _Integer64, w2 As _Integer64, h2w2 As _Integer64
    Dim x As Long, y As Long
    w2 = xr * xr: h2 = yr * yr: h2w2 = h2 * w2
    Line (CX - xr, CY)-(CX + xr, CY), C, BF
    Do While y < yr
        y = y + 1
        x = Sqr((h2w2 - y * y * w2) \ h2)
        Line (CX - x, CY + y)-(CX + x, CY + y), C, BF
        Line (CX - x, CY - y)-(CX + x, CY - y), C, BF
    Loop
End Sub

Sub fcirc (x As Long, y As Long, R As Long, C As _Unsigned Long) 'vince version  fill circle x, y, radius, color
    Dim x0 As Long, y0 As Long, e As Long
    x0 = R: y0 = 0: e = 0
    Do While y0 < x0
        If e <= 0 Then
            y0 = y0 + 1
            Line (x - x0, y + y0)-(x + x0, y + y0), C, BF
            Line (x - x0, y - y0)-(x + x0, y - y0), C, BF
            e = e + 2 * y0
        Else
            Line (x - y0, y - x0)-(x + y0, y - x0), C, BF
            Line (x - y0, y + x0)-(x + y0, y + x0), C, BF
            x0 = x0 - 1: e = e - 2 * x0
        End If
    Loop
    Line (x - R, y)-(x + R, y), C, BF
End Sub

