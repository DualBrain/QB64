DECLARE FUNCTION hash (s$)
DECLARE FUNCTION READOBJ (depth)
DECLARE FUNCTION READTOKEN (depth)
DECLARE FUNCTION STRTOATOM (s$)
DECLARE FUNCTION CONS (car, cdr)
DECLARE FUNCTION READLIST (depth)
DECLARE FUNCTION ALLOC ()
DECLARE SUB PRINTOBJ (id)
DECLARE FUNCTION EVALOBJ (id, env)
DECLARE FUNCTION apply (f, args)
DECLARE FUNCTION lookup (anum, env)
DECLARE FUNCTION lvals (id, env)
DECLARE SUB defvar (var, vals, env)
DECLARE SUB setvar (id, vals, env)
DECLARE FUNCTION mkprimop (id)
DECLARE FUNCTION collect(p)
DECLARE SUB gc(root)
DECLARE FUNCTION DoLISP$(TheStringIn$, envin)

' Make these smaller to get it to work in QBASIC / QuickBASIC
Const msize = 16384 'size of memory -- arbitrary
Const hsize = 4096 'size of hash table -- should be power of 2

Dim Shared bufpos As Integer, state As Integer
Dim Shared buf As String
Dim Shared hptr
Dim Shared atom$(0 To hsize - 1), heap(2 * msize - 1, 2)
Dim Shared mmin, nmin, gcnow

mmin = 1: nmin = msize

Dim Shared TheInput$
Dim Shared TheOutput$

Const TRUE = -1
Const FALSE = 0
Const TNIL = 0
Const TCONS = 2
Const TNUM = 3
Const TSYM = 4
Const TPROC = 5
Const TPPROC = 6
Const TOKNIL = 0
Const TOKERR = -1
Const TOKOPEN = -2
Const TOKCLOSE = -3
Const TOKQUOTE = -4
Const TOKDOT = -5

Const PPLUS = 1
Const PMINUS = 2
Const PTIMES = 3
Const PCONS = 4
Const PCAR = 5
Const PCDR = 6
Const PEQUAL = 7
Const PNOT = 8
Const PEQ = 9
Const PSETCAR = 10
Const PSETCDR = 11
Const PAPPLY = 12
Const PLIST = 13
Const PREAD = 14
Const PLT = 15
Const PGT = 16
Const PGEQ = 17
Const PLEQ = 18
Const PNUMP = 20
Const PPROCP = 21
Const PSYMP = 22
Const PCONSP = 24

'''''

$Console
_Dest _Console

GoSub KickStartLISP

Do
    Line Input a$
    Print DoLISP$(a$, env)
Loop

End


KickStartLISP:
hptr = mmin: bufpos = 1
vars = TNIL
vals = TNIL
frame = CONS(vars, vals)
env = CONS(frame, TNIL)
Call defvar(STRTOATOM("+"), mkprimop(PPLUS), env)
Call defvar(STRTOATOM("-"), mkprimop(PMINUS), env)
Call defvar(STRTOATOM("*"), mkprimop(PTIMES), env)
Call defvar(STRTOATOM("CONS"), mkprimop(PCONS), env)
Call defvar(STRTOATOM("CAR"), mkprimop(PCAR), env)
Call defvar(STRTOATOM("CDR"), mkprimop(PCDR), env)
Call defvar(STRTOATOM("="), mkprimop(PEQUAL), env)
Call defvar(STRTOATOM("NOT"), mkprimop(PNOT), env)
Call defvar(STRTOATOM("EQ?"), mkprimop(PEQ), env)
Call defvar(STRTOATOM("EQV?"), mkprimop(PEQ), env)
Call defvar(STRTOATOM("T"), STRTOATOM("T"), env) ' true
Call defvar(STRTOATOM("SET-CAR!"), mkprimop(PSETCAR), env)
Call defvar(STRTOATOM("SET-CDR!"), mkprimop(PSETCDR), env)
Call defvar(STRTOATOM("APPLY"), mkprimop(PAPPLY), env)
Call defvar(STRTOATOM("LIST"), mkprimop(PLIST), env)
Call defvar(STRTOATOM("READ"), mkprimop(PREAD), env)
Call defvar(STRTOATOM("<"), mkprimop(PLT), env)
Call defvar(STRTOATOM(">"), mkprimop(PGT), env)
Call defvar(STRTOATOM(">="), mkprimop(PGEQ), env)
Call defvar(STRTOATOM("<="), mkprimop(LEQ), env)
Call defvar(STRTOATOM("SYMBOL?"), mkprimop(PSYMP), env)
Call defvar(STRTOATOM("NUMBER?"), mkprimop(PNUMP), env)
Call defvar(STRTOATOM("PROCEDURE?"), mkprimop(PPROCP), env)
Call defvar(STRTOATOM("PAIR?"), mkprimop(PCONSP), env)
Return

'''''


