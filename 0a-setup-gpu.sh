#!/bin/bash
git pull
sudo sed -i.bak -r '/swap/d' /etc/fstab

sudo apt-get update && sudo apt-get install -y apt-transport-https curl ubuntu-drivers-common
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo ubuntu-drivers autoinstall
curl -s -L https://nvidia.github.io/nvidia-container-runtime/gpgkey | sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-container-runtime/$distribution/nvidia-container-runtime.list | sudo tee /etc/apt/sources.list.d/nvidia-container-runtime.list
sudo apt-get update
sudo apt-get install nvidia-docker2 -y
sudo cp node-config/containerd_gpu.toml /etc/containerd/config.toml




sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y kubectl kubelet kubeadm haproxy apache2-utils
sudo apt-mark hold kubelet kubeadm kubectl
sudo cp node-config/containerd.conf /etc/modules-load.d/containerd.conf
sudo cp node-config/k8s.conf /etc/sysctl.d/k8s.conf 
sudo cp node-config/haproxy.cfg /etc/haproxy/haproxy.cfg
sudo cp node-config/sys-fs-bpf.mount /etc/systemd/system/sys-fs-bpf.mount
sudo reboot
