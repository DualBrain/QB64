'#lang "qb" '...for freebasic compiler. Must disable for QB64 features.

' *** Video settings. ***

screenwidth = 640
screenheight = 480
SCREEN 12

' *** Performance settings. ***

bignumber = 500000 ' Maximum objects per array (determined by memory).
globaldelayinit = 1000 ' Loop damping factor (fine adjustment below).
RANDOMIZE TIMER

' *** Initialize counters and array sizes. ***

numparticleorig = bignumber
numparticlevisible = bignumber
numdoubletorig = bignumber
numdoubletclip = bignumber
numdoubletclipwork = bignumber
numdoubletsnip = bignumber
numdoubletsnipwork = bignumber
numdoubletintinfo = bignumber
numtripletorig = bignumber
numtripletfaceon = bignumber
numtripletclip = bignumber
numtripletclipwork = bignumber
numtripletsnip = bignumber
numtripletsnipimage = bignumber
numtripletsnipwork = bignumber
numtripletencpoint = bignumber
numtripletintpointpair = bignumber
numtripletfinal = bignumber

' *** Define basis arrays and structures. ***

' Screen vectors in three-space.
' These vectors define the camera angle.
DIM uhat(1 TO 3), vhat(1 TO 3), nhat(1 TO 3)

' View clipping planes defined in three-space.
DIM nearplane(1 TO 4), farplane(1 TO 4), rightplane(1 TO 4), leftplane(1 TO 4), topplane(1 TO 4), bottomplane(1 TO 4)
DIM nearplanespotlight(1 TO 4), farplanespotlight(1 TO 4), rightplanespotlight(1 TO 4), leftplanespotlight(1 TO 4), topplanespotlight(1 TO 4), bottomplanespotlight(1 TO 4)

' Basis vectors defined in three-space.
DIM xhat(1 TO 4), yhat(1 TO 4), zhat(1 TO 4)
xhat(1) = 1: xhat(2) = 0: xhat(3) = 0: xhat(4) = 4
yhat(1) = 0: yhat(2) = 1: yhat(3) = 0: yhat(4) = 2
zhat(1) = 0: zhat(2) = 0: zhat(3) = 1: zhat(4) = 1

' Basis vectors projected into uv two-space.
DIM xhatp(1 TO 2), yhatp(1 TO 2), zhatp(1 TO 2)
DIM xhatp.old(1 TO 2), yhatp.old(1 TO 2), zhatp.old(1 TO 2)

' *** Define particle arrays and structures. ***

' Particle vectors defined in three-space.
DIM vec(numparticleorig, 4)
DIM vecdotnhat(numparticleorig)
DIM vecdotnhatunit.old(numparticleorig)
DIM vecvisible(numparticlevisible, 4)
DIM vecvisibledotnhat(numparticlevisible)
DIM vecvisibledotnhatunit.old(numparticlevisible)

' Particle vectors projected onto infinite uv two-space.
DIM vecpuv(numparticleorig, 1 TO 2)
DIM vecpuv.old(numparticleorig, 1 TO 2)
DIM vecvisiblepuv(numparticlevisible, 1 TO 2)
DIM vecvisiblepuv.old(numparticlevisible, 1 TO 2)

' Particle projections adjusted for screen uv two-space.
DIM vecpuvs(numparticleorig, 1 TO 2)
DIM vecpuvs.old(numparticleorig, 1 TO 2)
DIM vecvisiblepuvs(numparticlevisible, 1 TO 2)
DIM vecvisiblepuvs.old(numparticlevisible, 1 TO 2)

' *** Define doublet arrays and structures. ***

' Doublet vectors defined in three-space.
DIM doubletorig(numdoubletorig, 7)

' Doublet vectors clipped by view planes.
DIM doubletclip(numdoubletclip, 7)
DIM doubletclipdotnhat(numdoubletclip, 2)
DIM doubletclipdotnhat.old(numdoubletclip, 2)
DIM doubletclipwork(numdoubletclipwork, 7)
DIM doubletclipworkdotnhat(numdoubletclipwork, 2)
DIM doubletclipworkdotnhat.old(numdoubletclipwork, 2)

' Doublet vectors clipped and projected onto infinite uv two-space.
DIM doubletclippuv(numdoubletclip, 4)
DIM doubletclippuv.old(numdoubletclip, 4)

' Doublet vectors snipped by apparent intersections.
DIM doubletsnip(numdoubletsnip, 7)
DIM doubletsnipwork(numdoubletsnipwork, 7)
DIM doubletsnipdotnhat(numdoubletsnip, 2)
DIM doubletsnipdotnhat.old(numdoubletsnip, 2)

' Doublet vectors snipped and projected onto infinite uv two-space.
DIM doubletsnippuv(numdoubletsnip, 4)
DIM doubletsnippuv.old(numdoubletsnip, 4)

' Array information inferred from apparent intersections.
DIM doubletintinfo(numdoubletintinfo, 2)

' Doublet projections adjusted for screen uv two-space.
DIM doubletsnippuvs(numdoubletsnip, 4)
DIM doubletsnippuvs.old(numdoubletsnip, 4)
DIM doubletclippuvs(numdoubletclip, 4)
DIM doubletclippuvs.old(numdoubletclip, 4)

' *** Define triplet arrays and structures. ***

' Triplet vectors defined in three-space.
DIM tripletorig(numtripletorig, 10)

' Triplet vectors after discarding outfacing members.
DIM tripletfaceon(numtripletfaceon, 10)
DIM tripletfaceondotnhat(numtripletfaceon, 3)
DIM tripletfaceondotnhat.old(numtripletfaceon, 3)

' Triplet vectors clipped by view planes.
DIM tripletclip(numtripletclip, 10)
DIM tripletclipdotnhat(numtripletclip, 3)
DIM tripletclipdotnhat.old(numtripletclip, 3)
DIM tripletclipwork(numtripletclipwork, 10)
DIM tripletclipworkdotnhat(numtripletclipwork, 3)
DIM tripletclipworkdotnhat.old(numtripletclipwork, 3)

' Triplet vectors clipped and projected onto infinite uv two-space.
DIM tripletfaceonpuv(numtripletfaceon, 6)
DIM tripletfaceonpuv.old(numtripletfaceon, 6)
DIM tripletclippuv(numtripletclip, 6)
DIM tripletclippuv.old(numtripletclip, 6)

' Triplet vectors snipped by apparent intersections.
DIM tripletsnip(numtripletsnip, 10)
DIM tripletsnipimage(numtripletsnipimage, 10)
DIM tripletsnipwork(numtripletsnipwork, 10)
DIM tripletsnipdotnhat(numtripletsnip, 3)
DIM tripletsnipdotnhat.old(numtripletsnip, 3)
DIM tripletfinal(numtripletfinal, 10)
DIM tripletfinaldotnhat(numtripletfinal, 3)
DIM tripletfinaldotnhat.old(numtripletfinal, 3)

' Triplet vectors snipped and projected onto infinite uv two-space.
'DIM tripletsnippuv(numtripletsnip, 7)
'DIM tripletsnippuv.old(numtripletsnip, 7)
DIM tripletfinalpuv(numtripletfinal, 7)
DIM tripletfinalpuv.old(numtripletfinal, 7)

' Array information inferred from apparent intersections.
DIM tripletencpoint(9, 8)
DIM tripletintpointpair(9, 21)

' Triplet projections adjusted for screen uv two-space.
DIM tripletfinalpuvs(numtripletfinal, 6)
DIM tripletfinalpuvs.old(numtripletfinal, 6)

' *** Define specialized arrays and structures. ***

' Arrays for tech 2 mesh plotting.
DIM plotflag(numparticleorig)
DIM plotflag.old(numparticleorig)

' Binary switches for triangle snip algorithm.
snip000enabled = 1
snip004enabled = 1
snip030enabled = 1
snip003enabled = 1
snip006enabled = 1
snip012enabled = 1
snip102enabled = 1
snip112enabled = 1
snip022enabled = 1
snip202enabled = 1
snip122enabled = 1
snip212enabled = 1
snip014enabled = 1
snip104enabled = 1
snip114enabled = 1

' *** Set mathematical constants. ***

pi = 3.1415926536
ee = 2.7182818285

mainstart:

' *** Initialize user input variables. ***
key$ = ""
'mousekey$ = ""

' *** Show first visual. ***

CLS
COLOR 15
PRINT " *** Welcome to 3DCTRWGRAPH ***"
PRINT "     by: William F. Barnes"
PRINT
PRINT " 3D Graphics and Physics Engine"
PRINT
COLOR 14
PRINT " -3D World Prototypes-"
PRINT " 1:  3D world made of only particles. (Type 'file' to load object3d.txt)"
PRINT " 2:  3D world made of line segments with three-space clipping feature."
PRINT " 3:  3D polygon world using advanded three-space clipping algorithm."
COLOR 15
PRINT
PRINT " -Plotting and Geometry Demonstrations-"
PRINT " 4:  Parameterized curve with linear point connecting."
PRINT " 5:  Parameterized surface made of single points."
PRINT " 6:  Molecule with atoms connected by lines."
PRINT " 7:  Abstract 3D objects with near-neighbor tiling."
PRINT " 8:  Time-animated surface in simple mesh tiling."
PRINT " 9:  Time-animated surface in tech-2 mesh tiling."
COLOR 8
PRINT " 10: Spherical harmonics (in development) in single point plot mode."
COLOR 15
PRINT
PRINT " -Physics Engine Demonstrations-"
PRINT " 11: Solution to 2D Laplace equation via relaxation in tech-2 mesh tiling."
PRINT " 12: Sphere with random surface features in tech-2 custom mesh tiling."
PRINT " 13: Wave 2D propagation on flexible membrane in simple mesh tiling."
PRINT " 14: Waves on infinite surface in simple mesh tiling."
PRINT " 15: Brownian mating bacteria in custom single point plot mode."
PRINT " 16: Elementary neural network with three-space neighbor-connections."
PRINT: INPUT " Enter a choice (99 to quit) and press ENTER: ", a$

' *** Process first user input. ***

SELECT CASE a$
    CASE "1": genscheme$ = "3denvparticles": plotmode$ = "3denvparticles"
    CASE "file": genscheme$ = "3denvparticlesfile": plotmode$ = "3denvparticles"
    CASE "2": genscheme$ = "3denvdoublets": plotmode$ = "3denvdoublets"
    CASE "3": genscheme$ = "3denvtriplets": plotmode$ = "3denvtriplets"
    CASE "4": genscheme$ = "curve": plotmode$ = "linearconnect"
    CASE "5": genscheme$ = "simplepoints": plotmode$ = "simplepoints"
    CASE "6": genscheme$ = "molecule": plotmode$ = "molecule"
    CASE "7": genscheme$ = "neighbortile": plotmode$ = "neighbortile"
    CASE "8": genscheme$ = "animatedflag": plotmode$ = "simplemesh"
    CASE "9": genscheme$ = "animatedpretzel": plotmode$ = "meshtech2"
    CASE "10": genscheme$ = "sphericalharmonics": plotmode$ = "simplepoints"
    CASE "11": genscheme$ = "laplace2d": plotmode$ = "meshtech2"
    CASE "12": genscheme$ = "planet": plotmode$ = "meshtech2planet"
    CASE "13": genscheme$ = "wave2d": plotmode$ = "simplemesh"
    CASE "14": genscheme$ = "wave2dinf": plotmode$ = "simplemesh"
    CASE "15": genscheme$ = "bacteria": plotmode$ = "simplepointsbacteria"
    CASE "16": genscheme$ = "neuron": plotmode$ = "linearneuron"
    CASE "99": END
    CASE ELSE: GOTO mainstart
END SELECT

substart:

' *** Zero counters and array sizes. ***

numparticleorig = 0
numparticlevisible = 0
numdoubletorig = 0
numdoubletclip = 0
numdoubletclipwork = 0
numdoubletsnip = 0
numdoubletsnipwork = 0
numdoubletintinfo = 0
numtripletorig = 0
numtripletfaceon = 0
numtripletclip = 0
numtripletclipwork = 0
numtripletsnip = 0
numtripletsnipimage = 0
numtripletsnipwork = 0
numtripletencpoint = 0
numtripletintpointpair = 0
numtripletfinal = 0
pcountparticleorig = 0
pcountdoubletorig = 0
pcounttripletorig = 0

' *** Constants and switch control. ***

' Perspective and animation switches/defaults.
fovd = -256
nearplane(4) = 3
farplane(4) = -100
rightplane(4) = 0 '*' fovd * (nhat(1) * rightplane(1) + nhat(2) * rightplane(2) + nhat(3) * rightplane(3))
leftplane(4) = 0
topplane(4) = 0
bottomplane(4) = 0
spotlightwidth = 1.3
spotlightthickness = 3
spotlightwidth = 1.3
spotlightcenter = 20
nearplanespotlight(4) = spotlightcenter - spotlightthickness / 2
farplanespotlight(4) = -(spotlightcenter + spotlightthickness / 2)
rightplanespotlight(4) = 0
leftplanespotlight(4) = 0
topplanespotlight(4) = 0
bottomplanespotlight(4) = 0
centerx = screenwidth / 2
centery = screenheight / 2
speedconst = 50
falsedepth = .01
zoom = 30
timevar = 0
T = 0
togglehud = 1
toggleatomnumbers = -1
toggletimeanimate = -1
toggletimealert = 0
camx = 0
camy = 0
camz = 0
uhat(1) = -3: uhat(2) = 5: uhat(3) = 1 / 4
vhat(1) = -1: vhat(2) = -1: vhat(3) = 8

CLS

SELECT CASE LCASE$(genscheme$)
    CASE "curve":
        GOSUB genscheme.curve
        numparticleorig = pcountparticleorig
    CASE "simplepoints":
        uhat(1) = -0.2376385: uhat(2) = 0.970313: uhat(3) = -0.04495043
        vhat(1) = -0.8201708: vhat(2) = -0.1756434: vhat(3) = 0.5444899
        GOSUB genscheme.simplepoints
        numparticleorig = pcountparticleorig
    CASE "3denvparticles":
        globaldelay = globaldelayinit * 1000
        uhat(1) = 0.8251367: uhat(2) = -0.564903: uhat(3) = -0.005829525
        vhat(1) = 0.065519: vhat(2) = 0.08544215: vhat(3) = 0.9941866
        falsedepth = 0
        zoom = 1.95
        toggletimeanimate = 1
        togglehud = -1
        toggletimealert = 1
        camx = 30
        camy = 25
        camz = -25
        GOSUB genscheme.3denvparticles.init
        numparticleorig = pcountparticleorig
    CASE "3denvparticlesfile":
        uhat(1) = 0.8251367: uhat(2) = -0.564903: uhat(3) = -0.005829525
        vhat(1) = 0.065519: vhat(2) = 0.08544215: vhat(3) = 0.9941866
        falsedepth = 0
        zoom = 1.95
        togglehud = -1
        camx = 30
        camy = 30
        camz = -25
        pcountparticleorig = 0
        OPEN "object3d.txt" FOR INPUT AS #1
        DO
            pcountparticleorig = pcountparticleorig + 1
            INPUT #1, vec(pcountparticleorig, 1), vec(pcountparticleorig, 2), vec(pcountparticleorig, 3), vec(pcountparticleorig, 4)
        LOOP WHILE EOF(1) = 0
        CLOSE #1
        numparticleorig = pcountparticleorig
    CASE "molecule":
        uhat(1) = -0.7027042: uhat(2) = 0.5818964: uhat(3) = -0.409394
        vhat(1) = -0.6446534: vhat(2) = -0.2772641: vhat(3) = 0.7124231
        zoom = 55
        togglehud = -1
        toggleatomnumbers = 1
        numparticleorig = 12
        REDIM vec(numparticleorig, 10)
        REDIM vecvisible(numparticleorig, 10)
        FOR i = 1 TO numparticleorig
            READ vec(i, 1), vec(i, 2), vec(i, 3), vec(i, 4), vec(i, 5), vec(i, 6), vec(i, 7), vec(i, 8), vec(i, 9), vec(i, 10)
        NEXT
        GOSUB genscheme.molecule
    CASE "neighbortile":
        GOSUB genscheme.neighbortile
        numparticleorig = pcountparticleorig
    CASE "3denvdoublets":
        uhat(1) = 0.7941225: uhat(2) = -0.6026734: uhat(3) = -0.07844898
        vhat(1) = 0.2287595: vhat(2) = 0.1768191: vhat(3) = 0.95729
        falsedepth = 0
        zoom = 1.95
        camx = 30
        camy = 45
        camz = -25
        GOSUB genscheme.3denvdoublets
        numparticleorig = pcountparticleorig
        numdoubletorig = pcountdoubletorig
    CASE "3denvtriplets":
        uhat(1) = 0.470269: uhat(2) = -0.8823329: uhat(3) = -0.01832148
        vhat(1) = -0.03788515: vhat(2) = -0.0409245: vhat(3) = 0.9984438
        falsedepth = 0
        zoom = 1.95
        camx = 20
        camy = 20
        camz = 17
        GOSUB genscheme.3denvtriplets
        numparticleorig = pcountparticleorig
        numtripletorig = pcounttripletorig
    CASE "animatedflag":
        globaldelay = globaldelayinit * 5000
        toggletimeanimate = 1
        togglehud = -1
        toggletimealert = 1
        uhat(1) = .7802773: uhat(2) = -.4759201: uhat(3) = .4058135
        vhat(1) = .2502121: vhat(2) = .8321912: vhat(3) = .4948249
        GOSUB genscheme.animatedsurface.init
        numparticleorig = pcountparticleorig
        REDIM vec2dztemp(xrange, yrange)
        GOSUB genschemeUSAcolors
    CASE "animatedpretzel":
        globaldelay = globaldelayinit * 5000
        uhat(1) = .7802773: uhat(2) = -.4759201: uhat(3) = .4058135
        vhat(1) = .2502121: vhat(2) = .8321912: vhat(3) = .4948249
        toggletimealert = 1
        GOSUB genscheme.animatedpretzel.init
        numparticleorig = pcountparticleorig
    CASE "sphericalharmonics":
        GOSUB genscheme.sphericalharmonics
        numparticleorig = pcountparticleorig
    CASE "laplace2d":
        uhat(1) = 0.4919244: uhat(2) = 0.869175: uhat(3) = 0.0504497
        vhat(1) = -0.2520696: vhat(2) = 0.08672012: vhat(3) = 0.9638156
        globaldelay = globaldelayinit * 1500
        togglehud = -1
        toggletimealert = 1
        GOSUB genscheme.laplace2d.init
        numparticleorig = pcountparticleorig
        REDIM vec2dz(xrange, yrange)
        REDIM vec2dztemp(xrange, yrange)
        REDIM vec2dzfixed(xrange, yrange)
        GOSUB genscheme.laplace2d.gridinit
    CASE "planet":
        globaldelay = globaldelayinit * 1500
        uhat(1) = 0.4868324: uhat(2) = 0.8719549: uhat(3) = -0.05185585
        vhat(1) = 0.458436: vhat(2) = -0.2045161: vhat(3) = 0.8648755
        togglehud = -1
        toggletimealert = 1
        GOSUB genscheme.planet.init
        numparticleorig = pcountparticleorig
        REDIM vec2ds(xrange, yrange)
        REDIM vec2dstemp(xrange, yrange)
        REDIM vec2dsfixed(xrange, yrange)
        GOSUB genscheme.planet.gridinit
    CASE "wave2d":
        globaldelay = globaldelayinit * 1500
        uhat(1) = .7802773: uhat(2) = -.4759201: uhat(3) = .4058135
        vhat(1) = .2502121: vhat(2) = .8321912: vhat(3) = .4948249
        togglehud = -1
        toggletimealert = 1
        GOSUB genscheme.wave2d.init
        numparticleorig = pcountparticleorig
        REDIM vec2dz(xrange, yrange)
        REDIM vec2dztemp(xrange, yrange)
        REDIM vec2dzprev(xrange, yrange)
        GOSUB genschemeUSAcolors
        GOSUB genscheme.wave2d.gridinit
    CASE "wave2dinf":
        globaldelay = globaldelayinit * 4000
        uhat(1) = 0.6781088: uhat(2) = 0.7263383: uhat(3) = 0.1122552
        vhat(1) = -0.4469305: vhat(2) = 0.2862689: vhat(3) = 0.8475278
        toggletimeanimate = 1
        togglehud = -1
        toggletimealert = 1
        GOSUB genscheme.wave2dinf.init
        numparticleorig = pcountparticleorig
        REDIM vec2dz(xrange, yrange)
        REDIM vec2dztemp(xrange, yrange)
        REDIM vec2dzfixed(xrange, yrange)
        REDIM vec2dzprev(xrange, yrange)
        GOSUB genscheme.wave2dinf.gridinit
    CASE "bacteria":
        falsedepth = 0.001
        globaldelay = globaldelayinit
        toggletimeanimate = 1
        toggletimealert = 1
        zoom = 3
        numcreatures = 300
        REDIM vec(numcreatures, 10)
        REDIM vecvisible(numcreatures, 10)
        GOSUB genscheme.bacteria.init
        numparticleorig = pcountparticleorig
    CASE "neuron":
        globaldelay = globaldelayinit
        uhat(1) = 0.3494484: uhat(2) = -0.9331037: uhat(3) = -0.08487199
        vhat(1) = 0.4430568: vhat(2) = 0.08476364: vhat(3) = 0.8924774
        toggletimeanimate = 1
        toggletimealert = 1
        togglehud = -1
        zoom = 1.5
        falsedepth = 0.001
        REDIM vec(bignumber, 15)
        REDIM vecvisible(bignumber, 15)
        REDIM vecpuvsrev(bignumber, 15)
        GOSUB genscheme.neuron.init
        numparticleorig = pcountparticleorig
END SELECT

' Move objects to accomodate initial camera position.
IF camx <> 0 AND camy <> 0 AND camz <> 0 THEN
    FOR i = 1 TO numparticleorig
        vec(i, 1) = vec(i, 1) + camx
        vec(i, 2) = vec(i, 2) + camy
        vec(i, 3) = vec(i, 3) + camz
    NEXT
    FOR i = 1 TO numdoubletorig
        doubletorig(i, 1) = doubletorig(i, 1) + camx
        doubletorig(i, 2) = doubletorig(i, 2) + camy
        doubletorig(i, 3) = doubletorig(i, 3) + camz
        doubletorig(i, 4) = doubletorig(i, 4) + camx
        doubletorig(i, 5) = doubletorig(i, 5) + camy
        doubletorig(i, 6) = doubletorig(i, 6) + camz
    NEXT
    FOR i = 1 TO numtripletorig
        tripletorig(i, 1) = tripletorig(i, 1) + camx
        tripletorig(i, 2) = tripletorig(i, 2) + camy
        tripletorig(i, 3) = tripletorig(i, 3) + camz
        tripletorig(i, 4) = tripletorig(i, 4) + camx
        tripletorig(i, 5) = tripletorig(i, 5) + camy
        tripletorig(i, 6) = tripletorig(i, 6) + camz
        tripletorig(i, 7) = tripletorig(i, 7) + camx
        tripletorig(i, 8) = tripletorig(i, 8) + camy
        tripletorig(i, 9) = tripletorig(i, 9) + camz
    NEXT
END IF

GOSUB redraw

' *** Begin main loop. ***
DO
    IF toggletimeanimate = 1 THEN
        GOSUB timeanimate
        flagredraw = 1
    END IF
    IF flagredraw = 1 THEN
        GOSUB redraw
        flagredraw = -1
    END IF
    'GOSUB mouseprocess
    GOSUB keyprocess
    IF toggletimeanimate = 1 THEN
        FOR delaycount = 1 TO globaldelay: NEXT
    END IF
LOOP
' *** End main loop. ***

' *** Begin function definitions. ***

' Comment out the conents of this gosub for non-QB64 compiler.
mouseprocess:
'DO
'    IF _MOUSEMOVEMENTX > 0 THEN
'        mousekey$ = "6"
'        GOSUB rotate.uhat.plus: GOSUB normalize.screen.vectors: flagredraw = 1
'    END IF
'    IF _MOUSEMOVEMENTX < 0 THEN
'        mousekey$ = "4"
'        GOSUB rotate.uhat.minus: GOSUB normalize.screen.vectors: flagredraw = 1
'    END IF
'    IF _MOUSEMOVEMENTY > 0 THEN
'        mousekey$ = "8"
'        GOSUB rotate.vhat.plus: GOSUB normalize.screen.vectors: flagredraw = 1
'    END IF
'    IF _MOUSEMOVEMENTY < 0 THEN
'       mousekey$ = "2"
'       GOSUB rotate.vhat.minus: GOSUB normalize.screen.vectors: flagredraw = 1
'   END IF
'   MouseLB = _MOUSEBUTTON(1)
'   MouseRB = _MOUSEBUTTON(2)
'LOOP WHILE _MOUSEINPUT
RETURN

keyprocess:
'IF mousekey$ <> "" THEN
'    key$ = mousekey$
'    mousekey$ = ""
'ELSE
key$ = INKEY$
'END IF
IF key$ <> "" THEN
    flagredraw = 1
END IF
SELECT CASE LCASE$(key$)
    CASE "8":
        GOSUB rotate.vhat.plus
    CASE "2":
        GOSUB rotate.vhat.minus
    CASE "4":
        GOSUB rotate.uhat.minus
    CASE "6":
        GOSUB rotate.uhat.plus
    CASE "7":
        GOSUB rotate.clockwise
    CASE "9":
        GOSUB rotate.counterclockwise
    CASE "1":
        GOSUB rotate.uhat.minus: GOSUB normalize.screen.vectors: GOSUB rotate.clockwise
    CASE "3":
        GOSUB rotate.uhat.plus: GOSUB normalize.screen.vectors: GOSUB rotate.counterclockwise
    CASE "w"
        GOSUB strafe.objects.nhat.plus
        GOSUB strafe.camera.nhat.plus
    CASE "s"
        GOSUB strafe.objects.nhat.minus
        GOSUB strafe.camera.nhat.minus
    CASE "a"
        GOSUB strafe.objects.uhat.plus
        GOSUB strafe.camera.uhat.plus
    CASE "d"
        GOSUB strafe.objects.uhat.minus
        GOSUB strafe.camera.uhat.minus
    CASE "q"
        GOSUB strafe.objects.vhat.plus
        GOSUB strafe.camera.vhat.plus
    CASE "e"
        GOSUB strafe.objects.vhat.minus
        GOSUB strafe.camera.vhat.minus
    CASE "x"
        uhat(1) = 0: uhat(2) = 1: uhat(3) = 0
        vhat(1) = 0: vhat(2) = 0: vhat(3) = 1
    CASE "y"
        uhat(1) = 0: uhat(2) = 0: uhat(3) = 1
        vhat(1) = 1: vhat(2) = 0: vhat(3) = 0
    CASE "z"
        uhat(1) = 1: uhat(2) = 0: uhat(3) = 0
        vhat(1) = 0: vhat(2) = 1: vhat(3) = 0
    CASE ","
        nearplane(4) = nearplane(4) - 1
        IF nearplane(4) < 0 THEN nearplane(4) = 0
    CASE "."
        nearplane(4) = nearplane(4) + 1
    CASE "]"
        farplane(4) = farplane(4) - 1
    CASE "["
        farplane(4) = farplane(4) + 1
    CASE "'"
        spotlightcenter = spotlightcenter + spotlightthickness / 2
    CASE ";"
        spotlightcenter = spotlightcenter - spotlightthickness / 2
        IF spotlightcenter < 0 THEN spotlightcenter = 0
    CASE "t"
        toggletimeanimate = -toggletimeanimate
    CASE "r"
        timevar = 0
    CASE "f"
        GOTO substart
    CASE "g"
        GOTO mainstart
    CASE "-"
        spotlightthickness = spotlightthickness - .25
        IF spotlightthickness < 0 THEN spotlightthickness = 0
        globaldelay = globaldelay * 1.1
    CASE "="
        spotlightthickness = spotlightthickness + .25
        globaldelay = globaldelay * 0.9
    CASE "`"
        globaldelayinit = globaldelay
    CASE " "
        togglehud = -togglehud
        CLS
    CASE "n"
        toggleatomnumbers = -toggleatomnumbers
        CLS
    CASE "/"
        OPEN "uvn.txt" FOR OUTPUT AS #1
        PRINT #1, uhat(1); uhat(2); uhat(3)
        PRINT #1, vhat(1); vhat(2); vhat(3)
        PRINT #1, nhat(1); nhat(2); nhat(3)
        CLOSE #1
        OPEN "vec1.txt" FOR OUTPUT AS #1
        PRINT #1, vec(1, 1); vec(1, 2); vec(1, 3)
        CLOSE #1
        OPEN "object3d.txt" FOR OUTPUT AS #1
        FOR i = 1 TO numparticleorig
            PRINT #1, vec(i, 1); "   "; vec(i, 2); "   "; vec(i, 3); "   "; vec(i, 4)
        NEXT
        CLOSE #1
    CASE CHR$(27)
        END
END SELECT
RETURN

convert:
' Convert graphics from uv-cartesian coordinates to monitor coordinates.
x0 = x: y0 = y
x = x0 + centerx
y = -y0 + centery
IF toggleatomnumbers = 1 THEN
    xtext = (x0 + centerx) * (80 / 640)
    ytext = (centery - y0) * (30 / 480) + 1
    IF xtext < 1 THEN xtext = 1
    IF xtext > 77 THEN xtext = 77
    IF ytext < 1 THEN ytext = 1
    IF ytext > 27 THEN ytext = 27
END IF
RETURN

' *** Define functions for view translation and rotation. ***

rotate.uhat.plus:
uhat(1) = nhat(1) + speedconst * uhat(1)
uhat(2) = nhat(2) + speedconst * uhat(2)
uhat(3) = nhat(3) + speedconst * uhat(3)
RETURN

rotate.uhat.minus:
uhat(1) = -nhat(1) + speedconst * uhat(1)
uhat(2) = -nhat(2) + speedconst * uhat(2)
uhat(3) = -nhat(3) + speedconst * uhat(3)
RETURN

rotate.vhat.plus:
vhat(1) = nhat(1) + speedconst * vhat(1)
vhat(2) = nhat(2) + speedconst * vhat(2)
vhat(3) = nhat(3) + speedconst * vhat(3)
RETURN

rotate.vhat.minus:
vhat(1) = -nhat(1) + speedconst * vhat(1)
vhat(2) = -nhat(2) + speedconst * vhat(2)
vhat(3) = -nhat(3) + speedconst * vhat(3)
RETURN

rotate.counterclockwise:
v1 = vhat(1)
v2 = vhat(2)
v3 = vhat(3)
vhat(1) = uhat(1) + speedconst * vhat(1)
vhat(2) = uhat(2) + speedconst * vhat(2)
vhat(3) = uhat(3) + speedconst * vhat(3)
uhat(1) = -v1 + speedconst * uhat(1)
uhat(2) = -v2 + speedconst * uhat(2)
uhat(3) = -v3 + speedconst * uhat(3)
RETURN

rotate.clockwise:
v1 = vhat(1)
v2 = vhat(2)
v3 = vhat(3)
vhat(1) = -uhat(1) + speedconst * vhat(1)
vhat(2) = -uhat(2) + speedconst * vhat(2)
vhat(3) = -uhat(3) + speedconst * vhat(3)
uhat(1) = v1 + speedconst * uhat(1)
uhat(2) = v2 + speedconst * uhat(2)
uhat(3) = v3 + speedconst * uhat(3)
RETURN
RETURN

strafe.objects.uhat.plus:
FOR i = 1 TO numparticleorig
    vec(i, 1) = vec(i, 1) + uhat(1) * 1 / zoom
    vec(i, 2) = vec(i, 2) + uhat(2) * 1 / zoom
    vec(i, 3) = vec(i, 3) + uhat(3) * 1 / zoom
NEXT
FOR i = 1 TO numdoubletorig
    doubletorig(i, 1) = doubletorig(i, 1) + uhat(1) * 1 / zoom
    doubletorig(i, 2) = doubletorig(i, 2) + uhat(2) * 1 / zoom
    doubletorig(i, 3) = doubletorig(i, 3) + uhat(3) * 1 / zoom
    doubletorig(i, 4) = doubletorig(i, 4) + uhat(1) * 1 / zoom
    doubletorig(i, 5) = doubletorig(i, 5) + uhat(2) * 1 / zoom
    doubletorig(i, 6) = doubletorig(i, 6) + uhat(3) * 1 / zoom
NEXT
FOR i = 1 TO numtripletorig
    tripletorig(i, 1) = tripletorig(i, 1) + uhat(1) * 1 / zoom
    tripletorig(i, 2) = tripletorig(i, 2) + uhat(2) * 1 / zoom
    tripletorig(i, 3) = tripletorig(i, 3) + uhat(3) * 1 / zoom
    tripletorig(i, 4) = tripletorig(i, 4) + uhat(1) * 1 / zoom
    tripletorig(i, 5) = tripletorig(i, 5) + uhat(2) * 1 / zoom
    tripletorig(i, 6) = tripletorig(i, 6) + uhat(3) * 1 / zoom
    tripletorig(i, 7) = tripletorig(i, 7) + uhat(1) * 1 / zoom
    tripletorig(i, 8) = tripletorig(i, 8) + uhat(2) * 1 / zoom
    tripletorig(i, 9) = tripletorig(i, 9) + uhat(3) * 1 / zoom
NEXT
RETURN

strafe.objects.uhat.minus:
FOR i = 1 TO numparticleorig
    vec(i, 1) = vec(i, 1) - uhat(1) * 1 / zoom
    vec(i, 2) = vec(i, 2) - uhat(2) * 1 / zoom
    vec(i, 3) = vec(i, 3) - uhat(3) * 1 / zoom
NEXT
FOR i = 1 TO numdoubletorig
    doubletorig(i, 1) = doubletorig(i, 1) - uhat(1) * 1 / zoom
    doubletorig(i, 2) = doubletorig(i, 2) - uhat(2) * 1 / zoom
    doubletorig(i, 3) = doubletorig(i, 3) - uhat(3) * 1 / zoom
    doubletorig(i, 4) = doubletorig(i, 4) - uhat(1) * 1 / zoom
    doubletorig(i, 5) = doubletorig(i, 5) - uhat(2) * 1 / zoom
    doubletorig(i, 6) = doubletorig(i, 6) - uhat(3) * 1 / zoom
NEXT
FOR i = 1 TO numtripletorig
    tripletorig(i, 1) = tripletorig(i, 1) - uhat(1) * 1 / zoom
    tripletorig(i, 2) = tripletorig(i, 2) - uhat(2) * 1 / zoom
    tripletorig(i, 3) = tripletorig(i, 3) - uhat(3) * 1 / zoom
    tripletorig(i, 4) = tripletorig(i, 4) - uhat(1) * 1 / zoom
    tripletorig(i, 5) = tripletorig(i, 5) - uhat(2) * 1 / zoom
    tripletorig(i, 6) = tripletorig(i, 6) - uhat(3) * 1 / zoom
    tripletorig(i, 7) = tripletorig(i, 7) - uhat(1) * 1 / zoom
    tripletorig(i, 8) = tripletorig(i, 8) - uhat(2) * 1 / zoom
    tripletorig(i, 9) = tripletorig(i, 9) - uhat(3) * 1 / zoom
NEXT
RETURN

strafe.objects.vhat.plus:
FOR i = 1 TO numparticleorig
    vec(i, 1) = vec(i, 1) + vhat(1) * 1 / zoom
    vec(i, 2) = vec(i, 2) + vhat(2) * 1 / zoom
    vec(i, 3) = vec(i, 3) + vhat(3) * 1 / zoom
NEXT
FOR i = 1 TO numdoubletorig
    doubletorig(i, 1) = doubletorig(i, 1) + vhat(1) * 1 / zoom
    doubletorig(i, 2) = doubletorig(i, 2) + vhat(2) * 1 / zoom
    doubletorig(i, 3) = doubletorig(i, 3) + vhat(3) * 1 / zoom
    doubletorig(i, 4) = doubletorig(i, 4) + vhat(1) * 1 / zoom
    doubletorig(i, 5) = doubletorig(i, 5) + vhat(2) * 1 / zoom
    doubletorig(i, 6) = doubletorig(i, 6) + vhat(3) * 1 / zoom
NEXT
FOR i = 1 TO numtripletorig
    tripletorig(i, 1) = tripletorig(i, 1) + vhat(1) * 1 / zoom
    tripletorig(i, 2) = tripletorig(i, 2) + vhat(2) * 1 / zoom
    tripletorig(i, 3) = tripletorig(i, 3) + vhat(3) * 1 / zoom
    tripletorig(i, 4) = tripletorig(i, 4) + vhat(1) * 1 / zoom
    tripletorig(i, 5) = tripletorig(i, 5) + vhat(2) * 1 / zoom
    tripletorig(i, 6) = tripletorig(i, 6) + vhat(3) * 1 / zoom
    tripletorig(i, 7) = tripletorig(i, 7) + vhat(1) * 1 / zoom
    tripletorig(i, 8) = tripletorig(i, 8) + vhat(2) * 1 / zoom
    tripletorig(i, 9) = tripletorig(i, 9) + vhat(3) * 1 / zoom
NEXT
RETURN

strafe.objects.vhat.minus:
FOR i = 1 TO numparticleorig
    vec(i, 1) = vec(i, 1) - vhat(1) * 1 / zoom
    vec(i, 2) = vec(i, 2) - vhat(2) * 1 / zoom
    vec(i, 3) = vec(i, 3) - vhat(3) * 1 / zoom
NEXT
FOR i = 1 TO numdoubletorig
    doubletorig(i, 1) = doubletorig(i, 1) - vhat(1) * 1 / zoom
    doubletorig(i, 2) = doubletorig(i, 2) - vhat(2) * 1 / zoom
    doubletorig(i, 3) = doubletorig(i, 3) - vhat(3) * 1 / zoom
    doubletorig(i, 4) = doubletorig(i, 4) - vhat(1) * 1 / zoom
    doubletorig(i, 5) = doubletorig(i, 5) - vhat(2) * 1 / zoom
    doubletorig(i, 6) = doubletorig(i, 6) - vhat(3) * 1 / zoom
NEXT
FOR i = 1 TO numtripletorig
    tripletorig(i, 1) = tripletorig(i, 1) - vhat(1) * 1 / zoom
    tripletorig(i, 2) = tripletorig(i, 2) - vhat(2) * 1 / zoom
    tripletorig(i, 3) = tripletorig(i, 3) - vhat(3) * 1 / zoom
    tripletorig(i, 4) = tripletorig(i, 4) - vhat(1) * 1 / zoom
    tripletorig(i, 5) = tripletorig(i, 5) - vhat(2) * 1 / zoom
    tripletorig(i, 6) = tripletorig(i, 6) - vhat(3) * 1 / zoom
    tripletorig(i, 7) = tripletorig(i, 7) - vhat(1) * 1 / zoom
    tripletorig(i, 8) = tripletorig(i, 8) - vhat(2) * 1 / zoom
    tripletorig(i, 9) = tripletorig(i, 9) - vhat(3) * 1 / zoom
NEXT
RETURN

strafe.objects.nhat.plus:
FOR i = 1 TO numparticleorig
    vec(i, 1) = vec(i, 1) + nhat(1) * 1 / zoom
    vec(i, 2) = vec(i, 2) + nhat(2) * 1 / zoom
    vec(i, 3) = vec(i, 3) + nhat(3) * 1 / zoom
NEXT
FOR i = 1 TO numdoubletorig
    doubletorig(i, 1) = doubletorig(i, 1) + nhat(1) * 1 / zoom
    doubletorig(i, 2) = doubletorig(i, 2) + nhat(2) * 1 / zoom
    doubletorig(i, 3) = doubletorig(i, 3) + nhat(3) * 1 / zoom
    doubletorig(i, 4) = doubletorig(i, 4) + nhat(1) * 1 / zoom
    doubletorig(i, 5) = doubletorig(i, 5) + nhat(2) * 1 / zoom
    doubletorig(i, 6) = doubletorig(i, 6) + nhat(3) * 1 / zoom
NEXT
FOR i = 1 TO numtripletorig
    tripletorig(i, 1) = tripletorig(i, 1) + nhat(1) * 1 / zoom
    tripletorig(i, 2) = tripletorig(i, 2) + nhat(2) * 1 / zoom
    tripletorig(i, 3) = tripletorig(i, 3) + nhat(3) * 1 / zoom
    tripletorig(i, 4) = tripletorig(i, 4) + nhat(1) * 1 / zoom
    tripletorig(i, 5) = tripletorig(i, 5) + nhat(2) * 1 / zoom
    tripletorig(i, 6) = tripletorig(i, 6) + nhat(3) * 1 / zoom
    tripletorig(i, 7) = tripletorig(i, 7) + nhat(1) * 1 / zoom
    tripletorig(i, 8) = tripletorig(i, 8) + nhat(2) * 1 / zoom
    tripletorig(i, 9) = tripletorig(i, 9) + nhat(3) * 1 / zoom
NEXT
RETURN

strafe.objects.nhat.minus:
FOR i = 1 TO numparticleorig
    vec(i, 1) = vec(i, 1) - nhat(1) * 1 / zoom
    vec(i, 2) = vec(i, 2) - nhat(2) * 1 / zoom
    vec(i, 3) = vec(i, 3) - nhat(3) * 1 / zoom
NEXT
FOR i = 1 TO numdoubletorig
    doubletorig(i, 1) = doubletorig(i, 1) - nhat(1) * 1 / zoom
    doubletorig(i, 2) = doubletorig(i, 2) - nhat(2) * 1 / zoom
    doubletorig(i, 3) = doubletorig(i, 3) - nhat(3) * 1 / zoom
    doubletorig(i, 4) = doubletorig(i, 4) - nhat(1) * 1 / zoom
    doubletorig(i, 5) = doubletorig(i, 5) - nhat(2) * 1 / zoom
    doubletorig(i, 6) = doubletorig(i, 6) - nhat(3) * 1 / zoom
NEXT
FOR i = 1 TO numtripletorig
    tripletorig(i, 1) = tripletorig(i, 1) - nhat(1) * 1 / zoom
    tripletorig(i, 2) = tripletorig(i, 2) - nhat(2) * 1 / zoom
    tripletorig(i, 3) = tripletorig(i, 3) - nhat(3) * 1 / zoom
    tripletorig(i, 4) = tripletorig(i, 4) - nhat(1) * 1 / zoom
    tripletorig(i, 5) = tripletorig(i, 5) - nhat(2) * 1 / zoom
    tripletorig(i, 6) = tripletorig(i, 6) - nhat(3) * 1 / zoom
    tripletorig(i, 7) = tripletorig(i, 7) - nhat(1) * 1 / zoom
    tripletorig(i, 8) = tripletorig(i, 8) - nhat(2) * 1 / zoom
    tripletorig(i, 9) = tripletorig(i, 9) - nhat(3) * 1 / zoom
NEXT
RETURN

strafe.camera.uhat.plus:
camx = camx + uhat(1) * 1 / zoom
camy = camy + uhat(2) * 1 / zoom
camz = camz + uhat(3) * 1 / zoom
RETURN

strafe.camera.uhat.minus:
camx = camx - uhat(1) * 1 / zoom
camy = camy - uhat(2) * 1 / zoom
camz = camz - uhat(3) * 1 / zoom
RETURN

strafe.camera.vhat.plus:
camx = camx + vhat(1) * 1 / zoom
camy = camy + vhat(2) * 1 / zoom
camz = camz + vhat(3) * 1 / zoom
RETURN

strafe.camera.vhat.minus:
camx = camx - vhat(1) * 1 / zoom
camy = camy - vhat(2) * 1 / zoom
camz = camz - vhat(3) * 1 / zoom
RETURN

strafe.camera.nhat.plus:
camx = camx + nhat(1) * 1 / zoom
camy = camy + nhat(2) * 1 / zoom
camz = camz + nhat(3) * 1 / zoom
RETURN

strafe.camera.nhat.minus:
camx = camx - nhat(1) * 1 / zoom
camy = camy - nhat(2) * 1 / zoom
camz = camz - nhat(3) * 1 / zoom
RETURN

' *** Define core functions. ***

timeanimate:
timevar = timevar + 1
IF timevar > 10 ^ 6 THEN timevar = 1
SELECT CASE genscheme$
    CASE "3denvparticles": GOSUB genscheme.3denvparticles.timeanimate
    CASE "animatedflag": GOSUB genscheme.animatedsurface.timeanimate
    CASE "animatedpretzel": GOSUB genscheme.animatedpretzel.timeanimate
    CASE "laplace2d": GOSUB genscheme.laplace2d.timeanimate
    CASE "planet": GOSUB genscheme.planet.timeanimate
    CASE "wave2d": GOSUB genscheme.wave2d.timeanimate
    CASE "wave2dinf": GOSUB genscheme.wave2dinf.timeanimate
    CASE "bacteria": GOSUB genscheme.bacteria.timeanimate
    CASE "neuron": GOSUB genscheme.neuron.timeanimate
END SELECT
RETURN

normalize.screen.vectors:
'normalize the two vectors that define the screen orientation
uhatmag = SQR(uhat(1) ^ 2 + uhat(2) ^ 2 + uhat(3) ^ 2)
uhat(1) = uhat(1) / uhatmag: uhat(2) = uhat(2) / uhatmag: uhat(3) = uhat(3) / uhatmag
vhatmag = SQR(vhat(1) ^ 2 + vhat(2) ^ 2 + vhat(3) ^ 2)
vhat(1) = vhat(1) / vhatmag: vhat(2) = vhat(2) / vhatmag: vhat(3) = vhat(3) / vhatmag
uhatdotvhat = uhat(1) * vhat(1) + uhat(2) * vhat(2) + uhat(3) * vhat(3)
IF SQR(uhatdotvhat ^ 2) > .0005 THEN
    CLS: COLOR 15: LOCATE 5, 5: PRINT "Screen vectors are not perpendicular. Press ESC to quit."
    'DO: LOOP UNTIL INKEY$ = CHR$(27): END
END IF
' Compute the normal vector to the view plane.
' The normal vector points toward the eye, away from view frustum.
nhat(1) = uhat(2) * vhat(3) - uhat(3) * vhat(2)
nhat(2) = uhat(3) * vhat(1) - uhat(1) * vhat(3)
nhat(3) = uhat(1) * vhat(2) - uhat(2) * vhat(1)
nhatmag = SQR(nhat(1) ^ 2 + nhat(2) ^ 2 + nhat(3) ^ 2)
nhat(1) = nhat(1) / nhatmag: nhat(2) = nhat(2) / nhatmag: nhat(3) = nhat(3) / nhatmag
RETURN

redraw:
GOSUB normalize.screen.vectors
GOSUB compute.viewplanes
' Project the three-space basis vectors onto the screen plane.
xhatp(1) = xhat(1) * uhat(1) + xhat(2) * uhat(2) + xhat(3) * uhat(3)
xhatp(2) = xhat(1) * vhat(1) + xhat(2) * vhat(2) + xhat(3) * vhat(3)
yhatp(1) = yhat(1) * uhat(1) + yhat(2) * uhat(2) + yhat(3) * uhat(3)
yhatp(2) = yhat(1) * vhat(1) + yhat(2) * vhat(2) + yhat(3) * vhat(3)
zhatp(1) = zhat(1) * uhat(1) + zhat(2) * uhat(2) + zhat(3) * uhat(3)
zhatp(2) = zhat(1) * vhat(1) + zhat(2) * vhat(2) + zhat(3) * vhat(3)
IF numparticleorig > 0 THEN
    GOSUB compute.visible.particles
    GOSUB project.particles
    GOSUB depth.adjust.particles
END IF
IF numdoubletorig > 0 THEN
    GOSUB copy.doublets.orig.clip
    GOSUB clip.doublets.viewplanes
    GOSUB copy.doublets.clip.snip
    GOSUB project.doublets
    GOSUB depth.adjust.doublets
    GOSUB snip.doublets
    GOSUB copy.doublets.snipwork.snip
    GOSUB project.doublets
    GOSUB depth.adjust.doublets
END IF
IF numtripletorig > 0 THEN
    GOSUB reverse.uvnhat
    GOSUB triplet.filter.faceon
    GOSUB copy.triplets.faceon.clip
    GOSUB clip.triplets.viewplanes
    GOSUB copy.triplets.clip.snip
    GOSUB snip.triplets
    GOSUB copy.triplets.snip.final
    GOSUB project.triplets
    GOSUB depth.adjust.triplets
    GOSUB reverse.uvnhat
END IF
GOSUB draw.all.objects
GOSUB store.screen.projections
RETURN

reverse.uvnhat:
uhat(1) = -uhat(1)
uhat(2) = -uhat(2)
uhat(3) = -uhat(3)
GOSUB normalize.screen.vectors
RETURN

compute.visible.particles:
numparticlevisible = 0
FOR i = 1 TO numparticleorig
    IF falsedepth = 0 THEN
        GOSUB clip.particle.viewplanes
    ELSE
        SELECT CASE genscheme$
            CASE "molecule"
                numparticlevisible = numparticlevisible + 1
                vecvisible(numparticlevisible, 1) = vec(i, 1)
                vecvisible(numparticlevisible, 2) = vec(i, 2)
                vecvisible(numparticlevisible, 3) = vec(i, 3)
                vecvisible(numparticlevisible, 4) = vec(i, 4)
                vecvisible(numparticlevisible, 5) = vec(i, 5)
                vecvisible(numparticlevisible, 6) = vec(i, 6)
                vecvisible(numparticlevisible, 7) = vec(i, 7)
                vecvisible(numparticlevisible, 8) = vec(i, 8)
                vecvisible(numparticlevisible, 9) = vec(i, 9)
                vecvisible(numparticlevisible, 10) = vec(i, 10)
            CASE "bacteria"
                numparticlevisible = numparticlevisible + 1
                vecvisible(numparticlevisible, 1) = vec(i, 1)
                vecvisible(numparticlevisible, 2) = vec(i, 2)
                vecvisible(numparticlevisible, 3) = vec(i, 3)
                vecvisible(numparticlevisible, 4) = vec(i, 4)
                vecvisible(numparticlevisible, 5) = vec(i, 5)
                vecvisible(numparticlevisible, 6) = vec(i, 6)
                vecvisible(numparticlevisible, 7) = vec(i, 7)
                vecvisible(numparticlevisible, 8) = vec(i, 8)
                vecvisible(numparticlevisible, 9) = vec(i, 9)
                vecvisible(numparticlevisible, 10) = vec(i, 10)
            CASE "neuron"
                numparticlevisible = numparticlevisible + 1
                vecvisible(numparticlevisible, 1) = vec(i, 1)
                vecvisible(numparticlevisible, 2) = vec(i, 2)
                vecvisible(numparticlevisible, 3) = vec(i, 3)
                vecvisible(numparticlevisible, 4) = vec(i, 4)
                vecvisible(numparticlevisible, 5) = vec(i, 5)
                vecvisible(numparticlevisible, 6) = vec(i, 6)
                vecvisible(numparticlevisible, 7) = vec(i, 7)
                vecvisible(numparticlevisible, 8) = vec(i, 8)
                vecvisible(numparticlevisible, 9) = vec(i, 9)
                vecvisible(numparticlevisible, 10) = vec(i, 10)
                vecvisible(numparticlevisible, 11) = vec(i, 11)
                vecvisible(numparticlevisible, 12) = vec(i, 12)
                vecvisible(numparticlevisible, 13) = vec(i, 13)
                vecvisible(numparticlevisible, 14) = vec(i, 14)
                vecvisible(numparticlevisible, 15) = vec(i, 15)
            CASE ELSE
                numparticlevisible = numparticlevisible + 1
                vecvisible(numparticlevisible, 1) = vec(i, 1)
                vecvisible(numparticlevisible, 2) = vec(i, 2)
                vecvisible(numparticlevisible, 3) = vec(i, 3)
                vecvisible(numparticlevisible, 4) = vec(i, 4)
        END SELECT
    END IF
NEXT
RETURN

clip.particle.viewplanes:
particleinview = 1
fogswitch = -1
' Perform standard view plane clipping and determine depth 'fog effect'.
givenplanex = nearplane(1)
givenplaney = nearplane(2)
givenplanez = nearplane(3)
givenplaned = nearplane(4)
IF vec(i, 1) * givenplanex + vec(i, 2) * givenplaney + vec(i, 3) * givenplanez - givenplaned < 0 THEN particleinview = 0
givenplanex = farplane(1)
givenplaney = farplane(2)
givenplanez = farplane(3)
givenplaned = farplane(4)
IF vec(i, 1) * givenplanex + vec(i, 2) * givenplaney + vec(i, 3) * givenplanez - givenplaned < 0 THEN particleinview = 0
IF togglehud = -1 THEN IF vec(i, 1) * givenplanex + vec(i, 2) * givenplaney + vec(i, 3) * givenplanez - givenplaned * .9 < 0 THEN fogswitch = 1
givenplanex = rightplane(1)
givenplaney = rightplane(2)
givenplanez = rightplane(3)
givenplaned = rightplane(4)
IF vec(i, 1) * givenplanex + vec(i, 2) * givenplaney + vec(i, 3) * givenplanez - givenplaned < 0 THEN particleinview = 0
givenplanex = leftplane(1)
givenplaney = leftplane(2)
givenplanez = leftplane(3)
givenplaned = leftplane(4)
IF vec(i, 1) * givenplanex + vec(i, 2) * givenplaney + vec(i, 3) * givenplanez - givenplaned < 0 THEN particleinview = 0
givenplanex = topplane(1)
givenplaney = topplane(2)
givenplanez = topplane(3)
givenplaned = topplane(4)
IF vec(i, 1) * givenplanex + vec(i, 2) * givenplaney + vec(i, 3) * givenplanez - givenplaned < 0 THEN particleinview = 0
givenplanex = bottomplane(1)
givenplaney = bottomplane(2)
givenplanez = bottomplane(3)
givenplaned = bottomplane(4)
IF vec(i, 1) * givenplanex + vec(i, 2) * givenplaney + vec(i, 3) * givenplanez - givenplaned < 0 THEN particleinview = 0
IF particleinview = 1 AND togglehud = 1 THEN
    ' Apply spotlight effect.
    givenplanex = nearplanespotlight(1)
    givenplaney = nearplanespotlight(2)
    givenplanez = nearplanespotlight(3)
    givenplaned = nearplanespotlight(4)
    IF vec(i, 1) * givenplanex + vec(i, 2) * givenplaney + vec(i, 3) * givenplanez - givenplaned < 0 THEN fogswitch = 1
    givenplanex = farplanespotlight(1)
    givenplaney = farplanespotlight(2)
    givenplanez = farplanespotlight(3)
    givenplaned = farplanespotlight(4)
    IF vec(i, 1) * givenplanex + vec(i, 2) * givenplaney + vec(i, 3) * givenplanez - givenplaned < 0 THEN fogswitch = 1
    givenplanex = rightplanespotlight(1)
    givenplaney = rightplanespotlight(2)
    givenplanez = rightplanespotlight(3)
    givenplaned = rightplanespotlight(4)
    IF vec(i, 1) * givenplanex + vec(i, 2) * givenplaney + vec(i, 3) * givenplanez - givenplaned < 0 THEN fogswitch = 1
    givenplanex = leftplanespotlight(1)
    givenplaney = leftplanespotlight(2)
    givenplanez = leftplanespotlight(3)
    givenplaned = leftplanespotlight(4)
    IF vec(i, 1) * givenplanex + vec(i, 2) * givenplaney + vec(i, 3) * givenplanez - givenplaned < 0 THEN fogswitch = 1
    givenplanex = topplanespotlight(1)
    givenplaney = topplanespotlight(2)
    givenplanez = topplanespotlight(3)
    givenplaned = topplanespotlight(4)
    IF vec(i, 1) * givenplanex + vec(i, 2) * givenplaney + vec(i, 3) * givenplanez - givenplaned < 0 THEN fogswitch = 1
    givenplanex = bottomplanespotlight(1)
    givenplaney = bottomplanespotlight(2)
    givenplanez = bottomplanespotlight(3)
    givenplaned = bottomplanespotlight(4)
    IF vec(i, 1) * givenplanex + vec(i, 2) * givenplaney + vec(i, 3) * givenplanez - givenplaned < 0 THEN fogswitch = 1
END IF
IF particleinview = 1 THEN
    numparticlevisible = numparticlevisible + 1
    vecvisible(numparticlevisible, 1) = vec(i, 1)
    vecvisible(numparticlevisible, 2) = vec(i, 2)
    vecvisible(numparticlevisible, 3) = vec(i, 3)
    vecvisible(numparticlevisible, 4) = vec(i, 4)
    IF fogswitch = 1 THEN vecvisible(numparticlevisible, 4) = 8
END IF
RETURN

project.particles:
' Project object vectors onto the screen plane.
FOR i = 1 TO numparticlevisible
    vecvisibledotnhat(i) = vecvisible(i, 1) * nhat(1) + vecvisible(i, 2) * nhat(2) + vecvisible(i, 3) * nhat(3)
    vecvisiblepuv(i, 1) = (vecvisible(i, 1) * uhat(1) + vecvisible(i, 2) * uhat(2) + vecvisible(i, 3) * uhat(3))
    vecvisiblepuv(i, 2) = (vecvisible(i, 1) * vhat(1) + vecvisible(i, 2) * vhat(2) + vecvisible(i, 3) * vhat(3))
NEXT
RETURN

depth.adjust.particles:
IF falsedepth = 0 THEN
    FOR i = 1 TO numparticlevisible
        vecvisiblepuvs(i, 1) = vecvisiblepuv(i, 1) * fovd / vecvisibledotnhat(i)
        vecvisiblepuvs(i, 2) = vecvisiblepuv(i, 2) * fovd / vecvisibledotnhat(i)
    NEXT
ELSE
    FOR i = 1 TO numparticlevisible
        vecvisiblepuvs(i, 1) = vecvisiblepuv(i, 1) * (1 + falsedepth * vecvisibledotnhat(i))
        vecvisiblepuvs(i, 2) = vecvisiblepuv(i, 2) * (1 + falsedepth * vecvisibledotnhat(i))
    NEXT
END IF
RETURN

draw.all.objects:
SELECT CASE plotmode$
    CASE "molecule": GOSUB plotmode.molecule
    CASE "simplepoints": GOSUB plotmode.simplepoints
    CASE "neighbortile": GOSUB plotmode.neighbortile
    CASE "linearconnect": GOSUB plotmode.linearconnect
    CASE "3denvparticles": GOSUB plotmode.3denvparticles
    CASE "3denvdoublets"
        IF numparticleorig > 0 THEN GOSUB plotmode.simplepoints
        IF numdoubletorig > 0 THEN GOSUB plotmode.3denvdoublets
    CASE "3denvtriplets": GOSUB plotmode.3denvtriplets
    CASE "simplemesh": GOSUB plotmode.simplemesh
    CASE "meshtech2": GOSUB plotmode.meshtech2
    CASE "meshtech2planet": GOSUB plotmode.meshtech2planet
    CASE "simplepointsbacteria": GOSUB plotmode.simplepointsbacteria
    CASE "linearneuron": GOSUB plotmode.linearneuron
END SELECT
COLOR 7
LOCATE 28, 23: PRINT "SPACE = toggle HUD,  ESC = quit."
IF togglehud = 1 THEN
    ' Replace basis vector triad.
    x = 50 * xhatp.old(1): y = 50 * xhatp.old(2): GOSUB convert
    LINE (centerx, centery)-(x, y), 0
    x = 50 * yhatp.old(1): y = 50 * yhatp.old(2): GOSUB convert
    LINE (centerx, centery)-(x, y), 0
    x = 50 * zhatp.old(1): y = 50 * zhatp.old(2): GOSUB convert
    LINE (centerx, centery)-(x, y), 0
    x = 50 * xhatp(1): y = 50 * xhatp(2): GOSUB convert
    LINE (centerx, centery)-(x, y), xhat(4)
    x = 50 * yhatp(1): y = 50 * yhatp(2): GOSUB convert
    LINE (centerx, centery)-(x, y), yhat(4)
    x = 50 * zhatp(1): y = 50 * zhatp(2): GOSUB convert
    LINE (centerx, centery)-(x, y), zhat(4)
    COLOR 14
    LOCATE 26, 2: PRINT "- MOVE -"
    COLOR 15
    LOCATE 27, 2: PRINT " q W e"
    LOCATE 28, 2: PRINT " A S D"
    COLOR 14
    LOCATE 25, 68: PRINT "-   VIEW   -"
    COLOR 15
    LOCATE 26, 68: PRINT "  8  "
    LOCATE 27, 68: PRINT "4   6"
    LOCATE 28, 68: PRINT "  2  "
    COLOR 7
    LOCATE 26, 75: PRINT "7   9"
    LOCATE 27, 75: PRINT "     "
    LOCATE 28, 75: PRINT "1   3"
    IF numparticleorig > 0 AND falsedepth = 0 THEN
        COLOR 7
        LOCATE 3, 2: PRINT "- Particle Info -"
        LOCATE 4, 2: PRINT "   Total:"; numparticleorig
        LOCATE 5, 2: PRINT " Visible:"; numparticlevisible
        LOCATE 6, 2: PRINT " Percent:"; INT(100 * numparticlevisible / numparticleorig)
        LOCATE 8, 2: PRINT " Press '/' to"
        LOCATE 9, 2: PRINT " export view."
        LOCATE 3, 65: PRINT "- View Planes -"
        LOCATE 4, 65: PRINT " Far dist:"; -farplane(4)
        LOCATE 5, 65: PRINT " Near dist:"; nearplane(4)
        LOCATE 6, 65: PRINT " [,] shift Far"
        LOCATE 7, 65: PRINT " <,> shift Near"
        LOCATE 9, 65: PRINT "- Spotlight -"
        LOCATE 10, 64: PRINT "  Center:"; spotlightcenter
        LOCATE 11, 64: PRINT "  Thick:"; spotlightthickness
        LOCATE 12, 64: PRINT "  Control keys:"
        LOCATE 13, 64: PRINT "    ; ' - ="
    END IF
END IF
IF toggletimealert = 1 THEN
    COLOR 7
    LOCATE 1, 25: PRINT "Press 'T' to toggle animation."
END IF
RETURN

store.screen.projections:
xhatp.old(1) = xhatp(1): xhatp.old(2) = xhatp(2)
yhatp.old(1) = yhatp(1): yhatp.old(2) = yhatp(2)
zhatp.old(1) = zhatp(1): zhatp.old(2) = zhatp(2)
FOR i = 1 TO numparticlevisible
    vecvisiblepuvs.old(i, 1) = vecvisiblepuvs(i, 1)
    vecvisiblepuvs.old(i, 2) = vecvisiblepuvs(i, 2)
NEXT
numparticlevisible.old = numparticlevisible
FOR i = 1 TO numdoubletsnip
    doubletsnippuvs.old(i, 1) = doubletsnippuvs(i, 1)
    doubletsnippuvs.old(i, 2) = doubletsnippuvs(i, 2)
    doubletsnippuvs.old(i, 3) = doubletsnippuvs(i, 3)
    doubletsnippuvs.old(i, 4) = doubletsnippuvs(i, 4)
NEXT
numdoubletsnip.old = numdoubletsnip
FOR i = 1 TO numtripletfinal
    tripletfinalpuvs.old(i, 1) = tripletfinalpuvs(i, 1)
    tripletfinalpuvs.old(i, 2) = tripletfinalpuvs(i, 2)
    tripletfinalpuvs.old(i, 3) = tripletfinalpuvs(i, 3)
    tripletfinalpuvs.old(i, 4) = tripletfinalpuvs(i, 4)
    tripletfinalpuvs.old(i, 5) = tripletfinalpuvs(i, 5)
    tripletfinalpuvs.old(i, 6) = tripletfinalpuvs(i, 6)
NEXT
numtripletfinal.old = numtripletfinal
RETURN

compute.viewplanes:
' Define normal vectors to all view planes.
nearplane(1) = -nhat(1)
nearplane(2) = -nhat(2)
nearplane(3) = -nhat(3)
farplane(1) = nhat(1)
farplane(2) = nhat(2)
farplane(3) = nhat(3)
rightplane(1) = (screenheight / 4) * fovd * uhat(1) - (screenheight / 4) * (screenwidth / 4) * nhat(1)
rightplane(2) = (screenheight / 4) * fovd * uhat(2) - (screenheight / 4) * (screenwidth / 4) * nhat(2)
rightplane(3) = (screenheight / 4) * fovd * uhat(3) - (screenheight / 4) * (screenwidth / 4) * nhat(3)
mag = SQR((rightplane(1)) ^ 2 + (rightplane(2)) ^ 2 + (rightplane(3)) ^ 2)
rightplane(1) = rightplane(1) / mag
rightplane(2) = rightplane(2) / mag
rightplane(3) = rightplane(3) / mag
leftplane(1) = -(screenheight / 4) * fovd * uhat(1) - (screenheight / 4) * (screenwidth / 4) * nhat(1)
leftplane(2) = -(screenheight / 4) * fovd * uhat(2) - (screenheight / 4) * (screenwidth / 4) * nhat(2)
leftplane(3) = -(screenheight / 4) * fovd * uhat(3) - (screenheight / 4) * (screenwidth / 4) * nhat(3)
mag = SQR((leftplane(1)) ^ 2 + (leftplane(2)) ^ 2 + (leftplane(3)) ^ 2)
leftplane(1) = leftplane(1) / mag
leftplane(2) = leftplane(2) / mag
leftplane(3) = leftplane(3) / mag
topplane(1) = (screenwidth / 4) * fovd * vhat(1) - (screenheight / 4) * (screenwidth / 4) * nhat(1)
topplane(2) = (screenwidth / 4) * fovd * vhat(2) - (screenheight / 4) * (screenwidth / 4) * nhat(2)
topplane(3) = (screenwidth / 4) * fovd * vhat(3) - (screenheight / 4) * (screenwidth / 4) * nhat(3)
mag = SQR((topplane(1)) ^ 2 + (topplane(2)) ^ 2 + (topplane(3)) ^ 2)
topplane(1) = topplane(1) / mag
topplane(2) = topplane(2) / mag
topplane(3) = topplane(3) / mag
bottomplane(1) = -(screenwidth / 4) * fovd * vhat(1) - (screenheight / 4) * (screenwidth / 4) * nhat(1)
bottomplane(2) = -(screenwidth / 4) * fovd * vhat(2) - (screenheight / 4) * (screenwidth / 4) * nhat(2)
bottomplane(3) = -(screenwidth / 4) * fovd * vhat(3) - (screenheight / 4) * (screenwidth / 4) * nhat(3)
mag = SQR((bottomplane(1)) ^ 2 + (bottomplane(2)) ^ 2 + (bottomplane(3)) ^ 2)
bottomplane(1) = bottomplane(1) / mag
bottomplane(2) = bottomplane(2) / mag
bottomplane(3) = bottomplane(3) / mag
IF togglehud = 1 THEN
    nearplanespotlight(4) = spotlightcenter - spotlightthickness / 2
    farplanespotlight(4) = -(spotlightcenter + spotlightthickness / 2)
    nearplanespotlight(1) = -nhat(1)
    nearplanespotlight(2) = -nhat(2)
    nearplanespotlight(3) = -nhat(3)
    farplanespotlight(1) = nhat(1)
    farplanespotlight(2) = nhat(2)
    farplanespotlight(3) = nhat(3)
    rightplanespotlight(1) = (screenheight / (4 * spotlightwidth)) * fovd * uhat(1) - (screenheight / (4 * spotlightwidth)) * (screenwidth / (4 * spotlightwidth)) * nhat(1)
    rightplanespotlight(2) = (screenheight / (4 * spotlightwidth)) * fovd * uhat(2) - (screenheight / (4 * spotlightwidth)) * (screenwidth / (4 * spotlightwidth)) * nhat(2)
    rightplanespotlight(3) = (screenheight / (4 * spotlightwidth)) * fovd * uhat(3) - (screenheight / (4 * spotlightwidth)) * (screenwidth / (4 * spotlightwidth)) * nhat(3)
    mag = SQR((rightplanespotlight(1)) ^ 2 + (rightplanespotlight(2)) ^ 2 + (rightplanespotlight(3)) ^ 2)
    rightplanespotlight(1) = rightplanespotlight(1) / mag
    rightplanespotlight(2) = rightplanespotlight(2) / mag
    rightplanespotlight(3) = rightplanespotlight(3) / mag
    leftplanespotlight(1) = -(screenheight / (4 * spotlightwidth)) * fovd * uhat(1) - (screenheight / (4 * spotlightwidth)) * (screenwidth / (4 * spotlightwidth)) * nhat(1)
    leftplanespotlight(2) = -(screenheight / (4 * spotlightwidth)) * fovd * uhat(2) - (screenheight / (4 * spotlightwidth)) * (screenwidth / (4 * spotlightwidth)) * nhat(2)
    leftplanespotlight(3) = -(screenheight / (4 * spotlightwidth)) * fovd * uhat(3) - (screenheight / (4 * spotlightwidth)) * (screenwidth / (4 * spotlightwidth)) * nhat(3)
    mag = SQR((leftplanespotlight(1)) ^ 2 + (leftplanespotlight(2)) ^ 2 + (leftplanespotlight(3)) ^ 2)
    leftplanespotlight(1) = leftplanespotlight(1) / mag
    leftplanespotlight(2) = leftplanespotlight(2) / mag
    leftplanespotlight(3) = leftplanespotlight(3) / mag
    topplanespotlight(1) = (screenwidth / (4 * spotlightwidth)) * fovd * vhat(1) - (screenheight / (4 * spotlightwidth)) * (screenwidth / (4 * spotlightwidth)) * nhat(1)
    topplanespotlight(2) = (screenwidth / (4 * spotlightwidth)) * fovd * vhat(2) - (screenheight / (4 * spotlightwidth)) * (screenwidth / (4 * spotlightwidth)) * nhat(2)
    topplanespotlight(3) = (screenwidth / (4 * spotlightwidth)) * fovd * vhat(3) - (screenheight / (4 * spotlightwidth)) * (screenwidth / (4 * spotlightwidth)) * nhat(3)
    mag = SQR((topplanespotlight(1)) ^ 2 + (topplanespotlight(2)) ^ 2 + (topplanespotlight(3)) ^ 2)
    topplanespotlight(1) = topplanespotlight(1) / mag
    topplanespotlight(2) = topplanespotlight(2) / mag
    topplanespotlight(3) = topplanespotlight(3) / mag
    bottomplanespotlight(1) = -(screenwidth / (4 * spotlightwidth)) * fovd * vhat(1) - (screenheight / (4 * spotlightwidth)) * (screenwidth / (4 * spotlightwidth)) * nhat(1)
    bottomplanespotlight(2) = -(screenwidth / (4 * spotlightwidth)) * fovd * vhat(2) - (screenheight / (4 * spotlightwidth)) * (screenwidth / (4 * spotlightwidth)) * nhat(2)
    bottomplanespotlight(3) = -(screenwidth / (4 * spotlightwidth)) * fovd * vhat(3) - (screenheight / (4 * spotlightwidth)) * (screenwidth / (4 * spotlightwidth)) * nhat(3)
    mag = SQR((bottomplanespotlight(1)) ^ 2 + (bottomplanespotlight(2)) ^ 2 + (bottomplanespotlight(3)) ^ 2)
    bottomplanespotlight(1) = bottomplanespotlight(1) / mag
    bottomplanespotlight(2) = bottomplanespotlight(2) / mag
    bottomplanespotlight(3) = bottomplanespotlight(3) / mag
END IF
RETURN

' *** Define functions for doublet manipulations. ***

project.doublets:
FOR i = 1 TO numdoubletclip
    doubletclipdotnhat(i, 1) = doubletclip(i, 1) * nhat(1) + doubletclip(i, 2) * nhat(2) + doubletclip(i, 3) * nhat(3)
    doubletclipdotnhat(i, 2) = doubletclip(i, 4) * nhat(1) + doubletclip(i, 5) * nhat(2) + doubletclip(i, 6) * nhat(3)
    doubletclippuv(i, 1) = doubletclip(i, 1) * uhat(1) + doubletclip(i, 2) * uhat(2) + doubletclip(i, 3) * uhat(3)
    doubletclippuv(i, 2) = doubletclip(i, 1) * vhat(1) + doubletclip(i, 2) * vhat(2) + doubletclip(i, 3) * vhat(3)
    doubletclippuv(i, 3) = doubletclip(i, 4) * uhat(1) + doubletclip(i, 5) * uhat(2) + doubletclip(i, 6) * uhat(3)
    doubletclippuv(i, 4) = doubletclip(i, 4) * vhat(1) + doubletclip(i, 5) * vhat(2) + doubletclip(i, 6) * vhat(3)
NEXT
FOR i = 1 TO numdoubletsnip
    doubletsnipdotnhat(i, 1) = doubletsnip(i, 1) * nhat(1) + doubletsnip(i, 2) * nhat(2) + doubletsnip(i, 3) * nhat(3)
    doubletsnipdotnhat(i, 2) = doubletsnip(i, 4) * nhat(1) + doubletsnip(i, 5) * nhat(2) + doubletsnip(i, 6) * nhat(3)
    doubletsnippuv(i, 1) = doubletsnip(i, 1) * uhat(1) + doubletsnip(i, 2) * uhat(2) + doubletsnip(i, 3) * uhat(3)
    doubletsnippuv(i, 2) = doubletsnip(i, 1) * vhat(1) + doubletsnip(i, 2) * vhat(2) + doubletsnip(i, 3) * vhat(3)
    doubletsnippuv(i, 3) = doubletsnip(i, 4) * uhat(1) + doubletsnip(i, 5) * uhat(2) + doubletsnip(i, 6) * uhat(3)
    doubletsnippuv(i, 4) = doubletsnip(i, 4) * vhat(1) + doubletsnip(i, 5) * vhat(2) + doubletsnip(i, 6) * vhat(3)
NEXT
RETURN

depth.adjust.doublets:
FOR i = 1 TO numdoubletclip
    doubletclippuvs(i, 1) = doubletclippuv(i, 1) * fovd / doubletclipdotnhat(i, 1)
    doubletclippuvs(i, 2) = doubletclippuv(i, 2) * fovd / doubletclipdotnhat(i, 1)
    doubletclippuvs(i, 3) = doubletclippuv(i, 3) * fovd / doubletclipdotnhat(i, 2)
    doubletclippuvs(i, 4) = doubletclippuv(i, 4) * fovd / doubletclipdotnhat(i, 2)
NEXT
FOR i = 1 TO numdoubletsnip
    doubletsnippuvs(i, 1) = doubletsnippuv(i, 1) * fovd / doubletsnipdotnhat(i, 1)
    doubletsnippuvs(i, 2) = doubletsnippuv(i, 2) * fovd / doubletsnipdotnhat(i, 1)
    doubletsnippuvs(i, 3) = doubletsnippuv(i, 3) * fovd / doubletsnipdotnhat(i, 2)
    doubletsnippuvs(i, 4) = doubletsnippuv(i, 4) * fovd / doubletsnipdotnhat(i, 2)
NEXT
RETURN

' *** Define functions for doublet viewplane clipping. ***

copy.doublets.orig.clip:
FOR i = 1 TO numdoubletorig
    doubletclip(i, 1) = doubletorig(i, 1)
    doubletclip(i, 2) = doubletorig(i, 2)
    doubletclip(i, 3) = doubletorig(i, 3)
    doubletclip(i, 4) = doubletorig(i, 4)
    doubletclip(i, 5) = doubletorig(i, 5)
    doubletclip(i, 6) = doubletorig(i, 6)
    doubletclip(i, 7) = doubletorig(i, 7)
NEXT
numdoubletclip = numdoubletorig
RETURN

copy.doublets.clipwork.clip:
FOR i = 1 TO pcountdoubletclipwork
    doubletclip(i, 1) = doubletclipwork(i, 1)
    doubletclip(i, 2) = doubletclipwork(i, 2)
    doubletclip(i, 3) = doubletclipwork(i, 3)
    doubletclip(i, 4) = doubletclipwork(i, 4)
    doubletclip(i, 5) = doubletclipwork(i, 5)
    doubletclip(i, 6) = doubletclipwork(i, 6)
    doubletclip(i, 7) = doubletclipwork(i, 7)
NEXT
numdoubletclip = pcountdoubletclipwork
RETURN

'clip.doublets.nearplane:
'pcountdoubletclipwork = 0
'FOR i = 1 TO numdoubletclip
'    doubletclip1dotnearplane = doubletclip(i, 1) * nearplane(1) + doubletclip(i, 2) * nearplane(2) + doubletclip(i, 3) * nearplane(3)
'    doubletclip2dotnearplane = doubletclip(i, 4) * nearplane(1) + doubletclip(i, 5) * nearplane(2) + doubletclip(i, 6) * nearplane(3)
'    gamma = doubletclip2dotnearplane / doubletclip1dotnearplane
'    Ax = (doubletclip(i, 1) - doubletclip(i, 4)) / (1 - gamma)
'    Ay = (doubletclip(i, 2) - doubletclip(i, 5)) / (1 - gamma)
'    Az = (doubletclip(i, 3) - doubletclip(i, 6)) / (1 - gamma)
'    Bx = gamma * Ax
'    By = gamma * Ay
'    Bz = gamma * Az
'    Adotnearplane = Ax * nearplane(1) + Ay * nearplane(2) + Az * nearplane(3)
'    Bdotnearplane = Bx * nearplane(1) + By * nearplane(2) + Bz * nearplane(3)
'    IF Adotnearplane > nearplane(4) AND Bdotnearplane > nearplane(4) THEN
'        pcountdoubletclipwork = pcountdoubletclipwork + 1
'        doubletclipwork(pcountdoubletclipwork, 1) = doubletclip(i, 1)
'        doubletclipwork(pcountdoubletclipwork, 2) = doubletclip(i, 2)
'        doubletclipwork(pcountdoubletclipwork, 3) = doubletclip(i, 3)
'        doubletclipwork(pcountdoubletclipwork, 4) = doubletclip(i, 4)
'        doubletclipwork(pcountdoubletclipwork, 5) = doubletclip(i, 5)
'        doubletclipwork(pcountdoubletclipwork, 6) = doubletclip(i, 6)
'        doubletclipwork(pcountdoubletclipwork, 7) = doubletclip(i, 7)
'    END IF
'    IF Adotnearplane < nearplane(4) AND Bdotnearplane < nearplane(4) THEN
'    END IF
'    IF Adotnearplane > nearplane(4) AND Bdotnearplane < nearplane(4) THEN
'        pcountdoubletclipwork = pcountdoubletclipwork + 1
'        doubletclipwork(pcountdoubletclipwork, 1) = doubletclip(i, 1)
'        doubletclipwork(pcountdoubletclipwork, 2) = doubletclip(i, 2)
'        doubletclipwork(pcountdoubletclipwork, 3) = doubletclip(i, 3)
'        doubletclipwork(pcountdoubletclipwork, 4) = doubletclip(i, 4) - Bx + nearplane(4) * nearplane(1)
'        doubletclipwork(pcountdoubletclipwork, 5) = doubletclip(i, 5) - By + nearplane(4) * nearplane(2)
'        doubletclipwork(pcountdoubletclipwork, 6) = doubletclip(i, 6) - Bz + nearplane(4) * nearplane(3)
'        doubletclipwork(pcountdoubletclipwork, 7) = doubletclip(i, 7)
'    END IF
'    IF Adotnearplane < nearplane(4) AND Bdotnearplane > nearplane(4) THEN
'        pcountdoubletclipwork = pcountdoubletclipwork + 1
'        doubletclipwork(pcountdoubletclipwork, 1) = doubletclip(i, 1) - Ax + nearplane(4) * nearplane(1)
'        doubletclipwork(pcountdoubletclipwork, 2) = doubletclip(i, 2) - Ay + nearplane(4) * nearplane(2)
'        doubletclipwork(pcountdoubletclipwork, 3) = doubletclip(i, 3) - Az + nearplane(4) * nearplane(3)
'        doubletclipwork(pcountdoubletclipwork, 4) = doubletclip(i, 4)
'        doubletclipwork(pcountdoubletclipwork, 5) = doubletclip(i, 5)
'        doubletclipwork(pcountdoubletclipwork, 6) = doubletclip(i, 6)
'        doubletclipwork(pcountdoubletclipwork, 7) = doubletclip(i, 7)
'    END IF
'NEXT
'RETURN

clip.doublets.viewplanes:
givenplanex = nearplane(1)
givenplaney = nearplane(2)
givenplanez = nearplane(3)
givenplaned = nearplane(4)
GOSUB clip.doublets.givenplane
GOSUB copy.doublets.clipwork.clip
givenplanex = rightplane(1)
givenplaney = rightplane(2)
givenplanez = rightplane(3)
givenplaned = rightplane(4)
GOSUB clip.doublets.givenplane
GOSUB copy.doublets.clipwork.clip
givenplanex = leftplane(1)
givenplaney = leftplane(2)
givenplanez = leftplane(3)
givenplaned = leftplane(4)
GOSUB clip.doublets.givenplane
GOSUB copy.doublets.clipwork.clip
givenplanex = topplane(1)
givenplaney = topplane(2)
givenplanez = topplane(3)
givenplaned = topplane(4)
GOSUB clip.doublets.givenplane
GOSUB copy.doublets.clipwork.clip
givenplanex = bottomplane(1)
givenplaney = bottomplane(2)
givenplanez = bottomplane(3)
givenplaned = bottomplane(4)
GOSUB clip.doublets.givenplane
GOSUB copy.doublets.clipwork.clip
RETURN

clip.doublets.givenplane:
pcountdoubletclipwork = 0
FOR i = 1 TO numdoubletclip
    doubletclip1dotgivenplane = doubletclip(i, 1) * givenplanex + doubletclip(i, 2) * givenplaney + doubletclip(i, 3) * givenplanez
    doubletclip2dotgivenplane = doubletclip(i, 4) * givenplanex + doubletclip(i, 5) * givenplaney + doubletclip(i, 6) * givenplanez
    gamma = doubletclip2dotgivenplane / doubletclip1dotgivenplane
    Ax = (doubletclip(i, 1) - doubletclip(i, 4)) / (1 - gamma)
    Ay = (doubletclip(i, 2) - doubletclip(i, 5)) / (1 - gamma)
    Az = (doubletclip(i, 3) - doubletclip(i, 6)) / (1 - gamma)
    Bx = gamma * Ax
    By = gamma * Ay
    Bz = gamma * Az
    Adotgivenplane = Ax * givenplanex + Ay * givenplaney + Az * givenplanez - givenplaned
    Bdotgivenplane = Bx * givenplanex + By * givenplaney + Bz * givenplanez - givenplaned
    IF Adotgivenplane > 0 AND Bdotgivenplane > 0 THEN
        pcountdoubletclipwork = pcountdoubletclipwork + 1
        doubletclipwork(pcountdoubletclipwork, 1) = doubletclip(i, 1)
        doubletclipwork(pcountdoubletclipwork, 2) = doubletclip(i, 2)
        doubletclipwork(pcountdoubletclipwork, 3) = doubletclip(i, 3)
        doubletclipwork(pcountdoubletclipwork, 4) = doubletclip(i, 4)
        doubletclipwork(pcountdoubletclipwork, 5) = doubletclip(i, 5)
        doubletclipwork(pcountdoubletclipwork, 6) = doubletclip(i, 6)
        doubletclipwork(pcountdoubletclipwork, 7) = doubletclip(i, 7)
    END IF
    IF Adotgivenplane > 0 AND Bdotgivenplane < 0 THEN
        pcountdoubletclipwork = pcountdoubletclipwork + 1
        doubletclipwork(pcountdoubletclipwork, 1) = doubletclip(i, 1)
        doubletclipwork(pcountdoubletclipwork, 2) = doubletclip(i, 2)
        doubletclipwork(pcountdoubletclipwork, 3) = doubletclip(i, 3)
        doubletclipwork(pcountdoubletclipwork, 4) = doubletclip(i, 4) - Bx + givenplaned * givenplanex
        doubletclipwork(pcountdoubletclipwork, 5) = doubletclip(i, 5) - By + givenplaned * givenplaney
        doubletclipwork(pcountdoubletclipwork, 6) = doubletclip(i, 6) - Bz + givenplaned * givenplanez
        doubletclipwork(pcountdoubletclipwork, 7) = doubletclip(i, 7)
    END IF
    IF Adotgivenplane < 0 AND Bdotgivenplane > 0 THEN
        pcountdoubletclipwork = pcountdoubletclipwork + 1
        doubletclipwork(pcountdoubletclipwork, 1) = doubletclip(i, 1) - Ax + givenplaned * givenplanex
        doubletclipwork(pcountdoubletclipwork, 2) = doubletclip(i, 2) - Ay + givenplaned * givenplaney
        doubletclipwork(pcountdoubletclipwork, 3) = doubletclip(i, 3) - Az + givenplaned * givenplanez
        doubletclipwork(pcountdoubletclipwork, 4) = doubletclip(i, 4)
        doubletclipwork(pcountdoubletclipwork, 5) = doubletclip(i, 5)
        doubletclipwork(pcountdoubletclipwork, 6) = doubletclip(i, 6)
        doubletclipwork(pcountdoubletclipwork, 7) = doubletclip(i, 7)
    END IF
NEXT
RETURN

' *** Define functions for doublet snipping. ***

copy.doublets.clip.snip:
FOR i = 1 TO numdoubletclip
    doubletsnip(i, 1) = doubletclip(i, 1)
    doubletsnip(i, 2) = doubletclip(i, 2)
    doubletsnip(i, 3) = doubletclip(i, 3)
    doubletsnip(i, 4) = doubletclip(i, 4)
    doubletsnip(i, 5) = doubletclip(i, 5)
    doubletsnip(i, 6) = doubletclip(i, 6)
    doubletsnip(i, 7) = doubletclip(i, 7)
NEXT
numdoubletsnip = numdoubletclip
RETURN

copy.doublets.snipwork.snip:
FOR i = 1 TO snipworkpcount
    doubletsnip(i, 1) = doubletsnipwork(i, 1)
    doubletsnip(i, 2) = doubletsnipwork(i, 2)
    doubletsnip(i, 3) = doubletsnipwork(i, 3)
    doubletsnip(i, 4) = doubletsnipwork(i, 4)
    doubletsnip(i, 5) = doubletsnipwork(i, 5)
    doubletsnip(i, 6) = doubletsnipwork(i, 6)
    doubletsnip(i, 7) = doubletsnipwork(i, 7)
NEXT
numdoubletsnip = snipworkpcount
RETURN

snip.doublets:
snipworkpcount = 0
FOR i = 1 TO numdoubletsnip
    Ax = doubletsnip(i, 1)
    Ay = doubletsnip(i, 2)
    Az = doubletsnip(i, 3)
    Bx = doubletsnip(i, 4)
    By = doubletsnip(i, 5)
    Bz = doubletsnip(i, 6)
    Au = doubletsnippuv(i, 1)
    Av = doubletsnippuv(i, 2)
    Bu = doubletsnippuv(i, 3)
    Bv = doubletsnippuv(i, 4)
    An = doubletsnipdotnhat(i, 1)
    Bn = doubletsnipdotnhat(i, 2)
    Asu = doubletsnippuvs(i, 1)
    Asv = doubletsnippuvs(i, 2)
    Bsu = doubletsnippuvs(i, 3)
    Bsv = doubletsnippuvs(i, 4)
    numintersections = 0
    FOR j = 1 TO numdoubletsnip
        IF i <> j THEN
            Cx = doubletsnip(j, 1)
            Cy = doubletsnip(j, 2)
            Cz = doubletsnip(j, 3)
            Dx = doubletsnip(j, 4)
            Dy = doubletsnip(j, 5)
            Dz = doubletsnip(j, 6)
            Cu = doubletsnippuv(j, 1)
            Cv = doubletsnippuv(j, 2)
            Du = doubletsnippuv(j, 3)
            Dv = doubletsnippuv(j, 4)
            Cn = doubletsnipdotnhat(j, 1)
            Dn = doubletsnipdotnhat(j, 2)
            Csu = doubletsnippuvs(j, 1)
            Csv = doubletsnippuvs(j, 2)
            Dsu = doubletsnippuvs(j, 3)
            Dsv = doubletsnippuvs(j, 4)
            magdoubletABps = SQR((Bsu - Asu) ^ 2 + (Bsv - Asv) ^ 2)
            magdoubletCDps = SQR((Dsu - Csu) ^ 2 + (Dsv - Csv) ^ 2)
            slopeAB = (Bsv - Asv) / (Bsu - Asu)
            intAB = Asv - slopeAB * Asu
            slopeCD = (Dsv - Csv) / (Dsu - Csu)
            intCD = Csv - slopeCD * Csu
            xstar = -(intAB - intCD) / (slopeAB - slopeCD)
            ystar = slopeAB * xstar + intAB
            alphaAB1u = -xstar + Asu
            alphaAB1v = -ystar + Asv
            alphaAB2u = -xstar + Bsu
            alphaAB2v = -ystar + Bsv
            alphaCD1u = -xstar + Csu
            alphaCD1v = -ystar + Csv
            alphaCD2u = -xstar + Dsu
            alphaCD2v = -ystar + Dsv
            magalphaAB1 = SQR(alphaAB1u ^ 2 + alphaAB1v ^ 2)
            magalphaAB2 = SQR(alphaAB2u ^ 2 + alphaAB2v ^ 2)
            magalphaCD1 = SQR(alphaCD1u ^ 2 + alphaCD1v ^ 2)
            magalphaCD2 = SQR(alphaCD2u ^ 2 + alphaCD2v ^ 2)
            IF magalphaAB1 < magdoubletABps AND magalphaAB2 < magdoubletABps AND magalphaCD1 < magdoubletCDps AND magalphaCD2 < magdoubletCDps THEN
                qAB1u = (Asu - alphaAB1u) / fovd
                '*'qAB1v = (Asv - alphaAB1v) / fovd ' (Nonessential but interesting.)
                numerator = qAB1u * An - Au
                denominator = Bu - Au + qAB1u * (An - Bn)
                betaAB1 = numerator / denominator
                '*'betaAB2 = 1 - betaAB1 ' (Nonessential but interesting.)
                '*'qCD1u = (Csu - alphaCD1u) / fovd ' (Nonessential but interesting.)
                '*'numerator = qCD1u * Cn - Cu ' (Nonessential but interesting.)
                '*'denominator = Du - Cu + qCD1u * (Cn - Dn) ' (Nonessential but interesting.)
                '*'betaCD1 = numerator / denominator ' (Nonessential but interesting.)
                '*'betaCD2 = 1 - betaCD1 ' (Nonessential but interesting.)
                numintersections = numintersections + 1
                doubletintinfo(numintersections, 1) = j
                doubletintinfo(numintersections, 2) = betaAB1
            END IF
        END IF
    NEXT
    IF numintersections = 0 THEN
        snipworkpcount = snipworkpcount + 1
        doubletsnipwork(snipworkpcount, 1) = Ax
        doubletsnipwork(snipworkpcount, 2) = Ay
        doubletsnipwork(snipworkpcount, 3) = Az
        doubletsnipwork(snipworkpcount, 4) = Bx
        doubletsnipwork(snipworkpcount, 5) = By
        doubletsnipwork(snipworkpcount, 6) = Bz
        doubletsnipwork(snipworkpcount, 7) = doubletsnip(i, 7)
    ELSE
        IF numintersections = 1 THEN
            snipworkpcount = snipworkpcount + 1
            doubletsnipwork(snipworkpcount, 1) = Ax
            doubletsnipwork(snipworkpcount, 2) = Ay
            doubletsnipwork(snipworkpcount, 3) = Az
            doubletsnipwork(snipworkpcount, 4) = Ax * (1 - doubletintinfo(1, 2)) + doubletintinfo(1, 2) * Bx
            doubletsnipwork(snipworkpcount, 5) = Ay * (1 - doubletintinfo(1, 2)) + doubletintinfo(1, 2) * By
            doubletsnipwork(snipworkpcount, 6) = Az * (1 - doubletintinfo(1, 2)) + doubletintinfo(1, 2) * Bz
            doubletsnipwork(snipworkpcount, 7) = doubletsnip(i, 7)
            snipworkpcount = snipworkpcount + 1
            doubletsnipwork(snipworkpcount, 1) = Ax * (1 - doubletintinfo(1, 2)) + doubletintinfo(1, 2) * Bx
            doubletsnipwork(snipworkpcount, 2) = Ay * (1 - doubletintinfo(1, 2)) + doubletintinfo(1, 2) * By
            doubletsnipwork(snipworkpcount, 3) = Az * (1 - doubletintinfo(1, 2)) + doubletintinfo(1, 2) * Bz
            doubletsnipwork(snipworkpcount, 4) = Bx
            doubletsnipwork(snipworkpcount, 5) = By
            doubletsnipwork(snipworkpcount, 6) = Bz
            doubletsnipwork(snipworkpcount, 7) = doubletsnip(i, 7)
        ELSE
            snipworkpcount = snipworkpcount + 1
            doubletsnipwork(snipworkpcount, 1) = Ax
            doubletsnipwork(snipworkpcount, 2) = Ay
            doubletsnipwork(snipworkpcount, 3) = Az
            doubletsnipwork(snipworkpcount, 4) = Ax * (1 - doubletintinfo(1, 2)) + doubletintinfo(1, 2) * Bx
            doubletsnipwork(snipworkpcount, 5) = Ay * (1 - doubletintinfo(1, 2)) + doubletintinfo(1, 2) * By
            doubletsnipwork(snipworkpcount, 6) = Az * (1 - doubletintinfo(1, 2)) + doubletintinfo(1, 2) * Bz
            doubletsnipwork(snipworkpcount, 7) = doubletsnip(i, 7)
            snipworkpcount = snipworkpcount + 1
            doubletsnipwork(snipworkpcount, 1) = Ax * (1 - doubletintinfo(numintersections, 2)) + doubletintinfo(numintersections, 2) * Bx
            doubletsnipwork(snipworkpcount, 2) = Ay * (1 - doubletintinfo(numintersections, 2)) + doubletintinfo(numintersections, 2) * By
            doubletsnipwork(snipworkpcount, 3) = Az * (1 - doubletintinfo(numintersections, 2)) + doubletintinfo(numintersections, 2) * Bz
            doubletsnipwork(snipworkpcount, 4) = Bx
            doubletsnipwork(snipworkpcount, 5) = By
            doubletsnipwork(snipworkpcount, 6) = Bz
            doubletsnipwork(snipworkpcount, 7) = doubletsnip(i, 7)
            FOR k = 1 TO numintersections - 1
                snipworkpcount = snipworkpcount + 1
                doubletsnipwork(snipworkpcount, 1) = Ax * (1 - doubletintinfo(k, 2)) + doubletintinfo(k, 2) * Bx
                doubletsnipwork(snipworkpcount, 2) = Ay * (1 - doubletintinfo(k, 2)) + doubletintinfo(k, 2) * By
                doubletsnipwork(snipworkpcount, 3) = Az * (1 - doubletintinfo(k, 2)) + doubletintinfo(k, 2) * Bz
                doubletsnipwork(snipworkpcount, 4) = Ax * (1 - doubletintinfo(k + 1, 2)) + doubletintinfo(k + 1, 2) * Bx
                doubletsnipwork(snipworkpcount, 5) = Ay * (1 - doubletintinfo(k + 1, 2)) + doubletintinfo(k + 1, 2) * By
                doubletsnipwork(snipworkpcount, 6) = Az * (1 - doubletintinfo(k + 1, 2)) + doubletintinfo(k + 1, 2) * Bz
                doubletsnipwork(snipworkpcount, 7) = doubletsnip(i, 7)
            NEXT
        END IF
    END IF
NEXT
RETURN

' *** Define functions for triplet manipulations. ***

project.triplets:
FOR i = 1 TO numtripletfinal
    tripletfinaldotnhat(i, 1) = tripletfinal(i, 1) * nhat(1) + tripletfinal(i, 2) * nhat(2) + tripletfinal(i, 3) * nhat(3)
    tripletfinaldotnhat(i, 2) = tripletfinal(i, 4) * nhat(1) + tripletfinal(i, 5) * nhat(2) + tripletfinal(i, 6) * nhat(3)
    tripletfinaldotnhat(i, 3) = tripletfinal(i, 7) * nhat(1) + tripletfinal(i, 8) * nhat(2) + tripletfinal(i, 9) * nhat(3)
    tripletfinalpuv(i, 1) = tripletfinal(i, 1) * uhat(1) + tripletfinal(i, 2) * uhat(2) + tripletfinal(i, 3) * uhat(3)
    tripletfinalpuv(i, 2) = tripletfinal(i, 1) * vhat(1) + tripletfinal(i, 2) * vhat(2) + tripletfinal(i, 3) * vhat(3)
    tripletfinalpuv(i, 3) = tripletfinal(i, 4) * uhat(1) + tripletfinal(i, 5) * uhat(2) + tripletfinal(i, 6) * uhat(3)
    tripletfinalpuv(i, 4) = tripletfinal(i, 4) * vhat(1) + tripletfinal(i, 5) * vhat(2) + tripletfinal(i, 6) * vhat(3)
    tripletfinalpuv(i, 5) = tripletfinal(i, 7) * uhat(1) + tripletfinal(i, 8) * uhat(2) + tripletfinal(i, 9) * uhat(3)
    tripletfinalpuv(i, 6) = tripletfinal(i, 7) * vhat(1) + tripletfinal(i, 8) * vhat(2) + tripletfinal(i, 9) * vhat(3)
NEXT
RETURN

depth.adjust.triplets:
FOR i = 1 TO numtripletfinal
    tripletfinalpuvs(i, 1) = tripletfinalpuv(i, 1) * fovd / tripletfinaldotnhat(i, 1)
    tripletfinalpuvs(i, 2) = tripletfinalpuv(i, 2) * fovd / tripletfinaldotnhat(i, 1)
    tripletfinalpuvs(i, 3) = tripletfinalpuv(i, 3) * fovd / tripletfinaldotnhat(i, 2)
    tripletfinalpuvs(i, 4) = tripletfinalpuv(i, 4) * fovd / tripletfinaldotnhat(i, 2)
    tripletfinalpuvs(i, 5) = tripletfinalpuv(i, 5) * fovd / tripletfinaldotnhat(i, 3)
    tripletfinalpuvs(i, 6) = tripletfinalpuv(i, 6) * fovd / tripletfinaldotnhat(i, 3)
NEXT
RETURN

' *** Define functions for triplet backface culling. ***

triplet.filter.faceon:
pcounttripletfaceon = 0
FOR i = 1 TO numtripletorig
    Ax = tripletorig(i, 4) - tripletorig(i, 1)
    Ay = tripletorig(i, 5) - tripletorig(i, 2)
    Az = tripletorig(i, 6) - tripletorig(i, 3)
    Bx = tripletorig(i, 7) - tripletorig(i, 1)
    By = tripletorig(i, 8) - tripletorig(i, 2)
    Bz = tripletorig(i, 9) - tripletorig(i, 3)
    centroiDx = (1 / 3) * (tripletorig(i, 1) + tripletorig(i, 4) + tripletorig(i, 7))
    centroiDy = (1 / 3) * (tripletorig(i, 2) + tripletorig(i, 5) + tripletorig(i, 8))
    centroidz = (1 / 3) * (tripletorig(i, 3) + tripletorig(i, 6) + tripletorig(i, 9))
    PanelNormx = Ay * Bz - Az * By
    PanelNormy = Az * Bx - Ax * Bz
    PanelNormz = Ax * By - Ay * Bx
    mag = SQR(PanelNormx ^ 2 + PanelNormy ^ 2 + PanelNormz ^ 2)
    PanelNormx = PanelNormx / mag
    PanelNormy = PanelNormy / mag
    PanelNormz = PanelNormz / mag
    panelnormdotnhat = PanelNormx * nhat(1) + PanelNormy * nhat(2) + PanelNormz * nhat(3)
    cullpoint = PanelNormx * centroiDx + PanelNormy * centroiDy + PanelNormz * centroidz
    IF panelnormdotnhat >= cullpoint THEN
        pcounttripletfaceon = pcounttripletfaceon + 1
        tripletfaceon(pcounttripletfaceon, 1) = tripletorig(i, 1)
        tripletfaceon(pcounttripletfaceon, 2) = tripletorig(i, 2)
        tripletfaceon(pcounttripletfaceon, 3) = tripletorig(i, 3)
        tripletfaceon(pcounttripletfaceon, 4) = tripletorig(i, 4)
        tripletfaceon(pcounttripletfaceon, 5) = tripletorig(i, 5)
        tripletfaceon(pcounttripletfaceon, 6) = tripletorig(i, 6)
        tripletfaceon(pcounttripletfaceon, 7) = tripletorig(i, 7)
        tripletfaceon(pcounttripletfaceon, 8) = tripletorig(i, 8)
        tripletfaceon(pcounttripletfaceon, 9) = tripletorig(i, 9)
        tripletfaceon(pcounttripletfaceon, 10) = tripletorig(i, 10)
    ELSE
        'pcounttripletfaceon = pcounttripletfaceon + 1
        'tripletfaceon(pcounttripletfaceon, 1) = tripletorig(i, 1)
        'tripletfaceon(pcounttripletfaceon, 2) = tripletorig(i, 2)
        'tripletfaceon(pcounttripletfaceon, 3) = tripletorig(i, 3)
        'tripletfaceon(pcounttripletfaceon, 4) = tripletorig(i, 4)
        'tripletfaceon(pcounttripletfaceon, 5) = tripletorig(i, 5)
        'tripletfaceon(pcounttripletfaceon, 6) = tripletorig(i, 6)
        'tripletfaceon(pcounttripletfaceon, 7) = tripletorig(i, 7)
        'tripletfaceon(pcounttripletfaceon, 8) = tripletorig(i, 8)
        'tripletfaceon(pcounttripletfaceon, 9) = tripletorig(i, 9)
        'tripletfaceon(pcounttripletfaceon, 10) = 8
    END IF
NEXT
numtripletfaceon = pcounttripletfaceon
RETURN

' *** Define functions for triplet viewplane clipping. ***


copy.triplets.faceon.clip:
FOR i = 1 TO numtripletfaceon
    tripletclip(i, 1) = tripletfaceon(i, 1)
    tripletclip(i, 2) = tripletfaceon(i, 2)
    tripletclip(i, 3) = tripletfaceon(i, 3)
    tripletclip(i, 4) = tripletfaceon(i, 4)
    tripletclip(i, 5) = tripletfaceon(i, 5)
    tripletclip(i, 6) = tripletfaceon(i, 6)
    tripletclip(i, 7) = tripletfaceon(i, 7)
    tripletclip(i, 8) = tripletfaceon(i, 8)
    tripletclip(i, 9) = tripletfaceon(i, 9)
    tripletclip(i, 10) = tripletfaceon(i, 10)
NEXT
numtripletclip = numtripletfaceon
RETURN

copy.triplets.clipwork.clip:
FOR i = 1 TO pcounttripletclipwork
    tripletclip(i, 1) = tripletclipwork(i, 1)
    tripletclip(i, 2) = tripletclipwork(i, 2)
    tripletclip(i, 3) = tripletclipwork(i, 3)
    tripletclip(i, 4) = tripletclipwork(i, 4)
    tripletclip(i, 5) = tripletclipwork(i, 5)
    tripletclip(i, 6) = tripletclipwork(i, 6)
    tripletclip(i, 7) = tripletclipwork(i, 7)
    tripletclip(i, 8) = tripletclipwork(i, 8)
    tripletclip(i, 9) = tripletclipwork(i, 9)
    tripletclip(i, 10) = tripletclipwork(i, 10)
NEXT
numtripletclip = pcounttripletclipwork
RETURN

clip.triplets.viewplanes:
givenplanex = nearplane(1)
givenplaney = nearplane(2)
givenplanez = nearplane(3)
givenplaned = nearplane(4)
GOSUB clip.triplets.givenplane
GOSUB copy.triplets.clipwork.clip
givenplanex = rightplane(1)
givenplaney = rightplane(2)
givenplanez = rightplane(3)
givenplaned = rightplane(4)
GOSUB clip.triplets.givenplane
GOSUB copy.triplets.clipwork.clip
givenplanex = leftplane(1)
givenplaney = leftplane(2)
givenplanez = leftplane(3)
givenplaned = leftplane(4)
GOSUB clip.triplets.givenplane
GOSUB copy.triplets.clipwork.clip
givenplanex = topplane(1)
givenplaney = topplane(2)
givenplanez = topplane(3)
givenplaned = topplane(4)
GOSUB clip.triplets.givenplane
GOSUB copy.triplets.clipwork.clip
givenplanex = bottomplane(1)
givenplaney = bottomplane(2)
givenplanez = bottomplane(3)
givenplaned = bottomplane(4)
GOSUB clip.triplets.givenplane
GOSUB copy.triplets.clipwork.clip
RETURN

clip.triplets.givenplane:
pcounttripletclipwork = 0
FOR i = 1 TO numtripletclip
    tripletclip1dotgivenplane = tripletclip(i, 1) * givenplanex + tripletclip(i, 2) * givenplaney + tripletclip(i, 3) * givenplanez - givenplaned
    tripletclip2dotgivenplane = tripletclip(i, 4) * givenplanex + tripletclip(i, 5) * givenplaney + tripletclip(i, 6) * givenplanez - givenplaned
    tripletclip3dotgivenplane = tripletclip(i, 7) * givenplanex + tripletclip(i, 8) * givenplaney + tripletclip(i, 9) * givenplanez - givenplaned
    gamma12 = tripletclip2dotgivenplane / tripletclip1dotgivenplane
    gamma23 = tripletclip3dotgivenplane / tripletclip2dotgivenplane
    gamma31 = tripletclip1dotgivenplane / tripletclip3dotgivenplane
    A12x = (tripletclip(i, 1) - tripletclip(i, 4)) / (1 - gamma12)
    A12y = (tripletclip(i, 2) - tripletclip(i, 5)) / (1 - gamma12)
    A12z = (tripletclip(i, 3) - tripletclip(i, 6)) / (1 - gamma12)
    B12x = gamma12 * A12x
    B12y = gamma12 * A12y
    B12z = gamma12 * A12z
    A23x = (tripletclip(i, 4) - tripletclip(i, 7)) / (1 - gamma23)
    A23y = (tripletclip(i, 5) - tripletclip(i, 8)) / (1 - gamma23)
    A23z = (tripletclip(i, 6) - tripletclip(i, 9)) / (1 - gamma23)
    B23x = gamma23 * A23x
    B23y = gamma23 * A23y
    B23z = gamma23 * A23z
    A31x = (tripletclip(i, 7) - tripletclip(i, 1)) / (1 - gamma31)
    A31y = (tripletclip(i, 8) - tripletclip(i, 2)) / (1 - gamma31)
    A31z = (tripletclip(i, 9) - tripletclip(i, 3)) / (1 - gamma31)
    B31x = gamma31 * A31x
    B31y = gamma31 * A31y
    B31z = gamma31 * A31z
    A12dotgivenplane = A12x * givenplanex + A12y * givenplaney + A12z * givenplanez
    B12dotgivenplane = B12x * givenplanex + B12y * givenplaney + B12z * givenplanez
    A23dotgivenplane = A23x * givenplanex + A23y * givenplaney + A23z * givenplanez
    B23dotgivenplane = B23x * givenplanex + B23y * givenplaney + B23z * givenplanez
    A31dotgivenplane = A31x * givenplanex + A31y * givenplaney + A31z * givenplanez
    B31dotgivenplane = B31x * givenplanex + B31y * givenplaney + B31z * givenplanez
    IF A12dotgivenplane > 0 AND B12dotgivenplane > 0 AND A23dotgivenplane > 0 AND B23dotgivenplane > 0 AND A31dotgivenplane > 0 AND B31dotgivenplane > 0 THEN
        pcounttripletclipwork = pcounttripletclipwork + 1
        tripletclipwork(pcounttripletclipwork, 1) = tripletclip(i, 1)
        tripletclipwork(pcounttripletclipwork, 2) = tripletclip(i, 2)
        tripletclipwork(pcounttripletclipwork, 3) = tripletclip(i, 3)
        tripletclipwork(pcounttripletclipwork, 4) = tripletclip(i, 4)
        tripletclipwork(pcounttripletclipwork, 5) = tripletclip(i, 5)
        tripletclipwork(pcounttripletclipwork, 6) = tripletclip(i, 6)
        tripletclipwork(pcounttripletclipwork, 7) = tripletclip(i, 7)
        tripletclipwork(pcounttripletclipwork, 8) = tripletclip(i, 8)
        tripletclipwork(pcounttripletclipwork, 9) = tripletclip(i, 9)
        tripletclipwork(pcounttripletclipwork, 10) = tripletclip(i, 10)
        panelinview = 1
    END IF
    IF A12dotgivenplane > 0 AND B12dotgivenplane > 0 AND A23dotgivenplane > 0 AND B23dotgivenplane < 0 AND A31dotgivenplane < 0 AND B31dotgivenplane > 0 THEN
        pcounttripletclipwork = pcounttripletclipwork + 1
        tripletclipwork(pcounttripletclipwork, 1) = tripletclip(i, 1)
        tripletclipwork(pcounttripletclipwork, 2) = tripletclip(i, 2)
        tripletclipwork(pcounttripletclipwork, 3) = tripletclip(i, 3)
        tripletclipwork(pcounttripletclipwork, 4) = tripletclip(i, 1) - B31x + givenplaned * givenplanex
        tripletclipwork(pcounttripletclipwork, 5) = tripletclip(i, 2) - B31y + givenplaned * givenplaney
        tripletclipwork(pcounttripletclipwork, 6) = tripletclip(i, 3) - B31z + givenplaned * givenplanez
        tripletclipwork(pcounttripletclipwork, 7) = tripletclip(i, 7) - B23x + givenplaned * givenplanex
        tripletclipwork(pcounttripletclipwork, 8) = tripletclip(i, 8) - B23y + givenplaned * givenplaney
        tripletclipwork(pcounttripletclipwork, 9) = tripletclip(i, 9) - B23z + givenplaned * givenplanez
        tripletclipwork(pcounttripletclipwork, 10) = tripletclip(i, 10)
        pcounttripletclipwork = pcounttripletclipwork + 1
        tripletclipwork(pcounttripletclipwork, 1) = tripletclip(i, 1)
        tripletclipwork(pcounttripletclipwork, 2) = tripletclip(i, 2)
        tripletclipwork(pcounttripletclipwork, 3) = tripletclip(i, 3)
        tripletclipwork(pcounttripletclipwork, 4) = tripletclip(i, 4)
        tripletclipwork(pcounttripletclipwork, 5) = tripletclip(i, 5)
        tripletclipwork(pcounttripletclipwork, 6) = tripletclip(i, 6)
        tripletclipwork(pcounttripletclipwork, 7) = tripletclip(i, 7) - B23x + givenplaned * givenplanex
        tripletclipwork(pcounttripletclipwork, 8) = tripletclip(i, 8) - B23y + givenplaned * givenplaney
        tripletclipwork(pcounttripletclipwork, 9) = tripletclip(i, 9) - B23z + givenplaned * givenplanez
        tripletclipwork(pcounttripletclipwork, 10) = tripletclip(i, 10)
    END IF
    IF A12dotgivenplane < 0 AND B12dotgivenplane > 0 AND A23dotgivenplane > 0 AND B23dotgivenplane > 0 AND A31dotgivenplane > 0 AND B31dotgivenplane < 0 THEN
        pcounttripletclipwork = pcounttripletclipwork + 1
        tripletclipwork(pcounttripletclipwork, 1) = tripletclip(i, 7)
        tripletclipwork(pcounttripletclipwork, 2) = tripletclip(i, 8)
        tripletclipwork(pcounttripletclipwork, 3) = tripletclip(i, 9)
        tripletclipwork(pcounttripletclipwork, 4) = tripletclip(i, 1) - B31x + givenplaned * givenplanex
        tripletclipwork(pcounttripletclipwork, 5) = tripletclip(i, 2) - B31y + givenplaned * givenplaney
        tripletclipwork(pcounttripletclipwork, 6) = tripletclip(i, 3) - B31z + givenplaned * givenplanez
        tripletclipwork(pcounttripletclipwork, 7) = tripletclip(i, 4)
        tripletclipwork(pcounttripletclipwork, 8) = tripletclip(i, 5)
        tripletclipwork(pcounttripletclipwork, 9) = tripletclip(i, 6)
        tripletclipwork(pcounttripletclipwork, 10) = tripletclip(i, 10)
        pcounttripletclipwork = pcounttripletclipwork + 1
        tripletclipwork(pcounttripletclipwork, 1) = tripletclip(i, 4)
        tripletclipwork(pcounttripletclipwork, 2) = tripletclip(i, 5)
        tripletclipwork(pcounttripletclipwork, 3) = tripletclip(i, 6)
        tripletclipwork(pcounttripletclipwork, 4) = tripletclip(i, 1) - B31x + givenplaned * givenplanex
        tripletclipwork(pcounttripletclipwork, 5) = tripletclip(i, 2) - B31y + givenplaned * givenplaney
        tripletclipwork(pcounttripletclipwork, 6) = tripletclip(i, 3) - B31z + givenplaned * givenplanez
        tripletclipwork(pcounttripletclipwork, 7) = tripletclip(i, 4) - B12x + givenplaned * givenplanex
        tripletclipwork(pcounttripletclipwork, 8) = tripletclip(i, 5) - B12y + givenplaned * givenplaney
        tripletclipwork(pcounttripletclipwork, 9) = tripletclip(i, 6) - B12z + givenplaned * givenplanez
        tripletclipwork(pcounttripletclipwork, 10) = tripletclip(i, 10)
    END IF
    IF A12dotgivenplane > 0 AND B12dotgivenplane < 0 AND A23dotgivenplane < 0 AND B23dotgivenplane > 0 AND A31dotgivenplane > 0 AND B31dotgivenplane > 0 THEN
        pcounttripletclipwork = pcounttripletclipwork + 1
        tripletclipwork(pcounttripletclipwork, 1) = tripletclip(i, 1)
        tripletclipwork(pcounttripletclipwork, 2) = tripletclip(i, 2)
        tripletclipwork(pcounttripletclipwork, 3) = tripletclip(i, 3)
        tripletclipwork(pcounttripletclipwork, 4) = tripletclip(i, 4) - B12x + givenplaned * givenplanex
        tripletclipwork(pcounttripletclipwork, 5) = tripletclip(i, 5) - B12y + givenplaned * givenplaney
        tripletclipwork(pcounttripletclipwork, 6) = tripletclip(i, 6) - B12z + givenplaned * givenplanez
        tripletclipwork(pcounttripletclipwork, 7) = tripletclip(i, 7)
        tripletclipwork(pcounttripletclipwork, 8) = tripletclip(i, 8)
        tripletclipwork(pcounttripletclipwork, 9) = tripletclip(i, 9)
        tripletclipwork(pcounttripletclipwork, 10) = tripletclip(i, 10)
        pcounttripletclipwork = pcounttripletclipwork + 1
        tripletclipwork(pcounttripletclipwork, 1) = tripletclip(i, 7)
        tripletclipwork(pcounttripletclipwork, 2) = tripletclip(i, 8)
        tripletclipwork(pcounttripletclipwork, 3) = tripletclip(i, 9)
        tripletclipwork(pcounttripletclipwork, 4) = tripletclip(i, 4) - B12x + givenplaned * givenplanex
        tripletclipwork(pcounttripletclipwork, 5) = tripletclip(i, 5) - B12y + givenplaned * givenplaney
        tripletclipwork(pcounttripletclipwork, 6) = tripletclip(i, 6) - B12z + givenplaned * givenplanez
        tripletclipwork(pcounttripletclipwork, 7) = tripletclip(i, 7) - B23x + givenplaned * givenplanex
        tripletclipwork(pcounttripletclipwork, 8) = tripletclip(i, 8) - B23y + givenplaned * givenplaney
        tripletclipwork(pcounttripletclipwork, 9) = tripletclip(i, 9) - B23z + givenplaned * givenplanez
        tripletclipwork(pcounttripletclipwork, 10) = tripletclip(i, 10)
    END IF
    IF A12dotgivenplane > 0 AND B12dotgivenplane < 0 AND A23dotgivenplane < 0 AND B23dotgivenplane < 0 AND A31dotgivenplane < 0 AND B31dotgivenplane > 0 THEN
        pcounttripletclipwork = pcounttripletclipwork + 1
        tripletclipwork(pcounttripletclipwork, 1) = tripletclip(i, 1)
        tripletclipwork(pcounttripletclipwork, 2) = tripletclip(i, 2)
        tripletclipwork(pcounttripletclipwork, 3) = tripletclip(i, 3)
        tripletclipwork(pcounttripletclipwork, 4) = tripletclip(i, 4) - B12x + givenplaned * givenplanex
        tripletclipwork(pcounttripletclipwork, 5) = tripletclip(i, 5) - B12y + givenplaned * givenplaney
        tripletclipwork(pcounttripletclipwork, 6) = tripletclip(i, 6) - B12z + givenplaned * givenplanez
        tripletclipwork(pcounttripletclipwork, 7) = tripletclip(i, 1) - B31x + givenplaned * givenplanex
        tripletclipwork(pcounttripletclipwork, 8) = tripletclip(i, 2) - B31y + givenplaned * givenplaney
        tripletclipwork(pcounttripletclipwork, 9) = tripletclip(i, 3) - B31z + givenplaned * givenplanez
        tripletclipwork(pcounttripletclipwork, 10) = tripletclip(i, 10)
    END IF
    IF A12dotgivenplane < 0 AND B12dotgivenplane > 0 AND A23dotgivenplane > 0 AND B23dotgivenplane < 0 AND A31dotgivenplane < 0 AND B31dotgivenplane < 0 THEN
        pcounttripletclipwork = pcounttripletclipwork + 1
        tripletclipwork(pcounttripletclipwork, 1) = tripletclip(i, 4)
        tripletclipwork(pcounttripletclipwork, 2) = tripletclip(i, 5)
        tripletclipwork(pcounttripletclipwork, 3) = tripletclip(i, 6)
        tripletclipwork(pcounttripletclipwork, 4) = tripletclip(i, 7) - B23x + givenplaned * givenplanex
        tripletclipwork(pcounttripletclipwork, 5) = tripletclip(i, 8) - B23y + givenplaned * givenplaney
        tripletclipwork(pcounttripletclipwork, 6) = tripletclip(i, 9) - B23z + givenplaned * givenplanez
        tripletclipwork(pcounttripletclipwork, 7) = tripletclip(i, 4) - B12x + givenplaned * givenplanex
        tripletclipwork(pcounttripletclipwork, 8) = tripletclip(i, 5) - B12y + givenplaned * givenplaney
        tripletclipwork(pcounttripletclipwork, 9) = tripletclip(i, 6) - B12z + givenplaned * givenplanez
        tripletclipwork(pcounttripletclipwork, 10) = tripletclip(i, 10)
    END IF
    IF A12dotgivenplane < 0 AND B12dotgivenplane < 0 AND A23dotgivenplane < 0 AND B23dotgivenplane > 0 AND A31dotgivenplane > 0 AND B31dotgivenplane < 0 THEN
        pcounttripletclipwork = pcounttripletclipwork + 1
        tripletclipwork(pcounttripletclipwork, 1) = tripletclip(i, 7)
        tripletclipwork(pcounttripletclipwork, 2) = tripletclip(i, 8)
        tripletclipwork(pcounttripletclipwork, 3) = tripletclip(i, 9)
        tripletclipwork(pcounttripletclipwork, 4) = tripletclip(i, 7) - B23x + givenplaned * givenplanex
        tripletclipwork(pcounttripletclipwork, 5) = tripletclip(i, 8) - B23y + givenplaned * givenplaney
        tripletclipwork(pcounttripletclipwork, 6) = tripletclip(i, 9) - B23z + givenplaned * givenplanez
        tripletclipwork(pcounttripletclipwork, 7) = tripletclip(i, 1) - B31x + givenplaned * givenplanex
        tripletclipwork(pcounttripletclipwork, 8) = tripletclip(i, 2) - B31y + givenplaned * givenplaney
        tripletclipwork(pcounttripletclipwork, 9) = tripletclip(i, 3) - B31z + givenplaned * givenplanez
        tripletclipwork(pcounttripletclipwork, 10) = tripletclip(i, 10)
    END IF
NEXT
RETURN

' *** Define functions for triplet snipping. ***

copy.triplets.clip.snip:
FOR i = 1 TO numtripletclip
    tripletsnip(i, 1) = tripletclip(i, 1)
    tripletsnip(i, 2) = tripletclip(i, 2)
    tripletsnip(i, 3) = tripletclip(i, 3)
    tripletsnip(i, 4) = tripletclip(i, 4)
    tripletsnip(i, 5) = tripletclip(i, 5)
    tripletsnip(i, 6) = tripletclip(i, 6)
    tripletsnip(i, 7) = tripletclip(i, 7)
    tripletsnip(i, 8) = tripletclip(i, 8)
    tripletsnip(i, 9) = tripletclip(i, 9)
    tripletsnip(i, 10) = tripletclip(i, 10)
NEXT
numtripletsnip = numtripletclip
RETURN

snip.triplets:
snipworkpcount = 0
FOR i = 1 TO numtripletsnip
    pcounttripletsnipimage = 1
    tripletsnipimage(1, 1) = tripletsnip(i, 1)
    tripletsnipimage(1, 2) = tripletsnip(i, 2)
    tripletsnipimage(1, 3) = tripletsnip(i, 3)
    tripletsnipimage(1, 4) = tripletsnip(i, 4)
    tripletsnipimage(1, 5) = tripletsnip(i, 5)
    tripletsnipimage(1, 6) = tripletsnip(i, 6)
    tripletsnipimage(1, 7) = tripletsnip(i, 7)
    tripletsnipimage(1, 8) = tripletsnip(i, 8)
    tripletsnipimage(1, 9) = tripletsnip(i, 9)
    tripletsnipimage(1, 10) = tripletsnip(i, 10)
    begintripletsnipsubloop:
    FOR k = 1 TO pcounttripletsnipimage
        FOR j = 1 TO numtripletsnip
            IF j <> i THEN
                IF pcounttripletsnipimage > numtripletsnip + 5 THEN
                    ' Error case. The 5 is completely arbitrary.
                    GOTO bypasssniploop
                END IF
                Ax = tripletsnipimage(k, 1)
                Ay = tripletsnipimage(k, 2)
                Az = tripletsnipimage(k, 3)
                Bx = tripletsnipimage(k, 4)
                By = tripletsnipimage(k, 5)
                Bz = tripletsnipimage(k, 6)
                Cx = tripletsnipimage(k, 7)
                Cy = tripletsnipimage(k, 8)
                Cz = tripletsnipimage(k, 9)
                Au = Ax * uhat(1) + Ay * uhat(2) + Az * uhat(3)
                Av = Ax * vhat(1) + Ay * vhat(2) + Az * vhat(3)
                Bu = Bx * uhat(1) + By * uhat(2) + Bz * uhat(3)
                Bv = Bx * vhat(1) + By * vhat(2) + Bz * vhat(3)
                Cu = Cx * uhat(1) + Cy * uhat(2) + Cz * uhat(3)
                Cv = Cx * vhat(1) + Cy * vhat(2) + Cz * vhat(3)
                An = Ax * nhat(1) + Ay * nhat(2) + Az * nhat(3)
                Bn = Bx * nhat(1) + By * nhat(2) + Bz * nhat(3)
                Cn = Cx * nhat(1) + Cy * nhat(2) + Cz * nhat(3)
                Asu = Au * fovd / An
                Asv = Av * fovd / An
                Bsu = Bu * fovd / Bn
                Bsv = Bv * fovd / Bn
                Csu = Cu * fovd / Cn
                Csv = Cv * fovd / Cn
                Dx = tripletsnip(j, 1)
                Dy = tripletsnip(j, 2)
                Dz = tripletsnip(j, 3)
                Ex = tripletsnip(j, 4)
                Ey = tripletsnip(j, 5)
                Ez = tripletsnip(j, 6)
                Fx = tripletsnip(j, 7)
                Fy = tripletsnip(j, 8)
                Fz = tripletsnip(j, 9)
                Du = Dx * uhat(1) + Dy * uhat(2) + Dz * uhat(3)
                Dv = Dx * vhat(1) + Dy * vhat(2) + Dz * vhat(3)
                Eu = Ex * uhat(1) + Ey * uhat(2) + Ez * uhat(3)
                Ev = Ex * vhat(1) + Ey * vhat(2) + Ez * vhat(3)
                Fu = Fx * uhat(1) + Fy * uhat(2) + Fz * uhat(3)
                Fv = Fx * vhat(1) + Fy * vhat(2) + Fz * vhat(3)
                Dn = Dx * nhat(1) + Dy * nhat(2) + Dz * nhat(3)
                En = Ex * nhat(1) + Ey * nhat(2) + Ez * nhat(3)
                Fn = Fx * nhat(1) + Fy * nhat(2) + Fz * nhat(3)
                Dsu = Du * fovd / Dn
                Dsv = Dv * fovd / Dn
                Esu = Eu * fovd / En
                Esv = Ev * fovd / En
                Fsu = Fu * fovd / Fn
                Fsv = Fv * fovd / Fn
                GOSUB compute.triplet.sig.components
                ' Classify the scheme of triangle overlap and assign a 3-digit code.
                signature1 = pointDinside + pointEinside + pointFinside
                signature2 = pointAinside + pointBinside + pointCinside
                signature3 = intABDE + intBCDE + intCADE + intABEF + intBCEF + intCAEF + intABFD + intBCFD + intCAFD
                signature1text$ = STR$(signature1)
                signature2text$ = STR$(signature2)
                signature3text$ = STR$(signature3)
                signaturefull$ = signature1text$ + signature2text$ + signature3text$
                GOSUB triplet.image.generate
            END IF
        NEXT
    NEXT
    bypasssniploop:
    FOR m = 1 TO pcounttripletsnipimage
        snipworkpcount = snipworkpcount + 1
        tripletsnipwork(snipworkpcount, 1) = tripletsnipimage(m, 1)
        tripletsnipwork(snipworkpcount, 2) = tripletsnipimage(m, 2)
        tripletsnipwork(snipworkpcount, 3) = tripletsnipimage(m, 3)
        tripletsnipwork(snipworkpcount, 4) = tripletsnipimage(m, 4)
        tripletsnipwork(snipworkpcount, 5) = tripletsnipimage(m, 5)
        tripletsnipwork(snipworkpcount, 6) = tripletsnipimage(m, 6)
        tripletsnipwork(snipworkpcount, 7) = tripletsnipimage(m, 7)
        tripletsnipwork(snipworkpcount, 8) = tripletsnipimage(m, 8)
        tripletsnipwork(snipworkpcount, 9) = tripletsnipimage(m, 9)
        tripletsnipwork(snipworkpcount, 10) = tripletsnipimage(m, 10)
    NEXT
NEXT
FOR i = 1 TO snipworkpcount
    tripletsnip(i, 1) = tripletsnipwork(i, 1)
    tripletsnip(i, 2) = tripletsnipwork(i, 2)
    tripletsnip(i, 3) = tripletsnipwork(i, 3)
    tripletsnip(i, 4) = tripletsnipwork(i, 4)
    tripletsnip(i, 5) = tripletsnipwork(i, 5)
    tripletsnip(i, 6) = tripletsnipwork(i, 6)
    tripletsnip(i, 7) = tripletsnipwork(i, 7)
    tripletsnip(i, 8) = tripletsnipwork(i, 8)
    tripletsnip(i, 9) = tripletsnipwork(i, 9)
    tripletsnip(i, 10) = tripletsnipwork(i, 10)
    ' Code for troubleshooting.
    'centsnipx = (1 / 3) * (tripletsnipwork(i, 1) + tripletsnipwork(i, 4) + tripletsnipwork(i, 7))
    'centsnipy = (1 / 3) * (tripletsnipwork(i, 2) + tripletsnipwork(i, 5) + tripletsnipwork(i, 8))
    'centsnipz = (1 / 3) * (tripletsnipwork(i, 3) + tripletsnipwork(i, 6) + tripletsnipwork(i, 9))
    'centmag = SQR((centsnipx) ^ 2 + (centsnipy) ^ 2 + (centsnipz) ^ 2)
NEXT
numtripletsnip = snipworkpcount
RETURN

compute.triplet.sig.components:
' Begin calculations for enclosed points: DEF inside ABC.

pointDinside = -1
pointEinside = -1
pointFinside = -1
pcounttripletencpoint = 0

tan12uv = (Asv - Bsv) / (Asu - Bsu)
norm12u = -(Asv - Bsv)
norm12v = (Asu - Bsu)
mag = SQR(norm12u ^ 2 + norm12v ^ 2)
norm12u = norm12u / mag
norm12v = norm12v / mag
Asdotnorm12 = Asu * norm12u + Asv * norm12v
Bsdotnorm12 = Bsu * norm12u + Bsv * norm12v
Dsdotnorm12 = Dsu * norm12u + Dsv * norm12v
Esdotnorm12 = Esu * norm12u + Esv * norm12v
Fsdotnorm12 = Fsu * norm12u + Fsv * norm12v

tan23uv = (Bsv - Csv) / (Bsu - Csu)
norm23u = -(Bsv - Csv)
norm23v = (Bsu - Csu)
mag = SQR(norm23u ^ 2 + norm23v ^ 2)
norm23u = norm23u / mag
norm23v = norm23v / mag
Bsdotnorm23 = Bsu * norm23u + Bsv * norm23v
Csdotnorm23 = Csu * norm23u + Csv * norm23v
Dsdotnorm23 = Dsu * norm23u + Dsv * norm23v
Esdotnorm23 = Esu * norm23u + Esv * norm23v
Fsdotnorm23 = Fsu * norm23u + Fsv * norm23v

tan31uv = (Csv - Asv) / (Csu - Asu)
norm31u = -(Csv - Asv)
norm31v = (Csu - Asu)
mag = SQR(norm31u ^ 2 + norm31v ^ 2)
norm31u = norm31u / mag
norm31v = norm31v / mag
Csdotnorm31 = Csu * norm31u + Csv * norm31v
Asdotnorm31 = Asu * norm31u + Asv * norm31v
Dsdotnorm31 = Dsu * norm31u + Dsv * norm31v
Esdotnorm31 = Esu * norm31u + Esv * norm31v
Fsdotnorm31 = Fsu * norm31u + Fsv * norm31v

pointDdist12 = Dsdotnorm12 - (1 / 2) * (Asdotnorm12 + Bsdotnorm12)
pointDdist23 = Dsdotnorm23 - (1 / 2) * (Bsdotnorm23 + Csdotnorm23)
pointDdist31 = Dsdotnorm31 - (1 / 2) * (Csdotnorm31 + Asdotnorm31)

pointEdist12 = Esdotnorm12 - (1 / 2) * (Asdotnorm12 + Bsdotnorm12)
pointEdist23 = Esdotnorm23 - (1 / 2) * (Bsdotnorm23 + Csdotnorm23)
pointEdist31 = Esdotnorm31 - (1 / 2) * (Csdotnorm31 + Asdotnorm31)

pointFdist12 = Fsdotnorm12 - (1 / 2) * (Asdotnorm12 + Bsdotnorm12)
pointFdist23 = Fsdotnorm23 - (1 / 2) * (Bsdotnorm23 + Csdotnorm23)
pointFdist31 = Fsdotnorm31 - (1 / 2) * (Csdotnorm31 + Asdotnorm31)

IF pointDdist12 > 0 AND pointDdist23 > 0 AND pointDdist31 > 0 THEN
    pointDinside = 1
    Q = Dsu / fovd
    R = Q * (Bn - An) - (Bu - Au)
    S = Q * (Cn - An) - (Cu - Au)
    T = Au - Q * An
    Z = Dsv / fovd
    U = Z * (Bn - An) - (Bv - Av)
    V = Z * (Cn - An) - (Cv - Av)
    W = Av - Z * An
    factor1 = (T / S - W / V) / (R / S - U / V)
    factor2 = (T / R - W / U) / (S / R - V / U)
    pcounttripletencpoint = pcounttripletencpoint + 1
    tripletencpoint(pcounttripletencpoint, 1) = Dx
    tripletencpoint(pcounttripletencpoint, 2) = Dy
    tripletencpoint(pcounttripletencpoint, 3) = Dz
    tripletencpoint(pcounttripletencpoint, 4) = Ax + factor1 * (Bx - Ax) + factor2 * (Cx - Ax)
    tripletencpoint(pcounttripletencpoint, 5) = Ay + factor1 * (By - Ay) + factor2 * (Cy - Ay)
    tripletencpoint(pcounttripletencpoint, 6) = Az + factor1 * (Bz - Az) + factor2 * (Cz - Az)
    tripletencpoint(pcounttripletencpoint, 7) = Dsu
    tripletencpoint(pcounttripletencpoint, 8) = Dsv
ELSE
    pointDinside = 0
END IF

IF pointEdist12 > 0 AND pointEdist23 > 0 AND pointEdist31 > 0 THEN
    pointEinside = 1
    Q = Esu / fovd
    R = Q * (Bn - An) - (Bu - Au)
    S = Q * (Cn - An) - (Cu - Au)
    T = Au - Q * An
    Z = Esv / fovd
    U = Z * (Bn - An) - (Bv - Av)
    V = Z * (Cn - An) - (Cv - Av)
    W = Av - Z * An
    factor1 = (T / S - W / V) / (R / S - U / V)
    factor2 = (T / R - W / U) / (S / R - V / U)
    pcounttripletencpoint = pcounttripletencpoint + 1
    tripletencpoint(pcounttripletencpoint, 1) = Ex
    tripletencpoint(pcounttripletencpoint, 2) = Ey
    tripletencpoint(pcounttripletencpoint, 3) = Ez
    tripletencpoint(pcounttripletencpoint, 4) = Ax + factor1 * (Bx - Ax) + factor2 * (Cx - Ax)
    tripletencpoint(pcounttripletencpoint, 5) = Ay + factor1 * (By - Ay) + factor2 * (Cy - Ay)
    tripletencpoint(pcounttripletencpoint, 6) = Az + factor1 * (Bz - Az) + factor2 * (Cz - Az)
    tripletencpoint(pcounttripletencpoint, 7) = Esu
    tripletencpoint(pcounttripletencpoint, 8) = Esv
ELSE
    pointEinside = 0
END IF

IF pointFdist12 > 0 AND pointFdist23 > 0 AND pointFdist31 > 0 THEN
    pointFinside = 1
    Q = Fsu / fovd
    R = Q * (Bn - An) - (Bu - Au)
    S = Q * (Cn - An) - (Cu - Au)
    T = Au - Q * An
    Z = Fsv / fovd
    U = Z * (Bn - An) - (Bv - Av)
    V = Z * (Cn - An) - (Cv - Av)
    W = Av - Z * An
    factor1 = (T / S - W / V) / (R / S - U / V)
    factor2 = (T / R - W / U) / (S / R - V / U)
    pcounttripletencpoint = pcounttripletencpoint + 1
    tripletencpoint(pcounttripletencpoint, 1) = Fx
    tripletencpoint(pcounttripletencpoint, 2) = Fy
    tripletencpoint(pcounttripletencpoint, 3) = Fz
    tripletencpoint(pcounttripletencpoint, 4) = Ax + factor1 * (Bx - Ax) + factor2 * (Cx - Ax)
    tripletencpoint(pcounttripletencpoint, 5) = Ay + factor1 * (By - Ay) + factor2 * (Cy - Ay)
    tripletencpoint(pcounttripletencpoint, 6) = Az + factor1 * (Bz - Az) + factor2 * (Cz - Az)
    tripletencpoint(pcounttripletencpoint, 7) = Fsu
    tripletencpoint(pcounttripletencpoint, 8) = Fsv
ELSE
    pointFinside = 0
END IF

' Begin calculations for enclosed points: ABC inside DEF.

pointAinside = -1
pointBinside = -1
pointCinside = -1

tan12uv = (Dsv - Esv) / (Dsu - Esu)
norm12u = -(Dsv - Esv)
norm12v = (Dsu - Esu)
mag = SQR(norm12u ^ 2 + norm12v ^ 2)
norm12u = norm12u / mag
norm12v = norm12v / mag
Dsdotnorm12 = Dsu * norm12u + Dsv * norm12v
Esdotnorm12 = Esu * norm12u + Esv * norm12v
Asdotnorm12 = Asu * norm12u + Asv * norm12v
Bsdotnorm12 = Bsu * norm12u + Bsv * norm12v
Csdotnorm12 = Csu * norm12u + Csv * norm12v

tan23uv = (Esv - Fsv) / (Esu - Fsu)
norm23u = -(Esv - Fsv)
norm23v = (Esu - Fsu)
mag = SQR(norm23u ^ 2 + norm23v ^ 2)
norm23u = norm23u / mag
norm23v = norm23v / mag
Esdotnorm23 = Esu * norm23u + Esv * norm23v
Fsdotnorm23 = Fsu * norm23u + Fsv * norm23v
Asdotnorm23 = Asu * norm23u + Asv * norm23v
Bsdotnorm23 = Bsu * norm23u + Bsv * norm23v
Csdotnorm23 = Csu * norm23u + Csv * norm23v

tan31uv = (Fsv - Dsv) / (Fsu - Dsu)
norm31u = -(Fsv - Dsv)
norm31v = (Fsu - Dsu)
mag = SQR(norm31u ^ 2 + norm31v ^ 2)
norm31u = norm31u / mag
norm31v = norm31v / mag
Fsdotnorm31 = Fsu * norm31u + Fsv * norm31v
Dsdotnorm31 = Dsu * norm31u + Dsv * norm31v
Asdotnorm31 = Asu * norm31u + Asv * norm31v
Bsdotnorm31 = Bsu * norm31u + Bsv * norm31v
Csdotnorm31 = Csu * norm31u + Csv * norm31v

pointAdist12 = Asdotnorm12 - (1 / 2) * (Dsdotnorm12 + Esdotnorm12)
pointAdist23 = Asdotnorm23 - (1 / 2) * (Esdotnorm23 + Fsdotnorm23)
pointAdist31 = Asdotnorm31 - (1 / 2) * (Fsdotnorm31 + Dsdotnorm31)

pointBdist12 = Bsdotnorm12 - (1 / 2) * (Dsdotnorm12 + Esdotnorm12)
pointBdist23 = Bsdotnorm23 - (1 / 2) * (Esdotnorm23 + Fsdotnorm23)
pointBdist31 = Bsdotnorm31 - (1 / 2) * (Fsdotnorm31 + Dsdotnorm31)

pointCdist12 = Csdotnorm12 - (1 / 2) * (Dsdotnorm12 + Esdotnorm12)
pointCdist23 = Csdotnorm23 - (1 / 2) * (Esdotnorm23 + Fsdotnorm23)
pointCdist31 = Csdotnorm31 - (1 / 2) * (Fsdotnorm31 + Dsdotnorm31)

IF pointAdist12 > 0 AND pointAdist23 > 0 AND pointAdist31 > 0 THEN
    pointAinside = 1
    Q = Asu / fovd
    R = Q * (En - Dn) - (Eu - Du)
    S = Q * (Fn - Dn) - (Fu - Du)
    T = Du - Q * Dn
    Z = Asv / fovd
    U = Z * (En - Dn) - (Ev - Dv)
    V = Z * (Fn - Dn) - (Fv - Dv)
    W = Dv - Z * Dn
    factor1 = (T / S - W / V) / (R / S - U / V)
    factor2 = (T / R - W / U) / (S / R - V / U)
    pcounttripletencpoint = pcounttripletencpoint + 1
    tripletencpoint(pcounttripletencpoint, 1) = Ax
    tripletencpoint(pcounttripletencpoint, 2) = Ay
    tripletencpoint(pcounttripletencpoint, 3) = Az
    tripletencpoint(pcounttripletencpoint, 4) = Dx + factor1 * (Ex - Dx) + factor2 * (Fx - Dx)
    tripletencpoint(pcounttripletencpoint, 5) = Dy + factor1 * (Ey - Dy) + factor2 * (Fy - Dy)
    tripletencpoint(pcounttripletencpoint, 6) = Dz + factor1 * (Ez - Dz) + factor2 * (Fz - Dz)
    tripletencpoint(pcounttripletencpoint, 7) = Asu
    tripletencpoint(pcounttripletencpoint, 8) = Asv
ELSE
    pointAinside = 0
END IF

IF pointBdist12 > 0 AND pointBdist23 > 0 AND pointBdist31 > 0 THEN
    pointBinside = 1
    Q = Bsu / fovd
    R = Q * (En - Dn) - (Eu - Du)
    S = Q * (Fn - Dn) - (Fu - Du)
    T = Du - Q * Dn
    Z = Bsv / fovd
    U = Z * (En - Dn) - (Ev - Dv)
    V = Z * (Fn - Dn) - (Fv - Dv)
    W = Dv - Z * Dn
    factor1 = (T / S - W / V) / (R / S - U / V)
    factor2 = (T / R - W / U) / (S / R - V / U)
    pcounttripletencpoint = pcounttripletencpoint + 1
    tripletencpoint(pcounttripletencpoint, 1) = Bx
    tripletencpoint(pcounttripletencpoint, 2) = By
    tripletencpoint(pcounttripletencpoint, 3) = Bz
    tripletencpoint(pcounttripletencpoint, 4) = Dx + factor1 * (Ex - Dx) + factor2 * (Fx - Dx)
    tripletencpoint(pcounttripletencpoint, 5) = Dy + factor1 * (Ey - Dy) + factor2 * (Fy - Dy)
    tripletencpoint(pcounttripletencpoint, 6) = Dz + factor1 * (Ez - Dz) + factor2 * (Fz - Dz)
    tripletencpoint(pcounttripletencpoint, 7) = Bsu
    tripletencpoint(pcounttripletencpoint, 8) = Bsv
ELSE
    pointBinside = 0
END IF

IF pointCdist12 > 0 AND pointCdist23 > 0 AND pointCdist31 > 0 THEN
    pointCinside = 1
    Q = Csu / fovd
    R = Q * (En - Dn) - (Eu - Du)
    S = Q * (Fn - Dn) - (Fu - Du)
    T = Du - Q * Dn
    Z = Csv / fovd
    U = Z * (En - Dn) - (Ev - Dv)
    V = Z * (Fn - Dn) - (Fv - Dv)
    W = Dv - Z * Dn
    factor1 = (T / S - W / V) / (R / S - U / V)
    factor2 = (T / R - W / U) / (S / R - V / U)
    pcounttripletencpoint = pcounttripletencpoint + 1
    tripletencpoint(pcounttripletencpoint, 1) = Cx
    tripletencpoint(pcounttripletencpoint, 2) = Cy
    tripletencpoint(pcounttripletencpoint, 3) = Cz
    tripletencpoint(pcounttripletencpoint, 4) = Dx + factor1 * (Ex - Dx) + factor2 * (Fx - Dx)
    tripletencpoint(pcounttripletencpoint, 5) = Dy + factor1 * (Ey - Dy) + factor2 * (Fy - Dy)
    tripletencpoint(pcounttripletencpoint, 6) = Dz + factor1 * (Ez - Dz) + factor2 * (Fz - Dz)
    tripletencpoint(pcounttripletencpoint, 7) = Csu
    tripletencpoint(pcounttripletencpoint, 8) = Csv
ELSE
    pointCinside = 0
END IF

' Begin calculations for triplet line intersections.

magtripletABps = SQR((Asu - Bsu) ^ 2 + (Asv - Bsv) ^ 2)
magtripletBCps = SQR((Bsu - Csu) ^ 2 + (Bsv - Csv) ^ 2)
magtripletCAps = SQR((Csu - Asu) ^ 2 + (Csv - Asv) ^ 2)

magtripletDEps = SQR((Dsu - Esu) ^ 2 + (Dsv - Esv) ^ 2)
magtripletEFps = SQR((Esu - Fsu) ^ 2 + (Esv - Fsv) ^ 2)
magtripletFDps = SQR((Fsu - Dsu) ^ 2 + (Fsv - Dsv) ^ 2)

slopeAB = (Bsv - Asv) / (Bsu - Asu)
intAB = Asv - slopeAB * Asu
slopeBC = (Csv - Bsv) / (Csu - Bsu)
intBC = Bsv - slopeBC * Bsu
slopeCA = (Asv - Csv) / (Asu - Csu)
intCA = Csv - slopeCA * Csu

slopeDE = (Esv - Dsv) / (Esu - Dsu)
intDE = Dsv - slopeDE * Dsu
slopeEF = (Fsv - Esv) / (Fsu - Esu)
intEF = Esv - slopeEF * Esu
slopeFD = (Dsv - Fsv) / (Dsu - Fsu)
intFD = Fsv - slopeFD * Fsu

xstarABDE = -(intAB - intDE) / (slopeAB - slopeDE)
ystarABDE = slopeAB * xstarABDE + intAB
xstarABEF = -(intAB - intEF) / (slopeAB - slopeEF)
ystarABEF = slopeAB * xstarABEF + intAB
xstarABFD = -(intAB - intFD) / (slopeAB - slopeFD)
ystarABFD = slopeAB * xstarABFD + intAB

xstarBCDE = -(intBC - intDE) / (slopeBC - slopeDE)
ystarBCDE = slopeBC * xstarBCDE + intBC
xstarBCEF = -(intBC - intEF) / (slopeBC - slopeEF)
ystarBCEF = slopeBC * xstarBCEF + intBC
xstarBCFD = -(intBC - intFD) / (slopeBC - slopeFD)
ystarBCFD = slopeBC * xstarBCFD + intBC

xstarCADE = -(intCA - intDE) / (slopeCA - slopeDE)
ystarCADE = slopeCA * xstarCADE + intCA
xstarCAEF = -(intCA - intEF) / (slopeCA - slopeEF)
ystarCAEF = slopeCA * xstarCAEF + intCA
xstarCAFD = -(intCA - intFD) / (slopeCA - slopeFD)
ystarCAFD = slopeCA * xstarCAFD + intCA

alphaABDE1u = -xstarABDE + Asu
alphaABDE1v = -ystarABDE + Asv
alphaABDE2u = -xstarABDE + Bsu
alphaABDE2v = -ystarABDE + Bsv
alphaABEF1u = -xstarABEF + Asu
alphaABEF1v = -ystarABEF + Asv
alphaABEF2u = -xstarABEF + Bsu
alphaABEF2v = -ystarABEF + Bsv
alphaABFD1u = -xstarABFD + Asu
alphaABFD1v = -ystarABFD + Asv
alphaABFD2u = -xstarABFD + Bsu
alphaABFD2v = -ystarABFD + Bsv

alphaBCDE1u = -xstarBCDE + Bsu
alphaBCDE1v = -ystarBCDE + Bsv
alphaBCDE2u = -xstarBCDE + Csu
alphaBCDE2v = -ystarBCDE + Csv
alphaBCEF1u = -xstarBCEF + Bsu
alphaBCEF1v = -ystarBCEF + Bsv
alphaBCEF2u = -xstarBCEF + Csu
alphaBCEF2v = -ystarBCEF + Csv
alphaBCFD1u = -xstarBCFD + Bsu
alphaBCFD1v = -ystarBCFD + Bsv
alphaBCFD2u = -xstarBCFD + Csu
alphaBCFD2v = -ystarBCFD + Csv

alphaCADE1u = -xstarCADE + Csu
alphaCADE1v = -ystarCADE + Csv
alphaCADE2u = -xstarCADE + Asu
alphaCADE2v = -ystarCADE + Asv
alphaCAEF1u = -xstarCAEF + Csu
alphaCAEF1v = -ystarCAEF + Csv
alphaCAEF2u = -xstarCAEF + Asu
alphaCAEF2v = -ystarCAEF + Asv
alphaCAFD1u = -xstarCAFD + Csu
alphaCAFD1v = -ystarCAFD + Csv
alphaCAFD2u = -xstarCAFD + Asu
alphaCAFD2v = -ystarCAFD + Asv

alphaDEAB1u = -xstarABDE + Dsu
alphaDEAB1v = -ystarABDE + Dsv
alphaDEAB2u = -xstarABDE + Esu
alphaDEAB2v = -ystarABDE + Esv
alphaDEBC1u = -xstarBCDE + Dsu
alphaDEBC1v = -ystarBCDE + Dsv
alphaDEBC2u = -xstarBCDE + Esu
alphaDEBC2v = -ystarBCDE + Esv
alphaDECA1u = -xstarCADE + Dsu
alphaDECA1v = -ystarCADE + Dsv
alphaDECA2u = -xstarCADE + Esu
alphaDECA2v = -ystarCADE + Esv

alphaEFAB1u = -xstarABEF + Esu
alphaEFAB1v = -ystarABEF + Esv
alphaEFAB2u = -xstarABEF + Fsu
alphaEFAB2v = -ystarABEF + Fsv
alphaEFBC1u = -xstarBCEF + Esu
alphaEFBC1v = -ystarBCEF + Esv
alphaEFBC2u = -xstarBCEF + Fsu
alphaEFBC2v = -ystarBCEF + Fsv
alphaEFCA1u = -xstarCAEF + Esu
alphaEFCA1v = -ystarCAEF + Esv
alphaEFCA2u = -xstarCAEF + Fsu
alphaEFCA2v = -ystarCAEF + Fsv

alphaFDAB1u = -xstarABFD + Fsu
alphaFDAB1v = -ystarABFD + Fsv
alphaFDAB2u = -xstarABFD + Dsu
alphaFDAB2v = -ystarABFD + Dsv
alphaFDBC1u = -xstarBCFD + Fsu
alphaFDBC1v = -ystarBCFD + Fsv
alphaFDBC2u = -xstarBCFD + Dsu
alphaFDBC2v = -ystarBCFD + Dsv
alphaFDCA1u = -xstarCAFD + Fsu
alphaFDCA1v = -ystarCAFD + Fsv
alphaFDCA2u = -xstarCAFD + Dsu
alphaFDCA2v = -ystarCAFD + Dsv

magalphaABDE1 = SQR(alphaABDE1u ^ 2 + alphaABDE1v ^ 2)
magalphaABDE2 = SQR(alphaABDE2u ^ 2 + alphaABDE2v ^ 2)
magalphaABEF1 = SQR(alphaABEF1u ^ 2 + alphaABEF1v ^ 2)
magalphaABEF2 = SQR(alphaABEF2u ^ 2 + alphaABEF2v ^ 2)
magalphaABFD1 = SQR(alphaABFD1u ^ 2 + alphaABFD1v ^ 2)
magalphaABFD2 = SQR(alphaABFD2u ^ 2 + alphaABFD2v ^ 2)

magalphaBCDE1 = SQR(alphaBCDE1u ^ 2 + alphaBCDE1v ^ 2)
magalphaBCDE2 = SQR(alphaBCDE2u ^ 2 + alphaBCDE2v ^ 2)
magalphaBCEF1 = SQR(alphaBCEF1u ^ 2 + alphaBCEF1v ^ 2)
magalphaBCEF2 = SQR(alphaBCEF2u ^ 2 + alphaBCEF2v ^ 2)
magalphaBCFD1 = SQR(alphaBCFD1u ^ 2 + alphaBCFD1v ^ 2)
magalphaBCFD2 = SQR(alphaBCFD2u ^ 2 + alphaBCFD2v ^ 2)

magalphaCADE1 = SQR(alphaCADE1u ^ 2 + alphaCADE1v ^ 2)
magalphaCADE2 = SQR(alphaCADE2u ^ 2 + alphaCADE2v ^ 2)
magalphaCAEF1 = SQR(alphaCAEF1u ^ 2 + alphaCAEF1v ^ 2)
magalphaCAEF2 = SQR(alphaCAEF2u ^ 2 + alphaCAEF2v ^ 2)
magalphaCAFD1 = SQR(alphaCAFD1u ^ 2 + alphaCAFD1v ^ 2)
magalphaCAFD2 = SQR(alphaCAFD2u ^ 2 + alphaCAFD2v ^ 2)

magalphaDEAB1 = SQR(alphaDEAB1u ^ 2 + alphaDEAB1v ^ 2)
magalphaDEAB2 = SQR(alphaDEAB2u ^ 2 + alphaDEAB2v ^ 2)
magalphaDEBC1 = SQR(alphaDEBC1u ^ 2 + alphaDEBC1v ^ 2)
magalphaDEBC2 = SQR(alphaDEBC2u ^ 2 + alphaDEBC2v ^ 2)
magalphaDECA1 = SQR(alphaDECA1u ^ 2 + alphaDECA1v ^ 2)
magalphaDECA2 = SQR(alphaDECA2u ^ 2 + alphaDECA2v ^ 2)

magalphaEFAB1 = SQR(alphaEFAB1u ^ 2 + alphaEFAB1v ^ 2)
magalphaEFAB2 = SQR(alphaEFAB2u ^ 2 + alphaEFAB2v ^ 2)
magalphaEFBC1 = SQR(alphaEFBC1u ^ 2 + alphaEFBC1v ^ 2)
magalphaEFBC2 = SQR(alphaEFBC2u ^ 2 + alphaEFBC2v ^ 2)
magalphaEFCA1 = SQR(alphaEFCA1u ^ 2 + alphaEFCA1v ^ 2)
magalphaEFCA2 = SQR(alphaEFCA2u ^ 2 + alphaEFCA2v ^ 2)

magalphaFDAB1 = SQR(alphaFDAB1u ^ 2 + alphaFDAB1v ^ 2)
magalphaFDAB2 = SQR(alphaFDAB2u ^ 2 + alphaFDAB2v ^ 2)
magalphaFDBC1 = SQR(alphaFDBC1u ^ 2 + alphaFDBC1v ^ 2)
magalphaFDBC2 = SQR(alphaFDBC2u ^ 2 + alphaFDBC2v ^ 2)
magalphaFDCA1 = SQR(alphaFDCA1u ^ 2 + alphaFDCA1v ^ 2)
magalphaFDCA2 = SQR(alphaFDCA2u ^ 2 + alphaFDCA2v ^ 2)

' Determine and store the mutual intersection points of triplets ABD and DEF.

intABDE = -1
intBCDE = -1
intCADE = -1
intABEF = -1
intBCEF = -1
intCAEF = -1
intABFD = -1
intBCFD = -1
intCAFD = -1
pcounttripletintpointpair = 0

IF magalphaABDE1 - magtripletABps < 0 AND magalphaABDE2 - magtripletABps < 0 AND magalphaDEAB1 - magtripletDEps < 0 AND magalphaDEAB2 - magtripletDEps < 0 THEN
    qAB1u = (Asu - alphaABDE1u) / fovd
    numerator = qAB1u * An - Au
    denominator = Bu - Au + qAB1u * (An - Bn)
    betaABDE = numerator / denominator
    qDE1u = (Dsu - alphaDEAB1u) / fovd
    numerator = qDE1u * Dn - Du
    denominator = Eu - Du + qDE1u * (Dn - En)
    betaDEAB = numerator / denominator
    intABDE = 1
    pcounttripletintpointpair = pcounttripletintpointpair + 1
    tripletintpointpair(pcounttripletintpointpair, 1) = Ax * (1 - betaABDE) + betaABDE * Bx
    tripletintpointpair(pcounttripletintpointpair, 2) = Ay * (1 - betaABDE) + betaABDE * By
    tripletintpointpair(pcounttripletintpointpair, 3) = Az * (1 - betaABDE) + betaABDE * Bz
    tripletintpointpair(pcounttripletintpointpair, 4) = Dx * (1 - betaDEAB) + betaDEAB * Ex
    tripletintpointpair(pcounttripletintpointpair, 5) = Dy * (1 - betaDEAB) + betaDEAB * Ey
    tripletintpointpair(pcounttripletintpointpair, 6) = Dz * (1 - betaDEAB) + betaDEAB * Ez
    tripletintpointpair(pcounttripletintpointpair, 7) = Cx
    tripletintpointpair(pcounttripletintpointpair, 8) = Cy
    tripletintpointpair(pcounttripletintpointpair, 9) = Cz
    tripletintpointpair(pcounttripletintpointpair, 10) = Ax
    tripletintpointpair(pcounttripletintpointpair, 11) = Ay
    tripletintpointpair(pcounttripletintpointpair, 12) = Az
    tripletintpointpair(pcounttripletintpointpair, 13) = Bx
    tripletintpointpair(pcounttripletintpointpair, 14) = By
    tripletintpointpair(pcounttripletintpointpair, 15) = Bz
    tripletintpointpair(pcounttripletintpointpair, 16) = Dx
    tripletintpointpair(pcounttripletintpointpair, 17) = Dy
    tripletintpointpair(pcounttripletintpointpair, 18) = Dz
    tripletintpointpair(pcounttripletintpointpair, 19) = Ex
    tripletintpointpair(pcounttripletintpointpair, 20) = Ey
    tripletintpointpair(pcounttripletintpointpair, 21) = Ez
ELSE
    intABDE = 0
END IF

IF magalphaBCDE1 - magtripletBCps < 0 AND magalphaBCDE2 - magtripletBCps < 0 AND magalphaDEBC1 - magtripletDEps < 0 AND magalphaDEBC2 - magtripletDEps < 0 THEN
    qBC1u = (Bsu - alphaBCDE1u) / fovd
    numerator = qBC1u * Bn - Bu
    denominator = Cu - Bu + qBC1u * (Bn - Cn)
    betaBCDE = numerator / denominator
    qDE1u = (Dsu - alphaDEBC1u) / fovd
    numerator = qDE1u * Dn - Du
    denominator = Eu - Du + qDE1u * (Dn - En)
    betaDEBC = numerator / denominator
    intBCDE = 1
    pcounttripletintpointpair = pcounttripletintpointpair + 1
    tripletintpointpair(pcounttripletintpointpair, 1) = Bx * (1 - betaBCDE) + betaBCDE * Cx
    tripletintpointpair(pcounttripletintpointpair, 2) = By * (1 - betaBCDE) + betaBCDE * Cy
    tripletintpointpair(pcounttripletintpointpair, 3) = Bz * (1 - betaBCDE) + betaBCDE * Cz
    tripletintpointpair(pcounttripletintpointpair, 4) = Dx * (1 - betaDEBC) + betaDEBC * Ex
    tripletintpointpair(pcounttripletintpointpair, 5) = Dy * (1 - betaDEBC) + betaDEBC * Ey
    tripletintpointpair(pcounttripletintpointpair, 6) = Dz * (1 - betaDEBC) + betaDEBC * Ez
    tripletintpointpair(pcounttripletintpointpair, 7) = Ax
    tripletintpointpair(pcounttripletintpointpair, 8) = Ay
    tripletintpointpair(pcounttripletintpointpair, 9) = Az
    tripletintpointpair(pcounttripletintpointpair, 10) = Bx
    tripletintpointpair(pcounttripletintpointpair, 11) = By
    tripletintpointpair(pcounttripletintpointpair, 12) = Bz
    tripletintpointpair(pcounttripletintpointpair, 13) = Cx
    tripletintpointpair(pcounttripletintpointpair, 14) = Cy
    tripletintpointpair(pcounttripletintpointpair, 15) = Cz
    tripletintpointpair(pcounttripletintpointpair, 16) = Dx
    tripletintpointpair(pcounttripletintpointpair, 17) = Dy
    tripletintpointpair(pcounttripletintpointpair, 18) = Dz
    tripletintpointpair(pcounttripletintpointpair, 19) = Ex
    tripletintpointpair(pcounttripletintpointpair, 20) = Ey
    tripletintpointpair(pcounttripletintpointpair, 21) = Ez
ELSE
    intBCDE = 0
END IF

IF magalphaCADE1 - magtripletCAps < 0 AND magalphaCADE2 - magtripletCAps < 0 AND magalphaDECA1 - magtripletDEps < 0 AND magalphaDECA2 - magtripletDEps < 0 THEN
    qCA1u = (Csu - alphaCADE1u) / fovd
    numerator = qCA1u * Cn - Cu
    denominator = Au - Cu + qCA1u * (Cn - An)
    betaCADE = numerator / denominator
    qDE1u = (Dsu - alphaDECA1u) / fovd
    numerator = qDE1u * Dn - Du
    denominator = Eu - Du + qDE1u * (Dn - En)
    betaDECA = numerator / denominator
    intCADE = 1
    pcounttripletintpointpair = pcounttripletintpointpair + 1
    tripletintpointpair(pcounttripletintpointpair, 1) = Cx * (1 - betaCADE) + betaCADE * Ax
    tripletintpointpair(pcounttripletintpointpair, 2) = Cy * (1 - betaCADE) + betaCADE * Ay
    tripletintpointpair(pcounttripletintpointpair, 3) = Cz * (1 - betaCADE) + betaCADE * Az
    tripletintpointpair(pcounttripletintpointpair, 4) = Dx * (1 - betaDECA) + betaDECA * Ex
    tripletintpointpair(pcounttripletintpointpair, 5) = Dy * (1 - betaDECA) + betaDECA * Ey
    tripletintpointpair(pcounttripletintpointpair, 6) = Dz * (1 - betaDECA) + betaDECA * Ez
    tripletintpointpair(pcounttripletintpointpair, 7) = Bx
    tripletintpointpair(pcounttripletintpointpair, 8) = By
    tripletintpointpair(pcounttripletintpointpair, 9) = Bz
    tripletintpointpair(pcounttripletintpointpair, 10) = Cx
    tripletintpointpair(pcounttripletintpointpair, 11) = Cy
    tripletintpointpair(pcounttripletintpointpair, 12) = Cz
    tripletintpointpair(pcounttripletintpointpair, 13) = Ax
    tripletintpointpair(pcounttripletintpointpair, 14) = Ay
    tripletintpointpair(pcounttripletintpointpair, 15) = Az
    tripletintpointpair(pcounttripletintpointpair, 16) = Dx
    tripletintpointpair(pcounttripletintpointpair, 17) = Dy
    tripletintpointpair(pcounttripletintpointpair, 18) = Dz
    tripletintpointpair(pcounttripletintpointpair, 19) = Ex
    tripletintpointpair(pcounttripletintpointpair, 20) = Ey
    tripletintpointpair(pcounttripletintpointpair, 21) = Ez
ELSE
    intCADE = 0
END IF

IF magalphaABEF1 - magtripletABps < 0 AND magalphaABEF2 - magtripletABps < 0 AND magalphaEFAB1 - magtripletEFps < 0 AND magalphaEFAB2 - magtripletEFps < 0 THEN
    qAB1u = (Asu - alphaABEF1u) / fovd
    numerator = qAB1u * An - Au
    denominator = Bu - Au + qAB1u * (An - Bn)
    betaABEF = numerator / denominator
    qEF1u = (Esu - alphaEFAB1u) / fovd
    numerator = qEF1u * En - Eu
    denominator = Fu - Eu + qEF1u * (En - Fn)
    betaEFAB = numerator / denominator
    intABEF = 1
    pcounttripletintpointpair = pcounttripletintpointpair + 1
    tripletintpointpair(pcounttripletintpointpair, 1) = Ax * (1 - betaABEF) + betaABEF * Bx
    tripletintpointpair(pcounttripletintpointpair, 2) = Ay * (1 - betaABEF) + betaABEF * By
    tripletintpointpair(pcounttripletintpointpair, 3) = Az * (1 - betaABEF) + betaABEF * Bz
    tripletintpointpair(pcounttripletintpointpair, 4) = Ex * (1 - betaEFAB) + betaEFAB * Fx
    tripletintpointpair(pcounttripletintpointpair, 5) = Ey * (1 - betaEFAB) + betaEFAB * Fy
    tripletintpointpair(pcounttripletintpointpair, 6) = Ez * (1 - betaEFAB) + betaEFAB * Fz
    tripletintpointpair(pcounttripletintpointpair, 7) = Cx
    tripletintpointpair(pcounttripletintpointpair, 8) = Cy
    tripletintpointpair(pcounttripletintpointpair, 9) = Cz
    tripletintpointpair(pcounttripletintpointpair, 10) = Ax
    tripletintpointpair(pcounttripletintpointpair, 11) = Ay
    tripletintpointpair(pcounttripletintpointpair, 12) = Az
    tripletintpointpair(pcounttripletintpointpair, 13) = Bx
    tripletintpointpair(pcounttripletintpointpair, 14) = By
    tripletintpointpair(pcounttripletintpointpair, 15) = Bz
    tripletintpointpair(pcounttripletintpointpair, 16) = Ex
    tripletintpointpair(pcounttripletintpointpair, 17) = Ey
    tripletintpointpair(pcounttripletintpointpair, 18) = Ez
    tripletintpointpair(pcounttripletintpointpair, 19) = Fx
    tripletintpointpair(pcounttripletintpointpair, 20) = Fy
    tripletintpointpair(pcounttripletintpointpair, 21) = Fz
ELSE
    intABEF = 0
END IF

IF magalphaBCEF1 - magtripletBCps < 0 AND magalphaBCEF2 - magtripletBCps < 0 AND magalphaEFBC1 - magtripletEFps < 0 AND magalphaEFBC2 - magtripletEFps < 0 THEN
    qBC1u = (Bsu - alphaBCEF1u) / fovd
    numerator = qBC1u * Bn - Bu
    denominator = Cu - Bu + qBC1u * (Bn - Cn)
    betaBCEF = numerator / denominator
    qEF1u = (Esu - alphaEFBC1u) / fovd
    numerator = qEF1u * En - Eu
    denominator = Fu - Eu + qEF1u * (En - Fn)
    betaEFBC = numerator / denominator
    intBCEF = 1
    pcounttripletintpointpair = pcounttripletintpointpair + 1
    tripletintpointpair(pcounttripletintpointpair, 1) = Bx * (1 - betaBCEF) + betaBCEF * Cx
    tripletintpointpair(pcounttripletintpointpair, 2) = By * (1 - betaBCEF) + betaBCEF * Cy
    tripletintpointpair(pcounttripletintpointpair, 3) = Bz * (1 - betaBCEF) + betaBCEF * Cz
    tripletintpointpair(pcounttripletintpointpair, 4) = Ex * (1 - betaEFBC) + betaEFBC * Fx
    tripletintpointpair(pcounttripletintpointpair, 5) = Ey * (1 - betaEFBC) + betaEFBC * Fy
    tripletintpointpair(pcounttripletintpointpair, 6) = Ez * (1 - betaEFBC) + betaEFBC * Fz
    tripletintpointpair(pcounttripletintpointpair, 7) = Ax
    tripletintpointpair(pcounttripletintpointpair, 8) = Ay
    tripletintpointpair(pcounttripletintpointpair, 9) = Az
    tripletintpointpair(pcounttripletintpointpair, 10) = Bx
    tripletintpointpair(pcounttripletintpointpair, 11) = By
    tripletintpointpair(pcounttripletintpointpair, 12) = Bz
    tripletintpointpair(pcounttripletintpointpair, 13) = Cx
    tripletintpointpair(pcounttripletintpointpair, 14) = Cy
    tripletintpointpair(pcounttripletintpointpair, 15) = Cz
    tripletintpointpair(pcounttripletintpointpair, 16) = Ex
    tripletintpointpair(pcounttripletintpointpair, 17) = Ey
    tripletintpointpair(pcounttripletintpointpair, 18) = Ez
    tripletintpointpair(pcounttripletintpointpair, 19) = Fx
    tripletintpointpair(pcounttripletintpointpair, 20) = Fy
    tripletintpointpair(pcounttripletintpointpair, 21) = Fz
ELSE
    intBCEF = 0
END IF

IF magalphaCAEF1 - magtripletCAps < 0 AND magalphaCAEF2 - magtripletCAps < 0 AND magalphaEFCA1 - magtripletEFps < 0 AND magalphaEFCA2 - magtripletEFps < 0 THEN
    qCA1u = (Csu - alphaCAEF1u) / fovd
    numerator = qCA1u * Cn - Cu
    denominator = Au - Cu + qCA1u * (Cn - An)
    betaCAEF = numerator / denominator
    qEF1u = (Esu - alphaEFCA1u) / fovd
    numerator = qEF1u * En - Eu
    denominator = Fu - Eu + qEF1u * (En - Fn)
    betaEFCA = numerator / denominator
    intCAEF = 1
    pcounttripletintpointpair = pcounttripletintpointpair + 1
    tripletintpointpair(pcounttripletintpointpair, 1) = Cx * (1 - betaCAEF) + betaCAEF * Ax
    tripletintpointpair(pcounttripletintpointpair, 2) = Cy * (1 - betaCAEF) + betaCAEF * Ay
    tripletintpointpair(pcounttripletintpointpair, 3) = Cz * (1 - betaCAEF) + betaCAEF * Az
    tripletintpointpair(pcounttripletintpointpair, 4) = Ex * (1 - betaEFCA) + betaEFCA * Fx
    tripletintpointpair(pcounttripletintpointpair, 5) = Ey * (1 - betaEFCA) + betaEFCA * Fy
    tripletintpointpair(pcounttripletintpointpair, 6) = Ez * (1 - betaEFCA) + betaEFCA * Fz
    tripletintpointpair(pcounttripletintpointpair, 7) = Bx
    tripletintpointpair(pcounttripletintpointpair, 8) = By
    tripletintpointpair(pcounttripletintpointpair, 9) = Bz
    tripletintpointpair(pcounttripletintpointpair, 10) = Cx
    tripletintpointpair(pcounttripletintpointpair, 11) = Cy
    tripletintpointpair(pcounttripletintpointpair, 12) = Cz
    tripletintpointpair(pcounttripletintpointpair, 13) = Ax
    tripletintpointpair(pcounttripletintpointpair, 14) = Ay
    tripletintpointpair(pcounttripletintpointpair, 15) = Az
    tripletintpointpair(pcounttripletintpointpair, 16) = Ex
    tripletintpointpair(pcounttripletintpointpair, 17) = Ey
    tripletintpointpair(pcounttripletintpointpair, 18) = Ez
    tripletintpointpair(pcounttripletintpointpair, 19) = Fx
    tripletintpointpair(pcounttripletintpointpair, 20) = Fy
    tripletintpointpair(pcounttripletintpointpair, 21) = Fz
ELSE
    intCAEF = 0
END IF

IF magalphaABFD1 - magtripletABps < 0 AND magalphaABFD2 - magtripletABps < 0 AND magalphaFDAB1 - magtripletFDps < 0 AND magalphaFDAB2 - magtripletFDps < 0 THEN
    qAB1u = (Asu - alphaABFD1u) / fovd
    numerator = qAB1u * An - Au
    denominator = Bu - Au + qAB1u * (An - Bn)
    betaABFD = numerator / denominator
    qFD1u = (Fsu - alphaFDAB1u) / fovd
    numerator = qFD1u * Fn - Fu
    denominator = Du - Fu + qFD1u * (Fn - Dn)
    betaFDAB = numerator / denominator
    intABFD = 1
    pcounttripletintpointpair = pcounttripletintpointpair + 1
    tripletintpointpair(pcounttripletintpointpair, 1) = Ax * (1 - betaABFD) + betaABFD * Bx
    tripletintpointpair(pcounttripletintpointpair, 2) = Ay * (1 - betaABFD) + betaABFD * By
    tripletintpointpair(pcounttripletintpointpair, 3) = Az * (1 - betaABFD) + betaABFD * Bz
    tripletintpointpair(pcounttripletintpointpair, 4) = Fx * (1 - betaFDAB) + betaFDAB * Dx
    tripletintpointpair(pcounttripletintpointpair, 5) = Fy * (1 - betaFDAB) + betaFDAB * Dy
    tripletintpointpair(pcounttripletintpointpair, 6) = Fz * (1 - betaFDAB) + betaFDAB * Dz
    tripletintpointpair(pcounttripletintpointpair, 7) = Cx
    tripletintpointpair(pcounttripletintpointpair, 8) = Cy
    tripletintpointpair(pcounttripletintpointpair, 9) = Cz
    tripletintpointpair(pcounttripletintpointpair, 10) = Ax
    tripletintpointpair(pcounttripletintpointpair, 11) = Ay
    tripletintpointpair(pcounttripletintpointpair, 12) = Az
    tripletintpointpair(pcounttripletintpointpair, 13) = Bx
    tripletintpointpair(pcounttripletintpointpair, 14) = By
    tripletintpointpair(pcounttripletintpointpair, 15) = Bz
    tripletintpointpair(pcounttripletintpointpair, 16) = Fx
    tripletintpointpair(pcounttripletintpointpair, 17) = Fy
    tripletintpointpair(pcounttripletintpointpair, 18) = Fz
    tripletintpointpair(pcounttripletintpointpair, 19) = Dx
    tripletintpointpair(pcounttripletintpointpair, 20) = Dy
    tripletintpointpair(pcounttripletintpointpair, 21) = Dz
ELSE
    intABFD = 0
END IF

IF magalphaBCFD1 - magtripletBCps < 0 AND magalphaBCFD2 - magtripletBCps < 0 AND magalphaFDBC1 - magtripletFDps < 0 AND magalphaFDBC2 - magtripletFDps < 0 THEN
    qBC1u = (Bsu - alphaBCFD1u) / fovd
    numerator = qBC1u * Bn - Bu
    denominator = Cu - Bu + qBC1u * (Bn - Cn)
    betaBCFD = numerator / denominator
    qFD1u = (Fsu - alphaFDBC1u) / fovd
    numerator = qFD1u * Fn - Fu
    denominator = Du - Fu + qFD1u * (Fn - Dn)
    betaFDBC = numerator / denominator
    intBCFD = 1
    pcounttripletintpointpair = pcounttripletintpointpair + 1
    tripletintpointpair(pcounttripletintpointpair, 1) = Bx * (1 - betaBCFD) + betaBCFD * Cx
    tripletintpointpair(pcounttripletintpointpair, 2) = By * (1 - betaBCFD) + betaBCFD * Cy
    tripletintpointpair(pcounttripletintpointpair, 3) = Bz * (1 - betaBCFD) + betaBCFD * Cz
    tripletintpointpair(pcounttripletintpointpair, 4) = Fx * (1 - betaFDBC) + betaFDBC * Dx
    tripletintpointpair(pcounttripletintpointpair, 5) = Fy * (1 - betaFDBC) + betaFDBC * Dy
    tripletintpointpair(pcounttripletintpointpair, 6) = Fz * (1 - betaFDBC) + betaFDBC * Dz
    tripletintpointpair(pcounttripletintpointpair, 7) = Ax
    tripletintpointpair(pcounttripletintpointpair, 8) = Ay
    tripletintpointpair(pcounttripletintpointpair, 9) = Az
    tripletintpointpair(pcounttripletintpointpair, 10) = Bx
    tripletintpointpair(pcounttripletintpointpair, 11) = By
    tripletintpointpair(pcounttripletintpointpair, 12) = Bz
    tripletintpointpair(pcounttripletintpointpair, 13) = Cx
    tripletintpointpair(pcounttripletintpointpair, 14) = Cy
    tripletintpointpair(pcounttripletintpointpair, 15) = Cz
    tripletintpointpair(pcounttripletintpointpair, 16) = Fx
    tripletintpointpair(pcounttripletintpointpair, 17) = Fy
    tripletintpointpair(pcounttripletintpointpair, 18) = Fz
    tripletintpointpair(pcounttripletintpointpair, 19) = Dx
    tripletintpointpair(pcounttripletintpointpair, 20) = Dy
    tripletintpointpair(pcounttripletintpointpair, 21) = Dz
ELSE
    intBCFD = 0
END IF

IF magalphaCAFD1 - magtripletCAps < 0 AND magalphaCAFD2 - magtripletCAps < 0 AND magalphaFDCA1 - magtripletFDps < 0 AND magalphaFDCA2 - magtripletFDps < 0 THEN
    qCA1u = (Csu - alphaCAFD1u) / fovd
    numerator = qCA1u * Cn - Cu
    denominator = Au - Cu + qCA1u * (Cn - An)
    betaCAFD = numerator / denominator
    qFD1u = (Fsu - alphaFDCA1u) / fovd
    numerator = qFD1u * Fn - Fu
    denominator = Du - Fu + qFD1u * (Fn - Dn)
    betaFDCA = numerator / denominator
    intCAFD = 1
    pcounttripletintpointpair = pcounttripletintpointpair + 1
    tripletintpointpair(pcounttripletintpointpair, 1) = Cx * (1 - betaCAFD) + betaCAFD * Ax
    tripletintpointpair(pcounttripletintpointpair, 2) = Cy * (1 - betaCAFD) + betaCAFD * Ay
    tripletintpointpair(pcounttripletintpointpair, 3) = Cz * (1 - betaCAFD) + betaCAFD * Az
    tripletintpointpair(pcounttripletintpointpair, 4) = Fx * (1 - betaFDCA) + betaFDCA * Dx
    tripletintpointpair(pcounttripletintpointpair, 5) = Fy * (1 - betaFDCA) + betaFDCA * Dy
    tripletintpointpair(pcounttripletintpointpair, 6) = Fz * (1 - betaFDCA) + betaFDCA * Dz
    tripletintpointpair(pcounttripletintpointpair, 7) = Bx
    tripletintpointpair(pcounttripletintpointpair, 8) = By
    tripletintpointpair(pcounttripletintpointpair, 9) = Bz
    tripletintpointpair(pcounttripletintpointpair, 10) = Cx
    tripletintpointpair(pcounttripletintpointpair, 11) = Cy
    tripletintpointpair(pcounttripletintpointpair, 12) = Cz
    tripletintpointpair(pcounttripletintpointpair, 13) = Ax
    tripletintpointpair(pcounttripletintpointpair, 14) = Ay
    tripletintpointpair(pcounttripletintpointpair, 15) = Az
    tripletintpointpair(pcounttripletintpointpair, 16) = Fx
    tripletintpointpair(pcounttripletintpointpair, 17) = Fy
    tripletintpointpair(pcounttripletintpointpair, 18) = Fz
    tripletintpointpair(pcounttripletintpointpair, 19) = Dx
    tripletintpointpair(pcounttripletintpointpair, 20) = Dy
    tripletintpointpair(pcounttripletintpointpair, 21) = Dz
ELSE
    intCAFD = 0
END IF
RETURN

triplet.image.generate:
flagimagechange = 0

SELECT CASE signaturefull$

    CASE " 0 0 0" '*' 1 of 15
        'LOCATE 1, 1: PRINT signaturefull$

    CASE " 0 0 4" '*' 2 of 15
        ' Load information on overlap triangle.
        int1ABCx = tripletintpointpair(1, 1)
        int1ABCy = tripletintpointpair(1, 2)
        int1ABCz = tripletintpointpair(1, 3)
        int1DEFx = tripletintpointpair(1, 4)
        int1DEFy = tripletintpointpair(1, 5)
        int1DEFz = tripletintpointpair(1, 6)
        int2ABCx = tripletintpointpair(2, 1)
        int2ABCy = tripletintpointpair(2, 2)
        int2ABCz = tripletintpointpair(2, 3)
        int2DEFx = tripletintpointpair(2, 4)
        int2DEFy = tripletintpointpair(2, 5)
        int2DEFz = tripletintpointpair(2, 6)
        int3ABCx = tripletintpointpair(3, 1)
        int3ABCy = tripletintpointpair(3, 2)
        int3ABCz = tripletintpointpair(3, 3)
        int3DEFx = tripletintpointpair(3, 4)
        int3DEFy = tripletintpointpair(3, 5)
        int3DEFz = tripletintpointpair(3, 6)
        GOSUB perform.overlap.calculations
        ' Compare the apparent overlap tringles using centroid.
        IF magcentABC > magcentDEF AND magdiff > 0 AND areaABC > 0.005 AND areaDEF > 0.005 AND snip004enabled = 1 THEN
            'LOCATE 2, 1: PRINT signaturefull$
            flagimagechange = 1
            ' Classify the two outer points of ABC.
            outerpoint1x = tripletintpointpair(1, 7)
            outerpoint1y = tripletintpointpair(1, 8)
            outerpoint1z = tripletintpointpair(1, 9)
            possibleoutpoint2x = tripletintpointpair(2, 7)
            possibleoutpoint2y = tripletintpointpair(2, 8)
            possibleoutpoint2z = tripletintpointpair(2, 9)
            possibleoutpoint3x = tripletintpointpair(3, 7)
            possibleoutpoint3y = tripletintpointpair(3, 8)
            possibleoutpoint3z = tripletintpointpair(3, 9)
            '*'possibleoutpoint4x = tripletintpointpair(4, 7)
            '*'possibleoutpoint4y = tripletintpointpair(4, 8)
            '*'possibleoutpoint4z = tripletintpointpair(4, 9)
            IF SQR((outerpoint1x - possibleoutpoint2x) ^ 2 + (outerpoint1y - possibleoutpoint2y) ^ 2 + (outerpoint1z - possibleoutpoint2z) ^ 2) < 0.0001 THEN
                outerpoint2x = possibleoutpoint3x
                outerpoint2y = possibleoutpoint3y
                outerpoint2z = possibleoutpoint3z
            ELSE
                outerpoint2x = possibleoutpoint2x
                outerpoint2y = possibleoutpoint2y
                outerpoint2z = possibleoutpoint2z
            END IF
            ' Classify the lonely point of ABC.
            possibleinpoint1x = tripletintpointpair(1, 10)
            possibleinpoint1y = tripletintpointpair(1, 11)
            possibleinpoint1z = tripletintpointpair(1, 12)
            possibleinpoint2x = tripletintpointpair(1, 13)
            possibleinpoint2y = tripletintpointpair(1, 14)
            possibleinpoint2z = tripletintpointpair(1, 15)
            IF SQR((possibleinpoint1x - outerpoint1x) ^ 2 + (possibleinpoint1y - outerpoint1y) ^ 2 + (possibleinpoint1z - outerpoint1z) ^ 2) > 0.1 AND SQR((possibleinpoint1x - outerpoint2x) ^ 2 + (possibleinpoint1y - outerpoint2y) ^ 2 + (possibleinpoint1z - outerpoint2z) ^ 2) > 0.1 THEN
                innerpointx = possibleinpoint1x
                innerpointy = possibleinpoint1y
                innerpointz = possibleinpoint1z
            ELSE
                innerpointx = possibleinpoint2x
                innerpointy = possibleinpoint2y
                innerpointz = possibleinpoint2z
            END IF
            ' Determine the closest and furthest int points on each int line for lonely point.
            test1pointx = tripletintpointpair(1, 1)
            test1pointy = tripletintpointpair(1, 2)
            test1pointz = tripletintpointpair(1, 3)
            test1pointuninvolvedx = tripletintpointpair(1, 7)
            test1pointuninvolvedy = tripletintpointpair(1, 8)
            test1pointuninvolvedz = tripletintpointpair(1, 9)
            disttotest1point = SQR((innerpointx - test1pointx) ^ 2 + (innerpointy - test1pointy) ^ 2 + (innerpointz - test1pointz) ^ 2)
            disttotest1pointuninvolved = SQR((innerpointx - test1pointuninvolvedx) ^ 2 + (innerpointy - test1pointuninvolvedy) ^ 2 + (innerpointz - test1pointuninvolvedz) ^ 2)
            test2pointx = tripletintpointpair(2, 1)
            test2pointy = tripletintpointpair(2, 2)
            test2pointz = tripletintpointpair(2, 3)
            test2pointuninvolvedx = tripletintpointpair(2, 7)
            test2pointuninvolvedy = tripletintpointpair(2, 8)
            test2pointuninvolvedz = tripletintpointpair(2, 9)
            disttotest2point = SQR((innerpointx - test2pointx) ^ 2 + (innerpointy - test2pointy) ^ 2 + (innerpointz - test2pointz) ^ 2)
            disttotest2pointuninvolved = SQR((innerpointx - test2pointuninvolvedx) ^ 2 + (innerpointy - test2pointuninvolvedy) ^ 2 + (innerpointz - test2pointuninvolvedz) ^ 2)
            test3pointx = tripletintpointpair(3, 1)
            test3pointy = tripletintpointpair(3, 2)
            test3pointz = tripletintpointpair(3, 3)
            test3pointuninvolvedx = tripletintpointpair(3, 7)
            test3pointuninvolvedy = tripletintpointpair(3, 8)
            test3pointuninvolvedz = tripletintpointpair(3, 9)
            disttotest3point = SQR((innerpointx - test3pointx) ^ 2 + (innerpointy - test3pointy) ^ 2 + (innerpointz - test3pointz) ^ 2)
            disttotest3pointuninvolved = SQR((innerpointx - test3pointuninvolvedx) ^ 2 + (innerpointy - test3pointuninvolvedy) ^ 2 + (innerpointz - test3pointuninvolvedz) ^ 2)
            test4pointx = tripletintpointpair(4, 1)
            test4pointy = tripletintpointpair(4, 2)
            test4pointz = tripletintpointpair(4, 3)
            test4pointuninvolvedx = tripletintpointpair(4, 7)
            test4pointuninvolvedy = tripletintpointpair(4, 8)
            test4pointuninvolvedz = tripletintpointpair(4, 9)
            disttotest4point = SQR((innerpointx - test4pointx) ^ 2 + (innerpointy - test4pointy) ^ 2 + (innerpointz - test4pointz) ^ 2)
            disttotest4pointuninvolved = SQR((innerpointx - test4pointuninvolvedx) ^ 2 + (innerpointy - test4pointuninvolvedy) ^ 2 + (innerpointz - test4pointuninvolvedz) ^ 2)
            testpoint1used = 0
            testpoint2used = 0
            testpoint3used = 0
            testpoint4used = 0
            IF SQR((disttotest1pointuninvolved - disttotest2pointuninvolved) ^ 2) < 0.0001 THEN
                testpoint1used = 1
                testpoint2used = 1
                IF disttotest1point < disttotest2point THEN
                    firsttriangleleftx = test1pointx
                    firsttrianglelefty = test1pointy
                    firsttriangleleftz = test1pointz
                    firstfurtherpointx = test2pointx
                    firstfurtherpointy = test2pointy
                    firstfurtherpointz = test2pointz
                ELSE
                    firsttriangleleftx = test2pointx
                    firsttrianglelefty = test2pointy
                    firsttriangleleftz = test2pointz
                    firstfurtherpointx = test1pointx
                    firstfurtherpointy = test1pointy
                    firstfurtherpointz = test1pointz
                END IF
            END IF
            IF SQR((disttotest1pointuninvolved - disttotest3pointuninvolved) ^ 2) < 0.0001 THEN
                testpoint1used = 1
                testpoint3used = 1
                IF disttotest1point < disttotest3point THEN
                    firsttriangleleftx = test1pointx
                    firsttrianglelefty = test1pointy
                    firsttriangleleftz = test1pointz
                    firstfurtherpointx = test3pointx
                    firstfurtherpointy = test3pointy
                    firstfurtherpointz = test3pointz
                ELSE
                    firsttriangleleftx = test3pointx
                    firsttrianglelefty = test3pointy
                    firsttriangleleftz = test3pointz
                    firstfurtherpointx = test1pointx
                    firstfurtherpointy = test1pointy
                    firstfurtherpointz = test1pointz
                END IF
            END IF
            IF SQR((disttotest1pointuninvolved - disttotest4pointuninvolved) ^ 2) < 0.0001 THEN
                testpoint1used = 1
                testpoint4used = 1
                IF disttotest1point < disttotest4point THEN
                    firsttriangleleftx = test1pointx
                    firsttrianglelefty = test1pointy
                    firsttriangleleftz = test1pointz
                    firstfurtherpointx = test4pointx
                    firstfurtherpointy = test4pointy
                    firstfurtherpointz = test4pointz
                ELSE
                    firsttriangleleftx = test4pointx
                    firsttrianglelefty = test4pointy
                    firsttriangleleftz = test4pointz
                    firstfurtherpointx = test1pointx
                    firstfurtherpointy = test1pointy
                    firstfurtherpointz = test1pointz
                END IF
            END IF
            IF testpoint2used = 0 AND testpoint3used = 0 THEN
                IF disttotest2point < disttotest3point THEN
                    firsttrianglerightx = test2pointx
                    firsttrianglerighty = test2pointy
                    firsttrianglerightz = test2pointz
                    secondfurtherpointx = test3pointx
                    secondfurtherpointy = test3pointy
                    secondfurtherpointz = test3pointz
                ELSE
                    firsttrianglerightx = test3pointx
                    firsttrianglerighty = test3pointy
                    firsttrianglerightz = test3pointz
                    secondfurtherpointx = test2pointx
                    secondfurtherpointy = test2pointy
                    secondfurtherpointz = test2pointz
                END IF
            END IF
            IF testpoint3used = 0 AND testpoint4used = 0 THEN
                IF disttotest3point < disttotest4point THEN
                    firsttrianglerightx = test3pointx
                    firsttrianglerighty = test3pointy
                    firsttrianglerightz = test3pointz
                    secondfurtherpointx = test4pointx
                    secondfurtherpointy = test4pointy
                    secondfurtherpointz = test4pointz
                ELSE
                    firsttrianglerightx = test4pointx
                    firsttrianglerighty = test4pointy
                    firsttrianglerightz = test4pointz
                    secondfurtherpointx = test3pointx
                    secondfurtherpointy = test3pointy
                    secondfurtherpointz = test3pointz
                END IF
            END IF
            IF testpoint4used = 0 AND testpoint2used = 0 THEN
                IF disttotest4point < disttotest2point THEN
                    firsttrianglerightx = test4pointx
                    firsttrianglerighty = test4pointy
                    firsttrianglerightz = test4pointz
                    secondfurtherpointx = test2pointx
                    secondfurtherpointy = test2pointy
                    secondfurtherpointz = test2pointz
                ELSE
                    firsttrianglerightx = test2pointx
                    firsttrianglerighty = test2pointy
                    firsttrianglerightz = test2pointz
                    secondfurtherpointx = test4pointx
                    secondfurtherpointy = test4pointy
                    secondfurtherpointz = test4pointz
                END IF
            END IF
            flagindexkused = 0
            ' First new triangle overwrites old one.
            basepointx = innerpointx
            basepointy = innerpointy
            basepointz = innerpointz
            rightpointx = firsttrianglerightx
            rightpointy = firsttrianglerighty
            rightpointz = firsttrianglerightz
            leftpointx = firsttriangleleftx
            leftpointy = firsttrianglelefty
            leftpointz = firsttriangleleftz
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
            ' Second new triangle.
            basepointx = firstfurtherpointx
            basepointy = firstfurtherpointy
            basepointz = firstfurtherpointz
            rightpointx = secondfurtherpointx
            rightpointy = secondfurtherpointy
            rightpointz = secondfurtherpointz
            leftpointx = outerpoint1x
            leftpointy = outerpoint1y
            leftpointz = outerpoint1z
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
            ' Third new triangle.
            basepointx = firstfurtherpointx
            basepointy = firstfurtherpointy
            basepointz = firstfurtherpointz
            rightpointx = outerpoint1x
            rightpointy = outerpoint1y
            rightpointz = outerpoint1z
            leftpointx = outerpoint2x
            leftpointy = outerpoint2y
            leftpointz = outerpoint2z
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
        END IF
        IF flagimagechange = 1 THEN
            IF flagindexkused = 1 THEN
                GOTO begintripletsnipsubloop
            ELSE
                GOSUB triplet.image.repack
            END IF
        END IF

    CASE " 0 3 0" '*' 3 of 15
        ' Load information on overlap triangle.
        int3ABCx = tripletencpoint(1, 1)
        int3ABCy = tripletencpoint(1, 2)
        int3ABCz = tripletencpoint(1, 3)
        int3DEFx = tripletencpoint(1, 4)
        int3DEFy = tripletencpoint(1, 5)
        int3DEFz = tripletencpoint(1, 6)
        int1ABCx = tripletencpoint(2, 1)
        int1ABCy = tripletencpoint(2, 2)
        int1ABCz = tripletencpoint(2, 3)
        int1DEFx = tripletencpoint(2, 4)
        int1DEFy = tripletencpoint(2, 5)
        int1DEFz = tripletencpoint(3, 6)
        int2ABCx = tripletencpoint(3, 1)
        int2ABCy = tripletencpoint(3, 2)
        int2ABCz = tripletencpoint(3, 3)
        int2DEFx = tripletencpoint(3, 4)
        int2DEFy = tripletencpoint(3, 5)
        int2DEFz = tripletencpoint(3, 6)
        GOSUB perform.overlap.calculations
        ' Compare the apparent overlap tringles using centroid.
        IF magcentABC > magcentDEF AND snip030enabled = 1 THEN
            'IF magcentABC > magcentDEF AND magdiff > 0 AND areaABC > 0 AND areaDEF > 0 AND snip030enabled = 1 THEN
            'LOCATE 3, 1: PRINT signaturefull$
            flagimagechange = 1
            flagindexkused = 0
        END IF
        IF flagimagechange = 1 THEN
            IF flagindexkused = 1 THEN

            ELSE
                GOSUB triplet.image.repack
            END IF
        END IF

    CASE " 3 0 0" '*' 4 of 15
        ' Load information on overlap triangle.
        int3ABCx = tripletencpoint(1, 4)
        int3ABCy = tripletencpoint(1, 5)
        int3ABCz = tripletencpoint(1, 6)
        int3DEFx = tripletencpoint(1, 1)
        int3DEFy = tripletencpoint(1, 2)
        int3DEFz = tripletencpoint(1, 3)
        int1ABCx = tripletencpoint(2, 4)
        int1ABCy = tripletencpoint(2, 5)
        int1ABCz = tripletencpoint(2, 6)
        int1DEFx = tripletencpoint(2, 1)
        int1DEFy = tripletencpoint(2, 2)
        int1DEFz = tripletencpoint(2, 3)
        int2ABCx = tripletencpoint(3, 4)
        int2ABCy = tripletencpoint(3, 5)
        int2ABCz = tripletencpoint(3, 6)
        int2DEFx = tripletencpoint(3, 1)
        int2DEFy = tripletencpoint(3, 2)
        int2DEFz = tripletencpoint(3, 3)
        GOSUB perform.overlap.calculations
        ' Compare the apparent overlap tringles using centroid.
        IF magcentABC > magcentDEF AND magdiff > 0 AND areaABC > 0.005 AND areaDEF > 0.005 AND snip300enabled = 1 THEN
            'LOCATE 4, 1: PRINT signaturefull$
            flagimagechange = 1
            centDEFx = (1 / 3) * (tripletencpoint(1, 4) + tripletencpoint(2, 4) + tripletencpoint(3, 4))
            centDEFy = (1 / 3) * (tripletencpoint(1, 5) + tripletencpoint(2, 5) + tripletencpoint(3, 5))
            centDEFz = (1 / 3) * (tripletencpoint(1, 6) + tripletencpoint(2, 6) + tripletencpoint(3, 6))
            flagindexkused = 0
            ' First new triangle overwrites old one.
            basepointx = centDEFx
            basepointy = centDEFy
            basepointz = centDEFz
            rightpointx = Ax
            rightpointy = Ay
            rightpointz = Az
            leftpointx = Bx
            leftpointy = By
            leftpointz = Bz
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
            ' Second new triangle.
            basepointx = centDEFx
            basepointy = centDEFy
            basepointz = centDEFz
            rightpointx = Bx
            rightpointy = By
            rightpointz = Bz
            leftpointx = Cx
            leftpointy = Cy
            leftpointz = Cz
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
            ' Third new triangle.
            basepointx = centDEFx
            basepointy = centDEFy
            basepointz = centDEFz
            rightpointx = Cx
            rightpointy = Cy
            rightpointz = Cz
            leftpointx = Ax
            leftpointy = Ay
            leftpointz = Az
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
        END IF
        IF flagimagechange = 1 THEN
            IF flagindexkused = 1 THEN
                GOTO begintripletsnipsubloop
            ELSE
                GOSUB triplet.image.repack
            END IF
        END IF

    CASE " 0 0 6" '*' 5 of 15
        ' Load information on overlap triangle.
        int3ABCx = tripletintpointpair(3, 1)
        int3ABCy = tripletintpointpair(3, 2)
        int3ABCz = tripletintpointpair(3, 3)
        int3DEFx = tripletintpointpair(3, 4)
        int3DEFy = tripletintpointpair(3, 5)
        int3DEFz = tripletintpointpair(3, 6)
        int1ABCx = tripletintpointpair(1, 1)
        int1ABCy = tripletintpointpair(1, 2)
        int1ABCz = tripletintpointpair(1, 3)
        int1DEFx = tripletintpointpair(1, 4)
        int1DEFy = tripletintpointpair(1, 5)
        int1DEFz = tripletintpointpair(1, 6)
        int2ABCx = tripletintpointpair(2, 1)
        int2ABCy = tripletintpointpair(2, 2)
        int2ABCz = tripletintpointpair(2, 3)
        int2DEFx = tripletintpointpair(2, 4)
        int2DEFy = tripletintpointpair(2, 5)
        int2DEFz = tripletintpointpair(2, 6)
        GOSUB perform.overlap.calculations
        ' Compare the apparent overlap tringles using centroid.
        IF magcentABC > magcentDEF AND magdiff > 0 AND areaABC > 0.005 AND areaDEF > 0.005 AND snip006enabled = 1 THEN
            'LOCATE 5, 1: PRINT signaturefull$
            flagimagechange = 1
            centDEFx = (1 / 3) * (Dx + Ex + Fx) '(tripletencpoint(1, 4) + tripletencpoint(2, 4) + tripletencpoint(3, 4))
            centDEFy = (1 / 3) * (Dy + Ey + Fy) '(tripletencpoint(1, 5) + tripletencpoint(2, 5) + tripletencpoint(3, 5))
            centDEFz = (1 / 3) * (Dz + Ez + Fz) '(tripletencpoint(1, 6) + tripletencpoint(2, 6) + tripletencpoint(3, 6))
            flagindexkused = 0
            ' First new triangle overwrites old one.
            basepointx = centDEFx
            basepointy = centDEFy
            basepointz = centDEFz
            rightpointx = Ax
            rightpointy = Ay
            rightpointz = Az
            leftpointx = Bx
            leftpointy = By
            leftpointz = Bz
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
            ' Second new triangle.
            basepointx = centDEFx
            basepointy = centDEFy
            basepointz = centDEFz
            rightpointx = Bx
            rightpointy = By
            rightpointz = Bz
            leftpointx = Cx
            leftpointy = Cy
            leftpointz = Cz
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
            ' Third new triangle.
            basepointx = centDEFx
            basepointy = centDEFy
            basepointz = centDEFz
            rightpointx = Cx
            rightpointy = Cy
            rightpointz = Cz
            leftpointx = Ax
            leftpointy = Ay
            leftpointz = Az
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
        END IF
        IF flagimagechange = 1 THEN
            IF flagindexkused = 1 THEN
                GOTO begintripletsnipsubloop
            ELSE
                GOSUB triplet.image.repack
            END IF
        END IF

    CASE " 0 1 2" '*' 6 of 15
        ' Load information on overlap triangle.
        int3ABCx = tripletencpoint(1, 1)
        int3ABCy = tripletencpoint(1, 2)
        int3ABCz = tripletencpoint(1, 3)
        int3DEFx = tripletencpoint(1, 4)
        int3DEFy = tripletencpoint(1, 5)
        int3DEFz = tripletencpoint(1, 6)
        int1ABCx = tripletintpointpair(1, 1)
        int1ABCy = tripletintpointpair(1, 2)
        int1ABCz = tripletintpointpair(1, 3)
        int1DEFx = tripletintpointpair(1, 4)
        int1DEFy = tripletintpointpair(1, 5)
        int1DEFz = tripletintpointpair(1, 6)
        int2ABCx = tripletintpointpair(2, 1)
        int2ABCy = tripletintpointpair(2, 2)
        int2ABCz = tripletintpointpair(2, 3)
        int2DEFx = tripletintpointpair(2, 4)
        int2DEFy = tripletintpointpair(2, 5)
        int2DEFz = tripletintpointpair(2, 6)
        GOSUB perform.overlap.calculations
        ' Compare the apparent overlap tringles using centroid.
        IF magcentABC > magcentDEF AND magdiff > 0 AND areaABC > 0.005 AND areaDEF > 0.005 AND snip012enabled = 1 THEN
            'LOCATE 6, 1: PRINT signaturefull$
            flagimagechange = 1
            flagindexkused = 0
            ' First new triangle overwrites old one.
            basepointx = tripletintpointpair(2, 7)
            basepointy = tripletintpointpair(2, 8)
            basepointz = tripletintpointpair(2, 9)
            rightpointx = int1ABCx
            rightpointy = int1ABCy
            rightpointz = int1ABCz
            leftpointx = tripletintpointpair(1, 7)
            leftpointy = tripletintpointpair(1, 8)
            leftpointz = tripletintpointpair(1, 9)
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
            ' Second new triangle.
            basepointx = int2ABCx
            basepointy = int2ABCy
            basepointz = int2ABCz
            rightpointx = tripletintpointpair(1, 7)
            rightpointy = tripletintpointpair(1, 8)
            rightpointz = tripletintpointpair(1, 9)
            leftpointx = int1ABCx
            leftpointy = int1ABCy
            leftpointz = int1ABCz
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
        END IF
        IF flagimagechange = 1 THEN
            IF flagindexkused = 1 THEN
                GOTO begintripletsnipsubloop
            ELSE
                GOSUB triplet.image.repack
            END IF
        END IF

    CASE " 1 0 2" '*' 7 of 15
        ' Load information on overlap triangle.
        int3ABCx = tripletencpoint(1, 4)
        int3ABCy = tripletencpoint(1, 5)
        int3ABCz = tripletencpoint(1, 6)
        int3DEFx = tripletencpoint(1, 1)
        int3DEFy = tripletencpoint(1, 2)
        int3DEFz = tripletencpoint(1, 3)
        int1ABCx = tripletintpointpair(1, 1)
        int1ABCy = tripletintpointpair(1, 2)
        int1ABCz = tripletintpointpair(1, 3)
        int1DEFx = tripletintpointpair(1, 4)
        int1DEFy = tripletintpointpair(1, 5)
        int1DEFz = tripletintpointpair(1, 6)
        int2ABCx = tripletintpointpair(2, 1)
        int2ABCy = tripletintpointpair(2, 2)
        int2ABCz = tripletintpointpair(2, 3)
        int2DEFx = tripletintpointpair(2, 4)
        int2DEFy = tripletintpointpair(2, 5)
        int2DEFz = tripletintpointpair(2, 6)
        GOSUB perform.overlap.calculations
        ' Compare the apparent overlap tringles using centroid.
        IF magcentABC > magcentDEF AND magdiff > 0 AND areaABC > 0.005 AND areaDEF > 0.005 AND snip102enabled = 1 THEN
            'LOCATE 7, 1: PRINT signaturefull$
            flagimagechange = 1
            outerpointx = tripletintpointpair(1, 7)
            outerpointy = tripletintpointpair(1, 8)
            outerpointz = tripletintpointpair(1, 9)
            leftvertpointx = tripletintpointpair(1, 10)
            leftvertpointy = tripletintpointpair(1, 11)
            leftvertpointz = tripletintpointpair(1, 12)
            rightvertpointx = tripletintpointpair(1, 13)
            rightvertpointy = tripletintpointpair(1, 14)
            rightvertpointz = tripletintpointpair(1, 15)
            int1ABCdistleftvertpoint = SQR((leftvertpointx - int1ABCx) ^ 2 + (leftvertpointy - int1ABCy) ^ 2 + (leftvertpointz - int1ABCz) ^ 2)
            '*'int1ABCdistrightvertpoint = SQR((rightvertpointx - int1ABCx) ^ 2 + (rightvertpointy - int1ABCy) ^ 2 + (rightvertpointz - int1ABCz) ^ 2)
            int2ABCdistleftvertpoint = SQR((leftvertpointx - int2ABCx) ^ 2 + (leftvertpointy - int2ABCy) ^ 2 + (leftvertpointz - int2ABCz) ^ 2)
            '*'int2ABCdistrightvertpoint = SQR((rightvertpointx - int2ABCx) ^ 2 + (rightvertpointy - int2ABCy) ^ 2 + (rightvertpointz - int2ABCz) ^ 2)
            IF int1ABCdistleftvertpoint < int2ABCdistleftvertpoint THEN
                intleftclosestx = int1ABCx
                intleftclosesty = int1ABCy
                intleftclosestz = int1ABCz
                intrightclosestx = int2ABCx
                intrightclosesty = int2ABCy
                intrightclosestz = int2ABCz
            ELSE
                intleftclosestx = int2ABCx
                intleftclosesty = int2ABCy
                intleftclosestz = int2ABCz
                intrightclosestx = int1ABCx
                intrightclosesty = int1ABCy
                intrightclosestz = int1ABCz
            END IF
            flagindexkused = 0
            ' First new triangle overwrites old one.
            basepointx = leftvertpointx
            basepointy = leftvertpointy
            basepointz = leftvertpointz
            rightpointx = intleftclosestx
            rightpointy = intleftclosesty
            rightpointz = intleftclosestz
            leftpointx = int3ABCx
            leftpointy = int3ABCy
            leftpointz = int3ABCz
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
            ' Second new triangle.
            basepointx = outerpointx
            basepointy = outerpointy
            basepointz = outerpointz
            rightpointx = leftvertpointx
            rightpointy = leftvertpointy
            rightpointz = leftvertpointz
            leftpointx = int3ABCx
            leftpointy = int3ABCy
            leftpointz = int3ABCz
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
            ' Third new triangle.
            basepointx = outerpointx
            basepointy = outerpointy
            basepointz = outerpointz
            rightpointx = int3ABCx
            rightpointy = int3ABCy
            rightpointz = int3ABCz
            leftpointx = rightvertpointx
            leftpointy = rightvertpointy
            leftpointz = rightvertpointz
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
            ' Fourth new triangle.
            basepointx = rightvertpointx
            basepointy = rightvertpointy
            basepointz = rightvertpointz
            rightpointx = int3ABCx
            rightpointy = int3ABCy
            rightpointz = int3ABCz
            leftpointx = intrightclosestx
            leftpointy = intrightclosesty
            leftpointz = intrightclosestz
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
        END IF
        IF flagimagechange = 1 THEN
            IF flagindexkused = 1 THEN
                GOTO begintripletsnipsubloop
            ELSE
                GOSUB triplet.image.repack
            END IF
        END IF
    CASE " 1 1 2" '*' 8 of 15
        ' Load information on overlap triangle.
        int3ABCx = tripletencpoint(1, 4) '
        int3ABCy = tripletencpoint(1, 5) '
        int3ABCz = tripletencpoint(1, 6) '
        int3DEFx = tripletencpoint(1, 1) '
        int3DEFy = tripletencpoint(1, 2) '
        int3DEFz = tripletencpoint(1, 3) '
        int1ABCx = tripletintpointpair(1, 1)
        int1ABCy = tripletintpointpair(1, 2)
        int1ABCz = tripletintpointpair(1, 3)
        int1DEFx = tripletintpointpair(1, 4)
        int1DEFy = tripletintpointpair(1, 5)
        int1DEFz = tripletintpointpair(1, 6)
        int2ABCx = tripletintpointpair(2, 1)
        int2ABCy = tripletintpointpair(2, 2)
        int2ABCz = tripletintpointpair(2, 3)
        int2DEFx = tripletintpointpair(2, 4)
        int2DEFy = tripletintpointpair(2, 5)
        int2DEFz = tripletintpointpair(2, 6)
        GOSUB perform.overlap.calculations
        ' Compare the apparent overlap tringles using centroid.
        IF magcentABC > magcentDEF AND magdiff > 0 AND areaABC > 0.005 AND areaDEF > 0.005 AND snip112enabled = 1 THEN
            'LOCATE 8, 1: PRINT signaturefull$
            flagimagechange = 1
            flagindexkused = 0
            ' First new triangle overwrites old one.
            basepointx = int3ABCx '
            basepointy = int3ABCy '
            basepointz = int3ABCz '
            rightpointx = int1ABCx
            rightpointy = int1ABCy
            rightpointz = int1ABCz
            leftpointx = tripletintpointpair(2, 7)
            leftpointy = tripletintpointpair(2, 8)
            leftpointz = tripletintpointpair(2, 9)
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
            ' Second new triangle.
            basepointx = int3ABCx '
            basepointy = int3ABCy '
            basepointz = int3ABCz '
            rightpointx = tripletintpointpair(1, 7)
            rightpointy = tripletintpointpair(1, 8)
            rightpointz = tripletintpointpair(1, 9)
            leftpointx = tripletintpointpair(2, 7)
            leftpointy = tripletintpointpair(2, 8)
            leftpointz = tripletintpointpair(2, 9)
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
            ' Third new triangle.
            basepointx = int3ABCx '
            basepointy = int3ABCy '
            basepointz = int3ABCz '
            rightpointx = int2ABCx
            rightpointy = int2ABCy
            rightpointz = int2ABCz
            leftpointx = tripletintpointpair(1, 7)
            leftpointy = tripletintpointpair(1, 8)
            leftpointz = tripletintpointpair(1, 9)
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
        END IF
        IF flagimagechange = 1 THEN
            IF flagindexkused = 1 THEN
                GOTO begintripletsnipsubloop
            ELSE
                GOSUB triplet.image.repack
            END IF
        END IF

    CASE " 0 2 2" '*' 9 of 15
        ' Load information on overlap triangle.
        int3ABCx = tripletencpoint(1, 1)
        int3ABCy = tripletencpoint(1, 2)
        int3ABCz = tripletencpoint(1, 3)
        int3DEFx = tripletencpoint(1, 4)
        int3DEFy = tripletencpoint(1, 5)
        int3DEFz = tripletencpoint(1, 6)
        int1ABCx = tripletintpointpair(1, 1)
        int1ABCy = tripletintpointpair(1, 2)
        int1ABCz = tripletintpointpair(1, 3)
        int1DEFx = tripletintpointpair(1, 4)
        int1DEFy = tripletintpointpair(1, 5)
        int1DEFz = tripletintpointpair(1, 6)
        int2ABCx = tripletintpointpair(2, 1)
        int2ABCy = tripletintpointpair(2, 2)
        int2ABCz = tripletintpointpair(2, 3)
        int2DEFx = tripletintpointpair(2, 4)
        int2DEFy = tripletintpointpair(2, 5)
        int2DEFz = tripletintpointpair(2, 6)
        GOSUB perform.overlap.calculations
        ' Compare the apparent overlap tringles using centroid.
        IF magcentABC > magcentDEF AND magdiff > 0 AND areaABC > 0.005 AND areaDEF > 0.005 AND snip022enabled = 1 THEN
            'LOCATE 9, 1: PRINT signaturefull$
            flagimagechange = 1
            ' Classify the outer point of ABC.
            possibleoutpoint1x = tripletintpointpair(1, 10)
            possibleoutpoint1y = tripletintpointpair(1, 11)
            possibleoutpoint1z = tripletintpointpair(1, 12)
            possibleoutpoint2x = tripletintpointpair(1, 13)
            possibleoutpoint2y = tripletintpointpair(1, 14)
            possibleoutpoint2z = tripletintpointpair(1, 15)
            IF SQR((possibleoutpoint1x - tripletencpoint(1, 1)) ^ 2 + (possibleoutpoint1y - tripletencpoint(1, 2)) ^ 2 + (possibleoutpoint1z - tripletencpoint(1, 3)) ^ 2) > 0.1 AND SQR((possibleoutpoint1x - tripletencpoint(2, 1)) ^ 2 + (possibleoutpoint1y - tripletencpoint(2, 2)) ^ 2 + (possibleoutpoint1z - tripletencpoint(2, 3)) ^ 2) > 0.1 THEN
                outerpointx = possibleoutpoint1x
                outerpointy = possibleoutpoint1y
                outerpointz = possibleoutpoint1z
            ELSE
                outerpointx = possibleoutpoint2x
                outerpointy = possibleoutpoint2y
                outerpointz = possibleoutpoint2z
            END IF
            flagindexkused = 0
            ' First new triangle overwrites old one.
            basepointx = int1ABCx
            basepointy = int1ABCy
            basepointz = int1ABCz
            rightpointx = outerpointx
            rightpointy = outerpointy
            rightpointz = outerpointz
            leftpointx = int2ABCx
            leftpointy = int2ABCy
            leftpointz = int2ABCz
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
        END IF
        IF flagimagechange = 1 THEN
            IF flagindexkused = 1 THEN
                GOTO begintripletsnipsubloop
            ELSE
                GOSUB triplet.image.repack
            END IF
        END IF

    CASE " 2 0 2" '*' 10 of 15
        ' Load information on overlap triangle.
        int3ABCx = tripletencpoint(1, 4)
        int3ABCy = tripletencpoint(1, 5)
        int3ABCz = tripletencpoint(1, 6)
        int3DEFx = tripletencpoint(1, 1)
        int3DEFy = tripletencpoint(1, 2)
        int3DEFz = tripletencpoint(1, 3)
        int1ABCx = tripletintpointpair(1, 1)
        int1ABCy = tripletintpointpair(1, 2)
        int1ABCz = tripletintpointpair(1, 3)
        int1DEFx = tripletintpointpair(1, 4)
        int1DEFy = tripletintpointpair(1, 5)
        int1DEFz = tripletintpointpair(1, 6)
        int2ABCx = tripletintpointpair(2, 1)
        int2ABCy = tripletintpointpair(2, 2)
        int2ABCz = tripletintpointpair(2, 3)
        int2DEFx = tripletintpointpair(2, 4)
        int2DEFy = tripletintpointpair(2, 5)
        int2DEFz = tripletintpointpair(2, 6)
        GOSUB perform.overlap.calculations
        ' Compare the apparent overlap tringles using centroid.
        IF magcentABC > magcentDEF AND magdiff > 0 AND areaABC > 0.005 AND areaDEF > 0.005 AND snip202enabled = 1 THEN
            'LOCATE 10, 1: PRINT signaturefull$
            flagimagechange = 1
            verttopx = tripletintpointpair(1, 7)
            verttopy = tripletintpointpair(1, 8)
            verttopz = tripletintpointpair(1, 9)
            vertleftx = tripletintpointpair(1, 10)
            vertlefty = tripletintpointpair(1, 11)
            vertleftz = tripletintpointpair(1, 12)
            vertrightx = tripletintpointpair(1, 13)
            vertrighty = tripletintpointpair(1, 14)
            vertrightz = tripletintpointpair(1, 15)
            disttointpoint1 = SQR((vertleftx - tripletintpointpair(1, 1)) ^ 2 + (vertlefty - tripletintpointpair(1, 2)) ^ 2 + (vertleftz - tripletintpointpair(1, 3)) ^ 2)
            disttointpoint2 = SQR((vertleftx - tripletintpointpair(2, 1)) ^ 2 + (vertlefty - tripletintpointpair(2, 2)) ^ 2 + (vertleftz - tripletintpointpair(2, 3)) ^ 2)
            IF disttointpoint1 < disttointpoint2 THEN
                intleftx = tripletintpointpair(1, 1)
                intlefty = tripletintpointpair(1, 2)
                intleftz = tripletintpointpair(1, 3)
                intrightx = tripletintpointpair(2, 1)
                intrighty = tripletintpointpair(2, 2)
                intrightz = tripletintpointpair(2, 3)
                candencleft1x = tripletintpointpair(1, 16)
                candencleft1y = tripletintpointpair(1, 17)
                candencleft1z = tripletintpointpair(1, 18)
                candencleft2x = tripletintpointpair(1, 19)
                candencleft2y = tripletintpointpair(1, 20)
                candencleft2z = tripletintpointpair(1, 21)
            ELSE
                intleftx = tripletintpointpair(2, 1)
                intlefty = tripletintpointpair(2, 2)
                intleftz = tripletintpointpair(2, 3)
                intrightx = tripletintpointpair(1, 1)
                intrighty = tripletintpointpair(1, 2)
                intrightz = tripletintpointpair(1, 3)
                candencleft1x = tripletintpointpair(2, 16)
                candencleft1y = tripletintpointpair(2, 17)
                candencleft1z = tripletintpointpair(2, 18)
                candencleft2x = tripletintpointpair(2, 19)
                candencleft2y = tripletintpointpair(2, 20)
                candencleft2z = tripletintpointpair(2, 21)
            END IF
            IF SQR((candencleft1x - tripletencpoint(1, 1)) ^ 2 + (candencleft1y - tripletencpoint(1, 2)) ^ 2 + (candencleft1z - tripletencpoint(1, 3)) ^ 2) < 0.0001 OR SQR((candencleft2x - tripletencpoint(1, 1)) ^ 2 + (candencleft2y - tripletencpoint(1, 2)) ^ 2 + (candencleft2z - tripletencpoint(1, 3)) ^ 2) < 0.0001 THEN
                encpointleftx = tripletencpoint(1, 4)
                encpointlefty = tripletencpoint(1, 5)
                encpointleftz = tripletencpoint(1, 6)
                encpointrightx = tripletencpoint(2, 4)
                encpointrighty = tripletencpoint(2, 5)
                encpointrightz = tripletencpoint(2, 6)
            ELSE
                encpointleftx = tripletencpoint(2, 4)
                encpointlefty = tripletencpoint(2, 5)
                encpointleftz = tripletencpoint(2, 6)
                encpointrightx = tripletencpoint(1, 4)
                encpointrighty = tripletencpoint(1, 5)
                encpointrightz = tripletencpoint(1, 6)
            END IF
            flagindexkused = 0
            ' First new triangle overwrites old one.
            basepointx = intleftx
            basepointy = intlefty
            basepointz = intleftz
            rightpointx = encpointleftx
            rightpointy = encpointlefty
            rightpointz = encpointleftz
            leftpointx = vertleftx
            leftpointy = vertlefty
            leftpointz = vertleftz
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
            ' Second new triangle.
            basepointx = encpointleftx
            basepointy = encpointlefty
            basepointz = encpointleftz
            rightpointx = verttopx
            rightpointy = verttopy
            rightpointz = verttopz
            leftpointx = vertleftx
            leftpointy = vertlefty
            leftpointz = vertleftz
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
            ' Third new triangle.
            basepointx = encpointrightx
            basepointy = encpointrighty
            basepointz = encpointrightz
            rightpointx = verttopx
            rightpointy = verttopy
            rightpointz = verttopz
            leftpointx = encpointleftx
            leftpointy = encpointlefty
            leftpointz = encpointleftz
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
            ' Fourth new triangle.
            basepointx = vertrightx
            basepointy = vertrighty
            basepointz = vertrightz
            rightpointx = verttopx
            rightpointy = verttopy
            rightpointz = verttopz
            leftpointx = encpointrightx
            leftpointy = encpointrighty
            leftpointz = encpointrightz
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
            ' Fifth new triangle.
            basepointx = vertrightx
            basepointy = vertrighty
            basepointz = vertrightz
            rightpointx = encpointrightx
            rightpointy = encpointrighty
            rightpointz = encpointrightz
            leftpointx = intrightx
            leftpointy = intrighty
            leftpointz = intrightz
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
        END IF
        IF flagimagechange = 1 THEN
            IF flagindexkused = 1 THEN
                GOTO begintripletsnipsubloop
            ELSE
                GOSUB triplet.image.repack
            END IF
        END IF

    CASE " 1 2 2" '*' 11 of 15
        ' Load information on overlap triangle.
        int3ABCx = tripletencpoint(1, 1)
        int3ABCy = tripletencpoint(1, 2)
        int3ABCz = tripletencpoint(1, 3)
        int3DEFx = tripletencpoint(1, 4)
        int3DEFy = tripletencpoint(1, 5)
        int3DEFz = tripletencpoint(1, 6)
        int1ABCx = tripletintpointpair(1, 1)
        int1ABCy = tripletintpointpair(1, 2)
        int1ABCz = tripletintpointpair(1, 3)
        int1DEFx = tripletintpointpair(1, 4)
        int1DEFy = tripletintpointpair(1, 5)
        int1DEFz = tripletintpointpair(1, 6)
        int2ABCx = tripletintpointpair(2, 1)
        int2ABCy = tripletintpointpair(2, 2)
        int2ABCz = tripletintpointpair(2, 3)
        int2DEFx = tripletintpointpair(2, 4)
        int2DEFy = tripletintpointpair(2, 5)
        int2DEFz = tripletintpointpair(2, 6)
        GOSUB perform.overlap.calculations
        ' Compare the apparent overlap tringles using centroid.
        IF magcentABC > magcentDEF AND magdiff > 0 AND areaABC > 0.005 AND areaDEF > 0.005 AND snip122enabled = 1 THEN
            'LOCATE 11, 1: PRINT signaturefull$
            flagimagechange = 1
            candouterpoint1x = tripletintpointpair(1, 10)
            candouterpoint1y = tripletintpointpair(1, 11)
            candouterpoint1z = tripletintpointpair(1, 12)
            candouterpoint2x = tripletintpointpair(1, 13)
            candouterpoint2y = tripletintpointpair(1, 14)
            candouterpoint2z = tripletintpointpair(1, 15)
            IF SQR((candouterpoint1x - tripletencpoint(1, 1)) ^ 2 + (candouterpoint1y - tripletencpoint(1, 2)) ^ 2 + (candouterpoint1z - tripletencpoint(1, 3)) ^ 2) > 0.1 AND SQR((candouterpoint1x - tripletencpoint(2, 1)) ^ 2 + (candouterpoint1y - tripletencpoint(2, 2)) ^ 2 + (candouterpoint1z - tripletencpoint(2, 3)) ^ 2) > 0.1 THEN
                outerpointx = candouterpoint1x
                outerpointy = candouterpoint1y
                outerpointz = candouterpoint1z
            ELSE
                outerpointx = candouterpoint1x
                outerpointy = candouterpoint1y
                outerpointz = candouterpoint1z
            END IF
            flagindexkused = 0
            ' First new triangle overwrites old one.
            basepointx = int3DEFx
            basepointy = int3DEFy
            basepointz = int3DEFz
            rightpointx = outerpointx
            rightpointy = outerpointy
            rightpointz = outerpointz
            leftpointx = int1ABCx
            leftpointy = int1ABCy
            leftpointz = int1ABCz
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
            ' Second new triangle.
            basepointx = int3DEFx
            basepointy = int3DEFy
            basepointz = int3DEFz
            rightpointx = outerpointx
            rightpointy = outerpointy
            rightpointz = outerpointz
            leftpointx = int2ABCx
            leftpointy = int2ABCy
            leftpointz = int2ABCz
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
        END IF
        IF flagimagechange = 1 THEN
            IF flagindexkused = 1 THEN
                GOTO begintripletsnipsubloop
            ELSE
                GOSUB triplet.image.repack
            END IF
        END IF
    CASE " 2 1 2" '*' 12 of 15
        ' Load information on overlap triangle.
        int3ABCx = tripletencpoint(1, 4)
        int3ABCy = tripletencpoint(1, 5)
        int3ABCz = tripletencpoint(1, 6)
        int3DEFx = tripletencpoint(1, 1)
        int3DEFy = tripletencpoint(1, 2)
        int3DEFz = tripletencpoint(1, 3)
        int1ABCx = tripletintpointpair(1, 1)
        int1ABCy = tripletintpointpair(1, 2)
        int1ABCz = tripletintpointpair(1, 3)
        int1DEFx = tripletintpointpair(1, 4)
        int1DEFy = tripletintpointpair(1, 5)
        int1DEFz = tripletintpointpair(1, 6)
        int2ABCx = tripletintpointpair(2, 1)
        int2ABCy = tripletintpointpair(2, 2)
        int2ABCz = tripletintpointpair(2, 3)
        int2DEFx = tripletintpointpair(2, 4)
        int2DEFy = tripletintpointpair(2, 5)
        int2DEFz = tripletintpointpair(2, 6)
        GOSUB perform.overlap.calculations
        ' Compare the apparent overlap tringles using centroid.
        IF magcentABC > magcentDEF AND magdiff > 0 AND areaABC > 0.005 AND areaDEF > 0.005 AND snip212enabled = 1 THEN
            'LOCATE 12, 1: PRINT signaturefull$
            flagimagechange = 1
            outvert1x = tripletintpointpair(2, 7)
            outvert1y = tripletintpointpair(2, 8)
            outvert1z = tripletintpointpair(2, 9)
            outvert2x = tripletintpointpair(1, 7)
            outvert2y = tripletintpointpair(1, 8)
            outvert2z = tripletintpointpair(1, 9)
            IF SQR((tripletintpointpair(1, 16) - tripletencpoint(1, 1)) ^ 2 + (tripletintpointpair(1, 17) - tripletencpoint(1, 2)) ^ 2 + (tripletintpointpair(1, 18) - tripletencpoint(1, 3)) ^ 2) < 0.0001 OR SQR((tripletintpointpair(1, 19) - tripletencpoint(1, 1)) ^ 2 + (tripletintpointpair(1, 20) - tripletencpoint(1, 2)) ^ 2 + (tripletintpointpair(1, 21) - tripletencpoint(1, 3)) ^ 2) < 0.0001 THEN
                encpoint1x = tripletencpoint(1, 4)
                encpoint1y = tripletencpoint(1, 5)
                encpoint1z = tripletencpoint(1, 6)
                encpoint2x = tripletencpoint(2, 4)
                encpoint2y = tripletencpoint(2, 5)
                encpoint2z = tripletencpoint(2, 6)
            ELSE
                encpoint1x = tripletencpoint(2, 4)
                encpoint1y = tripletencpoint(2, 5)
                encpoint1z = tripletencpoint(2, 6)
                encpoint2x = tripletencpoint(1, 4)
                encpoint2y = tripletencpoint(1, 5)
                encpoint2z = tripletencpoint(1, 6)
            END IF
            flagindexkused = 0
            ' First new triangle overwrites old one.
            basepointx = outvert2x
            basepointy = outvert2y
            basepointz = outvert2z
            rightpointx = int2ABCx
            rightpointy = int2ABCy
            rightpointz = int2ABCz
            leftpointx = encpoint2x
            leftpointy = encpoint2y
            leftpointz = encpoint2z
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
            ' Second new triangle.
            basepointx = outvert2x
            basepointy = outvert2y
            basepointz = outvert2z
            rightpointx = encpoint2x
            rightpointy = encpoint2y
            rightpointz = encpoint2z
            leftpointx = encpoint1x
            leftpointy = encpoint1y
            leftpointz = encpoint1z
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
            ' Third new triangle.
            basepointx = outvert1x
            basepointy = outvert1y
            basepointz = outvert1z
            rightpointx = outvert2x
            rightpointy = outvert2y
            rightpointz = outvert2z
            leftpointx = encpoint1x
            leftpointy = encpoint1y
            leftpointz = encpoint1z
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
            ' Fourth new triangle.
            basepointx = outvert1x
            basepointy = outvert1y
            basepointz = outvert1z
            rightpointx = encpoint1x
            rightpointy = encpoint1y
            rightpointz = encpoint1z
            leftpointx = int1ABCx
            leftpointy = int1ABCy
            leftpointz = int1ABCz
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
        END IF
        IF flagimagechange = 1 THEN
            IF flagindexkused = 1 THEN
                GOTO begintripletsnipsubloop
            ELSE
                GOSUB triplet.image.repack
            END IF
        END IF

    CASE " 0 1 4" '*' 13 of 15
        ' Load information on overlap triangle.
        int3ABCx = tripletencpoint(1, 1)
        int3ABCy = tripletencpoint(1, 2)
        int3ABCz = tripletencpoint(1, 3)
        int3DEFx = tripletencpoint(1, 4)
        int3DEFy = tripletencpoint(1, 5)
        int3DEFz = tripletencpoint(1, 6)
        int1ABCx = tripletintpointpair(1, 1)
        int1ABCy = tripletintpointpair(1, 2)
        int1ABCz = tripletintpointpair(1, 3)
        int1DEFx = tripletintpointpair(1, 4)
        int1DEFy = tripletintpointpair(1, 5)
        int1DEFz = tripletintpointpair(1, 6)
        int2ABCx = tripletintpointpair(2, 1)
        int2ABCy = tripletintpointpair(2, 2)
        int2ABCz = tripletintpointpair(2, 3)
        int2DEFx = tripletintpointpair(2, 4)
        int2DEFy = tripletintpointpair(2, 5)
        int2DEFz = tripletintpointpair(2, 6)
        GOSUB perform.overlap.calculations
        ' Compare the apparent overlap tringles using centroid.
        IF magcentABC > magcentDEF AND magdiff > 0 AND areaABC > 0.005 AND areaDEF > 0.005 AND snip014enabled = 1 THEN
            'LOCATE 13, 1: PRINT signaturefull$
            flagimagechange = 1
            ' Identify the two triangles.
            leftedgefound = 0
            FOR f = 1 TO 4
                IF SQR((tripletintpointpair(f, 7) - int3ABCx) ^ 2 + (tripletintpointpair(f, 8) - int3ABCy) ^ 2 + (tripletintpointpair(f, 9) - int3ABCz) ^ 2) > 0.1 THEN
                    possibleoutpoint1x = tripletintpointpair(f, 10)
                    possibleoutpoint1y = tripletintpointpair(f, 11)
                    possibleoutpoint1z = tripletintpointpair(f, 12)
                    possibleoutpoint2x = tripletintpointpair(f, 13)
                    possibleoutpoint2y = tripletintpointpair(f, 14)
                    possibleoutpoint2z = tripletintpointpair(f, 15)
                    intpointfwdx = tripletintpointpair(f, 1)
                    intpointfwdy = tripletintpointpair(f, 2)
                    intpointfwdz = tripletintpointpair(f, 3)
                    IF leftedgefound = 0 THEN
                        IF SQR((possibleoutpoint1x - int3ABCx) ^ 2 + (possibleoutpoint1y - int3ABCy) ^ 2 + (possibleoutpoint1z - int3ABCz) ^ 2) < 0.0001 THEN
                            outerpointleftx = possibleoutpoint2x
                            outerpointlefty = possibleoutpoint2y
                            outerpointleftz = possibleoutpoint2z
                            intpointfwdleftx = intpointfwdx
                            intpointfwdlefty = intpointfwdy
                            intpointfwdleftz = intpointfwdz
                        ELSE
                            outerpointleftx = possibleoutpoint1x
                            outerpointlefty = possibleoutpoint1y
                            outerpointleftz = possibleoutpoint1z
                            intpointfwdleftx = intpointfwdx
                            intpointfwdlefty = intpointfwdy
                            intpointfwdleftz = intpointfwdz
                        END IF
                        disttointpointmin = 10 ^ 5
                        FOR m = 1 TO 4
                            IF m <> W THEN
                                IF SQR((tripletintpointpair(m, 7) - int3ABCx) ^ 2 + (tripletintpointpair(m, 8) - int3ABCy) ^ 2 + (tripletintpointpair(m, 9) - int3ABCz) ^ 2) < 0.0001 THEN
                                    disttointpoint = SQR((outerpointleftx - tripletintpointpair(m, 1)) ^ 2 + (outerpointlefty - tripletintpointpair(m, 2)) ^ 2 + (outerpointleftz - tripletintpointpair(m, 3)) ^ 2)
                                    IF disttointpoint < disttointpointmin THEN
                                        intpointbackleftx = tripletintpointpair(m, 1)
                                        intpointbacklefty = tripletintpointpair(m, 2)
                                        intpointbackleftz = tripletintpointpair(m, 3)
                                        disttointpointmin = disttointpoint
                                    END IF

                                END IF
                            END IF
                        NEXT
                        leftedgefound = 1
                    ELSE
                        IF SQR((possibleoutpoint1x - int3ABCx) ^ 2 + (possibleoutpoint1y - int3ABCy) ^ 2 + (possibleoutpoint1z - int3ABCz) ^ 2) < 0.0001 THEN
                            outerpointrightx = possibleoutpoint2x
                            outerpointrighty = possibleoutpoint2y
                            outerpointrightz = possibleoutpoint2z
                            intpointfwdrightx = intpointfwdx
                            intpointfwdrighty = intpointfwdy
                            intpointfwdrightz = intpointfwdz
                        ELSE
                            outerpointrightx = possibleoutpoint1x
                            outerpointrighty = possibleoutpoint1y
                            outerpointrightz = possibleoutpoint1z
                            intpointfwdrightx = intpointfwdx
                            intpointfwdrighty = intpointfwdy
                            intpointfwdrightz = intpointfwdz
                        END IF
                        disttointpointmin = 10 ^ 5
                        FOR m = 1 TO 4
                            IF m <> W THEN
                                IF SQR((tripletintpointpair(m, 7) - int3ABCx) ^ 2 + (tripletintpointpair(m, 8) - int3ABCy) ^ 2 + (tripletintpointpair(m, 9) - int3ABCz) ^ 2) < 0.0001 THEN
                                    disttointpoint = SQR((outerpointrightx - tripletintpointpair(m, 1)) ^ 2 + (outerpointrighty - tripletintpointpair(m, 2)) ^ 2 + (outerpointrightz - tripletintpointpair(m, 3)) ^ 2)
                                    IF disttointpoint < disttointpointmin THEN
                                        intpointbackrightx = tripletintpointpair(m, 1)
                                        intpointbackrighty = tripletintpointpair(m, 2)
                                        intpointbackrightz = tripletintpointpair(m, 3)
                                        disttointpointmin = disttointpoint
                                    END IF
                                END IF
                            END IF
                        NEXT
                    END IF
                END IF
            NEXT
            flagindexkused = 0
            ' First new triangle overwrites old one.
            basepointx = outerpointrightx
            basepointy = outerpointrighty
            basepointz = outerpointrightz
            rightpointx = intpointfwdrightx
            rightpointy = intpointfwdrighty
            rightpointz = intpointfwdrightz
            leftpointx = intpointbackrightx
            leftpointy = intpointbackrighty
            leftpointz = intpointbackrightz
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
            ' Second new triangle.
            basepointx = outerpointleftx
            basepointy = outerpointlefty
            basepointz = outerpointleftz
            rightpointx = intpointbackleftx
            rightpointy = intpointbacklefty
            rightpointz = intpointbackleftz
            leftpointx = intpointfwdleftx
            leftpointy = intpointfwdlefty
            leftpointz = intpointfwdleftz
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
        END IF
        IF flagimagechange = 1 THEN
            IF flagindexkused = 1 THEN
                GOTO begintripletsnipsubloop
            ELSE
                GOSUB triplet.image.repack
            END IF
        END IF

    CASE " 1 0 4" '*' 14 of 15
        int3ABCx = tripletintpointpair(3, 1)
        int3ABCy = tripletintpointpair(3, 2)
        int3ABCz = tripletintpointpair(3, 3)
        int3DEFx = tripletintpointpair(3, 4)
        int3DEFy = tripletintpointpair(3, 5)
        int3DEFz = tripletintpointpair(3, 6)
        int1ABCx = tripletintpointpair(1, 1)
        int1ABCy = tripletintpointpair(1, 2)
        int1ABCz = tripletintpointpair(1, 3)
        int1DEFx = tripletintpointpair(1, 4)
        int1DEFy = tripletintpointpair(1, 5)
        int1DEFz = tripletintpointpair(1, 6)
        int2ABCx = tripletintpointpair(2, 1)
        int2ABCy = tripletintpointpair(2, 2)
        int2ABCz = tripletintpointpair(2, 3)
        int2DEFx = tripletintpointpair(2, 4)
        int2DEFy = tripletintpointpair(2, 5)
        int2DEFz = tripletintpointpair(2, 6)
        GOSUB perform.overlap.calculations
        ' Compare the apparent overlap tringles using centroid.
        IF magcentABC > magcentDEF AND magdiff > 0 AND areaABC > 0.005 AND areaDEF > 0.005 AND snip104enabled = 1 THEN
            'LOCATE 14, 1: PRINT signaturefull$
            flagimagechange = 1
            ''intpointbackleftused = 0
            ''FOR m = 1 TO 4
            ''    IF SQR((tripletintpointpair(m, 16) - tripletencpoint(1, 1)) ^ 2 + (tripletintpointpair(m, 17) - tripletencpoint(1, 2)) ^ 2 + (tripletintpointpair(m, 18) - tripletencpoint(1, 3)) ^ 2) > 0.1 AND SQR((tripletintpointpair(m, 19) - tripletencpoint(1, 1)) ^ 2 + (tripletintpointpair(m, 20) - tripletencpoint(1, 2)) ^ 2 + (tripletintpointpair(m, 21) - tripletencpoint(1, 3)) ^ 2) > 0.1 THEN
            ''        IF intpointbackleftused = 0 THEN
            ''            intpointbackleftx = tripletintpointpair(m, 1)
            ''            intpointbacklefty = tripletintpointpair(m, 2)
            ''            intpointbackleftz = tripletintpointpair(m, 3)
            ''            backleftindex = m
            ''            intpointbackleftused = 1
            ''        ELSE
            ''            intpointbackrightx = tripletintpointpair(m, 1)
            ''            intpointbackrighty = tripletintpointpair(m, 2)
            ''            intpointbackrightz = tripletintpointpair(m, 3)
            ''            backrightindex = m
            ''        END IF
            ''    END IF
            ''NEXT
            ''cand1x = tripletintpointpair(backleftindex, 10)
            ''cand1y = tripletintpointpair(backleftindex, 11)
            ''cand1z = tripletintpointpair(backleftindex, 12)
            ''cand2x = tripletintpointpair(backleftindex, 13)
            ''cand2y = tripletintpointpair(backleftindex, 14)
            ''cand2z = tripletintpointpair(backleftindex, 15)
            ''cand3x = tripletintpointpair(backrightindex, 10)
            ''cand3y = tripletintpointpair(backrightindex, 11)
            ''cand3z = tripletintpointpair(backrightindex, 12)
            ''cand4x = tripletintpointpair(backrightindex, 13)
            ''cand4y = tripletintpointpair(backrightindex, 14)
            ''cand4z = tripletintpointpair(backrightindex, 15)
            ''diff13 = SQR((cand1x - cand3x) ^ 2 + (cand1y - cand3y) ^ 2 + (cand1z - cand3z) ^ 2)
            ''diff14 = SQR((cand1x - cand4x) ^ 2 + (cand1y - cand4y) ^ 2 + (cand1z - cand4z) ^ 2)
            ''diff23 = SQR((cand2x - cand3x) ^ 2 + (cand2y - cand3y) ^ 2 + (cand2z - cand3z) ^ 2)
            ''diff24 = SQR((cand2x - cand4x) ^ 2 + (cand2y - cand4y) ^ 2 + (cand2z - cand4z) ^ 2)
            ''IF diff13 < 0.0001 THEN
            ''    pointbackoutx = cand1x
            ''    pointbackouty = cand1y
            ''    pointbackoutz = cand1z
            ''    pointfwdoutleftx = cand2x
            ''    pointfwdoutlefty = cand2y
            ''    pointfwdoutleftz = cand2z
            ''    pointfwdoutrightx = cand4x
            ''    pointfwdoutrighty = cand4y
            ''    pointfwdoutrightz = cand4z
            ''END IF
            ''IF diff14 < 0.0001 THEN
            ''    pointbackoutx = cand1x
            ''    pointbackouty = cand1y
            ''    pointbackoutz = cand1z
            ''    pointfwdoutleftx = cand2x
            ''    pointfwdoutlefty = cand2y
            ''    pointfwdoutleftz = cand2z
            ''    pointfwdoutrightx = cand3x
            ''    pointfwdoutrighty = cand3y
            ''    pointfwdoutrightz = cand3z
            ''END IF
            ''IF diff23 < 0.0001 THEN
            ''    pointbackoutx = cand2x
            ''    pointbackouty = cand2y
            ''    pointbackoutz = cand2z
            ''    pointfwdoutleftx = cand1x
            ''    pointfwdoutlefty = cand1y
            ''    pointfwdoutleftz = cand1z
            ''    pointfwdoutrightx = cand4x
            ''    pointfwdoutrighty = cand4y
            ''    pointfwdoutrightz = cand4z
            ''END IF
            ''IF diff24 < 0.0001 THEN
            ''    pointbackoutx = cand2x
            ''    pointbackouty = cand2y
            ''    pointbackoutz = cand2z
            ''    pointfwdoutleftx = cand1x
            ''    pointfwdoutlefty = cand1y
            ''    pointfwdoutleftz = cand1z
            ''    pointfwdoutrightx = cand3x
            ''    pointfwdoutrighty = cand3y
            ''    pointfwdoutrightz = cand3z
            ''END IF
            ''FOR m = 1 TO 4
            ''    IF SQR((tripletintpointpair(m, 16) - tripletencpoint(1, 1)) ^ 2 + (tripletintpointpair(m, 17) - tripletencpoint(1, 2)) ^ 2 + (tripletintpointpair(m, 18) - tripletencpoint(1, 3)) ^ 2) < 0.0001 OR SQR((tripletintpointpair(m, 19) - tripletencpoint(1, 1)) ^ 2 + (tripletintpointpair(m, 20) - tripletencpoint(1, 2)) ^ 2 + (tripletintpointpair(m, 21) - tripletencpoint(1, 3)) ^ 2) < 0.0001 THEN
            ''        IF SQR((tripletintpointpair(m, 7) - tripletintpointpair(backleftindex, 7)) ^ 2 + (tripletintpointpair(m, 8) - tripletintpointpair(backleftindex, 8)) ^ 2 + (tripletintpointpair(m, 9) - tripletintpointpair(backleftindex, 9)) ^ 2) < 0.0001 THEN
            ''            intpointfwdleftx = tripletintpointpair(m, 1)
            ''            intpointfwdlefty = tripletintpointpair(m, 2)
            ''            intpointfwdleftz = tripletintpointpair(m, 3)
            ''        END IF
            ''        IF SQR((tripletintpointpair(m, 7) - tripletintpointpair(backrightindex, 7)) ^ 2 + (tripletintpointpair(m, 8) - tripletintpointpair(backrightindex, 8)) ^ 2 + (tripletintpointpair(m, 9) - tripletintpointpair(backrightindex, 9)) ^ 2) < 0.0001 THEN
            ''            intpointfwdrightx = tripletintpointpair(m, 1)
            ''            intpointfwdrighty = tripletintpointpair(m, 2)
            ''            intpointfwdrightz = tripletintpointpair(m, 3)
            ''        END IF
            ''    END IF
            ''NEXT
            ''flagindexkused = 0
            ''' First new triangle overwrites old one.
            ''basepointx = pointbackoutx
            ''basepointy = pointbackouty
            ''basepointz = pointbackoutz
            ''rightpointx = intpointbackrightx
            ''rightpointy = intpointbackrighty
            ''rightpointz = intpointbackrightz
            ''leftpointx = intpointbackleftx
            ''leftpointy = intpointbacklefty
            ''leftpointz = intpointbackleftz
            ''GOSUB compute.triangle.areas.cents
            ''GOSUB create.image.triangle
            ''' Second new triangle.
            ''basepointx = intpointfwdleftx
            ''basepointy = intpointfwdlefty
            ''basepointz = intpointfwdleftz
            ''rightpointx = tripletencpoint(1, 4)
            ''rightpointy = tripletencpoint(1, 5)
            ''rightpointz = tripletencpoint(1, 6)
            ''leftpointx = pointfwdoutleftx
            ''leftpointy = pointfwdoutlefty
            ''leftpointz = pointfwdoutleftz
            ''GOSUB compute.triangle.areas.cents
            ''GOSUB create.image.triangle
            ''' Third new triangle.
            ''basepointx = tripletencpoint(1, 4)
            ''basepointy = tripletencpoint(1, 5)
            ''basepointz = tripletencpoint(1, 6)
            ''rightpointx = pointfwdoutrightx
            ''rightpointy = pointfwdoutrighty
            ''rightpointz = pointfwdoutrightz
            ''leftpointx = pointfwdoutleftx
            ''leftpointy = pointfwdoutlefty
            ''leftpointz = pointfwdoutleftz
            ''GOSUB compute.triangle.areas.cents
            ''GOSUB create.image.triangle
            ''' Fourth new triangle.
            ''basepointx = tripletencpoint(1, 4)
            ''basepointy = tripletencpoint(1, 5)
            ''basepointz = tripletencpoint(1, 6)
            ''rightpointx = intpointfwdrightx
            ''rightpointy = intpointfwdrighty
            ''rightpointz = intpointfwdrightz
            ''leftpointx = pointfwdoutrightx
            ''leftpointy = pointfwdoutrighty
            ''leftpointz = pointfwdoutrightz
            ''GOSUB compute.triangle.areas.cents
            ''GOSUB create.image.triangle
            centsharedx = (1 / 3) * (int1ABCx + int2ABCx + int3ABCx)
            centsharedy = (1 / 3) * (int1ABCy + int2ABCy + int3ABCy)
            centsharedz = (1 / 3) * (int1ABCz + int2ABCz + int3ABCz)
            flagindexkused = 0
            ' First new triangle overwrites old one.
            basepointx = centsharedx
            basepointy = centsharedy
            basepointz = centsharedz
            rightpointx = Ax
            rightpointy = Ay
            rightpointz = Az
            leftpointx = Bx
            leftpointy = By
            leftpointz = Bz
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
            ' Second new triangle.
            basepointx = centsharedx
            basepointy = centsharedy
            basepointz = centsharedz
            rightpointx = Bx
            rightpointy = By
            rightpointz = Bz
            leftpointx = Cx
            leftpointy = Cy
            leftpointz = Cz
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
            ' Third new triangle.
            basepointx = centsharedx
            basepointy = centsharedy
            basepointz = centsharedz
            rightpointx = Cx
            rightpointy = Cy
            rightpointz = Cz
            leftpointx = Ax
            leftpointy = Ay
            leftpointz = Az
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
        END IF
        IF flagimagechange = 1 THEN
            IF flagindexkused = 1 THEN
                GOTO begintripletsnipsubloop
            ELSE
                GOSUB triplet.image.repack
            END IF
        END IF

    CASE " 1 1 4" '*' 15 of 15
        ' Load information on overlap triangle.
        int3ABCx = tripletencpoint(1, 1)
        int3ABCy = tripletencpoint(1, 2)
        int3ABCz = tripletencpoint(1, 3)
        int3DEFx = tripletencpoint(1, 4)
        int3DEFy = tripletencpoint(1, 5)
        int3DEFz = tripletencpoint(1, 6)
        int1ABCx = tripletintpointpair(1, 1)
        int1ABCy = tripletintpointpair(1, 2)
        int1ABCz = tripletintpointpair(1, 3)
        int1DEFx = tripletintpointpair(1, 4)
        int1DEFy = tripletintpointpair(1, 5)
        int1DEFz = tripletintpointpair(1, 6)
        int2ABCx = tripletintpointpair(2, 1)
        int2ABCy = tripletintpointpair(2, 2)
        int2ABCz = tripletintpointpair(2, 3)
        int2DEFx = tripletintpointpair(2, 4)
        int2DEFy = tripletintpointpair(2, 5)
        int2DEFz = tripletintpointpair(2, 6)
        GOSUB perform.overlap.calculations
        ' Compare the apparent overlap tringles using centroid.
        IF magcentABC > magcentDEF AND magdiff > 0 AND areaABC > 0.005 AND areaDEF > 0.005 AND snip114enabled = 1 THEN
            'LOCATE 15, 1: PRINT signaturefull$
            flagimagechange = 1
            ' Identify the left int points.
            FOR m = 1 TO 4
                IF SQR((tripletintpointpair(m, 7) - tripletencpoint(2, 1)) ^ 2 + (tripletintpointpair(m, 8) - tripletencpoint(2, 2)) ^ 2 + (tripletintpointpair(m, 9) - tripletencpoint(2, 3)) ^ 2) > 0.1 THEN
                    IF SQR((tripletintpointpair(m, 16) - tripletencpoint(1, 1)) ^ 2 + (tripletintpointpair(m, 17) - tripletencpoint(1, 2)) ^ 2 + (tripletintpointpair(m, 18) - tripletencpoint(1, 3)) ^ 2) < 0.0001 OR SQR((tripletintpointpair(m, 19) - tripletencpoint(1, 1)) ^ 2 + (tripletintpointpair(m, 20) - tripletencpoint(1, 2)) ^ 2 + (tripletintpointpair(m, 21) - tripletencpoint(1, 3)) ^ 2) < 0.0001 THEN
                        intpointfwdleftx = tripletintpointpair(m, 1)
                        intpointfwdlefty = tripletintpointpair(m, 2)
                        intpointfwdleftz = tripletintpointpair(m, 3)
                        IF SQR((tripletintpointpair(m, 10) - tripletencpoint(2, 1)) ^ 2 + (tripletintpointpair(m, 11) - tripletencpoint(2, 2)) ^ 2 + (tripletintpointpair(m, 12) - tripletencpoint(2, 3)) ^ 2) < 0.0001 THEN
                            intpointfwdoutx = tripletintpointpair(m, 13)
                            intpointfwdouty = tripletintpointpair(m, 14)
                            intpointfwdoutz = tripletintpointpair(m, 15)
                        ELSE
                            intpointfwdoutx = tripletintpointpair(m, 10)
                            intpointfwdouty = tripletintpointpair(m, 11)
                            intpointfwdoutz = tripletintpointpair(m, 12)
                        END IF
                    ELSE
                        intpointbackleftx = tripletintpointpair(m, 1)
                        intpointbacklefty = tripletintpointpair(m, 2)
                        intpointbackleftz = tripletintpointpair(m, 3)
                        IF SQR((tripletintpointpair(m, 10) - tripletencpoint(2, 1)) ^ 2 + (tripletintpointpair(m, 11) - tripletencpoint(2, 2)) ^ 2 + (tripletintpointpair(m, 12) - tripletencpoint(2, 3)) ^ 2) < 0.0001 THEN
                            intpointbackoutx = tripletintpointpair(m, 13)
                            intpointbackouty = tripletintpointpair(m, 14)
                            intpointbackoutz = tripletintpointpair(m, 15)
                        ELSE
                            intpointbackoutx = tripletintpointpair(m, 10)
                            intpointbackouty = tripletintpointpair(m, 11)
                            intpointbackoutz = tripletintpointpair(m, 12)
                        END IF
                    END IF
                ELSE
                    IF SQR((tripletintpointpair(m, 16) - tripletencpoint(1, 1)) ^ 2 + (tripletintpointpair(m, 17) - tripletencpoint(1, 2)) ^ 2 + (tripletintpointpair(m, 18) - tripletencpoint(1, 3)) ^ 2) < 0.0001 OR SQR((tripletintpointpair(m, 19) - tripletencpoint(1, 1)) ^ 2 + (tripletintpointpair(m, 20) - tripletencpoint(1, 2)) ^ 2 + (tripletintpointpair(m, 21) - tripletencpoint(1, 3)) ^ 2) < 0.0001 THEN
                        intpointfwdrightx = tripletintpointpair(m, 1)
                        intpointfwdrighty = tripletintpointpair(m, 2)
                        intpointfwdrightz = tripletintpointpair(m, 3)
                    END IF
                    IF SQR((tripletintpointpair(m, 16) - tripletencpoint(1, 1)) ^ 2 + (tripletintpointpair(m, 17) - tripletencpoint(1, 2)) ^ 2 + (tripletintpointpair(m, 18) - tripletencpoint(1, 3)) ^ 2) > 0.1 AND SQR((tripletintpointpair(m, 19) - tripletencpoint(1, 1)) ^ 2 + (tripletintpointpair(m, 20) - tripletencpoint(1, 2)) ^ 2 + (tripletintpointpair(m, 21) - tripletencpoint(1, 3)) ^ 2) > 0.1 THEN
                        intpointbackrightx = tripletintpointpair(m, 1)
                        intpointbackrighty = tripletintpointpair(m, 2)
                        intpointbackrightz = tripletintpointpair(m, 3)
                    END IF
                END IF
            NEXT
            flagindexkused = 0
            ' First new triangle overwrites old one.
            basepointx = tripletencpoint(1, 4)
            basepointy = tripletencpoint(1, 5)
            basepointz = tripletencpoint(1, 6)
            rightpointx = intpointfwdoutx
            rightpointy = intpointfwdouty
            rightpointz = intpointfwdoutz
            leftpointx = intpointfwdleftx
            leftpointy = intpointfwdlefty
            leftpointz = intpointfwdleftz
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
            ' Second new triangle.
            basepointx = intpointfwdrightx
            basepointy = intpointfwdrighty
            basepointz = intpointfwdrightz
            rightpointx = intpointfwdoutx
            rightpointy = intpointfwdouty
            rightpointz = intpointfwdoutz
            leftpointx = tripletencpoint(1, 4)
            leftpointy = tripletencpoint(1, 5)
            leftpointz = tripletencpoint(1, 6)
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
            ' Third new triangle.
            basepointx = intpointbackoutx
            basepointy = intpointbackouty
            basepointz = intpointbackoutz
            rightpointx = intpointbackrightx
            rightpointy = intpointbackrighty
            rightpointz = intpointbackrightz
            leftpointx = intpointbackleftx
            leftpointy = intpointbacklefty
            leftpointz = intpointbackleftz
            GOSUB compute.triangle.areas.cents
            GOSUB create.image.triangle
        END IF
        IF flagimagechange = 1 THEN
            IF flagindexkused = 1 THEN
                GOTO begintripletsnipsubloop
            ELSE
                GOSUB triplet.image.repack
            END IF
        END IF

    CASE ELSE
        ' Code for troubleshooting.
        'LOCATE 16, 1: PRINT "else"
        'rdy = INT(RND * 9)
        'IF i = 1 AND j = 3 THEN COLOR 4
        'LOCATE 17 + rdy, 1: PRINT signaturefull$
        'COLOR 15
END SELECT
RETURN

compute.triangle.areas.cents:
rightarmx = rightpointx - basepointx
rightarmy = rightpointy - basepointy
rightarmz = rightpointz - basepointz
leftarmx = leftpointx - basepointx
leftarmy = leftpointy - basepointy
leftarmz = leftpointz - basepointz
trianglearea3Dvecx = rightarmy * leftarmz - rightarmz * leftarmy
trianglearea3Dvecy = rightarmz * leftarmx - rightarmx * leftarmz
trianglearea3Dvecz = rightarmx * leftarmy - rightarmy * leftarmx
trianglearea3D = (1 / 2) * (SQR(trianglearea3Dvecx ^ 2 + trianglearea3Dvecy ^ 2 + trianglearea3Dvecz ^ 2))
trianglecent3Dx = (1 / 3) * (basepointx + rightpointx + leftpointx)
trianglecent3Dy = (1 / 3) * (basepointy + rightpointy + leftpointy)
trianglecent3Dz = (1 / 3) * (basepointz + rightpointz + leftpointz)
trianglecent3Dmag = SQR(trianglecent3Dx ^ 2 + trianglecent3Dy ^ 2 + trianglecent3Dz ^ 2)
baseu = basepointx * uhat(1) + basepointy * uhat(2) + basepointz * uhat(3)
basev = basepointx * vhat(1) + basepointy * vhat(2) + basepointz * vhat(3)
rightu = rightpointx * uhat(1) + rightpointy * uhat(2) + rightpointz * uhat(3)
rightv = rightpointx * vhat(1) + rightpointy * vhat(2) + rightpointz * vhat(3)
leftu = leftpointx * uhat(1) + leftpointy * uhat(2) + leftpointz * uhat(3)
leftv = leftpointx * vhat(1) + leftpointy * vhat(2) + leftpointz * vhat(3)
basen = (basepointx * nhat(1) + basepointy * nhat(2) + basepointz * nhat(3))
rightn = (rightpointx * nhat(1) + rightpointy * nhat(2) + rightpointz * nhat(3))
leftn = (leftpointx * nhat(1) + leftpointy * nhat(2) + leftpointz * nhat(3))
basesu = baseu * fovd / basen
basesv = basev * fovd / basen
rightsu = rightu * fovd / rightn
rightsv = rightv * fovd / rightn
leftsu = leftu * fovd / leftn
leftsv = leftv * fovd / leftn
rightarmsu = rightsu - basesu
rightarmsv = rightsv - basesv
leftarmsu = leftsu - basesu
leftarmsv = leftsv - basesv
trianglearea2Dsvecncomp = rightarmsu * leftarmsv - rightarmsv * leftarmsu
trianglearea2Ds = (1 / 2) * (SQR(trianglearea2Dsvecncomp ^ 2))
trianglecent2Dsu = (1 / 3) * (basesu + rightsu + leftsu)
trianglecent2Dsv = (1 / 3) * (basesv + rightsv + leftsv)
trianglecent2Dmag = SQR(trianglecent2Dsu ^ 2 + trianglecent2Dsv ^ 2)
RETURN

perform.overlap.calculations:
basepointx = int3ABCx
basepointy = int3ABCy
basepointz = int3ABCz
rightpointx = int1ABCx
rightpointy = int1ABCy
rightpointz = int1ABCz
leftpointx = int2ABCx
leftpointy = int2ABCy
leftpointz = int2ABCz
GOSUB compute.triangle.areas.cents
areaABC = trianglearea3D
magcentABC = trianglecent3Dmag
basepointx = int3DEFx
basepointy = int3DEFy
basepointz = int3DEFz
rightpointx = int1DEFx
rightpointy = int1DEFy
rightpointz = int1DEFz
leftpointx = int2DEFx
leftpointy = int2DEFy
leftpointz = int2DEFz
GOSUB compute.triangle.areas.cents
areaDEF = trianglearea3D
magcentDEF = trianglecent3Dmag
magdiff = SQR((magcentABC - magcentDEF) ^ 2)
RETURN

create.image.triangle:
IF trianglearea3D > 0 AND trianglearea2Ds > 0 THEN
    IF flagindexkused = 0 THEN
        imageindex = k
        flagindexkused = 1
    ELSE
        pcounttripletsnipimage = pcounttripletsnipimage + 1
        imageindex = pcounttripletsnipimage
    END IF
    ' Code for troubleshooting.
    'shrinkfactor = .90
    'centimagex = (1 / 3) * (basepointx + rightpointx + leftpointx)
    'centimagey = (1 / 3) * (basepointy + rightpointy + leftpointy)
    'centimagez = (1 / 3) * (basepointz + rightpointz + leftpointz)
    'basepointx = centimagex + (shrinkfactor) * (basepointx - centimagex)
    'basepointy = centimagey + (shrinkfactor) * (basepointy - centimagey)
    'basepointz = centimagez + (shrinkfactor) * (basepointz - centimagez)
    'rightpointx = centimagex + (shrinkfactor) * (rightpointx - centimagex)
    'rightpointy = centimagey + (shrinkfactor) * (rightpointy - centimagey)
    'rightpointz = centimagez + (shrinkfactor) * (rightpointz - centimagez)
    'leftpointx = centimagex + (shrinkfactor) * (leftpointx - centimagex)
    'leftpointy = centimagey + (shrinkfactor) * (leftpointy - centimagey)
    'leftpointz = centimagez + (shrinkfactor) * (leftpointz - centimagez)
    tripletsnipimage(imageindex, 1) = basepointx
    tripletsnipimage(imageindex, 2) = basepointy
    tripletsnipimage(imageindex, 3) = basepointz
    tripletsnipimage(imageindex, 4) = rightpointx
    tripletsnipimage(imageindex, 5) = rightpointy
    tripletsnipimage(imageindex, 6) = rightpointz
    tripletsnipimage(imageindex, 7) = leftpointx
    tripletsnipimage(imageindex, 8) = leftpointy
    tripletsnipimage(imageindex, 9) = leftpointz
    tripletsnipimage(imageindex, 10) = tripletsnip(i, 10)
END IF
RETURN

copy.triplets.snip.final:
FOR i = 1 TO numtripletsnip
    tripletfinal(i, 1) = tripletsnip(i, 1)
    tripletfinal(i, 2) = tripletsnip(i, 2)
    tripletfinal(i, 3) = tripletsnip(i, 3)
    tripletfinal(i, 4) = tripletsnip(i, 4)
    tripletfinal(i, 5) = tripletsnip(i, 5)
    tripletfinal(i, 6) = tripletsnip(i, 6)
    tripletfinal(i, 7) = tripletsnip(i, 7)
    tripletfinal(i, 8) = tripletsnip(i, 8)
    tripletfinal(i, 9) = tripletsnip(i, 9)
    tripletfinal(i, 10) = tripletsnip(i, 10)
NEXT
numtripletfinal = numtripletsnip
RETURN

triplet.image.repack:
pcountimagerepack = 0
FOR m = 1 TO pcounttripletsnipimage
    IF m <> k THEN
        pcountimagerepack = pcountimagerepack + 1
        tripletsnipimage(pcountimagerepack, 1) = tripletsnipimage(m, 1)
        tripletsnipimage(pcountimagerepack, 2) = tripletsnipimage(m, 2)
        tripletsnipimage(pcountimagerepack, 3) = tripletsnipimage(m, 3)
        tripletsnipimage(pcountimagerepack, 4) = tripletsnipimage(m, 4)
        tripletsnipimage(pcountimagerepack, 5) = tripletsnipimage(m, 5)
        tripletsnipimage(pcountimagerepack, 6) = tripletsnipimage(m, 6)
        tripletsnipimage(pcountimagerepack, 7) = tripletsnipimage(m, 7)
        tripletsnipimage(pcountimagerepack, 8) = tripletsnipimage(m, 8)
        tripletsnipimage(pcountimagerepack, 9) = tripletsnipimage(m, 9)
        tripletsnipimage(pcountimagerepack, 10) = tripletsnipimage(m, 10)
    END IF
NEXT
pcounttripletsnipimage = pcountimagerepack
RETURN

' *** Define functions for plot modes. ***

plotmode.linearconnect:
' Erase old graphics.
FOR i = 1 TO numparticlevisible - 1
    x = zoom * vecvisiblepuvs.old(i, 1): y = zoom * vecvisiblepuvs.old(i, 2): GOSUB convert: x1 = x: y1 = y
    x = zoom * vecvisiblepuvs.old(i + 1, 1): y = zoom * vecvisiblepuvs.old(i + 1, 2): GOSUB convert: x2 = x: y2 = y
    LINE (x1, y1)-(x2, y2), 0
NEXT
' Draw new graphics.
FOR i = 1 TO numparticlevisible - 1
    x = zoom * vecvisiblepuvs(i, 1): y = zoom * vecvisiblepuvs(i, 2): GOSUB convert: x1 = x: y1 = y
    x = zoom * vecvisiblepuvs(i + 1, 1): y = zoom * vecvisiblepuvs(i + 1, 2): GOSUB convert: x2 = x: y2 = y
    IF vecvisibledotnhat(i) > 0 THEN
        LINE (x1, y1)-(x2, y2), vecvisible(i, 4)
    ELSE
        LINE (x1, y1)-(x2, y2), 8
    END IF
NEXT
RETURN

plotmode.simplepoints:
' Erase old graphics.
FOR i = 1 TO numparticlevisible
    x = zoom * vecvisiblepuvs.old(i, 1): y = zoom * vecvisiblepuvs.old(i, 2): GOSUB convert
    IF x > 0 AND x < 640 AND y > 0 AND y < 480 THEN
        PSET (x, y), 0
    END IF
NEXT
' Draw new graphics.
FOR i = 1 TO numparticlevisible
    x = zoom * vecvisiblepuvs(i, 1): y = zoom * vecvisiblepuvs(i, 2): GOSUB convert
    IF x > 0 AND x < 640 AND y > 0 AND y < 480 THEN
        PSET (x, y), vecvisible(i, 4)
    END IF
NEXT

plotmode.3denvparticles:
CLS
FOR i = 1 TO numparticlevisible
    x = zoom * vecvisiblepuvs(i, 1): y = zoom * vecvisiblepuvs(i, 2): GOSUB convert
    PSET (x, y), vecvisible(i, 4)
NEXT
RETURN

plotmode.molecule:
'FOR i = numparticlevisible TO 1 STEP -1
FOR i = 1 TO numparticlevisible
    FOR j = 6 TO 10
        IF vecvisible(i, j) = 0 THEN
            EXIT FOR
        ELSE
            x = zoom * vecvisiblepuvs.old(i, 1): y = zoom * vecvisiblepuvs.old(i, 2): GOSUB convert: x1 = x: y1 = y
            x = zoom * vecvisiblepuvs.old((vecvisible(i, j)), 1): y = zoom * vecvisiblepuvs.old((vecvisible(i, j)), 2): GOSUB convert: x2 = x: y2 = y
            LINE (x1, y1)-(x2, y2), 0
        END IF
    NEXT
    x = zoom * vecvisiblepuvs.old(i, 1): y = zoom * vecvisiblepuvs.old(i, 2)
    GOSUB convert
    IF x > 0 AND x < 640 AND y > 0 AND y < 480 THEN
        CIRCLE (x, y), INT(3 + 4 * vecvisible(i, 4) / biggestatom), 0
        IF toggleatomnumbers = 1 THEN
            COLOR 0
            LOCATE ytext, xtext: PRINT vecvisible(i, 5)
        END IF
    END IF
    FOR j = 6 TO 10
        IF vecvisible(i, j) = 0 THEN
            EXIT FOR
        ELSE
            x = zoom * vecvisiblepuvs(i, 1): y = zoom * vecvisiblepuvs(i, 2): GOSUB convert: x1 = x: y1 = y
            x = zoom * vecvisiblepuvs((vecvisible(i, j)), 1): y = zoom * vecvisiblepuvs((vecvisible(i, j)), 2): GOSUB convert: x2 = x: y2 = y
            LINE (x1, y1)-(x2, y2), vecvisible(i, 4)
        END IF
    NEXT
    x = zoom * vecvisiblepuvs(i, 1): y = zoom * vecvisiblepuvs(i, 2)
    GOSUB convert
    IF x > 0 AND x < 640 AND y > 0 AND y < 480 THEN
        CIRCLE (x, y), INT(3 + 4 * vecvisible(i, 4) / biggestatom), vecvisible(i, 4)
        IF toggleatomnumbers = 1 THEN
            COLOR vecvisible(i, 4)
            LOCATE ytext, xtext: PRINT vecvisible(i, 5)
        END IF
    END IF
NEXT
RETURN

plotmode.neighbortile:
tilemin = 1: tilemax = 3
FOR i = 1 TO numparticlevisible - 1
    FOR j = (i + 1) TO numparticlevisible
        vecvisiblesep = SQR((vecvisible(j, 1) - vecvisible(i, 1)) ^ 2 + (vecvisible(j, 2) - vecvisible(i, 2)) ^ 2 + (vecvisible(j, 3) - vecvisible(i, 3)) ^ 2)
        IF vecvisiblesep > tilemin AND vecvisiblesep < tilemax THEN
            ' Erase old graphics.
            x = zoom * vecvisiblepuvs.old(i, 1): y = zoom * vecvisiblepuvs.old(i, 2): GOSUB convert: x1 = x: y1 = y
            x = zoom * vecvisiblepuvs.old(j, 1): y = zoom * vecvisiblepuvs.old(j, 2): GOSUB convert: x2 = x: y2 = y
            LINE (x1, y1)-(x2, y2), 0
            ' Draw new graphics.
            x = zoom * vecvisiblepuvs(i, 1): y = zoom * vecvisiblepuvs(i, 2): GOSUB convert: x1 = x: y1 = y
            x = zoom * vecvisiblepuvs(j, 1): y = zoom * vecvisiblepuvs(j, 2): GOSUB convert: x2 = x: y2 = y
            IF vecvisibledotnhat(j) < 0 THEN
                LINE (x1, y1)-(x2, y2), 8
            ELSE
                LINE (x1, y1)-(x2, y2), vecvisible(j, 4)
            END IF
        END IF
    NEXT
NEXT
RETURN

plotmode.3denvdoublets:
FOR i = 1 TO numdoubletsnip.old
    ' Erase old graphics.
    x = zoom * doubletsnippuvs.old(i, 1): y = zoom * doubletsnippuvs.old(i, 2): GOSUB convert
    u1 = x: v1 = y
    CIRCLE (u1, v1), 5, 0
    x = zoom * doubletsnippuvs.old(i, 3): y = zoom * doubletsnippuvs.old(i, 4): GOSUB convert
    u2 = x: v2 = y
    CIRCLE (u2, v2), 3, 0
    LINE (u1, v1)-(u2, v2), 0
NEXT
FOR i = 1 TO numdoubletsnip
    ' Draw new graphics.
    x = zoom * doubletsnippuvs(i, 1): y = zoom * doubletsnippuvs(i, 2): GOSUB convert
    u1 = x: v1 = y
    CIRCLE (u1, v1), 5, doubletsnip(i, 7)
    x = zoom * doubletsnippuvs(i, 3): y = zoom * doubletsnippuvs(i, 4): GOSUB convert
    u2 = x: v2 = y
    CIRCLE (u2, v2), 3, doubletsnip(i, 7)
    LINE (u1, v1)-(u2, v2), doubletsnip(i, 7)
NEXT
RETURN

plotmode.3denvtriplets:
'FOR i = 1 TO numtripletfinal.old
'    ' Erase old graphics.
'    x = zoom * tripletfinalpuvs.old(i, 1): y = zoom * tripletfinalpuvs.old(i, 2): GOSUB convert
'    u1 = x: v1 = y
'    'CIRCLE (u1, v1), 5, 0
'    x = zoom * tripletfinalpuvs.old(i, 3): y = zoom * tripletfinalpuvs.old(i, 4): GOSUB convert
'    u2 = x: v2 = y
'    'CIRCLE (u2, v2), 4, 0
'    x = zoom * tripletfinalpuvs.old(i, 5): y = zoom * tripletfinalpuvs.old(i, 6): GOSUB convert
'    u3 = x: v3 = y
'    'CIRCLE (u3, v3), 3, 0
'    centu = (1 / 3) * (u1 + u2 + u3)
'    centv = (1 / 3) * (v1 + v2 + v3)
'    LINE (u1, v1)-(u2, v2), 0
'    LINE (u2, v2)-(u3, v3), 0
'    LINE (u3, v3)-(u1, v1), 0
'    'PAINT (centu, centv), 0, 0
'NEXT
CLS
FOR i = 1 TO numtripletfinal
    ' Draw new graphics.
    x = zoom * tripletfinalpuvs(i, 1): y = zoom * tripletfinalpuvs(i, 2): GOSUB convert
    u1 = x: v1 = y
    'CIRCLE (u1, v1), 5, tripletfinal(i, 10)
    x = zoom * tripletfinalpuvs(i, 3): y = zoom * tripletfinalpuvs(i, 4): GOSUB convert
    u2 = x: v2 = y
    'CIRCLE (u2, v2), 4, tripletfinal(i, 10)
    x = zoom * tripletfinalpuvs(i, 5): y = zoom * tripletfinalpuvs(i, 6): GOSUB convert
    u3 = x: v3 = y
    'CIRCLE (u3, v3), 3, tripletfinal(i, 10)
    LINE (u1, v1)-(u2, v2), tripletfinal(i, 10)
    LINE (u2, v2)-(u3, v3), tripletfinal(i, 10)
    LINE (u3, v3)-(u1, v1), tripletfinal(i, 10)
    centu = (1 / 3) * (u1 + u2 + u3)
    centv = (1 / 3) * (v1 + v2 + v3)
    'PAINT (centu, centv), tripletfinal(i, 10), tripletfinal(i, 10)
NEXT
RETURN

plotmode.simplemesh:
FOR i = 1 TO numparticlevisible - 1
    IF i MOD yrange <> 0 THEN 'point obeys normal neighbor-connect scheme
        ' Erase old graphics.
        x = zoom * vecvisiblepuvs.old(i, 1): y = zoom * vecvisiblepuvs.old(i, 2): GOSUB convert: x1 = x: y1 = y
        x = zoom * vecvisiblepuvs.old(i + 1, 1): y = zoom * vecvisiblepuvs.old(i + 1, 2): GOSUB convert: x2 = x: y2 = y
        x = zoom * vecvisiblepuvs.old(i + yrange, 1): y = zoom * vecvisiblepuvs.old(i + yrange, 2): GOSUB convert: x3 = x: y3 = y
        LINE (x1, y1)-(x2, y2), 0
        IF i < (numparticlevisible - yrange) THEN LINE (x1, y1)-(x3, y3), 0
        ' Draw new graphics.
        x = zoom * vecvisiblepuvs(i, 1): y = zoom * vecvisiblepuvs(i, 2): GOSUB convert: x1 = x: y1 = y
        x = zoom * vecvisiblepuvs(i + 1, 1): y = zoom * vecvisiblepuvs(i + 1, 2): GOSUB convert: x2 = x: y2 = y
        x = zoom * vecvisiblepuvs(i + yrange, 1): y = zoom * vecvisiblepuvs(i + yrange, 2): GOSUB convert: x3 = x: y3 = y
        LINE (x1, y1)-(x2, y2), vecvisible(i, 4)
        IF i < (numparticlevisible - yrange) THEN LINE (x1, y1)-(x3, y3), vecvisible(i, 4)
    ELSE 'point does not obey normal neighbor-connect scheme
        ' Erase old graphics.
        x = zoom * vecvisiblepuvs.old(i, 1): y = zoom * vecvisiblepuvs.old(i, 2): GOSUB convert: x1 = x: y1 = y
        x = zoom * vecvisiblepuvs.old(i + yrange, 1): y = zoom * vecvisiblepuvs.old(i + yrange, 2): GOSUB convert: x3 = x: y3 = y
        IF i < (numparticlevisible - yrange + 1) THEN LINE (x1, y1)-(x3, y3), 0
        ' Draw new graphics.
        x = zoom * vecvisiblepuvs(i, 1): y = zoom * vecvisiblepuvs(i, 2): GOSUB convert: x1 = x: y1 = y
        x = zoom * vecvisiblepuvs(i + yrange, 1): y = zoom * vecvisiblepuvs(i + yrange, 2): GOSUB convert: x3 = x: y3 = y
        IF i < (numparticlevisible - yrange + 1) THEN LINE (x1, y1)-(x3, y3), vecvisible(i, 4)
    END IF
NEXT
RETURN

plotmode.meshtech2:
FOR i = 1 TO numparticlevisible - yrange
    vecvisible1temp1 = vecvisible(i + 1, 1) - vecvisible(i, 1)
    vecvisible1temp2 = vecvisible(i + 1, 2) - vecvisible(i, 2)
    vecvisible1temp3 = vecvisible(i + 1, 3) - vecvisible(i, 3)
    vecvisible2temp1 = vecvisible(i + yrange, 1) - vecvisible(i, 1)
    vecvisible2temp2 = vecvisible(i + yrange, 2) - vecvisible(i, 2)
    vecvisible2temp3 = vecvisible(i + yrange, 3) - vecvisible(i, 3)
    vecvisiblet1 = -vecvisible1temp2 * vecvisible2temp3 + vecvisible1temp3 * vecvisible2temp2
    vecvisiblet2 = -vecvisible1temp3 * vecvisible2temp1 + vecvisible1temp1 * vecvisible2temp3
    vecvisiblet3 = -vecvisible1temp1 * vecvisible2temp2 + vecvisible1temp2 * vecvisible2temp1
    vecvisibletdotnhat = vecvisiblet1 * nhat(1) + vecvisiblet2 * nhat(2) + vecvisiblet3 * nhat(3)
    IF vecvisibletdotnhat > 0 THEN plotflag(i) = 1 ELSE plotflag(i) = -1
NEXT
FOR i = 1 TO numparticlevisible - yrange
    IF i MOD yrange <> 0 THEN 'point obeys normal neighbor-connect scheme
        ' Erase old graphics.
        IF plotflag.old(i) = 1 THEN
            x = zoom * vecvisiblepuvs.old(i, 1): y = zoom * vecvisiblepuvs.old(i, 2): GOSUB convert: x1 = x: y1 = y
            x = zoom * vecvisiblepuvs.old(i + 1, 1): y = zoom * vecvisiblepuvs.old(i + 1, 2): GOSUB convert: x2 = x: y2 = y
            x = zoom * vecvisiblepuvs.old(i + yrange, 1): y = zoom * vecvisiblepuvs.old(i + yrange, 2): GOSUB convert: x3 = x: y3 = y
            LINE (x1, y1)-(x2, y2), 0
            LINE (x1, y1)-(x3, y3), 0
        END IF
        ' Draw new graphics.
        IF plotflag(i) = 1 THEN
            x = zoom * vecvisiblepuvs(i, 1): y = zoom * vecvisiblepuvs(i, 2): GOSUB convert: x1 = x: y1 = y
            x = zoom * vecvisiblepuvs(i + 1, 1): y = zoom * vecvisiblepuvs(i + 1, 2): GOSUB convert: x2 = x: y2 = y
            x = zoom * vecvisiblepuvs(i + yrange, 1): y = zoom * vecvisiblepuvs(i + yrange, 2): GOSUB convert: x3 = x: y3 = y
            LINE (x1, y1)-(x2, y2), vecvisible(i, 4)
            LINE (x1, y1)-(x3, y3), vecvisible(i, 4)
        END IF
        plotflag.old(i) = plotflag(i)
    END IF
NEXT
RETURN

plotmode.meshtech2planet:
FOR i = 1 TO numparticlevisible - 1
    IF i MOD yrange <> 0 THEN
        ' Erase old graphics.
        IF vecvisibledotnhatunit.old(i) > 0 THEN
            x = zoom * vecvisiblepuvs.old(i, 1): y = zoom * vecvisiblepuvs.old(i, 2): GOSUB convert: x1 = x: y1 = y
            x = zoom * vecvisiblepuvs.old(i + 1, 1): y = zoom * vecvisiblepuvs.old(i + 1, 2): GOSUB convert: x2 = x: y2 = y
            x = zoom * vecvisiblepuvs.old(i + yrange, 1): y = zoom * vecvisiblepuvs.old(i + yrange, 2): GOSUB convert: x3 = x: y3 = y
            LINE (x1, y1)-(x2, y2), 0
            IF i < (numparticlevisible - yrange) THEN LINE (x1, y1)-(x3, y3), 0
        END IF
        ' Draw new graphics.
        IF vecvisibledotnhat(i) > 0 THEN
            x = zoom * vecvisiblepuvs(i, 1): y = zoom * vecvisiblepuvs(i, 2): GOSUB convert: x1 = x: y1 = y
            x = zoom * vecvisiblepuvs(i + 1, 1): y = zoom * vecvisiblepuvs(i + 1, 2): GOSUB convert: x2 = x: y2 = y
            x = zoom * vecvisiblepuvs(i + yrange, 1): y = zoom * vecvisiblepuvs(i + yrange, 2): GOSUB convert: x3 = x: y3 = y
            LINE (x1, y1)-(x2, y2), vecvisible(i, 4)
            IF i < (numparticlevisible - yrange) THEN LINE (x1, y1)-(x3, y3), vecvisible(i, 4)
        END IF
    END IF
    vecvisibledotnhatunit.old(i) = vecvisibledotnhat(i)
NEXT
RETURN

plotmode.simplepointsbacteria:
FOR i = numparticlevisible TO 1 STEP -1
    IF vecvisible(i, 4) = 8 THEN
        ' Erase old graphics.
        x = zoom * vecvisiblepuvs.old(i, 1): y = zoom * vecvisiblepuvs.old(i, 2): GOSUB convert
        IF x > 0 AND x < 640 AND y > 0 AND y < 480 THEN
            PSET (x, y), 0
        END IF
        ' Draw new graphics.
        x = zoom * vecvisiblepuvs(i, 1): y = zoom * vecvisiblepuvs(i, 2): GOSUB convert
        IF x > 0 AND x < 640 AND y > 0 AND y < 480 THEN
            IF vecvisibledotnhat(i) > 0 THEN
                PSET (x, y), vecvisible(i, 4)
            ELSE
                PSET (x, y), 8
            END IF
        END IF
    ELSE
        ' Erase old graphics.
        x = zoom * vecvisiblepuvs.old(i, 1): y = zoom * vecvisiblepuvs.old(i, 2): GOSUB convert
        IF x > 0 AND x < 640 AND y > 0 AND y < 480 THEN
            CIRCLE (x, y), INT(vecvisible(i, 7) * zoom) + 1, 0
        END IF
        ' Draw new graphics.
        x = zoom * vecvisiblepuvs(i, 1): y = zoom * vecvisiblepuvs(i, 2): GOSUB convert
        IF x > 0 AND x < 640 AND y > 0 AND y < 480 THEN
            CIRCLE (x, y), INT(vecvisible(i, 6) * zoom) + 1, vecvisible(i, 4)
        END IF
    END IF
NEXT
RETURN

plotmode.linearneuron:
FOR i = 1 TO numneuralnodes
    FOR j = 1 TO numparticlevisible
        IF i <> j AND vecvisible(j, 5) = i THEN
            ' Erase old graphics.
            x = zoom * vecvisiblepuvs.old(i, 1): y = zoom * vecvisiblepuvs.old(i, 2): GOSUB convert: x1 = x: y1 = y
            x = zoom * vecvisiblepuvs.old(j, 1): y = zoom * vecvisiblepuvs.old(j, 2): GOSUB convert: x2 = x: y2 = y
            IF x1 > 0 AND x1 < 640 AND y1 > 0 AND y1 < 480 AND x2 > 0 AND x2 < 640 AND y2 > 0 AND y2 < 480 THEN
                LINE (x1, y1)-(x2, y2), 0
            END IF
            ' Draw new graphics.
            x = zoom * vecvisiblepuvs(i, 1): y = zoom * vecvisiblepuvs(i, 2): GOSUB convert: x1 = x: y1 = y
            x = zoom * vecvisiblepuvs(j, 1): y = zoom * vecvisiblepuvs(j, 2): GOSUB convert: x2 = x: y2 = y
            IF x1 > 0 AND x1 < 640 AND y1 > 0 AND y1 < 480 AND x2 > 0 AND x2 < 640 AND y2 > 0 AND y2 < 480 THEN
                LINE (x1, y1)-(x2, y2), vecvisible(j, 4)
            END IF
        END IF
    NEXT
NEXT
RETURN

' *** Define functions for generation schemes. ***

' *****************************************************************************
'ALLYLDICHLOROSILANE SGI MOLECULE BEGIN
DATA 0.000000,0.000000,0.000000,6,1,2,0,0,0,0
DATA 0.000000,0.000000,1.317000,6,2,0,0,0,0,0
DATA 1.253339,0.000000,2.174135,6,3,2,0,0,0,0
DATA 1.648740,-1.728751,2.759165,14,4,3,0,0,0,0
DATA 1.861829,-2.662286,1.657558,1,5,4,0,0,0,0
DATA 0.909973,0.026847,-0.570958,1,6,1,0,0,0,0
DATA -0.914351,-0.018888,-0.560617,1,7,1,0,0,0,0
DATA -0.931482,-0.023791,1.853298,1,8,2,0,0,0,0
DATA 1.132146,0.660744,3.028965,1,9,3,0,0,0,0
DATA 2.102271,0.367006,1.600915,1,10,3,0,0,0,0
DATA 3.353124,-1.699853,3.896830,17,11,4,0,0,0,0
DATA 0.105750,-2.448640,3.896713,17,12,4,0,0,0,0
'DATA x, y, z, atomic number, atom index, neighbor 1, neighbor 2, etc.
'ALLYLDICHLOROSILANE SGI MOLECULE END
' *****************************************************************************

genschemeUSAcolors:
'delinearize
pcountparticleorig = 0
FOR i = 1 TO xrange
    FOR j = 1 TO yrange
        pcountparticleorig = pcountparticleorig + 1
        vec2dztemp(i, j) = vec(pcountparticleorig, 4)
    NEXT
NEXT
FOR i = 1 TO xrange
    FOR jj = 0 TO 12 STEP 2
        FOR j = jj * yrange / 13 + 1 TO (jj + 1) * yrange / 13
            vec2dztemp(i, j) = 4
        NEXT
    NEXT
    FOR jj = 1 TO 11 STEP 2
        FOR j = jj * yrange / 13 + 1 TO (jj + 1) * yrange / 13
            vec2dztemp(i, j) = 7
        NEXT
    NEXT
NEXT
starflag = -1
FOR i = 1 TO xrange * .76 / 1.9
    FOR j = yrange TO yrange * .5385 STEP -1
        IF starflag = 1 THEN
            vec2dztemp(i, j) = 15
        ELSE
            vec2dztemp(i, j) = 1
        END IF
        starflag = -starflag
    NEXT
NEXT
'relinearize
pcountparticleorig = 0
FOR i = 1 TO xrange
    FOR j = 1 TO yrange
        pcountparticleorig = pcountparticleorig + 1
        vec(pcountparticleorig, 4) = vec2dztemp(i, j)
    NEXT
NEXT
RETURN

genscheme.curve:
helixL = 15
helixR1 = 5
helixR2 = 2.5
helixalpha = .1
xl = -helixL / 2: xr = helixL / 2: Dx = .005
gridxhalfsize = 10
gridyhalfsize = 30
gridzhalfsize = 5
gridxstep = 1
gridystep = 1
gridzstep = 1
pcountparticleorig = 0
FOR i = xl TO xr STEP Dx
    pcountparticleorig = pcountparticleorig + 1
    RZ = helixR1 - (helixR1 - helixR2) * (i + helixL / 2) / helixL
    vec(pcountparticleorig, 1) = RZ * COS(i)
    vec(pcountparticleorig, 2) = RZ * SIN(i)
    vec(pcountparticleorig, 3) = helixalpha * i
    vec(pcountparticleorig, 4) = 5
NEXT
RETURN

genscheme.simplepoints:
xl = -3.2: xr = 5.98
yl = -4.01: yr = 6.1
Dx = .2: Dy = .1
pcountparticleorig = 0
FOR i = xl TO xr STEP Dx
    FOR j = yl TO yr STEP Dy
        pcountparticleorig = pcountparticleorig + 1
        vec(pcountparticleorig, 1) = i
        vec(pcountparticleorig, 2) = j
        vec(pcountparticleorig, 3) = COS((i ^ 2 - j ^ 2))
        vec(pcountparticleorig, 4) = 9
    NEXT
NEXT
RETURN

genscheme.3denvparticles.init:
pcountparticleorig = 0
'particle grass
FOR i = -50 TO 50 STEP 1
    FOR j = -50 TO 50 STEP 1
        k = 0
        pcountparticleorig = pcountparticleorig + 1
        vec(pcountparticleorig, 1) = i + RND - RND
        vec(pcountparticleorig, 2) = j + RND - RND
        vec(pcountparticleorig, 3) = k - COS((i - 15) * .08) + COS((j - 6) * .12)
        IF COS((i - 15) * .08) + COS((j - 6) * .12) < .5 THEN
            vec(pcountparticleorig, 4) = 2
        ELSE
            IF RND > .2 THEN
                vec(pcountparticleorig, 4) = 9
            ELSE
                vec(pcountparticleorig, 4) = 1
            END IF
        END IF
    NEXT
NEXT
'particle sky
FOR i = -50 TO 50 STEP 1
    FOR j = -50 TO 50 STEP 1
        k = -50
        pcountparticleorig = pcountparticleorig + 1
        vec(pcountparticleorig, 1) = i + RND
        vec(pcountparticleorig, 2) = j + RND
        vec(pcountparticleorig, 3) = -k - RND
        IF RND > .5 THEN
            vec(pcountparticleorig, 4) = 9
        ELSE
            vec(pcountparticleorig, 4) = 15
        END IF
    NEXT
NEXT
'particle wave art 1
FOR i = 1 TO 5 STEP .05
    FOR k = 1 TO 5 STEP .05
        pcountparticleorig = pcountparticleorig + 1
        vec(pcountparticleorig, 1) = -7 * i
        vec(pcountparticleorig, 2) = 50 + 1 * COS(2 * ((i - 7) ^ 2 - (k - 5) ^ 2))
        vec(pcountparticleorig, 3) = 10 + 7 * k
        IF vec(pcountparticleorig, 2) < 50 THEN
            vec(pcountparticleorig, 4) = 13
        ELSE
            vec(pcountparticleorig, 4) = 4
        END IF
    NEXT
NEXT
'particle wave art 2
FOR i = 1 TO 5 STEP .05
    FOR k = 1 TO 5 STEP .05
        pcountparticleorig = pcountparticleorig + 1
        vec(pcountparticleorig, 1) = 7 * i
        vec(pcountparticleorig, 2) = 50 + 1 * COS((i ^ 2 - k ^ 2))
        vec(pcountparticleorig, 3) = 10 + 7 * k
        IF vec(pcountparticleorig, 2) < 50 THEN
            vec(pcountparticleorig, 4) = 2
        ELSE
            vec(pcountparticleorig, 4) = 1
        END IF
    NEXT
NEXT
'air ball
FOR j = 1 TO 5
    p1 = RND * 5
    p2 = RND * 5
    p3 = RND * 5
    FOR i = -pi TO pi STEP .15 '.0005 for Menon demo
        pcountparticleorig = pcountparticleorig + 1
        vec(pcountparticleorig, 1) = 30 + 5 * COS(i) * SIN(p1 * i) + SIN(p3 * i)
        vec(pcountparticleorig, 2) = 20 + 5 * SIN(i) * COS(p2 * i) + COS(p2 * i)
        vec(pcountparticleorig, 3) = 20 - 5 * COS(i) * SIN(p3 * i) + SIN(p1 * i)
        vec(pcountparticleorig, 4) = 6
    NEXT
NEXT
animpcountparticleflag = pcountparticleorig
'particle snake
FOR i = -pi TO pi STEP .005
    pcountparticleorig = pcountparticleorig + 1
    vec(pcountparticleorig, 1) = -10 + 5 * COS(i)
    vec(pcountparticleorig, 2) = -20 + 5 * SIN(i)
    vec(pcountparticleorig, 3) = 25 - 3 * COS(6 * i) * SIN(3 * i)
    vec(pcountparticleorig, 4) = 12
NEXT
'rain drops
FOR i = -50 TO 50 STEP 5
    FOR j = -50 TO 50 STEP 5
        k = 50
        pcountparticleorig = pcountparticleorig + 1
        vec(pcountparticleorig, 1) = i + RND
        vec(pcountparticleorig, 2) = j + RND
        vec(pcountparticleorig, 3) = k * RND
        IF RND > .66 THEN
            vec(pcountparticleorig, 4) = 9
        ELSE
            vec(pcountparticleorig, 4) = 7
        END IF
    NEXT
NEXT
RETURN

genscheme.3denvparticles.timeanimate:
T = timevar / 50
pcountparticleorig = animpcountparticleflag
'particle snake
FOR i = -pi TO pi STEP .005
    pcountparticleorig = pcountparticleorig + 1
    vec(pcountparticleorig, 1) = camx - 10 + 5 * COS(i + T)
    vec(pcountparticleorig, 2) = camy - 20 + 5 * SIN(i + T)
    vec(pcountparticleorig, 3) = camz + 25 - 3 * COS(6 * i + T) * SIN(3 * i + T)
    vec(pcountparticleorig, 4) = 12
NEXT
'rain drops
FOR i = -50 TO 50 STEP 5
    FOR j = -50 TO 50 STEP 5
        pcountparticleorig = pcountparticleorig + 1
        vec(pcountparticleorig, 1) = vec(pcountparticleorig, 1)
        vec(pcountparticleorig, 2) = vec(pcountparticleorig, 2)
        vec(pcountparticleorig, 3) = vec(pcountparticleorig, 3) - .3
        IF vec(pcountparticleorig, 3) < camz THEN vec(pcountparticleorig, 3) = vec(pcountparticleorig, 3) + 50
    NEXT
NEXT
RETURN

' *****************************************************************************
'ETHANE MOLECULE BEGIN
'DATA 0,0,-0.771209,6,1,0,0,0,0,0
'DATA 0,0,0.771209,6,2,1,0,0,0,0
'DATA 1.013466,0,1.156212,2,3,2,0,0,0,0
'DATA -1.013466,0,-1.156212,2,4,1,0,0,0,0
'DATA -0.506733,-0.877687,1.156212,2,5,2,0,0,0,0
'DATA -0.506733,0.877687,1.156212,2,6,2,0,0,0,0
'DATA 0.506733,-0.877687,-1.156212,2,7,1,0,0,0,0
'DATA 0.506733,0.877687,-1.156212,2,8,1,0,0,0,0
'DATA x, y, z, atomic number, atom index, neighbor 1, neighbor 2, etc.
'ETHANE MOLECULE END
' *****************************************************************************

genscheme.molecule:
'DATA x, y, z, atomic number, atom index, neighbor 1, neighbor 2, etc.
biggestatom = -999999999
FOR i = 1 TO numparticleorig
    IF vec(i, 4) > 15 THEN
        DO
            vec(i, 4) = vec(i, 4) * .75
        LOOP UNTIL vec(i, 4) <= 15
    END IF
    IF vec(i, 4) > biggestatom THEN biggestatom = vec(i, 4)
NEXT
RETURN

genscheme.neighbortile:
pcountparticleorig = 0
pcountparticleorig = 0
FOR i = -8 TO 8 STEP 1
    FOR j = -8 TO 8 STEP 1
        FOR k = -8 TO 8 STEP 1
            mag = SQR((i ^ 2) + (j ^ 2) + (k ^ 2)) - 6
            IF SQR(mag ^ 2) < .1 AND i > 0 THEN
                pcountparticleorig = pcountparticleorig + 1
                vec(pcountparticleorig, 1) = i
                vec(pcountparticleorig, 2) = j
                vec(pcountparticleorig, 3) = k
                vec(pcountparticleorig, 4) = 4
            END IF
            mag = SQR((i ^ 2) + (j ^ 2) + (k ^ 2)) - 3
            IF SQR(mag ^ 2) < .1 AND i < 2 THEN
                pcountparticleorig = pcountparticleorig + 1
                vec(pcountparticleorig, 1) = i - 5
                vec(pcountparticleorig, 2) = j
                vec(pcountparticleorig, 3) = k
                vec(pcountparticleorig, 4) = 5
            END IF
        NEXT
    NEXT
NEXT
FOR i = -3 TO 2
    pcountparticleorig = pcountparticleorig + 1
    vec(pcountparticleorig, 1) = i: vec(pcountparticleorig, 2) = -3: vec(pcountparticleorig, 3) = -3: vec(pcountparticleorig, 4) = 2
    pcountparticleorig = pcountparticleorig + 1
    vec(pcountparticleorig, 1) = i: vec(pcountparticleorig, 2) = -3: vec(pcountparticleorig, 3) = 3: vec(pcountparticleorig, 4) = 2
    pcountparticleorig = pcountparticleorig + 1
    vec(pcountparticleorig, 1) = i: vec(pcountparticleorig, 2) = 3: vec(pcountparticleorig, 3) = -3: vec(pcountparticleorig, 4) = 2
    pcountparticleorig = pcountparticleorig + 1
    vec(pcountparticleorig, 1) = i: vec(pcountparticleorig, 2) = 3: vec(pcountparticleorig, 3) = 3: vec(pcountparticleorig, 4) = 2
NEXT
RETURN

genscheme.3denvdoublets:
pcountdoubletorig = 0
pcountdoubletorig = pcountdoubletorig + 1
doubletorig(pcountdoubletorig, 1) = 5
doubletorig(pcountdoubletorig, 2) = 0
doubletorig(pcountdoubletorig, 3) = 0
doubletorig(pcountdoubletorig, 4) = 30
doubletorig(pcountdoubletorig, 5) = 0
doubletorig(pcountdoubletorig, 6) = 0
doubletorig(pcountdoubletorig, 7) = 14
FOR j = 1 TO 5
    pcountdoubletorig = pcountdoubletorig + 1
    doubletorig(pcountdoubletorig, 1) = 5
    doubletorig(pcountdoubletorig, 2) = -20
    doubletorig(pcountdoubletorig, 3) = j
    doubletorig(pcountdoubletorig, 4) = 5
    doubletorig(pcountdoubletorig, 5) = 20
    doubletorig(pcountdoubletorig, 6) = j
    doubletorig(pcountdoubletorig, 7) = 13
NEXT
FOR j = 1 TO 5
    pcountdoubletorig = pcountdoubletorig + 1
    doubletorig(pcountdoubletorig, 1) = 15
    doubletorig(pcountdoubletorig, 2) = j
    doubletorig(pcountdoubletorig, 3) = -20
    doubletorig(pcountdoubletorig, 4) = 15
    doubletorig(pcountdoubletorig, 5) = j
    doubletorig(pcountdoubletorig, 6) = 20
    doubletorig(pcountdoubletorig, 7) = 4
NEXT
'dot grid
pcountparticleorig = 0
FOR i = -20 TO 20 STEP 2
    FOR j = -20 TO 20 STEP 2
        FOR k = -20 TO 20 STEP 5
            pcountparticleorig = pcountparticleorig + 1
            vec(pcountparticleorig, 1) = i
            vec(pcountparticleorig, 2) = j
            vec(pcountparticleorig, 3) = k
            vec(pcountparticleorig, 4) = 6
        NEXT
    NEXT
NEXT
RETURN

genscheme.3denvtriplets:
pcounttripletorig = 0
'cubes
length = 5
cubecenterx = 0: cubecentery = 0: cubecenterz = -15: GOSUB genscheme.3denvtriplets.makecube
cubecenterx = 20: cubecentery = 15: cubecenterz = -15: GOSUB genscheme.3denvtriplets.makecube
cubecenterx = 40: cubecentery = 0: cubecenterz = -25: GOSUB genscheme.3denvtriplets.makecube
RETURN

genscheme.3denvtriplets.makecube:
basepointx = cubecenterx + length
basepointy = cubecentery + length
basepointz = cubecenterz - length
rightpointx = cubecenterx + length
rightpointy = cubecentery - length
rightpointz = cubecenterz - length
leftpointx = cubecenterx - length
leftpointy = cubecentery + length
leftpointz = cubecenterz - length
panelcolor = INT(RND * 14) + 1
GOSUB create.original.triangle
basepointx = cubecenterx - length
basepointy = cubecentery + length
basepointz = cubecenterz - length
rightpointx = cubecenterx + length
rightpointy = cubecentery - length
rightpointz = cubecenterz - length
leftpointx = cubecenterx - length
leftpointy = cubecentery - length
leftpointz = cubecenterz - length
'panelcolor = 9
GOSUB create.original.triangle
basepointx = cubecenterx - length
basepointy = cubecentery + length
basepointz = cubecenterz - length
rightpointx = cubecenterx - length
rightpointy = cubecentery - length
rightpointz = cubecenterz - length
leftpointx = cubecenterx - length
leftpointy = cubecentery + length
leftpointz = cubecenterz + length
panelcolor = INT(RND * 14) + 1
GOSUB create.original.triangle
basepointx = cubecenterx - length
basepointy = cubecentery + length
basepointz = cubecenterz + length
rightpointx = cubecenterx - length
rightpointy = cubecentery - length
rightpointz = cubecenterz - length
leftpointx = cubecenterx - length
leftpointy = cubecentery - length
leftpointz = cubecenterz + length
'panelcolor = 10
GOSUB create.original.triangle
basepointx = cubecenterx - length
basepointy = cubecentery - length
basepointz = cubecenterz - length
rightpointx = cubecenterx + length
rightpointy = cubecentery - length
rightpointz = cubecenterz - length
leftpointx = cubecenterx - length
leftpointy = cubecentery - length
leftpointz = cubecenterz + length
panelcolor = INT(RND * 14) + 1
GOSUB create.original.triangle
basepointx = cubecenterx - length
basepointy = cubecentery - length
basepointz = cubecenterz + length
rightpointx = cubecenterx + length
rightpointy = cubecentery - length
rightpointz = cubecenterz - length
leftpointx = cubecenterx + length
leftpointy = cubecentery - length
leftpointz = cubecenterz + length
'panelcolor = 11
GOSUB create.original.triangle
basepointx = cubecenterx - length
basepointy = cubecentery + length
basepointz = cubecenterz + length
rightpointx = cubecenterx - length
rightpointy = cubecentery - length
rightpointz = cubecenterz + length
leftpointx = cubecenterx + length
leftpointy = cubecentery + length
leftpointz = cubecenterz + length
panelcolor = INT(RND * 14) + 1
GOSUB create.original.triangle
basepointx = cubecenterx + length
basepointy = cubecentery + length
basepointz = cubecenterz + length
rightpointx = cubecenterx - length
rightpointy = cubecentery - length
rightpointz = cubecenterz + length
leftpointx = cubecenterx + length
leftpointy = cubecentery - length
leftpointz = cubecenterz + length
'panelcolor = 12
GOSUB create.original.triangle
basepointx = cubecenterx + length
basepointy = cubecentery - length
basepointz = cubecenterz - length
rightpointx = cubecenterx + length
rightpointy = cubecentery + length
rightpointz = cubecenterz - length
leftpointx = cubecenterx + length
leftpointy = cubecentery - length
leftpointz = cubecenterz + length
panelcolor = INT(RND * 14) + 1
GOSUB create.original.triangle
basepointx = cubecenterx + length
basepointy = cubecentery - length
basepointz = cubecenterz + length
rightpointx = cubecenterx + length
rightpointy = cubecentery + length
rightpointz = cubecenterz - length
leftpointx = cubecenterx + length
leftpointy = cubecentery + length
leftpointz = cubecenterz + length
'panelcolor = 13
GOSUB create.original.triangle
basepointx = cubecenterx + length
basepointy = cubecentery + length
basepointz = cubecenterz - length
rightpointx = cubecenterx - length
rightpointy = cubecentery + length
rightpointz = cubecenterz - length
leftpointx = cubecenterx + length
leftpointy = cubecentery + length
leftpointz = cubecenterz + length
panelcolor = INT(RND * 14) + 1
GOSUB create.original.triangle
basepointx = cubecenterx + length
basepointy = cubecentery + length
basepointz = cubecenterz + length
rightpointx = cubecenterx - length
rightpointy = cubecentery + length
rightpointz = cubecenterz - length
leftpointx = cubecenterx - length
leftpointy = cubecentery + length
leftpointz = cubecenterz + length
'panelcolor = 14
GOSUB create.original.triangle
RETURN

create.original.triangle:
shrinkfactor = .90
centorigx = (1 / 3) * (basepointx + rightpointx + leftpointx)
centorigy = (1 / 3) * (basepointy + rightpointy + leftpointy)
centorigz = (1 / 3) * (basepointz + rightpointz + leftpointz)
basepointx = centorigx + (shrinkfactor) * (basepointx - centorigx)
basepointy = centorigy + (shrinkfactor) * (basepointy - centorigy)
basepointz = centorigz + (shrinkfactor) * (basepointz - centorigz)
rightpointx = centorigx + (shrinkfactor) * (rightpointx - centorigx)
rightpointy = centorigy + (shrinkfactor) * (rightpointy - centorigy)
rightpointz = centorigz + (shrinkfactor) * (rightpointz - centorigz)
leftpointx = centorigx + (shrinkfactor) * (leftpointx - centorigx)
leftpointy = centorigy + (shrinkfactor) * (leftpointy - centorigy)
leftpointz = centorigz + (shrinkfactor) * (leftpointz - centorigz)
pcounttripletorig = pcounttripletorig + 1
tripletorig(pcounttripletorig, 1) = basepointx
tripletorig(pcounttripletorig, 2) = basepointy
tripletorig(pcounttripletorig, 3) = basepointz
tripletorig(pcounttripletorig, 4) = rightpointx
tripletorig(pcounttripletorig, 5) = rightpointy
tripletorig(pcounttripletorig, 6) = rightpointz
tripletorig(pcounttripletorig, 7) = leftpointx
tripletorig(pcounttripletorig, 8) = leftpointy
tripletorig(pcounttripletorig, 9) = leftpointz
tripletorig(pcounttripletorig, 10) = panelcolor
RETURN

genscheme.animatedsurface.init:
xl = -1.9: xr = 1.9
yl = -1: yr = 1
xl = xl * 4: xr = xr * 4: yl = yl * 4: yr = yr * 4
Dx = .32
Dy = .32
xrange = 1 + INT((-xl + xr) / Dx)
yrange = 1 + INT((-yl + yr) / Dy)
pcountparticleorig = 0
FOR i = xl TO xr STEP Dx
    FOR j = yl TO yr STEP Dy
        pcountparticleorig = pcountparticleorig + 1
        vec(pcountparticleorig, 1) = i
        vec(pcountparticleorig, 2) = j
        vec(pcountparticleorig, 3) = .25 + .25 * COS(i - 2 * T) ^ 2 - .25 * SIN(j - T) ^ 2
        '*'vec(pcountparticleorig, 4) = 14 'use special color scheme
    NEXT
NEXT
RETURN

genscheme.animatedsurface.timeanimate:
T = timevar / 5
pcountparticleorig = 0
FOR i = xl TO xr STEP Dx
    FOR j = yl TO yr STEP Dy
        pcountparticleorig = pcountparticleorig + 1
        vec(pcountparticleorig, 1) = i
        vec(pcountparticleorig, 2) = j
        vec(pcountparticleorig, 3) = .25 + .25 * COS(i - 2 * T) ^ 2 - .25 * SIN(j - T) ^ 2
        '*'vec(pcountparticleorig, 4) = 14 'use special color scheme
    NEXT
NEXT
RETURN

genscheme.animatedpretzel.init:
rho = 4: beta = .5: a = 1: b = 5: L = 4
xl = -L: xr = L
yl = 0: yr = 2 * pi
Dx = .10: Dy = .157
xrange = 1 + INT((-xl + xr) / Dx)
yrange = 1 + INT((-yl + yr) / Dy)
pcountparticleorig = 0
FOR i = xl TO xr STEP Dx
    FOR j = yl TO yr STEP Dy
        pcountparticleorig = pcountparticleorig + 1
        R = rho - (T / 100) * beta * (i ^ 2)
        h = a * SQR(1 - (i / b) ^ 2)
        k = 1 / SQR((2 * beta * i) ^ 2 + R ^ 2)
        vec(pcountparticleorig, 1) = R * COS(i) + h * k * (R * COS(i) - 2 * beta * i * SIN(i)) * COS(j)
        vec(pcountparticleorig, 2) = R * SIN(i) + h * k * (R * SIN(i) + 2 * beta * i * COS(i)) * COS(j)
        vec(pcountparticleorig, 3) = h * SIN(j)
        vec(pcountparticleorig, 4) = 5
    NEXT
NEXT
RETURN

genscheme.animatedpretzel.timeanimate:
T = timevar
pcountparticleorig = 0
FOR i = xl TO xr STEP Dx
    FOR j = yl TO yr STEP Dy
        pcountparticleorig = pcountparticleorig + 1
        R = rho - (T / 100) * beta * (i ^ 2)
        h = a * SQR(1 - (i / b) ^ 2)
        k = 1 / SQR((2 * beta * i) ^ 2 + R ^ 2)
        vec(pcountparticleorig, 1) = R * COS(i) + h * k * (R * COS(i) - 2 * beta * i * SIN(i)) * COS(j)
        vec(pcountparticleorig, 2) = R * SIN(i) + h * k * (R * SIN(i) + 2 * beta * i * COS(i)) * COS(j)
        vec(pcountparticleorig, 3) = h * SIN(j)
        vec(pcountparticleorig, 4) = 5
    NEXT
NEXT
RETURN

genscheme.sphericalharmonics:
xl = 0: xr = pi: Dx = .05
yl = 0: yr = 2 * pi: Dy = .05
xrange = 1 + INT((-xl + xr) / Dx)
yrange = 1 + INT((-yl + yr) / Dy)
L = 0
ml = 0
PRINT " Choose the orbital L value (must be >= 0)."
PRINT: INPUT " Enter a choice: ", L
IF L < 0 THEN L = 0
PRINT
PRINT " Choose the orbital mL value (must have -L < mL < L)."
PRINT: INPUT " Enter a choice: ", ml
IF ml < -L THEN ml = -L
IF ml > L THEN ml = L
pcountparticleorig = 0
FOR i = xl TO xr STEP Dx
    FOR j = yl TO yr STEP Dy
        pcountparticleorig = pcountparticleorig + 1
        x0 = 10 * SIN(i) * COS(j)
        y0 = 10 * SIN(i) * SIN(j)
        z0 = 10 * COS(i)
        SELECT CASE L
            CASE 0
                vec(pcountparticleorig, 1) = x0 * (1 / 2) * SQR(1 / pi)
                vec(pcountparticleorig, 2) = y0 * (1 / 2) * SQR(1 / pi)
                vec(pcountparticleorig, 3) = z0 * (1 / 2) * SQR(1 / pi)
                vec(pcountparticleorig, 4) = 9
            CASE 1
                SELECT CASE ml
                    CASE -1
                        vec(pcountparticleorig, 1) = x0 * (1 / 2) * SQR(3 / pi) * SIN(i) * COS(j)
                        vec(pcountparticleorig, 2) = y0 * (1 / 2) * SQR(3 / pi) * SIN(i) * COS(j)
                        vec(pcountparticleorig, 3) = z0 * (1 / 2) * SQR(3 / pi) * SIN(i) * COS(j)
                        vec(pcountparticleorig, 4) = 9
                    CASE 0
                        vec(pcountparticleorig, 1) = x0 * (1 / 2) * SQR(3 / pi) * COS(i)
                        vec(pcountparticleorig, 2) = y0 * (1 / 2) * SQR(3 / pi) * COS(i)
                        vec(pcountparticleorig, 3) = z0 * (1 / 2) * SQR(3 / pi) * COS(i)
                        vec(pcountparticleorig, 4) = 9
                    CASE 1
                        vec(pcountparticleorig, 1) = x0 * (1 / 2) * SQR(3 / pi) * SIN(i) * COS(j)
                        vec(pcountparticleorig, 2) = y0 * (1 / 2) * SQR(3 / pi) * SIN(i) * COS(j)
                        vec(pcountparticleorig, 3) = z0 * (1 / 2) * SQR(3 / pi) * SIN(i) * COS(j)
                        vec(pcountparticleorig, 4) = 9
                END SELECT
            CASE 2
                SELECT CASE ml
                    CASE -2
                        vec(pcountparticleorig, 1) = x0 * (1 / 2) * SQR(3 / pi) * SIN(i) ^ 2 * COS(2 * j)
                        vec(pcountparticleorig, 2) = y0 * (1 / 2) * SQR(3 / pi) * SIN(i) ^ 2 * COS(2 * j)
                        vec(pcountparticleorig, 3) = z0 * (1 / 2) * SQR(3 / pi) * SIN(i) ^ 2 * COS(2 * j)
                        vec(pcountparticleorig, 4) = 9
                    CASE -1
                        vec(pcountparticleorig, 1) = x0 * (1 / 2) * SQR(3 / pi) * SIN(i) * COS(i) * COS(j)
                        vec(pcountparticleorig, 2) = y0 * (1 / 2) * SQR(3 / pi) * SIN(i) * COS(i) * COS(j)
                        vec(pcountparticleorig, 3) = z0 * (1 / 2) * SQR(3 / pi) * SIN(i) * COS(i) * COS(j)
                        vec(pcountparticleorig, 4) = 9
                    CASE 0
                        vec(pcountparticleorig, 1) = x0 * (1 / 4) * SQR(5 / pi) * (3 * COS(i) ^ 2 - 1)
                        vec(pcountparticleorig, 2) = y0 * (1 / 4) * SQR(5 / pi) * (3 * COS(i) ^ 2 - 1)
                        vec(pcountparticleorig, 3) = z0 * (1 / 4) * SQR(5 / pi) * (3 * COS(i) ^ 2 - 1)
                        vec(pcountparticleorig, 4) = 9
                    CASE 1
                        vec(pcountparticleorig, 1) = x0 * (1 / 2) * SQR(3 / pi) * SIN(i) * COS(i) * COS(j)
                        vec(pcountparticleorig, 2) = y0 * (1 / 2) * SQR(3 / pi) * SIN(i) * COS(i) * COS(j)
                        vec(pcountparticleorig, 3) = z0 * (1 / 2) * SQR(3 / pi) * SIN(i) * COS(i) * COS(j)
                        vec(pcountparticleorig, 4) = 9
                    CASE 2
                        vec(pcountparticleorig, 1) = x0 * (1 / 2) * SQR(3 / pi) * SIN(i) ^ 2 * COS(2 * j)
                        vec(pcountparticleorig, 2) = y0 * (1 / 2) * SQR(3 / pi) * SIN(i) ^ 2 * COS(2 * j)
                        vec(pcountparticleorig, 3) = z0 * (1 / 2) * SQR(3 / pi) * SIN(i) ^ 2 * COS(2 * j)
                        vec(pcountparticleorig, 4) = 9
                END SELECT
            CASE 3
                SELECT CASE ml
                    CASE -3
                    CASE -2
                    CASE -1
                    CASE 0
                    CASE 1
                    CASE 2
                    CASE 3
                END SELECT
            CASE ELSE
                L = 0
                ml = 0
        END SELECT
    NEXT
NEXT
RETURN

genscheme.laplace2d.init:
xl = -5: xr = 5
yl = -7: yr = 7
Dx = .25
Dy = .25
xrange = 1 + INT((-xl + xr) / Dx)
yrange = 1 + INT((-yl + yr) / Dy)
pcountparticleorig = 0
FOR i = xl TO xr STEP Dx
    FOR j = yl TO yr STEP Dy
        pcountparticleorig = pcountparticleorig + 1
        vec(pcountparticleorig, 1) = i
        vec(pcountparticleorig, 2) = j
        vec(pcountparticleorig, 3) = 0
        vec(pcountparticleorig, 4) = 6
    NEXT
NEXT
RETURN

genscheme.laplace2d.gridinit:
pcountparticleorig = 0
FOR i = 1 TO xrange
    FOR j = 1 TO yrange
        pcountparticleorig = pcountparticleorig + 1
        vec2dzfixed(i, j) = -1
        '''
        randnum = RND * 1000
        IF randnum < 40 AND i > xrange * .33 AND i < xrange * .66 AND j > yrange * .33 AND j < yrange * .66 THEN
            vec(pcountparticleorig, 3) = RND * 6
            vec(pcountparticleorig, 4) = 15
            vec2dzfixed(i, j) = 1
        END IF
        IF randnum > 995 THEN
            vec(pcountparticleorig, 3) = -RND * 5
            vec(pcountparticleorig, 4) = 1
            vec2dzfixed(i, j) = 1
        END IF
        '''
        '''
        '        IF i = 1 THEN
        '            vec2dzfixed(i, j) = 1
        '            vec(pcountparticleorig, 3) = pi / 2
        '        END IF
        '        IF i = xrange THEN
        '            vec2dzfixed(i, j) = 1
        '            vec(pcountparticleorig, 3) = 0
        '        END IF
        '        IF j = 1 THEN
        '            vec2dzfixed(i, j) = 1
        '            vec(pcountparticleorig, 3) = pi / 2
        '        END IF
        '        IF j = yrange THEN
        '            vec2dzfixed(i, j) = 1
        '            vec(pcountparticleorig, 3) = pi / 2
        '        END IF
        '''
    NEXT
NEXT
RETURN

genscheme.laplace2d.timeanimate:
'delinearize
pcountparticleorig = 0
FOR i = 1 TO xrange
    FOR j = 1 TO yrange
        pcountparticleorig = pcountparticleorig + 1
        vec2dztemp(i, j) = vec(pcountparticleorig, 3)
    NEXT
NEXT
'begin relax process
FOR i = 2 TO xrange - 1 'boDy, no edges
    FOR j = 2 TO yrange - 1
        IF vec2dzfixed(i, j) = -1 THEN
            rx1 = vec2dztemp(i + 1, j)
            rx2 = vec2dztemp(i - 1, j)
            rx3 = vec2dztemp(i, j - 1)
            rx4 = vec2dztemp(i, j + 1)
            vec2dz(i, j) = (1 / 4) * (rx1 + rx2 + rx3 + rx4)
        END IF
    NEXT
NEXT
FOR j = 2 TO yrange - 1 'left edge, right edge, no corners
    i = 1
    IF vec2dzfixed(i, j) = -1 THEN
        rx1 = vec2dztemp(i + 1, j)
        rx3 = vec2dztemp(i, j - 1)
        rx4 = vec2dztemp(i, j + 1)
        vec2dz(i, j) = (1 / 3) * (rx1 + rx3 + rx4)
    END IF
    i = xrange
    IF vec2dzfixed(i, j) = -1 THEN
        rx2 = vec2dztemp(i - 1, j)
        rx3 = vec2dztemp(i, j - 1)
        rx4 = vec2dztemp(i, j + 1)
        vec2dz(i, j) = (1 / 3) * (rx2 + rx3 + rx4)
    END IF
NEXT
FOR i = 2 TO xrange - 1 'top edge, bottom edge, no corners
    j = 1
    IF vec2dzfixed(i, j) = -1 THEN
        rx1 = vec2dztemp(i + 1, j)
        rx2 = vec2dztemp(i - 1, j)
        rx4 = vec2dztemp(i, j + 1)
        vec2dz(i, j) = (1 / 3) * (rx1 + rx2 + rx4)
    END IF
    j = yrange
    IF vec2dzfixed(i, j) = -1 THEN
        rx1 = vec2dztemp(i + 1, j)
        rx2 = vec2dztemp(i - 1, j)
        rx3 = vec2dztemp(i, j - 1)
        vec2dz(i, j) = (1 / 3) * (rx1 + rx2 + rx3)
    END IF
NEXT
'four corners
IF vec2dzfixed(1, 1) = -1 THEN vec2dz(1, 1) = (1 / 2) * (vec2dztemp(1, 2) + vec2dztemp(2, 1))
IF vec2dzfixed(xrange, 1) = -1 THEN vec2dz(xrange, 1) = (1 / 2) * (vec2dztemp(xrange - 1, 1) + vec2dztemp(xrange, 2))
IF vec2dzfixed(1, yrange) = -1 THEN vec2dz(1, yrange) = (1 / 2) * (vec2dztemp(2, yrange) + vec2dztemp(1, yrange - 1))
IF vec2dzfixed(xrange, yrange) = -1 THEN vec2dz(xrange, yrange) = (1 / 2) * (vec2dztemp(xrange - 1, yrange) + vec2dztemp(xrange, yrange - 1))
'relinearize
pcountparticleorig = 0
FOR i = 1 TO xrange
    FOR j = 1 TO yrange
        pcountparticleorig = pcountparticleorig + 1
        IF vec2dzfixed(i, j) = -1 THEN vec(pcountparticleorig, 3) = vec2dz(i, j)
        IF vec2dz(i, j) > 2 THEN vec(pcountparticleorig, 4) = 15
        IF vec2dz(i, j) < -1 THEN vec(pcountparticleorig, 4) = 1
    NEXT
NEXT
RETURN

genscheme.planet.init:
planetradius = 5
Dx = .0628
Dy = .0628
xl = 0: xr = 2 * pi
yl = 0: yr = pi
xrange = 1 + INT((-xl + xr) / Dx)
yrange = 1 + INT((-yl + yr) / Dy)
pcountparticleorig = 0
FOR i = 1 TO xrange
    FOR j = 1 TO yrange
        pcountparticleorig = pcountparticleorig + 1
        theta = i * Dx - Dx
        phi = j * Dy - Dy
        vec(pcountparticleorig, 1) = planetradius * SIN(phi) * COS(theta)
        vec(pcountparticleorig, 2) = planetradius * SIN(phi) * SIN(theta)
        vec(pcountparticleorig, 3) = planetradius * COS(phi)
        vec(pcountparticleorig, 4) = 2
        'randnum = RND * 1000
        'IF randnum > 600 THEN vec(pcountparticleorig, 4) = 2
    NEXT
NEXT
RETURN

genscheme.planet.gridinit:
pcountparticleorig = 0
FOR i = 1 TO xrange
    FOR j = 1 TO yrange
        pcountparticleorig = pcountparticleorig + 1
        theta = i * Dx - Dx
        phi = j * Dy - Dy
        vec2dsfixed(i, j) = -1
        IF phi > pi / 8 AND phi < pi - pi / 8 THEN
            randnum = RND * 1000
            IF randnum < 20 THEN
                plrad = planetradius + RND * 1.25
                vec(pcountparticleorig, 1) = plrad * SIN(phi) * COS(theta)
                vec(pcountparticleorig, 2) = plrad * SIN(phi) * SIN(theta)
                vec(pcountparticleorig, 3) = plrad * COS(phi)
                vec2dsfixed(i, j) = 1
            END IF
            IF randnum > 980 THEN
                plrad = planetradius - RND * 1.25
                vec(pcountparticleorig, 1) = plrad * SIN(phi) * COS(theta)
                vec(pcountparticleorig, 2) = plrad * SIN(phi) * SIN(theta)
                vec(pcountparticleorig, 3) = plrad * COS(phi)
                vec2dsfixed(i, j) = 1
            END IF
            vec(pcountparticleorig, 4) = 2
        ELSE
            vec(pcountparticleorig, 4) = 15
        END IF
    NEXT
NEXT
RETURN

genscheme.planet.timeanimate:
pcountparticleorig = 0
FOR i = 1 TO xrange
    FOR j = 1 TO yrange
        pcountparticleorig = pcountparticleorig + 1
        vec2dstemp(i, j) = SQR(vec(pcountparticleorig, 1) ^ 2 + vec(pcountparticleorig, 2) ^ 2 + vec(pcountparticleorig, 3) ^ 2)
    NEXT
NEXT
'begin relax process
FOR i = 2 TO xrange - 1 'boDy, no seam
    FOR j = 2 TO yrange - 1
        IF vec2dsfixed(i, j) = -1 THEN
            rx1 = vec2dstemp(i + 1, j)
            rx2 = vec2dstemp(i - 1, j)
            rx3 = vec2dstemp(i, j - 1)
            rx4 = vec2dstemp(i, j + 1)
            vec2ds(i, j) = (1 / 4) * (rx1 + rx2 + rx3 + rx4)
        END IF
    NEXT
NEXT
FOR j = 2 TO yrange - 1 'seam
    IF vec2dsfixed(1, j) = -1 THEN
        rx1 = vec2dstemp(2, j)
        rx2 = vec2dstemp(xrange, j)
        rx3 = vec2dstemp(1, j - 1)
        rx4 = vec2dstemp(1, j + 1)
        vec2ds(1, j) = (1 / 4) * (rx1 + rx2 + rx3 + rx4)
    END IF
    IF vec2dsfixed(xrange, j) = -1 THEN
        rx1 = vec2dstemp(1, j)
        rx2 = vec2dstemp(xrange - 1, j)
        rx3 = vec2dstemp(xrange, j - 1)
        rx4 = vec2dstemp(xrange, j + 1)
        vec2ds(xrange, j) = (1 / 4) * (rx1 + rx2 + rx3 + rx4)
    END IF
NEXT
'relinearize
pcountparticleorig = 0
FOR i = 1 TO xrange
    FOR j = 1 TO yrange
        pcountparticleorig = pcountparticleorig + 1
        IF vec2dsfixed(i, j) = -1 AND j <> 1 AND j <> yrange THEN
            vec(pcountparticleorig, 1) = vec(pcountparticleorig, 1) * vec2ds(i, j) / vec2dstemp(i, j)
            vec(pcountparticleorig, 2) = vec(pcountparticleorig, 2) * vec2ds(i, j) / vec2dstemp(i, j)
            vec(pcountparticleorig, 3) = vec(pcountparticleorig, 3) * vec2ds(i, j) / vec2dstemp(i, j)
        END IF
        SELECT CASE SQR(vec(pcountparticleorig, 1) ^ 2 + vec(pcountparticleorig, 2) ^ 2 + vec(pcountparticleorig, 3) ^ 2)
            CASE IS > planetradius + 0.25
                vec(pcountparticleorig, 4) = 6
            CASE IS < planetradius - 0.25
                vec(pcountparticleorig, 4) = 1
        END SELECT
    NEXT
NEXT
RETURN

genscheme.wave2d.init:
xl = -1.9: xr = 1.9
yl = -1: yr = 1
xl = xl * 4: xr = xr * 4: yl = yl * 4: yr = yr * 4
Dx = .32
Dy = .32
xrange = 1 + INT((-xl + xr) / Dx)
yrange = 1 + INT((-yl + yr) / Dy)
alpha = .25
pcountparticleorig = 0
FOR i = xl TO xr STEP Dx
    FOR j = yl TO yr STEP Dy
        pcountparticleorig = pcountparticleorig + 1
        vec(pcountparticleorig, 1) = i
        vec(pcountparticleorig, 2) = j
        vec(pcountparticleorig, 3) = 0
        '*' vec(pcountparticleorig, 4) = 14 'use special color scheme
    NEXT
NEXT
RETURN

genscheme.wave2d.gridinit:
'delinearize
pcountparticleorig = 0
FOR i = 1 TO xrange
    FOR j = 1 TO yrange
        pcountparticleorig = pcountparticleorig + 1
        vec2dztemp(i, j) = vec(pcountparticleorig, 3)
    NEXT
NEXT
'initial position condition
'FOR i = 1 TO xrange 'random high points
'  FOR j = 1 TO yrange
'      nrand = RND * 1000
'      IF nrand < 10 THEN
'          vec2dz(i, j) = 5
'      END IF
'  NEXT
'NEXT
'vec2dz(xrange * .8, yrange * .2) = -2.5 'single plucked point
'FOR i = 1 TO xrange 'cross arm
'   vec2dz(i, yrange / 3) = 2
'NEXT
'FOR j = 1 TO yrange 'cross arm
'   vec2dz(xrange / 2, j) = 1
'NEXT
'sync
pcountparticleorig = 0
FOR i = 1 TO xrange
    FOR j = 1 TO yrange
        pcountparticleorig = pcountparticleorig + 1
        vec2dzprev(i, j) = vec2dz(i, j)
        vec2dztemp(i, j) = vec2dz(i, j)
    NEXT
NEXT
'initial velocity condition
vec2dzprev(xrange * .8, yrange * .8) = 1.5 'single struck point
'relinearize
pcountparticleorig = 0
FOR i = 1 TO xrange
    FOR j = 1 TO yrange
        pcountparticleorig = pcountparticleorig + 1
        vec(pcountparticleorig, 3) = vec2dz(i, j)
    NEXT
NEXT
RETURN

genscheme.wave2d.timeanimate:
'delinearize
pcountparticleorig = 0
FOR i = 1 TO xrange
    FOR j = 1 TO yrange
        pcountparticleorig = pcountparticleorig + 1
        vec2dztemp(i, j) = vec(pcountparticleorig, 3)
    NEXT
NEXT
'begin propagation process
FOR i = 2 TO xrange - 1 'boDy, no edges
    FOR j = 2 TO yrange - 1
        wp1 = alpha * (vec2dztemp(i + 1, j) + vec2dztemp(i - 1, j)) + 2 * (1 - alpha) * vec2dztemp(i, j) - vec2dzprev(i, j)
        wp2 = alpha * (vec2dztemp(i, j + 1) + vec2dztemp(i, j - 1)) + 2 * (1 - alpha) * vec2dztemp(i, j) - vec2dzprev(i, j)
        vec2dz(i, j) = (1 / 2) * (wp1 + wp2)
    NEXT
NEXT
'comment out this section for fixed edges (or pieces of this section)
i = 1 'left edge
FOR j = 2 TO yrange - 1
    wfp = vec2dztemp(i, j)
    wp1 = alpha * (vec2dztemp(i + 1, j) + wfp) + 2 * (1 - alpha) * vec2dztemp(i, j) - vec2dzprev(i, j)
    wp2 = alpha * (vec2dztemp(i, j + 1) + vec2dztemp(i, j - 1)) + 2 * (1 - alpha) * vec2dztemp(i, j) - vec2dzprev(i, j)
    'vec2dz(i, j) = (1 / 2) * (wp1 + wp2)
NEXT
i = xrange 'right edge
FOR j = 2 TO yrange - 1
    wfp = vec2dztemp(i, j)
    wp1 = alpha * (wfp + vec2dztemp(i - 1, j)) + 2 * (1 - alpha) * vec2dztemp(i, j) - vec2dzprev(i, j)
    wp2 = alpha * (vec2dztemp(i, j + 1) + vec2dztemp(i, j - 1)) + 2 * (1 - alpha) * vec2dztemp(i, j) - vec2dzprev(i, j)
    vec2dz(i, j) = (1 / 2) * (wp1 + wp2)
NEXT
j = 1 'bottom edge
FOR i = 2 TO xrange - 1
    wfp = vec2dztemp(i, j)
    wp2 = alpha * (vec2dztemp(i, j + 1) + wfp) + 2 * (1 - alpha) * vec2dztemp(i, j) - vec2dzprev(i, j)
    wp1 = alpha * (vec2dztemp(i + 1, j) + vec2dztemp(i - 1, j)) + 2 * (1 - alpha) * vec2dztemp(i, j) - vec2dzprev(i, j)
    vec2dz(i, j) = (1 / 2) * (wp1 + wp2)
NEXT
j = yrange 'top edge
FOR i = 2 TO xrange - 1
    wfp = vec2dztemp(i, j)
    wp2 = alpha * (wfp + vec2dztemp(i, j - 1)) + 2 * (1 - alpha) * vec2dztemp(i, j) - vec2dzprev(i, j)
    wp1 = alpha * (vec2dztemp(i + 1, j) + vec2dztemp(i - 1, j)) + 2 * (1 - alpha) * vec2dztemp(i, j) - vec2dzprev(i, j)
    vec2dz(i, j) = (1 / 2) * (wp1 + wp2)
NEXT
'bottom left corner
i = 1: j = 1
wfp1 = vec2dztemp(i, j)
wfp2 = vec2dztemp(i, j)
wp1 = alpha * (vec2dztemp(i + 1, j) + wfp1) + 2 * (1 - alpha) * vec2dztemp(i, j) - vec2dzprev(i, j)
wp2 = alpha * (vec2dztemp(i, j + 1) + wfp2) + 2 * (1 - alpha) * vec2dztemp(i, j) - vec2dzprev(i, j)
'vec2dz(i, j) = (1 / 2) * (wp1 + wp2)
'bottom right corner
i = xrange: j = 1
wfp1 = vec2dztemp(i, j)
wfp2 = vec2dztemp(i, j)
wp1 = alpha * (wfp1 + vec2dztemp(i - 1, j)) + 2 * (1 - alpha) * vec2dztemp(i, j) - vec2dzprev(i, j)
wp2 = alpha * (vec2dztemp(i, j + 1) + wfp2) + 2 * (1 - alpha) * vec2dztemp(i, j) - vec2dzprev(i, j)
vec2dz(i, j) = (1 / 2) * (wp1 + wp2)
'top left corner
i = 1: j = yrange
wfp1 = vec2dztemp(i, j)
wfp2 = vec2dztemp(i, j)
wp1 = alpha * (vec2dztemp(i + 1, j) + wfp1) + 2 * (1 - alpha) * vec2dztemp(i, j) - vec2dzprev(i, j)
wp2 = alpha * (wfp2 + vec2dztemp(i, j - 1)) + 2 * (1 - alpha) * vec2dztemp(i, j) - vec2dzprev(i, j)
'vec2dz(i, j) = (1 / 2) * (wp1 + wp2)
'top right corner
i = xrange: j = yrange
wfp1 = vec2dztemp(i, j)
wfp2 = vec2dztemp(i, j)
wp1 = alpha * (wfp1 + vec2dztemp(i - 1, j)) + 2 * (1 - alpha) * vec2dztemp(i, j) - vec2dzprev(i, j)
wp2 = alpha * (wfp2 + vec2dztemp(i, j - 1)) + 2 * (1 - alpha) * vec2dztemp(i, j) - vec2dzprev(i, j)
vec2dz(i, j) = (1 / 2) * (wp1 + wp2)
'start special movements
T = timevar / 5
IF T < pi THEN 'wave left edge just once
    FOR j = 1 TO yrange
        i = 1
        vec2dz(i, j) = (j / yrange) * 1.5 * SIN(T)
    NEXT
END IF
IF T < pi THEN 'wave bottom edge just once
    FOR i = 1 TO xrange
        j = 1
        vec2dz(i, j) = (i / xrange) * .45 * SIN(T)
    NEXT
END IF
'relinearize
pcountparticleorig = 0
FOR i = 1 TO xrange
    FOR j = 1 TO yrange
        pcountparticleorig = pcountparticleorig + 1
        vec2dzprev(i, j) = vec2dztemp(i, j)
        vec2dztemp(i, j) = vec2dz(i, j)
        vec(pcountparticleorig, 3) = vec2dz(i, j)
    NEXT
NEXT
RETURN

genscheme.wave2dinf.init:
xl = -12: xr = 12
yl = -12: yr = 12
Dx = .33
Dy = .33
xrange = 1 + INT((-xl + xr) / Dx)
yrange = 1 + INT((-yl + yr) / Dy)
alpha = .25
pcountparticleorig = 0
FOR i = xl TO xr STEP Dx
    FOR j = yl TO yr STEP Dy
        pcountparticleorig = pcountparticleorig + 1
        vec(pcountparticleorig, 1) = i
        vec(pcountparticleorig, 2) = j
        vec(pcountparticleorig, 3) = 0
        vec(pcountparticleorig, 4) = 1
    NEXT
NEXT
RETURN

genscheme.wave2dinf.gridinit:
'delinearize
pcountparticleorig = 0
FOR i = 1 TO xrange
    FOR j = 1 TO yrange
        pcountparticleorig = pcountparticleorig + 1
        vec2dzfixed(i, j) = -1
        vec2dztemp(i, j) = vec(pcountparticleorig, 3)
    NEXT
NEXT
'set edge damping constants
xrdamp = INT(xrange / 10)
yrdamp = INT(yrange / 10)
'create fixed heights
FOR j = 1 TO INT(yrange / 2 - 3)
    FOR i = INT(xrange / 3 - 5) TO INT(xrange / 3 - 3)
        vec2dzfixed(i, j) = 1
        vec2dz(i, j) = 0
    NEXT
NEXT
FOR j = INT(yrange / 2 + 3) TO yrange
    FOR i = INT(xrange / 3 - 5) TO INT(xrange / 3 - 3)
        vec2dzfixed(i, j) = 1
        vec2dz(i, j) = 0
    NEXT
NEXT
'initial position condition
'FOR i = 1 TO xrange 'random high points
'   FOR j = 1 TO yrange
'       nrand = RND * 1000
'       IF nrand < 10 THEN
'           vec2dz(i, j) = 1
'       END IF
'   NEXT
'NEXT
'i = xrange / 2: j = yrange / 2: vec2dz(i, j) = 8 'pluck middle
'sync
pcountparticleorig = 0
FOR i = 1 TO xrange
    FOR j = 1 TO yrange
        pcountparticleorig = pcountparticleorig + 1
        vec2dzprev(i, j) = vec2dz(i, j)
        vec2dztemp(i, j) = vec2dz(i, j)
    NEXT
NEXT
'initial velocity condition
'vec2dzprev(xrange / 2, yrange / 2) = 1.5 'single struck point
'relinearize
pcountparticleorig = 0
FOR i = 1 TO xrange
    FOR j = 1 TO yrange
        pcountparticleorig = pcountparticleorig + 1
        vec(pcountparticleorig, 3) = vec2dz(i, j)
        IF i < xrdamp THEN vec(pcountparticleorig, 4) = 8
        IF i > xrange - xrdamp THEN vec(pcountparticleorig, 4) = 8
        IF j < yrdamp THEN vec(pcountparticleorig, 4) = 8
        IF j > yrange - yrdamp THEN vec(pcountparticleorig, 4) = 8
        IF vec2dzfixed(i, j) = 1 THEN vec(pcountparticleorig, 4) = 4
    NEXT
NEXT
RETURN

genscheme.wave2dinf.timeanimate:
'delinearize
pcountparticleorig = 0
FOR i = 1 TO xrange
    FOR j = 1 TO yrange
        pcountparticleorig = pcountparticleorig + 1
        vec2dztemp(i, j) = vec(pcountparticleorig, 3)
    NEXT
NEXT
'start pre-propagation special movements
T = timevar
IF RND * 250 < 10 THEN 'rain drops
    i = INT(RND * xrange - xrdamp - 2) + xrdamp + 2
    j = INT(RND * yrange - yrdamp - 2) + yrdamp + 2
    'IF vec2dzfixed(i, j) = -1 THEN vec2dzprev(i, j) = -2 'set velocity or
    IF vec2dzfixed(i, j) = -1 THEN vec2dztemp(i, j) = 2 'set position
END IF
'begin propagation process
FOR i = 2 TO xrange - 1 'boDy, no edges
    FOR j = 2 TO yrange - 1
        vp1 = vec2dztemp(i + 1, j)
        vp2 = vec2dztemp(i - 1, j)
        vp3 = vec2dztemp(i, j + 1)
        vp4 = vec2dztemp(i, j - 1)
        IF vec2dzfixed(i + 1, j) = 1 THEN vp1 = 0
        IF vec2dzfixed(i - 1, j) = 1 THEN vp2 = 0
        IF vec2dzfixed(i, j + 1) = 1 THEN vp3 = 0
        IF vec2dzfixed(i, j - 1) = 1 THEN vp4 = 0
        wp1 = alpha * (vp1 + vp2) + 2 * (1 - alpha) * vec2dztemp(i, j) - vec2dzprev(i, j)
        wp2 = alpha * (vp3 + vp4) + 2 * (1 - alpha) * vec2dztemp(i, j) - vec2dzprev(i, j)
        vec2dz(i, j) = (1 / 2) * (wp1 + wp2)
    NEXT
NEXT
'damp out motion at edges
'left edge
FOR j = 2 TO yrange - 1
    FOR i = xrdamp TO 2 STEP -1
        vec2dz(i, j) = (1 / 4) * (vec2dztemp(i, j) + vec2dztemp(i + 1, j) + vec2dztemp(i, j + 1) + vec2dztemp(i, j - 1))
    NEXT
NEXT
'right edge
FOR j = 2 TO yrange - 1
    FOR i = (xrange - xrdamp) TO (xrange - 1)
        vec2dz(i, j) = (1 / 4) * (vec2dztemp(i, j) + vec2dztemp(i - 1, j) + vec2dztemp(i, j + 1) + vec2dztemp(i, j - 1))
    NEXT
NEXT
'bottom edge
FOR i = 2 TO xrange - 1
    FOR j = yrdamp TO 2 STEP -1
        vec2dz(i, j) = (1 / 4) * (vec2dztemp(i, j) + vec2dztemp(i, j + 1) + vec2dztemp(i + 1, j) + vec2dztemp(i - 1, j))
    NEXT
NEXT
'top edge
FOR i = 2 TO xrange - 1
    FOR j = (yrange - yrdamp) TO (yrange - 1)
        vec2dz(i, j) = (1 / 4) * (vec2dztemp(i, j) + vec2dztemp(i, j - 1) + vec2dztemp(i + 1, j) + vec2dztemp(i - 1, j))
    NEXT
NEXT
'adjust for error caused by boundary conditions
nrbcerr = 0
FOR j = 1 TO yrange
    nrbcerr = nrbcerr + vec2dz(xrange - 1, j)
    nrbcerr = nrbcerr + vec2dz(2, j)
NEXT
FOR i = 1 TO xrange
    nrbcerr = nrbcerr + vec2dz(i, yrange - 1)
    nrbcerr = nrbcerr + vec2dz(i, 2)
NEXT
nrbcerr = nrbcerr / (2 * xrange + 2 * yrange)
'start post-propagation special movements
'IF t < pi THEN 'wave middle just once
'   i = xrange / 2
'   j = yrange / 2
'   vec2dz(i, j) = -4.5 * SIN(t)
'END IF
'IF t < pi THEN 'wave some place
FOR j = 1 + 2.5 * yrdamp TO yrange - 2.5 * yrdamp
    i = xrdamp + 1
    vec2dz(i, j) = .75 * SIN(.5 * T)
NEXT
'END IF
'relinearize and correct for nonreflecting boundary condition error
pcountparticleorig = 0
FOR i = 1 TO xrange
    FOR j = 1 TO yrange
        pcountparticleorig = pcountparticleorig + 1
        vec2dzprev(i, j) = vec2dztemp(i, j) - nrbcerr
        vec2dztemp(i, j) = vec2dz(i, j) - nrbcerr
        IF vec2dzfixed(i, j) = -1 THEN vec(pcountparticleorig, 3) = vec2dz(i, j) - nrbcerr
        IF vec2dzfixed(i, j) = -1 AND i >= xrdamp AND i <= xrange - xrdamp AND j >= yrdamp AND j <= yrange - yrdamp THEN
            IF vec2dz(i, j) > .2 THEN vec(pcountparticleorig, 4) = 9 ELSE vec(pcountparticleorig, 4) = 1
        END IF
    NEXT
NEXT
RETURN

genscheme.bacteria.init:
gridxhalfsize = 50
gridyhalfsize = 50
gridzhalfsize = 50
gridxstep = 2
gridystep = 2
gridzstep = 2
numcreatures1 = numcreatures
numcreatures2 = 0
numcreatures3 = 0
creatureinitrad = 0.5
pcountparticleorig = 0
FOR i = 1 TO numcreatures
    pcountparticleorig = pcountparticleorig + 1
    vec(pcountparticleorig, 5) = .15 'step constant
    vec(pcountparticleorig, 6) = creatureinitrad 'creature radius
    vec(pcountparticleorig, 7) = vec(pcountparticleorig, 6) 'old creature radius
    IF RND > .5 THEN 'determine gender of species 1
        vec(pcountparticleorig, 4) = 9
        vec(pcountparticleorig, 8) = 1 'species 1 male
    ELSE
        vec(pcountparticleorig, 4) = 13
        vec(pcountparticleorig, 8) = 2 'species 1 female
    END IF
    placecreature:
    vec(pcountparticleorig, 1) = RND * (2 * gridxhalfsize) - gridxhalfsize 'x position
    vec(pcountparticleorig, 2) = RND * (2 * gridyhalfsize) - gridyhalfsize 'y position
    vec(pcountparticleorig, 3) = RND * (2 * gridzhalfsize) - gridzhalfsize 'z position
    FOR j = 1 TO i 'initial overlap prevention
        IF i <> j THEN
            deltax = vec(i, 1) - vec(j, 1)
            deltay = vec(i, 2) - vec(j, 2)
            deltaz = vec(i, 3) - vec(j, 3)
            deltar = SQR(deltax ^ 2 + deltay ^ 2 + deltaz ^ 2)
            IF deltar < (vec(i, 6) + vec(j, 6)) THEN GOTO placecreature
        END IF
    NEXT
NEXT
RETURN

genscheme.bacteria.timeanimate:
FOR i = 1 TO numcreatures
    'store old creature radius
    vec(i, 7) = vec(i, 6)
    'determine if creature grows in radius
    IF RND > .66 THEN
        vec(i, 6) = vec(i, 6) * (1 + RND * 0.001)
    END IF
    'creature is too large and explodes
    IF vec(i, 6) > 8 * creatureinitrad THEN
        vec(i, 6) = creatureinitrad
        SELECT CASE vec(i, 8) 'erase creature count of particular species
            CASE 1: numcreatures1 = numcreatures1 - 1
            CASE 2: numcreatures1 = numcreatures1 - 1
            CASE 3: numcreatures2 = numcreatures2 - 1
            CASE 4: numcreatures2 = numcreatures2 - 1
            CASE 5: numcreatures3 = numcreatures3 - 1
            CASE 6: numcreatures3 = numcreatures3 - 1
        END SELECT
        'perform weighted average over species for replacement creature
        j1 = RND * numcreatures1
        j2 = RND * numcreatures2
        j3 = RND * numcreatures3
        IF j1 > j2 AND j1 > j3 THEN
            numcreatures1 = numcreatures1 + 1
            IF RND > .5 THEN
                vec(i, 4) = 9
                vec(i, 8) = 1 'species 1 male
            ELSE
                vec(i, 4) = 13
                vec(i, 8) = 2 'species 1 female
            END IF
        END IF
        IF j2 > j1 AND j2 > j3 THEN
            numcreatures2 = numcreatures2 + 1
            IF RND > .5 THEN
                vec(i, 4) = 14
                vec(i, 8) = 3 'species 2 male
            ELSE
                vec(i, 4) = 15
                vec(i, 8) = 4 'species 2 female
            END IF
        END IF
        IF j3 > j1 AND j3 > j2 THEN
            numcreatures3 = numcreatures3 + 1
            IF RND > .99 THEN
                IF RND > .5 THEN
                    vec(i, 4) = 11
                    vec(i, 8) = 5 'species 3 male
                ELSE
                    vec(i, 4) = 11
                    vec(i, 8) = 6 'species 3 female
                END IF
            END IF
        END IF
    END IF
    'move creature in random direction (to fix)
    creaturexstep = (RND - .5)
    creatureystep = (RND - .5)
    creaturezstep = (RND - .5)
    stepmag = SQR(creaturexstep ^ 2 + creatureystep ^ 2 + creaturezstep ^ 2)
    creaturexstep = creaturexstep / stepmag
    creatureystep = creatureystep / stepmag
    creaturezstep = creaturezstep / stepmag
    vec(i, 1) = vec(i, 1) + creaturexstep * vec(i, 5) * (1 + 1.5 / vec(i, 6))
    vec(i, 2) = vec(i, 2) + creatureystep * vec(i, 5) * (1 + 1.5 / vec(i, 6))
    vec(i, 3) = vec(i, 3) + creaturezstep * vec(i, 5) * (1 + 1.5 / vec(i, 6))
    'collision with wall
    IF vec(i, 1) >= gridxhalfsize THEN vec(i, 1) = vec(i, 1) - creaturexstep
    IF vec(i, 1) <= -gridxhalfsize THEN vec(i, 1) = vec(i, 1) - creaturexstep
    IF vec(i, 2) >= gridyhalfsize THEN vec(i, 2) = vec(i, 2) - creatureystep
    IF vec(i, 2) <= -gridyhalfsize THEN vec(i, 2) = vec(i, 2) - creatureystep
    IF vec(i, 3) >= gridzhalfsize THEN vec(i, 3) = vec(i, 3) - creaturezstep
    IF vec(i, 3) <= -gridzhalfsize THEN vec(i, 3) = vec(i, 3) - creaturezstep
    'ckeck for collision with another creature
    FOR j = 1 TO numcreatures
        IF i <> j THEN
            deltax = vec(i, 1) - vec(j, 1)
            deltay = vec(i, 2) - vec(j, 2)
            deltaz = vec(i, 3) - vec(j, 3)
            deltar = SQR(deltax ^ 2 + deltay ^ 2 + deltaz ^ 2)
            'collision between mature creatures
            IF deltar < (vec(i, 6) + vec(j, 6)) AND vec(i, 6) > 1.5 * creatureinitrad AND vec(j, 6) > 1.5 * creatureinitrad THEN
                IF vec(i, 8) <> vec(j, 8) THEN 'collision between opposing genders
                    vec(i, 1) = vec(i, 1) - creaturexstep
                    vec(i, 2) = vec(i, 2) - creatureystep
                    vec(i, 3) = vec(i, 3) - creaturezstep
                    'species 1 mating
                    IF vec(i, 8) >= 1 AND vec(i, 8) <= 2 AND vec(j, 8) >= 1 AND vec(j, 8) <= 2 THEN
                        IF RND > .95 THEN 'determine if offspring is mutates to species 2
                            numcreatures1 = numcreatures1 - 1
                            numcreatures2 = numcreatures2 + 1
                            IF RND > .5 THEN 'determine gender of species 2
                                vec(i, 4) = 14
                                vec(i, 8) = 3 'species 2 male
                            ELSE
                                vec(i, 4) = 15
                                vec(i, 8) = 4 'species 2 female
                            END IF
                        END IF
                        GOTO donemating
                    END IF
                    'species 2 mating
                    IF vec(i, 8) >= 3 AND vec(i, 8) <= 4 AND vec(j, 8) >= 3 AND vec(j, 8) <= 4 THEN
                        IF RND > .95 THEN 'determine if offspring is mutates to species 3
                            numcreatures2 = numcreatures2 - 1
                            numcreatures3 = numcreatures3 + 1
                            IF RND > .5 THEN 'determine gender of species 3
                                vec(i, 4) = 11
                                vec(i, 8) = 5 'species 3 male
                            ELSE
                                vec(i, 4) = 11
                                vec(i, 8) = 6 'species 3 female
                            END IF
                        END IF
                        GOTO donemating
                    END IF
                    donemating:
                    vec(i, 6) = creatureinitrad
                END IF
            END IF
        END IF
    NEXT
NEXT
RETURN

genscheme.neuron.init:
numneuralnodes = 75
brainsize = 350
pcountparticleorig = 0
FOR i = 1 TO numneuralnodes
    pcountparticleorig = pcountparticleorig + 1
    vec(pcountparticleorig, 1) = brainsize * (RND - .5)
    vec(pcountparticleorig, 2) = brainsize * (RND - .5)
    vec(pcountparticleorig, 3) = brainsize * (RND - .5) / 5
    vec(pcountparticleorig, 4) = 14
    vec(pcountparticleorig, 5) = i 'node index
    vec(pcountparticleorig, 6) = -1 'stimulation index (-1 for no stimulation)
    vec(pcountparticleorig, 7) = 0 'dead time counter
NEXT
FOR i = 1 TO numneuralnodes
    FOR j = 2 TO 21
        pcountparticleorig = pcountparticleorig + 1
        neuronxstep = (RND - .5)
        neuronystep = (RND - .5)
        neuronzstep = (RND - .5)
        stepmag = SQR(neuronxstep ^ 2 + neuronystep ^ 2 + neuronzstep ^ 2)
        neuronxstep = neuronxstep / stepmag
        neuronystep = neuronystep / stepmag
        neuronzstep = neuronzstep / stepmag
        vec(pcountparticleorig, 1) = vec(i, 1) + .25 * neuronxstep * (brainsize * RND)
        vec(pcountparticleorig, 2) = vec(i, 2) + .25 * neuronystep * (brainsize * RND)
        vec(pcountparticleorig, 3) = vec(i, 3) + .25 * neuronzstep * (brainsize * RND) / 3
        vec(pcountparticleorig, 4) = 7
        vec(pcountparticleorig, 5) = i
        vec(pcountparticleorig, 6) = -1
        vec(pcountparticleorig, 7) = 0
    NEXT
NEXT
randomneuron = INT(RND * (pcountparticleorig - numneuralnodes)) + numneuralnodes
vec(randomneuron, 4) = 14
vec(randomneuron, 6) = 1
RETURN

'Things to check:
'Question: is nhat.old a necessary construction?
'Question: is work.nhat a necessary construction?
'Unify snipworkpcount nomenclature
'There is an overall minus sign problem somewhere:
'   doublets and particles clip differenetly for nearplane.
'       This may have been solved. See comment below, too.
' The triplet snipping broke after I started playing with
' the normal vector. The temporary patch is the two calls of
' the function reverse.uvnhat. Triplet viewplane clipping has
' not been retested.
'The 'file' input mode for particle world has not been re-
' tested since the simple time animation setup, June 2013.

genscheme.neuron.timeanimate:
FOR i = 1 TO numparticleorig
    vecpuvsrev(i, 1) = vec(i, 1)
    vecpuvsrev(i, 2) = vec(i, 2)
    vecpuvsrev(i, 3) = vec(i, 3)
    vecpuvsrev(i, 4) = vec(i, 4)
    vecpuvsrev(i, 5) = vec(i, 5)
    vecpuvsrev(i, 6) = vec(i, 6)
    vecpuvsrev(i, 7) = vec(i, 7)
NEXT
FOR i = numneuralnodes + 1 TO numparticleorig
    'single neuron activates whole cluster if cluster is ready
    IF vecpuvsrev(i, 6) = 1 AND vecpuvsrev(vecpuvsrev(i, 5), 6) = -1 AND vecpuvsrev(vecpuvsrev(i, 5), 7) = 0 THEN
        vec(vec(i, 5), 6) = 1
        vec(vec(i, 5), 7) = 3000
        FOR j = numneuralnodes + 1 TO numparticleorig
            IF vecpuvsrev(i, 5) = vecpuvsrev(j, 5) THEN
                vec(j, 4) = 4
                vec(j, 6) = 1
            END IF
        NEXT
    END IF
    'cluster is fully active: probe neighbors and then become inactive
    IF vecpuvsrev(i, 6) = 1 AND vecpuvsrev(vecpuvsrev(i, 5), 6) = 1 THEN
        vec(i, 4) = 7
        vec(i, 6) = -1
        vec(vec(i, 5), 6) = -1
        FOR j = numneuralnodes + 1 TO numparticleorig
            IF vecpuvsrev(i, 5) <> vecpuvsrev(j, 5) THEN
                vecsep = SQR((vecpuvsrev(j, 1) - vecpuvsrev(i, 1)) ^ 2 + (vecpuvsrev(j, 2) - vecpuvsrev(i, 2)) ^ 2 + (vecpuvsrev(j, 3) - vecpuvsrev(i, 3)) ^ 2)
                IF vecsep < 7 AND vecpuvsrev(j, 6) = -1 THEN
                    vec(j, 4) = 7
                    vec(j, 6) = 1
                END IF
            END IF
        NEXT
    END IF
    IF vec(vec(i, 5), 7) > 0 THEN vec(vec(i, 5), 7) = vec(vec(i, 5), 7) - 1
NEXT
RETURN

'*'
