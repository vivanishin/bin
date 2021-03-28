#!/usr/bin/env python

def p(a, b): return (a - b) * 100. / min(a, b)

print (p (int(input()), int(input())))
