The STATIC keyword is used in declaration statements to control where variables are stored.

## Syntax

> STATIC variableName[()] [AS dataType][, ...]
> STATIC [AS dataType] variableName[()][, ...]

## Syntax

> {[SUB](SUB)|[FUNCTION](FUNCTION)} procedureName [(parameterList)] STATIC

## Description

* A STATIC list can be used in [SUB](SUB) and [FUNCTION](FUNCTION) procedures to designate one or more variables to retain their values. 
* Variables and arrays with static storage will retain their values in between procedure calls. The values may also be used recursively.
  * variableName may include a type suffix or use [AS](AS) to specify a type other than the default [SINGLE](SINGLE) type.
  * Arrays with static storage are declared by specifying empty parenthesis following the array name. See [Arrays](Arrays)
* STATIC can be used after the name of a [SUB](SUB) or [FUNCTION](FUNCTION) in the procedure to force all variables to retain their values.
* **Recursive procedures may be required to be STATIC to avoid a Stack Overflow error. QB64 programs may just close.**
* [$STATIC]($STATIC) defined program [arrays](arrays) cannot be [REDIM](REDIM) or use [_PRESERVE](_PRESERVE).

## Example(s)

*Example 1: Finding the binary bit settings from a 32 bit [LONG](LONG) register return using recursion.

```vb

INPUT "Enter a numerical value to see binary value: ", num&
PRINT Bin$(num&)

END

FUNCTION Bin$ (n&) STATIC 'comment out STATIC to see what happens!
  DIM p%, s$
  IF 2 ^ p% > n& THEN
    p% = 0
  ELSE
    IF n& AND 2 ^ p% THEN s$ = "1" + s$ ELSE s$ = "0" + s$
    IF n& > 2 ^ p% THEN
      p% = p% + 1
      s$ = Bin$(n&) 'recursive call to itself
    ELSE: p% = 0
    END IF
  END IF
  IF s$ = "" THEN Bin$ = "0" ELSE Bin$ = s$
END FUNCTION 

```

> *Explanation:* The [FUNCTION](FUNCTION) above returns a [STRING](STRING) value representing the bits ON in an [INTEGER](INTEGER) value. The string can be printed to the screen to see what is happening in a port register. **STATIC** keeps the function from overloading the memory "Stack" and is normally REQUIRED when recursive calls are used in QBasic! **QB64 procedures will close without warning or error!**

Using a static array to cache factorials, speeding up repeated calculations:

```vb

PRINT Factorial(0)
PRINT Factorial(5)
PRINT Factorial(50)

FUNCTION Factorial# ( n AS DOUBLE )
    CONST maxNToCache = 50
    STATIC resultCache() AS DOUBLE
    STATIC firstCall AS INTEGER
    
    ' The lookup table is initially empty, so re-size it..
    IF firstCall = 0 THEN
        firstCall = -1
        REDIM resultCache(maxNToCache) AS DOUBLE
        
        ' ..and pre-calculate some factorials.
        resultCache(0) = 1
        resultCache(1) = 1
        resultCache(2) = 2
    END IF
    
    ' See if we have the result cached. If so, we're done.
    IF n <= maxNToCache THEN
        IF resultCache(n) <> 0 THEN
            Factorial = resultCache(n)
            EXIT FUNCTION
        END IF
    END IF
    
    ' If not, we use recursion to calculate the result, then cache it for later use:
    resultCache(n) = INT(n) * Factorial(INT(n) - 1)
    Factorial = resultCache(n)
END FUNCTION


```

```text

 1
 120
 3.041409320171338D+64

```

## See Also

* [DIM](DIM), [REDIM](REDIM), [COMMON](COMMON)
* [SUB](SUB), [FUNCTION](FUNCTION)
* [TYPE](TYPE), [Arrays](Arrays)
* [$STATIC]($STATIC), [$DYNAMIC]($DYNAMIC) ([Metacommand](Metacommand)s)
* [Data types](Data-types)
