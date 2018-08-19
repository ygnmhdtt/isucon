#!/bin/bash
set -e

if [ "$(which go)" = "" ]; then
  echo "Please install go"
  echo "example for xbuild : $ xbuild/go-install 1.10 ~/local/go"
  exit 1
fi

cd $HOME

sudo apt update -y && sudo apt upgrade -y

# install zsh
sudo apt -y install zsh
# chsh -s `which zsh`

# install (latest) vim
sudo apt -y remove vim
wget https://github.com/vim/vim/archive/v8.1.0290.tar.gz
tar xzvf v8.1.0290.tar.gz
cd vim-8.1.0290/
make && sudo make install
rm -rf v8.1.0290.tar.gz
rm -rf vim-8.1.0290
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

sudo usermod -s `which zsh` isucon
# . $HOME/.zshrc

# install kataribe
go get github.com/matsuu/kataribe

# install pt-query-digest
sudo apt -y install percona-toolkit

# install minifier
sudo apt install nodejs
sudo apt install npm
npm cache clean
npm install -g n
n stable
npm update -g npm
npm install uglify-js -g
npm install uglifycss -g
npm install html-minifier -g

echo 'setup done. Exit and relogin to change shell'
