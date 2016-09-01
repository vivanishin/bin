#!/bin/sh
cd ~/s > /dev/null
make hex-to-bin > /dev/null
cd - > /dev/null
hexfile=`~/s/v8-process-asm-function.py $1`
~/s/hex-to-bin $hexfile
