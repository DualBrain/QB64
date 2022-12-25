**Boolean** statements are numerical evaluations that return True (-1 or NOT 0) or False (0) values that can be used in other calculations.

*Basic Returns:*

* True evaluations return -1. [NOT](NOT) 0 = -1 in Basic. Can be used to increment a value.
* For positive True results, subtract it, multiply it by a negative value or use [ABS](ABS).
* False evaluations return 0. Watch out for [ERROR Codes](ERROR-Codes)!

MISSING: Relational Table

* When evaluating a True value, an IF value < 0 statement is NOT necessary for return values not 0.

** Truth table of the BASIC Logical Operators:**

MISSING: Logical Truth Table

**Boolean Conditional Operators:**

* [AND (boolean)](AND-(boolean)) can be used to add extra conditions to a boolean statement evaluation. Both must be True.
* [OR (boolean)](OR-(boolean)) can be used to add alternate conditions to a boolean statement evaluation. One must be True.
* Parenthesis are allowed inside of boolean statements to clarify an evaluation.
* **Note that Basic returns -1 for True and 0 for False.**

Using 2 different boolean evaluations to determine a leap year.

```vb

 INPUT "Enter a year greater than 1583: ", annum$
 Y = VAL(annum$)
 leap1 = (Y MOD 4 = 0 AND Y MOD 100 <> 0) OR (Y MOD 400 = 0)
 leap2 = (Y MOD 4 = 0) - (Y MOD 100 = 0) + (Y MOD 400 = 0)
 PRINT "Year = "; annum$, "Leap1 = "; leap1, "Leap2 = "; leap2 

```

*Explanation:* Both boolean evaluations will return -1 if the year is a leap year. It is not simply every four years as many people think. That is checked by the first evaluation (Y MOD 4 = 0) of each. In new century years like 1900 (which was not a leapyear) there is only one leap year every 400 years. 100 is used with [MOD](MOD) to see if there is a remainder. When that is true, the boolean return of that part of the first evaluation will be 0. The second returns -1 (which is actually added). In both evaluations the result of (Y MOD 400 = 0) indicates a century leap year. 

Entry year = 2000

> leap1 = (-1 AND 0) OR -1 = -1 ' the AND evaluation returns False(0) so the OR value is used.

> leap2 = (-1) - (-1) + (-1) = -1 + 1 + -1 = -1

Entry year = 1900

>  leap1 = (-1 AND 0) OR 0 = 0 OR 0 = 0

>  leap2 = (-1) - (-1) + (0) = -1 + 1 + 0 = 0

Moving an [ASCII](ASCII) character using the arrow keys and boolean statements to determine the new coordinate.

```vb

SCREEN 12
COLOR 7
LOCATE 11, 20: PRINT "Using Screen 12 here to be in 80 X 30 coordinates mode"
LOCATE 13, 6: PRINT "Simple Example of Alternative programming without IF-THEN-ELSE Statements"
LOCATE 15, 1: PRINT "Use the four Cursor keys to move the yellow cursor, text will not be disturbed"
LOCATE 17, 12: PRINT "When you END the program with the ESC key, cursor will disappear"

cordx% = 40
cordy% = 15

DO
oldcordx% = cordx%
oldcordy% = cordy%
p% = SCREEN(cordy%, cordx%) 'get ASCII character code at present position
COLOR 14: LOCATE cordy%, cordx%: PRINT CHR$(178); 'print cursor character to position

WHILE cordx% = oldcordx% AND cordy% = oldcordy% AND k$ <> CHR$(27)
k$ = INKEY$
cordx% = cordx% + (k$ = (CHR$(0) + "K") AND cordx% > 1) + ABS(k$ = (CHR$(0) + "M") AND cordx% < 80)
cordy% = cordy% + (k$ = (CHR$(0) + "H") AND cordy% > 1) + ABS(k$ = (CHR$(0) + "P") AND cordy% < 30)
WEND

COLOR 7: LOCATE oldcordy%, oldcordx%: PRINT CHR$(p%); 'replace overwritten screen characters

LOOP UNTIL k$ = CHR$(27) 

```
<sub>Code by AlgoreIthm</sub>

## See Also
 
* [IF...THEN](IF...THEN), [SELECT CASE](SELECT-CASE)
* [Binary](Binary), [ABS](ABS), [SGN](SGN)
* [AND](AND), [OR](OR), [XOR](XOR)
