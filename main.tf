#Pinning to Ubuntu 22.04 LTS as the base image for stability and long-term security patching

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket =  "devsecops-tf-state-bernardez"
    key = "infra/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "devsecops-tf-lock"
    encrypt = true
  }
}


provider "aws" {
  region = "us-east-1"
}



data "aws_ami" "ubuntu" {
  most_recent = "true"
  owners = ["099720109477"]
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}


resource "aws_instance" "Web_server" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.micro" # Kept on t3.micro to stay within AWS Free Tier
  tags = {
    Name = "DevSecOps-Server"
    Environment = "Development"
    Owner = "Santiago"

  }
}