**Scientific notation** or [^](^) notation is used to express very large or small numerical values by [SINGLE](SINGLE) or [DOUBLE](DOUBLE) accuracy.

## Usage

> -9.7587E+04 or 4.6545D-9

* **E** denotes [SINGLE](SINGLE) precision accuracy and **D** denotes [DOUBLE](DOUBLE) precision accuracy in QBasic. D and E are considered numbers!
* To translate the notation, multiply the number preceding the letter by the value of 10 raised to the power following the letter. 
* [PRINT USING](PRINT-USING) can display the normal numerical values. You will have to use less digits than the real value.
* **Note:** Naturally numerically calculating the value in QBasic would return the same value!
* [INPUT](INPUT) WILL accept the letter E with [SINGLE](SINGLE) or [DOUBLE](DOUBLE) variables while D can only be used with [DOUBLE](DOUBLE) variables.

*Sample 1:* +2.184D+3 means to multiply 2.184 by 1,000 (1,000 is 10 raised to the third power, or 10 [^](^) 3 ).

>  To multiply by 10 raised to a positive power, just move the decimal point to the right by 3.

>  The result is 2184 in DOUBLE accuracy.

*Sample 2:* -5.412D-2 is negative 5.412 times .01 (10 raised to the -2 power or 10 [^](^) -2 ).

>  To multiply a number by 10 raised to a negative power, just move the decimal point to the left by 2.

>  The result is -.05412 in DOUBLE accuracy.

*Sample 3:* 3.07E+12 is a positive 3.07 times 1,000,000,000,000 (10 raised to the 12 power or 10 [^](^) 12).

>  To multiply a number by 10 raised to a positive power, just move the decimal point to the right by 12.

>  The result is 3,070,000,000,000 in SINGLE accuracy.

## Example(s)

A string function that displays extremely small or large exponential decimal values.

```vb

num# = -2.34D-15
PRINT num#
PRINT StrNum$(num#)
END

FUNCTION StrNum$ (n#)
value$ = UCASE$(LTRIM$(STR$(n#)))
Xpos% = INSTR(value$, "D") + INSTR(value$, "E")  'only D or E can be present
IF Xpos% THEN
  expo% = VAL(MID$(value$, Xpos% + 1))
  IF VAL(value$) < 0 THEN
    sign$ = "-": valu$ = MID$(value$, 2, Xpos% - 2)
  ELSE valu$ = MID$(value$, 1, Xpos% - 1)
  END IF
  dot% = INSTR(valu$, "."): L% = LEN(valu$)
  IF expo% > 0 THEN add$ = STRING$(expo% - (L% - dot%), "0")
  IF expo% < 0 THEN min$ = STRING$(ABS(expo%) - (dot% - 1), "0"): DP$ = "."
  FOR n = 1 TO L%
    IF MID$(valu$, n, 1) <> "." THEN num$ = num$ + MID$(valu$, n, 1)
  NEXT
ELSE StrNum$ = value$: EXIT FUNCTION
END IF
StrNum$ = sign$ + DP$ + min$ + num$ + add$
END FUNCTION 

```
<sub>Code by Ted Weissgerber</sub>

```text

 -2.34D-15
 -.00000000000000234

```

## See Also

* [^](^)
* [SINGLE](SINGLE), [DOUBLE](DOUBLE)
