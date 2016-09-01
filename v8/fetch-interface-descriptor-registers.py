#!/usr/bin/python
import re

regex = re.compile("Register registers\[\]\s?=\s?\{(.*)\}")

res = set()
for line in open("/home/vlad/code/blessed-v8/v8/src/x64/interface-descriptors-x64.cc"):
    found = regex.findall(line)
    if found:
        res.add(tuple("".join(found).split()))
   
casted = sorted(res)
cnt = 1
for i in xrange(len(casted) - 1):
    if ",".join(casted[i + 1]).startswith(",".join(casted[i])):
        print casted[i]
        cnt += 1

print casted[-1]
print cnt
