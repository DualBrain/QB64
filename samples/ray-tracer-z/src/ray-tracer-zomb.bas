'> Merged with Zom-B's smart $include merger 0.51

' Best viewed with 120 or more columns

DefDbl A-Z
Option Base 1

'####################################################################################################################
'# Math Library V1.0 (include)
'# By Zom-B
'####################################################################################################################

Const sqrt2 = 1.41421356237309504880168872420969807856967187537695 ' Knuth01
Const sqrt3 = 1.73205080756887729352744634150587236694280525381038 ' Knuth02
Const sqrt5 = 2.23606797749978969640917366873127623544061835961153 ' Knuth03
Const sqrt10 = 3.16227766016837933199889354443271853371955513932522 ' Knuth04
Const cubert2 = 1.25992104989487316476721060727822835057025146470151 ' Knuth05
Const cubert3 = 1.44224957030740838232163831078010958839186925349935 ' Knuth06
Const q2pow025 = 1.18920711500272106671749997056047591529297209246382 ' Knuth07
Const phi = 1.61803398874989484820458683436563811772030917980576 ' Knuth08
Const log2 = 0.69314718055994530941723212145817656807550013436026 ' Knuth09
Const log3 = 1.09861228866810969139524523692252570464749055782275 ' Knuth10
Const log10 = 2.30258509299404568401799145468436420760110148862877 ' Knuth11
Const logpi = 1.14472988584940017414342735135305871164729481291531 ' Knuth12
Const logphi = 0.48121182505960344749775891342436842313518433438566 ' Knuth13
Const q1log2 = 1.44269504088896340735992468100189213742664595415299 ' Knuth14
Const q1log10 = 0.43429448190325182765112891891660508229439700580367 ' Knuth15
Const q1logphi = 2.07808692123502753760132260611779576774219226778328 ' Knuth16
Const pi = 3.14159265358979323846264338327950288419716939937511 ' Knuth17
Const deg2rad = 0.01745329251994329576923690768488612713442871888542 ' Knuth18
Const q1pi = 0.31830988618379067153776752674502872406891929148091 ' Knuth19
Const pisqr = 9.86960440108935861883449099987615113531369940724079 ' Knuth20
Const gamma05 = 1.7724538509055160272981674833411451827975494561224 '  Knuth21
Const gamma033 = 2.6789385347077476336556929409746776441286893779573 '  Knuth22
Const gamma067 = 1.3541179394264004169452880281545137855193272660568 '  Knuth23
Const e = 2.71828182845904523536028747135266249775724709369996 ' Knuth24
Const q1e = 0.36787944117144232159552377016146086744581113103177 ' Knuth25
Const esqr = 7.38905609893065022723042746057500781318031557055185 ' Knuth26
Const eulergamma = 0.57721566490153286060651209008240243104215933593992 ' Knuth27
Const expeulergamma = 1.7810724179901979852365041031071795491696452143034 '  Knuth28
Const exppi025 = 2.19328005073801545655976965927873822346163764199427 ' Knuth29
Const sin1 = 0.84147098480789650665250232163029899962256306079837 ' Knuth30
Const cos1 = 0.54030230586813971740093660744297660373231042061792 ' Knuth31
Const zeta3 = 1.2020569031595942853997381615114499907649862923405 '  Knuth32
Const nloglog2 = 0.36651292058166432701243915823266946945426344783711 ' Knuth33

Const logr10 = 0.43429448190325182765112891891660508229439700580367
Const logr2 = 1.44269504088896340735992468100189213742664595415299
Const pi05 = 1.57079632679489661923132169163975144209858469968755
Const pi2 = 6.28318530717958647692528676655900576839433879875021
Const q05log10 = 0.21714724095162591382556445945830254114719850290183
Const q05log2 = 0.72134752044448170367996234050094606871332297707649
Const q05pi = 0.15915494309189533576888376337251436203445964574046
Const q13 = 0.33333333333333333333333333333333333333333333333333
Const q16 = 0.16666666666666666666666666666666666666666666666667
Const q2pi = 0.63661977236758134307553505349005744813783858296183
Const q2sqrt5 = 0.89442719099991587856366946749251049417624734384461
Const rad2deg = 57.2957795130823208767981548141051703324054724665643
Const sqrt02 = 0.44721359549995793928183473374625524708812367192231
Const sqrt05 = 0.70710678118654752440084436210484903928483593768847
Const sqrt075 = 0.86602540378443864676372317075293618347140262690519
Const y2q112 = 1.05946309435929526456182529494634170077920431749419 ' Chromatic base

'####################################################################################################################
'# Vector math library v0.1 (include part)
'# By Zom-B
'####################################################################################################################

Type VECTOR
    x As Double
    y As Double
    z As Double
End Type

'####################################################################################################################
'# Screen mode selector v1.0 (include)
'# By Zom-B
'####################################################################################################################

videoaspect:
Data "all aspect",15
Data "4:3",11
Data "16:10",10
Data "16:9",14
Data "5:4",13
Data "3:2",12
Data "5:3",9
Data "1:1",7
Data "other",8
Data ,

videomodes:
Data 256,256,7
Data 320,240,1
Data 400,300,1
Data 512,384,1
Data 512,512,7
Data 640,480,1
Data 720,540,1
Data 768,576,1
Data 800,480,2
Data 800,600,1
Data 854,480,3
Data 1024,600,8
Data 1024,640,2
Data 1024,768,1
Data 1024,1024,7
Data 1152,768,5
Data 1152,864,1
Data 1280,720,3
Data 1280,768,6
Data 1280,800,2
Data 1280,854,5
Data 1280,960,1
Data 1280,1024,4
Data 1366,768,3
Data 1400,1050,1
Data 1440,900,2
Data 1440,960,5
Data 1600,900,3
Data 1600,1200,1
Data 1680,1050,2
Data 1920,1080,3
Data 1920,1200,2
Data 2048,1152,3
Data 2048,1536,1
Data 2048,2048,7
Data ,,


'####################################################################################################################
'# Ray Tracer (Beta version)
'# By Zom-B
'####################################################################################################################

Const Doantialias = -1
Const Usegaussian = 0

Const FLOOR = 1
Const SPHERE = 2

Type TEXTURE
    image As Long
    w As Integer
    h As Integer
    scaleU As Single
    scaleV As Single
    offsetU As Single
    offsetV As Single
    bumpfactor As Single
End Type

Dim Shared sizeX%, sizeY%
Dim Shared maxX%, maxY%
Dim Shared halfX%, halfY%

Dim Shared texture&(4)

