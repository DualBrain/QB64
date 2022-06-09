'----------------------------------------------------------------------------
'RIPPLES, by Antoni Gual 26/1/2001   agual@eic.ictnet.es
'Simulates water reflection in a SCREEN 13 image
'----------------------------------------------------------------------------
'Who said QBasic is obsolete?
'This is a remake of the popular LAKE Java applet.
'You can experiment with different images and different values of the
'parameters passed to RIPPLES sub.
'----------------------------------------------------------------------------
'PCX Loader modified from Kurt Kuzba.
'Timber Wolf came with PaintShopPro 5, I rescaned it to fit SCREEN13
'----------------------------------------------------------------------------
'WARNING!: PCX MUST be 256 colors and 320x 200.The loader does'nt check it!!
'----------------------------------------------------------------------------
'Use as you want, only give me credit.
'E-mail me to tell me about!
'----------------------------------------------------------------------------
$NoPrefix
DefLng A-Z
Option Explicit
Option ExplicitArray

$Resize:Smooth
Screen 13
FullScreen SquarePixels , Smooth

Const FALSE = 0, TRUE = Not FALSE

If Not LoadPCX("twolf.pcx") Then
    Print "File twolf.pcx not Found!"
    End
End If

ripples 150, .1, 2, 1

System 0

'LOADS A 320x200x256 PCX. Modified from Kurt Kuzba
Function LoadPCX%% (PCX$)
    Dim As Long bseg, f, fin, t, BOFS, RLE, fpos, l, pn, dat
    Dim As String p
    Dim done As Byte

    LoadPCX = FALSE
    bseg& = &HA000

    f = FreeFile
    Open PCX$ For Binary As #f
    If LOF(f) = 0 Then
        Close #f
        Kill PCX$
        Exit Function
    End If

    fin& = LOF(1) - 767: Seek #f, fin&
    p$ = Input$(768, 1)
    'p% = 1
    fin& = fin& - 1
    Out &H3C8, 0: Def Seg = VarSeg(p$)

    For t& = SAdd(p$) To SAdd(p$) + 767
        Out &H3C9, Peek(t&) \ 4
    Next

    Seek #f, 129
    t& = BOFS&
    RLE = 0
    Do
        p$ = Input$(256, f)
        fpos& = Seek(f)
        l = Len(p$)
        If fpos& > fin& Then
            l = l - (fpos& - fin&)
            done = TRUE
        End If
        For pn = SAdd(p$) To SAdd(p$) + l - 1
            Def Seg = VarSeg(p$)
            dat = Peek(pn)
            Def Seg = bseg&
            If RLE Then
                For RLE = RLE To 1 Step -1:
                    Poke t&, dat: t& = t& + 1
                Next
            Else
                If (dat And 192) = 192 Then
                    RLE = dat And 63
                Else
                    Poke t&, dat
                    t& = t& + 1
                End If
            End If
        Next
    Loop Until done
    Close f

    LoadPCX = TRUE
End Function

'----------------------------------------------------------------------------
'Ripples SUB, by Antoni Gual  26/1/2001   agual@eic.ictnet.es
'Simulates water reflection in a SCREEN 13 image
'----------------------------------------------------------------------------
'PARAMETERS:
'waterheight     in pixels from top
'dlay!           delay between two recalcs in seconds
'amplitude!      amplitude of the distortion in pixels
'wavelength!     distance between two ripples
'----------------------------------------------------------------------------
Sub ripples (waterheight, dlay!, amplitude!, wavelength!)
    Dim As Long widh, hght
    Dim As Single i, j, temp

    'these are screen size constants, don't touch it!
    widh = 319
    hght = 199

    ReDim a%(162)
    Dim r(0 To 200) As Integer

    'precalc a sinus table for speed
    For i! = 0 To 200
        r(i!) = CInt(Sin(i! / wavelength!) * amplitude!)
    Next
    j = 0

    'the loop!
    Do
        'it must be slowed down to look real!
        Delay dlay!

        For i = 1 To hght - waterheight
            temp = waterheight - i + r((j + i) Mod 200)
            Get (1, temp)-(widh, temp), a%()
            Put (1, waterheight + i), a%(), PSet
        Next
        If j = 200 Then j = 0 Else j = j + 1
    Loop Until Len(InKey$)
End Sub

