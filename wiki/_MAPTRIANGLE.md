The [_MAPTRIANGLE](_MAPTRIANGLE) statement maps a triangular portion of an image onto a destination image or screen page.

## Syntax

### 2D drawing

> [_MAPTRIANGLE](_MAPTRIANGLE) [{**_SEAMLESS}**] **(** sx1 **,** sy1 **)-(** sx2 **,** sy2 **)-(** sx3 **,** sy3 **),** source& [TO](TO) **(** dx1 **,** dy1 **)-(** dx2 **,** dy2 **)-(** dx3 **,** dy3 **)**[, destination&][{**_SMOOTH**|**_SMOOTHSHRUNK**|**_SMOOTHSTRETCHED**}]]

### 3D drawing (hardware images only)

> [_MAPTRIANGLE](_MAPTRIANGLE) [{**_CLOCKWISE**|**_ANTICLOCKWISE**}] [{**_SEAMLESS**}] **(** sx1 **,** sy1 **)-(** sx2 **,** sy2 **)-(** sx3 **,** sy3 **),** source& [TO](TO) **(** dx1 **,** dy1 **,** dz1 **)-(** dx2 **,** dy2 **,** dz2 **)-(** dx3 **,** dy3 **,** dz3 **)** [, destination&][{**_SMOOTH**|**_SMOOTHSHRUNK**|**_SMOOTHSTRETCHED**}]]

## Parameter(s)

* The **_SEAMLESS** option makes the triangle skip the right-most and bottom-most pixels of the triangle. When you make larger objects using several triangles, there can be a "seam" where they overlap when using alpha transparency and the seam would be twice as bright. **_SEAMLESS** is ignored when rendering 3D content and is not yet supported when drawing 2D hardware images.**
* For 3D drawing use the **_CLOCKWISE** and **_ANTICLOCKWISE** arguments to only draw triangles in the correct direction. See *Example 4*. 
* Coordinates are [SINGLE](SINGLE) values where whole numbers represent the exact center of a pixel of the source texture. 
* source& and optional destination& are [LONG](LONG) image or screen page handles. 
* Supports an optional final argument **_SMOOTH** which applies linear filtering. See *Example 3*. 
* Use **_SMOOTHSTRETCHED** or **_SMOOTHSHRUNK** for when a pixelated/smooth effect is desirable but not both.

## Description

* This statement is used similar to [_PUTIMAGE](_PUTIMAGE) to place triangular sections of an image, but is more flexible.
* The [STEP](STEP) keyword can be used to for coordinates relative to the last graphic coordinates used.
* For 2D drawing, the destination coordinates are pixel coordinates either on-screen or on the destination image.
* For 3D drawing, the destination coordinates represent left (-x) to right (+x), bottom (-y) to top (+y) & furthest (-z) to nearest (z=-1). The center of the screen is therefore (0,0,-1). Note that a z value of 0 will result in off-screen content. The furthest visible z value is -10,000.
* When drawing **software images** coordinate positions are **limited from -16383 to 16383**
* The source coordinates can be positioned outside the boundary of the *source* image to achieve a tiled effect.
* If the destination& image handle is the current [SCREEN](SCREEN) page, [_DEST](_DEST) or hardware layer, then it can be omitted.
* **Hardware images** (created using mode 33 via [_LOADIMAGE](_LOADIMAGE) or [_COPYIMAGE](_COPYIMAGE)) can be used as the source or destination.

## Example(s)

Rotating an image using a rotation and zoom SUB with _MAPTRIANGLE.

```vb

SCREEN _NEWIMAGE(800, 600, 32)

Image& = _LOADIMAGE("qb64_trans.png")   'replace with your own image

DO
  CLS
  RotoZoom 400, 300, Image&, 1.5 + SIN(zoom), angle
  LOCATE 1, 1: PRINT "Angle:"; CINT(angle)
  PRINT "Zoom"; USING "##.###"; 1.5 + SIN(zoom)
  _DISPLAY
  angle = angle + .5: IF angle >= 360 THEN angle = angle - 360
  zoom = zoom + .01
LOOP UNTIL INKEY$ <> ""
END

SUB RotoZoom (X AS LONG, Y AS LONG, Image AS LONG, Scale AS SINGLE, Rotation AS SINGLE)
DIM px(3) AS SINGLE: DIM py(3) AS SINGLE
W& = _WIDTH(Image&): H& = _HEIGHT(Image&)
px(0) = -W& / 2: py(0) = -H& / 2: px(1) = -W& / 2:py(1) = H& / 2 
px(2) = W& / 2: py(2) = H& / 2: px(3) = W& / 2: py(3) = -H& / 2
sinr! = SIN(-Rotation / 57.2957795131): cosr! = COS(-Rotation / 57.2957795131)
FOR i& = 0 TO 3
  x2& = (px(i&) * cosr! + sinr! * py(i&)) * Scale + X: y2& = (py(i&) * cosr! - px(i&) * sinr!) * Scale + Y
  px(i&) = x2&: py(i&) = y2&
NEXT
_MAPTRIANGLE (0, 0)-(0, H& - 1)-(W& - 1, H& - 1), Image& TO(px(0), py(0))-(px(1), py(1))-(px(2), py(2))
_MAPTRIANGLE (0, 0)-(W& - 1, 0)-(W& - 1, H& - 1), Image& TO(px(0), py(0))-(px(3), py(3))-(px(2), py(2))
END SUB 

```

