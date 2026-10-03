resource "aws_ecs_cluster" "main" {
  name = "cloud-assessment-cluster"

  tags = {
    Project     = "cloud-devops-assessment"
    Environment = "assessment"
  }
}

resource "aws_iam_role" "ecs_task_execution" {
  name = "cloud-assessment-ecs-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = {
    Project = "cloud-devops-assessment"
  }
}

resource "aws_ecs_task_definition" "backend" {
  family                   = "cloud-assessment-backend"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    {
      name      = "backend"
      image     = "${aws_ecr_repository.backend.repository_url}:latest"
      essential = true

      portMappings = [{
        containerPort = 5000
        hostPort      = 5000
        protocol      = "tcp"
      }]
    }
  ])

  tags = {
    Project     = "cloud-devops-assessment"
    Environment = "assessment"
  }
}
resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}