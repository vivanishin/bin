#!/bin/bash

# We assume filenames w/o spaces.
list_sensitive_files_and_dirs()
{
    sudo ls -d /etc/.git
    sudo find /etc/openvpn/ -name '*.conf' -o -name '*.login'
    sudo find /etc/wpa_supplicant -name '*.conf'

    find ~/.local/share/qutebrowser/ -name 'history.*'
    ls ~/.local/share/qutebrowser/webengine/Cookies
    ls -d ~/.ssh
    ls -d ~/.vpn
    ls ~/.authinfo.gpg
    ls -d ~/.gnupg/private-keys*

    ls ~/bin/config.py # Instapaper

    find ~/.electrum/wallets/ -type f

    ls -d ~/Documents

    ls -d ~/News
    ls ~/.newsrc*

    find ~/.mozilla/firefox -name '*.db' -o -name '*.sqlite'
}

if [ "$1" = "--archive" ]
then
   sudo tar zcvf /tmp/sens.tar.gz $(list_sensitive_files_and_dirs)
   gpg --list-secret-keys
elif [ "$1" = "--remove" ]
then
     sudo rm -rf $(list_sensitive_files_and_dirs)
else
    echo '?'
    exit 1
fi
