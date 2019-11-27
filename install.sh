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

if [[ ! -d "$HOME/.local/bin" ]] ; then
    echo "Creating $HOME/.local/bin"
    mkdir -p "$HOME/.local/bin"
fi

#Work the magic
symlink() {
    # $1 - source file
    # $2 - target file
    # $3 - backup directory
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

    chmod +x "$2";

}

install_files() {
    local SOURCE_DIR=$1
    local FILES=$2
    local TARGET_DIR=$3 # .config/geany/colorschemes
    local BACKUP_DIR=$4

    echo "Installing files from $DIR/$SOURCE_DIR to $installation_dir/$TARGET_DIR"

    if [[ $FILES == "" ]] ; then
        FILES=$(ls -A "$DIR/$SOURCE_DIR")
    fi

    if [[ ! -d "$installation_dir/$TARGET_DIR/" ]] ; then
        mkdir -p "$installation_dir/$TARGET_DIR/"
    fi
    if [[ ! -d "$installation_dir/$BACKUP_DIR/" ]] ; then
        mkdir -p "$installation_dir/$BACKUP_DIR/"
    fi

    for file in $FILES ; do
        SOURCE="$DIR/$SOURCE_DIR/$file";
        TARGET="$installation_dir/$TARGET_DIR/$file";
        BACKUP="$installation_dir/.rcbackup/$BACKUP_DIR";

        symlink "$SOURCE" "$TARGET" "$BACKUP";
    done
}

echo "$DIR" > "$installation_dir/.dotfilesrc"

# Shell config files
#install_files "shell" ".aliases .bashrc .promptrc .shvars .zshrc .bash_profile .functions .shrc .termtitle" "" ""
install_files "shell" ".bashrc .zshrc .bash_profile" "" "" # TODO: Store .dotfilesrc containing path to dotfiles folder

# Miscellanous files
install_files "" ".tmux.conf .conkyrc .gitconfig" "" "" # No yaourtrc as I'm not using Arch


# Scripts
#install_files ".scripts" "" ".scripts" ".scripts" - made obsolete

install_files "bin" "" ".local/bin" "bin"

### Program configs
# Geany themes
install_files "other/geany-themes" "" ".config/geany/colorschemes" "geany-themes"
# Redshift
install_files "other" "redshift.conf" ".config"

# Python stuff
install_files "other/python" ".pythonrc" "" ""


# X.Org files - locale, themes, fonts
install_files "xorg" "" "" ""