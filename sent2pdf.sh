#!/bin/sh -

trap '[ -n "$pid" ] && kill $pid' EXIT

rm -f ??.png
sent $1 &
sleep 1 # I am ashamed...
pid=$!
i=0
# TODO: abort if there's more than 1 `sent` running.
xdotool search --name 'sent' windowfocus
while ! cmp -s $(ls -rt -1 | tail -2)
do
  scrot $(printf "%02d.png" $i)
  xdotool search --name 'sent' key space
  if [ $(ls | wc -l) -gt 100 ]; then
    echo "too many slides"
    exit 1
  fi
  i=$((i+1))
done
rm $(printf "%02d.png" $((i-1)))
convert ??.png "$1.pdf"
