#!/bin/sh
export HOME=/home/joe/
cd $HOME/org
git add .
git commit -m 'v'
git push origin HEAD
