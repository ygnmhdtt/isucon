#!/bin/bash
set -e


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
