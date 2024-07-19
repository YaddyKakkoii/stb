#!/data/data/com.termux/files/usr/bin/bash
clear
file_bin="/data/data/com.termux/files/usr/bin/stb"
known_host="/data/data/com.termux/files/home/.ssh/known_hosts"
printf "\nSilakan masukkan password openwrt kamu\n default password adalah indonesia\n"
read -p "MASUKKAN PASSWORD KAMU [ cth: indonesia ] : " passwordmu
if [[ -f ${known_host} ]]; then
    rm -f ${known_host}
fi
if [[ ! -f ${file_bin} ]]; then
    echo -e "sshpass -p "$passwordmu" ssh root@192.168.1.1" > ${file_bin}
    chmod +x $PREFIX/bin/stb
    ssh root@192.168.1.1 | echo -e "yes\n${passwordmu}\n${passwordmu}\n\nJika bengong tekan Ctrl d kemudian ketik stb lalu enter"
    yes
else
    rm -f ${file_bin}
    echo -e "sshpass -p "$passwordmu" ssh root@192.168.1.1" > ${file_bin}
    chmod +x $PREFIX/bin/stb
    ssh root@192.168.1.1 | echo -e "yes\n${passwordmu}\n${passwordmu}\n\nJika bengong tekan Ctrl d kemudian ketik stb lalu enter"
    yes
fi
