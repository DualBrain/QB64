DECLARE SUB SetDefaults (Principal!, Months!, AnnualInt!, Extra!, EndProg!)
DECLARE SUB GetInputs (Principal!, Months!, AnnualInt!)
DECLARE SUB FinCalc (Principal!, Months!, AnnualInt!, MonthInt!, Payment!)
DECLARE SUB GetExtra (Principal!, Months!, Payment!, Extra!)
DECLARE SUB PrintIt (Principal!, Months!, AnnualInt!, MonthInt!, Payment!, Extra!, EndProg!)
DECLARE FUNCTION Min! (A!, B!)
DECLARE FUNCTION ROUND2! (Value!)
'
' Loan amortization program
' Alan Zeichick, March 16, 1993
' Copyright (c) 1993 DOS Resource Guide
' Published in Issue #11, September 1993, page 49
'
' This program produces a loan amortization table, given
' the amount of a loan, number of payments, annual interest
' rate, and extra money (if any) to be paid each month.
'
'
' Here is the main program
'
CONST False = 0, True = 1

CALL SetDefaults(Principal, Months, AnnualInt, Extra, EndProg)

WHILE EndProg = False

   CALL GetInputs(Principal, Months, AnnualInt)
   CALL FinCalc(Principal, Months, AnnualInt, MonthInt, Payment)
   CALL GetExtra(Principal, Months, Payment, Extra)
   CALL PrintIt(Principal, Months, AnnualInt, MonthInt, Payment, Extra, EndProg)

WEND

END

SUB FinCalc (Principal, Months, AnnualInt, MonthInt, Payment)

MonthInt = AnnualInt / 12

Payment = (Principal * (MonthInt / (1 - (1 + MonthInt) ^ -Months)))
             
END SUB

SUB GetExtra (Principal, Months, Payment, Extra)

PRINT
PRINT "Based on your input data,"
PRINT "   The monthly payment is $"; ROUND2(Payment)
PRINT "   The sum of payments is $"; ROUND2(Payment * Months)
PRINT "   The total amount of interest to be paid is $"; ROUND2(Payment * Months - Principal)
PRINT
PRINT "Enter any additional payment amount (default=$"; Extra; ") ";
INPUT Answer$
IF Answer$ <> "" THEN Extra = VAL(Answer$)
END SUB

SUB GetInputs (Principal, Months, AnnualInt)

CLS
PRINT "What principal amount do you wish to use? (default=$"; Principal; ")"
PRINT "Please do not enter the dollar sign or commas."
INPUT Answer$
IF Answer$ <> "" THEN Principal = VAL(Answer$)

PRINT "How many months does the loan cover? (default="; Months; ")"
INPUT Answer$
IF Answer$ <> "" THEN Months = VAL(Answer$)

PRINT "What is the annual interest rate? (default="; AnnualInt * 100; "%)"
INPUT Answer$
IF Answer$ <> "" THEN AnnualInt = VAL(Answer$)
IF AnnualInt > 1 THEN AnnualInt = AnnualInt / 100

END SUB

FUNCTION Min (A, B)

IF A < B THEN Min = A ELSE Min = B

END FUNCTION

SUB PrintIt (Principal, Months, AnnualInt, MonthInt, Payment, Extra, EndProg)

OkayToProceed = False

WHILE OkayToProceed = False
   PRINT
   PRINT "Do you wish to:"
   PRINT "   S - Output amortization table to screen"
   PRINT "   P - Send amortization table to printer"
   PRINT "   D - Output as printable disk file"
   PRINT "   C - Create a comma-delimited data file"
   PRINT "   R - Restart without printing table"
   PRINT "   Q - Quit program"
   PRINT "(default=S) ";
   INPUT DESTINATION$
   DESTINATION$ = UCASE$(LEFT$(DESTINATION$ + "S", 1))
   IF INSTR("SPDCRQ", DESTINATION$) > 0 THEN OkayToProceed = True
   WEND

filenum = FREEFILE

