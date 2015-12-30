#!/usr/bin/python 
# Takes function dump obtained with --print-code.
# Produces the bytestream in textual form
# typically for v8-asm-to-bin.py consumption

import sys


buffer = ""
for line in sys.stdin:
    split = line.split()
    # ignore comment
    if len(split) < 1 or split[0][0] == ';':
        continue
    buffer += split[2]
print buffer
