    _TITLE "Dropping Balls: Pile Attempt #3" ' bplus started 2018-04-03"
    ' Attempt to build a pile by adjusting drop rate, elasticity, and gravity.
    ' Built from Dropping balls 4 w snd and STATIC created 2018-04-3
    ' Add STATIC's ball moving before figuring any bounce from collision
    ' which was a mod in Dropping Balls 2 w sound posted 2018-03-31.
    ' 2020-03-04 Pile Attempt #3 revive and tidy up
     
    RANDOMIZE TIMER
    CONST xmax = 750, ymax = 720, elastic = .8, gravity = .75, balls = 400, br = 15
    SCREEN _NEWIMAGE(xmax, ymax, 32)
    _SCREENMOVE 360, 20
    DIM x(balls), y(balls), dx(balls), dy(balls), a(balls), rr(balls), gg(balls), bb(balls)
    FOR i = 1 TO balls 'initialize balls to drop
        x(i) = xmax / 2 + (i MOD 2) * 8 - 4: y(i) = 0 '                                     location
        dx(i) = 0: dy(i) = 3 '                                                        change on axis
        rr(i) = 150 + RND * 100: gg(i) = 150 + RND * 100: bb(i) = 150 + RND * 100 '        rgb color
    NEXT
    WHILE 1
        CLS
        loopCnt = loopCnt + 1 '                   drop ball every 17 loops so previous ball is clear
        IF loopCnt MOD 17 = 0 THEN
            IF maxBall < balls THEN maxBall = maxBall + 1
        END IF
        _PRINTSTRING (100, 10), "Balls:" + STR$(maxBall)
        FOR i = 1 TO maxBall
            'ready for collision
            dy(i) = dy(i) + gravity '                               gravity increase update on y axis
            a(i) = _ATAN2(dy(i), dx(i)) '                                       angle ball is heading
            imoved = 0
            FOR j = i + 1 TO maxBall
                '      The following is STxAxTIC's adjustment of ball positions if overlapping before
                ' calculation of new positions from collision. Displacement vector and its magnitude:
                nx = x(j) - x(i): ny = y(j) - y(i)
                nm = SQR(nx ^ 2 + ny ^ 2)
                IF nm < 1 + 2 * br THEN
                    nx = nx / nm: ny = ny / nm
                    ' Regardless of momentum exchange, separate balls along the line connecting them.
                    DO WHILE nm < 1 + 2 * br
                        flub = .001
                        x(j) = x(j) + flub * nx: y(j) = y(j) + flub * ny
                        x(i) = x(i) - flub * nx: y(i) = y(i) - flub * ny
                        nx = x(j) - x(i): ny = y(j) - y(i)
                        nm = SQR(nx ^ 2 + ny ^ 2)
                        nx = nx / nm: ny = ny / nm
                    LOOP
                    imoved = 1
                    a(i) = _ATAN2(y(i) - y(j), x(i) - x(j))
                    a(j) = _ATAN2(y(j) - y(i), x(j) - x(i))
                    power1 = (dx(i) ^ 2 + dy(i) ^ 2) ^ .5 '       update new dx, dy for i and j balls
                    power2 = (dx(j) ^ 2 + dy(j) ^ 2) ^ .5
                    power = elastic * (power1 + power2) / 2
                    dx(i) = power * COS(a(i)): dy(i) = power * SIN(a(i))
                    dx(j) = power * COS(a(j)): dy(j) = power * SIN(a(j))
                    x(i) = x(i) + dx(i): y(i) = y(i) + dy(i)
                    x(j) = x(j) + dx(j): y(j) = y(j) + dy(j)
                END IF '                                                              Thanks STxAxTIC
            NEXT
            IF imoved = 0 THEN x(i) = x(i) + dx(i): y(i) = y(i) + dy(i)
            IF x(i) - br < 0 OR x(i) + br > xmax THEN '       keep balls inside sides and bottom edge
                dx(i) = -dx(i)
                IF x(i) - br < 0 THEN x(i) = br
                IF x(i) + br > xmax THEN x(i) = xmax - br
            END IF
            IF y(i) + br > ymax THEN y(i) = ymax - br: dy(i) = -dy(i) * elastic
            FOR rad = br TO 1 STEP -1 '                                         finally draw the ball
                fcirc x(i), y(i), rad, _RGB32(rr(i) - 10 * rad, gg(i) - 10 * rad, bb(i) - 10 * rad)
            NEXT
        NEXT
        _DISPLAY
        _LIMIT 20
    WEND
     
    SUB fcirc (CX AS LONG, CY AS LONG, R AS LONG, C AS _UNSIGNED LONG) '       SMcNeill's fill circle
        DIM subRadius AS LONG, RadiusError AS LONG, X AS LONG, Y AS LONG
        subRadius = ABS(R): RadiusError = -subRadius: X = subRadius: Y = 0
        IF subRadius = 0 THEN PSET (CX, CY): EXIT SUB
        LINE (CX - X, CY)-(CX + X, CY), C, BF
        WHILE X > Y
            RadiusError = RadiusError + Y * 2 + 1
            IF RadiusError >= 0 THEN
                IF X <> Y + 1 THEN
                    LINE (CX - Y, CY - X)-(CX + Y, CY - X), C, BF
                    LINE (CX - Y, CY + X)-(CX + Y, CY + X), C, BF
                END IF
                X = X - 1
                RadiusError = RadiusError - X * 2
            END IF
            Y = Y + 1
            LINE (CX - X, CY - Y)-(CX + X, CY - Y), C, BF
            LINE (CX - X, CY + Y)-(CX + X, CY + Y), C, BF
        WEND
    END SUB
 