Function DoLISP$ (TheStringIn As String, envin)
    TheInput$ = TheStringIn
    TheOutput$ = ""
    s = READOBJ(0)
    Select Case s
        Case TOKCLOSE
            ' unmatched closed parenthesis
        Case TOKDOT
            'PRINT "dot used outside list"
        Case TOKERR
            'PRINT "[Error]"
            TheOutput$ = TheOutput$ + "[Error]"
        Case Else
            Call PRINTOBJ(EVALOBJ(s, envin))
    End Select
    DoLISP$ = TheOutput$
End Function

'DO
'    s = READOBJ(0)
'    SELECT CASE s
'        CASE TOKCLOSE
'            ' unmatched closed parenthesis
'        CASE TOKDOT
'            PRINT "dot used outside list"
'        CASE TOKERR
'            PRINT "[Error]"
'        CASE ELSE
'            CALL PRINTOBJ(EVALOBJ(s, env))
'    END SELECT
'    PRINT
'    IF gcnow THEN CALL gc(env)
'LOOP

Function ALLOC
    ALLOC = hptr
    hptr = hptr + 1
    If hptr > (mmin + 3 * (msize / 4)) Then gcnow = -1
End Function

Function apply (id, args)
    If heap(id, 0) = TPROC Then
        params = heap(id, 1)
        body = heap(heap(id, 2), 1)
        procenv = heap(heap(id, 2), 2)
        env = CONS(CONS(params, args), procenv)
        Do While heap(body, 2)
            t = heap(body, 1)
            t = EVALOBJ(t, env) 'ignore result
            body = heap(body, 2)
        Loop
        t = heap(body, 1)
        apply = EVALOBJ(t, env)
    ElseIf heap(id, 0) = TPPROC Then
        Select Case heap(id, 1)
            Case PPLUS
                sum = 0
                a = args
                While a
                    sum = sum + heap(heap(a, 1), 1)
                    a = heap(a, 2)
                Wend
                p = ALLOC
                heap(p, 0) = TNUM
                heap(p, 1) = sum
                apply = p
            Case PTIMES
                prod = 1
                a = args
                While a
                    prod = prod * heap(heap(a, 1), 1)
                    a = heap(a, 2)
                Wend
                p = ALLOC
                heap(p, 0) = TNUM
                heap(p, 1) = prod
                apply = p
            Case PCONS
                apply = CONS(heap(args, 1), heap(heap(args, 2), 1))
            Case PCAR
                apply = heap(heap(args, 1), 1)
            Case PCDR
                apply = heap(heap(args, 1), 2)
            Case PEQUAL
                If args = TNIL Then apply = STRTOATOM("T"): Exit Function
                f = heap(heap(args, 1), 1)
                a = heap(args, 2)
                Do While a
                    If heap(heap(a, 1), 1) <> f Then apply = TNIL: Exit Function
                    a = heap(a, 2)
                Loop
                apply = STRTOATOM("T"): Exit Function
            Case PNOT
                If heap(args, 1) Then apply = TNIL Else apply = STRTOATOM("T")
            Case PEQ
                arg1 = heap(args, 1)
                arg2 = heap(heap(args, 2), 1)
                If heap(arg1, 0) <> heap(arg2, 0) Then apply = TNIL: Exit Function
                Select Case heap(arg1, 0)
                    Case TNUM, TPROC, TPPROC, TSYM
                        If heap(arg1, 1) = heap(arg2, 1) Then apply = STRTOATOM("T")
                    Case TCONS, TNIL
                        If arg1 = arg2 Then apply = STRTOATOM("T")
                End Select
            Case PLT
                If args = TNIL Then apply = STRTOATOM("T"): Exit Function
                f = heap(heap(args, 1), 1)
                a = heap(args, 2)
                Do While a
                    If f < heap(heap(a, 1), 1) Then
                        f = heap(heap(a, 1), 1)
                        a = heap(a, 2)
                    Else
                        apply = TNIL: Exit Function
                    End If
                Loop
                apply = STRTOATOM("T"): Exit Function
            Case PGT
                If args = TNIL Then apply = STRTOATOM("T"): Exit Function
                f = heap(heap(args, 1), 1)
                a = heap(args, 2)
                Do While a
                    If f > heap(heap(a, 1), 1) Then
                        f = heap(heap(a, 1), 1)
                        a = heap(a, 2)
                    Else
                        apply = TNIL: Exit Function
                    End If
                Loop
                apply = STRTOATOM("T"): Exit Function
            Case PLEQ
                If args = TNIL Then apply = STRTOATOM("T"): Exit Function
                f = heap(heap(args, 1), 1)
                a = heap(args, 2)
                Do While a
                    If f <= heap(heap(a, 1), 1) Then
                        f = heap(heap(a, 1), 1)
                        a = heap(a, 2)
                    Else
                        apply = TNIL: Exit Function
                    End If
                Loop
                apply = STRTOATOM("T"): Exit Function
            Case PGEQ
                If args = TNIL Then apply = STRTOATOM("T"): Exit Function
                f = heap(heap(args, 1), 1)
                a = heap(args, 2)
                Do While a
                    If f >= heap(heap(a, 1), 1) Then
                        f = heap(heap(a, 1), 1)
                        a = heap(a, 2)
                    Else
                        apply = TNIL: Exit Function
                    End If
                Loop
                apply = STRTOATOM("T"): Exit Function
            Case PSETCAR
                arg1 = heap(args, 1)
                arg2 = heap(heap(args, 2), 1)
                heap(arg1, 1) = arg2
            Case PSETCDR
                arg1 = heap(args, 1)
                arg2 = heap(heap(args, 2), 1)
                heap(arg2, 2) = arg2
            Case PAPPLY
                arg1 = heap(args, 1)
                arg2 = heap(heap(args, 2), 1)
                apply = apply(arg1, arg2)
            Case PLIST
                apply = args
            Case PREAD
                apply = READOBJ(0)
            Case PMINUS
                arg1 = heap(heap(args, 1), 1)
                rargs = heap(args, 2)
                If rargs Then
                    res = arg1
                    While rargs
                        res = res - heap(heap(rargs, 1), 1)
                        rargs = heap(rargs, 2)
                    Wend
                    p = ALLOC
                    heap(p, 0) = TNUM: heap(p, 1) = res: apply = p
                Else
                    p = ALLOC: heap(p, 0) = TNUM: heap(p, 1) = -arg1
                    apply = p
                End If
            Case PSYMP
                targ1 = heap(heap(args, 1), 0)
                If targ1 = TSYM Then apply = STRTOATOM("T")
            Case PNUMP
                targ1 = heap(heap(args, 1), 0)
                If targ1 = TNUM Then apply = STRTOATOM("T")
            Case PPROCP
                targ1 = heap(heap(args, 1), 0)
                If targ1 = TPROC Or targ1 = TPPROC Then apply = STRTOATOM("T")
            Case PCONSP
                targ1 = heap(heap(args, 1), 0)
                If targ1 = TCONS Then apply = STRTOATOM("T")
        End Select
    Else
        Print "Bad application -- not a function"
        apply = TOKERR
    End If
