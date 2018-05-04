#!/bin/sh

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# prepare git
ssh-keygen -t rsa -b 4096 -C "ygnmhdtt@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub
## and add ssh key to GitHub!
## test: $ ssh -T git@github.com

## initialize repository:
## $ git init
## $ git remote add origin git@github.com:ygnmhdtt/isucon.git
## $ git add .
## $ git commit -m 'initialize'
## $ git push -f origin master

## prepare git for root

## $ cat ~/.ssh/id_rsa
## $ sudo su -
## $ vi ~/.ssh/id_rsa
## $ chmod 400 ~/.ssh/id_rsa
## $ ssh -T git@github.com
