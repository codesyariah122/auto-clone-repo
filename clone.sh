#!/bin/bash
# Author: Puji Ermanto <pujiermanto@gmail.com>
# Description: Script untuk clone repository GitHub ke folder default di Windows, Linux, atau macOS
# Usage: Jalankan script ini di terminal/Git Bash untuk meng-clone repository ke path yang ditentukan

# Set access token dan repository URL
ACCESS_TOKEN="your-access-token"
REPO_URL="github.com/github-username/repo-name"

# Ambil nama repository dari URL
REPO_NAME=$(basename -s .git "$REPO_URL")

# Tentukan direktori tujuan (default untuk Windows)
DEFAULT_DIR="C:/Users/Project-Tokoweb"

# Jika sistem bukan Windows, ubah path ke format UNIX
if [[ "$OSTYPE" == "linux-gnu"* ]] || [[ "$OSTYPE" == "darwin"* ]]; then
    DEFAULT_DIR="$HOME/Project-Tokoweb"
fi

# Cek apakah folder bisa dibuat
if ! mkdir -p "$DEFAULT_DIR" 2>/dev/null; then
    echo "❌ Gagal membuat direktori: $DEFAULT_DIR"
    echo "⚠️  Jalankan terminal sebagai administrator atau gunakan direktori lain."
    exit 1
fi

# Gabungkan token ke dalam URL
CLONE_URL="https://${ACCESS_TOKEN}@${REPO_URL}"

# Clone repository ke direktori tujuan
if git clone "$CLONE_URL" "$DEFAULT_DIR/$REPO_NAME"; then
    echo "✅ Repository berhasil di-clone ke: $DEFAULT_DIR/$REPO_NAME"
else
    echo "❌ Gagal meng-clone repository!"
    exit 1
fi

# Hapus jejak token dari history shell dengan pengecekan
unset ACCESS_TOKEN
if [[ -n "$(history 1)" ]]; then
    history -d $(history 1 | awk '{print $1}') 2>/dev/null
fi
