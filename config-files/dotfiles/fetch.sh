#! /bin/sh -

username=${SSH_USER:-ivladak}
host=${HOST:-titan}

# We assume here, that current dir is dotfiles (i.e. where dot files are located).

for dotfile in *
do
    path='~/'".$dotfile" # Expand tilta after ssh'ing.
    if ssh "$username@$host" "test -e $path"; then
        scp "$username@$host":"$path" "$dotfile"
    fi
done
