#!/bin/sh
DIR="$(pwd)"
BINDLE="$HOME/.bindle"

mkdir -p "$BINDLE/vim/colors"
ln -sf "$DIR/bashrc" "$BINDLE/bashrc"
ln -sf "$DIR/vimrc" "$BINDLE/vimrc"
ln -sf "$DIR/tmux.conf" "$BINDLE/tmux.conf"
ln -sf "$DIR/gitconfig" "$BINDLE/.gitconfig"
ln -sf "$DIR/vim-colors/molokaimod.vim" "$BINDLE/vim/colors/molokaimod.vim"

cat > "$BINDLE/bashrc.bootstrap" <<DELIM
[ -f $HOME/.bashrc ] && . $HOME/.bashrc
alias git='HOME=__BINDLE__ git'
alias tmux='tmux -f __BINDLE__/tmux.bootstrap'
alias testbindle='ls -lah'
export VIMINIT='source __BINDLE__/vimrc.bootstrap'
source __BINDLE__/bashrc
DELIM

cat > "$BINDLE/tmux.bootstrap" <<DELIM
set-option -g default-command "/bin/bash --rcfile __BINDLE__/bashrc.bootstrap -i"
source __BINDLE__/tmux.conf
DELIM

cat > "$BINDLE/vimrc.bootstrap" <<DELIM
set rtp +=__BINDLE__/vim
source __BINDLE__/vimrc
DELIM
