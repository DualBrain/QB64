**HTTP/1.1** protocol downloads can be done using a **GET** request using the following format without HTTP:// in the url:

```text

CRLF$ = CHR$(13) + CHR$(10)
Request$ = "GET " + File_Path + " HTTP/1.1" + CRLF$ + "Host:" + Web_Address + CRLF$ + CRLF$

```

>  Two carriage returns end the request to the [_OPENCLIENT](_OPENCLIENT) URL. The header that is returned from the site also ends with two carriage returns when there are no errors. The header will also include the requested file's byte size after "content-length:" as below:

```text

HTTP/1.1 200 OK
Server: dbws
Date: Tue, 25 Oct 2011 04:41:03 GMT
Content-Type: text/plain; charset=ascii
Connection: keep-alive
content-length: 4087
x-robots-tag: noindex,nofollow
accept-ranges: bytes
etag: 365n
pragma: public
cache-control: max-age=0 

```

>  Each row of text response sent is ended with a carriage return with the end of header having two. After that comes the file data.
>  It is recommended that data be loaded immediately by using a [GET (TCP/IP statement)](GET-(TCP-IP-statement)) loop so that connections are not dropped during a [_DELAY](_DELAY).

>  **A "raw" Download function that downloads an image directly off of a web page using the image name on that page.**

```vb

IF Download("www.qb64.net/qb64.png", "qb64logo.png", 10) THEN ' timelimit = 10 seconds
 SCREEN _LOADIMAGE("qb64logo.png",32)
ELSE: PRINT "Couldn't download QB64 logo."
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
            OPEN file$ FOR OUTPUT AS #fh: CLOSE #fh 'Warning! Clears data from existing file
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
<sub>Code by Galleon</sub>

> **Downloading a [BINARY](BINARY) image file from a download link using [GET](GET) which requires the "content-length" in header.**

```vb

DEFINT A-Z

CR$ = CHR$(13) + CHR$(10) 'crlf carriage return line feed characters
' Change this to the file's public link
<nowiki>DownFile$ = "http://a5.sphotos.ak.fbcdn.net/hphotos-ak-snc7/293944_10150358253659788_151813304787_8043392_486717139_n.jpg?dl=1"</nowiki>

' Get base URL
BaseURL$ = DownFile$
IF INSTR(BaseURL$, "http://") THEN BaseURL$ = RIGHT$(BaseURL$, LEN(BaseURL$) - 7) 'trim http://
Path$ = MID$(BaseURL$, INSTR(BaseURL$, "/")) 'path to file
BaseURL$ = LEFT$(BaseURL$, INSTR(BaseURL$, "/") - 1) 'site URL

' Connect to base URL
PRINT "Connecting to "; BaseURL$; "...";
Client& = _OPENCLIENT("TCP/IP:80:" + BaseURL$)
IF Client& = 0 THEN PRINT "Failed to connect...": END
PRINT "Done."

' Send download request
PRINT "Sending download request...";
Request$ = "GET " + Path$ + " HTTP/1.1" + CR$ + "Host:" + BaseURL$ + CR$ + CR$
PUT #Client&, , Request$
PRINT "Done."

' Download the header
PRINT "Getting HTML header...";
Dat$ = ""
DO
   _LIMIT 20
   GET #Client&, , gDat$
   Dat$ = Dat$ + gDat$
LOOP UNTIL INSTR(Dat$, CR$ + CR$) ' Loop until 2 CRLFs (end of HTML header) are found
PRINT "Done."

' Get file size
FileSizePos = INSTR(UCASE$(Dat$), "CONTENT-LENGTH: ") + 16
FileSizeEnd = INSTR(FileSizePos, Dat$, CR$)
FileSize& = VAL(MID$(Dat$, FileSizePos, (FileSizeEnd - FileSizePos) + 1))

PRINT "File size:"; FileSize&
PRINT "Downloading file...";

