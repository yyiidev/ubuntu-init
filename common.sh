#!/bin/bash

# 执行方法
function call_function {
    func=$1
    desc=$2
    log_file=$3
    echo -n "===> ${desc}..."
    $func >> ${log_file} 2>&1
    ret=$?
    echo -n '    ['
    if [[ $ret -eq 0 ]]; then
        echo -n "DONE"
    else
        echo -n "ERROR"
    fi
    echo ']'
}

# 检查是否为 root，如果不是提示使用 root 执行
function check_root {
    [ $(id -u) != "0" ] && { echo "当前账户并非 root，请用 root 账户执行安装脚本（使用命令：sudo -H -s 切换为 root）"; exit 1; }
}