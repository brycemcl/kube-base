#!/bin/bash
sed -i.bak -r 's/(.+ swap .+)/#\1/' /etc/fstab
git pull
sudo su
apt-get update && apt-get install -y apt-transport-https curl containerd kubectl kubelet kubeadm haproxy 
apt-mark hold kubelet kubeadm kubectl
cp node-config/containerd.conf /etc/modules-load.d/containerd.conf
cp node-config/k8s.conf /etc/sysctl.d/k8s.conf 
cp node-config/haproxy.cfg /etc/haproxy/haproxy.cfg
cp node-config/sys-fs-bpf.mount /etc/systemd/system/sys-fs-bpf.mount
reboot