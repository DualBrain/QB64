_TITLE "ParseExample"
'=== Full description for the ParseLine&() function is available
'=== in the separate HTML document.
'=====================================================================
WIDTH 100, 32
REDIM a$(3 TO 4) 'result array (at least one element)



'=== e$ = example description
'=== s$ = used separators (max. 5 chars)
'=== q$ = used quotes (max. 2 chars) (empty = regular ")
'=== l$ = test line to parse
'=====================================================================
e$ = "empty lines or those containing defined separators only, won't give a result"
s$ = " ,.": q$ = ""
l$ = "      ,. , ., ., . ,.,., .,,,,,. ,., "
GOSUB doFunc
e$ = "a simple text line, using space, comma and period as separators and regular quoting"
s$ = " ,.": q$ = ""
l$ = "Hello World, just want to say,greetings " + CHR$(34) + "to all" + CHR$(34) + " from RhoSigma."
GOSUB doFunc
e$ = "now a complex space separated test line with regular quoting and empty quotes"
s$ = " ": q$ = ""
l$ = "     " + CHR$(34) + "  ABC  " + CHR$(34) + " 123 " + CHR$(34) + CHR$(34) + " " + CHR$(34) + CHR$(34) + "X Y Z" + CHR$(34) + CHR$(34)
GOSUB doFunc
e$ = "same space separated test line with reodered quoting and empty quotes"
s$ = " ": q$ = ""
l$ = "       ABC   123" + CHR$(34) + CHR$(34) + CHR$(34) + " X Y Z " + CHR$(34) + CHR$(34) + CHR$(34) + "345  "
GOSUB doFunc
e$ = "again the space separated test line with regular quoting and an unfinished (EOL) quote"
s$ = " ": q$ = ""
l$ = "       ABC   123" + CHR$(34) + " " + CHR$(34) + " X Y Z " + CHR$(34) + " " + CHR$(34) + CHR$(34) + "345  "
GOSUB doFunc
e$ = "an opening quote at EOL is in fact an empty quote, it adds another empty array element"
s$ = " ": q$ = ""
l$ = "  " + CHR$(34) + "a final open quote is empty" + CHR$(34) + "   " + CHR$(34)
GOSUB doFunc
'-----------------------------
'-----------------------------
e$ = "a SUB declaration line using paranthesis as TWO char quoting"
s$ = " ": q$ = "()"
l$ = "SUB RectFill (lin%, col%, hei%, wid%, fg%, bg%, ch$)"
GOSUB doFunc
e$ = "same SUB line with many extra paranthesis, showing that TWO char quoting avoids nesting"
s$ = " ": q$ = "()"
l$ = "SUB RectFill (lin%, col%, ((hei%)), wid%, (fg%), bg%, (ch$))"
GOSUB doFunc
'-----------------------------
'-----------------------------
e$ = "space separated command line with regular quoting"
s$ = " ": q$ = ""
l$ = "--testfile " + CHR$(34) + "C:\My Folder\My File.txt" + CHR$(34) + " --testmode --output logfile.txt"
GOSUB doFunc
e$ = "space and/or equal sign separated command line with regular quoting"
s$ = " =": q$ = ""
l$ = "--testfile=" + CHR$(34) + "C:\My Folder\My File.txt" + CHR$(34) + " --testmode --output=logfile.txt"
GOSUB doFunc
e$ = "space and/or equal sign separated command line with alternative ONE char quoting"
s$ = " =": q$ = "|"
l$ = "--testfile=|C:\My Folder\My File.txt| --testmode --output=logfile.txt"
GOSUB doFunc
e$ = "space and/or equal sign separated command line with alternative TWO char quoting"
s$ = " =": q$ = "{}"
l$ = "--testfile={C:\My Folder\My File.txt} --testmode --output=logfile.txt"
GOSUB doFunc
'-----------------------------
'-----------------------------
e$ = "parsing a filename using (back)slashes as separators but NO spaces"
s$ = "\/": q$ = ""
l$ = "C:\My Folder\My File.txt"
GOSUB doFunc
e$ = "for quoted filenames the quoting char(s) must be separators instead of quotes (see source)"
'NOTE: a char cannot be used as separator and quote at the same time
s$ = "\/" + CHR$(34): q$ = "*" '* is not allowd in filenames, so it's perfect to knock out the regular quote here
l$ = CHR$(34) + "C:\My Folder\My File.txt" + CHR$(34)
GOSUB doFunc
'=====================================================================
SYSTEM



