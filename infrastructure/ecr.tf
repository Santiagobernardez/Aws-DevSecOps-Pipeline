# infrastructure/ecr.tf

# Create an Elastic Container Registry to store our secure Docker images
resource "aws_ecr_repository" "app_repo" {
  name                 = "devsecops-portfolio-app"
  image_tag_mutability = "MUTABLE"

  # Enable AWS native scanning on push for an extra layer of security
  image_scanning_configuration {
    scan_on_push = true
  }
}