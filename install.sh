#!/bin/bash
#Won't work executed by zsh or by sh

#Get directory in which the script is located
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#If an argument is provided, install there, otherwise in $HOME (won't work outside of $HOME anyway as of now :p)
if [[ -n $* ]] ; then
    INSTALL_DIR=$*
else
    INSTALL_DIR="$HOME"
fi

# If empty, no backups will be performed
BACKUP_DIR=".rcbackup"

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

if [[ "$BACKUP_DIR" == "" ]] ; then
    echo "Backup directory set to none, no backup will be performed or checked for"
else
    FULL_BACKUP_DIR="$INSTALL_DIR/$BACKUP_DIR"

    if [[ ! -d "$FULL_BACKUP_DIR" ]] ; then
        mkdir "$FULL_BACKUP_DIR"
    else
        if [ ! $(is_empty "$FULL_BACKUP_DIR") ] ; then
            printf ".rcbackup directory already exists. Continue? [y/n] ";
            read _INP;
            if [[ ! $_INP == "y" ]] ; then
                echo "Installation cancelled";
                exit;
            fi
        fi
    fi
fi

if [[ ! -d "$HOME/.local/bin" ]] ; then
    echo "Creating $HOME/.local/bin"
    mkdir -p "$HOME/.local/bin"
fi

# prompt_yn "Prompt text?" return_variable
prompt_yn() {
    while true; do
        read -r -n1 -p "$1 [y/n] " yn
        case $yn in
            [Yy]* ) echo; eval "$2=1";  break;;
            [Nn]* ) echo; eval "$2=\"\""; break;;
            * ) echo "Please input Y or N";;
        esac
    done
}

#Work the magic
symlink() {
    # $1 - source file
    # $2 - target file
    # $3 - backup directory
    if [[ -f "$2" ]] ; then
        if [[ $(readlink "$2") == "$1" ]] ; then
            return;
        elif [[ "$3" != "" ]] ; then
            prompt_yn "    Back up and replace '$2'?" yn

            if [[ $yn == "" ]] ; then
                echo "    SKIP: $2";
            else
                echo "  BACKUP: $2 into $3";
                mv "$2" "$3";
                echo "    LINK: $1 -> $2";
                ln -s "$1" "$2";
            fi
        fi
    else
        echo "    LINK: $1 -> $2 $BAK";
        ln -s "$1" "$2";
    fi

    chmod +x "$2";
}

# install_files SOURCE_DIR FILELIST TARGET_DIR BACKUP_DIR
install_files() {
    local SOURCE_DIR=$1
    local FILES=$2
    local TARGET_DIR=$3

    echo "Installing files from $DIR/$SOURCE_DIR to $INSTALL_DIR/$TARGET_DIR"

    if [[ $FILES == "" ]] ; then
        FILES=$(ls -A "$DIR/$SOURCE_DIR")
    fi

    if [[ ! -d "$INSTALL_DIR/$TARGET_DIR/" ]] ; then
        mkdir -p "$INSTALL_DIR/$TARGET_DIR/"
    fi

    for file in $FILES ; do
        SOURCE="$DIR/$SOURCE_DIR/$file";
        TARGET="$INSTALL_DIR/$TARGET_DIR/$file";
        if [[ "$BACKUP_DIR" != "" ]] ; then
            if [[ ! -d "$FULL_BACKUP_DIR/$TARGET_DIR" ]] ; then
                mkdir -p "$FULL_BACKUP_DIR/$TARGET_DIR"
            fi
            symlink "$SOURCE" "$TARGET" "$FULL_BACKUP_DIR/$TARGET_DIR";
        else
            symlink "$SOURCE" "$TARGET" "";
        fi
    done
}

echo "$DIR" > "$INSTALL_DIR/.dotfilesrc"

# install_files SOURCE_DIR FILELIST TARGET_DIR BACKUP_DIR

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
# Other config files
install_files "other" "redshift.conf" ".config" ""
install_files "other" "sxhkdrc" ".config/sxhkd" ""
install_files "other/rofi" "config" ".config/rofi"

# Python stuff
install_files "other/python" ".pythonrc" "" ""


# X.Org files - locale, themes, fonts
install_files "xorg" "" "" ""

AUTOSTART_DIR=".config/autostart"
# This would require expanding the install_files fn to handle absolute paths too
#if [[ "$XDG_CONFIG_HOME" != "" ]] ; then
#    AUTOSTART_DIR="$XDG_CONFIG_HOME/autostart"
#fi

# The desktop autorun
install_files "other" "autorun.llama.desktop" "$AUTOSTART_DIR" ""
