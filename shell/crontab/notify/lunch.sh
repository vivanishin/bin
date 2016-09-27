#! /bin/sh -

DISPLAY=:0 XDG_RUNTIME_DIR=/run/user/$(id -u) yad --title="My Master,"  --text="LUNCH time!" --text-align=center --center
