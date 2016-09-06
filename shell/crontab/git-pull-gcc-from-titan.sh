#! /bin/sh -

logfile="/media/big/cron-logs/git-pull-gcc.log"
exec 2>>$logfile
exec 1>>$logfile
date_begin=$(date)

echo "=========== $date_begin BEGIN ==========="
echo

cd /home/vlad/gcc-gomp
git fetch --all
git reset --hard origin/elf-semantics-for-nvptx
saved=$?
[ $saved -eq 0 ] || echo "Error code $saved"

echo
echo "============ $date_begin END ($(date)) ============"
