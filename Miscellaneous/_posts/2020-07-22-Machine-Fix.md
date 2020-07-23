---
layout: post
title: "Machine-Fix"
author: "AnandSaminathan"
tags: ['Miscellaneous']
---

We ran a code on a machine a few years ago. It is still running however we forgot what it was meant for. It completed n=523693181734689806809285195318 iterations of the loop and broke down. We want the answer but cannot wait a few more years. Find the answer after n iterations to get the flag.

The flag would be of the format csictf{answer_you_get_from_above}.


**Files**
- [machine-fix.py]({{site.baseurl}}/assets/Machine-fix/machine-fix.py)

## Solution

The python code in this question has a loop which runs `523693181734689806809285195318` times which is never ending. Instead of trying to find of what it does and how to optimize it, we generated the result for iterations 1 to 10 (`[1, 2, 4, 5, 6, 8, 9, 10, 13, 14]`) and used [oeis](http://oeis.org/) to find out some formula for the sequence. And there was a recursive formula which generated the required sequence:
``` 
a(n) = n + a(n/3)
a(0) = 0 
```

Implementation of this recursive function is much faster than what they had implemented:

```python
def rec(n):
    if n == 0: return 0
    return n+rec(n//3)

rec(523693181734689806809285195318)
```
And we got the answer in no time - 785539772602034710213927792950.

## Flag

```
csictf{785539772602034710213927792950}
```

