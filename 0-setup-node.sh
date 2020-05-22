#!/bin/bash
git pull
sudo sed -i.bak -r '/swap/d' /etc/fstab

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y apt-transport-https curl containerd kubectl kubelet kubeadm haproxy apache2-utils
sudo apt-mark hold kubelet kubeadm kubectl
sudo cp node-config/containerd.conf /etc/modules-load.d/containerd.conf
sudo cp node-config/k8s.conf /etc/sysctl.d/k8s.conf 
sudo cp node-config/haproxy.cfg /etc/haproxy/haproxy.cfg
sudo cp node-config/sys-fs-bpf.mount /etc/systemd/system/sys-fs-bpf.mount
sudo reboot
