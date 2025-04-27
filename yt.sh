#!/bin/bash

die()
{
    [ $# -gt 0 ] && echo >&2 "$@"
    exit 1
}

maybe_add_proxy()
{
    local url=$1
    case "$url" in
        https://youtube.com*|https://www.youtube.com*|https://youtu.be*)
            printf "%s\n" "${proxy[@]}"
            ;;
        *)
            :
            ;;
    esac
    echo "$url"
}

cmd=(yt-dlp --cookies-from-browser chromium:~/.local/share/qutebrowser)
proxy=(--proxy socks://127.0.0.1:5050)

ignore_output=true
while [ $# -gt 0 ]; do
    case "$1" in
        --sport|-s|--playlist)
            cmd+=(-o "%(playlist_index)s:%(title)s.%(ext)s")
            ;;
        --proxy|-p)
            cmd+=("${proxy[@]}")
            ;;
        -v|--verbose)
            ignore_output=false
            ;;
        --quality)
            cmd+=(-f)
            case "$2" in
                auto)
                    cmd+=(bestvideo.2+bestaudio)
                    ;;
                *)
                    cmd+=("$2")
                    ;;
            esac
            shift
            ;;
        --*)
            cmd+=($1)
            ;;
        *)
            [ $# -eq 1 ] || die "extra arguments:" "$@"
            readarray -t -O "${#cmd[@]}" cmd < <(maybe_add_proxy "$1")
            ;;
    esac
    shift
done

if $ignore_output; then
   "${cmd[@]}" &>/dev/null
else
   "${cmd[@]}"
fi

