#!/bin/bash
#Won't work executed by zsh or by sh

#Get directory in which the script is located
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#If an argument is provided, install there, otherwise in $HOME (won't work outside of $HOME anyway as of now :p)
if [[ -n $* ]] ; then
	installation_dir=$*
else
	installation_dir="$HOME"
fi

#Function to check if directory is empty
is_empty() {
    CC=$(ls -1 $0 2>/dev/null | wc -l);
    if [[ CC == 0 ]] ; then
        return "empty";
    else
        return 0
    fi
}

#Create backup directory, prompt for confirmation if it already exists
if [[ ! -d "$installation_dir/.rcbackup/" ]] ; then
    mkdir "$installation_dir/.rcbackup/"
else
    if [ ! $(is_empty "$installation_dir/.rcbackup/") ] ; then
        printf ".rcbackup directory already exists. Continue? [y/n] ";
        read _INP;
        if [[ ! $_INP == "y" ]] ; then
            echo "Installation cancelled";
            exit;
        fi
    fi
fi

#Work the magic
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
	SOURCE="$DIR/$shell_config_dir/$file";
    TARGET="$installation_dir/$file";
    BACKUP="$installation_dir/.rcbackup";

    symlink "$SOURCE" "$TARGET" "$BACKUP";

done

other_files=".tmux.conf .conkyrc .Xdefaults yaourtrc"
for file in $other_files ; do
	SOURCE="$DIR/$file";
    TARGET="$installation_dir/$file";
    BACKUP="$installation_dir/.rcbackup";

    symlink "$SOURCE" "$TARGET" "$BACKUP";

done

scripts_subdir=".scripts"
if [[ ! -d "$installation_dir/$scripts_subdir/" ]] ; then
    mkdir "$installation_dir/$scripts_subdir/"
fi
script_files=$(ls $scripts_subdir)
for file in $script_files ; do
	SOURCE="$PWD/.scripts/$file";
    TARGET="$installation_dir/$scripts_subdir/$file";
    BACKUP="$installation_dir/.rcbackup/$scripts_subdir";

    chmod +x "$TARGET"
    symlink "$SOURCE" "$TARGET" "$BACKUP";

done