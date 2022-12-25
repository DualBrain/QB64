The [_CONNECTED](_CONNECTED) function returns the status of a TCP/IP connection handle.

## Syntax

> result& = [_CONNECTED](_CONNECTED)(connectionHandle&)

## Description

* The handle can come from the [_OPENHOST](_OPENHOST), [OPENCLIENT](OPENCLIENT) or [_OPENCONNECTION](_OPENCONNECTION) QB64 TCP/IP functions.
* Returns -1 if still connected or 0 if connection has ended/failed. 
* Do not rely solely on this function to check for ending communication.
* Use "time-out" checking as well and [CLOSE](CLOSE) any suspect connections.
* If this function indicates the handle is not connected, any unread messages can still be read using [GET (TCP/IP statement)](GET-(TCP-IP-statement)).
* Even if this function indicates the handle is not connected, it is important to [CLOSE](CLOSE) the connection anyway or important resources cannot be reallocated. 

## See Also

* [_OPENCONNECTION](_OPENCONNECTION)
* [_OPENHOST](_OPENHOST)
* [_OPENCLIENT](_OPENCLIENT)
* [_CONNECTIONADDRESS$](_CONNECTIONADDRESS$)
* [Downloading Files](Downloading-Files)
