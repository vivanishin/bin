#!/usr/bin/env python
# parse ouptut of --trace-opt and output total time spent optimizig
import sys
import re
import itertools
regex = re.compile('0x[0-9a-f]|[0-9]+\.[0-9]*')
#regex = re.compile('0x[0-9a-f]')
total = 0
for line in sys.stdin:
    for i in itertools.ifilterfalse(lambda s: regex.search(s) , line.split()):
        print i,
    print 
