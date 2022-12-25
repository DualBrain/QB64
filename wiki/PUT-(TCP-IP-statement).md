The **PUT #** TCP/IP statement sends unformatted(raw) data to an open connection using a user's handle.

## Syntax

> **PUT *#handle*, , *data* **


## Parameters

* The *handle* value is returned by the [_OPENCLIENT](_OPENCLIENT), [_OPENHOST](_OPENHOST) or [_OPENCONNECTION](_OPENCONNECTION) **QB64** functions.
* The *data* can be any variable type value. Literal values are not allowed.

**Communicating using unformatted/raw streamed data:**

* Benefit: Communicate with any TCP/IP compatible protocol (eg. FTP, HTTP, web-pages, etc)
* Disadvantage: Streamed data has no 'message length' as such, just a continuous bunch of bytes all in a row. Some messages get fragmented and parts of messages can (and often do) arrive at different times. 
* The position parameter (between the commas) is not used in TCP/IP statements as all data is streamed consecutively.

**Your program MUST cater for these situations manually.**

```text

*Example: string variable b$'s length is adjusted to the number of bytes read.*

 PUT #client, , a$ 'sends data (this could be a string, variable array, user defined type, etc)
 GET #openconn, , b$ 'reads any available data into variable length string b$ 
 GET #openconn, , x% 'reads 2 bytes of data as an integer value.

```

> *Explanation:* Checking [EOF](EOF)(o) is unnecessary. If 2 bytes are available, they are read into x%, if not then nothing is read and [EOF](EOF)(o) will return -1

*See the example in [_OPENCLIENT](_OPENCLIENT)*

## See Also

* [GET (TCP/IP statement)](GET-(TCP-IP-statement)), [PUT #](PUT)
* [_OPENCLIENT](_OPENCLIENT), [_OPENHOST](_OPENHOST), [_OPENCONNECTION](_OPENCONNECTION)
