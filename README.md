# Project Purpose
This project aims to provide a guide for setting up and configuring an EC2 instance and nginx server on AWS using Terraform and Ansible.
In addition, it aims to guide how to create a CI/CD Pipeline using GitHub Actions that takes an index.html file from the repository, and automatically uploads it to your nginx server when commit

# Prerequisites
Before starting, ensure that you've installed:

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) (with AWS provider version ~>5.0)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)


# Getting Started
1. Fork and clone this repository.
   - git clone 
3. Navigate to the cloned repository's directory.
   - cd 


# Terraform Setup
1. Configure AWS Credentials:
   ```bash
   aws configure

Review Configuration
- NOTE: You may consider changing inventory_content and inventory_filename values (in variables.tf).
  They are responsible for creating inventory.ini and populating it with data

Initialize Terraform, plan, and apply
- terraform init
- terraform plan
- terraform apply


# Ansible Setup
Navigate to the directory that contains nginx.yml
- cd 

Review Ansible Playbook:
Review the nginx.yml Ansible playbook file to ensure it aligns with your desired Nginx installation and configuration.

Run Ansible Playbook
1. Configure Nginx on the EC2 instances using the command below:
   ```bash
   ansible-playbook --inventory-file=<location_to_the_directory>/inventory.ini nginx.yml

- NOTE: Replace <location_to_the_directory>/cloud_bootcamp_final_task/inventory.ini with the path to your inventory file if it's in a different location

- NOTE 2: You may consider chmod 600 <path_to_your_private_key/key.pem


# Github Actions Setup
In this project, the GitHub Actions workflow is set to automatically deploy the index.html file to your AWS EC2 instance whenever changes are pushed to the main branch.

The GitHub Actions workflow is defined in the .github/workflows/upload_to_ec2.yml file.
It defines a single job named deploy that runs on an Ubuntu runner. This job contains the steps to deploy the index.html file.

Pass configuration with env vars

Create ssh keypair and enter secrets in github settings/secrets
1. SSH_PRIVATE_KEY [required]
   Private key part of an SSH key pair.

   The public key part should be added to the **authorized_keys** file on the server that receives the deployment.
   
   More info for SSH keys: https://www.ssh.com/ssh/public-key-authentication
   
   The keys should be generated using the PEM format. You can use this command
   
   - ssh-keygen -m PEM -t rsa -b 4096

2. REMOTE_HOST [required]
   eg: mydomain.com

3. REMOTE_TARGET_DIR
   eg: /var/www/html

5. REMOTE_USER [required]
   eg: ubuntu

6. REMOTE_PORT (optional, default '22')
   eg: '59184'

# Cleanup
1. To remove the AWS resources created by Terraform, you can use
   ```bash
   terraform destroy
