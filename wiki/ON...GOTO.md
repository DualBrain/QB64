[ON...GOTO](ON...GOTO) is a control-flow statement that branches to a line or label in a list depending on a numerical expression.

## Syntax

> **ON** numericalExpression [GOTO](GOTO) labelOrNumber[,labelOrNumber][,...]

## Description

* numericalExpression represents the *line* or *label* that the program should branch to: 1 branches to the first line or label in the list, 2 branches to the second, etc.
* The procedure must be used after the number value is determined or in a loop to monitor current user events.
* **Note:** [SELECT CASE](SELECT-CASE) provides a much more convenient way of doing this task.

## QBasic

* In QuickBASIC 4.5 the list could contain a maximum of 60 line numbers or labels, while **QB64** has no limit.

## Example(s)

Changing the program flow when a value is not 0.

```vb

CLS
a = 2
ON a GOTO hello, hereweare, 143
END
hello:
PRINT "you don't get to see this!"
END
hereweare:
PRINT "And here we are..."
END
143
PRINT "you don't get to see this neither..."
END 

```

```text

And here we are...

```

*Explanation:* Since *a* equals 2 it goes to the second item in the list (hereweare) and branches to there. Try changing *a' to 1 or 3.

## See Also

* [ON...GOSUB](ON...GOSUB)
* [GOTO](GOTO)
* [GOSUB](GOSUB)
* [SELECT CASE](SELECT-CASE)