Dim Shared camPos As VECTOR
Dim Shared camDir As VECTOR
Dim Shared camUp As VECTOR
Dim Shared camRight As VECTOR

'Speed required with these variables, so not using TYPEs here
Dim Shared objectType%(7) '                                 Object type
Dim Shared positionX(7), positionY(7), positionZ(7) '       Object position
Dim Shared size(7) '                                        Radius (in case of a sphere)
Dim Shared colorR!(7), colorG!(7), colorB!(7), colorA!(7) ' RGBA color
Dim Shared specular!(7), highlight!(7) '                    Phong parameters
Dim Shared reflection!(7) '                                 Ray reflection amount
Dim Shared textures(7) As TEXTURE, bumpmap(7) As TEXTURE '  image handle
Dim Shared numObjects%

Dim Shared lightX(4), lightY(4), lightZ(4) '                Light position
Dim Shared lightR!(4), lightG!(4), lightB!(4) '             Light color
Dim Shared numLights%

init
main

worldMap:
Data "!~#!~#!~#!-#(.69AEGFC@5.224;DJMORQND:)(*$!:#'#$!e#+.+1WX\_`ab\MCOZ!/baaQ5&!)#'<;CB=,&!&#$06,8@6/$!%#&&##$8NL"
Data ":1%!P#-=@@D25CGHIKJYZ]A)=^b`!0b]:!+#$0M?80!.#*-6.!&#%#%#/6?VR=6)!*#'%!B#,DDID?>>/LLPRINQE,!%#$#'F!.bZ0!;#=P="
Data "-%$'$%)7GV^!)bA/)&6.##-BL/0+!,#/!'#$/80)&!'#$)5NA\]^]W3EQZ,[]baaN>0!&#J_!+bZ2!%#$$!+#$/3-!)#8V*##+R]PUV\!/ba"
Data "bb8CBN[XRF26/!(#(=*##&B`!'b_YQPYaaVVMTVVX]YJY]YFMaZ_!%b9$##/Q!(b]TJ6$!-#%>V`ba`UJ<),2;<DCSTL[`O]!%ba!:baSTVT"
Data "[XOOWT06OZ!.b_PNa!+b`WH._a]aOP%#&[!%baP@%##1@CF&!*#Dab\Mba\FFLQ`!*b\_!Gb##*--VS!1baa^ab_`abN0?E.=8GVT'!%#1_bb"
Data "<!(#8=/##&!%#$9RbbN=Ya^aV\!,baY]`!@b^!%b]G##$#CUab`WXGKQ^!)b__a]!%abA!&#%ObZ3.,!&#-@I!0#&#/aa`b=6TLUQ[a!,b!%a"
Data "!9ba^]Xa:)RNGF1!*#+AJ>!&#$@Y!+baZbb^=.##%Cbb^][)!4#2T+##9>Q^,3Q`!%b_!EbO*##$$1U\(!+#),3+!*#6Qa_a!&ba_abb`bbU"
Data "G,Taab``U8!2#/LJK$#-ZO;>T!>babTa!'babbN1'!&#L`=#&!&#')'%&!-#$)L`baa!*b_!%bGa`baabaX-!1#;?KaGJ!@babbabZ\!-bT$"
Data "!%#;6!&#&#'!4#*FYaa!)b`bQZ!'b[L7,PI%!2#9DZ!Rb[<*!%#'!=#+a!,bYPAU[!&b_@4(2)!2#%N!&b^!'bZMZWbbaW!@b^/5#'&!?#/a"
Data "!-bYPQVXb_84-!4#)C@PbMEER=[bb`-$(.Sb`(T!*b`!4b\R.(Q;%!@#,a!-baa^`bY9%!6#-!%bA($:2N3aNWJW[KPbbG3!9b]``X)##08!C#"
Data "N!1ba1!2#$!'#/[aP&*,3.;$B>D!%abbabM-!9b[7?U##)K2!C#)X!0bW&!9#4KJ`bbX!&#+('19!?bU&,Q.HQI$!E#K]!-bD!:#5a!(bQ:$"
Data "HA/)/M!@b@$%J-$!G#*B^!&b`GJ<8Q/!7#$%(N!+b]!&b`a!&bL`!:bC##%!J#;=_!%bA!J5!7#+Z!2b=!&bW:KV!7bX&#'!L#:0]bb6!&#"
Data "4BU,!6#I!3bLB!&b]\E(',\!2bU>3%!<#'*!3#Dbb@#-L)79Q4/!4#%a!4b5]!'b])##/V!&b_A?!&b`FL-#%!?#(!3#(H``HYX!%#/)E3,$"
Data "!/#$##V!4bJ5!&b\2!&#(!%bU(##G!%bV1-##*6!R#';;^ZM8$!(#(!.#*#&_!5b?YbZ=!)#TbP'!%#0<!%bK!%#6;!U#&7\8##$4-$#%!1#"
Data "a!6bJ3)'&!(#:bC!%#&'.PWbZ!%#)A5!V#5E31[^^QU:!1#2^!5b\[b+!*#ZF!%#$#,A)S-##&+9>!W#(0N!(b>0!0#8]!%bZX!1bJ!)#%#&"
Data "E&!%#'$G-!    $3Q##$!V#F!*bQ!0#*;/0#&@W!.b[)!)#%%!(#&L?U$%%C_0!?#$!<#1a!+bG!6#J!)b`!%bS*!3#0[_,/Wb_/2*4!1#%!C#"
Data "(!%#P!-bS4'!3#Q!(baB_bW&!5#=bR0`bK@<'*6F35$#%%!*#$!F#T!0bI+!1#)\!'b^bba-!6#$Da/05-=B%0+<Mb]C$,+!N#A!1bL!2#B!'b"
Data "Xbba(!8#8EH:!&'$)/,\b\C.#0)!M#X!/ba7!2#3!'b`b^b3!;#&-5-6$(%%&U,?2%#'+!*#%!C#7!/bA!3#8!)bXb?$#;!<#'&U_K#R,##%"
Data "!&#$!1#$!:#$Ia_!,b/!3#R!+b;)EY!;#1W`bbW4^T!)#.!%#)!,#$!=#1!-b)!3#Qa!(b]3#:bF!;#R!*b.!(#$$##0!I#`!+bJ!4#/a!(b"
Data "F##@b2#%%!5#,M^!+b`:!?*!L#(!*bJ1$!5#X!(bE##A\!9#L!.bY*!Q#/!)bT!8#K!'bO!&#%!9#J!/bC!Q#=!)b:!8#(_!%ba0!>#/!/b"
Data "C!Q#@!(bF!:#Hbb^6!@#]bbM=4I!'b^/!Q#R!&b^:!;#*3*$!@#$=0'!&#?[bb`D!)#/&!H#*a!%b]C!g#-NP@)!)#%Q1!G#/_b_K&!j#1:!*#"
Data "=C##%!E#1^bZ*!k#'1!(#)K>!I#Cbb;!t#8;!J#Wb`3!Q#-!n#G_W##0*!P#$!l#%AO5$!*#'&!~#!H#(!~#!;#$##%!(#%!~#!8#)8;'!W#"
Data "&!f#+>\O!G#&/EH3&!)#5?@:>[NLA7BD52;ONCDA92/!'#$$!F#$!'#.@>`bM%!5#+,)*+-41-'+8CD1GWa!(b_ZH8BY!9bTNOA8&!B#$6BA"
Data "30.%#'4E`!%bM!0#.6DX^a!,babb`!,b^_!Cb^W7!0#'/37>DIQZVUPOIB>K!'b`X`!(bL*!,#)IT!@b]`!BbaK2&!%#21!%./7?JHTa!Bb_"
Data "RG:7?;:GT`!db_;DDC?7!~b!=ba_!Uba!%baa!hbaabaa!%b`^!%bab]a`ba!?b_a!qba\_!~b!Ib"

