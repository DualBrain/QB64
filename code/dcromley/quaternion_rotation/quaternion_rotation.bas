' https://qb64.boards.net/thread/42/rotating-tetraeder
_Title "Quaternion Rotation" ' dcromley
Option _Explicit
DefSng A-Z: DefLng I-N: DefStr S
Const TRUE = -1, FALSE = 0
Dim Shared mx, my, m1Clk, m1Rpt, m1Dn, m1End, m2Clk, m2Dn ' for MouseCk
Dim Shared Img1, Img2
Img1 = _NewImage(1024, 768, 256)
Img2 = _NewImage(1024, 768, 256)
_Dest Img2: Color 0, 15: Cls
_Dest Img1: Color 0, 15: Cls

' == MAIN start ==

Type type4f ' 4 floats for quaternions, points, triangles
  w As Single ' 0 for points; color for triangles
  x As Single ' pt1 for triangles
  y As Single ' pt2 for triangles
  z As Single ' pt3 for triangles
End Type

Const x0 = 384, y0 = 384, kxy = 200, z0 = 200 ' center, scale
Dim Shared As type4f T, aPts(5), aPts0(5), aTris(4), QMain, QSlew, va, vb
Dim Shared nPts, nTris ' # of Points, Triangles
Dim Shared aMatrix(2, 2)
Dim As type4f Qxp, Qxm, Qyp, Qym, Qzp, Qzm ' +- 1 deg Q's
Dim i, x, y, z, s, p1, p2, p3, icolor, nloop
Dim EuAngX, EuAngY, EuAngZ, fcos, fsin ' Euler angles
Dim az(4), ndx(4), time0, iSlew, xa, ya

' -- Points - x,y,z,/ (# ends)
Data 0,1,0,/,-1,-1,-1,/,-1,-1,1,/,1,-1,1,/,1,-1,-1,#
' -- Triangles - p1,p2,p3,color,/ (# ends)
Data 1,2,3,9,/,1,3,4,10,/,1,4,5,12,/,1,5,2,14,#

Do ' -- load aPoints
  nPts = nPts + 1 ' read point x,y,z
  Read aPts0(nPts).x, aPts0(nPts).y, aPts0(nPts).z, s ' s is / or # to end
Loop Until s = "#"
Do ' -- load aTriangles
  nTris = nTris + 1 ' read triangle p1,p2,p3,color
  Read aTris(nTris).x, aTris(nTris).y, aTris(nTris).z, aTris(nTris).w, s
Loop Until s = "#"
' --  load 1 deg quaternions
fcos = Cos(1 * _Pi / 360): fsin = Sin(1 * _Pi / 360) ' half angle
Qxp.w = fcos: Qxp.x = fsin: Qxm.w = fcos: Qxm.x = -fsin
Qyp.w = fcos: Qyp.y = fsin: Qym.w = fcos: Qym.y = -fsin
Qzp.w = fcos: Qzp.z = fsin: Qzm.w = fcos: Qzm.z = -fsin
QMain.w = 1 ' start with null rotation
QSlew = QMain

