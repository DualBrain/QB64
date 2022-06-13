Dim Shared RGB As Integer
Dim Shared CT As Single, ST As Single, CP As Single, SP As Single
Dim X(0 To 179) As Integer, Y(0 To 179) As Integer, Z(0 To 179) As Integer
Dim XM As Integer, YM As Integer, OLDXM As Integer, OLDYM As Integer
Randomize Timer
Screen 9, , 0, 1
Call _MouseHide
XX = 75: YY = 50: ZZ = 25
NDX = 0
Do
    OLDXM = XM
    OLDYM = YM
    Call getmouse(XM, YM)
    P = (DM - 320) / 150: T = (96 - YM) / 150
    CT = Cos(T): ST = Sin(T)
    CP = Cos(P): SP = Sin(P)
    XX = XX + Int(Rnd(1) * 10) - 5
    YY = YY + Int(Rnd(1) * 11) - 5
    ZZ = ZZ + Int(Rnd(1) * 12) - 5
    If Abs(XX) > 200 Or Abs(YY) > 200 Or Abs(ZZ) > 200 Then
        XX = 0: YY = 0: ZZ = 0
        Cls
    End If
    X(NDX) = XX
    Y(NDX) = YY
    Z(NDX) = ZZ
    PCopy 0, 1
    Cls
    For K = 0 To 179
        RGB = K / 30 + 1
        Call MIRROR(X(K), Y(K), Z(K))
    Next
    NDX = (NDX + 1) Mod 180
    T = Timer
    While T = Timer
        If InKey$ = Chr$(27) Then End
    Wend
Loop

Sub MIRROR (X As Integer, Y As Integer, Z As Integer)
    Call OCTANTS(X, Y, Z)
    Call OCTANTS(X, Z, Y)
    Call OCTANTS(Y, Z, X)
    Call OCTANTS(Y, X, Z)
    Call OCTANTS(Z, X, Y)
    Call OCTANTS(Z, Y, X)
End Sub

Sub OCTANTS (X As Integer, Y As Integer, Z As Integer)
    Call PROJECT(X, Y, Z)
    Call PROJECT(X, Y, -Z)
    Call PROJECT(X, -Y, Z)
    Call PROJECT(X, -Y, -Z)
    Call PROJECT(-X, Y, Z)
    Call PROJECT(-X, Y, -Z)
    Call PROJECT(-X, Y, -Z)
    Call PROJECT(-X, -Y, Z)
    Call PROJECT(-X, -Y, -Z)
End Sub

Sub PROJECT (X As Integer, Y As Integer, Z As Integer)
    XX = CP * X + SP * (CT * Z + ST * Y)
    YY = CT * Y - ST * Z
    ZZ = CP * (CT * Z + ST * Y) - SP * X
    PSet (320 + XX, 175 - YY), RGB - 8 * (ZZ > 0)
End Sub

Sub getmouse (x%, y%)
    Do
    Loop Until _MouseInput = 0
    x% = _MouseX
    y% = _MouseY
End Sub

