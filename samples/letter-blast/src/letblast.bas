'   LETBLAST.BAS - Shoot the falling letters!
'      by Antonio & Alfonso De Pasquale
'
'   Copyright (C) 1993 DOS Resource Guide
'   Published in Issue #9, May 1993, page 50
'
' --------------------------------------------------------------
' Last modified by Robert Smith on 22 Jun 2006
' --Increased difficulty by penalizing player with
'   a strike if the player strikes the wrong key.
' --Added two new difficulties; training and really slow
'   because I suck at typing.
' Version number# 1.1
' --------------------------------------------------------------
DECLARE SUB CENTER (m$)
DECLARE SUB BOX (r1, c1, r2, c2)
SETUP:
    CLS
    BOX 1, 5, 5, 75
    BOX 7, 21, 18, 59
    LOCATE 2, 6: CENTER "**  Letter Blaster  **"
    LOCATE 3, 6: CENTER "By"
    LOCATE 4, 6: CENTER "Antonio & Alfonso De Pasquale & Robert Smith"
    LOCATE 8, 26: PRINT "Please select a game speed:"
    LOCATE 10, 30: PRINT "(T)raining"
    LOCATE 11, 30: PRINT "(R)eally Slow"
    LOCATE 12, 30: PRINT "(S)low"
    LOCATE 13, 30: PRINT "(I)intermediate"
    LOCATE 14, 30: PRINT "(F)ast"
    LOCATE 15, 30: PRINT "(Q)uit This Game"
   
    DO
        speed$ = ""
        LOCATE 17, 26: INPUT "Enter your selection: ", speed$
        speed$ = UCASE$(LEFT$(speed$, 1))
    LOOP UNTIL (INSTR(1, "TRSIFQ", speed$))
    IF speed$ = "Q" THEN
        CLS
        END
    END IF
    BOX 19, 5, 21, 75
    LOCATE 20, 6: CENTER "Press <ENTER> to begin playing"
    DO: LOOP UNTIL INKEY$ = CHR$(13)
    GOSUB SETSPEED
    GOSUB SETVARS
    GOSUB PLAYGAME
    GOSUB FINALSCORE
    GOTO SETUP
SETSPEED:
    SELECT CASE speed$
        CASE "T"
            delay = 1 / 4
        CASE "R"
            delay = 1 / 8
        CASE "S"
            delay = 1 / 16
        CASE "I"
            delay = 1 / 32
        CASE "F"
            delay = 1 / 64
    END SELECT
    RETURN
SETVARS:
    score = 0: strike = 0: pass = 0: maxpass = 50: mdl = 50
    char$ = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    numchars = 26
    t1 = VAL(LEFT$(TIME$, 2))
    t2 = VAL(MID$(TIME$, 3, 2))
    t3 = VAL(RIGHT$(TIME$, 2))
    tt = t1 + t2 + t3
    RANDOMIZE (tt + tt * 100)
    RETURN
PLAYGAME:
    CLS
    BOX 1, 5, 3, 75
    LOCATE 2, 6: CENTER "**  Letter Blaster  **"
    BOX 21, 1, 23, 79
    LOCATE 22, 67: PRINT USING "Score: ####"; score
    DO
        lt = INT(RND * numchars) + 1: lt$ = MID$(char$, lt, 1)
        hp = INT(RND * 70) + 5: vp = 4
        DO
            LOCATE vp, hp
            PRINT lt$
            Begin! = TIMER
            DO UNTIL ABS(TIMER - Begin!) > delay
            LOOP
            LOCATE vp, hp
            PRINT " "
            vp = vp + 1
            Key$ = UCASE$(INKEY$)
        LOOP UNTIL (vp = 20) OR (Key$ <> "")
        IF (Key$ <> lt$) THEN vp = 21
        IF vp < 20 THEN
            score = score + 1
            LOCATE vp, hp: PRINT lt$
            FOR x = 20 TO vp STEP -1
                LOCATE x, hp: PRINT "*"
                FOR y = 1 TO mdl: NEXT y
                LOCATE x, hp: PRINT " "
            NEXT x
           
            SOUND 800, 3
            LOCATE 22, 67: PRINT USING "Score: ####"; score
        ELSE
            strike = strike + 1
            SOUND 50, 8
            SELECT CASE strike
                CASE 1
                    tb = 3
                CASE 2
                    tb = 14
                CASE 3
                    tb = 25
            END SELECT
            LOCATE 22, tb: PRINT USING "STRIKE #"; strike
        END IF
        pass = pass + 1
    LOOP UNTIL (strike = 3) OR (pass = maxpass)
    LOCATE 22, 2: PRINT SPACE$(76)
    LOCATE 22, 2: CENTER "Game Over!    Press <ENTER> to continue"
    DO: LOOP UNTIL INKEY$ = CHR$(13)
    RETURN
FINALSCORE:
    CLS
    BOX 1, 5, 3, 75
    LOCATE 2, 6: CENTER "**  Letter Blaster  **"
    BOX 6, 5, 16, 75
    LOCATE 8, 6: CENTER "Your final score is " + LTRIM$(STR$(score)) + " points"
    LOCATE 9, 6: CENTER "on " + LTRIM$(STR$(pass)) + " letters."
   
    SELECT CASE score
        CASE IS < 11
            m$ = "Come on!  You can do better than that!"
        CASE IS < 21
            m$ = "Not bad. But there's still room for improvement."
        CASE IS < 31
            m$ = "Pretty good. You're getting better."
        CASE IS < 50
            m$ = "All right! You're well on your way to perfection."
        CASE 50
            m$ = "Perfect! You are a master of the keyboard!"
    END SELECT
   
    LOCATE 11, 6: CENTER m$
    LOCATE 14, 6: CENTER "Press <ENTER> to continue"
    DO: LOOP UNTIL INKEY$ = CHR$(13)
    RETURN

SUB BOX (r1, c1, r2, c2)
  
    LOCATE r1, c1
    PRINT CHR$(218);
    FOR x = (c1 + 1) TO (c2 - 1)
        PRINT CHR$(196);
    NEXT x
    PRINT CHR$(191)
    FOR x = (r1 + 1) TO (r2 - 1)
        LOCATE x, c1
        PRINT CHR$(179); SPACE$(c2 - c1 - 1); CHR$(179)
    NEXT x
    LOCATE r2, c1
    PRINT CHR$(192);
    FOR x = (c1 + 1) TO (c2 - 1)
        PRINT CHR$(196);
    NEXT x
    PRINT CHR$(217)
END SUB

SUB CENTER (m$)
    PRINT TAB(40 - (LEN(m$) / 2)); m$
END SUB

