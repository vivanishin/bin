#!/usr/bin/python
from __future__ import print_function
import sys
import re

regex = re.compile("Testcase.*href=\'(.*)\'.*failed")
file = open(sys.argv[1])

for line in file:
    found = re.search(regex, line) 
    if found:
       print(found.group(1))

#='./ecma/Array/15.4.5.1-1.js'>ecma/Array/15.4.5.1-1.js</a> 
