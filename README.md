Datasizes
=========

**datasizes** gem provides simple API for converting `dd` like 
data amount postfixes (like `3M` or `4G`) to bytes and bytes to these 
strings.

Usage is simple (see API reference for details):
  
  Datasizes::to_bytes("3K")           # will return 3072
  Datasizes::to_magnitude(3072, :K)   # will return "3K"
  Datasizes::from_bytes(3145728)      # will return "3M"
  
    
Contributing
------------

1. Fork it.
2. Create a branch (`git checkout -b 20101220-my-change`).
3. Commit your changes (`git commit -am "Added something"`).
4. Push to the branch (`git push origin 20101220-my-change`).
5. Create an [Issue][9] with a link to your branch.
6. Enjoy a refreshing Diet Coke and wait.


Copyright
---------

Copyright &copy; 2012-2014 [Martin Poljak][10]. See `LICENSE.txt` 
for further details.

[9]: http://github.com/martinkozak/datasizes/issues
[10]: http://www.martinpoljak.net/
