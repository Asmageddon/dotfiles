#!/usr/bin/env bash

launch() {
    setsid $@ >/dev/null 2>&1 < /dev/null &
}

bpgrep() {
  ps -eo pid,args | grep "$@" | grep -v "^\s*[0-9]*\s*grep"
}

run() {
  # bpgrep $1
  if [[ "$(bpgrep $1)" == "" ]] ; then
    echo "Launching: '$@'"
    launch $@
  else
    echo "Already running: '$1' ('$@')"
  fi
}

# run compton --unredir-if-possible --backend glx --vsync opengl-swc
# Might need: --xrender-sync and --xrender-sync-fence

run sxhkd
pkill -SIGUSR1 sxhkd

run dropbox start -i
run flameshot
run redshift-gtk
run volti
run /home/asmageddon/.local/bin/pytka
run conky
run xfce4-clipman

notify-send "Autorun successfully executed"
