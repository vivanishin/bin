#!/usr/bin/python
# Takes a log produced with d8 --trace-opt.
# Outputs total time spent optimizing funcitons.

import sys
import os
import re

# V8:
#  if (FLAG_trace_opt) {
#    PrintF("[optimizing ");
#    function->ShortPrint();
#    PrintF(" - took %0.3f, %0.3f, %0.3f ms]\n", ms_creategraph, ms_optimize,
#           ms_codegen);
#  }

regex = re.compile("\[optimizing.*took (\d*\.\d*), (\d*\.\d*), (\d*\.\d*) ms\]")

if len(sys.argv) < 2:
    print "Please provide an input file"
    exit()

input_filename = sys.argv[1]

total = 0

for line in open(input_filename):
    match = re.search(regex, line)
    if match:
        ms_creategraph, ms_optimize, ms_codegen = [float(t) for t in match.groups()]
        total += ms_optimize + ms_codegen + ms_creategraph

print str(total)  + " ms"
