#!/bin/bash

die()
{
    [ $# -gt 0 ] && echo >&2 "$@"
    exit 1
}

base=/mnt/shared

if [ $# -ge 1 ]; then
    base=$1
fi

command -v adb >/dev/null 2>&1 || die "adb not found — install android-tools (e.g. pacman -S android-tools)"

device=$(adb get-state 2>/dev/null) || die "No device connected. Enable USB debugging and connect the device."

has_sync=
if adb pull --help 2>&1 | grep -q -- '--sync'; then
    has_sync=1
fi

date_dir=$(date +%Y-%m-%d)
dest="$base/android/$date_dir"
mkdir -p "$dest" || die "Failed to create '$dest'"

pairs=(
    "DCIM:/sdcard/DCIM"
    "Screenshots:/sdcard/Pictures/Screenshots:/sdcard/DCIM/Screenshots:/sdcard/Screenshots"
    "Downloads:/sdcard/Download"
)

for entry in "${pairs[@]}"; do
    name=${entry%%:*}
    candidates=${entry#*:}

    src=
    IFS=: read -ra paths <<< "$candidates"
    for p in "${paths[@]}"; do
        if adb shell "test -d \"$p\"" 2>/dev/null; then
            src=$p
            break
        fi
    done

    if [ -z "$src" ]; then
        echo "$name: no source directory found on device, skipping"
        continue
    fi

    echo "$name: pulling from $src ..."
    if [ -n "$has_sync" ]; then
        adb pull --sync "$src" "$dest/$name" 2>&1
    else
        adb pull "$src" "$dest/$name" 2>&1
    fi
    echo "$name: done"
    echo
done

echo "All done. Files saved under $dest"
