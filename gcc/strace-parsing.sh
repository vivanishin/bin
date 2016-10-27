#! /bin/sh -

grep execve | sed -e 's;execve;;g' | grep -v resumed | sed -e 's;\].*$;;g'
