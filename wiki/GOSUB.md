[GOSUB](GOSUB) sends the program flow to a sub procedure identified by a line number or label.

## Syntax

> GOSUB {lineNumber|label}

## Description

* Use [RETURN](RETURN) in a sub procedure to return to the next line of code after the original [GOSUB](GOSUB) call. [END](END) or [SYSTEM](SYSTEM) can also be used to end program.
* GOSUB and GOTO can be used **within** [SUB](SUB) or [FUNCTION](FUNCTION) procedures, but cannot refer to a label located outside the procedure.

## QBasic

* Too many GOSUBs without a [RETURN](RETURN) can eventually cause "Out of Stack Errors" in QBasic as each GOSUB uses memory to store the location to return to. Each [RETURN](RETURN) frees the memory of the GOSUB it returns to.

## Example(s)

Simple usage of GOSUB

```vb

PRINT "1. It goes to the subroutine."
GOSUB subroutine
PRINT "3. And it returns."
END

subroutine:
PRINT "2. It is at the subroutine."
RETURN


```

```text

1. It goes to the subroutine.
2. It is at the subroutine.
3. And it returns.

```

What happens if two GOSUB executes then two RETURN's?

```vb

start: 
 
a = a + 1 
IF a = 1 THEN GOSUB here: PRINT "It returned to IF a = 1": END 
IF a = 2 THEN GOSUB there: PRINT "It returned to IF a = 2": RETURN

here: 
PRINT "It went here." 
GOTO start

there: 
PRINT "It went there." 
RETURN 

```

```text

It went here.
It went there.
It returned to IF a = 2
It returned to IF a = 1

```

*Explanation:* When a = 1 it uses GOSUB to go to "here:", then it uses GOTO to go back to "start:". a is increased by one so when a = 2 it uses GOSUB to go to "there:", and uses RETURN to go the last GOSUB (which is on the IF a = 2 line), it then encounters another RETURN which makes it return to the first GOSUB call we used on the IF a = 1 line.

## See Also

* [ON...GOSUB](ON...GOSUB)
* [ON...GOTO](ON...GOTO), [GOTO](GOTO)
* [ON ERROR](ON-ERROR), [RESUME](RESUME)
* [ON TIMER (n)](ON-TIMER-(n))
* [Line number](Line-number)
