#!bin/bash
dnf update
dnf install java-17-amazon-corretto -y

tee /home/ec2-user/replaceserver.sh <<EOF 
#!/bin/bash 
lsof -i :8080 | awk '{print $2}' | sed -n '2p' >> /home/ec2-user/pid.txt
export SERVER_PID=$(tail -1 pid.txt) 
kill -9 $SERVER_PID 
nohup java -jar /home/ec2-user/server.jar & 
echo $SERVER_PID
EOF


chmod 777 /home/ec2-user/replaceserver.sh