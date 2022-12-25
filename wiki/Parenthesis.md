**Parenthesis** are used to enclose [SUB](SUB) and [FUNCTION](FUNCTION) parameters or to set the operation order in [Mathematical Operations](Mathematical-Operations).

## Usage

> COLOR 14: PRINT [TAB](TAB)(30); "Hello World"

```text

                              Hello World

```

* [SUB](SUB) parameters MUST be enclosed in parenthesis when the [CALL](CALL) statement is used. Do **not** use parenthesis without CALL.
* Parenthesis can be used in calculations to determine the order in which math operations are performed when the normal order would not work correctly. Normal operation order is: **1)** exponential, **2)** multiplication or division **3)** addition or subtraction.
* Parenthesis can also denote the array index or the dimension size(s) in a [DIM](DIM) statement.
* Instead of [BYVAL](BYVAL), use extra parenthesis around sub-procedure call parameters to pass them by value instead of by reference.
* Extra pairs of brackets have no effect on the code! If one is missing the IDE should tell you.

## Example(s)

Using too many brackets does not harm the code execution as long as they are paired up.

```vb

nmb$ = STR$(100)
nmb$ = LTRIM$(((RTRIM$(nmb$))))  'extra bracket pairs do not affect the code

PRINT nmb$ 

```

## See Also

* [DIM](DIM), DECLARE
* [SUB](SUB), [FUNCTION](FUNCTION)
* [Arrays](Arrays)
