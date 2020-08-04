# TODO: Organize this file

# NOTE: ~/.bash_logout - The individual login shell cleanup file, executed when a login shell exits

# TODO: Xfce4 defaults
# TODO: Consider replacing xfce4-clipman with something else. In terms of deps: clipit > qlipper > copyq > xfce4-clipman > parcellite > diodon
#       Features: copyq: Scripting. qlipper: Cross-platform
#       sudo apt install parcellite diodon copyq clipit qlipper # get testing
# Also consider:
#       screengrab - screenshots; that not-in-repo screenshot tool
#       kazam, slop(maim)
# Also check out: dzen2, xmobar, lemonbar

# TODO: My dotfiles, use a pipe file for stuff like tmux bar, check for its existence
#       Do keyboard shortcuts through something universal(what was that X11 shortcut thingy I tried to use for speedhack? Check Erlend chat)
#       Figure out which other states the prompt update crashes(happens most often in real TTY)


# In likelihood of ll-net, create similar utility for disk, cpu, memory, processes, etc. - just overall monitoring
#       cat /proc/stat | head -n 1 -> sum(columns 1,2,3,6,7,9,10) / sum(all columns)

# Lookup: How to create temp filesystem mountpoints

# TODO: Compile info like how to reload xmodmap, how to setup global hotkeys, etc.

# DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# TODO: autorun.sh - check if there's already a compositor running
# TODO: Investigate checking network interface for conky when loading the config

# Look at other people's dotfiles:
#    E.g. https://github.com/msafadieh/dotfiles/

# TODO: Where to put: 'setxkbmap -option keypad:pointerkeys and shift+numlock4' (enables numpad mouse)

# TODO: Syncing of: Clementine DB. libpurple logs.

# Compton manpage:
#        --glx-fshader-win SHADER
#           GLX backend: Use specified GLSL fragment shader for rendering window contents. See
#           compton-default-fshader-win.glsl and compton-fake-transparency-fshader-win.glsl in the
#           source tree for examples.
#		 --force-win-blend - if it ever makes opaque pixels transparent

# TODO: Find or make mcomix AppImage - consider doing this for more stable-for-a-long-time programs :0

# TODO/Research: Is software corrections for a display's poor gray-to-gray possible?

# TODO: Set shell (possibly query)
# TODO: dialog/whiplash logout/session dialog

# TODO: Find out what package (if any) provides "/bin/$NAME" or "/usr/bin/local/$NAME"
# TODO: Calibrate color balance

# NOTE: ${@:2}; can be used to use arguments from position 2 onward

# Look up: How to use command line or IPC for switching workspaces etc. ideally also launch programs DE-agnostic


Try out other WMs and DEs - any super scriptable ones?
Actual timeout, but only if tmux isn't attached. Or, can I catch the parent terminal emulator being closed?
Are tricopter drones viable?
Is there Linux lib for all kinds of system stats?

About testing: Once you get it, might be possible to print same summary using preexec and precmd or whatever it was called.
rm, mv, cp with history - what about hooking?


------------------------------------------------------------------------
# Programs and utilities to install:

# Debian: zram-tools & /etc/default/zramswap | Ubuntu: zram-config & good to go
# cairo-dock
# i-nex kinfocenter                                  # CPU info, detailed(not in repos?). KDE's hw info

# Development

    rxvt-unicode tmux zsh xsel                                  # terminal stack
    ack most lsof htop joe source-highlight colordiff    # terminal utils


# Management
    stress-ng lm-sensors hddtemp                         # Stress testing, temperature, HDD temperature
    conky-all lshw-gtk hardinfo                          # system monitoring in GUI
    net-tools                                            # contains netstat
    exfat-fuse exfat-utils ntfs-3g                       # filesystep support
# unlikely to be missing but hey:
    wget
# Development
    git make automake cmake build-essential
    python3 ipython3 python3-pip python3-setuptools python3-tk python3-wxgtk4.0 luajit luarocks
    dhex ghex
# Desktop programs:
    file-roller unrar-free furiusisomount brasero
    volti flameshot xfce4-clipman redshift-gtk
    rofi # replaces dmenu_run from suckless-tools
    geany geany-plugins
    pidgin pidgin-plugin-pack
    calibre imagemagick
    baobab sqlitebrowser
    qbittorrent

    firefox tor torbrowser-launcher
    pcmanfm ristretto atril clementine
    gimp krita libreoffice
# Keybindings
	sxhkd xbindkeys # sxhkd has more features and is thus preferable


dialog whiptail
sudo add-apt-repository ppa:bartbes/love-stable && sudo apt-get update sudo apt-get install love





