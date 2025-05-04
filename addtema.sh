
#!/bin/bash
tambahkantema(){
cd /root
opkg update && opkg upgrade

fileconfig="luci-app-alpha-config_2.1_all.ipk"
filetema="luci-theme-alpha_3.9.7-beta-10_all.ipk"

wget -o /root/$fileconfig "https://objects.githubusercontent.com/github-production-release-asset-2e65be/588593072/39d77676-109b-493c-b89d-58bd8f09e764?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20250504%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250504T022946Z&X-Amz-Expires=300&X-Amz-Signature=0a9481c4599a70457bef777d4362c72c8e2a1cf3328bce5b699756bb4daa1415&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dluci-theme-alpha_3.9.7-beta-10_all.ipk&response-content-type=application%2Foctet-stream"
if [ $? -eq 0 ]; then
echo "Unduhan $fileconfig via wget berhasil"
chmod +x luci-theme-alpha_3.9.7-beta-10_all.ipk
else
echo "Unduhan $fileconfig via wget gagal, beralih dengan curl"
curl -L -o luci-theme-alpha_3.9.7-beta-10_all.ipk -# --retry 2 https://github.com/derisamedia/luci-theme-alpha/releases/download/3.9.7/luci-theme-alpha_3.9.7-beta-10_all.ipk
if [ $? -eq 0 ]; then
echo "Unduhan $fileconfig via curl berhasil"
chmod +x $fileconfig
else
echo "Unduhan $fileconfig via curl gagal, please cek url"
fi
fi

wget -o /root/$filetema "https://objects.githubusercontent.com/github-production-release-asset-2e65be/588593072/6a2fe3ca-9cc8-4295-b3e1-15159fed7f79?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20250504%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20250504T023643Z&X-Amz-Expires=300&X-Amz-Signature=e54b74e4eed4109d596a44340a83bb6564244a25bbddf54e73446ad225043d84&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3Dluci-app-alpha-config_2.1_all.ipk&response-content-type=application%2Foctet-stream"
if [ $? -eq 0 ]; then
echo "Unduhan $filetema via wget berhasil"
chmod +x luci-theme-alpha_3.9.7-beta-10_all.ipk
else
echo "Unduhan $filetema via wget gagal, beralih dengan curl"
curl -L -o luci-theme-alpha_3.9.7-beta-10_all.ipk -# --retry 2 https://github.com/derisamedia/luci-theme-alpha/releases/download/3.9.7/luci-app-alpha-config_2.1_all.ipk
if [ $? -eq 0 ]; then
echo "Unduhan $filetema via curl berhasil"
chmod +x $filetema
else
echo "Unduhan $filetema via curl gagal, please cek url"
fi
fi

opkg install luci-theme-alpha_3.9.7-beta-10_all.ipk
opkg install luci-app-alpha-config_2.1_all.ipk

}
tambahkantema
