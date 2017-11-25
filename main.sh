#!/usr/bin/env bash
# set -e
ChangeSource(){
# Use https to ensure security
apt install apt-transport-https
#
mv /etc/apt/sources.list /etc/apt/sources.list.old
echo 'deb http://mirror.tuna.tsinghua.edu.cn/debian/ testing main contrib non-free
deb http://mirror.tuna.tsinghua.edu.cn/debian-security/ testing/updates main contrib non-free
deb http://mirror.tuna.tsinghua.edu.cn/debian/ testing-updates main contrib non-free
deb http://mirror.tuna.tsinghua.edu.cn/debian/ testing-proposed-updates main contrib non-free
# deb http://mirror.tuna.tsinghua.edu.cn/debian/ experimental main
# deb http://mirror.tuna.tsinghua.edu.cn/debian/ testing-backports main contrib non-free
# deb http://repo.debiancn.org/ stretch main experimental' > /etc/apt/sources.list
}

# Uncomment the following line to change your sources.list
# ChangeSource

# Preparation
apt update
apt full-upgrade -y
apt clean

# Install daily packages
apt install -y tmux nano vim screen less git lsof htop bash-completion build-essential autoconf automake
apt clean

# Install xfce desktop
apt install -y xfce4 xfce4-goodies xorg fonts-noto
apt clean

# Install tigervnc server
apt install -y tigervnc-scraping-server tigervnc-standalone-server tigervnc-xorg-extension
apt clean

# Install chromium browser
apt install -y chromium-l10n
apt clean
sed -i 's/^vncconfig\ -iconic\ \&/\#vncconfig\ -iconic\ \&/g' /etc/X11/Xvnc-session

# Install themes
echo 'You 'd better build package from ppa if the theme cannot install properly. See https://wiki.debian.org/CreatePackageFromPPA'
touch /etc/apt/trusted.gpg.d/adapta-gtk-theme.gpg /etc/apt/trusted.gpg.d/paper-icon-theme.gpg
# Since keyserver.ubuntu.com is slow in China, an alternative is used.
# apt-key --keyring /etc/apt/trusted.gpg.d/adapta-gtk-theme.gpg adv --keyserver keyserver.ubuntu.com --recv 2D87398A
# apt-key --keyring /etc/apt/trusted.gpg.d/paper-icon-theme.gpg adv --keyserver keyserver.ubuntu.com --recv 89993A70
wget -qO - https://raw.githubusercontent.com/Jerry981028/install-xfce-on-debian/master/keys/adapta-gtk-theme.key |apt-key --keyring /etc/apt/trusted.gpg.d/adapta-gtk-theme.gpg add -
wget -qO - https://raw.githubusercontent.com/Jerry981028/install-xfce-on-debian/master/keys/paper-icon-theme.key |apt-key --keyring /etc/apt/trusted.gpg.d/paper-icon-theme.gpg add -
# apt-key del 2D87398A 89993A70 # Use this command to delete the keys imported.
echo 'deb http://ppa.launchpad.net/tista/adapta/ubuntu artful main
#deb-src http://ppa.launchpad.net/tista/adapta/ubuntu artful main' > /etc/apt/sources.list.d/adapta-gtk-theme.list
echo 'deb http://ppa.launchpad.net/snwh/pulp/ubuntu artful main
#deb-src http://ppa.launchpad.net/snwh/pulp/ubuntu artful main' > /etc/apt/sources.list.d/paper-icon-theme.list
apt update
apt install -y adapta-gtk-theme paper-icon-theme paper-cursor-theme
apt clean
#update-alternatives --config x-session-manager
echo -e 'Installation complete.'

exit 0
