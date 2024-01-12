'Option _Explicit
_Title "Mandala Life Perpetual Random Border" 'b+ 2023-01-17 from no pulse
Randomize Timer
Dim Shared As Long CellsPerSide, pixPerSide, Block
CellsPerSide = 60: pixPerSide = 10: Block = 600
Dim Shared Seed(1 To CellsPerSide)
Dim As Long a(1 To CellsPerSide, 1 To CellsPerSide), ng(1 To CellsPerSide, 1 To CellsPerSide), ls(1 To CellsPerSide, 1 To CellsPerSide)
Dim r$
Dim As Long g, x, y, pc, lc, cl
Screen _NewImage(Block, Block, 12)
_Title "Press Spacebar to Reseed Perpetual Border..."
makeSeed
While _KeyDown(27) = 0
    If _KeyHit = 32 Then makeSeed
    For x = 1 To CellsPerSide 'redraw random seed around border
        a(x, 1) = Seed(x)
        a(x, CellsPerSide) = Seed(x)
        a(1, x) = Seed(x)
        a(CellsPerSide, x) = Seed(x)
    Next
    For x = 2 To CellsPerSide - 1
        For y = 2 To CellsPerSide - 1
            pc = a(x - 1, y - 1) + a(x - 1, y) + a(x - 1, y + 1) + a(x, y - 1) + a(x, y + 1) + a(x + 1, y - 1) + a(x + 1, y) + a(x + 1, y + 1)
            ls(x, y) = pc: r$ = _Trim$(Str$(pc))
            If a(x, y) Then
                If InStr("2346", r$) Then ng(x, y) = 1 Else ng(x, y) = 0
            Else 'birth?
                If InStr("34", r$) Then ng(x, y) = 1 Else ng(x, y) = 0
            End If
        Next
    Next
    Line (1, 1)-(Block, Block), 15, BF
    For y = 1 To CellsPerSide
        For x = 1 To CellsPerSide
            If a(x, y) Then
                Line ((x - 1) * pixPerSide + 1, (y - 1) * pixPerSide + 1)-Step(pixPerSide, pixPerSide), 0, BF
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
                Line ((x - 1) * pixPerSide + 1, (y - 1) * pixPerSide + 1)-Step(pixPerSide, pixPerSide), cl, BF
            End If
        Next
    Next
    _Display
    _Limit 2
    For y = 1 To CellsPerSide
        For x = 1 To CellsPerSide
            a(x, y) = ng(x, y)
        Next
    Next
Wend
Sub makeSeed
    Dim As Long i, r
    Dim d
    d = Rnd
    For i = 1 To Int(CellsPerSide / 2 + .5)
        If Rnd < d Then r = 1 Else r = 0
        Seed(i) = r: Seed(CellsPerSide - i + 1) = r
    Next
End Sub