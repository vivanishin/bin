# My .vimrc file looks like this:
# ...
# let TABWIDTH=8
# let &tabstop=TABWIDTH
# let &shiftwidth=TABWIDTH
# ...
# Sometimes I need to change the value after TABWIDTH=
# This script does exactly that. The defauld value is 8.

tmpfile=/tmp/vitab$$
vimrc=~/.vimrc

sed_cmd="s/\(TABWIDTH=\)\(.*\)/\1${1:-8}/g"
cat $vimrc | sed -e $sed_cmd > tmpfile

cat tmpfile > $vimrc
rm tmpfile
