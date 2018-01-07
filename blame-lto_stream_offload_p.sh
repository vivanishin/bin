#! /bin/sh -

# This script shows lines in git blame (and delta surrounding lines in both directions)
# which contain (in current revision) a string. 
# Right now the first (or rather, its result) is hardcoded as /tmp/1.

min()
{
  if [ "$1" -lt "$2" ]; then
    echo "$1"
  else
    echo "$2"
  fi
}

max()
{
  if [ "$1" -ge "$2" ]; then
    echo "$1"
  else
    echo "$2"
  fi
}

delta=2
#showfind lto_stream_offload_p | 
cat /tmp/1 |
  while read entry 
  do
    filename=$(echo "$entry" | awk -F: '{ print $1 }')
    line=$(echo "$entry" | awk -F: '{ print $2 }')
    num_lines=$(cat "$filename" | wc -l) # Either this cat or another awk/cut.
    first_line=$(max 1 $(($line - $delta)) )
    last_line=$(min $num_lines $(($line + $delta)) )
    echo "$filename: "
    git --no-pager blame -L"$first_line","$last_line" "$filename"
  done 
