scripts='~/src/build-default.sh ~/S/command-reparse.py ~/S/strace-gen-reproduce.sh'

for s in "$scripts"
do
  scp ivladak@titan:"$s" .
done
