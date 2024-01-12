Option _Explicit
_Title "Mandala Life trans from sb" 'b+ 2023-01-15
'Mandala life.bas SmallBASIC (not MS) B+ for Bpf 2015-03-25
Screen _NewImage(600, 600, 12)
Dim As Long an, s, bigblock, g, x, y, pc, lc, cl
an = 60: s = 10: bigblock = 600: g = 0
Dim As Long a(1 To an, 1 To an), ng(1 To an, 1 To an), ls(1 To an, 1 To an)
Dim r$

While _KeyDown(27) = 0
    'If g Mod 2 = 0 Then ' keep a pulsing border
        For x = 1 To an
            a(x, 1) = 1: a(x, an) = 1: a(1, x) = 1: a(an, x) = 1
        Next
    'End If
    For x = 2 To an - 1
        For y = 2 To an - 1
            pc = a(x - 1, y - 1) + a(x - 1, y) + a(x - 1, y + 1) + a(x, y - 1) + a(x, y + 1) + a(x + 1, y - 1) + a(x + 1, y) + a(x + 1, y + 1)
            ls(x, y) = pc: r$ = _Trim$(Str$(pc))
            If a(x, y) Then
                If InStr("2346", r$) Then ng(x, y) = 1 Else ng(x, y) = 0
            Else 'birth?
                If InStr("34", r$) Then ng(x, y) = 1 Else ng(x, y) = 0
            End If
        Next
    Next
    Line (1, 1)-(bigblock, bigblock), 15, BF
    For y = 1 To an
        For x = 1 To an
            If a(x, y) Then
                Line ((x - 1) * s + 1, (y - 1) * s + 1)-Step(s, s), 0, BF
            Else
                lc = ls(x, y)
                Select Case lc
                    Case 0: cl = 15 'br white
                    Case 1: cl = 11 'cyan
                    Case 2: cl = 7 'low white, br gray
                    Case 3: cl = 10 'light green
                    Case 4: cl = 9 'blue
                    Case 5: cl = 13 'violet
                    Case 6: cl = 12 'br red
                    Case 7: cl = 4 'dark red
                    Case 8: cl = 1 'indigo
                End Select
                Line ((x - 1) * s + 1, (y - 1) * s + 1)-Step(s, s), cl, BF
            End If
        Next
    Next
    For y = 1 To an
        For x = 1 To an
            a(x, y) = ng(x, y)
        Next
    Next
    g = g + 1
    If g > 60 Then _delay .25

Wend
