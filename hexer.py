#!/usr/bin/python 

import sys

while True:
    try:
        print hex(input("Enter a decimal number -> "))
    except EOFError:
        print "Bye."
        exit()
    except Exception as e:
        print e
