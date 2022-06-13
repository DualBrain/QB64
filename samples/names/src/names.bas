'  NAMES.BAS by David Bannon
'  Copyright (C) 1992 DOS Resource Guide
'  Published in Issue #6, November 1992, page 65
'
DEFINT A-Z
DECLARE SUB Menu (Row, Column, Option$(), Escape, Selection)

CONST TRUE = -1
CONST FG = 7, BG = 4

DIM Main$(1 TO 10)
FOR X = 1 TO 10
  READ Main$(X)
NEXT


' Display the main menu
MainMenu:
DATA NAMES DATABASE, Keep track of those, Names and Numbers!, MAIN MENU, -
DATA 1. ENTER a name, 2. SEARCH for a name, 3. Quit, -, Select a number

CLS
CALL Menu(6, 30, Main$(), LastKey, Selection)
COLOR 7, 1

' A simple database program for entering names, phone numbers and
' company names, and searching for them.

file$ = "NAMES.TXT"    ' Database file name
form$ = "\            \\         \"
form$ = "(\ \)\       \"
form$ = "\                            \"



' Get the user's choice
DO: choice$ = INKEY$
LOOP UNTIL choice$ = "1" OR choice$ = "2" OR choice$ = "3"

SELECT CASE choice$
  CASE "1"        ' Add a name to the database
    OPEN file$ FOR APPEND AS #1
    WHILE UCASE$(last$) <> "END"
    CLS : LOCATE 11, 25: PRINT "ADD a name to the database"
    LOCATE 12, 25: PRINT "(To stop, enter END as a last name)"
    LOCATE 14, 25: INPUT "Last name: ", last$
    IF UCASE$(last$) <> "END" THEN
      LOCATE 16, 24: INPUT "First name: ", first$
      LOCATE 18, 40: PRINT "(Press Enter if n/a)"
      LOCATE 18, 25: INPUT "Area code: ", area$
      LOCATE 20, 22: INPUT "Phone number: ", phone$
      LOCATE 22, 22: INPUT "Company name: ", compa$
      WRITE #1, last$, first$, area$, phone$, compa$: CLS
    END IF
  WEND
  CLOSE #1: last$ = "": GOTO MainMenu

CASE "2"        ' Search for a name in the database
  WHILE UCASE$(search$) <> "END"
    OPEN file$ FOR INPUT AS #1
    CLS : LOCATE 11, 25: PRINT "SEARCH for a name in the database"
      LOCATE 12, 25: PRINT "(To stop, enter END as the name)"
      LOCATE 14, 25: INPUT "Name to search for: ", search$: PRINT
      IF UCASE$(search$) <> "END" THEN
        DO WHILE (NOT EOF(1))
          INPUT #1, last$, first$, area$, phone$, compa$
          SELECT CASE UCASE$(search$)
            CASE UCASE$(last$)
              hit% = 1: LOCATE , 25
              PRINT USING form$; last$; first$;
              LOCATE , 25: PRINT USING form$; area$; phone$
              LOCATE , 25: PRINT USING form$; compa$
            CASE UCASE$(first$)
              hit% = 1: LOCATE , 25
              PRINT USING form$; last$; first$;
              LOCATE , 25: PRINT USING form$; area$; phone$
              LOCATE , 25: PRINT USING form$; compa$
            CASE UCASE$(compa$)
              hit% = 1: LOCATE , 25
              PRINT USING form$; last$; first$;
              LOCATE , 25: PRINT USING form$; area$; phone$
              LOCATE , 25: PRINT USING form$; compa$
          END SELECT
        LOOP
        IF hit% = 0 THEN
            LOCATE , 25: PRINT "No match found for "; search$
        END IF
        hit% = 0: LOCATE , 25: PRINT
        LOCATE , 25: PRINT "Press any key to continue"
        DO WHILE INKEY$ = "": LOOP
        CLOSE #1
      END IF
    WEND
    CLOSE #1: search$ = "": GOTO MainMenu

  CASE "3"      ' Quit the program
    CLS : SYSTEM

END SELECT

'
SUB Menu (Row, Column, Option$(), last, Selection) STATIC


  LMax = 0                              'Max length of options
  NumOpts = UBOUND(Option$)             'Number of options
  IF Selection = 0 OR Selection > NumOpts THEN Selection = 1

  FOR A = 1 TO NumOpts                  'Determine longest item
    B = LEN(Option$(A))
    IF B > LMax THEN LMax = B
  NEXT
  LMax = LMax + 2                       'Add two for surrounding spaces

  FOR A = 1 TO NumOpts                  'Display the choices
    COLOR FG, BG
    F = Row + A - 1
    LOCATE F, Column
    IF Option$(A) = "-" THEN
      PRINT STRING$(LMax, 196)
    ELSE
      PRINT " "; Option$(A); TAB(Column + LMax);

       B = INSTR(UCASE$(Option$(A)), A$)
       IF B THEN
         LOCATE F, Column + B
         PRINT MID$(Option$(A), B, 1)
       END IF
     END IF
 NEXT


  COLOR FG, BG
  LOCATE Row + Selection - 1, Column
  PRINT " "; Option$(Selection); TAB(Column + LMax);
    B = INSTR(UCASE$(Option$(Selection)), A$)
    IF B THEN
      LOCATE Row + Selection - 1, Column + B
      PRINT MID$(Option$(Selection), B, 1)
    END IF

  SELECT CASE T
       CASE -71                            'Home
         Selection = 1
       CASE -79                            'End
         Selection = NumOpts
       CASE -72
         Selection = Selection - 1         'Up arrow
         IF Selection = 0 THEN Selection = NumOpts
         IF MID$(Option$(Selection), 2, 1) = "-" THEN
           Selection = Selection - 1
         END IF
       CASE -80                            'Down arrow
         Selection = Selection + 1
         IF Selection > NumOpts THEN Selection = 1
         IF Option$(Selection) = "-" THEN
           Selection = Selection + 1
         END IF
       CASE ELSE
         Selection = Letter
     END SELECT
   

 END SUB

