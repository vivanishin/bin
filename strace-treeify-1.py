#!/usr/bin/python3

import sys

def usage():
  print("treeify-strace <pid-ancestry-data> <pid-exec-data>")
  print("    The first argument is a file containing a 2-column table:")
  print("    <pid parent> <pid child>.")
  print("    The second argument is a talbe containing a mapping from pids to")
  print("    their payloads (arbitrary strings) separated with a space.")

if (len(sys.argv) < 3):
  usage()
  exit(0)

children = {}
def create(pid):
  if (not children.get(pid)):
    children[pid] = []

for line in open(sys.argv[1]):
  parent, child = [int(p) for p in line.split()]
  create (parent)
  create (child)
  children[parent] += [child]

payloads = {}
for line in open(sys.argv[2]):
  pid, payload = line[:-1].split(" ", 1)
  pid = int(pid)
  payloads[pid] = payload

def dfs(p, i):
  if p in vis:
    return
  print("  " * i + str(p) + " " + payloads[p])
  vis.add(p)
  for c in sorted(children[p]):
    dfs(c, i + 1)

vis = set()
for p in sorted(children):
  dfs(p, 0)
