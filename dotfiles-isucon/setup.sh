#!/bin/bash
set -e

# goをインストールした後に実行する

cd $HOME

sudo apt update -y && sudo apt upgrade -y

# install zsh
sudo apt -y install zsh
# chsh -s `which zsh`

# install (latest) vim
wget https://github.com/vim/vim/archive/v8.1.0290.tar.gz
tar xzvf v8.1.0290.tar.gz
cd vim-8.1.0290/
make && sudo make install
cd $HOME

# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install tig
sudo apt -y install tig

# install tmux
sudo apt -y install tmux

# install jq
sudo apt -y install jq

ln -sf $HOME/ygnmhdtt-isucon/dotfiles-isucon/.vimrc $HOME/.vimrc
ln -sf $HOME/ygnmhdtt-isucon/dotfiles-isucon/.zshrc $HOME/.zshrc
ln -sf $HOME/ygnmhdtt-isucon/dotfiles-isucon/.tmux.conf $HOME/.tmux.conf
ln -sf $HOME/ygnmhdtt-isucon/dotfiles-isucon/.gitconfig $HOME/.gitconfig
ln -sf $HOME/ygnmhdtt-isucon/dotfiles-isucon/.tigrc $HOME/.tigrc

. $HOME/.zshrc

# install kataribe
go get github.com/matsuu/kataribe

# install pt-query-digest
sudo apt -y install percona-toolkit

sudo usermod -s `which zsh` isucon
