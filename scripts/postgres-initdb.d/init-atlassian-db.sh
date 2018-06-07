#!/bin/bash

POSTGRES_USER=postgres
POSTGRES_DB=postgres
SETUP_FILE=/var/lib/postgresql/data/.setup_lock

if [ ! -f "${SETUP_FILE}" ] ; then
  echo "################################## Setup postgres"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER jira WITH LOGIN PASSWORD 'makerjellyfish' VALID UNTIL 'infinity';
    CREATE DATABASE jiradb;
    GRANT ALL PRIVILEGES ON DATABASE jiradb TO jira;
    CREATE USER wiki WITH LOGIN PASSWORD 'makerjellyfish' VALID UNTIL 'infinity';
    CREATE DATABASE wikidb;
    GRANT ALL PRIVILEGES ON DATABASE wikidb TO wiki;
EOSQL
  
fi

touch ${SETUP_FILE}