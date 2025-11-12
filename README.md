# DevContainer Template with Oracle Database

This repository provides a DevContainer template that launches a development container with an Oracle Database (XE) instance.

## Features

- 🐳 Docker-based development environment
- 🗄️ Oracle Database Express Edition (XE) 21.3.0
- 🛠️ Oracle Instant Client and SQL*Plus pre-installed
- 📦 VS Code DevContainer integration
- 🔧 Common development utilities

## Prerequisites

- [Docker](https://www.docker.com/get-started) installed and running
- [Visual Studio Code](https://code.visualstudio.com/) with the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- At least 8GB of RAM available for Docker
- At least 10GB of free disk space

## Getting Started

1. **Clone this repository:**
   ```bash
   git clone https://github.com/scriptautomation123/template-devcontainer.git
   cd template-devcontainer
   ```

2. **Open in VS Code:**
   ```bash
   code .
   ```

3. **Reopen in Container:**
   - When prompted, click "Reopen in Container"
   - Or use the Command Palette (F1) and select "Dev Containers: Reopen in Container"

4. **Wait for the container to build:**
   - The first time will take several minutes as it downloads Oracle Database XE and builds the containers
   - Subsequent starts will be much faster

## Oracle Database Connection Details

Once the DevContainer is running, you can connect to the Oracle database using these credentials:

- **Hostname:** `oracle-db` (from within the dev container) or `localhost` (from your host machine)
- **Port:** `1521`
- **Service Name:** `XE`
- **SID:** `XE`
- **Username:** `system`
- **Password:** `OraclePassword123`
- **PDB:** `XEPDB1`

### Connecting from within the DevContainer

You can use SQL*Plus from the terminal:

```bash
sqlplus system/OraclePassword123@oracle-db:1521/XE
```

Or connect to the pluggable database:

```bash
sqlplus system/OraclePassword123@oracle-db:1521/XEPDB1
```

### Enterprise Manager Express

Oracle Enterprise Manager Express is also available at:
- **URL:** http://localhost:5500/em
- **Username:** `system`
- **Password:** `OraclePassword123`
- **Container Name:** `XE` or `XEPDB1`

## Directory Structure

```
.
├── .devcontainer/
│   ├── devcontainer.json    # DevContainer configuration
│   ├── docker-compose.yml   # Multi-container setup
│   └── Dockerfile          # Development container image
└── README.md               # This file
```

## Customization

### Changing the Oracle Password

Edit `.devcontainer/docker-compose.yml` and modify the `ORACLE_PWD` environment variable:

```yaml
environment:
  ORACLE_PWD: YourNewPassword
```

### Adding Additional Tools

Edit `.devcontainer/Dockerfile` to install additional tools:

```dockerfile
RUN apt-get update && apt-get install -y \
    your-package-here \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*
```

### Adding VS Code Extensions

Edit `.devcontainer/devcontainer.json` under `customizations.vscode.extensions`:

```json
"extensions": [
  "oracle.oracledevtools",
  "your-extension-id"
]
```

## Troubleshooting

### Oracle Database not starting

1. Check Docker has enough resources (minimum 2GB RAM, 4GB recommended)
2. Check the Oracle container logs:
   ```bash
   docker logs <oracle-container-id>
   ```
3. The database takes 1-2 minutes to fully start on first launch

### Connection refused

Wait for the healthcheck to pass. You can check with:
```bash
docker ps
```
Look for "healthy" status on the oracle-db container.

### Port already in use

If port 1521 or 5500 is already in use, modify the port mappings in `.devcontainer/docker-compose.yml`:

```yaml
ports:
  - "1522:1521"  # Change 1521 to 1522 (or any available port)
  - "5501:5500"  # Change 5500 to 5501 (or any available port)
```

## Data Persistence

Oracle database data is persisted in a Docker volume named `oracle-data`. This means your database will retain its state between container restarts.

To completely reset the database, remove the volume:

```bash
docker volume rm template-devcontainer_oracle-data
```

## License

This template is provided as-is for development purposes.

## Resources

- [Oracle Database Express Edition](https://www.oracle.com/database/technologies/appdev/xe.html)
- [VS Code Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers)
- [Oracle Instant Client](https://www.oracle.com/database/technologies/instant-client.html)