[Home](https://qb64.com) • [News](news.md) • [GitHub](https://github.com/QB64Official/qb64) • [Wiki](https://github.com/QB64Official/qb64/wiki) • [Samples](samples.md) • [InForm](inform.md) • [GX](gx.md) • [QBjs](qbjs.md) • [Community](community.md) • [More...](more.md)

## Articles - TCP/IP communications

*by Luke*

```text

QB64 - TCP/IP Communications

Conceptual overview
-------------------

TCP is a protocol for communicating over a network. It guarantees that:

 - Data will arrive
 - It will arrive in order
 - It will arrive error-free

Obviously, if someone cuts the cable, nothing can be done.

A TCP connection is established between two parties, a client and server. When
started, the server will listen on a specific port. By listening on different
ports, multiple servers can be run on the same machine. When a client wishes to
connect, it requests a connection to the server, specifying its IP address (or a
text equivalent like www.google.com) and the port the server is on. The server
then accepts the connection request, and the connection is established.

Aside on ports: ports are numbers between 1 and 65535, and their use allows
multiple servers to run on the same machine. The client needs to know the port
the server is using beforehand - luckily, common services have standard ports:
HTTP (for internet pages): 80
SSH (secure remote access): 22
Telnet (insecure remote access): 23
SMTP (Send email): 25
On some systems, ports below 1024 may be protected, meaning a server can't
listen on them without administrator/superuser privliges.

TCP structures the data sent as a stream. This has many consequences:
 - Individual send operations do not mean data will arrive as separate chunks at
   the other end. You cannot tell where one chunk ends and the next starts.
 - But one send operation does not guarantee only one read operation will be
   needed. TCP may split the data, and it may arrive bit by bit, meaning more
   than one read operation is needed to collect it all.
Although this may sound limiting, the associated issues can be solved by either
sending a special signal to note the end of the data (NUL and Linefeed are popular
choices), or by first sending the size of the data as a pre-agreed numeric
data type, then sending the data itself.

TCP is full-duplex, meaning both parties can send and receive data. It is not
necessary to read all data before you can send any yourself.

-------------------------------------------------------

_OPENCLIENT - Connect to a listening server
-----------
handle& = _OPENCLIENT("TCP/IP:1234:host")
Where 1234 can be any port number, and host can be any IPv4 address or any domain
name, upon which DNS resolution will be performed.

If you are connecting to a server, this is typically the first command used. It
establishes the connection, and returns a handle to refer to the connection by
later on. If handle& = 0, this indicates an error occurred connecting.


_OPENHOST - Begin listening on a specific port
---------
server& = _OPENHOST("TCP/IP:1234")
Where 1234 can be any port number, but may be subject to Operating System
permission restrictions.

This is typically the first command a server will call, in the startup phase.
The program is then ready to accept connections to port 1234, by use of
_OPENCONNECTION.

server& is a handle that refers to listening on a particular port, and does not
relate to any particular client. If server& = 0, an error occured.


_OPENCONNECTION - Accept incoming connection from a client
handle& = _OPENCONNECTION(server&)
Where server& is a handle returned by _OPENHOST.

Checks for any connection requests from clients, and accepts the next waiting
one, if any. If a new connection is established, handle& is non-zero, and is
a handle& used to refer to that particular connection. That is, each client
connection will have a different handle&.

If server& = 0 there are no clients attempting to connect, or establishing a
connection failed.

If clients attempt to connect faster than a server can accept their connections,
they will be queued. The size of the queue is limited by the Operating System -
if it is exceeded, clients will likely be refused a connection straight away.

In typical operation, a server will repeatedly call this function to check for
any new clients.


_CONNECTIONADDRESS$ - Get address information about a connection
-------------------
info$ = _CONNECTIONADDRESS$(h&)
Where h& is a handle returned by any of _OPENCLIENT, _OPENHOST, _OPENCONNECTION.

In all three cases, the string returned as the format "TCP/IP:1234:address",
where 1234 is any port number and address is a IPv4 address or textual domain
name.

_OPENCLIENT handles: Returns the same string passed to _OPENCLIENT
_OPENHOST handles: Returns the listening port, and the public IP address of the
machine. _CONNECTIONADDRESS$ knows about NAT, so if a machine is behind a router
performing NAT, the address returned is the public address of the router, not
the local address of the machine.
_OPENCONNECTION handles: Returns the port from which the client is connecting,
and their IP address. In many cases, a client will be connecting from a randomly
assigned port number, usually towards the upper end of the range.

_CONNECTED - Check if a connection is still active
----------
bool& = CONNECTED(h&)
Where h& is a handle returned by _OPENCLIENT, _OPENHOST, _OPENCONNECTION, and
bool& is a boolean value (-1 = true, 0 = false).

Returns the state of the connection, as far as the program can tell. _CONNECTED
will only notice a disconnection when a read or write (GET or PUT) operation
does not succeed due to the connection being closed or otherwise broken. Thus:
 - Simply calling _CONNECTED in a loop without any I/O is useless.
 - Even if the connection is closed, GET may still succeed if there is data
   in the incoming buffer. In this case, _CONNECTED will still return true.

Since GET and PUT do not raise any errors, or return a value indicating
success/failure, _CONNECTED can be called after them to get an idea of what
happened. 

If h& has already been closed with CLOSE, an error is raised. A connection that
is found to be disconnected with _CONNECTED must still be closed with CLOSE.

Handles returned by _OPENHOST are always considered connected, since they are
not true connections.


CLOSE - Close a connection
-----
CLOSE #h& 'The # is optional

Like with a file, this is how one shuts down a connection or listen. h& may be
a handle returned by _OPENCLIENT, _OPENHOST, _OPENCONNECTION. Depending on the
application, it may be useful to arrange for one end to send a 'acknowledge'
signal, to confirm the connection is ready to close.

Especially in longrunning server programs, closing used connections is important
for preventing memory leaks.


GET - Read data from a connection
---
GET #h&, , fixed_len
GET #h&, , text$
Where h& is a handle returned by _OPENCLIENT, _OPENCONNECTION (not _OPENHOST),
and fixed_len/text$ is the variable to hold the data.

Receives data from the connection, if any is present. The behaviour differs
depending on whether the receiving variable is fixed length (numbers, UDT's 
including _MEM, arrays, fixed-length strings) or a variable length string.

If the data type is fixed, GET checks if there is sufficient data available to 
fill it. If there is, the appropriate number of bytes are read from the stream,
and EOF(h) is set to 0. If insufficient (or no) data is available, no bytes are
read from the stream, and EOF(h) is set to -1. The value of the receiving
variable may or may not be changed, so don't count on either.

If the data type is a variable length string, GET will read all available bytes
from the stream and return them in the string. EOF(h) is always set to 0, even
if no bytes are read (an empty string is returned in that case). However, you
should be prepared to accept fragmented or joined-together data, due to the
nature of TCP.

In all cases, GET is non-blocking, meaning it does not wait for data to arrive.
(Some programming languages have blocking network functions, which will not
return until data arrives). Consequentially, the following code is common to
read a piece of data:

DO
  GET #h, , num&&
LOOP WHILE EOF(h&)

EOF(h) will return -1 (true) if the GET cannot retrieve a sufficient number of
bytes (in this case, 8) from the stream, and 0 (false) when it succeeds.


PUT - Send data on a connection
---
PUT #h&, , var
Where h& is a handle returned by _OPENCLIENT, _OPENCONNECTION (not _OPENHOST),
and var is the variable to send (a numeric type, string, array of fixed length
data, or UDT including _MEM).

The counterpart to GET, PUT sends data to the other party. Usage is straght
forward, although note that:
 - You cannot send an array of variable strings.
 - Sending a _MEM block sends the _MEM header itself, not the data it refers to.

```