```text

        **Triangle sections of image in code above     __ **  
                                                    **|\2|**
                                                 ** 1→|_\|**

```

A 3D Spinning Cube demo using a software image and [_MAPTRIANGLE](_MAPTRIANGLE):

```vb

' Copyright (C) 2011 by Andrew L. Ayers

DIM OBJECT(9, 9, 4, 2) AS LONG

' OBJECTS DEFINED AS FOLLOWS:
'   (#OBJECTS,#PLANES PER OBJECT,#POINTS PER PLANE, XYZ TRIPLE)

DIM DPLANE2D(4, 1) AS LONG ' SCREEN PLANE COORDINATES

' DPLANE2D DEFINED AS FOLLOWS:
'   (#POINTS PER PLANE, XY DOUBLE)

DIM DPLANE3D(4, 2) AS LONG ' 3D PLANE COORDINATES

' DPLANE3D DEFINED AS FOLLOWS:
'   (#POINTS PER PLANE, XYZ TRIPLE)

DIM PLANECOL(9) AS INTEGER
DIM STAB(359), CTAB(359) ' SINE/COSINE TABLES
D& = 400: MX& = 0: MY& = 0: MZ& = -100
'
' COMPUTE SINE/COSINE TABLES
FOR t& = 0 TO 359
  STAB(t&) = SIN((6.282 / 360) * t&)
  CTAB(t&) = COS((6.282 / 360) * t&)
NEXT
'
' BUILD CUBE IN OBJECT ARRAY
' PLANE 0
OBJECT(0, 0, 0, 0) = -30: OBJECT(0, 0, 0, 1) = 30: OBJECT(0, 0, 0, 2) = -30
OBJECT(0, 0, 1, 0) = -30: OBJECT(0, 0, 1, 1) = -30: OBJECT(0, 0, 1, 2) = -30
OBJECT(0, 0, 2, 0) = 30: OBJECT(0, 0, 2, 1) = -30: OBJECT(0, 0, 2, 2) = -30
OBJECT(0, 0, 3, 0) = 30: OBJECT(0, 0, 3, 1) = 30: OBJECT(0, 0, 3, 2) = -30
OBJECT(0, 0, 4, 0) = 0: OBJECT(0, 0, 4, 1) = 0: OBJECT(0, 0, 4, 2) = -30
' PLANE 1
OBJECT(0, 1, 0, 0) = 30: OBJECT(0, 1, 0, 1) = 30: OBJECT(0, 1, 0, 2) = -30
OBJECT(0, 1, 1, 0) = 30: OBJECT(0, 1, 1, 1) = -30: OBJECT(0, 1, 1, 2) = -30
OBJECT(0, 1, 2, 0) = 30: OBJECT(0, 1, 2, 1) = -30: OBJECT(0, 1, 2, 2) = 30
OBJECT(0, 1, 3, 0) = 30: OBJECT(0, 1, 3, 1) = 30: OBJECT(0, 1, 3, 2) = 30
OBJECT(0, 1, 4, 0) = 30: OBJECT(0, 1, 4, 1) = 0: OBJECT(0, 1, 4, 2) = 0
' PLANE 2
OBJECT(0, 2, 0, 0) = 30: OBJECT(0, 2, 0, 1) = 30: OBJECT(0, 2, 0, 2) = 30
OBJECT(0, 2, 1, 0) = 30: OBJECT(0, 2, 1, 1) = -30: OBJECT(0, 2, 1, 2) = 30
OBJECT(0, 2, 2, 0) = -30: OBJECT(0, 2, 2, 1) = -30: OBJECT(0, 2, 2, 2) = 30
OBJECT(0, 2, 3, 0) = -30: OBJECT(0, 2, 3, 1) = 30: OBJECT(0, 2, 3, 2) = 30
OBJECT(0, 2, 4, 0) = 0: OBJECT(0, 2, 4, 1) = 0: OBJECT(0, 2, 4, 2) = 30
' PLANE 3
OBJECT(0, 3, 0, 0) = -30: OBJECT(0, 3, 0, 1) = 30: OBJECT(0, 3, 0, 2) = 30
OBJECT(0, 3, 1, 0) = -30: OBJECT(0, 3, 1, 1) = -30: OBJECT(0, 3, 1, 2) = 30
OBJECT(0, 3, 2, 0) = -30: OBJECT(0, 3, 2, 1) = -30: OBJECT(0, 3, 2, 2) = -30
OBJECT(0, 3, 3, 0) = -30: OBJECT(0, 3, 3, 1) = 30: OBJECT(0, 3, 3, 2) = -30
OBJECT(0, 3, 4, 0) = -30: OBJECT(0, 3, 4, 1) = 0: OBJECT(0, 3, 4, 2) = 0
' PLANE 4
OBJECT(0, 4, 0, 0) = -30: OBJECT(0, 4, 0, 1) = -30: OBJECT(0, 4, 0, 2) = -30
OBJECT(0, 4, 1, 0) = -30: OBJECT(0, 4, 1, 1) = -30: OBJECT(0, 4, 1, 2) = 30
OBJECT(0, 4, 2, 0) = 30: OBJECT(0, 4, 2, 1) = -30: OBJECT(0, 4, 2, 2) = 30
OBJECT(0, 4, 3, 0) = 30: OBJECT(0, 4, 3, 1) = -30: OBJECT(0, 4, 3, 2) = -30
OBJECT(0, 4, 4, 0) = 0: OBJECT(0, 4, 4, 1) = -30: OBJECT(0, 4, 4, 2) = 0
' PLANE 5
OBJECT(0, 5, 0, 0) = -30: OBJECT(0, 5, 0, 1) = 30: OBJECT(0, 5, 0, 2) = -30
OBJECT(0, 5, 1, 0) = 30: OBJECT(0, 5, 1, 1) = 30: OBJECT(0, 5, 1, 2) = -30
OBJECT(0, 5, 2, 0) = 30: OBJECT(0, 5, 2, 1) = 30: OBJECT(0, 5, 2, 2) = 30
OBJECT(0, 5, 3, 0) = -30: OBJECT(0, 5, 3, 1) = 30: OBJECT(0, 5, 3, 2) = 30
OBJECT(0, 5, 4, 0) = 0: OBJECT(0, 5, 4, 1) = 30: OBJECT(0, 5, 4, 2) = 0
' SET UP PLANE COLORS ON CUBE
'
PLANECOL(0) = 3
PLANECOL(1) = 4
PLANECOL(2) = 5
PLANECOL(3) = 6
PLANECOL(4) = 7
PLANECOL(5) = 8
'
_TITLE "QB64 _MAPTRIANGLE CUBE DEMO"
SCREEN _NEWIMAGE(800, 600, 32)
TextureImage& = _LOADIMAGE("qb64_trans.png") **'<<<< **replace with your own image
'_PUTIMAGE , Image&

DO
  ' LIMIT TO 25 FPS
  _LIMIT 25
  ' ERASE LAST IMAGE
  CLS

  ' CALCULATE POSITION OF NEW IMAGE
  FOR OB& = 0 TO 0 ' UP TO 9 OBJECTS
    SP = STAB(PIT(OB&)): CP = CTAB(PIT(OB&))
    SY = STAB(YAW(OB&)): CY = CTAB(YAW(OB&))
    SR = STAB(ROL(OB&)): CR = CTAB(ROL(OB&))
    FOR PL& = 0 TO 5 ' CONSISTING OF UP TO 9 PLANES
      '
      FOR PN& = 0 TO 3 ' EACH PLANE WITH UP TO 4 POINTS (#5 TO PAINT)
        '
        ' TRANSLATE, THEN ROTATE
        TX& = OBJECT(OB&, PL&, PN&, 0)
        TY& = OBJECT(OB&, PL&, PN&, 1)
        TZ& = OBJECT(OB&, PL&, PN&, 2)
        RX& = (TZ& * CP - TY& * SP) * SY - ((TZ& * SP + TY& * CP) * SR + TX& * CR) * CY
        RY& = (TZ& * SP + TY& * CP) * CR - TX& * SR
        RZ& = (TZ& * CP - TY& * SP) * CY + ((TZ& * SP + TY& * CP) * SR + TX& * CR) * SY
        '
        ' ROTATE, THEN TRANSLATE
        RX& = RX& + MX&
        RY& = RY& + MY&
        RZ& = RZ& + MZ&
        '
        DPLANE3D(PN&, 0) = RX&: DPLANE3D(PN&, 1) = RY&: DPLANE3D(PN&, 2) = RZ&
        DPLANE2D(PN&, 0) = 399 + (D& * RX& / RZ&)
        DPLANE2D(PN&, 1) = 299 + (D& * RY& / RZ&)
      NEXT
      '
      ' CHECK TO SEE IF PLANE IS VISIBLE
      x1& = DPLANE3D(0, 0): y1& = DPLANE3D(0, 1): Z1& = DPLANE3D(0, 2)
      x2& = DPLANE3D(1, 0): y2& = DPLANE3D(1, 1): Z2& = DPLANE3D(1, 2)
      x3& = DPLANE3D(2, 0): y3& = DPLANE3D(2, 1): Z3& = DPLANE3D(2, 2)
      T1& = -x1& * (y2& * Z3& - y3& * Z2&)
      T2& = x2& * (y3& * Z1& - y1& * Z3&)
      T3& = x3& * (y1& * Z2& - y2& * Z1&)
      '
      VISIBLE& = T1& - T2& - T3&
      IF VISIBLE& > 0 THEN
        ' DRAW PLANE
        xx1% = DPLANE2D(0, 0): yy1% = DPLANE2D(0, 1)
        xx2% = DPLANE2D(1, 0): yy2% = DPLANE2D(1, 1)
        xx3% = DPLANE2D(2, 0): yy3% = DPLANE2D(2, 1)
        col% = PLANECOL(PL&)

        _MAPTRIANGLE (0, 0)-(0, 255)-(255, 255), TextureImage& TO(xx3%, yy3%)-(xx2%, yy2%)-(xx1%, yy1%)
        ' CALL DrawTriangle(xx1%, yy1%, xx2%, yy2%, xx3%, yy3%, col%)
        xx1% = DPLANE2D(0, 0): yy1% = DPLANE2D(0, 1)
        xx3% = DPLANE2D(2, 0): yy3% = DPLANE2D(2, 1)
        xx4% = DPLANE2D(3, 0): yy4% = DPLANE2D(3, 1)
        _MAPTRIANGLE (0, 0)-(255, 255)-(255, 0), TextureImage& TO(xx3%, yy3%)-(xx1%, yy1%)-(xx4%, yy4%)
        'CALL DrawTriangle(xx1%, yy1%, xx3%, yy3%, xx4%, yy4%, col%)
      END IF
    NEXT
    '
    ' ROTATE OBJECT
    PIT(OB&) = PIT(OB&) + 5
    IF PIT(OB&) > 359 THEN PIT(OB&) = 0
    YAW(OB&) = YAW(OB&) + 7
    IF YAW(OB&) > 359 THEN YAW(OB&) = 0
    ROL(OB&) = ROL(OB&) + 9
    IF ROL(OB&) > 359 THEN ROL(OB&) = 0
  NEXT
  '
  ' Calculate Frames per Second
  frames% = frames% + 1
  IF oldtime$ <> TIME$ THEN
    fps% = frames%
    frames% = 1
    oldtime$ = TIME$
  END IF
  COLOR _RGB(255, 255, 255): LOCATE 1, 1: PRINT "FPS :"; fps%
  '
  ' Show Image on Screen
  _DISPLAY
LOOP UNTIL INKEY$ <> ""
WIDTH 80: SCREEN 0: CLS

SUB DrawHline (fromx%, tox%, yy%, col%)
  'DEF SEG = &HA000
  'IF fromx% > tox% THEN SWAP fromx%, tox%
  'yyy& = yy%
  'sloc& = yyy& * 320 + fromx%
  'eloc& = sloc& + (tox% - fromx%)
  'FOR t& = sloc& TO eloc&
  '  POKE t&, col%
  'NEXT
  'DEF SEG
  LINE (fromx%, yy%)-(tox%, yy%), _RGB(255, 255, 255) 'col%
END SUB

SUB DrawTriangle (x1%, y1%, x2%, y2%, x3%, y3%, col%)
  DO
    sflag% = 0
    IF y1% > y2% THEN
      sflag% = 1
      SWAP y1%, y2%
      SWAP x1%, x2%
    END IF
    IF y2% > y3% THEN
      sflag% = 1
      SWAP y2%, y3%
      SWAP x2%, x3%
    END IF
  LOOP UNTIL sflag% = 0
  '
  IF y2% = y3% THEN
    ' Draw a flat bottomed triangle
    ydiff1% = y2% - y1%
    ydiff2% = y3% - y1%
    IF ydiff1% <> 0 THEN
      slope1! = (x2% - x1%) / ydiff1%
    ELSE
      slope1! = 0
    END IF
    IF ydiff2% <> 0 THEN
      slope2! = (x3% - x1%) / ydiff2%
    ELSE
      slope2! = 0
    END IF
    sx! = x1%: ex! = x1%
    FOR y% = y1% TO y2%
      CALL DrawHline(CINT(sx!), CINT(ex!), y%, col%)
      sx! = sx! + slope1!
      ex! = ex! + slope2!
    NEXT
    EXIT SUB
  ELSE
    IF y1% = y2% THEN
      '
      ' Draw a flat topped triangle
      ydiff1% = y3% - y1%
      ydiff2% = y3% - y2%
      IF ydiff1% <> 0 THEN
        slope1! = (x3% - x1%) / ydiff1%
      ELSE
        slope1! = 0
      END IF
      IF ydiff2% <> 0 THEN
        slope2! = (x3% - x2%) / ydiff2%
      ELSE
        slope2! = 0
      END IF
      sx! = x1%: ex! = x2%
      FOR y% = y1% TO y3%
        CALL DrawHline(CINT(sx!), CINT(ex!), y%, col%)
        sx! = sx! + slope1!
        ex! = ex! + slope2!
      NEXT
      x1% = sx!: x2% = ex!
      EXIT SUB
    ELSE
      ' Draw a general purpose triangle
      ' First draw the flat bottom portion (top half)
      ydiff1% = y2% - y1%
      ydiff2% = y3% - y1%
      IF ydiff1% <> 0 THEN
        slope1! = (x2% - x1%) / ydiff1%
      ELSE
        slope1! = 0
      END IF
      IF ydiff2% <> 0 THEN
        slope2! = (x3% - x1%) / ydiff2%
      ELSE
        slope2! = 0
      END IF
      sx! = x1%: ex! = x1%
      FOR y% = y1% TO y2%
        CALL DrawHline(CINT(sx!), CINT(ex!), y%, col%)
        sx! = sx! + slope1!
        ex! = ex! + slope2!
      NEXT
      ' Then draw the flat topped portion (bottom half)
      x1% = x2%
      x2% = ex!
      y1% = y2%
      ydiff1% = y3% - y1%
      ydiff2% = y3% - y2%
      IF ydiff1% <> 0 THEN
        slope1! = (x3% - x1%) / ydiff1%
      ELSE
        slope1! = 0
      END IF
      IF ydiff2% <> 0 THEN
        slope2! = (x3% - x2%) / ydiff2%
      ELSE
        slope2! = 0
      END IF
      sx! = x1%: ex! = x2%
      FOR y% = y1% TO y3%
        CALL DrawHline(CINT(sx!), CINT(ex!), y%, col%)
        sx! = sx! + slope1!
        ex! = ex! + slope2!
      NEXT
      x1% = sx!: x2% = ex!
    END IF
  END IF
  '
END SUB 

```

