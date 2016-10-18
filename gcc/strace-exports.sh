#! /bin/sh -

# Parse strace log (or rather, one entry of such a log) produced with strace -v
# and output interesting environment variables in the form ready to be used in a
# repro script.
# Maybe it could be easily done with strace's functionality, haven't checked.

helper=$(which helper-strace-exports.py) || helper=./helper-strace-exports.py

$helper "${1--}" | sed -e 's;"\?\([A-Z_][A-Z_0-9]\{0,\}=\)\(.*\)$;export \1"\2";g' | grep export | egrep "(GCC|LIB|WRAP|COMPILER|COLLECT)" | grep -v SPECPERLLIB
