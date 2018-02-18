#! /bin/sh
# This bash script is simply to ensure ansible is installed prior to further provisioning via ansible-local

# Ensure the CentOS 7 EPEL repository is installed
sudo yum install epel-release -y

# Install Ansible
sudo yum install ansible -y

# cat >> /etc/hosts <<-EOL
# # vagrant environment nodes
# 192.168.29.92  ansible-host ansible-host.local
# EOL
