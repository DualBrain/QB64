[OPTION _EXPLICIT](OPTION--EXPLICIT) instructs the compiler to require variable declaration with [DIM](DIM), [REDIM](REDIM) or an equivalent statement.

## Syntax

> [OPTION _EXPLICIT](OPTION--EXPLICIT)

## Description

* With [OPTION _EXPLICIT](OPTION--EXPLICIT) you can avoid typos by having QB64 immediately warn in the **Status area** of new variables used without previous declaration.
* Enable [OPTION _EXPLICIT](OPTION--EXPLICIT) temporarily even if a program source file doesn't contain the directive by specifying the **-e** switch when compiling via command line (*qb64 -c file.bas -e*).

## Error(s)

* It's not advisable to use [OPTION _EXPLICIT](OPTION--EXPLICIT) in [$INCLUDE]($INCLUDE)d modules.

## Example(s)

Avoiding simple typos with [OPTION _EXPLICIT](OPTION--EXPLICIT) results shown in the QB64 IDE Status area.

```vb

OPTION _EXPLICIT

DIM myVariable AS INTEGER

myVariable = 5

PRINT myVariabe

```

*QB64 IDE Status will show:*
**Variable 'myVariabe' (SINGLE) not defined on line 4**

## See Also

* [OPTION _EXPLICITARRAY](OPTION--EXPLICITARRAY)
* [DIM](DIM), [REDIM](REDIM)
* [SHARED](SHARED)
* [STATIC](STATIC)