End Function

Function CONS (car, cdr)
    p = ALLOC
    heap(p, 0) = TCONS
    heap(p, 1) = car
    heap(p, 2) = cdr
    CONS = p
End Function

Sub defvar (id, value, env)
    anum = heap(id, 1)
    frame = heap(env, 1)
    vars = heap(frame, 1)
    vals = heap(frame, 2)
    While vars
        If heap(heap(vars, 1), 1) = anum Then
            heap(vals, 1) = value: Exit Sub
        End If
        vars = heap(vars, 2): vals = heap(vals, 2)
    Wend
    vars = heap(frame, 1)
    vals = heap(frame, 2)
    heap(frame, 1) = CONS(id, vars)
    heap(frame, 2) = CONS(value, vals)
End Sub

Function EVALOBJ (id, env)
    1 Select Case heap(id, 0)
        Case TNIL, TNUM ' self-evaluating
            EVALOBJ = id
        Case TSYM
            EVALOBJ = lookup(heap(id, 1), env)
        Case TCONS
            o = heap(id, 1)
            t = heap(o, 0)
            If t = TSYM Then
                a$ = atom$(heap(o, 1)) ' symbol name of car(id)
                Select Case a$
                    Case "QUOTE"
                        EVALOBJ = heap(heap(id, 2), 1)
                    Case "SET!"
                        vid = heap(heap(id, 2), 1) 'cadr
                        aval = heap(heap(heap(id, 2), 2), 1) 'caddr
                        Call setvar(vid, EVALOBJ(aval, env), env)
                    Case "DEFINE"
                        vid = heap(heap(id, 2), 1)
                        aval = heap(heap(heap(id, 2), 2), 1)
                        Call setvar(vid, EVALOBJ(aval, env), env)
                    Case "IF"
                        ' (if pred ic ia)
                        pred = heap(heap(id, 2), 1) 'predicate = cadr
                        ic = heap(heap(heap(id, 2), 2), 1) ' caddr
                        ia = heap(heap(heap(heap(id, 2), 2), 2), 1) ' cadddr
                        If EVALOBJ(pred, env) Then
                            ' return EVALOBJ(ic,env)
                            id = ic: GoTo 1
                        Else
                            ' return EVALOBJ(ia,env)
                            id = ia: GoTo 1
                        End If
                    Case "LAMBDA"
                        p = ALLOC
                        heap(p, 0) = TPROC
                        heap(p, 1) = heap(heap(id, 2), 1) ' cadr = args
                        heap(p, 2) = CONS(heap(heap(id, 2), 2), env) 'caddr = body
                        EVALOBJ = p
                    Case "BEGIN"
                        seq = heap(id, 2)
                        Do While heap(seq, 2)
                            t = heap(seq, 1)
                            t = EVALOBJ(t, env) 'ignore result
                            seq = heap(seq, 2)
                        Loop
                        id = heap(seq, 1): GoTo 1
                    Case "AND"
                        seq = heap(id, 2)
                        Do While heap(seq, 2)
                            t = heap(seq, 1)
                            t = EVALOBJ(t, env)
                            If t = 0 Then EVALOBJ = 0: Exit Function
                            seq = heap(seq, 2)
                        Loop
                        id = heap(seq, 1): GoTo 1
                    Case "OR"
                        seq = heap(id, 2)
                        Do While heap(seq, 2)
                            t = heap(seq, 1)
                            t = EVALOBJ(t, env)
                            If t Then EVALOBJ = t: Exit Function
                            seq = heap(seq, 2)
                        Loop
                        id = heap(seq, 1): GoTo 1
                    Case "COND"
                        clauses = heap(id, 2)
                        While clauses
                            clause = heap(clauses, 1)
                            pred = heap(clause, 1)
                            If EVALOBJ(pred, env) Then
                                seq = heap(clause, 2)
                                Do While heap(seq, 2)
                                    t = heap(seq, 1)
                                    t = EVALOBJ(t, env) 'ignore result
                                    seq = heap(seq, 2)
                                Loop
                                id = heap(seq, 1): GoTo 1
                            End If
                            clauses = heap(clauses, 2)
                        Wend
                    Case Else
                        args = heap(id, 2)
                        proc = EVALOBJ(o, env)
                        EVALOBJ = apply(proc, lvals(args, env))
                End Select
            Else
                args = heap(id, 2)
                proc = EVALOBJ(o, env)
                EVALOBJ = apply(proc, lvals(args, env))
            End If
        Case Else
            Print "Unhandled expression type: "; a$
            EVALOBJ = id
    End Select
