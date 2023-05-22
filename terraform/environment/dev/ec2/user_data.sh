#!/bin/bash
echo "Setup ubuntu"
apt update -y
apt install net-tools
ifconfig eth0 mtu 1350
echo "installing snap"
apt install snapd -y
systemctl enable --now snapd.socket
ln -s /var/lib/snapd/snap /snap
curl -fsSl https://get.docker.com/ | sh
groupadd docker
usermod -aG docker ubuntu
newgrp docker

echo "Config amazon-ssm"
snap install amazon-ssm-agent --classic
snap start amazon-ssm-agent

echo "installing microk8s"
snap install microk8s --classic

echo "Starting microk8s"
microk8s status --wait-ready
microk8s enable dns
usermod -a -G microk8s ubuntu
chown -R ubuntu ~/.kube
newgrp microk8s

# Create a folder
su ubuntu -c '
    whoami
    cd /tmp
    mkdir actions-runner && cd actions-runner
    curl -o actions-runner-linux-x64-2.304.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.304.0/actions-runner-linux-x64-2.304.0.tar.gz
    echo "292e8770bdeafca135c2c06cd5426f9dda49a775568f45fcc25cc2b576afc12f  actions-runner-linux-x64-2.304.0.tar.gz" | shasum -a 256 -c
    tar xzf ./actions-runner-linux-x64-2.304.0.tar.gz
    ./config.sh --url https://github.com/matheusleaao/teste-lion-sre --token AK6AAEKZXHUBZZSQAIOEL4LEMT2TK
    nohup ./run.sh  &
'
#o token muda, precisa ser configurado manualmente