**DO...LOOP** statements are used in programs to repeat code or return to the start of a procedure.

## Syntax

*Syntax 1:*
> **[DO](DO)** [{**WHILE**|**UNTIL**} condition]
>>   *{code}*
>>
>>   ⋮
>>
> **[LOOP](LOOP)** 

*Syntax 2:*
> **[DO](DO)**
>>   *{code}*
>>
>>   ⋮
>
> **[LOOP](LOOP)** [{**WHILE**|**UNTIL**} condition]

## Description

* **DO UNTIL or DO WHILE used with LOOP**: The condition is evaluated before running the loop code.
> [UNTIL](UNTIL) checks if the condition is false each time before running code.
> [WHILE](WHILE) checks if the condition is true each time before running code.
   * **DO used with LOOP UNTIL or LOOP WHILE**: The code block will run at least once:
> [UNTIL](UNTIL) checks if the condition is false before running loop code again.
> [WHILE](WHILE) checks if the condition is true before running loop code again.
* NOTE: You cannot use a condition after both the DO and LOOP statements at the same time. 
* Use **[EXIT](EXIT) DO** to exit a loop block even before the condition is met.
* Use [_CONTINUE](_CONTINUE) to skip the remaining lines in the iteration without leaving the loop.
  * If you don't specify a condition, you must exit the loop block manually using **[EXIT](EXIT) DO**.
* If a loop never meets an exit condition requirement, it will never stop.

**Relational Operators:**

| Symbol | Condition | Example Usage |
| -- | -- | -- |
| = | Equal | IF a = b THEN |
| <> | NOT equal | IF a <> b THEN |
| < | Less than | IF a < b THEN |
| > | Greater than | IF a > b THEN |
| <= | Less than or equal | IF a <= b THEN |
| >= | Greater than or equal | IF a >= b THEN |

## Example(s)

Using WHILE to clear the keyboard buffer.

```vb

DO WHILE INKEY$ <> "": LOOP ' checks evaluation before running loop code

DO: LOOP WHILE INKEY$ <> "" ' checks evaluation after one run of loop code


```

Using UNTIL to clear the keyboard buffer.

```vb

DO UNTIL INKEY$ = "": LOOP ' checks evaluation before running loop code

DO: LOOP UNTIL INKEY$ = "" ' checks evaluation after one run of loop code


```

Using a one time DO loop to exit ANY of several FOR LOOPs, without using [GOTO](GOTO).
> SUB reads header contents of a [BSAVE](BSAVE) file that may include embedded RGB color settings before the image.

```vb

DEFINT A-Z
INPUT "Enter a BSAVE file name to read the file for screen mode:"', filenm$
CheckScreen filenm$

END

DEFINT A-Z
SUB CheckScreen (Filename$)        'find Screen mode (12 or 13) and image dimensions
   DIM Bsv AS STRING * 1
   DIM Header AS STRING * 6

   Scr = 0: MaxColors = 0
   OPEN Filename$ FOR BINARY AS #1

   GET #1, , Bsv           '1 check for small 2 character
   GET #1, , Header        '2 - 7 rest of file header

   IF Bsv <> CHR$(253) THEN   ' small 2 character denotes a BSAVE file
      COLOR 12: LOCATE 15, 33: PRINT "Not a BSAVE file!": SLEEP 3: EXIT SUB
   END IF

   GET #1, , widN           '8 no color info bmp sizes
   GET #1, , depN           '9   "        "      "

DO
  IF widN > 63 OR depN > 63 THEN EXIT DO  ' width and depth already found

  FOR i = 10 TO 55       'check for Screen 12 embedded colors
    GET #1, , RGB
    tot12& = tot12& + RGB
    'PRINT i; RGB; : SOUND 300, 1         'test sound slows loop in QB
    IF RGB > 63 OR RGB < 0 THEN EXIT DO
    IF i = 55 AND tot12& = 0 THEN EXIT DO
  NEXT

  GET #1, , wid12          '56
  GET #1, , dep12          '57
  IF wid12 > 63 OR dep12 > 63 THEN EXIT DO

  FOR i = 58 TO 775      'check for Screen 13 embedded colors
    GET #1, , RGB
    tot13& = tot13& + RGB
    'PRINT i; RGB; : SOUND 300, 1          'test
    IF RGB > 63 OR RGB < 0 THEN EXIT DO
    IF i = 775 AND tot13& = 0 THEN EXIT DO
  NEXT
  GET #1, , wid13          '776
  GET #1, , dep13          '777
LOOP UNTIL 1 = 1    'TRUE statement exits one-time LOOP
CLOSE #1

COLOR 14: LOCATE 10, 25
SELECT CASE i
  CASE IS < 56:
   IF widN > 640 THEN
       Scr = 13: MaxColors = 0
       PRINT "Default Screen 13:"; widN \ 8; "X"; depN
   ELSE
    LOCATE 10, 15
    PRINT "Screen 12 ("; widN; "X"; depN; ") OR 13 ("; widN \ 8; "X"; depN; ")" 
    DO: SOUND 600, 4
       COLOR 13: LOCATE 12, 23  'ask if no data found. Prevents ERROR opening in wrong mode
       INPUT "Enter a Screen mode 12 or 13 : ", Scrn$  
       Scr = VAL(Scrn$)
    LOOP UNTIL Scr = 12 OR Scr = 13
   END IF
   IF Scr = 12 THEN MaxColors = 0: PWidth = widN: PDepth = depN
   IF Scr = 13 THEN MaxColors = 0: PWidth = widN \ 8: PDepth = depN
  CASE 56 TO 775
     PRINT "Custom Screen 12:"; wid12; "X"; dep12
     Scr = 12: MaxColors = 16: PWidth = wid12: PDepth = dep12
  CASE 776: PRINT "Custom Screen 13:"; wid13 \ 8; "X"; dep13
     Scr = 13: MaxColors = 256: PWidth = wid13 \ 8: PDepth = dep13
END SELECT

END SUB 

```

> *Explanation:* The SUB procedure reads a file that was [BSAVE](BSAVE)d previously. If the RGB colors are stored before the image, the values can only be between 0 and 63. Higher values indicate that the image width and height are located there and that there are no stored color values to be read. SUB later displays the dimensions of the file image that [GET (graphics statement)](GET-(graphics-statement)) placed in the file array. The loop is set to only run once by creating **a TRUE [UNTIL](UNTIL) statement** such as 1 = 1. When a screen mode cannot be determined, the user must select one.

> Dimensions and location of width and height information indicates the screen mode as [SCREEN (statement)](SCREEN-(statement)) 13 if it has 768 RGB values and dimensions of 320 X 200 max. If the file only holds 64 settings and/or is larger than 320 X 200, it uses SCREEN 12 or 9. The procedure [EXIT](EXIT)s the DO LOOP early when the image size is found with or without custom color settings.

> Divide SCREEN 13 [GET (graphics statement)](GET-(graphics-statement)) widths by 8.

## See Also

* [EXIT DO](EXIT-DO)
* [WHILE...WEND](WHILE...WEND)
* [FOR...NEXT](FOR...NEXT)