'####################################################################################################################
'####################################################################################################################
'####################################################################################################################

Sub init ()
    Width , 40
    Color 11: Print
    Print Tab(27); "Ray Tracer (Beta version)"
    Color 7
    Print Tab(36); "By Zom-B"

    scrn& = selectScreenMode&(4, 32)

    makeTextures
    'texture&(1) = _LOADIMAGE("d:\0synced\software\qb64\wTex.png", 32)
    'texture&(2) = _LOADIMAGE("d:\0synced\software\qb64\wBump.png", 32)
    'texture&(3) = _LOADIMAGE("d:\0synced\software\qb64\fTex.png", 32)
    'texture&(4) = _LOADIMAGE("d:\0synced\software\qb64\fBump.png", 32)

    makeScene

    Screen scrn&
    _Dest scrn&
    'SCREEN _NEWIMAGE(640, 480, 32)

    sizeX% = _Width
    sizeY% = _Height
    maxX% = sizeX% - 1
    maxY% = sizeY% - 1
    halfX% = sizeX% \ 2
    halfY% = sizeY% \ 2

    cameraPrepare 150, -250, 200, 0, 0, 66, 0, 0, 1, 60, maxX% / maxY%
    'cameraPrepare 0, 0, 400, 0, 0, 132, 0, -1, 0, 45, maxX% / maxY%
End Sub

'####################################################################################################################

Sub main ()
    'FOR i% = 0 TO 360 STEP 30
    '  x = 100 * COS(i% * _deg2rad)
    '  y = 100 * SIN(i% * _deg2rad)
    '  cameraPrepare x, y, 400, 0, 0, 200, 0, 0, 1, 60, maxX% / maxY%

    renderProgressive 256, 4

    Circle (maxX% \ 2, maxY% \ 2), 3, _RGB32(255, 255, 255), , , 1
    'NEXT
End Sub

'####################################################################################################################
'####################################################################################################################
'####################################################################################################################

Sub cameraPrepare (posX, posY, posZ, lookAtX, lookAtY, lookAtZ, upX, upY, upZ, fov, aspect)
    camPos.x = posX
    camPos.y = posY
    camPos.z = posZ

    camDir.x = lookAtX - posX
    camDir.y = lookAtY - posY
    camDir.z = lookAtZ - posZ
    vectorNormalize camDir
    'PRINT camDir.x, camDir.y, camDir.z

    camUp.x = upX
    camUp.y = upY
    camUp.z = upZ
    'vectorNormalize camUp
    'PRINT camUp.x, camUp.y, camUp.z

    'Right vec
    vectorCross camUp, camDir, camRight
    vectorNormalize camRight
    'PRINT camRight.x, camRight.y, camRight.z

    vectorCross camDir, camRight, camUp
    vectorNormalize camUp
    'PRINT camUp.x, camUp.y, camUp.z
    'END

    scaleY = Tan(fov * (_Pi / 360)) * 0.75
    scaleX = scaleY * aspect

    vectorScale camRight, scaleX
    vectorScale camUp, scaleY

    'PRINT fov, scaleX, scaleY
    'END
End Sub

'####################################################################################################################

Sub renderProgressive (startSize%, endSize%)
    pixStep% = startSize%

    pixWidth% = pixStep% - 1
    For y% = 0 To maxY% Step pixStep%
        For x% = 0 To maxX% Step pixStep%
            tracePoint x%, y%, r!, g!, b!
            Line (x%, y%)-Step(pixWidth%, pixWidth%), _RGB(r! * 255, g! * 255, b! * 255), BF
        Next
        If InKey$ = Chr$(27) Then System
    Next

    While pixStep% > 2
        pixSize% = pixStep% \ 2
        pixWidth% = pixSize% - 1
        For y% = 0 To maxY% Step pixStep%
            y1% = y% + pixSize%
            For x% = 0 To maxX% Step pixStep%
                x1% = x% + pixSize%

                If x1% < sizeX% Then
                    tracePoint x1%, y%, r!, g!, b!
                    Line (x1%, y%)-Step(pixWidth%, pixWidth%), _RGB(r! * 255, g! * 255, b! * 255), BF
                End If
                If y1% < sizeY% Then
                    tracePoint x%, y1%, r!, g!, b!
                    Line (x%, y1%)-Step(pixWidth%, pixWidth%), _RGB(r! * 255, g! * 255, b! * 255), BF
                    If x1% < sizeX% Then
                        tracePoint x1%, y1%, r!, g!, b!
                        Line (x1%, y1%)-Step(pixWidth%, pixWidth%), _RGB(r! * 255, g! * 255, b! * 255), BF
                    End If
                End If
            Next
            If InKey$ = Chr$(27) Then System
        Next
        pixStep% = pixStep% \ 2
    Wend

    For y% = 0 To maxY%
        y1% = y% + 1
        For x% = 0 To maxX%
            x1% = x% + 1

            If x1% < sizeX% Then
                tracePoint x1%, y%, r!, g!, b!
                PSet (x1%, y%), _RGB(r! * 255, g! * 255, b! * 255)
            End If
            If y1% < sizeY% Then
                tracePoint x%, y1%, r!, g!, b!
                PSet (x%, y1%), _RGB(r! * 255, g! * 255, b! * 255)
                If x1% < sizeX% Then
                    tracePoint x1%, y1%, r!, g!, b!
                    PSet (x1%, y1%), _RGB(r! * 255, g! * 255, b! * 255)
                End If
            End If
        Next
        If InKey$ = Chr$(27) Then System
    Next

    If Not Doantialias Then Exit Sub

    factor! = 255 / (endSize% * endSize%)

    If Usegaussian Then
        For y% = 0 To maxY%
            For x% = 0 To maxX%
                c& = Point(x%, y%)
                r! = _Red(c&)
                g! = _Green(c&)
                b! = _Blue(c&)
                For i% = 2 To endArea%
                    Do 'Marsaglia polar method for random gaussian
                        u! = Rnd * 2 - 1
                        v! = Rnd * 2 - 1
                        s! = u! * u! + v! * v!
                    Loop While s! >= 1 Or s! = 0
                    s! = Sqr(-2 * Log(s!) / s!) * 0.5
                    u! = u! * s!
                    v! = v! * s!

                    tracePoint x% + u!, y% + v!, r1!, g1!, b1!

                    r! = r! + r1!
                    g! = g! + g1!
                    b! = b! + b1!
                Next

                PSet (x%, y%), _RGB(r! * factor!, g! * factor!, b! * factor!)
                If InKey$ = Chr$(27) Then System
            Next
        Next
    Else
        For y% = 0 To maxY%
            For x% = 0 To maxX%
                r! = 0
                g! = 0
                b! = 0
                For v% = 0 To endSize% - 1
                    y1! = y% + v% / endSize%
                    For u% = 0 To endSize% - 1
                        If u% = 0 And v& = 0 Then
                            c& = Point(x%, y%)
                        Else
                            x1! = x% + u% / endSize%
                            tracePoint x1!, y1!, r1!, g1!, b1!
                        End If
                        r! = r! + r1!
                        g! = g! + g1!
                        b! = b! + b1!
                    Next
                Next

                PSet (x%, y%), _RGB(r! * factor!, g! * factor!, b! * factor!)
                If InKey$ = Chr$(27) Then System
            Next
        Next
    End If
