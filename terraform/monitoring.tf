resource "aws_cloudwatch_log_group" "backend" {
  name              = "/ecs/cloud-assessment-backend"
  retention_in_days = 7

  tags = {
    Name        = "cloud-assessment-backend-logs"
    Project     = "cloud-devops-assessment"
    Environment = "assessment"
  }
}

resource "aws_cloudwatch_log_metric_filter" "errors" {
  name           = "cloud-assessment-errors"
  log_group_name = aws_cloudwatch_log_group.backend.name
  pattern        = "ERROR"

  metric_transformation {
    name      = "BackendErrors"
    namespace = "CloudAssessment"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "backend_errors" {
  alarm_name          = "cloud-assessment-backend-errors"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "BackendErrors"
  namespace           = "CloudAssessment"
  period              = 300
  statistic           = "Sum"
  threshold           = 5

  treat_missing_data = "notBreaching"

  tags = {
    Project     = "cloud-devops-assessment"
    Environment = "assessment"
  }
}