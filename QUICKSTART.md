# Quick Start Guide

This guide will help you get started with the DevContainer and Oracle Database in just a few minutes.

## Step 1: Open in VS Code

Open this repository in Visual Studio Code:
```bash
code .
```

## Step 2: Reopen in Container

1. VS Code will detect the `.devcontainer` folder
2. Click "Reopen in Container" when prompted
3. Or press `F1` and select "Dev Containers: Reopen in Container"

## Step 3: Wait for Setup

The first time you open the container:
- Docker will download the Oracle Database XE image (~2GB)
- The dev container will be built with Oracle Instant Client
- This takes about 5-10 minutes depending on your internet speed

Subsequent opens will be much faster (under 30 seconds).

## Step 4: Verify Oracle Database

Once inside the container, open a terminal and run:

```bash
./scripts/wait-for-oracle.sh
```

This script will wait for Oracle to be fully ready and display connection details.

## Step 5: Connect to Oracle

### Using SQL*Plus (Command Line)

```bash
sqlplus system/OraclePassword123@oracle-db:1521/XE
```

### Try the Sample Script

Run the included sample SQL script:

```bash
sqlplus system/OraclePassword123@oracle-db:1521/XEPDB1 @scripts/sample.sql
```

This will create a sample user, table, and data.

## Step 6: Start Developing!

You now have a fully functional Oracle database for development. Some ideas:

1. **Create your own schemas and tables**
2. **Practice SQL queries**
3. **Test PL/SQL procedures**
4. **Experiment with Oracle features**

## Common Tasks

### Execute a SQL file

```bash
sqlplus system/OraclePassword123@oracle-db:1521/XE @your-script.sql
```

### Check database status

```bash
echo "SELECT STATUS FROM V\$INSTANCE;" | sqlplus -S system/OraclePassword123@oracle-db:1521/XE
```

### Access Enterprise Manager

Open your browser to: http://localhost:5500/em
- Username: `system`
- Password: `OraclePassword123`

## Troubleshooting

### "Container fails to start"
- Ensure Docker Desktop has at least 4GB RAM allocated
- Check Docker Desktop is running

### "Oracle DB not responding"
- Wait 2-3 minutes after container start for Oracle to initialize
- Run `./scripts/wait-for-oracle.sh` to check status

### "Port already in use"
- Another service is using port 1521 or 5500
- Stop the conflicting service or change ports in `docker-compose.yml`

## Next Steps

- Read the full [README.md](README.md) for detailed documentation
- Explore Oracle Database features
- Customize the container for your needs

Happy coding! 🚀
