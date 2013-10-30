#!/bin/sh
DIR="$(pwd)"
BINDLE="$HOME/.bindle"

mkdir -p "$BINDLE/vim/colors"
ln -sf "$DIR/bashrc" "$BINDLE/bashrc.pup"
ln -sf "$DIR/vimrc" "$BINDLE/vimrc.pup"
ln -sf "$DIR/tmux.conf" "$BINDLE/tmux.pup"
ln -sf "$DIR/gitconfig" "$BINDLE/.gitconfig"
ln -sf "$DIR/vim-colors/molokaimod.vim" "$BINDLE/vim/colors/molokaimod.vim"

cat > "$BINDLE/bootstrap_bashrc.pup" <<DELIM
[ -f $HOME/.bashrc ] && . $HOME/.bashrc
alias git='HOME=__BINDLE__ git'
alias tmux='tmux -f __BINDLE__/bootstrap_tmux.pup'
alias testbindle='ls -lah'
export VIMINIT='source __BINDLE__/bootstrap_vimrc.pup'
source __BINDLE__/bashrc.pup
DELIM

cat > "$BINDLE/bootstrap_tmux.pup" <<DELIM
set-option -g default-command "/bin/bash --rcfile __BINDLE__/bootstrap_bashrc.pup -i"
source __BINDLE__/tmux.pup
DELIM

cat > "$BINDLE/bootstrap_vimrc.pup" <<DELIM
set rtp +=__BINDLE__/vim
source __BINDLE__/vimrc.pup
DELIM
