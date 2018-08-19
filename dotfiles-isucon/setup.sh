#!/bin/bash
set -e

if [ `which go` = ""  ]; then
  echo "Install go"
  exit 1
fi

cd $HOME

sudo apt update -y && sudo apt upgrade -y

# install zsh
sudo apt -y install zsh
# chsh -s `which zsh`

# install (latest) vim
sudo apt remove vim
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

ln -sf $HOME/isucon/dotfiles-isucon/.vimrc $HOME/.vimrc
ln -sf $HOME/isucon/dotfiles-isucon/.zshrc $HOME/.zshrc
ln -sf $HOME/isucon/dotfiles-isucon/.tmux.conf $HOME/.tmux.conf
ln -sf $HOME/isucon/dotfiles-isucon/.gitconfig $HOME/.gitconfig
ln -sf $HOME/isucon/dotfiles-isucon/.tigrc $HOME/.tigrc

. $HOME/.zshrc

# install kataribe
go get github.com/matsuu/kataribe

# install pt-query-digest
sudo apt -y install percona-toolkit

sudo usermod -s `which zsh` isucon

# install minifier
sudo apt install nodejs
sudo apt install npm
sudo npm cache clean
sudo npm install -g n
sudo n stable
sudo npm update -g npm
sudo npm install uglify-js -g
sudo npm install uglifycss -g
sudo npm install html-minifier -g
