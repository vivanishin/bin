#!/usr/bin/python 

import sys

while True:
    try:
        print raw_input().translate(None, '",][()\'')
    except EOFError:
        sys.exit()
    except Exception as e:
        print e
	sys.exit(1)