End Sub

'####################################################################################################################

Sub tracePoint (x!, y!, r!, g!, b!)
    x0! = (x! - halfX%) / halfX%
    y0! = (halfY% - y!) / halfY%

    rayX = camDir.x + x0! * camRight.x + y0! * camUp.x
    rayY = camDir.y + x0! * camRight.y + y0! * camUp.y
    rayZ = camDir.z + x0! * camRight.z + y0! * camUp.z

    'normalize to a vector length of 1
    d = 1 / Sqr(rayX * rayX + rayY * rayY + rayZ * rayZ)
    traceRay camPos.x, camPos.y, camPos.z, rayX * d, rayY * d, rayZ * d, 3, -1, r!, g!, b!
End Sub

'####################################################################################################################

Sub traceRay (startX, startY, startZ, rayX, rayY, rayZ, depth%, lastObj%, lightR!, lightG!, lightB!)
    findMinObj startX, startY, startZ, rayX, rayY, rayZ, lastObj%, minobj%, minDepth

    If minobj% = 0 Then '                        Infinity
        lightR! = 0
        lightG! = 0
        lightB! = 0
    Else '                                       An object was found
        intersectX = startX + rayX * minDepth
        intersectY = startY + rayY * minDepth
        intersectZ = startZ + rayZ * minDepth

        'Calculate normal vector
        Select Case objectType%(minobj%)
            Case FLOOR:
                normalX = 0
                normalY = 0
                normalZ = 1
            Case SPHERE:
                normalX = (intersectX - positionX(minobj%)) / size(minobj%)
                normalY = (intersectY - positionY(minobj%)) / size(minobj%)
                normalZ = (intersectZ - positionZ(minobj%)) / size(minobj%)
        End Select

        'Calculate UV coordinates
        If textures(minobj%).image <> -1 Or bumpmap(minobj%).image <> -1 Then
            Select Case objectType%(minobj%)
                Case FLOOR:
                    texcoordU! = intersectX
                    texcoordV! = intersectY
                Case SPHERE:
                    If normalX = 0 Then
                        If normalY <= 0 Then texcoordU! = 0 Else texcoordU! = 0.5
                    Else
                        texcoordU! = atan2(normalX, normalY) / pi2 + 0.5
                    End If

                    texcoordV! = acos(normalZ) / _Pi
            End Select
        End If

        'Bumpmapping
        If bumpmap(minobj%).image <> -1 Then
            If minobj% < 3 Then
                texdirxx = 1
                texdirxy = 0
                texdirxz = 0

                texdiryx = 0
                texdiryy = 1
                texdiryz = 0
            Else
                texdirxx = normalY
                texdirxy = -normalX
                texdirxz = 0

                texdiryx = normalZ * normalX
                texdiryy = normalZ * normalY
                texdiryz = -(normalX * normalX + normalY * normalY)
            End If

            x! = texcoordU! * bumpmap(minobj%).scaleU - bumpmap(minobj%).offsetU
            y! = texcoordV! * bumpmap(minobj%).scaleV - bumpmap(minobj%).offsetV
            x1% = Int(x!)
            y1% = Int(y!)

            dx1! = x! - x1%
            dy1! = y! - y1%
            dx2! = 1 - dx1!
            dy2! = 1 - dy1!
            dx1dy1! = dx1! * dy1!
            dx1dy2! = dx1! * dy2!
            dx2dy1! = dx2! * dy1!
            dx2dy2! = dx2! * dy2!

            x0% = remainder%(x1%, bumpmap(minobj%).w)
            y0% = remainder%(y1%, bumpmap(minobj%).h)
            x1% = remainder%(x1% + 1, bumpmap(minobj%).w)
            y1% = remainder%(y1% + 1, bumpmap(minobj%).h)

            _Source bumpmap(minobj%).image
            c0& = Point(x0%, y0%)
            c1& = Point(x1%, y0%)
            c2& = Point(x0%, y1%)
            c3& = Point(x1%, y1%)

            sx! = ((_Red(c0&) - 127) * dx2dy2! + (_Red(c1&) - 127) * dx1dy2! + (_Red(c2&) - 127) * dx2dy1! + (_Red(c3&) - 127) * dx1dy1!) * bumpmap(minobj%).bumpfactor / 127
            sy! = ((_Green(c0&) - 127) * dx2dy2! + (_Green(c1&) - 127) * dx1dy2! + (_Green(c2&) - 127) * dx2dy1! + (_Green(c3&) - 127) * dx1dy1!) * bumpmap(minobj%).bumpfactor / 127

            normalX = normalX - (texdirxx * sx! + texdiryx * sy)
            normalY = normalY - (texdirxy * sx! + texdiryy * sy)
            normalZ = normalZ - (texdirxz * sx! + texdiryz * sy)

            r = Sqr(normalX * normalX + normalY * normalY + normalZ * normalZ)
            normalX = normalX / r
            normalY = normalY / r
            normalZ = normalZ / r
        End If

        'lighting
        r = 2 * (rayX * normalX + rayY * normalY + rayZ * normalZ)
        rayX = rayX - normalX * r
        rayY = rayY - normalY * r
        rayZ = rayZ - normalZ * r

        diffuseR! = 0
        diffuseG! = 0
        diffuseB! = 0
        specularR! = 0
        specularG! = 0
        specularB! = 0

        For a% = numLights% To 1 Step -1
            dirX = lightX(a%) - intersectX
            dirY = lightY(a%) - intersectY
            dirZ = lightZ(a%) - intersectZ

            r = 1 / Sqr(dirX * dirX + dirY * dirY + dirZ * dirZ)
            dirX = dirX * r
            dirY = dirY * r
            dirZ = dirZ * r

            'Shadows testing
            findShadow intersectX, intersectY, intersectZ, dirX, dirY, dirZ, minobj%, noShadows%

            If noShadows% Then
                'Diffuse lighting
                r = normalX * dirX + normalY * dirY + normalZ * dirZ
                If r > 0 Then
                    diffuseR! = diffuseR! + colorR!(minobj%) * lightR!(a%) * r
                    diffuseG! = diffuseG! + colorG!(minobj%) * lightG!(a%) * r
                    diffuseB! = diffuseB! + colorB!(minobj%) * lightB!(a%) * r
                End If

                'Specular lighting
                r = rayX * dirX + rayY * dirY + rayZ * dirZ
                If r > 0 Then
                    c! = r ^ (1 / highlight!(minobj%)) * specular!(minobj%)

                    specularR! = specularR! + lightR!(a%) * c!
                    specularG! = specularG! + lightG!(a%) * c!
                    specularB! = specularB! + lightB!(a%) * c!
                End If
            End If
        Next

        lightR! = diffuseR! + specularR!
        lightG! = diffuseG! + specularG!
        lightB! = diffuseB! + specularB!

        'texturing
        If textures(minobj%).image <> -1 Then
            x! = texcoordU! * textures(minobj%).scaleU - textures(minobj%).offsetU
            y! = texcoordV! * textures(minobj%).scaleV - textures(minobj%).offsetV
            x0% = Int(x!)
            y0% = Int(y!)

            dx1! = x! - x0%
            dy1! = y! - y0%
            dx2! = 1 - dx1!
            dy2! = 1 - dy1!
            dx1dy1! = dx1! * dy1!
            dx1dy2! = dx1! * dy2!
            dx2dy1! = dx2! * dy1!
            dx2dy2! = dx2! * dy2!

            x1% = remainder%(x0% + 1, textures(minobj%).w) ' returns positive value only, in contrast to MOD
            y1% = remainder%(y0% + 1, textures(minobj%).h)
            x0% = remainder%(x0%, textures(minobj%).w)
            y0% = remainder%(y0%, textures(minobj%).h)

            _Source textures(minobj%).image
            c0& = Point(x0%, y0%)
            c1& = Point(x1%, y0%)
            c2& = Point(x0%, y1%)
            c3& = Point(x1%, y1%)

            materialr! = _Red(c0&) * dx2dy2! + _Red(c1&) * dx1dy2! + _Red(c2&) * dx2dy1! + _Red(c3&) * dx1dy1!
            materialg! = _Green(c0&) * dx2dy2! + _Green(c1&) * dx1dy2! + _Green(c2&) * dx2dy1! + _Green(c3&) * dx1dy1!
            materialb! = _Blue(c0&) * dx2dy2! + _Blue(c1&) * dx1dy2! + _Blue(c2&) * dx2dy1! + _Blue(c3&) * dx1dy1!

            lightR! = lightR! * materialr! / 255F
            lightG! = lightG! * materialg! / 255F
            lightB! = lightB! * materialb! / 255F
        End If

        'Reflection
        If reflection!(minobj%) > 0 And depth% > 0 Then
            traceRay intersectX, intersectY, intersectZ, rayX, rayY, rayZ, depth% - 1, minobj%, reflectR!, reflectG!, reflectB!
            lightR! = lightR! + (reflectR! - lightR!) * reflection!(minobj%)
            lightG! = lightG! + (reflectG! - lightG!) * reflection!(minobj%)
            lightB! = lightB! + (reflectB! - lightB!) * reflection!(minobj%)
        End If

        ' Global intensity
        r = Exp(-minDepth / 1000.0)

        lightR! = lightR! * r
        lightG! = lightG! * r
        lightB! = lightB! * r
    End If
