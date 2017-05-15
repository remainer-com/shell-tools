#! /bin/bash

source /etc/profile

if [ ! -f "run.pid" ]
then
	echo "server is not running, begin start"
else
	cat run.pid | if read PID
	then
		kill $PID & echo "stop $PID"
	fi
	rm -f run.pid
fi
java -Xmx1024M -Xms512M -XX:MaxPermSize=256m -jar ghss-1.1.1.20170228_alpha.jar --spring.profiles.active=prod 2>&1 & echo $! > run.pid
