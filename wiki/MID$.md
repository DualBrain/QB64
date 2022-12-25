The [MID$](MID$) function returns a portion of a [STRING](STRING).

## Syntax

>  portion$ = [MID$](MID$)(stringValue$, startPosition%[, bytes%])

## Parameter(s)

* stringValue$ can be any literal or variable non-empty [STRING](STRING) value. Use [LEN](LEN) to check the length of a string.
* startPosition% designates the non-zero position of the first character to be returned by the function.
* bytes% (optional) tells the function how many characters to return including the first character at startPosition%. 

## Description

* When the bytes% value is not passed, the function returns the remainder of the string from the starting character position.
* Number of character bytes% should be within the string's [LEN](LEN) from the start position, but will only return the string's remainder when exceeded.
* If the bytes% value is 0 or the startPosition% is 0 or greater than the [LEN](LEN) of the string, an empty string is returned (no error is triggered).
* In **QB64**, [ASC](ASC) string byte position reads are about **5 times faster** than MID$ when parsing strings. See *Example 2* below.

## QBasic

* In QBasic the startPosition% could not be zero (0) or an [ERROR Codes](ERROR-Codes) would occur.

## Example(s)

Getting the hour and minutes from [TIME$](TIME$)

```vb

PRINT TIME$

hour$ = LEFT$(TIME$, 2)
minutes$ = MID$(TIME$, 4, 2) ' skip hours and the colon (first 3 characters)

PRINT "hour = "; hour$; ": minutes = "; minutes$ 

``` 

```text

11:23:30
hour = 11: minutes = 23

```

Comparing MID$, the **QB64** byte position version of [ASC](ASC) and [_MEMGET](_MEMGET) speeds parsing string characters:

```vb

_TITLE "String Speed Test"
DEFLNG A-Z

'First let's build a string for testing.
Limit = 100000 'the size of the string
LoopCount = 1000 'the number of times we want to deconstruct it

FOR i = 1 TO Limit
  t$ = t$ + CHR$(RND * 255)
NEXT

'now for some times

t1# = TIMER
FOR j = 1 TO LoopCount
  FOR i = 1 TO Limit
    m$ = MID$(t$, i, 1)
  NEXT
NEXT
t2# = TIMER
FOR j = 1 TO LoopCount
  FOR i = 1 TO Limit
    m = ASC(t$, i)
  NEXT
NEXT

t3# = TIMER
$CHECKING:OFF
DIM m AS _MEM, m1 AS STRING * 1, m2 AS _UNSIGNED _BYTE
m = _MEMNEW(Limit) 'create new memory space for string
_MEMPUT m, m.OFFSET, t$ 'put string t$ into memory space
FOR j = 1 TO LoopCount
  FOR i = 1 TO Limit
    _MEMGET m, m.OFFSET + i - 1, m1
  NEXT
NEXT
t4# = TIMER
FOR j = 1 TO LoopCount
  FOR i = 1 TO Limit
    _MEMGET m, m.OFFSET + i - 1, m2
  NEXT
NEXT
t5# = TIMER

'results

PRINT USING "##.###### seconds for MID$"; t2# - t1#
PRINT USING "##.###### seconds for ASC"; t3# - t2#
PRINT USING "##.###### seconds for _MEMGET String"; t4# - t3#
PRINT USING "##.###### seconds for _MEMGET Byte"; t5# - t4# 

```
 
```text

6.593750 seconds for MID$
1.044922 seconds for ASC
0.494141 seconds for _MEMGET String
0.494141 seconds for _MEMGET Byte

```

>  *Note:* [_MEMGET](_MEMGET) can be used with [$CHECKING]($CHECKING):OFF to cut the parsing speed even more. [STRING](STRING) * 1 or [_BYTE](_BYTE) are similar speeds.

## See Also

* [MID$ (statement)](MID$-(statement)), [ASC](ASC)
* [LEFT$](LEFT$), [RIGHT$](RIGHT$)
* [LTRIM$](LTRIM$), [RTRIM$](RTRIM$) 
* [INSTR](INSTR), [LEN](LEN)
* [_MEMPUT](_MEMPUT), [_MEMGET](_MEMGET) 
