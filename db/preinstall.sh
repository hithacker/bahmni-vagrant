cp centos.repo /etc/yum.repos.d
yum install -y python-psycopg2
yum install -y https://kojipkgs.fedoraproject.org//packages/zlib/1.2.11/19.fc30/x86_64/zlib-1.2.11-19.fc30.x86_64.rpm
sudo yum install -y epel-release
sudo yum install -y python-pip
sudo pip install pip==v19.0
sudo pip uninstall click
sudo pip install click==v7.0
sudo pip install pyusb
sudo pip install babel==v0.9.6
sudo pip install decorator==v3.4.0
sudo pip install beautifulsoup4
sudo yum install -y http://repo.mybahmni.org/releases/bahmni-installer-0.92-155.noarch.rpm
