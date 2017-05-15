PATH=$PATH:"/D/apache-maven-3.3.9/bin"
mvn clean package
scp -P 10026 -r "target/oto.fsgw-0.0.1-SNAPSHOT.jar" root@123.125.147.106:/home/oto/fsgw/oto.fsgw-0.0.1-SNAPSHOT.jar