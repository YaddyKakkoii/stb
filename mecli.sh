#!/bin/bash
TARGET_DIR=/storage/emulated/0/me-cli
mkdir -p "$TARGET_DIR"
if [[ ! -f ${TARGET_DIR}/main.py ]]; then
git clone https://github.com/purplemashu/me-cli "$TARGET_DIR"
fi

cd "$TARGET_DIR" || { echo "Gagal masuk ke $TARGET_DIR"; exit 1; }
if ! command -v python-pillow &> /dev/null; then
 bash setup.sh
fi

python main.py
