Option _Explicit
Dim x As Double
Dim Coefficient(21) As Double
Dim k As Long
x = 1 / 2 + Sqr(5) / 2
'x = 1 + SQR(2)
'x = 3 / 2 + SQR(13) / 2
'x = 2 + SQR(5)
Do
    Cls
    If (_KeyDown(18432) = -1) Then ' Up-arrow
        x = x + .01
    End If
    If (_KeyDown(20480) = -1) Then ' Down-arrow
        x = x - .01
    End If
    _KeyClear
    Coefficient(1) = 1
    Coefficient(2) = x - 1 / x
    Print "x="; x
    Print "C_1="; Coefficient(1)
    Print "C_2="; Coefficient(2)
    For k = 3 To UBound(Coefficient)
        Coefficient(k) = -1 * Coefficient(k - 2) + x ^ (k - 1) + (-1) ^ (k - 1) * 1 / (x ^ (k - 1))
        Print "C_"; LTrim$(RTrim$(Str$(k))); "="; Coefficient(k) ', Coefficient(k) / Coefficient(k - 1)
    Next
    _Limit 60
    _Display
Loop
