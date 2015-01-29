[ ${OSTYPE:0:6} == darwin ] && export PS1="\u@\h:\w$ "
[ ${OSTYPE:0:6} == darwin ] && export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
[ -d $HOME/perl5 ] && eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)

## global history
export HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s checkwinsize
export HISTFILESIZE=300000
export HISTSIZE=30000
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
export TERM=xterm-256color


## for when ssh agent gets screwy
function refresh_ssha() {
if [[ -n $TMUX ]]; then
    NEW_SSH_AUTH_SOCK=$( tmux showenv|grep ^SSH_AUTH_SOCK|cut -d = -f 2 )
    if [[ -n $NEW_SSH_AUTH_SOCK ]] && [[ -S $NEW_SSH_AUTH_SOCK ]]; then
        SSH_AUTH_SOCK=$NEW_SSH_AUTH_SOCK
    fi
fi
}

ec2-info() {
    IP=169.254.169.254
    ssh $1 "curl -q http://$IP/latest/meta-data/$2" 2>/dev/null
    echo -ne "\n"
}
export EDITOR=vim
export PATH=$HOME/bin:$HOME/perl5/bin:/usr/sbin/:$PATH 
[ -f $HOME/perl5/lib/perl5/Devel/Local.pm ] && source `which devel-local.sh`
function github() {
    git clone git@github.com:SocialFlowDev/$1.git
}

git-extract-dir() {
    DIR=$1
    git filter-branch --subdirectory-filter ${DIR} HEAD -- --all --prune-empty 
    git reset --hard
    rm -rf .git/refs/original/
    git reflog expire --expire=now --all
    git gc --aggressive --prune=now
}
agc () {  ag --color "$@" | less -R ; }

pie () { 
    if [[ -n $2 ]]; then
        perl -p -i -e "$1" `find .  -name "$2" ! -type d`
    else
        echo hi
        perl -p -i -e "$1" `find . ! -type d`
    fi
}
export PYTHONPATH=~/python/


alias sfreversion='perl-reversion --bump lib/SocialFlow/Web.pm;git add lib/SocialFlow/Web.pm;git commit -m "Bumping sf-web version"'
alias sfcpanm='cpanm --mirror file:///srv/socialflow/mcpan/ --mirror-only'
alias bump='perl-reversion --bump '
alias vi='vi -p'
alias lessr='less -R'
alias shadowpaste='nopaste -s Shadowcat '
alias netstat='netstat --wide'

if command -v ag >/dev/null 2>&1; then
    alias ack=ag
elif command -v ack-grep >/dev/null 2>&1; then
    alias ack='ack-grep'
fi
[ -f /home/joe/dotfiles/additional_options ] && . /home/joe/dotfiles/additional_options
export GOPATH=$HOME/code/go
export PATH=$PATH:$GOPATH/bin
