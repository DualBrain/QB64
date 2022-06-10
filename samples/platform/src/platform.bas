Const FALSE = 0, TRUE = Not FALSE

Const objHero = 1
Const objEnemy = 2
Const objFloor = 3
Const objBonus = 4
Const objBackground = 5
Const objBlock = 6

Dim Shared kinds(1 To 6) As String
kinds(1) = "Hero"
kinds(2) = "Enemy"
kinds(3) = "Floor"
kinds(4) = "Bonus"
kinds(5) = "Background"
kinds(6) = "Block"

Const objShapeRect = 0
Const objShapeRound = 1
Const g = 1

Type Objects
    kind As Integer
    shape As Integer
    x As Integer
    xv As Single
    y As Integer
    yv As Single
    w As Integer
    h As Integer
    color As _Unsigned Long
    landedOn As Long
    taken As _Byte
End Type

ReDim Shared Object(1 To 100) As Objects
Dim Shared TotalObjects As Long
Dim Shared Hero As Long, NewObj As Long
Dim Shared Dead As _Byte, CameraX As Long, CameraY As Long
Dim Shared Points As Long

Screen _NewImage(800, 600, 32)
_PrintMode _KeepBackground

Do
    Level = Level + 1
    SetLevel Level

    Do
        ProcessInput
        DoPhysics
        UpdateScreen
        _Limit 35
    Loop
Loop

System

Function AddObject (Kind As Integer, x As Single, y As Single, w As Single, h As Single, c As _Unsigned Long)
    TotalObjects = TotalObjects + 1
    If TotalObjects > UBound(Object) Then
        ReDim _Preserve Object(1 To UBound(Object) + 99) As Objects
    End If

    Object(TotalObjects).kind = Kind

    Object(TotalObjects).x = x
    Object(TotalObjects).y = y
    Object(TotalObjects).w = w
    Object(TotalObjects).h = h
    Object(TotalObjects).color = c

    AddObject = TotalObjects
End Function

Sub ProcessInput
    Static JumpButton As _Byte
    If _KeyDown(19712) And Not Dead Then
        If _KeyDown(100306) Then
            Object(Hero).x = Object(Hero).x + 1
            Do While _KeyDown(19712): Loop
        Else
            If Object(Hero).xv < 0 Then
                Object(Hero).xv = Object(Hero).xv + 2
            Else
                Object(Hero).xv = 4
            End If
        End If
    End If
    If _KeyDown(19200) And Not Dead Then
        If _KeyDown(100306) Then
            Object(Hero).x = Object(Hero).x - 1
            Do While _KeyDown(19200): Loop
        Else
            If Object(Hero).xv > 0 Then
                Object(Hero).xv = Object(Hero).xv - 2
            Else
                Object(Hero).xv = -4
            End If
        End If
    End If
    If _KeyDown(18432) And Not Dead Then
        If Not JumpButton Then
            JumpButton = TRUE
            If Object(Hero).landedOn > 0 Then Object(Hero).yv = -20: Object(Hero).landedOn = 0
        End If
    ElseIf Not _KeyDown(18432) Then
        If JumpButton Then JumpButton = FALSE
    End If
    If _KeyDown(13) And Dead Then
        Dead = 0
        Object(Hero).x = 25
        Object(Hero).y = _Height - _Height / 5 - 22
        Object(Hero).yv = 0
        Object(Hero).xv = 0
        Object(Hero).landedOn = 0
    End If
    If _KeyDown(27) Then System
End Sub

