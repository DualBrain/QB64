The [_OPENCONNECTION](_OPENCONNECTION) function opens a connection from a client that the host has detected and returns a status handle.

## Syntax

> connectHandle = [_OPENCONNECTION](_OPENCONNECTION)(hostHandle)

## Description
 
* Valid connectHandle values returned are negative numbers.
* If the syntax is correct but they fail to begin/connect, a connectHandle of 0 is returned. 
* Always check if the handle returned is 0 (failed) before continuing.  
* [CLOSE](CLOSE) #connectHandle closes the connection. Failed connections(connectHandle = 0) do not need to be closed.
* As a **Host** you can check for new clients (users). Each will have a unique connection handle.
* Creates an [ERROR Codes](ERROR-Codes) error if called with a string argument of the wrong syntax.
* Handle values can be used as the open number by [GET (TCP/IP statement)](GET-(TCP-IP-statement)) read statement and [PUT (TCP/IP statement)](PUT-(TCP-IP-statement)) write statement.

## See Also

* [_OPENHOST](_OPENHOST), [_OPENCLIENT](_OPENCLIENT)
* [_CONNECTED](_CONNECTED), [_CONNECTIONADDRESS](_CONNECTIONADDRESS)
