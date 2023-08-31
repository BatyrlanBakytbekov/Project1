# Project Purpose
This project aims to provide a guide for setting up and configuring an EC2 instance and nginx server on AWS using Terraform and Ansible.

# Prerequisites
Before starting, ensure that you've installed:

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) (with AWS provider version ~>5.0)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)


# Getting Started
1. Fork and clone this repository.
2. Navigate to the cloned repository's directory.


# Terraform Setup
1. Configure AWS Credentials:
   ```bash
   aws configure


# Review Configuration
NOTE: You may consider changing inventory_content and inventory_filename values (in variables.tf).
They are responsible for creating inventory.ini and populating it with data

# Initialize Terraform
terraform init
terraform plan
terraform apply


# Ansible Setup
Review Ansible Playbook:
Review the nginx.yml Ansible playbook file to ensure it aligns with your desired Nginx installation and configuration.

# Run Ansible Playbook
Configure Nginx on the EC2 instances using the command below:
   ```bash
ansible-playbook --inventory-file=<location_to_the_directory>/cloud_bootcamp_final_task/inventory.ini install_nginx.yml

NOTE: Replace <location_to_the_directory>/cloud_bootcamp_final_task/inventory.ini with the path to your inventory file if it's in a different location

NOTE 2: You may consider chmod 600 <path_to_your_private_key/key.pem

