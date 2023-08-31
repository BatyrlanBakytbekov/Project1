terraform {
  required_providers {
    aws = {
    source  = "hashicorp/aws"
    version = "~> 5.0"
    }
  }
}


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


resource "aws_instance" "maintask" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = "subnet-0661942722a54dcf8"
  vpc_security_group_ids = [aws_security_group.security_terraform_batyrlan.id]
  key_name               = "Batyrlan_key"
  tags = var.common_tags
}


resource "local_file" "inventory" {
  depends_on = [aws_instance.maintask]

  content = "[web]\n${aws_instance.maintask.public_ip} ${var.inventory_content}" 
  filename = "/ansible/inventory.ini"
}
