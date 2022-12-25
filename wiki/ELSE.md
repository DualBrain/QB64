[ELSE](ELSE) is used in [IF...THEN](IF...THEN) or [SELECT CASE](SELECT-CASE) statements to offer an alternative to other conditional statements.

## Syntax

*Single-line syntax:*
>  [IF](IF) condition [THEN](THEN) *{code}* [ELSE](ELSE) *{alternative-code}*

*Block syntax:*
> [IF](IF) condition [THEN](THEN)
>>   *{code}*
>>
>> ⋮
>>
> [ELSEIF](ELSEIF) condition2 [THEN](THEN)
>>   *{code}*
>>
>>   ⋮
>>
> [ELSE](ELSE)
>>   *{alternative-code}*
>>
>>   ⋮
>
> [END IF](END-IF)

## Description

* ELSE is used in a IF block statement to cover any remaining conditions not covered in the main block by IF or [ELSEIF](ELSEIF).
* [CASE ELSE](CASE-ELSE) covers any remaining conditions not covered by the other CASE statements.
* ELSE can also be used as a false comparison to a true IF statement when a condition will only be true or false.
* Other [IF...THEN](IF...THEN) statements can be inside of an ELSE statement.

## Example(s)

One line IF statement

```vb

IF x = 100 THEN PRINT "100" ELSE PRINT "Not 100"


```

Multiple line IF statement block

```vb

IF x = 100 THEN ' code executed MUST be on next statement line!
   PRINT "100"
ELSE PRINT "Not 100"
END IF


```

To alternate between any two values (as long as the value after ELSE is the same as the condition)

```vb

IF a = 3 THEN a = 5 ELSE a = 3


```

## See Also
 
* [ELSEIF](ELSEIF)
* [IF...THEN](IF...THEN)
