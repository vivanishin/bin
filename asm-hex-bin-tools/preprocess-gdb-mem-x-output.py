#!/usr/bin/python
# Take a file containing output of a gdb examine command like `x/748xb 0xad74f240ba0`
#
# (it looks like this:
#   ...
#   0xad74f240da8: 0xd8    0x4c    0x8b    0x4d    0xe0    0x8b    0x41    0x23
#   --Type <return> to continue, or q <return> to quit---
#   0xad74f240db0:  0xff    0xc0    0x0f    0x80    0xc1    0x00    0x00    0x00
#   ...
# ) and turn it into a hex string encoded as plain ASCII text:
#
# ...d84c8b4de08b4123ffc00f80c1000000...

# Be aware that this script rewrites the input file.

import sys
import re

if len(sys.argv) < 2:
    print "Please provide an input file (containing gdb `x` output)."
    exit()

input_filename = sys.argv[1]

hex_byte = re.compile("0x(..)\s")

hex_stream = ""
for line in open(input_filename):
    hex_stream += "".join(hex_byte.findall(line))

the_file = open(input_filename, "w")
print >> the_file, hex_stream
the_file.close()
