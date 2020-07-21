---
layout: post
title: "little RSA"
author: "anishbadhri"
tags: ['Crypto']
---

The flag.zip contains the flag I am looking for but it is password protected. The password is the encrypted message which has to be correctly decrypted so I can useit to open the zip file. I tried using RSA but the zip doesn't open by it. Can you help me get the flag please?

**Files**:
- [a.txt](https://ctf.csivit.com/files/d636798f02ac223b21ed0d76e3e95d73/a.txt?token=eyJ1c2VyX2lkIjo3NjUsInRlYW1faWQiOjI1MSwiZmlsZV9pZCI6NDg0OH0.Xxb5Hw.GTxrUrWmx4ZczLXjkt1va12syY0)
- [flag.zip](https://ctf.csivit.com/files/c35979df09249404a47691808e78e134/flag.zip?token=eyJ1c2VyX2lkIjo3NjUsInRlYW1faWQiOjI1MSwiZmlsZV9pZCI6NDg0OX0.Xxb5Hw.ZWQOiVrcMPuWbTshmgWxSu2ChFo)

## Solution

The file `a.txt` has a really small value of `n`. The factors of this value can be brute-forced for directly and then an integer is obtained. The only file in `flag.zip` is `flag.txt` which is password-protected. The password to this file is the integer which is obtained.

**Solution Script**:
```python
import mod

c=32949
n=64741
e=42667

p = None
for i in range(2,n):
	if n % i == 0:
		p = i
		break

q = n // p
em = mod.Mod(e, (p-1) * (q-1))
d = int(1//em)
cm = mod.Mod(c,n)
ans = int(cm ** d)
print(ans)
```

## Flag
```
csictf{gr34t_m1nds_th1nk_4l1ke}
```
