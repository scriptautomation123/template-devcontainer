# Architecture Overview

This document explains the architecture of the DevContainer template with Oracle Database.

## Components

```
┌─────────────────────────────────────────────────────────────┐
│                        VS Code                               │
│                    (Your Host Machine)                       │
└─────────────────────┬───────────────────────────────────────┘
                      │
                      │ Dev Containers Extension
                      │
┌─────────────────────▼───────────────────────────────────────┐
│                    Docker Host                               │
│                                                              │
│  ┌────────────────────────────────────────────────────┐    │
│  │         Development Container                       │    │
│  │  ┌──────────────────────────────────────────┐      │    │
│  │  │  - Ubuntu Base                           │      │    │
│  │  │  - Oracle Instant Client                 │      │    │
│  │  │  - SQL*Plus                              │      │    │
│  │  │  - Development Tools                     │      │    │
│  │  │  - Your workspace mounted at /workspace  │      │    │
│  │  └──────────────────────────────────────────┘      │    │
│  │                                                      │    │
│  │  Network: Shared with oracle-db container          │    │
│  └──────────────────────┬───────────────────────────────┘    │
│                         │                                    │
│                         │ network_mode: service:oracle-db   │
│                         │                                    │
│  ┌──────────────────────▼───────────────────────────────┐   │
│  │         Oracle Database Container                    │   │
│  │  ┌──────────────────────────────────────────┐        │   │
│  │  │  Oracle Database XE 21.3.0              │        │   │
│  │  │  - Port 1521 (Database)                 │        │   │
│  │  │  - Port 5500 (Enterprise Manager)       │        │   │
│  │  │  - Persistent volume: oracle-data       │        │   │
│  │  └──────────────────────────────────────────┘        │   │
│  └──────────────────────────────────────────────────────┘   │
│                         │                                    │
│                         │                                    │
│  ┌──────────────────────▼───────────────────────────────┐   │
│  │         Docker Volume                                 │   │
│  │         oracle-data                                   │   │
│  │  (Persists database files across restarts)           │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                              │
└──────────────────────────────────────────────────────────────┘
                         │
                         │ Port Forwarding
                         │
              ┌──────────┴──────────┐
              │                     │
        localhost:1521        localhost:5500
     (Database Access)    (Enterprise Manager)
```

## How It Works

### 1. Container Startup

When you open the project in VS Code and select "Reopen in Container":

1. **Docker Compose** reads `.devcontainer/docker-compose.yml`
2. **Oracle DB Container** starts first with the official Oracle XE image
3. **Dev Container** builds from the Dockerfile and starts
4. The dev container shares the network with Oracle DB container
5. VS Code connects to the dev container

### 2. Network Configuration

The development container uses `network_mode: service:oracle-db`, which means:

- Both containers share the same network namespace
- The dev container can access Oracle DB via `localhost` or `oracle-db`
- Ports exposed by Oracle DB (1521, 5500) are accessible from the dev container

### 3. Data Persistence

- Oracle database files are stored in a Docker volume named `oracle-data`
- Data persists even when containers are stopped or rebuilt
- To reset the database, remove the volume: `docker volume rm template-devcontainer_oracle-data`

### 4. Development Workflow

```
Developer → VS Code → Dev Container → Oracle DB
                ↓
         Workspace Files
    (/workspace in container)
```

## Connection Details

### From Inside Dev Container

```bash
# Direct connection
sqlplus system/OraclePassword123@oracle-db:1521/XE

# Or using localhost
sqlplus system/OraclePassword123@localhost:1521/XE
```

### From Host Machine

```bash
# Through forwarded ports
sqlplus system/OraclePassword123@localhost:1521/XE
```

### From External Tools

Configure your database tool with:
- **Host**: `localhost`
- **Port**: `1521`
- **Service**: `XE` or `XEPDB1`
- **Username**: `system`
- **Password**: `OraclePassword123`

## File Locations

### In Dev Container

- **Workspace**: `/workspace` (your project files)
- **Oracle Client**: `/usr/lib/oracle/21/client64/`
- **Scripts**: `/workspace/scripts/`

### In Oracle Container

- **Database Files**: `/opt/oracle/oradata` (mounted to docker volume)
- **Config Files**: `/opt/oracle/product/21c/dbhomeXE/`

## Resource Requirements

- **Minimum RAM**: 4GB (2GB for Oracle, 2GB for dev container)
- **Recommended RAM**: 8GB or more
- **Disk Space**: ~10GB for images and volumes
- **CPU**: 2+ cores recommended

## Security Considerations

⚠️ **Important**: This template is designed for **development purposes only**.

- Default password is hardcoded (change it for production)
- No SSL/TLS configuration
- No advanced security features enabled
- Ports are exposed to localhost

For production use, implement:
- Strong, unique passwords
- SSL/TLS encryption
- Network isolation
- Proper access controls
- Regular backups

## Customization Points

1. **devcontainer.json**: VS Code settings, extensions, features
2. **Dockerfile**: Additional tools, languages, configurations
3. **docker-compose.yml**: Service settings, ports, environment variables
4. **scripts/**: Custom initialization or helper scripts