A 3D Spinning Cube demo using a hardware image and **QB64GL** hardware acceleration with [_MAPTRIANGLE](_MAPTRIANGLE):

```vb

' Copyright (C) 2011 by Andrew L. Ayers

DIM OBJECT(9, 9, 4, 2) AS LONG

' OBJECTS DEFINED AS FOLLOWS:
'   (#OBJECTS,#PLANES PER OBJECT,#POINTS PER PLANE, XYZ TRIPLE)

DIM DPLANE2D(4, 1) AS LONG ' SCREEN PLANE COORDINATES

' DPLANE2D DEFINED AS FOLLOWS:
'   (#POINTS PER PLANE, XY DOUBLE)

DIM DPLANE3D(4, 2) AS LONG ' 3D PLANE COORDINATES

' DPLANE3D DEFINED AS FOLLOWS:
'   (#POINTS PER PLANE, XYZ TRIPLE)

DIM PLANECOL(9) AS INTEGER
DIM STAB(359), CTAB(359) ' SINE/COSINE TABLES
D& = 400: MX& = 0: MY& = 0: MZ& = -100
'
' COMPUTE SINE/COSINE TABLES
FOR t& = 0 TO 359
    STAB(t&) = SIN((6.282 / 360) * t&)
    CTAB(t&) = COS((6.282 / 360) * t&)
NEXT
'
' BUILD CUBE IN OBJECT ARRAY
' PLANE 0
OBJECT(0, 0, 0, 0) = -30: OBJECT(0, 0, 0, 1) = 30: OBJECT(0, 0, 0, 2) = -30
OBJECT(0, 0, 1, 0) = -30: OBJECT(0, 0, 1, 1) = -30: OBJECT(0, 0, 1, 2) = -30
OBJECT(0, 0, 2, 0) = 30: OBJECT(0, 0, 2, 1) = -30: OBJECT(0, 0, 2, 2) = -30
OBJECT(0, 0, 3, 0) = 30: OBJECT(0, 0, 3, 1) = 30: OBJECT(0, 0, 3, 2) = -30
OBJECT(0, 0, 4, 0) = 0: OBJECT(0, 0, 4, 1) = 0: OBJECT(0, 0, 4, 2) = -30
' PLANE 1
OBJECT(0, 1, 0, 0) = 30: OBJECT(0, 1, 0, 1) = 30: OBJECT(0, 1, 0, 2) = -30
OBJECT(0, 1, 1, 0) = 30: OBJECT(0, 1, 1, 1) = -30: OBJECT(0, 1, 1, 2) = -30
OBJECT(0, 1, 2, 0) = 30: OBJECT(0, 1, 2, 1) = -30: OBJECT(0, 1, 2, 2) = 30
OBJECT(0, 1, 3, 0) = 30: OBJECT(0, 1, 3, 1) = 30: OBJECT(0, 1, 3, 2) = 30
OBJECT(0, 1, 4, 0) = 30: OBJECT(0, 1, 4, 1) = 0: OBJECT(0, 1, 4, 2) = 0
' PLANE 2
OBJECT(0, 2, 0, 0) = 30: OBJECT(0, 2, 0, 1) = 30: OBJECT(0, 2, 0, 2) = 30
OBJECT(0, 2, 1, 0) = 30: OBJECT(0, 2, 1, 1) = -30: OBJECT(0, 2, 1, 2) = 30
OBJECT(0, 2, 2, 0) = -30: OBJECT(0, 2, 2, 1) = -30: OBJECT(0, 2, 2, 2) = 30
OBJECT(0, 2, 3, 0) = -30: OBJECT(0, 2, 3, 1) = 30: OBJECT(0, 2, 3, 2) = 30
OBJECT(0, 2, 4, 0) = 0: OBJECT(0, 2, 4, 1) = 0: OBJECT(0, 2, 4, 2) = 30
' PLANE 3
OBJECT(0, 3, 0, 0) = -30: OBJECT(0, 3, 0, 1) = 30: OBJECT(0, 3, 0, 2) = 30
OBJECT(0, 3, 1, 0) = -30: OBJECT(0, 3, 1, 1) = -30: OBJECT(0, 3, 1, 2) = 30
OBJECT(0, 3, 2, 0) = -30: OBJECT(0, 3, 2, 1) = -30: OBJECT(0, 3, 2, 2) = -30
OBJECT(0, 3, 3, 0) = -30: OBJECT(0, 3, 3, 1) = 30: OBJECT(0, 3, 3, 2) = -30
OBJECT(0, 3, 4, 0) = -30: OBJECT(0, 3, 4, 1) = 0: OBJECT(0, 3, 4, 2) = 0
' PLANE 4
OBJECT(0, 4, 0, 0) = -30: OBJECT(0, 4, 0, 1) = -30: OBJECT(0, 4, 0, 2) = -30
OBJECT(0, 4, 1, 0) = -30: OBJECT(0, 4, 1, 1) = -30: OBJECT(0, 4, 1, 2) = 30
OBJECT(0, 4, 2, 0) = 30: OBJECT(0, 4, 2, 1) = -30: OBJECT(0, 4, 2, 2) = 30
OBJECT(0, 4, 3, 0) = 30: OBJECT(0, 4, 3, 1) = -30: OBJECT(0, 4, 3, 2) = -30
OBJECT(0, 4, 4, 0) = 0: OBJECT(0, 4, 4, 1) = -30: OBJECT(0, 4, 4, 2) = 0
' PLANE 5
OBJECT(0, 5, 0, 0) = -30: OBJECT(0, 5, 0, 1) = 30: OBJECT(0, 5, 0, 2) = -30
OBJECT(0, 5, 1, 0) = 30: OBJECT(0, 5, 1, 1) = 30: OBJECT(0, 5, 1, 2) = -30
OBJECT(0, 5, 2, 0) = 30: OBJECT(0, 5, 2, 1) = 30: OBJECT(0, 5, 2, 2) = 30
OBJECT(0, 5, 3, 0) = -30: OBJECT(0, 5, 3, 1) = 30: OBJECT(0, 5, 3, 2) = 30
OBJECT(0, 5, 4, 0) = 0: OBJECT(0, 5, 4, 1) = 30: OBJECT(0, 5, 4, 2) = 0
' SET UP PLANE COLORS ON CUBE
'
PLANECOL(0) = 3
PLANECOL(1) = 4
PLANECOL(2) = 5
PLANECOL(3) = 6
PLANECOL(4) = 7
PLANECOL(5) = 8
'
_TITLE "QB64 _MAPTRIANGLE CUBE DEMO"
SCREEN _NEWIMAGE(800, 600, 32)

TextureImage& = _LOADIMAGE("qb64_trans.png", 32)'replace with your own image
_SETALPHA 128, , TextureImage&
TextureImage& = _COPYIMAGE(TextureImage&, 33)'copy of hardware image

'_PUTIMAGE , Image&

DO

    ' LIMIT TO 25 FPS
    '_LIMIT 25
    ' ERASE LAST IMAGE
    'CLS , _RGB(0, 0, 160)

    ' CALCULATE POSITION OF NEW IMAGE
    FOR OB& = 0 TO 0 ' UP TO 9 OBJECTS
        SP = STAB(PIT(OB&)): CP = CTAB(PIT(OB&))
        SY = STAB(YAW(OB&)): CY = CTAB(YAW(OB&))
        SR = STAB(ROL(OB&)): CR = CTAB(ROL(OB&))
        FOR PL& = 0 TO 5 ' CONSISTING OF UP TO 9 PLANES
            '
            FOR PN& = 0 TO 3 ' EACH PLANE WITH UP TO 4 POINTS (#5 TO PAINT)
                '
                ' TRANSLATE, THEN ROTATE
                TX& = OBJECT(OB&, PL&, PN&, 0)
                TY& = OBJECT(OB&, PL&, PN&, 1)
                TZ& = OBJECT(OB&, PL&, PN&, 2)
                RX& = (TZ& * CP - TY& * SP) * SY - ((TZ& * SP + TY& * CP) * SR + TX& * CR) * CY
                RY& = (TZ& * SP + TY& * CP) * CR - TX& * SR
                RZ& = (TZ& * CP - TY& * SP) * CY + ((TZ& * SP + TY& * CP) * SR + TX& * CR) * SY
                '
                ' ROTATE, THEN TRANSLATE
                RX& = RX& + MX&
                RY& = RY& + MY&
                RZ& = RZ& + MZ&
                '
                DPLANE3D(PN&, 0) = RX&: DPLANE3D(PN&, 1) = RY&: DPLANE3D(PN&, 2) = RZ&
                DPLANE2D(PN&, 0) = 399 + (D& * RX& / RZ&)
                DPLANE2D(PN&, 1) = 299 + (D& * RY& / RZ&)
            NEXT
            '
            ' CHECK TO SEE IF PLANE IS VISIBLE
            x1& = DPLANE3D(0, 0): y1& = DPLANE3D(0, 1): Z1& = DPLANE3D(0, 2)
            x2& = DPLANE3D(1, 0): y2& = DPLANE3D(1, 1): Z2& = DPLANE3D(1, 2)
            x3& = DPLANE3D(2, 0): y3& = DPLANE3D(2, 1): Z3& = DPLANE3D(2, 2)
            T1& = -x1& * (y2& * Z3& - y3& * Z2&)
            T2& = x2& * (y3& * Z1& - y1& * Z3&)
            T3& = x3& * (y1& * Z2& - y2& * Z1&)
            '
            VISIBLE& = T1& - T2& - T3&
            IF VISIBLE& > 0 THEN
                ' DRAW PLANE
                xx1% = DPLANE2D(0, 0): yy1% = DPLANE2D(0, 1)
                xx2% = DPLANE2D(1, 0): yy2% = DPLANE2D(1, 1)
                xx3% = DPLANE2D(2, 0): yy3% = DPLANE2D(2, 1)
                col% = PLANECOL(PL&)

                _BLEND TextureImage&
                _MAPTRIANGLE (0, 0)-(0, 255)-(255, 255), TextureImage& TO(xx1%, yy1%)-(xx2%, yy2%)-(xx3%, yy3%)

                ' CALL DrawTriangle(xx1%, yy1%, xx2%, yy2%, xx3%, yy3%, col%)
                xx1% = DPLANE2D(0, 0): yy1% = DPLANE2D(0, 1)
                xx3% = DPLANE2D(2, 0): yy3% = DPLANE2D(2, 1)
                xx4% = DPLANE2D(3, 0): yy4% = DPLANE2D(3, 1)

                _DONTBLEND TextureImage&
                _MAPTRIANGLE (0, 0)-(255, 255)-(255, 0), TextureImage& TO(xx3%, yy3%)-(xx1%, yy1%)-(xx4%, yy4%), , _SMOOTH
                'CALL DrawTriangle(xx1%, yy1%, xx3%, yy3%, xx4%, yy4%, col%)
            END IF
        NEXT
        '
        ' ROTATE OBJECT
        PIT(OB&) = PIT(OB&) + 5
        IF PIT(OB&) > 359 THEN PIT(OB&) = 0
        YAW(OB&) = YAW(OB&) + 7
        IF YAW(OB&) > 359 THEN YAW(OB&) = 0
        ROL(OB&) = ROL(OB&) + 9
        IF ROL(OB&) > 359 THEN ROL(OB&) = 0
    NEXT
    '
    ' Calculate Frames per Second
    frames% = frames% + 1
    IF oldtime$ <> TIME$ THEN
        fps% = frames%
        frames% = 1
        oldtime$ = TIME$
    END IF
    COLOR _RGB(255, 255, 255): LOCATE 1, 1: PRINT "FPS :"; fps%
    '
    ' Show Image on Screen
    _DISPLAY
LOOP UNTIL INKEY$ <> ""
WIDTH 80: SCREEN 0: CLS

SUB DrawHline (fromx%, tox%, yy%, col%)
'DEF SEG = &HA000
'IF fromx% > tox% THEN SWAP fromx%, tox%
'yyy& = yy%
'sloc& = yyy& * 320 + fromx%
'eloc& = sloc& + (tox% - fromx%)
'FOR t& = sloc& TO eloc&
'  POKE t&, col%
'NEXT
'DEF SEG
LINE (fromx%, yy%)-(tox%, yy%), _RGB(255, 255, 255) 'col%
END SUB

SUB DrawTriangle (x1%, y1%, x2%, y2%, x3%, y3%, col%)
DO
    sflag% = 0
    IF y1% > y2% THEN
        sflag% = 1
        SWAP y1%, y2%
        SWAP x1%, x2%
    END IF
    IF y2% > y3% THEN
        sflag% = 1
        SWAP y2%, y3%
        SWAP x2%, x3%
    END IF
LOOP UNTIL sflag% = 0
'
IF y2% = y3% THEN
    ' Draw a flat bottomed triangle
    ydiff1% = y2% - y1%
    ydiff2% = y3% - y1%
    IF ydiff1% <> 0 THEN
        slope1! = (x2% - x1%) / ydiff1%
    ELSE
        slope1! = 0
    END IF
    IF ydiff2% <> 0 THEN
        slope2! = (x3% - x1%) / ydiff2%
    ELSE
        slope2! = 0
    END IF
    sx! = x1%: ex! = x1%
    FOR y% = y1% TO y2%
        CALL DrawHline(CINT(sx!), CINT(ex!), y%, col%)
        sx! = sx! + slope1!
        ex! = ex! + slope2!
    NEXT
    EXIT SUB
ELSE
    IF y1% = y2% THEN
        '
        ' Draw a flat topped triangle
        ydiff1% = y3% - y1%
        ydiff2% = y3% - y2%
        IF ydiff1% <> 0 THEN
            slope1! = (x3% - x1%) / ydiff1%
        ELSE
            slope1! = 0
        END IF
        IF ydiff2% <> 0 THEN
            slope2! = (x3% - x2%) / ydiff2%
        ELSE
            slope2! = 0
        END IF
        sx! = x1%: ex! = x2%
        FOR y% = y1% TO y3%
            CALL DrawHline(CINT(sx!), CINT(ex!), y%, col%)
            sx! = sx! + slope1!
            ex! = ex! + slope2!
        NEXT
        x1% = sx!: x2% = ex!
        EXIT SUB
    ELSE
        ' Draw a general purpose triangle
        ' First draw the flat bottom portion (top half)
        ydiff1% = y2% - y1%
        ydiff2% = y3% - y1%
        IF ydiff1% <> 0 THEN
            slope1! = (x2% - x1%) / ydiff1%
        ELSE
            slope1! = 0
        END IF
        IF ydiff2% <> 0 THEN
            slope2! = (x3% - x1%) / ydiff2%
        ELSE
            slope2! = 0
        END IF
        sx! = x1%: ex! = x1%
        FOR y% = y1% TO y2%
            CALL DrawHline(CINT(sx!), CINT(ex!), y%, col%)
            sx! = sx! + slope1!
            ex! = ex! + slope2!
        NEXT
        ' Then draw the flat topped portion (bottom half)
        x1% = x2%
        x2% = ex!
        y1% = y2%
        ydiff1% = y3% - y1%
        ydiff2% = y3% - y2%
        IF ydiff1% <> 0 THEN
            slope1! = (x3% - x1%) / ydiff1%
        ELSE
            slope1! = 0
        END IF
        IF ydiff2% <> 0 THEN
            slope2! = (x3% - x2%) / ydiff2%
        ELSE
            slope2! = 0
        END IF
        sx! = x1%: ex! = x2%
        FOR y% = y1% TO y3%
            CALL DrawHline(CINT(sx!), CINT(ex!), y%, col%)
            sx! = sx! + slope1!
            ex! = ex! + slope2!
        NEXT
        x1% = sx!: x2% = ex!
    END IF
END IF
'
END SUB

```

