'   CALC.BAS
'      by William Loughner
'   Copyright (c) 1994 DOS Resource Guide
'   Published in Issue #14, March 1994, page 58

DO
Total = 0: Calculation$ = "": Op$ = "+": Key$ = "x": NegFlag% = 0
DO
GOSUB GetKeyStroke
SELECT CASE Key$
	CASE "(", "["
		IF NParen% = 1 THEN
			Key$ = ""
		ELSE
			IF NegFlag% = 1 THEN ParenNeg% = 1: NegFlag% = 0
			Operand$ = "": NParen% = 1: ParenTotal = Total: Total = 0
			ParenOp$ = Op$: Op$ = "+"
		END IF
	CASE ")", "]"
		IF NParen% = 0 THEN
			Key$ = ""
		ELSE
			GOSUB Operate: IF ParenNeg% = 1 THEN Total = -Total: ParenNeg% = 0
			Op$ = ParenOp$: Operand$ = STR$(Total): Total = ParenTotal
			GOSUB Operate: NParen% = 0
		END IF
	CASE "=", CHR$(13)
		IF NParen% = 1 THEN
			Key$ = ""
		ELSE
			GOSUB Operate: EXIT DO
		END IF
	CASE "s", "+", "*", "/", "^"
		GOSUB Operate: NegFlag% = 0: IF Key$ = "s" THEN Key$ = "-"
	CASE "-", ".", "0" TO "9"
		Operand$ = Operand$ + Key$: NegFlag% = 1
	CASE ELSE
		Key$ = ""
END SELECT
Calculation$ = Calculation$ + Key$
LOOP
GOSUB GetKeyStroke
LOOP

GetKeyStroke:
CLS : PRINT "Calculation: "; Calculation$
LOCATE 7, 1: PRINT "Running total: "; Total
SELECT CASE Key$
	CASE ""
		PRINT "** You can't do that **"
	CASE "=", CHR$(13)
		PRINT "** ANSWER **   (Press X to quit, any other key to calculate again.)"
END SELECT
DO: Key$ = INKEY$: LOOP UNTIL Key$ <> ""
SELECT CASE Key$
	CASE "x", "X"
		END
	CASE "-"
		IF NegFlag% = 1 THEN Key$ = "s"
END SELECT
RETURN

Operate:
Operand = VAL(Operand$): Operand$ = ""
SELECT CASE Op$
	CASE "+"
		Total = Total + Operand
	CASE "s"
		Total = Total - Operand
	CASE "*"
		Total = Total * Operand
	CASE "/"
		Total = Total / Operand
	CASE "^"
		Total = Total ^ Operand
END SELECT
Op$ = Key$
RETURN

