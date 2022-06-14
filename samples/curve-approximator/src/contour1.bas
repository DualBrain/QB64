deflng a-z

const sw = 800
const sh = 600

dim shared pi as double
pi = 4*atn(1)

n = 0
redim x(n), y(n)

r = 20


screen _newimage(sw, sh, 32),,0,0
_screenmove 0.5*(1920 - sw), 0.5*(1080 - sh)

do
	do while _mouseinput
		mw = mw + _mousewheel
	loop
	mx = _mousex
	my = _mousey
	mb = _mousebutton(1)


	if mb = -1 then
		n = 1
		redim _preserve x(n)
		redim _preserve y(n)

		mx = _mousex
		my = _mousey

		x(0) = mx - sw/2
		y(0) = sh/2 - my

		pset (mx, my)
		do while mb = -1
			do while _mouseinput
			loop
			mx = _mousex
			my = _mousey
			mb = _mousebutton(1)

			line -(mx, my)

			if (mx - omx)^2 + (my - omy)^2 > r*r then
				circle (mx, my), 3
				omx = mx
				omy = my

				x(n) = mx - sw/2
				y(n) = sh/2 - my
				n = n + 1
				redim _preserve x(n)
				redim _preserve y(n)
			end if
			_display
		loop

		'close the contour
		x(n) = x(0)
		y(n) = y(0)
		n = n + 1
		redim _preserve x(n)
		redim _preserve y(n)

		'redraw spline frame
		screen ,,1,0
		cls
		pset (sw/2 + x(0), sh/2 - y(0)), _rgb(100,0,0)
		for i=0 to n-1
			line -(sw/2 + x(i), sh/2 - y(i)), _rgb(100,0,0)
			circle step(0, 0), 3, _rgb(100,0,0)
		next

		'draw bezier curve
		dim as double bx, by, bin, t

		pset (sw/2 + x(0), sh/2 - y(0)), _rgb(255,0,0)
		for t=0 to 1 step 0.01
			bx = 0
			by = 0

			for i=0 to n-1
				bin = 1
				for j=1 to i
					bin = bin*(n - j)/j
				next

				bx = bx + bin*((1 - t)^(n - 1 - i))*(t^i)*x(i)
				by = by + bin*((1 - t)^(n - 1 - i))*(t^i)*y(i)
			next
			line -(sw/2 + bx, sh/2 - by), _rgb(255,0,0)
		next
		'close
		line -(sw/2 + x(0), sh/2 - y(0)), _rgb(255,0,0)

		'screen ,,0,0
		'pcopy 1,0
		'_display

		'animate derivative vector
		dim as double dx, dy

		screen ,,0,0

		do
			for t=0 to 1 step 0.01
				pcopy 1,0

				bx = 0
				by = 0

				dx = 0
				dy = 0
				for i=0 to n-1
					bin = 1
					for j=1 to i
						bin = bin*(n - j)/j
					next
					bx = bx + bin*((1 - t)^(n - 1 - i))*(t^i)*x(i)
					by = by + bin*((1 - t)^(n - 1 - i))*(t^i)*y(i)

					dx = dx + bin*((1 - t)^(n - 2 - i))*(t^(i - 1))*(i - (n)*t + t)*x(i)
					dy = dy + bin*((1 - t)^(n - 2 - i))*(t^(i - 1))*(i - (n)*t + t)*y(i)
				next

				circlef sw/2 + bx, sh/2 - by, 3, _rgb(255,255,0)
				line (sw/2 + bx, sh/2 - by)-step(1*dx, -1*dy), _rgb(255,255,0)

				_display
				_limit 30

				if _keyhit = 27 then exit do
			next
		loop

		cls
	end if

	_limit 50
loop until _keyhit = 27
system

sub circlef(x, y, r, c)
    x0 = r
    y0 = 0
    e = -r
    do while y0 < x0
        if e <= 0 then
            y0 = y0 + 1
            line (x - x0, y + y0)-(x + x0, y + y0), c, bf
            line (x - x0, y - y0)-(x + x0, y - y0), c, bf
            e = e + 2*y0
        else
            line (x - y0, y - x0)-(x + y0, y - x0), c, bf
            line (x - y0, y + x0)-(x + y0, y + x0), c, bf
            x0 = x0 - 1
            e = e - 2*x0
        end if
    loop
    line (x - r, y)-(x + r, y), c, bf
end sub
