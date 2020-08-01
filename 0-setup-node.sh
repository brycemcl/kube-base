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
sudo cp node-config/sys-fs-bpf.mount /etc/systemd/system/sys-fs-bpf.mount
sudo sh -c 'echo 0 > /sys/block/bcache0/bcache/sequential_cutoff'
sudo sh -c 'echo 0 > /sys/block/bcache1/bcache/sequential_cutoff'
sudo sh -c 'echo 0 > /sys/block/bcache2/bcache/sequential_cutoff'
sudo sh -c 'echo 0 > /sys/block/bcache3/bcache/sequential_cutoff'
sudo sh -c 'echo 0 > /sys/block/bcache4/bcache/sequential_cutoff'
sudo sh -c 'echo 0 > /sys/block/bcache5/bcache/sequential_cutoff'

sudo sh -c 'echo writeback > /sys/block/bcache0/bcache/cache_mode'
sudo sh -c 'echo writeback > /sys/block/bcache1/bcache/cache_mode'
sudo sh -c 'echo writeback > /sys/block/bcache2/bcache/cache_mode'
sudo sh -c 'echo writeback > /sys/block/bcache3/bcache/cache_mode'
sudo sh -c 'echo writeback > /sys/block/bcache4/bcache/cache_mode'
sudo sh -c 'echo writeback > /sys/block/bcache5/bcache/cache_mode'

sudo reboot
