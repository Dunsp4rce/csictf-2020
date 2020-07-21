---
layout: post
title: "Quick Math"
author: "anishbadhri"
tags: ['Crypto']
---

Ben has encrypted a message with the same value of 'e' for 3 public moduli 
- n1 = 86812553978993 
- n2 = 81744303091421 
- n3 = 83695120256591 

and got the cipher texts 
- c1 = 8875674977048 
- c2 = 70744354709710 
- c3 = 29146719498409

Find the original message. (Wrap it with csictf{})

## Solution

The given problem is a typical example of [hastad attack](https://en.wikipedia.org/wiki/Coppersmith%27s_attack#H%C3%A5stad%27s_broadcast_attack). Given 3 pairs of `n` and `c` with the same value of `e=3`, the original message can be decoded.

**Solution Script**:
```python
from pwn import remote
from sympy.ntheory.modular import crt
from gmpy2 import iroot

e = 3
N = [86812553978993, 81744303091421, 83695120256591]
C = [8875674977048, 70744354709710, 29146719498409]

resultant, mod = crt(N,C)
value, is_perfect = iroot(resultant,e)
print(bytes.fromhex(str(value)).decode())
```

## Flag
```
csictf{h45t4d}
```

