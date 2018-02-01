#!/bin/bash

# Install ansible...

# Run ansible playbook
ansible-playbook -i "localhost," -c local ubuntu_setup.yml
