#!/bin/bash

if [[ -n $* ]] ; then
	installation_dir=$*
else
	installation_dir="~"
fi

shell_config_dir="shell"
shell_files=".aliases .bashrc .promptrc .shvars .zshrc .bash_profile .functions .shrc .termtitle"
for file in $shell_files ; do
	chmod +x "$shell_config_dir/$file"
	COMMAND="ln -s $PWD/$shell_config_dir/$file $installation_dir/$file"
	eval $COMMAND
done

other_files=".tmux.conf .conkyrc"
for file in $other_files ; do
	chmod +x $file
	COMMAND="ln -s $PWD/$file $installation_dir/$file"
	eval $COMMAND
done