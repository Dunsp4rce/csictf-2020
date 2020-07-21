---
layout: post
title: "Mein Kampf"
author: "raghul-rajasekar"
---

"We have intercepted the enemy's communications, but unfortunately, some data was corrupted during transmission. Can you recover the message?" M4 UKW $ Gamma 2 4 $ 5 9 $ 14 3 $ 5 20 fv cd hu ik es op yl wq jm

"Ciphertext: zkrtwvvvnrkulxhoywoj" (Words in the flag are separated by underscores)

## Solution

From the communication data format, it is clear that this challenge uses Enigma (the challenge title suggests the same too). However, there are dollar signs in a few places where we don't know the machine configuration. The only choice is to brute-force through all possibilities and see for which combination we get an output in the correct flag format. For automating this, I used the [`py-enigma`](https://pypi.org/project/py-enigma/) package in Python.
```python
from enigma.machine import EnigmaMachine 

reflectors = ['B-Thin', 'C-Thin'] 
rotors = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII'] 

for r1 in rotors: 
    for r2 in rotors: 
        for r3 in rotors: 
            for r in reflectors: 
                machine = EnigmaMachine.from_key_sheet( 
                   rotors=' '.join(['Gamma', r1, r2, r3]), 
                   reflector=r, 
                   ring_settings='D I C T', 
                   plugboard_settings='fv cd hu ik es op yl wq jm'.upper()) 
                machine.set_display('BENE') 
                temp = machine.process_text('zkrtwvvvnrkulxhoywoj') 
                if 'CTF' in temp: 
                    print(temp, r1, r2, r3, r) 
```

The output is `CSICTFNOSHITSHERLOCK I IV VII B-Thin`.

## Flag

`csictf{no_shit_sherlock}`

