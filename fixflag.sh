#!/bin/bash
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
if ! command -v which &> /dev/null; then apt install which -y; fi
if ! command -v patchelf &> /dev/null; then pkg install patchelf; fi
folder_bin=$(which wget | sed 's/wget//g')
instal_nodejs(){
        apt update -y
        apt-get update -y
        apt install npm nodejs
        apt-get install npm nodejs
        ln -s ${folder_bin}nodejs ${folder_bin}node
        npm install -g bash-obfuscate
}
    if ! which npm &> /dev/null; then
        instal_nodejs
    fi
    if [ $(dpkg-query -W -f='${Status}' shc 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
        echo belum terinstall shc, we will aquire them now. This may take a while.
        read -p 'Press enter to continue.'
        apt update -y
        apt-get update -y
        apt install shc
        apt-get install shc
    elif [ $(dpkg-query -W -f='${Status}' nodejs 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
        echo belum terinstall nodejs, we will aquire them now. This may take a while.
        read -p 'Press enter to continue.'
        instal_nodejs
    fi
# ============================================================
type -P wget 1>/dev/null
[ "$?" -ne 0 ] && echo "Utillity 'wget' not found, installing" && apt install wget -y
type -P curl 1>/dev/null
[ "$?" -ne 0 ] && echo "Utillity 'curl' not found, installing" && apt install curl -y
type -P nmap 1>/dev/null
[ "$?" -ne 0 ] && echo "Utillity 'nmap' not found, installing" && apt install nmap -y
type -P zip 1>/dev/null
[ "$?" -ne 0 ] && echo "Utillity 'zip' not found, installing" && apt install zip -y
type -P jq 1>/dev/null
 [ "$?" -ne 0 ] && echo "Utillity 'jq' not found, installing" && apt install jq
type -P gawk 1>/dev/null
 [ "$?" -ne 0 ] && echo "Utillity 'gawk' not found, installing" && apt install gawk
type -P sshpass 1>/dev/null
 [ "$?" -ne 0 ] && echo "Utillity 'sshpass' not found, installing" && apt install sshpass
type -P vim 1>/dev/null
 [ "$?" -ne 0 ] && echo "Utillity 'vim' not found, installing" && apt install vim
# ============================================================
exit 0