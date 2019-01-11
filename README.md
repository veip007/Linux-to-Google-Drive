# Linux-to-Google-Drive
Linux下谷歌网盘同步工具、自动备份VPS文件到Google Drive

## 简介
Gdrive，Linux下上传、下载Google Drive文件的一款CLI工具，安装简单、使用方便。

## 安装
### 1、安装
```bash
wget -O /usr/bin/gdrive "https://raw.githubusercontent.com/veip007/Linux-to-Google-Drive/master/gdrive-linux-x64" && chmod +x /usr/bin/gdrive
```

### 2、授权
```bash
gdrive about
```

然后会出现一串网址并询问验证码。
![GitHub](https://raw.githubusercontent.com/veip007/Linux-to-Google-Drive/master/Gdrive.jpg)

将地址粘贴到浏览器并登陆账号，会返回一串代码。

![GitHub](https://raw.githubusercontent.com/veip007/Linux-to-Google-Drive/master/Gdrive(2).jpg)

将代码粘贴到SSH下，然后会返回你的账户信息。

![GitHub](https://raw.githubusercontent.com/veip007/Linux-to-Google-Drive/master/Gdrive(3).jpg)

gdrive程序会自动将你的token保存在用户目录下的.gdrive目录中，所以如果不需要了记得把这个文件删掉。

### 使用
常用命令如下，更多查看gdrive官网：https://github.com/prasmussen/gdrive。

1、列出Google Drive根目录下文件、文件夹

```bash
gdrive list
```

2、下载Google Drive根目录下文件到本地（xxxx为文件名）

```bash
gdrive download xxxx
```

3、下载Google Drive根目录下文件夹到本地（xxx为文件夹名）

```bash
gdrive download xxx
```

4、把本地文件上传到Google Drive根目录下（xxxx为文件名）

```bash
gdrive upload xxxx
```

5、在Google Drive根目录下创建文件夹（xxx为文件夹名）

```bash
gdrive mkdir xxx
```

## 自动备份
### 1、网站自动备份脚本（基于Mysql数据库）
脚本下载：

```bash
wget https://raw.githubusercontent.com/veip007/Linux-to-Google-Drive/master/googledrive.sh && chmod +x googledrive.sh
```

修改以下部分：
```
第3行：my-database-name改为自己的数据库名
第4行：my-database-user改为自己的数据库用户名
第5行：my-database-password改为自己的数据库用户名对应的密码
第7行：yourdomain.com改为自己的网站目录
第8行：/home/wwwroot改为自己的网站所在目录（即需备份目录为/home/wwwroot/yourdomain.com）
第9行：/backups改为备份文件存放目录
第35行：youremail@yourdomain.com修改为自己的邮箱
```

2、创建定时任务

```bash
vi  /etc/crontab
```

添加

```bash
0 2 * * * /backups/googledrive.sh
```

以上备份脚本存放在/backups/下，每日2点备份。

3、重启crontab

```bash
/etc/init.d/crond restart
```
