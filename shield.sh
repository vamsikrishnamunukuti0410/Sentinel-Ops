#!/bin/bash

# --- CONFIGURATION (Must be defined!) ---
LOG_FILE="/home/ubuntu/sentinel-ops/logs/health.log"
ALERT_LOG="/home/ubuntu/sentinel-ops/logs/alerts.log"
MAX_SIZE_KB=1024 

echo "--- [$(date)] SHIELD ANALYSIS STARTING ---"

# 1. VALIDATION (Module 38/39)
# We check if file exists, but we DO NOT exit if it's healthy.
if [ ! -s "$LOG_FILE" ]; then
    echo "Error: $LOG_FILE is missing or empty. Skipping analysis."
    exit 1
fi

# 2. THE EFFICIENT SCAN (Single-Pass Extraction)
# Use grep -E for multi-pattern matching in one read. (Module 37)
THREATS=$(tail -n 50 "$LOG_FILE" | grep -E "CRITICAL|WARNING")

if [[ -n "$THREATS" ]]; then
    echo "[!] THREATS DETECTED: Formatting and logging..."
    # Append to alert log with timestamp
    echo "$THREATS" | sed "s/^/[$(date)] /" >> "$ALERT_LOG"
else
    echo "OK: No threats found in recent logs."
fi

# 3. LOG ROTATION (Module 35/40)
# Check size and truncate if necessary.
CURRENT_SIZE=$(stat -c%s "$LOG_FILE")
MAX_SIZE_BYTES=$((MAX_SIZE_KB * 1024))

if [ "$CURRENT_SIZE" -gt "$MAX_SIZE_BYTES" ]; then
    echo "[*] Health log limit reached. Truncating..."
    # Proper truncation to 0 bytes
    > "$LOG_FILE" 
    echo "[$(date)] LOG_WIPE: Health log cleared (Policy: Zero-Waste)." >> "$ALERT_LOG"
fi
