#! /bin/sh -

# This is supposed to be run when I log in to my work computer
# in the morning, once a day. This can be achieved with acron.
# The script copies an updated todo and creates a diff against
# the todo from the previous run of the script. That constitutes
# the diff for yesterday (more precisely for the previous day I
# worked on the computer).


logfile="/media/big/cron-logs/todo-diffs.log"
exec 2>>$logfile
exec 1>>$logfile
echo `date` # Watch how acron schedules this job.

# I assume the user running this script is vlad.
wd=~/".todo-diffs"
todo_upstream=~/"yandex.disk/work/todo"
todo_cur="$wd/todo"
todo_old="$wd/todo.old"

if [ ! -e "$wd" ]; then
    mkdir -p "$wd"
fi

if [ ! -e "$todo_cur" ]; then
    cp "$todo_upstream" "$todo_cur"
    exit
fi

last_modification_date=$(stat --printf=%y "$todo_cur" | awk '{print $1}')
diff_file="$wd/$last_modification_date-todo.diff"

cp "$todo_cur" "$todo_old"
cp "$todo_upstream" "$todo_cur"

diff "$todo_cur" "$todo_old" > "$diff_file"
