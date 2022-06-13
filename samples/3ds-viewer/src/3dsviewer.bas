'CHDIR ".\samples\n54\big\3dsviewer"

'----sub declarations
'--file stuff
DECLARE SUB ReadChunkInfo (ChunkInfoHolder AS ANY, BytePosition AS LONG)
DECLARE SUB SkipChunk (ChunkInfoHolder AS ANY, BytePosition AS LONG)
DECLARE SUB SearchForChunk (ChunkInfoHolder AS ANY)
DECLARE SUB ReadObject ()
'--3D engine stuff
DECLARE SUB multiplyMatrices (matrixA(), matrixB(), result())
DECLARE SUB getScalingMatrix (sX, sY, sZ, result())
DECLARE SUB getRotationXMatrix (rX, result())
DECLARE SUB getRotationYMatrix (rY, result())
DECLARE SUB getRotationZMatrix (rZ, result())
DECLARE SUB getTranslationMatrix (tX, tY, tZ, result())
DECLARE SUB getCombinedMatrix (sX, sY, sZ, rX, rY, rZ, tX, tY, tZ, temp(), temp2(), result())
DECLARE SUB getNewXYZ (X, Y, Z, combinedMatrix())
DECLARE SUB getScreenXY (X, Y, Z)

'----global declarations
Rem $DYNAMIC
Dim Shared PointsArray(0, 0) As Single
Dim Shared NewPointsArray(0, 0) As Long
Dim Shared FaceArray(0, 0) As Integer
Rem $STATIC
Dim Shared numberVertices As Integer
Dim Shared numberFaces As Integer
Dim Shared CurrentBytePosition As Long
Dim Shared FindChunk$

'----type definitions
Type ChunkInfo
    ID As Integer
    Size As Long
    Position As Long
End Type

'----open file
Cls
Print "Would you like to view car.3ds (y/n)?"
Do
    k$ = InKey$
Loop Until k$ <> ""
If UCase$(k$) = "N" Then
    Input "Please input the file you wish to load:", fileName$
Else
    fileName$ = "car.3ds"
End If
Open fileName$ For Binary As #1

'----initialise variables
sX = 5
sY = 5
sZ = 5
rX = 0
rY = 0
rZ = 0
tX = 0
tY = 0
tZ = 500
currentFrame = 0

'----allocate space for matrix calcs
Dim temp(3, 3)
Dim temp2(3, 3)
Dim result(3, 3)

'----MAIN PROGRAM
Cls
Print "3DS Object Viewer 0.5"
Print "---------------------"
Print "By David Llewellyn"
Print "24/10/2004"
Print ""
Call ReadObject
Print ""
Print "Press any key to continue"
Do
Loop Until InKey$ > Chr$(0)

'3D-Section
Screen 7, , 0, 1
Colour = 4
oldTime = Timer

Do

    Call getCombinedMatrix(sX, sY, sZ, rX, rY, rZ, tX, tY, tZ, temp(), temp2(), result())
    Cls

    For i = 0 To numberVertices 'load screen coordinates into new array
        X = PointsArray(0, i)
        Y = PointsArray(1, i)
        Z = PointsArray(2, i)
        Call getNewXYZ(X, Y, Z, result())
        Call getScreenXY(X, Y, Z)
        NewPointsArray(0, i) = X
        NewPointsArray(1, i) = Y
    Next i 'load screen coordinates into new array

    For i = 0 To numberFaces - 1 'draw faces
        'line from point 0 to 1
        Line (NewPointsArray(0, FaceArray(0, i)), NewPointsArray(1, FaceArray(0, i)))-(NewPointsArray(0, FaceArray(1, i)), NewPointsArray(1, FaceArray(1, i))), Colour
        'line from point 1 to 2
        Line (NewPointsArray(0, FaceArray(1, i)), NewPointsArray(1, FaceArray(1, i)))-(NewPointsArray(0, FaceArray(2, i)), NewPointsArray(1, FaceArray(2, i))), Colour
        'line from point 2 to 0
        Line (NewPointsArray(0, FaceArray(2, i)), NewPointsArray(1, FaceArray(2, i)))-(NewPointsArray(0, FaceArray(0, i)), NewPointsArray(1, FaceArray(0, i))), Colour
    Next i 'draw faces

    PCopy 0, 1
    frames = frames + 1

    A$ = InKey$
    rX = rX + .00065
    rY = rY + .00545
    If A$ = "=" Then tZ = tZ - 5
    If A$ = "-" Then tZ = tZ + 5

