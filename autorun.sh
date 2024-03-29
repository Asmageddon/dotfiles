#!/usr/bin/env bash

# Startup: sh -e -c "exec \"$(cat ~/.dotfilesrc)/autorun.sh\""

# More details about specific approaches to checking VM: https://unix.stackexchange.com/q/89714
# sudo virt-what # Unknown output
# sudo dmesg | grep -i hypervisor # Contains idk
# sudo dmidecode -t system|grep 'Product\ Name' # Contains VirtualBox
is_vm() {
    grep -q "^flags.*\ hypervisor" /proc/cpuinfo
}

launch() {
    setsid $@ >/dev/null 2>&1 < /dev/null &
}

bpgrep() {
  ps -eo pid,args | grep "$@" | grep -v "^\s*[0-9]*\s*grep"
}


first-available() {
    for CHOICE in "$@" ; do
        if [[ $(command -v $CHOICE) != "" ]] ; then
            echo $CHOICE; exit
        fi
    done
    echo "ERROR_NONE_FOUND"
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


run-first() {
    run $(first-available $@)
}

# run compton --unredir-if-possible --backend glx --vsync opengl-swc
# Might need: --xrender-sync and --xrender-sync-fence

run sxhkd

run dropbox start -i
run flameshot

run-first redshift-scheduler redshift-gtk

run volti
run /home/asmageddon/.local/bin/pytka
run conky
run xfce4-clipman
run pomodorino

if [[ $(is_vm) != "" && $(command -v VBoxClient-all != "") ]]; then
    notify-send "Launching VBoxClient-all"
    run VBoxClient-all
fi

notify-send "Autorun successfully executed"
