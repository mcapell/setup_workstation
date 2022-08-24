#!/bin/bash

ANSIBLE_ARGS=
if [ "$(uname -s)" == "Linux" ]; then
    ANSIBLE_ARGS="--ask-become-pass"
fi

TAGS="$@"
if [ "$TAGS" == "" ]; then
    TAGS="all"
fi

function install_ansible () {
    if [ "$(uname -s)" == "Darwin" ]; then
        if ! [ -x "$(command -v brew)" ]; then
            echo "Manually install brew to continue"
            exit
        fi
        brew install ansible
    elif [ "$(uname -s)" == "Linux" ]; then
        echo "installing using apt"
        sudo apt install ansible
    else
        echo "Unsupported OS"
    fi
}

# Install ansible...
if ! [ -x "$(command -v ansible-playbook)" ]; then
    echo "Ansible is not installed. Installing it..." >&2
    install_ansible
fi

# Run ansible playbook from system's python (removing pyenv from PATH)
PATH=`echo ${PATH} | awk -v RS=: -v ORS=: '/pyenv/ {next} {print}'` ansible-playbook $ANSIBLE_ARGS workspace.yml --tags $TAGS
