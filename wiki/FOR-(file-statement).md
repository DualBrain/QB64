See [OPEN](OPEN).

[FOR](FOR-(file-statement)) is used in a [OPEN](OPEN) statement to indicate the file mode with which to open a file.

## Syntax

> [OPEN](OPEN) ... [FOR](FOR-(file-statement)) {APPEND|BINARY|INPUT|OUTPUT|RANDOM}

## Description

* If [FOR](FOR-(file-statement)) isn't used in an [OPEN](OPEN) statement, the default file mode RANDOM is used.
  * APPEND - Keeps the information of the file intact while you can insert information at the end of it, writing permission only.
  * BINARY - Opens the file in binary mode, use this with binary files.
  * INPUT - Opens the file for viewing only.
  * OUTPUT - The entire contents of the file is erased while you can put new information inside it, writing permission only.
  * RANDOM - The default, you can get/put records defined by a record length (the variables type or LEN=length).

## Example(s)

**Warning:** Make sure you don't have a file named test.tst before you run this or it will be overwritten.

```vb

CLS

OPEN "test.tst" FOR OUTPUT AS #1
PRINT #1, "If test.tst didn't exist:"
PRINT #1, "A new file was created named test.tst and then deleted."
PRINT #1, "If test.tst did exist:"
PRINT #1, "It was overwritten with this and deleted."
CLOSE #1

OPEN "test.tst" FOR INPUT AS #1
DO UNTIL EOF(1)
INPUT #1, a$
PRINT a$
LOOP
CLOSE #1

KILL "test.tst"

END


```

```text

If test.tst didn't exist:
A new file was created named test.tst and then deleted.
If test.tst did exist:
It was overwritten with this and deleted.

```

## See Also

* [OPEN](OPEN)
