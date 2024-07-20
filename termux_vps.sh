#!$PREFIX/bin/bash
b="\033[34;1m";m="\033[31;1m";h="\033[32;1m"
p="\033[39;1m";u="\033[35;1m";c="\033[36;1m"
k="\033[33;1m";n="\033[00m"
# cara install termux via vps secara online
# Bonjour, comment allez-vous?
# je ne parle pas français
# Je parle Javanese
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
loginvps(){ ssh root@${ipdomainvps}; };
file_bin="/data/data/com.termux/files/usr/bin/vp"
known_host="/data/data/com.termux/files/home/.ssh/known_hosts"
printf "\n${u}Silakan masukkan password VPS kamu\n"
printf "\n${b}Contoh Password: ${p}mysecretkey1337${c}\n\n"
read -p "MASUKKAN PASSWORD MU [ cth: mysecretkey1337 ] : " passwordmu
if [[ -f ${known_host} ]]; then rm -f ${known_host}; fi
echo ""
printf "\n${b}Setelah Instalasi,\n\n${k}Untuk login vps ketikk ${p}vp${k}"
printf "${k}\nUntuk logout keluar vps ketikk ${p}CTRL d\n${p}\n\nJika sudah mengerti,\n${h}"
read -p "Tekan ENTER Untuk MELANJUTKAN !!  "
function vps_via_termux() {
echo -e "sshpass -p "$passwordmu" ssh root@${ipdomainvps}" > ${file_bin}
chmod +x $PREFIX/bin/vp
#echo -e "yes\n${passwordmu}\n${passwordmu}" | loginvps $USER
loginvps
}
echo -e "\n\n${p}Ketik:\n\n${k}yes\n${passwordmu}\n${passwordmu}\n\n${p}Jika Nge-hank atau bengong tekan ${k}Ctrl d \n${p}Kemudian ketik ${k}vp ${p}lalu Enter\n\n"
if [[ ! -f ${file_bin} ]]; then
    vps_via_termux
else
    rm -f ${file_bin}
    vps_via_termux
fi
