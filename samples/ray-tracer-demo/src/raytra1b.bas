'Pure QB Realtime Raytracer Demo
'Translated to/optimized for QB by Antoni Gual agual@eic.ictnet.es
'The original was written in C by Texel, a Spanish demo coder.
'It will not work in the IDE due to integer overflow errors.
'Compile with QB 4.0 or QB4.5 + ffix. It does 12.5 fps in my P4 1,4.
'The C version (DOS protected mode, DJGPP) does 50 fps :(

$NoPrefix
$Resize:Smooth

Const objnum = 4

Dim n As Integer, K As Integer, OBJMIN As Integer, OBJMIN2 As Integer
Dim OBJ(objnum) As Integer, l As Integer, posi As Integer, POS2 As Integer
Dim s As Integer, t(8200) As Integer, XX As Integer, YY As Integer, XQ As Integer
Dim YQ As Integer, mmmm As Integer, xx1 As Integer, yy1 As Integer
Dim t2(8200) As Integer, ipos As Integer

Dim A(objnum) As Single, B(objnum) As Single, C(objnum) As Single
Dim R(objnum) As Single

Screen 13
FullScreen SquarePixels , Smooth

Def Seg = &HA000
'Cambiar la paleta a tonos de azul
Out &H3C8, 0 '
For n = 0 To 127
    Out &H3C9, 0
    Out &H3C9, Int(n / 4)
    Out &H3C9, Int(n / 2)
Next
For n = 0 To 127
    Out &H3C9, Int(n / 2)
    Out &H3C9, Int(31 + n / 4)
    Out &H3C9, 63
Next
D = 230
l = 0
   
'four objects
OBJ(0) = 0: A(0) = -50 + l: B(0) = 0: C(0) = -100: R(0) = -55 * 55
OBJ(1) = 0: A(1) = 50 - l: B(1) = -25: C(1) = -120: R(1) = -55 * 55
OBJ(2) = 0: A(2) = 0: B(2) = 500: C(2) = -220: R(2) = -500! * 500
OBJ(3) = 1: A(3) = 60: B(3) = -35: C(3) = -30

tt! = Timer
For l = 0 To 199

    A(0) = -50 + l
    A(1) = 50 - l
    posi = 400
    mmmm = -1
    'calculamos uno de cada 4 pixels a buffer t()
    For Y = -40 To 39 Step 2
        For X = -80 To 79 Step 2
            X0 = X
            Y0 = Y
            GoSub raytrace
            t(posi) = COL
            posi = posi + 1
        Next
    Next
    posi = 482
    POS2 = 0
    'calculamos pixels restantes, interpolando si podemos
    For YQ = 6 To 43
        For XQ = 2 To 77
            'interpolar
            If t2(posi) = t2(posi + 1) And t2(posi) = t2(posi + 80) And t2(posi) = t2(posi + 81) Then
                ipos = (YQ * 1280 + (XQ * 4))
                For YY = 0 To 3
                    For XX = 0 To 3
                        Poke ipos, (YY * (t(posi + 80) * (4 - XX) + t(posi + 81) * XX) + (t(posi) * (4 - XX) + t(posi + 1) * XX) * (4 - YY)) \ 16
                        ipos = ipos + 1
                    Next
                    ipos = ipos + 316
                Next
                'no interpolar
            Else
                mmmm = 0
                For yy1 = 0 To 3
                    For xx1 = 0 To 3
                        If xx1 Or yy1 Then
                            X0 = (-160 + XQ * 4 + xx1) / 2
                            Y0 = (-100 + YQ * 4 + yy1) / 2
                            GoSub raytrace
                            Poke (YQ * 4 + yy1) * 320 + XQ * 4 + xx1, COL
                        Else
                            Poke YQ * 1280 + XQ * 4, t(posi)
                        End If
                    Next
                Next
            End If
            posi = posi + 1
        Next
        posi = posi + 4
    Next
    If Len(InKey$) Then Exit For
    Limit 60
Next
Color 255: Print l / (Timer - tt!)
KK$ = Input$(1)
End

raytrace:
Z0 = 0
MD = 1 / Sqr(X0 * X0 + Y0 * Y0 + D * D)
X1 = X0 * MD
Y1 = Y0 * MD
Z1 = -(D + Z0) * MD
K = 0
COL = 0
OBJMIN = objnum
If mmmm Then t2(posi) = objnum
Do
    TMIN = 327680
    For n = 0 To 2
        If OBJ(n) = 0 And (OBJ(n) <> OBJMIN) Then
            A0 = A(n) - X0
            B0 = B(n) - Y0
            C0 = C(n) - Z0
            TB = A0 * X1 + B0 * Y1 + C0 * Z1
            RZ = TB * TB - A0 * A0 - B0 * B0 - C0 * C0
            If RZ >= R(n) Then
                TN = TB - Sqr(RZ - R(n))
                If TN < TMIN And TN > 0 Then TMIN = TN: OBJMIN2 = n
            End If
        End If
    Next
    OBJMIN = OBJMIN2
    If TMIN < 327680 And (OBJ(OBJMIN) = 0) Then
        If mmmm Then t2(posi) = t2(posi) * K * objnum * 3 + OBJMIN
        X0 = X0 + X1 * TMIN
        Y0 = Y0 + Y1 * TMIN
        Z0 = Z0 + Z1 * TMIN
        NX = X0 - A(OBJMIN)
        NY = Y0 - B(OBJMIN)
        NZ = Z0 - C(OBJMIN)
        CA = 2 * (NX * X1 + NY * Y1 + NZ * Z1) / (NX * NX + NY * NY + NZ * NZ + 1)
        X1 = X1 - NX * CA
        Y1 = Y1 - NY * CA
        Z1 = Z1 - NZ * CA
        A2 = A(3) - X0
        B2 = B(3) - Y0
        C2 = C(3) - Z0
        MV = 1 / Sqr(A2 * A2 + B2 * B2 + C2 * C2)
        A2 = A2 * MV
        B2 = B2 * MV
        C2 = C2 * MV
        s = 0
        For n = 0 To 2
            If OBJ(n) = 0 And Not s Then
                A0 = X0 - A(n)
                B0 = Y0 - B(n)
                C0 = Z0 - C(n)
                TB = A2 * A0 + B2 * B0 + C2 * C0
                RZ = TB * TB - A0 * A0 - B0 * B0 - C0 * C0
                If RZ >= R(n) And TB < 0 Then s = -1: If mmmm Then t2(posi) = t2(posi) * 32
            End If
        Next
        If Not s Then
            If mmmm Then t2(posi) = t2(posi) + 1
            col2 = X1 * A2 + Y1 * B2 + Z1 * C2
            If col2 < 0 Then col2 = 0
            cc = col2 * col2
            col2 = cc * cc
            MV = Sqr(NX * NX + NY * NY + NZ * NZ)
            'IF COL2 < 0 THEN COL2 = 0
            col2 = col2 + (NX * A2 + NY * B2 + NZ * C2) / MV
            If col2 < 0 Then col2 = 0
            COL = COL + col2 / ((K + 1) * (K + 1) * 2)
            If COL > 1 Then COL = 1
        End If
        K = K + 1
    End If
Loop While TMIN < 327680 And K <= 2
If K = 0 Then COL = 50 Else COL = COL * 255
Return

