variable aws_access_key {
    type        = string
    default     = "Enter your access key"
}


variable aws_secret_key {
    type        = string
    default     = "Enter your secret key"
}

variable "region" {
    type        = string
    default     = "eu-central-1"
}

variable "vpc_id" {
    type        = string
    default     = "vpc-0c978c7db11ae32e9"
}

variable "instance_type" {
    type        = string
    default     = "t2.micro"
}

variable "common_tags" {
    type        = map
    default     = {
        Owner = "Batyrlan Bakytbekov"
        Project = "Bootcamp"
    }
}

variable "inventory_content" {
  type = string
  default = "ansible_ssh_private_key_file=/Users/Admin/Documents/Batyrlan_key.pem ansible_user=ubuntu"
}
