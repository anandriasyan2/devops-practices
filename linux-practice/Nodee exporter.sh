#!bin/bash

#Installing node_exporter

### for x64 arch (common server)
wget
https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz

#Extract the downloaded archive

tar -xf node_exporter-1.5.0.linux-amd64.tar.gz
Move the node_exporter binary to /usr/local/bin

 mv node_exporter-1.5.0.linux-amd64/node_exporter /usr/local/bin
#Remove the residual files with:

rm -r node_exporter-1.5.0.linux-amd64*
#Next,we will create users and service files for node_exporter.

 useradd -rs /bin/false node_exporter

#Since we have created a new unit file, we must reload the systemd daemon, set the service to always run at boot and start it :

 systemctl daemon-reload
 systemctl enable node_exporter
 systemctl start node_exporter
 systemctl status node_exporter
Configure UFW / Firewall Ubuntu :

 ufw allow from YOURPROMETHEUSSERVERIP to any port 9100
 ufw status numbered






