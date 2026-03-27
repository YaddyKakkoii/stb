#!/bin/bash
BASE_URL="https://raw.githubusercontent.com/YaddyKakkoii/stb/main"

rm -rf /etc/openclash/{backup,config,rule_provider,proxy_provider}
mkdir -p /etc/openclash/{backup,config,rule_provider,proxy_provider}

wget -qO /etc/openclash/config/flexy.yaml "$BASE_URL/config/flexy.yaml"

for file in ID.yaml SG.yaml; do
    wget -qO "/etc/openclash/proxy_provider/$file" "$BASE_URL/proxy_provider/$file"
done

# Rule Provider
for file in \
    banks.yaml \
    playstore.yaml \
    portumum.yaml \
    direct.yaml \
    reject.yaml \
    speedtest.yaml \
    meta.yaml \
    sosmed.yaml \
    youtube.yaml \
    tiktok.yaml \
    streaming.yaml \
    telegram.yaml \
    whatsapp.yaml
do
    wget -qO "/etc/openclash/rule_provider/$file" "$BASE_URL/rule_provider/$file"
done

echo -e "Proses selesai!\n Silahkan Restart Openclash "

