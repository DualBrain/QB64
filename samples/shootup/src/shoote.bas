'CHDIR ".\samples\pete\su2"

DECLARE SUB border ()
DECLARE SUB center (text$)
Screen 13
U$ = Chr$(0) + "H"
D$ = Chr$(0) + "P"
L$ = Chr$(0) + "K"
R$ = Chr$(0) + "M"

new:
Cls
Dim map$(27, 12)
For y = 1 To 12
    For x = 1 To 27
        map$(x, y) = "5-0"
Next: Next

x = 13: y = 6

drawon:
Cls
border
For yy = 1 To 12
    For xx = 1 To 27
        For i = 1 To 5
            If Mid$(map$(xx, yy), i, 1) = "-" Then B$ = Mid$(map$(xx, yy), 1, i - 1): item2 = Val(Mid$(map$(xx, yy), i + 1, 10))
        Next
        c = Val(B$)
        If c = 0 Or item2 = 0 Or item2 = 255 Or item2 = 32 Then map$(xx, yy) = "0-0"
        Color c: Locate yy + 4, xx + 6: Print Chr$(item2)
Next: Next
top:
If drw = 0 Then Color 15
If drw = 1 Then Color 12
Locate y + 4, x + 6: Print Chr$(197)
Locate 18, 7: Color clr: Print "Color "; Chr$(item)
Do: P$ = InKey$: Loop Until P$ <> ""
oldy = y: oldx = x
If P$ = U$ And y <> 1 Then y = y - 1
If P$ = D$ And y <> 12 Then y = y + 1
If P$ = R$ And x <> 27 Then x = x + 1
If P$ = L$ And x <> 1 Then x = x - 1
If P$ = "s" Or P$ = "S" Then GoTo save
If P$ = "l" Or P$ = "L" Then GoTo load
If P$ = "r" Or P$ = "R" Then GoTo drawon
If P$ = "i" Then item = item + 1: If item = 256 Then item = 0
If P$ = "I" Then GoTo item
If P$ = "h" Or P$ = "H" Then drw = drw + 1: If drw = 2 Then drw = 0
If P$ = Chr$(27) Then End
If P$ = "c" Or P$ = "C" Then clr = clr + 1: If clr = 16 Then clr = 0
If P$ = "1" Then clr = 1
If P$ = "2" Then clr = 2
If P$ = "3" Then clr = 3
If P$ = "4" Then clr = 4
If P$ = "5" Then clr = 5
If P$ = "6" Then clr = 6
If P$ = "7" Then clr = 7
If P$ = "8" Then clr = 8
If P$ = "9" Then clr = 9
If P$ = Chr$(32) Or drw = 1 Then map$(x, y) = Str$(clr) + "-" + Str$(item): If clr = 0 Or item = 0 Or item = 255 Or item = 32 Then map$(x, y) = "0-0"
For i = 1 To 5
    If Mid$(map$(oldx, oldy), i, 1) = "-" Then B$ = Mid$(map$(oldx, oldy), 1, i - 1): item2 = Val(Mid$(map$(oldx, oldy), i + 1, 10))
Next
c = Val(B$)
If c = 0 Or item2 = 0 Or item2 = 255 Or item2 = 32 Then map$(oldx, oldy) = "0-0"
Color c: Locate oldy + 4, oldx + 6: Print Chr$(item2)
GoTo top

item:
Locate 19, 7: Color 4
Input "ASCII Num"; item
If item >= 256 Then item = 255
Locate 19, 7: Print "               "
GoTo top

save:
Locate 19, 7: Color 12
If file$ = "" Then Input "File name to save as"; file$
Open file$ + ".dat" For Output As #1
For yy = 1 To 12
    For xx = 1 To 27
        For i = 1 To 5
            If Mid$(map$(xx, yy), i, 1) = "-" Then B$ = Mid$(map$(xx, yy), 1, i - 1): item2 = Val(Mid$(map$(xx, yy), i + 1, 3))
        Next
        c = Val(B$)
        If c = 0 Or item2 = 0 Or item2 = 255 Or item2 = 32 Then map$(xx, yy) = "0-0"
        Print #1, map$(xx, yy)
Next: Next
Locate 19, 7: Print "                                "
Close #1
GoTo top

load:
Locate 19, 7: Color 12
Input "File name to load"; file$
Open file$ + ".dat" For Input As #1
For yy = 1 To 12
    For xx = 1 To 27
        Input #1, map$(xx, yy)
Next: Next
Close #1
GoTo drawon

Sub border
    Color 4
    center "Shoot Up Editor 2"
    center ""
    center ""
    Color 7
    center "±±±±±±±±±±±±±±±±±±±±±±±±±±±±±"
    center "±                           ±"
    center "±                           ±"
    center "±                           ±"
    center "±                           ±"
    center "±                           ±"
    center "±                           ±"
    center "±                           ±"
    center "±                           ±"
    center "±                           ±"
    center "±                           ±"
    center "±                           ±"
    center "±                           ±"
    center "±±±±±±±±±±±±±±±±±±±±±±±±±±±±±"

End Sub

Sub center (text$)
    Print Tab(20 - (Int(Len(text$) / 2))); text$
End Sub

