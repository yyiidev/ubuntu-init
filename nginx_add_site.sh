#!/bin/bash

CURRENT_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
source ${CURRENT_DIR}/common.sh

check_root

read -r -p "请输入项目名：" project

[[ $project =~ ^[\.0-9a-zA-Z_\-]+$ ]] || {
    echo "项目名包含非法字符"
    exit 1
}

read -r -p "请输入站点域名（多个域名用空格隔开）：" domains

project_dir="/var/www/${project}"

echo "域名列表：${domains}"
echo "项目名：${project}"
echo "项目目录：${project_dir}"

read -r -p "是否确认？ [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
        ;;
    *)
        echo "用户取消"
        exit 1
        ;;
esac

read -r -p "请输入项目类型【dzq/laravel】：" project_type

cat ${CURRENT_DIR}/templates/${project_type}-nginx_site_conf.tpl |
    sed "s|{{domains}}|${domains}|g" |
    sed "s|{{project}}|${project}|g" |
    sed "s|{{project_dir}}|${project_dir}|g" > /etc/nginx/sites-available/${project}.conf

ln -sf /etc/nginx/sites-available/${project}.conf /etc/nginx/sites-enabled/${project}.conf

echo "配置文件创建成功"

mkdir -p ${project_dir} && chown -R ${DEPLOYER_USER}.${WWW_USER_GROUP} ${project_dir}

systemctl restart nginx.service

echo "Nginx 重启成功"
