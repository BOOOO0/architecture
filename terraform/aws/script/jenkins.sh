#!bin/bash
yum update
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

dnf update
dnf install java-11-amazon-corretto -y

yum install jenkins -y
systemctl enable --now jenkins

wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm
yum install ./jdk-17_linux-x64_bin.rpm -y

gradle_version=8.5
wget -c http://services.gradle.org/distributions/gradle-${gradle_version}-all.zip
unzip  gradle-${gradle_version}-all.zip -d /opt
ln -s /opt/gradle-${gradle_version} /opt/gradle
printf "export GRADLE_HOME=/opt/gradle\nexport PATH=\$PATH:\$GRADLE_HOME/bin\n" > /etc/profile.d/gradle.sh
source /etc/profile.d/gradle.sh