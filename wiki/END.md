The [END](END) statement terminates a program without an immediate exit or ends a procedure or statement block. 

## Syntax

>  [END](END) [returnCode%]
>
> [END](END) [IF](IF...THEN)
>
>  [END](END) [TYPE](TYPE)
>
>  [END](END) [SELECT](SELECT-CASE)
>
>  [END](END) [SUB](SUB)
>
>  [END](END) [FUNCTION](FUNCTION)
>
>  [END DECLARE](DECLARE-LIBRARY)

## Description

* In **QB64**, [END](END) can be followed by a code that can be read by another module using the [SHELL (function)](SHELL-(function)) or [_SHELLHIDE](_SHELLHIDE) function (known as [https://blogs.msdn.microsoft.com/oldnewthing/20080926-00/?p=20743 **errorlevel**])
* When END is used to end a program, there is a pause and the message "Press any key to continue..." is displayed at the bottom of the program's window.
* If the program does not use END or [SYSTEM](SYSTEM), the program will still end with a pause and display "Press any key to continue...".
* In **QB64**, [SYSTEM](SYSTEM) will end the program immediately and close the window.
* The **QB64** [_EXIT (function)](_EXIT-(function)) can block a user's Ctrl + Break key presses and clicks on the window's close button (X button) until the program is ready to close.

## Example(s)

In QB64 you won't return to the IDE unless you are using it to run or edit the program module.

```vb

PRINT "Hello world!"
END
PRINT "Hello no one!" 

```

*Returns:*

```text

Hello world!

Press any key to continue...

```

> *Explanation:*"Hello no one!" isn't returned because the program ended with the END statement no matter what is after that.
> The message "Press any key to continue..." is displayed after the program ends, both in QBasic and in **QB64**.

## See Also

* [SYSTEM](SYSTEM) (immediate exit)
* [SHELL (function)](SHELL-(function)), [_SHELLHIDE](_SHELLHIDE)
* [EXIT](EXIT) (statement), [_EXIT (function)](_EXIT-(function))