------------------------------------------------------------------------
# From .promptrc:

# TODO: Display ^C if command was not executed - or better yet, clear the prompt!
# TODO: Alternative for timestamp is: preexec () { echo "$(date +%H:%M:%S)"
# TODO: preexec + precmd = notification when a command is complete
# TODO: Disable refresh in more widgets, e.g. tab-completion, history, etc.
# TODO: Diagnose and fix bash compatibility
# TODO: Look into the installation process again
# TODO: Rename tmux_network_usage to tmux_updates
# TODO: ctrl+shift+z to send process into background without suspending it
# TODO: Rename tmux_network_usage, and do other style updates
# TODO: Fancy menu selector using `read -k1`
# TODO: INSIDE_TRAPALRM trick to avoid queueing up expensive operations (not needed, but for reference)
# TODO: Bad idea? Instead of rendering a huge amount of text, render a snippet, and allow looking it up?
# TODO: Fix tmux ping display displaying full ping output when it timed out

# Note: file for file type

# sudo lshw -short | grep -E "^/0[^/]|processor|memory|display|multimedia|volume"

# read -r -s -n1 pass
# $PROMPT_COMMAND variable
# /proc/cpuinfo for processor information
# /proc/$PID for process info

# TODO: Global performance statistics, ohohoho

# source-highlight, iputils-ping, tmux, zsh, most, conky

#set -g status-right '#[fg=red]#(echo ▼$TMUX_DOWNSPEED)#[fg=default]/\
##[fg=green]#(echo ▲$TMUX_UPSPEED)#[fg=default]\
# (#(echo $TMUX_PING))\
# | #[fg=yellow]#(cut -d " " -f 1-3 /proc/loadavg)#[default]\
# | #[fg=cyan]#(echo $TMUX_MEMORY)#[default]\
# | #[bg=blue]%H:%M#[default]'

#preexec() {
#    echo preexec $1
#    if [[ $1 == "" ]] ; then
#        LINENO=LINENO - 1
#    fi
#}
#precmd() {
#
#    echo precmd $1
#}

# Permissions: Special Permissions Flag, Owner(Read, Write, Execute), Group(RWE), All Users(RWE)




------------------------------------------------------------------------
# WIP tomfoolery from .functions:

# Take time
# Check time, if over 5s, start displaying the stuff
# ESC[#A 	moves cursor up # lines, B for down, C for left, D for right
# ESC[K 	clear to end of line

# /etc/termcap  is  an  ASCII  file (the database master) that lists the capabilities of many different types of
# terminals.  Programs can read termcap to find the particular escape codes needed to  control  the  visual  at‐
# tributes  of the terminal actually in use.  (Other aspects of the terminal are handled by stty(1).)  The term‐
# cap database is indexed on the TERM environment variable.

# TODO: wc -l for longer summaries
# TODO: Figure out how to update this even with no new input happening

testing(){
    local START_TIME=$(date +%s)
    local CUR_TIME=0
    local COUNTING=""
    printf "\n"
    while read data; do
        CUR_TIME=$(date +%s)
        CUR_TIME=$((CUR_TIME - START_TIME))
        printf $'\033[1A\033[K'
        printf "%s\n" "$data"
        printf "[Time: %s]\n" "$CUR_TIME"
    done
}

# The only way to save/restore colors would be manually catch and parse them
timestamp() {
    while read data; do
        local cur_time=$(date +%H:%M:%S)
        printf "\033[s[%s]\033[u %s\n" "$cur_time" "$data"
    done
}

procs() {
    while read data; do
        local pids=$(ps -o cmd,pid | tail -n +2 | sed 's/\n//')
        printf "[%s]\n" "$pids"
        printf "%s\n" "$data"
    done
}

# $# - arg count, $@ - all args, $1-9 args

derp() {
    local arr="$@"
    for index in "$@" ; do
        echo $index
        #echo "$index: ${arr[index]}"
    done
}

selector() {
    local P1="   "
    local P2=" > "
    local RUN=1
    local OPT=0

    key=""
    while [[ $RUN == 1 ]] ; do
        local index=0
        for value in "$@" ; do
            echo "$index: $value"
            index=$((index + 1))
        done
        #read -r -s -n1 key # bash ver
        read -sk key # zsh ver
        echo ":"$key":"
        if [[ $key == $"\n" ]] ; then
            echo "ENTAR"
            RUN=0
        fi
    done
    #for option in "$@" ; do
        #echo "$P1$option"
    #done

    #while [[ RUN == 1 ]] ; do
        #echo "${arr[0]}"
    #done
    # $# - arg count, $@ - all args, $1-9 args
    #
}