End Sub

'####################################################################################################################

Sub findMinObj (startX, startY, startZ, rayX, rayY, rayZ, lastObj%, minObj%, minDepth)
    minObj% = 0
    minDepth = 1E+308
    For a% = numObjects% To 1 Step -1
        If a% <> lastObj% Then
            Select Case objectType%(a%)
                Case FLOOR:
                    depth = -startZ / rayZ
                Case SPHERE:
                    posX = positionX(a%) - startX
                    posY = positionY(a%) - startY
                    posZ = positionZ(a%) - startZ

                    r = rayX * posX + rayY * posY + rayZ * posZ
                    d = r * r - posX * posX - posY * posY - posZ * posZ + size(a%) * size(a%)
                    If d >= 0 Then depth = r - Sqr(d) Else depth = -1
            End Select

            If depth >= 0 Then
                If minDepth > depth Then minDepth = depth: minObj% = a%
            End If
        End If
    Next
End Sub

'####################################################################################################################

Sub findShadow (startX, startY, startZ, rayX, rayY, rayZ, lastObj%, noShadows%)
    noShadows% = -1
    For a% = numObjects% To 1 Step -1
        If a% <> lastObj% Then
            Select Case objectType%(a%)
                Case FLOOR:
                    depth = -startZ / rayZ
                Case SPHERE:
                    posX = positionX(a%) - startX
                    posY = positionY(a%) - startY
                    posZ = positionZ(a%) - startZ

                    r = rayX * posX + rayY * posY + rayZ * posZ
                    d = r * r - posX * posX - posY * posY - posZ * posZ + size(a%) * size(a%)
                    If d >= 0 Then depth = r - Sqr(d) Else depth = -1
            End Select

            If depth >= 0 Then
                noShadows% = 0
                Exit Sub
            End If
        End If
    Next
End Sub

'####################################################################################################################
'####################################################################################################################
'####################################################################################################################

