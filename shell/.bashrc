export DOTFILES_DIR=$(cat "$HOME/.dotfilesrc")

source $DOTFILES_DIR/shell/.shrc
source $DOTFILES_DIR/shell/.promptrc
source $DOTFILES_DIR/shell/.termtitle

#Ignore minor spelling errors
shopt -s cdspell

shopt -s checkhash

#Do not exit with jobs running
shopt -s checkjobs

#Save multiline commands as single entry and don't transform newlines
# into semicolons
shopt -s cmdhist
shopt -s lithist

#Don't ignore .files
shopt -s dotglob

#Ignore lines prefied with '#' in interactive shell
shopt -s interactive_comments