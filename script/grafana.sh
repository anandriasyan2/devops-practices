#!/bin/bash

#--------------------------------------How to Install and Deploy the Grafana Server--------------------------------------
#Prometheus is now collecting statistics from the clients listed in the scrape_configs section of its configuration file. However, the information can only be viewed as a raw data dump. The statistics are difficult to read and not too useful.

#Grafana provides an interface for viewing the statistics collected by Prometheus. Install Grafana on the same server running Prometheus and add Prometheus as a data source. Then install one or more panels for interpreting the data. To install and configure Grafana, follow these steps.
#1. Install some required utilities using apt.

sudo apt-get install -y apt-transport-https software-properties-common
#2. Import the Grafana GPG key.

sudo wget -q -O /usr/share/keyrings/grafana.key https://apt.grafana.com/gpg.key
#3. Add the Grafana “stable releases” repository.

echo "deb [signed-by=/usr/share/keyrings/grafana.key] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
#4. Update the packages in the repository, including the new Grafana package.

sudo apt-get update
#5. Install the open-source version of Grafana.
#Note
#To install the Enterprise edition of Grafana, use the command sudo apt-get install grafana-enterprise instead.

sudo apt-get install grafana
#6. Reload the systemctl daemon.

sudo systemctl daemon-reload
#7. Enable and start the Grafana server. Using systemctl enable configures the server to launch Grafana when the system boots.

sudo systemctl enable grafana-server.service sudo systemctl start grafana-server
#8. Verify the status of the Grafana server and ensure it is in the active state.

sudo systemctl status grafana-server

#grafana-server.service - Grafana instance Loaded: loaded (/lib/systemd/system/grafana-server.service; enabled; vendor preset: enabled) Active: active (running) since Tue 2023-04-11 17:31:53 UTC; 9s ago

#--------------------------------------How to Integrate Grafana and Prometheus-------------------------------------- #All system components are now installed, but Grafana and Prometheus are not set up to interact. The remaining configuration tasks, including adding Prometheus as the data source and importing a dashboard panel, can be accomplished using the Grafana web interface.

#To integrate Grafana and Prometheus, follow the steps below:


