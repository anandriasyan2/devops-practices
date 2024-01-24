#!/bin/bash


# 1.Install the prerequisite packages:

apt-get install -y apt-transport-https software-properties-common wget

# 2.Import the GPG key:
 mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null

# 3.To add a repository for stable releases, run the following command:

echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" |  tee -a /etc/apt/sources.list.d/grafana.list


# 4.To add a repository for beta releases, run the following command:

echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com beta main" |  tee -a /etc/apt/sources.list.d/grafana.list

# 5.Run the following command to update the list of available packages:
# Updates the list of available packages

 apt-get update

# 6.To install Grafana OSS, run the following command:

# Installs the latest OSS release:
 apt-get install grafana

# 7.To install Grafana Enterprise, run the following command:
# Installs the latest Enterprise release:

 apt-get install grafana-enterprise


#Start the Grafana server with systemd

# 1.To start the service, run the following commands:

 systemctl daemon-reload
 systemctl start grafana-server
 systemctl status grafana-server


#2.To verify that the service is running, run the following command:

 systemctl status grafana-server

#Configure the Grafana server to start at boot using systemd
#To configure the Grafana server to start at boot, run the following command:

 systemctl enable grafana-server.service

# Restart the Grafana server using systemd
# To restart the Grafana server, run the following commands:

 systemctl restart grafana-server