Sub makeTextures
    Print "Generating textures. Press any key to see them generating."
    View Print 2 To 40
    showing = 0

    world& = _NewImage(128, 64, 32)
    texture&(1) = _NewImage(1024, 512, 32)
    texture&(2) = _NewImage(1024, 512, 32)
    texture&(3) = _NewImage(512, 512, 32)
    texture&(4) = _NewImage(512, 512, 32)

    If showing Then Screen world& Else _Dest 0: Print: Print "(1/5) Decompressing world template (RLE)";

    x% = 0: y% = 0
    For a% = 1 To 25
        _Dest world&
        Read a$
        For b! = 1 To Len(a$)
            c% = (Asc(Mid$(a$, b!, 1)) - 35) * 4
            If c% < 0 Then n% = Asc(Mid$(a$, b! + 1, 1)) - 34: b! = b! + 2: c% = (Asc(Mid$(a$, b!, 1)) - 35) * 4 Else n% = 1
            For n% = n% To 1 Step -1
                PSet (x%, y%), _RGB(c%, c%, c%)
                x% = x% + 1: If x% = 128 Then x% = 0: y% = y% + 1
            Next
        Next
        If Len(InKey$) Then showing = -1: Screen world& Else If Not showing Then _Dest 0: Print ".";
    Next

    If showing Then Screen texture&(1) Else _Dest 0: Print: Print "(2/5) World bump map";

    For y% = 0 To 511
        _Source world&
        _Dest texture&(1)
        For x% = 0 To 1023
            getWorldBump x% / 3000, y% / 2000, a!
            a! = (a! - 0.387) / 0.502: a! = a! * a!
            getWorldPixel x% / 8 - 0.5, y% / 8 - 0.50, c!
            c! = c! / 255: If c! > 1 Then c! = 1

            r! = 11 + (24 + 231 * a! - 11) * c!
            g! = 10 + (49 + 198 * a! - 10) * c!
            b! = 50 + (8 + 181 * a! - 50) * c!

            PSet (x%, y%), _RGB32(r!, g!, b!)
        Next
        If Len(InKey$) Then showing = -1: Screen texture&(1) Else If Not showing Then _Dest 0: Print ".";
    Next

    If showing Then Screen texture&(2) Else _Dest 0: Print: Print "(3/5) World bump map";

    For y% = 0 To 511
        _Source world&
        _Dest texture&(2)
        For x% = 0 To 1023
            getWorldPixel x% / 8 - 0.46, y% / 8 - 0.50, c0!: getWorldBump x% / 300 + 0.001, y% / 300, a0!: a0! = a0! * c0!
            getWorldPixel x% / 8 - 0.54, y% / 8 - 0.50, c1!: getWorldBump x% / 300 - 0.001, y% / 300, a1!: a1! = a1! * c1!
            getWorldPixel x% / 8 - 0.50, y% / 8 - 0.46, c2!: getWorldBump x% / 300, y% / 300 + 0.001, a2!: a2! = a2! * c2!
            getWorldPixel x% / 8 - 0.50, y% / 8 - 0.54, c3!: getWorldBump x% / 300, y% / 300 - 0.001, a3!: a3! = a3! * c3!

            r! = (a1! - a0!) * 7
            g! = (a2! - a3!) * 7
            PSet (x%, y%), _RGB32(r! + 127, g! + 127, 127)
        Next
        If Len(InKey$) Then showing = -1: Screen texture&(2) Else If Not showing Then _Dest 0: Print ".";
    Next

    If showing Then Screen texture&(3) Else _Dest 0: Print: Print "(4/5) Floor texture";

    For y% = 0 To 511
        _Dest texture&(3)
        For x% = 0 To 511
            getFloorTexture x% / 256, y% / 256, r!, g!, b!
            PSet (x%, y%), _RGB32(r! * 255, g! * 255, b! * 255)
        Next
        If Len(InKey$) Then showing = -1: Screen texture&(2) Else If Not showing Then _Dest 0: Print ".";
    Next

    If showing Then Screen texture&(4) Else _Dest 0: Print: Print "(5/5) Floor bump map";

    For y% = 0 To 511
        _Dest texture&(4)
        For x% = 0 To 511
            getFloorBump x% / 256 - 0.002, y% / 256, a0!
            getFloorBump x% / 256 + 0.002, y% / 256, a1!
            getFloorBump x% / 256, y% / 256 + 0.002, a2!
            getFloorBump x% / 256, y% / 256 - 0.002, a3!

            r! = (a1! - a0!) * 1400
            g! = (a2! - a3!) * 1400

            PSet (x%, y%), _RGB32(r! + 127, g! + 127, 127)
        Next
        If Len(InKey$) Then showing = -1: Screen texture&(4) Else If Not showing Then _Dest 0: Print ".";
    Next
End Sub

'####################################################################################################################

Sub getWorldPixel (x!, y!, c0!)
    x% = Int(x!) And &H7F
    y% = Int(y!) And &H3F
    dx! = x! - x%: If dx! < 0 Then dx! = dx! + 128
    dy! = y! - y%


    c0! = Point(x%, y%) And &HFF
    c1! = Point((x% + 1) And &H7F, y%) And &HFF
    c2! = Point(x%, y% + 1) And &HFF
    c3! = Point((x% + 1) And &H7F, y% + 1) And &HFF

    c0! = c0! + (c1! - c0!) * dx!
    c2! = c2! + (c3! - c2!) * dx!
    c0! = c0! + (c2! - c0!) * dy!

    c0! = c0! - 72: If c0! < 0 Then c0! = 0
End Sub


Sub getWorldBump (u!, v!, a!)
    l! = 0
    fbm u!, v!, 1, l!
    a! = 0.3 * l! + 0.2
End Sub


Sub getFloorTexture (u!, v!, r!, g!, b!)
    v1% = v! - Int(v!) < 0.5: u1% = u! - Int(u!) < 0.5

    If u1% = v1% Then
        l! = 0
        fbm u!, v!, 3, l!
        l! = l! * 0.7
        fbm u!, v!, 2, l!
        r! = 0.054 * l! + 0.61
        g! = 0.054 * l! + 0.42
        b! = 0.054 * l! + 0.25
    Else
        l! = 0
        fbm u!, v!, 1, l!
        l! = l! * 0.6
        fbm u!, v!, 0, l!
        r! = 0.10 * l! + 0.05
        g! = 0.08 * l! - 0.04
        b! = 0.07 * l! - 0.06
    End If
End Sub


