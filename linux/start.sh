#! /bin/bash

# 加载/etc/profile文件，不加载容易出现commond not found 错误，原因见
# http://feihu.me/blog/2014/env-problem-when-ssh-executing-command-on-remote/
source /etc/profile

# 判断run.pid文件是否存在
if [ ! -f "run.pid" ]
then # 不存在
	echo "server is not running, begin start"
else # 存在
	# cat run.pid | if read PID # 读取第一行，第一行存在
	# then
	# 	kill $PID & echo "stop $PID" # 杀掉进程并显示stop 进程号(pid)
	# fi
	PID=$(cat run.pid) # 读取pid
	kill $PID & echo "stop $PID" # 杀掉进程并显示stop 进程号(pid)

	rm -f run.pid # 删除run.pid文件
fi
# 运行程序并记录进程号(pid)
# 若您不是Java项目，只需要编辑为您的运行命令并在之后添加  2>&1 & echo $! > run.pid
java -Xmx1024M -Xms512M -XX:MaxPermSize=256m -jar ghss-1.1.1.20170228_alpha.jar --spring.profiles.active=prod 2>&1 & echo $! > run.pid
