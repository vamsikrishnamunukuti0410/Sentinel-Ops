# Sentinel-Ops: Containerized Cloud Monitoring Engine

A production-grade system observability suite deployed on **AWS EC2**. It utilizes a containerized agent to audit host-level health metrics, providing automated alerting and intelligent log management.

## 🚀 Key Features

- **Containerized Observability**: Runs a hardened Alpine Linux agent using Docker, utilizing host PID namespace sharing for accurate system-wide monitoring.
- **Intelligent Alerting**: Features a custom Bash engine (shield.sh) that performs single-pass regex extraction to identify system threats (CPU spikes, Disk exhaustion, Zombie processes).
- **Resource Efficiency**: Implemented a "Zero-Waste" log rotation policy, preventing disk bloat on small cloud instances via atomic file truncation.
- **Security First**: The agent runs as a non-root system user within the container to follow the principle of least privilege.

## 🛠️ Tech Stack

- **Cloud**: AWS EC2 (t3.micro), Security Groups, UFW Firewall
- **Containers**: Docker, Alpine Linux (Multi-stage mindset)
- **Scripting**: Advanced Bash (Grep, Awk, Sed, BC for float math)
- **Automation**: Linux Crontab scheduling

## 📂 Project Structure

```
sentinel-ops/
├── Dockerfile          # Hardened Alpine-based environment
├── doctor.sh           # The "Sensor" - Gathers raw system metrics
├── shield.sh           # The "Intelligence" - Parses logs & alerts
├── logs/               # Local directory for health & alert data
└── README.md           # Documentation
```

## ⚙️ Setup & Deployment

### Build the Agent
```bash
docker build -t sentinel-agent:v1.0 .
```

### Run the Monitor (Manual Test)
```bash
docker run --rm --pid=host sentinel-agent:v1.0
```

### Automate via Cron
```bash
*/5 * * * * docker run --rm --pid=host sentinel-agent:v1.0 >> ~/sentinel-ops/logs/health.log 2>&1
```

## 📊 How It Works

1. **doctor.sh** collects system metrics (CPU, Memory, Disk, Processes)
2. **shield.sh** analyzes logs and triggers alerts based on thresholds
3. Results are logged for monitoring and compliance

## 🔒 Security Features

- Non-root container execution
- Minimal attack surface with Alpine Linux
- Host monitoring without exposing credentials
- Atomic file operations for data integrity

## 📝 License

MIT License - Feel free to use and modify

## 👤 Author

vamsikrishnamunukuti0410