End Function

Function hash (s$)
    Dim h As Long
    For i = 1 To Len(s$)
        c = Asc(Mid$(s$, i, 1))
        h = (h * 33 + c) Mod hsize
    Next
    hash = h
End Function

Function lookup (anum, env)
    ' env is a list of (vars . vals) frames
    ' where: vars is a list of symbols
    '        vals is a list of their values
    e = env
    Do
        frame = heap(e, 1) ' get the first frame

        vars = heap(frame, 1) ' vars is car

        vals = heap(frame, 2) ' vals is cdr

        While vars ' while vars left to check
            If heap(heap(vars, 1), 1) = anum Then 'atom number of car(vars) = anum
                lookup = heap(vals, 1) ' car(vals)
                Exit Function
            End If
            vars = heap(vars, 2) 'cdr(vars)
            vals = heap(vals, 2) 'cdr(vals)
        Wend
        e = heap(e, 2) ' cdr(e)
    Loop While e
    Print "Unbound variable: "; atom$(anum): lookup = TOKERR
End Function

Function lvals (id, env)
    If heap(id, 0) = TCONS Then
        car = heap(id, 1)
        ecar = EVALOBJ(car, env)
        head = CONS(ecar, 0)
        l = heap(id, 2): prev = head
        While l
            car = heap(l, 1)
            ecar = EVALOBJ(car, env)
            new = CONS(ecar, 0)
            heap(prev, 2) = new
            prev = new
            l = heap(l, 2)
        Wend
        lvals = head
    Else
        lvals = 0
    End If
