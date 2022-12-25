The **apostrophe** allows explanatory comments, or remarks, to be inserted in a program.  These may be included anywhere in the source code and extend to the end of the line.  Comments are ignored when the program is run.

## Syntax

> [apostrophe](apostrophe) this is a comment
> [REM](REM) this is also a comment

## Description

* [REM](REM) can also be used to insert comments but may only be used as the last, or only, statement on a line.
* QBasic [metacommand](metacommand)s like [$INCLUDE]($INCLUDE) must be included in a comment using either [REM](REM) or [apostrophe](apostrophe).
* [Apostrophe](Apostrophe) comments, unavailable in earlier dialects of the BASIC language, are now generally favored over [REM](REM) statements for their greater flexibility.
* Comments are also useful for disabling code for program testing and debugging purposes.

## Example(s)

```vb

COLOR 11: PRINT "Print this...." ' PRINT "Don't print this program comment!"

```

```text

Print this....

```

## See Also

* [REM](REM)
* [$DYNAMIC]($DYNAMIC), [$STATIC]($STATIC), [$INCLUDE]($INCLUDE)
