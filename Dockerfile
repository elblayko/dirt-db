FROM mcr.microsoft.com/mssql/server:2022-latest

ENV ACCEPT_EULA 'Y'

## Reference: https://learn.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-ver16
#
RUN \
  if ! [[ "18.04 20.04 22.04" == *"$(lsb_release -rs)"* ]]; then \
    echo "Ubuntu $(lsb_release -rs) is not currently supported."; exit; \
  fi

USER root

RUN \
  apt-get update && apt-get install -y gnupg && \
  wget -q --output-document - https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
  wget -q --output-document - https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list > /etc/apt/sources.list.d/mssql-release.list

RUN apt-get install -y msodbcsql18

USER mssql
