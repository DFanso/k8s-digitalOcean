#!/bin/bash
#
# Common setup for all servers (Control Plane and Nodes)

set -euxo pipefail

# Kuernetes Variable Declaration

KUBERNETES_VERSION="1.30"

# disable swap
sudo swapoff -a

# keeps the swaf off during reboot
(crontab -l 2>/dev/null; echo "@reboot /sbin/swapoff -a") | crontab - || true
sudo apt-get update -y
sudo apt-get install -y software-properties-common curl
sudo add-apt-repository -y ppa:projectatomic/ppa

# Install CRI-O Runtime

OS="xUbuntu_$(lsb_release -r | awk '{print $2}')"

VERSION="1.30"

# Create the .conf file to load the modules at bootup
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter
sysctl -w net.ipv4.ip_forward=1

# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system

echo 'deb [signed-by=/usr/share/keyrings/libcontainers-archive-keyring.gpg] https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/ /' | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
echo 'deb [signed-by=/usr/share/keyrings/libcontainers-crio-$VERSION-archive-keyring.gpg] https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:/cri-o:/$VERSION/$OS/ /' | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:$VERSION.list

sudo mkdir -p /usr/share/keyrings
curl -fsSL https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:/cri-o:/$VERSION/$OS/Release.key | sudo tee /usr/share/keyrings/libcontainers-crio-$VERSION-archive-keyring.gpg > /dev/null
curl -fsSL https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/$OS/Release.key | sudo tee /usr/share/keyrings/libcontainers-archive-keyring.gpg > /dev/null

sudo apt-get update
sudo apt-get install cri-o cri-o-runc -y

sudo systemctl daemon-reload
sudo systemctl enable crio --now
sudo systemctl start crio

sudo systemctl status crio

echo "CRI runtime installed susccessfully"

# Install kubelet, kubectl and Kubeadm

sudo apt-get update -y
sudo apt-get install -y apt-transport-https ca-certificates curl gpg

sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/$KUBERNETES_VERSION/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/$KUBERNETES_VERSION/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update -y
sudo apt-get install -y kubelet="$KUBERNETES_VERSION" kubectl="$KUBERNETES_VERSION" kubeadm="$KUBERNETES_VERSION"
sudo apt-get update -y
sudo apt-mark hold kubelet kubeadm kubectl

sudo apt-get install -y jq

local_ip="$(ip --json addr show eth0 | jq -r '.[0].addr_info[] | select(.family == "inet") | .local')"
cat > /etc/default/kubelet << EOF
KUBELET_EXTRA_ARGS=--node-ip=$local_ip
EOF