'-- This GOSUB subroutine will execute the examples from above and
'-- print the given inputs and function results.
doFunc:
CLS
COLOR 12: PRINT "square brackets just used to better visualize the start and end of strings ..."
PRINT
COLOR 14: PRINT "Example: ";: COLOR 10: PRINT e$
PRINT
COLOR 15
PRINT "given input to function:"
PRINT "------------------------"
COLOR 14: PRINT "      Line: ";: COLOR 12: PRINT "[";: COLOR 7: PRINT l$;: COLOR 12: PRINT "]"
COLOR 14: PRINT "Separators: ";: COLOR 12: PRINT "[";: COLOR 7: PRINT s$;: COLOR 12: PRINT "]"
COLOR 14: PRINT "    Quotes: ";: COLOR 12: PRINT "[";: COLOR 7: PRINT q$;: COLOR 12: PRINT "]";: COLOR 3: PRINT " (empty = " + CHR$(34) + ")     "
PRINT
COLOR 14: PRINT "     Array: ";: COLOR 7: PRINT "LBOUND ="; LBOUND(a$), "UBOUND ="; UBOUND(a$)
PRINT
res& = ParseLine&(l$, s$, q$, a$(), 0)
COLOR 15
PRINT "result of function call (new UBOUND or -1 for nothing to parse):"
PRINT "----------------------------------------------------------------"
COLOR 14: PRINT "Result: ";: COLOR 7: PRINT res&
PRINT
IF res& > 0 THEN
    COLOR 15
    PRINT "array dump:"
    PRINT "-----------"
    FOR x& = LBOUND(a$) TO UBOUND(a$)
        COLOR 14: PRINT "Index:";: COLOR 7: PRINT x&,
        COLOR 14: PRINT "Content: ";: COLOR 12: PRINT "[";: COLOR 7: PRINT a$(x&);: COLOR 12: PRINT "]"; TAB(80);
        COLOR 14: PRINT "Length:";: COLOR 7: PRINT LEN(a$(x&))
    NEXT x&
    PRINT
END IF
PRINT "press any key ...": SLEEP
RETURN





'--- Full description available in separate HTML document.
'---------------------------------------------------------------------
FUNCTION ParseLine& (inpLine$, sepChars$, quoChars$, outArray$(), minUB&)
'--- option _explicit requirements ---
DIM ilen&, icnt&, slen%, s1%, s2%, s3%, s4%, s5%, q1%, q2%
DIM oalb&, oaub&, ocnt&, flag%, ch%, nest%, spos&, epos&
'--- so far return nothing ---
ParseLine& = -1
'--- init & check some runtime variables ---
ilen& = LEN(inpLine$): icnt& = 1
IF ilen& = 0 THEN EXIT FUNCTION
slen% = LEN(sepChars$)
IF slen% > 0 THEN s1% = ASC(sepChars$, 1)
IF slen% > 1 THEN s2% = ASC(sepChars$, 2)
IF slen% > 2 THEN s3% = ASC(sepChars$, 3)
IF slen% > 3 THEN s4% = ASC(sepChars$, 4)
IF slen% > 4 THEN s5% = ASC(sepChars$, 5)
IF slen% > 5 THEN slen% = 5 'max. 5 chars, ignore the rest
IF LEN(quoChars$) > 0 THEN q1% = ASC(quoChars$, 1): ELSE q1% = 34
IF LEN(quoChars$) > 1 THEN q2% = ASC(quoChars$, 2): ELSE q2% = q1%
oalb& = LBOUND(outArray$): oaub& = UBOUND(outArray$): ocnt& = oalb&
'--- skip preceding separators ---
plSkipSepas:
flag% = 0
WHILE icnt& <= ilen& AND NOT flag%
    ch% = ASC(inpLine$, icnt&)
    SELECT CASE slen%
        CASE 0: flag% = -1
        CASE 1: flag% = ch% <> s1%
        CASE 2: flag% = ch% <> s1% AND ch% <> s2%
        CASE 3: flag% = ch% <> s1% AND ch% <> s2% AND ch% <> s3%
        CASE 4: flag% = ch% <> s1% AND ch% <> s2% AND ch% <> s3% AND ch% <> s4%
        CASE 5: flag% = ch% <> s1% AND ch% <> s2% AND ch% <> s3% AND ch% <> s4% AND ch% <> s5%
    END SELECT
    icnt& = icnt& + 1
