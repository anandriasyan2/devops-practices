#!bin/bash

#install Prometheus on Ubuntu

#1. Update System Packages

 apt update

#2. Create a System User for Prometheus

 groupadd --system prometheus
 useradd -s /sbin/nologin --system -g prometheus prometheus

#3. Create Directories for Prometheus

 mkdir /etc/prometheus
 mkdir /var/lib/prometheus

#4. Download Prometheus and Extract Files

wget https://github.com/prometheus/prometheus/releases/download/v2.43.0/prometheus-2.43.0.linux-amd64.tar.gz

#After the download has been completed, run the following command to extract the contents of the downloaded file:

tar vxf prometheus*.tar.gz

#5. Navigate to the Prometheus Directory

cd prometheus*/

#The next step 

mv prometheus /usr/local/bin
 mv promtool /usr/local/bin
 chown prometheus:prometheus /usr/local/bin/prometheus
 chown prometheus:prometheus /usr/local/bin/promtool

#then Move the Configuration Files & Set Owner

 mv consoles /etc/prometheus
 mv console_libraries /etc/prometheus
 mv prometheus.yml /etc/prometheus
 chown prometheus:prometheus /etc/prometheus
 chown -R prometheus:prometheus /etc/prometheus/consoles
 chown -R prometheus:prometheus /etc/prometheus/console_libraries
 chown -R prometheus:prometheus /var/lib/prometheus

 nano /etc/prometheus/prometheus.yml


#Reload Systemd
 systemctl daemon-reload

#Start Prometheus Service

 systemctl enable prometheus
 systemctl start prometheus

#Check Prometheus Status

 systemctl status prometheus

#Access Prometheus Web Interface
 ufw allow 9090/tcp