IF INSTR("CD", DESTINATION$) THEN
   PRINT "Please enter disk file name (default=C:\AMORT.OUT) ";
   INPUT OutputFile$
   IF OutputFile$ = "" THEN OutputFile$ = "C:\AMORT.OUT"
   OPEN OutputFile$ FOR OUTPUT AS filenum
   END IF

IF DESTINATION$ = "P" THEN OPEN "prn" FOR OUTPUT AS filenum

IF DESTINATION$ = "S" THEN OPEN "scrn:" FOR OUTPUT AS filenum

IF INSTR("DPS", DESTINATION$) THEN
   PRINT #filenum, "Amortization table"
   PRINT #filenum, "Principal = $"; Principal; ""
   PRINT #filenum, "Annual Interest Rate ="; 100 * AnnualInt; "%"
   PRINT #filenum, "Monthly Interest Rate ="; 100 * MonthInt; "%"
   PRINT #filenum, "Basic monthly payment = $"; ROUND2(Payment)
   PRINT #filenum, "Extra amount towards principal = $"; Extra
   PRINT #filenum,
   PRINT #filenum, "Payment     Principal     Interest      Applied        Extra      New Balance"

END IF

IF DESTINATION$ = "C" THEN
   WRITE #filenum, "Payment", "Principal", "Interest", "Applied", "Extra", "New Balance"
   END IF

IF INSTR("CDPS", DESTINATION$) THEN
   
   TotalInterest = 0
   PaymentNumber = 0
   Balance = Principal

   WHILE Balance > 0
     
      InterestAmount = Balance * MonthInt
      PrincipalAmount = Min(Payment - InterestAmount, Balance)
      ExtraAmount = Min(Balance - PrincipalAmount, Extra)
      NewBalance = Balance - PrincipalAmount - ExtraAmount
      PaymentNumber = PaymentNumber + 1
     
      TotalInterest = TotalInterest + InterestAmount
      TotalPayments = TotalPayments + PrincipalAmount
      TotalExtra = TotalExtra + ExtraAmount
     
      IF INSTR("DPS", DESTINATION$) THEN
         PRINT #filenum, USING "####"; PaymentNumber;
         PRINT #filenum, USING " $$###,###,###.##"; Balance;
         PRINT #filenum, USING " $$###,###.##"; InterestAmount;
         PRINT #filenum, USING " $$###,###.##"; PrincipalAmount;
         PRINT #filenum, USING " $$###,###.##"; ExtraAmount;
         PRINT #filenum, USING " $$###,###,###.##"; NewBalance
      ELSE
         WRITE #filenum, PaymentNumber, Balance, InterestAmount, PrincipalAmount, ExtraAmount, NewBalance
      END IF
     
      Balance = NewBalance
     
   WEND

   AmountSaved = ROUND2(Months * Payment - Principal - TotalInterest)

   IF DESTINATION$ = "DP" THEN
      PRINT #filenum,
      PRINT #filenum, "Actual number of payments ="; PaymentNumber;
      PRINT #filenum, "you saved"; Months - PaymentNumber; "months."
      PRINT #filenum, "Actual amount of interest paid = $"; ROUND2(TotalInterest);
      PRINT #filenum, "you saved $"; ROUND2(AmountSaved)
   END IF
  
   PRINT
   PRINT "Actual number of payments ="; PaymentNumber;
   PRINT "you saved"; Months - PaymentNumber; "months."
   PRINT "Actual amount of interest paid = $"; ROUND2(TotalInterest);
   PRINT "you saved $"; ROUND2(AmountSaved)

   CLOSE #filenum

END IF

IF DESTINATION$ <> "Q" THEN
   PRINT "Enter Q to end program, anything else to continue:"
   INPUT Answer$
END IF

IF DESTINATION$ = "Q" OR UCASE$(LEFT$(Answer$, 1)) = "Q" THEN
   EndProg = True
ELSE
   EndProg = False
END IF

END SUB

FUNCTION ROUND2 (Value)
  
   ROUND2 = INT(Value * 100 + .5) / 100

END FUNCTION

SUB SetDefaults (Principal, Months, AnnualInt, Extra, EndProg)
Principal = 10000
Months = 48
AnnualInt = .08
Extra = 0
EndProg = False
END SUB

