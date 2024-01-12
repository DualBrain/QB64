_Title "Different Rotozooms test with grid" 'b+ 2023-01-18

' with original tests of Rotozoom2 with independent scales for x and y axis

Const xmax = 800
Const ymax = 600
Dim Shared pi As _Float
pi = _Pi

Screen _NewImage(xmax, ymax, 32)
_ScreenMove 360, 60

Dim As Long imgD, imgR
imgD = _NewImage(801, 801, 32)
_Dest imgD
Color &HFF0000FF
drawGrid 0, 0, 20, 40, 40
imgR = _NewImage(801, 801, 32)
_Dest imgR
Color &HFFFF0000
drawGrid 0, 0, 20, 40, 40

_Dest 0
Dim r As _Float
Do
    Cls
    Color &HFF0000FF: Print d
    Color &HFFFF0000: Print Int(_R2D(r))
    'Color &HFFFFFFFF
    RotoZoom23 400, 300, imgD, .5, 1, d
    RotoZoom2 400, 300, imgR, .5, 1, d
    'RotoZoom3 400, 300, imgR, .5, 1, r
    d = d + 1
    r = _D2R(d)
    _Display
    _Limit 5
Loop Until _KeyDown(27)

' ==================== Test Code when orininally tested scaling Rotozooms =================================

' Rotozoom23 works fine here too!

backImage& = _LoadImage("Stars.png")
myImage& = _LoadImage("Starship.png")
xscale = .2: yscale = 1.4

''test shrink x expand x
For lc = 1 To 800 Step 5
    _PutImage , backImage&
    RotoZoom23 xmax / 2, ymax / 2, myImage&, (200 - lc) / 200 + .5, 1, 0
    _Display
    _Limit 20
Next
''test shrink and expand y
For lc = 1 To 800 Step 5
    _PutImage , backImage&
    RotoZoom23 xmax / 2, ymax / 2, myImage&, 1, (200 - lc) / 200 + .5, 0
    _Display
    _Limit 20
Next
''test rotation
For a = 0 To 360
    _PutImage , backImage&
    RotoZoom23 xmax / 2, ymax / 2, myImage&, 1, 1, a
    _Display
    _Limit 20
Next
'test warp drive
_PutImage , backImage&
For x = 10 To xmax
    RotoZoom23 x, ymax / 2, myImage&, (1 + x / xmax) ^ 2, 1, 0
    _Display
    _Limit 2000
Next

Sub drawGrid (x, y, sq, xn, yn) ' top left x, y, x side, y side, number of x, nmber of y
    Dim As Long i, dx, dy
    dx = sq * xn: dy = sq * yn
    For i = 0 To xn
        Line (x + sq * i, y)-(x + sq * i, y + dy)
    Next
    For i = 0 To yn
        Line (x, y + sq * i)-(x + dx, y + sq * i)
    Next
End Sub

Sub RotoZoom2 (X As Long, Y As Long, Image As Long, xScale As Single, yScale, Rotation As Single)
    Dim px(3) As Single: Dim py(3) As Single
    W& = _Width(Image&): H& = _Height(Image&)
    px(0) = -W& / 2: py(0) = -H& / 2: px(1) = -W& / 2: py(1) = H& / 2
    px(2) = W& / 2: py(2) = H& / 2: px(3) = W& / 2: py(3) = -H& / 2
    sinr! = Sin(-Rotation / 57.2957795131): cosr! = Cos(-Rotation / 57.2957795131)
    For i& = 0 To 3
        x2& = (px(i&) * cosr! + sinr! * py(i&)) * xScale + X: y2& = (py(i&) * cosr! - px(i&) * sinr!) * yScale + Y
        px(i&) = x2&: py(i&) = y2&
    Next
    _MapTriangle (0, 0)-(0, H& - 1)-(W& - 1, H& - 1), Image& To(px(0), py(0))-(px(1), py(1))-(px(2), py(2))
    _MapTriangle (0, 0)-(W& - 1, 0)-(W& - 1, H& - 1), Image& To(px(0), py(0))-(px(3), py(3))-(px(2), py(2))
End Sub

Sub RotoZoom3 (X As Long, Y As Long, Image As Long, xScale As Single, yScale As Single, radianRotation As Single) ' 0 at end means no scaling of x or y
    Dim px(3) As Single: Dim py(3) As Single
    Dim W&, H&, sinr!, cosr!, i&, x2&, y2&
    W& = _Width(Image&): H& = _Height(Image&)
    px(0) = -W& / 2: py(0) = -H& / 2: px(1) = -W& / 2: py(1) = H& / 2
    px(2) = W& / 2: py(2) = H& / 2: px(3) = W& / 2: py(3) = -H& / 2
    sinr! = Sin(-radianRotation): cosr! = Cos(-radianRotation)
    For i& = 0 To 3
        x2& = xScale * (px(i&) * cosr! + sinr! * py(i&)) + X: y2& = yScale * (py(i&) * cosr! - px(i&) * sinr!) + Y
        px(i&) = x2&: py(i&) = y2&
    Next
    _MapTriangle _Seamless(0, 0)-(0, H& - 1)-(W& - 1, H& - 1), Image To(px(0), py(0))-(px(1), py(1))-(px(2), py(2))
    _MapTriangle _Seamless(0, 0)-(W& - 1, 0)-(W& - 1, H& - 1), Image To(px(0), py(0))-(px(3), py(3))-(px(2), py(2))
End Sub

Sub RotoZoom23 (centerX As Long, centerY As Long, Image As Long, xScale As Single, yScale As Single, Rotation As Single)
    Dim px(3) As Single: Dim py(3) As Single
    W& = _Width(Image&): H& = _Height(Image&)
    px(0) = -W& / 2 * xScale: py(0) = -H& / 2 * yScale: px(1) = -W& / 2 * xScale: py(1) = H& / 2 * yScale
    px(2) = W& / 2 * xScale: py(2) = H& / 2 * yScale: px(3) = W& / 2 * xScale: py(3) = -H& / 2 * yScale
    sinr! = Sin(-0.01745329 * Rotation): cosr! = Cos(-0.01745329 * Rotation)
    For i& = 0 To 3
        ' x2& = (px(i&) * cosr! + sinr! * py(i&)) * xScale + centerX: y2& = (py(i&) * cosr! - px(i&) * sinr!) * yScale + centerY
        x2& = (px(i&) * cosr! + sinr! * py(i&)) + centerX: y2& = (py(i&) * cosr! - px(i&) * sinr!) + centerY
        px(i&) = x2&: py(i&) = y2&
    Next
    _MapTriangle (0, 0)-(0, H& - 1)-(W& - 1, H& - 1), Image& To(px(0), py(0))-(px(1), py(1))-(px(2), py(2))
    _MapTriangle (0, 0)-(W& - 1, 0)-(W& - 1, H& - 1), Image& To(px(0), py(0))-(px(3), py(3))-(px(2), py(2))
End Sub
