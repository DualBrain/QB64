'
'  PHONE.BAS by Hardin Brothers
'  Copyright (C) 1992 DOS Resource Guide
'  Published in Issue # 4, page 63
'
DEFINT A-Z

TYPE EntryType
   LastName AS STRING * 20
   FirstName AS STRING * 20
   Phone AS STRING * 14
END TYPE

CONST RecLen = 54             'Length of EntryType
CONST FALSE = 0
CONST TRUE = NOT FALSE
CONST FormLength = 18         'Lines in screen top
CONST MaxEntries = 500        'Maximum number of entries
CONST FileName$ = "PHONE.LST" 'Data filename

CONST PgUp = -&H49
CONST PgDn = -&H51
CONST Esc = 27

DIM SHARED Entry(1 TO MaxEntries) AS EntryType
DIM SHARED CurrentEntry, LastEntry
DIM SHARED ErrorFlag
DIM SHARED BlankLine$, DashLine$

BlankLine$ = STRING$(79, " ")
DashLine$ = STRING$(79, "=")

ReadFile
MainDisplay
SaveFile
CLS
END

ErrorTrap:
   ErrorFlag = ERR
   RESUME NEXT

SUB AddEntry
   ClearBottom
   LOCATE FormLength + 1
   PRINT DashLine$
   IF LastEntry < MaxEntries THEN
      PRINT "Last Name ==> ";
      LINE INPUT Name$
      IF LEN(Name$) < 1 THEN
         ShowMenu
         EXIT SUB
      ELSE
         LastEntry = LastEntry + 1
         Entry(LastEntry).LastName$ = Name$
         PRINT "First Name==> ";
         LINE INPUT Entry(LastEntry).FirstName$
         PRINT "Phone     ==> ";
         LINE INPUT Entry(LastEntry).Phone$
         SortList
      END IF
   ELSE
      PRINT "The phone list is full"
      PRINT "Press any key to continue";
      Z$ = INPUT$(1)
   END IF
   IF CurrentEntry = 0 THEN CurrentEntry = 1
   ShowMenu
END SUB

SUB ClearBottom
   LOCATE FormLength + 1, 1
   FOR Lp = FormLength + 1 TO 23
      PRINT BlankLine$
   NEXT Lp
   PRINT BlankLine$;
END SUB

SUB ClearTop
   LOCATE 1, 1
   FOR Lp = 1 TO FormLength
      PRINT BlankLine$
   NEXT Lp
END SUB

SUB DeleteEntry
   ClearBottom
   LOCATE FormLength + 1
   PRINT DashLine$
   PRINT "Entry number to delete ==> ";
   LINE INPUT Item$
   Item = VAL(Item$)
   IF Item > 0 AND Item <= LastEntry THEN
      PRINT Entry(Item).LastName$; " ";
      PRINT Entry(Item).FirstName$; " ";
      PRINT Entry(Item).Phone$
      PRINT "Delete this entry";
      IF YesNo = "Y" THEN
         FOR Lp = Item TO LastEntry - 1
            Entry(Lp) = Entry(Lp + 1)
         NEXT Lp
         LastEntry = LastEntry - 1
      END IF
   END IF
   ShowMenu
END SUB

FUNCTION FileExists (File$)
  ErrorFlag = 0
  FileNum = FREEFILE
  ON ERROR GOTO ErrorTrap
  OPEN File$ FOR INPUT AS FileNum
  ON ERROR GOTO 0
  CLOSE FileNum
  IF ErrorFlag = 0 THEN
     FileExists = TRUE
  ELSE
     FileExists = FALSE
  END IF
END FUNCTION

FUNCTION GetKey
  DO
     Ch$ = INKEY$
  LOOP UNTIL LEN(Ch$) > 0
  IF LEN(Ch$) = 1 THEN
     GetKey = ASC(UCASE$(Ch$))
  ELSE
     GetKey = -1 * ASC(RIGHT$(Ch$, 1))
  END IF
END FUNCTION

SUB MainDisplay
   CLS
   LOCATE , , 0         'Turn off cursor
   ShowMenu
   DO
      ShowList (CurrentEntry)
      SELECT CASE GetKey
         CASE PgUp
            CurrentEntry = CurrentEntry - FormLength
            IF CurrentEntry < 1 THEN
               CurrentEntry = 1
            END IF
         CASE PgDn
            IF CurrentEntry + FormLength <= LastEntry THEN
               CurrentEntry = CurrentEntry + FormLength
            END IF
         CASE ASC("A")
            AddEntry
         CASE ASC("D")
            DeleteEntry
         CASE Esc
            EXIT SUB
         CASE ELSE
      END SELECT
   LOOP
END SUB

SUB ReadFile
   IF FileExists(FileName$) THEN
      OPEN FileName$ FOR RANDOM AS #1 LEN = RecLen
      LastEntry = LOF(1) \ RecLen
      FOR Lp = 1 TO LastEntry
         GET #1, , Entry(Lp)
      NEXT Lp
      CLOSE #1
      IF LastEntry > 0 THEN
         CurrentEntry = 1
      ELSE
         CurrentEntry = 0
      END IF
   ELSE
      CurrentEntry = 0
      LastEntry = 0
   END IF
END SUB

SUB SaveFile
   IF LastEntry > 0 THEN
      OPEN FileName$ FOR RANDOM AS #1 LEN = RecLen
      FOR Lp = 1 TO LastEntry
         PUT #1, , Entry(Lp)
      NEXT Lp
      CLOSE #1
   END IF
END SUB

SUB ShowList (Start)
   ClearTop
   LOCATE 1, 1
   IF Start > 0 THEN
      FOR Lp = Start TO Start + FormLength - 1
         IF Lp > LastEntry THEN EXIT FOR
         PRINT USING "###_. "; Lp;
         PRINT Entry(Lp).LastName$; " ";
         PRINT Entry(Lp).FirstName$; " ";
         PRINT Entry(Lp).Phone$
      NEXT Lp
   END IF
END SUB

SUB ShowMenu
   ClearBottom
   LOCATE FormLength + 1, 1
   PRINT DashLine$
   PRINT "   Commands:    <PgUp>         <PgDn>  "
   PRINT "                <A>dd Name     <D>elete Name"
   PRINT "                <Esc> to end"
   PRINT DashLine$
END SUB

SUB SortList
   DIM SortChart$(0 TO 3)
   SortChart$(0) = "\": SortChart$(1) = CHR$(179)
   SortChart$(2) = "/": SortChart$(3) = CHR$(196)
   ClearBottom
   LOCATE FormLength + 1, 1
   PRINT DashLine$
   PRINT "    Sorting    ";
   IF LastEntry >= 2 THEN
      FOR Lp1 = 1 TO LastEntry - 1
         FOR Lp2 = Lp1 TO LastEntry
            IF Entry(Lp1).LastName$ > Entry(Lp2).LastName$ THEN
               SWAP Entry(Lp1), Entry(Lp2)
            END IF
         NEXT Lp2
         LOCATE CSRLIN, POS(0) - 1
         PRINT SortChart$(Lp1 MOD 4);
      NEXT Lp1
   END IF
   ShowMenu
END SUB

FUNCTION YesNo$
   PRINT " (y/n) ==> ";
   DO
      Ch$ = UCASE$(INPUT$(1))
   LOOP UNTIL Ch$ = "Y" OR Ch$ = "N"
   PRINT Ch$
   YesNo$ = Ch$
END FUNCTION

