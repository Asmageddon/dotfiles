source ~/.shrc
source ~/.promptrc
source ~/.termtitle

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
shopt -s