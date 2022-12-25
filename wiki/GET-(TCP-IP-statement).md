*GET* reads unformatted (raw) data from an open TCP/IP connection opened with [_OPENCLIENT](_OPENCLIENT), [_OPENHOST](_OPENHOST) or [_OPENCONNECTION](_OPENCONNECTION).

## Syntax

*Syntax 1:*

> **GET** *#handle*, , *b$*

* Reads any available data into variable length string b$ (b$'s length is adjusted to the number of bytes read, so checking EOF is unnecessary) using the handle return value from [_OPENCLIENT](_OPENCLIENT), [_OPENHOST](_OPENHOST) or [_OPENCONNECTION](_OPENCONNECTION).

**Syntax 2:**

> **GET** *#handle*, ,*x%*

* Reads an integer. If 2 bytes are available, they are read into x%, if not then nothing is read and [EOF](EOF)(handle) will return -1 (and *x%*'s value will be undefined) using the handle return value from [_OPENCLIENT](_OPENCLIENT), [_OPENHOST](_OPENHOST) or [_OPENCONNECTION](_OPENCONNECTION).

__Communicating using unformatted/raw streamed data__

* Benefit: Communicate with any TCP/IP compatible protocol (eg. FTP, HTTP, web-pages, etc).
* Disadvantage: Streamed data has no 'message length', as such just the program deals with a continuous number of bytes in a row. Some messages get fragmented and parts of messages can (and often do) arrive at different times, due to the very nature of the TCP/IP protocol.
* The position parameter (between the commas) is not used in TCP/IP connections.
* The programmer must cater for these situations manually.

## Example(s)

*Example:*

```vb

 PUT #​c, , a$ ' sends data 
 GET #​o, , b$ ' reads any available data into variable length string b$  
 GET #​o, , x% ' if 2 bytes are available, they are read into x%

```

*Explanation:*

* Data could be a string, variable array, user defined [TYPE](TYPE), etc.
* b$'s length is adjusted to the number of bytes read. Checking [EOF](EOF)(o) is  unnecessary. 
* If 2 bytes are not available for the x% integer then nothing is read and [EOF](EOF)(o) will return -1 

## More Examples

* **See the examples in [_OPENCLIENT](_OPENCLIENT) or [Email Demo](Email-Demo).**

## See Also

* [PUT (TCP/IP statement)](PUT-(TCP-IP-statement))
* [_OPENCLIENT](_OPENCLIENT), [_OPENHOST](_OPENHOST)
* [_OPENCONNECTION](_OPENCONNECTION), [GET #](GET)
* [cURL](https://curl.haxx.se/) (HTTP and FTP file transfer)
