#!/bin/bash
# pemakaian: ./scripts/monitor.sh <label_beban> <durasi_detik>
LABEL="${1:-uji}"; DUR="${2:-5}"
[[ "$DUR" =~ ^[0-9]+$ ]] || { echo "Durasi harus angka"; exit 2; }
mkdir -p output
{
  echo "=== Monitoring [$LABEL] $(date '+%F %T') ==="
  for i in $(seq 1 "$DUR"); do
    CPU=$(top -bn1 | awk '/Cpu\(s\)/ {print 100-$8}')
    MEM=$(free -m | awk '/Mem:/ {print $3"/"$2" MB"}')
    echo "t=$i CPU=${CPU}% MEM=$MEM"
    sleep 1
  done
} >> output/laporan.txt
