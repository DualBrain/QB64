[Home](https://qb64.com) • [News](../../news.md) • [GitHub](../../github.md) • [Wiki](../../wiki.md) • [Samples](../../samples.md) • [Media](../../media.md) • [Community](../../community.md) • [Rolodex](../../rolodex.md) • [More...](../../more.md)

## SAMPLE: CONNECT CIRCLES

![screenshot.png](img/screenshot.png)

### Author

[🐝 bplus](../bplus.md) 

### Description

```text
Created by QB64 community member bplus.
```

### Code

#### connectcircles.bas

```vb

' Created by QB64 community member bplus

$NoPrefix
Option Explicit
Option ExplicitArray

Const xmax = 600 ' not working!!!
Const ymax = 600

Dim As Integer i, j, s, sq
Dim As Double x, y, c, d
Dim As Unsigned Long cc

Screen NewImage(xmax, ymax, 32)
Title "Connect Circles"

s = 1
sq = 5
Do
    For j = 0 To ymax / sq
        For i = 0 To xmax / sq
            x = i * s / 600
            y = j * s / 600
            c = x * x + y * y
            d = c / 2
            d = d - Int(d)
            d = Int(d * 1000)
            If d < 250 Then
                cc = RGB32(d, 0, 0)
            ElseIf d < 500 Then
                cc = RGB32(0, d - 250, 0)
            ElseIf d < 750 Then
                cc = RGB32(0, 0, d - 500)
            Else
                cc = RGB32(255, 255, 255)
            End If
            Line (i * sq, j * sq)-Step(sq, sq), cc, BF
        Next
    Next
    Delay 0.5
    'Color RGB32(255, 255, 255)
    'Locate 1, 1
    'Print s
    s = s + 15
    If s > 1000 Then
        s = 1
    End If
Loop While Len(InKey$) = 0

System 0

```

### File(s)

* [connectcircles.bas](src/connectcircles.bas)

🔗 [screensaver](../screensaver.md), [mosaic](../mosaic.md)