WEND
IF NOT flag% THEN 'nothing else? - then exit
    IF ocnt& > oalb& GOTO plEnd
    EXIT FUNCTION
END IF
'--- redim to clear array on 1st word/component ---
IF ocnt& = oalb& THEN REDIM outArray$(oalb& TO oaub&)
'--- expand array, if required ---
plNextWord:
IF ocnt& > oaub& THEN
    oaub& = oaub& + 10
    REDIM _PRESERVE outArray$(oalb& TO oaub&)
END IF
'--- get current word/component until next separator ---
flag% = 0: nest% = 0: spos& = icnt& - 1
WHILE icnt& <= ilen& AND NOT flag%
    IF ch% = q1% AND nest% = 0 THEN
        nest% = 1
    ELSEIF ch% = q1% AND nest% > 0 THEN
        nest% = nest% + 1
    ELSEIF ch% = q2% AND nest% > 0 THEN
        nest% = nest% - 1
    END IF
    ch% = ASC(inpLine$, icnt&)
    SELECT CASE slen%
        CASE 0: flag% = (nest% = 0 AND (ch% = q1%)) OR (nest% = 1 AND ch% = q2%)
        CASE 1: flag% = (nest% = 0 AND (ch% = s1% OR ch% = q1%)) OR (nest% = 1 AND ch% = q2%)
        CASE 2: flag% = (nest% = 0 AND (ch% = s1% OR ch% = s2% OR ch% = q1%)) OR (nest% = 1 AND ch% = q2%)
        CASE 3: flag% = (nest% = 0 AND (ch% = s1% OR ch% = s2% OR ch% = s3% OR ch% = q1%)) OR (nest% = 1 AND ch% = q2%)
        CASE 4: flag% = (nest% = 0 AND (ch% = s1% OR ch% = s2% OR ch% = s3% OR ch% = s4% OR ch% = q1%)) OR (nest% = 1 AND ch% = q2%)
        CASE 5: flag% = (nest% = 0 AND (ch% = s1% OR ch% = s2% OR ch% = s3% OR ch% = s4% OR ch% = s5% OR ch% = q1%)) OR (nest% = 1 AND ch% = q2%)
    END SELECT
    icnt& = icnt& + 1
WEND
epos& = icnt& - 1
IF ASC(inpLine$, spos&) = q1% THEN spos& = spos& + 1
outArray$(ocnt&) = MID$(inpLine$, spos&, epos& - spos&)
ocnt& = ocnt& + 1
'--- more words/components following? ---
IF flag% AND ch% = q1% AND nest% = 0 GOTO plNextWord
IF flag% GOTO plSkipSepas
IF (ch% <> q1%) AND (ch% <> q2% OR nest% = 0) THEN outArray$(ocnt& - 1) = outArray$(ocnt& - 1) + CHR$(ch%)
'--- final array size adjustment, then exit ---
plEnd:
IF ocnt& - 1 < minUB& THEN ocnt& = minUB& + 1
REDIM _PRESERVE outArray$(oalb& TO (ocnt& - 1))
ParseLine& = ocnt& - 1
END FUNCTION

