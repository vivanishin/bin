#!/bin/sh
# You'll have to cd to the directory containing this script for now.

make hex-to-bin
./preprocess-gdb-mem-x-output.py $1
./hex-to-bin $1
