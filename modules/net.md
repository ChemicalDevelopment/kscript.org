---
layout: default
parent: Modules
title: 'net: Network'
permalink: /modules/net
nav_order: 90
---

# Network Module ('import net')
{: .no_toc }

The network module (`net`) provides functionality related to the world wide web, and other networks (i.e. LANs). 


 * TOC
{:toc}

---


---

## `net.FK`: Family Kind {#FK}

This type represents the type of family of address/connection/network.

#### `net.FK.INET4` {#FK.INET4}
{: .method .no_toc }

<div class="method-text" markdown="1">
IPv4 style addresses.

Addresses for this type of socket are expected to be a [`tuple`](/builtins#tuple) containing `(host, port)`, where `host` is a string hostname/IP, and `port` is an integer.


C-equivalent: `AF_INET`
</div>

#### `net.FK.INET6` {#FK.INET6}
{: .method .no_toc }

<div class="method-text" markdown="1">
IPv6 style addresses.

Addresses for this type of socket are expected to be a [`tuple`](/builtins#tuple) containing `(host, port, flow, scope)`, where `host` is a string hostname/IP, and `port` is an integer

TODO: This is not yet implemented

C-equivalent: `AF_INET6`

</div>


#### `net.FK.BT` {#FK.BT}
{: .method .no_toc }

<div class="method-text" markdown="1">
Bluetooth style addresses.

TODO: This is not yet implemented

C-equivalent: `AF_BLUETOOTH`
</div>

---

## `net.SK`: Socket Kind {#SK}

This type represents the type of socket

#### `net.SK.RAW` {#SK.RAW}
{: .method .no_toc }

<div class="method-text" markdown="1">
Raw socket kind, which sends raw packets

C-equivalent: `SOCK_RAW`
</div>

#### `net.SK.TCP` {#SK.TCP}
{: .method .no_toc }

<div class="method-text" markdown="1">
TCP/IP socket kind, which goes through the TCP/IP network protocol

C-equivalent: `SOCK_STREAM`
</div>

#### `net.SK.UDP` {#SK.UDP}
{: .method .no_toc }

<div class="method-text" markdown="1">
UDP socket kind, which goes through the UDP network protocol

C-equivalent: `SOCK_DGRAM`
</div>

#### `net.SK.PACKET` {#SK.PACKET}
{: .method .no_toc }

<div class="method-text" markdown="1">
Packet socket kind

NOTE: This kind of socket is deprecated

C-equivalent: `SOCK_PACKET`
</div>


#### `net.SK.PACKET_SEQ` {#SK.PACKET_SEQ}
{: .method .no_toc }

<div class="method-text" markdown="1">
Packet (sequential) socket kind

C-equivalent: `SOCK_SEQPACKET`
</div>

---


## `net.PK`: Protocol Kind {#PK}

This type represents the type of protocol

#### `net.PK.AUTO` {#PK.AUTO}
{: .method .no_toc }

<div class="method-text" markdown="1">
Automatic protocl (which is a safe default)

C-equivalent: `0`
</div>

#### `net.PK.BT_L2CAP` {#PK.BT_L2CAP}
{: .method .no_toc }

<div class="method-text" markdown="1">
Bluetooth protocol

C-equivalent: `BTPROTO_L2CAP`
</div>


#### `net.PK.BT_FRCOMM` {#PK.BT_RFCOMM}
{: .method .no_toc }

<div class="method-text" markdown="1">
Bluetooth protocol

C-equivalent: `BTPROTO_RFCOMM`
</div>

---


## `net.SocketIO(fk=net.FK.INET4, sk=net.SK.TCP, pk=net.PK.AUTO)`: Network Socket {#SocketIO}

This type represents a [network socket](https://en.wikipedia.org/wiki/Network_socket), which is an endpoint for sending/receiving data across a network. There are different types of sockets, but the most commons are the default arguments. You can manually specify the family, socket, and protocol used by supplying them, they should be members of the enums [`net.FK`](#FK), [`net.SK`](#SK), and [`net.PK`](#PK) respectively. The dfeault is IPv4, TCP/IP, and automatic protocol.

This type is a subtype of [`io.BaseIO`](/modules/io#BaseIO), and it implements all the functions mentioned in that type. In addition, it defines the following methods/attributes:


#### `net.SocketIO.bind(self, addr)` {#SocketIO.bind}
{: .method .no_toc }

<div class="method-text" markdown="1">
Binds the socket to the given address

The type expected for `addr` depends on the [family kind (`net.FK`)](#FK) of socket that `self` is
</div>

#### `net.SocketIO.connect(self, addr)` {#SocketIO.connect}
{: .method .no_toc }

<div class="method-text" markdown="1">
Connects the socket to the given address

The type expected for `addr` depends on the [family kind (`net.FK`)](#FK) of socket that `self` is
</div>

#### `net.SocketIO.listen(self, num=16)` {#SocketIO.listen}
{: .method .no_toc }

<div class="method-text" markdown="1">
Begins listening for connections, and only allows `num` to be active at once before refusing connections
</div>

#### `net.SocketIO.accept(self)` {#SocketIO.accept}
{: .method .no_toc }

<div class="method-text" markdown="1">
Accepts a new connection, returning a tuple of `(sock, name)` which are a [`net.SocketIO`](#SocketIO) object that can be read from and written to, and a string representing the client's name
</div>

---
