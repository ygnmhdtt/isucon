#!/bin/sh

if [ $# -ne 3 ]; then
  echo "Usage: ./init ssh_ipaddr ssh_user pem_file_path"
  exit 1
fi

IP_ADDR=$1
USER=$2
PEM_FILE=$3

# create ssh config
cat <<EOF >> ~/.ssh/config
Host isucon
  User $USER
  HostName $IP_ADDR
  IdentityFile $PEM_FILE
EOF

# prepare my dotfiles
scp vimrc isucon:/tmp
scp bashrc isucon:/tmp
scp git_push.sh isucon:/tmp
scp return_config.sh isucon:/tmp
scp redis.conf isucon:/tmp
