[Home](https://qb64.com) • [News](../../news.md) • [GitHub](../../github.md) • [Wiki](../../wiki.md) • [Samples](../../samples.md) • [Media](../../media.md) • [Community](../../community.md) • [Rolodex](../../rolodex.md) • [More...](../../more.md)

## SAMPLE: FRACTAL ART

![hearts-and-butterflies.png](img/hearts-and-butterflies.png)

### Author

[🐝 Zom-B](../zom-b.md) 

### Description

```text
This is [...] a series of fractal artworks that I ported from Ultra Fractal to Quick Basic 4.5 with the Future library, and are currently upgrading to QB64. I received permission from the author(s) of the artworks to republish their works in this particular form. The original consists of a lot of include and routine files $included in the main, which I have merged here for convenience.
```

### Code

#### hearts-and-butterflies.bas

```vb

'> Merged with Zom-B's smart $include merger 0.51

DEFSNG A-Z

'####################################################################################################################
'# Math Library V1.0 (include)
'# By Zom-B
'####################################################################################################################

CONST sqrt2         = 1.41421356237309504880168872420969807856967187537695 ' Knuth01
CONST sqrt3 = 1.73205080756887729352744634150587236694280525381038 ' Knuth02
CONST sqrt5 = 2.23606797749978969640917366873127623544061835961153 ' Knuth03
CONST sqrt10 = 3.16227766016837933199889354443271853371955513932522 ' Knuth04
CONST cubert2 = 1.25992104989487316476721060727822835057025146470151 ' Knuth05
CONST cubert3 = 1.44224957030740838232163831078010958839186925349935 ' Knuth06
CONST q2pow025 = 1.18920711500272106671749997056047591529297209246382 ' Knuth07
CONST phi = 1.61803398874989484820458683436563811772030917980576 ' Knuth08
CONST log2 = 0.69314718055994530941723212145817656807550013436026 ' Knuth09
CONST log3 = 1.09861228866810969139524523692252570464749055782275 ' Knuth10
CONST log10 = 2.30258509299404568401799145468436420760110148862877 ' Knuth11
CONST logpi = 1.14472988584940017414342735135305871164729481291531 ' Knuth12
CONST logphi = 0.48121182505960344749775891342436842313518433438566 ' Knuth13
CONST q1log2 = 1.44269504088896340735992468100189213742664595415299 ' Knuth14
CONST q1log10 = 0.43429448190325182765112891891660508229439700580367 ' Knuth15
CONST q1logphi = 2.07808692123502753760132260611779576774219226778328 ' Knuth16
CONST pi = 3.14159265358979323846264338327950288419716939937511 ' Knuth17
CONST deg2rad = 0.01745329251994329576923690768488612713442871888542 ' Knuth18
CONST q1pi = 0.31830988618379067153776752674502872406891929148091 ' Knuth19
CONST pisqr = 9.86960440108935861883449099987615113531369940724079 ' Knuth20
CONST gamma05 = 1.7724538509055160272981674833411451827975494561224 '  Knuth21
CONST gamma033 = 2.6789385347077476336556929409746776441286893779573 '  Knuth22
CONST gamma067 = 1.3541179394264004169452880281545137855193272660568 '  Knuth23
CONST e = 2.71828182845904523536028747135266249775724709369996 ' Knuth24
CONST q1e = 0.36787944117144232159552377016146086744581113103177 ' Knuth25
CONST esqr = 7.38905609893065022723042746057500781318031557055185 ' Knuth26
CONST eulergamma = 0.57721566490153286060651209008240243104215933593992 ' Knuth27
CONST expeulergamma = 1.7810724179901979852365041031071795491696452143034 '  Knuth28
CONST exppi025 = 2.19328005073801545655976965927873822346163764199427 ' Knuth29
CONST sin1 = 0.84147098480789650665250232163029899962256306079837 ' Knuth30
CONST cos1 = 0.54030230586813971740093660744297660373231042061792 ' Knuth31
CONST zeta3 = 1.2020569031595942853997381615114499907649862923405 '  Knuth32
CONST nloglog2 = 0.36651292058166432701243915823266946945426344783711 ' Knuth33

CONST logr10 = 0.43429448190325182765112891891660508229439700580367
CONST logr2 = 1.44269504088896340735992468100189213742664595415299
CONST pi05 = 1.57079632679489661923132169163975144209858469968755
CONST pi2 = 6.28318530717958647692528676655900576839433879875021
CONST q05log10 = 0.21714724095162591382556445945830254114719850290183
CONST q05log2 = 0.72134752044448170367996234050094606871332297707649
CONST q05pi = 0.15915494309189533576888376337251436203445964574046
CONST q13 = 0.33333333333333333333333333333333333333333333333333
CONST q16 = 0.16666666666666666666666666666666666666666666666667
CONST q2pi = 0.63661977236758134307553505349005744813783858296183
CONST q2sqrt5 = 0.89442719099991587856366946749251049417624734384461
CONST rad2deg = 57.2957795130823208767981548141051703324054724665643
CONST sqrt02 = 0.44721359549995793928183473374625524708812367192231
CONST sqrt05 = 0.70710678118654752440084436210484903928483593768847
CONST sqrt075 = 0.86602540378443864676372317075293618347140262690519
CONST y2q112 = 1.05946309435929526456182529494634170077920431749419 ' Chromatic base

'####################################################################################################################
'# Screen mode selector v1.0 (include)
'# By Zom-B
'####################################################################################################################

videoaspect:
DATA "all aspect",15
DATA "4:3",11
DATA "16:10",10
DATA "16:9",14
DATA "5:4",13
DATA "3:2",12
DATA "5:3",9
DATA "1:1",7
DATA "other",8
DATA ,

videomodes:
DATA 256,256,7
DATA 320,240,1
DATA 400,300,1
DATA 512,384,1
DATA 512,512,7
DATA 640,480,1
DATA 720,540,1
DATA 768,576,1
DATA 800,480,2
DATA 800,600,1
DATA 854,480,3
DATA 1024,600,8
DATA 1024,640,2
DATA 1024,768,1
DATA 1024,1024,7
DATA 1152,768,5
DATA 1152,864,1
DATA 1280,720,3
DATA 1280,768,6
DATA 1280,800,2
DATA 1280,854,5
DATA 1280,960,1
DATA 1280,1024,4
DATA 1366,768,3
DATA 1400,1050,1
DATA 1440,900,2
DATA 1440,960,5
DATA 1600,900,3
DATA 1600,1200,1
DATA 1680,1050,2
DATA 1920,1080,3
DATA 1920,1200,2
DATA 2048,1152,3
DATA 2048,1536,1
DATA 2048,2048,7
DATA ,,

'####################################################################################################################
'# Ultra Fractal Gradient library v1.0 (include)
'# By Zom-B
'#
'# Smooth Gradient algorithm from Ultra Fractal (www.ultrafractal.com)
'####################################################################################################################

TYPE GRADIENTPOINT
    index AS SINGLE
    r AS SINGLE
    g AS SINGLE
    b AS SINGLE
    rdr AS SINGLE
    rdl AS SINGLE
    gdr AS SINGLE
    gdl AS SINGLE
    bdr AS SINGLE
    bdl AS SINGLE
END TYPE

'$dynamic

DIM SHARED gradientSmooth(1) AS _BYTE '_BIT <- bugged
DIM SHARED gradientPoints(1) AS INTEGER
DIM SHARED gradient(1, 1) AS GRADIENTPOINT


'####################################################################################################################
'# InterestingSpiral2
'# By Zom-B
'#
'# Original art by Mark Hammond (markch1@mindspring.com) (Sep 10, 2002)
'####################################################################################################################

CONST Doantialias = -1
CONST Usegaussian = 0

'####################################################################################################################

_TITLE "Hearts and Butterflies"
WIDTH 80, 40

COLOR 11
PRINT
PRINT TAB(29); "Hearts and Butterflies"
COLOR 7
PRINT
PRINT TAB(4); "Original artwork by Joy A. Stevenson <jars7@bellsouth.net> (Sep 6, 2002)"
PRINT TAB(29); "Palette tweak by Zom-B"
PRINT TAB(19); "Converted to Quick Basic and QB64 by Zom-B"

selectScreenMode 7, 32

'####################################################################################################################

DIM SHARED sizeX%, sizeY%
DIM SHARED maxX%, maxY%
DIM SHARED halfX%, halfY%

sizeX% = _WIDTH
sizeY% = _HEIGHT
maxX% = sizeX% - 1
maxY% = sizeY% - 1
halfX% = sizeX% \ 2
halfY% = sizeY% \ 2

DIM SHARED magn

magn = 0.92905402789825371908069484570116 / halfY%

DIM SHARED px, py
DIM SHARED zx(100), zy(100), numIter%

'####################################################################################################################

setNumGradients 2

addGradientPoint 0, -0.0850, 0.314, 0.004, 0.000
addGradientPoint 0, 0.1325, 0.988, 0.627, 0.471
addGradientPoint 0, 0.3075, 0.235, 0.000, 0.000
addGradientPoint 0, 0.5425, 1.000, 1.000, 1.000
addGradientPoint 0, 0.6850, 0.314, 0.000, 0.000
addGradientPoint 0, 0.7675, 1.000, 0.616, 0.906
addGradientPoint 0, 0.8625, 0.996, 0.098, 0.000
addGradientPoint 0, 0.9150, 0.314, 0.004, 0.000
addGradientPoint 0, 1.1325, 0.988, 0.627, 0.471
setGradientSmooth 0, -1

addGradientPoint 1, -0.0975, 0.988, 0.902, 0.627
addGradientPoint 1, 0.0150, 0.314, 0.000, 0.000
addGradientPoint 1, 0.0925, 0.482, 0.161, 0.161
addGradientPoint 1, 0.3875, 0.988, 0.471, 0.471
addGradientPoint 1, 0.4575, 0.235, 0.000, 0.000
addGradientPoint 1, 0.6050, 1.000, 0.459, 0.459
addGradientPoint 1, 0.7025, 0.314, 0.000, 0.000
addGradientPoint 1, 0.9025, 0.988, 0.902, 0.627
addGradientPoint 1, 1.0150, 0.314, 0.000, 0.000
setGradientSmooth 1, -1

renderProgressive 256, 4

i$ = INPUT$(1)
END

'####################################################################################################################

SUB renderProgressive (startSize%, endSize%)
    pixStep% = startSize%

    pixWidth% = pixStep% - 1
    FOR y% = 0 TO maxY% STEP pixStep%
        FOR x% = 0 TO maxX% STEP pixStep%
            calcPoint x%, y%, r%, g%, b%
            LINE (x%, y%)-STEP(pixWidth%, pixWidth%), _RGB(r%, g%, b%), BF
        NEXT
        IF INKEY$ = CHR$(27) THEN SYSTEM
    NEXT

    WHILE pixStep% > 2
        pixSize% = pixStep% \ 2
        pixWidth% = pixSize% - 1
        FOR y% = 0 TO maxY% STEP pixStep%
            y1% = y% + pixSize%
            FOR x% = 0 TO maxX% STEP pixStep%
                x1% = x% + pixSize%

                IF x1% < sizeX% THEN
                    calcPoint x1%, y%, r%, g%, b%
                    LINE (x1%, y%)-STEP(pixWidth%, pixWidth%), _RGB(r%, g%, b%), BF
                END IF
                IF y1% < sizeY% THEN
                    calcPoint x%, y1%, r%, g%, b%
                    LINE (x%, y1%)-STEP(pixWidth%, pixWidth%), _RGB(r%, g%, b%), BF
                    IF x1% < sizeX% THEN
                        calcPoint x1%, y1%, r%, g%, b%
                        LINE (x1%, y1%)-STEP(pixWidth%, pixWidth%), _RGB(r%, g%, b%), BF
                    END IF
                END IF
            NEXT
            IF INKEY$ = CHR$(27) THEN SYSTEM
        NEXT
        pixStep% = pixStep% \ 2
    WEND

    FOR y% = 0 TO maxY% STEP 2
        y1% = y% + 1
        FOR x% = 0 TO maxX% STEP 2
            x1% = x% + 1

            IF x1% < sizeX% THEN
                calcPoint x1%, y%, r%, g%, b%
                PSET (x1%, y%), _RGB(r%, g%, b%)
            END IF
            IF y1% < sizeY% THEN
                calcPoint x%, y1%, r%, g%, b%
                PSET (x%, y1%), _RGB(r%, g%, b%)
                IF x1% < sizeX% THEN
                    calcPoint x1%, y1%, r%, g%, b%
                    PSET (x1%, y1%), _RGB(r%, g%, b%)
                END IF
            END IF
        NEXT
        IF INKEY$ = CHR$(27) THEN SYSTEM
    NEXT

    IF NOT Doantialias THEN EXIT SUB

    endArea% = endSize% * endSize%

    IF Usegaussian THEN
        FOR y% = 0 TO maxY%
            FOR x% = 0 TO maxX%
                c& = POINT(x%, y%)
                r% = _RED(c&)
                g% = _GREEN(c&)
                b% = _BLUE(c&)
                FOR i% = 2 TO endArea%
                    DO 'Marsaglia polar method for random gaussian
                        u! = RND * 2 - 1
                        v! = RND * 2 - 1
                        s! = u! * u! + v! * v!
                    LOOP WHILE s! >= 1 OR s! = 0
                    s! = SQR(-2 * LOG(s!) / s!) * 0.5
                    u! = u! * s!
                    v! = v! * s!

                    calcPoint x% + u!, y% + v!, r1%, g1%, b1%

                    r% = r% + r1%
                    g% = g% + g1%
                    b% = b% + b1%
                NEXT

                PSET (x%, y%), _RGB(CINT(r% / endArea%), CINT(g% / endArea%), CINT(b% / endArea%))
                IF INKEY$ = CHR$(27) THEN SYSTEM
            NEXT
        NEXT
    ELSE
        FOR y% = 0 TO maxY%
            FOR x% = 0 TO maxX%
                r% = 0
                g% = 0
                b% = 0
                FOR v% = 0 TO endSize% - 1
                    y1! = y% + v% / endSize%
                    FOR u% = 0 TO endSize% - 1
                        IF u% = 0 AND v& = 0 THEN
                            c& = POINT(x%, y%)
                        ELSE
                            x1! = x% + u% / endSize%
                            calcPoint x1!, y1!, r1%, g1%, b1%
                        END IF
                        r% = r% + r1%
                        g% = g% + g1%
                        b% = b% + b1%
                    NEXT
                NEXT
                PSET (x%, y%), _RGB(CINT(r% / endArea%), CINT(g% / endArea%), CINT(b% / endArea%))
                IF INKEY$ = CHR$(27) THEN SYSTEM
            NEXT
        NEXT
    END IF
END SUB

'####################################################################################################################

SUB calcPoint (screenX!, screenY!, r%, g%, b%)
    applyLocation screenX!, screenY!

    calcFractal

    IF numIter% < 100 THEN
        calcOutside index1!, index2!

        getGradient 0, index1!, r!, g!, b!
        getGradient 1, index2!, r2!, g2!, b2!

        mergeHSLAddition r!, g!, b!, r2!, g2!, b2!
    ELSE
        'r! = 0: g! = 0: b! = 0
    END IF

    r% = r! * 255
    g% = g! * 255
    b% = b! * 255
END SUB

'####################################################################################################################

SUB applyLocation (inX!, inY!)
    px = (inX! - halfX%) * magn + 1.27027027032
    py = (halfY% - inY!) * magn + -.02027027035
END SUB

'####################################################################################################################

SUB calcFractal
    zx(0) = px: zy(0) = py
    x = px: y = py

    outside% = false
    FOR numIter% = 1 TO 100
        t = x
        x = t * 0.3508212350261158# - y * 1.1517464294873868# + .9287217468784809#
        y = y * 0.3508212350261158# + t * 1.1517464294873868# - 1.296066350576871#

        zx(numIter%) = x: zy(numIter%) = y

        IF x * x + y * y >= 44 THEN EXIT FOR
    NEXT

    numIter% = numIter% - 1
END SUB

'####################################################################################################################

SUB calcOutside (index1!, index2!)
    dist1 = 1E38: dist2 = 1E38
    FOR a% = 1 TO numIter%
        x = zx(a%): y = zy(a%)
        ax = ABS(x)
        r2 = x * x + y * y
        r = SQR(r2)

        y2 = r - ax
        dy = y2 * y2 - 1
        IF dy < 0 THEN
            x2 = LOG(y2 * y2 - dy) * 0.5
            y2 = ATN(SQR(-dy) / y2)
            dx = x2 * x2 + y2 * y2
            x2 = x - dx + r2 * r2
            y2 = y - 2 * SQR(dx) * r2
        ELSE
            x2 = y2 + SQR(dy)
            dx = LOG(x2 * x2) / 2
            x2 = x - dx * dx + r2 * r2
            y2 = y - 2 * dx * r2
        END IF

        x2 = x2 * x2 + y2 * y2
        IF dist2 > x2 THEN dist2 = x2

        y2 = ABS(ax - r)

        dy = y2 * y2 - 1
        IF dy < 0 THEN
            dy = SQR(-dy)
            x2 = LOG(y2 * y2 + dy * dy) * 0.5
            y2 = ATN(dy / (y2 + .0000001))
            dx = SQR(x2 * x2 + y2 * y2)
        ELSE
            dx = LOG(y2 + SQR(dy))
        END IF

        dy = r - ABS(ABS(ABS(y) + x) - r) / r
        dx = dx - 3 * (dy + ABS(dy))

        x2 = x + dx * dx - dy * dy
        y2 = y + 2 * dx * dy

        x2 = x2 * x2 + y2 * y2
        IF dist1 > x2 THEN dist1 = x2
    NEXT
    dist1 = SQR(dist1) ^ .1
    dist2 = SQR(dist2) ^ .1

    r = 1 - dist1 * dist1
    IF r < 0 THEN
        y = SQR(-r) + dist1
        x = LOG(y * y) * 0.5
        dist1 = x * x + 2.467401100272339#
    ELSE
        y = SQR(r)
        x = LOG(y * y + dist1 * dist1) * 0.5
        y = ATN(dist1 / (y + .0000001))
        dist1 = x * x + y * y
    END IF

    index1! = SQR(dist1) * 0.5

    r = 1 - dist2 * dist2
    IF r < 0 THEN
        y = SQR(-r) + dist2
        x = LOG(y * y) * 0.5
        y = 1.570796326794897#
    ELSE
        r = SQR(r)
        x = LOG(r * r + dist2 * dist2) * 0.5
        y = ATN(dist2 / r)
    END IF

    x2 = x * x - y * y
    y2 = 2 * x * y
    index2! = SQR(SQR(x2 * x2 + y2 * y2)) * 0.5
END SUB

'####################################################################################################################
'# Math Library V0.11 (routines)
'# By Zom-B
'####################################################################################################################

'> merger: Skipping unused FUNCTION remainder% (a%, b%)

'> merger: Skipping unused FUNCTION fRemainder (a, b)

'####################################################################################################################

'> merger: Skipping unused FUNCTION safeLog (x)

'####################################################################################################################

'> merger: Skipping unused FUNCTION asin (y)

'> merger: Skipping unused FUNCTION acos (y)

'> merger: Skipping unused FUNCTION safeAcos (y)

'> merger: Skipping unused FUNCTION atan2 (y, x)

'####################################################################################################################
'# Screen mode selector v1.0 (routines)
'# By Zom-B
'####################################################################################################################

SUB selectScreenMode (yOffset%, colors%)
    DIM aspectName$(10), aspectCol%(10)
    RESTORE videoaspect
    FOR y% = 0 TO 10
        READ aspectName$(y%), aspectCol%(y%)
        IF aspectCol%(y%) = 0 THEN numAspect% = y% - 1: EXIT FOR
    NEXT

    DIM vidX%(100), vidY%(100), vidA%(100)
    RESTORE videomodes
    FOR y% = 1 TO 100
        READ vidX%(y%), vidY%(y%), vidA%(y%)
        IF (vidX%(y%) <= 0) THEN numModes% = y% - 1: EXIT FOR
    NEXT

    IF numModes% > _HEIGHT - yOffset% - 1 THEN numModes% = _HEIGHT - yOffset% - 1

    DEF SEG = &HB800
    LOCATE yOffset% + 1, 1
    PRINT "Select video mode:"; TAB(61); "Click "
    POKE yOffset% * 160 + 132, 31

    y% = 0
    lastY% = 0
    selectedAspect% = 0
    reprint% = 1
    lastButton% = 0
    DO
        IF INKEY$ = CHR$(27) THEN CLS: SYSTEM
        IF reprint% THEN
            reprint% = 0

            FOR x% = 1 TO numModes%
                LOCATE yOffset% + x% + 1, 1
                COLOR 7, 0
                PRINT USING "##:"; x%;
                IF selectedAspect% = 0 THEN
                    COLOR aspectCol%(vidA%(x%))
                ELSEIF selectedAspect% = vidA%(x%) THEN
                    COLOR 15
                ELSE
                    COLOR 8
                END IF
                PRINT STR$(vidX%(x%)); ","; vidY%(x%);
            NEXT

            FOR x% = 0 TO numAspect%
                IF x% > 0 AND selectedAspect% = x% THEN
                    COLOR aspectCol%(x%), 3
                ELSE
                    COLOR aspectCol%(x%), 0
                END IF
                LOCATE yOffset% + x% + 2, 64
                PRINT "<"; aspectName$(x%); ">"
            NEXT
        END IF
        IF _MOUSEINPUT THEN
            IF lastY% > 0 THEN
                FOR x% = 0 TO 159 STEP 2
                    POKE lastY% + x%, PEEK(lastY% + x%) AND &HEF
                NEXT
            END IF

            x% = _MOUSEX
            y% = _MOUSEY - yOffset% - 1

            IF x% <= 60 THEN
                IF y% > 0 AND y% <= numModes% THEN
                    IF _MOUSEBUTTON(1) = 0 AND lastButton% THEN EXIT DO
                    y% = (yOffset% + y%) * 160 + 1
                    FOR x% = 0 TO 119 STEP 2
                        POKE y% + x%, PEEK(y% + x%) OR &H10
                    NEXT
                ELSE
                    y% = 0
                END IF
            ELSE
                IF y% > 0 AND y% - 1 <= numAspect% THEN
                    IF _MOUSEBUTTON(1) THEN
                        selectedAspect% = y% - 1
                        reprint% = 1
                    END IF
                    y% = (yOffset% + y%) * 160 + 1
                    FOR x% = 120 TO 159 STEP 2
                        POKE y% + x%, PEEK(y% + x%) OR &H10
                    NEXT
                ELSE
                    y% = 0
                END IF
            END IF
            lastY% = y%
            lastButton% = _MOUSEBUTTON(1)
        END IF
    LOOP

    CLS 'bug evasion for small video modes
    SCREEN _NEWIMAGE(vidX%(y%), vidY%(y%), colors%)
END SUB

'####################################################################################################################
'# Ultra Fractal Gradient library v1.1 (routines)
'# By Zom-B
'#
'# Smooth Gradient algorithm from Ultra Fractal (www.ultrafractal.com)
'####################################################################################################################

'> merger: Skipping unused SUB defaultGradient (gi%)

'> merger: Skipping unused SUB grayscaleGradient (gi%)

'####################################################################################################################

SUB setNumGradients (gi%)
    offset% = LBOUND(gradientPoints) - 1
    REDIM _PRESERVE gradientSmooth(gi% + offset%) AS _BYTE '_BIT <- bugged
    REDIM _PRESERVE gradientPoints(gi% + offset%) AS INTEGER
    REDIM _PRESERVE gradient(gi% + offset%, 1) AS GRADIENTPOINT
END FUNCTION

SUB addGradientPoint (gi%, index!, r!, g!, b!)
    p% = gradientPoints(gi%)

    IF UBOUND(gradient, 2) < p% THEN
        REDIM _PRESERVE gradient(0 TO UBOUND(gradient, 1), 0 TO p%) AS GRADIENTPOINT
    END IF

    gradient(gi%, p%).index = index!
    gradient(gi%, p%).r = r!
    gradient(gi%, p%).g = g!
    gradient(gi%, p%).b = b!
    gradientPoints(gi%) = p% + 1
END SUB

SUB setGradientSmooth (gi%, s%)
    gradientSmooth(gi%) = s%

    IF gradientSmooth(0) = 0 THEN EXIT SUB

    FOR i% = 0 TO gradientPoints(gi%) - 1
        ip1% = i% + 1
        IF ip1% = gradientPoints(gi%) THEN ip1% = 2
        in1% = i% - 1
        IF in1% = -1 THEN in1% = gradientPoints(gi%) - 3

        dxl! = gradient(gi%, i%).index - gradient(gi%, in1%).index
        dxr! = gradient(gi%, ip1%).index - gradient(gi%, i%).index
        IF dxl! < 0 THEN dxl! = dxl! + 1
        IF dxr! < 0 THEN dxr! = dxr! + 1

        d! = (gradient(gi%, i%).r - gradient(gi%, in1%).r) * dxr!
        IF d! = 0 THEN
            gradient(gi%, i%).rdr = 0
            gradient(gi%, i%).rdl = 0
        ELSE
            d! = (gradient(gi%, ip1%).r - gradient(gi%, i%).r) * dxl! / d!
            IF d! <= 0 THEN
                gradient(gi%, i%).rdr = 0
                gradient(gi%, i%).rdl = 0
            ELSE
                gradient(gi%, i%).rdr = 1 / (1 + d!)
                gradient(gi%, i%).rdl = gradient(gi%, i%).rdr - 1
            END IF
        END IF

        d! = (gradient(gi%, i%).g - gradient(gi%, in1%).g) * dxr!
        IF d! = 0 THEN
            gradient(gi%, i%).gdr = 0
            gradient(gi%, i%).gdl = 0
        ELSE
            d! = (gradient(gi%, ip1%).g - gradient(gi%, i%).g) * dxl! / d!
            IF d! <= 0 THEN
                gradient(gi%, i%).gdr = 0
                gradient(gi%, i%).gdl = 0
            ELSE
                gradient(gi%, i%).gdr = 1 / (1 + d!)
                gradient(gi%, i%).gdl = gradient(gi%, i%).gdr - 1
            END IF
        END IF

        d! = (gradient(gi%, i%).b - gradient(gi%, in1%).b) * dxr!
        IF d! = 0 THEN
            gradient(gi%, i%).bdr = 0
            gradient(gi%, i%).bdl = 0
        ELSE
            d! = (gradient(gi%, ip1%).b - gradient(gi%, i%).b) * dxl! / d!
            IF d! <= 0 THEN
                gradient(gi%, i%).bdr = 0
                gradient(gi%, i%).bdl = 0
            ELSE
                gradient(gi%, i%).bdr = 1 / (1 + d!)
                gradient(gi%, i%).bdl = gradient(gi%, i%).bdr - 1
            END IF
        END IF
    NEXT
END SUB

'####################################################################################################################

SUB getGradient (gi%, index!, red!, green!, blue!)
    IF index! < 0 THEN x! = 0 ELSE x! = index! - INT(index!)

    FOR l% = gradientPoints(gi%) - 2 TO 1 STEP -1
        IF gradient(gi%, l%).index <= x! THEN
            EXIT FOR
        END IF
    NEXT

    r% = l% + 1
    u! = (x! - gradient(gi%, l%).index) / (gradient(gi%, r%).index - gradient(gi%, l%).index)

    IF gradientSmooth(gi%) THEN
        u2! = u! * u!
        u3! = u2! * u!
        ur! = u3! - (u2! + u2!) + u!
        ul! = u2! - u3!

        red! = gradient(gi%, l%).r + (gradient(gi%, r%).r - gradient(gi%, l%).r) * (u3! + 3 * (gradient(gi%, l%).rdr * ur! + (1 + gradient(gi%, r%).rdl) * ul!))
        green! = gradient(gi%, l%).g + (gradient(gi%, r%).g - gradient(gi%, l%).g) * (u3! + 3 * (gradient(gi%, l%).gdr * ur! + (1 + gradient(gi%, r%).gdl) * ul!))
        blue! = gradient(gi%, l%).b + (gradient(gi%, r%).b - gradient(gi%, l%).b) * (u3! + 3 * (gradient(gi%, l%).bdr * ur! + (1 + gradient(gi%, r%).bdl) * ul!))
    ELSE
        red! = gradient(gi%, l%).r + (gradient(gi%, r%).r - gradient(gi%, l%).r) * u!
        green! = gradient(gi%, l%).g + (gradient(gi%, r%).g - gradient(gi%, l%).g) * u!
        blue! = gradient(gi%, l%).b + (gradient(gi%, r%).b - gradient(gi%, l%).b) * u!
    END IF
END SUB

'> merger: Skipping unused SUB testGradient (gi%)

'####################################################################################################################
'# Merge modes library v0.11 (routines)
'# By Zom-B
'####################################################################################################################

'> merger: Skipping unused SUB testMerge

'####################################################################################################################

'> merger: Skipping unused SUB mergeOverlay (br!, bg!, bb!, tr!, tg!, tb!)

'> merger: Skipping unused SUB mergeHardLight (br!, bg!, bb!, tr!, tg!, tb!)

'> merger: Skipping unused SUB mergeSoftLight (br!, bg!, bb!, tr!, tg!, tb!)

'> merger: Skipping unused SUB mergeColor (r!, g!, b!, r2!, g2!, b2!)

SUB mergeHSLAddition (r!, g!, b!, r2!, g2!, b2!)
    largest! = r!
    smallest! = r!
    IF largest! < g! THEN largest! = g!
    IF smallest! > g! THEN smallest! = g!
    IF largest! < b! THEN largest! = b!
    IF smallest! > b! THEN smallest! = b!

    lum! = (largest! + smallest!) * 0.5
    chr! = largest! - smallest!

    IF lum! < 0.5 THEN
        sat! = chr! / (2 * lum!)
    ELSE
        sat! = chr! / (2 - 2 * lum!)
    END IF
    IF chr! = 0 THEN
        hue! = 0
    ELSEIF largest! = r! THEN
        hue! = (g! - b!) / chr!
    ELSEIF largest! = g! THEN
        hue! = (b! - r!) / chr! + 2
    ELSE
        hue! = (r! - g!) / chr! + 4
    END IF

    largest! = r2!
    smallest! = r2!
    IF largest! < g2! THEN largest! = g2!
    IF smallest! > g2! THEN smallest! = g2!
    IF largest! < b2! THEN largest! = b2!
    IF smallest! > b2! THEN smallest! = b2!

    lum2! = (largest! + smallest!) * 0.5
    chr2! = largest! - smallest!

    IF lum2! < 0.5 THEN
        sat2! = chr2! / (2 * lum2!)
    ELSE
        sat2! = chr2! / (2 - 2 * lum2!)
    END IF
    IF chr2! = 0 THEN
        hue! = hue!
    ELSEIF largest! = r2! THEN
        hue! = hue! + (g2! - b2!) / chr2!
    ELSEIF largest! = g2! THEN
        hue! = hue! + (b2! - r2!) / chr2! + 2
    ELSE
        hue! = hue! + (r2! - g2!) / chr2! + 4
    END IF
    IF hue! < 0 THEN hue! = hue! + 6 ELSE IF hue! > 6 THEN hue! = hue! - 6

    sat! = sat! + sat2! - 0.5: IF sat! < 0 THEN sat! = 0 ELSE IF sat! > 1 THEN sat! = 1
    lum! = lum! + lum2! - 0.5: IF lum! < 0 THEN lum! = 0 ELSE IF lum! > 1 THEN lum! = 1

    IF lum! < 0.5 THEN
        chr! = sat! * 2 * lum!
    ELSE
        chr! = sat! * (2 - 2 * lum!)
    END IF

    smallest! = lum! - chr! * 0.5

    x! = chr! * (1 - ABS(hue! - INT(hue! / 2) * 2 - 1))
    SELECT CASE hue!
        CASE IS <= 1: r! = chr! + smallest!: g! = x! + smallest!: b! = smallest!
        CASE IS <= 2: r! = x! + smallest!: g! = chr! + smallest!: b! = smallest!
        CASE IS <= 3: r! = smallest!: g! = chr! + smallest!: b! = x! + smallest!
        CASE IS <= 4: r! = smallest!: g! = x! + smallest!: b! = chr! + smallest!
        CASE IS <= 5: r! = x! + smallest!: g! = smallest!: b! = chr! + smallest!
        CASE ELSE: r! = chr! + smallest!: g! = smallest!: b! = x! + smallest!
    END SELECT
END SUB

'####################################################################################################################

'> merger: Skipping unused SUB mergeHue (r!, g!, b!, r2!, g2!, b2!)

'> merger: Skipping unused SUB rgb2hsl (r!, g!, b!, chr!, smallest!, hue!, sat!, lum!)

'> merger: Skipping unused SUB hsl2rgb (hue!, sat!, lum!, r!, g!, b!)

'> merger: Skipping unused SUB hsl2rgb2 (hue!, chr!, smallest!, r!, g!, b!)

```

#### interestingspiral2.bas

```vb

'> Merged with Zom-B's smart $include merger 0.51

DEFDBL A-Z

'####################################################################################################################
'# Math Library V1.0 (include)
'# By Zom-B
'####################################################################################################################

CONST sqrt2 = 1.41421356237309504880168872420969807856967187537695 ' Knuth01
CONST sqrt3 = 1.73205080756887729352744634150587236694280525381038 ' Knuth02
CONST sqrt5 = 2.23606797749978969640917366873127623544061835961153 ' Knuth03
CONST sqrt10 = 3.16227766016837933199889354443271853371955513932522 ' Knuth04
CONST cubert2 = 1.25992104989487316476721060727822835057025146470151 ' Knuth05
CONST cubert3 = 1.44224957030740838232163831078010958839186925349935 ' Knuth06
CONST q2pow025 = 1.18920711500272106671749997056047591529297209246382 ' Knuth07
CONST phi = 1.61803398874989484820458683436563811772030917980576 ' Knuth08
CONST log2 = 0.69314718055994530941723212145817656807550013436026 ' Knuth09
CONST log3 = 1.09861228866810969139524523692252570464749055782275 ' Knuth10
CONST log10 = 2.30258509299404568401799145468436420760110148862877 ' Knuth11
CONST logpi = 1.14472988584940017414342735135305871164729481291531 ' Knuth12
CONST logphi = 0.48121182505960344749775891342436842313518433438566 ' Knuth13
CONST q1log2 = 1.44269504088896340735992468100189213742664595415299 ' Knuth14
CONST q1log10 = 0.43429448190325182765112891891660508229439700580367 ' Knuth15
CONST q1logphi = 2.07808692123502753760132260611779576774219226778328 ' Knuth16
CONST pi = 3.14159265358979323846264338327950288419716939937511 ' Knuth17
CONST deg2rad = 0.01745329251994329576923690768488612713442871888542 ' Knuth18
CONST q1pi = 0.31830988618379067153776752674502872406891929148091 ' Knuth19
CONST pisqr = 9.86960440108935861883449099987615113531369940724079 ' Knuth20
CONST gamma05 = 1.7724538509055160272981674833411451827975494561224 '  Knuth21
CONST gamma033 = 2.6789385347077476336556929409746776441286893779573 '  Knuth22
CONST gamma067 = 1.3541179394264004169452880281545137855193272660568 '  Knuth23
CONST e = 2.71828182845904523536028747135266249775724709369996 ' Knuth24
CONST q1e = 0.36787944117144232159552377016146086744581113103177 ' Knuth25
CONST esqr = 7.38905609893065022723042746057500781318031557055185 ' Knuth26
CONST eulergamma = 0.57721566490153286060651209008240243104215933593992 ' Knuth27
CONST expeulergamma = 1.7810724179901979852365041031071795491696452143034 '  Knuth28
CONST exppi025 = 2.19328005073801545655976965927873822346163764199427 ' Knuth29
CONST sin1 = 0.84147098480789650665250232163029899962256306079837 ' Knuth30
CONST cos1 = 0.54030230586813971740093660744297660373231042061792 ' Knuth31
CONST zeta3 = 1.2020569031595942853997381615114499907649862923405 '  Knuth32
CONST nloglog2 = 0.36651292058166432701243915823266946945426344783711 ' Knuth33

CONST logr10 = 0.43429448190325182765112891891660508229439700580367
CONST logr2 = 1.44269504088896340735992468100189213742664595415299
CONST pi05 = 1.57079632679489661923132169163975144209858469968755
CONST pi2 = 6.28318530717958647692528676655900576839433879875021
CONST q05log10 = 0.21714724095162591382556445945830254114719850290183
CONST q05log2 = 0.72134752044448170367996234050094606871332297707649
CONST q05pi = 0.15915494309189533576888376337251436203445964574046
CONST q13 = 0.33333333333333333333333333333333333333333333333333
CONST q16 = 0.16666666666666666666666666666666666666666666666667
CONST q2pi = 0.63661977236758134307553505349005744813783858296183
CONST q2sqrt5 = 0.89442719099991587856366946749251049417624734384461
CONST rad2deg = 57.2957795130823208767981548141051703324054724665643
CONST sqrt02 = 0.44721359549995793928183473374625524708812367192231
CONST sqrt05 = 0.70710678118654752440084436210484903928483593768847
CONST sqrt075 = 0.86602540378443864676372317075293618347140262690519
CONST y2q112 = 1.05946309435929526456182529494634170077920431749419 ' Chromatic base

'####################################################################################################################
'# Screen mode selector v1.0 (include)
'# By Zom-B
'####################################################################################################################

videoaspect:
DATA "all aspect",15
DATA "4:3",11
DATA "16:10",10
DATA "16:9",14
DATA "5:4",13
DATA "3:2",12
DATA "5:3",9
DATA "1:1",7
DATA "other",8
DATA ,

videomodes:
DATA 256,256,7
DATA 320,240,1
DATA 400,300,1
DATA 512,384,1
DATA 512,512,7
DATA 640,480,1
DATA 720,540,1
DATA 768,576,1
DATA 800,480,2
DATA 800,600,1
DATA 854,480,3
DATA 1024,600,8
DATA 1024,640,2
DATA 1024,768,1
DATA 1024,1024,7
DATA 1152,768,5
DATA 1152,864,1
DATA 1280,720,3
DATA 1280,768,6
DATA 1280,800,2
DATA 1280,854,5
DATA 1280,960,1
DATA 1280,1024,4
DATA 1366,768,3
DATA 1400,1050,1
DATA 1440,900,2
DATA 1440,960,5
DATA 1600,900,3
DATA 1600,1200,1
DATA 1680,1050,2
DATA 1920,1080,3
DATA 1920,1200,2
DATA 2048,1152,3
DATA 2048,1536,1
DATA 2048,2048,7
DATA ,,

'####################################################################################################################
'# Ultra Fractal Gradient library v1.0 (include)
'# By Zom-B
'#
'# Smooth Gradient algorithm from Ultra Fractal (www.ultrafractal.com)
'####################################################################################################################

TYPE GRADIENTPOINT
    index AS SINGLE
    r AS SINGLE
    g AS SINGLE
    b AS SINGLE
    rdr AS SINGLE
    rdl AS SINGLE
    gdr AS SINGLE
    gdl AS SINGLE
    bdr AS SINGLE
    bdl AS SINGLE
END TYPE

'$dynamic

DIM SHARED gradientSmooth(1) AS _BYTE '_BIT <- bugged
DIM SHARED gradientPoints(1) AS INTEGER
DIM SHARED gradient(1, 1) AS GRADIENTPOINT

'####################################################################################################################
'# Ultra Fractal Gradient library v1.0 (include)
'# By Zom-B
'#
'# Smooth Gradient algorithm from Ultra Fractal (www.ultrafractal.com)
'####################################################################################################################

TYPE OPACITYPOINT
    index AS SINGLE
    o AS SINGLE
    odr AS SINGLE
    odl AS SINGLE
END TYPE

'$dynamic

DIM SHARED opacitySmooth(0 TO 0) AS _BYTE '_BIT <- bugged
DIM SHARED opacityPoints(0 TO 0) AS INTEGER
DIM SHARED opacity(0 TO 0, 0 TO 0) AS OPACITYPOINT


'####################################################################################################################
'# InterestingSpiral2
'# By Zom-B
'#
'# Original art by Mark Hammond (markch1@mindspring.com) (Sep 10, 2002)
'####################################################################################################################

CONST Doantialias = -1
CONST Usegaussian = 0

'####################################################################################################################

_TITLE "InterestingSpiral2"
WIDTH 80, 40

COLOR 11
PRINT
PRINT TAB(31); "InterestingSpiral2"
COLOR 7
PRINT
PRINT TAB(6); "Original art by Mark Hammond (markch1@mindspring.com) (Sep 10, 2002)"
PRINT TAB(19); "Converted to Quick Basic and QB64 by Zom-B"

selectScreenMode 6, 32

'####################################################################################################################

DIM SHARED sizeX%, sizeY%
DIM SHARED maxX%, maxY%
DIM SHARED halfX%, halfY%

sizeX% = _WIDTH
sizeY% = _HEIGHT
maxX% = sizeX% - 1
maxY% = sizeY% - 1
halfX% = sizeX% \ 2
halfY% = sizeY% \ 2

DIM SHARED zx(250), zy(250)
DIM SHARED px, py
DIM SHARED magn

magn = 0.375 / halfY%

'####################################################################################################################

setNumGradients 2
setNumOpacities 2

addGradientPoint 0, -0.1150, 0.780, 0.553, 0.420
addGradientPoint 0, 0.0450, 0.169, 0.000, 0.000
addGradientPoint 0, 0.2175, 0.992, 0.878, 0.741
addGradientPoint 0, 0.3850, 0.169, 0.000, 0.000
addGradientPoint 0, 0.5525, 0.725, 0.694, 0.600
addGradientPoint 0, 0.7200, 0.169, 0.000, 0.000
addGradientPoint 0, 0.8850, 0.780, 0.553, 0.420
addGradientPoint 0, 1.0450, 0.169, 0.000, 0.000
setGradientSmooth 0, -1

addGradientPoint 1, -0.140, 0.502, 0.251, 0.063
addGradientPoint 1, 0.110, 0.502, 0.251, 0.063
addGradientPoint 1, 0.235, 0.706, 0.502, 0.251
addGradientPoint 1, 0.360, 0.867, 0.749, 0.561
addGradientPoint 1, 0.485, 1.000, 1.000, 1.000
addGradientPoint 1, 0.610, 0.867, 0.749, 0.561
addGradientPoint 1, 0.735, 0.706, 0.502, 0.251
addGradientPoint 1, 0.860, 0.502, 0.251, 0.063
addGradientPoint 1, 1.110, 0.502, 0.251, 0.063
setGradientSmooth 1, -1

addOpacityPoint 0, -0.210, 0
addOpacityPoint 0, 0.285, 1
addOpacityPoint 0, 0.790, 0
addOpacityPoint 0, 1.285, 1
setOpacitySmooth 0, -1

addOpacityPoint 1, -0.0025, 0
addOpacityPoint 1, 0.4975, 1
addOpacityPoint 1, 0.9975, 0
addOpacityPoint 1, 1.4975, 1
setOpacitySmooth 1, -1

renderProgressive 256, 4

i$ = INPUT$(1)
END

'####################################################################################################################

SUB renderProgressive (startSize%, endSize%)
    pixStep% = startSize%

    pixWidth% = pixStep% - 1
    FOR y% = 0 TO maxY% STEP pixStep%
        FOR x% = 0 TO maxX% STEP pixStep%
            calcPoint x%, y%, r%, g%, b%
            LINE (x%, y%)-STEP(pixWidth%, pixWidth%), _RGB(r%, g%, b%), BF
        NEXT
        IF INKEY$ = CHR$(27) THEN SYSTEM
    NEXT

    DO
        pixSize% = pixStep% \ 2
        pixWidth% = pixSize% - 1
        FOR y% = 0 TO maxY% STEP pixStep%
            y1% = y% + pixSize%
            FOR x% = 0 TO maxX% STEP pixStep%
                x1% = x% + pixSize%

                IF x1% < sizeX% THEN
                    calcPoint x1%, y%, r%, g%, b%
                    LINE (x1%, y%)-STEP(pixWidth%, pixWidth%), _RGB(r%, g%, b%), BF
                END IF
                IF y1% < sizeY% THEN
                    calcPoint x%, y1%, r%, g%, b%
                    LINE (x%, y1%)-STEP(pixWidth%, pixWidth%), _RGB(r%, g%, b%), BF
                    IF x1% < sizeX% THEN
                        calcPoint x1%, y1%, r%, g%, b%
                        LINE (x1%, y1%)-STEP(pixWidth%, pixWidth%), _RGB(r%, g%, b%), BF
                    END IF
                END IF
            NEXT
            IF INKEY$ = CHR$(27) THEN SYSTEM
        NEXT
        pixStep% = pixStep% \ 2
    LOOP WHILE pixStep% > 2

    FOR y% = 0 TO maxY% STEP 2
        y1% = y% + 1
        FOR x% = 0 TO maxX% STEP 2
            x1% = x% + 1

            IF x1% < sizeX% THEN
                calcPoint x1%, y%, r%, g%, b%
                PSET (x1%, y%), _RGB(r%, g%, b%)
            END IF
            IF y1% < sizeY% THEN
                calcPoint x%, y1%, r%, g%, b%
                PSET (x%, y1%), _RGB(r%, g%, b%)
                IF x1% < sizeX% THEN
                    calcPoint x1%, y1%, r%, g%, b%
                    PSET (x1%, y1%), _RGB(r%, g%, b%)
                END IF
            END IF
        NEXT
        IF INKEY$ = CHR$(27) THEN SYSTEM
    NEXT

    IF NOT Doantialias THEN EXIT SUB

    endArea% = endSize% * endSize%

    IF Usegaussian THEN
        FOR y% = 0 TO maxY%
            FOR x% = 0 TO maxX%
                c& = POINT(x%, y%)
                r% = _RED(c&)
                g% = _GREEN(c&)
                b% = _BLUE(c&)
                FOR i% = 2 TO endArea%
                    DO 'Marsaglia polar method for random gaussian
                        u! = RND * 2 - 1
                        v! = RND * 2 - 1
                        s! = u! * u! + v! * v!
                    LOOP WHILE s! >= 1 OR s! = 0
                    s! = SQR(-2 * LOG(s!) / s!) * 0.5
                    u! = u! * s!
                    v! = v! * s!

                    calcPoint x% + u!, y% + v!, r1%, g1%, b1%

                    r% = r% + r1%
                    g% = g% + g1%
                    b% = b% + b1%
                NEXT

                PSET (x%, y%), _RGB(CINT(r% / endArea%), CINT(g% / endArea%), CINT(b% / endArea%))
                IF INKEY$ = CHR$(27) THEN SYSTEM
            NEXT
        NEXT
    ELSE
        FOR y% = 0 TO maxY%
            FOR x% = 0 TO maxX%
                r% = 0
                g% = 0
                b% = 0
                FOR v% = 0 TO endSize% - 1
                    y1! = y% + v% / endSize%
                    FOR u% = 0 TO endSize% - 1
                        IF u% = 0 AND v& = 0 THEN
                            c& = POINT(x%, y%)
                        ELSE
                            x1! = x% + u% / endSize%
                            calcPoint x1!, y1!, r1%, g1%, b1%
                        END IF
                        r% = r% + r1%
                        g% = g% + g1%
                        b% = b% + b1%
                    NEXT
                NEXT
                PSET (x%, y%), _RGB(CINT(r% / endArea%), CINT(g% / endArea%), CINT(b% / endArea%))
                IF INKEY$ = CHR$(27) THEN SYSTEM
            NEXT
        NEXT
    END IF
END SUB

'####################################################################################################################

SUB calcPoint (screenX!, screenY!, r%, g%, b%)
    applyLocation screenX!, screenY!

    calcFractal numIter%

    IF numIter% < 250 THEN
        calcOutside numIter%, index1!, index2!, index3!, index4!

        getGradient 0, index1!, r!, g!, b!
        getGradient 0, index2!, r2!, g2!, b2!
        getGradient 0, index3!, r3!, g3!, b3!
        getOpacity 0, index3!, o3!
        getGradient 1, index4!, r4!, g4!, b4!
        getOpacity 1, index4!, o4!

        r! = r! - r2!: IF r! < 0 THEN r! = 0
        g! = g! - g2!: IF g! < 0 THEN g! = 0
        b! = b! - b2!: IF b! < 0 THEN b! = 0

        r2! = r!: g2! = g!: b2! = b!
        mergeHardLight r2!, g2!, b2!, r3!, g3!, b3!
        r! = r! + (r2! - r!) * o3!
        g! = g! + (g2! - g!) * o3!
        b! = b! + (b2! - b!) * o3!

        r2! = r!: g2! = g!: b2! = b!
        mergeSoftLight r2!, g2!, b2!, r4!, g4!, b4!
        r! = r! + (r2! - r!) * o4!
        g! = g! + (g2! - g!) * o4!
        b! = b! + (b2! - b!) * o4!
    ELSE
        'r! = 0: g! = 0: b! = 0
    END IF

    r% = r! * 255
    g% = g! * 255
    b% = b! * 255
END SUB

'####################################################################################################################

SUB applyLocation (inX!, inY!)
    px = (inX! - halfX%) * magn
    py = (halfY% - inY!) * magn
END SUB

'####################################################################################################################

SUB calcFractal (numIter%)
    zx(0) = px: zy(0) = py
    x = px: y = py
    xx = x * x: yy = y * y

    i% = -1
    FOR numIter% = 1 TO 250
        IF i% THEN
            y = 2 * x * y + 0.5276360735394
            x = xx - yy + 0.5494321598602
        ELSE
            t = x - xx + yy
            y = y - 2 * y * x
            x = t * 1.5875 + y * .51875
            y = y * 1.5875 - t * .51875
        END IF
        i% = NOT i%

        zx(numIter%) = x: zy(numIter%) = y

        xx = x * x: yy = y * y

        IF xx + yy >= 128 THEN
            Outside% = true
            EXIT FOR
        END IF
    NEXT

    numIter% = numIter% - 1
END SUB

'####################################################################################################################

SUB calcOutside (numIter%, index1!, index2!, index3!, index4!)
    dist1 = 1E38: dist2 = 1E38: dist3 = 0: dist4 = 1E+38

    FOR a% = 1 TO numIter%
        x = zx(a%): y = zy(a%)
        r = SQR(x * x + y * y)

        IF r >= 0.1 AND r <= 0.75 THEN
            a = 4 * r * r
            x2 = x - COS(a) * r
            y2 = y - SIN(a) * r
            a = x2 * x2 + y2 * y2
            IF dist4 > a THEN dist4 = a
        END IF

        a = atan2(ABS(y), ABS(x))
        IF a < 0 THEN a = a + pi2
        r = r + a

        IF dist2 > r THEN dist2 = r

        x2 = x - r * r + 0.25
        y2 = y - r
        r = x2 * x2 + y2 * y2

        IF dist1 > r THEN dist1 = r

        x2 = px * px + py * py

        y2 = INT(0.5 - (y * px - x * py) / x2)
        x2 = INT(0.5 - (x * px + y * py) / x2)

        x = px * x2 - py * y2 + x
        y = px * y2 + py * x2 + y

        a = x * x + y * y
        IF dist3 < a THEN dist3 = a
    NEXT
    cAsin SQR(dist1) ^ .1, 0, zr, zi
    index1! = (zr * zr + zi * zi) + 0.865

    cAsin dist2, 0, zr, zi
    index2! = SQR(zr * zr + zi * zi) / 2 + 0.985

    index3! = SQR(SQR(dist3)) / 2 + 0.37

    IF dist4 = 1E38 THEN index4! = 0.388 ELSE index4! = SQR(SQR(dist4)) / 2
END SUB

'####################################################################################################################

SUB cAsin (re, im, outRe, outIm)
    ' = Inverse Sine = LOG(sqrt(1-z^2) + z*i) * -i
    a = 1 - re * re + im * im
    b = -2 * re * im
    c = SQR(a * a + b * b)
    IF b < 0 THEN
        b = re - SQR((c - a) * 0.5)
    ELSE
        b = re + SQR((c - a) * 0.5)
    END IF
    a = SQR((c + a) * 0.5) - im
    outRe = atan2(b, a)
    outIm = LOG(a * a + b * b) * -0.5
END SUB

'####################################################################################################################
'# Math Library V0.11 (routines)
'# By Zom-B
'####################################################################################################################

'> merger: Skipping unused FUNCTION remainder% (a%, b%)

'> merger: Skipping unused FUNCTION fRemainder (a, b)

'####################################################################################################################

'> merger: Skipping unused FUNCTION safeLog (x)

'####################################################################################################################

'> merger: Skipping unused FUNCTION asin (y)

'> merger: Skipping unused FUNCTION acos (y)

'> merger: Skipping unused FUNCTION safeAcos (y)

FUNCTION atan2 (y, x)
    IF x > 0 THEN
        atan2 = ATN(y / x)
    ELSEIF x < 0 THEN
        IF y > 0 THEN
            atan2 = ATN(y / x) + _PI
        ELSE
            atan2 = ATN(y / x) - _PI
        END IF
    ELSEIF y > 0 THEN
        atan2 = _PI / 2
    ELSE
        atan2 = -_PI / 2
    END IF
END FUNCTION

'####################################################################################################################
'# Screen mode selector v1.0 (routines)
'# By Zom-B
'####################################################################################################################

SUB selectScreenMode (yOffset%, colors%)
    DIM aspectName$(10), aspectCol%(10)
    RESTORE videoaspect
    FOR y% = 0 TO 10
        READ aspectName$(y%), aspectCol%(y%)
        IF aspectCol%(y%) = 0 THEN numAspect% = y% - 1: EXIT FOR
    NEXT

    DIM vidX%(100), vidY%(100), vidA%(100)
    RESTORE videomodes
    FOR y% = 1 TO 100
        READ vidX%(y%), vidY%(y%), vidA%(y%)
        IF (vidX%(y%) <= 0) THEN numModes% = y% - 1: EXIT FOR
    NEXT

    IF numModes% > _HEIGHT - yOffset% - 1 THEN numModes% = _HEIGHT - yOffset% - 1

    DEF SEG = &HB800
    LOCATE yOffset% + 1, 1
    PRINT "Select video mode:"; TAB(61); "Click "
    POKE yOffset% * 160 + 132, 31

    y% = 0
    lastY% = 0
    selectedAspect% = 0
    reprint% = 1
    lastButton% = 0
    DO
        IF INKEY$ = CHR$(27) THEN CLS: SYSTEM
        IF reprint% THEN
            reprint% = 0

            FOR x% = 1 TO numModes%
                LOCATE yOffset% + x% + 1, 1
                COLOR 7, 0
                PRINT USING "##:"; x%;
                IF selectedAspect% = 0 THEN
                    COLOR aspectCol%(vidA%(x%))
                ELSEIF selectedAspect% = vidA%(x%) THEN
                    COLOR 15
                ELSE
                    COLOR 8
                END IF
                PRINT STR$(vidX%(x%)); ","; vidY%(x%);
            NEXT

            FOR x% = 0 TO numAspect%
                IF x% > 0 AND selectedAspect% = x% THEN
                    COLOR aspectCol%(x%), 3
                ELSE
                    COLOR aspectCol%(x%), 0
                END IF
                LOCATE yOffset% + x% + 2, 64
                PRINT "<"; aspectName$(x%); ">"
            NEXT
        END IF
        IF _MOUSEINPUT THEN
            IF lastY% > 0 THEN
                FOR x% = 0 TO 159 STEP 2
                    POKE lastY% + x%, PEEK(lastY% + x%) AND &HEF
                NEXT
            END IF

            x% = _MOUSEX
            y% = _MOUSEY - yOffset% - 1

            IF x% <= 60 THEN
                IF y% > 0 AND y% <= numModes% THEN
                    IF _MOUSEBUTTON(1) = 0 AND lastButton% THEN EXIT DO
                    y% = (yOffset% + y%) * 160 + 1
                    FOR x% = 0 TO 119 STEP 2
                        POKE y% + x%, PEEK(y% + x%) OR &H10
                    NEXT
                ELSE
                    y% = 0
                END IF
            ELSE
                IF y% > 0 AND y% - 1 <= numAspect% THEN
                    IF _MOUSEBUTTON(1) THEN
                        selectedAspect% = y% - 1
                        reprint% = 1
                    END IF
                    y% = (yOffset% + y%) * 160 + 1
                    FOR x% = 120 TO 159 STEP 2
                        POKE y% + x%, PEEK(y% + x%) OR &H10
                    NEXT
                ELSE
                    y% = 0
                END IF
            END IF
            lastY% = y%
            lastButton% = _MOUSEBUTTON(1)
        END IF
    LOOP

    CLS 'bug evasion for small video modes
    SCREEN _NEWIMAGE(vidX%(y%), vidY%(y%), colors%)
END SUB

'####################################################################################################################
'# Ultra Fractal Gradient library v1.0 (routines)
'# By Zom-B
'#
'# Smooth Gradient algorithm from Ultra Fractal (www.ultrafractal.com)
'####################################################################################################################

'> merger: Skipping unused SUB defaultGradient (gi%)

'> merger: Skipping unused SUB grayscaleGradient (gi%)

'####################################################################################################################

SUB setNumGradients (gi%)
    offset% = LBOUND(gradientPoints) - 1
    REDIM _PRESERVE gradientSmooth(gi% + offset%) AS _BYTE '_BIT <- bugged
    REDIM _PRESERVE gradientPoints(gi% + offset%) AS INTEGER
    REDIM _PRESERVE gradient(gi% + offset%, 1) AS GRADIENTPOINT
END FUNCTION

SUB addGradientPoint (gi%, index!, r!, g!, b!)
    p% = gradientPoints(gi%)

    IF UBOUND(gradient, 2) < p% THEN
        REDIM _PRESERVE gradient(0 TO UBOUND(gradient, 1), 0 TO p%) AS GRADIENTPOINT
    END IF

    gradient(gi%, p%).index = index!
    gradient(gi%, p%).r = r!
    gradient(gi%, p%).g = g!
    gradient(gi%, p%).b = b!
    gradientPoints(gi%) = p% + 1
END SUB

SUB setGradientSmooth (gi%, s%)
    gradientSmooth(gi%) = s%

    IF gradientSmooth(0) = 0 THEN EXIT SUB

    FOR i% = 1 TO gradientPoints(gi%) - 1
        i1% = i% + 1
        IF i1% = gradientPoints(gi%) THEN i1% = 2

        dxl! = gradient(gi%, i%).index - gradient(gi%, i% - 1).index
        dxr! = gradient(gi%, i1%).index - gradient(gi%, i%).index
        IF dxl! < 0 THEN dxl! = dxl! + 1
        IF dxr! < 0 THEN dxr! = dxr! + 1

        d! = (gradient(gi%, i%).r - gradient(gi%, i% - 1).r) * dxr!
        IF d! = 0 THEN
            gradient(gi%, i%).rdr = 0
            gradient(gi%, i%).rdl = 0
        ELSE
            d! = (gradient(gi%, i1%).r - gradient(gi%, i%).r) * dxl! / d!
            IF d! <= 0 THEN
                gradient(gi%, i%).rdr = 0
                gradient(gi%, i%).rdl = 0
            ELSE
                gradient(gi%, i%).rdr = 1 / (1 + d!)
                gradient(gi%, i%).rdl = gradient(gi%, i%).rdr - 1
            END IF
        END IF

        d! = (gradient(gi%, i%).g - gradient(gi%, i% - 1).g) * dxr!
        IF d! = 0 THEN
            gradient(gi%, i%).gdr = 0
            gradient(gi%, i%).gdl = 0
        ELSE
            d! = (gradient(gi%, i1%).g - gradient(gi%, i%).g) * dxl! / d!
            IF d! <= 0 THEN
                gradient(gi%, i%).gdr = 0
                gradient(gi%, i%).gdl = 0
            ELSE
                gradient(gi%, i%).gdr = 1 / (1 + d!)
                gradient(gi%, i%).gdl = gradient(gi%, i%).gdr - 1
            END IF
        END IF

        d! = (gradient(gi%, i%).b - gradient(gi%, i% - 1).b) * dxr!
        IF d! = 0 THEN
            gradient(gi%, i%).bdr = 0
            gradient(gi%, i%).bdl = 0
        ELSE
            d! = (gradient(gi%, i1%).b - gradient(gi%, i%).b) * dxl! / d!
            IF d! <= 0 THEN
                gradient(gi%, i%).bdr = 0
                gradient(gi%, i%).bdl = 0
            ELSE
                gradient(gi%, i%).bdr = 1 / (1 + d!)
                gradient(gi%, i%).bdl = gradient(gi%, i%).bdr - 1
            END IF
        END IF
    NEXT
END SUB

'####################################################################################################################

SUB getGradient (gi%, index!, red!, green!, blue!)
    IF index! < 0 THEN x! = 0 ELSE x! = index! - INT(index!)

    FOR l% = gradientPoints(gi%) - 2 TO 1 STEP -1
        IF gradient(gi%, l%).index <= x! THEN
            EXIT FOR
        END IF
    NEXT

    r% = l% + 1
    u! = (x! - gradient(gi%, l%).index) / (gradient(gi%, r%).index - gradient(gi%, l%).index)

    IF gradientSmooth(gi%) THEN
        u2! = u! * u!
        u3! = u2! * u!
        ur! = u3! - (u2! + u2!) + u!
        ul! = u2! - u3!

        red! = gradient(gi%, l%).r + (gradient(gi%, r%).r - gradient(gi%, l%).r) * (u3! + 3 * (gradient(gi%, l%).rdr * ur! + (1 + gradient(gi%, r%).rdl) * ul!))
        green! = gradient(gi%, l%).g + (gradient(gi%, r%).g - gradient(gi%, l%).g) * (u3! + 3 * (gradient(gi%, l%).gdr * ur! + (1 + gradient(gi%, r%).gdl) * ul!))
        blue! = gradient(gi%, l%).b + (gradient(gi%, r%).b - gradient(gi%, l%).b) * (u3! + 3 * (gradient(gi%, l%).bdr * ur! + (1 + gradient(gi%, r%).bdl) * ul!))
    ELSE
        red! = gradient(gi%, l%).r + (gradient(gi%, r%).r - gradient(gi%, l%).r) * u!
        green! = gradient(gi%, l%).g + (gradient(gi%, r%).g - gradient(gi%, l%).g) * u!
        blue! = gradient(gi%, l%).b + (gradient(gi%, r%).b - gradient(gi%, l%).b) * u!
    END IF
END SUB

'> merger: Skipping unused SUB testGradient (gi%)

'####################################################################################################################
'# Ultra Fractal Opacity library v1.0 (routines)
'# By Zom-B
'#
'# Smooth Opacity algorithm from Ultra Fractal (www.ultrafractal.com)
'####################################################################################################################

SUB setNumOpacities (gi%)
    offset% = LBOUND(opacityPoints) - 1
    REDIM _PRESERVE opacitySmooth(gi% + offset%) AS _BYTE '_BIT <- bugged
    REDIM _PRESERVE opacityPoints(gi% + offset%) AS INTEGER
    REDIM _PRESERVE opacity(gi% + offset%, 1) AS OPACITYPOINT
END FUNCTION

SUB addOpacityPoint (gi%, index!, o!)
    p% = opacityPoints(gi%)

    IF UBOUND(opacity, 2) < p% THEN
        REDIM _PRESERVE opacity(0 TO UBOUND(opacity, 1), 0 TO p%) AS OPACITYPOINT
    END IF

    opacity(gi%, p%).index = index!
    opacity(gi%, p%).o = o!
    opacityPoints(gi%) = p% + 1
END SUB

SUB setOpacitySmooth (gi%, s%)
    opacitySmooth(gi%) = s%

    IF opacitySmooth(0) = 0 THEN EXIT SUB

    FOR i% = 1 TO opacityPoints(gi%) - 1
        i1% = i% + 1
        IF i1% = opacityPoints(gi%) THEN i1% = 2

        dxl! = opacity(gi%, i%).index - opacity(gi%, i% - 1).index
        dxr! = opacity(gi%, i1%).index - opacity(gi%, i%).index
        IF dxl! < 0 THEN dxl! = dxl! + 1
        IF dxr! < 0 THEN dxr! = dxr! + 1

        d! = (opacity(gi%, i%).o - opacity(gi%, i% - 1).o) * dxr!
        IF d! = 0 THEN
            opacity(gi%, i%).odr = 0
            opacity(gi%, i%).odl = 0
        ELSE
            d! = (opacity(gi%, i1%).o - opacity(gi%, i%).o) * dxl! / d!
            IF d! <= 0 THEN
                opacity(gi%, i%).odr = 0
                opacity(gi%, i%).odl = 0
            ELSE
                opacity(gi%, i%).odr = 1 / (1 + d!)
                opacity(gi%, i%).odl = opacity(gi%, i%).odr - 1
            END IF
        END IF
    NEXT
END SUB

'####################################################################################################################

SUB getOpacity (gi%, index!, opacity!)
    IF index! < 0 THEN x! = 0 ELSE x! = index! - INT(index!)

    FOR l% = opacityPoints(gi%) - 2 TO 1 STEP -1
        IF opacity(gi%, l%).index <= x! THEN
            EXIT FOR
        END IF
    NEXT

    r% = l% + 1
    u! = (x! - opacity(gi%, l%).index) / (opacity(gi%, r%).index - opacity(gi%, l%).index)

    IF opacitySmooth(gi%) THEN
        u2! = u! * u!
        u3! = u2! * u!
        ur! = u3! - (u2! + u2!) + u!
        ul! = u2! - u3!

        opacity! = opacity(gi%, l%).o + (opacity(gi%, r%).o - opacity(gi%, l%).o) * (u3! + 3 * (opacity(gi%, l%).odr * ur! + (1 + opacity(gi%, r%).odl) * ul!))
    ELSE
        opacity! = opacity(gi%, l%).o + (opacity(gi%, r%).o - opacity(gi%, l%).o) * u!
    END IF
END SUB

'> merger: Skipping unused SUB testOpacity (gi%)

'####################################################################################################################
'# Merge modes library v0.1 (routines)
'# By Zom-B
'####################################################################################################################

'> merger: Skipping unused SUB testMerge

'####################################################################################################################

'> merger: Skipping unused SUB mergeOverlay (br!, bg!, bb!, tr!, tg!, tb!)

SUB mergeHardLight (br!, bg!, bb!, tr!, tg!, tb!)
    IF tr! <= 0.5 THEN br! = br! * tr! * 2 ELSE br! = 1 - (1 - br!) * (1 - tr!) * 2
    IF tg! <= 0.5 THEN bg! = bg! * tg! * 2 ELSE bg! = 1 - (1 - bg!) * (1 - tg!) * 2
    IF tb! <= 0.5 THEN bb! = bb! * tb! * 2 ELSE bb! = 1 - (1 - bb!) * (1 - tb!) * 2
END SUB

SUB mergeSoftLight (br!, bg!, bb!, tr!, tg!, tb!)
    IF tr! <= 0.5 THEN br! = br! * (tr! + 0.5) ELSE br! = 1 - (1 - br!) * (1.5 - tr!)
    IF tg! <= 0.5 THEN bg! = bg! * (tg! + 0.5) ELSE bg! = 1 - (1 - bg!) * (1.5 - tg!)
    IF tb! <= 0.5 THEN bb! = bb! * (tb! + 0.5) ELSE bb! = 1 - (1 - bb!) * (1.5 - tb!)
END SUB

'> merger: Skipping unused SUB mergeColor (r!, g!, b!, r2!, g2!, b2!)

'> merger: Skipping unused SUB mergeHSLAddition (r!, g!, b!, r2!, g2!, b2!)

'####################################################################################################################

'> merger: Skipping unused SUB mergeHue (r!, g!, b!, r2!, g2!, b2!)

'> merger: Skipping unused SUB rgb2hsl (r!, g!, b!, chr!, smallest!, hue!, sat!, lum!)

'> merger: Skipping unused SUB hsl2rgb (hue!, sat!, lum!, r!, g!, b!)

'> merger: Skipping unused SUB hsl2rgb2 (hue!, chr!, smallest!, r!, g!, b!)

```

#### sierpinsky-rays+aet.bas

```vb

'> Merged with Zom-B's smart $include merger 0.51

DEFSNG A-Z

'####################################################################################################################
'# Math Library V1.0 (include)
'# By Zom-B
'####################################################################################################################

CONST sqrt2 = 1.41421356237309504880168872420969807856967187537695 ' Knuth01
CONST sqrt3 = 1.73205080756887729352744634150587236694280525381038 ' Knuth02
CONST sqrt5 = 2.23606797749978969640917366873127623544061835961153 ' Knuth03
CONST sqrt10 = 3.16227766016837933199889354443271853371955513932522 ' Knuth04
CONST cubert2 = 1.25992104989487316476721060727822835057025146470151 ' Knuth05
CONST cubert3 = 1.44224957030740838232163831078010958839186925349935 ' Knuth06
CONST q2pow025 = 1.18920711500272106671749997056047591529297209246382 ' Knuth07
CONST phi = 1.61803398874989484820458683436563811772030917980576 ' Knuth08
CONST log2 = 0.69314718055994530941723212145817656807550013436026 ' Knuth09
CONST log3 = 1.09861228866810969139524523692252570464749055782275 ' Knuth10
CONST log10 = 2.30258509299404568401799145468436420760110148862877 ' Knuth11
CONST logpi = 1.14472988584940017414342735135305871164729481291531 ' Knuth12
CONST logphi = 0.48121182505960344749775891342436842313518433438566 ' Knuth13
CONST q1log2 = 1.44269504088896340735992468100189213742664595415299 ' Knuth14
CONST q1log10 = 0.43429448190325182765112891891660508229439700580367 ' Knuth15
CONST q1logphi = 2.07808692123502753760132260611779576774219226778328 ' Knuth16
CONST pi = 3.14159265358979323846264338327950288419716939937511 ' Knuth17
CONST deg2rad = 0.01745329251994329576923690768488612713442871888542 ' Knuth18
CONST q1pi = 0.31830988618379067153776752674502872406891929148091 ' Knuth19
CONST pisqr = 9.86960440108935861883449099987615113531369940724079 ' Knuth20
CONST gamma05 = 1.7724538509055160272981674833411451827975494561224 '  Knuth21
CONST gamma033 = 2.6789385347077476336556929409746776441286893779573 '  Knuth22
CONST gamma067 = 1.3541179394264004169452880281545137855193272660568 '  Knuth23
CONST e = 2.71828182845904523536028747135266249775724709369996 ' Knuth24
CONST q1e = 0.36787944117144232159552377016146086744581113103177 ' Knuth25
CONST esqr = 7.38905609893065022723042746057500781318031557055185 ' Knuth26
CONST eulergamma = 0.57721566490153286060651209008240243104215933593992 ' Knuth27
CONST expeulergamma = 1.7810724179901979852365041031071795491696452143034 '  Knuth28
CONST exppi025 = 2.19328005073801545655976965927873822346163764199427 ' Knuth29
CONST sin1 = 0.84147098480789650665250232163029899962256306079837 ' Knuth30
CONST cos1 = 0.54030230586813971740093660744297660373231042061792 ' Knuth31
CONST zeta3 = 1.2020569031595942853997381615114499907649862923405 '  Knuth32
CONST nloglog2 = 0.36651292058166432701243915823266946945426344783711 ' Knuth33

CONST logr10 = 0.43429448190325182765112891891660508229439700580367
CONST logr2 = 1.44269504088896340735992468100189213742664595415299
CONST pi05 = 1.57079632679489661923132169163975144209858469968755
CONST pi2 = 6.28318530717958647692528676655900576839433879875021
CONST q05log10 = 0.21714724095162591382556445945830254114719850290183
CONST q05log2 = 0.72134752044448170367996234050094606871332297707649
CONST q05pi = 0.15915494309189533576888376337251436203445964574046
CONST q13 = 0.33333333333333333333333333333333333333333333333333
CONST q16 = 0.16666666666666666666666666666666666666666666666667
CONST q2pi = 0.63661977236758134307553505349005744813783858296183
CONST q2sqrt5 = 0.89442719099991587856366946749251049417624734384461
CONST rad2deg = 57.2957795130823208767981548141051703324054724665643
CONST sqrt02 = 0.44721359549995793928183473374625524708812367192231
CONST sqrt05 = 0.70710678118654752440084436210484903928483593768847
CONST sqrt075 = 0.86602540378443864676372317075293618347140262690519
CONST y2q112 = 1.05946309435929526456182529494634170077920431749419 ' Chromatic base

'####################################################################################################################
'# Screen mode selector v1.0 (include)
'# By Zom-B
'####################################################################################################################

videoaspect:
DATA "all aspect",15
DATA "4:3",11
DATA "16:10",10
DATA "16:9",14
DATA "5:4",13
DATA "3:2",12
DATA "5:3",9
DATA "1:1",7
DATA "other",8
DATA ,

videomodes:
DATA 256,256,7
DATA 320,240,1
DATA 400,300,1
DATA 512,384,1
DATA 512,512,7
DATA 640,480,1
DATA 720,540,1
DATA 768,576,1
DATA 800,480,2
DATA 800,600,1
DATA 854,480,3
DATA 1024,600,8
DATA 1024,640,2
DATA 1024,768,1
DATA 1024,1024,7
DATA 1152,768,5
DATA 1152,864,1
DATA 1280,720,3
DATA 1280,768,6
DATA 1280,800,2
DATA 1280,854,5
DATA 1280,960,1
DATA 1280,1024,4
DATA 1366,768,3
DATA 1400,1050,1
DATA 1440,900,2
DATA 1440,960,5
DATA 1600,900,3
DATA 1600,1200,1
DATA 1680,1050,2
DATA 1920,1080,3
DATA 1920,1200,2
DATA 2048,1152,3
DATA 2048,1536,1
DATA 2048,2048,7
DATA ,,

'####################################################################################################################
'# Ultra Fractal Gradient library v1.0 (include)
'# By Zom-B
'#
'# Smooth Gradient algorithm from Ultra Fractal (www.ultrafractal.com)
'####################################################################################################################

TYPE GRADIENTPOINT
    index AS SINGLE
    r AS SINGLE
    g AS SINGLE
    b AS SINGLE
    rdr AS SINGLE
    rdl AS SINGLE
    gdr AS SINGLE
    gdl AS SINGLE
    bdr AS SINGLE
    bdl AS SINGLE
END TYPE

'$dynamic

DIM SHARED gradientSmooth(1) AS _BYTE '_BIT <- bugged
DIM SHARED gradientPoints(1) AS INTEGER
DIM SHARED gradient(1, 1) AS GRADIENTPOINT


'####################################################################################################################
'# Sierpinsky Rays+aet for QB64
'# By Zom-B
'#
'# Original art by Daniele (alcamese@libero.it)
'# Tweaked by Athena Tracey (athena_1963@hotmail.com)
'####################################################################################################################

CONST Doantialias = -1
CONST Usegaussian = 0

'####################################################################################################################

_TITLE "Sierpinsky Rays+aet"
WIDTH 80, 40

COLOR 11
PRINT
PRINT TAB(30); "Sierpinsky Rays+aet"
COLOR 7
PRINT
PRINT TAB(18); "Original art by Daniele (alcamese@libero.it)"
PRINT TAB(15); "Tweaked by Athena Tracey (athena_1963@hotmail.com)"
PRINT TAB(19); "Converted to Quick Basic and QB64 by Zom-B"

selectScreenMode 7, 32

'####################################################################################################################

DIM SHARED sizeX%, sizeY%
DIM SHARED maxX%, maxY%
DIM SHARED halfX%, halfY%

sizeX% = _WIDTH
sizeY% = _HEIGHT
maxX% = sizeX% - 1
maxY% = sizeY% - 1
halfX% = sizeX% \ 2
halfY% = sizeY% \ 2

DIM SHARED magX, magY

magX = 1.300052002080083203328133125325 / halfY%
magY = 1.300052002080083203328133125325 / halfY%

DIM SHARED zx(149), zy(149)

'####################################################################################################################

setNumGradients 5

addGradientPoint 0, -0.0450, 0.710, 1.000, 1.000
addGradientPoint 0, 0.0025, 1.000, 0.702, 0.729
addGradientPoint 0, 0.0850, 0.082, 0.431, 0.000
addGradientPoint 0, 0.2300, 0.812, 0.745, 0.824
addGradientPoint 0, 0.5500, 0.380, 0.000, 0.000
addGradientPoint 0, 0.7600, 1.000, 0.757, 1.000
addGradientPoint 0, 0.8800, 0.000, 0.263, 0.000
addGradientPoint 0, 0.9550, 0.710, 1.000, 1.000
addGradientPoint 0, 1.0025, 1.000, 0.702, 0.729
setGradientSmooth 0, -1

addGradientPoint 1, -0.0450, 0.165, 0.000, 0.184
addGradientPoint 1, 0.7475, 0.718, 0.918, 1.000
addGradientPoint 1, 0.8425, 0.945, 0.710, 1.000
addGradientPoint 1, 0.9550, 0.165, 0.000, 0.184
addGradientPoint 1, 1.7475, 0.718, 0.918, 1.000
setGradientSmooth 1, -1

addGradientPoint 2, -0.2750, 0.000, 0.973, 0.114
addGradientPoint 2, 0.0475, 1.000, 0.545, 0.875
addGradientPoint 2, 0.1725, 0.000, 0.345, 0.000
addGradientPoint 2, 0.5500, 1.000, 0.071, 1.000
addGradientPoint 2, 0.7250, 0.000, 0.973, 0.114
addGradientPoint 2, 1.0475, 1.000, 0.545, 0.875
setGradientSmooth 2, -1

addGradientPoint 3, -0.0675, 1.000, 0.502, 1.000
addGradientPoint 3, 0.0700, 0.000, 0.000, 0.698
addGradientPoint 3, 0.1650, 0.725, 0.741, 0.000
addGradientPoint 3, 0.3300, 0.290, 0.000, 0.757
addGradientPoint 3, 0.4550, 0.000, 0.251, 0.039
addGradientPoint 3, 0.6375, 0.584, 0.918, 1.000
addGradientPoint 3, 0.8250, 0.000, 0.165, 0.000
addGradientPoint 3, 0.9325, 1.000, 0.502, 1.000
addGradientPoint 3, 1.0700, 0.000, 0.000, 0.698
setGradientSmooth 3, -1

addGradientPoint 4, -0.1025, 1.000, 0.282, 0.082
addGradientPoint 4, 0.0775, 0.306, 0.376, 1.000
addGradientPoint 4, 0.2225, 0.333, 0.298, 0.000
addGradientPoint 4, 0.3000, 1.000, 1.000, 0.208
addGradientPoint 4, 0.3800, 0.337, 0.271, 0.741
addGradientPoint 4, 0.6400, 0.651, 0.404, 0.220
addGradientPoint 4, 0.8075, 0.000, 1.000, 1.000
addGradientPoint 4, 0.8975, 1.000, 0.282, 0.082
addGradientPoint 4, 1.0775, 0.306, 0.376, 1.000
setGradientSmooth 4, -1

renderProgressive 256, 4

i$ = INPUT$(1)
END

'####################################################################################################################

SUB renderProgressive (startSize%, endSize%)
    pixStep% = startSize%

    pixWidth% = pixStep% - 1
    FOR y% = 0 TO maxY% STEP pixStep%
        FOR x% = 0 TO maxX% STEP pixStep%
            calcPoint x%, y%, r%, g%, b%
            LINE (x%, y%)-STEP(pixWidth%, pixWidth%), _RGB(r%, g%, b%), BF
        NEXT
        IF INKEY$ = CHR$(27) THEN SYSTEM
    NEXT

    DO
        pixSize% = pixStep% \ 2
        pixWidth% = pixSize% - 1
        FOR y% = 0 TO maxY% STEP pixStep%
            y1% = y% + pixSize%
            FOR x% = 0 TO maxX% STEP pixStep%
                x1% = x% + pixSize%

                IF x1% < sizeX% THEN
                    calcPoint x1%, y%, r%, g%, b%
                    LINE (x1%, y%)-STEP(pixWidth%, pixWidth%), _RGB(r%, g%, b%), BF
                END IF
                IF y1% < sizeY% THEN
                    calcPoint x%, y1%, r%, g%, b%
                    LINE (x%, y1%)-STEP(pixWidth%, pixWidth%), _RGB(r%, g%, b%), BF
                    IF x1% < sizeX% THEN
                        calcPoint x1%, y1%, r%, g%, b%
                        LINE (x1%, y1%)-STEP(pixWidth%, pixWidth%), _RGB(r%, g%, b%), BF
                    END IF
                END IF
            NEXT
            IF INKEY$ = CHR$(27) THEN SYSTEM
        NEXT
        pixStep% = pixStep% \ 2
    LOOP WHILE pixStep% > 2

    FOR y% = 0 TO maxY% STEP 2
        y1% = y% + 1
        FOR x% = 0 TO maxX% STEP 2
            x1% = x% + 1

            IF x1% < sizeX% THEN
                calcPoint x1%, y%, r%, g%, b%
                PSET (x1%, y%), _RGB(r%, g%, b%)
            END IF
            IF y1% < sizeY% THEN
                calcPoint x%, y1%, r%, g%, b%
                PSET (x%, y1%), _RGB(r%, g%, b%)
                IF x1% < sizeX% THEN
                    calcPoint x1%, y1%, r%, g%, b%
                    PSET (x1%, y1%), _RGB(r%, g%, b%)
                END IF
            END IF
        NEXT
        IF INKEY$ = CHR$(27) THEN SYSTEM
    NEXT

    IF NOT Doantialias THEN EXIT SUB

    endArea% = endSize% * endSize%

    IF Usegaussian THEN
        FOR y% = 0 TO maxY%
            FOR x% = 0 TO maxX%
                c& = POINT(x%, y%)
                r% = _RED(c&)
                g% = _GREEN(c&)
                b% = _BLUE(c&)
                FOR i% = 2 TO endArea%
                    DO 'Marsaglia polar method for random gaussian
                        u! = RND * 2 - 1
                        v! = RND * 2 - 1
                        s! = u! * u! + v! * v!
                    LOOP WHILE s! >= 1 OR s! = 0
                    s! = SQR(-2 * LOG(s!) / s!) * 0.5
                    u! = u! * s!
                    v! = v! * s!

                    calcPoint x% + u!, y% + v!, r1%, g1%, b1%

                    r% = r% + r1%
                    g% = g% + g1%
                    b% = b% + b1%
                NEXT

                PSET (x%, y%), _RGB(CINT(r% / endArea%), CINT(g% / endArea%), CINT(b% / endArea%))
                IF INKEY$ = CHR$(27) THEN SYSTEM
            NEXT
        NEXT
    ELSE
        FOR y% = 0 TO maxY%
            FOR x% = 0 TO maxX%
                r% = 0
                g% = 0
                b% = 0
                FOR v% = 0 TO endSize% - 1
                    y1! = y% + v% / endSize%
                    FOR u% = 0 TO endSize% - 1
                        IF u% = 0 AND v& = 0 THEN
                            c& = POINT(x%, y%)
                        ELSE
                            x1! = x% + u% / endSize%
                            calcPoint x1!, y1!, r1%, g1%, b1%
                        END IF
                        r% = r% + r1%
                        g% = g% + g1%
                        b% = b% + b1%
                    NEXT
                NEXT
                PSET (x%, y%), _RGB(CINT(r% / endArea%), CINT(g% / endArea%), CINT(b% / endArea%))
                IF INKEY$ = CHR$(27) THEN SYSTEM
            NEXT
        NEXT
    END IF
END SUB

'####################################################################################################################

SUB calcPoint (screenX!, screenY!, r%, g%, b%)
    applyLocation screenX!, screenY!, px, py

    fractal px, py, numIter1%, numIter2%

    outside1 numIter1%, index!
    getGradient 0, index!, r!, g!, b!

    outside2 numIter2%, index!
    getGradient 1, index!, r2!, g2!, b2!
    r! = ABS(r! - r2!): g! = ABS(g! - g2!): b! = ABS(b! - b2!)

    outside3 numIter2%, index!
    getGradient 2, index!, r2!, g2!, b2!
    r1! = r!: g1! = g!: b1! = b!
    mergeOverlay r!, g!, b!, r2!, g2!, b2!
    r! = r1! + (r! - r1!) * 0.45
    g! = g1! + (g! - g1!) * 0.45
    b! = b1! + (b! - b1!) * 0.45

    outside4 numIter2%, index!
    getGradient 3, index!, r2!, g2!, b2!
    r! = r! + r2!: g! = g! + g2!: b! = b! + b2!

    outside5 px, py, numIter2%, index!
    getGradient 4, index!, r2!, g2!, b2!
    r1! = r!: g1! = g!: b1! = b!
    mergeColor r!, g!, b!, r2!, g2!, b2!
    r! = r1! + (r! - r1!) * 0.5
    g! = g1! + (g! - g1!) * 0.5
    b! = b1! + (b! - b1!) * 0.5

    r% = r! * 255
    g% = g! * 255
    b% = b! * 255
END SUB

'####################################################################################################################

SUB applyLocation (inX!, inY!, outX, outY)
    x = (inX! - halfX%) * magX
    y = (halfY% - inY!) * magY
    outX = 0.99999998476912904932780850903444 * x - 1.7453292431333680334067268304459D-4 * y - 0.01168313399#
    outY = 1.7453292431333680334067268304459D-4 * x + 0.99999998476912904932780850903444 * y - 0.00626625065#
END SUB

'####################################################################################################################

SUB fractal (px, py, numIter1%, numIter2%)
    xx = px * px: yy = py * py

    x = ABS(px * xx - 3 * px * yy) * 0.2
    y = ABS(3 * xx * py - py * yy) * 0.2
    x = x - INT(x * 2.5 + 0.5) * 0.4
    y = y - INT(y * 2.5 + 0.5) * 0.4

    zx(0) = x: zy(0) = y

    numIter1% = -1
    numIter2% = -1
    FOR numIter% = 1 TO 149
        x = x * 2: y = y * 2

        IF y > 1 THEN
            y = y - 1
        ELSEIF x > 1 THEN
            x = x - 1
        END IF

        zx(numIter%) = x: zy(numIter%) = y

        IF x * x + y * y > 127 THEN
            IF numIter2% = -1 THEN numIter2% = numIter% - 1
            IF numIter1% >= 0 THEN EXIT SUB
        END IF

        bail = ABS(x + y)
        IF bail * bail > 127 THEN
            IF numIter1% = -1 THEN numIter1% = numIter% - 1
            IF numIter2% >= 0 THEN EXIT SUB
        END IF
    NEXT

    IF numIter1% = -1 THEN numIter1% = 149
    IF numIter2% = -1 THEN numIter2% = 149
END SUB

'####################################################################################################################

SUB outside1 (numIter%, index!)
    index! = ATN(numIter% / 25)
END SUB

'####################################################################################################################

SUB outside2 (numIter%, index!)
    closest = 1E+38
    ix = 0
    iy = 0

    FOR a% = 1 TO numIter%
        x = zx(a%) * zx(a%): y = zy(a%) * zy(a%)
        d = x * x + y * y

        IF d < closest THEN
            closest = d
            ix = zx(a%)
            iy = zy(a%)
        END IF
    NEXT

    index! = SQR(SQR(ix * ix + iy * iy) * 2) / 2
END SUB

'####################################################################################################################

SUB outside3 (numIter%, index!)
    x = zx(numIter% + 1)
    y = zy(numIter% + 1)
    d = atan2(y, x) / pi2
    index! = SQR((6.349563872353654# - 4.284804271440222# * LOG(LOG(SQR(x * x + y * y))) + ABS((d - INT(d)) * 4 - 2)) * 2) / 2
END SUB

'####################################################################################################################

SUB outside4 (numIter%, index!)
    closest = 1E+38

    FOR a% = 1 TO numIter%
        zy2 = zy(a%) * zy(a%)
        d = zx(a%) + zx(a%) * zx(a%) + zy2
        d = SQR(d * d + zy2)

        IF d < closest THEN
            closest = d
        END IF
    NEXT

    index! = asin(closest ^ .1) ^ (1 / 1.5) * .41577394#
END SUB

'####################################################################################################################

SUB outside5 (px, py, numIter%, index!)
    r = SQR(px * px + py * py)
    cost = px / r
    sint = py / r

    ave = 0
    i% = 0
    FOR a% = 1 TO numIter%
        prevave = ave

        x = zx(a%)
        y = zy(a%)
        r = SQR(x * x + y * y)
        x = zx(a%) / r + cost
        y = zy(a%) / r + sint

        ave = ave + SQR(x * x + y * y)

        cost = -cost
        sint = -sint
        i% = i% + 1
    NEXT

    ave = ave / numIter%
    prevave = prevave / (numIter% - 1)
    x = zx(numIter% + 1)
    y = zy(numIter% + 1)
    f = 2.2762545841680618369458486886285 - 1.4426950408889634073599246810019 * LOG(LOG(SQR(x * x + y * y)))
    index! = prevave + (ave - prevave) * f

    index! = index! * 2
END SUB

'####################################################################################################################
'# Math Library V0.11 (routines)
'# By Zom-B
'####################################################################################################################

'> merger: Skipping unused FUNCTION remainder% (a%, b%)

'> merger: Skipping unused FUNCTION fRemainder (a, b)

'####################################################################################################################

'> merger: Skipping unused FUNCTION safeLog (x)

'####################################################################################################################

FUNCTION asin (y)
    IF y = -1 THEN asin = -pi05: EXIT FUNCTION
    IF y = 1 THEN asin = pi05: EXIT FUNCTION
    asin = ATN(y / SQR(1 - y * y))
END FUNCTION

'> merger: Skipping unused FUNCTION acos (y)

'> merger: Skipping unused FUNCTION safeAcos (y)

FUNCTION atan2 (y, x)
    IF x > 0 THEN
        atan2 = ATN(y / x)
    ELSEIF x < 0 THEN
        IF y > 0 THEN
            atan2 = ATN(y / x) + pi
        ELSE
            atan2 = ATN(y / x) - pi
        END IF
    ELSEIF y > 0 THEN
        atan2 = pi / 2
    ELSE
        atan2 = -pi / 2
    END IF
END FUNCTION

'####################################################################################################################
'# Screen mode selector v1.0 (routines)
'# By Zom-B
'####################################################################################################################

SUB selectScreenMode (yOffset%, colors%)
    DIM aspectName$(10), aspectCol%(10)
    RESTORE videoaspect
    FOR y% = 0 TO 10
        READ aspectName$(y%), aspectCol%(y%)
        IF aspectCol%(y%) = 0 THEN numAspect% = y% - 1: EXIT FOR
    NEXT

    DIM vidX%(100), vidY%(100), vidA%(100)
    RESTORE videomodes
    FOR y% = 1 TO 100
        READ vidX%(y%), vidY%(y%), vidA%(y%)
        IF (vidX%(y%) <= 0) THEN numModes% = y% - 1: EXIT FOR
    NEXT

    IF numModes% > _HEIGHT - yOffset% - 1 THEN numModes% = _HEIGHT - yOffset% - 1

    DEF SEG = &HB800
    LOCATE yOffset% + 1, 1
    PRINT "Select video mode:"; TAB(61); "Click "
    POKE yOffset% * 160 + 132, 31

    y% = 0
    lastY% = 0
    selectedAspect% = 0
    reprint% = 1
    lastButton% = 0
    DO
        IF INKEY$ = CHR$(27) THEN CLS: SYSTEM
        IF reprint% THEN
            reprint% = 0

            FOR x% = 1 TO numModes%
                LOCATE yOffset% + x% + 1, 1
                COLOR 7, 0
                PRINT USING "##:"; x%;
                IF selectedAspect% = 0 THEN
                    COLOR aspectCol%(vidA%(x%))
                ELSEIF selectedAspect% = vidA%(x%) THEN
                    COLOR 15
                ELSE
                    COLOR 8
                END IF
                PRINT STR$(vidX%(x%)); ","; vidY%(x%);
            NEXT

            FOR x% = 0 TO numAspect%
                IF x% > 0 AND selectedAspect% = x% THEN
                    COLOR aspectCol%(x%), 3
                ELSE
                    COLOR aspectCol%(x%), 0
                END IF
                LOCATE yOffset% + x% + 2, 64
                PRINT "<"; aspectName$(x%); ">"
            NEXT
        END IF
        IF _MOUSEINPUT THEN
            IF lastY% > 0 THEN
                FOR x% = 0 TO 159 STEP 2
                    POKE lastY% + x%, PEEK(lastY% + x%) AND &HEF
                NEXT
            END IF

            x% = _MOUSEX
            y% = _MOUSEY - yOffset% - 1

            IF x% <= 60 THEN
                IF y% > 0 AND y% <= numModes% THEN
                    IF _MOUSEBUTTON(1) = 0 AND lastButton% THEN EXIT DO
                    y% = (yOffset% + y%) * 160 + 1
                    FOR x% = 0 TO 119 STEP 2
                        POKE y% + x%, PEEK(y% + x%) OR &H10
                    NEXT
                ELSE
                    y% = 0
                END IF
            ELSE
                IF y% > 0 AND y% - 1 <= numAspect% THEN
                    IF _MOUSEBUTTON(1) THEN
                        selectedAspect% = y% - 1
                        reprint% = 1
                    END IF
                    y% = (yOffset% + y%) * 160 + 1
                    FOR x% = 120 TO 159 STEP 2
                        POKE y% + x%, PEEK(y% + x%) OR &H10
                    NEXT
                ELSE
                    y% = 0
                END IF
            END IF
            lastY% = y%
            lastButton% = _MOUSEBUTTON(1)
        END IF
    LOOP

    CLS 'bug evasion for small video modes
    SCREEN _NEWIMAGE(vidX%(y%), vidY%(y%), colors%)
END SUB

'####################################################################################################################
'# Ultra Fractal Gradient library v1.1 (routines)
'# By Zom-B
'#
'# Smooth Gradient algorithm from Ultra Fractal (www.ultrafractal.com)
'####################################################################################################################

'> merger: Skipping unused SUB defaultGradient (gi%)

'> merger: Skipping unused SUB grayscaleGradient (gi%)

'####################################################################################################################

SUB setNumGradients (gi%)
    offset% = LBOUND(gradientPoints) - 1
    REDIM _PRESERVE gradientSmooth(gi% + offset%) AS _BYTE '_BIT <- bugged
    REDIM _PRESERVE gradientPoints(gi% + offset%) AS INTEGER
    REDIM _PRESERVE gradient(gi% + offset%, 1) AS GRADIENTPOINT
END FUNCTION

SUB addGradientPoint (gi%, index!, r!, g!, b!)
    p% = gradientPoints(gi%)

    IF UBOUND(gradient, 2) < p% THEN
        REDIM _PRESERVE gradient(0 TO UBOUND(gradient, 1), 0 TO p%) AS GRADIENTPOINT
    END IF

    gradient(gi%, p%).index = index!
    gradient(gi%, p%).r = r!
    gradient(gi%, p%).g = g!
    gradient(gi%, p%).b = b!
    gradientPoints(gi%) = p% + 1
END SUB

SUB setGradientSmooth (gi%, s%)
    gradientSmooth(gi%) = s%

    IF gradientSmooth(0) = 0 THEN EXIT SUB

    FOR i% = 0 TO gradientPoints(gi%) - 1
        ip1% = i% + 1
        IF ip1% = gradientPoints(gi%) THEN ip1% = 2
        in1% = i% - 1
        IF in1% = -1 THEN in1% = gradientPoints(gi%) - 3

        dxl! = gradient(gi%, i%).index - gradient(gi%, in1%).index
        dxr! = gradient(gi%, ip1%).index - gradient(gi%, i%).index
        IF dxl! < 0 THEN dxl! = dxl! + 1
        IF dxr! < 0 THEN dxr! = dxr! + 1

        d! = (gradient(gi%, i%).r - gradient(gi%, in1%).r) * dxr!
        IF d! = 0 THEN
            gradient(gi%, i%).rdr = 0
            gradient(gi%, i%).rdl = 0
        ELSE
            d! = (gradient(gi%, ip1%).r - gradient(gi%, i%).r) * dxl! / d!
            IF d! <= 0 THEN
                gradient(gi%, i%).rdr = 0
                gradient(gi%, i%).rdl = 0
            ELSE
                gradient(gi%, i%).rdr = 1 / (1 + d!)
                gradient(gi%, i%).rdl = gradient(gi%, i%).rdr - 1
            END IF
        END IF

        d! = (gradient(gi%, i%).g - gradient(gi%, in1%).g) * dxr!
        IF d! = 0 THEN
            gradient(gi%, i%).gdr = 0
            gradient(gi%, i%).gdl = 0
        ELSE
            d! = (gradient(gi%, ip1%).g - gradient(gi%, i%).g) * dxl! / d!
            IF d! <= 0 THEN
                gradient(gi%, i%).gdr = 0
                gradient(gi%, i%).gdl = 0
            ELSE
                gradient(gi%, i%).gdr = 1 / (1 + d!)
                gradient(gi%, i%).gdl = gradient(gi%, i%).gdr - 1
            END IF
        END IF

        d! = (gradient(gi%, i%).b - gradient(gi%, in1%).b) * dxr!
        IF d! = 0 THEN
            gradient(gi%, i%).bdr = 0
            gradient(gi%, i%).bdl = 0
        ELSE
            d! = (gradient(gi%, ip1%).b - gradient(gi%, i%).b) * dxl! / d!
            IF d! <= 0 THEN
                gradient(gi%, i%).bdr = 0
                gradient(gi%, i%).bdl = 0
            ELSE
                gradient(gi%, i%).bdr = 1 / (1 + d!)
                gradient(gi%, i%).bdl = gradient(gi%, i%).bdr - 1
            END IF
        END IF
    NEXT
END SUB

'####################################################################################################################

SUB getGradient (gi%, index!, red!, green!, blue!)
    IF index! < 0 THEN x! = 0 ELSE x! = index! - INT(index!)

    FOR l% = gradientPoints(gi%) - 2 TO 1 STEP -1
        IF gradient(gi%, l%).index <= x! THEN
            EXIT FOR
        END IF
    NEXT

    r% = l% + 1
    u! = (x! - gradient(gi%, l%).index) / (gradient(gi%, r%).index - gradient(gi%, l%).index)

    IF gradientSmooth(gi%) THEN
        u2! = u! * u!
        u3! = u2! * u!
        ur! = u3! - (u2! + u2!) + u!
        ul! = u2! - u3!

        red! = gradient(gi%, l%).r + (gradient(gi%, r%).r - gradient(gi%, l%).r) * (u3! + 3 * (gradient(gi%, l%).rdr * ur! + (1 + gradient(gi%, r%).rdl) * ul!))
        green! = gradient(gi%, l%).g + (gradient(gi%, r%).g - gradient(gi%, l%).g) * (u3! + 3 * (gradient(gi%, l%).gdr * ur! + (1 + gradient(gi%, r%).gdl) * ul!))
        blue! = gradient(gi%, l%).b + (gradient(gi%, r%).b - gradient(gi%, l%).b) * (u3! + 3 * (gradient(gi%, l%).bdr * ur! + (1 + gradient(gi%, r%).bdl) * ul!))
    ELSE
        red! = gradient(gi%, l%).r + (gradient(gi%, r%).r - gradient(gi%, l%).r) * u!
        green! = gradient(gi%, l%).g + (gradient(gi%, r%).g - gradient(gi%, l%).g) * u!
        blue! = gradient(gi%, l%).b + (gradient(gi%, r%).b - gradient(gi%, l%).b) * u!
    END IF
END SUB

'> merger: Skipping unused SUB testGradient (gi%)

'####################################################################################################################
'# Merge modes library v0.1 (routines)
'# By Zom-B
'####################################################################################################################

'> merger: Skipping unused SUB testMerge

'####################################################################################################################

SUB mergeOverlay (br!, bg!, bb!, tr!, tg!, tb!)
    IF br! <= 0.5 THEN br! = br! * tr! * 2 ELSE br! = 1 - (1 - br!) * (1 - tr!) * 2
    IF bg! <= 0.5 THEN bg! = bg! * tg! * 2 ELSE bg! = 1 - (1 - bg!) * (1 - tg!) * 2
    IF bb! <= 0.5 THEN bb! = bb! * tb! * 2 ELSE bb! = 1 - (1 - bb!) * (1 - tb!) * 2
END SUB

'> merger: Skipping unused SUB mergeHardLight (br!, bg!, bb!, tr!, tg!, tb!)

'> merger: Skipping unused SUB mergeSoftLight (br!, bg!, bb!, tr!, tg!, tb!)

SUB mergeColor (r!, g!, b!, r2!, g2!, b2!)
    max! = r!
    min! = r!
    IF max! < g! THEN max! = g!
    IF min! > g! THEN min! = g!
    IF max! < b! THEN max! = b!
    IF min! > b! THEN min! = b!

    lum1! = max! + min!

    max! = r2!
    min! = r2!
    IF max! < g2! THEN max! = g2!
    IF min! > g2! THEN min! = g2!
    IF max! < b2! THEN max! = b2!
    IF min! > b2! THEN min! = b2!

    sum! = max! + min!
    dif! = max! - min!

    IF sum! < 1 THEN
        sat2! = dif! / sum!
    ELSE
        sat2! = dif! / (2 - sum!)
    END IF

    IF dif! = 0 THEN
        lum1! = lum1! * 0.5
        r! = lum1!: g! = lum1!: b! = lum1!
        EXIT SUB
    END IF

    IF lum1! < 1 THEN
        chr! = sat2! * lum1!
    ELSE
        chr! = sat2! * (2 - lum1!)
    END IF
    min! = (lum1! - chr!) * 0.5

    IF max! = r2! THEN
        hue2! = (g2! - b2!) / dif!
        IF hue2! < 0 THEN
            r! = chr! + min!: g! = min!: b! = chr! * -hue2! + min!
        ELSE
            r! = chr! + min!: g! = chr! * hue2! + min!: b! = min!
        END IF
    ELSEIF max! = g2! THEN
        hue2! = (b2! - r2!) / dif!
        IF hue2! < 0 THEN
            r! = chr! * -hue2! + min!: g! = chr! + min!: b! = min!
        ELSE
            r! = min!: g! = chr! + min!: b! = chr! * hue2! + min!
        END IF
    ELSE
        hue2! = (r2! - g2!) / dif!
        IF hue2! < 0 THEN
            r! = min!: g! = chr! * -hue2! + min!: b! = chr! + min!
        ELSE
            r! = chr! * hue2! + min!: g! = min!: b! = chr! + min!
        END IF
    END IF
END SUB

'> merger: Skipping unused SUB mergeHSLAddition (r!, g!, b!, r2!, g2!, b2!)

'####################################################################################################################

'> merger: Skipping unused SUB mergeHue (r!, g!, b!, r2!, g2!, b2!)

'> merger: Skipping unused SUB rgb2hsl (r!, g!, b!, chr!, smallest!, hue!, sat!, lum!)

'> merger: Skipping unused SUB hsl2rgb (hue!, sat!, lum!, r!, g!, b!)

'> merger: Skipping unused SUB hsl2rgb2 (hue!, chr!, smallest!, r!, g!, b!)

```

#### the-burning-of-julia2.1.bas

```vb

'> Merged with Zom-B's smart $include merger 0.51

DEFDBL A-Z

'####################################################################################################################
'# Math Library V1.0 (include)
'# By Zom-B
'####################################################################################################################

CONST sqrt2         = 1.41421356237309504880168872420969807856967187537695 ' Knuth01
CONST sqrt3 = 1.73205080756887729352744634150587236694280525381038 ' Knuth02
CONST sqrt5 = 2.23606797749978969640917366873127623544061835961153 ' Knuth03
CONST sqrt10 = 3.16227766016837933199889354443271853371955513932522 ' Knuth04
CONST cubert2 = 1.25992104989487316476721060727822835057025146470151 ' Knuth05
CONST cubert3 = 1.44224957030740838232163831078010958839186925349935 ' Knuth06
CONST q2pow025 = 1.18920711500272106671749997056047591529297209246382 ' Knuth07
CONST phi = 1.61803398874989484820458683436563811772030917980576 ' Knuth08
CONST log2 = 0.69314718055994530941723212145817656807550013436026 ' Knuth09
CONST log3 = 1.09861228866810969139524523692252570464749055782275 ' Knuth10
CONST log10 = 2.30258509299404568401799145468436420760110148862877 ' Knuth11
CONST logpi = 1.14472988584940017414342735135305871164729481291531 ' Knuth12
CONST logphi = 0.48121182505960344749775891342436842313518433438566 ' Knuth13
CONST q1log2 = 1.44269504088896340735992468100189213742664595415299 ' Knuth14
CONST q1log10 = 0.43429448190325182765112891891660508229439700580367 ' Knuth15
CONST q1logphi = 2.07808692123502753760132260611779576774219226778328 ' Knuth16
CONST pi = 3.14159265358979323846264338327950288419716939937511 ' Knuth17
CONST deg2rad = 0.01745329251994329576923690768488612713442871888542 ' Knuth18
CONST q1pi = 0.31830988618379067153776752674502872406891929148091 ' Knuth19
CONST pisqr = 9.86960440108935861883449099987615113531369940724079 ' Knuth20
CONST gamma05 = 1.7724538509055160272981674833411451827975494561224 '  Knuth21
CONST gamma033 = 2.6789385347077476336556929409746776441286893779573 '  Knuth22
CONST gamma067 = 1.3541179394264004169452880281545137855193272660568 '  Knuth23
CONST e = 2.71828182845904523536028747135266249775724709369996 ' Knuth24
CONST q1e = 0.36787944117144232159552377016146086744581113103177 ' Knuth25
CONST esqr = 7.38905609893065022723042746057500781318031557055185 ' Knuth26
CONST eulergamma = 0.57721566490153286060651209008240243104215933593992 ' Knuth27
CONST expeulergamma = 1.7810724179901979852365041031071795491696452143034 '  Knuth28
CONST exppi025 = 2.19328005073801545655976965927873822346163764199427 ' Knuth29
CONST sin1 = 0.84147098480789650665250232163029899962256306079837 ' Knuth30
CONST cos1 = 0.54030230586813971740093660744297660373231042061792 ' Knuth31
CONST zeta3 = 1.2020569031595942853997381615114499907649862923405 '  Knuth32
CONST nloglog2 = 0.36651292058166432701243915823266946945426344783711 ' Knuth33

CONST logr10 = 0.43429448190325182765112891891660508229439700580367
CONST logr2 = 1.44269504088896340735992468100189213742664595415299
CONST pi05 = 1.57079632679489661923132169163975144209858469968755
CONST pi2 = 6.28318530717958647692528676655900576839433879875021
CONST q05log10 = 0.21714724095162591382556445945830254114719850290183
CONST q05log2 = 0.72134752044448170367996234050094606871332297707649
CONST q05pi = 0.15915494309189533576888376337251436203445964574046
CONST q13 = 0.33333333333333333333333333333333333333333333333333
CONST q16 = 0.16666666666666666666666666666666666666666666666667
CONST q2pi = 0.63661977236758134307553505349005744813783858296183
CONST q2sqrt5 = 0.89442719099991587856366946749251049417624734384461
CONST rad2deg = 57.2957795130823208767981548141051703324054724665643
CONST sqrt02 = 0.44721359549995793928183473374625524708812367192231
CONST sqrt05 = 0.70710678118654752440084436210484903928483593768847
CONST sqrt075 = 0.86602540378443864676372317075293618347140262690519
CONST y2q112 = 1.05946309435929526456182529494634170077920431749419 ' Chromatic base

'####################################################################################################################
'# Screen mode selector v1.0 (include)
'# By Zom-B
'####################################################################################################################

videoaspect:
DATA "all aspect",15
DATA "4:3",11
DATA "16:10",10
DATA "16:9",14
DATA "5:4",13
DATA "3:2",12
DATA "5:3",9
DATA "1:1",7
DATA "other",8
DATA ,

videomodes:
DATA 256,256,7
DATA 320,240,1
DATA 400,300,1
DATA 512,384,1
DATA 512,512,7
DATA 640,480,1
DATA 720,540,1
DATA 768,576,1
DATA 800,480,2
DATA 800,600,1
DATA 854,480,3
DATA 1024,600,8
DATA 1024,640,2
DATA 1024,768,1
DATA 1024,1024,7
DATA 1152,768,5
DATA 1152,864,1
DATA 1280,720,3
DATA 1280,768,6
DATA 1280,800,2
DATA 1280,854,5
DATA 1280,960,1
DATA 1280,1024,4
DATA 1366,768,3
DATA 1400,1050,1
DATA 1440,900,2
DATA 1440,960,5
DATA 1600,900,3
DATA 1600,1200,1
DATA 1680,1050,2
DATA 1920,1080,3
DATA 1920,1200,2
DATA 2048,1152,3
DATA 2048,1536,1
DATA 2048,2048,7
DATA ,,

'####################################################################################################################
'# Ultra Fractal Gradient library v1.0 (include)
'# By Zom-B
'#
'# Smooth Gradient algorithm from Ultra Fractal (www.ultrafractal.com)
'####################################################################################################################

TYPE GRADIENTPOINT
    index AS SINGLE
    r AS SINGLE
    g AS SINGLE
    b AS SINGLE
    rdr AS SINGLE
    rdl AS SINGLE
    gdr AS SINGLE
    gdl AS SINGLE
    bdr AS SINGLE
    bdl AS SINGLE
END TYPE

'$dynamic

DIM SHARED gradientSmooth(1) AS _BYTE '_BIT <- bugged
DIM SHARED gradientPoints(1) AS INTEGER
DIM SHARED gradient(1, 1) AS GRADIENTPOINT


'####################################################################################################################
'# InterestingSpiral2
'# By Zom-B
'#
'# Original art by Mark Hammond (markch1@mindspring.com) (Sep 10, 2002)
'####################################################################################################################

CONST Doantialias = -1
CONST Usegaussian = 0

'####################################################################################################################

_TITLE "The burning of Julia2.1"
WIDTH 80, 40

COLOR 11
PRINT
PRINT TAB(31); "The burning of Julia2.1"
COLOR 7
PRINT
PRINT "Original artwork from Alan Hughes (alan.hughes2@blueyonder.co.uk) (Sep 19, 2002)"
PRINT TAB(19); "Converted to Quick Basic and QB64 by Zom-B"

selectScreenMode 6, 32

'####################################################################################################################

DIM SHARED sizeX%, sizeY%
DIM SHARED maxX%, maxY%
DIM SHARED halfX%, halfY%

sizeX% = _WIDTH
sizeY% = _HEIGHT
maxX% = sizeX% - 1
maxY% = sizeY% - 1
halfX% = sizeX% \ 2
halfY% = sizeY% \ 2

DIM SHARED magn

magn = 0.14195401787598556308710998843359 / halfY%

DIM SHARED px, py
DIM SHARED zx(1000), zy(1000), numIter1%, numIter2%

'####################################################################################################################

setNumGradients 4

addGradientPoint 0, -0.1800, 0.188, 0.663, 0.961
addGradientPoint 0, 0.1800, 0.604, 0.416, 0.000
addGradientPoint 0, 0.5400, 0.000, 0.000, 0.000
addGradientPoint 0, 0.8200, 0.188, 0.663, 0.961
addGradientPoint 0, 1.1800, 0.604, 0.416, 0.000
setGradientSmooth 0, -1

addGradientPoint 1, -0.7225, 0.000, 0.000, 0.000
addGradientPoint 1, 0.1075, 0.506, 0.973, 1.000
addGradientPoint 1, 0.2775, 0.000, 0.000, 0.000
addGradientPoint 1, 1.1075, 0.506, 0.973, 1.000
setGradientSmooth 1, -1

addGradientPoint 2, -0.6925, 0.000, 0.000, 0.000
addGradientPoint 2, 0.0800, 0.898, 1.000, 1.000
addGradientPoint 2, 0.3075, 0.000, 0.000, 0.000
addGradientPoint 2, 1.0800, 0.898, 1.000, 1.000
setGradientSmooth 2, -1

addGradientPoint 3, -0.6975, 0.016, 0.000, 0.251
addGradientPoint 3, 0.0650, 0.596, 0.678, 0.918
addGradientPoint 3, 0.3025, 0.016, 0.000, 0.251
addGradientPoint 3, 1.0650, 0.596, 0.678, 0.918
setGradientSmooth 3, -1

renderProgressive 256, 4

i$ = INPUT$(1)
END

'####################################################################################################################

SUB renderProgressive (startSize%, endSize%)
    pixStep% = startSize%

    pixWidth% = pixStep% - 1
    FOR y% = 0 TO maxY% STEP pixStep%
        FOR x% = 0 TO maxX% STEP pixStep%
            calcPoint x%, y%, r%, g%, b%
            LINE (x%, y%)-STEP(pixWidth%, pixWidth%), _RGB(r%, g%, b%), BF
        NEXT
        IF INKEY$ = CHR$(27) THEN SYSTEM
    NEXT

    WHILE pixStep% > 2
        pixSize% = pixStep% \ 2
        pixWidth% = pixSize% - 1
        FOR y% = 0 TO maxY% STEP pixStep%
            y1% = y% + pixSize%
            FOR x% = 0 TO maxX% STEP pixStep%
                x1% = x% + pixSize%

                IF x1% < sizeX% THEN
                    calcPoint x1%, y%, r%, g%, b%
                    LINE (x1%, y%)-STEP(pixWidth%, pixWidth%), _RGB(r%, g%, b%), BF
                END IF
                IF y1% < sizeY% THEN
                    calcPoint x%, y1%, r%, g%, b%
                    LINE (x%, y1%)-STEP(pixWidth%, pixWidth%), _RGB(r%, g%, b%), BF
                    IF x1% < sizeX% THEN
                        calcPoint x1%, y1%, r%, g%, b%
                        LINE (x1%, y1%)-STEP(pixWidth%, pixWidth%), _RGB(r%, g%, b%), BF
                    END IF
                END IF
            NEXT
            IF INKEY$ = CHR$(27) THEN SYSTEM
        NEXT
        pixStep% = pixStep% \ 2
    WEND

    IF startSize% > 1 THEN
        FOR y% = 0 TO maxY% STEP 2
            y1% = y% + 1
            FOR x% = 0 TO maxX% STEP 2
                x1% = x% + 1

                IF x1% < sizeX% THEN
                    calcPoint x1%, y%, r%, g%, b%
                    PSET (x1%, y%), _RGB(r%, g%, b%)
                END IF
                IF y1% < sizeY% THEN
                    calcPoint x%, y1%, r%, g%, b%
                    PSET (x%, y1%), _RGB(r%, g%, b%)
                    IF x1% < sizeX% THEN
                        calcPoint x1%, y1%, r%, g%, b%
                        PSET (x1%, y1%), _RGB(r%, g%, b%)
                    END IF
                END IF
            NEXT
            IF INKEY$ = CHR$(27) THEN SYSTEM
        NEXT
    END IF

    IF NOT Doantialias THEN EXIT SUB

    endArei% = endSize% * endSize%

    IF Usegaussian THEN
        FOR y% = 0 TO maxY%
            FOR x% = 0 TO maxX%
                c& = POINT(x%, y%)
                r% = _RED(c&)
                g% = _GREEN(c&)
                b% = _BLUE(c&)
                FOR i% = 2 TO endArei%
                    DO 'Marsaglia polar method for random gaussian
                        u! = RND * 2 - 1
                        v! = RND * 2 - 1
                        s! = u! * u! + v! * v!
                    LOOP WHILE s! >= 1 OR s! = 0
                    s! = SQR(-2 * LOG(s!) / s!) * 0.5
                    u! = u! * s!
                    v! = v! * s!

                    calcPoint x% + u!, y% + v!, r1%, g1%, b1%

                    r% = r% + r1%
                    g% = g% + g1%
                    b% = b% + b1%
                NEXT

                PSET (x%, y%), _RGB(CINT(r% / endArei%), CINT(g% / endArei%), CINT(b% / endArei%))
                IF INKEY$ = CHR$(27) THEN SYSTEM
            NEXT
        NEXT
    ELSE
        FOR y% = 0 TO maxY%
            FOR x% = 0 TO maxX%
                r% = 0
                g% = 0
                b% = 0
                FOR v% = 0 TO endSize% - 1
                    y1! = y% + v% / endSize%
                    FOR u% = 0 TO endSize% - 1
                        IF u% = 0 AND v& = 0 THEN
                            c& = POINT(x%, y%)
                        ELSE
                            x1! = x% + u% / endSize%
                            calcPoint x1!, y1!, r1%, g1%, b1%
                        END IF
                        r% = r% + r1%
                        g% = g% + g1%
                        b% = b% + b1%
                    NEXT
                NEXT
                PSET (x%, y%), _RGB(CINT(r% / endArei%), CINT(g% / endArei%), CINT(b% / endArei%))
                IF INKEY$ = CHR$(27) THEN SYSTEM
            NEXT
        NEXT
    END IF
END SUB

'####################################################################################################################

SUB calcPoint (screenX!, screenY!, r%, g%, b%)
    applyLocation screenX!, screenY!

    calcFractal

    IF numIter2% < 1000 THEN
        calcOutside2 index2!

        getGradient 1, index2!, r2!, g2!, b2!
    ELSE
        r2! = 0: g2! = 0: b2! = 0
    END IF

    IF numIter1% < 1000 THEN
        calcOutside134 index1!, index3!, index4!

        getGradient 0, index1!, r1!, g1!, b1!
        getGradient 2, index3!, r3!, g3!, b3!
        getGradient 3, index4!, r4!, g4!, b4!
    ELSE
        r! = 0: g! = 0: b! = 0
    END IF

    r! = r1!: g! = g1!: b! = b1!
    mergeHSLAddition r1!, g1!, b1!, r2!, g2!, b2!
    r1! = r! + (r1! - r!) * 0.9
    g1! = g! + (g1! - g!) * 0.9
    b1! = b! + (b1! - b!) * 0.9

    mergeOverlay r1!, g1!, b1!, r3!, g3!, b3!

    r! = r1!: g! = g1!: b! = b1!
    mergeScreen r1!, g1!, b1!, r4!, g4!, b4!
    r1! = r! + (r1! - r!) * 0.7
    g1! = g! + (g1! - g!) * 0.7
    b1! = b! + (b1! - b!) * 0.7

    r% = r1! * 255
    g% = g1! * 255
    b% = b1! * 255
END SUB

'####################################################################################################################

SUB applyLocation (inX!, inY!)
    px = (inX! - halfX%) * magn - 0.516284792045
    py = (halfY% - inY!) * magn + 0.0972965155915
END SUB

'####################################################################################################################

SUB calcFractal
    x = px: y = py
    xx = x * x: yy = y * y
    zx(0) = x: zy(0) = y

    numIter1% = -1
    FOR numIter2% = 1 TO 1000
        y = 2 * x * y + .20625
        x = xx - yy - .8

        zx(numIter2%) = x: zy(numIter2%) = y

        xx = x * x
        yy = y * y

        IF xx + yy >= 250 THEN
            IF numIter1% = -1 THEN numIter1% = numIter2% - 1
            IF xx + yy >= 1E+20 THEN numIter2% = numIter2% - 1: EXIT SUB
        END IF
    NEXT

    IF numIter1% = -1 THEN numIter1% = 1000
    numIter2% = 1000
END SUB

SUB calcFractalFish
    x = px: y = py
    xx = x * x: yy = y * y
    zx(0) = x: zy(0) = y

    numIter1% = -1
    FOR numIter2% = 1 TO 1000
        x = xx - yy - .8
        y = 2 * x * y + .20625

        zx(numIter2%) = x: zy(numIter2%) = y

        xx = x * x
        yy = y * y

        IF xx + yy >= 250 THEN
            IF numIter1% = -1 THEN numIter1% = numIter2% - 1
            IF xx + yy >= 1E+20 THEN numIter2% = numIter2% - 1: EXIT SUB
        END IF
    NEXT

    numIter1% = 250
    numIter2% = 1000
END SUB

'####################################################################################################################

SUB calcOutside134 (index1!, index3!, index4!)
    dist3 = 1E12: dist4 = 1E20

    x2 = 0: y2 = 0

    FOR i% = 1 TO numIter1%
        x = zx(i%): y = zy(i%)

        r = x * x + y * y
        IF dist4 > r THEN dist4 = r: x2 = x: y2 = y

        x = x - INT(x + 0.5)
        y = y - INT(y + 0.5)
        r = x * x + y * y
        IF dist3 > r THEN dist3 = r
    NEXT

    x = zx(numIter1% + 1): y = zy(numIter1% + 1)
    index1! = .025 * (numIter1% + 2.46505 - 1.442695 * LOG(LOG(SQR(x * x + y * y))))

    index3! = SQR(SQR(dist3)) * 0.5

    x3 = ABS(x2) * 10
    y3 = ABS(y2) * 10
    x2 = INT(x3)
    y2 = INT(y3)

    a1 = (x2 + y2 - 1) * 0.2
    a2 = a1 + 0.45

    a3 = a1: a4 = a2
    h = 0.97
    r = 0

    FOR i = 1 TO 20
        h = h * 0.5

        x4 = x2 + h
        y4 = y2 + h

        a = (a1 + a2 + a3 + a4) * 0.25
        r = r * 0.01 + a

        IF x4 < x3 THEN
            x2 = x4
            IF y4 < y3 THEN
                y2 = y4
                a1 = r
            ELSE
                a2 = r
            END IF
        ELSE
            IF y4 < y3 THEN
                y2 = y4
                a3 = r
            ELSE
                a4 = r
            END IF
        END IF
    NEXT

    index4! = (a - FIX(a) + fRemainder(SQR(dist4), 0.9)) * 0.5
END SUB

SUB calcOutside2 (index2!)
    pr = SQR(px * px + py * py)
    sum = 0
    first = -1

    FOR i% = 2 TO numIter2%
        lastSum = sum
        x = zx(i%): y = zy(i%)
        x2 = x - px
        y2 = y - py
        x2 = SQR(x2 * x2 + y2 * y2)
        y2 = ABS(x2 - pr)
        'PRINT (x2 - y2 + pr); x2; pr; y2
        sum = sum + ((SQR(x * x + y * y) - y2) / (x2 - y2 + pr))
    NEXT

    sum = sum / numIter2%
    lastSum = lastSum / (numIter2% - 1)
    x = zx(numIter2% + 1): y = zy(numIter2% + 1)
    index2! = SQR((lastSum + (sum - lastSum) * (5.5251825675870840747620004790735 - 1.4426950408889634073599246810019 * LOG(LOG(SQR(x * x + y * y))))) * 0.25) * 0.5
END SUB

'####################################################################################################################
'# Math Library V0.11 (routines)
'# By Zom-B
'####################################################################################################################

'> merger: Skipping unused FUNCTION remainder% (a%, b%)

FUNCTION fRemainder (a, b)
    fRemainder = a - INT(a / b) * b
END FUNCTION

'####################################################################################################################

'> merger: Skipping unused FUNCTION safeLog (x)

'####################################################################################################################

'> merger: Skipping unused FUNCTION asin (y)

'> merger: Skipping unused FUNCTION acos (y)

'> merger: Skipping unused FUNCTION safeAcos (y)

'> merger: Skipping unused FUNCTION atan2 (y, x)

'####################################################################################################################
'# Screen mode selector v1.0 (routines)
'# By Zom-B
'####################################################################################################################

SUB selectScreenMode (yOffset%, colors%)
    DIM aspectName$(10), aspectCol%(10)
    RESTORE videoaspect
    FOR y% = 0 TO 10
        READ aspectName$(y%), aspectCol%(y%)
        IF aspectCol%(y%) = 0 THEN numAspect% = y% - 1: EXIT FOR
    NEXT

    DIM vidX%(100), vidY%(100), vidA%(100)
    RESTORE videomodes
    FOR y% = 1 TO 100
        READ vidX%(y%), vidY%(y%), vidA%(y%)
        IF (vidX%(y%) <= 0) THEN numModes% = y% - 1: EXIT FOR
    NEXT

    IF numModes% > _HEIGHT - yOffset% - 1 THEN numModes% = _HEIGHT - yOffset% - 1

    DEF SEG = &HB800
    LOCATE yOffset% + 1, 1
    PRINT "Select video mode:"; TAB(61); "Click "
    POKE yOffset% * 160 + 132, 31

    y% = 0
    lastY% = 0
    selectedAspect% = 0
    reprint% = 1
    lastButton% = 0
    DO
        IF INKEY$ = CHR$(27) THEN CLS: SYSTEM
        IF reprint% THEN
            reprint% = 0

            FOR x% = 1 TO numModes%
                LOCATE yOffset% + x% + 1, 1
                COLOR 7, 0
                PRINT USING "##:"; x%;
                IF selectedAspect% = 0 THEN
                    COLOR aspectCol%(vidA%(x%))
                ELSEIF selectedAspect% = vidA%(x%) THEN
                    COLOR 15
                ELSE
                    COLOR 8
                END IF
                PRINT STR$(vidX%(x%)); ","; vidY%(x%);
            NEXT

            FOR x% = 0 TO numAspect%
                IF x% > 0 AND selectedAspect% = x% THEN
                    COLOR aspectCol%(x%), 3
                ELSE
                    COLOR aspectCol%(x%), 0
                END IF
                LOCATE yOffset% + x% + 2, 64
                PRINT "<"; aspectName$(x%); ">"
            NEXT
        END IF
        IF _MOUSEINPUT THEN
            IF lastY% > 0 THEN
                FOR x% = 0 TO 159 STEP 2
                    POKE lastY% + x%, PEEK(lastY% + x%) AND &HEF
                NEXT
            END IF

            x% = _MOUSEX
            y% = _MOUSEY - yOffset% - 1

            IF x% <= 60 THEN
                IF y% > 0 AND y% <= numModes% THEN
                    IF _MOUSEBUTTON(1) = 0 AND lastButton% THEN EXIT DO
                    y% = (yOffset% + y%) * 160 + 1
                    FOR x% = 0 TO 119 STEP 2
                        POKE y% + x%, PEEK(y% + x%) OR &H10
                    NEXT
                ELSE
                    y% = 0
                END IF
            ELSE
                IF y% > 0 AND y% - 1 <= numAspect% THEN
                    IF _MOUSEBUTTON(1) THEN
                        selectedAspect% = y% - 1
                        reprint% = 1
                    END IF
                    y% = (yOffset% + y%) * 160 + 1
                    FOR x% = 120 TO 159 STEP 2
                        POKE y% + x%, PEEK(y% + x%) OR &H10
                    NEXT
                ELSE
                    y% = 0
                END IF
            END IF
            lastY% = y%
            lastButton% = _MOUSEBUTTON(1)
        END IF
    LOOP

    CLS 'bug evasion for small video modes
    SCREEN _NEWIMAGE(vidX%(y%), vidY%(y%), colors%)
END SUB

'####################################################################################################################
'# Ultra Fractal Gradient library v1.1 (routines)
'# By Zom-B
'#
'# Smooth Gradient algorithm from Ultra Fractal (www.ultrafractal.com)
'####################################################################################################################

'> merger: Skipping unused SUB defaultGradient (gi%)

'> merger: Skipping unused SUB grayscaleGradient (gi%)

'####################################################################################################################

SUB setNumGradients (gi%)
    offset% = LBOUND(gradientPoints) - 1
    REDIM _PRESERVE gradientSmooth(gi% + offset%) AS _BYTE '_BIT <- bugged
    REDIM _PRESERVE gradientPoints(gi% + offset%) AS INTEGER
    REDIM _PRESERVE gradient(gi% + offset%, 1) AS GRADIENTPOINT
END FUNCTION

SUB addGradientPoint (gi%, index!, r!, g!, b!)
    p% = gradientPoints(gi%)

    IF UBOUND(gradient, 2) < p% THEN
        REDIM _PRESERVE gradient(0 TO UBOUND(gradient, 1), 0 TO p%) AS GRADIENTPOINT
    END IF

    gradient(gi%, p%).index = index!
    gradient(gi%, p%).r = r!
    gradient(gi%, p%).g = g!
    gradient(gi%, p%).b = b!
    gradientPoints(gi%) = p% + 1
END SUB

SUB setGradientSmooth (gi%, s%)
    gradientSmooth(gi%) = s%

    IF gradientSmooth(0) = 0 THEN EXIT SUB

    FOR i% = 0 TO gradientPoints(gi%) - 1
        ip1% = i% + 1
        IF ip1% = gradientPoints(gi%) THEN ip1% = 2
        in1% = i% - 1
        IF in1% = -1 THEN in1% = gradientPoints(gi%) - 3

        dxl! = gradient(gi%, i%).index - gradient(gi%, in1%).index
        dxr! = gradient(gi%, ip1%).index - gradient(gi%, i%).index
        IF dxl! < 0 THEN dxl! = dxl! + 1
        IF dxr! < 0 THEN dxr! = dxr! + 1

        d! = (gradient(gi%, i%).r - gradient(gi%, in1%).r) * dxr!
        IF d! = 0 THEN
            gradient(gi%, i%).rdr = 0
            gradient(gi%, i%).rdl = 0
        ELSE
            d! = (gradient(gi%, ip1%).r - gradient(gi%, i%).r) * dxl! / d!
            IF d! <= 0 THEN
                gradient(gi%, i%).rdr = 0
                gradient(gi%, i%).rdl = 0
            ELSE
                gradient(gi%, i%).rdr = 1 / (1 + d!)
                gradient(gi%, i%).rdl = gradient(gi%, i%).rdr - 1
            END IF
        END IF

        d! = (gradient(gi%, i%).g - gradient(gi%, in1%).g) * dxr!
        IF d! = 0 THEN
            gradient(gi%, i%).gdr = 0
            gradient(gi%, i%).gdl = 0
        ELSE
            d! = (gradient(gi%, ip1%).g - gradient(gi%, i%).g) * dxl! / d!
            IF d! <= 0 THEN
                gradient(gi%, i%).gdr = 0
                gradient(gi%, i%).gdl = 0
            ELSE
                gradient(gi%, i%).gdr = 1 / (1 + d!)
                gradient(gi%, i%).gdl = gradient(gi%, i%).gdr - 1
            END IF
        END IF

        d! = (gradient(gi%, i%).b - gradient(gi%, in1%).b) * dxr!
        IF d! = 0 THEN
            gradient(gi%, i%).bdr = 0
            gradient(gi%, i%).bdl = 0
        ELSE
            d! = (gradient(gi%, ip1%).b - gradient(gi%, i%).b) * dxl! / d!
            IF d! <= 0 THEN
                gradient(gi%, i%).bdr = 0
                gradient(gi%, i%).bdl = 0
            ELSE
                gradient(gi%, i%).bdr = 1 / (1 + d!)
                gradient(gi%, i%).bdl = gradient(gi%, i%).bdr - 1
            END IF
        END IF
    NEXT
END SUB

'####################################################################################################################

SUB getGradient (gi%, index!, red!, green!, blue!)
    IF index! < 0 THEN x! = 0 ELSE x! = index! - INT(index!)

    FOR l% = gradientPoints(gi%) - 2 TO 1 STEP -1
        IF gradient(gi%, l%).index <= x! THEN
            EXIT FOR
        END IF
    NEXT

    r% = l% + 1
    u! = (x! - gradient(gi%, l%).index) / (gradient(gi%, r%).index - gradient(gi%, l%).index)

    IF gradientSmooth(gi%) THEN
        u2! = u! * u!
        u3! = u2! * u!
        ur! = u3! - (u2! + u2!) + u!
        ul! = u2! - u3!

        red! = gradient(gi%, l%).r + (gradient(gi%, r%).r - gradient(gi%, l%).r) * (u3! + 3 * (gradient(gi%, l%).rdr * ur! + (1 + gradient(gi%, r%).rdl) * ul!))
        green! = gradient(gi%, l%).g + (gradient(gi%, r%).g - gradient(gi%, l%).g) * (u3! + 3 * (gradient(gi%, l%).gdr * ur! + (1 + gradient(gi%, r%).gdl) * ul!))
        blue! = gradient(gi%, l%).b + (gradient(gi%, r%).b - gradient(gi%, l%).b) * (u3! + 3 * (gradient(gi%, l%).bdr * ur! + (1 + gradient(gi%, r%).bdl) * ul!))
    ELSE
        red! = gradient(gi%, l%).r + (gradient(gi%, r%).r - gradient(gi%, l%).r) * u!
        green! = gradient(gi%, l%).g + (gradient(gi%, r%).g - gradient(gi%, l%).g) * u!
        blue! = gradient(gi%, l%).b + (gradient(gi%, r%).b - gradient(gi%, l%).b) * u!
    END IF
END SUB

'> merger: Skipping unused SUB testGradient (gi%)

'####################################################################################################################
'# Merge modes library v0.11 (routines)
'# By Zom-B
'####################################################################################################################

'> merger: Skipping unused SUB testMerge

'####################################################################################################################

'> merger: Skipping unused SUB mergeMultiply (br!, bg!, bb!, tr!, tg!, tb!)

SUB mergeScreen (br!, bg!, bb!, tr!, tg!, tb!)
    br! = 1 - (1 - br!) * (1 - tr!)
    bg! = 1 - (1 - bg!) * (1 - tg!)
    bb! = 1 - (1 - bb!) * (1 - tb!)
END SUB

SUB mergeOverlay (br!, bg!, bb!, tr!, tg!, tb!)
    IF br! <= 0.5 THEN br! = br! * tr! * 2 ELSE br! = 1 - (1 - br!) * (1 - tr!) * 2
    IF bg! <= 0.5 THEN bg! = bg! * tg! * 2 ELSE bg! = 1 - (1 - bg!) * (1 - tg!) * 2
    IF bb! <= 0.5 THEN bb! = bb! * tb! * 2 ELSE bb! = 1 - (1 - bb!) * (1 - tb!) * 2
END SUB

'> merger: Skipping unused SUB mergeHardLight (br!, bg!, bb!, tr!, tg!, tb!)

'> merger: Skipping unused SUB mergeSoftLight (br!, bg!, bb!, tr!, tg!, tb!)

'> merger: Skipping unused SUB mergeDarken (br!, bg!, bb!, tr!, tg!, tb!)

'> merger: Skipping unused SUB mergeLighten (br!, bg!, bb!, tr!, tg!, tb!)

'> merger: Skipping unused SUB mergeDifference (br!, bg!, bb!, tr!, tg!, tb!)

'> merger: Skipping unused SUB mergeColor (r!, g!, b!, r2!, g2!, b2!)

'> merger: Skipping unused SUB mergeAddition (br!, bg!, bb!, tr!, tg!, tb!)

'> merger: Skipping unused SUB mergeSubtraction (br!, bg!, bb!, tr!, tg!, tb!)

SUB mergeHSLAddition (r!, g!, b!, r2!, g2!, b2!)
    largest! = r!
    smallest! = r!
    IF largest! < g! THEN largest! = g!
    IF smallest! > g! THEN smallest! = g!
    IF largest! < b! THEN largest! = b!
    IF smallest! > b! THEN smallest! = b!

    lum! = (largest! + smallest!) * 0.5
    chr! = largest! - smallest!

    IF lum! < 0.5 THEN
        sat! = chr! / (2 * lum!)
    ELSE
        sat! = chr! / (2 - 2 * lum!)
    END IF
    IF chr! = 0 THEN
        hue! = 0
    ELSEIF largest! = r! THEN
        hue! = (g! - b!) / chr!
    ELSEIF largest! = g! THEN
        hue! = (b! - r!) / chr! + 2
    ELSE
        hue! = (r! - g!) / chr! + 4
    END IF

    largest! = r2!
    smallest! = r2!
    IF largest! < g2! THEN largest! = g2!
    IF smallest! > g2! THEN smallest! = g2!
    IF largest! < b2! THEN largest! = b2!
    IF smallest! > b2! THEN smallest! = b2!

    lum2! = (largest! + smallest!) * 0.5
    chr2! = largest! - smallest!

    IF lum2! < 0.5 THEN
        sat2! = chr2! / (2 * lum2!)
    ELSE
        sat2! = chr2! / (2 - 2 * lum2!)
    END IF
    IF chr2! = 0 THEN
        hue! = hue!
    ELSEIF largest! = r2! THEN
        hue! = hue! + (g2! - b2!) / chr2!
    ELSEIF largest! = g2! THEN
        hue! = hue! + (b2! - r2!) / chr2! + 2
    ELSE
        hue! = hue! + (r2! - g2!) / chr2! + 4
    END IF
    IF hue! < 0 THEN hue! = hue! + 6 ELSE IF hue! > 6 THEN hue! = hue! - 6

    sat! = sat! + sat2! - 0.5: IF sat! < 0 THEN sat! = 0 ELSE IF sat! > 1 THEN sat! = 1
    lum! = lum! + lum2! - 0.5: IF lum! < 0 THEN lum! = 0 ELSE IF lum! > 1 THEN lum! = 1

    IF lum! < 0.5 THEN
        chr! = sat! * 2 * lum!
    ELSE
        chr! = sat! * (2 - 2 * lum!)
    END IF

    smallest! = lum! - chr! * 0.5

    x! = chr! * (1 - ABS(hue! - INT(hue! / 2) * 2 - 1))
    SELECT CASE hue!
        CASE IS <= 1: r! = chr! + smallest!: g! = x! + smallest!: b! = smallest!
        CASE IS <= 2: r! = x! + smallest!: g! = chr! + smallest!: b! = smallest!
        CASE IS <= 3: r! = smallest!: g! = chr! + smallest!: b! = x! + smallest!
        CASE IS <= 4: r! = smallest!: g! = x! + smallest!: b! = chr! + smallest!
        CASE IS <= 5: r! = x! + smallest!: g! = smallest!: b! = chr! + smallest!
        CASE ELSE: r! = chr! + smallest!: g! = smallest!: b! = x! + smallest!
    END SELECT
END SUB

'> merger: Skipping unused SUB mergeRed (br!, bg!, bb!, tr!, tg!, tb!)

'> merger: Skipping unused SUB mergeGreen (br!, bg!, bb!, tr!, tg!, tb!)

'> merger: Skipping unused SUB mergeBlue (br!, bg!, bb!, tr!, tg!, tb!)

'####################################################################################################################

'> merger: Skipping unused SUB mergeHue (r!, g!, b!, r2!, g2!, b2!)

'> merger: Skipping unused SUB rgb2hsl (r!, g!, b!, chr!, smallest!, hue!, sat!, lum!)

'> merger: Skipping unused SUB hsl2rgb (hue!, sat!, lum!, r!, g!, b!)

'> merger: Skipping unused SUB hsl2rgb2 (hue!, chr!, smallest!, r!, g!, b!)

```

### File(s)

* [hearts-and-butterflies.bas](src/hearts-and-butterflies.bas)
* [interestingspiral2.bas](src/interestingspiral2.bas)
* [sierpinsky-rays+aet.bas](src/sierpinsky-rays+aet.bas)
* [the-burning-of-julia2.1.bas](src/the-burning-of-julia2.1.bas)

### Additional Image(s)

![interestingspiral2.png](img/interestingspiral2.png)
![sierpinsky-rays+aet.png](img/sierpinsky-rays+aet.png)
![the-burning-of-julia2.1.png](img/the-burning-of-julia2.1.png)

🔗 [fractal](../fractal.md), [art](../art.md)


<sub>Reference: [qb64.net Forum](https://qb64forum.alephc.xyz/index.php?topic=173.0) </sub>