Sub getFloorBump (u!, v!, a!)
    v1% = v! - Int(v!) < 0.5: u1% = u! - Int(u!) < 0.5
    v2! = v! * 2 - Int(v! * 2): v2! = 1 - v2! * (1 - v2!) * 4: v2! = v2! * v2!: v2! = 1 - v2! * v2!
    u2! = u! * 2 - Int(u! * 2): u2! = 1 - u2! * (1 - u2!) * 4: u2! = u2! * u2!: u2! = 1 - u2! * u2!

    If u1% = v1% Then
        l! = 0
        fbm u!, v!, 3, l!
        l! = l! * 0.7
        fbm u!, v!, 2, l!
        a! = 0.02 * l! + 0.7
    Else
        l! = 0
        fbm u!, v!, 1, l!
        l! = l! * 0.6
        fbm u!, v!, 0, l!
        a! = 0.05 * l! + 0.6
    End If

    a! = a! * u2! * v2!

    'a! = a! + (u2! * v2! - 1) ' * 0.88
    'IF a! < 0.06 THEN a = RND * 0.02
End Sub

'####################################################################################################################

Sub fbm (x!, y!, a%, o!)
    Select Case a%
        Case 0:
            zx! = x! * 40 - y! * 2
            zy! = y!
            i% = -5
        Case 1:
            zx! = x! * 50
            zy! = y! * 50
            i% = -2
        Case 2:
            zx! = x! * 80
            zy! = y! * 80
            i% = -2
        Case 3:
            zx! = x! * 30 + y! * 0.5
            zy! = y! * 2
            i% = -2
    End Select

    scale! = 1
    For i% = i% To 0
        zcx! = zx!: zx! = zcx! * 0.6 - zy! * 0.8: zy! = zcx! * 0.8 + zy! * 0.6
        zcx! = CInt(zx! / scale!) * scale!: zcy! = CInt(zy! / scale!) * scale!

        rx1! = zcx! + 0.5 * scale! + 14: ry1! = zcy! + 0.5 * scale!: r! = 123094 / (rx1! * rx1! + ry1! * ry1!)
        rx1! = rx1! * r!: ry1! = ry1! * r!: rx1! = rx1! - Int(rx1!): ry1! = ry1! - Int(ry1!)
        rx2! = zcx! - 0.5 * scale! + 14: ry2! = zcy! + 0.5 * scale!: r! = 123094 / (rx2! * rx2! + ry2! * ry2!)
        rx2! = rx2! * r!: ry2! = ry2! * r!: rx2! = rx2! - Int(rx2!): ry2! = ry2! - Int(ry2!)
        rx3! = zcx! + 0.5 * scale! + 14: ry3! = zcy! - 0.5 * scale!: r! = 123094 / (rx3! * rx3! + ry3! * ry3!)
        rx3! = rx3! * r!: ry3! = ry3! * r!: rx3! = rx3! - Int(rx3!): ry3! = ry3! - Int(ry3!)
        rx4! = zcx! - 0.5 * scale! + 14: ry4! = zcy! - 0.5 * scale!: r! = 123094 / (rx4! * rx4! + ry4! * ry4!)
        rx4! = rx4! * r!: ry4! = ry4! * r!: rx4! = rx4! - Int(rx4!): ry4! = ry4! - Int(ry4!)
        x0! = (zx! - zcx!) / scale! + 0.5: x0! = (3 - 2 * x0!) * x0! * x0!: x1! = 1 - x0!
        y0! = (zy! - zcy!) / scale! + 0.5: y0! = (3 - 2 * y0!) * y0! * y0!: y1! = 1 - y0!
        pixcompx! = rx1! * x0! * y0! + rx3! * x0! * y1! + rx2! * x1! * y0! + rx4! * x1! * y1!
        pixcompy! = ry1! * x0! * y0! + ry3! * x0! * y1! + ry2! * x1! * y0! + ry4! * x1! * y1!
        o! = o! + Sqr(pixcompx! * pixcompx! + pixcompy! * pixcompy!) * scale! * scale!: scale! = scale! * 0.8
    Next
End Sub

'####################################################################################################################
'####################################################################################################################
'####################################################################################################################

Sub makeScene
    objectType%(1) = FLOOR
    colorR!(1) = 1
    colorG!(1) = 1
    colorB!(1) = 1
    colorA!(1) = 1
    specular!(1) = 2
    highlight!(1) = 0.002
    reflection!(1) = 0.5
    texturePrepare textures(1), texture&(3), .005, .005, 0, 0, 0
    texturePrepare bumpmap(1), texture&(4), .005, .005, 0, 0, 1

    objectType%(2) = SPHERE
    positionX(2) = 0
    positionY(2) = 57.735
    positionZ(2) = 50
    size(2) = 50
    colorR!(2) = 1
    colorG!(2) = 0
    colorB!(2) = 0
    colorA!(2) = 1
    specular!(2) = 1
    highlight!(2) = 0.1
    reflection!(2) = 0.1
    texturePrepare textures(2), -1, 1, 1, 0, 0, 0
    texturePrepare bumpmap(2), -1, 1, 1, 0, 0, 1

    objectType%(3) = SPHERE
    positionX(3) = -50
    positionY(3) = -28.8675
    positionZ(3) = 50
    size(3) = 50
    colorR!(3) = 0
    colorG!(3) = 0
    colorB!(3) = 1
    colorA!(3) = 1
    specular!(3) = 1
    highlight!(3) = 0.04
    reflection!(3) = 0.4
    texturePrepare textures(3), -1, 1, 1, 0, 0, 0
    texturePrepare bumpmap(3), -1, 1, 1, 0, 0, 1

    objectType%(4) = SPHERE
    positionX(4) = 50
    positionY(4) = -28.8675
    positionZ(4) = 50
    size(4) = 50
    colorR!(4) = 0
    colorG!(4) = 1
    colorB!(4) = 0
    colorA!(4) = 1
    specular!(4) = 10
    highlight!(4) = 0.01
    reflection!(4) = 0.2
    texturePrepare textures(4), -1, 1, 1, 0, 0, 0
    texturePrepare bumpmap(4), -1, 1, 1, 0, 0, 1

    objectType%(5) = SPHERE
    positionX(5) = 0
    positionY(5) = 0
    positionZ(5) = 132
    size(5) = 50
    colorR!(5) = 1
    colorG!(5) = 1
    colorB!(5) = 1
    colorA!(5) = 1
    specular!(5) = 5
    highlight!(5) = 0.002
    reflection!(5) = 0.15
    texturePrepare textures(5), texture&(1), 1, 1, 0.35, 0, 0
    texturePrepare bumpmap(5), texture&(2), 1, 1, 0.35, 0, 1

    numObjects% = 5

    lightX(1) = 460
    lightY(1) = -460
    lightZ(1) = 460
    lightR!(1) = 1
    lightG!(1) = 0.25
    lightB!(1) = 0.25

    lightX(2) = -640
    lightY(2) = -180
    lightZ(2) = 460
    lightR!(2) = 0.25
    lightG!(2) = 1
    lightB!(2) = 0.25

    lightX(3) = 80
    lightY(3) = 260
    lightZ(3) = 760
    lightR!(3) = 0.25
    lightG!(3) = 0.25
    lightB!(3) = 1

    lightX(4) = 0
    lightY(4) = 0
    lightZ(4) = 400
    lightR!(4) = 1
    lightG!(4) = 1
    lightB!(4) = 1

    numLights% = 4
