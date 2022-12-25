The [_OPENCLIENT](_OPENCLIENT) function connects to a Host on the Internet as a Client and returns the Client status handle.

## Syntax

> clientHandle& = [_OPENCLIENT](_OPENCLIENT)(**"TCP/IP:8080:12:30:1:10"**)

## Description

* An [ERROR Codes](ERROR-Codes) error will be triggered if the function is called with a string argument of the wrong syntax.
* Connects to a host somewhere on the internet as a client.
* Valid clientHandle& values are negative. 0 means that the connection failed. Always check that the handle returned is not 0.
* [CLOSE](CLOSE) client_handle closes the client. A failed handle of value 0 does not need to be closed.

## Example(s)

Attempting to connect to a local host(your host) as a client. A zero return indicates failure.

```vb

client = _OPENCLIENT("TCP/IP:7319:localhost")
IF client THEN 
   PRINT "[Connected to " + _CONNECTIONADDRESS(client) + "]" 
ELSE PRINT "[Connection Failed!]"
END IF 

```

> **NOTE:** Try a valid TCP/IP port setting to test this routine!

Using a "raw" Download function to download the QB64 bee image and displays it.

```vb

'replace the fake image address below with a real image address you want to download
IF Download("www.qb64.org/qb64.png", "qb64logo.png", 10) THEN ' timelimit = 10 seconds
 SCREEN _LOADIMAGE("qb64logo.png",32)
ELSE: PRINT "Couldn't download image."
END IF
SLEEP
SYSTEM
' ---------- program end -----------

FUNCTION Download (url$, file$, timelimit) ' returns -1 if successful, 0 if not
url2$ = url$
x = INSTR(url2$, "/")
IF x THEN url2$ = LEFT$(url$, x - 1)
client = _OPENCLIENT("TCP/IP:80:" + url2$)
IF client = 0 THEN EXIT FUNCTION
e$ = CHR$(13) + CHR$(10) ' end of line characters
url3$ = RIGHT$(url$, LEN(url$) - x + 1)
x$ = "GET " + url3$ + " HTTP/1.1" + e$
x$ = x$ + "Host: " + url2$ + e$ + e$
PUT #client, , x$
t! = TIMER ' start time
DO
    _DELAY 0.05 ' 50ms delay (20 checks per second)
    GET #client, , a2$
    a$ = a$ + a2$
    i = INSTR(a$, "Content-Length:")
    IF i THEN
      i2 = INSTR(i, a$, e$)
      IF i2 THEN
      l = VAL(MID$(a$, i + 15, i2 - i -14))
      i3 = INSTR(i2, a$, e$ + e$)
        IF i3 THEN
          i3 = i3 + 4 'move i3 to start of data
          IF (LEN(a$) - i3 + 1) = l THEN
            CLOSE client ' CLOSE CLIENT
            d$ = MID$(a$, i3, l)
            fh = FREEFILE
            OPEN file$ FOR OUTPUT AS #fh: CLOSE #fh ' erase existing file?

            OPEN file$ FOR BINARY AS #fh
            PUT #fh, , d$
            CLOSE #fh
            Download = -1 'indicates download was successfull
            EXIT FUNCTION
          END IF ' availabledata = l
        END IF ' i3
      END IF ' i2
    END IF ' i
LOOP UNTIL TIMER > t! + timelimit ' (in seconds)
CLOSE client
END FUNCTION 

```

## See Also

* [_OPENHOST](_OPENHOST), [_OPENCONNECTION](_OPENCONNECTION)
* [_CONNECTED](_CONNECTED), [_CONNECTIONADDRESS$](_CONNECTIONADDRESS$)
* [Email Demo](Email-Demo), [Inter-Program Data Sharing Demo](Inter-Program-Data-Sharing-Demo)
* [Downloading Files](Downloading-Files)
