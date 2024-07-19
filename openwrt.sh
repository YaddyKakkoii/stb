#!/data/data/com.termux/files/usr/bin/bash
file_bin="/data/data/com.termux/files/usr/bin/stb"
known_host="/data/data/com.termux/files/home/.ssh/known_hosts"
if [[ -f ${file_bin} ]]; then
    echo -e "sshpass -p "indonesia" ssh root@192.168.1.1" > ${file_bin}
fi
if [[ -f ${known_host} ]]; then
    rm -f ${known_host}
fi
