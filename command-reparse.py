#!/usr/bin/python 

import sys

while True:
    try:
        print raw_input("Command w/garbage-> ").translate(None, '",][()\'')
    except EOFError:
        print "Bye."
        exit()
    except Exception as e:
        print e
