#!/bin/sh -

chunk_size=${2:-9M}

base=$(basename -s .mp4 $1)

split -d -a 3 -b $chunk_size $1 $base.
cat << EOF >  $base.crc
filename=$1
size=$(wc -c $1 | awk '{print $1}')
crc32=$(cksfv -c $1 | tail -1 | awk '{print $2}')
EOF
