#!/bin/bash
shell_config_dir="shell"
shell_files=".aliases .bashrc .promptrc .shvars .zshrc .bash_profile .functions .shrc .termtitle"

if [[ -n $* ]] ; then
	installation_dir=$*
else
	installation_dir="~"
fi

for file in $shell_files ; do
	COMMAND="ln -s $PWD/$shell_config_dir/$file $installation_dir/$file"
	echo "Creating a symlink from $shell_config_dir/$file to $installation_dir/$file"
	eval $COMMAND
done

eval "ln -s $PWD/.conkyrc $installation_dir/.conkyrc"