#!/bin/bash 

#--------------------------------------How to Install and Configure Prometheus, Grafana, and Node Exporter-------------------------------------- #In these instructions, the system hosting the Prometheus server is referred to as the “monitoring server”. The system being monitored is a “client”. It is possible to develop very complicated custom exporters and dashboards using Prometheus and Grafana. However, this guide describes a more straightforward solution for monitoring the most critical client details, including CPU, memory, and I/O usage. It does not require any knowledge of PromQL or any low-level details for either Prometheus or Grafana.

#To configure the end-to-end solution, the following steps are required.

#Download and install Prometheus on the monitoring system. #Configure Prometheus to run as a service. #Install Node Exporter on all clients. #Configure Prometheus to monitor the clients. #Install and deploy the Grafana server. #Integrate Grafana and Prometheus. #Import a Dashboard for the Node Exporter Statistics. #This guide is designed for Ubuntu 22.04 LTS users but is generally applicable to the most recent Ubuntu releases.

#--------------------------------------How to Install and Configure Node Exporter on the Client--------------------------------------
#1. Use wget to download Prometheus to the monitoring server. The target link has the format https://github.com/prometheus/prometheus/releases/download/v[release]/prometheus-[release].linux-amd64.tar.gz. Replace the string [release] with the actual release to download. For example, the following command downloads release 2.37.6.

wget https://github.com/prometheus/prometheus/releases/download/v2.37.6/prometheus-2.37.6.linux-amd64.tar.gz
#2. Extract the archived Prometheus files.

tar xvfz prometheus-*.tar.gz
#3. (Optional) After the files have been extracted, delete the archive or move it to a different location for storage.

rm prometheus-*.tar.gz
#4. Create two new directories for Prometheus to use. The /etc/prometheus directory stores the Prometheus configuration files. The /var/lib/prometheus directory holds application data.

sudo mkdir /etc/prometheus /var/lib/prometheus
#5. Move into the main directory of the extracted prometheus folder. Substitute the name of the actual directory in place of prometheus-2.37.6.linux-amd64.

cd prometheus-2.37.6.linux-amd64
#6. Move the prometheus and promtool directories to the /usr/local/bin/ directory. This makes Prometheus accessible to all users.

sudo mv prometheus promtool /usr/local/bin/
#7. Move the prometheus.yml YAML configuration file to the /etc/prometheus directory.

sudo mv prometheus.yml /etc/prometheus/prometheus.yml
#8. The consoles and console_libraries directories contain the resources necessary to create customized consoles. This feature is more advanced and is not covered in this guide. However, these files should also be moved to the etc/prometheus directory in case they are ever required.

sudo mv consoles/ console_libraries/ /etc/prometheus/
#9. Verify that Prometheus is successfully installed using the below command:

prometheus --version

#--------------------------------------How to Configure Prometheus as a Service--------------------------------------
#1. Create a prometheus user. The following command creates a system user.

sudo useradd -rs /bin/false prometheus
#2. Assign ownership of the two directories created in the previous section to the new prometheus user.

sudo chown -R prometheus: /etc/prometheus /var/lib/prometheus
#3. To allow Prometheus to run as a service, create a prometheus.service file using the following command:

sudo mv prometheus.service /etc/systemd/system/
#Enter the following content into the file:

sudo systemctl daemon-reload
#5. (Optional) Use systemctl enable to configure the prometheus service to automatically start when the system boots. If this command is not added, Prometheus must be launched manually.

sudo systemctl enable prometheus
#6. Start the prometheus service and review the status command to ensure it is active.

sudo systemctl start prometheus sudo systemctl status prometheus
#7. Access the Prometheus web interface and dashboard at http://local_ip_addr:9090. Replace local_ip_addr with the address of the monitoring server. Because Prometheus is using the default configuration file, it does not display much information yet.
#8. The default prometheus.yml file contains a directive to scrape the local host. Click Status and Targets to list all the targets. Prometheus should display the local Prometheus service as the only target.

#--------------------------------------How to Install and Configure Node Exporter on the Client--------------------------------------
#1. Consult the Node Exporter section of the Prometheus downloads page and determine the latest release.
#2. Use wget to download this release. The format for the file is https://github.com/prometheus/node_exporter/releases/download/v[release_num]/node_exporter-[release_num].linux-amd64.tar.gz. Replace [relea
