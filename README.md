# Sentinel-Ops: Containerized Cloud Monitoring

A production-grade system health audit engine built for AWS EC2. 

## Key Features
- **Dockerized Agent:** Uses Alpine Linux and multi-stage builds for a small, secure footprint.
- **System Intelligence:** Bash-based health auditing (CPU, Disk, Zombies) with `bc` for floating-point math.
- **Log Shield:** Optimized single-pass log analysis with automated rotation and alerting.
- **Automation:** Fully scheduled via Crontab for 24/7 observability.

## Technologies Used
- **Cloud:** AWS EC2, IAM, Security Groups
- **DevOps:** Docker, Linux (Ubuntu/Alpine)
- **Scripting:** Bash (Grep, Awk, Sed)
- **Security:** UFW, Non-root container users
