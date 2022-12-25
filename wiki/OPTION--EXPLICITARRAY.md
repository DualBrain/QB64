[OPTION _EXPLICITARRAY](OPTION--EXPLICITARRAY) instructs the compiler to require arrays be declared with [DIM](DIM), [REDIM](REDIM) or equivalent.

## Syntax

>  [OPTION _EXPLICITARRAY](OPTION--EXPLICITARRAY)

## Description

* Normally statements like `x(2) = 3` will implicitly create an array x(). [OPTION _EXPLICITARRAY](OPTION--EXPLICITARRAY) requires a preceding declaration for the array, helping to catch mistyped array and function names.
* Unlike [OPTION _EXPLICIT](OPTION--EXPLICIT), simple variables can still be used without a declaration. Example: `i = 1`

## Error(s)

* It's not advisable to use [OPTION _EXPLICITARRAY](OPTION--EXPLICITARRAY) in [$INCLUDE]($INCLUDE)d modules.

## Example(s)

Avoiding simple typos with [OPTION _EXPLICITARRAY](OPTION--EXPLICITARRAY) results shown in the QB64 IDE Status area.

```vb

OPTION _EXPLICITARRAY
x = 1 'This is fine, it's not an array so not affected

DIM z(5)
z(2) = 3 'All good here, we've explicitly DIMmed our array

y(2) = 3 'This now generates an error

```

*QB64 IDE Status will show:*

**Array 'y' (SINGLE) not defined on line 7**

## See Also

* [OPTION _EXPLICIT](OPTION--EXPLICIT)
* [DIM](DIM), [REDIM](REDIM)
* [SHARED](SHARED)
* [STATIC](STATIC)