time0 = Timer - 1 ' prevent div by 0
Do ' ======== MAIN LOOP ========
  nloop = nloop + 1 ' nloop + 1 and print
  If nloop Mod 2 = 1 Then _Dest Img1: screen img1 _
  Else _Dest Img2: Screen Img2 ' swap screens
  Cls ' simplicity, not performance
  Line (768, 0)-(768, 752), _RGB(192, 192, 192) ' vertical
  MouseCk ' get mouse data
  ' -- check controls
  If iBox(110, 12, " Up") Then Qmult Qxm, QMain, QMain ' nudge orientation
  If iBox(106, 13, "Lft") Then Qmult Qym, QMain, QMain
  If iBox(114, 13, "Rht") Then Qmult Qyp, QMain, QMain
  If iBox(110, 14, " Dn") Then Qmult Qxp, QMain, QMain
  If iBox(106, 15, "CCW") Then Qmult Qzp, QMain, QMain
  If iBox(114, 15, " CW") Then Qmult Qzm, QMain, QMain
  ' -- check for random quaternion
  If iBox(110, 16, "Random") Then QRandom
  ' -- check for mouse dragging (slewing)
  vb.x = mx - x0: vb.y = y0 - my: vb.z = z0 ' new mouse data
  If m1Dn And isIn(mx, 0, 767) And isIn(my, 0, 767) Then ' yes
    QVtoV va, vb, T ' need to smooth out the mouse data
    QSlew.x = QSlew.x * .9 + T.x * .1: QSlew.y = QSlew.y * .9 + T.y * .1: QSlew.z = QSlew.z * .9 + T.z * .1
    Qnorm QSlew ' this is what slews
  Else
    Const k = .99 ' make the slewing decay
    QSlew.x = QSlew.x * k: QSlew.y = QSlew.y * k: QSlew.z = QSlew.z * k
    QSlew.w = Sqr(1 - QSlew.x * QSlew.x - QSlew.y * QSlew.y - QSlew.z * QSlew.z)
  End If
  Qmult QSlew, QMain, QMain ' add slew to QMain
  va = vb ' new becomes old mouse data
  ' -- quaternion to Matrix
  QtoMatrix
  ' -- quaternion to Euler
  EuAngX = _Atan2(2 * QMain.x * QMain.w - 2 * QMain.y * QMain.z, 1 - 2 * QMain.x * QMain.x - 2 * QMain.z * QMain.z)
  EuAngY = _Atan2(2 * QMain.y * QMain.w - 2 * QMain.x * QMain.z, 1 - 2 * QMain.y * QMain.y - 2 * QMain.z * QMain.z)
  EuAngZ = _Asin(2 * QMain.x * QMain.y + 2 * QMain.z * QMain.w)
  ' -- rotate points
  For i = 1 To nPts
    aPts(i) = aPts0(i) ' reset to original
    T = QMain
    T.x = -T.x: T.y = -T.y: T.z = -T.z: ' << Q' >> conjugate
    Qmult aPts(i), T, T '                 << PQ' >>
    Qmult QMain, T, aPts(i) '             << QPQ' >>
  Next i
  For i = 1 To 4 ' get center Z's into a(4)
    T = aTris(i)
    az(i) = aPts(T.x).z + aPts(T.y).z + aPts(T.z).z ' p1.z+p2.z+p3.z
  Next i
  zSortIndexF az(), ndx() ' getting z-order
  For i = 1 To nTris ' this draws the triangles
    drawTri (ndx(i)) ' in z-order
  Next i
  ' -- print stuff
  Locate 2, 101: Print Using "nloops:#,###,###,###"; nloop
  Locate , 101: Print Using "fps:          ####.#"; nloop / (Timer - time0)
  Locate , 104: Print
  Locate , 104: Print "-- To rotate --"
  Locate , 104: Print "1) Click boxes"
  Locate , 104: Print "2) Press boxes"
  Locate , 104: Print "3) Drag mouse"
  Locate , 104: Print "ESC to end"
  Locate 19, 102: Print " -- Quaternion --"
  Locate , 99: Print Using " ##.#####"; QMain.w
  Locate , 99: Print Using " ##.#####"; QMain.x; QMain.y; QMain.z
  '  Locate , 99: Print Using " ##.#####"; QSlew.w
  '  Locate , 99: Print Using " ##.#####"; QSlew.x; QSlew.y; QSlew.z
  Locate , 100: Print ""
  Locate , 102: Print " -- Matrix --"
  Locate , 99: Print Using " ##.#####"; aMatrix(0, 0); aMatrix(0, 1); aMatrix(0, 2)
  Locate , 99: Print Using " ##.#####"; aMatrix(1, 0); aMatrix(1, 1); aMatrix(1, 2)
  Locate , 99: Print Using " ##.#####"; aMatrix(2, 0); aMatrix(2, 1); aMatrix(2, 2)
  Locate , 99: Print Using "  k(w)= ##.#####"; 1.0 + aMatrix(0, 0) + aMatrix(1, 1) + aMatrix(2, 2)
  Locate , 100: Print ""

  Locate , 102: Print " -- Points --"
  For i = 1 To nPts
    Locate , 99: Print Using " ##.#####"; aPts(i).x; aPts(i).y; aPts(i).z
  Next i
  Locate , 100: Print ""
  Locate , 102: Print " -- Euler Angles --"
  Locate , 100: Print Using "EuAngX: ###"; (EuAngX * 180 / _Pi + 360) Mod 360
  Locate , 100: Print Using "EuAngY: ###"; (EuAngY * 180 / _Pi + 360) Mod 360
  Locate , 100: Print Using "EuAngZ: ###"; (EuAngZ * 180 / _Pi + 360) Mod 360
  _Display
