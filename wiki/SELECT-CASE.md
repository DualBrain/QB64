[SELECT CASE](SELECT-CASE) is used to determine the program flow by comparing the value of a variable to specific CASE values.

## Syntax

> **SELECT** [EVERY]**CASE** testExpression
>
>   **CASE** expressionList1
>
>     [statement-block1]
>
>   [**CASE** expressionList2
>
>     [statement-block2]]...
>
>   [**CASE ELSE**
>
>     [statementblock-n]]
>
> **END SELECT** 

## Description

* **SELECT CASE** evaluates testExpression and executes the first matching [CASE](CASE) or [CASE ELSE](CASE-ELSE) block and exits.
* **SELECT EVERYCASE** allows the execution of all matching [CASE](CASE) blocks from top to bottom or the [CASE ELSE](CASE-ELSE) block.
* The literal, variable or expression testExpression comparison can result in any string or numerical type. 
* **Note:** A testExpression variable value can be changed inside of true CASE evaluations in SELECT EVERYCASE. 
* A testExpression derived from an expression or [FUNCTION](FUNCTION) will only be determined once at the start of the block execution.
* <span id="allCASES">Supports individual CASE values and ranges or lists of literal values as below:</span>
  * **CASE** casevalue: code **'case compares one numerical or text value**
  * **CASE** casevalue1 [TO](TO) casevalue2: code **'case compares a range of values **
  * **CASE** casevalue1, casevalue2, casevalue3: code **'case compares a list of values separated by commas**
  * **CASE IS** > casevalue: code **'case compares a value as <nowiki> =, <>, < or > </nowiki>**
  * **CASE ELSE**: code **'bottom case statement executes only when no other CASE is executed.**
* The CASE values should cover the normal ranges of the comparison testExpression values. 
* Use **CASE ELSE** before **END SELECT** if an alternative is necessary when no other case matches.
* CASEs should be listed in an ascending or descending values for best and fastest results.
* [STRING](STRING) comparisons will be based on their respective [ASCII](ASCII) code values where capital letters are valued less than lower case.
* Use **SELECT CASE** when [IF...THEN](IF...THEN) statements get too long or complicated.
* **SELECT CASE** and **EVERYCASE** statement blocks must **always** be ended with [END SELECT](END-SELECT).
* Use **[colon](colon)s** to execute multiple statements in one line.
* An **[underscore](underscore)** can be used anywhere after the code on one line to continue it to the next line in **QB64**.

## Example(s)

SELECT CASE can use literal or variable [STRING](STRING) or numerical values in CASE comparisons:

```vb

INPUT "Enter a whole number value from 1 to 40: ", value
value1 = 10
value2 = 20
value3 = 30

SELECT CASE value
  CASE value1: PRINT "Ten only"
  CASE value1 TO value2: PRINT "11 to 20 only" '10 is already evaluated
  CASE value1, value2, value3: PRINT "30 only" '10 and 20 are already evaluated
  CASE IS > value2: PRINT "greater than 20 but not 30" '30 is already evaluated
  CASE ELSE: PRINT "Other value" 'values less than 10
END SELECT 

```

> *Explanation:* The first true CASE is executed and SELECT CASE is exited. "Other value" is printed for values less than 10.

SELECT CASE will execute the first CASE statement that is true and ignore all CASE evaluations after that:

```vb

a = 100
SELECT CASE a          'designate the value to compare
  CASE 1, 3, 5, 7, 9
    PRINT "This will not be shown."
  CASE 10
    PRINT "This will not be shown."
  CASE 50
    PRINT "This will not be shown."
  CASE 100
    PRINT "This will be displayed when a equals 100"
    PRINT "(and no other case will be checked)"
  CASE 150
    PRINT "This will not be shown."
  CASE IS < 150
    PRINT "This will not be shown as a previous case was true"
  CASE 50 TO 150
    PRINT "This will not be shown as a previous case was true"
  CASE ELSE
   PRINT "This will only print if it gets this far!"
END SELECT 

```

```text

This will be displayed when a equals 100
(and no other case will be checked)

```

> *Explanation:* The first case where a value is true is shown, the remainder are skipped. Try changing the value of *a*.

