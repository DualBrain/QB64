The **RND** function returns a random number with a value between 0 (inclusive) and 1 (exclusive).

## Syntax
 
> result! = [RND](RND) [(*n*)]

## Parameter(s)

* *n* is a [SINGLE](SINGLE) numeric value that defines the behavior of the RND function but is **NOT normally required**:
    - n parameter omitted: Returns next random number in the sequence.
    - n = 0: Return the last value returned.
    - n < 0: Always returns the same value for any given n
    - n > 0: the sequence of numbers generated will not change unless [RANDOMIZE](RANDOMIZE) is initiated. 

## Description

* The random numbers generated range from 0 minimum to .9999999 maximum  [SINGLE](SINGLE) values that never equal 1.
* To get values in a range larger than 1, multiply RND with a number to get returns up to but not including that numerical value.
* To get values starting at a certain number, add that number to the RND result as RND minimums can be 0.
* If you need an integer range of numbers, like a dice roll, round it down to an [INT](INT). Add 1 to the maximum number with [INT](INT).
* The random sequence is 2 ^ 24 or 16,777,216 entries long, which can allow repeated patterns in some procedures.
* Formulas for the [INT](INT) or [CINT](CINT) of ANY number range from *min%*(lowest value) to *max%*(greatest value): 
  * Using [INT](INT): randNum% = INT(RND * (max% - min% + 1)) + min%
  * Using [CINT](CINT): randNum% = CINT(RND * (max% - min%)) + min%
* Use [RANDOMIZE](RANDOMIZE) [TIMER](TIMER) for different random number results each time a program is run. 
* [RUN](RUN) should reset the [RANDOMIZE](RANDOMIZE) sequence to the starting [RND](RND) function value.(Not yet in QB64)

## Example(s)

Generating a random integer value between 1 and 6 (inclusive) using INT.

```vb

dice% = INT(RND * 6) + 1 'add one as INT value never reaches 6 

```

Using uniform random numbers to create random numbers with a gaussian distribution ([http://en.wikipedia.org/wiki/Marsaglia_polar_method| Marsaglia's polar method]).

```vb

DO
  u! = RND * 2 - 1
  v! = RND * 2 - 1
  s! = u! * u! + v! * v!
LOOP WHILE s! >= 1 OR s! = 0
s! = SQR(-2 * LOG(s!) / s!) * 0.5
u! = u! * s!
v! = v! * s! 

```

> *Explanation:* Values *u!* and *v!* are now two independent random numbers with gaussian distribution, centered at 0.

Random flashes from an explosion

```vb

SCREEN _NEWIMAGE(640, 480, 32)
RANDOMIZE TIMER
BC = 120 ' BALL COUNT
DIM ballx(1 TO BC)
DIM bally(1 TO BC)
DIM velx(1 TO BC)
DIM vely(1 TO BC)
DIM bsize(1 TO BC)
Y = INT(RND * (400 - 100 + 1)) + 100
X0 = 325
Y0 = 300
Tmax = 150
DO
    FOR p = 1 TO BC
        T = INT(RND * (Tmax - 50 + 1)) + 50
        X = INT(RND * (1000 + 500 + 1)) - 500
        velx(p) = (X - X0) / T '                       calculate velocity based on flight time
        vely(p) = -1 * (Y - .05 * (T ^ 2 + 20 * Y0)) / (T) ' verticle velocity
    NEXT p

    FOR w = 1 TO BC
        bsize(w) = INT(RND * (10 - 0 + 1)) + 0 'size
    NEXT w

    FOR J = 1 TO Tmax
        _LIMIT 60
        CLS
        'FOR i = 0 TO 255 STEP .5
        'CIRCLE (X0, Y0), i, _RGB(255 - i, 0, 0), 0, 3.147
        ' NEXT i

        R = INT(RND * (25 - 20 + 1)) + 20 'random glimmer
        FOR z = 1 TO BC
            ballx(z) = X0 + velx(z) * J
            bally(z) = Y0 - vely(z) * J + .5 * .1 * J ^ 2
        NEXT z

        FOR d = 1 TO BC
            RCOL = INT(RND * (255 - 0 + 1)) 'color
            FOR i = 0 TO bsize(d) + 1 STEP .4 'draw balls
                CIRCLE (ballx(d), bally(d)), i, _RGBA(255, RCOL - (R * i), RCOL - R * i, 255)
            NEXT i
        NEXT d

        _DISPLAY

    NEXT J

LOOP UNTIL INKEY$ <> "" 

```

## See Also

* [RANDOMIZE](RANDOMIZE), [TIMER](TIMER)
* [INT](INT), [CINT](CINT), [FIX](FIX)
