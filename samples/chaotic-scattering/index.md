[Home](https://qb64.com) • [News](../../news.md) • [GitHub](../../github.md) • [Wiki](../../wiki.md) • [Samples](../../samples.md) • [Media](../../media.md) • [Community](../../community.md) • [Rolodex](../../rolodex.md) • [More...](../../more.md)

## SAMPLE: CHAOTIC SCATTERING - GASPARD-RICE SYSTEM

![chaoticscattering.png](img/chaoticscattering.png)

### Author

[🐝 vince](../vince.md) 

### Description

```text
Demo of the Gaspard-Rice system. Left-click to change location.
```

### Code

#### chaoticscattering.bas

```vb

DEFINT A-Z
sw = 640
sh = 480
DIM pi AS DOUBLE
DIM t AS DOUBLE
DIM a AS DOUBLE, b AS DOUBLE
DIM a1 AS DOUBLE, a2 AS DOUBLE

DIM x AS DOUBLE, y AS DOUBLE
DIM x0 AS DOUBLE, y0 AS DOUBLE
DIM x1 AS DOUBLE, y1 AS DOUBLE

pi = 3.141593

SCREEN _NEWIMAGE(sw, sh, 12)

r = 150
rr = 100

xx = sw / 2
yy = sh / 2

DO
    DO
        mx = _MOUSEX
        my = _MOUSEY
        mb = _MOUSEBUTTON(1)
    LOOP WHILE _MOUSEINPUT

    LINE (0, 0)-(sw, sh), 0, BF
    FOR b = 0 TO 2 * pi STEP 2 * pi / 3
        CIRCLE (r * COS(b) + sw / 2, r * SIN(b) + sh / 2), rr
    NEXT

    IF mb THEN
        f = -1
        DO WHILE mb
            DO
                mb = _MOUSEBUTTON(1)
            LOOP WHILE _MOUSEINPUT
        LOOP
        FOR b = 0 TO 2 * pi STEP 2 * pi / 3
            x1 = r * COS(b) + sw / 2
            y1 = r * SIN(b) + sh / 2
            IF (mx - x1) ^ 2 + (my - y1) ^ 2 < rr * rr THEN f = 0
        NEXT
        IF f THEN
            xx = mx
            yy = my
            f = -1
        END IF
    END IF

    x0 = xx
    y0 = yy

    a = _ATAN2(my - yy, mx - xx)

    t = 0
    DO
        t = t + 1
        x = t * COS(a) + x0
        y = t * SIN(a) + y0
        IF x < 0 OR x > sw OR y < 0 OR y > sh THEN EXIT DO
        FOR b = 0 TO 2 * pi STEP 2 * pi / 3
            x1 = r * COS(b) + sw / 2
            y1 = r * SIN(b) + sh / 2
            IF (x - x1) ^ 2 + (y - y1) ^ 2 < rr * rr THEN
                a1 = _ATAN2(y - y1, x - x1)
                a2 = 2 * a1 - a - pi

                LINE (x0, y0)-(x, y), 14

                x0 = x
                y0 = y
                a = a2
                t = 0
                EXIT FOR
            END IF
        NEXT
    LOOP

    LINE (x0, y0)-(x, y), 14

    _DISPLAY
    _LIMIT 50
LOOP UNTIL _KEYHIT = 27
SYSTEM

```

#### scatter2.bas

```vb

#lang "fblite"

dim pi as double
pi = 4*atn(1)

sw = 800
sh = 600

dim as double t, a, b, a1, a2
dim as double x, y, x0, y0, x1, y1, dx, dy
r = 150
rr0 = 110

sx = 0
sy = sh/2

screenres sw, sh, 32

do
    m = getmouse(mx, my, mw, mb)
    
    rr = rr0 + mw
    
    if mb > 0 then
        do while mb > 0
            m = getmouse(mx, my, mw, mb)
        loop
        
        valid = -1
        for b = 0 to 2*pi step 2*pi/3
            x1 = r*cos(b) + sw/2
            y1 = r*sin(b) + sh/2
                
            dx = mx - x1
            dy = my - y1
            if dx*dx + dy*dy < rr*rr then
                valid = 0
                exit for
            end if
        next
        
        if valid then
            sx = mx
            sy = my
        end if
    end if
    
	if mx<>old_mx or my<>old_my or mw<>old_mw then
		screenlock

		line (0,0)-(sw,sh), rgb(0,0,0), bf

		locate 1,1: ? mx, my, mw, mb
		
		for b = 0 to 2*pi step 2*pi/3
			circle (r*cos(b) + sw/2, r*sin(b) + sh/2), rr
		next
		
		a = atan2(my - sy, mx - sx)
		
		x0 = sx
		y0 = sy
		
		for t = 0 to 1000
			x = t*cos(a) + x0
			y = t*sin(a) + y0
			
			for b = 0 to 2*pi step 2*pi/3
				if x >= 0 and x < sw and y >=0 and y < sh then
					x1 = r*cos(b) + sw/2
					y1 = r*sin(b) + sh/2
					
					dx = x - x1
					dy = y - y1
					if dx*dx + dy*dy < rr*rr then
						a1 = atan2(dy, dx)
						a2 = 2*a1 - a - pi
						
						line (x0, y0)-(x, y), rgb(233,205,89)
						
						x0 = x
						y0 = y
						a = a2
						t = 0
						exit for
					end if
				end if
			next
		next
		
		line (x0, y0)-(x, y), rgb(233,205,89)
		
		screenunlock
		screensync
	end if

	old_mx = mx
	old_my = my
	old_mw = mw

loop until inkey = chr(27)
system

```

### File(s)

* [chaoticscattering.bas](src/chaoticscattering.bas)
* [scatter2.bas](src/scatter2.bas)

🔗 [ray tracing](../ray-tracing.md), [reflections](../reflections.md)


<sub>Reference: [qb64.org Forum](https://qb64forum.alephc.xyz/index.php?topic=2300.0) , [qb64.org Forum](https://en.wikipedia.org/wiki/Chaotic_scattering) </sub>
