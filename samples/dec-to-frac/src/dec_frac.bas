'  DEC_FRAC.BAS - Fraction/Decimal conversion functions
'                and sample program

'  by Antonio and Alfonso De Pasquale
'  Copyright (C) 1993 DOS Resource Guide
'  Published in Issue #10, July 1993, page 46

DECLARE FUNCTION DecToFrac$ (decimal)
DECLARE FUNCTION FracToDec (fraction$)

MAIN:
Cls: Locate 1, 25: Print "Fraction/Decimal Converter"
Locate 2, 21: Print "by Antonio and Alfonso De Pasquale"
Locate 3, 1: For x = 1 To 79: Print "=";: Next x
Locate 5, 1: Print "Please select one of the following choices:"
Locate 7, 10: Print "[D]ecimal to Fraction"
Locate 8, 10: Print "[F]raction to Decimal"
Locate 9, 10: Print "[Q]uit Program"

Do
    Locate 11, 1: Print Space$(79)
    Locate 11, 1: Input "Please enter your choice (D/F/Q): ", choice$
    choice$ = UCase$(Left$(choice$, 1))
Loop Until choice$ = "D" Or choice$ = "F" Or choice$ = "Q"

CONVERT:
Select Case choice$
    Case "Q"
        Cls: End

    Case "D"
        Locate 13, 1: Print Space$(79)
        Locate 13, 1: Input "Please enter a decimal value: ", decimal$
        decimal = Val(decimal$)
        If decimal = 0 Or Int(decimal) = decimal Then GoTo CONVERT
        fraction$ = DecToFrac$(decimal)
        Locate 16, 1: Print "The Decimal  "; decimal; "  is equal to the fraction; "; fraction$; ""

    Case "F"
        Locate 13, 1: Print Space$(79)
        Locate 13, 1: Input "Please enter a fractional value: ", fraction$
        fl$ = fraction$: fl$ = fl$ + " ": fl = InStr(1, fl$, "/")
        If Val(fraction$) = 0 Or fl = 0 Then GoTo CONVERT
        If (Mid$(fl$, fl - 1, 1) = " ") Or (Mid$(fl$, fl + 1, 1) = " ") Then GoTo CONVERT
        decimal = FracToDec(fraction$)
        Locate 16, 1: Print "The fraction  "; fraction$; "  is equal to the decimal  "; decimal

End Select

Locate 19, 1: Print "Press Enter to continue";
Do: Loop Until InKey$ = Chr$(13)
GoTo MAIN
End

'*********************************************************
'
'         ACTUAL CONVERSION FUNCTIONS BEGIN HERE
'
'*********************************************************

Function DecToFrac$ (decimal)

    decimal$ = Str$(decimal)
    index = InStr(decimal$, ".")
   
    If index = 1 Then
        decimal$ = "0" + decimal$
        index = index + 1
    End If

    whole$ = Left$(decimal$, index - 1)
    dec$ = Mid$(decimal$, index, 10)

    If Val(whole$) = 0 Then
        whole$ = ""
    End If

    dec = Val(dec$)
    dec = Int(dec * 1000 + .5)

    num = dec
    den = 1000

    For pass = 0 To 3
        For index = 10 To 1 Step -1
            If (num / index = Int(num / index)) And (den / index) = Int(den / index) Then
                num = (num / index)
                den = (den / index)
            End If
        Next index
    Next pass

    fraction$ = whole$ + Str$(num) + "/" + Mid$(Str$(den), 2)
    DecToFrac$ = fraction$

End Function

Function FracToDec (fraction$)

    decimal = 0
    dp = 0

    index = InStr(fraction$, Chr$(32))

    If index = 0 Then
        f$ = fraction$
    Else
        whole$ = Left$(fraction$, index)
        f$ = Mid$(fraction$, index + 1, 10)
    End If

    index = InStr(f$, "/")
    num = Val(Left$(f$, index - 1))
    den = Val(Mid$(f$, index + 1))

    dp = num / den
    decimal = Abs(Val(whole$)) + dp
    If Left$(fraction$, 1) = "-" Then decimal = (-decimal)
    If Left$(fraction$, 1) = "-" And decimal > 0 Then decimal = (-decimal)
    FracToDec = decimal

End Function

