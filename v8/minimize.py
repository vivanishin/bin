#!/usr/bin/python
# Takes testing log produced by tools/run-tests.py.
# Produces the list of failed tests sorted by file size.

import sys
import os

if len(sys.argv) < 2:
    print "Please provide an input file"
    exit()

input_filename = sys.argv[1]

failed_test_filenames = []

for line in open(input_filename):
    if "Command:" in line:
        last = line.split()[-1]
        if last[-2:] == "js":
            failed_test_filenames += [last]

def compare(x, y):
    return os.stat(x).st_size < os.stat(y).st_size

failed_test_filenames.sort(compare)

for f in failed_test_filenames[-10:]:
    print f
