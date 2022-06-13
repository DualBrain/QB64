Screen 12
Randomize Timer

Type Vector
    x As Double
    y As Double
End Type

Type LineSegment
    '                  Endpoint definition:
    p1 As Vector '     Endpoint 1
    p2 As Vector '     Endpoint 2
    '                  Parameterized definition:
    b As Vector '      Origin vector
    alpha1 As Double ' End-parameter 1
    alpha2 As Double ' End-parameter 2
    ang As Double '    Orientation angle
    t As Vector '      Tangent (unit) vector
End Type

Dim Shared Segments(100) As LineSegment
Dim Shared NumSegments As Integer
NumSegments = 0

'' Example: Define a line using parameters (calculates endpoints anyway):
'NumSegments = NumSegments + 1
'Segments(NumSegments).b.x = 0
'Segments(NumSegments).b.y = 0
'Segments(NumSegments).alpha1 = 0
'Segments(NumSegments).alpha2 = 100
'Segments(NumSegments).ang = ATN(0)
'Segments(NumSegments).t.x = COS(Segments(NumSegments).ang)
'Segments(NumSegments).t.y = SIN(Segments(NumSegments).ang)
'CALL CalcEndpoints(NumSegments)

'' Example: Define a line using endpoints (calculates parameters anyway):
'NumSegments = NumSegments + 1
'Segments(NumSegments).p1.x = 0
'Segments(NumSegments).p1.y = 0
'Segments(NumSegments).p2.x = 100
'Segments(NumSegments).p2.y = 0

' Main lines and shapes

NumSegments = NumSegments + 1
Segments(NumSegments).p1.x = -100
Segments(NumSegments).p1.y = -100
Segments(NumSegments).p2.x = 100
Segments(NumSegments).p2.y = -100

NumSegments = NumSegments + 1
Segments(NumSegments).p1.x = -200
Segments(NumSegments).p1.y = -100
Segments(NumSegments).p2.x = 200
Segments(NumSegments).p2.y = -100

NumSegments = NumSegments + 1
Segments(NumSegments).p1.x = 200
Segments(NumSegments).p1.y = -100
Segments(NumSegments).p2.x = 0
Segments(NumSegments).p2.y = 200

NumSegments = NumSegments + 1
Segments(NumSegments).p1.x = 0
Segments(NumSegments).p1.y = 200
Segments(NumSegments).p2.x = -200
Segments(NumSegments).p2.y = -100

NumSegments = NumSegments + 1
Segments(NumSegments).p1.x = -200
Segments(NumSegments).p1.y = -200
Segments(NumSegments).p2.x = 200
Segments(NumSegments).p2.y = 200

NumSegments = NumSegments + 1
Segments(NumSegments).p1.x = 200
Segments(NumSegments).p1.y = -200
Segments(NumSegments).p2.x = -200
Segments(NumSegments).p2.y = 200

' Main loop
Do

    ' User input
    Do While _MouseInput
        x = _MouseX
        y = _MouseY
        If ((x > 0) And (x < _Width) And (y > 0) And (y < _Height)) Then
            If (_MouseButton(1)) Then
                Call CalcParameters(1)
                x = _MouseX
                y = _MouseY
                Segments(1).b.x = Int((x - _Width / 2))
                Segments(1).b.y = Int((-y + _Height / 2))
                Call CalcEndpoints(1)
            End If
            If (_MouseWheel > 0) Then
                Call CalcParameters(1)
                Segments(1).ang = Segments(1).ang + Atn(1) / 10
                Segments(1).t.x = Cos(Segments(1).ang)
                Segments(1).t.y = Sin(Segments(1).ang)
                Call CalcEndpoints(1)
            End If
            If (_MouseWheel < 0) Then
                Call CalcParameters(1)
                Segments(1).ang = Segments(1).ang - Atn(1) / 10
                Segments(1).t.x = Cos(Segments(1).ang)
                Segments(1).t.y = Sin(Segments(1).ang)
                Call CalcEndpoints(1)
            End If
        End If
    Loop

    ' Graphics
    Cls
    For k = 1 To NumSegments
        Call cline(Segments(k).p1.x, Segments(k).p1.y, Segments(k).p2.x, Segments(k).p2.y, 15)
    Next

    ' Intersections loop
    For k = 1 To NumSegments
        For j = k + 1 To NumSegments
            a1x = Segments(k).p1.x
            a1y = Segments(k).p1.y
            a2x = Segments(k).p2.x
            a2y = Segments(k).p2.y
            b1x = Segments(j).p1.x
            b1y = Segments(j).p1.y
            b2x = Segments(j).p2.x
            b2y = Segments(j).p2.y
            Call CalcIntersections(a1x, a1y, a2x, a2y, b1x, b1y, b2x, b2y)
        Next
    Next

    _Display
    _Limit 60
