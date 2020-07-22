---
layout: post
title: "Commitment"
author: "vishalananth"
tags: ['OSINT']
---

hoshimaseok is up to no good. Track him down.

## Solution

We open sherlock and search for the given username

```
python3 sherlock hoshimaseok
```

We get lots of useful results from  Facebook, Github, Instagram, Reddit and Twitter. We check them one by one to eliminate false positives and end up with the Github account: [https://github.com/hoshimaseok](https://github.com/hoshimaseok)(in hindsight the challenge name is a clue :P). We see a repo named `SomethingFishy` and we look into the commit history. We check them one by one and we see a commit message `feat: Looking for flag?`. Looking at that we see a lot of hebrew text which sadly was a distraction and did'nt give us any useful information. Looking into the other commits we see that the commit `fix: userSchema.js fix` has a deleted `.env` file with the flag.

## Flag
```
csictf{sc4r3d_0f_c0mm1tm3nt}
```
