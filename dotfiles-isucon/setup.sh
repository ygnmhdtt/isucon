#!/bin/bash
set -e

# check go
if [ "$(which go)" = "" ]; then
  echo "Please install go"
  echo "example for xbuild : $ xbuild/go-install 1.10 ~/local/go"
  exit 1
fi

# create .ssh dir
if [ -e $HOME/.ssh ]; then
  :
else
  mkdir $HOME/.ssh
fi

# ssh key for github
if [ ! -e $HOME/.ssh/github_rsa_isucon ]; then
  cd $HOME/.ssh
  ssh-keygen -t rsa -f github_rsa_isucon -P ""
  cat << EOT > $HOME/.ssh/config
Host github github.com
  HostName github.com
  IdentityFile ~/.ssh/github_rsa_isucon
  User git
EOT
fi

# register public key to github by basic authentication
echo "Input GitHub username(to register public key to GitHub)"
read user

echo "Input GitHub password(to register public key to GitHub)"
read -sp "Password: " password

publickey=`cat $HOME/.ssh/github_rsa_isucon.pub`

curl -XPOST \
  -H "Content-Type: application/json" \
  --basic -u "${user}:${password}" \
  -d "{\"title\": \"${user}@isucon\", \"key\": \"${publickey}\"}" \
  'https://api.github.com/user/keys'

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
# sudo apt -y install tig

# install tmux
sudo apt -y install tmux

# install jq
sudo apt -y install jq

ln -sf $HOME/isucon/dotfiles-isucon/.vimrc $HOME/.vimrc
ln -sf $HOME/isucon/dotfiles-isucon/.zshrc $HOME/.zshrc
ln -sf $HOME/isucon/dotfiles-isucon/.tmux.conf $HOME/.tmux.conf
ln -sf $HOME/isucon/dotfiles-isucon/.gitconfig $HOME/.gitconfig
# ln -sf $HOME/isucon/dotfiles-isucon/.tigrc $HOME/.tigrc

sudo usermod -s `which zsh` isucon
# . $HOME/.zshrc

# install kataribe
go get github.com/matsuu/kataribe

# install pt-query-digest
sudo apt -y install percona-toolkit

# install minifier
# sudo apt install nodejs
# sudo apt install npm
# npm cache clean
# npm install -g n
# n stable
# npm update -g npm
# npm install uglify-js -g
# npm install uglifycss -g
# npm install html-minifier -g

echo 'setup done. Exit and relogin to change shell'
