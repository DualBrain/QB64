[NEXT](NEXT) is used in a [FOR...NEXT](FOR...NEXT) counter loop to progress through the loop count.

## Syntax
 
> [FOR](FOR) counterVariable = startValue [TO](TO) stopValue [[STEP](STEP) increment]
>   *{code}*
>   ⋮
> [NEXT](NEXT) [counterVariable]

## Description

* [NEXT](NEXT) is required in a FOR loop or a [ERROR Codes](ERROR-Codes) will occur. 
* The FOR variable name is not required after [NEXT](NEXT).
* [NEXT](NEXT) can be grouped with other NEXTs in nested FOR loops using colons like [NEXT](NEXT): [NEXT](NEXT)
* [NEXT](NEXT) can also end more than one nested [FOR...NEXT](FOR...NEXT) loop using comma separated variables like [NEXT](NEXT) j, i
* [NEXT](NEXT) increases the FOR loop count, so after the loop is over the counterVariable's value will be stopValue + 1 (or stopValue + increment).
* [NEXT](NEXT)  is also used with the [RESUME](RESUME) statement.

## Example(s)

Finding the FOR variable value AFTER a simple counter loop to 10.

```vb

FOR i = 1 TO 10
  PRINT i;
NEXT i

PRINT "AFTER the LOOP, NEXT makes the value of i ="; i 

```

```text

1 2 3 4 5 6 7 8 9 10 AFTER the LOOP, NEXT makes the value of i = 11

```

*Result:* The last value of i = 11 although FOR only looped 10 times. **Only use the count values while inside of the loop or compensate for this behavior in your code.**

## See Also

* [FOR...NEXT](FOR...NEXT)
* [DO...LOOP](DO...LOOP)
* [RESUME](RESUME)
