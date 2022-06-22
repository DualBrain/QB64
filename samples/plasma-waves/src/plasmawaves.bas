'Wavy with Plama.bas for QB64 fork (B+=MGA) 2017-05-05
' Wavy with Plasma Treatment.bas SmallBASIC 0.12.9 (B+=MGA) 2017-05-03
' from: animated circles started by Admin at SdlBasic 2017-05-03
' I added Plasma treatment and spacebar  changer


'===================================================================

' Instructions: press spacebar for new injection of plasma

'==================================================================

Randomize Timer
Const sqr12! = .5 ^ .5
Const xmax = 1100
Const ymax = 700
Const DPI = 3.141516 * 2
Const PHIDELTA = DPI / 15
Const PHISTEP = DPI / 50
Const RADIUS = 20
Const SMALL_R = 20
Const DISTANCE = 23
Const W = xmax
Const H = ymax

Screen _NewImage(xmax, ymax, 32)
_Title "Wavy with Plasma trans by bplus, Press Spacebar for New Plasma Injection."
Dim Shared cN As Double
Dim Shared pR, pG, pB As Integer
Dim x, y, xball, yball As Integer
Dim current_phi, phiIndex, phi As Double
current_phi = 0
cN = 1
resetPlasma
While 1
    Cls
    _Limit 10
    If _KeyHit = 32 Then cN = 1: resetPlasma
    current_phi = current_phi + PHISTEP
    For x = 0 To (W + RADIUS) Step DISTANCE
        For y = 0 To (H + RADIUS) Step DISTANCE
            'COLOR _RGB(120, 80, 80)
            'CIRCLE (x, y), RADIUS
            phiIndex = ((x + y) Mod (2 * W)) / RADIUS
            phi = phiIndex * PHIDELTA + current_phi
            xball = Cos(phi) * RADIUS + x
            yball = Sin(phi) * RADIUS + y
            changePlasma
            'LINE (x, y)-(xball, yball)
            fcirc2 xball, yball, SMALL_R
        Next
    Next
    _Display
Wend

Sub changePlasma ()
    cN = cN + 1
    Color _RGB(127 + 127 * Sin(pR * cN), 127 + 127 * Sin(pG * cN), 127 + 127 * Sin(pB * cN))
End Sub

Sub resetPlasma ()
    pR = Rnd ^ 2: pG = Rnd ^ 2: pB = Rnd ^ 2
End Sub

'========================================== sqrSeg Method for filled circle
Sub fcirc2 (xx%, yy%, r%)
    'const sqr12! = .5^.5  'in main const section
    r2% = r% * r%
    sqr12r% = sqr12! * r%
    Line (xx% - sqr12r%, yy% - sqr12r%)-(xx% + sqr12r%, yy% + sqr12r%), , BF
    For x% = 0 To sqr12r%
        y% = Sqr(r2% - x% * x%)
        Line (xx% - x%, yy% + sqr12r%)-(xx% - x%, yy% + y%)
        Line (xx% - x%, yy% - sqr12r%)-(xx% - x%, yy% - y%)
        Line (xx% + x%, yy% + sqr12r%)-(xx% + x%, yy% + y%)
        Line (xx% + x%, yy% - sqr12r%)-(xx% + x%, yy% - y%)
    Next
    For x% = sqr12r% To r%
        y% = Sqr(r2% - x% * x%)
        Line (xx% - x%, yy% + y%)-(xx% - x%, yy% - y%)
        Line (xx% + x%, yy% + y%)-(xx% + x%, yy% - y%)
    Next
End Sub

Sub fcirc (xx%, yy%, r%)
    r2% = r% * r%
    For x% = 0 To r%
        y% = Int(Sqr(r2% - x% * x%))
        Line (xx% - x%, yy% + y%)-(xx% - x%, yy% - y%)
        Line (xx% + x%, yy% + y%)-(xx% + x%, yy% - y%)
    Next
End Sub



