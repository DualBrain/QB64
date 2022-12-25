The SWAP statement is used to exchange two variable or array element values.

## Syntax

> SWAP variable1, variable2

## Description

* variable1 and variable2 are any type variables whose values will be exchanged.
* If either variable1 or variable2 is an array, then an element in the array must be designated.
* SWAP can be used with string or number variable values. Both must be of the same type.
* SWAP is often used to sort array elements into greater or lesser numerical or cumulative [ASCII](ASCII) [STRING](STRING) values. 
* SWAP can be used in page flipping to change between source and destination pages.

## Example(s)

A simple SWAP of [STRING](STRING) values.

```vb

a$ = "one"
b$ = "two"

SWAP a$, b$

PRINT a$
PRINT b$

```

```text

two
one

```

Creating Cryptograms by scrambling EVERY capital letter in the alphabet.

```vb

DIM Letter$(65 TO 90)
RANDOMIZE TIMER
CLS
FOR a = 65 TO 90                    'set ASCII codes and letters in order
  Letter$(a) = CHR$(a)              'create capitalized characters
NEXT a

COLOR 11: LOCATE 10, 10
FOR i = 65 TO 90
  IF Letter$(i) = CHR$(i) THEN      'find characters the same as the ASCII code index
    DO: j = INT(RND * 26) + 65: LOOP WHILE j = i    'loop until j <> i
    SWAP Letter$(i), Letter$(j)     'swap corresponding letter characters
  END IF
  PRINT CHR$(i); " ";               'print normal alphabetical order
NEXT

COLOR 14: LOCATE 12, 10
FOR a = 65 TO 90                    'display new alphabetical order
  PRINT Letter$(a); " ";
NEXT

text$ = "This is how a normal sentence would look before being encrypted."
COLOR 11: LOCATE 20, 5: PRINT text$
L = LEN(text$)
DIM Code(L)                         'place ASCII code solution into an array
COLOR 14: LOCATE 22, 5
FOR i = 1 TO L
  Code(i) = ASC(UCASE$(text$), i)   'in QB64, ASC can read by character position
  IF Code(i) >= 65 AND Code(i) <= 90 THEN PRINT Letter$(Code(i)); ELSE PRINT CHR$(Code(i));
NEXT
END 

```


  * Explanation:* The Letter$ [STRING](STRING) [Arrays](Arrays) is first created with the letters matching the [ASCII](ASCII) code index value. Every index is **swap**ped when the letter matches it's index code until every letter is different. The Code array holds the text code solution.

A very quick array sorting SUB procedure using recursion sorts 10 thousand numbers in milliseconds.

```vb

DEFINT A-Z
DIM SHARED swap2 AS LONG  'Demo only
DIM array(10000) AS SINGLE 'array can hold any type of value
RANDOMIZE TIMER
FOR i = 0 TO 10000
  array(i) = RND * 1000 'populate array with random values to sort
NEXT
start = LBOUND(array)  'lowest element
finish = UBOUND(array) 'highest element
swap2 = 0                     'count swaps for demo only
start! = TIMER(.001)
CALL QuickSort(start, finish, array())
ending! = TIMER(.001)
tmp$ = " array(0)= ##.#####     array(5000)= ###.####   array(10000)= ###.####"
PRINT USING tmp$; array(0); array(5000); array(10000) 
PRINT USING " Elapsed time: #.###### seconds with #######, swaps"; ending! - start!; swap2&
FOR n = 0 TO 10000             'check array sort order
  IF array(n) >= max! THEN     'max should match the array type
    max! = array(n)
  ELSE BEEP
    PRINT "Bad sort order!"
    EXIT FOR
  END IF
NEXT
END

SUB QuickSort (start AS INTEGER, finish AS INTEGER, array() AS SINGLE)    
DIM Hi AS INTEGER, Lo AS INTEGER, Middle AS SINGLE
Hi = finish: Lo = start
Middle = array((Lo + Hi) / 2) 'find middle of array
DO
  DO WHILE array(Lo) < Middle: Lo = Lo + 1: LOOP
  DO WHILE array(Hi) > Middle: Hi = Hi - 1: LOOP
  IF Lo <= Hi THEN
    SWAP array(Lo), array(Hi)
    swap2 = swap2 + 1                  'count swaps for demo only    
    Lo = Lo + 1: Hi = Hi - 1
  END IF                               'If homework, you will fail
LOOP UNTIL Lo > Hi
IF Hi > start THEN CALL QuickSort(start, Hi, array())
IF Lo < finish THEN CALL QuickSort(Lo, finish, array())
END SUB 

```

```text

 array(0)= 0.20200    array(5000)= 525.8505   array(10000)= 999.6196
 Elapsed time: 0.023438 seconds with 33,759 swaps

```

> **NOTE:** The *swap2* shared value is used to count the swaps for the demo and can be removed from the SUB procedure for speed. 

## See Also

* [RND](RND), [RANDOMIZE](RANDOMIZE)
* [CHR$](CHR$), [ASC](ASC) 
* [ASCII](ASCII), [Arrays](Arrays)
