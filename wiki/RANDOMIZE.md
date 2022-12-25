**RANDOMIZE** is used with a seed value to generate different random number sequences using the [RND](RND) function.

## Syntax

> **RANDOMIZE** [USING] **{*seednumber*|TIMER}**

* The *seed number* can be ANY positive or negative numerical type value. The [TIMER](TIMER) value is often used to change [RND](RND) output each run.
* If the *seed number* is omitted, the program will display: **Random-number seed (-32768 to 32767)?** request on screen.
* **USING** resets a *seed number* sequence to the start of the sequence as if the program just started using that seed in **QB64 only**.
* **Note:** The RANDOMIZE USING *seed number* MUST be designated or a Name already in use status error will occur! 
* If the same initial seed number is used, the sequence of random numbers returned will be identical every program run.
* The fact that random numbers would always be the same has been used for simple data encryption and decryption.
* Using a [TIMER](TIMER) starting value ensures that the initial return sequence values are different almost every time the program is run!
* [RUN](RUN) should reset the [RANDOMIZE](RANDOMIZE) sequence to the starting [RND](RND) function value.(Not yet in QB64)

## Example(s)

Using RANDOMIZE **TIMER** to set a different starting sequence of [RND](RND) numbers every run.

```vb

RANDOMIZE TIMER
DO
randnum% = INT(RND * 11) + 2  'add one to multiplier as INT rounds down and never equals 10
PRINT randnum%
K$ = INPUT$(1)
LOOP UNTIL UCASE$(K$) = "Q"  'q = quit
END 

```

> *Explanation:* Procedure generates random integer values from 2 to 12 like a pair of dice.

Repeating a random number sequence with RANDOMIZE **USING** and a specific seed value in **QB64** only.

```vb

seed = 10
RANDOMIZE seed
Print7
RANDOMIZE seed
Print7
PRINT "Press a key to start sequence over!"
K$ = INPUT$(1) 
RANDOMIZE **USING** seed
Print7

SUB Print7
FOR r = 1 TO 7
  PRINT RND;
NEXT
PRINT: PRINT
END SUB 

```

> *Explanation:* The second RANDOMIZE statement just continues the sequence where USING in the third restarts the sequence.

Random fireworks explosions:

```vb

RANDOMIZE TIMER
DEFINT A-Z

TYPE ftype
    vx AS SINGLE
    vy AS SINGLE
END TYPE
DIM frag(500) AS ftype 'fragments

DIM pi AS SINGLE
pi = 3.141593

DIM x AS SINGLE, y AS SINGLE
DIM t AS SINGLE, g AS SINGLE, p AS SINGLE
t = 0
g = 0.4 'gravity
p = 15 'explosion power

sw = 800
sh = 600

SCREEN _NEWIMAGE(sw, sh, 32)

DO
    FOR i = 0 TO UBOUND(frag)
        frag(i).vx = RND * COS(2 * pi * RND)
        frag(i).vy = RND * SIN(2 * pi * RND)
    NEXT

    x = sw * RND
    y = sh * RND

    FOR t = 0 TO 25 STEP 0.1
        LINE (0, 0)-(sw, sh), _RGB(0, 0, 0), BF
        FOR i = 0 TO UBOUND(frag)
            PSET (x + t * p * frag(i).vx, y + t * p * frag(i).vy + g * t * t), _RGB(255, 255, 0)
        NEXT
        _DISPLAY
        _LIMIT 150

        IF _KEYHIT = -27 THEN EXIT DO
    NEXT
LOOP
SYSTEM

```

## See Also
 
* [RND](RND), [INT](INT), [CINT](CINT)
* [TIMER](TIMER)
