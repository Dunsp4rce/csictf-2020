---
layout: post
title: "Gradient sky"
author: "INXS_JOY"
tags: ['Forensics']
---

Gradient sky is a begginer level ctf challenge which is aimed towards rookies.

**Files**
- [sky.jpg](
https://ctf.csivit.com/files/26679530ae48abdd115d63afbb110aa7/sky.jpg?token=eyJ1c2VyX2lkIjo3NjMsInRlYW1faWQiOjI1MSwiZmlsZV9pZCI6NDQwOH0.XxR6FA.SEk0TLjKmCoENWQIE-Ac-YlntDo)

## Solution
The **strings** command in linux returns each **string** of printable characters in a file. 

So we use the strings command on the jpg file,
```strings sky.jpg```

It produces a bunch of strings, in the bottom of the list we find the flag.
## Flag
```csictf{j0ker_w4snt_happy}```
