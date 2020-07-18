---
layout: post
title: "Secure Portal"
author: "anishbadhri"
tags: ['Web']
---

This is a super secure portal with a really unusual HTML file. Try to login.

[http://chall.csivit.com:30281](http://chall.csivit.com:30281)

## Solution

In the sourcecode, an unreadable script is at the end. The javascript code can be deobfuscated to an extent with [http://www.jsnice.org/](http://www.jsnice.org/). The script still has a lot of useless functions. On replacing all necessary values into the corresponding locations, we get a final script of
```js
window["localStorage"]["setItem"]("9-12", "BE*");
window["localStorage"]["setItem"]("4-7", "bb=");
window["localStorage"]["setItem"]("0-2", "5W");
window["localStorage"]["setItem"]("16", "^7M");
window["localStorage"]["setItem"]("12-14", "pg");
window["localStorage"]["setItem"]("7-9", "+n");
window["localStorage"]["setItem"]("14-16", "4t");
window["localStorage"]["setItem"]("2-4", "$F");
```
From here, its clearly visible that that the password is just rearranging this into increasing order of key. On entering the password, the flag is obtained.

**Password**: `5W$Fbb=+nBE*pg4t^7M`

## Flag

```
csictf{l3t_m3_c0nfus3_y0u}
```

