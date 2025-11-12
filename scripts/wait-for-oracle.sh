#!/bin/bash

# Script to check Oracle DB connectivity and wait for it to be ready

echo "Waiting for Oracle Database to be ready..."

MAX_TRIES=30
COUNT=0

until echo "SELECT 1 FROM DUAL;" | sqlplus -S system/OraclePassword123@oracle-db:1521/XE > /dev/null 2>&1; do
    COUNT=$((COUNT + 1))
    if [ $COUNT -ge $MAX_TRIES ]; then
        echo "Error: Oracle Database did not become ready in time"
        exit 1
    fi
    echo "Waiting for Oracle DB... (attempt $COUNT/$MAX_TRIES)"
    sleep 5
done

echo "Oracle Database is ready!"
echo ""
echo "Connection details:"
echo "  Host: oracle-db"
echo "  Port: 1521"
echo "  Service: XE"
echo "  Username: system"
echo "  Password: OraclePassword123"
echo ""
echo "Connect using: sqlplus system/OraclePassword123@oracle-db:1521/XE"
