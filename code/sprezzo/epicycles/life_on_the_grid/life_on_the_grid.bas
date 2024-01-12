Option _Explicit

Screen _NewImage(800, 800, 32)

_Title "GridLife - Click & Drag"



Dim Shared GridWidth

Dim Shared GridHeight

Dim Shared CellWidth

Dim Shared CellHeight

GridWidth = _Width / 8

GridHeight = _Height / 8

CellWidth = _Width / GridWidth

CellHeight = _Height / GridHeight



Type Vector

    x As Double

    y As Double

    z As Double

End Type



Dim Shared MainGrid(GridWidth, GridHeight) As Vector

Dim Shared AuxiGrid(GridWidth, GridHeight) As Vector

Dim Shared GridVel(GridWidth, GridHeight) As Double



Dim SelectedCelli

Dim SelectedCellj

Do



    Do While _MouseInput

        SelectedCelli = Int(_MouseX / CellWidth)

        SelectedCellj = Int(_MouseY / CellHeight)

        If _MouseButton(1) Then

            MainGrid(SelectedCelli, SelectedCellj).x = 8

            MainGrid(SelectedCelli, SelectedCellj).y = 1

            MainGrid(SelectedCelli, SelectedCellj).z = 6

            GridVel(SelectedCelli, SelectedCellj) = 0

        End If

        If _MouseButton(2) Then

            MainGrid(SelectedCelli, SelectedCellj).x = 0

            MainGrid(SelectedCelli, SelectedCellj).y = 0

            MainGrid(SelectedCelli, SelectedCellj).z = 0

            GridVel(SelectedCelli, SelectedCellj) = 0

        End If

    Loop



    Call UpdateGrid

    Cls

    Call PlotGrid

    _Display

    _Limit 30

Loop



End



Sub UpdateGrid

    Dim i As Integer

    Dim j As Integer

    Dim t As Double

    Dim As Vector a1, a2, a3, a4, a5, a6, a7, a8, a9

    For i = 1 To GridWidth

        For j = 1 To GridHeight

            AuxiGrid(i, j).x = MainGrid(i, j).x

            AuxiGrid(i, j).y = MainGrid(i, j).y

            AuxiGrid(i, j).z = MainGrid(i, j).z

        Next

    Next

    For i = 1 To GridWidth - 1

        For j = 1 To GridHeight - 1

            a1 = AuxiGrid(i - 1, j + 1)

            a2 = AuxiGrid(i, j + 1)

            a3 = AuxiGrid(i + 1, j + 1)

            a4 = AuxiGrid(i - 1, j)

            a5 = AuxiGrid(i, j)

            a6 = AuxiGrid(i + 1, j)

            a7 = AuxiGrid(i - 1, j - 1)

            a8 = AuxiGrid(i, j - 1)

            a9 = AuxiGrid(i + 1, j - 1)



            ' Diffusion

            MainGrid(i, j).x = (1 / 5) * (a2.x + a4.x + a6.x + a8.x + a5.x)



            ' Game of life

            t = a1.y + a2.y + a3.y + a4.y + a6.y + a7.y + a8.y + a9.y

            If (a5.y = 1) Then

                Select Case t

                    Case Is < 2

                        MainGrid(i, j).y = 0

                    Case 2

                        MainGrid(i, j).y = 1

                    Case 3

                        MainGrid(i, j).y = 1

                    Case Is > 3

                        MainGrid(i, j).y = 0

                End Select

            Else

                If (t = 3) Then

                    MainGrid(i, j).y = 1

                End If

            End If



            ' Wave propagation

            Dim alpha

            Dim wp1

            Dim wp2

            alpha = .25

            wp1 = alpha * (a6.z + a4.z) + 2 * (1 - alpha) * a5.z - GridVel(i, j)

            wp2 = alpha * (a2.z + a8.z) + 2 * (1 - alpha) * a5.z - GridVel(i, j)

            MainGrid(i, j).z = (0.98) * (1 / 2) * (wp1 + wp2)

            GridVel(i, j) = AuxiGrid(i, j).z

        Next

    Next

End Sub



Sub PlotGrid

    Dim i As Integer

    Dim j As Integer

    For i = 0 To GridWidth

        For j = 0 To GridHeight

            Line (i * CellWidth, j * CellHeight)-(i * CellWidth + CellWidth, j * CellHeight + CellHeight), _RGB32(255 * MainGrid(i, j).x, 25 + 230 * MainGrid(i, j).y, 255 * Abs(MainGrid(i, j).z)), BF

            Line (i * CellWidth, j * CellHeight)-(i * CellWidth + CellWidth, j * CellHeight + CellHeight), _RGB32(100, 100, 100), B

        Next

    Next

End Sub



