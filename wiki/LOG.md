The [LOG](LOG) math function returns the natural logarithm of a specified numerical value.

## Syntax

> logarithm! = [LOG](LOG)(value)

## Description

* value MUST be greater than 0. [ERROR Codes](ERROR-Codes) occurs if negative or zero values are used.
* The natural logarithm is the logarithm to the base **e = 2.718282** (approximately).
* The natural logarithm of *a* is defined as the integral from 1 to *a* of dx/x.
* Returns are default [SINGLE](SINGLE) precision unless the value parameter uses [DOUBLE](DOUBLE) precision.

## Example(s)

[FUNCTION](FUNCTION) to find the base ten logarithm of a numerical value.

```vb

 FUNCTION Log10#(value AS DOUBLE) STATIC
   Log10# = LOG(value) / LOG(10.#) 
 END FUNCTION 

```

> *Explanation:* The natural logarithm of the value is divided by the base 10 logarithm. The LOG of ten is designated as a DOUBLE precision return by using # after the Log10 value. The return tells you the number of times 10 goes into a value.

A binary FUNCTION to convert [INTEGER](INTEGER) values using LOG to find the number of digits the return will be.

```vb

FUNCTION BIN$ (n&)
  IF n& < 0 THEN EXIT FUNCTION            'positive numbers only! negative error!
  FOR p% = 0 TO INT(LOG(n& + .1) / LOG(2))     ' added +.1 to get 0 to work
    IF n& AND 2 ^ p% THEN s$ = "1" + s$ ELSE s$ = "0" + s$  'find bits on
  NEXT p%
  IF s$ = "" THEN BIN$ = "&B0" ELSE BIN$ = "&B" + s$       'check for zero return
END FUNCTION


```

> *Explanation:* The LOG of a **positive** [INTEGER](INTEGER) value is divided by the LOG of 2 to determine the number of binary digits that will be returned. The FOR loop compares the value with the exponents of two and determines if a bit is ON or OFF as "1" or "0". 

## See Also

*[EXP](EXP), [&B](&B) (binary number)
