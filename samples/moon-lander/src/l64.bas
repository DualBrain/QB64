' Moon Lander by rfrost@mail.com

$ExeIcon:'./l64_dat/astro.ico'
$Resize:Smooth

DefInt A-Z
Dim Shared a '                                                        angle of craft
Dim Shared a51i '                                                     Area 51 initializations
Dim Shared APdisengage '                                              AutoPilot disengage
Dim Shared ASO '                                                      ascent stage only
Dim Shared auto '                                                     autopilot
Dim Shared background '                                               for instrument panel
Dim Shared bh '                                                       black hole
Dim Shared bhx, bhy '                                                 black hole
Dim Shared bbit '                                                     blinking bit synced to time
Dim Shared bolthit, bolthitf, boltx '                                 Deathstar hit vehicle, feature
Dim Shared borgl, borgr, borgt '                                      left right top, distance
Dim Shared bstyle1, bstyle2 '                                         Borg matrix/lines/Moire
Dim Shared bw '                                                       black and white
Dim Shared c '                                                        usually color
Dim Shared canvas& '                                                  primary screen
Dim Shared cbh '                                                      constant black holes
Dim Shared center '                                                   varies according to gs (graphics start)
Dim Shared chs '                                                      parachute size
Dim Shared contact '                                                  landed
Dim Shared convo '                                                    conversation active LM/CM
Dim Shared cpal '                                                     color palette, normal/green/b&w (32 color kludge/fun)
Dim Shared craft '                                                    color
Dim Shared crash '                                                    layer of debris
Dim Shared cwd, cwsi, cwsd '                                          car wash distance, angles
Dim Shared cybilltime! '                                              time on screen
Dim Shared darkstarc '                                                deathstar color set
Dim Shared darkstars '                                                deathstar spin rate
Dim Shared darkstart '                                                   "      thickness
Dim Shared dead$ '                                                    end condition
Dim Shared debug$ '                                                   messages to God
Dim Shared demo '                                                     ground features compressed
Dim Shared doclock '                                                  it's Howdy Doody time
Dim Shared dosbox '                                                   flag
Dim Shared dsinit '                                                   deathstar
Dim Shared eou '                                                      end of universe
Dim Shared fb$ '                                                      landing feedback/analysis
Dim Shared flx '                                                      US/USSR flag position
Dim Shared fuel, fuel! '                                              color of, quantity left
Dim Shared gh, glmin, glmax '                                         ground height, level
Dim Shared grav! '                                                    gravity
Dim Shared gs '                                                       flight area x start
Dim Shared gstyle '                                                   ground style
Dim Shared inpause '                                                  flag
Dim Shared invincible '                                               impervious to threats
Dim Shared iscd '                                                     don't attempt to write!
Dim Shared jitter '                                                   shift-T to control
Dim Shared LEDc '                                                     color
Dim Shared LEDtri '                                                   tri-color flag
Dim Shared level '                                                    surface is
Dim Shared LGMc '                                                     Little Green Man color
Dim Shared liftoff '                                                  AS only
Dim Shared lmsl '                                                     LM shield/laser color
Dim Shared lob '                                                      landed on Borg
Dim Shared lockfuel '                                                 cheat!
Dim Shared lp, rp, xp, th1, th2 '                                     pads, radar, thrusters
Dim Shared magic '                                                    cheat! (instant landing)
Dim Shared mdelay '                                                   PgUp/PgDn controlled
Dim Shared mpath$
Dim Shared msflag '                                                   making surfaces
Dim Shared mstar '                                                    make stars
Dim Shared nation '                                                   1 US, 2 USSR (flags & fireworks)
Dim Shared ok '                                                       at landing, to plant flag
Dim Shared okrick '                                                   diagnostics
Dim Shared osc '                                                      on screen count
Dim Shared oscar '                                                    semaphore land/sea flags
Dim Shared panelinit '                                                replot flag
Dim Shared paraf '                                                    parachute flag
Dim Shared pload '                                                    panel load flag
Dim Shared porb '                                                     pointers/bargraphs
Dim Shared ptk '                                                      points to kill (gasoline) ExplodeLM
Dim Shared px!, py! '                                                 vehicle position on screen
Dim Shared ra '                                                       random angle
Dim Shared radarf '                                                   radar on/off
Dim Shared rads '                                                     Luna radiation
Dim Shared radiationdeath '                                           flag
Dim Shared rdtime! '                                                  fun with high res screen (my picture)
Dim Shared regen '                                                    all star files
Dim Shared rfx, rfy '                                                 craft jigger
Dim Shared rick '                                                     debug flag
Dim Shared rmin, dmin '                                               stars
Dim Shared settings$ '                                                lander.set
Dim Shared sf '                                                       surface feature
Dim Shared shield '                                                   flag
Dim Shared shoot '                                                    flag
Dim Shared showmap '                                                  locations of things shown at top
Dim Shared sia '                                                      shells in air
Dim Shared skyoff '                                                   for faster performance
Dim Shared slash$
Dim Shared starship '                                                 Enterprise (double shift twice)
Dim Shared ufof '                                                     for ufo
Dim Shared sspinit1, sspinit2 '                                       Surveyor
Dim Shared starfiles '                                                use stars1,2 or 3 (few/med/lots)
Dim Shared starinit '                                                 flag
Dim Shared shipi&, shipx '                                            starship
Dim Shared starstatus '                                               0 off, 1 on, 234 more info
Dim Shared suri '                                                     surface index
Dim Shared sx0, sy0 '                                                 LM radar/laser location
Dim Shared sx1, sy1 '                                                 LM left landing pad
Dim Shared sx2, sy2 '                                                 LM right landing pad
Dim Shared temp '                                                     temperature
Dim Shared thrust! '                                                  0 - 100
Dim Shared tilef '                                                    tile variation
Dim Shared twinkle '                                                  stars
Dim Shared vx!, vy! '                                                 LM velocity
Dim Shared wa1
Dim Shared warp! '                                                    vx! >= 100
Dim Shared wi, wi2 '                                                  width (distance between pads)
Dim Shared wx!, wy! '                                                 vehicle position on screen
Dim Shared x '                                                        = suri + px!
Dim Shared xoff '                                                     offset for v=5-20, Surv & Etna
Dim Shared zoom '                                                     starfield

Dim Shared blue, green, gunmetal, red, gasoline, gray2, white, gray
Dim Shared dred, gold, black2, orange, blue2, yellow, white2

Dim Shared q1, q2, q3, q4, h, t, th, tsix, aspect!, pf! '             constants

q1 = 6400: q2 = 860: q3 = 639: q4 = 349: h = 100: th = 200: t = 10: tsix = 360
pf! = .5: aspect! = 1.4: grav! = 1.6

qt = 2000 '                                                           3 arrays below weren't loading properly with q2
Dim Shared LMx(qt), LMy(qt), LMc(qt) '                                LM+exhaust x,y,color

Dim Shared LMrx(1400), LMry(1400) '                                   LM+exhaust x,y after rotation
Dim Shared LMoc(705), LMci(3) '                                       LM colors,original colors, index
Dim Shared c!(360), s!(360) '                                         sines and cosines
Dim Shared ex(6), ey(6), exv(6), eyv(6), ei(6), ek(6), exl(6) '       sky objects
Dim Shared f$(40) '                                                   support files
Dim Shared mes$(1), omes$(1), sm!(1) '                                messages at screen top
Dim Shared sf(10, 2), sf$(10) '                                       surface features start/end/middle
Dim Shared shx(20), shy(20), sha(20) '                                shells (IBM weapons) x,y,angle
Dim Shared shvx(20), shvy(20), shd(20) '                              velocity, distance
Dim Shared rtl!(2), rtlc(2) '                                         radiation/temperature/lightning
Dim Shared gh(6400) '                                                 ground height

Dim clocka(2) '                                                       clock angles
Dim cmp&(30) '                                                        CM patterns
Dim convo$(50) '                                                      LM/CM
Dim Shared gbuff(800) '                                               DS liftoff
Dim skyset1(t), skyset2(t) '                                          skycrud
Dim Shared p(127, 13), p2(127, 7) '                                   vga and cga fonts
Dim Shared tflags(30)

begin:
GoSub init1
Do
    GoSub init2
    While Len(InKey$): Wend '                                         clear keyboard buffer
    Do: _Limit mdelay
        GoSub Autopilot
        GoSub Plotscreen
        GoSub KeyAndMouse
        If restart Then GoTo begin '                                  restore defaults
        If warp! < 1 Then GoSub CheckHit
    Loop Until contact Or Len(dead$)
    GoSub CheckDead
    If contact Then
        Evaluate savea, a + ma '                                      landing feedback contact/currentø
        wu2! = Timer + 1
        GoSub pause '                                                 landed, Enter for liftoff
        If restart Then GoTo begin '                                  restore defaults
        If k <> 60 Then GoSub CheckDead '                             F2 demo restart
    End If
Loop

CheckDead:
z$ = Left$(Left$(dead$, 1) + " ", 1)
If InStr(" CBE", z$) = 0 Then '                                       not Crashed, Borg, Eaten by BH
    ExplodeLM
    contact = 0
End If
dead$ = ""
Return

Autopilot:
aboveborg = 0
If (ek(2) = -1) Or (ek(2) > h) Then borgt = 0
If (skyoff = 0) And (sy1 < borgt) And (px! > borgl) And (px! < borgr) Then aboveborg = 1
super = 0
If vert Or hover Then
    GoSub GetAlt
    i! = alt! / 8 + pf! '                                             thrust target
    If jitter And (alt! < t) Then i! = i! * 2 '                       optional, faster
    If aboveborg Then i! = 1
    GoSub idealthrust
    thrust! = sbest!
    super = -(sbest! > h) '                                           add side thusters
    If thrust! > h Then thrust! = h
End If
If thrust! < 0 Then thrust! = 0
Return

CutOrOutOfFuel:
If fuel! = 0 Then shield = 0 '                                        shields need fuel
If cut = 0 Then
    cut = 1
    cvy! = vy!
    ctime! = Timer
    tfollow = 0 '                                                     terrain following
    thrust! = 0
End If
Return

idealthrust: '                                                        for hover or descend
If (alt! < pf!) And (jitter = 0) Then i! = .05 '                      soft landing
If hover Then i! = hoverc '                                           target
hoverc = hoverc - Sgn(hoverc) '                                       up/down
fmin! = q1 '                                                          conventient large number (6400)
ma! = (vmass + fuel!) / th '                                          mass (actually 54% fuel)
ts! = s!((a + 270) Mod tsix) / ma! / power
If jitter Then us! = Rnd * t + 1 Else us! = .1
If powerloss Then us! = h
For z! = 0 To (h + t) Step us! '                                      find best thrust 0-110
    fo! = z! * ts!
    aa! = Abs(vy! + grav! + fo! - i!)
    If aa! < fmin! Then fmin! = aa!: sbest! = z!
    If aa! > fmin! Then Exit For
Next z!
Return

GoSkyObject:
If (ek(p) <> -1) And (contact = 0) Then
    auto = 0
    a = -ma
    wa = -ma
    lock1 = 0
    suri = ex(p) - center
    GoSub slimit
    If p > 2 Then ey(p) = th '                                        BH, worm, comet, alien
    px! = center
    If p = 2 Then py! = 130 '                                         above Borg
    vx! = exv(p)
    eyv(p) = 0
End If
Return

KeyAndMouse:
Do While _MouseInput
    lb = Abs(_MouseButton(1))
    rb = Abs(_MouseButton(2))
    If mouseswap Then Swap lb, rb '                                   whatever floats your boat
    If Timer < ignoreuntil! Then lb = 0: rb = 0 '                     2 lines for debouncing
    If lb Or rb Then ignoreuntil! = Timer + .25
    ww = wa '                                                         stash current wanted angle
    wa = wa + lb - rb '                                               want angle
    If wa <> ww Then '                                                if changed
        If inpause Then i$ = Chr$(13): GoTo gotit '                   either button to cause liftoff
        apd = 1 '                                                     autopilot disconnect warning
        auto = 0 '                                                    autopilot
        GoTo endk '                                                   don't bother checking keys
    End If
    mw = mw + _MouseWheel
Loop
If mw <> 0 Then '                                                     wheel moved
    thrust! = Int(thrust!) - mw
    If thrust! < 0 Then thrust! = 0
    If thrust! > h Then thrust! = h
    apd = 1 '                                                         autopilot disconnect warning
    auto = 0 '                                                        autopilot
    hover = 0 '                                                       hover off
    vert = 0 '                                                        vertical control off
    mw = 0 '                                                          zap
    GoTo endk '                                                       don't bother checking keys
End If

Def Seg = 0
status = Peek(&H417) '                                                7ins 6caps 5num 4scrl 3alt 2ctrl 1ls 0rs

If ((status And 1) > 0) And ((status And 2) > 0) Then '               both shift (cookie!)
    If rdtime! > 0 Then starship = 1 '                                must have pressed shift-shift twice, another cookie
    rdtime! = Timer + 5 '                                             Rick display time
End If

If status And 8 Then start1! = Timer: mpass& = 0 '                    alt, reset speed timer

If status And 4 Then '                                                ctrl
    i$ = Right$(" " + InKey$, 1)
    kk = Asc(i$)
    If (kk = 3) Or (kk = 19) Then '                                   c or s
        nfile:
        image = image + 1
        f$ = "CAP" + Right$("0000" + LTrim$(Str$(image)), 3) + ".BMP"
        If _FileExists(f$) Then GoTo nfile
        SaveImage f$
        If _FileExists(f$) Then mes$(1) = "Screen captured to " + f$
        GoTo endk
    End If
End If

i$ = InKey$ '                                                         consult human
li = Len(i$)
If li = 0 Then Return

If i$ = "|" Then MakeStarFiles '                                      takes hours!

k = Asc(Right$(i$, 1))
If k = 27 Then Quit
If inpause And (k = 32) Then
    k = 13 '                                                          transform spacebar to Enter
    i$ = Right$(Chr$(0) + Chr$(k), li) '                              gentlemen, we can rebuild him
End If

