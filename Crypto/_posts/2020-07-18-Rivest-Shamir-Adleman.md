---
layout: post
title: "Rivest Shamir Adleman"
author: "anishbadhri"
tags: ['Crypto']
---

These 3 guys encrypted my flag, but they didn't tell me how to decrypt it.

**Files**:
- [enc.txt](https://ctf.csivit.com/files/13db735cb25a739baf073ce40b761a85/enc.txt?token=eyJ1c2VyX2lkIjo3NjUsInRlYW1faWQiOjI1MSwiZmlsZV9pZCI6NDMwM30.XxLArg.4DrNUlUL78a4rewLoEs8md4irdI)

## Solution

The values of `n` is generated using a small prime. One of the primes can be searched using brute-force and the message can then be decrypted.

**Solution Script**:

```python
import mod

f = open("enc.txt").read().split('\n')
n = int(f[0].split()[2])
e = int(f[1].split()[2])
c = int(f[2].split()[2])

p = None
for i in range(2,n):
	if n % i == 0:
		p = i
		break
q = n // p
phi = (p-1) * (q-1)

em = mod.Mod(e, phi)
d = int(1 // em)
cm = mod.Mod(c, n)
dec = int(cm ** d)

print(bytes.fromhex(hex(dec)[2:]))
```

## Flag

```
csictf{sh0uld'v3_t4k3n_b1gg3r_pr1m3s}
```