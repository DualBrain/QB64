The [LPOS](LPOS) function returns the current LPT printer head position.

## Syntax

>  result% = [LPOS](LPOS)(index%)

## Description

* index% is the index of the printer, which can have the following values:
  * 0 - LPT1:
  * 1 - LPT1:
  * 2 - LPT2:
  * 3 - LPT3:
* The LPOS function does not necessarily give the physical position of the print head because it does not expand tab characters. In addition, some printers may buffer characters.

## Example(s)

> Prompts the user for team names and the names of players on each team. It then prints the players and their teams on the printer.

```vb

CLS
LPRINT "Team Members"; TAB(76); "TEAM" : LPRINT
INPUT "How many teams"; TEAMS
INPUT "How many players per team";PPT
PRINT
FOR T = 1 TO TEAMS
    INPUT "Team name: ", TEAM$
    FOR P = 1 TO PPT
        INPUT "   Enter player name: ", PLAYER$
        LPRINT PLAYER$;
        IF P < PPT THEN
            IF LPOS(0) > 55 THEN ' Print a new line if print head past column 55.
                LPRINT : LPRINT SPACE$(5);
            ELSE
                LPRINT ", ";         'Otherwise, print a comma.
            END IF
        END IF
    NEXT P
LPRINT STRING$(80 - LPOS(0) - LEN(TEAM$),"."); TEAM$
NEXT T

```

## See Also

* [LPRINT](LPRINT)
