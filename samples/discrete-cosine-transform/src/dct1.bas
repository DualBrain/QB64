deflng a-z

const n = 10

type dct_type
	r as double
	g as double
	b as double
end type

type q_type
	r as _unsigned _byte
	g as _unsigned _byte
	b as _unsigned _byte
end type

dim shared pi as double
pi = _pi

img1 = _loadimage("greenland1.png", 32)

w = _width(img1)
h = _height(img1)

ww = (w\n+1)*n
hh = (h\n+1)*n

dim dct(ww, hh) as dct_type
dim q(ww, hh) as q_type

dim sr as double, sg as double, sb as double
dim c as double, cu as double, cv as double

img2 = _newimage(w, h, 32)
img3 = _newimage(w, h, 32)

img1_dct = _newimage(w, h, 32)
img2_dct = _newimage(w, h, 32)
img3_dct = _newimage(w, h, 32)

screen _newimage(3*w, 2*h, 32)
_putimage (0,0),img1

_source img1

'forward DCT
for y0=0 to hh-1 step n
for x0=0 to ww-1 step n
	for y=0 to n-1
	for x=0 to n-1
		sr = 0
		sg = 0
		sb = 0

		for v=0 to n-1
		for u=0 to n-1
			if (x0 + u > w - 1) then px = x0 + u - n else px = x0 + u
			if (y0 + v > h - 1) then py = y0 + v - n else py = y0 + v

			z = point(px, py)
			r = _red(z)
			g = _green(z)
			b = _blue(z)

			c = cos((2*u + 1)*x*pi/(2*n)) * cos((2*v + 1)*y*pi/(2*n))

			sr = sr + r*c
			sg = sg + g*c
			sb = sb + b*c
		next
		next

		if x = 0 then cu = 1/sqr(2) else cu = 1
		if y = 0 then cv = 1/sqr(2) else cv = 1

		dct(x0 + x, y0 + y).r = sr*cu*cv/(0.5*n)
		dct(x0 + x, y0 + y).g = sg*cu*cv/(0.5*n)
		dct(x0 + x, y0 + y).b = sb*cu*cv/(0.5*n)
	next
	next
next
next

'quantization
dim minr as double, ming as double, minb as double
dim maxr as double, maxg as double, maxb as double

minr = 1000000
ming = 1000000
minb = 1000000

maxr = -1000000 
maxg = -1000000 
maxb = -1000000 

for y=0 to hh
for x=0 to ww
	if dct(x, y).r < minr then minr = dct(x, y).r
	if dct(x, y).g < ming then ming = dct(x, y).g
	if dct(x, y).b < minb then minb = dct(x, y).b

	if dct(x, y).r > maxr then maxr = dct(x, y).r
	if dct(x, y).g > maxg then maxg = dct(x, y).g
	if dct(x, y).b > maxb then maxb = dct(x, y).b
next
next

_dest img1_dct
for y=0 to hh
for x=0 to ww
	r = q(x, y).r 
	g = q(x, y).g 
	b = q(x, y).b 

	pset (x, y), _rgb(r, g, b)
next
next


_dest img1_dct
for y=0 to hh
for x=0 to ww
	q(x, y).r = 255*(dct(x,y).r - minr)/(maxr - minr)
	q(x, y).g = 255*(dct(x,y).g - ming)/(maxg - ming)
	q(x, y).b = 255*(dct(x,y).b - minb)/(maxb - minb)

	r = q(x, y).r
	g = q(x, y).g
	b = q(x, y).b

	pset (x, y), _rgb(r, g, b)
next
next


_dest img2_dct
for y0=0 to hh-1 step n
for x0=0 to ww-1 step n
	for y=0 to 7 'n-1
	for x=0 to 7 'n-1
		r = q(x0 + x, y0 + y).r 
		g = q(x0 + x, y0 + y).g 
		b = q(x0 + x, y0 + y).b 

		if (x0 + x < w) and (y0 + y < h) then pset (x0 + x, y0 + y), _rgb(r, g, b)
	next
	next
next
next

_dest img3_dct
for y0=0 to hh-1 step n
for x0=0 to ww-1 step n
	for y=0 to 2 'n-1
	for x=0 to 2 'n-1
		r = q(x0 + x, y0 + y).r 
		g = q(x0 + x, y0 + y).g 
		b = q(x0 + x, y0 + y).b 

		if (x0 + x < w) and (y0 + y < h) then pset (x0 + x, y0 + y), _rgb(r, g, b)
	next
	next
next
next

_dest img2
'inverse DCT
for y0=0 to hh-1 step n
for x0=0 to ww-1 step n
	for y=0 to n-1
	for x=0 to n-1
		sr = 0
		sg = 0
		sb = 0

		for v=0 to 7 'n-1
		for u=0 to 7 'n-1
			c = cos((2*x + 1)*u*pi/(2*n))*cos((2*y + 1)*v*pi/(2*n))

			if u = 0 then cu = 1/sqr(2) else cu = 1
			if v = 0 then cv = 1/sqr(2) else cv = 1

			'sr = sr + dct(x + x3, y + y3).r*c*cu*cv
			'sg = sg + dct(x + x3, y + y3).g*c*cu*cv
			'sb = sb + dct(x + x3, y + y3).b*c*cu*cv

			r = q(x0 + u, y0 + v).r 
			g =	q(x0 + u, y0 + v).g 
			b = q(x0 + u, y0 + v).b 

			sr = sr + c*cu*cv*((r/255)*(maxr - minr) + minr)
			sg = sg + c*cu*cv*((g/255)*(maxg - ming) + ming)
			sb = sb + c*cu*cv*((b/255)*(maxb - minb) + minb)
		next
		next

		sr = sr/(0.5*n)
		sg = sg/(0.5*n)
		sb = sb/(0.5*n)

		if (x0 + x < w) and (y0 + y < h) then pset (x0 + x, y0 + y), _rgb(sr, sg, sb)
	next
	next
next
next

_dest img3
'inverse DCT
for y0=0 to hh-1 step n
for x0=0 to ww-1 step n
	for y=0 to n-1
	for x=0 to n-1
		sr = 0
		sg = 0
		sb = 0

		for v=0 to 2
		for u=0 to 2
			c = cos((2*x + 1)*u*pi/(2*n))*cos((2*y + 1)*v*pi/(2*n))

			if u = 0 then cu = 1/sqr(2) else cu = 1
			if v = 0 then cv = 1/sqr(2) else cv = 1

			'sr = sr + dct(x + x3, y + y3).r*c*cu*cv
			'sg = sg + dct(x + x3, y + y3).g*c*cu*cv
			'sb = sb + dct(x + x3, y + y3).b*c*cu*cv

			r = q(x0 + u, y0 + v).r 
			g = q(x0 + u, y0 + v).g 
			b = q(x0 + u, y0 + v).b 

			sr = sr + c*cu*cv*((r/255)*(maxr - minr) + minr)
			sg = sg + c*cu*cv*((g/255)*(maxg - ming) + ming)
			sb = sb + c*cu*cv*((b/255)*(maxb - minb) + minb)
		next
		next

		sr = sr/(0.5*n)
		sg = sg/(0.5*n)
		sb = sb/(0.5*n)

		if (x0 + x < w) and (y0 + y < h) then pset (x0 + x, y0 + y), _rgb(sr, sg, sb)
	next
	next
next
next


_dest 0
_putimage (w,0), img2
_putimage (2*w,0), img3
_putimage (0,h), img1_dct
_putimage (w,h), img2_dct
_putimage (2*w,h), img3_dct

do
loop until _keyhit=27
system
