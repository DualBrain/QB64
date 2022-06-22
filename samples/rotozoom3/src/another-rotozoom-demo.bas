OPTION _EXPLICIT
_TITLE "Another RotoZoom Demo" 'b+ started 2020-03-02

CONST xmax = 1200, ymax = 700, xc = 600, yc = 350
SCREEN _NEWIMAGE(xmax, ymax, 32)
_SCREENMOVE 100, 40
DIM SHARED s&, ao
DIM a, x, y, x1, y1, xs, dxs, ddxs, ys, dys, ddys, maxScale

' Starting from an image I pulled from Internet, I used Paint 3D to give it a transparent background.
s& = _LOADIMAGE("tspike.png") 't for transparent background


' Standard Rotation about the image center on a given X, Y location. Rotating image in middle of screen,
' I used something like this to find ideal angle for level point on left head on right.
WHILE _KEYDOWN(27) = 0
    a = a + _PI(1 / 36)
    IF a > _PI(1.999) THEN a = 0
    CLS
    RotoZoom3 xc, yc, s&, 1, 1, a
    PRINT "Raw image rotation:": PRINT
    PRINT "radian angle:"; a; "   degrees:"; _R2D(a) \ 1; " press key for next angle... esc to rotate on y axis"
    WHILE LEN(INKEY$) = 0: _LIMIT 60: WEND
WEND

ao = _PI(.27) ' I have to offset the image angle by this amount so that the spike point is on the left
'               and the head is on the right at 0 degrees or radians.


'Demo of the independent x and y scale for axis rotations
maxScale = 4: dxs = .01: ddxs = 1: xs = maxScale:
WHILE LEN(INKEY$) = 0
    CLS
    PRINT "Press any for rotation on x axis..."
    RotoZoom3 xc, yc, s&, xs, maxScale, ao
    IF xs + dxs > maxScale OR xs + dxs < -maxScale THEN ddxs = ddxs * -1
    xs = xs + dxs * ddxs
    _DISPLAY
    _LIMIT 60
WEND

ys = maxScale: dys = .01: ddys = 1
WHILE LEN(INKEY$) = 0
    CLS
    PRINT "Press any to see layout of image over whole screen and end demo..."
    RotoZoom3 xc, yc, s&, maxScale, ys, ao
    IF ys + dys > maxScale OR ys + dys < -maxScale THEN ddys = ddys * -1
    ys = ys + dys * ddys
    _DISPLAY
    _LIMIT 60
WEND

' Demo of an applied layout on screen
COLOR , &HFFBBBBBB: CLS ' the image has slight gray halo so hide with gray background
FOR x = 40 TO _WIDTH - 40 STEP 20
    RotoZoom3 x, 15, s&, .2, .2, _PI(1.5 + .27)
    RotoZoom3 x, _HEIGHT - 15, s&, .2, .2, _PI(.5 + .27)
NEXT
FOR y = 40 TO _HEIGHT - 40 STEP 20
    RotoZoom3 15, y, s&, .2, .2, _PI(1 + .27)
    RotoZoom3 _WIDTH - 15, y, s&, .2, .2, _PI(.27)
NEXT
FOR a = 0 TO _PI(2) STEP _PI(1 / 6)
    x1 = xc + 200 * COS(a)
    y1 = yc + 200 * SIN(a)
    RotoZoom3 x1, y1, s&, 2, 2, a + ao
NEXT
_DISPLAY
_DELAY 4

'And finally a little show. What is better than a knife thrower throwing bananas?
WHILE _KEYDOWN(27) = 0
    CLS
    drawKite xc, .9 * ymax, 600, a + ao
    _DISPLAY
    _LIMIT 30
    a = a + _PI(2 / 360)
WEND
SYSTEM

SUB drawKite (x, y, s, a)
    RotoZoom3 x, y, s&, s / _WIDTH(s&), s / _HEIGHT(s&), a + ao
    IF s > 10 THEN
        drawKite x + .5 * s * COS(_PI(2) - a), (y - .25 * s) + .25 * s * SIN(_PI(2) - a), s / 1.5, a
        drawKite x + .5 * s * COS(_PI + a), (y - .25 * s) + .25 * s * SIN(_PI + a), s / 1.5, a
    END IF
END SUB

' Description:
' Started from a mod of Galleon's in Wiki that both scales and rotates an image.
' This version scales the x-axis and y-axis independently allowing rotations of image just by changing X or Y Scales
' making this tightly coded routine a very powerful and versatile image tool.
SUB RotoZoom3 (X AS LONG, Y AS LONG, Image AS LONG, xScale AS SINGLE, yScale AS SINGLE, radianRotation AS SINGLE)
    ' This assumes you have set your drawing location with _DEST or default to screen.
    ' X, Y - is where you want to put the middle of the image
    ' Image - is the handle assigned with _LOADIMAGE
    ' xScale, yScale - are shrinkage < 1 or magnification > 1 on the given axis, 1 just uses image size.
    ' These are multipliers so .5 will create image .5 size on given axis and 2 for twice image size.
    ' radianRotation is the Angle in Radian units to rotate the image
    ' note: Radian units for rotation because it matches angle units of other Basic Trig functions
    '       and saves a little time converting from degree.
    '       Use the _D2R() function if you prefer to work in degree units for angles.

    DIM px(3) AS SINGLE: DIM py(3) AS SINGLE ' simple arrays for x, y to hold the 4 corners of image
    DIM W&, H&, sinr!, cosr!, i&, x2&, y2& '   variables for image manipulation
    W& = _WIDTH(Image&): H& = _HEIGHT(Image&)
    px(0) = -W& / 2: py(0) = -H& / 2 'left top corner
    px(1) = -W& / 2: py(1) = H& / 2 ' left bottom corner
    px(2) = W& / 2: py(2) = H& / 2 '  right bottom
    px(3) = W& / 2: py(3) = -H& / 2 ' right top
    sinr! = SIN(-radianRotation): cosr! = COS(-radianRotation) ' rotation helpers
    FOR i& = 0 TO 3 ' calc new point locations with rotation and zoom
        x2& = xScale * (px(i&) * cosr! + sinr! * py(i&)) + X: y2& = yScale * (py(i&) * cosr! - px(i&) * sinr!) + Y
        px(i&) = x2&: py(i&) = y2&
    NEXT
    _MAPTRIANGLE _SEAMLESS(0, 0)-(0, H& - 1)-(W& - 1, H& - 1), Image TO(px(0), py(0))-(px(1), py(1))-(px(2), py(2))
    _MAPTRIANGLE _SEAMLESS(0, 0)-(W& - 1, 0)-(W& - 1, H& - 1), Image TO(px(0), py(0))-(px(3), py(3))-(px(2), py(2))
END SUB


