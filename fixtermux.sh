#!/bin/bash
YDX="https://raw.githubusercontent.com/YaddyKakkoii/stb/main/"
clear
tyblue='\e[1;36m'
NC='\e[0m'
b="\033[34;1m";m="\033[31;1m";h="\033[32;1m"
p="\033[39;1m";c="\033[35;1m";u="\033[36;1m"
k="\033[33;1m";n="\033[00m"
load(){
printf "${p}[${m}•${p}]${n}Check_and_install paket yang diperlukan${h}"
sleep 1
printf "."
sleep 0.5
printf "."
sleep 0.5
printf "."
sleep 1
printf ".\n"
}
load
apt install perl -y
apt install binutils -y
apt install libarchive
apt install git
apt install libandroid-wordexp
pkg install libandroid-wordexp
pkg install file
if ! command -v which &> /dev/null; then apt install which -y; fi
    if ! which gawk &> /dev/null; then
        apt install gawk
    fi
if ! command -v patchelf &> /dev/null; then apt install patchelf; fi
type -P curl 1>/dev/null
[ "$?" -ne 0 ] && echo "Utillity 'curl' not found, installing" && apt install curl -y
folder_bin=$(which curl | sed 's/curl//g')
instal_nodejs(){
    folder_bin="/data/data/com.termuxdata/files/usr/bin/"
    pkg update && pkg upgrade -y
    pkg install nodejs -y
    ln -s ${folder_bin}nodejs ${folder_bin}node
    npm install -g bash-obfuscate
}
    if [ $(dpkg-query -W -f='${Status}' shc 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
        echo belum terinstall shc, we will aquire them now. This may take a while.
        read -p 'Press enter to continue.'
        apt update && apt upgrade -y
        apt install shc
    elif [ $(dpkg-query -W -f='${Status}' nodejs 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
        echo belum terinstall nodejs, we will aquire them now. This may take a while.
        read -p 'Press enter to continue.'
        instal_nodejs
    fi
if [[ ! -f /data/data/com.termux/files/usr/bin/npm ]]; then
    instal_nodejs
fi
type -P tput 1>/dev/null
[ "$?" -ne 0 ] && echo "Utillity 'tput' not found, installing ncurses-utils" && apt install ncurses-utils
# ============================================================
type -P wget 1>/dev/null
[ "$?" -ne 0 ] && echo "Utillity 'wget' not found, installing" && apt install wget -y
type -P nmap 1>/dev/null
[ "$?" -ne 0 ] && echo "Utillity 'nmap' not found, installing" && apt install nmap -y
type -P zip 1>/dev/null
[ "$?" -ne 0 ] && echo "Utillity 'zip' not found, installing" && apt install zip -y
type -P jq 1>/dev/null
 [ "$?" -ne 0 ] && echo "Utillity 'jq' not found, installing" && apt install jq
type -P sshpass 1>/dev/null
 [ "$?" -ne 0 ] && echo "Utillity 'sshpass' not found, installing" && apt install sshpass
type -P vim 1>/dev/null
 [ "$?" -ne 0 ] && echo "Utillity 'vim' not found, installing" && apt install vim
# ============================================================
#ln -s /data/data/com.termux/files/usr/bin/nodejs /data/data/com.termux/files/usr/bin/node
cd $HOME
wget "https://raw.githubusercontent.com/YaddyKakkoii/stb/main/termuxsharedobject.zip"
unzip termuxsharedobject.zip
chmod +x sharedobject/*
cd sharedobject
cp -vf *.so $PREFIX/lib
HOME_PATH="$HOME"
function check_dir(){
echo "HOME DIR: $HOME_PATH"
}
cd $HOME
if [ -d $HOME/.var ]; then rm -rf $HOME/.var; fi
    mkdir -p $HOME/.var
    mkdir -p $HOME/.var/local
    mkdir -p $HOME/.var/local/sbin
    mkdir -p $HOME/.var/local/backup
if [ ! -f $HOME/.var/local/sbin/spiner ]; then
    wget -qO $HOME/.var/local/sbin/spiner "${YDX}spiner.sh"
    chmod 777 $HOME/.var/local/sbin/spiner
else
    rm -rf $HOME/.var/local/sbin/spiner
    wget -qO $HOME/.var/local/sbin/spiner "${YDX}spiner.sh"
    chmod 777 $HOME/.var/local/sbin/spiner
fi

rm -f termuxsharedobj*
rm -rf sharedobject

echo ""
check_dir
echo ""
echo "CURRENT DIR: $(pwd)"
echo ""
exit 0
