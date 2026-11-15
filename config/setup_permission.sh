#!/bin/bash
# Menyiapkan grup, akun uji, dan folder antrean bersama
getent group antrean >/dev/null || sudo groupadd antrean
id petugas >/dev/null 2>&1 || sudo useradd -m -s /bin/bash -G antrean petugas
id tamu >/dev/null 2>&1 || sudo useradd -m -s /bin/bash tamu

sudo mkdir -p /srv/antrean
sudo cp "$(dirname "$0")/../tests/data/antrean_contoh.txt" /srv/antrean/antrean.txt
sudo chown root:antrean /srv/antrean /srv/antrean/antrean.txt
sudo chmod 770 /srv/antrean
sudo chmod 660 /srv/antrean/antrean.txt
echo "Selesai. Grup antrean: petugas (anggota), tamu (bukan anggota)."
