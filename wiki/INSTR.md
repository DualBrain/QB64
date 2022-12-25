The [INSTR](INSTR) function searches for the first occurence of a search [STRING](STRING) within a base string and returns the position it was found.

## Syntax

> position% = [INSTR](INSTR)([start%,] baseString$, searchString$)

## Parameter(s)

* The optional literal or variable [INTEGER](INTEGER) start% indicates where in the baseString$ the search must start. 
* The baseString$ is a literal or variable [STRING](STRING) value to be searched for an exact match including [UCASE$](UCASE$). 
* The searchString$ is a literal or variable [STRING](STRING) value being searched.

## Description

* The function returns the position% in the baseString$ where the searchString$ was found.
* position% will be 0 if the search found no matches in the base string. 
* [INSTR](INSTR) returns 0 if an empty baseString$ is passed, and returns 1 with an empty searchString$.
* The start% position is useful when making multiple searches in the same string. See the example below.
* The searchString$ should be smaller or equal in [LEN](LEN) to the baseString$, or 0 is returned.
* Non-zero position% return values can be used as a new start position by adding 1 to re-search the base string. See the example below.
* In a loop, INSTR can search an entire file for occurences of certain words. See the [MID$ (statement)](MID$-(statement)) statement example.
* To search right to left, use [_INSTRREV](_INSTRREV)

## QBasic

* The start% position had to be at least 1 or greater when used or there will be an [ERROR Codes](ERROR-Codes) error. In **QB64**, a start% value of 0 or negative is interpreted as 1 and doesn't generate an error.

## Example(s)

Reading more than one instance of a word in a string using the INSTR return value as the start value plus 1.

```vb

text$ = "The cats and dogs where playing, even though dogs don't like cats."
DO
  findcats% = INSTR(findcats% + 1, text$, "cats") ' find another occurance after
  IF findcats% THEN PRINT "There is 'cats' in the string at position:"; findcats%
LOOP UNTIL findcats% = 0

findmonkey% = INSTR(text$, "monkeys")  ' find any occurance?
PRINT findmonkey%; "'monkeys' were found so it returned:"; findmonkey% 

```

```text

There is 'cats' in the string at position: 5
There is 'cats' in the string at position: 62
 0 'monkeys' were found so INSTR returned: 0

```

> *Explanation:* When the INSTR return value is 0 there are no more instances of a string in a string so the search loop is exited.

## See Also

* [MID$](MID$), [MID$ (statement)](MID$-(statement))
* [LEFT$](LEFT$), [RIGHT$](RIGHT$)
* [LCASE$](LCASE$), [UCASE$](UCASE$)
* [STRING](STRING), [INTEGER](INTEGER)
* [_INSTRREV](_INSTRREV)
