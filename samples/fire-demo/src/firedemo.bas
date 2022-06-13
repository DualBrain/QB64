_Title "FIRE Demo v1.0"
'-----| by harixxx
'-----| 6-16-2010

Const mx = 108
Const my = 44
Const sx = 3
Const sy = 6
Const ms$ = "QB64 : FIRE Demo v1.0 - Created by harixxx"

sc = -mx
lt = Len(ms$) * 8
Dim ct(lt, 14), fl(mx, my)

Screen _NewImage(640, 240, 256), , 1, 0

Print ms$
For i = 0 To lt - 1
    For j = 0 To 13
        If Point(i, j) > 0 Then
            ct(i, j) = 64
            ct(i, j + 1) = -64
            ct(i + 1, j + 1) = -64
        End If
Next j, i

Screen _NewImage(320, 240, 256), , 1, 0
For i = 0 To 63
    SetPal i, i, 0, 0
    SetPal i + 64, 63, i, 0
    SetPal i + 128, 63, 63, i
Next

'_FULLSCREEN
_Limit 10
Do
    ReDim fm(mx, my)
    sc = sc + .5
    If sc > lt Then sc = -mx
    For x = 0 To mx
        For y = 0 To 14
            cx = Int(x + sc)
            If cx >= 0 And cx <= lt Then fm(x, y + 16) = ct(cx, y)
    Next y, x
    For x = 1 To mx - 1
        fl(x, my) = Rnd * 2250 - 1000
        For y = my - 1 To 0 Step -1
            fl(x, y) = (fl(x - 1, y) + fl(x, y + 1) + fl(x + 1, y + 1)) \ 3 - 4
            c = fl(x, y)
            c = (c - 2) * -(c < 64) + c * -(c > 63) + fm(x, y)
            c = 191 * -(c > 191) + c * -(c < 192)
            If y < my - 4 Then Line (x * sx - sx, y * sy)-Step(sx, sy), c * -(c > 0), BF
    Next y, x
    _Delay .03
    PCopy 1, 0
Loop Until InKey$ > ""
Sleep
System

Sub SetPal (n, r, g, b)
    Out 968, n
    Out 969, r
    Out 969, g
    Out 969, b
END SUB

