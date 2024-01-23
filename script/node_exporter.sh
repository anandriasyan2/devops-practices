#!/bin/bash

#--------------------------------------How to Install and Configure Node Exporter on the Client--------------------------------------
#1. Consult the Node Exporter section of the Prometheus downloads page and determine the latest release.
#2. Use wget to download this release. The format for the file is https://github.com/prometheus/node_exporter/releases/download/v[release_num]/node_exporter-[release_num].linux-amd64.tar.gz. Replace [release_num] with the number corresponding to the actual release. For example, the following example demonstrates how to download Node Exporter release 1.5.0.

wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz
#3. Extract the application.

tar xvfz node_exporter-*.tar.gz
#4. Move the executable to usr/local/bin so it is accessible throughout the system.

sudo mv node_exporter-1.5.0.linux-amd64/node_exporter /usr/local/bin
#5. (Optional) Remove any remaining files.

rm -r node_exporter-1.5.0.linux-amd64*
#6. There are two ways of running Node Exporter. It can be launched from the terminal using the command node_exporter. Or, it can be activated as a system service. Running it from the terminal is less convenient. But this might not be a problem if the tool is only intended for occasional use. To run Node Exporter manually, use the following command. The terminal outputs details regarding the statistics collection process.

node_exporter
#7. It is more convenient to run Node Exporter as a service. To run Node Exporter this way, first, create a node_exporter user.

sudo useradd -rs /bin/false node_exporter
#8. Create a service file for systemctl to use. The file must be named node_exporter.service and should have the following format. Most of the fields are similar to those found in prometheus.service, as described in the previous section.

sudo mv node_exporter /etc/systemd/system/

#Description=Node Exporter Wants=network-online.target After=network-online.target

#[Service] User=node_exporter Group=node_exporter Type=simple Restart=on-failure RestartSec=5s ExecStart=/usr/local/bin/node_exporter

#[Install] WantedBy=multi-user.target
#9. (Optional) If you intend to monitor the client on an ongoing basis, use the systemctl enable command to automatically launch Node Exporter at boot time. This continually exposes the system metrics on port 9100. If Node Exporter is only intended for occasional use, do not use the command below.

sudo systemctl enable node_exporter

#10. Reload the systemctl daemon, start Node Exporter, and verify its status. The service should be active.

sudo systemctl daemon-reload sudo systemctl start node_exporter sudo systemctl status node_exporter

#Use a web browser to visit port 9100 on the client node, for example, http://local_ip_addr:9100. A page entitled Node Exporter is displayed along with a link reading Metrics. Click the Metrics link and confirm the statistics are being collected. For a detailed explanation of the various statistics, see the Node Exporter Documentation.

#--------------------------------------How to Configure Prometheus to Monitor Client Nodes-------------------------------------- #The client nodes are now ready for monitoring. To add clients to prometheus.yml, follow the steps below:
