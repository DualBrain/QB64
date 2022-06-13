'#lang "qb"

Screen 12
Randomize Timer

pi = 3.141592653589793#

'
' This program can simulate any signle lens, convex or concave or otherwise.
' Rays may enter the lens in any fashion.
' There are three separate sections where user may change parameters.
' There is also an adjustable target.
'

'************************************************************
'begin first user-controlled parameter section
drawscale = 2 'enter 1 for no change
indexxair = 1
indexxlens = 1.6
rad1 = -75 'change the sign on these radii to change concavity
rad2 = 120 'change the sign on these radii to change concavity
'end first user-controlled parameter section
'************************************************************

'Determine focus using Lensmaker's equation.
foc.temp.a = 1 / rad1
foc.temp.b = -1 / rad2
foc.temp.c = ((indexxlens - 1) * thickness) / (indexxlens * rad1 * rad2)
foc.temp = (indexxlens - 1) * (foc.temp.a + foc.temp.b + foc.temp.c)
If Sqr(foc.temp ^ 2) < .00001 Then foc.temp = .00001
focus = 1 / foc.temp
'Done finding focus.

'************************************************************
'begin second user-controlled parameter section
left.ext = -10 'prefers value to be always less than 0
right.ext = 6 'prefers value to be always greater than 0
objectx = -Sqr((focus * .75) ^ 2)
targetx = 130
yplacecnt = -20
yplacemax = 20
yinc = 10
angcnt = -85 * pi / 180
angmax = 85 * pi / 180
anginc = 5 * pi / 180
angcnt.min = angcnt
extras = .1 'display normal and tangent lines, etc (see subsequent code for exact use)
tolerance = 1 '10
speed = .005
'end second user-controlled parameter section
'************************************************************

thickness = right.ext - left.ext
left.edge = left.ext
right.edge = right.ext
yplacecnt = yplacecnt - yinc
angcnt = angcnt - anginc
left.ext = left.ext + rad1
right.ext = right.ext + rad2

Cls
GoSub DrawLens
Locate 2, 3: Print "PRESS ANY KEY"
Locate 3, 3: Print "  TO BEGIN.  "
Do: Loop Until InKey$ <> ""

Triggers = 0
NumRays = 0

mainloop:
Do
    'yplacecnt = yplacecnt + yinc
    Do
        NewRay:
        NumRays = NumRays + 1
        ni = indexxair
        lockleft = 0
        lockright = 0

        '************************************************************
        'begin third user-controlled parameter section

        'angcnt = angcnt + anginc
        angcnt = 9999

        'IF focus < 0 THEN x = focus ELSE x = -focus
        x = objectx
        'x = ((-1) ^ INT(RND * 2)) * RND * 100 - 200

        'y = yplacecnt
        'yplacecnt = 9999
        y = ((-1) ^ Int(Rnd * 2)) * Rnd * (50 / 2)
        'y = 0

        'ang = angcnt
        'ang = ((-1) ^ INT(RND * 2)) * RND * pi / 8
        't = 2 * RND - 1
        'ang = .25 * ATN(t / SQR(1 - t ^ 2))
        'ang = 0
        ang = -pi / 32

        'end third user-controlled parameter section
        '************************************************************

        x0 = x: y0 = y
        GoSub convert.x0y0
        xi = x0: yi = y0

        GoSub PrintData

        Do
            GoSub convert.xiyi
            PSet (xxi, yyi), 14
            xi = xi + speed * Cos(ang)
            yi = yi + speed * Sin(ang)
            'Look for detector.
            GoSub convert.xiyi
            If Point(xxi, yyi) = 12 Then: Triggers = Triggers + 1: Exit Do
            'Look for left lens interface.
            If (xi - (left.ext)) ^ 2 + (yi) ^ 2 > (rad1 ^ 2 - tolerance) And (xi - (left.ext)) ^ 2 + (yi) ^ 2 < (rad1 ^ 2 + tolerance) And lockleft = 0 Then
                lockleft = 1
                ni = indexxlens
                n.old = indexxair
                n.new = indexxlens
                'Determine the slope of the tangent line to the circle.
                If yi = 0 Then yi = .00001
                m = (-xi + left.ext) / yi
                mn = (-1 / m)
                rad.i = rad1
                GoSub lens.interface
            End If
            'Look for right lens interface.
            If (xi - (right.ext)) ^ 2 + (yi) ^ 2 > (rad2 ^ 2 - tolerance) And (xi - (right.ext)) ^ 2 + (yi) ^ 2 < (rad2 ^ 2 + tolerance) And lockright = 0 Then
                lockright = 1
                ni = indexxair
                n.old = indexxlens
                n.new = indexxair
                'Determine the slope of the tangent line to the circle.
                If yi = 0 Then yi = .00001
                m = (-xi + right.ext) / yi
                mn = (-1 / m)
                rad.i = rad2
                GoSub lens.interface
            End If
            key$ = InKey$
            Select Case key$
                Case " ": Exit Do
                Case Chr$(27): End
            End Select
            key$ = ""
            'LOOP UNTIL drawscale * xi > 1.1 * drawscale * targetx OR 2 * drawscale * xi > 320 OR drawscale * SQR(yi ^ 2) > 240
        Loop Until drawscale * xi > 320 Or drawscale * Sqr(yi ^ 2) > 240
        tir.bypass:
        'Redraw the focii.
        x = focus: y = 0: GoSub convert.xy: Circle (xx, yy), 3, 4
        x = -focus: y = 0: GoSub convert.xy: Circle (xx, yy), 3, 4
        'Draw 3mm detector.
        x = targetx - 1: y = 15: GoSub convert.xy
        x1 = xx: y1 = yy
        x = targetx + 1: y = -15: GoSub convert.xy
        x2 = xx: y2 = yy
        Line (x1, y1)-(x2, y2), 12, BF
    Loop Until angcnt >= angmax
    angcnt = angcnt.min - anginc
    'LOOP UNTIL yplacecnt >= yplacemax
Loop Until NumRays >= 500
GoSub PrintData
Sleep
End

lens.interface:
'Calculate the tangent line at intersection point.
x = xi - 5
y = m * (x - xi) + yi
GoSub convert.xy
x1 = xx: y1 = yy
x = xi + 5: y = m * (x - xi) + yi
GoSub convert.xy
x2 = xx: y2 = yy
If extras = 1 And indexxlens <> 1 Then Line (x1, y1)-(x2, y2), 11

'Calculate the normal line at intersection point.
x = xi - 10
y = mn * (x - xi) + yi
GoSub convert.xy
x1 = xx: y1 = yy
x = xi + 10: y = mn * (x - xi) + yi
GoSub convert.xy
x2 = xx: y2 = yy
If extras > .5 And indexxlens <> 1 Then Line (x1, y1)-(x2, y2), 4

'Indicate the intersection point with a circle.
If extras > 0 And indexxlens <> 1 Then x = xi: y = yi: GoSub convert.xy: Circle (xx, yy), 3, 3

normal.ang = -Atn(mn)
inc.ang = ang + normal.ang

'Recalculate velocity angle.
t = n.old * Sin(inc.ang) / n.new
If t ^ 2 < 1 Then
    ang = Atn(t / Sqr(1 - t ^ 2))
    ang = ang - normal.ang
Else
    'Total internal reflection.
    x = xi: y = yi: GoSub convert.xy: Circle (xx, yy), 3, 5
    Line (xx - 2, yy - 2)-(xx + 2, yy + 2), 5, BF
    If angcnt < angmax Then GoTo NewRay Else GoTo tir.bypass
End If
GoSub PrintData
Return

DrawLens:
'Draw border grid.
For ii = 0 To 320 / drawscale Step 25
    Line (320 + ii * drawscale, 0)-(320 + ii * drawscale, 480), 8
    Line (320 - ii * drawscale, 0)-(320 - ii * drawscale, 480), 8
