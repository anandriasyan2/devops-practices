#!/bin/bash
systemctl stop prometheus
userdel -r prometheus
groupdel prometheus
apt-get purge prometheus
rm -rf /etc/prometheus/
rm -rf /var/lib/prometheus
rm /etc/systemd/system/prometheus.service
apt-get autoremove
apt-get autoclean
systemctl deamon-reload
