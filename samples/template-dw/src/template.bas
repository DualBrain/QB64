' TEMPLATE.BAS
'   by Tim Syrop
' Copyright (C) 1994 DOS World
' Published in Issue #18, November 1994, page 62

DECLARE SUB DrawBox (LR%, LC%, RR%, RC%, SC%, FC%, BC%)
DECLARE SUB Pause (Delay!)
DECLARE SUB Beeper ()
DECLARE SUB Centext (Row%, Text$)

DrawBox 10, 15, 16, 61, 1, 0, 11
Centext 13, "This text is will be centered on row 13."
Pause 1.9
Beeper

SUB Beeper
  PLAY "o3L20af"
END SUB

SUB Centext (Row%, Text$)
  LOCATE Row%, 40 - LEN(Text$) / 2
  PRINT Text$
END SUB

SUB DrawBox (LR%, LC%, RR%, RC%, SC%, FC%, BC%)

  COLOR , SC%
  CLS
  COLOR FC%, BC%

  LOCATE LR%, LC%: PRINT " "; "�"; STRING$(RC% - LC%, "�"); "� "
  LOCATE RR%, LC%: PRINT " "; "�"; STRING$(RC% - LC%, "�"); "� "

  FOR Sides% = LR% TO RR% - 2
    LOCATE Sides% + 1, LC%: PRINT " �"; SPACE$(RC% - LC%); "� "
  NEXT Sides%

  FOR Shade% = LR% TO RR%
    LOCATE Shade% + 1, RC% + 4: PRINT "��"
  NEXT

  LOCATE RR% + 1, LC% + 2: PRINT STRING$(RC% - LC% + 2, "�")

END SUB

SUB Pause (Delay!)
 
  Paused# = TIMER
  DO
    Trash$ = INKEY$
    Trash$ = ""
  LOOP UNTIL TIMER > Paused# + Delay!

END SUB

