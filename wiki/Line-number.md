**Line numbers** or line labels are used in QBasic as references to code lines. Numbers are required with [GOTO](GOTO) and numbers or label names are required with [GOSUB](GOSUB). Although not required in QBasic, other older programming languages such as GW Basic often required them. Line labels require a colon after them to differentiate them from keywords and variable names.

**[Microsoft's REMLINE.BAS program removes unnecessary line numbers](ftp://ftp.microsoft.com/services/technet/windows/msdos/RESKIT/SUPPDISK/REMLINE.BAS)**

The following program can remove line numbers where they are not required by [IF...THEN](IF...THEN), [GOTO](GOTO), [GOSUB](GOSUB), [ERL](ERL), [RUN](RUN) or [RESUME](RESUME): 

```vb

CLS
REDIM linenumber(100000)
PRINT "This Program removes unnecessary line numbers.": PRINT
INPUT "Name of file: ", filename$: PRINT

OPEN filename$ FOR INPUT AS #1
DO UNTIL EOF(1)
LINE INPUT #1, a$
REM Get rid of quotes and REM statements.
DO
IF INSTR(a$, CHR$(34)) <> 0 THEN
IF INSTR(INSTR(a$, CHR$(34)) + 1, a$, CHR$(34)) = 0 THEN EXIT DO: REM Mismatched quotes. Illegal code.
a$ = MID$(a$, 1, INSTR(a$, CHR$(34)) - 1) + MID$(a$, INSTR(INSTR(a$, CHR$(34)) + 1, a$, CHR$(34)) + 1)
ELSE
EXIT DO
END IF
LOOP

IF INSTR(UCASE$(a$), "REM ") <> 0 THEN a$ = MID$(a$, 1, INSTR(UCASE$(a$), "REM "))
IF INSTR(UCASE$(a$), "' ") <> 0 THEN a$ = MID$(a$, 1, INSTR(a$, "' "))

DO
flag = 0
REM Break down compound statements and get line numbers.
IF INSTR(a$, "GOTO ") <> 0 THEN flag = 1: n = INSTR(a$, "GOTO ") + 5: GOSUB tracknumber
IF INSTR(a$, "GOSUB ") <> 0 THEN flag = 1: n = INSTR(a$, "GOSUB ") + 6: GOSUB tracknumber
IF INSTR(a$, "THEN ") <> 0 THEN flag = 1: n = INSTR(a$, "THEN ") + 5: GOSUB tracknumber
IF INSTR(a$, "ELSE ") <> 0 THEN flag = 1: n = INSTR(a$, "ELSE ") + 5: GOSUB tracknumber
IF INSTR(a$, "RUN ") <> 0 THEN flag = 1: n = INSTR(a$, "RUN ") + 4: GOSUB tracknumber
IF INSTR(a$, "RESUME ") <> 0 THEN flag = 1: n = INSTR(a$, "RESUME ") + 7: GOSUB tracknumber
IF INSTR(a$, "RETURN ") <> 0 THEN flag = 1: n = INSTR(a$, "RETURN ") + 7: GOSUB tracknumber
IF flag = 0 THEN EXIT DO ELSE a$ = MID$(a$, n)
LOOP
LOOP
PRINT "Number of line-numbered statements kept:"; count
CLOSE #1

OPEN filename$ FOR INPUT AS #1
OPEN "filename.tmp" FOR OUTPUT AS #2
DO UNTIL EOF(1)
LINE INPUT #1, a$
flag = 0
IF VAL(MID$(a$, 1, 1)) <> 0 THEN
FOR i = 1 TO count
IF VAL(a$) = linenumber(i) THEN flag = 1: EXIT FOR
NEXT
IF flag = 0 THEN a$ = MID$(a$, INSTR(a$, " ") + 1)
END IF
PRINT #2, a$
LOOP
CLOSE #1, #2
SHELL _DONTWAIT "notepad filename.tmp"
PRINT
PRINT "Back up original file as .org and give edited file original file name? [Y/N]"
DO
b$ = UCASE$(INKEY$)
SELECT CASE b$
CASE CHR$(27): SYSTEM
CASE "N"
ON ERROR GOTO RESNXT
KILL "filename.tmp"
ON ERROR GOTO 0
PRINT
PRINT "Temporary "+ CHR$(34) + "filename.tmp" + CHR$(34) + " was removed and no changes were made to original file."
PRINT
PRINT "Press any key to end."
EXIT DO

CASE "Y"
ON ERROR GOTO resnxt
KILL MID$(filename$, 1, INSTR(filename$, ".") - 1) + ".org"
ON ERROR GOTO 0
NAME filename$ AS MID$(filename$, 1, INSTR(filename$, ".") - 1) + ".org"
NAME "filename.tmp" AS filename$
PRINT : PRINT "File conversion completed. Press any key to end."
EXIT DO
END SELECT
LOOP
SLEEP
SYSTEM

tracknumber:
DO
count = count + 1
linenumber(count) = VAL(MID$(a$, n))
IF INSTR(a$, "ON") <> 0 AND INSTR(a$, "GOSUB") <> 0 OR INSTR(a$, "ON") <> 0 AND INSTR(a$, "GOTO") <> 0 THEN
FOR i = n TO LEN(a$)
IF VAL(MID$(a$, i, 1)) = 0 AND MID$(a$, i, 1) <> "0" AND MID$(a$, i, 1) <> "," AND MID$(a$, i, 1) <> " " THEN EXIT FOR
IF MID$(a$, i, 2) = ", " THEN n = i + 1: EXIT FOR
NEXT
IF n <> i + 1 THEN EXIT DO
ELSE
EXIT DO
END IF
LOOP
RETURN

resnxt:
RESUME NEXT 

```
<sub>Code courtesy of Pete from the Network 54 Qbasic Forum</sub>

## See Also

* [GOTO](GOTO) , [RUN](RUN)
* [GOSUB](GOSUB) , [RETURN](RETURN)
* [RESUME](RESUME), [NEXT](NEXT)
* [RESTORE](RESTORE)
* [IF...THEN](IF...THEN)
