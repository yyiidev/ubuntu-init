#!/bin/bash

CURRENT_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

source ${CURRENT_DIR}/common.sh

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
echo 'deb https://mirrors.tuna.tsinghua.edu.cn/nodesource/deb_12.x bionic main' > /etc/apt/sources.list.d/nodesource.list
echo 'deb-src https://mirrors.tuna.tsinghua.edu.cn/nodesource/deb_12.x bionic main' >> /etc/apt/sources.list.d/nodesource.list

apt update

apt install -y nodejs yarn
sudo -H -u ${WWW_USER} sh -c 'cd ~ && yarn config set registry https://registry.npm.taobao.org'