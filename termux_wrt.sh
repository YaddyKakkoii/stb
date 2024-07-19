#!/data/data/com.termux/files/usr/bin/bash
clear
function loginwrt(){ ssh root@192.168.1.1; };
file_bin="/data/data/com.termux/files/usr/bin/stb"
known_host="/data/data/com.termux/files/home/.ssh/known_hosts"
printf "\nSilakan masukkan password openwrt kamu\n default password adalah indonesia\n"
read -p "MASUKKAN PASSWORD KAMU [ cth: indonesia ] : " passwordmu
if [[ -f ${known_host} ]]; then
    rm -f ${known_host}
fi
function stbtermux(){
echo -e "sshpass -p "$passwordmu" ssh root@192.168.1.1" > ${file_bin}
chmod +x $PREFIX/bin/stb
#echo -e "yes\n${passwordmu}\n${passwordmu}" | loginwrt
loginwrt
}
echo -e "\n\nKetik:\n\nyes\n${passwordmu}\n${passwordmu}\n\nJika bengong tekan Ctrl d kemudian ketik stb lalu enter\n\n"
if [[ ! -f ${file_bin} ]]; then
    stbtermux
else
    rm -f ${file_bin}
    stbtermux
fi
