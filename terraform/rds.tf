resource "aws_db_subnet_group" "main" {
  name = "cloud-assessment-db-subnet-group"

  subnet_ids = [
    aws_subnet.private.id,
    aws_subnet.private_2.id
  ]

  tags = {
    Name        = "cloud-assessment-db-subnet-group"
    Project     = "cloud-devops-assessment"
    Environment = "assessment"
  }
}

resource "aws_db_instance" "postgres" {
  identifier = "cloud-assessment-postgres"

  engine         = "postgres"
  engine_version = "16"

  instance_class      = "db.t3.micro"
  allocated_storage   = 20
  storage_type        = "gp3"
  publicly_accessible = false
  skip_final_snapshot = true
  deletion_protection = false

  db_name  = "assessment"
  username = "assessment_user"
  password = var.db_password

  db_subnet_group_name = aws_db_subnet_group.main.name

  tags = {
    Name        = "cloud-assessment-postgres"
    Project     = "cloud-devops-assessment"
    Environment = "assessment"
  }
}