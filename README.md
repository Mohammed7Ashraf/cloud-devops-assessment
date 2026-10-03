# Cloud DevOps Assessment

## Overview

A three-tier web application demonstrating containerization, Infrastructure as Code, CI/CD, AWS architecture, security, and monitoring.

The application consists of a static frontend, a Flask backend API, and a planned PostgreSQL database.

## Architecture

### Application Architecture

Internet
   |
   v
Frontend
   |
   v
Backend API
   |
   v
PostgreSQL Database

### Planned AWS Architecture

Internet
   |
   v
CloudFront / S3
   |
   v
Application Load Balancer
   |
   v
ECS Fargate
   |
   v
RDS PostgreSQL
   |
   v
Private Subnets

Terraform is used to define the AWS infrastructure.

GitHub Actions is used for CI/CD.

## Technology Stack

- Python
- Flask
- Gunicorn
- Docker
- Terraform
- AWS
- Amazon ECS Fargate
- Amazon ECR
- Amazon RDS PostgreSQL
- Application Load Balancer
- Amazon CloudWatch
- AWS IAM
- GitHub Actions

## Backend API

The backend is built with Flask and provides:

- `GET /health` - health check endpoint
- `GET /api/hello` - sample API endpoint

## Running Locally

### Run with Python

```bash
cd backend
python -m venv venv
pip install -r requirements.txt
python app.py

The backend will run on:
http://127.0.0.1:5000
Run with Docker
cd backend
docker build -t cloud-assessment-api .
docker run -p 5000:5000 cloud-assessment-api

Test the health endpoint:
http://127.0.0.1:5000/health
Docker
The backend is containerized using Docker.
The Docker image:
- Uses Python 3.12 slim
- Installs only required Python dependencies
- Runs Gunicorn
- Runs as a non-root user
- Exposes port 5000
Infrastructure as Code
Terraform configuration is located in the terraform/ directory.
The Terraform configuration includes:
- AWS VPC
- Public subnets
- Private subnets
- Internet Gateway
- Public route table
- Security groups
- Application Load Balancer
- Amazon ECS cluster
- ECS Fargate task definition
- Amazon ECR repository
- Amazon RDS PostgreSQL
- IAM execution role
- CloudWatch log group
- CloudWatch metric filter
- CloudWatch alarm
The Terraform configuration has been validated with terraform validate.
The infrastructure has not been deployed to AWS as part of this assessment.
CI/CD
GitHub Actions is configured to run when changes are pushed to the main branch or when a pull request is created.
The current pipeline performs:
1. Checkout repository
2. Set up Python
3. Install dependencies
4. Test the backend health endpoint
5. Build the Docker image
CI/CD Flow
GitHub
   |
   v
Checkout
   |
   v
Install Dependencies
   |
   v
Test
   |
   v
Docker Build
A production deployment stage could be added to push the image to Amazon ECR and deploy the application to ECS Fargate.
Security
The project follows basic cloud security principles:
- Backend Docker container runs as a non-root user.
- Database is configured as not publicly accessible.
- Database is intended to run in private subnets.
- Security groups restrict inbound traffic to required ports.
- IAM is used for ECS task execution.
- ECR image scanning is enabled on image push.
- ECR uses encryption.
- Database credentials are represented using a sensitive Terraform variable rather than being intended as a production hard-coded secret.
- Production credentials should be stored in AWS Secrets Manager.
Monitoring
CloudWatch configuration is included for the planned deployment.
Monitoring includes:
- Backend container logs
- CloudWatch log group
- Error metric filter
- CloudWatch alarm
The alarm can be used to detect repeated backend errors.
Architecture Decisions and Trade-offs
ECS Fargate
ECS Fargate was selected because it provides managed container execution without requiring EC2 server management.
Trade-off: Fargate is simpler operationally but can be more expensive than self-managed EC2 infrastructure.
RDS PostgreSQL
RDS provides a managed PostgreSQL database and reduces database administration overhead.
Trade-off: managed database services have less infrastructure-level control than self-managed databases.
Terraform
Terraform provides repeatable and version-controlled infrastructure.
Trade-off: Infrastructure as Code introduces additional configuration and requires understanding of Terraform state and AWS resources.
CloudFront and S3
S3 and CloudFront provide a scalable approach for hosting static frontend content.
Trade-off: this introduces additional AWS services and configuration compared with serving the frontend directly from the backend.
Project Structure
cloud-devops-assessment/
│
├── backend/
│   ├── app.py
│   ├── requirements.txt
│   └── Dockerfile
│
├── frontend/
│   └── index.html
│
├── terraform/
│   ├── versions.tf
│   ├── provider.tf
│   ├── main.tf
│   ├── ecs.tf
│   ├── rds.tf
│   ├── ecr.tf
│   ├── alb.tf
│   ├── monitoring.tf
│   └── variables.tf
│
├── .github/
│   └── workflows/
│       └── ci.yml
│
└── README.md

Current Status
Completed
- Flask backend
- API endpoints
- Docker containerization
- Non-root Docker user
- Local Docker testing
- Terraform configuration
- AWS VPC networking
- Public and private subnet configuration
- Security groups
- ECS Fargate configuration
- ECR configuration
- RDS PostgreSQL configuration
- Application Load Balancer configuration
- IAM ECS execution role
- CloudWatch logging and alerting configuration
- GitHub Actions CI pipeline
- Project documentation
Deployment Status
The AWS infrastructure is defined using Terraform but has not been deployed as part of this assessment.
Production Improvements
For a production deployment, the following improvements would be made:
1. Deploy the Terraform infrastructure using a controlled AWS account.
2. Push the Docker image to Amazon ECR.
3. Deploy the backend to ECS Fargate.
4. Configure the Application Load Balancer target group and listener.
5. Store database credentials in AWS Secrets Manager.
6. Configure ECS tasks to retrieve secrets securely.
7. Deploy PostgreSQL in multiple private subnets.
8. Configure HTTPS using AWS Certificate Manager.
9. Host the frontend using S3 and CloudFront.
10. Add automated deployment to the GitHub Actions workflow.
11. Add automated security scanning.
12. Add CloudWatch dashboards and production alerts.
13. Configure Terraform remote state and state locking.
14. Add automated application and integration tests.
Conclusion
This project demonstrates the core workflow of a cloud DevOps application:
Application
→ Docker
→ Terraform
→ AWS Infrastructure
→ CI/CD
→ Security
→ Monitoring
The repository provides the application code, container configuration, Infrastructure as Code, CI pipeline, and documentation required to extend the project into a production deployment.