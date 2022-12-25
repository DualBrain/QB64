The **DECLARE LIBRARY** declaration allows the use of external library [SUB](SUB) and [FUNCTION](FUNCTION) procedures supported by QB64.

## Syntax

> **DECLARE** [DYNAMIC|CUSTOMTYPE|STATIC] **LIBRARY** [{*"Library_filename"*|*"Headerfile"*}]
>
> {[SUB](SUB)|[FUNCTION](FUNCTION)} [*procedure_name* ALIAS] *library_procedure* ([BYVAL] *parameter AS*, ...)
>
> ... 'other SUBs or Functions as required
>
> **END DECLARE**

## Parameter(s)

* The Library_filename is needed if a Library is not already loaded by QB64. Do not include the *.DLL*, *LIB* or *.H* file extension.
* It's always a good idea to try declaring Windows API libraries without a Library_filename first, as most Windows headers are already included in QB64 source.
* Begin the Library_filename with **./** or **.\** to make it relative to the path where your source file is saved, so you can keep all your project files together.
* Procedure_name is any program procedure name you want to designate by using [ALIAS](ALIAS) with the Library_procedure name. 
* Library procedure is the actual procedure name used inside of the library or header file.

### Library Types

* **[DECLARE DYNAMIC LIBRARY](DECLARE-DYNAMIC-LIBRARY)** links a program to functions in dynamically linkable libraries. At present, only .DLL files are supported
* **CUSTOMTYPE** is already implied when using [DECLARE DYNAMIC LIBRARY](DECLARE-DYNAMIC-LIBRARY). This type of library just allows the same flexibility to apply when referencing STATIC libraries that are used to refer to dynamic libraries. Supports shared object (*.so) libraries.
* **STATIC** is the same as [DECLARE LIBRARY](DECLARE-LIBRARY) except that it prioritizes linking to static libraries (*.a/*.o) over shared object (*.so) libraries, if both exist. As Windows doesn't use shared libraries (DLLs are different) this does not affect Windows users.

## Description

* The declaration can be used with C++ sub-procedures, Windows API and QB64 SDL (versions prior to 1.000)/OpenGL (version 1.000 and up) Libraries.
* *Library filename*s can be listed to combine more than one DLL or Header file name or path into one DECLARE LIBRARY block.
* C procedures can use a header file name. File code must be included with program code. Do not include the *.h* extension.
* *Parameters* used by the Library procedure must be passed by value ([BYVAL](BYVAL)) except for [STRING](STRING) characters.
* When using a procedure from an **unsupported** Dynamic Link Library (DLL file) use [DECLARE DYNAMIC LIBRARY](DECLARE-DYNAMIC-LIBRARY).

* The [_OFFSET](_OFFSET) in memory can be used in **CUSTOMTYPE**, **STATIC** and **DYNAMIC LIBRARY** declarations.
* Declarations can be made inside of [SUB](SUB) or [FUNCTION](FUNCTION) procedures. Declarations do not need to be at program start.
* **NOTE: It is up to the user to document and determine the suitability of all Libraries and procedures they choose to use! QB64 cannot guarantee that any procedure will work and cannot guarantee any troubleshooting help.**

## Example(s)

Using an **SDL** library procedure as a program SUB procedure to move the mouse pointer to a coordinate (works in versions prior to 1.000):

```vb

DECLARE LIBRARY
  SUB SDL_WarpMouse (BYVAL column AS LONG, BYVAL row AS LONG) 'SDL procedure name
END DECLARE
SCREEN _NEWIMAGE(640, 480, 256)  'simulate screen 12 with 256 colors
RANDOMIZE TIMER

DO
  _DELAY 1
  x = RND * 640: y = RND * 480
  LINE (x, y)-STEP(10, 10), RND * 100 + 32, BF
  MouseMove x + 5, y + 5
LOOP UNTIL LEN(INKEY$)  'any keypress quits
END

SUB MouseMove (x AS LONG, y AS LONG)
SDL_WarpMouse x, y     'call SDL library procedure
END SUB 

```

> *Explanation:* The SDL Library is included and loaded with QB64 versions prior to 1.000, so these procedures are directly available for use. 

**Using [ALIAS](ALIAS) to create a program SUB or FUNCTION** using **QB64 SDL ONLY**

```vb

SCREEN 12
DECLARE LIBRARY
  SUB MouseMove ALIAS SDL_WarpMouse (BYVAL column&, BYVAL row&)
END DECLARE

_DELAY 2
MouseMove 100, 100
_DELAY 2
MouseMove 200, 200 

```

> *Explanation:* When a Library procedure is used to represent another procedure name use [ALIAS](ALIAS) instead. Saves creating a SUB!

Don't know if a C function is defined by C++ or QB64? Try using empty quotes.

```vb

DECLARE LIBRARY ""
    FUNCTION addone& (BYVAL value&)
END DECLARE 

```

> *Explanation:* The C function 'addone' exists in a library QB64 already links to, but it hasn't been defined as a C function or a QB64 function. By using "" we are telling QB64 the function exists in a library which is already linked to and that it must define the C function before calling it, as well as allowing QB64 code to call it. Trying the above code without the "" will fail.

> **Note: Which libraries are or aren't automatically used in the linking process is not formally defined, nor is it guaranteed to stay that way in future versions of QB64.**

**QB64 version 1.000 and up produce standalone executables. External DLL files must be distributed with your program.**

## See Also

* [DECLARE DYNAMIC LIBRARY](DECLARE-DYNAMIC-LIBRARY)
* [SUB](SUB), [FUNCTION](FUNCTION)
* [BYVAL](BYVAL), [ALIAS](ALIAS)
* [C Libraries](C-Libraries), [DLL Libraries](DLL-Libraries), [Windows Libraries](Windows-Libraries)
* [Port Access Libraries](Port-Access-Libraries)
* [SQL Client](SQL-Client)
