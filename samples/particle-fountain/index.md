[Home](https://qb64.com) • [News](../../news.md) • [GitHub](../../github.md) • [Wiki](../../wiki.md) • [Samples](../../samples.md) • [Media](../../media.md) • [Community](../../community.md) • [Rolodex](../../rolodex.md) • [More...](../../more.md)

## SAMPLE: PARTICLE FOUNTAIN

![screenshot.png](img/screenshot.png)

### Author

[🐝 bplus](../bplus.md) 

### Description

```text
' Created by QB64 community member bplus.
```

### Code

#### particlefountain.bas

```vb

' Created by QB64 community member bplus

$NoPrefix
Option Explicit
Option ExplicitArray

Title "Particle Fountain"

Const nP = 30000

Type particle
    x As Single
    y As Single
    dx As Single
    dy As Single
    r As Single
    c As Unsigned Long
End Type

Dim Shared p(nP) As particle

Screen NewImage(600, 600, 32)

Dim As Long i, lp
For i = 0 To nP
    new i
Next

Do
    Limit 90
    Cls
    If lp < nP Then
        lp = lp + 100
    End If
    For i = 0 To lp
        p(i).dy = p(i).dy + .1
        p(i).x = p(i).x + p(i).dx
        p(i).y = p(i).y + p(i).dy
        If p(i).x < 0 Or p(i).x > Width Then
            new i
        End If
        If p(i).y > Height And p(i).dy > 0 Then
            p(i).dy = -.75 * p(i).dy
            p(i).y = Height - 5
        End If
        Circle (p(i).x, p(i).y), p(i).r, p(i).c
    Next
    Display
Loop While Len(InKey$) = 0

System 0

Sub new (i)
    p(i).x = Width / 2 + Rnd * 20 - 10
    p(i).y = Height + Rnd * 5
    p(i).dx = Rnd * 1 - .5
    p(i).dy = -10
    p(i).r = Rnd * 3
    p(i).c = RGB32(100 * Rnd + 155, 100 * Rnd + 155, 200 + Rnd * 55)
End Sub

```

### File(s)

* [particlefountain.bas](src/particlefountain.bas)

🔗 [particles](../particles.md)


<sub>Reference: [qb64.org Forum](https://qb64forum.alephc.xyz/index.php?topic=2957) </sub>
