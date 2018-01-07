#!/usr/bin/python

import sys
import os.path
import string

def contents(filename):
  result = ""
  for line in open(filename):
    result += line.translate(string.maketrans("\n", " "))
  return result

def expand_at_symbol(s):
  """
  GCC uses the following notation to include the contents of a file foo:
    @foo
  This function reconstructs the verbose command line, substituting the
  contents of foo (with newlines replaced by spaces) for the reference.

  If foo is not a file, the occurance of @foo is unchanged.
  """
  words = s.split()
  for i in range(len(words)):
    w = words[i]
    if w.startswith("@"):
      maybe_file = w[1:]
      if (os.path.isfile(maybe_file)):
        words[i] = contents(maybe_file)
  return " ".join(words)


while True:
    try:
        at_expanded = expand_at_symbol(raw_input().translate(None, '",][()\''))
        words = at_expanded.split()
        # At this point words usually contain [<pid> command command <args...> ]
        start_idx = 2 if words[1] == words[2] else 0
        print " ".join(words[start_idx:])
    except EOFError:
        sys.exit()
    except Exception as e:
        print e
	sys.exit(1)
