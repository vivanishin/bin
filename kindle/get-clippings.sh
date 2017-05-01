#!/bin/bash -

from='/run/media/vlad/Kindle/documents/My Clippings.txt'
to="my-clippings-"$(date +%Y-%m-%d)".txt"

if [ -f "$from" ]
then
  cp "$from" "$to"
else
  echo "Cannot find '$from'. Check if the device is connected."
  exit 1
fi
