#!/bin/sh
DIR="$(pwd)"
echo "[ -f $DIR/bashrc ] && . $DIR/bashrc" >> ~/.bashrc
