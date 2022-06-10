Option _Explicit

Const FALSE = 0, TRUE = Not false

Screen _NewImage(800, 450, 32)

Type newLevel
    As _Unsigned Long landColor, grassColor, waterColor
    As Long symbolSpacingX, symbolSpacingY
End Type

Type object
    As Long id, w, h, img
    As Single x, xv, y, yv
    As _Byte imgPointer, standing, alive
    As _Unsigned Long color
End Type

Const idPlatform = 1
Const idGoal = 2
Const idAirJump = 3
Const idInfiniteJumps = 4
Const idSpike = 5
Const idCloud = 6
Const idScene = 7
Const idSky = 8
Const idWater = 9

Dim Shared As Long thisLevel, arenaWidth, i, totalObjects, airJumps, hero, goal
Dim Shared As Single x, y, camera, gravity
Dim Shared As _Byte drowned, restartRequested, shadowCast
Dim Shared As String platformDecoration, goalGlyph, airJumpGlyph
Dim Shared As newLevel levelData
Dim Shared As object obj(100), shadowCastOn

Randomize Timer

goalGlyph = "C" + Str$(_RGB32(255, 255, 255)) + "e10f10g10 h8e8f6g6 h4 e4f2g1"
airJumpGlyph = "C" + Str$(_RGB32(255, 255, 255)) + "e10f10g10h10"
gravity = .8
thisLevel = 1

Restart:
setLevel thisLevel

Do
    processInput
    doPhysics
    adjustCamera
    drawObjects
    If restartRequested Then restartRequested = FALSE: GoTo Restart
    If Not drowned Then drawHero
    checkVictory

    If Not obj(hero).alive Then
        _PrintString (0, 0), "Dead"
        _PrintString (0, 20), Str$((obj(hero).x / arenaWidth) * 100) + "%"
    ElseIf obj(hero).standing Then
        _PrintString (0, 0), "Standing"
    End If

    _Display
    _Limit 60
Loop

Sub addWater
    Dim this As Long
    this = newObject
    obj(this).id = idWater
    obj(this).img = _NewImage(_Width, _Height, 32)
    _Dest obj(this).img
    Line (0, _Height - _Height / 4)-Step(_Width, _Height / 4), darken(levelData.waterColor, 55), BF
    Line (0, _Height - _Height / 4)-Step(_Width, _Height / 7), darken(levelData.waterColor, 70), BF
    Line (0, _Height - _Height / 4)-Step(_Width, _Height / 9), darken(levelData.waterColor, 85), BF
    Line (0, _Height - _Height / 4)-Step(_Width, _Height / 11), levelData.waterColor, BF
    _Dest 0
End Sub

Sub drawObjects
    For i = 1 To totalObjects
        Select Case obj(i).id
            Case idPlatform
                _PutImage (obj(i).x + camera, obj(i).y), obj(i).img
            Case idGoal
                Draw "bm" + Str$(obj(goal).x + camera) + "," + Str$(obj(goal).y + obj(goal).h / 2)
                Draw goalGlyph
            Case idAirJump
                Draw "bm" + Str$(obj(i).x + camera) + "," + Str$(obj(i).y + obj(i).h / 2)
                Draw airJumpGlyph
            Case idCloud
                obj(i).x = obj(i).x - obj(i).xv
                If obj(i).x + obj(i).w < 0 Then obj(i).x = arenaWidth
                Line (obj(i).x + camera / 2.5, obj(i).y)-Step(obj(i).w, obj(i).h), _RGBA32(255, 255, 255, 30), BF
            Case idScene
                _PutImage (obj(i).x + camera / obj(i).xv, obj(i).y), obj(i).img
            Case idSky
                Line (0, 0)-(_Width, _Height), obj(i).color, BF
            Case idWater
                _PutImage , obj(i).img
        End Select
    Next
End Sub