End Function

Function mkprimop (id)
    p = ALLOC
    heap(p, 0) = TPPROC
    heap(p, 1) = id
    mkprimop = p
End Function

Sub PRINTOBJ (id)

    If id = TOKERR Then Print "[Error]": Exit Sub
    Select Case heap(id, 0)
        Case TNIL
            'PRINT "()";
            TheOutput$ = TheOutput$ + "()"
        Case TCONS
            'PRINT "(";
            TheOutput$ = TheOutput$ + "("
            printlist:
            Call PRINTOBJ(heap(id, 1))
            'PRINT " ";
            TheOutput$ = TheOutput$ + " "
            cdr = heap(id, 2)
            If heap(cdr, 0) = TCONS Then id = cdr: GoTo printlist
            If heap(cdr, 0) = TNIL Then
                'PRINT ")";
                TheOutput$ = TheOutput$ + ")"
            Else
                'PRINT ".";
                TheOutput$ = TheOutput$ + "."
                Call PRINTOBJ(cdr)
                'PRINT ")";
                TheOutput$ = TheOutput$ + ")"
            End If
        Case TNUM
            'PRINT heap(id, 1);
            TheOutput$ = TheOutput$ + Str$(heap(id, 1))
        Case TSYM
            'PRINT atom$(heap(id, 1));
            TheOutput$ = TheOutput$ + atom$(heap(id, 1))
        Case TPROC, TPPROC
            'PRINT "[Procedure]"
            TheOutput$ = TheOutput$ + "[Procedure]"
    End Select
End Sub

Function READLIST (depth)
    SH = READOBJ(depth)
    Select Case SH
        Case TOKERR
            READLIST = TOKERR
        Case TOKCLOSE
            READLIST = 0
        Case TOKDOT
            SH = READOBJ(depth)
            Select Case SH
                Case TOKERR, TOKDOT, TOKCLOSE
                    READLIST = TOKERR
                Case Else
                    ST = READLIST(depth)
                    If ST Then READLIST = TOKERR Else READLIST = SH
            End Select
        Case Else
            ST = READLIST(depth)
            If ST = TOKERR Then READLIST = TOKERR Else READLIST = CONS(SH, ST)
    End Select
End Function

Function READOBJ (depth)
    tok = READTOKEN(depth)
    Select Case tok
        Case TOKOPEN
            s = READLIST(depth + 1)
            READOBJ = s
        Case TOKQUOTE
            tok = READOBJ(depth + 1)
            Select Case tok
                Case TOKCLOSE
                    Print "warning: quote before close parenthesis"
                    READOBJ = tok
                Case TOKDOT
                    Print "warning: quote before dot"
                    READOBJ = tok
                Case Else
                    s = CONS(STRTOATOM("QUOTE"), CONS(tok, 0))
                    READOBJ = s
            End Select
        Case Else
            READOBJ = tok
    End Select
End Function

