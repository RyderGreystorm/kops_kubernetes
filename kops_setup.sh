#!/bin/bash
################################################################################
# Script Name:    kops_setup.sh
# Description:    Installs essential tools and services: AWS CLI, kubectl,
#                 Kops, and sets up the Kubernetes cluster using Kops.
#
# Author:         Godbless Biekro
# Date Created:   2024-12-14
# Last Modified:  2024-12-14
# Version:        1.1.1
# Notes:          Requires sudo privileges. Tested on Ubuntu 22.04 LTS.
################################################################################

set -e  # Exit immediately if a command exits with a non-zero status.

#Installing Kops
sudo apt update && sudo apt upgrade -y

install_kops(){
    curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
    chmod +x kops
    sudo mv kops /usr/local/bin/kops
}

install_kubectl(){
    sudo apt update
    echo "Installing kubectl..."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    echo "kubectl installed successfully."
}

install_aws_cli(){
    sudo apt update
    sudo snap install aws-cli --classic
}

create_cluster(){
    kops create cluster --name=profile.devopsfetish.xyz \
      --state=s3://biekro-kops \
      --zones=us-east-1a,us-east-1b,us-east-1c \
      --node-count=2 \
      --node-size=t3.medium \
      --control-plane-size=t3.medium \
      --dns-zone=profile.devopsfetish.xyz \
      --node-volume-size=25 \
      --control-plane-volume-size=25 \
      --ssh-public-key=~/.ssh/kops.pub
}

# functions call
install_kops
install_kubectl
install_aws_cli
create_cluster