Sub processInput
    Dim button As _Byte

    If _KeyHit = 27 Then
        obj(hero).alive = TRUE
        obj(hero).yv = 0
        restartRequested = TRUE
        Exit Sub
    End If

    If obj(hero).alive = FALSE Then Exit Sub

    'keep hero moving forward
    If obj(hero).x + obj(hero).w < arenaWidth + _Width Then obj(hero).x = obj(hero).x + 5

    'If _KeyDown(19712) Then 'character goes left, screen goes right
    '    obj(hero).x = obj(hero).x + 5
    'End If

    'If _KeyDown(19200) Then 'character goes right, screen goes left
    '    obj(hero).x = obj(hero).x - 5
    'End If

    Static lastJump!, jumpKeyDown As _Byte
    Const jumpFactor = 3

    While _MouseInput: Wend
    button = _MouseButton(1) Or _KeyDown(32)

    If button Then '18432
        If jumpKeyDown = FALSE And (obj(hero).standing = TRUE Or airJumps > 0) Then
            If airJumps > 0 Then airJumps = airJumps - 1
            jumpKeyDown = TRUE
            obj(hero).standing = FALSE
            lastJump! = 0
            obj(hero).yv = obj(hero).yv - gravity * jumpFactor
        Else
            lastJump! = lastJump! + 1
            If lastJump! < 7 Then
                obj(hero).yv = obj(hero).yv - gravity * jumpFactor
            End If
        End If
    Else
        jumpKeyDown = FALSE
    End If
End Sub

Sub adjustCamera
    camera = _Width / 4 - obj(hero).x
    If camera > 0 Then camera = 0
    If camera < -arenaWidth Then camera = -arenaWidth
End Sub

Sub drawHero
    Dim shadow As object
    Line (obj(hero).x + camera, obj(hero).y)-Step(obj(hero).w, obj(hero).h), obj(hero).color, BF

    If obj(hero).alive Then
        If shadowCast Then
            'shadow already cast on a platform
            shadow.x = (obj(hero).x + 1) + camera
            shadow.y = shadowCastOn.y + 5
            shadow.w = obj(hero).w - 2
            Do While shadow.x < shadowCastOn.x + camera
                shadow.x = shadow.x + 1
                shadow.w = shadow.w - 1
            Loop
            Do While shadow.x + shadow.w > shadowCastOn.x + shadowCastOn.w + camera
                shadow.w = shadow.w - 1
            Loop
            Line (shadow.x, shadow.y)-Step(shadow.w, 2), _RGBA32(0, 0, 0, 30), BF
        Else
            'cast shadow on water
            Line ((obj(hero).x + 1) + camera, _Height - _Height / 4 + _Height / 22)-Step(obj(hero).w - 2, 2), _RGBA32(0, 0, 0, 30), BF
        End If
    End If
End Sub

Sub doPhysics
    Dim j As Long

    If Not obj(hero).alive Then Exit Sub

    Const gravityCap = 15

    obj(hero).standing = FALSE
    drowned = FALSE
    If obj(hero).y + obj(hero).yv + gravity > _Height - _Height / 4 + _Height / 22 Then drowned = TRUE: obj(hero).alive = FALSE: Exit Sub

    shadowCast = FALSE
    For j = 1 To totalObjects
        If obj(j).id = idPlatform Then
            If obj(hero).x + obj(hero).w > obj(j).x And obj(hero).x < obj(j).x + obj(j).w Then
                shadowCast = TRUE
                shadowCastOn = obj(j)

                If obj(hero).y + obj(hero).yv + gravity < obj(j).y - (obj(hero).h - 5) Then
                    Exit For
                ElseIf obj(hero).y + obj(hero).yv + gravity <= obj(j).y - (obj(hero).h - 20) Then
                    obj(hero).standing = TRUE
                    obj(hero).y = obj(j).y - (obj(hero).h - 5)
                    Exit For
                ElseIf obj(hero).y >= obj(j).y - (obj(hero).h - 20) Then
                    obj(hero).alive = FALSE
                    Exit For
                End If
            End If
        End If
    Next

    If Not obj(hero).standing Then
        obj(hero).yv = obj(hero).yv + gravity
        If obj(hero).yv > gravityCap Then obj(hero).yv = gravityCap
        obj(hero).y = obj(hero).y + obj(hero).yv
        obj(hero).color = _RGB32(255, 255, 255)
    Else
        obj(hero).yv = 0
        obj(hero).color = _RGB32(200, 200, 200)
    End If
