# Disclaimer
This repo has been built and only tested on _my_ M1 Max for this class. USE AT YOUR OWN RISK.

## macOS
A Docker container has been published to Dockerhub `cy1337demos/bughuntenv` but for Apple Silicon use the docker compose! 

**Easy Option**: Use Docker Compose (recommended):
```bash
git clone https://github.com/AndrewMohawk/BugHuntEnv-AppleSilicon.git
cd BugHuntEnv
docker-compose up -d
docker-compose exec bughunt-env bash
```

See [DOCKER_USAGE.md](DOCKER_USAGE.md) for detailed Docker instructions.

**✅ Apple Silicon (M1/M2) Supported**: The Docker Compose setup now works on Apple Silicon Macs with proper x86_64 emulation and library configuration.
