resource "aws_ecr_repository" "backend" {
  name                 = "cloud-assessment-api"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Name        = "cloud-assessment-api"
    Project     = "cloud-devops-assessment"
    Environment = "assessment"
  }
}