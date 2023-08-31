# Define the required provider and its version
terraform {
  required_providers {
    aws = {
    source  = "hashicorp/aws"
    version = "~> 5.0"
    }
  }

  required_version = ">= 0.14.9"
}

# Fetch the latest Ubuntu AMI from AWS
data "aws_ami" "latest_ubuntu" {
   most_recent = true
 
   filter {
     name = "name"
     values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
   }
 
   filter {
     name = "virtualization-type"
     values = ["hvm"]
   }
   owners = ["099720109477"]
 }

# Define a security group to control inbound and outbound traffic
resource "aws_security_group" "security_terraform_batyrlan" {
   name = "security_terraform_batyrlan"
   vpc_id = var.vpc_id
   description = "security group for terraform"

   # Allow incoming HTTP traffic
   ingress {
     from_port = 80
     to_port = 80
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }

   # Allow incoming SSH traffic
   ingress {
     from_port = 22
     to_port = 22
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }

   # Allow outgoing traffic
   egress {
     from_port = 0
     to_port = 65535
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }

   # Attach common tags to the security group
   tags = var.common_tags
 }

# Launch an AWS EC2 instance
resource "aws_instance" "maintask" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = "subnet-0661942722a54dcf8"

  # Attach the previously defined security group
  vpc_security_group_ids = [aws_security_group.security_terraform_batyrlan.id]
  # Specify the SSH key pair to use for connecting to the instance
  key_name               = "Batyrlan_key"
  tags = var.common_tags
}

# Create a local inventory file for Ansible
resource "local_file" "inventory" {
  depends_on = [aws_instance.maintask]

  content = "[web]\n${aws_instance.maintask.public_ip} ${var.inventory_content}" 
  filename = "/ansible/inventory.ini"
}