Sub DoPhysics
    For i = 1 To TotalObjects
        If Object(i).kind = objHero Or Object(i).kind = objEnemy Then

            If Object(i).kind = objEnemy Then
                If Object(Hero).x < Object(i).x Then Object(i).xv = -1.5 Else Object(i).xv = 1.5
            End If

            Object(i).x = Object(i).x + Object(i).xv
            Object(i).y = Object(i).y + Object(i).yv

            If Object(i).landedOn = 0 Then
                Object(i).yv = Object(i).yv + g
            End If

            For j = 1 To TotalObjects

                If Object(i).yv < 0 Then
                    If Object(j).kind = objBlock Then
                        If Object(i).x + Object(i).w > Object(j).x And Object(i).x < Object(j).x + Object(j).w Then
                            If Object(i).y > Object(j).y And Object(i).y < Object(j).y + Object(j).h + 1 Then
                                Object(i).yv = 2
                                Object(i).y = Object(i).y + 2
                                If Object(j).taken = FALSE Then
                                    Object(j).taken = TRUE
                                    Object(j).color = _RGB32(122, 100, 78)
                                End If
                                Exit For
                            End If
                        End If
                    End If
                End If

                If Object(i).kind = objHero And Object(j).kind = objBonus And Object(j).taken = FALSE Then
                    If Object(i).y + Object(i).h >= Object(j).y And Object(i).y <= Object(j).y + Object(j).h Then
                        If Object(i).x + Object(i).w > Object(j).x And Object(i).x < Object(j).x + Object(j).w Then
                            Object(j).taken = TRUE
                            Points = Points + 10
                            Exit For
                        End If
                    End If
                End If

                If Object(i).xv > 0 Then
                    If Object(j).kind = objBlock Or Object(j).kind = objEnemy Then
                        If Object(i).y + Object(i).h >= Object(j).y And Object(i).y <= Object(j).y + Object(j).h Then
                            If Object(i).x + Object(i).w > Object(j).x And Object(i).x < Object(j).x + Object(j).w Then
                                Object(i).x = Object(j).x - Object(i).w - 1
                                Object(i).xv = 0
                                If Object(i).kind = objHero And Object(j).kind = objEnemy And Object(j).taken = FALSE Then Dead = TRUE: Object(j).taken = TRUE
                                Exit For
                            End If
                        End If
                    End If
                ElseIf Object(i).xv < 0 Then
                    If Object(j).kind = objBlock Then
                        If Object(i).y + Object(i).h >= Object(j).y And Object(i).y <= Object(j).y + Object(j).h Then
                            If Object(i).x + Object(i).w > Object(j).x And Object(i).x < Object(j).x + Object(j).w Then
                                Object(i).x = Object(j).x + Object(j).w + 1
                                Object(i).xv = 0
                                If Object(i).kind = objHero And Object(j).kind = objEnemy And Object(j).taken = FALSE Then Dead = TRUE: Object(j).taken = TRUE
                                Exit For
                            End If
                        End If
                    End If
                End If

                If Object(i).yv >= 0 Then
                    If Object(j).kind = objFloor Or Object(j).kind = objBlock Then
                        If Object(i).x + Object(i).w >= Object(j).x And Object(i).x <= Object(j).x + Object(j).w Then
                            If Object(i).y + Object(i).h > Object(j).y And Object(i).y < Object(j).y + Object(j).h Then
                                Object(i).y = Object(j).y - Object(i).h - 1
                                Object(i).yv = 0
                                Object(i).landedOn = j
                                Exit For
                            End If
                        Else
                            If Object(i).landedOn = j Then
                                Object(i).landedOn = 0
                                Exit For
                            End If
                        End If
                    End If
                End If
            Next

            If Object(Hero).y > _Height Then Dead = TRUE

            If Object(i).xv > 0 Then Object(i).xv = Object(i).xv - 1
            If Object(i).xv < 0 Then Object(i).xv = Object(i).xv + 1
            If Object(i).yv <> 0 Then Object(i).yv = Object(i).yv + g
        End If
    Next

    If Object(Hero).x + CameraX > _Width / 2 Then
        CameraX = _Width / 2 - Object(Hero).x
    ElseIf Object(Hero).x + CameraX < _Width / 5 Then
        CameraX = _Width / 5 - Object(Hero).x
    End If

    If Object(Hero).y + CameraY < _Height / 3 Then
        CameraY = -Object(Hero).y + _Height / 3
    ElseIf Object(Hero).y + CameraY > _Height / 2 Then
        CameraY = _Height / 2 - Object(Hero).y
    End If

    If CameraX > 0 Then CameraX = 0
    If CameraY < 0 Then CameraY = 0
End Sub

Sub UpdateScreen
    Cls

    Dim this As Objects

    For i = 1 To TotalObjects
        this = Object(i)
        If this.kind > 0 Then
            If this.kind = objBackground Then
                thisCameraX = CameraX / 2
                thisCameraY = CameraY / 2
            Else
                thisCameraX = CameraX
                thisCameraY = CameraY
            End If
            If (this.kind = objEnemy Or this.kind = objBonus) And this.taken Then GoTo Continue
            If this.x + this.w + thisCameraX < 0 And this.shape <> objShapeRound Then
                GoTo Continue
            ElseIf thisCameraX + this.x + this.w + this.w / 2 < 0 And this.shape = objShapeRound Then
                GoTo Continue
            End If
            If this.x + thisCameraX > _Width Then GoTo Continue
            If this.shape = objShapeRect Then
                Line (this.x + thisCameraX, this.y + thisCameraY)-Step(this.w, this.h), this.color, BF
                Line (this.x + thisCameraX, this.y + thisCameraY)-Step(this.w, this.h), _RGB32(0, 0, 0), B
                '_PRINTSTRING (this.x + CameraX, this.y), LTRIM$(STR$(this.x)) + STR$(this.x + this.w)
            ElseIf this.shape = objShapeRound Then
                For k = 1 To this.w
                    Circle (thisCameraX + this.x + this.w / 2, thisCameraY + this.y + this.h / 2), k, this.color, , , this.w / this.h
                Next
                Circle (thisCameraX + this.x + this.w / 2, thisCameraY + this.y + this.h / 2), this.w, _RGB32(0, 0, 0), , , this.w / this.h
            End If
            'IF this.kind = objHero AND this.landedOn > 0 THEN _PRINTSTRING (this.x + CameraX, this.y - _FONTHEIGHT), "Landed on" + STR$(this.landedOn)
            Print i; kinds(this.kind)
        End If
        Continue:
    Next

    Print "CameraX"; CameraX
    Print "CameraY"; CameraY

    If Dead Then
        _PrintString (_Width / 2 - _PrintWidth("You're dead!") / 2, _Height / 2 - _FontHeight), "You're dead!"
        _PrintString (_Width / 2 - _PrintWidth("(hit ENTER)") / 2, _Height / 2 + _FontHeight), "(hit ENTER)"
    End If

    If Points > 0 Then _PrintString (0, 0), Str$(Points)

    _Display
