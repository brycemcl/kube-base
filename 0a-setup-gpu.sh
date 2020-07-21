#!/bin/bash
sudo apt-get update
sudo apt-get install -y apt-transport-https curl ubuntu-drivers-common
sudo ubuntu-drivers autoinstall
curl -s -L https://nvidia.github.io/nvidia-container-runtime/gpgkey | sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-container-runtime/$distribution/nvidia-container-runtime.list | sudo tee /etc/apt/sources.list.d/nvidia-container-runtime.list
sudo apt-get update
sudo apt-get install nvidia-container-runtime -y
sudo mkdir /etc/containerd/
sudo cp node-config/containerd_gpu.toml /etc/containerd/config.toml