#! /bin/sh -

logfile=/media/big/cron-logs/git-pull-gcc.log
exec 2>>$logfile
exec 1>>$logfile
date_begin=$(date)

echo "=========== $date_begin BEGIN ==========="
cd /home/vlad/gcc-gomp
git pull
echo "============ $date_begin END ($(date)) ============"
