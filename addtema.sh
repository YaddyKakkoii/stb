#!/bin/bash
tambahkantema(){

cd /root
opkg update

if [[ -f /root/luci-app-alpha-config_2.1_all.ipk ]]; then
rm -vf luci-app-alpha-config_2.1_all.ipk
fi
if [[ -f /root/luci-theme-alpha_3.9.7-beta-10_all.ipk ]]; then
rm -vf luci-theme-alpha_3.9.7-beta-10_all.ipk
fi

fileconfig="luci-app-alpha-config_2.1_all.ipk"
filetema="luci-theme-alpha_3.9.7-beta-10_all.ipk"

wget -o /root/$filetema "https://github.com/derisamedia/luci-theme-alpha/releases/download/3.9.7/luci-theme-alpha_3.9.7-beta-10_all.ipk"
if [ $? -eq 0 ]; then
echo "Unduhan $filetema via wget berhasil"
chmod +x luci-theme-alpha_3.9.7-beta-10_all.ipk
else
echo "Unduhan $filetema via wget gagal, beralih dengan curl"
curl -L -o luci-theme-alpha_3.9.7-beta-10_all.ipk -# --retry 2 https://github.com/derisamedia/luci-theme-alpha/releases/download/3.9.7/luci-theme-alpha_3.9.7-beta-10_all.ipk
if [ $? -eq 0 ]; then
echo "Unduhan $filetema via curl berhasil"
chmod +x $filetema
else
echo "Unduhan $filetema via curl gagal, please cek url"
fi
fi

wget -o /root/$fileconfig "https://github.com/derisamedia/luci-theme-alpha/releases/download/3.9.7/luci-app-alpha-config_2.1_all.ipk"
if [ $? -eq 0 ]; then
echo "Unduhan $fileconfig via wget berhasil"
chmod +x luci-theme-alpha_3.9.7-beta-10_all.ipk
else
echo "Unduhan $fileconfig via wget gagal, beralih dengan curl"
curl -L -o luci-theme-alpha_3.9.7-beta-10_all.ipk -# --retry 2 https://github.com/derisamedia/luci-theme-alpha/releases/download/3.9.7/luci-app-alpha-config_2.1_all.ipk
if [ $? -eq 0 ]; then
echo "Unduhan $fileconfig via curl berhasil"
chmod +x $fileconfig
else
echo "Unduhan $fileconfig via curl gagal, please cek url"
fi
fi

opkg install luci-theme-alpha_3.9.7-beta-10_all.ipk
opkg install luci-app-alpha-config_2.1_all.ipk

}
tambahkantema
