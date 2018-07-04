#! /usr/bin/python3

# It is not a standalone script, it does not do the whole job of processing...
# Because the rest it easier for me to do with sed.
# Pass this script a file containing strace log (containing among other things
# the values of environment variables).

import sys

if len(sys.argv) > 1 and sys.argv[1] != '-':
    inp = open(sys.argv[1])
else:
    inp = sys.stdin

lines = []
for line in inp:
    lines += [line]

splitted = lines[0].split(' "')
for i in splitted:
    print(i[:-2])

