The [_OPENHOST](_OPENHOST) function opens a Host which listens for new connections and returns a Host status handle.

## Syntax

> hostHandle = [_OPENHOST](_OPENHOST)(**"TCP/IP:8080"**)

## Description

* Creates an [ERROR Codes](ERROR-Codes) error if called with a string argument of the wrong syntax.
* The port used in the syntax example is 8080.
* Valid hostHandle values are negative numbers.
* If the syntax is correct but they fail to begin/connect a hostHandle of 0 is returned.
* Always check if the handle returned is 0 (failed) before continuing.  
* [CLOSE](CLOSE) hostHandle closes the host. A failed handle value of 0 does not need to be closed.

## See Also

* [_OPENCONNECTION](_OPENCONNECTION), [_OPENCLIENT](_OPENCLIENT)
* [_CONNECTED](_CONNECTED), [_CONNECTIONADDRESS](_CONNECTIONADDRESS)
* [Email Demo](Email-Demo), [Inter-Program Data Sharing Demo](Inter-Program-Data-Sharing-Demo) 
* [Downloading Files](Downloading-Files)