End Sub

Function hit%% (obj1 As object, obj2 As object)
    hit%% = obj1.x + obj1.w > obj2.x And obj1.x <= obj2.x + obj2.w And obj1.y + obj1.h > obj2.y And obj1.y < obj2.y + obj2.h
End Function

Function darken~& (WhichColor~&, ByHowMuch%)
    darken~& = _RGB32(_Red32(WhichColor~&) * (ByHowMuch% / 100), _Green32(WhichColor~&) * (ByHowMuch% / 100), _Blue32(WhichColor~&) * (ByHowMuch% / 100))
End Function


Sub setLevel (level As Long)
    'the order of creation of objects is also the draw order

    Dim totalPlatforms As Long
    Dim this As Long, firstPlatform As Long

    resetObjects
    Select Case level
        Case 1
            arenaWidth = 3200
            totalPlatforms = 30
            levelData.landColor = _RGB32(194, 127, 67)
            levelData.waterColor = _RGB32(33, 166, 188)
            levelData.grassColor = _RGB32(83, 161, 72)

            this = newObject
            obj(this).id = idSky
            obj(this).color = _RGB32(67, 200, 205)

            addScene level

            addWater

            addClouds 5

            platformDecoration = "c" + Str$(_RGB32(166, 111, 67)) + " bd5 e10r1g10r1e10r1g10r1e10r1g10r1e10r1g10"
            levelData.symbolSpacingX = 11
            levelData.symbolSpacingY = 11
            For i = 1 To totalPlatforms
                this = newObject
                obj(this).id = idPlatform
                obj(this).w = Rnd * 200 + 100
                obj(this).w = obj(this).w - (obj(this).w Mod 20)
                If i = 1 Then
                    firstPlatform = this
                    obj(this).h = 200
                    obj(this).x = Rnd * (arenaWidth / totalPlatforms)
                Else
                    obj(this).h = Rnd * 50 + 50
                    obj(this).x = obj(this - 1).x + obj(this - 1).w + (Rnd * (arenaWidth / (totalPlatforms * 1.5)))
                End If
                obj(this).y = (_Height - _Height / 4 + (_Height / 20)) - obj(this).h
                drawPlatform obj(this)
            Next

            goal = newObject
            obj(goal).id = idGoal
            obj(goal).x = arenaWidth
            obj(goal).y = _Height / 2
            obj(goal).h = 20
            obj(goal).w = 20

            hero = newObject
            obj(hero).x = obj(firstPlatform).x
            obj(hero).y = obj(firstPlatform).y - 25
            obj(hero).w = 15
            obj(hero).h = 30
            obj(hero).alive = TRUE
            obj(hero).standing = TRUE
    End Select
End Sub

Function newObject&
    totalObjects = totalObjects + 1
    If totalObjects > UBound(obj) Then
        ReDim _Preserve obj(totalObjects + 99) As object
    End If
    newObject& = totalObjects
End Function

Sub resetObjects
    Dim emptyObject As object
    For i = 1 To UBound(obj)
        If obj(i).img < -1 And obj(i).imgPointer = FALSE Then _FreeImage obj(i).img
        obj(i) = emptyObject
    Next
    totalObjects = 0
End Sub

