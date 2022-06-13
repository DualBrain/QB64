$NoPrefix
Option Explicit
Option ExplicitArray
$Resize:Smooth

DefLng A-Z

Type vector
    x As Single
    y As Single
End Type

Type Particle
    pos As vector
    vel As vector
    fade As Single
    active As _Byte
    b As Single
End Type

Type rocket
    x As Single
    y As Single
    xs As Single
    ys As Single
    dead As _Byte
End Type

Const MaxExplosion = 60

Dim rockets(5) As rocket
Dim particles(UBound(rockets) * MaxExplosion * 100) As Particle
Dim As Long i, n, v, k

Randomize Timer
Screen NewImage(1280, 800, 32)
FullScreen SquarePixels , Smooth

For i = 1 To UBound(particles)
    particles(i).vel.x = Rnd * 2
    particles(i).vel.y = Rnd * 2
    particles(i).fade = Rnd * 3 + 1
    particles(i).b = 255
    If Rnd * 2 > 1 Then particles(i).vel.x = -particles(i).vel.x
    If Rnd * 2 > 1 Then particles(i).vel.y = -particles(i).vel.y
Next

For i = 1 To UBound(rockets)
    rockets(i).y = _Height
    rockets(i).x = Rnd * _Width
    rockets(i).dead = -1
    rockets(i).xs = Rnd * 4
    rockets(i).ys = Rnd * 4
Next

Do While KeyHit <> 27
    Line (0, 0)-(_Width, _Height), _RGBA(0, 0, 0, 50), BF

    For i = 1 To UBound(rockets)
        If rockets(i).dead Then

            rockets(i).dead = 0
            rockets(i).x = Rnd * _Width
            rockets(i).y = _Height
            rockets(i).xs = Rnd * 4
            rockets(i).ys = Rnd * 4
        Else
            n = 0
            While n < MaxExplosion
                v = v + 1
                If v > UBound(particles) Then v = 0: Exit While
                If Not particles(v).active Then particles(v).pos.x = rockets(i).x: particles(v).pos.y = rockets(i).y: particles(v).active = -1: n = n + 1
            Wend
            rockets(i).x = rockets(i).x + rockets(i).xs
            rockets(i).y = rockets(i).y - rockets(i).ys
            rockets(i).ys = rockets(i).ys + .1
            rockets(i).xs = rockets(i).xs - .05
            PSet (rockets(i).x, rockets(i).y)
            If rockets(i).y < 0 Then rockets(i).dead = -1: k = k + 1
        End If
    Next
    For i = 1 To UBound(particles)
        If particles(i).active Then
            PSet (particles(i).pos.x, particles(i).pos.y), _RGB(particles(i).b, particles(i).b, 0)
            particles(i).pos.x = particles(i).pos.x + particles(i).vel.x
            particles(i).pos.y = particles(i).pos.y + particles(i).vel.y
            particles(i).vel.y = particles(i).vel.y + .05
            If particles(i).b > 0 Then particles(i).b = particles(i).b - particles(i).fade
        End If
        If particles(i).b < 0 Then
            particles(i).active = 0
            particles(i).vel.x = Rnd * 2
            particles(i).vel.y = Rnd * 2
            particles(i).b = 255
            If Rnd * 2 > 1 Then particles(i).vel.x = -particles(i).vel.x
            If Rnd * 2 > 1 Then particles(i).vel.y = -particles(i).vel.y
        End If
    Next
    _Display
    _Limit 120
Loop

End

