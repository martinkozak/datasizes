Datasizes
=========

**datasizes** gem provides simple API for converting `dd` like
data amount postfixes (like `3M` or `4G`) to bytes and bytes to these
strings.

Usage is simple (see API reference for details):

```ruby  
Datasizes::to_bytes("3K")           # will return 3072
Datasizes::to_magnitude(3072, :K)   # will return "3K"
Datasizes::from_bytes(3145728)      # will return "3M"
```

Copyright
---------

Copyright &copy; 2012 &ndash; 2015 [Martin Poljak][10]. See `LICENSE.txt`
for further details.

[9]: http://github.com/martinkozak/datasizes/issues
[10]: http://www.martinpoljak.net/
