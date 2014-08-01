xmodmap .Xmodmap

if [[ -z $__LOCAL_BIN_IN_PATH ]] ; then
    export __LOCAL_BIN_IN_PATH="TRUE"
    export PATH="${PATH}:$HOME/.local/bin"
fi