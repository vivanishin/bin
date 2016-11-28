#! /bin/sh -

inst_location=~/bin
if [ ! -e $inst_location  ] || [ ! -w $inst_location ] || [ ! -d $inst_location ]
then
  echo "Error: your inst_location ($inst_location) is not a directory or not writable by this user."
  exit 1
fi

for script in "../command-reparse.py"
do
    cp $script $inst_location
done
