
#alias sfcpanm='cpanm --mirror http://devdb:25123 --mirror-only'
alias sfcpanm='cpanm --mirror http://dev.socialflow.com:25123 --mirror-only'
alias ack='ack-grep'
eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)

## global history
export HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s checkwinsize
export HISTFILESIZE=300000
export HISTSIZE=30000
PROMPT_COMMAND='history -a'


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
export PATH=$HOME/perl5/bin:$PATH
source `which devel-local.sh`
function github() {
    git clone git@github.com:SocialFlowDev/$1.git
}
