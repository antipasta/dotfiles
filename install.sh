#!/bin/sh
DIR="$(pwd)"
	ln -sf "$DIR/vimrc" "$HOME/.vimrc"
	ln -sf "$DIR/tmux.conf" "$HOME/.tmux.conf"
    mkdir -p "$HOME/.vim/colors"
    ln -sf "$DIR/vim-colors/molokai_mod.vim" "$HOME/.vim/colors/molokai_mod.vim"