Loop Until InKey$ = Chr$(27)
System

' == ROUTINES start ==

Function iBox (iCol, iRow, s3) ' simple control
  Dim ix, iy
  Locate iRow, iCol: Color 0, 14: Print s3;: Color 0, 15
  ix = iCol * 8 - 11
  iy = iRow * 16 - 1
  Line (ix, iy)-(ix + 3 * 8 + 4, iy - 16), , B ' rectangle
  If m1Rpt And isIn(mx, ix, ix + 28) And isIn(my, iy - 16, iy) Then iBox = TRUE
End Function

Sub Qmult (qa As type4f, qb As type4f, qab As type4f) ' Q multiplication
  Dim w, x, y, z
  w = qa.w * qb.w - qa.x * qb.x - qa.y * qb.y - qa.z * qb.z
  x = qa.w * qb.x + qa.x * qb.w + qa.y * qb.z - qa.z * qb.y
  y = qa.w * qb.y - qa.x * qb.z + qa.y * qb.w + qa.z * qb.x
  z = qa.w * qb.z + qa.x * qb.y - qa.y * qb.x + qa.z * qb.w
  qab.w = w: qab.x = x: qab.y = y: qab.z = z
End Sub

Sub QVtoV (v1 As type4f, v2 As type4f, Q As type4f) ' get Q from v1 to v2
  Dim v1dv2, v1xv2 As type4f ' dot, cross
  v1dv2 = VdotV(v1, v2) ' dot
  VcrossV v1, v2, Q ' cross
  Q.w = v1dv2 + Sqr(v1dv2 * v1dv2 + VdotV(Q, Q)) ' from the book
  Qnorm Q
End Sub

Function VdotV (v1 As type4f, v2 As type4f) ' dot product
  VdotV = v1.x * v2.x + v1.y * v2.y + v1.z * v2.z
End Function

Sub VcrossV (v1 As type4f, v2 As type4f, v As type4f) ' cross product
  v.x = v1.y * v2.z - v1.z * v2.y
  v.y = v1.z * v2.x - v1.x * v2.z
  v.z = v1.x * v2.y - v1.y * v2.x
End Sub

Sub Qnorm (q As type4f) ' normalize
  Dim d
  d = Sqr(q.w * q.w + q.x * q.x + q.y * q.y + q.z * q.z)
  q.w = q.w / d: q.x = q.x / d: q.y = q.y / d: q.z = q.z / d
End Sub

Sub drawTri (iTri) ' draw Triangle
  Dim ip1, ip2, ip3, icolor
  Dim ixc, iyc, x1, y1, x2, y2, x3, y3
  T = aTris(iTri) ' the triangle
  ip1 = T.x: ip2 = T.y: ip3 = T.z: icolor = T.w ' the points, color
  x1 = 386 + kxy * aPts(ip1).x: y1 = 386 - kxy * aPts(ip1).y
  x2 = 386 + kxy * aPts(ip2).x: y2 = 386 - kxy * aPts(ip2).y
  x3 = 386 + kxy * aPts(ip3).x: y3 = 386 - kxy * aPts(ip3).y
  Line (x1, y1)-(x2, y2), icolor
  Line (x2, y2)-(x3, y3), icolor
  Line (x3, y3)-(x1, y1), icolor
  ' don't paint if points are colinear
  If Abs(x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)) < 1000 Then Exit Sub
  ixc = (x1 + x2 + x3) / 3: iyc = (y1 + y2 + y3) / 3 ' center
  Paint (ixc, iyc), icolor ' paint
