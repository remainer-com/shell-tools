#! /bin/bash

# 设置变量
destination=/home/oto/ghss/
filename=ghss-1.1.1.20170228_alpha.jar

# 从svn上更新代码
svn update
# PATH环境变量中添加maven
PATH=$PATH:"/D/apache-maven-3.3.9/bin"
# 使用maven打包代码
mvn clean package
# 删除打包后的代码中和配置无关的，依自身情况自行添加或删除
rm -rf target/classes/cn/ target/classes/static/ target/classes/META-INF/
# 上传打包的jar文件
scp -P 10026 -r "target/$filename" root@127.0.0.1:$destination$filename
# 重命名classes文件夹为config(因没找见scp上传同时修改文件夹名称的方法，望有知道的麻烦告知一下)
mv -f target/classes/ target/config/
# 上传配置文件
# 我的项目是spring boot的项目，需要添加配置文件到服务器上jar包同级config/下
scp -P 10026 -r "target/config/" root@127.0.0.1:$destination
# 删除config文件夹
rm -rf target/config/
# 运行start.sh文件
# start.sh文件内容参照本项目linux/start.sh
ssh -p 10026 root@127.0.0.1 "cd $destination &&./start.sh"