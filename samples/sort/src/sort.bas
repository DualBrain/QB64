DECLARE SUB BUBBLESORT (ARRAY())
DECLARE SUB SHELLSORT (ARRAY())

' SORT.BAS
'   by Antonio and Alfonso De Pasquale
' Copyright (C) 1994 DOS Resource Guide
' Published in Issue #17, September 1994, page 64

MAIN:
    COLOR 15, 1
    CLS : CLEAR : RANDOMIZE TIMER: ENTRIES = 0
    PRINT TAB(32); "Sort Demonstrator"
    PRINT TAB(25); "By Antonio & Alfonso De Pasquale"
    FOR X = 1 TO 80: PRINT CHR$(196); : NEXT X: PRINT : PRINT
    PRINT " This program demonstrates the differences in speed between"
    PRINT " a Bubble Sort and a Shell Sort.": PRINT
    INPUT " Please enter an array size (50 - 500) or press Enter to quit: ", ENTRIES
    IF ENTRIES = 0 THEN COLOR 7, 0: CLS : END
    IF ENTRIES < 50 OR ENTRIES > 500 THEN GOTO MAIN
    DIM NUMLIST(ENTRIES): PRINT
   
    PRINT " Please wait while the program creates an array of"; ENTRIES; "random numbers..."
    FOR X = 1 TO ENTRIES: NUMLIST(X) = INT(1000 * RND + 1): NEXT X
    PRINT : PRINT " Please select one:  (B)ubble Sort, (S)hell Sort, (Q)uit Program: ";
   
    K$ = ""
    DO WHILE K$ <> "B" AND K$ <> "S" AND K$ <> "Q"
	K$ = UCASE$(INKEY$)
    LOOP
   
    PRINT K$: IF K$ = "Q" THEN CLS : END
    PRINT : PRINT " The sort was started at   "; TIME$
   
    IF K$ = "B" THEN
	BUBBLESORT NUMLIST()
    ELSE
	SHELLSORT NUMLIST()
    END IF
   
    PRINT " The sort was completed at "; TIME$
    PRINT : PRINT " Press Enter to view the sorted numbers"
    PRINT : DO: LOOP UNTIL INKEY$ = CHR$(13)
    CLS : PRINT " Here are the sorted numbers...": PRINT
    FOR X = 1 TO ENTRIES: PRINT USING " ####"; NUMLIST(X); : NEXT X
    PRINT : PRINT : PRINT " Press Enter to continue"
    DO: LOOP UNTIL INKEY$ = CHR$(13)
    GOTO MAIN

SUB BUBBLESORT (ARRAY())

LOW = LBOUND(ARRAY)
HIGH = UBOUND(ARRAY)
SWITCH = 0
DO WHILE SWITCH = 0
    SWITCH = 1
    FOR INDEX = (LOW + 1) TO (HIGH - 1)
	IF ARRAY(INDEX) > ARRAY(INDEX + 1) THEN
	    SWAP ARRAY(INDEX), ARRAY(INDEX + 1)
	    SWITCH = 0
	END IF
    NEXT INDEX
LOOP

END SUB

SUB SHELLSORT (ARRAY())

LOW = LBOUND(ARRAY)
HIGH = UBOUND(ARRAY)
GAP = INT(HIGH / 2)

DO WHILE GAP <> 0
    SWITCH = 0
    DO WHILE SWITCH = 0
	SWITCH = 1
	FOR INDEX = (LOW + 1) TO (HIGH - GAP)
	    IF ARRAY(INDEX) > ARRAY(INDEX + GAP) THEN
		SWAP ARRAY(INDEX), ARRAY(INDEX + GAP)
		SWITCH = 0
	    END IF
	NEXT INDEX
    LOOP
    GAP = INT(GAP / 2)
LOOP

END SUB

