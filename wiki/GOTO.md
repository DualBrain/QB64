The [GOTO](GOTO) statement sends the procedure to a line label or a line number in the program.

## Syntax
 
> [GOTO](GOTO) {*lineNumber*|*lineLabel*}

*[IF](IF) Syntax:*

> IF condition [GOTO](GOTO) {*lineNumber*|*lineLabel*}
>
> IF condition THEN [GOTO](GOTO) {*lineNumber*|*lineLabel*}
>
> IF condition THEN *lineNumber* ' GOTO may be omitted when line numbers are used

## Description

* *lineNumber* or *lineLabel* must already exist or an IDE status error will be displayed until it is created.
* Can be used in [SUB](SUB) or [FUNCTION](FUNCTION) procedures using their own line labels or numbers.
* The frequent use of GOTO statements can become confusing when trying to follow the code and it could also cause endless loops.
* [GOTO](GOTO) is an easy trap for new programmers. Use loops instead when possible.

## Example(s)

```vb

1 PRINT "first line": GOTO gohere
2 PRINT "second line": GOTO 3

gohere:
PRINT "third line"
GOTO 2

3 END 

```

```text

first line
third line
second line

```

> *Explanation:* After it prints "first line" it goes to the line label "gohere" where it prints "third line", then it goes to the line that is numbered "2" and prints "second line" and goes to line number 3 and an [END](END) statement which ends the program.

## See Also

* [GOSUB](GOSUB), [ON ERROR](ON-ERROR)
* [ON...GOTO](ON...GOTO), [ON...GOSUB](ON...GOSUB)
* [DO...LOOP](DO...LOOP), [FOR...NEXT](FOR...NEXT)
* [IF...THEN](IF...THEN), [SELECT CASE](SELECT-CASE) 
* [Line number](Line-number)
