' LIB.BAS
' by Dennis Mull and Tina Sweet
' Copyright (C) 1994 DOS World
' Published in Issue #18, November 1994, page 54

DIM SHARED FUN$(300)
CLS
INPUT "Your program name: ", YOUR$  'Ask for the name of the program.
                 
  OPEN "I", #1, "FUNSUBS.BAS"       'Open FUNSUBS.BAS for reading.
  OPEN "I", #2, YOUR$               'Open your program for reading.
  OPEN "O", #3, "TEMP.BAS"          'Temporary file made by LIB.BAS.
  DO
    X = X + 1
    LINE INPUT #1, FUN$(X)          'Load FUNSUBS.BAS in an array.
    IF X < 5 THEN PRINT #3, FUN$(X) 'Add FUNSUBS declarations to TEMP.BAS.
  LOOP WHILE NOT EOF(1)
  CLOSE #1                          'Close FUNSUBS.BAS file.

  DO
    LINE INPUT #2, YUR$             'Read your program file.
    PRINT #3, YUR$                  'Add your program lines to TEMP.BAS
  LOOP WHILE NOT EOF(2)             'Stop when last line is read.

  FOR F = 5 TO 300
    IF INSTR(FUN$(F), "SUB ") = 1 THEN OK = 1
    IF OK THEN PRINT #3, FUN$(F)    'Add subroutines to TEMP.BAS.
  NEXT F
  CLOSE #2, #3                      'Close files
  CLS : BEEP: LOCATE 11, 1, 0
  PRINT "Job Complete. Load TEMP.BAS into QBasic and save it under a different name."
END