Function READTOKEN (depth)

    start1: bufend = Len(buf)
    While bufpos < bufend And InStr(" " + Chr$(9), Mid$(buf, bufpos, 1))
        bufpos = bufpos + 1
    Wend
    c$ = Mid$(buf, bufpos, 1)
    If InStr(":;", c$) Then
        If c$ = ":" Then
            bufpos = bufpos + 1
            If bufpos <= bufend Then
                Select Case Mid$(buf, bufpos, 1)
                    Case "q", "Q" ' quit
                        System
                    Case "g", "G" ' garbage collect now
                        gcnow = -1
                    Case Else
                        READTOKEN = TOKERR
                        Exit Function
                End Select
            End If
        End If
        bufpos = bufend + 1
    End If
    If bufpos > bufend Then
        'IF depth = 0 THEN PRINT "]=> ";
        'LINE INPUT buf
        buf = TheInput$
        bufend = Len(buf)
        bufpos = 1
        GoTo start1
    End If
    Select Case c$
        Case "("
            bufpos = bufpos + 1
            READTOKEN = TOKOPEN
        Case ")"
            bufpos = bufpos + 1
            READTOKEN = TOKCLOSE
        Case "'"
            bufpos = bufpos + 1
            READTOKEN = TOKQUOTE
        Case "."
            bufpos = bufpos + 1
            READTOKEN = TOKDOT
        Case Else
            strbeg = bufpos
            bufpos = bufpos + 1
            Do While bufpos <= bufend
                c$ = Mid$(buf, bufpos, 1)
                If c$ = " " Or c$ = "." Or c$ = "(" Or c$ = ")" Then Exit Do
                bufpos = bufpos + 1
            Loop
            READTOKEN = STRTOATOM(Mid$(buf, strbeg, bufpos - strbeg))
    End Select
End Function

Sub setvar (id, value, env)
    anum = heap(id, 1)
    e = env
    Do
        frame = heap(e, 1)
        vars = heap(frame, 1)
        vals = heap(frame, 2)
        While vars
            If heap(heap(vars, 1), 1) = anum Then
                heap(vals, 1) = value: Exit Sub
            End If
            vars = heap(vars, 2): vals = heap(vals, 2)
        Wend
        e = heap(e, 2)
    Loop While e
    Call defvar(id, value, env)
End Sub

Function STRTOATOM (s$)
    l = Len(s$)
    c$ = Left$(s$, 1)
    If (c$ = "-" And l >= 2) Or (c$ >= "0" And c$ <= "9") Then
        v = 0
        If c$ = "-" Then neg = 1: idx = 2 Else neg = 0: idx = 1
        For idx = idx To l
            c$ = Mid$(s$, idx, 1)
            If (c$ >= "0" And c$ <= "9") Then
                v = v * 10 + (Asc(c$) - Asc("0"))
            Else
                Exit For
            End If
        Next
        If idx = l + 1 Then
            If neg Then v = -v
            p = ALLOC
            heap(p, 0) = TNUM
            heap(p, 1) = v
            STRTOATOM = p: Exit Function
        End If
    End If
    If UCase$(s$) = "NIL" Then STRTOATOM = TOKNIL: Exit Function

    i = hash(UCase$(s$))
    For count = 1 To hsize
        If atom$(i) = UCase$(s$) Then
            found = TRUE: Exit For
        ElseIf atom$(i) = "" Then
            atom$(i) = UCase$(s$)
            found = TRUE
            Exit For
        Else
            i = (i + count) Mod hsize
        End If
    Next
    If Not found Then Print "Symbol table full!"
    p = ALLOC: heap(p, 0) = TSYM: heap(p, 1) = i
    STRTOATOM = p
End Function

Sub gc (root)
    hptr = nmin
    root = collect(root)
    Swap mmin, nmin
    Swap mmax, nmax
    gcnow = 0
End Sub

Function collect (p)

    Select Case heap(p, 0)

        Case -1
            collect = heap(p, 1)

        Case TCONS, TPROC

            ' address of new copy
            x = ALLOC

            ' car, cdr
            a = heap(p, 1)
            d = heap(p, 2)

            ' replace with forwarding address
            heap(p, 0) = -1
            heap(p, 1) = x

            ' copy
            heap(x, 0) = heap(p, 0)
            heap(x, 1) = collect(a)
            heap(x, 2) = collect(d)
            collect = x

        Case TNIL
            collect = 0

        Case Else
            x = ALLOC

            ' copy the entire structure
            For i = 0 To 2
                heap(x, i) = heap(p, i)
            Next

            ' write forwarding address
            heap(p, 0) = -1
            heap(p, 1) = x
            collect = x
    End Select

End Function


