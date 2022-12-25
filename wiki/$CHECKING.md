The [$CHECKING]($CHECKING) metacommand turns C++ event checking ON or OFF.

## Syntax

>  [$CHECKING]($CHECKING):{ON|OFF}

## Description

* The Metacommand does **not** require a comment or REM before it. There is no space after the colon.
* The OFF action turns event checking off and should **only be used when running stable, errorless code.** 
* The default [$CHECKING]($CHECKING):ON action is only required when checking has been turned OFF previously.
* When [$CHECKING]($CHECKING):OFF is used, all error code and the reporting code is removed from the EXE program.
* **Warning: Turning OFF error checking could create a General Protection Fault (or segfault). Use only with 100% stable sections of code.**

### Details

* After every QB64 command is translated to C++, the compiler adds special code sections to check for [ON TIMER (n)](ON-TIMER-(n)) events and errors that may have occured in the last function call. Disabling error checking with the [$CHECKING]($CHECKING):OFF directive prevents the compiler from adding the extra code sections.
* Setting [$CHECKING]($CHECKING):OFF is only designed for 100% stable, errorless sections of code, where every CPU cycle saved counts, such as in a software 3D texture mapper, for example.

## See Also

* [ON TIMER(n)](ON-TIMER(n))
* [ON ERROR](ON-ERROR)
* [Metacommand](Metacommand)
* [ERROR Codes](ERROR-Codes)
