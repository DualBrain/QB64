[REM](REM) allows explanatory comments, or remarks, to be inserted in a program.  [REM](REM) statements extend to the end of the line and the text is ignored when the program is run.

## Syntax

> [REM](REM) this is a comment
> [apostrophe](apostrophe) this is also a comment

## Description

* [REM](REM) may only be used where statements are allowed unlike [apostrophe](apostrophe) comments which may be included anywhere.
* [REM](REM) must appear as the last, or only, statement on a line.  Any following statements are included in the comment text and ignored.
* QBasic [metacommand](metacommand)s like [$INCLUDE]($INCLUDE) must be included in a comment using either [REM](REM) or [apostrophe](apostrophe).
* [Apostrophe](Apostrophe) comments, unavailable in earlier dialects of the BASIC language, are now generally favored over [REM](REM) statements for their greater flexibility.
* Comments are also useful for disabling code for program testing and debugging purposes.

## Example(s)

Avoiding an [END IF](END-IF) error.

```vb

REM This is a remark...
' This is also a remark...
IF a = 0 THEN REM this statement is executed so this is a single-line IF statement
IF a = 0 THEN ' this comment is not executed so this is a multi-line IF statement and END IF is required
END IF 

```

## See Also
 
* [Apostrophe](Apostrophe)
* [$DYNAMIC]($DYNAMIC), [$STATIC]($STATIC), [$INCLUDE]($INCLUDE)
