# Ubuntu 初始化脚本

## 安装

```
curl https://raw.githubusercontent.com/yyiidev/ubuntu-init/master/download.sh | bash
```

### 添加本地的公钥至 deployer 用户中

```
su - deployer
vim ~/.ssh/authorized_keys # 复制本地公钥至 deployer 用户，用于使用 deployer 的代码部署
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

## 显示 deplpyer 用户的 SSH 公钥

```
./show_deployer_key.sh
```

复制 SSH 公钥至你的代码库用于代码部署

## 其他

* 脚本参考：[laravel-ubuntu-init](https://github.com/summerblue/laravel-ubuntu-init)
* 推荐阅读：[又一篇 Deployer 的使用攻略](https://overtrue.me/articles/2018/06/deployer-guide.html)