#!/bin/sh
DIR="$(pwd)"
	ln -sf "$DIR/vimrc" "$HOME/.vimrc"
	ln -sf "$DIR/tmux.conf" "$HOME/.tmux.conf"
	ln -sf "$DIR/gitconfig" "$HOME/.gitconfig"
    mkdir -p "$HOME/.vim/colors"
    mkdir -p "$HOME/.vim/plugins"
    ln -sf "$DIR/vim-colors/molokaimod.vim" "$HOME/.vim/colors/molokaimod.vim"
    ln -sf "$DIR/vim-plugins/ack.vim" "$HOME/.vim/plugins/ack.vim"
