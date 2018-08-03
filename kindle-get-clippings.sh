#!/bin/bash -

from="/mnt/kindle/documents/My Clippings.txt"
to="/mnt/co/notes/personal/kindle-clippings.txt"

if [ -f "$from" ]
then
  cp "$from" "$to"
  chmod -x "$to"
  dos2unix "$to"
  sed -i 's/ $//g' "$to"
else
  echo "Cannot find '$from'. Check if the device is connected."
  exit 1
fi
