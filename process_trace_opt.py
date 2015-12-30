#!/usr/bin/env python
# parse ouptut of --trace-opt and output total time spent optimizig
import sys
total = 0
for i in sys.stdin:
    if not i.startswith("[optimizing"):
        continue
    i = i[i.find("took")+4:i.find("ms]")]
    a,b,c = eval(i)
    total += a + b + c
print total
