#!/bin/bash
set -e

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
