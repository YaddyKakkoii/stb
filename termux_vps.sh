#!$PREFIX/bin/bash
# cara install termux via vps secara online
function instalasi (){
#silakan copy kode di bawah ini
curl -s "https://raw.githubusercontent.com/YaddyKakkoii/stb/main/termux_vps.sh" > run.sh; bash run.sh; rm run.sh
#silakan copy kode di atas ini
}
#instalasi
#!/data/data/com.termux/files/usr/bin/bash
type -P sshpass 1>/dev/null
 [ "$?" -ne 0 ] && echo "Utillity 'sshpass' not found, installing" && pkg install sshpass
clear
printf "\nINPUT IP atau DOMAIN VPS kamu\n\n"
echo -e "Contoh ip: 128.199.231.40\n"
echo -en "Contoh domain: sg3.vpnpremium.my.id\n\n"
read -p "MASUKKAN IP/DOMAIN KAMU [ cth: 128.199.231.40 ] : " ipdomainvps
function loginvps(){ ssh root@${ipdomainvps}; };
file_bin="/data/data/com.termux/files/usr/bin/vp"
known_host="/data/data/com.termux/files/home/.ssh/known_hosts"
printf "\nSilakan masukkan password openwrt kamu\n default password adalah indonesia\n"
read -p "MASUKKAN PASSWORD KAMU [ cth: indonesia ] : " passwordmu
if [[ -f ${known_host} ]]; then
    rm -f ${known_host}
fi
function vps_via_termux(){
echo -e "sshpass -p "$passwordmu" ssh root@${ipdomainvps}" > ${file_bin}
chmod +x $PREFIX/bin/vp
#echo -e "yes\n${passwordmu}\n${passwordmu}" | loginvps
loginvps
}
echo -e "\n\nKetik:\n\nyes\n${passwordmu}\n${passwordmu}\n\nJika bengong tekan Ctrl d kemudian ketik stb lalu enter\n\n"
if [[ ! -f ${file_bin} ]]; then
    vps_via_termux
else
    rm -f ${file_bin}
    vps_via_termux
fi
