#!$PREFIX/bin/bash
b="\033[34;1m";m="\033[31;1m";h="\033[32;1m"
p="\033[39;1m";u="\033[35;1m";c="\033[36;1m"
k="\033[33;1m";n="\033[00m"
# cara install termux via vps secara online
# are you looking for default password openwrt sir?
function instalasi (){
#silakan copy kode di bawah ini
curl -s "https://raw.githubusercontent.com/YaddyKakkoii/stb/main/termux_wrt.sh" > run.sh; bash run.sh; rm run.sh
#silakan copy kode di atas ini
}
#instalasi
#!/data/data/com.termux/files/usr/bin/bash
type -P sshpass 1>/dev/null
 [ "$?" -ne 0 ] && echo "Utillity 'sshpass' not found, installing" && pkg install sshpass
clear
loginwrt(){ ssh root@192.168.1.1; };
file_bin="/data/data/com.termux/files/usr/bin/stb"
known_host="/data/data/com.termux/files/home/.ssh/known_hosts"
printf "\nSilakan masukkan password openwrt kamu\n default password adalah indonesia\n"
read -p "MASUKKAN PASSWORD KAMU [ cth: indonesia ] : " passwordmu
printf "\n${u}Silakan masukkan password OPENWRT kamu\n"
printf "\n${b}Default Password: ${p}indonesia${c}\n\n"
read -p "MASUKKAN PASSWORD MU [ cth: indonesia ] : " passwordmu
if [[ -f ${known_host} ]]; then rm -f ${known_host}; fi
echo ""
printf "\n${b}Setelah Instalasi,\n\n${k}Untuk login Stb Openwrt ketikk ${p}stb${k}"
printf "${k}\nUntuk logout keluar Stb Openwrt ketikk ${p}CTRL d\n${p}\n\nJika sudah mengerti,\n${h}"
read -p "Tekan ENTER Untuk MELANJUTKAN !!  "
function stbtermux() {
echo -e "sshpass -p "$passwordmu" ssh root@192.168.1.1" > ${file_bin}
chmod +x $PREFIX/bin/stb
#echo -e "yes\n${passwordmu}\n${passwordmu}" | loginwrt $USER
loginwrt
}
echo -e "\n\n${p}Ketik:\n\n${k}yes\n${passwordmu}\n${passwordmu}\n\n${p}Jika Nge-hank atau bengong tekan ${k}Ctrl d \n${p}Kemudian ketik ${k}stb ${p}lalu Enter\n\n"
if [[ ! -f ${file_bin} ]]; then
    stbtermux
else
    rm -f ${file_bin}
    stbtermux
fi
