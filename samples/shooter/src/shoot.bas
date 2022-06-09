$NoPrefix
DefLng A-Z

$Resize:Smooth
Screen 13, , 1, 0
FullScreen SquarePixels , Smooth

SndPlayFile "ps2battl.mid"
shootsound = SndOpen("fireball.wav", "SYNC")

'index,filename(.RAW),width,height
Data 1,ship1,21,27
Data 2,shot1,10,10
Data 3,evil1,93,80
Data 4,land1,320,56
Data 5,boom1,65,75

Dim Shared spritedata(1000000) As Unsigned Byte
Dim Shared freespritedata As Long
Dim Shared freesprite As Long
freesprite = 1

Type spritetype
    x As Integer
    y As Integer
    index As Long 'an index in the spritedata() array
    index2 As Long 'optional secondary index
    halfx As Integer
    halfy As Integer
End Type
Dim Shared s(1 To 1000) As spritetype

'load sprites
For i = 1 To 5
    b$ = " "
    Read n
    Read f$: f$ = f$ + ".raw"
    Read x, y
    Open f$ For Binary As #1
    If LOF(1) <> x * y Then Screen 0: Print "Error loading " + f$: End
    For y2 = y - 1 To 0 Step -1
        For x2 = 0 To x - 1
            Get #1, , b$
            PSet (x2, y2), Asc(b$)
        Next
    Next
    Close #1
    Get (0, 0)-(x - 1, y - 1), spritedata(freespritedata)
    s(freesprite).index = freespritedata
    freespritedata = freespritedata + x * y + 4
    'create shadow
    For y2 = y - 1 To 0 Step -1
        For x2 = 0 To x - 1
            If Point(x2, y2) <> 254 Then PSet (x2, y2), 18
        Next
    Next
    Get (0, 0)-(x - 1, y - 1), spritedata(freespritedata)
    s(freesprite).index2 = freespritedata
    freespritedata = freespritedata + x * y + 4
    s(freesprite).x = x: s(freesprite).y = y
    s(freesprite).halfx = x \ 2: s(freesprite).halfy = y \ 2
    freesprite = freesprite + 1
Next

Type object
    active As Integer
    x As Integer
    y As Integer
    z As Integer 'height
    mx As Integer
    my As Integer
    sprite As Integer
End Type

'create objects
Dim o(1 To 1000) As object 'all game objects
Dim Shared lastobject As Integer
lastobject = 1000

'create player
i = newobject(o())
o(i).sprite = 1
o(i).z = 50
o(i).active = 20
player = i

MouseHide

