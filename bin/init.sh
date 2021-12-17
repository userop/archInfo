#!/bin/bash


# 初始化配置，如果已经有大量修改过的配置了，不要轻易执行该动作
# xfce4 安装
echo y | pacman -S xorg
echo y | pacman -S xfce4 xfce4-goodies
echo y | pacman -S lightdm lightdm-gtk-greeter
system enable lightdm.service

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
