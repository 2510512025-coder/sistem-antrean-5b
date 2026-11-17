#!/bin/bash
# Mahasiswa 3: pencatatan status, PID, dan exit status pekerjaan
# Pemakaian: status_job.sh <id_job> <perintah> [argumen...]
# Status: MENUNGGU -> BERJALAN -> BERHASIL / GAGAL

BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
LOG_DIR="$BASE_DIR/logs"
STATUS_LOG="$LOG_DIR/status.log"
mkdir -p "$LOG_DIR"

catat() {  # id status pid exit keterangan
  echo "$(date '+%Y-%m-%d %H:%M:%S') | JOB=$1 | STATUS=$2 | PID=$3 | EXIT=$4 | $5" >> "$STATUS_LOG"
}

if [ $# -lt 2 ]; then
  echo "Pemakaian: $0 <id_job> <perintah> [argumen...]" >&2
  exit 2
fi

ID="$1"; shift

catat "$ID" "MENUNGGU" "-" "-" "pekerjaan masuk: $*"

"$@" &
PID=$!
catat "$ID" "BERJALAN" "$PID" "-" "proses dimulai"

wait "$PID"
KODE=$?

if [ "$KODE" -eq 0 ]; then
  catat "$ID" "BERHASIL" "$PID" "$KODE" "selesai normal"
else
  catat "$ID" "GAGAL" "$PID" "$KODE" "exit status bukan nol"
fi

exit "$KODE"
