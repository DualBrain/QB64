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

