**$IF** is precompiler [Metacommand](Metacommand), which determines which sections of code inside its blocks are included into the final code for compliing.

## Syntax

> [$IF]($IF) variable = expression THEN
> .
> [$ELSEIF]($ELSEIF) variable = expression THEN
> .
> [$ELSE]($ELSE)
> .
> [$END IF]($END-IF)

* $IF is the start of a precompiler code block which includes or excludes sections of code from being compiled.
* There is no single line $IF statement.  $IF must be in a valid $IF THEN...$END IF block to work properly.
* Like all other metacommands, you can not use more than one metacommand per line. **Use of : to separate statements in a single line is not allowed.**
* Variable names can contain numbers, letters and periods, in any order.
* Expressions can contain one set of leading and/or trailing quotes; and any number of numbers, letters and periods, in any order.
* The precompiler comes with some preset values which can be used to help determine which code blocks to include/exclude.  These are:
  * **WIN** or **WINDOWS** if the user is running QB64 in a Windows environment.
  * **LINUX** if the user is running QB64 in a Linux environment.
  * **MAC** or **MACOSX** if the user is running QB64 in a macOS environment.
  * **32BIT** if the user is running a 32-bit version of QB64.
  * **64BIT** if the user is running a 64-bit version of QB64.
  * **VERSION**, which is set to the version of the QB64 compiler. This is a number and can be ordered, see example below.
* Special values **DEFINED** and **UNDEFINED** can be used to check whether a precompiler variable has already been assigned a value. Useful for code in libraries which may be repeated.
* [$END IF]($END-IF) denotes the end of a valid precompiler $IF block.
* [$ELSEIF]($ELSEIF) must follow a valid $IF or $ELSEIF statement.
* If [$ELSE]($ELSE) is used, it must be used as the last conditional check before $END IF.  $ELSEIF cannot come after $ELSE.
  * There can only be one $ELSE in an **$IF-$ELSEIF-$ELSE-$END IF** block, and it must be the last block selection before the $END IF.  $ELSEIF cannot follow $ELSE.

## Example(s)

```vb

$LET ScreenMode = 32
$IF ScreenMode = 0 THEN
    CONST Red = 4
$ELSEIF ScreenMode = 32 THEN
    CONST Red = _RGB32(255,0,0)
$END IF

COLOR Red
PRINT "Hello World"

```

*Explanation:* The same CONST is defined twice inside the program.  Normally, defining a CONST more than once generates an error, but the $IF condition here is choosing which CONST will be inside the final program.

As long as Screenmode is 0, the program will exclude the code where CONST Red is defined as color 4.  If Screenmode is 32, CONST Red will be defined as _RGB32(255, 0, 0).

The [$LET]($LET) and $IF statements let the programmer control the code that actually gets compiled, while excluding the other blocks completely.

```vb

$IF WIN THEN
    CONST Slash = "\"
$ELSE
    CONST Slash = "/"
$END IF

PRINT "The proper slash for your operating system is "; Slash

```

*Explanation:* For the above, the CONST slash is defined by the automatic internal flags which returns what operating system is being used at compile time. On a Windows PC, the Slash will be the backslash; for any other OS it will be the forward slash.

```vb

$IF VERSION < 1.5 THEN
    $ERROR Requires QB64 version 1.5 or greater
$END IF

```

*Explanation:* VERSION is a predefined variable that holds the QB64 compiler version. If we know our program needs features only available above a certain version, we can check for that and give the user a helpful error message instead of a confusing error elsewhere in the program.

## See Also

* [$LET]($LET)
* [$ERROR]($ERROR)
* [Metacommand](Metacommand)s
