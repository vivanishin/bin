#!/bin/bash

# This script helps debugging the "patch does not apply" problem by extracting
# the source file contents (matched against the contents of the actual file
# being patched) from the patch.

patch=$1

sed -n "/@@/,/@@/ p" "$patch" |
    tail -n +2 | head -n -1 |
    grep -v '^[+-]' |
    sed 's/^.//'

# Compare the result to:
# sed -n '$start,$end p' "$file"
