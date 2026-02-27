# Define the AWS region for infrastructure deployment
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

# Define the EC2 instance type (keeping it Free Tier eligible)
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

# Define the environment tag
variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "Development"
}