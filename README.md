# Project Purpose




# Prerequisites
Before starting, ensure that you've installed:

AWS CLI: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
Terraform: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
aws provider version ~>5.0
Ansible: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html


# Guide
Fork and clone the repository.
cd to the working directory.


# Terraform part
Set Up AWS Credentials
aws configure


# Review Configuration
NOTE: You may consider changing inventory_content and inventory_filename values (in variables.tf).
They are responsible for creating inventory.ini and populating it with data

# Initialize Terraform
terraform init
terraform plan
terraform apply


# Ansible Part
Review Ansible Playbook
Review nginx.yml Ansible playbook file to ensure it matches your desired Nginx installation and configuration.

# Run Ansible Playbook
The command below configures nginx on EC2
ansible-playbook --inventory-file=<location_to_the_directory>/cloud_bootcamp_final_task/inventory.ini install_nginx.yml
