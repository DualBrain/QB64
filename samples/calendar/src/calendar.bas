' Antonio & Alfonso De Pasquale
' Copyright (C) 1993 DOS Resource Guide
' Published in Issue #8, March 1993, page 47
'
' PERPETUAL CALENDAR PROGRAM

Setup:
    CLS
    CLEAR
    DIM Year(12, 6, 7), Month$(12), Month(12), Day$(7)
    FOR X = 1 TO 12
        FOR Y = 0 TO 6
            FOR Z = 0 TO 7
                Year(X, Y, Z) = 0
            NEXT Z
        NEXT Y
    NEXT X

GetYear:
    CLS
    PRINT TAB(30); "Calendar Creator"
    PRINT
    PRINT TAB(20); "By Antonio and Alfonso De Pasquale"
    PRINT
    INPUT "What is the calendar year you want"; Year$
    YR = VAL(Year$)
   
    IF YR < 1753 THEN
        PRINT
        PRINT "Year must be greater than 1752.  ";
        INPUT "Press <Enter> to try again"; A$
        GOTO GetYear
    END IF
   
    PRINT
    PRINT "Please make sure your printer is turned on and is on-line"
    PRINT "Also, make sure the paper is set to the top of the form"
    PRINT
    INPUT "Press <Enter> when you are ready to continue"; A$
    PRINT
    PRINT "Calculating dates...please wait"
    PRINT

CalcYear:
    C = INT(YR / 100)
    IF RIGHT$(STR$(YR), 2) = "00" THEN C = C - 1
    D = (YR - (100 * C)) - 1
    IF D = -1 THEN D = 99
    K = 1
    M = 11
    X = (INT(2.6 * M - .2) + K + D + INT(D / 4) + INT(C / 4) - (2 * C)) / 7
    G = ABS(X - INT(X))
    F = INT(7 * G + .00001) + 1

    IF (YR / 4) = INT(YR / 4) AND RIGHT$(Year$, 2) <> "00" THEN
        LY = 1
        GOTO FillYear
    END IF

    IF (YR / 400) = INT(YR / 400) AND RIGHT$(Year$, 2) = "00" THEN
        LY = 1
        GOTO FillYear
    END IF

    LY = 0

FillYear:
    FOR X = 1 TO 7
        READ Day$(X)
    NEXT X
    FOR X = 1 TO 12
        READ Month$(X)
    NEXT X
    FOR X = 1 TO 12
        READ Month(X)
    NEXT X
    IF LY = 1 THEN Month(2) = 29

    FOR X = 1 TO 12
        R = 1
        FOR G = 1 TO Month(X)
            Year(X, R, F) = G
            F = F + 1
            IF F = 8 THEN F = 1: R = R + 1
        NEXT G
    NEXT X
    DATA S,M,T,W,T,F,S
    DATA JANUARY,FEBRUARY,MARCH,APRIL,MAY,JUNE,JULY
    DATA AUGUST,SEPTEMBER,OCTOBER,NOVEMBER,DECEMBER
    DATA 31,28,31,30,31,30,31,31,30,31,30,31

BuildCalendar:
    LPRINT
    LPRINT
    LPRINT SPACE$(36);
    FOR X = 1 TO 5
        LPRINT MID$(Year$, X, 1); " ";
    NEXT X
    LPRINT
    LPRINT
    FOR I = 1 TO 12 STEP 2
        GOSUB PrintStars
        GOSUB PrintMonth
        GOSUB PrintWeek
        FOR Week = 1 TO 6
            LPRINT SPACE$(7);
            LPRINT "* ";
            FOR X = 1 TO 7
                SELECT CASE Year(I, Week, X)
                    CASE IS = 0
                        LPRINT SPACE$(4);
                    CASE IS < 10
                        SPV = 1
                        LPRINT SPACE$(SPV); Year(I, Week, X);
                    CASE IS > 9
                        SPV = 0
                        LPRINT SPACE$(SPV); Year(I, Week, X);
                END SELECT
            NEXT X
            LPRINT SPACE$(2); "* ";
            FOR X = 1 TO 7
                SELECT CASE Year(I + 1, Week, X)
                    CASE IS = 0
                        LPRINT SPACE$(4);
                    CASE IS < 10
                        SPV = 1
                        LPRINT SPACE$(SPV); Year(I + 1, Week, X);
                    CASE IS > 9
                        SPV = 0
                        LPRINT SPACE$(SPV); Year(I + 1, Week, X);
                END SELECT
            NEXT X
            LPRINT SPACE$(2); "*"
        NEXT Week
    NEXT I
    GOSUB PrintStars
    LPRINT CHR$(12)
    PRINT "Calendar has been printed."
    END

PrintStars:
    LPRINT SPACE$(7);
    FOR A = 1 TO 65
        LPRINT "*";
    NEXT A
    LPRINT
    RETURN

PrintMonth:
    FOR B = 1 TO 12 STEP 2
        IF B = I THEN
            GOSUB FindMonth
        END IF
    NEXT B
    RETURN

PrintWeek:
    LPRINT SPACE$(7);
    LPRINT "*"; SPACE$(3);
    FOR D = 1 TO 2
        FOR D1 = 1 TO 7
            LPRINT Day$(D1); SPACE$(3);
        NEXT D1
        LPRINT "*"; SPACE$(3);
    NEXT D
    LPRINT
    RETURN

FindMonth:
    T1 = LEN(Month$(B))
    T2 = LEN(Month$(B + 1))
    T3 = INT((33 - T1) / 2)
    T4 = INT((33 - T2) / 2)
    LPRINT SPACE$(7); "*";
    LPRINT SPACE$(T3); Month$(B);
    RT = 33 - T3 - T1
    LPRINT SPACE$(RT - 2); "*";
    LPRINT SPACE$(T4); Month$(B + 1);
    RT = 33 - T4 - T2
    LPRINT SPACE$(RT - 2); "*";
    LPRINT
    RETURN

