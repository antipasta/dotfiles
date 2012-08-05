#!/bin/sh
DIR="$(pwd)"
	ln -sf "$DIR/vimrc" "$HOME/.vimrc"
	ln -sf "$DIR/tmux.conf" "$HOME/.tmux.conf"
    mkdir -p "$HOME/.vim/colors"
    cp -f "$DIR/vim-colors/molokai_mod.vim" "$HOME/.vim/colors"
