#!/bin/bash
cd "$(dirname "$0")/.." || exit 1
rm -f logs/status.log

echo "=== SKENARIO POSITIF: pekerjaan normal (exit 0) ==="
./scripts/status_job.sh JOB-001 sleep 1
echo "exit status: $?"

echo
echo "=== SKENARIO NEGATIF: pekerjaan error (exit != 0) ==="
./scripts/status_job.sh JOB-002 bash -c 'echo "simulasi error"; exit 3'
echo "exit status: $?"

echo
echo "=== ISI logs/status.log ==="
cat logs/status.log
