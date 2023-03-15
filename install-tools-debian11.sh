#!/bin/bash

MINIKUBE_VERSION=v1.29.0
DOCKER_VERSION=5:23.0.1-1~debian.11~bullseye
HELM_VERSION=v3.11.2
TERRAFORM_VERION=1.4.0
KUBECTL_VERSION=v1.26.1

set -e

sudo apt update -y
sudo apt upgrade -y
# common misc tools
sudo apt install ca-certificates curl gnupg lsb-release wget apt-transport-https software-properties-common -y
sudo mkdir -p /usr/local/bin/

# install docker
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | \
    sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/debian bullseye stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce=${DOCKER_VERSION} docker-ce-cli=${DOCKER_VERSION} containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo usermod -aG docker ${USER}
# this is to avoid re-login
sudo chown ${USER} /var/run/docker.sock

# install minikube
sudo curl -Lo /usr/local/bin/minikube https://storage.googleapis.com/minikube/releases/${MINIKUBE_VERSION}/minikube-linux-amd64 && \
 sudo chmod +x /usr/local/bin/minikube
minikube config set driver docker

# install HELM
sudo curl -L https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz | tar xvzf - -C /tmp && \
    sudo cp /tmp/linux-amd64/helm /usr/local/bin/ && \
    sudo chmod +x /usr/local/bin/helm

# install kubectl
sudo curl -Lo /usr/local/bin/kubectl https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    sudo chmod +x /usr/local/bin/kubectl

# install Terraform
curl -fsSL https://apt.releases.hashicorp.com/gpg | \
    sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/hashicorp-archive-keyring.gpg
echo \
    "deb [signed-by=/etc/apt/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com bullseye main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list >/dev/null
sudo apt-get update
sudo apt-get install terraform=${TERRAFORM_VERION} -y

# show versions of installed tools
echo docker versions:
docker version
minikube version
echo k8s version
kubectl version --short
echo helm version:
helm version
terraform version

