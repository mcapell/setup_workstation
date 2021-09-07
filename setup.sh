#!/bin/bash

# Install ansible...
if ! [ -x "$(command -v ansible-playbook)" ]; then
  echo "Ansible is not installed. Installing it..." >&2
  sudo apt install ansible
fi

# Run ansible playbook from system's python (removing pyenv from PATH)
PATH=`echo ${PATH} | awk -v RS=: -v ORS=: '/pyenv/ {next} {print}'` ansible-playbook --ask-become-pass workspace.yml
