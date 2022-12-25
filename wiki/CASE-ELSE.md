See [SELECT CASE](SELECT-CASE).

[CASE ELSE](CASE-ELSE) is used in a [SELECT CASE](SELECT-CASE) procedure as an alternative if no other [CASE](CASE) statements are true.

## Description

* [CASE ELSE](CASE-ELSE) should be listed at the bottom of the case list as it will supersede any case statements after it.
* Use it as a "safety net" or as an alternative for all values not covered in the [CASE](CASE) statements.

## Example(s)

```vb

a = 100
SELECT CASE a
CASE IS < 99: PRINT "a is < 99"
CASE 99: PRINT "a is 99"
CASE IS > 100: PRINT "a is > 100"
CASE ELSE
PRINT "a is 100"
END SELECT


```

```text

a is 100


```

```vb

a = 100
SELECT CASE a
CASE 10: PRINT "a is 10"
CASE 20: PRINT "a is 20"
CASE 30: PRINT "a is 30"
CASE ELSE: PRINT "a is something other than 10, 20 and 30"
END SELECT


```

```text

a is something other than 10, 20 and 30


```

## See Also

* [SELECT CASE](SELECT-CASE)
* [IF...THEN](IF...THEN), [ELSE](ELSE)
