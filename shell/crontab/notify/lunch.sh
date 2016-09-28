#! /bin/sh -

event=${1:-LUNCH}

DISPLAY=:0 XDG_RUNTIME_DIR=/run/user/$(id -u) yad --title="My Master,"  --text="$event time!" --text-align=center --center
