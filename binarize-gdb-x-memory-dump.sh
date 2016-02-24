#!/bin/sh
cd ~/s
make hex-to-bin
cd -
~/s/preprocess-gdb-mem-x-output.py $1
~/s/hex-to-bin $1