End Sub

Sub SetLevel (__Level As Integer)
    Dim Level As Integer, MaxLevels As Integer

    MaxLevels = 1

    If __Level > MaxLevels Then
        Level = _Ceil(Rnd * MaxLevels)
    Else
        Level = __Level
    End If

    Select Case Level
        Case 1
            NewObj = AddObject(objBackground, 0, 0, _Width * 2, _Height, _RGB32(61, 161, 222))

            For i = 1 To 10
                NewObj = AddObject(objBackground, Rnd * _Width * 2, Rnd * -_Height, 50, 100, _RGB32(255, 255, 255))
                Object(NewObj).shape = objShapeRound
            Next

            NewObj = AddObject(objFloor, 20, _Height - _Height / 5, _Width * 1.5, 150, _RGB32(111, 89, 50))
            NewObj = AddObject(objFloor, 1300, _Height - _Height / 5, _Width * 1.5, 150, _RGB32(111, 89, 50))

            NewObj = AddObject(objFloor, 110, 400, 110, 10, _RGB32(111, 89, 50))

            NewObj = AddObject(objFloor, 400, 400, 110, 10, _RGB32(111, 89, 50))
            NewObj = AddObject(objFloor, 575, 330, 110, 10, _RGB32(111, 89, 50))
            NewObj = AddObject(objFloor, 700, 260, 110, 10, _RGB32(111, 89, 50))
            NewObj = AddObject(objFloor, 875, 200, 110, 10, _RGB32(111, 89, 50))
            NewObj = AddObject(objFloor, 1000, 140, 110, 10, _RGB32(111, 89, 50))
            NewObj = AddObject(objFloor, 1175, 70, 110, 10, _RGB32(111, 89, 50))
            NewObj = AddObject(objFloor, 1000, 10, 110, 10, _RGB32(111, 89, 50))
            NewObj = AddObject(objFloor, 875, -50, 110, 10, _RGB32(111, 89, 50))
            NewObj = AddObject(objFloor, 700, -110, 110, 10, _RGB32(111, 89, 50))

            NewObj = AddObject(objBlock, 20, 400, 25, 25, _RGB32(216, 166, 50))

            NewObj = AddObject(objBlock, 200, _Height - _Height / 5 - 16, 15, 15, _RGB32(216, 166, 50))
            NewObj = AddObject(objBlock, 216, _Height - _Height / 5 - 16, 15, 15, _RGB32(216, 166, 50))
            NewObj = AddObject(objBlock, 232, _Height - _Height / 5 - 16, 15, 15, _RGB32(216, 166, 50))
            NewObj = AddObject(objBlock, 216, _Height - _Height / 5 - 32, 15, 15, _RGB32(216, 166, 50))
            NewObj = AddObject(objBlock, 232, _Height - _Height / 5 - 32, 15, 15, _RGB32(216, 166, 50))
            NewObj = AddObject(objBlock, 232, _Height - _Height / 5 - 48, 15, 15, _RGB32(216, 166, 50))

            NewObj = AddObject(objBonus, 800, 270, 15, 10, _RGB32(249, 244, 55))
            Object(NewObj).shape = objShapeRound

            NewObj = AddObject(objBonus, 820, 320, 15, 10, _RGB32(249, 244, 55))
            Object(NewObj).shape = objShapeRound

            NewObj = AddObject(objBonus, 1200, _Height - _Height / 5 - 22, 15, 10, _RGB32(249, 244, 55))
            Object(NewObj).shape = objShapeRound

            NewObj = AddObject(objEnemy, 1200, _Height - _Height / 5 - 22, 15, 10, _RGB32(150, 89, 238))

            Hero = AddObject(objHero, 25, _Height - _Height / 5 - 22, 10, 20, _RGB32(127, 244, 127))
    End Select
End Sub

