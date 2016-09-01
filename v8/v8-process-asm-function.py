#!/usr/bin/python 
# Takes function dump obtained with --print-code.
# Produces the bytestream in textual form
# typically for v8-asm-to-bin.py consumption

import sys

if len(sys.argv) < 2:
    print "Please provide an input file (containing asm obtained with d8 --print-code)."
    exit()

input_filename = sys.argv[1]

buffer = ""
start_address = ""
for line in open(input_filename):
    split = line.split()
    # ignore comment
    if len(split) < 1 or split[0][0] == ';':
        continue
    buffer += split[2]
    if not start_address:
        start_address = split[0]

out_file_name = input_filename + ".hex"
hex_file = open(out_file_name, "w")
print >> hex_file, buffer
hex_file.close()

print out_file_name
