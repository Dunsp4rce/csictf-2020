---
layout: post
title: "In Your Eyes"
author: "vishalananth"
tags: ['Forensics']
---

'I talk of wondrous things I see, You picture purely out of imagination, You wonder how your light is spent, Days seem bright but you don't know for sure. I stand in your place and close my eyes, What do I see? (Open your windows to see the secret message)'

## Solution

Probably the hardest challenge in this CTF because of how clueless I was after every Steganography tool I had failed in finding any useful information. Thankfully we got a clue towards the end of the CTF where it was mentioned that we should use a windows tool to find the data from the image. So after trying all these Windows tools

```
Blind Side
S-Tools
Xiao
Crypture
SteganographX Plus
BMP Secrets
Hexa Stego BMP
```

I ended up getting something useful when using a tool called `QuickStego`. 

![alt text]({{site.baseurl}}/assets/In-Your-Eyes/ans.png)

So, now we have a hex string `2471491ED07C69930E8F994E383E415F`. Converting this to binary we get:

```
100100011100010100100100011110110100000111110001101001100100110000111010001111100110010100111000111000001111100100000101011111
```

Reading the question we can see that one of the two people is blind, So decoding using braille at [http://tyleregeto.com/article/braille-6bit-binary-language](http://tyleregeto.com/article/braille-6bit-binary-language) we get the flag.

## Flag

```
csictf{ucbr4ill3}
```
