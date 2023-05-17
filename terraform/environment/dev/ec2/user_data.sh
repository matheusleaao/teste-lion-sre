#!/bin/bash
echo "Setup ubuntu"
sudo apt update -y
sudo apt install net-tools
sudo ifconfig eth0 mtu 1350
echo "installing snap"
sudo apt install snapd -y
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap

echo "Config amazon-ssm"
sudo snap install amazon-ssm-agent --classic
sudo snap start amazon-ssm-agent

echo "installing microk8s"
sudo snap install microk8s --classic

echo "Starting microk8s"
sudo microk8s start
sudo microk8s enable dns