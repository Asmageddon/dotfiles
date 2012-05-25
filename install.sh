#!/bin/bash
#Won't work executed by zsh or by sh

if [[ -n $* ]] ; then
	installation_dir=$*
else
	installation_dir="$HOME"
fi

if [[ ! -d "$installation_dir/.rcbackup/" ]] ; then
    mkdir "$installation_dir/.rcbackup/"
else
    if [ ! is_empty "$installation_dir/.rcbackup/" ] ; then
        printf ".rcbackup directory already exists. Continue? [y/n] ";
        read _INP;
        echo $_INP;
        if [[ ! $_INP == "y" ]] ; then
            echo "Installation cancelled";
            exit;
        fi
    fi
fi

is_empty() {
    CC=$(ls -1 $0 2>/dev/null | wc -l);
    if [[ CC == 0 ]] ; then
        return "empty";
    else
        return ""
    fi
}

symlink() {
    if [[ -f "$2" ]] ; then
        if [[ $(readlink "$2") == "$1" ]] ; then
            return;
        else
            echo "Backing up $2 into $3";
            mv "$2" "$3";
            echo "$1 -> $2";
            ln -s "$1" "$2";
        fi
	else
        echo "$1 -> $2";
        ln -s "$1" "$2";
    fi

    chmod +x "$1";

}

shell_config_dir="shell"
shell_files=".aliases .bashrc .promptrc .shvars .zshrc .bash_profile .functions .shrc .termtitle"
for file in $shell_files ; do
	SOURCE="$PWD/$shell_config_dir/$file";
    TARGET="$installation_dir/$file";
    BACKUP="$installation_dir/.rcbackup";

    symlink $SOURCE $TARGET $BACKUP;

done

other_files=".tmux.conf .conkyrc .Xdefaults yaourtrc"
for file in $other_files ; do
	SOURCE="$PWD/$file";
    TARGET="$installation_dir/$file";
    BACKUP="$installation_dir/.rcbackup";

    symlink $SOURCE $TARGET $BACKUP;

done