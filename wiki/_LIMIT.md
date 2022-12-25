The [_LIMIT](_LIMIT) statement sets the loop repeat rate of a program to so many per second, relinquishing spare CPU cycles to other applications. 

## Syntax
 
> [_LIMIT](_LIMIT) framesPerSecond!

* The framesPerSecond! [SINGLE](SINGLE) parameter value adjusts the loops per second of a program loop. **Do not use negative values.**
* The loop code is executed before the loop is delayed. Loop cycles below once per second may delay program [_EXIT](_EXIT)s.
* _LIMIT measures its interval from the previous time that it was called and minor adjustments are automatically made to ensure that the number of times a loop is repeated is correct overall.
* Loop cycle rates of 1000 or less can **significantly reduce CPU usage** in programs.
* Do not use it to limit a loop to **less than once every 60 seconds**(.0167) or an [ERROR Codes](ERROR-Codes) will occur.
* Do not use _LIMIT as a timing delay outside of loops. Use [_DELAY](_DELAY) instead.
* Use _LIMIT to slow down old QBasic program loops that run too fast and use too much CPU.

## Example(s)

Limits loop execution to 30 frames per second and limits the program's CPU usage.

```vb

PRINT "To Quit press ESC key!"
DO
   _LIMIT 30
   PRINT CHR$(26);
   IF INKEY$ = CHR$(27) THEN EXIT DO 
LOOP 

```

```text

To Quit press ESC key!
→→→→→→→→→→→→→→→→→→→→

```

> *Note:* In the above example, _LIMIT has to be within the loop.

## See Also

* [_DELAY](_DELAY)
* [TIMER](TIMER), [ON TIMER(n)](ON-TIMER(n))
* [SLEEP](SLEEP)
