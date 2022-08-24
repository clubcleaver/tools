#!/bin/bash
#basic oscp pdf commands for enumeration

echo -e "\n ** WHO AM I ? **\n"
echo -e "\n>whoami:\n---------"
whoami
echo -e "\n>id::\n---------"
id
echo -e "\n>hostname::\n---------"
hostname

echo -e "\n\n ** OS and MACHINE ** \n"
echo -e "\n>issue::\n---------"
cat /etc/issue
echo -e "\n>release::\n---------"
cat /etc/*-release
echo -e "\n>OS info::\n---------"
uname -a
echo -e "\n>Kernel version::\n---------"
uname -r
echo -e "\n>Arch::\n---------"
arch

echo -e "\n\n ** its all about PASSWORDS **\n"
echo -e "\n>passwd file permissions::\n---------"
ls -la /etc/ | grep passwd
echo -e "\n>shadow file permissions::\n---------"
ls -la /etc/ | grep shadow
echo -e "\n>passwd file::\n---------"
cat /etc/passwd

echo -e "\n\n ** SHEDULING -- CRON --  **\n"
echo -e "\n>cron folder::\n---------"
ls -lah /etc/cron*
echo -e "\n>crontab file::\n---------"
cat /etc/crontab

echo -e "\n\n ** WRITABLE -- files -- **\n"
#un-comment below  when low priv only !!
#echo -e "\n>writable files:";find / -writable -type d 2>/dev/null

echo -e "\n\n ** UID Permission set! -- autoelevate bins -- **\n"
find / -perm -u=s -type f 2>/dev/null

echo -e "\n\n ** WHERE and WHO connected **\n"
ss -a

echo -e "\n\n ** WHATS RUNNING**\n"
ps -axu


echo -e "\n\n ** MOUNTS and SHARES **\n"
echo -e "\n>Mounts::\n---------"
mount
echo -e "\n>fstab FILE::\n---------"
cat /etc/fstab
echo -e "\n>lsblk::\n---------"
/bin/lsblk

echo -e "\n\n ** DRIVERS **\n"
lsmod
exit
