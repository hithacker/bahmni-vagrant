#!/bin/sh
set -e -x
. /etc/bahmni-installer/bahmni.conf

CHANGE_LOG_TABLE="-Dliquibase.databaseChangeLogTableName=databasechangelog -Dliquibase.databaseChangeLogLockTableName=databasechangeloglock"
LIQUIBASE_JAR="/opt/bahmni-lab/migrations/liquibase/lib/liquibase-1.9.5.jar"
DRIVER="org.postgresql.Driver"
CHANGE_LOG_FILE="liquibase.xml"
CLASSPATH=`ls /opt/bahmni-lab/bahmni-lab/WEB-INF/lib/postgresql*.jar`

if [  -f "/var/www/bahmni_config/openelis/migrations/$CHANGE_LOG_FILE" ]; then
cd /var/www/bahmni_config/openelis/migrations
java $CHANGE_LOG_TABLE -jar $LIQUIBASE_JAR --classpath=$CLASSPATH --driver=$DRIVER --changeLogFile=$CHANGE_LOG_FILE --defaultSchemaName=clinlims --url=jdbc:postgresql://$OPENELIS_DB_SERVER:5432/$OPENELIS_DB_NAME --username=$OPENELIS_DB_USERNAME --password=$OPENELIS_DB_PASSWORD update
cd -
else
echo "File not found: '/var/www/bahmni_config/openelis/migrations/$CHANGE_LOG_FILE'"
fi
