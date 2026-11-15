#!/bin/bash
Q=/srv/antrean/antrean.txt
echo "== Hak akses =="; ls -ld /srv/antrean; ls -l "$Q"

echo "== (+) petugas (anggota grup antrean) menulis ke antrean =="
sudo -u petugas bash -c "echo 'echo job dari petugas' >> $Q"
echo "exit status: $?"

echo "== (-) tamu (bukan anggota grup) menulis ke antrean =="
sudo -u tamu bash -c "echo 'echo job ilegal' >> $Q"
echo "exit status: $?"
