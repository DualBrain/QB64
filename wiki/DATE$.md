The [DATE$](DATE$) function returns the current computer date as a string in the format "mm-dd-yyyy".

## Syntax

> today$ = [DATE$](DATE$)

## Description

* Returns the current computer date in the format "mm-dd-yyyy" (e.g., "12-25-2009").

## Example(s)

Displaying the weekday and current date.

```vb

PRINT DATE$ 
month$ = LEFT$(DATE$, 2): M = VAL(month$)
day$ = MID$(DATE$, 4, 2): D = VAL(day$)
day$ = STR$(D)                  ' eliminate any leading zeros
year$ = RIGHT$(DATE$, 4): Y = VAL(year$)
SELECT CASE M
   CASE 1: Moon$ = "January"
   CASE 2: Moon$ = "February"
   CASE 3: Moon$ = "March"
   CASE 4: Moon$ = "April"
   CASE 5: Moon$ = "May"
   CASE 6: Moon$ = "June"
   CASE 7: Moon$ = "July"
   CASE 8: Moon$ = "August"
   CASE 9: Moon$ = "September"
   CASE 10: Moon$ = "October"
   CASE 11: Moon$ = "November"
   CASE 12: Moon$ = "December"
END SELECT
PRINT "Today is " + WeekDay$(M, D, Y) + ", " + Moon$ + day$ + ", " + year$ + SPACE$(10)

DEFINT A-Z
FUNCTION WeekDay$ (M, D, Y)          
IF M < 3 THEN M = M + 12: Y = Y - 1  'add 12 to Jan - Feb month, -1 year
C = Y \ 100: Y = Y MOD 100           'split century and year number
S1 = (C \ 4) - (2 * C) - 1           'century leap
S2 = (5 * Y) \ 4                     '4 year leap
S3 = 26 * (M + 1) \ 10               'days in months
WkDay = (S1 + S2 + S3 + D) MOD 7     'weekday total remainder 
IF WkDay < 0 THEN WkDay = WkDay + 7  'Adjust negative results to 0 to 6
SELECT CASE WkDay
   CASE 0: day$ = "Sunday"
   CASE 1: day$ = "Monday"
   CASE 2: day$ = "Tuesday"
   CASE 3: day$ = "Wednesday"
   CASE 4: day$ = "Thursday"
   CASE 5: day$ = "Friday"
   CASE 6: day$ = "Saturday"
END SELECT
WeekDay$ = day$
END FUNCTION 

```

```text

06-02-2010
Today is Wednesday, June 2, 2010

```

## See Also

* [TIME$](TIME$)
* [VAL](VAL), [STR$](STR$), [MID$](MID$), [LEFT$](LEFT$), [IF...THEN](IF...THEN)
