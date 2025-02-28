#!/bin/bash

# Add user to sudo group
USERNAME=$(whoami)
su -c "bash -c 'echo \"$USERNAME ALL=(ALL) NOPASSWD:ALL\" >> /etc/sudoers'"

# Mettre à jour les packages et installer les dépendances de base
echo "Mise à jour des paquets..."
apt-get update && apt-get upgrade -y
apt-get install -y \
  curl \
  wget \
  vim \
  git \
  lsb-release \
  apt-transport-https \
  ca-certificates \
  gnupg \
  software-properties-common \
  unzip \
  jq \
  lsb-release \
  apt-utils

# Installation de Vscode
echo "Installation de Vscode..."

sudo apt update

sudo apt install gnupg2 software-properties-common apt-transport-https curl

curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

sudo apt update

sudo apt install code

# Installation de Docker
echo "Installation de Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
usermod -aG docker $(whoami)  # Ajoute l'utilisateur actuel au groupe Docker
systemctl enable docker
systemctl start docker

apt-get install -y docker-compose

# Installation de Kubernetes (kubectl)
echo "Installation de Kubernetes (kubectl)..."
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.26.0/bin/linux/amd64/kubectl
chmod +x kubectl
mv kubectl /usr/local/bin/

# Installation de Minikube
echo "Installation de Minikube..."

curl -Lo minikube https://storage.googleapis.com/minikube/releases/v1.26.1/minikube-linux-amd64

# Rendre l'exécutable
chmod +x minikube

# Déplacer Minikube dans un répertoire accessible
sudo mv minikube /usr/local/bin/

# Installation de Terraform
echo "Installation de Terraform..."
curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
apt-add-repository "deb https://apt.releases.hashicorp.com $(lsb_release -cs) main"
apt-get update && apt-get install terraform

# Installation d'Ansible
echo "Installation d'Ansible..."
apt-add-repository ppa:ansible/ansible
apt-get update && apt-get install ansible -y

# Ajouter des alias pour kubectl et Terraform
echo "Alias pour kubectl et Terraform..."
echo "alias kubectl='kubectl --kubeconfig=/home/$(whoami)/.kube/config'" >> ~/.bashrc
echo "alias terraform='terraform'" >> ~/.bashrc
source ~/.bashrc


ssh-keygen

# Installer d'autres outils ou mettre en place des configurations supplémentaires si nécessaire
echo "Installation terminée. Redémarrage recommandé pour appliquer toutes les configurations."
