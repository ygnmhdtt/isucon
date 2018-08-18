#!/bin/bash
set -e

# goをインストールした後に実行する

# ssh key for github
if [ ! -e $HOME/.ssh/github_rsa_isucon ]; then
  mkdir $HOME/.ssh
  cd $HOME/.ssh
  ssh-keygen -t rsa -f github_rsa_isucon -P ""
  cat << EOT > $HOME/.ssh/config
Host github github.com
  HostName github.com
  IdentityFile ~/.ssh/github_rsa_isucon
  User git
EOT
fi


cd $HOME

sudo apt update -y && sudo apt upgrade -y

# install zsh
sudo apt install zsh
sudo apt install zsh-completion
chsh -s `which zsh`

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
sudo apt install tig

# install tmux
sudo apt install tmux

# install jq
sudo apt install jq

DOTFILES=$PWD

ln -sf $DOTFILES/.vimrc $HOME/.vimrc
ln -sf $DOTFILES/.zshrc $HOME/.zshrc
ln -sf $DOTFILES/.tmux.conf $HOME/.tmux.conf
ln -sf $DOTFILES/.gitconfig $HOME/.gitconfig
ln -sf $DOTFILES/.tigrc $HOME/.tigrc

. $HOME/.zshrc

# install kataribe
go get github.com/matsuu/kataribe

# install pt-query-digest
wget https://www.percona.com/downloads/percona-toolkit/3.0.11/binary/debian/bionic/amd64/percona-toolkit_3.0.11-1.bionic_amd64.deb
sudo dpkg -i percona-toolkit_3.0.11-1.bionic_amd64.deb

