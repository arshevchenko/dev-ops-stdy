#!/bin/bash
su -c "dnf update -y"
su -c "dnf install -y wget java tomcat jetty"
su -c "wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins.io/redhat-stable/jenkins.repo"
su -c "rpm --import http://pkg.jenkins.io/redhat-stable/jenkins.io.key"
su -c "dnf install -y jenkins"
su -c "sed -i 's/JENKINS_AJP_PORT=\"8009\"/JENKINS_AJP_PORT=\"-1\"/g' /etc/sysconfig/jenkins"
su -c "systemctl enable jenkins"
su -c "systemctl start jenkins"
echo "Jenkins succesfuly installed and pre-configurated. \n Enter to localhost:8080 for configuration."


if [  $(rpm -qa | grep -qw "openssh") ] && [  $(rpm -qa | grep -qw "openssh-server") ]
then
  su -c "dnf install -y openssh openssh-server"
  su -c "ssh-keygen -A"
fi

if [  $(ps -e | grep -qw "/sbin/sshd") ]
then
  su -c "systemctl start sshd.service"
  echo "Ssh daemon succesfuly launched"
fi
