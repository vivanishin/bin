#! /bin/sh -

event=${1:-LUNCH}
suffix="${2-time!}"

DISPLAY=:0 XDG_RUNTIME_DIR=/run/user/$(id -u) yad --title="My Master,"  --text="$event $suffix" --text-align=center --center
