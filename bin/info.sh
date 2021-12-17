#!/bin/bash

# 配置安装中文输入法
# google-pinyin
echo y | pacman -Sy
echo y | pacman -S archlinuxcn-keyring
echo y | pacman -S fcitx-im fcitx-configtool fcitx-gtk2 fcitx-gtk3 fcitx-qt5 libidn fcitx-googlepinyin
# 开机自启动
if [ ! -f ~/.config/autostart/fcitx-autostart.desktop ]; then
mkdir -p ~/.config/autostart
cp /etc/xdg/autostart/fcitx-autostart.desktop ~/.config/autostart/
fi
# 系统重启后生效
mkdir -p ~/.config/fcitx/
echo -e "export GTK_IM_MODULE=fcitx\nexport QT_IM_MODULE=fcitx\nexport XMODIFIERS=@im=fcitx" > ~/.config/fcitx/profile