Loop Until A$ = Chr$(27)

newTime = Timer
timeTaken = newTime - oldTime
Screen 13
Print Using "##.##"; frames / timeTaken
Print "frames per second"
Do
Loop Until InKey$ > Chr$(0)

System

Sub getCombinedMatrix (sX, sY, sZ, rX, rY, rZ, tX, tY, tZ, temp(), temp2(), result())

    Erase temp2
    Call getScalingMatrix(sX, sY, sZ, result())
    Call getRotationXMatrix(rX, temp())
    Call multiplyMatrices(result(), temp(), temp2()) 'combine with x rotation

    Call getRotationYMatrix(rY, temp())
    Erase result
    Call multiplyMatrices(temp2(), temp(), result()) 'combine with y rotation

    Call getRotationZMatrix(rZ, temp())
    Erase temp2
    Call multiplyMatrices(result(), temp(), temp2()) 'combine with z rotation

    Call getTranslationMatrix(tX, tY, tZ, temp())
    Erase result
    Call multiplyMatrices(temp2(), temp(), result()) 'combine with translation

End Sub

Sub getNewXYZ (X, Y, Z, combinedMatrix())

    newX = (combinedMatrix(0, 0) * X) + (combinedMatrix(0, 1) * Y) + (combinedMatrix(0, 2) * Z) + combinedMatrix(0, 3) 'new X point
    newY = (combinedMatrix(1, 0) * X) + (combinedMatrix(1, 1) * Y) + (combinedMatrix(1, 2) * Z) + combinedMatrix(1, 3) 'new Y point
    newZ = (combinedMatrix(2, 0) * X) + (combinedMatrix(2, 1) * Y) + (combinedMatrix(2, 2) * Z) + combinedMatrix(2, 3) 'new Z point

    X = newX
    Y = newY
    Z = newZ

End Sub

Sub getRotationXMatrix (rX, result())

    result(0, 0) = 1
    result(1, 0) = 0
    result(2, 0) = 0
    result(3, 0) = 0

    result(0, 1) = 0
    result(1, 1) = Cos(rX)
    result(2, 1) = Sin(rX)
    result(3, 1) = 0

    result(0, 2) = 0
    result(1, 2) = -Sin(rX)
    result(2, 2) = Cos(rX)
    result(3, 2) = 0

    result(0, 3) = 0
    result(1, 3) = 0
    result(2, 3) = 0
    result(3, 3) = 1

End Sub

Sub getRotationYMatrix (rY, result())

    result(0, 0) = Cos(rY)
    result(1, 0) = 0
    result(2, 0) = -Sin(rY)
    result(3, 0) = 0

    result(0, 1) = 0
    result(1, 1) = 1
    result(2, 1) = 0
    result(3, 1) = 0

    result(0, 2) = Sin(rY)
    result(1, 2) = 0
    result(2, 2) = Cos(rY)
    result(3, 2) = 0

    result(0, 3) = 0
    result(1, 3) = 0
    result(2, 3) = 0
    result(3, 3) = 1

End Sub

Sub getRotationZMatrix (rZ, result())

    result(0, 0) = Cos(rZ)
    result(1, 0) = Sin(rZ)
    result(2, 0) = 0
    result(3, 0) = 0

    result(0, 1) = -Sin(rZ)
    result(1, 1) = Cos(rZ)
    result(2, 1) = 0
    result(3, 1) = 0

    result(0, 2) = 0
    result(1, 2) = 0
    result(2, 2) = 1
    result(3, 2) = 0

    result(0, 3) = 0
    result(1, 3) = 0
    result(2, 3) = 0
    result(3, 3) = 1

