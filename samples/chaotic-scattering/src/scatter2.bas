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

