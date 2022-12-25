An **underscore** can be used at the end of a line of code to continue a code line to the next line.

## Syntax

> IF x + y > 500 AND x + y < 600 THEN _
>   PRINT x + y

## Description

* The underscore can be anywhere after the code on that line to continue the code to the next line in QB64.
* Multiple underscores can be used for the same line of code.
* Comments cannot follow an underscore and are not continued on the next line if they end in an underscore.
* Modern QB64 keywords are preceded by an underscore, unless [$NOPREFIX]($NOPREFIX) is used. Variables and user procedures names cannot start with a single underscore.
  * Variables and user procedures names can be preceded by double underscores if necessary.
* Underscores can be used in the middle of variable, sub procedure or [CONST](CONST) names.
* In [PRINT USING](PRINT-USING) an underscore can precede a formatting character to display that character as literal text in a template [STRING](STRING).

## See Also

* [Colon](Colon), [Comma](Comma), [Semicolon](Semicolon)
* [IF...THEN](IF...THEN)
* [$NOPREFIX]($NOPREFIX)
