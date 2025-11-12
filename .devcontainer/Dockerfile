FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Install Oracle Instant Client and SQL*Plus
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    wget \
    unzip \
    libaio1 \
    alien \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Download and install Oracle Instant Client
WORKDIR /tmp
RUN wget https://download.oracle.com/otn_software/linux/instantclient/2115000/oracle-instantclient-basic-21.15.0.0.0-1.el8.x86_64.rpm \
    && wget https://download.oracle.com/otn_software/linux/instantclient/2115000/oracle-instantclient-sqlplus-21.15.0.0.0-1.el8.x86_64.rpm \
    && alien -i oracle-instantclient-basic-21.15.0.0.0-1.el8.x86_64.rpm \
    && alien -i oracle-instantclient-sqlplus-21.15.0.0.0-1.el8.x86_64.rpm \
    && rm -f oracle-instantclient*.rpm

# Set Oracle environment variables
ENV LD_LIBRARY_PATH=/usr/lib/oracle/21/client64/lib:$LD_LIBRARY_PATH
ENV PATH=/usr/lib/oracle/21/client64/bin:$PATH

WORKDIR /workspace
