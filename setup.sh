#!/bin/bash

# Install ansible...
if ! [ -x "$(command -v ansible-playbook)" ]; then
  echo "Ansible is not installed. Installing it..." >&2
  sudo apt install ansible
fi

# Run ansible playbook
ansible-playbook ubuntu_setup.yml
