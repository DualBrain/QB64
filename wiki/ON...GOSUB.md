[ON...GOSUB](ON...GOSUB) is a control-flow statement that branches to a line or label in a list depending on a numerical expression.

## Syntax

> **ON** numericalExpression [GOSUB](GOSUB) labelOrNumber[,labelOrNumber][,...]

## Description

* numericalExpression represents the *line* or *label* that the program should branch to: 1 branches to the first line or label in the list, 2 branches to the second, etc.
* The procedure must be used after the number value is determined or in a loop to monitor current user events.
* [RETURN](RETURN) returns to the next code statement after the [ON...GOSUB](ON...GOSUB) statement. [END](END) or [SYSTEM](SYSTEM) can be used to end program.
* **Note:** [SELECT CASE](SELECT-CASE) provides a much more convenient way of doing this task.

## QBasic

* In QuickBASIC 4.5 the list could contain a maximum of 60 line numbers or labels, while **QB64** has no limit.

## Example(s)

```vb

CLS
a = 2
*ON* a **GOSUB** hello, hereweare, 143
PRINT "Also notice the RETURN statement that can be used with GOSUB!"
END

hello:
PRINT "Hello, with a = 1 you get to see this!"
END

hereweare:
PRINT "with a = 2 here we are...return to line after ON."
RETURN

143
PRINT "Line 143, with a = 3 you get to see this!"
END 

```

```text

with a = 2 here we are...return to line after ON.
Also notice the RETURN statement that can be used with GOSUB!

```

> *Explanation:* Since *a* equals to 2 it goes to the second item in the list (*hereweare*) and branches the program to there. Try changing 'a' to 1 or 3.

## See Also

* [ON...GOTO](ON...GOTO)
* [GOSUB](GOSUB), [GOTO](GOTO) 
* [SELECT CASE](SELECT-CASE), [RETURN](RETURN)
