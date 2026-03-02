Sentinel-Ops: Containerized Cloud Monitoring Engine
Sentinel-Ops is a production-grade system observability suite deployed on AWS EC2. It utilizes a containerized agent to audit host-level health metrics, providing automated alerting and intelligent log management.

🚀 Key Features
Containerized Observability: Runs a hardened Alpine Linux agent using Docker, utilizing host PID namespace sharing for accurate system-wide monitoring.

Intelligent Alerting: Features a custom Bash engine (shield.sh) that performs single-pass regex extraction to identify system threats (CPU spikes, Disk exhaustion, Zombie processes).

Resource Efficiency: Implemented a "Zero-Waste" log rotation policy, preventing disk bloat on small cloud instances via atomic file truncation.

Security First: The agent runs as a non-root system user within the container to follow the principle of least privilege.

🛠️ Tech Stack
Cloud: AWS EC2 (t3.micro), Security Groups, UFW Firewall.

Containers: Docker, Alpine Linux (Multi-stage mindset).

Scripting: Advanced Bash (Grep, Awk, Sed, BC for float math).

Automation: Linux Crontab scheduling.

📂 Project Structure
Plaintext
sentinel-ops/
├── Dockerfile          # Hardened Alpine-based environment
├── doctor.sh           # The "Sensor" - Gathers raw system metrics
├── shield.sh           # The "Intelligence" - Parses logs & alerts
├── logs/               # Local directory for health & alert data
└── README.md           # Documentation

⚙️ Setup & Deployment
Build the Agent:
docker build -t sentinel-agent:v1.0 .

Run the Monitor (Manual Test):
docker run --rm --pid=host sentinel-agent:v1.0

Automate via Cron:
*/5 * * * * docker run --rm --pid=host sentinel-agent:v1.0 >> ~/sentinel-ops/logs/health.log 2>&1