Next
For ii = 0 To 240 / drawscale Step 25
    Line (0, 240 + ii * drawscale)-(640, 240 + ii * drawscale), 8
    Line (0, 240 - ii * drawscale)-(640, 240 - ii * drawscale), 8
Next
Line (320, 0)-(320, 480), 11
Line (0, 240)-(640, 240), 11
x = left.ext: y = 0
GoSub convert.xy
If indexxlens <> 1 Then Circle (xx, yy), Sqr(rad1 ^ 2) * drawscale, 9
x = right.ext: y = 0
GoSub convert.xy
If indexxlens <> 1 Then Circle (xx, yy), Sqr(rad2 ^ 2) * drawscale, 9
If indexxlens <> 1 Then Paint (320, 240), 1, 9
'Draw the border of lens 2 again in a new color.
If indexxlens <> 1 Then Circle (xx, yy), Sqr(rad2 ^ 2) * drawscale, 10
'Draw border scale.
For ii = 0 To 320 Step 25
    Line (320 + ii * drawscale, 470)-(320 + ii * drawscale, 480), 2
    Line (320 - ii * drawscale, 470)-(320 - ii * drawscale, 480), 2
Next
For ii = 0 To 240 Step 25
    Line (0, 240 + ii * drawscale)-(10, 240 + ii * drawscale), 2
    Line (0, 240 - ii * drawscale)-(10, 240 - ii * drawscale), 2
Next
'Draw 3mm detector.
x = targetx - 1: y = 15: GoSub convert.xy
x1 = xx: y1 = yy
x = targetx + 1: y = -15: GoSub convert.xy
x2 = xx: y2 = yy
Line (x1, y1)-(x2, y2), 12, BF
Locate 2, 59: Print "-Optical Parameters-"
Locate 3, 59: Print Using "Index: ##########.##"; indexxlens
Locate 4, 59: Print Using "Left rad: ########.#"; rad1
Locate 5, 59: Print Using "Right rad: #######.#"; rad2
Locate 6, 59: Print Using "Thickness: #######.#"; thickness
Locate 7, 59: Print Using "Left edge: #######.#"; left.edge
Locate 8, 59: Print Using "Right edge: ######.#"; right.edge
Locate 9, 59: Print Using "Focus: ###########.#"; focus
Locate 10, 59: Print Using "Object: ##########.#"; objectx
Locate 11, 59: Print Using "Target: ##########.#"; targetx
x = focus: y = 0: GoSub convert.xy: Circle (xx, yy), 3, 4
x = -focus: y = 0: GoSub convert.xy: Circle (xx, yy), 3, 4
Return

PrintData:
Color 15
Locate 2, 3: Print "Ray & Interface Data"
Locate 3, 3: Print Using "Present index: ##.##"; ni
Locate 4, 3: Print Using "Ray angle: ######.##"; ang * 180 / pi
Locate 5, 3: Print Using "Incident: #######.##"; inc.ang * 180 / pi;
Locate 6, 3: Print Using "Normal: #########.##"; normal.ang * 180 / pi;
Locate 7, 3: Print Using "Height: #########.##"; yi
If (NumRays - 1) <> 0 Then
    Locate 8, 3: Print Using "Hits:  ###/####/###%"; Triggers; (NumRays - 1); 100 * Triggers / (NumRays - 1)
Else
    Locate 8, 3: Print Using "Trigg: ###/####/###%"; 0; 0; 0
End If
Return

convert.xy:
xx = x * drawscale + 320
yy = -y * drawscale + 240
Return

convert.x0y0:
xx0 = x0 * drawscale + 320
yy0 = -y0 * drawscale + 240
Return

convert.xiyi:
xxi = xi * drawscale + 320
yyi = -yi * drawscale + 240
Return

convert.x1y1x2y2:
xx1 = x1 * drawscale + 320
yy1 = -y1 * drawscale + 240
xx2 = x2 * drawscale + 320
yy2 = -y2 * drawscale + 240
Return

