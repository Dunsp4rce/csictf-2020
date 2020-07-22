---
layout: post
title: "Prime-Roll"
author: "raghul-rajasekar"
tags: ['Miscellaneous']
---
We built a random number generator and it just rolls dice in the background and prints the result of the roll. We love prime numbers so a dice with (10^9)+7 (a famous prime number) sides is used. To simulate random behaviour, the machine rolls the dice n number of times, where n equals the 2^((10^9)+7) (th) prime number. We want to know the probability of the largest result among all these rolls being a prime number too. You can stop the machine from rolling dices till the Heat Death of the universe by telling us the answer beforehand. Calculate the first 10 digits after the decimal place.

The flag will look like -> csictf{first_10_digits_after_the_decimal_point}

## Solution

Not sure what this question was about, but intuitively at least, if you roll a die many times, the probability of the largest number on the die appearing at least once tends to 1. Since the largest number in this case is 10^9 + 7 (which is prime), the probability of the largest result among all these rolls being a prime number also tends to 1 (something like 0.999999999999...). Thus, the first 10 digits after the decimal place are most likely `9999999999`, without even calculating.

## Flag

```
csictf{9999999999}
```
