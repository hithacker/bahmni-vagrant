# Purpose
To show the concept of running Bahmni app servers on different machine and dbs on a different machine.

This is a vagrant setup with two machines

1 machine running bahmni app server 10.0.0.10

1 machine running bahmni db server 10.0.0.11.

## Notes
Why are we doing full install even on db server?
Because the dbs are created by application roles in ansible. Application RPMs are the once creating the db currently.

Need to add CentOS repository to get python packages
Copy centos.repo file from this repo to /etc/yum.repos.d

Had to change postgres repo download url because the current one gived 404. 
After changing this also had to manually install python-psycopg2. It was failing otherwise. Installation proceeded smoothly after this.
So install this before installing bahmni. Use `yum install -y python-psycopg2`

### To see users on mysql
SELECT user, host FROM mysql.user;
### To see grants 
SHOW GRANTS FOR 'openmrs-user'@'localhost'

# Things to do before running our modified setup on db
Stop all the services.

Change OPENMRS_DB_NAME, REPORTS_DB_NAME, OPENELIS_DB_NAME in /etc/bahmni-installer/bahmni.conf file to be of our new server

We may have to change the schema name(schema name and db name are same in mysql) in CHANGE_LOG_TABLE in bahmni-installer/bahmni-playbooks/roles/implementation-config/files/run-implementation-openmrs-liquibase.sh
Modify openelis dump file(/opt/bahmni-lab/db-dump/openelis_demo_dump.sql) to use new db name e.g. clinlims2

# To run our new setup
Go to home folder and clone https://github.com/bahmni-bihar/bahmni-package
Run the following shell scripts one by one 
```
bahmni-emr/resources/runDBFunctions.sh
bahmni-reports/resources/runDBFunctions.sh
bahmni-lab/scripts/runDBFunctions.sh
```

# Things to do after setup in db server
Give postgres access to app server in db server
Add following lines in /var/lib/pgsql/9.6/data/pg_hba.conf
```
host all postgres 10.0.0.10/32 trust
host clinlims clinlims 10.0.0.10/32 trust
```

Give mysql access to app server in db server
Login to mysql as root user and execute following commands 
```
GRANT ALL PRIVILEGES ON openmrs.* TO 'openmrs-user'@'10.0.0.10' identified by 'P@ssw0rd';

GRANT ALL PRIVILEGES ON bahmni_reports.* TO 'reports-user'@'10.0.0.10' identified by 'P@ssw0rd';
```

Point to db server ip and db name in application server
```
/opt/bahmni-lab/bahmni-lab/WEB-INF/classes/us/mn/state/health/lims/hibernate/hibernate.cfg.xml

/opt/openmrs/etc/openmrs-runtime.properties

/opt/bahmi-reports/etc/bahmni-reports.properties
```