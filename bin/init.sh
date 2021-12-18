#!/bin/bash


# 初始化配置，如果已经有大量修改过的配置了，不要轻易执行该动作
# xfce4 安装
echo y | pacman -S xorg
echo y | pacman -S xfce4 xfce4-goodies
echo y | pacman -S lightdm lightdm-gtk-greeter
system enable lightdm.service

# 配置DNS
#@ /etc/resolv.conf
echo -e "
# 常见路由
nameserver 8.8.8.8
nameserver 8.8.4.4
nameserver 114.114.114.114
### 联通网络DNS
nameserver 202.106.0.20
"  > /etc/resolv.conf

#@ /etc/hosts
echo -e "
127.0.0.1      localhost
::1            localhost
127.0.1.1      myhostname.localdomain  myhostname
" > /etc/hosts

#@ wifi开机自动连接
#@ /etc/iwd/main.conf
echo -e "
[General]
EnableNetworkConfiguration=true
" > /etc/iwd/main.conf

# ~/.bashrc
echo -e "
#p@自动补全命令
if [ -d /usr/share/bash-completion/completions ]; then
   completFiles=(\$(ls /usr/share/bash-completion/completions))
   for fileName in \${completFiles[*]}
   do
      source /usr/share/bash-completion/completions/\$fileName
   done
fi
" > ~/.bashrc
