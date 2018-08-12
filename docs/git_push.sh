#!/bin/sh

if [ $# -eq 1 ]; then
  commit_message="${1}"
else
  echo 'no commit message'
  exit 1
fi

if [ -e ./etc ]; then
  echo 'exists etc'
else
  mkdir etc
fi

if [ -e ./etc/nginx ]; then
  echo 'exists etc/nginx'
else
  mkdir etc/nginx
fi

if [ -e ./etc/httpd ]; then
  echo 'exists etc/httpd'
else
  mkdir etc/httpd
fi

sudo cp /etc/my.cnf ./etc
sudo cp /etc/redis.conf ./etc
sudo cp /etc/nginx/* ./etc/nginx
sudo cp /etc/httpd/* ./etc/httpd

branch_name=`git rev-parse --abbrev-ref HEAD`

sudo git add .

sudo git commit -m "${commit_message}"

sudo git push origin ${branch_name}
