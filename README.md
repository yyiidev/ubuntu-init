# Ubuntu 初始化脚本

## 安装

```
wget -qO- https://raw.githubusercontent.com/yyiidev/ubuntu-init/master/download.sh - | bash
```

## 注意事项

* 适用于 ubuntu 18
* 请在 root 下执行脚本

## 软件列表

* Git
* PHP 7.4
* Nginx
* Sqlite3
* Composer
* Redis

## 新增 Nginx 站点

```
./nginx_add_site.sh
```

根据提示输入站点信息，确认之后将创建对应的 Nginx 配置并重启 Nginx

## 其他

* 脚本参考自：https://github.com/summerblue/laravel-ubuntu-init