gotit:
If (i$ = "\") And (shx(0) = 0) And (contact = 0) Then '               LM drops bomb
    If (cwd < 50) And (sy1 > 300) Then dead$ = "Smooth move, Exlax!" 'kill self in car wash
    sia = sia + 1 '                                                   shells in air
    shvx(0) = vx! + 3 + Rnd * t
    shvy(0) = 0
    shx(0) = suri + sx0
    shy(0) = sy0
    shd(0) = 1
End If

If i$ = "[" Then bw = bw Xor 1: Setcolor '                            crude method for b&w
If i$ = "]" Then
    ufof = ufof Xor 1
    mes$(0) = "UFO " + OnOff$(ufof)
    If ufof Then
        GoSub SkyStuff
        p = 6: GoSub GoSkyObject
    End If
End If

If i$ = "=" Then GoSub lmshow '                                       show LM data - pointless but amusing
If i$ = "'" Then pdiv = (pdiv + 1) Mod 4 '                            Henon speed, also slows down thrust display
If radiationdeath Then i$ = "": Return '                              you're dead and cannot pass this point

If i$ = "~" Then darkstarc = darkstarc Xor 1 '                        color
If i$ = "@" Then darkstart = darkstart Xor 1 '                        thickness

If inpause Then '                                                     hit "p" or landed
    If i$ = "b" Then '                                                Big Dipper
        rmin = 9 '                                                    right ascension
        dmin = 30 '                                                   declination
        starinit = 0
        Return
    End If
    If li = 2 Then '                                                  arrow keys move stars
        rdol = rmin + dmin '                                          detect change
        rmin = rmin + (k = 75) - (k = 77) '                           left right
        rmin = (rmin + 24) Mod 24 '                                   RA limit 0 - 24
        dmin = dmin - (k = 80) * t + (k = 72) * t '                   declination up down
        If dmin = h Then dmin = -80 '                                 limit -90 - 90
        If dmin = -h Then dmin = 80
        If (rmin + dmin) <> rdol Then starinit = 0 '                  changed, replot stars
    End If
End If
If li = 2 Then GoTo is2 '                                             extended key

If i$ = "_" Then '                                                    star twinkle
    twinkle = twinkle Xor 1
    mes$(0) = "STAR TWINKLE " + OnOff$(twinkle)
End If
If i$ = ";" Then fpl = 1 '                                            force power loss
If k = 9 Then ex(1) = (suri + px!) - Sgn(exv(1)) * h '                TAB summon DS
p = InStr(")!@#$%^&*(", i$)
If p And (contact = 0) Then GetSurface p - 1 '                        shifted-number for 1 of 10 surfaces
p = InStr("01234", i$) '                                              stars off/on/info
If p Then starstatus = p - 1
If (k = 8) And (warp! < 1) Then '                                     backspace, random star position
    rmin = Int(Rnd * 24) '                                            random RA
    dmin = (Int(Rnd * 18) - 9) * t '                                  random dec
    starinit = 0
End If
If i$ = "." Then
    tfollow = tfollow Xor 1
    auto = 0
    vert = 1
    mes$(0) = "TERRAIN FOLLOWING " + OnOff$(tfollow)
End If
p = (i$ = "<") - (i$ = ">") '                                         jump left/right
If (contact = 0) And (p <> 0) Then
    suri = suri + 40 * p '                                            surface index
    GoSub slimit '                                                    limit suri
    If lock1 Then hover = 1: lock1 = 0
End If
If okrick And (warp! < 1) Then
    If i$ = "+" Then
        If zoom < 2 Then zoom = zoom + 1
        starinit = 0
    End If
    If i$ = "-" Then
        If zoom > 0 Then zoom = zoom - 1
        starinit = 0
    End If
End If
If i$ = "?" Then rick = rick Xor 1 '                                  show speed of processing graph
If i$ = "/" Then
    cpal = (cpal + 1) Mod 4 '                                         cycle green/black & white/normal monitor
    mes$(0) = "": mes$(1) = ""
    If cpal = 1 Then mes$(0) = "GT40 mode"
    If cpal = 2 Then mes$(1) = "Hyperion mode!"
    If cpal = 3 Then mes$(1) = "Do not adjust your set.  We control the horizontal and the vertical!"
End If
If k = 32 Then '                                                      cycle thru features
    If lock1 > 0 Then '                                               on auto, landing zone selected, abort landing
        abort = 1
        mes$(0) = "ABORT!"
        If vx! = 0 Then vx! = .01
        Return
    End If
    If convo Then '                                                   or speed up rendesvous
        sct! = .2
        sc! = Timer
        Return
    End If

    If skyoff Then tmod = t Else tmod = 16
    jf = (jf + 1) Mod tmod
    '          01234567890123456
    i$ = Mid$("mtsiHg5wleObBWoR", jf + 1, 1) '                        cycle thru ground and sky features
    k = Asc(i$)
    If demo And (jf = 7) Then i$ = "e" '                              skip LGM in demo, because it's on the grave
End If

p = InStr("RObBWo", i$) '                                             jump to CM, deathstar, etc.
If p And (skyoff = 0) Then p = p - 1: GoSub GoSkyObject

If i$ = "A" Then
    lam = lam Xor 1 '                                                 land at McDonalds
    If lam And (auto = 0) Then i$ = "a" '                             turn on autopilot
End If
If i$ = "a" Then '                                                    autopilot
    abort = 0 '                                                       in case it was on
    tfollow = 0
    auto = auto Xor 1 '                                               toggle
    If auto And (radarf = 0) Then radarf = 2
    If auto = 0 Then hover = 1 '                                      be nice, help user
    pt! = Timer '                                                     restart countdown
End If
If i$ = "c" Then GoSub CutOrOutOfFuel
If i$ = "C" Then doclock = doclock Xor 1
If i$ = "d" Then dump = dump Xor 1 '                                  fuel
If i$ = "D" Then restart = 1 '                                        restart with defaults
If (i$ = "E") And (starstatus > 0) Then '                             end of universe
    If eou = 0 Then eou = -1 Else eou = eou + 1 '                     restart or speedup
End If
If i$ = "F" Then
    fuel! = h
    lockfuel = 1
End If
If i$ = "f" Then lockfuel = lockfuel Xor 1 '                          THIS cheat the GT40 had, using toggle switches!
If i$ = "G" Then gstyle = (gstyle + 1) Mod 6 '                        ground style
If i$ = "h" Then hover = hover Xor 1: apd = 1 '                       apd=autopilot disconnect warning
If i$ = "I" Then
    invincible = Abs(invincible) Xor 1
    mes$(0) = "INVINCIBLE MODE " + OnOff$(invincible)
    GoSub ReadLM '                                                    to change thrusters
End If
If i$ = "j" Then
    darkstars = (darkstars + 1) Mod 5
    mes$(0) = "Deathstar rotation" + Str$(darkstars)
End If
If i$ = "k" Then '                                                    kill threats or, if none, shoot at ground feature
    firel = 1 '                                                       fire laser
    For z = 1 To 20 '                                                 IBM shells
        shd(z) = 1
    Next z
End If
If i$ = "L" Then GetSurface -1 '                                      level ground
If (i$ = "M") And ((contact + inpause) = 0) Then '                    laser level & land
    magic = magic + 1
End If
If (i$ = "n") And inpause Then nation = ((nation - 1) Xor 1) + 1 '    flag 1 US, 2 USSR
If i$ = "p" Then GoSub pause '                                        pause LM movement
If (i$ = "P") And (contact = 0) And (warp! < 1) And (paraf = 0) Then
    paraf = 1 '                                                       parachute!
    chs = 0
    a = 0
    GoSub CutOrOutOfFuel
End If
If i$ = "q" Then Quit
If i$ = "Q" Then
    oscar = oscar Xor 1 '                                            land or sea flags for LGM
    If oscar Then z$ = "SEA" Else z$ = "LAND"
    mes$(0) = "LGM flags: " + z$
End If
If i$ = "r" Then
    If cut Then '                                                     restart engine
        cut = 0
        hover = 1
        power = opower
        powerloss = 0
    Else
        If auto = 0 Then
            radarf = (radarf + 1) Mod 3
            mes$(0) = "Radar " + Mid$("OFFON FAT", radarf * 3 + 1, 3)
        End If
    End If
End If
If i$ = "S" Then MakeSur: restart = 1 '                               generate new surfaces
If i$ = "T" Then jitter = jitter Xor 1 '                              thrust computation
If i$ = "u" Then '                                                    instrument panel on/off
    zz = gs
    gs = (Sgn(gs) Xor 1) * 85 '                                       graphics start

    panelinit = 0
    pif = -1

    z = (gs + 30) - px!
    If (gs > 0) And (z > 0) Then
        px! = px! + z
        suri = suri - z
        GoSub slimit
    End If
End If
If i$ = "U" Then tilef = (tilef + 1) Mod 3 '                          alternate tilings
If i$ = "v" Then '                                                    vertical automatic
    If tfollow Then
        tfollow = 0
        mes$(0) = "TERRAIN FOLLOWING OFF"
    End If
    vert = vert Xor 1
    apd = 1 '                                                         autopilot disconnect warning
End If
If i$ = "x" Then starinit = 0: starfiles = (starfiles + 1) Mod 3 '    star density
If i$ = "X" Then starinit = 0: regen = 1: Stars '                     regenerate single star file
If i$ = "y" Then
    mouseswap = mouseswap Xor 1
    If mouseswap Then z$ = "reversed" Else z$ = "normal"
    mes$(0) = "Mouse buttons " + z$
End If
If i$ = "Y" Then min = 3: sec = 45 '                                  black hole at 3:50
If (i$ = "z") And (crash = 0) Then
    mes$(0) = "" '
    mes$(1) = "" '                                                    erase radiation messages
    dead$ = "SELF-DESTRUCT"
End If

If i$ = "}" Then
    GoSub CutOrOutOfFuel
    sgs = gs: gs = 0
    srf = radarf: radarf = 0
    GoSub Plotscreen
    dissolve
    dead$ = " "
    gs = sgs: radarf = srf
End If

'          1234567890
p = InStr("5wlemtsiHg", i$) '                                         jump to feature
If p And (contact = 0) Then
    sf = p
    If demo And sf = 9 Then sf = t
    If (sf(sf, 1) >= suri) And (sf(sf, 0) < (suri + q3)) Then '       already in vicinity of IBM
        If sf = 8 Then shoot = 1 '                                    tell IBM to fire
        If demo Then '                                                IBM at special location in demo mode, deal with it
            px! = sf(sf, 2) - 3130
            suri = 3130
        End If
    Else
        px! = center '                                                move ship to screen center
        suri = sf(sf, 0) - center - 30 - (sf = 9) * h '               move ground to IBM
    End If
    a = -ma '                                                         angle = -malfunction angle
    abort = 0
    wa = -ma '                                                        want angle
    lock1 = 0 '                                                       radar lock
    tmt! = 0 '                                                        to move total
    vx! = 0 '                                                         not moving
    warp! = 0 '                                                       cancel warp
End If
GoTo endk '                                                           done with ordinary keys

is2: '                                                                extended key
z = mdelay '                                                          master delay
mdelay = mdelay - (k = 73) + (k = 81) '                               PgUp/PgDn
If mdelay < 1 Then mdelay = 1
If mdelay <> z Then '                                                 changed
    mes$(0) = "_LIMIT " + OnOff$(Sgn(mdelay))
    If mdelay Then mes$(0) = mes$(0) + LTrim$(Str$(mdelay))
End If
If status And 3 Then '                                                left or right shift
    If k = 72 Then k = 201 '                                          LM up
    If k = 75 Then k = 203 '                                          LM left
    If k = 77 Then k = 204 '                                          LM right
End If
If (inpause = 0) And ((k = 72) Or (k = 80)) Then '                    up and down arrow
    apd = 1 '                                                         autopilot disconnect
    hover = 0
    vert = 0
    thrust! = thrust! + (k = 80) - (k = 72) '                         true = -1
End If
thrust! = Int(thrust! * t) / t '                                      t = 10
If (hover = 0) And (vert = 0) Then thrust! = Int(thrust!)
If thrust! > h Then thrust! = h
If (dump = 0) And (fuel! > 0) And (contact = 0) Then '                side thrust/angle
    If inpause = 0 Then wa = a - (k = 75) + (k = 77) '                                    left/right arrows
    If Abs(wa) > 99 Then wa = 99 * Sgn(wa) '                          want angle, limit 99
    If a <> wa Then apd = 1 '                                         autopilot disconnect
End If
If k = 59 Then '                                                      F1 help
    Help
    start1! = Timer: mpass& = 0 '                                     reset speed timer
End If
If k = 60 Then '                                                      F2 demo
    demo = demo Xor 1
    GoSub init2
    cbh = demo '                                                      constant black holes
End If
If k = 61 Then '                                                      F3, sky feature toggle
    skyoff = skyoff Xor 1
    If skyoff = 0 Then convo = 0
    mes$(0) = "SKY OBJECTS " + OnOff$(1 - skyoff)
End If
If k = 62 Then '                                                      F4 endless bh
    cbh = cbh Xor 1
    exv(3) = 0
    mes$(0) = "CONSTANT BLACK HOLES " + OnOff$(cbh)
End If
If k = 63 Then '                                                      F5 instrument background
    f5toggle = f5toggle Xor 1
    If f5toggle = 0 Then background = background Xor 1
    If f5toggle = 1 Then porb = porb Xor 1
    pload = 0
End If
If (k = 64) And ((ASO + inpause) = 0) Then '                          F6 seperate AS/DS
    GoSub liftoff
    Return
End If
If k = 65 Then showmap = showmap Xor 1 '                              F7 map
If k = 66 Then '                                                      F8 shields
    shield = shield Xor 1
    geof = shield * t
End If
If k = 67 Then '                                                      F9 LED color
    z$ = Right$("0" + LTrim$(Str$(LEDc)), 2)
    z = InStr(LED$, z$): If z = 11 Then z = -1
    LEDc = Val(Mid$(LED$, z + 2, 2))
    LEDtri = 0
End If
If k = 68 Then '                                                      F10 LED tri-color
    LEDtri = LEDtri Xor 1
    If LEDtri Then LEDc = green
End If
If k = 71 Then rmin = 0: dmin = 0: starinit = 0 '                     Home, star RA/dec to 0

endk:
If k = 201 Then hoverc = hoverc - t '                                 move up
If k = 203 And (left = 0) Then left = 16 '                            move left
If k = 204 And (right = 0) Then right = 16 '                          move right
If apd Or (k = 201) Or (k = 203) Or (k = 204) Then '                  blink AUTO
    If auto Then APdisengage = 20 '                                   blink 20 times
    auto = 0 '                                                        turn it off
    apd = 0 '                                                         reset flag
End If
Return

pause:
If inpause Then Return '                                              already doing this....
dead$ = ""
inpause = 1
pt! = Timer '                                                         for demo mode
wu! = pt! + 1 '                                                       delay before planting flag
Do: _Limit mdelay
    GoSub KeyAndMouse
    If k = 60 Then Return '                                           F2 demo
    If (i$ > "") And (InStr("zD", i$)) Then Return '                  self-destruct or restart
    GoSub Plotscreen
    If Len(dead$) Then Return
    If auto And contact Then '                                        countdown to blast off
        If Timer < pt! Then pt! = Timer '                             midnite crossing fix
        z! = Timer - pt!
        z = t - z!
        If z < 0 Then z = 0
        TextOnLM$ = LTrim$(Str$(z))
        If z! > t Then i$ = Chr$(13) '                                like pressing the key
    End If
    GoSub CalcFuel
Loop Until (i$ = Chr$(13)) Or (i$ = "p")
ctime! = Timer
fb$ = "" '                                                            feedback
inpause = 0
c = (contact = 1) And (crash = 0) And (liftoff = 0) And (Abs(a) < 31)
If c Then GoSub liftoff
Return

CalculateMotion:
i = 0
If (power = opower) And (Rnd < .0003) Then
    i = ((auto + contact + liftoff + vert) = 0) And ((min * 60 + sec) > t)
End If
If fpl Or i Then '                                                    force power loss
    fpl = 0
    powerloss = t + Rnd * t + ASO * 30 '                              10 TO 20%, 50% ASO
    power = opower + powerloss / h * opower
    mes$(0) = LTrim$(Str$(powerloss)) + "% POWER LOSS - DUMP FUEL!"
End If

If lob Then px! = px! + exv(2) '                                      landed on Borg
If contact Or inpause Then GoTo other

ta = ((a + ma) + 270) Mod tsix '                                       temp angle = a+malfunction angle
ma! = (vmass + fuel!) / th '                                          actually 54% fuel
fo! = ((thrust! + super * 5) / ma!) / power '                         f = ma
If fuel! = 0 Then fo! = 0 '                                           nix any force if running on empty
fx! = fo! * c!(ta) / 2
If dump And (Abs(a) < 5) Then fx! = 0
fy! = fo! * s!(ta) + grav! '                                          thrust + gravity
If warp! > 0 Then fx! = fx! * (warp! * 2 + 1) '                       get thru warp msgs faster
vx! = vx! - fx!
If a <> 0 Then vx! = vx! + (Rnd - pf!) / h '                          help get to integer vx
If Abs(vx!) < .01 Then vx! = 0
avx = Abs(vx!)
If (avx > 5) And (avx < 20) Then xoff = vx! Else xoff = 0
If cut And (magic = 0) Then
    cel! = Timer - ctime! '                                           time since cut
    vy! = cvy! + grav! * (cel! * cel!) '                              v = at^2  velocity = acceleration times time squared
    fy! = 0 '                                                         null y force since it's a different situation
End If
vy! = vy! + fy!
If warp! >= 1 Then vy! = 0

px! = px! + vx! - lob * exv(2)
py! = py! + vy!

If (liftoff = 0) And (py! < 55) Then '                                stop going off screen top
    If convo = 0 Then mes$(0) = "Too high - reduce thrust!"
    py! = 55
    vy! = 0
End If

other:
GoSub CalcFuel
If liftoff And (lob = 0) Then Return
nomove = demo And (((suri \ q3) + 1) = 5)

zz = px! - center
z! = Abs(vx!)

If (nomove = 0) And ((rlink > 0) Or (z! < 3) Or (z! > 20)) Then
    dx! = px! - center
    px! = center
    tmt! = tmt! + dx!
Else
    zq = 0 '                                                          was 30 woof woof
    c1 = (px! <= (gs + zq))
    c2 = (px! >= (q3 - zq))
    If c1 Or c2 Then
        If c1 Then z = q3 - zq Else z = gs + zq
        z = z - px!
        tmt! = tmt! - z
        px! = px! + z
    ElseIf (zz <> 0) And (Abs(vx!) <= 5) And (nomove = 0) Then
        z = zz \ 2 + 1
        tmt! = tmt! + z
        px! = px! - z
    End If
End If
If Abs(tmt!) >= q3 Then tmt! = Sgn(tmt!) * q3 - 1

If left Then '                                                        jog left (shift left arrow)
    If left = 16 Then sv! = vx!
    If left > 8 Then a = 4 Else a = -4
    left = left - 1
    If left = 0 Then a = 0: vx! = sv!
End If
If right Then '                                                       jog right (shift right arrow)
    If right = 16 Then sv! = vx!
    If right > 8 Then a = -4 Else a = 4
    right = right - 1
    If right = 0 Then a = 0: vx! = sv!
End If
Return

CalcFuel:
If cut Then thrust! = 0
If lockfuel = 0 Then
    ta = Abs(a): If ta > 5 Then ta = 5 '                              main angle, up to 5
    z! = (ta + super + Abs(fst)) * t '                                plus 10% for thrusters
    used! = (thrust! + z!) / 8000
    If ASO Then used! = used! * 2 '                                   burn faster for AS
    If inpause Then used! = 0
    If shield Then used! = used! + .001
    fuel! = fuel! - used! * 4
    If fuel! <= 0 Then fuel! = 0: GoSub CutOrOutOfFuel
End If
Return

Plotscreen:
If bit! = 0 Then bit! = Timer + pf!
If Timer > bit! Then
    bbit = bbit Xor 1 '                                               toggles twice per second, used all over - instruments, IBM hazard lights, clock colon, LGM ear wiggle
    bit! = 0
End If

bolthit = 0
bolthitf = 0
If (crash = 0) And (Abs(vx!) >= h) Then warp! = Abs(vx!) / h Else warp! = 0
If warp! >= 1 Then paraf = 0 '                                        reckon parachute can be dropped at warp speeds

' change styles every 10/30 seconds
If style! = 0 Then style! = Timer + t
If style! > 86400 Then style! = 1 '                                   midnite xing
If Timer > style! Then
    bstyle1 = (bstyle1 + 1) Mod 3 '                                   Borg guts every 10s
    If bstyle1 = 0 Then bstyle2 = bstyle2 Xor 1 '                     Borg exhaust
    style! = 0
End If

If (starstatus > 0) And (eou = 0) And (vert = 0) And (Rnd > .9999) Then '  stars on+not already falling+WHY?+rarely
    mes$(0) = "THE SKY IS FALLING!  THE SKY IS FALLING!"
    eou = 1
End If
GoSub CalculateMotion

If gs Then '                                                          graphics start not 0, instruments are visible
    View
    pif = (pif + 1) Mod (pdiv + 1)
    If pif Then timemachine Else GoSub Instruments '                  INSTRUMENTS
End If
If starstatus Then
    View Screen(gs, Sgn(Len(mes$(0))) * 20)-(q3, q4)
    Stars '                                                           STARS
    View Screen(gs, 0)-(q3, q4)
Else
    View Screen(gs, 0)-(q3, q4)
    Cls
End If

If Len(mes$(0)) Then
    View Screen(gs, 0)-(q3, 20)
    Cls
    View Screen(gs, 0)-(q3, q4)
End If

Info '                                                                INFO show timed messages at top, if any
If warp! < 1 Then '                                                   no sky features except star streaks at warp speeds
    If skyoff = 0 Then GoSub SkyStuff '                               CM/DS/Bo/BH/Wo/Co
    GoSub PlotGround '                                                GROUND/FEATURES
    Shells '                                                          SHELLS
    If (invincible = 0) And (shield = 0) And (skyoff = 0) Then GoSub FiveWaysToDie
End If
If platform Then Put (pminx, pminy), gbuff(), Or '                    falling descent stage
If Len(dead$) = 0 Then GoSub PlotVehicle '                            VEHICLE
If (warp! < 1) And showmap And (crash = 0) Then
    View
    Map '                                                             LM, ground & sky features
    View Screen(gs, 0)-(q3, q4)
End If
If bolthit Then '                                                     lightning zap from Deathstar
    boltc = boltc + 1 + (boltc = 9999)
    rtl!(2) = Timer + 5
    rtlc(2) = boltc
    If ((invincible + shield) = 0) And (boltc >= t) Then dead$ = "Zapped!"
End If

If okrick And (Len(debug$) > 0) Then Locate 1, 12: Print debug$;
timemachine

Return

SkyStuff:
If (min = 3) And (sec = 50) Then '                                    Tree-fiddy! (Southpark), do black hole
    ex(3) = suri + t
    ey(3) = h
    exv(3) = t
    eyv(3) = 1
End If

If cmleaving Then
    exv(0) = exv(0) + 2
    If exv(0) = 0 Then exv(0) = 1
End If

Restore skycrud
If eou Then mi = 2 Else mi = 5 '                                      end of universe, no celestial events
For i = 0 To mi '                                                     0CM 1DS 2Borg 3BH 4Worm 5Comet 6Al
    Read g$, skyset1(i), skyset2(i)
Next i

For i = 0 To mi + ufof '                                              0CM 1DS 2Borg 3BH 4Worm 5Comet 6Alien
    xplus = skyset1(i): xminus = skyset2(i)
    If (i = 3) And cbh Then ek(i) = 0 '                               constant black hole
    If ek(i) = -1 Then GoTo ni2

    If (ey(i) > (q4 + 50)) Or (ey(i) < -50) Or (exv(i) = 0) Then
        ei(i) = 0 '                                                   ini
        ek(i) = 9999
        nx:
        ex(i) = Rnd * q1
        If Abs(ex(i) - (px! + suri)) < q3 Then GoTo nx '              start away from craft
        If Abs(ex(i) - px!) < q3 Then GoTo nx '                       start away from craft
        If i = 2 Then ex(i) = (ex(1) + 3200) Mod q1
        ey(i) = 120 + Rnd * h '                                       random y 120-220
        If i = 0 Then ey(i) = 22 '                                    CM
        If i = 1 Then ey(i) = 170 '                                   DS
        If i = 2 Then ey(i) = th '                                    Borg
        '              0 1 2 3 4 5
        '              CMDeBoBHWoCoAl
        c1 = Val(Mid$("04010210120502", i * 2 + 1, 2)) '              min x velocity
        c2 = Val(Mid$("09030210171005", i * 2 + 1, 2)) '              max x velocity
        exv(i) = Rnd * (c2 - c1) + c1 '                               random in range
        If Rnd > pf! Then exv(i) = -exv(i)

        z = Val(Mid$("00000003020100", i * 2 + 1, 2)) '               top range y velocity
        eyv(i) = 0
        If z Then eyv(i) = Rnd * (z - 1) + 1 '                        random in range

        If Rnd > pf! Then exv(i) = -exv(i)
        If Rnd > pf! Then eyv(i) = -eyv(i)
        If (i = 3) And cbh Then
            If Rnd > pf! Then
                ex(i) = suri - t
                exv(i) = t
            Else
                ex(i) = suri + q3 + t
                exv(i) = -t
            End If
        End If
    End If

    ex(i) = ex(i) + exv(i)
    ey(i) = ey(i) + eyv(i)

    If ex(i) < 0 Then
        If (i = 0) And cmleaving Then
            ek(i) = -1: cmleaving = 0
        Else
            ex(i) = ex(i) + q1
        End If
    End If
    If ex(i) > q1 Then
        If (i = 0) And cmleaving Then
            ek(i) = -1: cmleaving = 0
        Else
            ex(i) = ex(i) - q1
        End If
    End If

    exl(i) = localize(ex(i), xplus, xminus)
    If (i = 3) And cbh And (exl(i) = 9999) Then exv(i) = 0

    If ek(i) <> -1 Then ek(i) = 9999
    If exl(i) <> 9999 Then
        dx! = Abs(px! - exl(i))
        dy! = Abs(py! - ey(i))
        ek(i) = Sqr(dx! * dx! + dy! * dy!)

        If i = 0 Then GoSub CommandModule
        If i = 1 Then DeathStar exl(i), f$(37)
        If i = 2 Then Borg exl(i), ey(i)
        If i = 3 Then
            If (Len(mes$(0)) = 0) And (showmap = 0) And (cbh = 0) Then
                mes$(0) = "DANGER, WILL ROBINSON, DANGER!"
            End If
            If sas = 0 Then BlackHole 0
            sas = 0
        End If
        If i = 4 Then WormHole
        If i = 5 Then
            tx = localize(ex(5), 0, 0)
            ty = ey(5)
            Comet tx, ty
        End If
        If i = 6 Then '                                               traditional alien - too silly
            j = Rnd * h - h \ 2
            z = ey(6) + j
            If (Rnd > .9) And (z > h) And (z < 250) Then
                ey(6) = z
                alien = alien Xor 1
                ex(6) = ex(6) + 20 * Sgn(alien - pf!)
            End If
            UFO exl(6), ey(6), exv(6)
        End If
    End If
    ni2:
Next i
Return

FiveWaysToDie:
If (ek(2) >= 0) And (ek(2) < 20) Then '                               Borg
    wu! = Timer + 5
    Do: _Limit mdelay
        Cls
        mes$(0) = "YOU ARE BORG"
        Info
        Borg exl(2), ey(2)
        For i = 1 To rp
            p = Point(LMrx(i), LMry(i))
            If p = black2 Then c = green Else c = black2
            PSet (LMrx(i), LMry(i)), c
        Next i
        timemachine
    Loop Until Timer > wu!
    dead$ = "BORG"
End If

If (ek(3) >= 0) And (ek(3) < 30) Then '                               black hole
    dead$ = "EATEN"
    BlackHoleDoom
End If

If (ek(4) >= 0) And (ek(4) < 30) Then '                               wormhole
    wu! = Timer + 5
    spx! = exl(4)
    spy! = ey(4)
    exv(4) = 0
    eyv(4) = 0
    wradar = radarf
    radarf = 1
    cut = 1
    Do: _Limit mdelay
        Cls
        fb$ = ""
        mes$(0) = "HOLY CRAP, BATMAN!"
        mes$(1) = ""
        Info
        a = Rnd * 359
        px! = spx! + (Rnd - pf!) * 20
        py! = spy! + (Rnd - pf!) * 5
        WormHole
        LMdistort '                                                   optional
        GoSub PlotVehicle
        timemachine
    Loop Until Timer > wu!
    radarf = wradar
    dead$ = "BATMAN"
End If

If (ek(5) >= 0) And (ek(5) < 15) Then dead$ = "HIT BY COMET"
If ufof And (ek(6) >= 0) And (ek(6) < 45) Then dead$ = "HIT BY ALIEN"
Return

GetAlt:
alt! = (gety(-(rxm + wi2)) - ((sy1 + sy2) \ 2)) / 5
Return

Instruments:
osc = 8
If gs Then LoadPanel '                                                graphics start not zero, instrument panel is on
If (warp! > 0) And (contact = 0) Then
    If warp! >= t Then
        dead$ = "WARP 10"
        Return
    End If
    Restore warp
    For i = 1 To Int(warp!)
        Read z$
    Next i
    w$ = LTrim$(Str$(Int(warp! * h) / h))
    If Len(w$) = 1 Then w$ = w$ + ".00"
    If Len(w$) = 3 Then w$ = w$ + "0"
    mes$(0) = "WARP " + w$ + " - " + z$
    If gs And ((Timer Mod t) > 5) Then
        Henonp f
        Wave '                                                        osc = 5 if commented out
        AuHoVe auto, hover, vert, lam
        GoTo clock
    End If
End If

If gs = 0 Then Return '                                               graphics start of 0 means the instrument panel is off

If panelinit = 0 Then
    If crash Then f = 15 Else f = ((f + 1) Mod 5) + t '               title graphic/face
End If

Henonp f '                                                            title graphic

Line (0, 0)-(gs - 1, 3), blue2, BF '                                  clear map area

If pdiv Then '                                                        instrument update frequency 1-4, mainly a way to slow down erratic thrust display
    j = 0
    For i = 1 To 18 '                                                 my name in Morse
        p = Val(Mid$("002032023222300032", i, 1)) '                   Frost
        If p < 3 Then Line (14 + j, 2)-(14 + j + p, 2), white
        j = j + p + 2
    Next i
End If

If (contact + auto + hover + vert + liftoff) = 0 Then
    If (vy! > .6) And (-fy! < 0) Then PrintVGA Chr$(24), 5, 241, red, black2
    If (vy! < .4) And (-fy! > -.01) Then PrintVGA Chr$(25), 5, 250, yellow, black2
End If

AuHoVe auto, hover, vert, lam

If tfollow Then '                                                     terrain following!
    For ty = glmax - 20 To glmax
        For tx = 0 To gs - 1
            If Point(tx, ty) = blue Then PSet (tx, ty), red '         red bg
        Next tx
    Next ty
    For i = 0 To 4 '                                                  TF
        p& = Val("&H" + Mid$("E744464444", i * 2 + 1, 2))
        Line (2, 339 + i)-(10, 339 + i), green, , p& * 128
    Next i
End If

osc = 0
c = LEDc
If (sbest! >= h) Or powerloss Then c = red
z! = thrust!: If z! > h Then z! = h '                                 200 at liftoff, show 100
PrepAndShowLED z!, 3, 1 '                                             thrust osc1
PrintCGA "T", 5, -1, c, -blue, 0 '                                    T is for flame
i = LEDc: j = black
If jitter Then Swap i, j '                                            thrust calc type
Line (4, 231)-(5, 232), i, B '                                        left light  (on = slow)
Line (13, 231)-(14, 232), j, B '                                      right light (on = fast)
Bar z! / h, 0

c = dcolor(vy!, 2, 3, 1) '                                            vy osc2
z! = vy!
If Abs(z!) > 99.97 Then z! = 99.99
PrepAndShowLED z!, 3, 2
PrintCGA "V", 5, -1, c, -blue2, 0
z! = (z! + 3) / 6
Bar z!, 1

c = dcolor(vx!, 2, 3, 1) '                                            vx osc3
If warp! Then
    z! = warp!
Else
    z! = vx! + rfs!
End If
PrepAndShowLED z!, 3, 2
PrintCGA "H", 5, -1, c, -blue, 0
z! = (z! + 3) / 6
Bar z!, 1

GoSub GetAlt '                                                        alt osc4
If contact And (alt! > 0) Then alt! = 0
c = dcolor(alt!, t, 3, -1)
PrepAndShowLED alt!, 4, 1
PrintCGA "A", 5, -1, c, -blue2, 0
If warp! Or (radarf = 0) Then z! = 0 Else z! = alt! / 60
Bar z!, 0

c = dcolor(fuel!, t, 5, -1) '                                         fuel osc5
PrepAndShowLED fuel!, 4, 1
PrintCGA "F", 5, -1, c, -blue, 0
z! = fuel! / h
Bar z!, 0

clock:
If Timer < start2! Then start2! = Timer '                             midnite crossing
If crash = 0 Then el! = el! + (Timer - start2!) '                     elapsed time
start2! = Timer
If el! >= 1 Then
    While el! >= 1 '                                                  catch-up
        el! = el! - 1
        sec = (sec + 1) Mod 60
        If sec = 0 Then min = (min + 1) Mod 99
    Wend
    If sec Mod 5 = 0 Then '                                           change title graphic
        If crash Then f = 15 Else f = ((f + 1) Mod 5) + t
    End If
End If
z$ = Right$("0" + LTrim$(Str$(min)), 2) + Right$("0" + LTrim$(Str$(sec)), 2)
osc = 6
LEDdisplay z$ '                                                       clock osc6

i = suri + px!
j = Abs(i - sf(5, 2))
k = sf(5, 2) + (q1 - i)
If j <= 3200 Then dtm! = j Else dtm! = k
PrepAndShowLED dtm!, 4, 0 '                                           dtm osc7
PrepAndShowLED CSng(speed), 4, 0 '                                    speed osc8
ShowAngle a '                                                         angle osc9
panelinit = 1
Return

LMcolors: '                                                           optional
If contact Or (vx! = 0) Then lbit = 0
If (contact + vx!) = 0 Then
    v1 = Rnd * 3
    v2 = Rnd * 3
    Swap LMci(v1), LMci(v2)
End If
For i = 1 To rp '                                                     right pad
    oc = LMoc(i)
    LMc(i) = oc
    If (oc = craft) Or (oc = red) Then '                              shadow
        zx = LMrx(i) - px! + 2 - xoff * (inpause = 0)
        zy = LMry(i) - py!
        If (oc = craft) And ((warp! > 0) Or (zy > zx)) Then
            tc = gray2
        Else
            tc = oc
        End If
        LMc(i) = tc
    End If
    If (i < 279) And (LMoc(i) = black2) Then '                        Ascent stage cycle
        lbit = (lbit + 5) Mod 4
        LMc(i) = LMci(lbit)
    End If
Next i
lbit = lbit - (vx! > 0) * 2 + ASO * t
Return

PlotVehicle:
If warp! < 1 Then
    wda = 0
Else
    px! = wx!: py! = wy!
    wda = warp! * 5 * s!((px! + 40) Mod tsix)
End If

If crash Then
    For i = 1 To rp
        PSet (LMrx(i), LMry(i)), LMc(i)
    Next i
    GoTo endproc
End If

If bolthit = 0 Then GoSub LMcolors

i = sf(4, 2) - 50 '                                                   left of volcano
j = sf(4, 2) + 50 '                                                   right of volcano
k = suri + px! '                                                      LM position
If (k > i) And (k < j) Then '                                         in the locality?
    c = 0 '                                                           count
    For ty = py! + 8 To py! + 18 '                                    leg/nozzle area
        For tx = px! - 17 To px! + 17
            p = Point(tx, ty) '                                       what color is the pixel?
            c = c - (p = orange) '                                    hot lava
        Next tx
    Next ty
    ' LINE (px! - 17, py! + 8)-(px! + 17, py! + 18), yellow, B '      diagnostics
    If c Then '                                                       contacted some lava
        For i = rp To 1 Step -1 '                                     from the bottom
            If LMoc(i) = craft Then '                                 is normal color?
                LMoc(i) = red '                                       make red
                nred = nred + 1 '                                     keep track of count
                c = c - 1
                If c = 0 Then Exit For '                              enough
            End If
        Next i
    End If
End If

If nred = 0 Then '                                                    number red
    temp = 0
    rtlc(1) = 0
Else
    If ASO Then z = 115 Else z = 223 '                                max that COULD be normal
    otemp = temp
    temp = (nred * h / z) Mod 101 '                                   temperature
    rtlc(1) = temp
    If temp > otemp Then rtl!(1) = Timer + 5
    c = 24 '                                                          gasoline
    If temp > 30 Then c = 32 '                                        dark red
    If temp > 60 Then c = 4 '                                         red
    If temp = h Then c = 15 '                                         white
    If bw = 0 Then Palette gasoline, c
    If (temp = h) And (invincible = 0) Then dead$ = "FRIED BY VOLCANO"
    For i = 0 To 20 '                                                 cool down some
        j = Rnd * rp
        If LMoc(j) = red Then LMoc(j) = craft: nred = nred - 1
    Next i
End If

n = rp '                                                              last pixel = right pad
If fuel! > 0 Then GoSub Exhaust '                                     maybe vehicle only

If n > maxn Then maxn = n

ta = a + ma '                                                         temp a = a + malfunction
zz = ta * -(Abs(ta) > 4) '                                            rotate beyond 5 degrees
ta = (zz + wda + tsix * t) Mod tsix '                                   keep in array bounds
c! = c!(ta) '                                                         cosine
s! = s!(ta) '                                                         sine
ta = zz '                                                             angle to use

rfx = 0 '                                                             optional craft jitter
rfy = 0
rfs! = 0 '                                                            random change in vx
If (jitter = 1) And (cut = 0) Then '                                  not slow or engine cut
    If (Rnd > .9) And (a = 0) Then '                                  a = angle
        If Rnd > pf! Then rfx = 1 Else rfx = -1 '                     half right, half left
        rfs! = rfx * .01 * (Int(Rnd * 9) + 1) '                       how much? .01 - .09
    End If
    If Rnd > .9 Then '                                                y jitter, 1 chance in 10
        If Rnd > pf! Then rfy = 1 Else rfy = -1 '                     half down, half up
    End If
End If

If doclock Then
    i = Val(Mid$(Time$, 1, 2))
    j = Val(Mid$(Time$, 4, 2))
    k = Val(Mid$(Time$, 7, 2))
    clocka(0) = (i + j / 60) * 30 '                                   hour hand
    clocka(1) = j * 6 '                                               minute hand
    clocka(2) = k * 6 '                                               seconds
    For z = 0 To 2 '                                                  prep for radians
        clocka(z) = (clocka(z) + 270) Mod tsix
    Next z
    ao = 0 '                                                          angle offset
Else
    ao = (ao + 1) Mod 361
End If

tvx = Sgn(vx!): If tvx = 0 Then tvx = 1
tao = ao * tvx
sco = sco Xor 1
If doclock Then sco = 0
If sco Then tc = red Else tc = lmsl
z3 = tsix + (shield = 0) * 361
For z2 = 0 To z3
    a2 = (z2 + tao * 5 + tsix * t) Mod tsix
    'IF a2 < 0 THEN a2 = 0
    'IF a2 > 359 THEN a2 = 359
    tx = px! + 50 * c!(a2) * aspect!
    ty = py! + 50 * s!(a2)
    If ty < gety(tx) Then
        If (z2 Mod 30) = 0 Then
            Circle (tx, ty), 1, tc, , , .75
            If geof Then
                For i = z2 - 120 To z2 Step 30
                    j = (i + tsix) Mod tsix
                    tx2 = px! + 60 * c!(j) * aspect!
                    ty2 = py! + 60 * s!(j)
                    Line (tx, ty)-(tx2, ty2), tc
                Next i
            End If
        End If
        If doclock Then
            For i = 0 To 2
                If a2 = clocka(i) Then
                    c = Val(Mid$("021404", i * 2 + 1, 2))
                    Circle (tx, ty), 4 - i, c, , , .75
                    Paint (tx, ty), c, c
                End If
            Next i
        End If
    End If
Next z2

For i = 1 To rp '                                                     rp = craft right pad
    LMrx(i) = px! + LMx(i) * c! + LMy(i) * s! + rfx '                 x rotated
    LMry(i) = py! - LMx(i) * s! + LMy(i) * c! + rfy '                 y rotated
    If LMry(i) > glmax Then LMry(i) = glmax '                         not below ground
    If i = xp Then sx0 = LMrx(i): sy0 = LMry(i) '                     save radar loc
    If i = lp Then sx1 = LMrx(i): sy1 = LMry(i) '                     save left pad loc
    If i = rp Then sx2 = LMrx(i): sy2 = LMry(i) '                     save right pad loc
    If bolthit Then LMc(i) = white
    PSet (LMrx(i), LMry(i)), LMc(i)
Next i

If fuel! < 95 Then GoSub flevel
  
eflag = 0 '                                                           determine flame climb
fx1 = 0 ' initialize for deflect
fx2 = 0
phg = (sx1 + sx2) \ 2 + ta * 2 '                                      point hit ground

tty! = py! + 26

For i = rp + 1 To n '                                                 flame/fuel dump
    x = px! + LMx(i) * c! + LMy(i) * s! + rfx '                       x rotated
    y = py! - LMx(i) * s! + LMy(i) * c! + rfy '                       y rotated
    c = LMc(i) '                                                      fuel dump/flame
    If warp! < 1 Then GoSub deflect '                                 deflect off ground
    c = Abs(c) '                                                      color
    PSet (x, y), c '                                                  flame particle
    If i <= n3 Then '                                                 main exhaust
        If (i Mod t) = 1 Then '                                       every 10th pixel
            Line (x - 1, y)-(x + 1, y), c '                           make "+"
            Line (x, y - 1)-(x, y + 1), c
        End If
    End If
Next i

If rfx And dump And (a = 0) Then vx! = vx! + rfs! '                   make jitter real
If rfx And (dump = 0) And (a <> 0) Then vx! = vx! + rfs!

endproc:

If doclock Then TextOnLM$ = Left$(Time$, 5)
If Len(TextOnLM$) Then GoSub TextOnLM

GoSub radar

fc = 0 '                                                              LGM flame count
If (sf(3, 1) >= suri) And (sf(3, 0) < (suri + q3)) Then
    x1 = sf(3, 0) - suri
    y1 = gety(x1) - 14
    For x = x1 + 5 To x1 + 15
        For y = y1 - 9 To y1 + 12
            If Point(x, y) = yellow Then fc = fc + 1
        Next y
    Next x
End If

GoSub KillThreats
     
geof = geof - 1 - (geof = 0)

If ok And (Timer > wu2!) And (InStr(mes$(0), "IN CAR") = 0) Then FlagandFireworks

mpass& = mpass& + 1
If Timer <= start1! Then start1! = Timer: mpass& = 1
speed = ((Timer - start1!) / mpass&) * h * t

If rick Then GraphSpeed

If magic = 1 Then '                                                   magic landing, 1st step laser the surface to level
    sf = 0
    z = suri + px!
    If z > q1 Then z = z - q1
    sf(0, 0) = z - 35 '                                               cut out a swath 70 units wide
    sf(0, 1) = z + 35
    GoSub lsurface '                                                  apply laser
    a = 0 '                                                           angle
    auto = 0 '                                                        autopilot
    vx! = 0 '                                                         cancel any x velocity
    vy! = 0 '                                                         cancel any y velocity
    py! = 331 + ASO * 9 '                                             ground has been cut to the lowest
    cut = 1 '                                                         signal engine off
    magic = 2
End If

'                                                                     kill surface feature
If firel And ksf And (contact = 0) And (sf(sf, 2) > 0) Then
    GoSub lsurface
End If
firel = ks '                                                          ks = keep shooting

'                                                                     terrain following
If tfollow And (contact = 0) And (dump = 0) And (liftoff = 0) Then
    hover = 1
    hp = q1
    svx = Sgn(vx!)
    If svx < 0 Then tx = sx1 Else tx = sx2
    la = Abs(vx!) * t
    If la < t Then la = t
    If la > h Then la = h
    For i = -(wi + 5) To la
        j = tx + i * svx
        k = j
        If k < 0 Then k = k + q1
        If k > q1 Then k = k - q1
        z = gety(k)
        If z < hp Then hp = z: sx = j
    Next i
    cx = Abs(sx - tx)
    If cx Then
        cy = hp - t - Abs(a / 2) - sy1
        st! = cy / cx * (Abs(vx!) + 1)
        If st! > 2 Then st! = 2
        If st! < -t Then st = -t
        fst = -Sgn(st!) * 2
        py! = py! + st!
        If py! < 250 Then py! = 250
    End If
End If
If paraf Then
    If py! > 150 Then mes$(0) = "Parachutes don't work in a vacuum!"
    Parachute
End If

Return
  
TextOnLM:
If (ASO = 0) And (Abs(ta) < t) Then
    lt = Len(TextOnLM$)
    tx = px! - lt * 2 + rfx
    ty = py! + rfy
    If ty > 340 Then ty = 340
    TinyFont TextOnLM$, tx, ty, white
End If
TextOnLM$ = ""
Return

KillThreats:
killed = 0
For i = 0 To 20 '                                                     shells
    c1 = shield And (shx(i) > 0) And (shd(i) < 70) '                  shield on and shell close to LM
    c2 = firel And (shx(i) > 0) '                                     fire laser and shell in air
    If c1 Or c2 Then
        killed = 1 '                                                  found something to kill
        tx = shx(i) - suri
        ty = shy(i)
        GoSub LMfl '                                                  fl = fire laser
        If Len(dead$) Then Return
        ExplodeShell i
    End If
Next i

ks = 0
For i = 1 To 6
    If skyoff Or (ek(i) = -1) Then GoTo ni3
    '                   CM DS BO BH WO Co
    If firel And (exl(i) > gs) And (exl(i) < q3) Then
        killed = 1
        ks = 1
        tx = exl(i)
        ty = ey(i)
        If laserb = 0 Then laserb = 5
        If laserb > 0 Then
            GoSub LMfl
            If Len(dead$) Then Return
            k = (5 - laserb) * 4
            If i > 1 Then
                Circle (tx, ty), k, yellow
                Paint (tx, ty), yellow, yellow
            End If
            laserb = laserb - 1
        End If
        If laserb = 0 Then
            ks = 0
            If i = 1 Then
                mes$(1) = "The Dark Side has cookies!"
            Else
                For a2 = 0 To tsix Step 2
                    x2 = tx + Rnd * h * c!(a2) * aspect!
                    y2 = ty + Rnd * h * s!(a2)
                    Line (tx, ty)-(x2, y2), gold
                Next a2
                ek(i) = -1
                exv(i) = 0
                exl(i) = -1
                If (i = 2) And lob Then dead$ = "SELF-DESTRUCT"
            End If
        End If
    End If
    ni3:
Next i
If killed Then ksf = 0 Else ksf = 1
Return

lsurface: '                                                           laser surface feature
z = (Rnd > .9) Or (magic = 1) '                                       1 out of 10 destroys, magic always
For i = sf(sf, 0) To sf(sf, 1)
    tx = i - suri
    If tx < 0 Then tx = tx + q1
    ty = gety(tx)
    If sf <> 3 Then ty = ty + Rnd * (q4 - ty)
    If i Mod 2 Then GoSub LMfl '                                      fire laser
    If z Then gh(i) = glmax '                                         level
Next i
If z Then
    Smooth sf(sf, 0) - 1 '                                            smooth transition from where the ground has been leveled, left side
    Smooth sf(sf, 1) '                                                                                                        , right side
    sf(sf, 2) = -1
End If
Return

LMfl: '                                                               fire laser
If (cwd < 50) And (sy1 > szs) Then '                                  in car wash?
    dead$ = "REFLECTED LASER"
    cwd = 999
    firel = 0
    laserb = 0
    ks = 0
    Return
End If
For zx = -1 To 1
    For zy = -1 To 1
        Line (sx0 + zx, sy0 + zy)-(tx, ty), lmsl
    Next zy
Next zx
geof = t
Return

flevel: '                                                             make fuel level when angle > 4
If ASO Then Return '                                                  no fuel shown with AS
ptk = (h - fuel!) * 2.7 '                                             pixels to kill
z = ptk '                                                             ptk used by ExplodeLM
x1 = px! - 16
x2 = px! + 14
y1 = py! - 15
y2 = py! + 15
For y = y1 To y2
    For x = x1 To x2
        If Point(x, y) = fuel Then
            PSet (x, y), black2
            z = z - 1
        End If
    Next x
    If z <= 0 Then Exit For
Next y
Return

deflect: '                                                            flame bounce
oz = gety(-x)
If deflectat > 0 Then oz = deflectat
z = oz

'       dump           side t      st in pause
If (c = fuel) Or (c = -yellow) Or (c = -blue) Then
    If (fx1 > 0) And (x < fx1) Then z = 0
    If (fx2 > 0) And (x > fx2) Then z = 0
    rf1 = Rnd * t + 1
    rf2 = Rnd * 20 - t
    If y >= (z - 1) Then '                                            yep, deflect it
        If x < sx1 Then
            If fx1 = 0 Then fx1 = x: fy1 = LMry(th1)
            x = fx1 + rf1
            y = fy1 + rf2
        Else
            If fx2 = 0 Then fx2 = x: fy2 = LMry(th2)
            x = fx2 - rf1
            y = fy2 + rf2
        End If
    End If
    Return
End If

If y >= (z - 1) Then '                                                yep, deflect it
    If sy1 < borgt Then ky1 = 1: GoTo isborg
    If eflag = 0 Then '                                               limit flame climbing
        eflag = 1 '                                                   only once per position
        xmin2 = phg - thrust! * 1.5 '                                 point hit ground
        xmax2 = phg + thrust! * 1.5
        u1 = 0 '                                                      up count l of nozzle
        u2 = 0 '                                                      up count r of nozzle
        wu1 = 0 '                                                     worst l up count
        wu2 = 0 '                                                     worst r up count
        ky1 = 0 '                                                     keep y
        ky2 = 0 '                                                     keep y
        For zz = phg To phg - h Step -1 '                             from LM center left
            z2 = gety(-zz): If zz = phg Then lz = z2
            k1 = z2 - lz
            lz = z2
            If k1 > 0 Then '                                          down
                u1 = 0
            Else
                u1 = u1 - k1 '                                        up
                If u1 > wu1 Then wu1 = u1 '                           worst up
            End If
            If u1 > 20 Then xmin2 = zz + 2: Exit For
            If Abs(k1) > 20 Then ky1 = 1 '                            90 degrees TMA etc
        Next zz
        For zz = phg To phg + h '                                     from LM center right
            z2 = gety(-zz): If zz = phg Then lz = z2
            k2 = z2 - lz
            lz = z2
            If k2 > 0 Then '                                          down
                u2 = 0
            Else
                u2 = u2 - k2 '                                        up
                If u2 > wu2 Then wu2 = u2 '                           worst up
            End If
            If u2 > 20 Then xmax2 = zz - 2: Exit For
            If Abs(k2) > 20 Then ky2 = 1 '                            90 degrees TMA etc
        Next zz
    End If

    isborg:
    r = thrust! * 2 + (Rnd - pf!) * 80
    x = (phg - r) + Rnd * (r * 2)
    k = Abs(x - phg + a * 2) / 4

    tx = x + suri '                                                   McDonalds
    If (tx >= sf(5, 0)) And (tx <= sf(5, 1)) And (py! > 250) Then
        ky1 = 0: ky2 = 0
    End If

    If (ky1 = 1) Or (ky2 = 1) Then '                                  keep
        y = z - Rnd * k - 1: Return
    End If

    x2 = (Rnd - pf!) * 20
    If x < xmin2 Then x = xmin2 + Rnd * (xmax2 - xmin2) + x2
    If x > xmax2 Then x = xmin2 + Rnd * (xmax2 - xmin2) - x2

    If (platform > 0) And (Abs(px! - (pminx + 17)) < 20) Then
        y = y - platform
    Else
        y = gety(-x) - Rnd * k - 1
    End If

    If (deflectat > 0) And (y > deflectat) Then y = deflectat - (y - deflectat)
End If
Return

CWceiling: '                                                          car wash
cwd = Abs((suri + px!) - sf(2, 2)) '                                  car wash distance
If ASO Then szs = 323 Else szs = 340 '                                safe zone start
If (cwd < 69) And (sy1 > 304) Then '                                  lower than top of building
    If sy1 >= q4 Then '                                               touched down inside
        cc1 = -1
    ElseIf sy2 >= q4 Then '                                           touched down inside
        cc2 = -1
    ElseIf sy1 > szs Then '                                           in safe zone
        cc1 = 0
        cc2 = 0
        If cwd < 50 Then mes$(0) = "Washee washee no starchee!"
    Else
        If (sy1 > (szs - t)) And (sy1 <= szs) Then '                  bouncing off ceiling
            cc1 = 0
            cc2 = 0
            vy! = 1
            py! = py! + 2
            'hover = 1
        End If
    End If
End If
Return

CheckHit: '                                                           contact with ground
cc1 = ((sy1 + 1) >= gety(-sx1)) '                                     left pad
cc2 = ((sy2 + 1) >= gety(-sx2)) '                                     right pad
mingx = 0
mingy = q1
For zx = sx1 To sx2 '                                                 check between pads
    zy = sy1 - 2
    p = Point(zx, zy)
    If p = gray Then '                                                got 1
        ty = gety(-zx)
        If ty < mingy Then mingx = zx: mingy = ty
    End If
Next zx
If mingx Then
    i = mingx - sx1
    j = sx2 - mingx
    If i < j Then cc1 = -1 Else cc2 = -1
End If

GoSub CWceiling '                                                     car wash
If vy! < 0 Then Return '                                              going UP

If cc1 Or cc2 Then '                                                  pad(s) on ground
    contact = 1
    tmt! = 0
    py! = py! + rfy '                                                 no time to correct jitter
    TexOnLM$ = ""
    warp! = 0
    GoSub CutOrOutOfFuel

    If (vy! > 0) And Abs(sy1 - (ey(2) - 40)) < t Then
        lob = 1 '                                                     landed on Borg
        vx! = vx! - exv(2)
    End If

    If (Abs(vx!) > t) Or (vy! > 20) Then
        dead$ = "HIGH SPEED IMPACT!"
        Return
    End If

    dp = 8 + (h - fuel!) \ 25 '                                       8 - 12
    If (vy! > dp) Or (Abs(vx!) > 8) Then '                            too fast given load
        crash = 1
        panelinit = 0
        shield = 0
        dead$ = "CRASHED"
        z = Abs(vx!) * t + Abs(vy!) * t
        For i = 1 To rp '                                             create layer of debris
            LMrx(i) = LMrx(i) + Rnd * z - (z \ 2)
            LMry(i) = gety(LMrx(i)) - Rnd * 2 - 1
        Next i
        If bw = 0 Then
            Palette green, 0 '                                            blank instruments
            Palette yellow, 0
        End If
        Return
    End If

    If (vy! > 3) Or (Abs(vx!) > 3) Then fb$ = "vehicle damaged"

    If (vy! > 4) Or (Abs(vx!) > 4) Then
        fb$ = "vehicle severely damaged"
        LMdistort '                                                   randomly vary structure
        vsd = 1 '                                                     vehicle severely damaged
    End If

    savea = a + ma

    If lob Then '                                                     landed on Borg
        a = 0
        If sx1 < borgl Then a = 45
        If sx2 > borgr Then a = -45
        py! = py! - t * (Abs(a) = 45)
        Return
    End If

    '                                                                 optional, allow ANY part of pad
    If cc1 Then cd = -1: cpx = sx2: cpy = sy2 + 1
    If cc2 Then cd = 1: cpx = sx1: cpy = sy1 + 1
    For i = 1 To 4
        cpx = cpx + cd
        If (cpy >= gety(-cpx)) Then
            If cc1 Then cc2 = 1 Else cc1 = 1
        End If
    Next i

    If Not (cc1 And cc2) Then '                                       only 1 pad down
        npass = 0
        Do: _Limit mdelay * 2 '                                       settle LM
            a = a + (cc1 - cc2)
            pa:
            npass = npass + 1
            If npass > 150 Then Exit Do
            GoSub Plotscreen '                                        show change
            If Len(dead$) Then Exit Do
            If Abs(a) > 40 Then
                a = 180 '                                             upside down
                py! = glmax - ny
                LMdistort '                                           optional
                Exit Do
            End If
            If cc1 And (sy1 < gety(-sx1)) Then py! = py! + 1: GoTo pa
            If cc2 And (sy2 < gety(-sx2)) Then py! = py! + 1: GoTo pa
            cc3 = ((sy1 + 1) >= gety(-sx1))
            cc4 = ((sy2 + 1) >= gety(-sx2))
            If Abs(a) > 80 Then py! = glmax - wi2

            z = gety(Int(px!)) - py! - ny + 5
            If (z < 0) And (paraf = 0) Then
                dead$ = "PUNCTURE DAMAGE"
                Return
            End If
        Loop Until (cc1 And cc4) Or (cc2 And cc3)
    End If
End If
Return

slimit: '                                                             surface index bounds
z = 0
If suri < 0 Then z = q1
If suri >= q1 Then z = -q1
suri = suri + z
If lock1 Then lock1 = lock1 + z
Return

radar: '                                                              autopilot landing here too
If contact Or liftoff Then Return
z = Sgn(vx!): If z = 0 Then z = 1
If z = -1 Then sbl = -280 Else sbl = 220
bt = (bt Mod 4) + 1
div = Abs(alt!) \ 2 + bt

If right Or left Then tvx! = sv! Else tvx! = vx!
If Abs(tvx!) > 99 Then tvx! = 99 * Sgn(tvx!)
If (tfollow = 0) And (aboveborg Or ((radarf = 0) And (auto = 0))) Then tvx! = 0
bl = sbl * Abs(tvx!) + (sx1 - sx2)
If Abs(bl) > Abs(sbl) Then bl = sbl
If auto = 0 Then lock1 = 0
If lock1 = 0 Then rxm = sx2 + bl Else rxm = lock1 - suri

level = 1
For j = 0 To wi '                                                     width (distance between pads)
    tx = rxm + j
    ty = gety(-tx)
    If aboveborg And (sx1 >= borgl) And (sx2 <= borgr) Then ty = borgt
    If j = 0 Then cmp = ty
    If Abs(cmp - ty) > 1 Then level = 0
Next j

If level Then
    If auto And (lock1 = 0) Then '                                    automatic yet no current lock
        lock1 = suri + rxm - Sgn(rxm) * 2 * (vx! <> 0) '              lock onto level ground
    End If
    rbeam = green '                                                   radar beam color
Else
    lock1 = 0 '                                                       not level, cancel lock
    rbeam = red '                                                     radar beam color
End If

rpass = rpass Xor 1
If level And (vx! = 0) Then
    div = div \ 2
    If div < 1 Then div = 1
    If rpass Then rbeam = 0
End If

For i = 0 To (wi + 1) Step 5
    If vx! > 0 Then tx = rxm + i Else tx = rxm + wi - i
    If aboveborg Then
        tx = sx1 + i
        ty = borgt
    Else
        ty = gety(tx)
    End If
    If (warp! < 1) And (ty > sy0) And (radarf > 0) Then GoSub rbeam
Next i

If auto = 0 Then GoTo end6
If aboveborg Or (abort = 0) Then GoTo skipit

abort:
hover = 1
hoverc = 0
lock1 = 0

i = (py! > 120) '                                                     too low
j = Not ((vx! = 0) And (level = 1)) And (Abs(vx!) < (ideal! - .05)) ' too slow
k = (Abs(vx!) > (ideal! + .05)) '                                     too fast
If i Then wa = -ma: hoverc = -3
If j Then wa = 4 * -z + ma
If k Then
    wa = Abs(vx!) * z - ma
    If Abs(wa) > 20 Then wa = 20 * z
End If
If i Or j Or k Then abort = 1: GoTo end6
abort = 0

skipit:
If lam Then '                                                         land at McDonalds
    dis = Abs((suri + rxm) - sf(5, 2))
    If dis > 80 Then level = 0: lock1 = 0
End If
wa = -ma ' want angle = -malfunction angle

If dflag Then dump = 0: dflag = 0
If level = 0 Then '                                                   locked onto a target
    abort = 1
Else
    ddd = Abs(px! - rxm)
    If (ddd < 120) And (lock1 > 0) And (auto = 1) And (fuel! > 70) Then
        dump = 1
        dflag = 1
    End If
    If ddd < h Then '                                                 100 clicks away
        hover = 0 '                                                   stop hovering
        vert = 1 '                                                    start moving down
        dist = sx1 - rxm '                                            distance to target
        thv! = Abs(dist) / 27 '                                       to horizontal velocity
        If thv! < .08 Then mu = 1 Else mu = 4
        If thv! < .01 Then mu = 0
        If aboveborg = 0 Then
            If Abs(vx!) > thv! Then wa = wa + mu * z
        End If
    End If
End If
end6:
GoSub angle
Return

rbeam:
dx! = (tx - sx0) / div
dy! = (ty - sy0) / div
For j = 1 To q1
    tx = sx0 + j * dx!
    ty = sy0 + j * dy!
    my = gety(-tx)
    If ty >= my Then
        If (tx < rxm) Or (tx > (rxm + wi + 1)) Then level = 0: rbeam = red
        Exit For
    End If
    If i And (rbeam > 0) Then
        PSet (tx, ty), rbeam
        If radarf = 2 Then PSet (tx + 1, ty), rbeam
    End If
Next j
Return

angle:
If dump Then Return
cf = 0
If a <> wa Then '                                                     current angle, wanted angle
    w = a '                                                           was = angle
    a = a + Sgn(wa - a)
    change = a - w
    If change Then
        cf = 1
        a1 = Abs(w + ma)
        a2 = Abs(a + ma)
        If (a1 > 4) Or (a2 > 4) Then wan = 3 '                        activate up/down
    End If
End If
     
If liftoff Or ((auto = 0) And (vert = 1) And (ma = 0)) Then Return
cp = (a <> 0) And (Rnd < .01) '                                       clear problem

If cf Or cp Then
    If cp Or (Rnd < .01) Then
        z = ma
        If cp Then ma = 0 Else ma = a
        If ma <> z Then '                                             new malfunction angle
            If ma Then
                z$ = LTrim$(Str$(-ma))
                If ma < 0 Then z$ = "+" + z$
                mes$(0) = "DANGER! STUCK THRUSTER " + z$
                If auto Then a = a - ma: wa = a - ma '                immediate correct
            Else
                mes$(0) = "THRUSTERS OK"
                If auto Then a = a + z: wa = a + z '                  immediate correct
            End If
        End If
    End If
End If
Return

Exhaust:
If inpause Then tflame = blue Else tflame = flame

If cut Then thrust! = 0
d = thrust! - (Rnd * 20 - t) * (thrust! > 0)
x = (LMx(lp) + LMx(rp)) \ 2 '                                         halfway between pads

If ASO Then '                                                         ascent stage only
    i = 30 '                                                          divisor for exhaust width
    j = 1 '                                                           throwing x off up to this amount
    k = 3 '                                                           flame decrement
    y = ny + 1 '                                                      starting y
Else
    i = 20 '                                                          divisor for exhaust width
    j = 2 '                                                           throwing x off up to this amount
    k = 2 '                                                           flame decrement
    y = ny - 3 '                                                      starting y
End If

While d > 0 '                                                         until thrust decremented to 0
    p = d \ i
    For z = -1 To 1 Step 2
        For jj = 0 To 3
            n = n + 1 '                                               add to vehicle daa
            If n > 1400 Then End '                                    beyond array size
            LMx(n) = x + p * z + Rnd * (j * 2) - j
            LMy(n) = y + Rnd * 2
            If (powerloss > 0) And (Rnd < .3) Then zz = orange Else zz = tflame
            LMc(n) = zz '                                             yellow normally, blue during pause
            If Rnd > .95 Then '                                        some way off plume for realism
                LMx(n) = LMx(n) - Rnd * 80 + 40
                LMy(n) = LMy(n) + 5
            End If
        Next jj
    Next z
    y = y + 1 '                                                       next flame row
    d = d - k '                                                       decrement temp thrust
Wend
n3 = n '                                                              main/side thrusters

'                                                                     if there's a thruster malfunction, may have both thrusters active
If (ma = 0) Or (a = 0) Or (Sgn(a) = Sgn(ma)) Then
    ta = a + ma
    pass = 1
Else
    ta = a
    pass = 2
End If
If dump Then ta = t

dors: '                                                               dump fuel or sideways motion
If liftoff Then ta = 0
If rfx And (dump = 0) Then ta = rfs! * 50
If (contact = 1) And (dump = 0) Then ta = 0: wan = 0: super = 0
If ta <> 0 Then
    If ta < 0 Then th0 = th1: z! = -2
    If ta > 0 Then th0 = th2: z! = 2
    zz = ta: If zz > t Then ta = t
    tt = Abs(zz * 4 + 4 * Sgn(ta))
    If Abs(zz) > 20 Then tt = t
    Do
        n = n + 1
        LMx(n) = LMx(th0) + z! + Rnd * 2 - 1
        LMy(n) = LMy(th0) + (Rnd * 2 - 1) * (Abs(ta) > 2)
        If dump Then
            tc = fuel
            z = 20 - 20 * s!(90 + (LMx(n) - LMx(th0)) * 1.8)
            If a = 180 Then z = -z
            LMy(n) = LMy(n) + z
        Else
            tc = -tflame
        End If
        LMc(n) = tc
        tt = tt - 1
        z! = z! * 1.15
    Loop Until (tt = 0) Or (Abs(z!) > 40)
    If dump Then
        ta = -ta
        If lockfuel = 0 Then fuel! = fuel! - .1 + (fuel! > 5) * 2
        If ta = -t Then GoTo dors
        If fuel! < 1 Then dump = 0
    End If
End If
pass = pass - 1
If pass Then ta = ma: GoTo dors
noside:

'                                                                     super - use side thrusters to augment main thrust when more than
'                                                                     100% thrust is called for
If dump Then Return
If fst Or super Or (wan > 0) Then '                                   up/down to change angle beyond 5 degrees
    If change > 0 Then th1d = -1: th2d = 1
    If change < 0 Then th2d = -1: th1d = 1
    If super Then th1d = 1: th2d = 1
    If fst Then th1d = fst: th2d = fst: fst = 0
    For z = 0 To 6
        n = n + 1
        LMx(n) = LMx(th1) + Rnd * 2
        LMy(n) = LMy(th1) + th1d * (z + Rnd * 2) + 2
        LMc(n) = tflame '                                             blue flame in pause
        n = n + 1 '                                                   other thruster opposite
        LMx(n) = LMx(th2) + Rnd * 2 - 2
        LMy(n) = LMy(th2) + th2d * (z + Rnd * 2) + 2
        LMc(n) = tflame
    Next z
    wan = wan - 1
    If wan = 1 Then change = -change
End If

Return

init1: '                                                              only done once
Data convo,f1,f2,lmx1,lmy1,lmc1,lmx2,lmy2,lmc2
Data h1,h2,h3,h4,h5,h6,cybill,surv2,cm,rad,af2,sf2,panel
Data sd,sl,s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,panel0,panel1
Data dstarm,stars,lanblank,alien

$If WIN Then
    slash$ = "\"
$Else
        slash$ = "/"
$End If

mpath$ = _CWD$
If Right$(mpath$, 1) = slash$ Then mpath$ = Left$(mpath$, Len(mpath$) - 1) ' root (maybe USB stick?), take off slash
mpath$ = mpath$ + slash$ + "L64_DAT" + slash$

Restore init1
If _FileExists("rick.txt") Then okrick = 1
tc$ = UCase$(Command$ + "   ")
If Left$(tc$, 1) = "/" Then tc$ = "   "
If InStr(tc$, "DOS") Then dosbox = 0 '                                use large star file
If InStr(tc$, "BOX") Then dosbox = 1 '                                use small star file
If InStr(tc$, "CD ") Then iscd = 1 '                                  simulate CD
If InStr(tc$, "UFO ") Then ufof = 1 '
If _FileExists("cd.dat") Then iscd = 1 '                              include/create this file for CD/DVD distribution (read only)

z = 0
For i = 1 To 40
    Read f$(i)
    If i = 38 Then '                                                  stars
        j = 2 - dosbox '                                              1=small, 2=medium, 3=huge
        f$(i) = f$(i) + Chr$(48 + j)
    End If
    f$(i) = mpath$ + UCase$(f$(i) + ".dat")
    If _FileExists(f$(i)) = 0 Then '                                            file missing
        z = z + 1
        If z = 1 Then Cls
        Print f$(i)
    End If
Next i
If z Then
    Print
    Print "mpath$ = "; mpath$
    Print "Above file(s) missing"
    Sleep
    System
End If

s& = VarSeg(p(0, 0))
o& = VarPtr(p(0, 0))
Def Seg = s&
BLoad f$(2), o&
z$ = "386C6C38" '                                                    degree symbol
For i = 0 To 3
    p(0, i) = Val("&H" + Mid$(z$, i * 2 + 1, 2))
Next i

s& = VarSeg(p2(0, 0))
o& = VarPtr(p2(0, 0))
Def Seg = s&
BLoad f$(3), o&

canvas& = _NewImage(640, 350, 9)
Screen canvas&
_AllowFullScreen , Off
_ScreenMove _Middle
_MouseHide
_MouseMove 1, 1
_Title "Lander"
Randomize Timer
auto = 0 '                                                            full automatic
background = 1 '                                                      textured LED displays
cbh = 0 '                                                             constant black holes
darkstars = 1 '                                                       spin
darkstart = 1 '                                                       thickness of lines
demo = 0 '                                                            cram onto one page
doclock = 0 '                                                         shield effect
gh = 9
gs = 85 '                                                             graphics start
glmax = q4 '                                                          ground level max
glmin = glmax - 49 '                                                  ground level min
gs = 85 '                                                             graphics start (flying area)
'gstyle = 5
invincible = 1 '                                                      easier for beginner, thrusters gold
jitter = 1 '                                                          thrust calc
LED$ = "021404120115" '                                               color sequence - gr ye re or gun wh
LEDc = green '
LEDtri = 0 '                                                          off
mdelay = t '                                                          master delay
opower = 62 '                                                         original thrust factor
pdiv = 0 '                                                            instrument update
radarf = 1
segs$ = "abcdefg" '                                                   for 7 segment displays
settings$ = mpath$ + "LANDER.SET"
shield = 0 '                                                          Star Trek!
showmap = 0 '                                                         silly legend at top
skyoff = 1 '                                                          DS, BH, Wo, Co
starfiles = 1 '                                                       dat1, dat2, dat3
starstatus = 1 '                                                      show stars only, no names/info
twinkle = 1 '                                                         stars
zoom = 1 '                                                            starfield 6 hours 45 degrees

black = 0: blue = 1: green = 2: gunmetal = 3: red = 4: gasoline = 5
gray2 = 6: white = 7: gray = 8: dred = 9: gold = 10: black2 = 11
orange = 12: blue2 = 13: yellow = 14: white2 = 15

craft = white: flame = yellow: fuel = gasoline: LEDc = green
LMci(0) = gray2 '                                                     ASO shifting colors
LMci(1) = gold
LMci(2) = gray2
LMci(3) = black2

If _FileExists(settings$) Then
    Open settings$ For Input As #1
    nflags = 0
    Do
        If EOF(1) Then Exit Do
        Input #1, g$
        If EOF(1) Then Exit Do
        nflags = nflags + 1
        Input #1, tflags(nflags)
    Loop
    Close #1
End If

auto = tflags(1)
background = tflags(2)
cbh = tflags(3)
demo = tflags(4)
doclock = tflags(5)
invincible = tflags(6)
jitter = tflags(7)
LEDc = tflags(8)
LEDtri = tflags(9)
radarf = tflags(10)
shield = tflags(11)
showmap = tflags(12)
starstatus = tflags(13)
zoom = tflags(14)
skyoff = tflags(15)
gstyle = tflags(16)
mouseswap = tflags(17)
porb = tflags(18)
starfiles = tflags(19)
mdelay = tflags(20)
fsf = tflags(21)

If fsf Then
    _FullScreen
Else
    If _FullScreen = 0 Then _FullScreen _Off
End If

For i = 0 To tsix '                                                   sines and cosines, table faster
    s!(i) = Sin(_D2R(i))
    c!(i) = Cos(_D2R(i))
Next i

clines = 0
Open f$(1) For Input As #1 '                                          convo.dat, LM/CM chatter
While Not (EOF(1))
    clines = clines + 1
    Line Input #1, convo$(clines)
Wend
Close #1

s& = VarSeg(cmp&(0)) '                                                Command Module
o& = VarPtr(cmp&(0))
Def Seg = s& '                                                        cm.dat
BLoad f$(18), o&

If (restart = 0) And ((Rnd > .9) Or (InStr(LCase$(Command$), "regen"))) Then MakeSur '    new surfaces
gh = 9 '                                                              which surface to use (1-9)
restart = 0
start1! = Timer
Return

init2: '                                                              each cycle
a = 0 '                                                               angle
a51i = 0
ASO = 0 '                                                             ascent stage only = false
boltc = 0 '                                                           lightning count
center = 362
contact = 0 '                                                         with ground
convo = 0 '                                                           with CM
crash = 0
cut = 0 '                                                             engine
dump = 0 '                                                            fuel
eou = 0 '                                                             end of universe
fb$ = "" '                                                            landing feedback
flx = 0 '                                                             where to plot flag
fuel! = h
hover = 1 '                                                           start safe
ideal! = 2.7 '                                                        autopilot speed
inpause = 0
jf = -1 '                                                             jump to feature
LGMc = 1 '                                                            little green man color
lmsl = blue '                                                         LM shield & laser
lob = 0 '                                                             landed on Borg
lock1 = 0 '                                                           radar tracking
lockfuel = 0
ma = 0 '                                                              malfunction angle
magic = 0 '                                                           landing
mes$(0) = "" '                                                        messages ^ landing eval
mes$(1) = "" '                                                        radiation, landing comments
ok = 0 '                                                              landing status
panelinit = 0 '                                                       instruments
paraf = 0 '                                                           parachute flag
pif = -1 '                                                            counter for instruments
platform = 0 '                                                        for detached DS
power = opower '                                                      thrust factor
powerloss = 0 '                                                       random malfunction
px! = 320 '                                                           vehicle x
py! = 70 '                                                            vehicle y
radiationdeath = 0 '                                                  rads > 1000
rads = 0 '                                                            radiation count
rlink = 0 '                                                           LM/CM radio link
rmin = Rnd * 23 '                                                     stars right ascension 0 - 23
dmin = (Int(Rnd * 18) - 9) * t '                                      stars declination -90 to 90
sia = 0 '                                                             shells in air
sspinit1 = 0
sspinit2 = 0
starinit = 0
tfollow = 0 '                                                         terrain following
tmt! = 0 '                                                            to move total
wa = 0 '                                                              wanted angle
vert = 1 '                                                            vertical autopilot on
vsd = 0 '                                                             vehicle severely damaged

Setcolor
GetSurface gh

If demo Then
    auto = 0
    px! = sf(6, 2) - 3130 '                                           TMA
    py! = 130
    sf = 6 '                                                          surface feature
    suri = 3130 '                                                     surface index
    vx! = 0 '                                                         not moving
    vy! = 0
Else
    a = Rnd + t
    If Rnd > pf! Then a = -a
    sf = 4
    suri = Rnd * q1
    px! = 320
    thrust! = 95
    vx! = Sgn(a) * 5
    vy! = Rnd + 1
End If

Erase exv, ei, ek, rtl!, rtlc, shx, shd

mes$(0) = "F1 FOR HELP AND INFORMATION"
If ufof > 0 Then mes$(1) = "Alien on the loose!" '                    10% active
If LEDtri Then LEDc = green
GoSub ReadLM
start2! = Timer '                                                     elapsed time clock
sec = 0
min = 0
Return

PlotGround:
If crash = 0 Then
    surd = Sgn(tmt!) '                                                direction
    tomo = Int(Abs(tmt!)) '                                           to move
    If tomo > (q3 - gs) Then tomo = q3 - gs
    tmt! = tmt! - tomo * surd '                                       to move total
    suri = suri + tomo * surd '                                       surface index
    GoSub slimit '                                                    limit values to 0-6399
End If
         
If gh = -1 Then '                                                     ground height = flat
    Line (gs, q4)-(q3, q4), gray
    GoTo stuff
End If

For x = gs To q3 '                                                    graphics start to 639
    z = (suri + x) Mod q1
    tc = gray
    If (z >= sf(5, 0)) And (z <= sf(5, 1)) Then
        PSet (x, glmax), tc '                                         optional McD fix
    Else
        If (z >= sf(7, 0)) And (z <= sf(7, 1)) Then '                 Surveyor
            y = glmax
        Else
            y = gety(x)
        End If
        Select Case gstyle
            Case Is = 0 '                                             solid
                Line (x, y)-(x, glmax), tc
            Case Is = 5 '                                             solid
                Line (x, y)-(x, glmax), tc
            Case Is = 1 '                                             fancy
                Line (x, glmax)-(x, y), black2
                Line -(x, glmax), tc, , z + y
                PSet (x, y), tc
            Case Is = 2
                Line (x, y)-(x, glmax), tc
                ty = y + 5
                If ty < glmax Then
                    Line (x, ty)-(x, glmax - 1), black, , &HFEFE
                End If
            Case Else '                                               minimal or tiling
                Line (x, glmax)-(x, y), black2
                Line -(x, y + 3), tc
        End Select
    End If
Next x

If gstyle > 3 Then Tile

stuff:
For i = 1 To t
    ' Surv before IBM+TMA, IBM before TMA, LGM last
    '              1 2 3 4 5 6 7 8 9 0
    j = Val(Mid$("01070802040506091003", (i - 1) * 2 + 1, 2))
    z = Val(Mid$("80000080000080000000", (j - 1) * 2 + 1, 2))
    fb = sf(j, 0) - z
    fe = sf(j, 1) + z
    c1 = (fe >= (suri + gs)) And (fb <= (suri + q3))
    c2 = ((fe + q1) >= (suri + gs)) And ((fb + q1) <= (suri + q3))
    If c1 Or c2 Then
        sf = 0
        If sf(j, 2) = -1 Then GoTo nf
        sf = j
        x = sf(sf, 0) - suri
        z = sf(sf, 1) - suri

        If (j = 1) And (x < 0) And (suri > 3000) Then x = x + q1: z = z + q1
        bolthitf = (skyoff = 0) And (boltx >= x) And (boltx <= z) And (exl(1) <> 9999)
        If j = 1 Then
            Area51 f$(40)
            If (cut = 0) And (Left$(mes$(1), 7) = "AREA 51") Then
                GoSub CutOrOutOfFuel
            End If
        End If
        If j = 2 Then CarWash
        If j = 3 Then LGM fc
        If j = 4 Then Volcano
        If j = 5 Then McD
        If j = 6 Then TMA
        If j = 7 Then Surveyor
        If j = 8 Then IBM
        If j = 9 Then Hollywood
        If j = t Then Grave x, fb$
    End If
    nf:
Next i
Return

CommandModule: '                                                      27 * 9
If ek(0) = -1 Then Return
cminview = 1
tx = localize(ex(0), 14, 14)
If tx = 999 Then cminview = 0: GoTo nocm
x1 = tx - 14
x2 = tx + 14

View Screen(gs + 1, 0)-(q3, q4) '                                     protect panel
Line (x1 + 0, 18)-(x1 + 26, 26), black2, BF
For z = 1 To 27
    Line (x1 + z, 17)-(x1 + z, 26), white, , cmp&(z)
Next z

CMshadow tx, x1, x2 '                                                 optional

sd! = Abs(exv(0)) - Abs(vx!) '                                        speed diff
dbc = Abs(px! - tx)

If (py! < h) And (dbc < 50) And (Abs(sd!) < .06) Then
    rlink = t
    Line (LMrx(1), LMry(1))-(tx + 8, 27), green, , Rnd * &H7FFF
    If (cmleaving + convo) = 0 Then
        mes$(0) = "Establishing link with Campbell soup cans and string"
        sct! = 2
        convo = 1
    End If
    If sc! = 0 Then sc! = Timer + sct! '                              start conversation in xs
    If Timer > sc! Then
        convo = convo + 1
        If convo > (clines + 1) Then
            sc! = 0
            convo = 0
            cmleaving = 1
        Else
            mes$(0) = convo$(convo)
            sc! = Timer + sct!
        End If
    End If
End If
     
nocm:
rlink = rlink - 1 - (rlink = 0) '                                     allows brief radio interruption
If rlink = 0 Then '                                                   lost awhile ago
    If convo Then mes$(0) = " " '                                     clear current dialogue
    convo = 0 '                                                       stop conversation
    sc! = 0 '                                                         talk timer
End If

If cmleaving And cminview Then '                                      CM exhaust
    ty = 22
    Line (x1, ty - 2)-(x1, ty + 2), yellow
    Line -(x1 - 15, ty), yellow
    Line -(x1, ty - 2), yellow
End If
Return

liftoff: '                                                            forced seperation or surface launch
If (contact Or liftoff) And (cwd < 69) And (py! > 322) Then
    dead$ = "HIT CAR WASH"
    Return
End If

If contact Then vx! = 0
If lob Then vx! = exv(2): a = 0 '                                     landed on Borg

goy = -h '                                                            AS go y
If ASO Then '                                                         ascent stage only
    If fuel! = 0 Then Return
    thrust! = h
    falling = 0
    platform = 0
    If lob Then pminy = borgt
Else
    power = opower
    thrust! = th '                                                    simulate explosive seperation
    platform = 22 '                                                   deflect flame from DS
    If contact Then
        falling = 0 '                                                 DS already on surface
    Else
        falling = 1 '                                                 DS in air
        goy = py! - 20 '                                              go y - not to screen top
    End If
    Line (gs, 30)-(q3, q4), 0, BF '                                   erase "space" area
    pminx = q1: pmaxx = -pminx
    pminy = q1: pmaxy = -pmaxy
    For i = 279 To rp '                                               draw descent stage
        c = LMc(i)
        If c < 0 Then c = fuel
        PSet (LMrx(i), LMry(i)), c
        If LMrx(i) < pminx Then pminx = LMrx(i)
        If LMrx(i) > pmaxx Then pmaxx = LMrx(i)
        If LMry(i) < pminy Then pminy = LMry(i)
        If LMry(i) > pmaxy Then pmaxy = LMry(i)
    Next i
    GoSub flevel
    If platform > 0 Then deflectat = pminy
    zz = pmaxy - pminy
    Get (pminx, pminy)-(pmaxx, pmaxy), gbuff() '                      save descent stage
    Line (gs, 30)-(q3, q4), 0, BF '                                   erase "space" area

    ta = (a + tsix) Mod tsix
    px! = px! - t * s!(ta)
    py! = py! - 15 * c!(ta) '                                         explosive seperation
End If

wASO = ASO
ASO = 1
GoSub ReadLM
If wASO = 0 Then fuel! = h
If vsd Then LMdistort

If contact Then
    dropvx! = 0
    If lob And (Abs(px! - center) > 2) Then dropvx! = exv(1)
    dropvy! = 0
Else
    dropvx! = vx!
    dropvy! = vy!
End If

If lob Or (contact = 0) Then
    wa = 0
Else
    wa = Sgn(-exv(0)) * 20 '                                          want angle
    If wa = 0 Then wa = -20
End If

sauto = auto: auto = 1
contact = 0
cut = 0
dump = 0
hover = 0
liftoff = 1
lminx = pminx
lock1 = 0
lockfuel = 0
lpass = 0
If wASO = 0 Then ma = 0
mes$(0) = ""
mes$(1) = ""
np = 0
paraf = 0
pcontact = 0
powerloss = 0
psuri = suri
py! = py! - 2 '                                                       fool CheckHit
svert = vert
vert = 0

Do: _Limit mdelay * 1.5
    If py! < 280 Then GoSub angle '                                   make a=wa (angle=wanted)
    GoSub Plotscreen
    np = np + 1
    If np >= t Then GoSub CheckHit
    z = (sy1 + sy2) / 2 - 2
    If (deflectat > 0) And (z > deflectat) And (z > deflectat) Then contact = 1
    If contact Then dead$ = "NOT YOUR DAY": Exit Do
    lpass = lpass + 1
    If thrust! = th Then thrust! = h
    If vsd Then '                                                     very severe damage
        thrust! = h - (lpass + Rnd) '                                 slowly drop power
        If thrust! < 50 Then thrust! = 50 + Rnd
        If Rnd > .95 Then
            dead$ = "STRUCTURAL FAILURE"
            Exit Do
        End If
    End If
    GoSub KeyAndMouse
    If Len(dead$) Then GoTo endl
    If lob Or ((platform > 0) And (falling = 1)) Then
        pminx = pminx + dropvx!
        pmaxx = pmaxx + dropvx!
        pminy = pminy + dropvy!
        pmaxy = pmaxy + dropvy!
        If lob = 0 Then
            dropvy! = dropvy! + .6
            dropy! = gety(-(pminx + nx))
            If pmaxy < dropy! Then
                lminx = pminx
                lminy = dropy! - zz
                deflectat = pminy
            Else
                pminx = lminx
                pminy = lminy
                psuri = suri
                pcontact = 1
                falling = 0
            End If
        End If
    Else
        pminx = lminx + (psuri - suri)
    End If
    If cut Then lpass = 0
    If wASO Then
        If (py! <= goy) And (cut = 0) Then Exit Do
    Else
        If pcontact Or (pminx < gs) Or (pminx > 580) Then Exit Do
        If (cut = 0) And (py! <= goy) Then
            hover = 1
            GoSub Autopilot
            If falling = 0 Then Exit Do
        End If
    End If
Loop Until (alt! > h) Or Len(dead$)
  
endl:
auto = sauto
crash = 0
deflectat = 0
liftoff = 0
lock1 = 0
platform = 0
vert = svert
Return

ReadLM:
LMbloads
If ASO Then '                                                         ascent stage only
    lp = 294
    nx = 16
    ny = 9
    rp = 302
    th1 = 170
    th2 = 198
    vmass = 60
Else '                                                                AS&DS 34*36
    lp = 696 '                                                        left pad
    nx = 17 '                                                         center x (for rotating)
    ny = 18 '                                                         center y
    rp = 705 '                                                        right pad
    th1 = 449 '                                                       left thruster
    th2 = 483 '                                                       right thruster
    vmass = h '                                                       full mass
End If

nred = 0 '                                                            number red (volcanic heating)
temp = 0 '                                                            temperature
If bw = 0 Then Palette gasoline, 24
xp = 97 ' radar
wi = LMx(rp) - LMx(lp) + 1 '                                          width
wi2 = wi \ 2

If invincible Then c = gold Else c = gray '                           thruster color
For i = 1 To rp
    LMx(i) = LMx(i) - nx
    LMy(i) = LMy(i) - ny
    If (LMc(i) = gray) Or (LMc(i) = gold) Then LMc(i) = c '           thrusters
    If LMc(i) < 0 Then LMc(i) = fuel '                                fuel
    LMoc(i) = LMc(i)
Next i
GoSub LMcolors
Return
' --------------------------------------------------------------------------
d1:
Data 27,"Elapsed time"
Data 36,"Distance to McD"
Data 45,"CPU"
Data 54,"Rads/temperature"
Data 86,"Fuel"
Data 126,"Altitude"
Data 166,"Horizontal velocity"
Data 206,"Vertical velocity"
Data 244,"Main thrust"
Data 277,"Sideways thrust"
Data 307,"Autopilot (full)"
Data 322,"Hover control"
Data 337,"Vertical automatic"

Data "Scored on vertical & horizontal speed:"
Data "0.00 - 0.50 Excellent"
Data "0.51 - 1.00 Good"
Data "1.01 - 2.00 Fair"
Data "2.01 - 3.00 Poor"
Data ""
Data "Landing surface should be near flat,"
Data with required ending angle under 5ø.
Data ""
Data Based on a 1974 program running on a
Data DEC PDP/11 with GT40 vector display
Data terminal at the University of Alberta.
Data The graphic at top left is usually a Henon
Data "plot, dealing with the stability of orbits."
Data The face appearing in TMA-1 when it shoots
Data "is Cybill Shepherd. If you land on TMA-1,"
Data it displays a Mandelbrot. The semaphores
Data "use proper flag positions, and the Morse"
Data code in the McDonalds sign is real too.
Data "Little Green Man can be turned into a pile"
Data of ashes.  Beware the beach balls of IBM!
Data ""
Data F2 for a demo mode showing most features.
Data ""
Data "Esc or <: Back to Lander   > Next page"

d2:
Data "ud        main thrust"
Data "<>        side thrust/angle"
Data "Shift ud  move up"
Data "Shift <>  move left/right"
Data "<>        ground back/forward"
Data "space     abort/feature cycle"
Data "Bkspace   random star position"
Data "Esc       quit"
Data "01234     stars off/on/info"
Data "aA        autopilot on/off/McD"
Data "b         goto Borg"
Data "B         goto black hole"
Data "c         cut engine"
Data "C         clock(s) on/off"
Data "d         dump fuel"
Data "D         restart with defaults"
Data "fF        fuel lock/unlimited"
Data "G         new ground"
Data "h         hover"
Data "I         invincible mode"
Data "k         kill (fire laser)"
Data "wlemtsiHg goto surface feature"
Data "L         level ground"
Data "M         Magic landing!"
Data "n         nation (flag)"
Data "o         goto comet"
Data "O         goto Deathstar"
Data "p         pause"
Data "P         parachute"
Data "r         radar"
Data "R         rendesvous with CM"
Data "T         thrust accuracy"
Data "u         instruments"
Data "v         vertical automatic"
Data "y         swap mouse buttons"
Data "z         self-destruct"
Data ".         terrain following"
Data "F2        demo mode (compressed)"
Data "F3        sky features"
Data "F4        constant black holes"
Data "F5        panel/instruments"
Data "F6        drop descent stage"
Data "F7        map at top"
Data "F8        shields (uses fuel)"
Data "F9/F10    LED color/tri-color"
Data "PgDn/Up   slower/faster"
Data "< Previous page   > Next page"

d3:
Data "/  green/amber/b&w/regular screen"
Data "+  zoom in starfield"
Data "-  zoom out starfield"
Data "\  drop bomb"
Data ".  terrain following"
Data "_  star twinkle"
Data "j  DeathStar rotation"
Data "|  generate all star files (hours!)"
Data "x  more/less stars"
Data "X  regenerate current star file"
Data "Q  oscar (LGM flag colors)"
Data "=  show LM data"
Data "[  crude black & white"
Data "]  UFO toggle"
Data "}  dissolve screen"
Data "U  ground tiling style"
Data "ctrl-c or -s: SCREEN capture"
Data "alt-Enter: fullscreen toggle"
Data ""
Data "< Previous page   > Next page"

d4:
Data "      Programmed by:   R. Frost"
Data "                       Edmonton, Alberta, Canada"
Data ""
Data "                       rfrost@mail.com "
Data ""
Data ""
Data " 1) 2001 A Space Odyssey: TMA-1, HAL, CM/LM chatter"
Data " 2) Star Trek: warp messages, phasers, shield, Borg"
Data " 3) Lost in Space: black hole warning"
Data " 4) Southpark: black hole at 3:50 (Tree-fiddy! - Chef)"
Data " 5) Simpsons: LGM saying he has semaphore flags"
Data " 6) Rocky & Bullwinkle: a hall of Montezuma (car wash)"
Data " 7) Bonanza: car wash traverse generates a Hop Sing quote"
Data " 8) SCTV: CM/LM chatter"
Data " 9) a McDonalds on the Moon, and an instrument for it"
Data "10) Little Green Man wiggles ears & reacts to LM exhaust"
Data "11) pirate books & movies: CM/LM chatter"
Data "12) Command Module leaves you stranded"
Data "13) a Steve Martin quote precedes black hole death"
Data "14) half the time the USSR flag is planted"
Data "15) Cybil Shepherd's face appears in TMA-1 when it fires"
Data "16) Halley's Comet is renamed Halle Berry"
Data "17) digital, analog, and binary clocks!"
Data "18) End Of The Universe is signaled by Chicken Little"
Data "19) Mt. Etna spews volcanic cheese"
Data "20) a parachute that doesn't work in a vacuum"
Data "21) Area 51 is the first level landing zone"
Data "22) IBM weapon is a fishing float or beach ball"
Data ""
Data "< Previous page   Esc or >: Back to Lander"

leds:
Data a,0,-2,1,-2
Data b,1,-2,1,-1
Data c,1,-1,1,0
Data d,0,0,1,0
Data e,0,-1,0,0
Data f,0,-2,0,-1
Data g,0,-1,1,-1
       
Data 0,abcdef,1,bc,2,abged,3,abgcd,4,fgbc,5,acdfg,6,acdefg,7,abc,8,abcdefg,9,abcdfg,10,g,11,def

features:
'               x   y  lz
Data "Area 51",65,40,45
Data "Car Wash",100,44,130
Data "Little Green Man",12,0,70
Data "Etna",10,49,20
Data "McDonalds",38,0,80
Data "TMA-1",45,71,80
Data "Surveyor",28,0,80
Data "IBM",50,45,90
Data "Hollywood",170,0,0
Data "a grave",68,49,98

MorseData:
Data a,.-,b,-...,c,-.-.,d,-..,e,.,f,..-.,g,--.
Data h,....,i,..,j,.---,k,-.-,l,.-..,m,--,n,-.
Data o,---,p,.--.,q,--.-,r,-.-,s,...,t,-,u,..-
Data v,...-,w,.--,x,-..-,y,-.--,z,--..,1,.----,2,..---
Data 3,...--,4,....-,5,.....,6,-...,7,--..,8,---..,9,----.
Data 0,-----,!,..--.,$,...-..-,&,.-...

warp:
Data "The Rockwell warranty is now void"
Data "Hope we don't collide with Klingons!"
Data "You need a vacation, Jim!  - Bones!"
Data "It's a long way to Tipperary!"
Data "Do we know this universe?  - Spock"
Data "My miniskirt is getting shorter! - Uhuru"
Data "Da engines kanna tayke much more! - Scotty"
Data "Keptin, are you insane? - Chekhov"
Data "Hit 10 and we die!"

radcomments:
Data "has caused genetic damage"
Data "causes glowing in the dark"
Data "5 years"
Data "1 year"
Data "6 months"
Data "1 month"
Data "1 week"
Data "8 hours"
Data "5 minutes"
Data "has killed you - press Esc"

skycrud:
Data CM,14,14
Data DS,150,150
Data BO,58,46
Data BH,200,200
Data Wo,90,90
Data Co,20,100
Data AL,40,40
Data ZZ,1,1

semadata:
Data a 1,225,180
Data b 2,270,180
Data c 3,315,180
Data d 4,0,180
Data e 5,180,45
Data f 6,180,90
Data g 7,180,135
Data h 8,270,225
Data i 9,225,315
Data j,0,90
Data k 0,225,0
Data l,225,45
Data m,225,90
Data n,225,135
Data o,270,315
Data p,270,0
Data q,270,45
Data r,270,90
Data s,270,135
Data t,315,0
Data u,315,45
Data v,0,135
Data w,45,90
Data x,45,135
Data y,315,90
Data z,135,90
Data " ",180,180
Data !,0,0

say:
Data "The time is 1234"
Data "Welcome to the Moon"
Data "I am a little green man"
Data "I have semaphore flags"
Data "R Frost is a nerd!"
Data "abcdefghijklmnopqrstuvwxyz"
Data end

BigM: '                                                               37 * 16
Data "          X               X          "
Data "         X X             X X         "
Data "        X   X           X   X        "
Data "       X     X         X     X       "
Data "      X       X       X       X      "
Data "     X         X     X         X     "
Data "     X         X     X         X     "
Data "    X           X   X           X    "
Data "    X           X   X           X    "
Data "   X             X X             X   "
Data "   X             X X             X   "
Data "  X              XXX              X  "
Data " X                                 X "
Data " X                                 X "
Data "X                                   X"
Data "X                                   X"
Data x
'     1234567890123456789012345678901234567
'              1         2         3
tinyfontd:
Data 0,7,5,5,5,7
Data 1,2,6,2,2,7
Data 2,7,1,7,4,7
Data 3,7,1,7,1,7
Data 4,5,5,7,1,1
Data 5,7,4,7,1,7
Data 6,7,4,7,5,7
Data 7,7,1,1,1,1
Data 8,7,5,7,5,7
Data 9,7,5,7,1,7
Data .,0,0,0,0,2
Data -,0,0,1,0,0
Data ":",0,2,0,2,0
Data " ",0,0,0,0,0

lmshow:
View
For pass = 1 To 2
    Cls
    For i = 1 To rp
        x = (LMx(i) + 17 - ASO) * 16 + 30 + (pass = 2)
        y = (LMy(i) + 18 - ASO * 9) * 8 + t
        If pass = 1 Then z$ = LTrim$(Str$(LMc(i))) Else z$ = Right$("  " + Str$(i), 3)
        If Len(z$) = 1 Then z$ = "0" + z$
        c = LMc(i)
        TinyFont z$, x + 3, y + 3, c
    Next i
    For i = 1 To 35 '                                                 line of numbers at top
        z$ = Right$(" " + LTrim$(Str$(i)), 2)
        TinyFont z$, (i - 1) * 16 + 33, 4, gray
        x = (i - 1) * 16 + 30 + 16
        Line (x, 0)-(x, 320), red
    Next i
    For i = 1 To 36 '                                                 columb of numbers at left
        z$ = Right$(" " + LTrim$(Str$(i)), 2)
        TinyFont z$, 8, i * 8 + 13, gray
        y = i * 8 + t + 8 + 1
        Line (0, y)-(q3, y), red
    Next i
    Line (0, 0)-(q3, 320), red, B
    _Display
    Sleep
Next pass
Return
' -------------------------------------------------------------------------------------------------------x
Sub Area51 (tf$) Static
    If a51i = 0 Then
        pi! = _D2R(180)
        zz! = Atn(1) / 45 * 3
        ac1 = red
        ac2 = white2
        fc$ = "0105030709101412"
        a51i = 1
    End If

    If bolthitf Then GoTo aother

    tx = x + 33
    For i = 20 To h Step 5
        z = (z + 2) Mod 45
        For j = 0 To 1
            Swap ac1, ac2
            For k = 0 To 3
                aa = k * 45 + z
                a1! = _D2R(aa) - zz!
                a2! = _D2R(aa) + zz!
                If j Then
                    a1! = pi! - a1!
                    a2! = pi! - a2!
                End If
                If a1! < 0 Then a1! = 0
                If a2! < 0 Then a2! = 0
                If a2! < a1! Then Swap a1!, a2!
                Circle (tx, 308), i, ac1, a1!, a2!
            Next k
        Next j
    Next i

    If invincible Then GoTo aother
    dx! = px! - tx
    dy! = 280 - py!
    If (Abs(dx!) < 81) And (Abs(dy!) < 61) And (liftoff = 0) Then
        If contact = 0 Then mes$(1) = "AREA 51 ELEVATOR ACTIVATED"
        _Delay .1
        For tx2 = sx1 To sx2 Step 1
            Line (tx2, sy1 + 2)-(tx, 309), gray
        Next tx2
        If sy1 > 310 Then
            Line (sx1 - 1, sy1 + 2)-(tx, 309), black
            Line (sx2 + 1, sy1 + 2)-(tx, 309), black
        End If
        px! = px! - Sgn(dx!)
        If Abs(dx!) < 2 Then
            If py! > 280 Then j = 0 Else j = 2
        Else
            If py! > 280 Then j = -2 Else j = 1
        End If
        py! = py! + j
        a = 0
        thrust! = 0
        vx! = 0
        vy! = 0
        b2b = 1
        GoTo bingo
    End If

    aother:
    If bb2! = 0 Then bb2! = Timer + 2
    If Timer > bb2! Then
        bb2! = Timer + 2
        b2b = 1 - b2b
    End If

    bingo:
    If contact Then b2b = 1
    If b2b Then
        If bolthitf Then tc = white Else tc = dred
        For i = 1 To 4
            tx = x + i * t + 3
            PrintVGA Mid$("AREA", i, 1), tx, 313, white2, tc
        Next i
        For nu = 0 To 1
            For ty = 0 To 4
                bp = Val("&H" + Mid$("26227E8E2E", nu * 5 + ty + 1, 1))
                sp = 1
                For tx = 1 To 4
                    If bp And 1 Then
                        tx2 = x + 52 - tx * 4 - nu * 16
                        ty2 = 309 + ty * 5 + 15
                        Line (tx2, ty2)-Step(3, 4), tc, BF
                        If sp Then sp = 0: Line (tx2 + 4, ty2)-Step(0, 4), white2
                    End If
                    bp = bp \ 2
                Next tx
            Next ty
        Next nu
    Else
        Open tf$ For Input As #5 '                                    alien.dat (head)
        zc = (zc + 1) Mod 8 '                                         color
        For i = 1 To 32
            Line Input #5, z$
            For j = 1 To Len(z$)
                c$ = Mid$(z$, j, 1)
                If c$ <> "." Then '                                   . = transparent
                    If c$ = " " Then
                        tc = Val(Mid$(fc$, zc * 2 + 1, 2))
                        If bolthitf Then tc = white
                    ElseIf c$ = "r" Then '                            spooky eyes
                        tc = red
                    Else
                        tc = black2 '                                 eyes/nose/mouth
                    End If
                    x2 = x + j + t
                    y2 = 312 + i
                    PSet (x2, y2), tc
                End If
            Next j
        Next i
        Close #5
    End If
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub AuHoVe (auto, hover, vert, lam)
    For i = 0 To 2
        z$ = Mid$(" AUTOHOVER VERT", i * 5 + 1, 5)
        If i = 0 Then k = auto
        If i = 1 Then k = hover
        If i = 2 Then k = vert

        ty = 307 + i * 15
        PrintCGA z$, 4, ty, gunmetal, black2, 0

        If k Then
            c1 = green
            c2 = black2
        Else
            c1 = black2
            c2 = red
        End If

        If crash Then c1 = black2: c2 = black2

        If lam And k And (i = 0) Then c1 = gold '                     land at McD

        PrintCGA "ON ", 57, ty - 4, c1, -1, 0

        '                                                             blink OFF to indicate a keyboard command turned it off
        If (i = 0) And (APdisengage > 0) And (c2 = red) Then
            c2 = (APdisengage Mod 2) * red
            APdisengage = APdisengage - 1
        End If
        PrintCGA "OFF", 57, ty + 3, c2, -1, 0

        tx1 = 48: ty1 = ty + 5 '                                      switches
        If i = 1 Then c = blue2 Else c = blue '                       background
        If k Then ta = 285 Else ta = 75 '                             up & down angles
        tx2 = tx1 + 5 * c!(ta)
        ty2 = ty1 + 5 * s!(ta)
        For k = 0 To 1
            Line (tx1 + 2, ty1)-(tx2 + k + 2, ty2), white '           plot switch
        Next k
        Line (tx1 + 1, ty1)-(tx2 + 1, ty2), black2 '                  outline left
        Line (tx1 + 3, ty1)-(tx2 + 4, ty2), black2 '                  outline right
    Next i
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub Bar (xdat!, cl)
    xmax = gs - t '                                                   graphics start - ten
    xmin = xmax - 50
    ymax = 273 - osc * 39
    ymin = ymax - t
    'xcen = xmin + (xmax - xmin) / 2 '                                center line
    xbar = xmin + xdat! * (xmax - xmin) '                             data
    If xbar < xmin Then xbar = xmin '                                 limit min
    If xbar > xmax Then xbar = xmax '                                 limit max

    If porb Then '                                                    led bar
        If LEDtri = 0 Then c = LEDc
        If cl Then '                                                  center line
            Line (xbar - 1, ymin + 4)-(xbar + 1, ymin + 7), c, BF
        Else
            Line (xmin, ymin + 5)-(xbar, ymin + 7), c, BF
        End If
    Else '                                                            mechanical pointer
        If (osc = 4) And (radarf = 0) Then '                          altitude with radar off
            tc1 = gray
            tc2 = black
        Else '                                                        normal
            tc1 = white
            tc2 = white
        End If
        Line (xbar, ymin + 4)-(xbar - 4, ymin + 8), tc1
        Line -(xbar + 4, ymin + 8), tc1
        Line -(xbar, ymin + 4), tc1
        Paint (xbar, ymin + 5), tc2, tc1
    End If
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub BlackHole (freeze) Static
    If ei(3) = 0 Then
        Dim tc(2)
        ei(3) = 1
        l! = aspect!
        tx = 30 + Rnd * 40
        If Rnd > .7 Then tx = tx + Rnd * h
        If Rnd > .7 Then tx = tx + Rnd * h '                          intentional repeat
        v! = tx / l!
        s1! = l! / t: r = Rnd * 90: ri = Rnd * 8 + 2
        bc = bc + 1 + (bc = 6) * 7
        z$ = "020105040906010613070603091301070605121404" '           colors
        For i = 0 To 2
            tc(i) = Val(Mid$(z$, bc * 6 + i * 2 + 1, 2))
        Next i
        d1 = Rnd * 2 + 1
        d2 = Rnd * 2 + 1
    End If

    x0 = localize(ex(3), 0, 0)
    y0 = ey(3)

    tri = ri
    If freeze Then tri = tri \ 2 '                                    rotation increment
    r = (r + tri) Mod tsix '                                           rotation
    dtlt! = -30 - 30 * Abs(c!((r * 3 + 50) Mod tsix)) '                tilt
    dtlti = (dtlt! + tsix) Mod tsix
    crot! = c!(r)
    srot! = s!(r)
    ctlt! = c!(dtlti) / d1
    stlt! = s!(dtlti) / d2
    co = (co + 1) Mod tsix

    bhx = 0: bhy = bhx
    For pass = 0 To 1 '                                               90 degrees apart
        For za! = -l! To l! Step s1!
            pd = 0 '                                                  pen up
            For zb! = -l! To l! Step s1!
                x1! = za!
                y1! = zb!
                If pass Then Swap x1!, y1!
                x! = x1! * crot! + y1! * srot!
                y! = y1! * crot! - x1! * srot!
                q! = -.8 / (x1! * x1! + y1! * y1!) + .8
                z! = q! * ctlt! - y! * stlt!
                y! = y! * ctlt! + q! * stlt!
                s! = (l! * 2) / ((l! * 2) + y!)
                xx = x0 + x! * v! * s!
                yy = y0 - z! * v! * s!
                x! = za! * 1.8: x! = x! * x!
                y! = zb! * 1.8: y! = y! * y!
                tc = tc((x! + y! + co) Mod 3)
                If pd Then Line -(xx, yy), tc Else PSet (xx, yy)
                c1 = (xx > -120) And (xx < 770)
                c2 = (yy > -120) And (yy < 470)
                If c1 And c2 Then '                                   on screen
                    bh = 1
                    If (Abs(za!) < .1) And (yy > bhy) Then
                        bhx = xx
                        bhy = yy
                    End If
                End If
                pd = 1 '                                              pen down
            Next zb!
        Next za!
    Next pass
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub BlackHoleDoom '                                                   fall in while shrinking
    fb$ = "" '                                                        silence feedback, if any
    sgs = gs '                                                        save graphics start (going to kill panel here)
    gs = 0 '                                                          kills panel
    View
    Dim LMxi!(q2), LMyi!(q2)
    For i = 1 To rp '                                                 rp=right pad (end of LM data)
        LMxi!(i) = (exl(3) - LMrx(i)) / 50
        LMyi!(i) = ((ey(3) + bhy) \ 2 - LMry(i)) / 50
    Next i
    For pass = 1 To 50
        Cls
        mes$(0) = "Let's get SMALL! - Steve Martin"
        For i = 1 To rp
            x = LMrx(i) + LMxi!(i) * pass
            y = LMry(i) + LMyi!(i) * pass
            c = LMc(i)
            If (c = gasoline) And (Rnd > pf!) Then c = 0
            PSet (x, y), c
        Next i
        GoSub ibd
        wu! = Timer + .1
        Do: _Limit mdelay
            GoSub ibd
            i$ = InKey$
            If (i$ = "q") Or (i$ = Chr$(27)) Then Quit
        Loop Until Timer > wu!
    Next pass
    mes$(0) = dead$
    mes$(1) = ""
    gs = sgs
    Exit Sub

    ibd:
    Info
    BlackHole 1
    timemachine
    Return
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub Borg (lbx, bmy) Static
    If borginit = 0 Then
        z$ = Space$(t) + "WE ARE THE BORG - RESISTANCE IS FUTILE" + Space$(50)
        moire = 0: moired = 1: xn = 19: yn = 8: zz = 13: p0 = &HAAAA
        Dim mat$(yn)
        For i = 1 To yn
            mat$(i) = String$(xn, Asc("0"))
        Next i
        borginit = 1 '                                                      direction for guts
    End If
    p1 = &H5555: p2 = &HAAAA

    borgt = bmy - 40 '                                                top
    borgl = lbx - 40 '                                                left side
    borgr = lbx + 52 '                                                right side

    x1 = lbx - 46: y1 = bmy - 34: x2 = lbx + 46: y2 = bmy + 34

    For i = 0 To zz
        tx1 = x1 + i: tx2 = x2 + i: ty1 = y1 - i: ty2 = y2 - i
        If (tx1 + 2) < gs Then Swap p1, p2
        Line (tx1, ty1)-(tx1, ty2), black2 '                          left
        Line (tx1, ty1)-(tx1, ty2), dred, , p0
        Line (tx1 + 2, ty2)-(tx2, ty2), black2 '                      bottom
        Line (tx1 + 2, ty2)-(tx2, ty2), dred, , p1
    Next i
    For i = 0 To zz
        tx2 = x2 + i: ty1 = y1 - i + 2: ty2 = y2 - i
        Line (tx2, ty1)-(tx2, ty2), red '                             right
        tx1 = x1 + i: tx2 = x2 + i: ty1 = y1 - i
        Line (tx1, ty1)-(tx2, ty1), red '                             top
    Next i
    Line (x2 + 1, y1)-(x2 + zz, y1 - zz + 1), black2 '                top right diag
    Line (x1 + 1, y2)-(x1 + zz, y2 - zz + 1), black2 '                bottom left diag

    x1 = x1 + 8: y1 = y1 + 1: y2 = y2 - 8 '                           inside of craft

    Line (x1 + 4, y1)-(x2 - 1, y2 - 4), black2, BF '                  blank interior
    Select Case bstyle1
        Case Is = 0 '                                                 ala Matrix
            '                                                         84 60
            For y = 0 To yn - 1
                mat$(y) = mat$(y + 1)
            Next y
            For x = 1 To xn
                Mid$(mat$(yn), x, 1) = Chr$(48 + Rnd)
            Next x
            For y = 0 To yn
                ty = y1 + y * 6
                TinyFont mat$(y), x1 + 5, ty + 1, blue
            Next y
        Case Is = 1 '                                                 Moire
            moire = moire + moired
            If Abs(moire) > t Then moired = -moired
            For ty = y1 To y2
                For tx = x1 To x2 - 1
                    z1! = tx / (moire + 40): z1! = z1! * z1!
                    z2! = ty / (moire + 40): z2! = z2! * z1!
                    If ((z1! + z2!) Mod 4) Then
                        If ((z1! + z2!) Mod 2) Then tc = blue Else tc = dred
                        PSet (tx, ty), tc
                    End If
                Next tx
            Next ty
        Case Is = 2 '                                                 boxes
            x2 = x2 - 3: xs = x2 - x1: ys = y2 - y1
            For z = 1 To h
                bx1 = x1 + Rnd * xs + 2
                by1 = y1 + Rnd * ys + 2
                bx2 = bx1 + (Rnd - pf!) * xs / z * t + 2
                by2 = by1 + (Rnd - pf!) * ys / z * t + 2
                If bx2 < x1 Then bx2 = x1
                If bx2 > x2 Then bx2 = x2
                If by2 < y1 Then by2 = y1
                If by2 > y2 Then by2 = y2
                c = 1 + Sgn(z Mod 2) * 12
                If Rnd > .95 Then c = gunmetal
                Line (bx1, by1)-(bx2, by2), c, B
            Next z
    End Select

    For k = -30 To 30 Step 15 '                                   exhaust, 5 flames
        bit = bit Xor 1 '                                         alternate
        For i = 0 To 20
            ba1 = (ba1 + i) Mod tsix
            zzz = ((20 - i) / 4) * Sin(_D2R(ba1))
            ty0 = y2 + i + 8 + bit + 1
            tx1 = lbx - zzz + k
            tx2 = lbx + zzz + k
            Line (tx1, ty0)-(tx2, ty0), blue, , Rnd * &H7FFF
        Next i
    Next k
    '                                                                 scroll Borg message along top and right side of craft
    ti = (ti Mod (50 * 16)) + 8 '                                     index into text, speed 1-??
    tx1 = lbx - 46 - 3
    ty1 = bmy - 31

    PrintLines z$, ti, ti + 90, tx1, ty1 - 1, black2, -88, 2, 2 '     top
    PrintLines z$, ti, ti + 90, tx1, ty1 - 0, white2, -88, 2, 2

    tx1 = lbx + 46 - 2: ty1 = bmy - 32 '                              right
    PrintLines z$, ti + 91, ti + 91 + 67, tx1, ty1, black2, -99, 2, 2

End Sub
' -------------------------------------------------------------------------------------------------------x
Sub CarWash
    Dim cwpat&(7)
    cwpat&(0) = &HFFFF
    cwpat&(1) = &H1111
    cwpat&(2) = &H2222
    cwpat&(3) = &H4444
    cwpat&(4) = &H8888
    cwpat&(5) = cwpat&(3)
    cwpat&(6) = cwpat&(2)
    cwpat&(7) = cwpat&(1)

    x1 = x + 1
    x2 = x1 + 99
    y0 = 305
    If bolthitf Then tc = white Else tc = gunmetal
    Line (x, y0 - 19)-(x2, y0 - 1), tc, BF '                          sign background
    PrintCGA "MONTEZUMA", x + 14, 286, orange, black2, 0

    If bbit Then
        c1 = green
        c2 = blue
        c3 = green
    Else
        c1 = black2
        c2 = -1
        c3 = gunmetal
    End If
    PrintCGA "Car Wash", x + 17, 294, c1, c2, 0
    Line (x, y0 - 19)-(x2, y0 - 1), c3, B

    If bolthitf Then tc = white Else tc = blue2
    Line (x, y0)-(x2, q4), tc, BF '                                   spray zone
    Line (x1, y0)-(x1, q4), white, , cwpat&(1) '                      left side &H1111
    Line (x2, y0)-(x2, q4), white, , cwpat&(1) '                      right side

    If cwsi = 0 Then cwsi = 1 '                                       spray angle increment
    cwsd = cwsd + cwsi '                                              spray direction
    If (cwsd = 0) Or (cwsd = t) Then cwsi = -cwsi '                   hit limits, reverse
    For z = 1 To 5
        x1 = x + z * t + 24
        For i = -4 To 4 Step 2
            td = cwsd - 5 + i
            If z Mod 2 = 0 Then
                td = -td
                up = 0 '                                              use pattern
            Else
                iz = (iz + 1) Mod th
                up = iz Mod 7 + 1
            End If
            ra = (90 + td * 3) Mod tsix
            tx = 64 * c!(ra) * 1.1
            ty = y0 + 64 * s!(ra)
            Line (x1, y0)-(x1 + tx, ty), gunmetal, , cwpat&(up) '     along top
            Line (x + 0, y0)-(x1 + tx \ 2, ty), gunmetal, , cwpat&(up) ' tl
            Line (x + h, y0)-(x1 + tx \ 2, ty), gunmetal, , cwpat&(up) ' tr
            tx = x1 + 20 * c!(ra) * 1.2
            ty = q4 - 20 * s!(ra) \ 2
            Line (x1, q4)-(tx, ty), white '                           bottom
        Next i
        iz = iz + 1
    Next z
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub CMshadow (tx2, x1, x2)
    z = (Timer Mod 17) + 1 '                                          rotation 1
    If z < t Then
        Line (tx2 - 4, 17 + z)-(tx2 - 1, 17 + z), white
    End If
    z = ((z + 8) Mod 17) + 1 '                                        rotation 2
    If z < t Then
        Line (tx2 + 6, 17 + z)-(tx2 + 8, 17 + z), white
    End If
    For tx = x1 To x2 '                                               shadow
        For ty = 17 To 26
            pp = Point(tx, ty)
            zx = tx - x1 - (x2 - x1) \ 2
            zy = ty - 22
            If (pp = white) And (zy > (zx + 4)) Then PSet (tx, ty), gray2
        Next ty
    Next tx
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub Comet (comx, comy)
    If crash Then tc = white Else tc = green
    For i = 0 To 1
        Circle (comx, comy), i + 1, tc, , , .78
        c$ = Mid$("HalleBerry", i * 5 + 1, 5)
        tx = comx + t
        ty = comy + i * 8
        If (tx > gs) And (tx < 590) And (ty > 0) And (ty < 330) Then PrintCGA c$, tx, ty, white2, gunmetal, 0
    Next i
    For ta = -t To t Step 5 '                                         tail, -10 to 10
        zz = 50 + Rnd * tw '                                          vary tail length
        r! = _D2R(140 + ta * 4)
        x1 = comx + 3 * Cos(r!) '                                     tail start
        y1 = comy + 3 * Sin(r!)
        r! = _D2R(140 + ta \ 2)
        x2 = comx + zz * Cos(r!) '                                    tail end
        y2 = comy + zz * Sin(r!)
        Line (x1, y1)-(x2, y2), white2, , Rnd * &H7FFF
    Next ta
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub contour Static
    wa1 = (wa1 + 5) Mod tsix
    wx! = 320 + 70 * s!(wa1)
    wy! = 175 + 70 * c!(wa1)
    Dim distance(360), elevation(360), active(10), angle(10)
    e0 = 320
    n = 6: GoSub genang
    For i = 1 To n
        angle = angle(i)
        angle = (angle + tsix) Mod tsix
        active(i) = angle
        distance(angle) = 50 + Rnd * 150
        elevation(angle) = 100 + Rnd * 150
    Next i
    n = n + 1
    active(n) = active(1)
    distance(active(n)) = distance(active(1))
    elevation(active(n)) = elevation(active(1))
    For i = 1 To n
        angle1 = active(i - 1)
        angle2 = active(i)
        ddif! = distance(angle2) - distance(angle1)
        edif! = elevation(angle2) - elevation(angle1)
        If i = n Then angle2 = angle2 + tsix
        a! = 0: ai! = 90 / (angle2 - angle1)
        For z = Int(angle1) To angle2
            na = z Mod tsix
            a! = (a! + ai!) Mod tsix
            aa = Abs(a! Mod tsix)
            z! = s!(aa) * s!(aa)
            distance(na) = distance(angle1) + ddif! * z!
            elevation(na) = elevation(angle1) + edif! * z!
        Next z
    Next i
    For el = -200 To 220
        zz = 155 * s!((Abs(el) * 3) Mod tsix) + 100
        bb = bb Xor 1
        If bb Then c& = _RGB32(0, 0, zz) Else c& = _RGB32(zz, 0, 0)
        For mangle = 0 To tsix
            angle = mangle Mod tsix
            distance = distance(angle)
            elevation = elevation(angle)
            epf! = distance / (e0 - elevation)
            d! = distance - ((el - elevation) * epf!)
            tx = px! + d! * c!(angle)
            ty = py! - d! * s!(angle)
            If mangle Then Line -(tx, ty), c& Else PSet (tx, ty), c&
        Next mangle
    Next el
    Exit Sub

    genang:
    zz = 420 / n
    For i = 2 To n
        ta = (i - 2) * zz + Int(Rnd * 10) - 5 + 30
        angle(i) = Int(ta Mod tsix)
    Next i
    sort:
    sorted = 1
    For i = 1 To n - 1
        a1 = angle(i)
        a2 = angle(i + 1)
        If a1 > a2 Then sorted = 0: Swap angle(i), angle(i + 1)
    Next i
    If sorted = 0 Then GoTo sort
    For i = 1 To n - 1
        a1 = angle(i)
        a2 = angle(i + 1)
        If (a2 - a1) < 20 Then GoTo genang
    Next i
    Return
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub CybillPix (pfile$) Static '                                       Sheperd when TMA fires
    If cpinit = 0 Then
        z = 1225
        Dim cbuff(z)
        s& = VarSeg(cbuff(0))
        o& = VarPtr(cbuff(0))
        Def Seg = s&
        BLoad pfile$, o&
        cpinit = 1
    End If
    If ((x + 5) >= gs) And (x < 600) Then Put (x + 5, 289), cbuff(), PSet
End Sub
' -------------------------------------------------------------------------------------------------------x
Function dcolor (v!, z1, z2, d) '                                     determine color for various displays
    dcolor = LEDc '                                                   normal
    If liftoff = 0 Then
        tv! = Abs(v!)
        If d = 1 Then '                                               problem higher
            If tv! > z1 Then dcolor = yellow '                        warning
            If tv! > z2 Then dcolor = red '                           serious warning
        Else '                                                        problem lower
            If tv! < z1 Then dcolor = yellow '                        warning
            If tv! < z2 Then dcolor = red '                           serious warning
        End If
    End If
End Function
' -------------------------------------------------------------------------------------------------------x
Sub DeathStar (dtx, tf$) Static '                                     relies on data files
    If dsinit = 0 Then '                                              one time initializations
        Dim tc(1)
        xc = 320: yc = 175: dty = 170
        xs = 130: ys = 110: bs = ys - t: rs = 8000
        wx1 = xc - xs: wx2 = xc + xs
        wy1 = yc - ys: wy2 = yc + ys
        Close #8
        ReDim buff&(rs)
        Open tf$ For Binary As #8
        dsinit = 1
    End If

    If darkstarc = 0 Then c1 = black2: c2 = blue: c3 = blue2
    If darkstarc = 1 Then c1 = gunmetal: c2 = red: c3 = dred
    tc(0) = c2: tc(1) = c3

    Circle (dtx, dty + 6), xs, black2 '                               define area
    For z = -1 To 1 Step 2 '                                          circle may be barely on screen
        Paint (dtx + z * (xs - 1), dty), c1, black2 '                 far left & far right
    Next z

    xx = dtx - xc
    yy = dty - yc
    zz = (zz + darkstars) Mod 49 '                                    0-48 images
    rn& = zz * rs * 4 + 1
    Get #8, rn&, buff&()
    n = -1
    For i = wx1 To wx2
        tx = xx + i
        If tx > q3 Then GoTo bork
        For j = wy1 To wy2 Step 15
            For k = 0 To 1
                n = n + 1
                If (buff&(n) > 0) And (tx >= gs) Then
                    Line (tx, j)-(tx, j + 15), tc(k), , buff&(n)
                    If darkstart Then Line (tx, j + 1)-(tx, j + 16), tc(k), , buff&(n)
                End If
            Next k
        Next j
    Next i
    bork:
    GoSub Title

    boltx = q1 '                                                      handy large value

    If Rnd > .7 Then '                                                lightning bolt
        a! = 90 + (Rnd * 20) - t '                                    starting angle
        r! = bs '                                                     starting radius
        bolty = q1 '                                                  handy large value
        For i = -h To h '                                             -100 to 100
            tx = dtx + i
            ty = gety(tx)
            If ty <= bolty Then
                If (bolty = q1) Or (Rnd > .8) Then boltx = tx
                bolty = ty
            End If
        Next i
        Do
            xx = dtx + r! * Cos(_D2R(a!)) * aspect!
            yy = dty + r! * Sin(_D2R(a!))
            If yy > q4 Then Exit Do '                                 q4 = 349
            a! = a! + Rnd * 2 - 1 + Sgn(xx - boltx) * .05
            r! = r! + Rnd * 2.18 - 1
            If r! < bs Then r! = bs
            GoSub dot
        Loop
    End If

    nc = Rnd * 3 '                                                    "internal" lightning
    For s = 0 To nc
        Do
            a! = Rnd * tsix
        Loop Until Abs(a! - 90) > 20
        td = bs \ 2 + Rnd * bs \ 2
        If Rnd > .8 Then td = Rnd * bs
        r! = td
        qq = 6
        Do
            xx = dtx + r! * Cos(_D2R(a!)) * aspect!
            yy = dty + r! * Sin(_D2R(a!))
            GoSub dot
            a! = a! + Rnd * 2.15 - 1
            r! = r! - Rnd * 2.18 + qq
            qq = qq - 1 - (qq = 1)
        Loop Until r! < td
    Next s
    Exit Sub

    dot:
    dx! = px! - xx
    dy! = py! - yy
    dd! = Sqr(dx! * dx! + dy! * dy!)
    tcc = 1 - (Rnd > pf!) * 14
    If (shield = 0) And (dd! < 15) Then bolthit = 1
    If shield And (dd! <= 70) Then
        tcc = green
        If Rnd > .95 Then Line (sx0 + xoff, sy0 + vy!)-(xx, yy), red
    End If
    PSet (xx, yy), tcc
    Return

    Title:
    If atu = 0 Then atu = t: ati = 1
    atu = atu + ati
    If (atu = t) Or (atu = 25) Then ati = -ati
    t$ = "STARBUCKS" '                                                was EPCOR, then DEATHSTAR
    For i = 1 To Len(t$)
        z$ = Mid$(t$, i, 1)
        aa = -90 + (i - Len(t$) \ 2 - 1) * atu
        tx = dtx + bs * Cos(_D2R(aa)) * aspect! - 5
        ty = dty + bs * Sin(_D2R(aa))
        PrintVGA z$, tx, ty, c3, white
    Next i
    Return
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub dissolve Static '                                                 called with }
    Dim Buffer As _MEM
    Buffer = _MemImage(0)
    np = 0
    Do
        For y = _Height - 8 To 0 Step -1
            For x = 0 To _Width
                f& = y * _Width + x
                t& = f& + Int(Rnd * 2 + 4) * _Width
                d = _MemGet(Buffer, Buffer.OFFSET + f&, _Unsigned _Byte)
                _MemPut Buffer, Buffer.OFFSET + t&, d As _UNSIGNED _BYTE
            Next x
        Next y
        If np = 0 Then
            For x = 0 To _Width * 4
                _MemPut Buffer, Buffer.OFFSET + x, 0 As _UNSIGNED _BYTE
                o2& = _Width * _Height - 1 - x
                _MemPut Buffer, Buffer.OFFSET + o2&, 0 As _UNSIGNED _BYTE
            Next x
        End If
        timemachine
        np = np + 1
        If InKey$ = Chr$(27) Then System
    Loop Until np > 120
    _MemFree Buffer
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub Evaluate (savea, z) '                                             landing analysis
    If (Abs(z) > 4) And (crash = 0) Then
        If Abs(savea) > 4 Then
            z$ = "contact angle " + LTrim$(Str$(-savea)) + Chr$(248)
            GoSub tackon
        End If
        If Abs(z) > 4 Then
            z$ = "ending angle " + LTrim$(Str$(-(z))) + Chr$(248)
            GoSub tackon
        End If
    End If

    If Abs(vx!) > 3 Then z$ = "horizontal velocity": GoSub tackon
    If Abs(vy!) > 3 Then z$ = "vertical velocity": GoSub tackon
    ok = -(Len(fb$) = 0)
    z! = Abs(vx!)
    If (z! <= 3) And (vy! <= 3) Then score = 5: z$ = "Poor"
    If (z! <= 2) And (vy! <= 2) Then score = 4: z$ = "Fair"
    If (z! <= 1) And (vy! <= 1) Then score = 3: z$ = "Good"
    If (z! <= pf!) And (vy! <= pf!) Then score = 2: z$ = "Excellent"
    If (z! < .1) And (vy! < .1) Then score = 1: z$ = "Fantastic"
    If magic Then z$ = "Magic"
    If ok = 0 Then z$ = "Bad"
    z$ = z$ + " landing"
    If crash Then fb$ = "": z$ = "CRASHED"

    If lob Then
        z$ = z$ + " on Borg": GoSub tackon
        GoTo eother
    End If

    v$ = "" '                                                         verb
    n$ = "" '                                                         noun
    ldis = q1 '                                                       last distance

    For i = 1 To t '                                                  5wlemtsihg
        tx = sf(i, 2) - suri '                                        point of interest middle
        If tx < 0 Then tx = tx + q1
        poi$ = sf$(i) '                                               name of poi
        dis = Abs(px! - tx)
        If (poi$ = "") Or (dis > ldis) Then GoTo ni
        ldis = dis
        If dis < h Then
            n$ = poi$
            don = (sf(i, 2) - sf(i, 0)) + wi2 '                       distance to be "on"
            If dis < don Then
                '        pad  349              LGM        Surveyor
                If (Abs(sy1 - q4) < 20) And (i <> 3) And (i <> 7) Then
                    v$ = "in"
                Else
                    v$ = "on"
                End If
            Else
                v$ = "at"
            End If
            If ok Then
                If (i = 1) Then mes$(1) = "MIB will visit you shortly!"
                If (i = 3) And (LGMc = gray) Then n$ = "the ashes of " + n$
                If (i = 4) And (v$ = "on") Then mes$(1) = "On a volcano?  Are you crazy?"
                If (i = 5) Then mes$(1) = "Buzz wants a Happy Meal!"
                If (i = t) And (v$ = "on") Then
                    mes$(1) = "Rude to land on a tombstone!"
                End If
            End If
        End If
        ni:
    Next i

    z$ = RTrim$(z$ + " " + v$ + " " + n$): GoSub tackon

    If v$ = "in" Then '                                               handle oddball cases
        If n$ = sf$(6) Then mes$(1) = "The aliens will not be pleased!"
        If n$ = sf$(8) Then mes$(1) = "Merged with the machine!"
        If n$ = sf$(t) Then mes$(1) = "Desecration of a grave!"
    End If

    eother:
    If fuel! = 0 Then z$ = "ran out of fuel!": GoSub tackon
    Exit Sub

    tackon:
    If Len(fb$) Then z$ = ", " + z$
    fb$ = fb$ + z$
    Return
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub ExplodeLM
    Dim LMxi!(q2), LMyi!(q2)
    CountFuel = 0
    For i = 1 To rp '                                                 for each pixel, a direction
        ta = Rnd * tsix '                                             pick an angle, any angle
        If contact Then ta = Rnd * 180 + 180 '                        upward only if on ground
        tf = Rnd * 20 + 2 '                                           force
        LMxi!(i) = tf * c!(ta) '                                      x increment
        LMyi!(i) = tf * s!(ta)
        If LMc(i) = fuel Then '                                       color
            CountFuel = CountFuel + 1
            If CountFuel < ptk Then LMc(i) = 0 '                      points to kill
        End If
    Next i
    contact = 0
    fb$ = "" '                                                        eval feedback
    sgs = gs
    gs = 0 '                                                          full screen
    View
    For pass = 1 To 40 '                                              expanding debris
        Cls
        mes$(0) = dead$
        mes$(1) = ""
        Info '                                                        say why exploding
        For i = 1 To rp
            LMrx(i) = LMrx(i) + LMxi!(i)
            LMry(i) = LMry(i) + LMyi!(i)
            LMyi!(i) = LMyi!(i) - grav! * (warp! = 0)
            x = (LMrx(i) - h) * aspect!
            y = LMry(i)
            s = i Mod 5 '                                             size
            Line (x, y)-(x + s, y + s), LMc(i), BF
            z1 = ((Rnd * t) - 5) * 3
            z2 = ((Rnd * t) - 5) * 3
            Line (x + z1, y + z2)-(x + z1 + s, y + z2 + s), LMc(i), BF
        Next i
        Line (0, 0)-(q3, q4), 0, B '                                  erase ugly border
        timemachine
        w! = Timer + .02: While Timer < w!: Wend
    Next pass
    gs = sgs
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub ExplodeShell (s) '                                                not contact - when LM fires at them
    tx = shx(s) - suri
    ty = shy(s)
    Line (tx - 5, ty - 5)-(tx + 5, ty + 5), black2, BF '              erase shell

    For d = t To 30 Step 2 '                                          distance
        For z = 0 To 40 - d '                                         particles at above distance
            ang = Rnd * tsix '                                        angle
            tx2 = tx + d * c!(ang) * aspect!
            ty2 = ty + d * s!(ang)
            bit = bit Xor 1
            If bit Then c = red Else c = yellow
            PSet (tx2, ty2), c
        Next z
    Next d
    shx(s) = 0
    shd(s) = q1 '                                                     6400, any large number
    sia = sia - 1 '                                                   shells in air
End Sub
' -------------------------------------------------------------------------------------------------------x
Function FileCheck$ (f$)

    If _FileExists(f$) = 0 Then
        Locate 10, 1
        Color 15, 0
        Print f$
        _Display
        Sleep
        System
    End If

    'i = 0
    'If _FileExists(LCase$(f$)) Then f$ = LCase$(f$): i = 1
    'If _FileExists(UCase$(f$)) Then f$ = UCase$(f$): i = 1
    'If i = 0 Then f$ = ""
    FileCheck$ = f$
End Function
' -------------------------------------------------------------------------------------------------------x
Sub FlagandFireworks Static '                                         after good landing
    If fmax = 0 Then
        fs = 60: fq = 600: fmax = fs
        Dim flagb(fq)
        Dim ve!(fs), ho!(fs), pe(fs), x!(fs), y!(fs), c(fs)
    End If

    If flx = 0 Then '                                                 initialize
        z = Sgn(sf(sf, 2) - (px! + suri)) '                           to plant flag opposite feature
        If z = 0 Then z = -1 '                                        optional, prevent middle
        For i = -1 To 1 Step 2 '                                      check sides
            tx = px! + i * z * 22
            ty = gety(-tx)
            '                                                         prevent PUT beyond 580 for grave in demo mode
            If (tx < 580) And (Abs(ty - sy1) < t) Then
                flx = tx
                fly = ty
                rev = 0
                If nation = 1 Then nation = 2 Else nation = 1
                initfw = 0
                Exit Sub
            End If
        Next i
        Exit Sub
    End If

    If liftoff Then GoTo pflag '                                      no fireworks when LM is lifting off

    If initfw = 0 Then '                                              fireworks launch & init
        ve! = Rnd * 5 + 16 - lob * 8 '                                vertical velocity
        ho! = Rnd * 5 + 2 '                                           horizontal velocity
        x!(0) = px! '                                                 initial x, middle of craft
        y!(0) = py! - 15 + ASO * 7 '                                  initial y, top of craft
        ea = -(Rnd * t) '                                             explode at 0-10
        If lho! > 0 Then ho! = -ho! '                                 reverse direction half the time
        lho! = ho!
        Do '                                                          launch
            x!(0) = x!(0) + ho! / t '                                 t = 10
            y!(0) = y!(0) - ve! / t
            ve! = ve! - .1 '                                          slow down
            PSet (x!(0), y!(0)), yellow '                             launch track
        Loop Until ve! < ea '                                         explode
        For i = 1 To fmax
            z = nation - 1
            z = z * 6 + (i Mod (3 - z)) * 2 + 1 '                     color index
            '                rewhblreye
            c(i) = Val(Mid$("0415010414", z, 2)) '                    color
            z! = Rnd * 5 + 1 '                                        velocity
            ta = (i * 6) Mod tsix '                                    angle
            ve!(i) = z! * c!(ta) '                                    vertical velocity
            ho!(i) = z! * s!(ta) * 1.8 '                              horizontal velocity
            x!(i) = x!(0) + ho!(i) * 2 + xe! '                        start of arm
            y!(i) = y!(0) + ve!(i) * 2 + ye!
            pe(i) = Rnd * 5 + t '                                     persistance of arm
        Next i
        initfw = 1 '                                                  mark initialized
    End If

    f = 1 '                                                           assume done
    For q = 0 To 1 '                                                  show shell exploding
        For i = 1 To fmax '                                           arms
            If pe(i) Then '                                           persistance of arm
                f = 0 '                                               not done
                pe(i) = pe(i) - 1 '                                   persistance
                x!(i) = x!(i) + ho!(i)
                y!(i) = y!(i) + ve!(i)
                ve!(i) = ve!(i) + .4 '                                gravity modifies vertical
                If Rnd > .1 Then
                    Line (x!(i), y!(i))-(x!(i) + Rnd, y!(i) + Rnd), c(i), B
                End If
            End If
        Next i
    Next q
    If f Then initfw = 0 '                                            end of this one, start another

    pflag: '                                                          plant/show flag
    If sn <> nation Then '                                            new, or user changed it
        sn = nation '                                                 save current nation
        s& = VarSeg(flagb(0)) '                                       segment
        o& = VarPtr(flagb(0)) '                                       offset
        Def Seg = s& '                                                set segment
        BLoad f$(19 + nation), o& '                                   load array 20=USA 21=USSR
        sx = 0
        rev = 0
    End If

    ReDim f2(600) '                                                   FLAG
    ty = fly - 80
    Line (flx - 1, fly)-(flx - 1, ty), white '                        pole
    zx = flx - rev * 71
    Get (zx, ty)-(zx + 70, ty + 32), f2() '                           was flx
    Put (zx, ty), flagb(), PSet '                                     flag

    '                                                                 optional move flag to left of pole
    If (flx < px!) And (rev = 0) And (liftoff = 0) Then
        For rx = 0 To 69
            For ry = 0 To 32
                p = Point(flx + rx, ty + ry)
                PSet (flx - rx - 2, ty + ry), p
            Next ry
        Next rx
        Put (flx, ty), f2(), PSet '                                   restore original area
        Get (flx - 71, ty)-(flx - 2, ty + 32), flagb() '              get new
        rev = 1
        zx = flx - 71
    End If
    ReDim f2(0)

    sx = sx + t '                                                     optional unfurl flag
    If sx > 70 Then sx = 70
    If sx < 70 Then
        If rev Then
            Line (zx, ty)-(zx + 71 - sx, ty + 32), 0, BF
        Else
            Line (zx + sx, ty)-(zx + 71, ty + 32), 0, BF
        End If
    End If
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub GetSurface (gh) '                                                 load surface array
    Dim lz(t) '                                                       landing zones
    f$ = mpath$ + "s" + LTrim$(Str$(gh)) + ".dat" '                     0 - 10
    If gh < 0 Then f$ = mpath$ + "SL.DAT" '                           l for level
    If demo Then f$ = mpath$ + "SD.DAT" '                             d for demo
    Close #6
    Open f$ For Random As #6 Len = 2
    For i = 0 To 6399
        Get #6, i + 1, gh(i)
    Next i
    For i = 1 To t '                                                  create landing zones
        If demo Then '                                                compress onto 1 page
            lz(i) = 3050 + (i - 1) * 80
        Else
            lz(i) = 320 + (i - 1) * (q3 + 1) '                        1 per page
        End If
    Next i
    If demo Then '                                                    all on one page
        Swap lz(9), lz(t) '                                           move grave 1 page left
        Swap lz(2), lz(4) '                                           move car wash 2 pages right
    End If
    Restore features
    For i = 1 To t
        Read sf$(i), x, y, lz '                                       sf = special feature
        sf(i, 0) = lz(i) - x \ 2 '                                    start
        If demo And (i = 9) Then sf(i, 0) = 3750 '                    Hollywood
        sf(i, 1) = sf(i, 0) + x '                                     end
        sf(i, 2) = sf(i, 0) + x \ 2 '                                 middle
    Next i
    If demo Then '                                                    move LGM to top of grave
        sf(3, 0) = sf(t, 0) + 14 '                                    x left
        sf(3, 1) = sf(t, 1) + 14 '                                    x right
        sf(3, 2) = sf(t, 2) + 14 '                                    x middle
    End If
    sspinit2 = 0
End Sub
' -------------------------------------------------------------------------------------------------------x
Function gety (x) '                                                   ground level for given x
    ax = Abs(x)
    xx = (suri + ax) Mod q1
    If sy1 > 310 Then
        c1 = (xx >= sf(2, 0)) '                                       car wash start
        c2 = (xx <= sf(2, 1)) '                                       car wash end
        If c1 And c2 Then
            If ASO Then z = 320 Else z = 338 '                        safe zone start different with ascent stage only
            If sy1 > z Then
                gety = q4 '                                           349, max y
                Exit Function
            End If
        End If
    End If
    If x < 0 Then
        c1 = (ek(2) <> -1) And (ek(2) < h)
        c2 = (skyoff = 0) And (sy1 < borgt) And (ax > borgl) And (ax < borgr)
        If c1 And c2 Then
            gety = borgt
            Exit Function
        End If
    End If
    gety = gh(xx)
End Function
' -------------------------------------------------------------------------------------------------------x
Sub GraphSpeed Static '                                               pointless with QB64, but handy with QB4.5
    If speedi = 0 Then
        spq = t: psp = 500
        Dim spt!(spq)
        Dim pspeed(psp)
        Dim m(3) As _MEM
        m(0) = _Mem(spt!(0))
        m(1) = _Mem(spt!(1))
        m(2) = _Mem(pspeed(0))
        m(3) = _Mem(pspeed(1))
        speedi = 1
    End If

    If spt! = 0 Then
        spt! = Timer
        zmin! = h
        zran! = 2
        sphac = psp + 1
    Else
        _MemCopy m(1), m(1).OFFSET, 4 * spq To m(0), m(0).OFFSET
        _MemCopy m(3), m(3).OFFSET, 2 * psp To m(2), m(2).OFFSET

        If spt! > Timer Then spt! = Timer
        spt!(spq) = (Timer - spt!) * h * t
        spt! = Timer
        z! = 0
        For i = 1 To spq
            z! = z! + spt!(i)
        Next i
        pspeed(psp) = z! / spq
        spmin = q1: spmax = -spmin
        sphac = sphac - 1 - (sphac = 0)

        If rick = 0 Then Exit Sub

        For i = sphac To psp
            spx = 113 + i
            spy = zmin! + (pspeed(i) - zmin!) / zran!
            If i = sphac Then
                PSet (spx, spy), orange
            Else
                Line -(spx, spy), orange
            End If
            If pspeed(i) <= spmin Then spmin = pspeed(i): spminx = spx: spminy = spy
            If pspeed(i) >= spmax Then spmax = pspeed(i): spmaxx = spx: spmaxy = spy
        Next i

        spsta = Fix(spmin / h) * h
        spend = Int(spmax / h + pf!) * h
        spend = spend - (spend = spsta) * h
        For i = spsta To spend Step h
            spy = zmin! + (i - zmin!) / zran!
            Line (110, spy)-(614, spy), green, , &H1111
            z$ = Right$("  " + Str$(i), 4)
            TinyFont z$, 87, spy - 2, orange
            TinyFont z$, 620, spy - 2, orange
        Next i

        z$ = LTrim$(Str$(spmin))
        ty = spminy - 15
        TinyFont z$, spminx + 5, ty, orange
        Line (spminx, ty + 5)-(spminx, ty - 5), orange

        z$ = LTrim$(Str$(spmax))
        ty = spmaxy + 15
        If ty > q4 Then ty = q4 - 20
        TinyFont z$, spmaxx + 5, ty, orange
        Line (spmaxx, ty)-(spmaxx, ty + t), orange
    End If
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub Grave (x, fb$) Static '                                           JFK's grave
    tx1 = x: If tx1 < gs Then tx1 = gs
    tx2 = x + 68: If tx2 > q3 Then tx2 = q3
    If tx1 >= tx2 Then Exit Sub
    View Screen(tx1, 300)-(tx2, q4)
    If bolthitf Then
        tc = white: tc2 = white
    Else
        tc = gray: tc2 = gasoline
    End If
    Line (x, 300)-(x + 68, q4), tc, BF
    Line (x + 2, 302)-(x + 66, 347), black2, B
    For x1 = 0 To 1
        For y1 = 0 To 1
            x2 = x + x1 * 68 - 4
            y2 = 300 + y1 * 42 - 1
            Line (x2, y2)-(x2 + 9, y2 + 9), tc2, BF
            Line (x2, y2)-(x2 + 9, y2 + 9), black2, B
        Next y1
    Next x1

    For z = 0 To 1
        Line (x + z, 300 + z)-(x + 68 - z, q4 - z), tc2, B
    Next z

    If InStr(fb$, "g on a ") = 0 Then
        z$ = "  JFK      R.I.P. 1917 1963"
    Else
        If (Timer Mod 10) < 5 Then
            z$ = "B FROST    R.I.P. 1952 2006"
        Else
            z$ = "R FROST    R.I.P. 1957 2022"
        End If
    End If

    PrintVGA Left$(z$, 7), x + 5, 317, black2, white2

    For i = 0 To 1 '                                                  spooky wave effect for dates
        d$ = Mid$(z$, i * 9 + 10, 9)
        c1 = black2: c2 = gasoline
        For j = 1 To 9
            c$ = Mid$(d$, j, 1)
            ta = (ta + 23) Mod tsix
            zz = (3 + 3 * Sin(ta * Atn(1) / 45)) * i
            tx = x + (j - 2) * 6 + 12
            ty = 304 + i * 24 + zz
            PrintCGA c$, tx, ty, c1, c2, 0
        Next j
    Next i
    View Screen(gs, 0)-(q3, q4)
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub Help
    View: Cls
    hp = 1
    Do
        Cls
        If hp = 1 Then GoSub Help1
        If hp = 2 Then GoSub Help2
        If hp = 3 Then GoSub Help3
        If hp = 4 Then GoSub credits
        timemachine
        Do: _Limit 30
            i$ = InKey$
        Loop Until Len(i$)
        If Len(i$) = 1 Then k = Asc(i$) Else k = Asc(Right$(i$, 1))
        hp = hp + (k = 75) - (k = 77)
        If (k = 27) Or (hp < 1) Or (hp > 4) Then Exit Do
    Loop
    Cls
    Exit Sub
    ' --------------------------------------------------------------------------
    ReadAndReplace:
    Read z$
    z = InStr(z$, "ground")
    p = InStr(z$, "<"): If (p > 0) And (z = 0) Then Mid$(z$, p, 1) = Chr$(27)
    p = InStr(z$, ">"): If (p > 0) And (z = 0) Then Mid$(z$, p, 1) = Chr$(26)
    Return
    ' --------------------------------------------------------------------------
    Help1:
    Restore d1
    ReDim gbuff2(8000)
    s& = VarSeg(gbuff2(0))
    o& = VarPtr(gbuff2(0))
    Def Seg = s&
    BLoad mpath$ + "PANEL.DAT", o&
    Put (0, 0), gbuff2(0)
    ReDim gbuff2(0)
    Line (85, 0)-(260, q4), gray, BF
    For i = 1 To 13 '                                                 define the panel first
        Read ty, z$
        If i < 5 Then
            sprint2 z$, 90, ty, white, 0
        Else
            If i = 9 Then z$ = Chr$(24) + Chr$(25) + z$ '             up & down arrow keys
            If i = 10 Then z$ = Chr$(27) + Chr$(26) + z$ '            left & right arrow keys
            sprint z$, 90, ty, white, 0
            If (i = 9) Or (i = 10) Then sprint Left$(z$, 2), 90, ty, red, 0
            If i > 10 Then sprint Left$(z$, 1), 90, ty, red, 0
        End If
    Next i
    Line (261, 0)-(639, q4), blue2, BF '                              summary of program
    ty = 11: c = white
    For i = 1 To 25
        GoSub ReadAndReplace
        p = InStr(z$, "*auto")
        If p Then qm$ = Chr$(34): Mid$(z$, p, 6) = qm$ + "auto" + qm$
        sprint z$, 275, ty, c, 0
        ty = ty + 9 - (z$ <> "") * 5
    Next i
    Return
    ' --------------------------------------------------------------------------
    Help2:
    Restore d2
    c1 = gray
    c2 = black
    z$ = "KEYBOARD COMMANDS"
    GoSub pageprep
    tx = 40: ty = 26
    For i = 1 To 46
        GoSub ReadAndReplace
        p = InStr(z$, "ud")
        If p Then Mid$(z$, p, 2) = Chr$(24) + Chr$(25)
        If i = 3 Then Mid$(z$, 8, 1) = " "
        e = InStr(z$, "main t") + InStr(z$, "side t")
        If e Then c = green Else c = white
        If InStr("ahv", Left$(z$, 1)) Then c = gasoline
        sprint2 z$, tx, ty, c, 0
        ty = ty + 11: If ty > 276 Then tx = 340: ty = 26
    Next i
    Line (50, 300)-(585, 300), 0
    Line (55, 302)-(590, 302), 0
    GoSub ReadAndReplace
    sprint2 "When landed or paused, arrow keys move stars", 135, 282, white, 0
    ty = 310
    sprint z$, 350, ty, white, 0
    sprint "essential", 50, ty, green, 0
    sprint "other flight", 150, ty, gasoline, 0
    Return

    Help3:
    Restore d3
    c1 = gray
    c2 = black
    z$ = "MORE KEYBOARD COMMANDS"
    GoSub pageprep
    tx = 200: ty = 36: c2 = blue
    For i = 1 To 20
        GoSub ReadAndReplace
        If i = 20 Then ty = 310: c2 = black
        sprint z$, tx, ty, white, c2
        ty = ty + 14
    Next i

    Line (50, 300)-(585, 300), 0
    Line (55, 302)-(590, 302), 0
    Return
    ' --------------------------------------------------------------------------
    credits:
    Restore d4
    c1 = dred
    c2 = white
    z$ = "AUTHOR & HUMOUR SUMMARY"
    GoSub pageprep: x1 = 86: ty = 40
    For i = 1 To 30
        GoSub ReadAndReplace
        If i = 30 Then
            x1 = 320 - Len(z$) * 4 - 8
            x2 = 320 + Len(z$) * 4 + 8
            ty = 330
            Line (x1, ty)-(x2, ty + 11), dred, BF
        End If
        sprint2 z$, x1 + 8, ty, c2, 0
        ty = ty + t
    Next i
    Return
    ' --------------------------------------------------------------------------
    pageprep:
    Cls: Paint (1, 1), c1
    x1 = 30: y1 = 5: x2 = 610: y2 = 345
    For q = 2 To 20 Step 4
        Line (x1 - q, y1 + q)-(x2 + q, y2 - q), c1, B
        Line (x1 - q + 1, y1 + q + 1)-(x2 + q + 1, y2 - q + 1), c2, B
    Next q
    z = Len(z$) + 2: x1 = 320 - z * 4: x2 = 320 + z * 4
    Line (x1, 9)-(x2, 22), c1, BF
    sprint z$, x1 + 8, t, white, -c2
    Return
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub Henonp (f) Static '                                               pretty pictures at top left, Henon plots

    If henoni = 0 Then '                                              one time initializations
        z = 20000
        Dim tb(z)
        henoni = 1
    End If

    s& = VarSeg(tb(0)) '                                              for BLOADING images
    o& = VarPtr(tb(0))
    Def Seg = s&

    If crash Then GoTo nosp '                                         gonna show something else
    wts = (wts + 1) Mod 3 '                                           what to show
    For pass = 1 To 2
        For i = 0 To 2
            If ((i = wts) Or (pass = 2)) And (Timer < rtl!(i)) Then
                Select Case i
                    Case Is = 0 '                                     radiation
                        BLoad f$(19), o& '                            rad.dat
                        Put (0, 0), tb(0), PSet
                        gotblank = 0
                    Case Is = 1 '                                     thermometer
                        GoSub loadblank
                        Line (20, 28)-(26, 56), 0, BF '               shadow
                        Line (20, 26)-(24, 56), 0, BF '               erase old
                        Line (20, 26)-(24, 56), red, B '              outline
                        Circle (23, 60), 5, 0 '                       bulb shadow
                        Circle (24, 60), 5, 0 '                       bulb shadow
                        Circle (22, 59), 5, red '                     bulb
                        Paint (22, 59), red, red '                    bulb fill
                        ty = 56 - rtlc(1) / 100 * 30 '                reading
                        Line (20, ty)-(24, 56), red, BF
                    Case Is = 2 '                                     lightning count
                        GoSub loadblank
                        uc = uc Xor 1
                        If uc Then tc = yellow Else tc = gold
                        PSet (17, 27) '                               draw lightning bolt
                        Line -(33, 27), tc
                        Line -(24, 43), tc
                        Line -(29, 43), tc
                        Line -(16, 63), tc
                        Line -(21, 47), tc
                        Line -(13, 47), tc
                        Line -(17, 27), tc
                        Paint (22, 47), tc, tc
                End Select
                z = rtlc(i) '                                         0rads 1temperature 2bolts
                lf = -1
                PrepAndShowLED CSng(z), 4, 10
                Exit Sub
            End If
        Next i
    Next pass

    nosp: '                                                           no special = Henon plots
    If f <> lf Then
        tf$ = f$(f)
        BLoad tf$, o&
        gotblank = 0
        lf = f
    End If
    hc = (hc + 1) Mod 13 '                                            h1-h5 contain 13 images each
    If crash Then hc = 0 '                                            h6.dat only has one page
    Put (0, 0), tb(hc * 1500), PSet '                                 includes
    PrepAndShowLED 0, 4, 0
    Exit Sub

    loadblank: '                                                      not really blank - has program name
    If gotblank = 0 Then '                                             and clock/McD/speed/count box
        BLoad f$(39), o& '                                            is lanblank.dat
        gotblank = 1
    End If
    Put (0, 0), tb(0), PSet
    Return
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub Hollywood
    For i = 1 To 9
        tx = x + i * 16
        ty = gety(tx) - 14
        PrintVGA Mid$("HOLLYWOOD", i, 1), tx - 4, ty, white, black
        Line (tx, ty + 9)-(tx, ty + 22), gray2
    Next i
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub IBM Static
    Dim a(1)
    x0 = x
    y0 = 304
    If bolthitf Then tc = white Else tc = gasoline '                  lightning bolt from deathstar
    Line (x0, y0)-(x0 + 50, y0 + 45), tc, BF '                        entire area
    Line (x0, y0)-(x0 + 50, y0 + 45), gray, B '                       outline

    Line (x0, y0 - 1)-(x0, y0 - 30), gray2 '                          light towers
    Line (x0 + 50, y0 - 1)-(x0 + 50, y0 - 30), gray2

    If bbit Then '                                                    global seconds toggle
        PSet (x0, y0 - 30), red '                                     lights on towers
        PSet (x0 + 50, y0 - 30), red
        ltoggle = ltoggle Xor 1
        If ltoggle Then
            PSet (x0, y0 - 31), red
            PSet (x0 + 50, y0 - 31), red
            Line (x0 - 2, y0 - 30)-Step(4, 0), red
            Line (x0 + 48, y0 - 30)-Step(4, 0), red
        End If
    End If

    If a(0) = 0 Then a(0) = 30: a(1) = 150 '                          initial marker positions
    If Rnd > pf! Then '                                               reel mark direction&speed
        tdir = Sgn(Rnd - pf!) * Int(Rnd * 4 + 2)
        If Rnd > .8 Then tdir = 0 '                                   sometimes not moving
    End If
    Line (x0 + 6, y0 + 15)-(x0 + 19, y0 + 21), black2 '               tape
    Line -(x0 + 33, y0 + 21), black2
    Line -(x0 + 44, y0 + 15), black2
    Line (x0 + 24, y0 + 19)-Step(3, 1), dred, BF '                    head
    For i = 0 To 1 '                                                  reels/rollers
        a(i) = (a(i) + t * tdir + tsix) Mod tsix '                    marker angle
        x = x0 + 13 + i * 24
        y = y0 + 11
        For d! = 5 To 9
            Circle (x, y), d!, white, , , .73 '                       reel
            Circle (x, y), d!, white, , , .68
            Circle (x, y), d!, white, , , .62
        Next d!
        x1 = x + 3 * s!(a(i)) * grav!
        y1 = y + 3 * c!(a(i))
        x2 = x + 6 * s!(a(i)) * grav!
        y2 = y + 6 * c!(a(i))
        Line (x1, y1)-(x2, y2), black2 '                              rotation marker
        For d = 0 To 4 '                                              hub
            Circle (x, y), d, dred, , , .73
            Circle (x, y), d, dred, , , .68
        Next d
    Next i

    If sia > 0 Then '                                                 shells in air = building gets MEAN title
        PrintLines "HAL", 0, 47, x0 + 1, y0 + 39, red, white, 1, 2
    Else
        PrintLines "IBM", 0, 47, x0, y0 + 39, blue, white, 1, 2
    End If

    '                                                                 binary clock
    z$ = Time$ '                                                      hh:mm:ss
    z$ = Left$(z$, 2) + Mid$(z$, 4, 2) + Right$(z$, 2) '              hhmmss
    For i = 1 To 6
        v = Val(Mid$(z$, i, 1)) '                                     value
        x = x0 + i * 5 + 2 - (i > 2) * 5 - (i > 4) * 5 '              column
        z = Val(Mid$("132323", i, 1)) '                               rows for this column
        For j = 0 To z
            If v And 1 Then c = red Else c = black2 '                 red = on
            v = v \ 2
            y = glmax - 2 - j * 2
            Line (x - 1, y)-(x + 1, y), c, B '                        show bit
        Next j
    Next i

    If ttf! < -2 Then fat! = Timer + 10
    ttf! = fat! - Timer '                                             time to fire
    If fat! > 86400 Then fat! = t: ttf! = 0

    If (ttf! > 0) And (ttf! < 1) Then '                               optional radar
        sky = (sky + 1) Mod tsix
        x1 = x0 + 25
        For sky2 = 0 To 180 Step 5
            zz = (sky + sky2) Mod 180
            x2 = x1 + q2 * c!(zz)
            y2 = (y0 - 1) - q2 * s!(zz) - 1
            Line (x1, y0 - 1)-(x2, y2), red, , &H1111
        Next sky2
    End If

    If pat1& = 0 Then pat1& = &H5555: pat2& = &HAAAA
    Swap pat1&, pat2& '                                               countdown to firing
    z! = ttf!: If z! < 0 Then z! = 0
    tx = x0 + z! / t * 48
    If tx > (x0 + 48) Then tx = xo + 48 '                             crude fix for a midnite crossing
    ty = y0 + 1
    Line (x0 + 1, ty)-(tx, ty), black2, , pat1&
    Line (x0 + 1, ty)-(tx, ty), red, , pat2&

    If (sia < 20) And (shoot Or (ttf! <= 0)) Then '                   initialize shell
        shoot = 0
        For s = 1 To 20
            If shx(s) = 0 Then
                sia = sia + 1 '                                       shells in air
                shx(s) = suri + x0 + 25
                shy(s) = 320
                shellv = (-32 + (Rnd - pf!) * t) * t '                velocity
                ta = 0
                If Rnd > .1 Then '                                    smart 10% (good aim)
                    If Rnd > pf! Then
                        ta = -Rnd * 25
                    Else
                        ta = Rnd * 50 '                               above or below
                    End If
                    ta = ta + (Rnd - pf!) * 4 '                       vary it a little
                End If
                dx = px! - shx(s) + suri
                dy = shy(s) - py!
                If dy = 0 Then dy = 1
                shella = _R2D(Atn(dx / dy)) + (90 - 5 * Sgn(dx) + ta)
                If py! > 280 Then
                    shella = 90 + (Rnd - pf!) * 40
                    shellv = shellv * .75
                End If
                shella = (shella + tsix) Mod tsix
                shvx(s) = (shellv / t) * c!(shella)
                shvy(s) = (shellv / t) * s!(shella)
                shd(s) = q1
                Exit For
            End If
        Next s
    End If
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub Info Static '                                                     show messages
    Dim lenmes(1)
    If Len(fb$) Then mes$(0) = UCase$(fb$): sm!(0) = mTIMER

    For i = 0 To 1
        If mes$(i) <> omes$(i) Then sm!(i) = 0
        lenmes(i) = Len(mes$(i))
        If lenmes(i) And (sm!(i) = 0) Then
            sm!(i) = Timer
            omes$(i) = mes$(i)
        End If
        el! = Timer - sm!(i)
        If el! > 5 Then mes$(i) = "": sm!(i) = 0
    Next i
    tcenter = (q3 + gs) \ 2 '                                         center of "space" area
    If lenmes(0) Then
        c1 = white2: c2 = gray
        z$ = LTrim$(mes$(0))
        l3$ = Left$(z$, 3)
        If l3$ = "CM:" Then c1 = red '                                rendesvous chatter
        If l3$ = "DAN" Then c1 = red '                                Danger, Will Robinson
        If c1 = red Then c2 = black2
        If (convo > 0) Or (InStr("EstWARRad", l3$) > 0) Then
            PrintVGA z$, tcenter - lenmes(0) * 4, 5, c1, -1
        Else
            If lenmes(0) > (34 - (gs = 0) * 5) Then
                tcol = (tcol + 4) Mod (lenmes(0) * t)
                z$ = Space$(4) + z$
                PrintLines z$, tcol, tcol + 40 * 16, gs, 20, c1, c2, 2, 2
            Else
                tx = tcenter - Len(z$) * 8
                'LINE (gs, 6)-(q3, 17), 0, BF
                PrintLines z$, 0, lenmes(0) * 16 - 1, tx, 20, c1, c2, 2, 2
            End If
        End If
    End If

    If lenmes(1) Then '                                               subordinate msg
        If lenmes(0) Then ty = 30 Else ty = 5
        PrintVGA mes$(1), tcenter - lenmes(1) * 4, ty, red, dred
    End If

    If (invincible = 0) And (rads >= h) And (Timer < rtl!(0)) Then
        z = rads \ h
        If z >= t Then radiationdeath = 1: z = t '                    >= ten
        If z <= t Then '                                              <= ten
            Restore radcomments
            For i = 1 To z
                Read z$
            Next i
            If Val(Left$(z$, 1)) Then '                               does it start with a #?
                z$ = "ensures your death within " + z$ '              yes, tack on phrase
            End If
            mes$(1) = "Radiation exposure " + z$ + "!"
        End If
    End If
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub LEDdisplay (t$) Static
    If LEDinit = 0 Then
        Dim segment(6, 3), number$(11)
        Restore leds
        For i = 0 To 6
            Read g$
            For j = 0 To 3
                Read segment(i, j)
            Next j
        Next i
        For i = 0 To 11
            Read g$, number$(i)
        Next i
        LEDinit = 1
    End If

    If (osc < 6) Or (osc = t) Then '                                  fuel,alt,h,v,thrust,angle
        tc = c: If LEDtri = 0 Then tc = LEDc
        If osc = t Then '                                             angle
            segx = 14: segy = 14 '                                    segment size
            tx = 92 - Len(t$) * segx * 2
            ty = 298
        Else
            tl = (Len(t$) - Sgn(InStr(t$, "."))) * 16
            tx = gs - tl
            ty = 296 - osc * 39
            segx = 8: segy = 8
        End If
    Else '                                                            6clock 7dtm 8speed 9rads
        If osc = 9 Then tc = red Else tc = orange
        If crash Then tc = white2
        tx = 50
        ty = 35 + (osc - 6) * 9
        If osc = 9 Then ty = 62
        segx = 4: segy = 3
    End If

    If crash And (osc <> 6) Then Exit Sub '                           allow clock

    dpp = 0 '                                                         decimal point
    For si = 1 To Len(t$)
        z$ = Mid$(t$, si, 1)
        If z$ = "." Then '                                            plot sub can't handle decimal
            tx1 = tx + (si - 1) * 16 - 5
            Line (tx1, ty - 1)-(tx1 + 1, ty), tc, BF
            dpp = 1
        Else
            z = Val(z$)
            If z$ = "-" Then z = t
            If z$ = "L" Then z = 11 '                                 "L" for lock fuel and level ground
            If z$ <> " " Then GoSub leddigit
        End If
    Next si

    If osc = 6 Then '                                                 colon for clock
        If crash Then bbit = 1
        PSet (tx + 14, ty - 4), tc * bbit
        PSet (tx + 14, ty - 2), tc * bbit
    End If
    Exit Sub

    leddigit:
    For i = 1 To Len(number$(z))
        seg$ = Mid$(number$(z), i, 1)
        If InStr("abcdefg", z$) Then seg$ = z$ '                      for wave effect
        segn = Asc(seg$) - 97
        x0 = tx + (si - 1 - dpp) * (segx * 2)
        x1 = x0 + segment(segn, 0) * segx
        y1 = ty + segment(segn, 1) * segy
        x2 = x0 + segment(segn, 2) * segx
        y2 = ty + segment(segn, 3) * segy
        If x1 < x2 Then
            Line (x1 + 1, y1)-(x2 - 1, y1), tc '                      horizontal
            If osc = t Then '                                         angle (very thick)
                Line (x1 + 2, y1 - 1)-(x2 - 2, y1 - 1), tc
                Line (x1 + 2, y1 + 1)-(x2 - 2, y1 + 1), tc
            End If
        Else
            Line (x1, y1 + 1)-(x1, y2 - 1), tc '                      vertical
            If osc = t Then '                                         angle (very thick)
                Line (x1 - 1, y1 + 2)-(x1 - 1, y2 - 2), tc
                Line (x1 + 1, y1 + 2)-(x1 + 1, y2 - 2), tc
            End If
        End If
    Next i
    Return
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub LGM (fc) Static '                                                 little green man

    x = x - 5
    If LGMc = gray Then '                                             LGM toasted - show pile of ashes
        y1 = gety(x + t) - 1
        For y = 0 To 5
            Line (x + y, y1 - y)-(x + 15 - y, y1 - y), gray
            p = Val(Mid$("162341", y + 1, 1))
            PSet (x + y + p, y1 - y), black2
            PSet (x + y + p + 3, y1 - y), black2
        Next y
        Exit Sub
    End If

    If sema$ = "" Then '                                              initialize
        Dim a(28, 1) '                                                angles
        Restore semadata
        For i = 1 To 28 '                                             read angles
            Read z$, a(i, 0), a(i, 1)
        Next i
        Do
            Read z$
            If z$ = "end" Then Exit Do
            sema$ = sema$ + " " + z$ + " "
        Loop
        lc$ = Chr$(255): i = 0 '                                      lc = last character, i = index
    End If

    If crash Then LGMc = dred '                                       white2 as many other colors g1
    If Timer < sema! Then sema! = Timer '                             midnite crossing fix
    If (Timer - sema!) > semat! Then '                                signal next letter
        sema! = Timer
        If fc = 0 Then '                                              flame count
            semat! = .3
            tsema$ = sema$
            If si > 0 Then i = si - 1: si = 0
        Else
            semat! = .2 '                                             0.2 seconds between letters
            If fc < 5 Then '                                          flame count
                If tsema$ <> "help  " Then tsema$ = "!"
                toast = 0
            Else
                tsema$ = "help  "
                toast = toast + 1
                If toast > 2 Then toast = 0: LGMc = LGMc + 1
            End If
        End If
        i = (i Mod Len(tsema$)) + 1
        p = InStr(tsema$, "time is")
        If p Then
            z$ = Mid$(Time$, 1, 2) + Mid$(Time$, 4, 2)
            Mid$(tsema$, p + 8, 4) = z$
        End If
        y1 = gety(x) - 14
        If demo Then y1 = 286
        c$ = Mid$(tsema$, i, 1)
        d = Asc(LCase$(c$)) - 96
        If d < 1 Then d = 27
        If c$ = "!" Then d = 28
        p = InStr("1234567890", c$): If p Then d = p - (c$ = "0")
        If oscar Then
            c1 = red
            c2 = gold
        Else
            c1 = blue
            c2 = white
        End If
        If (c$ <> " ") And (c$ = lc$) Then Swap c1, c2
        lc$ = c$
    End If

    c = Val(Mid$("021412040906110015", (LGMc - 1) * 2 + 1, 2))
    If bolthitf Then c = white
    If c = black2 Then co = gray2 Else co = black2
    Circle (x + t, y1 - 6), 4, c '                                    head
    Paint (x + t, y1 - 6), c, c '                                     fill in head
    PSet (x + 8, y1 - 7), co '                                        left eye
    PSet (x + 12, y1 - 7), co '                                       right eye
    Line (x + 9, y1 - 5)-(x + 11, y1 - 5), co '                       mouth
    Line (x + 5, y1)-(x + 15, y1 + 12), c, BF '                       body
    If c = black2 Then
        Circle (x + t, y1 - 6), 5, co '                               eye
        Line (x + 5, y1)-(x + 15, y1 + 12), co, B '                   body
    End If

    If (d = 27) And (c <> black2) And (fc = 0) Then '                 wiggle ears
        x2 = x + 5 - bbit
        x3 = x + 14 + bbit
        y2 = y1 - 8 + bbit
        Line (x2, y2)-(x2 + 1, y2 + 1), c, BF
        Line (x3, y2)-(x3 + 1, y2 + 1), c, BF
    End If

    If fc Then '                                                      optional flame effect
        If fc > t Then di = 4 Else di = t '                           flame count
        For tx = x + 5 To x + 15
            For ty = y1 - 9 To y1 + 12
                p = Point(tx, ty)
                z = (z + 1) Mod q1
                If p = c Then
                    tc = (ty + tx + z) Mod di
                    If tc = 0 Then PSet (tx, ty), gold
                    If tc = 1 Then PSet (tx, ty), black2
                End If
            Next ty
        Next tx
    End If

    If c = black2 Then c = gray2
    For j = 0 To 1 '                                                  arms & flags
        a1 = a(d, j) - 90
        x2 = x + j * 20
        x3 = x2 + 26 * Cos(_D2R(a1))
        y2 = y1 + 25 * Sin(_D2R(a1))
        Line (x2, y1)-(x3, y2), c '                                   arm
        If j = 0 Then s = 1: If InStr("wxz", c$) Then s = -s
        If j = 1 Then s = -1: If InStr("hio89", c$) Then s = -s
        For q = 0 To 3
            a1 = a1 - 90 * s
            x4 = x3 + t * Cos(_D2R(a1))
            y4 = y2 + t * Sin(_D2R(a1))
            Line -(x4, y4), gunmetal
            If q = 1 Then
                sx = x4: sy = y4
                r! = _D2R(a1 - 45 * s)
                rx = x3 + 5 * Cos(r!)
                ry = y2 + 5 * Sin(r!)
            End If
            If q = 3 Then
                r! = _D2R(a1 - 45 * s)
                yx = x3 + 5 * Cos(r!)
                yy = y2 + 5 * Sin(r!)
            End If
            x3 = x4: y2 = y4
        Next q
        Line -(sx, sy), gunmetal
        Paint (rx, ry), c1, gunmetal
        Paint (yx, yy), c2, gunmetal
    Next j

    If c$ = UCase$(c$) Then
        x2 = x + 5 + Sgn(InStr("ACDHJMNOPSUV0123456789", c$)) '       letter centering
        y2 = y1 + 2
    Else
        x2 = x + 6 - Sgn(InStr("ijlnv", c$)) '                        as above
        y2 = y1 - Sgn(InStr("gjpqy", c$)) + 2
    End If

    If LGMc = 4 Then tc = gold Else tc = red
    Call PrintVGA(c$, x2, y2, tc, black2)
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub LMbloads
    p = ASO * 3 + 4

    s& = VarSeg(LMx(0))
    o& = VarPtr(LMx(0))
    Def Seg = s&
    BLoad f$(p), o&

    s& = VarSeg(LMy(0))
    o& = VarPtr(LMy(0))
    Def Seg = s&
    BLoad f$(p + 1), o&

    s& = VarSeg(LMc(0))
    o& = VarPtr(LMc(0))
    Def Seg = s&
    BLoad f$(p + 2), o&
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub LMdistort
    For i = 1 To rp
        If (LMc(i) = craft) And (Rnd > .6) Then
            LMx(i) = LMx(i) + Rnd * 3 - 1
            LMy(i) = LMy(i) + Rnd * 3 - 1
        End If
    Next i
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub LoadPanel Static
    If pload = 0 Then
        z = 12500
        ReDim pb(z)
        tf$ = mpath$ + "PANEL" + Chr$(48 + background) + ".DAT"
        s& = VarSeg(pb(0))
        o& = VarPtr(pb(0))
        Def Seg = s&
        BLoad tf$, o&
        pload = 1
    End If
    Put (0, 67), pb(), PSet
End Sub
' -------------------------------------------------------------------------------------------------------x
Function localize (tx, p, m)
    z0 = 9999 '                                                       assume out of range
    z1 = suri - m '                                                   surface index - minus
    z2 = suri + p + q3 '                                              surface index + plus
    For z = -1 To 1 '                                                 page before, current, next
        zx = tx + z * q1
        If (zx <= z2) And (zx >= z1) Then z0 = tx - suri + q1 * z
    Next z
    localize = z0 '                                                   return 9999 or calculated
End Function
' -------------------------------------------------------------------------------------------------------x
Sub MakeStarFiles '                                                   takes a LONG time
    If iscd Then Exit Sub
    savestarfiles = starfiles
    ts$ = Time$
    mstar = 0
    For starfiles = 0 To 2
        For rmin = 0 To 23
            For dmin = -90 To 90 Step 10
                mstar = mstar + 1 '                                   for progress bar
                starinit = 0
                regen = 1
                Stars
                If InKey$ = Chr$(27) Then System '                    Esc aborts
            Next dmin
        Next rmin
    Next starfiles
    mstar = 0
    sprint ts$, 200, 100, red, black
    sprint Time$, 200, 120, red, black
    timemachine
    Sleep '                                                           lets user see how LONG it took
    starfiles = savestarfiles: starinit = 0: rmin = 0: dmin = 0
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub MakeSur
    If iscd Then Exit Sub
    Dim z!(t), a1(t), v1(t), lz(t)
    msflag = 1
    View
    Cls
    For gh = -2 To 9 '                                                -2 demo, -1 flat, 0-9 rocks
        z$ = "Creating surfaces" + Str$(gh + 3) + " of 12"
        Line (s, 0)-(q3, 20), 0, BF
        PrintVGA z$, 320 - Len(z$) * 4, 2, white, black
        timemachine

        If InKey$ = Chr$(27) Then Quit
        f$ = "s" + LTrim$(Str$(gh))
        If gh = -2 Then f$ = "sd"
        If gh = -1 Then f$ = "sl"
        f$ = mpath$ + f$ + ".dat"
        Close #6
        Open f$ For Random As #6 Len = 2
        For i = 1 To q1 '                                             6400, 10 pages
            Put #6, i, glmax
        Next i
        If gh < 0 Then GoTo keepflat
        For i = 1 To 4 '                                              make sine waves
            z!(i) = Rnd * 36 / 550
            a1(i) = Rnd * tsix
            v1(i) = Rnd * gh * 2
        Next i
        For i = 0 To q1
            z! = 0
            For j = 1 To 4
                y! = v1(j) * Sin((i - a1(j)) * z!(j))
                z! = z! + y! * 4
            Next j
            If (i > 5320) And (i < 5560) Then z! = z! / 4 - 40 '      make Hollywood higher
            z = glmax - Abs(z!)
            If z < glmin Then z = glmin
            Put #6, i + 1, z
        Next i
        Smooth 5319
        Smooth 5559
        keepflat:
        If gh = -2 Then tz = 3130 Else tz = 2240
        For i = -51 To 51 '                                           volcano
            z = glmax - (51 - Abs(i))
            Put #6, tz + i, z
        Next i
        Smooth 2240 - 50
        Smooth 2240 + 50
        z = 302
        For i = -5 To 5 '                                             volcano top
            Put #6, tz + i, z
        Next i
        If gh > -1 Then '                                             ground height not flat, add rocks/small craters
            For i = -1 To 1 Step 2 '                                  up or down
                rocks = Rnd * h + h '                                 rocks & indentations
                For j = 1 To rocks
                    rx = Rnd * 6380 + t
                    zz = Rnd * 4 + 1
                    For k = -zz To zz
                        Get #6, rx + k, z
                        z = z - zz * i + Abs(k) * i
                        If z < glmin Then z = glmin
                        If z > glmax Then z = glmax
                        Put #6, rx + k, z
                    Next k
                Next j
            Next i
        End If
        Smooth q1 - 1 '                                               6399 - 0 transition

        For i = 1 To t '                                              create landing zones
            If gh = -2 Then '                                         compress onto 1 page
                lz(i) = 3050 + (i - 1) * 80
            Else
                lz(i) = 320 + (i - 1) * (q3 + 1) '                    1 per page
            End If
        Next i
        If gh = -2 Then '                                             demo terrain
            Swap lz(9), lz(t) '                                       move grave 1 page left
            Swap lz(2), lz(4) '                                       move car wash 2 pages right
        End If

        hs = 0
        Restore features
        For i = 1 To t '                                              10 features, create landing zones beside each
            Read z$, x, y, lz
            sf(i, 0) = lz(i) - x \ 2 '                                start
            sf(i, 1) = sf(i, 0) + x '                                 end
            sf(i, 2) = (sf(i, 0) + sf(i, 1)) \ 2 '                    middle
            If i = 4 Then GoTo isvolcano
            For x2 = -lz To lz
                z = hs * (y = 0) * (i <> 5)
                If i = 3 Then z = 40 '                                LGM
                If i = 4 Then z = 50 - Abs(x2) / 2
                If gh <> -2 Then
                    z = glmax - z
                    Put #6, sf(i, 2) + x2, z
                End If
            Next x2
            For x2 = sf(i, 0) To sf(i, 1) '                           target
                Get #6, x2 + 1, z
                z = z + y * (y <> 0)
                Put #6, x2 + 1, z
            Next x2
            If gh <> -2 Then
                Smooth sf(i, 2) - lz
                Smooth sf(i, 2) + lz
            End If
            isvolcano:
        Next i

        Smooth sf(1, 0) '                                             Area 51
        Smooth sf(1, 1)

        Restore BigM '                                                McDonalds
        y = 0
        Do
            Read z$
            If z$ = "x" Then Exit Do
            y = y + 1
            For x = 1 To Len(z$)
                If Mid$(z$, x, 1) = "X" Then
                    z = glmax + y - 38
                    Put #6, sf(5, 0) + x + 1, z
                End If
            Next x
        Loop

        suri = 0
        For i = 1 To q1 '                                             optional, show progress
            Get #6, i + 1, y
            y = gh * 25 + y / 6 + 20
            PSet (i \ t, y), 1
        Next i
    Next gh
    msflag = 0
    'timemachine
    'SLEEP
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub Mandel '                                                          appears in TMA-1 when landed on
    xd! = .044
    yd! = .036
    zz! = Timer * 4
    Line (x, glmax - 1)-(x + 45, glmax - 71), black2, BF
    For xx = 0 To 23
        For yy = 0 To 70
            MandelX! = -2 + yy * yd!
            MandelY! = -1 + xx * xd!
            Real# = 0
            Imag# = 0
            Itera = 20
            Do
                Itera = Itera - 1
                hold# = Imag#
                Imag# = (Real# * Imag#) * 2 + MandelY!
                Real# = Real# * Real# - hold# * hold# + MandelX!
                Size# = (Real# * Real# + Imag# * Imag#) - 4
            Loop Until (Itera = 0) Or (Size# > 0)
            If Size# > 0 Then
                tc = (Itera + zz!) Mod 15 + 1
                ty = glmax - 71 + yy
                PSet (x + xx, ty), tc '                               left half
                PSet (x + 45 - xx, ty), tc '                          right half
            End If
        Next yy
    Next xx
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub Map '                                                             location of features at top
    Line (0, 0)-(gs - 1, 1), blue2, BF
    For i = 1 To 17 + ufof
        If i <= t Then '                                              surface features
            tx = sf(i, 2)
            If tx = -1 Then GoTo skipf '                              destroyed
            tc = blue
            z$ = sf$(i) '                                             surface feature name
            If i = 3 Then z$ = "LGM" '                                shorten some names
            If i = 5 Then z$ = "McD"
            If i = 7 Then z$ = "SSC"
            GoTo wubba
        End If
        If i = (17 + ufof) Then
            tc = white
            tx = (suri + px!) Mod (q1 + 1)
            z$ = "LM"
        Else '                                                        sky feature
            If skyoff Then GoTo skipf
            j = i - 11
            If (ek(j) = -1) Or eou Then GoTo skipf '                  destroyed or not present
            If j Then tc = red Else tc = green '                      CM green, rest red
            tx = ex(j)
            '                     1    2    3    4    5    6
            '                 12345123451234512345123451234512345
            z$ = RTrim$(Mid$("CM   DS   Borg BH   Worm CometAlien", j * 5 + 1, 5))
            If j = 0 Then z$ = z$ + Str$(exv(0)) '                    CM + velocity
        End If

        wubba:
        tx = tx \ t
        Line (tx, 0)-(tx + 1, 1), tc, BF
        zz = Len(mes$(0)) + Len(mes$(1)) - (liftoff = 1) '            quash names when messages active and during liftoff
        If (zz = 0) And (tx > (gs + 6)) Then PrintLines z$, 0, Len(z$) * 8, tx - 6, 16, tc, -99, 0, 1
        skipf:
    Next i
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub McD Static '                                                      37 * 16
    If McDi = 0 Then '                                                initialize
        z$ = "    Burger, fries & Coke only $1.99!"
        For i = 1 To Len(z$) '                                        Morse code
            c$ = Mid$(z$, i, 1)
            Restore MorseData
            For j = 1 To 39
                Read d$, x$
                If d$ = LCase$(c$) Then m$ = m$ + x$ + " "
            Next j
        Next i
        McDi = 1
    End If

    mp = (mp + 4) Mod 320 '                                           show ad in text
    x2 = x + 38
    If bolthitf Then tc = white Else tc = gold
    Line (x, glmax)-(x2, glmax - 19), tc, BF '                        clear sign area
    PrintLines z$, mp, mp + 37, x, glmax - 1, red, black2, 1, 1

    For mx = x To x2 - 1 '                                            arch & red neon
        my = gety(mx)
        arch = (arch + 1) Mod t
        If arch < 2 Then tc = red Else tc = gold
        If bolthitf Then tc = white
        If mx > x Then Line (mx, my)-(mx, my + 2), tc
        tmx = x + x2 - mx - 2
        If tmx > x Then Line (tmx, glmax - 19)-(tmx + 2, glmax - 18), tc, BF
    Next mx

    y = glmax - 1 '                                                   show ad in Morse
    i = 0
    z = (z Mod Len(m$)) + 1
    Do
        j = ((z + i) Mod Len(m$)) + 1
        i = i + 1
        p = InStr(".- ", Mid$(m$, j, 1)) - 1
        If p < 2 Then Line (x, y)-(x + p * 2, y), black2
        x = x + (p + 1) * 2
    Loop Until (x + 2) > x2
End Sub
' -------------------------------------------------------------------------------------------------------x
Function OnOff$ (v)
    OnOff$ = Mid$("OFFON ", v * 3 + 1, 3)
End Function
' -------------------------------------------------------------------------------------------------------x
Sub Parachute Static '                                                because it's funny
    If contact Then
        cy! = cy! + 5
        If cy! > 500 Then cy! = 500: chs = 1: paraf = 0
        chs = chs - 1
    Else
        cy! = py! - h
        If (py! > 120) And (chs < 40) Then chs = chs + 2
    End If
    For ta = 0 To tsix
        r! = _D2R(ta) / 2
        tx = px! + chs * Cos(r!) * 2
        ty = cy! - chs * Sin(r!)
        PSet (tx, ty), gray2
        If (ta / 20) Mod 2 Then tc = red Else tc = white2
        Line -(tx, cy!), tc
        If (ta Mod 40) = 0 Then Line -(px! - ASO, cy! + 82 + ASO * t), gray2
    Next ta
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub PrepAndShowLED (t!, nd, dp) Static
    osc = osc + 1
    If dp = t Then dp = 0: osc = 9

    ti = Fix(t!)
    z! = Abs(t! - ti)
    s$ = Space$(6)
    If (t! < 0) And (ti = 0) Then
        t1$ = Right$(s$ + "-" + LTrim$(Str$(ti)), nd)
    Else
        t1$ = Right$(s$ + LTrim$(Str$(ti)), nd)
    End If

    t2a$ = LTrim$(Str$(Int(z! * (t ^ dp))))
    If Len(t2a$) < dp Then t2a$ = Right$("000" + t2a$, dp)
    t2$ = Left$(LTrim$(t2a$) + "0000", dp)
    If dp = 0 Then z$ = t1$ Else z$ = t1$ + "." + t2$

    If z$ = " -0.00" Then z$ = "  0.00"

    If (osc = 9) And (t! = 0) Then '                                  usually count for rads, lightning
        cylon = (cylon + 1) Mod 6 '                                   when blank, cycle a "-"
        zz = Val(Mid$("123432", cylon + 1, 1))
        z$ = "    "
        Mid$(z$, zz, 1) = "-"
    End If

    If osc = 4 Then
        If (liftoff = 0) And level Then Mid$(z$, 1, 1) = "L" '        altitude
        If radarf = 0 Then z$ = " ----"
    End If

    If (osc = 5) And lockfuel Then Mid$(z$, 1, 1) = "L" '             fuel

    If warp! > 0 Then
        If osc = 4 Then z$ = " ----" '                                suppress altitude
        If osc = 7 Then z$ = "----" '                                 distance to McDonalds
    End If

    LEDdisplay z$
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub PrintCGA (c$, x, y, tc1, tc2, compress) Static '                  CGA font, 8 * 8
    c1 = tc1
    c2 = tc2
    If y = -1 Then '                                                  single char panel stuff - F for Fuel, etc.
        c2 = -1
        y = 263 - osc * 39
        tx1 = x - 3
        tx2 = x + 11
        ty1 = y
        ty2 = y + t
        If bbit And (LEDc = green) And (radarf > 0) And (contact = 0) And ((c1 = red) Or (c1 = yellow)) Then
            Line (tx1 + 1, ty1 + 1)-(tx2 - 1, ty2 - 1), c1, BF
            c1 = black2
        Else
            If (osc = 4) And (radarf = 0) Then c1 = gray Else c1 = white
        End If
    End If

    If y + 9 > glmax Then Exit Sub
    tx = x + 1

    For i = 1 To Len(c$)
        d = Asc(Mid$(c$, i, 1))
        For k = 0 To 7
            If p2(d, k) Or (compress = 0) Then
                If c2 >= 0 Then
                    Line (tx + 1, y + 2)-(tx + 1, y + t), c2, , p2(d, k)
                End If
                Line (tx, y + 1)-(tx, y + 9), c1, , p2(d, k)
                tx = tx + 1
            End If
        Next k
    Next i
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub PrintLines (d$, i1, i2, x1, y1, c1, c2, sd, s) Static
    ' chars, index1, index2, x,y, color 1, color 2, shadow distance,size
    slant = -(c2 < -20)
    For i = i1 To i2 - 1
        z = i \ (8 * s) + 1
        If z > Len(d$) Then d = 32 Else d = Asc(Mid$(d$, z, 1))
        If d = 248 Then d = 0 '                                       degree symbol
        m& = _SHL(1, (7 - (i \ s) Mod 8))
        p& = 0
        For j = 0 To 13
            p& = p& * 2 + Sgn((p(d, 13 - j) And m&))
        Next j
        If c2 = -99 Then '                                            vertical
            ty1 = y1 + (i - i1)
            ty2 = ty1 - slant * 13
            Line (x1, ty1)-(x1 + 13, ty2), c1, , p& * 2
        Else '                                                        horizontal
            tx1 = x1 + i - i1 + 1
            tx2 = tx1 + slant * 15
            ty2 = y1 - 15
            Line (tx1, y1)-(tx2, ty2), c1, , p&
            If c2 >= 0 Then Line (tx1 + sd, y1)-(tx2 + sd, ty2), c2, , p&
        End If
    Next i
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub PrintVGA (z$, tx, ty, c1, c2) '                                   VGA font, 8 * 14
    PrintLines z$, 0, Len(z$) * 8 - 1, tx, ty + 13, c1, c2, 1, 1
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub Quit '                                                            save current configuration then exit to system
    Screen 0, 0, 0, 0
    Cls
    Close
    If iscd Then System '                                             can't save config to a CD

    Open settings$ For Output As #1
    z = auto: d$ = "auto": GoSub pconfig '                            1 full autopilot
    z = background: d$ = "panel": GoSub pconfig '                     2 instrument panel
    z = cbh: d$ = "cbh": GoSub pconfig '                              3 constant black holes
    z = demo: d$ = "skyf": GoSub pconfig '                            4 0 off 1 all features
    z = doclock: d$ = "clock": GoSub pconfig '                        5 clock display on DS
    z = invincible: d$ = "invincible": GoSub pconfig '                6 invincible
    z = jitter: d$ = "thrust": GoSub pconfig '                        7 thrust calculation
    z = LEDc: d$ = "ledc": GoSub pconfig '                            8 LED color
    z = LEDtri: d$ = "ledtri": GoSub pconfig '                        9 LED tri-color
    z = radarf: d$ = "radar": GoSub pconfig '                         10 radar visible
    z = shield: d$ = "shield": GoSub pconfig '                        11 Star Trek!
    z = showmap: d$ = "map": GoSub pconfig '                          12 feature locations at screen top
    z = starstatus: d$ = "stari": GoSub pconfig '                     13 0off 1names 2info 3info 4grid
    z = zoom: d$ = "starz": GoSub pconfig '                           14 starfield
    z = skyoff: d$ = "skys": GoSub pconfig '                          15 sky objects
    z = gstyle: d$ = "gstyle": GoSub pconfig '                        16 ground type
    z = mouseswap: d$ = "mouse": GoSub pconfig '                      17 mouse buttons
    z = porb: d$ = "porb": GoSub pconfig '                            18 pointers or bars for instruments
    z = starfiles: d$ = "stars": GoSub pconfig '                      19 star quantity
    z = mdelay: d$ = "speed": GoSub pconfig '                         20 system speed
    z = Sgn(_FullScreen): d$ = "fullscreen": GoSub pconfig '          21 fullscreen

    Close
    System

    pconfig: '                                                        prints to the config file
    Print #1, d$; ","; z
    Return
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub SaveImage (f$) '                                                  this sub from qb64.org website (modified)
    If iscd Then Exit Sub
    View Screen(0, 0)-(q3, q4)
    bpp& = 8
    tx& = 640
    ty& = 350
    '       XXXX   1XXXX
    '     12345678901234
    b$ = "BM????_RGF????" + MKL$(40) + MKL$(tx&) + MKL$(ty&) + MKI$(1) + MKI$(bpp&) + MKL$(0) + "????" + String$(16, 0) 'partial BMP header info(???? to be filled later)
    For c& = 0 To 255 '                                               read BGR color settings from JPG image + 1 byte spacer(CHR$(0))
        cv& = _PaletteColor(c&, 0) '                                  color attribute to read
        b$ = b$ + Chr$(_Blue32(cv&)) + Chr$(_Green32(cv&)) + Chr$(_Red32(cv&)) + Chr$(0) 'spacer byte
    Next
    Mid$(b$, 11, 4) = MKL$(Len(b$)) '                                 image pixel data offset (BMP header)
    If ((x& * 3) Mod 4) Then padder$ = String$(4 - ((x& * 3) Mod 4), 0)
    For py& = ty& - 1 To 0 Step -1
        z$ = ""
        For px& = 0 To tx& - 1
            c& = Point(px&, py&) '                                    2 bit values are large LONG values
            z$ = z$ + Chr$(Abs(c&) Mod 256)
        Next px&
        d$ = d$ + z$ + padder$
    Next py&
    Mid$(b$, 35, 4) = MKL$(Len(d$)) '                                 image size (BMP header)
    b$ = b$ + d$ '                                                    total file data bytes to create file
    Mid$(b$, 3, 4) = MKL$(Len(b$)) '                                  size of data file (BMP header)
    f& = FreeFile
    Open f$ For Output As #f&: Close #f& '                            erases an existing file
    Open f$ For Binary As #f&
    Put #f&, , b$
    Close #f&
    View Screen(gs, 0)-(q3, q4)
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub Setcolor
    '          b g g r g g w g d g b o b y w
    '          l r u e a y h y r o k r 2 e h
    '          1 2 3 4 5 6 7 8 9 0 1 2 3 4 5
    If bw Then '
        z$ = "070707075607070756070007565656" '                       black and white (because I can!)
    Else
        z$ = "010249042456075632380052085407" '                       color
        'z$ = "010249322456075632380052085407" '                       color
    End If
    For i = 0 To 14
        Palette i + 1, Val(Mid$(z$, i * 2 + 1, 2))
    Next i
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub Shells Static
    For s = 0 To 20 '                                                 0 element is bomb, others from IBM
        If shx(s) = 0 Then GoTo nextshell '                           never active or already exploded
        shvy(s) = shvy(s) + grav! '                                   gravity
        shx(s) = shx(s) + shvx(s)
        shy(s) = shy(s) + shvy(s)
        tsx = shx(s) - suri
        tsy = shy(s)

        If (s > 0) And (crash = 0) Then
            dx! = tsx - px!
            dy! = (tsy - py!) * aspect!
            shd(s) = Sqr(dx! * dx! + dy! * dy!)
            If (invincible = 0) And (shd(s) < 20) Then
                dead$ = "HAL KILLED YOU"
                Exit Sub
            End If
        End If

        If (tsy > 0) And (shvy(s) > 0) And ((tsy + shvy(s)) > gety(tsx)) Then
            tsy = gety(tsx)
            For a2 = 0 To tsix Step 30 '                               explode, make star
                bit = bit Xor 1 '                                     toggle
                d2 = bit * t + t / 2
                x2 = tsx + d2 * c!(a2) * aspect!
                y2 = tsy + d2 * s!(a2)
                If a2 Then Line -(x2, y2), gold Else PSet (x2, y2), gold
            Next a2
            Paint (tsx, tsy), gold, gold
            shx(s) = 0
            sia = sia - 1
            If s = 0 Then GoSub makecrater
        Else '                                                        show shell
            If shvx(s) < 0 Then ai = -30 Else ai = 30 '               spin
            sha(s) = (sha(s) + ai + tsix) Mod tsix
            ss = 3 + (s = 0) * 2
            For i = 0 To 1
                If i Then cc = red Else cc = gold
                a1 = (sha(s) + i * 180) Mod tsix '                     angle 1
                a2 = a1 + 150 '                                       angle 2
                ex = tsx + ss * c!(a1) * aspect! '                    1 of the endpoints
                ey = tsy + ss * s!(a1) '                              a line from an endpoint to
                For j = a1 To a2 Step t '                             each point on the half circle
                    zk = j Mod tsix '                                  seemed easier than a paint
                    zx = tsx + ss * c!(zk) * aspect!
                    zy = tsy + ss * s!(zk)
                    Line (zx, zy)-(ex, ey), cc
                Next j
            Next i
        End If
        nextshell:
    Next s
    Exit Sub

    makecrater:
    dd = Abs(sf(sf, 2) - suri - tsx) '                                distance to current surface feature
    If dd < t Then sf(sf, 2) = -1 '                                   under ten from a surface feature, kill feature

    zz = 40 '                                                         distance +- impact
    r1 = Rnd * 40
    r2 = Rnd * 40 + 40
    For crx = -zz To zz
        ta = (crx * 2 + 270) Mod tsix '                                angle
        tx = tsx + crx
        ty = gety(tc) - r1 - r2 * s!(ta)
        If ty > glmax Then ty = glmax
        ti = ((suri + tx + q1) Mod q1)
        gh(ti) = ty
        If iscd = 0 Then Put #6, ti + 1, ty
    Next crx

    ti = (suri + tsx - zz - 1 + q1) Mod q1
    Smooth ti
    ti = (suri + tsx + zz) Mod q1
    Smooth ti
    Return
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub ShowAngle (a)
    zc = dcolor(CSng(a), 0, 4, 1)
    c = zc
    If (bbit = 0) And (contact = 0) Then c = black '                  blink
    If a = 0 Then z$ = "  "
    If a > 0 Then z$ = Chr$(17) + " " '                               point left
    If a < 0 Then z$ = " " + Chr$(16) '                               point right
    PrintVGA z$, 7, 270, c, black2
    If LEDtri Then c = zc Else c = LEDc
    osc = t
    a$ = LTrim$(Str$(-a))
    LEDdisplay a$
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub Smooth (p1) '                                                     ground transistions
    p2 = p1 + 1
    zz = t
    i1 = (p1 - zz + q1) Mod q1
    i2 = (p2 + zz + q1) Mod q1
    If msflag Then '                                                  making surfaces, array not valid
        Get #6, i1 + 1, y1
        Get #6, i2 + 1, y2
    Else
        y1 = gh(i1)
        y2 = gh(i2)
    End If
    m! = (y1 + y2) / 2
    d! = (y1 - y2) / zz / 2
    For x = 1 To zz
        s! = d! * (zz - x)
        i1 = (p2 + zz - x + q1) Mod q1
        i2 = (p1 - zz + x + q1) Mod q1
        gh(i1) = m! - s!
        gh(i2) = m! + s!
        If iscd = 0 Then
            Put #6, i1 + 1, gh(i1)
            Put #6, i2 + 1, gh(i2)
        End If
    Next x
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub sprint (z$, tx, ty, c1, c2) '                                     VGA font
    For i = 1 To Len(z$)
        d = Asc(Mid$(z$, i, 1))
        If d = 248 Then d = 0 '                                       degree symbol
        x = tx + (i - 1) * 8
        For byte = 0 To 13
            y = ty + byte
            p& = (p(d, byte) And 255) * 128
            If c2 >= 0 Then Line (x + 1, y)-(x + 8, y), c2, , p&
            Line (x, y)-(x + 7, y), c1, , p&
        Next byte
    Next i
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub sprint2 (c$, tx, ty, c1, c2) '                                    CGA font
    For i = 1 To Len(c$)
        d = Asc(Mid$(c$, i, 1))
        If d = 248 Then d = 0 '                                       degree symbol
        For k = 0 To 7
            tx2 = tx + (i - 1) * 8 + k
            ty2 = ty + 2
            p& = p2(d, k)
            If c2 >= 0 Then
                Line (tx2 + 1, ty2 + 1)-(tx2 + 1, ty2 + 9), c2, , p&
            End If
            Line (tx2, ty2)-(tx2, ty2 + 8), c1, , p&
        Next k
    Next i
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub Stars Static

    ' - starstatus  0 off, 1 on, 2+names, 3+RA & Dec & grid, 4+Mag
    ' - encodes magnitude into xy array by making negative
    ' - stars1 1797, stars2 16571, stars3 87470

    If sinit = 0 Then
        sinit = 1
        qq = 18000
        Dim starx(qq), stary(qq), starn(30), star$(2, 50)
        starmax = qq: namemax = 100
        gc = blue '                                                   grid color
        sc = gray2 '                                                  star info color
    End If

    nh = 12 / (zoom + 1) '                                            hours (RA)
    nd = 90 / (zoom + 1) '                                            degrees (Dec)

    If eou <> 0 Then '                                                End of Universe
        alldown = 1
        For star = 1 To nstars
            sy = stary(star)
            ay = Abs(sy)
            If ay < q4 Then '                                         less than screen bottom
                stary(star) = stary(star) + Sgn(stary(star))
                alldown = 0 '                                         not done
            End If
        Next star
        If alldown Then Cls: Exit Sub
    End If

    If regen = 0 Then Cls
    tss = starstatus
    If starinit = 0 Then
        starinit = 1
        eou = 0 '                                                     End of Universe
        alldown = 0
        nstars = 0
        named = 0
        rmax! = rmin + nh '                                           hours
        dmax! = dmin + nd '                                           degrees
        n1& = 0
        isred1 = 0: isred2 = 0
        rmin$ = Right$("00" + LTrim$(Str$(rmin)), 2) '                0 - 24
        dmin$ = Right$("000" + LTrim$(Str$(dmin)), 3) '               -90 to 90
        zz$ = LTrim$(Str$(starfiles)) + rmin$ + dmin$ + ".DAT"
        If (warp! >= 1) And (starfiles = 2) Then tfs = 1 Else tfs = starfiles
        Select Case tfs
            Case Is = 0
                th! = 5.07: tf$ = mpath$ + "STARS1.DAT": d$ = mpath$ + "STARS1" + slash$: nl& = 1797
            Case Is = 1
                th! = 7.07: tf$ = mpath$ + "STARS2.DAT": d$ = mpath$ + "STARS2" + slash$: nl& = 16571
            Case Is = 2
                th! = 8.07: tf$ = mpath$ + "STARS3.DAT": d$ = mpath$ + "STARS3" + slash$: nl& = 87470
        End Select

        tf1$ = d$ + "SI" + zz$
        tf2$ = d$ + "SX" + zz$
        tf3$ = d$ + "SY" + zz$
        isstari = _FileExists(tf1$) + _FileExists(tf2$) + _FileExists(tf3$)
        If regen Then isstari = 0
        If isstari = -3 Then
            GoSub readstar
            GoTo plot
        End If
        regen = 0
        For i = 0 To qq
            starx(i) = 0
            stary(i) = 0
        Next i
        tf = FreeFile
        Open tf$ For Input As #tf
        Do
            Input #tf, r!, d!, m!, dis$, n$
            n1& = n1& + 1
            If (starfiles > -1) And ((n1& Mod h) = 1) Then
                zz1 = h + t '                                         hundred + 10 = 110
                zz2 = zz1 + n1& / nl& * 500
                Line (gs, 0)-(639, 40), black, BF
                Line (zz1, t)-(zz1 + 500, 13), red, B
                Line (zz1, t)-(zz2, 13), red, BF
                PrintCGA "Loading stars...", 300, 14, red, black, 0
                PrintCGA tf1$, 110, 14, red, black, 0
                If mstar > 0 Then '                                   regenerating all starfiles, show progress
                    zz2 = zz1 + mstar / 1368 * 500
                    Line (zz1, 27)-(zz1 + 500, 30), red, B
                    Line (zz1, 27)-(zz2, 30), red, BF
                End If
                timemachine
            End If

            sa = (Left$(n$, 1) = "*") '                               show always (low mag)
            tt! = th! '                                               temp threshold
            If Abs(d!) > 70 Then tt! = tt! + 2
            If Abs(d!) > 80 Then tt! = tt! + 2
            abd = Abs(d!): tt! = tt! - (abd > 70) - (abd > 80)
            If sa Or (m! <= tt!) Then '                               show always or bright
                For z1 = 0 To 1 '                                     why why why?
                    For z2 = 0 To 1
                        tr! = r! + z1 * 24
                        td! = d! + z2 * 180
                        If (tr! > rmin) And (tr! < rmax!) And (td! > dmin) And (td! < dmax!) Then sr = z1: sd = z2
                    Next z2
                Next z1
                tx = q3 - (r! - rmin + sr * 24) / nh * q3
                ty = q4 - (d! - dmin + sd * 180) / nd * q4
                If (tx > 0) And (tx < q3) And (ty > 0) And (ty < q4) Then
                    If m! <= 3 Then tx = -tx
                    If m! <= 2 Then ty = -ty
                    nstars = nstars + 1
                    starx(nstars) = tx
                    stary(nstars) = ty
                    If sa Then n$ = Right$(n$, Len(n$) - 1) '         show always, remove asterisk
                    If Len(n$) And (sa Or (m! < 2)) And (named < namemax) Then
                        named = named + 1
                        starn(named) = nstars
                        star$(0, named) = n$
                        If n$ = "Antares" Then isred1 = nstars
                        If n$ = "Mira" Then isred2 = nstars
                        star$(1, named) = LTrim$(Str$(m!)) + " " + dis$ ' + "P " + y$ + "L"
                        star$(2, named) = LTrim$(Str$(r!)) + " " + LTrim$(Str$(d!))
                    End If
                End If
            End If
        Loop Until EOF(tf) Or (nstars = starmax)
        Close #tf
    End If

    If isstari = 0 Then GoSub writestar

    plot:
    Cls
    'IF okrick THEN
    '    _PRINTSTRING (90, 30), tf1$ + STR$(zoom) + STR$(nh) + STR$(nd)
    '    _PRINTSTRING (90, 50), STR$(rmax!) + STR$(dmax!)
    'END IF
    tss = starstatus
    If auto And (gstyle = 0) Then tss = 4

    If tss > 2 Then '                                                 optional grids
        For i = 0 To nh '                                             vertical lines
            tx = (i / nh * q3) Mod (q3 + 1)
            Line (tx, 0)-(tx, q4), gc, , &H1111
            z = rmax! - i: z = z + (z > 23) * 24 '                    optional labeling
            TinyFont Str$(z), tx - 2, 0, -gc
        Next i
        z! = nd / t
        For de! = 0 To z! '                                           horizontal lines
            ty = q4 - ((de! / z! * q4) Mod (q4 + 1))
            Line (gs, ty)-(q3, ty), gc, , &H1111
            z = dmin + de! * t '                                      optional lableling
            z = z + ((z > 90) - (z < -90)) * 180
            z$ = Str$(z)
            TinyFont z$, q3 - Len(z$) * 4 - 2, ty + 2, -gc
        Next de!
    End If

    For star = 1 To nstars
        stx = starx(star): ax = Abs(stx)
        sty = stary(star): ay = Abs(sty)

        If warp! >= 1 Then
            tx = ax + Sgn(-vx!) * warp! * 2
            If ay < glmax Then Line (ax, ay)-(tx, ay), gray2
            If tx < 1 Then tx = tx + (q3 + 1)
            If tx > q3 Then tx = tx - (q3 + 1)
            starx(star) = tx * Sgn(stx + .01)
        Else
            If zoom = 1 Then ax = (ax - 320) * 2: ay = (ay - 175) * 2
            If zoom = 2 Then ax = (ax - 433) * 3: ay = (ay - 233) * 3
            m = 3 + (stx < 0) + (sty < 0) '                           magnitude
            If m < 3 Then tc = white2 Else tc = gray2 '               slightly different brightness
            If twinkle And (Rnd > .95) Then tc = black2
            If star = isred1 Then tc = red '                          Mira and Antares
            If star = isred2 Then tc = red
            If m = 1 Then '                                           small cross if < 2
                Line (ax - 1, ay)-(ax + 1, ay), tc
                Line (ax, ay - 1)-(ax, ay + 1), tc
            Else '                                                    bright or dim point
                PSet (ax, ay), tc
            End If
            ' IF (star MOD 37) = 0 THEN TinyFont STR$(star), ax, ay, sc ' diagnostic
            For i = 1 To named '                                      show names & info
                If star = starn(i) Then
                    For j = 0 To tss - 2
                        If j Then
                            ty = ay + j * 9 + (j = 2) * 3 + 1
                            TinyFont star$(j, i), ax, ty, sc
                        Else
                            PrintCGA star$(j, i), ax, ay + j * 9, sc, -1, 1
                        End If
                    Next j
                End If
            Next i
        End If
    Next star
    If rick Then '                                                    show counts
        z$ = LTrim$(Str$(starfiles)) + Str$(nstars) + Str$(starmax) + Str$(named) + Str$(th!)
        TinyFont z$, 86, 20, red
    End If
    Exit Sub

    readstar:
    tf = FreeFile
    Open tf1$ For Input As #tf
    Input #tf, nstars, named, isred1, isred2
    n1 = nstars
    For i = 1 To named
        Input #tf, starn(i)
        For j = 0 To 2
            Input #tf, star$(j, i)
        Next j
    Next i
    Close #tf
    Open tf2$ For Binary As #tf
    Get #tf, , starx()
    Close #tf
    Open tf3$ For Binary As #tf
    Get #tf, , stary()
    Close #tf
    Return
    ' -----------------------------------------------------------------------------------
    writestar:
    tf = FreeFile
    Open tf1$ For Output As #tf
    Print #tf, nstars; ","; named; ","; isred1; ","; isred2
    For i = 1 To named
        Print #tf, starn(i);
        For j = 0 To 2
            Print #tf, ","; star$(j, i);
        Next j
        Print #tf, Chr$(13);
    Next i
    Close #tf

    Open tf2$ For Binary As #tf
    Put #tf, , starx()
    Close #tf

    Open tf3$ For Binary As #tf
    Put #tf, , stary()
    Close #tf
    Return
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub Surveyor Static
    Dim SSp&(1, 26), x(1), y(1)
    If sspinit1 = 0 Then
        s& = VarSeg(SSp&(0, 0))
        o& = VarPtr(SSp&(0, 0))
        Def Seg = s&
        BLoad f$(17), o& '                                            surv2.dat
        sc = white
        sspinit1 = 1
    End If

    x0 = x
    ti = suri + x0 - 1
    If ti > q1 Then ti = ti - q1
    y0 = gh(ti)

    For i = 0 To 26
        tx = x0 + i
        Line (tx, y0 - 21)-(tx, y0 - 5), sc, , SSp&(0, i)
        Line (tx, y0 - 16)-(tx, y0 - 0), sc, , SSp&(1, i)
    Next i

    '                                                                 modify ground to include Surveyor
    If (x0 >= gs) And (x0 < 604) And (sspinit2 = 0) Then
        For tx = x0 To x0 + 32
            For ty = y0 - 20 To glmax
                If Point(tx, ty) = sc Then
                    z = (suri + tx) Mod q1
                    gh(z) = ty
                    Exit For
                End If
            Next ty
        Next tx
        sspinit2 = 1
    End If

    For tx = x0 To x0 + 26 '                                          optional shadow
        For ty = y0 - 21 To y0
            p = Point(tx, ty)
            If p = sc Then
                zx = tx - (x0 + 13)
                zy = ty - (y0 - t)
                If zy > (zx + 4) Then PSet (tx, ty), gray
            End If
        Next ty
    Next tx

    attack = 0
    sdd = q1
    For i = 180 To 355 Step 5 '                                       rays
        ra = i + Rnd * 5
        z = 25 + Rnd * t
        For j = 0 To 1
            x(j) = (x + t) + z * c!(ra) * aspect!
            y(j) = y0 + z * s!(ra) - 1
            z = z + Rnd * 30 + t
        Next j
        xs! = (x(1) - x(0)) / 20
        ys! = (y(1) - y(0)) / 20
        For j = 0 To 19
            tx = x(0) + j * xs!
            ty = y(0) + j * ys!
            x! = px! - tx
            y! = (py! - ty) * aspect!
            dd = Sqr(x! * x! + y! * y!)
            If dd < sdd Then sdd = dd
            If (shield = 0) Or (dd > 70) Or (j = 0) Then PSet (tx, ty), gunmetal
            If shield And ((dd = 70) Or ((j = 0) And (dd < 70))) Then
                Line (sx0 + xoff, sy0 + vy!)-(tx, ty), lmsl
                If Rnd < .7 Then
                    PSet Step(0, 0), red
                Else
                    Line (tx - 1, ty)-(tx + 1, ty), red
                    Line (tx, ty - 1)-(tx, ty + 1), red
                End If
                Exit For
            End If
        Next j
        If sdd < 20 Then attack = 1
    Next i
    If attack And (crash = 0) And (shield = 0) Then
        oldr = rads
        rads = rads + Rnd * t + 1
        If rads > 9999 Then rads = 9999
        If rads > oldr Then
            rtl!(0) = Timer + 5
            rtlc(0) = rads
            panelinit = 0
        End If
    End If
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub Tile Static '                                                     Truchet tiling
    If tinit = 0 Then
        s = 7
        Dim t(1, s, s)
        For i = 0 To 1
            For j = 0 To 1
                For k = 0 To 90 Step t
                    ta = k + j * 180
                    tx = j * s + (s \ 2) * c!(ta)
                    ty = j * s + (s \ 2) * s!(ta)
                    If i Then ty = s - ty
                    t(i, tx, ty) = 1
                Next k
            Next j
        Next i
        tinit = 1
    End If

    If gstyle = 4 Then tc = gray Else tc = black2
    For xo = gs To q3 Step s
        For yo = glmax To (glmin - 50) Step -s
            Select Case tilef '                                       static, change when moving, always changing
                Case Is = 0
                    bp = gety(xo) + yo
                    z1 = bp Mod 128
                    z2 = (bp Mod 12) + 1
                    td = p(z1, z2)
                    kk = Sgn(td And _SHL(1, (bp Mod 8)))
                Case Is = 1
                    bp = Sqr(xo * yo)
                    z1 = bp Mod 128
                    z2 = (bp Mod 12) + 1
                    td = p(z1, z2)
                    kk = Sgn(td And _SHL(1, (bp Mod 8)))
                Case Is = 2
                    kk = Rnd '
            End Select
            For i = 0 To s
                tx = xo + i
                yy = gety(tx) + 1
                For j = 0 To s
                    ty = yo - j
                    If ty <= yy Then Exit For
                    If t(kk, i, j) Then
                        zz = tx + suri
                        c1 = (sf(5, 2) = -1) Or (zz < sf(5, 0)) Or (zz > sf(5, 1)) '     McD
                        c2 = (sf(7, 2) = -1) Or (zz < sf(7, 0)) Or (zz > sf(7, 1)) '     Surv
                        If c1 And c2 Then PSet (tx, ty), tc
                    End If
                Next j
            Next i
        Next yo
    Next xo
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub TMA Static
    Dim tmaa!(10), tmab!(10), tmac(10)
    If ok And (InStr(fb$, "on TMA") > 0) Then '                       landed, do Mandelbrot instead of moire
        Mandel
        GoTo tmaother
    End If
    If zdc = 0 Then '                                                 then initialize
        nc = Rnd * 2 + 1 '                                            use 2-3 colors
        lc = -1 '                                                     last color, prevent repeats
        For z = 0 To nc
            tmaa!(z) = Rnd + 4
            tmab!(z) = (Rnd - pf!) / 8
            Do
                c = Rnd * 14 + 1
                If c = gray2 Then c = gray '                          stars use gray2
                If c = white2 Then c = white '                        stars use white2
                If c <> lc Then lc = c: Exit Do
            Loop
            tmac(z) = c
        Next z
    End If

    zdc = (zdc + 1) Mod 50
    For z = 0 To 2
        tmaa!(z) = tmaa!(z) + tmab!(z)
    Next z
    y0 = glmax - 72
    y1 = y0 + 1
    y2 = glmax - 1
    Line (x, glmax)-(x + 46, glmax), gray

    For gx = x To x + 45
        x2! = gx / tmaa!(0)
        x2! = x2! * x2!
        For gy = y1 To y2
            y2! = gy / tmaa!(0)
            y2! = y2! * y2!
            tcc = Abs((x2! + y2!) / tmaa!(1)) Mod (nc + 1)
            PSet (gx, gy), tmac(tcc)
        Next gy
    Next gx

    If Timer < cybilltime! Then CybillPix f$(16) Else gotpix = 0

    tmaother:
    If bolthitf Then Line (x, y0)-(x + 45, glmax), white, BF

    For s = 0 To 20 '                                                 shells
        If (shx(s) > 0) And (shd(s) < 80) Then
            tarx = shx(s) - suri
            tary = shy(s)
            If (s > 0) Or (shy(s) > 200) Then
                GoSub tmafl
                ExplodeShell s '                                      show it exploded
            End If
        End If
    Next s

    For i = 2 To 6 '                                                  not DS!
        If (ek(i) > 0) And (ek(i) < 30) Then
            tarx = exl(i) '                                           where to shoot
            tary = ey(i)
            GoSub tmafl '                                             fire laser
            ek(i) = 0
            ex(i) = 0 '                                               mark destroyed
            exv(i) = 0
        End If
    Next i
    Exit Sub

    tmafl: '                                                          fire laser
    For gx = x To x + 45 Step 2 '                                     along top of TMA1
        Line (gx, y1 - 1)-(tarx, tary), blue '                        nice blue
    Next gx
    If gotpix = 0 Then '                                              not showing Cybill
        cybilltime! = Timer + 2 '                                     keep on screen for 2 sec
        gotpix = 1 '                                                  flag onscreen
    End If
    Return
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub TinyFont (d$, tx, ty, tc) Static '                                3*5 font for countdown, clock, Borg
    If fontinit = 0 Then '                                            initialize
        Dim sp(13, 4)
        Restore tinyfontd
        For n = 0 To 13
            Read g$
            For i = 0 To 4
                Read z
                sp(n, i) = z * 4096
            Next i
        Next n
        fontinit = 1
    End If

    For z = 1 To Len(d$)
        z$ = Mid$(d$, z, 1)
        zz = InStr(".-: ", z$)
        If zz Then d = zz + 9 Else d = Val(z$)
        If (tc = 1) And (Rnd > .9) Then ttc = 3 Else ttc = tc '       Borg effect (some bright)
        For i = 0 To 4
            x2 = tx + z * 4 + j - 4
            Line (x2, ty + i)-(x2 + 4, ty + i), Abs(ttc), , sp(d, i)
        Next i
    Next z
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub timemachine '                                                     xlate to 32 bit color for green screen, warp effects
    Dim oc&(15)
    For i = 0 To 15
        Out &H3C7, i
        tred = Inp(&H3C9) * 4: tgrn = Inp(&H3C9) * 4: tblu = Inp(&H3C9) * 4
        coav = (tred + tgrn + tblu) \ 3 '                             color average
        If cpal = 0 Then
            oc&(i) = _RGB32(tred, tgrn, tblu) '                       regular color
        ElseIf cpal = 1 Then
            oc&(i) = _RGB32(0, coav, 0) '                             shades of green
        ElseIf cpal = 2 Then
            oc&(i) = _RGB32(coav, coav \ 2, 0) '                      shades of orange
        Else
            oc&(i) = _RGB32(coav, coav, coav) '                       black and white
        End If
    Next i

    Dim m As _MEM
    m = _MemImage(canvas&) '                                          canvas& = _NewImage(640, 350, 9)
    Do: _Limit q4 '                                                   349 (h/100 too little, slows down program!)
        tempimage& = _NewImage(640, 350, 32)
    Loop Until tempimage& < -1 '                                      try until valid (can fail to make screen)
    Screen tempimage&
    For y = 0 To q4 '                                                 replot each pixel of old to new screen
        For x = 0 To q3
            a& = y * 640 + x
            dd = _MemGet(m, m.OFFSET + a&, _Unsigned _Byte)
            PSet (x, y), oc&(dd)
        Next x
    Next y

    If (Len(dead$) = 0) And (warp! >= 1) Then
        View Screen(gs, Sgn(Len(mes$(0))) * 20)-(q3, q4) '            protect instrument panel, top line if message active
        If warp! >= 9 Then contour Else warpx
        View Screen(gs, 0)-(q3, q4) '                                 back to normal, only instrument panel protected
    End If

    If (rdtime! > 0) And (Timer < rdtime!) And _FileExists(mpath$ + "rick.jpg") Then
        i& = _LoadImage(mpath$ + "rick.jpg") '                                 87 * 93 pix of author
        If i& < -1 Then
            tx = _Width - 87
            _PutImage (tx, 0)-(tx + 87, 93), i&, 0
            _FreeImage i&
            _PrintString (tx + 24, 100), "What?"
        End If
    End If

    If starship And _FileExists(mpath$ + "starship.jpg") Then
        If shipi& = 0 Then shipi& = _LoadImage(mpath$ + "starship.jpg") '      296 * 91
        shipx = shipx + 4
        ty1 = py! - 50: ty2 = ty1 + 91
        shipo = shipx - 100
        q = 2
        gs = 0
        If shipi& < -1 Then _PutImage (shipo, ty1 \ q)-(shipo + 296 \ q, ty2 \ q), shipi&, 0
        If shipx > 750 Then shipx = 0: starship = 0
    End If

    _Display '                                                        show new image
    Screen canvas& '                                                  back to old mode so the rest of the program can run
    _MemFree m '                                                      would run out of memory otherwise
    _FreeImage tempimage&

End Sub
' -------------------------------------------------------------------------------------------------------x
Sub UFO (tx0, ty0, txi) Static '                                      so pathetic a graphic that it's funny, maybe
    aa = (aa + 5) Mod tsix
    tx = tx0 + t * Cos(_D2R(aa))
    ty = ty0 + t * Sin(_D2R(aa))
    For i = 0 To 55
        Circle (tx, ty), i, gunmetal, , , .15
    Next i
    For i = 8 To 15
        If i Mod 2 Then tc = orange Else tc = black2
        Circle (tx, ty - 12), i, tc, , , .35
    Next i
    tc = Val(Mid$("020414", (ty Mod 3) * 2 + 1, 2))
    p = (p + 1) Mod 5
    If txi < 0 Then tp = 4 - p Else tp = p
    For z = -2 To 2
        tx2 = tx + z * 16
        Circle (tx2, ty), 5 - Abs(z), black2, , , .7
        If tp = (z + 2) Then tc2 = tc Else tc2 = black2
        Paint (tx2, ty), tc2, black2
        Circle (tx2, ty), 5 - Abs(z), tc2, , , .7
    Next z
    Line (tx - 30, ty + 8)-(tx - 35, ty + 20), orange '               legs
    Line (tx - 37, ty + 20)-(tx - 31, ty + 20), orange
    Line (tx + 30, ty + 8)-(tx + 35, ty + 20), orange '               pads
    Line (tx + 32, ty + 20)-(tx + 38, ty + 20), orange
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub Volcano Static

    If vinit = 0 Then
        q = q3 * 2 '                                                  640*2=1280
        Dim vox!(q), voy!(q), vxi!(q), vyi!(q)
        vinit = 1
    End If

    vx = sf(4, 2)
    If Abs((Timer Mod t) - (Rnd * t)) > 5 Then
        For i = 0 To q
            If vyi!(i) < -3 Then k! = .6 Else k! = .8 '               kill some
            If (vox!(i) = 0) Or (Rnd > k!) Then '                     dead or kill
                vox!(i) = vx + Rnd * t - 5 '                          initial x
                voy!(i) = gety(Int(vox!(i) - suri)) - 1 '             initial y
                ta = Rnd * 40 + 70 '                                  angle
                r! = _D2R(ta)
                vxi!(i) = (Rnd * t + 1) * Cos(r!) '                   x velocity
                vyi!(i) = (Rnd * t + 2) * Sin(r!) '                   y velocity
            End If
        Next i
    End If

    For i = 0 To q
        tx = vox!(i) - suri '                                         local x
        ty = voy!(i) '                                                local y
        If shield Then z = 0: GoSub protect
        If ty > q4 Then '                                             off screen
            vox!(i) = 0 '                                             flag for init
        Else
            If (tx >= gs) And (tx <= q3) Then
                If vyi!(i) < -(Rnd * 4) Then
                    c = gunmetal
                    If (ty > gety(tx)) And (gstyle = 0) Then c = black ' black on white
                Else
                    c = orange
                End If
                PSet (tx, ty), c
                If i Mod 2 Then Line -Step(Rnd * 2 - 1, Rnd * 2 - 1), c
            End If
        End If
        vyi!(i) = vyi!(i) - .25 '                                     decelerate
        vox!(i) = vox!(i) - vxi!(i) '                                 new x
        voy!(i) = voy!(i) - vyi!(i) '                                 new y
    Next i
    Exit Sub

    protect:
    dx! = px! - tx '                                                  distance x
    dy! = (py! - ty) * aspect! '                                      distance y
    dd = Sqr(dx! * dx! + dy! * dy!) '                                 distance
    If dd < 70 Then '                                                 at shield
        z = 1
        vyi!(i) = 0
        ty = ty - Sgn(dy!)
        GoTo protect
    End If
    If z Then '                                                       laser
        vxi!(i) = Sgn(dx!) * (5 + Rnd * 5)
        Line (sx0 + xoff, sy0 + vy!)-(tx, ty), lmsl
    End If
    Return
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub warpx Static
    wa1 = (wa1 + 5) Mod tsix
    wa2 = wa1
    wx! = 320 + 70 * s!(wa1)
    wy! = 175 + 70 * c!(wa1)
    wc1 = 200
    For wd1 = 64 To 600 Step 8
        wa2 = wa2 + 2
        wc1 = (wc1 + 27) Mod 512
        wc2 = Abs(wc1 - 256)
        wc& = _RGB32(wc2, 1, 1)
        wd2 = 20 * s!((Abs(wa1 - 256) * 5) Mod tsix)
        wd3 = wd1 + wd2
        For z = 0 To 4
            wde = (wa2 + 90 * z) Mod tsix
            wtx = wx! + wd3 * s!(wde)
            wty = wy! + wd3 * c!(wde)
            If z = 0 Then PSet (wtx, wty), wc& Else Line -(wtx, wty), wc&
        Next z
    Next wd1
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub Wave Static '                                                     funny effect for warp speeds
    tdg = (tdg Mod 4) + 1
    For i = 1 To 22
        '               1234567890123456789012
        '               TTTTHHHHHVVVVVAAAAFFFF
        osc = Val(Mid$("1111222223333344445555", i, 1))
        wll = Val(Mid$("45555", osc, 1))
        adg = (tdg + wll) Mod 4 + 1 - (wll = 4)
        z$ = Mid$("agdgagdg", adg, wll)
        LEDdisplay z$
    Next i
End Sub
' -------------------------------------------------------------------------------------------------------x
Sub WormHole Static
    If eou Then Exit Sub '                                            end of universe

    If ei(4) = 0 Then
        nc:
        c1 = Rnd * 14 + 1
        c2 = Rnd * 14 + 1
        If c1 = c2 Then GoTo nc
        If (c1 = black2) Or (c1 = gray) Then GoTo nc
        If (c2 = black2) Or (c2 = gray) Then GoTo nc
        ei(4) = 1
    End If

    tx = localize(ex(4), 0, 0)
    wy = ey(4)
    ba = (ba + 30) Mod tsix
    For ta = 0 To 720 Step 2
        For d = 0 To 3
            baa = (ta + ba + d * 90) Mod tsix
            tx1 = tx + ta / 8 * c!(baa)
            ty1 = wy + ta / 40 * s!(baa)
            If d Mod 2 Then c = c1 Else c = c2
            PSet (tx1, ty1), c
        Next d
    Next ta
End Sub

