[ ${OSTYPE:0:6} == darwin ] && export PS1="\u@\h:\w$ "
[ ${OSTYPE:0:6} == darwin ] && export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
[ -d $HOME/perl5/lib ] && eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)

## global history
export HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s checkwinsize
export HISTFILESIZE=300000
export HISTSIZE=30000
export HISTTIMEFORMAT='%F %T '

PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
#export TERM=xterm-256color
export TERM=screen-256color


## for when ssh agent gets screwy
function refresh_ssha() {
if [[ -n $TMUX ]]; then
    NEW_SSH_AUTH_SOCK=$( tmux showenv|grep ^SSH_AUTH_SOCK|cut -d = -f 2 )
    if [[ -n $NEW_SSH_AUTH_SOCK ]] && [[ -S $NEW_SSH_AUTH_SOCK ]]; then
        SSH_AUTH_SOCK=$NEW_SSH_AUTH_SOCK
    fi
fi
}

function vpndocker() {
    if [[ `stat -c '%a' /dev/net/tun` == '660' ]]; then
        docker "$@"
    else
        echo 'lxc config device add penguin tun unix-char path=/dev/net/tun' | xclip -selection c
        echo 'no access to /dev/net/tun'
    fi
}

ec2-info() {
    IP=169.254.169.254
    ssh $1 "curl -q http://$IP/latest/meta-data/$2" 2>/dev/null
    echo -ne "\n"
}
export EDITOR=vim
export GOPATH=$HOME/code/go
export PATH=$HOME/bin:$HOME/bin/fzf/bin/:$HOME/gobin/go/bin/:/usr/local/go/bin:$HOME/perl5/bin:/usr/sbin/:$GOPATH/bin:$HOME/Library/Python/2.7/bin:$HOME/bin/vim/vim-8.0.1481/bin/bin/:/usr/local/MacGPG2/bin/:/usr/local/bin/:$PATH 
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
        perl -p -i -e "$1" `find .  -name "$2" ! -type d ! -path '*/\.*'`
    else
        perl -p -i -e "$1" `find . ! -type d ! -path '*/\.*'`
    fi
}
export PYTHONPATH=~/python/


alias sfreversion='perl-reversion --bump lib/SocialFlow/Web.pm;git add lib/SocialFlow/Web.pm;git commit -m "Bumping sf-web version"'
alias sfcpanm='cpanm --mirror http://cpan-mirror.dev.saturn.sfsrv.net:25123 --mirror-only' 
alias bump='perl-reversion --bump '
alias vi='vim -p'
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
export PATH=$PATH:$GOPATH/bin:$HOME/.local/bin
export PERLBREW_ROOT=$HOME/perlbrew
function refresh_gpga() {
    if [ -f "${HOME}/.gpg-agent-info" ]; then
        . "${HOME}/.gpg-agent-info"
        export GPG_AGENT_INFO
        export SSH_AUTH_SOCK
    else
        eval $( gpg-agent --daemon --write-env-file "${HOME}/.gpg-agent-info" )
    fi
}

export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_DEFAULT_OPTS='--height 40%  --border'

function filecurl {
    cat $1 | xargs -n 1 curl -LO
}

fd() {
      local dir
        dir=$(find ${1:-.} -path '*/\.*' -prune \
                              -o -type d -print 2> /dev/null | fzf +m) &&
                                cd "$dir"
    }

if [ -x "$(command -v gpg-agent)" ]; then
    if pgrep -x "gpg-agent" > /dev/null
    then
        export SSH_AUTH_SOCK=${HOME}/.gnupg/S.gpg-agent.ssh
    else
        eval $(gpg-agent --daemon --enable-ssh-support --sh)
    fi
fi



function toggle-agent {
    if [[ $SSH_AUTH_SOCK =~ gpg ]]
    then
        export SSH_AUTH_SOCK=$(ls /private/tmp/com.apple.launchd.*/Listeners )
    else
        export SSH_AUTH_SOCK=${HOME}/.gnupg/S.gpg-agent.ssh
    fi
    ssh-add -l

}

qq() {
    clear

    logpath="$TMPDIR/q"
    if [[ -z "$TMPDIR" ]]; then
        logpath="/tmp/q"
    fi

    if [[ ! -f "$logpath" ]]; then
        echo 'Q LOG' > "$logpath"
    fi

    tail -100f -- "$logpath"
}

rmqq() {
    logpath="$TMPDIR/q"
    if [[ -z "$TMPDIR" ]]; then
        logpath="/tmp/q"
    fi
    if [[ -f "$logpath" ]]; then
        rm "$logpath"
    fi
    qq
}
