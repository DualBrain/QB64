[Home](https://qb64.com) • [News](../../news.md) • [GitHub](../../github.md) • [Wiki](../../wiki.md) • [Samples](../../samples.md) • [Media](../../media.md) • [Community](../../community.md) • [Rolodex](../../rolodex.md) • [More...](../../more.md)

## SAMPLE: MANDALA 9 LINE

![screenshot.png](img/screenshot.png)

### Author

[🐝 Antoni Gual](../antoni-gual.md) 

### Description

```text
'patterns
'for Rel's 9 LINER contest at QBASICNEWS.COM  1/2003
'------------------------------------------------------------------------
```

### Code

#### pattern.bas

```vb

'patterns
'for Rel's 9 LINER contest at QBASICNEWS.COM  1/2003
'------------------------------------------------------------------------
$NoPrefix
DefLng A-Z
Option Explicit
Option ExplicitArray

$Resize:Smooth

Screen 13
FullScreen SquarePixels , Smooth

Dim As Long t, i, j, k

Do
    t = Rnd * 345
    Wait &H3DA, 8
    For i = 0 To 199
        For j = 0 To 319
            k = ((k + t Xor j Xor i)) And &HFF
            PSet (j, i), k
        Next
    Next
Loop While Len(InKey$) = 0

System 0

```

### File(s)

* [pattern.bas](src/pattern.bas)

🔗 [screensaver](../screensaver.md), [9 lines](../9-lines.md)