Same as Example 2 but, SELECT EVERYCASE will execute every CASE statement that is true.

```vb

a = 100
SELECT EVERYCASE a          'designate the value to compare
  CASE 1, 3, 5, 7, 9
    PRINT "This will not be shown."
  CASE 10
    PRINT "This will not be shown."
  CASE 50
    PRINT "This will not be shown."
  CASE 100
    PRINT "This will be displayed when a equals 100"
    PRINT "(and other cases will be checked)"
  CASE 150
    PRINT "This will not be shown."
  CASE IS < 150
    PRINT "This will be shown as 100 is less than 150"
  CASE 50 TO 150
    PRINT "This will be shown as 100 is between 50 and 150"
  CASE ELSE
   PRINT "This will only print if no other CASE is true!"
END SELECT 

```

```text

This will be displayed when a equals 100
(and other cases will be checked)
This will be shown as 100 is less than 150
This will be shown as 100 is between 50 and 150

```

> *Explanation:* [CASE ELSE](CASE-ELSE) will only execute if no other CASE was true. See Example 5 for more usages.

SELECT CASE evaluates string values by the [ASC](ASC) code value according to [ASCII](ASCII).

```vb

PRINT "Enter a letter, number or punctuation mark from the keyboard: ";
valu$ = INPUT$(1)
PRINT value$
value1$ = "A"
value2$ = "m"
value3$ = "z"

SELECT CASE value$
  CASE value1$: PRINT "A only"
  CASE value1$ TO value2$: PRINT "B to m" 'A is already evaluated
  CASE value1$, value2$, value3$: PRINT "z only" 'A and m are already evaluated
  CASE IS > value2$: PRINT "greater than m but not z" 'z is already evaluated
  CASE ELSE: PRINT "other value" 'key entry below A including all numbers
END SELECT 

```

> *Notes:* [STRING](STRING) values using multiple characters will be compared by the [ASCII](ASCII) code values sequentially from left to right. Once the equivalent code value of one string is larger than the other the evaluation stops. This allows string values to be compared and sorted alphabetically using [Greater Than](Greater-Than) or [Less Than](Less-Than) and to [SWAP](SWAP) values in [arrays](arrays) regardless of the string lengths.

EVERYCASE is used to draw sections of digital numbers in a simulated LED readout using numbers from 0 to 9:

```vb

SCREEN 12
DO
  LOCATE 1, 1: INPUT "Enter a number 0 to 9: ", num
  CLS
  SELECT EVERYCASE num
    CASE 0, 2, 3, 5 TO 9: PSET (20, 20), 12
      DRAW "E2R30F2G2L30H2BR5P12,12" 'top horiz
    CASE 0, 4 TO 6, 8, 9: PSET (20, 20), 12
      DRAW "F2D30G2H2U30E2BD5P12,12" 'left top vert
    CASE 0, 2, 6, 8: PSET (20, 54), 12
      DRAW "F2D30G2H2U30E2BD5P12, 12" 'left bot vert
    CASE 2 TO 6, 8, 9: PSET (20, 54), 12
      DRAW "E2R30F2G2L30H2BR5P12, 12" 'middle horiz
    CASE 0 TO 4, 7 TO 9: PSET (54, 20), 12
      DRAW "F2D30G2H2U30E2BD5P12,12" 'top right vert  
    CASE 0, 1, 3 TO 9: PSET (54, 54), 12
      DRAW "F2D30G2H2U30E2BD5P12,12" 'bottom right vert
    CASE 0, 2, 3, 5, 6, 8: PSET (20, 88), 12
      DRAW "E2R30F2G2L30H2BR5P12,12" 'bottom horiz
    CASE ELSE 
      LOCATE 20, 20: PRINT "Goodbye!"; num
  END SELECT
LOOP UNTIL num > 9 

```

> **Note:** [CASE ELSE](CASE-ELSE) will only execute if no other CASE is true! Changing the comparison value in a CASE may affect later CASE evaluations. **Beware of duplicate variables inside of cases affecting the comparison values and remaining cases.**

## See Also
 
* [IF...THEN](IF...THEN), [Boolean](Boolean)
