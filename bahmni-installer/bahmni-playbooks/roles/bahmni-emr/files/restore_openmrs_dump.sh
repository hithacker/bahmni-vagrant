#!/bin/sh
set -e -x
. /etc/bahmni-installer/bahmni.conf

RESULT=`mysql -h $OPENMRS_DB_SERVER -u$MYSQL_ROOT_USER -p$MYSQL_ROOT_PASSWORD --skip-column-names -e "SHOW DATABASES LIKE '$OPENMRS_DB_NAME'"`
if [ "$RESULT" != "$OPENMRS_DB_NAME" ] ; then
    echo "$OPENMRS_DB_NAME database not found... Restoring a base dump"
    mysql -h $OPENMRS_DB_SERVER -u$MYSQL_ROOT_USER -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE $OPENMRS_DB_NAME;"
    mysql -h $OPENMRS_DB_SERVER -u$MYSQL_ROOT_USER -p$MYSQL_ROOT_PASSWORD $OPENMRS_DB_NAME < '/etc/bahmni-installer/deployment-artifacts/openmrs_backup.sql'
fi

