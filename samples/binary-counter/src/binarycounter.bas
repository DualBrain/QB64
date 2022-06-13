' This program is a 12-bit Binary counter, displayed using a 3x4 grid.
' It was created in the honour of an old acquaintance who became
'   obsessed with the binary number system.
'
' It uses extended character code 219 from IBM code page 437 to render
'   the ON state and a simple space (character code 32) to render the
'   OFF state.
'
' If you don't want to run it and just want to see what it does, check
'   out the video on YouTube that inspired the program -
'
'   http://www.youtube.com/watch?v=Isydb_TCz_4
DefInt A-Z
Screen 1
Cls

bits = 1

Do
    bitpos = 1
    row = 3
    col = 4

    Do
        Locate row, col
        If bits And bitpos Then Print Chr$(219); Else Print " ";

        bitpos = bitpos * 2

        col = col - 1
        If col = 0 Then
            col = 4
            row = row - 1
        End If

    Loop While row

    Locate 7, 1
    Print LTrim$(RTrim$(Str$(bits)))

    bits = bits + 1

    _Delay 0.005 'Uncomment this line in QB64 if it runs too quickly.
Loop While bits < 4096

System

