#!/bin/bash
su -c "yum install wget java net-tools"
su -c "wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins.io/redhat-stable/jenkins.repo"
su -c "rpm --import http://pkg.jenkins.io/redhat-stable/jenkins.io.key"
su -c "yum install jenkins"

if [ ! $(rpm -qa | grep -qw "openssh") ] && [ ! $(rpm -qa | grep -qw "openssh-server") ]
then
  su -c "yum install openssh"
  su -c "yum install openssh-server"
  su -c "ssh-keygen -A"
  su -c "echo \"Port 1488\" >> /etc/ssh/sshd_config"
fi

if [ ! $(ps -e | grep -qw "/sbin/sshd") ]
then
  su -c "/sbin/sshd"
fi