End Sub

'####################################################################################################################

Sub texturePrepare (tex As TEXTURE, handle&, sU!, sV!, oU!, oV!, bumpfactor!)
    tex.image = handle&
    If handle& <> -1 Then
        tex.w = _Width(tex.image)
        tex.h = _Height(tex.image)
        tex.scaleU = sU! * tex.w
        tex.scaleV = sV! * tex.h
        tex.offsetU = oU! * tex.w
        tex.offsetV = oV! * tex.h
        tex.bumpfactor = bumpfactor!
    End If
End Sub

'####################################################################################################################
'# Math Library V0.11 (routines)
'# By Zom-B
'####################################################################################################################

Function remainder% (a%, b%)
    remainder% = a% - Int(a% / b%) * b%
End Function

'> merger: Skipping unused FUNCTION fRemainder (a, b)

'####################################################################################################################

'> merger: Skipping unused FUNCTION safeLog (x)

'####################################################################################################################

'> merger: Skipping unused FUNCTION asin (y)

Function acos (y)
    If y <= -0.99999999999999# Then acos = _Pi: Exit Function
    If y >= 0.99999999999999# Then acos = 0: Exit Function
    acos = pi05 - Atn(y / Sqr(1 - y * y))
End Function

'> merger: Skipping unused FUNCTION safeAcos (y)

Function atan2 (y, x)
    If x > 0 Then
        atan2 = Atn(y / x)
    ElseIf x < 0 Then
        If y > 0 Then
            atan2 = Atn(y / x) + _Pi
        Else
            atan2 = Atn(y / x) - _Pi
        End If
    ElseIf y > 0 Then
        atan2 = _Pi / 2
    Else
        atan2 = -_Pi / 2
    End If
End Function

'####################################################################################################################
'# Vector math library v0.1 (module part)
'# By Zom-B
'####################################################################################################################

Sub vectorScale (a As VECTOR, scale)
    a.x = a.x * scale
    a.y = a.y * scale
    a.z = a.z * scale
End Sub

Sub vectorNormalize (a As VECTOR)
    r = 1 / Sqr(a.x * a.x + a.y * a.y + a.z * a.z)
    a.x = a.x * r
    a.y = a.y * r
    a.z = a.z * r
End Sub

'####################################################################################################################

Sub vectorCross (a As VECTOR, b As VECTOR, o As VECTOR)
    o.x = a.y * b.z - a.z * b.y
    o.y = a.z * b.x - a.x * b.z
    o.z = a.x * b.y - a.y * b.x
End Sub

'####################################################################################################################
'# Screen mode selector v1.1 (routines)
'# By Zom-B
'####################################################################################################################

Function selectScreenMode& (yOffset%, colors%)
    Dim aspectName$(0 To 9), aspectCol%(0 To 9)
    Restore videoaspect
    For y% = 0 To 10
        Read aspectName$(y%), aspectCol%(y%)
        If aspectCol%(y%) = 0 Then numAspect% = y% - 1: Exit For
    Next

    Dim vidX%(1 To 100), vidY%(1 To 100), vidA%(1 To 100)
    Restore videomodes
    For y% = 1 To 100
        Read vidX%(y%), vidY%(y%), vidA%(y%)
        If (vidX%(y%) <= 0) Then numModes% = y% - 1: Exit For
    Next

    If numModes% > _Height - yOffset% - 1 Then numModes% = _Height - yOffset% - 1

    Def Seg = &HB800
    Locate yOffset% + 1, 1
    Print "Select video mode:"; Tab(61); "Click "
    Poke yOffset% * 160 + 132, 31

    y% = 0
    lastY% = 0
    selectedAspect% = 0
    reprint% = 1
    lastButton% = 0
    Do
        If InKey$ = Chr$(27) Then Cls: System
        If reprint% Then
            reprint% = 0

            For x% = 1 To numModes%
                Locate yOffset% + x% + 1, 1
                Color 7, 0
                Print Using "##:"; x%;
                If selectedAspect% = 0 Then
                    Color aspectCol%(vidA%(x%))
                ElseIf selectedAspect% = vidA%(x%) Then
                    Color 15
                Else
                    Color 8
                End If
                Print Str$(vidX%(x%)); ","; vidY%(x%);
            Next

            For x% = 0 To numAspect%
                If x% > 0 And selectedAspect% = x% Then
                    Color aspectCol%(x%), 3
                Else
                    Color aspectCol%(x%), 0
                End If
                Locate yOffset% + x% + 2, 64
                Print "<"; aspectName$(x%); ">"
            Next
        End If
        If _MouseInput Then
            If lastY% > 0 Then
                For x% = 0 To 159 Step 2
                    Poke lastY% + x%, Peek(lastY% + x%) And &HEF
                Next
            End If

            x% = _MouseX
            y% = _MouseY - yOffset% - 1

            If x% <= 60 Then
                If y% > 0 And y% <= numModes% Then
                    If _MouseButton(1) = 0 And lastButton% Then Exit Do
                    y% = (yOffset% + y%) * 160 + 1
                    For x% = 0 To 119 Step 2
                        Poke y% + x%, Peek(y% + x%) Or &H10
                    Next
                Else
                    y% = 0
                End If
            Else
                If y% > 0 And y% - 1 <= numAspect% Then
                    If _MouseButton(1) Then
                        selectedAspect% = y% - 1
                        reprint% = 1
                    End If
                    y% = (yOffset% + y%) * 160 + 1
                    For x% = 120 To 159 Step 2
                        Poke y% + x%, Peek(y% + x%) Or &H10
                    Next
                Else
                    y% = 0
                End If
            End If
            lastY% = y%
            lastButton% = _MouseButton(1)
        End If
    Loop

    selectScreenMode& = _NewImage(vidX%(y%), vidY%(y%), colors%)

    Color 7
    Cls
End Function

