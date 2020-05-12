#!/bin/sh
DIR="$(pwd)"
echo "[ -f $DIR/bashrc ] && . $DIR/bashrc" >> ~/.bashrc
echo "[ -f $DIR/bashrc ] && . $DIR/bashrc" >> ~/.bash_profile
