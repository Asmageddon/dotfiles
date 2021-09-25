#!/bin/bash

source ~/.xprofile

xrdb -merge ~/.Xresources

# Info about different X startup scripts: https://unix.stackexchange.com/questions/281858/difference-between-xinitrc-xsession-and-xsessionrc

if [[ -z $__X_STARTUP_SCRIPT ]] ; then
    export __X_STARTUP_SCRIPT="TRUE"

    xmodmap .Xmodmap

    if [[ -z $__LOCAL_BIN_IN_PATH ]] ; then
        export __LOCAL_BIN_IN_PATH="TRUE"
        export PATH="${PATH}:$HOME/.local/bin"
    fi
fi