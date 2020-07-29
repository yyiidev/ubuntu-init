#!/bin/bash

set -e

CURRENT_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
LOG_PATH="${CURRENT_DIR}/ubuntu-init.log"

source ${CURRENT_DIR}/common.sh

check_root

function init_system {
    apt update
    apt install -y software-properties-common
}

function init_repositories {
    add-apt-repository -y ppa:ondrej/php
    add-apt-repository -y ppa:nginx/stable

    grep -rl ppa.launchpad.net /etc/apt/sources.list.d/ | xargs sed -i 's/http:\/\/ppa.launchpad.net/https:\/\/launchpad.proxy.ustclug.org/g'

    apt update
}

function init_deployer_user {
    useradd -d /home/${DEPLOYER_USER} -m ${DEPLOYER_USER}
    usermod -aG ${WWW_USER_GROUP} ${DEPLOYER_USER}

    sudo -H -u ${DEPLOYER_USER} sh -c 'echo "umask 022" >> ~/.bashrc'

    echo "${DEPLOYER_USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

    chown ${DEPLOYER_USER}:${WWW_USER_GROUP} /var/www/html
    chmod g+s /var/www/html

    sudo -H -u ${DEPLOYER_USER} sh -c 'ssh-keygen -t rsa -b 4096 -N '' -f ~/.ssh/id_rsa'
}

function install_basic_softwares {
    apt install -y curl git build-essential unzip supervisor
}

function install_php {
    apt install -y php7.4-{bcmath,cli,curl,fpm,gd,mbstring,mysql,opcache,readline,xml,zip,redis,sqlite3,exif}
}

function install_composer {
    curl https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer
    chmod +x /usr/local/bin/composer
    sudo -H -u ${WWW_USER} sh -c  'cd ~ && composer config -g repo.packagist composer https://mirrors.cloud.tencent.com/composer/'
}

function install_others {
    apt install -y nginx redis-server sqlite3
    chown -R ${WWW_USER}.${WWW_USER_GROUP} /var/www/
    systemctl enable nginx.service
}

call_function init_system "正在初始化系统" ${LOG_PATH}
call_function init_repositories "正在初始化系统软件库" ${LOG_PATH}
call_function install_basic_softwares "正在安装基本的软件" ${LOG_PATH}
call_function install_php "正在安装 PHP" ${LOG_PATH}
call_function install_others "正在安装 Nginx Redis Sqlite3" ${LOG_PATH}
call_function install_composer "正在安装 Composer" ${LOG_PATH}
call_function init_deployer_user "正在初始化 deployer 用户" ${LOG_PATH}

echo "安装完毕!"