Loop

End

Sub CalcIntersections (a1x, a1y, a2x, a2y, b1x, b1y, b2x, b2y)
    ' Requires UDT LineSegment
    ' Requires FUNCTION DotProduct

    Dim s1 As LineSegment
    Dim s2 As LineSegment

    s1.p1.x = a1x
    s1.p1.y = a1y
    s1.p2.x = a2x
    s1.p2.y = a2y
    s1.ang = Atn((s1.p2.y - s1.p1.y) / (s1.p2.x - s1.p1.x))
    s1.b.x = .5 * (s1.p1.x + s1.p2.x)
    s1.b.y = .5 * (s1.p1.y + s1.p2.y)
    s1.alpha1 = -.5 * _Hypot(s1.p2.x - s1.p1.x, s1.p2.y - s1.p1.y)
    s1.alpha2 = .5 * _Hypot(s1.p2.x - s1.p1.x, s1.p2.y - s1.p1.y)
    s1.t.x = Cos(s1.ang)
    s1.t.y = Sin(s1.ang)

    s2.p1.x = b1x
    s2.p1.y = b1y
    s2.p2.x = b2x
    s2.p2.y = b2y
    s2.ang = Atn((s2.p2.y - s2.p1.y) / (s2.p2.x - s2.p1.x))
    s2.b.x = .5 * (s2.p1.x + s2.p2.x)
    s2.b.y = .5 * (s2.p1.y + s2.p2.y)
    s2.alpha1 = -.5 * _Hypot(s2.p2.x - s2.p1.x, s2.p2.y - s2.p1.y)
    s2.alpha2 = .5 * _Hypot(s2.p2.x - s2.p1.x, s2.p2.y - s2.p1.y)
    s2.t.x = Cos(s2.ang)
    s2.t.y = Sin(s2.ang)

    Dim db As Vector
    db.x = s2.b.x - s1.b.x
    db.y = s2.b.y - s1.b.y
    qj = DotProduct(db, s1.t)
    ql = DotProduct(db, s2.t)
    p = DotProduct(s1.t, s2.t)
    pp = p * p
    If (pp < 1) Then ' Non-parallel case
        alphaj = (qj - p * ql) / (1 - pp)
        alphal = (p * qj - ql) / (1 - pp)
        If ((alphaj > s1.alpha1) And (alphaj < s1.alpha2)) Then
            If ((alphal > s2.alpha1) And (alphal < s2.alpha2)) Then
                Call ccircle(s1.b.x + alphaj * s1.t.x, s1.b.y + alphaj * s1.t.y, 3, 13)
                Call ccircle(s2.b.x + alphal * s2.t.x, s2.b.y + alphal * s2.t.y, 5, 15)
            End If
        End If
    Else ' Parallel case
        Dim dbhat As Vector
        dbmag = Sqr(db.x * db.x + db.y * db.y)
        If (dbmag <> 0) Then
            dbhat.x = db.x / dbmag
            dbhat.y = db.y / dbmag
            thresh = DotProduct(dbhat, s1.t)
        End If
        If ((1 - thresh * thresh < 0.001) Or (dbmag = 0)) Then ' Overlap detection
            t1t2 = DotProduct(s1.t, s2.t)
            alphaj1 = s2.alpha1 * t1t2 + DotProduct(s1.t, db)
            alphaj2 = s2.alpha2 * t1t2 + DotProduct(s1.t, db)
            x1 = 0
            y1 = 0
            x2 = 0
            y2 = 0
            If ((alphaj1 >= s1.alpha1) And (alphaj1 <= s1.alpha2)) Then
                xx = s1.b.x + alphaj1 * s1.t.x
                yy = s1.b.y + alphaj1 * s1.t.y
                If (x1 = 0) Then x1 = xx Else x2 = xx
                If (y1 = 0) Then y1 = yy Else y2 = yy
                Call ccircle(xx, yy, 3, 13)
                'CALL ccircle(s2.b.x + s2.alpha1 * s2.t.x, s2.b.y + s2.alpha1 * s2.t.y, 4, 14)
            End If
            If ((alphaj2 >= s1.alpha1) And (alphaj2 <= s1.alpha2)) Then
                xx = s1.b.x + alphaj2 * s1.t.x
                yy = s1.b.y + alphaj2 * s1.t.y
                If (x1 = 0) Then x1 = xx Else x2 = xx
                If (y1 = 0) Then y1 = yy Else y2 = yy
                Call ccircle(xx, yy, 3, 13)
                'CALL ccircle(s2.b.x + s2.alpha2 * s2.t.x, s2.b.y + s2.alpha2 * s2.t.y, 4, 14)
            End If
            alphal1 = s1.alpha1 * t1t2 - DotProduct(s2.t, db)
            alphal2 = s1.alpha2 * t1t2 - DotProduct(s2.t, db)
            If ((alphal1 >= s2.alpha1) And (alphal1 <= s2.alpha2)) Then
                xx = s2.b.x + alphal1 * s2.t.x
                yy = s2.b.y + alphal1 * s2.t.y
                If (x1 = 0) Then x1 = xx Else x2 = xx
                If (y1 = 0) Then y1 = yy Else y2 = yy
                Call ccircle(xx, yy, 3, 15)
                'CALL ccircle(s1.b.x + s1.alpha1 * s1.t.x, s1.b.y + s1.alpha1 * s1.t.y, 5, 15)
            End If
            If ((alphal2 >= s2.alpha1) And (alphal2 <= s2.alpha2)) Then
                xx = s2.b.x + alphal2 * s2.t.x
                yy = s2.b.y + alphal2 * s2.t.y
                If (x1 = 0) Then x1 = xx Else x2 = xx
                If (y1 = 0) Then y1 = yy Else y2 = yy
                Call ccircle(xx, yy, 3, 15)
                'CALL ccircle(s1.b.x + s1.alpha2 * s1.t.x, s1.b.y + s1.alpha2 * s1.t.y, 5, 15)
            End If
            If (x1 Or x2 Or y1 Or y2) Then ' Overlap occurred
                Call cline(x1, y1, x2, y2, 13)
            End If
        End If
    End If

