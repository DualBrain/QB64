[Home](https://qb64.com) • [News](../../news.md) • [GitHub](../../github.md) • [Wiki](../../wiki.md) • [Samples](../../samples.md) • [Media](../../media.md) • [Community](../../community.md) • [Rolodex](../../rolodex.md) • [More...](../../more.md)

## SAMPLE: TURTLE GRAPHICS

![turtle.png](img/turtle.png)

### Author

[🐝 triggered](../triggered.md) 

### Description

```text
Basic "turtle graphics" setup. Draws a Koch snowflake by default.
```

### Code

#### turtle.bas

```vb

Screen 12

Dim a$
a$ = "FRRFRRF"

Dim j
For j = 1 To 4
    a$ = stReplace$(a$, "F", "FLFRRFLF")
Next j

TurtleGraphics 320 / 3, 240 / 2, 0, 5, a$

Sleep
End

Sub TurtleGraphics (x0 As Double, y0 As Double, a0 As Double, ssize As Double, path As String)
    Dim As Double x, y, angle, stepsize
    Dim w As String
    Dim t As String
    x = x0
    y = y0
    angle = a0
    w = path
    PReset (x0, y0)
    Do While Len(w)
        t = Left$(w, 1)
        w = Right$(w, Len(w) - 1)
        Select Case t
            Case "F"
                x = x + ssize * Cos(angle)
                y = y + ssize * Sin(angle)
            Case "L"
                angle = angle - 60 * _Pi / 180
            Case "R"
                angle = angle + 60 * _Pi / 180
        End Select
        Line -(x, y), 15
    Loop
End Sub

Function stReplace$ (a As String, b As String, c As String)
    Dim i As Integer
    Dim g As String
    Dim r As String
    For i = 1 To Len(a)
        g = Mid$(a, i, 1)
        If g = b Then
            r = r + c
        Else
            r = r + g
        End If
    Next
    stReplace = r
End Function

```

### File(s)

* [turtle.bas](src/turtle.bas)

🔗 [fractal](../fractal.md), [turtle graphics](../turtle-graphics.md)


<sub>Reference: [qb64 Forum](https://qb64phoenix.com/forum/showthread.php?tid=512) </sub>
