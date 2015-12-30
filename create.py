#!/usr/bin/python
import sys
res_str = "\""
for line in sys.stdin:
    for i in line:
        if i == "\"":
            res_str += '\\"' # " -> \"
        elif i == "\n":
            res_str += '\\n'
        else:
            res_str += i
print res_str            
