See [SELECT CASE](SELECT-CASE).

[CASE](CASE) is used within a [SELECT CASE](SELECT-CASE) block to specify a conditional value of the compared variable.

## Syntax

> [CASE](CASE) comparisonValues[:] {code}

## Description

*comparisonValues can be any literal string or number, depending on the value specified in the [SELECT CASE](SELECT-CASE) statement.
*Code is executed until the next case, so each case can handle multiple lines of code.
* [CASE](CASE) conditions are normally listed in some logical order going down the page.
* [CASE](CASE) order can affect the SELECT CASE code execution when more than one CASE can be true. This is specially true when multiple conditional operators, CASE IS or TO ranges are used.
* [CASE](CASE) lists can also be listed horizontally by using colon separators between cases.
* Supports individual CASE values and ranges or lists of values as below:
  * [CASE](CASE) value
  * [CASE](CASE) value1 [TO](TO) value2
  * [CASE](CASE) value1, value2, value3
  * [CASE IS](CASE-IS) value1 > value2
  * [CASE ELSE](CASE-ELSE)
* The first time a [CASE](CASE) value matches the compared variable's value, that [CASE](CASE) code is executed and [SELECT CASE](SELECT-CASE) is exited, unless **EVERYCASE** is used.

## Example(s)

```vb

a = 100
SELECT CASE a
   CASE 1, 3, 5, 7, 9: PRINT "Odd values under 10 will be shown."
   CASE 10: PRINT "10 will be shown."
   CASE 50: PRINT "50 will be shown."
   CASE 100: PRINT "This will be shown. (a is 100)"
             PRINT "(and this)"
   CASE 150: PRINT "150 will be shown."
   CASE IS < 150: PRINT "Less than 150 will be shown. (a which is 100 is under 150)"
   CASE 50 TO 150: PRINT "50 to 150 will be shown. (a which is 100 is between 50 TO 150)"
END SELECT


```

*Returns:*

```text

 This will be shown. (a is 100)
 (and this)


```

> *Explanation:* [SELECT CASE](SELECT-CASE) compares the variable's value to each descending CASE until ONE is true, executes the [CASE](CASE) code and exits the SELECT CASE. [CASE](CASE) statements should be placed in a increasing or decreasing order for the best results.

> What happens is that since 5 isn't 100 then the code until the next CASE is ignored, the same obviously goes for 10 and 50 but then comes 100 which is what a is so the code in that [CASE](CASE) is executed.

  * A [CASE](CASE) can list several values separated by commas for the same program option to be executed.

  * [CASE IS](CASE-IS) is used when we need to compare the value to a conditional expression range such as a value is "=" equal to, "<" less than, ">" greater than, "<>" not equal to or [NOT](NOT) a value.

  * A [CASE](CASE) range can be specified (in the example; 50 [TO](TO) 150) if needed.
*Note:* A [SELECT CASE](SELECT-CASE) block has to end with [END SELECT](END-SELECT).

## See Also

* [CASE ELSE](CASE-ELSE), [CASE IS](CASE-IS)
* [SELECT CASE](SELECT-CASE), [END SELECT](END-SELECT)
* [IF...THEN](IF...THEN)
