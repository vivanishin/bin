#! /bin/sh -

#username=${SSH_USER:-ivladak}
#host=${HOST:-titan}

# We assume here, that current dir is dotfiles (i.e. where dot files are located).

for dotfile in *
do
  echo "$dotfile"
  dotpath=~/".$dotfile"
  if [ -e "$dotpath" ]; then
    echo "$dotpath exists"
    cp "$dotpath" "$dotpath.old"
  fi
  cp "$dotfile" "$dotpath"
done
