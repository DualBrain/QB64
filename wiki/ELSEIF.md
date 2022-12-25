[ELSEIF](ELSEIF) is used in an [IF...THEN](IF...THEN) block statement to offer an alternative condition.

## Syntax

> [IF](IF) condition [THEN](THEN)
>
>>   *{code}*
>>
>>   ⋮
>
> [ELSEIF](ELSEIF) condition2 [THEN](THEN)~
>
>>   *{code}*
>>
>>   ⋮
>
> [ELSE](ELSE)
>
>>   *{alternative-code}*
>>
>>   ⋮
>
> [END IF](END-IF)

## Description

* ELSEIF statements require a **separate** code block line with [THEN](THEN) for each alternative condition.
* There can be more than one [ELSE](ELSE) IF statement in a single-line IF statement.
* If there is only one possible alternative condition (such as 0 or [NOT](NOT) 0), use [ELSE](ELSE) instead.
* If the comparisons are based on multiple conditions being true, it may require many ELSEIF comparisons. ELSE could help cover some of those conditions.
* You can use [SELECT CASE](SELECT-CASE) when IF blocks have a long list of alterative ELSEIF conditions.

**Relational Operators:**

| Symbol | Condition | Example Usage |
| -- | -- | -- |
| = | Equal | IF a = b THEN |
| <> | NOT equal | IF a <> b THEN |
| < | Less than | IF a < b THEN |
| > | Greater than | IF a > b THEN |
| <= | Less than or equal | IF a <= b THEN |
| >= | Greater than or equal | IF a >= b THEN |

## Example(s)

IF statement using ELSE IF in one statement line.

```vb

IF x = 100 THEN COLOR 10: PRINT x ELSE IF x > 100 THEN COLOR 12: PRINT x ELSE PRINT "< 100"


```

IF statement block

```vb

IF x = 100 THEN ' must place ANY code on next line!
  COLOR 10: PRINT x
ELSEIF x > 100 THEN COLOR 12: PRINT x
ELSE : PRINT "< 100"
END IF


```

## See Also

*[ELSE](ELSE), [END IF](END-IF)
*[IF...THEN](IF...THEN)
