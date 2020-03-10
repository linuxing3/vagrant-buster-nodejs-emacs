#!/bin/bash
set -ev

# Ansible syntax check
ansible-playbook ansible/hackbook.yml --syntax-check