End Sub

Sub getScalingMatrix (sX, sY, sZ, result())

    result(0, 0) = sX
    result(1, 0) = 0
    result(2, 0) = 0
    result(3, 0) = 0

    result(0, 1) = 0
    result(1, 1) = sY
    result(2, 1) = 0
    result(3, 1) = 0

    result(0, 2) = 0
    result(1, 2) = 0
    result(2, 2) = sZ
    result(3, 2) = 0

    result(0, 3) = 0
    result(1, 3) = 0
    result(2, 3) = 0
    result(3, 3) = 1

End Sub

Sub getScreenXY (X, Y, Z)

    If Z = 0 Then
        X = X * 280
        Y = Y * 240
    Else
        X = (X * 280) / Z
        Y = (Y * 240) / Z
    End If

    X = Int(X + 160)
    Y = Int(Y + 100)

End Sub

Sub getTranslationMatrix (tX, tY, tZ, result())

    result(0, 0) = 1
    result(1, 0) = 0
    result(2, 0) = 0
    result(3, 0) = 0

    result(0, 1) = 0
    result(1, 1) = 1
    result(2, 1) = 0
    result(3, 1) = 0

    result(0, 2) = 0
    result(1, 2) = 0
    result(2, 2) = 1
    result(3, 2) = 0

    result(0, 3) = tX
    result(1, 3) = tY
    result(2, 3) = tZ
    result(3, 3) = 1

End Sub

Sub multiplyMatrices (matrixA(), matrixB(), result())

    For i = 0 To 3
        For j = 0 To 3
            For k = 0 To 3
                result(j, i) = result(j, i) + (matrixB(j, k) * matrixA(k, i))
            Next k
        Next j
    Next i

End Sub

Sub ReadChunkInfo (ChunkInfoHolder As ChunkInfo, BytePosition As Long)

    Get #1, BytePosition, ChunkInfoHolder.ID
    Get #1, BytePosition + 2, ChunkInfoHolder.Size
    ChunkInfoHolder.Position = BytePosition

End Sub