Using a desktop image with _MAPTRIANGLE _ANTICLOCKWISE rendering.

```vb

SCREEN _NEWIMAGE(800, 600, 32)

ss32 = _SCREENIMAGE 'take a 32bit software screenshot
_SETALPHA 128, , ss32 'make it a bit transparent
ss33 = _COPYIMAGE(ss32, 33) 'convert it to a hardware image (mode 33)
_FREEIMAGE ss32 'we don't need this anymore

DO
    CLS , _RGB(0, 128, 255) 'use our software screen as a blue backdrop

    'rotate our destination points
    'the QB64 3D co-ordinate system is the same as  OpenGL's:
    '    negative z is in front of you, if it doesn't have a negative z value you won't see it!
    '    x goes from left to right, 0 is the middle of the screen
    '    y goes from bottom to top, 0 is the middle of the screen
    scale = 10
    dist = -10
    angle = angle + 0.1
    x1 = SIN(angle) * scale
    z1 = COS(angle) * scale
    x2 = SIN(angle + 3.14) * scale 'adding 3.14 adds 180 degrees
    z2 = COS(angle + 3.14) * scale
    'what we performed above is a 2D/horizontal rotation of points
    '(3D rotations are beyond the scope of this example)

    'draw the triangle
    '_ANTICLOCKWISE makes it only draw when our triangle is facing the correct direction
    '_SMOOTH applies linear filtering to avoid a pixelated look

    _MAPTRIANGLE **_ANTICLOCKWISE** (_WIDTH(ss33) / 2, 0)-(0, _HEIGHT(ss33))-(_WIDTH(ss33),_
    _HEIGHT(ss33)), ss33 TO(0, scale, dist)-(x1, -scale, z1 + dist)-(x2, -scale, z2 + dist), , **_SMOOTH**

    _LIMIT 30
    _DISPLAY
LOOP 

```

> **Tip:** If you are using Linux you might want to replace "[_SCREENIMAGE](_SCREENIMAGE)" with a [_LOADIMAGE](_LOADIMAGE) command if you don't see anything.

## See Also

* [_PUTIMAGE](_PUTIMAGE)
* [_LOADIMAGE](_LOADIMAGE)
* [_COPYIMAGE](_COPYIMAGE)
* [GET (graphics statement)](GET-(graphics-statement)), [PUT (graphics statement)](PUT-(graphics-statement))
* [STEP](STEP), [SIN](SIN), [COS](COS)
* [Hardware images](Hardware-images)
