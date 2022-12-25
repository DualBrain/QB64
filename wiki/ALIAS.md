See [DECLARE LIBRARY](DECLARE-LIBRARY).

The [ALIAS](ALIAS) clause in a [DECLARE LIBRARY](DECLARE-LIBRARY) statement block tells the program the name of the procedure used in the external library.

## Syntax

> SUB *pseudoname* [ALIAS](ALIAS) *actualname* [(*parameters*)]

## Parameter(s)

* The *pseudo name* is the name of the [SUB](SUB) or [FUNCTION](FUNCTION) the QB64 program will use.
* The *actual name* is the same procedure name as it is inside of the DLL library.
* QB64 must use all parameters of imported procedures including optional ones.

## Description

* The ALIAS name clause is optional as the original library procedure name can be used.
* The procedure name does not have to be inside of quotes when using [DECLARE LIBRARY](DECLARE-LIBRARY).
* QB64 does not support optional parameters.

## Example(s)

Instead of creating a SUB with the Library statement inside of it, just rename it:

```vb

DECLARE LIBRARY
    SUB MouseMove ALIAS glutWarpPointer (BYVAL xoffset&, BYVAL yoffset&)
END DECLARE

DO UNTIL _SCREENEXISTS: LOOP
PRINT "Hit a key..."
SLEEP

MouseMove 1, 1

```

> *Explanation:* When a Library procedure is used to represent another procedure name use ALIAS instead. Saves creating a SUB! Just place your name for the procedure first with the actual Library name after ALIAS.

## See Also

* [SUB](SUB), [FUNCTION](FUNCTION)
* [DECLARE LIBRARY](DECLARE-LIBRARY), [BYVAL](BYVAL)
* [DECLARE DYNAMIC LIBRARY](DECLARE-DYNAMIC-LIBRARY)