'gameloop
Do

    Do: Loop While MouseInput 'read all available mouse messages until current message

    'set player's position
    o(player).x = MouseX: o(player).y = MouseY

    'draw land
    landy = (landy + 1) Mod 56
    For i = -1 To 4
        Put (0, i * 56 + landy), spritedata(s(4).index), Clip PSet, 254
    Next

    'draw enemy shadows
    For i = 1 To lastobject
        If o(i).sprite = 3 Then displayshadow o(i)
    Next

    'draw player's shadow
    displayshadow o(player)

    'draw enemies
    For i = 1 To lastobject
        If o(i).sprite = 3 Then
            disp o(i)
            move o(i)
            If o(i).y - s(o(i).sprite).halfy > 200 Then o(i).y = -1000
        End If
    Next

    'draw bullets
    For i = 1 To lastobject
        If o(i).sprite = 2 Then
            disp o(i)
            move o(i)
            If offscreen(o(i)) Then freeobject o(i)
            xshift = Int(Rnd * 3) - 1
            o(i).mx = o(i).mx + xshift
            o(i).my = o(i).my - 1
        End If
    Next

    'draw player
    disp o(player)

    'draw explosion(s)
    For i = 1 To lastobject
        If o(i).sprite = 5 Then
            For i2 = 1 To o(i).active
                rad = i2 * 5: halfrad = rad \ 2
                dx = Rnd * rad - halfrad: dy = Rnd * rad - halfrad
                displayat o(i).x + dx, o(i).y + dy, o(i)
            Next
            move o(i)
            o(i).active = o(i).active - 1
            If o(i).active = 0 Then freeobject o(i)
        End If
    Next

    'hp bar
    x = 60
    y = 185
    Line (x - 1, y)-Step(20 * 10 + 2, 5), 2, B
    Line (x, y - 1)-Step(20 * 10, 5 + 2), 2, B
    Line (x, y)-Step(20 * 10, 5), 40, BF
    Line (x, y)-Step(o(player).active * 10, 5), 47, BF

    PCopy 1, 0

    'shoot?
    If MouseButton(1) Then
        i = newobject(o())
        o(i).sprite = 2
        o(i).x = o(player).x
        o(i).y = o(player).y - s(o(player).sprite).halfy
        o(i).my = -1
        SndPlayCopy shootsound
    End If

    'bullet->enemy collision
    For i = 1 To lastobject
        If o(i).sprite = 2 Then 'bullet
            For i2 = 1 To lastobject
                If o(i2).sprite = 3 Then 'enemy
                    If collision(o(i), o(i2)) Then
                        SndPlayCopy shootsound
                        i3 = newobject(o())
                        o(i3).sprite = 5
                        o(i3).my = o(i2).my \ 2 + 1
                        If o(i2).active > 1 Then 'hit (small explosion)
                            o(i2).active = o(i2).active - 1
                            o(i3).x = o(i).x
                            o(i3).y = o(i).y
                        Else 'destroyed (large explosion)
                            o(i3).x = o(i2).x
                            o(i3).y = o(i2).y
                            o(i3).active = 15
                            freeobject o(i2) 'enemy
                        End If
                        freeobject o(i) 'bullet
                        Exit For
                    End If 'collision
                End If
            Next
        End If
    Next

    'ship->enemy collision
    i = player
    For i2 = 1 To lastobject
        If o(i2).sprite = 3 Then 'enemy
            If collision(o(i), o(i2)) Then
                o(i).active = o(i).active - 1
                If o(i).active = 0 Then End
                Exit For
            End If 'collision
        End If
    Next

    'add new enemy?
    addenemy = addenemy + 1
    If addenemy = 50 Then
        addenemy = 0
        i = newobject(o())
        o(i).sprite = 3
        o(i).x = Rnd * 320
        o(i).y = Rnd * -1000 - s(o(i).sprite).halfy
        o(i).my = 3 + Rnd * 6
        o(i).z = 25 + o(i).my * 8
        o(i).active = 15 'hp
    End If

    'speed limit main loop to 18.2 frames per second
    Do: nt! = Timer: Loop While nt! = lt!
    lt! = nt!

Loop
'end main loop

Sub move (o As object)
    o.x = o.x + o.mx
    o.y = o.y + o.my
End Sub

Sub disp (o As object)
    Put (o.x - s(o.sprite).halfx, o.y - s(o.sprite).halfy), spritedata(s(o.sprite).index), Clip PSet, 254
End Sub

Sub displayat (x As Integer, y As Integer, o As object)
    Put (x - s(o.sprite).halfx, y - s(o.sprite).halfy), spritedata(s(o.sprite).index), Clip PSet, 254
End Sub


Sub displayshadow (o As object)
    Put (o.x - s(o.sprite).halfx, o.y - s(o.sprite).halfy + o.z), spritedata(s(o.sprite).index2), Clip PSet, 254
End Sub

Function newobject (o() As object)
    For i = 1 To lastobject
        If o(i).active = 0 Then
            o(i).active = 1
            o(i).mx = 0: o(i).my = 0
            o(i).z = 0
            newobject = i
            Exit Function
        End If
    Next
    Screen 0: Print "No more free objects available!": End
End Function

Function offscreen (o As object)
    If o.x + s(o.sprite).halfx < 0 Then offscreen = 1: Exit Function
    If o.x - s(o.sprite).halfx > 319 Then offscreen = 1: Exit Function
    If o.y + s(o.sprite).halfy < 0 Then offscreen = 1: Exit Function
    If o.y - s(o.sprite).halfy > 199 Then offscreen = 1: Exit Function
End Function

Sub freeobject (o As object)
    o.active = 0
    o.sprite = 0
End Sub

Function collision (o1 As object, o2 As object)
    If o1.y + s(o1.sprite).halfy < o2.y - s(o2.sprite).halfy Then Exit Function
    If o2.y + s(o2.sprite).halfy < o1.y - s(o1.sprite).halfy Then Exit Function
    If o1.x + s(o1.sprite).halfx < o2.x - s(o2.sprite).halfx Then Exit Function
    If o2.x + s(o2.sprite).halfx < o1.x - s(o1.sprite).halfx Then Exit Function
    collision = 1
End Function

