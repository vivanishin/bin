#!/bin/bash -

from='/Volumes/Kindle/documents/My Clippings.txt'
to=$(date +%v | awk -F- '{ print "my-clippings-" $3 "-" $2 "-" $1 ".txt" }')

if [ -f "$from" ]
then
  cp "$from" "$to"
else
  echo "Cannot find '$from'. Check if the device is connected."
  exit 1
fi
