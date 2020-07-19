---
layout: post
title: "Archenemy"
author: "INXS_JOY"
tags: ['Forensics']
---

John likes Arch Linux. What is he hiding?

**Files**
- [arched.png](https://ctf.csivit.com/files/3dc9fa09ba9d534332c7dd9271a3441d/arched.png?token=eyJ1c2VyX2lkIjo3NjMsInRlYW1faWQiOjI1MSwiZmlsZV9pZCI6NDQxM30.XxR7tw.bETdq_7FSVFM2pshbtDsZOyL3bU)

## Solution
>Its always a good practice to check the file format of all files while doing Forensics.

I used the command  `file arched.png` to check the file type. As suspected, I got this,
```
arched.png: JPEG image data, JFIF standard 1.01, resolution (DPI), density 300x300, segment length 16, baseline, precision 8, 1920x1080, components 3
```
So arched.png is a JPEG file. Let's change the extension to .jpeg

Next, I ran the image file through [Stego-Toolkit](https://github.com/DominicBreuker/stego-toolkit) and noticed that steghide found a embedded flag.zip file in the image.

Trying to unzip the flag.zip asks for a password, but we weren't provided with any passwords. So I tried to brute force the password using [fcrackzip](https://pentaroot.com/cracking-encrypted-zip-fcrackzip/).
>Fcrackzip tries all the passwords from any word-list we provide. In this case I used rockyou word-list which is a list of common passwords.  
 
Using the command, `fcrackzip -v -u -D -p /usr/share/wordlists/rockyou.txt flag.zip`, we get the following output,
```
found file 'meme.jpg', (size cp/uc  27553/ 27752, flags 9, chk 9ed1)


PASSWORD FOUND!!!!: pw == kathmandu
```
So, the password for the flag.zip is `kathmandu`. Extracting the contents, we get a file meme.jpg. Opening it, we find the flag at the bottom of the image.  

![alt text]({{site.baseurl}}/assets/Archenemy/meme.jpg)

## Flag
```
csictf{1_h0pe_y0u_don't_s33_m3_here}
```