Sub drawPlatform (this As object)
    this.img = _NewImage(this.w, this.h, 32)
    _Dest this.img
    Line (0, 10)-Step(this.w - 1, this.h - 1), levelData.landColor, BF
    For x = -10 To this.w Step levelData.symbolSpacingX
        For y = 15 To this.h + 10 Step levelData.symbolSpacingY
            PSet (x, y), 0
            Draw platformDecoration
        Next
    Next
    Line (0, 0)-Step(this.w - 1, 20), levelData.grassColor, BF
    Line (0, 0)-Step(this.w - 1, 10), _RGBA32(255, 255, 255, 30), BF
    Line (0, 10)-Step(5, this.h), _RGBA32(255, 255, 255, 30), BF
    Line (this.w - 6, 10)-Step(5, this.h), _RGBA32(0, 0, 0, 30), BF

    Line (0, 5)-(5, 0), _RGB32(255, 0, 255)
    Paint (0, 0), _RGB32(255, 0, 255), _RGB32(255, 0, 255)
    Line (_Width - 1, 5)-(_Width - 6, 0), _RGB32(255, 0, 255)
    Paint (_Width - 1, 0), _RGB32(255, 0, 255), _RGB32(255, 0, 255)
    Line (0, this.h - 4)-Step(this.w, 3), _RGB32(255, 0, 255), BF
    _ClearColor _RGB32(255, 0, 255)
    Line (0, this.h - 5)-Step(this.w - 1, 5), _RGBA32(0, 0, 0, 30), BF
    _Dest 0
End Sub

Sub addClouds (max As Long)
    Dim this As Long

    For i = 1 To max
        this = newObject
        obj(this).id = idCloud
        obj(this).x = Rnd * arenaWidth
        obj(this).y = Rnd * (_Height / 2)
        obj(this).h = 30
        obj(this).w = arenaWidth / max
        obj(this).xv = Rnd
    Next
End Sub

Sub addScene (level As Long)
    Dim this As Long, firstItem As Long

    Select Case level
        Case 1
            'green mountains, 2 layers

            'farther range
            For i = 1 To 20
                this = newObject
                If i = 1 Then
                    firstItem = this
                    obj(this).img = _NewImage(_Width, _Height, 32)
                    _Dest obj(this).img
                    Line (0, _Height - 1)-(_Width / 2, 0), _RGB32(100, 150, 122)
                    Line -(_Width - 1, _Height - 1), _RGB32(100, 150, 122)
                    Line -(0, _Height - 1), _RGB32(100, 150, 122)
                    Paint (_Width / 2, _Height / 2), _RGB32(100, 150, 122), _RGB32(100, 150, 122)
                    _Dest 0
                Else
                    obj(this).img = obj(firstItem).img
                    obj(this).imgPointer = TRUE
                End If

                obj(this).id = idScene
                obj(this).x = Rnd * arenaWidth
                obj(this).y = Rnd * (_Height / 2)
                obj(this).xv = 2.5
            Next

            'closer range
            For i = 1 To 20
                this = newObject
                If i = 1 Then
                    firstItem = this
                    obj(this).img = _NewImage(_Width, _Height, 32)
                    _Dest obj(this).img
                    Line (0, _Height - 1)-(_Width / 2, 0), _RGB32(78, 111, 67)
                    Line -(_Width - 1, _Height - 1), _RGB32(78, 111, 67)
                    Line -(0, _Height - 1), _RGB32(78, 111, 67)
                    Paint (_Width / 2, _Height / 2), _RGB32(78, 111, 67), _RGB32(78, 111, 67)
                    _Dest 0
                Else
                    obj(this).img = obj(firstItem).img
                    obj(this).imgPointer = TRUE
                End If

                obj(this).id = idScene
                obj(this).x = Rnd * arenaWidth
                obj(this).y = Rnd * (_Height / 2)
                obj(this).xv = 2
            Next
    End Select
End Sub

Sub checkVictory
    If hit(obj(hero), obj(goal)) Then _AutoDisplay: _PrintString (_Width / 2 - _PrintWidth("Level complete!") / 2, _Height / 2 - _FontHeight / 2), "Level complete!": restartRequested = TRUE: Sleep
End Sub