End Sub

Sub CalcEndpoints (i As Integer)
    Segments(i).p1.x = Segments(i).b.x + Segments(i).alpha1 * Segments(i).t.x
    Segments(i).p1.y = Segments(i).b.y + Segments(i).alpha1 * Segments(i).t.y
    Segments(i).p2.x = Segments(i).b.x + Segments(i).alpha2 * Segments(i).t.x
    Segments(i).p2.y = Segments(i).b.y + Segments(i).alpha2 * Segments(i).t.y
End Sub

Sub CalcParameters (i As Integer)
    Segments(i).ang = Atn((Segments(i).p2.y - Segments(i).p1.y) / (Segments(i).p2.x - Segments(i).p1.x))
    Segments(i).b.x = .5 * (Segments(i).p1.x + Segments(i).p2.x)
    Segments(i).b.y = .5 * (Segments(i).p1.y + Segments(i).p2.y)
    Segments(i).alpha1 = -.5 * _Hypot(Segments(i).p2.x - Segments(i).p1.x, Segments(i).p2.y - Segments(i).p1.y)
    Segments(i).alpha2 = .5 * _Hypot(Segments(i).p2.x - Segments(i).p1.x, Segments(i).p2.y - Segments(i).p1.y)
    Segments(i).t.x = Cos(Segments(i).ang)
    Segments(i).t.y = Sin(Segments(i).ang)
End Sub

Function DotProduct (a As Vector, b As Vector)
    DotProduct = a.x * b.x + a.y * b.y
End Function

Sub cline (x1 As Double, y1 As Double, x2 As Double, y2 As Double, col As _Unsigned Long)
    Line (_Width / 2 + x1, -y1 + _Height / 2)-(_Width / 2 + x2, -y2 + _Height / 2), col
End Sub

Sub ccircle (x1 As Double, y1 As Double, rad As Double, col As _Unsigned Long)
    Circle (_Width / 2 + x1, -y1 + _Height / 2), rad, col
End Sub

Sub cpset (x1 As Double, y1 As Double, col As _Unsigned Long)
    PSet (_Width / 2 + x1, -y1 + _Height / 2), col
End Sub

Sub cpaint (x1 As Double, y1 As Double, col1 As _Unsigned Long, col2 As _Unsigned Long)
    Paint (_Width / 2 + x1, -y1 + _Height / 2), col1, col2
End Sub

Sub cprintstring (y As Double, a As String)
    _PrintString (_Width / 2 - (Len(a) * 8) / 2, -y + _Height / 2), a
End Sub