' Trim off HTML header
EndHeaderPos = INSTR(Dat$, CR$ + CR$) + 4
Dat$ = RIGHT$(Dat$, (LEN(Dat$) - EndHeaderPos) + 1)

' Get the file name tucked at the end of the URL if necessary
FOR S = LEN(DownFile$) TO 1 STEP -1
   IF MID$(DownFile$, S, 1) = "/" THEN
      OutFile$ = RIGHT$(DownFile$, (LEN(DownFile$) - S))
      EXIT FOR
   END IF
NEXT S
' Remove some kind of tag at the end of the file name in some URLs
IF INSTR(OutFile$, "?") THEN OutFile$ = LEFT$(OutFile$, INSTR(OutFile$, "?") - 1)

' Download the rest of the data
OPEN OutFile$ FOR OUTPUT AS #1: CLOSE #1 'Warning! Clears data from an existing file
OPEN OutFile$ FOR BINARY AS #1 'write data to binary image file
DO
   _LIMIT 20
   PUT #1, , Dat$
   GET #Client&, , Dat$
LOOP UNTIL LOF(1) >= FileSize&
CLOSE #1, #Client&
PRINT "Done!" 

```
<sub>Adapted from code by Jobert14</sub>

> **Note:** Some download links require that a **tag** be added after the file name. Remove that tag if it will be used as the file name.

> **Downloading a sequencial text file from a Drop Box download link using HTTP GET and the  [GET (TCP/IP statement)](GET-(TCP-IP-statement)) statement.**

```vb

CrLf$ = CHR$(13) + CHR$(10) ' carriage return + line feed ASCII characters

Host = _OPENHOST("TCP/IP:319")
IF Host THEN
  PRINT "> Server started succesfully."

  '// Change this to the file's public link
  IP_File$ = "dl.dropbox.com/u/8440706/QB64.INI" 'a Drop Box link
  URL$ = LEFT$(IP_File$, INSTR(IP_File$, "/") - 1)
  Path$ = MID$(IP_File$, INSTR(IP_File$, "/"))
  Client& = _OPENCLIENT("TCP/IP:80:" + URL$)
  IF Client& THEN
    Request$ = "GET " + Path$ + " HTTP/1.1" + CrLf$ + "Host:" + URL$ + CrLf$ + CrLf$
    PUT #Client&, , Request$
    DO: _LIMIT 20 '              load response header
      GET #Client&, , Dat$
      Header$ = Header$ + Dat$
    LOOP UNTIL INSTR(Header$, CrLf$ + CrLf$) ' Loop until 2 CRLFs (end of HTML header) are found
    PRINT "Header Done."

    ' Get file size from header
    SizePos = INSTR(UCASE$(Header$), "CONTENT-LENGTH:") + 16
    SizeEnd = INSTR(SizePos, Header$, CrLf$)
    FileSize& = VAL(MID$(Header$, SizePos, (SizeEnd - SizePos) + 1))
    PRINT "File size is"; FileSize&; "bytes"
    EndPos = INSTR(Header$, CrLf$ + CrLf$) + 4
    Response$ = MID$(Header$, EndPos) ' get data after header already downloaded

    start = 1  '// Get file name from original URL path if necessary
    DO '// Change this to destination local file name and path...
      posit = INSTR(start, IP_File$, "/")
      IF posit THEN lastpos = posit: start = posit + 1
    LOOP UNTIL posit = 0
    File$ = MID$(IP_File$, lastpos + 1) 'beware of tag suffixes
    OPEN File$ FOR BINARY AS #1
    DO: _LIMIT 20
      PUT #1, , Response$
      GET #Client&, , Response$
    LOOP UNTIL LOF(1) >= FileSize&
    PRINT "File download completed!"
    CLOSE #1
  ELSE
    PRINT "Failed to connect."
  END IF
ELSE
  PRINT "Failed to create server connection..."
END IF 

```
<sub>Code suggested by Matt Kilgore</sub>
