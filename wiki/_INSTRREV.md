The [_INSTRREV](_INSTRREV) function searches for a substring inside another string, but unlike [INSTR](INSTR) it searches from right to left.

## Syntax

> position% = [_INSTRREV](_INSTRREV)([start%,] baseString$, subString$)

## Parameter(s)

* The optional literal or variable [INTEGER](INTEGER) start% indicates where in the baseString$ the search must start, counted from the left. 
* The baseString$ is a literal or variable [STRING](STRING) value to be searched for an exact match including [UCASE$](UCASE$). 
* The subString$ is a literal or variable [STRING](STRING) value being searched.

## Description

* The function returns the position% in the baseString$ where the subString$ was found, from right to left.
* position% will be 0 if the search found no matches in the base string.
* [_INSTRREV](_INSTRREV) returns 0 if an empty baseString$ is passed, and returns [LEN](LEN)(baseString$) with an empty subString$.
* The start% position is useful when making multiple searches in the same string. See the example below.
* The subString$ should be smaller or equal in [LEN](LEN) to the baseString$, or 0 is returned.
* A start% value of 0 or less starts search from the end of the baseString$ (same as not passing a start% parameter).

## Example(s)

Separating a file name from a full path.

```vb

fullPath$ = "C:\Documents and Settings\Administrator\Desktop\qb64\internal\c\libqb\os\win\libqb_1_2_000000000000.o"
file$ = MID$(fullPath$, _INSTRREV(fullPath$, "\") + 1)
PRINT file$

```

```text

libqb_1_2_000000000000.o

```

Searching for multiple instances of a substring inside a base string, going from the end to the start.

```vb

sentence$ = " This is a string full of spaces, including at start and end... "
PRINT sentence$
DO
    findPrevSpace% = _INSTRREV(findPrevSpace% - 1, sentence$, SPACE$(1))
    IF findPrevSpace% = 0 THEN
        LOCATE 4, 1
        PRINT "No more spaces"
        EXIT DO
    END IF

    LOCATE 2, findPrevSpace%
    PRINT "^"
    totalSpaces = totalSpaces + 1

    IF findPrevSpace% = 1 THEN 
        LOCATE 4, 1
        PRINT "Last space found at position 1"
        EXIT DO
    END IF
LOOP
PRINT "Total spaces found: "; totalSpaces

```

```text

 This is a string full of spaces, including at start and end... 
^    ^  ^ ^      ^    ^  ^       ^         ^  ^     ^   ^      ^

Last space found at position 1
Total spaces found: 13

```

## See Also

* [MID$](MID$), [INSTR](INSTR)
* [SPACE$](SPACE$)
