#!/bin/bash

die()
{
    [ $# -gt 0 ] && echo >&2 "$@"
    exit 1
}

dry_run=false

while [ $# -gt 0 ]; do
    case "$1" in
        -n|--dry-run) dry_run=true ;;
        *) die "Usage: $0 [-n]" ;;
    esac
    shift
done

command -v adb >/dev/null 2>&1 || die "adb not found"
adb get-state >/dev/null 2>&1 || die "No device connected"

pairs=(
    "DCIM:/sdcard/DCIM"
    "Screenshots:/sdcard/Pictures/Screenshots:/sdcard/DCIM/Screenshots:/sdcard/Screenshots"
    "Downloads:/sdcard/Download"
)

srcs=()
names=()

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
        echo "$name: no source directory found, skipping"
        continue
    fi

    srcs+=("$src")
    names+=("$name")
done

[ ${#srcs[@]} -eq 0 ] && die "Nothing to delete."

echo "Files to be removed:"
echo

total=0
for i in "${!srcs[@]}"; do
    name=${names[$i]}
    src=${srcs[$i]}

    files=$(adb shell find "$src" -type f 2>/dev/null)
    count=$(echo "$files" | wc -l)
    total=$((total + count))

    echo "$name ($src):"
    if $dry_run; then
        echo "$files" | sed 's/^/  /'
    else
        echo "  $count files"
    fi
    echo
done

echo "Total: $total files"

if $dry_run; then
    echo "(dry run, nothing was deleted)"
else
    echo
    read -p "Delete all of the above from device? [y/N] " confirm
    if [ "$confirm" = y ] || [ "$confirm" = Y ]; then
        for i in "${!srcs[@]}"; do
            name=${names[$i]}
            src=${srcs[$i]}

            echo "$name: deleting files ..."
            adb shell find "$src" -type f -delete 2>&1 || echo "$name: error"
        done
        echo "Done."
    else
        echo "Aborted."
    fi
fi
