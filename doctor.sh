#!/bin/bash

#---Config----
THRESHOLD_DISK=80
CPU_CORES=$(nproc)

echo "------------------------------------------"
echo "  SENTINEL-OPS: SYSTEM AUDIT ENGINE      "
echo "  DATE: $(date)"
echo "------------------------------------------"

#1. DISK Health 
echo "[*] Checking Disk Usage..."
CURRENT_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$CURRENT_USAGE" -gt "$THRESHOLD_DISK" ]; then
	echo "!!! CRITICAL: Disk usage is at ${CURRENT_USAGE}% !!!"

	du -ah /var/log 2>/dev/null | sort -rh | head -n 5
else
	echo "OK: Disk usage is within limits (${CURRENT_USAGE}%)"
fi


#LOAD MONITORING
LOAD_1MIN=$(uptime | awk -F 'load average:' '{print $2}' | cut -d, -f1 | xargs)


echo "[*] System load: $LOAD_1MIN | Cores: $CPU_CORES"


if (( $(echo "$LOAD_1MIN > $CPU_CORES" | bc -l) )); then
	echo "!!! WARNING: SYSTEM OVERLOADED !!!"
else

	echo "OK: Load is stable."
fi

#ZOMBIE AUDIT 
echo "[*] Scanning for Zombie Processes..."
ZOMBIE_COUNT=$(ps aux | awk '$8=="Z"' | wc -l)

if [ "$ZOMBIE_COUNT" -gt 0 ]; then
	echo "WARNING: Found $ZOMBIE_COUNT zombie processes!"

	ps aux | awk '$8=="Z" {print "PID: "$2" | PPID: "$3}'
else
	echo "OK: No Zombie detected."
fi