Sub ReadObject

    Dim ChunkH As ChunkInfo
    CurrentBytePosition = 1 'start of file
    Call ReadChunkInfo(ChunkH, CurrentBytePosition)
    FindChunk$ = "3D3D"
    Call SearchForChunk(ChunkH) 'CBP should now be 3D3D(EDIT3DS)
    Call ReadChunkInfo(ChunkH, CurrentBytePosition)
    FindChunk$ = "4000"
    Call SearchForChunk(ChunkH) 'CBP should now be 4000(NAMED_OBJECT)
    '\/Read & display object name
    i = 0
    Do
        ObjectName$ = " "
        Get #1, CurrentBytePosition + 6 + i, ObjectName$
        i = i + 1
    Loop Until Asc(ObjectName$) = 0
    ObjectName$ = String$(i - 1, " ")
    Get #1, CurrentBytePosition + 6, ObjectName$
    Print "Object Name: "; ObjectName$
    '/\Read & display object name
    Call ReadChunkInfo(ChunkH, CurrentBytePosition)
    ChunkH.Position = CurrentBytePosition + i 'skip past name area
    ChunkH.Size = ChunkH.Size - i 'skip past name area
    FindChunk$ = "4100"
    Call SearchForChunk(ChunkH) 'CBP should now be 4100(OBJ_MESH)
    Call ReadChunkInfo(ChunkH, CurrentBytePosition)
    Dim BackupBytePosition As Long
    BackupBytePosition = CurrentBytePosition
    FindChunk$ = "4110"
    Call SearchForChunk(ChunkH) 'CBP should now be 4110(MESH_VERTICES)
    '\/Read & display vertices
    'Number of vertices
    CurrentBytePosition = CurrentBytePosition + 6
    Get #1, CurrentBytePosition, numberVertices
    Print "Number of vertices:"; numberVertices
    ReDim PointsArray(2, numberVertices) As Single 'allocate space for 3d points
    ReDim NewPointsArray(1, numberVertices) As Long 'allocate space for screen points
    CurrentBytePosition = CurrentBytePosition + 2
    'Actual vertice data
    Dim vertex As Single
    For i = 0 To numberVertices
        Get #1, CurrentBytePosition, vertex
        'PRINT "X-vertex"; vertex
        PointsArray(0, i) = vertex
        CurrentBytePosition = CurrentBytePosition + 4
        Get #1, CurrentBytePosition, vertex
        'PRINT "Y-vertex"; vertex
        PointsArray(1, i) = vertex
        CurrentBytePosition = CurrentBytePosition + 4
        Get #1, CurrentBytePosition, vertex
        'PRINT "Z-vertex"; vertex
        PointsArray(2, i) = vertex
        CurrentBytePosition = CurrentBytePosition + 4
    Next i
    '/\Read & display vertices
    Call ReadChunkInfo(ChunkH, BackupBytePosition) 'ChunkH should now be 4100(OBJ_MESH)
    FindChunk$ = "4120"
    Call SearchForChunk(ChunkH) 'CBP should now be 4120(MESH_FACES)
    '\/Read & display faces
    'Number of faces
    CurrentBytePosition = CurrentBytePosition + 6
    Get #1, CurrentBytePosition, numberFaces
    Print "Number of faces:"; numberFaces
    ReDim FaceArray(2, numberFaces) As Integer 'allocate space for face points
    CurrentBytePosition = CurrentBytePosition + 2
    'Actual face data
    Dim face As Integer
    For i = 0 To numberFaces
        Get #1, CurrentBytePosition, face
        'PRINT "Face-point 1:"; face
        FaceArray(0, i) = face
        CurrentBytePosition = CurrentBytePosition + 2
        Get #1, CurrentBytePosition, face
        'PRINT "Face-point 2:"; face
        FaceArray(1, i) = face
        CurrentBytePosition = CurrentBytePosition + 2
        Get #1, CurrentBytePosition, face
        'PRINT "Face-point 3:"; face
        FaceArray(2, i) = face
        CurrentBytePosition = CurrentBytePosition + 2
        Get #1, CurrentBytePosition, face
        'PRINT "Face-visibility:"; face
        CurrentBytePosition = CurrentBytePosition + 2
    Next i
    '\/Read & display faces


End Sub

Sub SearchForChunk (ChunkInfoHolder As ChunkInfo)

    Dim InnerBytePosition As Long
    Dim MaxBytePosition As Long
    InnerBytePosition = ChunkInfoHolder.Position + 6
    MaxBytePosition = ChunkInfoHolder.Position + ChunkInfoHolder.Size
    ChunkName$ = Hex$(ChunkInfoHolder.ID)

    Found = 0

    Do

        Call ReadChunkInfo(ChunkInfoHolder, InnerBytePosition)

        If FindChunk$ = Hex$(ChunkInfoHolder.ID) Then
            Found = 1
        Else
            Call SkipChunk(ChunkInfoHolder, InnerBytePosition)
        End If

    Loop Until InnerBytePosition >= MaxBytePosition Or Found = 1 Or InKey$ = Chr$(27) Or ChunkInfoHolder.Size = 0

    If Found = 0 Then
        Print ""
        Print FindChunk$; " was not found within "; ChunkName$; "!"
        Print ""
        System
    Else
        CurrentBytePosition = ChunkInfoHolder.Position
    End If

End Sub

Sub SkipChunk (ChunkInfoHolder As ChunkInfo, BytePosition As Long)

    BytePosition = BytePosition + ChunkInfoHolder.Size

End Sub

