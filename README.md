# ProofLift Quick Setup

Quick setup script to clone all ProofLift repositories.

## Usage

### Windows (PowerShell)
```powershell
.\setup.ps1
```

### Linux/Mac (Bash)
```bash
chmod +x setup.sh
./setup.sh
```

## What it does

- Clones all ProofLift components from their respective branches
- Removes `.env*` and individual `docker-compose.yml*` files from cloned repositories
- Prepares the environment for Docker Compose deployment
