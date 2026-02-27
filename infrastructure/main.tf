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
  ami           = data.aws_ami.ubuntu.id
  
  # Use variable instead of hardcoded value
  instance_type = var.instance_type 
  
  # Metadata tags for resource identification
  tags = {
    Name        = "DevSecOps-Server"
    Environment = var.environment
    Project     = "AWS-Pipeline"
  }
}