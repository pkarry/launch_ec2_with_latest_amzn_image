terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region = var.aws_region
}

# Get latest amazon linux ami
data "aws_ami" "amzn_linux2" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["amzn2-ami-*-x86_64-gp2"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

output "amazon_linux_ami_id" {
  value = "${data.aws_ami.amzn_linux2.id}"
}


resource "aws_instance" "app_server" {
  ami = "${data.aws_ami.amzn_linux2.id}"
  instance_type = "t2.micro"

  tags = {
    Name = "First-Test"
  }
}
