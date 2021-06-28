# bahmni-vagrant

Local setup with two machines

1 machine running bahmni app server
1 machine running bahmni db server.

# Notes

Why are we doing full install even on db server?
Because the dbs are created by application roles in ansible

Need to add vbguest plugin to mount folders on RHEL vagrant box 
`vagrant plugin install vagrant-vbguest`

Need to add CentOS repository to get python packages
https://unix.stackexchange.com/questions/433046/how-do-i-enable-centos-repositories-on-rhel-red-hat
Create a new repository centos.repo in /etc/yum.repos.d/ with the content
[centos]
name=CentOS-7
baseurl=http://ftp.heanet.ie/pub/centos/7/os/x86_64/
enabled=1
gpgcheck=1
gpgkey=http://ftp.heanet.ie/pub/centos/7/os/x86_64/RPM-GPG-KEY-CentOS-7
Then run yum repolist

Had to change postgres repo download url because the current one gived 404. 
After changing this also had to manually install python-psycopg2. It was failing otherwise. Installation proceeded smoothly after this.

### To see users on mysql
SELECT user, host FROM mysql.user;
### To see grants 
SHOW GRANTS FOR 'openmrs-user'@'localhost'

# Add commands given in below file manually to grant privileges for openmrs db and reporting db
bahmni-installer/bahmni-playbooks/roles/mysql-users/tasks/main.yml

# We may have to change the schema name in CHANGE_LOG_TABLE in below file
bahmni-installer/bahmni-playbooks/roles/implementation-config/files/run-implementation-openmrs-liquibase.sh

# Check pg_hba.conf
bahmni-lab-db may have to be run again with app server ips in bahmni-lab-db-client to correctly set pg_hba.conf