---
layout: default
parent: 'net: Network'
grand_parent: Modules
title: 'net.http: HTTP'
permalink: /modules/net/http
---

# Network HTTP Module ('import nx.http')
{: .no_toc }

This module is a submodule of the [`net`](/modules/net) module. Specifically, it provides HTTP utilities, built on top of the rest of the networking stack.


 * TOC
{:toc}

---

## `net.http.Request(method, uri, httpv, headers, body)`: Request from client {#Request}

This type represents an [HTTP request](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Message_format).


#### net.http.Request.method {#Request.method}
{: .method .no_toc }

<div class="method-text" markdown="1">
A string representing the HTTP method. See [here](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods) for a list.
</div>

#### net.http.Request.uri {#Request.uri}
{: .method .no_toc }

<div class="method-text" markdown="1">
A string representing the requested path. Includes a leading `/`.

For example, a `GET` request to `mysite.com/path/to/dir.txt` would have `'/path/to/dir.txt'` as the `.uri` component

You can use the functions [`net.http.uriencode`](#uriencode) and [`net.http.uridecode`](#uridecode) to encode/decode components of a URI (for example, replaces reserved characters with `%` escapes)
</div>


#### net.http.Request.httpv {#Request.httpv}
{: .method .no_toc }

<div class="method-text" markdown="1">
A string representing the HTTP protocol version. This is almost always `'HTTP/1.1'`
</div>

#### net.http.Request.headers {#Request.headers}
{: .method .no_toc }

<div class="method-text" markdown="1">
A [`dict`](/builtins#dict) representing key-val entries for the headers
</div>

#### net.http.Request.body {#Request.body}
{: .method .no_toc }

<div class="method-text" markdown="1">
A [`bytes`](/builtins#bytes) representing the request body (may be empty)
</div>

---

## `net.http.Response(httpv, code, headers, body)`: Response from server {#Response}

This type represents an [HTTP response](https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol#Message_format).

#### net.http.Response.httpv {#Response.httpv}
{: .method .no_toc }

<div class="method-text" markdown="1">
A string representing the HTTP protocol version. This is almost always `'HTTP/1.1'`
</div>


#### net.http.Response.code {#Response.code}
{: .method .no_toc }

<div class="method-text" markdown="1">
An integer representing the status code. Common values are `200` (OK), `404` (NOTFOUND)
</div>

#### net.http.Response.headers {#Response.headers}
{: .method .no_toc }

<div class="method-text" markdown="1">
A [`dict`](/builtins#dict) representing the key-val pairs of headers
</div>


#### net.http.Response.body {#Response.body}
{: .method .no_toc }

<div class="method-text" markdown="1">
A [`bytes`](/builtins#bytes) object representing the body of the response
</div>

---


## `net.http.Server(addr)`: Server {#Server}

This type represents an HTTP server, which binds itself to `addr`.

Commonly, to host a local server, you will want to give `addr` as `("localhost", 8080)` (or whatever port you want to host on).

Once you've created a server, you should call `serverobj.serve()` ([`net.http.Server.serve()`](#Server.serve)) to serve forever in the current thread. When a new connection is requested, it spawns a new thread and serves each request in a new thread.


Example:

```ks
>>> s = net.http.Server(("localhost", 8080))
>>> s.serve() # Hangs in the current thread, but spawns new ones to handle requests
```

#### net.http.Server.serve(self) {#Server.serve}
{: .method .no_toc }

<div class="method-text" markdown="1">
Serve forever on the current thread, spawning new threads that call [`.handle()`](#Server.handle) for each request
</div>

#### net.http.Server.handle(self, addr, sock, req) {#Server.handle}
{: .method .no_toc }

<div class="method-text" markdown="1">
The request callback, which is called everytime a request is made to the server

It is given the arguments:

  * `addr`: A string representing the client's address
  * `sock`: The socket/socket-like IO (commonly an [`net.SocketIO`](/modules/net#SocketIO)) that can be used to communicate with the client
  * `req`: A request object (specifically, of the type [`net.http.Request`](#Request)), holding the information about the request.

This method should typically not write to `sock`. Instead, it should return either a string, bytes, or a [`net.http.Response`](#Response) object, which will then be automatically written to the socket afterwards.

Here's an example that just returns the path requested:

```ks
func handle(self, addr, sock, req) {
    ret "You asked for: %s" % (req.uri,)
}
```

</div>



#### net.http.Response.httpv {#Response.httpv}
{: .method .no_toc }

<div class="method-text" markdown="1">
A string representing the HTTP protocol version. This is almost always `'HTTP/1.1'`
</div>


#### net.http.Response.code {#Response.code}
{: .method .no_toc }

<div class="method-text" markdown="1">
An integer representing the status code. Common values are `200` (OK), `404` (NOTFOUND)
</div>

#### net.http.Response.headers {#Response.headers}
{: .method .no_toc }

<div class="method-text" markdown="1">
A [`dict`](/builtins#dict) representing the key-val pairs of headers
</div>


#### net.http.Response.body {#Response.body}
{: .method .no_toc }

<div class="method-text" markdown="1">
A [`bytes`](/builtins#bytes) object representing the body of the response
</div>

---





## `net.http.uriencode(text)`: Encode URI components {#uriencode}

This function takes a string, `text`, and encodes reserved characters with appropriate escape codes (see [here](https://en.wikipedia.org/wiki/Percent-encoding))


ASCII characters which are not escaped are added to the output unchanged; all non-ASCII characters are converted to their UTF-8 byte sequence, and `%` escaped each byte sequence

For the inverse of this function, see [`net.http.uridecode`](#uridecode)

Examples:

```ks
>>> net.http.uriencode('hey there everyone')
'hey%20there%20everyone'
>>> net.http.uriencode('I love to eat \N[GREEK SMALL LETTER PI]')
'I%20love%20to%20eat%20%CF%80'
```
---

## `net.http.uridecode(text)`: Decode URI components {#uridecode}

This function takes a string, `text`, and decodes reserved characters from appropriate escape codes (see [here](https://en.wikipedia.org/wiki/Percent-encoding))

Escape sequences outside of the normal ASCII range are taken to be UTF8, and decoded as such

For the inverse of this function, see [`net.http.uriencode`](#uriencode)

Examples:

```ks
>>> net.http.uridecode('hey%20there%20everyone')
'hey there everyone'
>>> net.http.uridecode('I%20love%20to%20eat%20%CF%80')
'I love to eat π'
```
---
