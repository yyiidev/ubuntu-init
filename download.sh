#!/bin/bash

green="\e[1;32m"
nc="\e[0m"

echo -e "${green}===> 开始下载...${nc}"

wget -q https://github.com/yyiidev/ubuntu-init/archive/master.tar.gz -O ubuntu-init.tar.gz
rm -rf ubuntu-init
tar zxf ubuntu-init.tar.gz
mv ubuntu-init-master ubuntu-init
rm -f ubuntu-init.tar.gz

echo -e "${green}===> 下载完毕${nc}"
echo ""
echo -e "${green}安装脚本位于： ${HOME}/ubuntu-init${nc}"

bash ./ubuntu-init/install.sh