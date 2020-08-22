#!/bin/bash
git pull
sudo sed -i.bak -r '/swap/d' /etc/fstab

sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y containerd kubectl kubelet kubeadm haproxy apache2-utils
sudo apt-mark hold kubelet kubeadm kubectl
sudo cp node-config/containerd.conf /etc/modules-load.d/containerd.conf
sudo cp node-config/k8s.conf /etc/sysctl.d/k8s.conf 
sudo cp node-config/haproxy.cfg /etc/haproxy/haproxy.cfg
sudo cp node-config/losetup.service /etc/systemd/system/losetup.service
sudo cp node-config/sys-fs-bpf.mount /etc/systemd/system/sys-fs-bpf.mount
sudo fallocate -l 50G /loop0.img
sudo chmod 600 /loop0.img
sud systemctl enable losetup.service



sudo reboot
