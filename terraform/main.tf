# Specifie the configuration for Terraform, and declare the required AWS provider and version

terraform {
  required_providers {
    aws = {
    source  = "hashicorp/aws"
    version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

# Declare a data source that retrieves the most recent Amazon Machine Image (AMI) 

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
 
   owners = ["099720109477"] # Canonical
 }

# Declare a security group resource for the VPC, allow incomming traffic on ports and outgoing traffic

resource "aws_security_group" "security_terraform_batyrlan" {
   name = "security_terraform_batyrlan"
   vpc_id = var.vpc_id
   description = "security group for terraform"
 
   ingress {
     from_port = 80
     to_port = 80
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }
   
   ingress {
     from_port = 22
     to_port = 22
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }
 
   egress {
     from_port = 0
     to_port = 65535
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }
 
   tags = var.common_tags
 }

# Finally create an EC2 instance

resource "aws_instance" "maintask" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = "subnet-0661942722a54dcf8"
  vpc_security_group_ids = [aws_security_group.security_terraform_batyrlan.id]
  #key_name               = "Batyrlan_key"
  tags = var.common_tags
}