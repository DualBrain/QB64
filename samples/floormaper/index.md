[Home](https://qb64.com) • [News](../../news.md) • [GitHub](../../github.md) • [Wiki](../../wiki.md) • [Samples](../../samples.md) • [Media](../../media.md) • [Community](../../community.md) • [Rolodex](../../rolodex.md) • [More...](../../more.md)

## SAMPLE: FLOORMAPER

![screenshot.png](img/screenshot.png)

### Author

[🐝 Antoni Gual](../antoni-gual.md) 

### Description

```text
Floormaper by Antoni Gual

for Rel's 9 LINER contest at QBASICNEWS.COM  1/2003
```

### Code

#### flrmp.bas

```vb

'Floormaper by Antoni Gual
'for Rel's 9 LINER contest at QBASICNEWS.COM  1/2003
'------------------------------------------------------------------------
$NoPrefix
DefLng A-Z
Option Explicit
Option ExplicitArray

$Resize:Smooth

Dim As Long r, y, y1, x
Dim As Single y2

Screen 13
FullScreen SquarePixels , Smooth

Do
    r = (r + 1) And 15
    For y = 1 To 99
        y1 = ((1190 / y + r) And 15)
        y2 = 6 / y
        For x = 0 To 319
            PSet (x, y + 100), CInt((159 - x) * y2) And 15 Xor y1 + 16
        Next
    Next
    Limit 60
Loop While Len(InKey$) = 0

System 0

```

### File(s)

* [flrmp.bas](src/flrmp.bas)

🔗 [graphics](../graphics.md), [floorscape](../floorscape.md)