End Sub

' -- LIBRARY ROUTINES --

' -- need Dim Shared mx,my,m1Clk,m1Rpt,m1Dn,m1End,m2Clk,m2Dn
Sub MouseCk () ' get mouse info
  Static m1Prev, m2Prev, m1Time ' for getting edges (Clk,End) and Repeating
  m1Clk = 0: m1Rpt = 0: m1End = 0: m2Clk = 0
  While _MouseInput: Wend ' bplus
  mx = _MouseX: my = _MouseY: m1Dn = _MouseButton(1): m2Dn = _MouseButton(2)
  If m1Dn Then ' Btn 1 down
    If Not m1Prev Then ' got a Clk (& Rpt), now look for repeats
      m1Clk = TRUE: m1Rpt = TRUE: m1Time = iMsecs + 250 ' delay 1/4 sec for repeats
    Else ' has been down, ck for repeat
      If iMsecs > m1Time Then m1Rpt = TRUE: m1Time = iMsecs + 50 ' repeat 20/sec
    End If
    m1Prev = TRUE
  Else ' Btn 1 up
    If m1Prev Then m1End = TRUE ' end of downtime (upedge)
    m1Prev = FALSE ' for next time
  End If
  If m2Dn Then ' Btn 2 down
    If Not m2Prev Then m2Clk = TRUE ' click (downedge)
    m2Prev = TRUE
  Else
    m2Prev = FALSE
  End If
End Sub

Function isIn (x, a, b) ' ck between
  If x >= a And x <= b Then isIn = TRUE
End Function

Sub zSortIndexF (a(), ndx()) ' make index to a()
  Dim i, j, t
  For i = 1 To UBound(a) ' add one at a time
    t = a(i) ' to be added
    For j = i To 2 Step -1 ' merge in
      If a(ndx(j - 1)) <= t Then Exit For
      ndx(j) = ndx(j - 1)
    Next j
    ndx(j) = i
  Next i
End Sub

Function iMsecs () ' milliseconds since midnight UTC
  iMsecs = Int(Timer(.001) * 1000 + .5)
End Function

Function zRandAB (a, b)
  zRandAB = a + Rnd * (b - a)
End Function

Sub QtoMatrix () ' quaternion to matrix
  ' https://www.euclideanspace.com/maths/geometry/rotations/conversions/
  Dim w, x, y, z, wx, wy, wz, xx, xy, xz, yy, yz, zz
  w = QMain.w: x = QMain.x: y = QMain.y: z = QMain.z
  wx = w * x
  wy = w * y
  wz = w * z
  xx = x * x
  xy = x * y
  xz = x * z
  yy = y * y
  yz = y * z
  zz = z * z
  aMatrix(0, 0) = 1 - 2 * (yy + zz)
  aMatrix(1, 1) = 1 - 2 * (xx + zz)
  aMatrix(2, 2) = 1 - 2 * (xx + yy)
  aMatrix(0, 1) = 2 * (xy - wz)
  aMatrix(1, 0) = 2 * (xy + wz)
  aMatrix(0, 2) = 2 * (xz + wy)
  aMatrix(2, 0) = 2 * (xz - wy)
  aMatrix(1, 2) = 2 * (yz - wx)
  aMatrix(2, 1) = 2 * (yz + wx)
End Sub

Sub QRandom () ' random (unit) quaternion
  Dim w, x, y, z, d
  w = zRandAB(-1, 1): x = zRandAB(-1, 1): y = zRandAB(-1, 1): z = zRandAB(-1, 1)
  d = Sqr(w * w + x * x + y * y + z * z)
  QMain.w = w / d: QMain.x = x / d: QMain.y = y / d: QMain.z = z / d
End Sub

