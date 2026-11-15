#!/bin/bash
cd "$(dirname "$0")/.." || exit 1
F=output/laporan.txt
IMG=alpine:3.20
[ -s "$F" ] || { echo "laporan.txt belum ada/kosong, jalankan monitor.sh dulu"; exit 2; }

echo "Image: $IMG"
echo "== Checksum host (sebelum) =="; sha256sum "$F"

echo "== (+) Container membaca laporan.txt (bind mount read-only) =="
sudo docker run --rm --mount type=bind,src="$(pwd)/output",dst=/data,readonly $IMG head -n 5 /data/laporan.txt
echo "exit status: $?"

echo "== (-) Container mencoba menulis ke laporan.txt =="
sudo docker run --rm --mount type=bind,src="$(pwd)/output",dst=/data,readonly $IMG sh -c 'echo "uji" >> /data/laporan.txt'
echo "exit status: $?"

echo "== Checksum host (sesudah) =="; sha256sum "$F"
