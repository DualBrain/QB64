
_Title "sb spiral of chatGPT - fixed by kay63 trans and mod by me, b+ 2023-01-04"
Const xmax = 600, ymax = 600
Dim Shared pi
pi = _Pi
Dim clr As _Unsigned Long
Screen _NewImage(xmax, ymax, 32)

' Set the starting position and radius of the spiral
x = ymax / 2 - .5 * ymax / pi
y = ymax / 2 - .5 * ymax / pi
r = 1

' Set the angle increment for each loop iteration
angle_inc = 5

' Set the maximum radius of the spiral
max_r = ymax / 2

' Set the maximum number of loops
max_loops = ymax

' Set the spiral rotation direction
direction = 1

' Draw the spiral
For i = 1 To max_loops
    ' Set the color for this loop iteration
    'Color i Mod 14
    ' Draw the spiral segment
    Select Case i Mod 3
        Case 0: clr = _RGB32(0, 255 * (i / 600), 128 - (i * 127 / 600))
        Case 1: clr = _RGB32(0, 100 * i / 600 + 55, 100 * i / 600 + 55)
        Case 2: clr = _RGB32(0, 255 * (i / 600), 128 - (i * 127 / 600))
    End Select
    arc x, y, r, angle_inc * i / 180 * pi, angle_inc * (i + 30) / 180 * pi, clr
    ' Increase the radius for the next loop iteration
    r = r + direction
    cnt = cnt + 1
    ' Check if the radius has reached the maximum
    If r > max_r Then
        ' Reverse the growing of the spiral
        direction = -direction
        ' Reset the radius
        r = max_r
    End If
    ' move the spiral:
    x = x + 1 / pi
    y = y + 1 / pi
    _Limit 60
Next
Sleep


Sub arc (x, y, r, raStart, raStop, c As _Unsigned Long) ' this does not check raStart and raStop like arcC does
    Dim al, a
    'x, y origin, r = radius, c = color

    'raStart is first angle clockwise from due East = 0 degrees
    ' arc will start drawing there and clockwise until raStop angle reached

    If raStop < raStart Then
        arc x, y, r, raStart, _Pi(2), c
        arc x, y, r, 0, raStop, c
    Else
        ' modified to easier way suggested by Steve
        'Why was the line method not good? I forgot.
        al = _Pi * r * r * (raStop - raStart) / _Pi(2)
        For a = raStart To raStop Step 1 / al
            PSet (x + r * Cos(a), y + r * Sin(a)), c
        Next
    End If
End Sub

