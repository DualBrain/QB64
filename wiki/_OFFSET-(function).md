The [_OFFSET](_OFFSET) function returns the memory offset of/within a given variable.

## Syntax

> offset%& = [_OFFSET](_OFFSET)(variable)

## Description

* The variable parameter can be any type of numerical or [STRING](STRING) variable name.
* API [DECLARE LIBRARY](DECLARE-LIBRARY) parameter or [TYPE](TYPE) names may include **lp, ptr** or **p** which designates them as a pointer type.
* _OFFSET function return values should be stored in [_OFFSET](_OFFSET) type variables. As no other variable type is 'elastic' like [_OFFSET](_OFFSET), there can be no guarantee that any other variable type can hold the value of an _OFFSET.
* Returns the memory offset of variables, user-defined-types & elements, arrays & indices and the base offset of [STRING](STRING)s.
* Offset values are currently only useful when used in conjunction with [_MEM](_MEM) or [DECLARE LIBRARY](DECLARE-LIBRARY) procedures. 
* OFFSET values are used as a part of the [_MEM](_MEM) variable [Variable Types](Variable-Types) in QB64; variable.OFFSET returns or sets the current position in memory.
* **Warning:** QB64 variable length strings can move about in memory at any time. If you get the _OFFSET of a variable length sting on one line and use it on the next it may not be there anymore.** To be safe, move variable length strings into fixed length strings first.**

## Example(s)

Using memcpy with the _OFFSET function values as parameters.

```vb

DECLARE CUSTOMTYPE LIBRARY
    SUB memcpy (BYVAL dest AS _OFFSET, BYVAL source AS _OFFSET, BYVAL bytes AS LONG)
END DECLARE

a$ = "1234567890"
b$ = "ABCDEFGHIJ"

memcpy _OFFSET(a$) + 5, _OFFSET(b$) + 5, 5
PRINT a$ 

```

```text

12345FGHIJ

```

## See Also

* [_OFFSET](_OFFSET) (variable type)
* [DECLARE LIBRARY](DECLARE-LIBRARY)
* [DECLARE DYNAMIC LIBRARY](DECLARE-DYNAMIC-LIBRARY)
* [Using _OFFSET](Using--OFFSET)
