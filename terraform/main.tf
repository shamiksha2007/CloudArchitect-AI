# File: main.tf
provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}

terraform {
  backend "s3" {
    bucket = "cloudarchitect-ai-tfstate-513816987431"
    key    = "terraform/state/terraform.tfstate"
    region = "ap-south-1"
  }
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr
  availability_zone = var.availability_zone
}

resource "aws_subnet" "secondary" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.second_subnet_cidr
  availability_zone = var.second_availability_zone
}

resource "aws_db_subnet_group" "main" {
  name       = "main-db-subnet-group"
  subnet_ids = [aws_subnet.main.id, aws_subnet.secondary.id]
}

resource "aws_ecs_cluster" "main" {
  name = var.cluster_name
}

resource "aws_ecs_task_definition" "main" {
  family                = var.task_definition_name
  cpu                    = var.task_cpu
  memory                 = var.task_memory
  network_mode           = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn      = aws_iam_role.ecs_task_execution.arn
  container_definitions = jsonencode([
    {
      name          = var.container_name
      image         = var.container_image
      portMappings = [
        {
          containerPort = var.container_port
          hostPort       = var.container_port
        }
      ]
    }
  ])
}

resource "aws_iam_role" "ecs_task_execution" {
  name        = var.ecs_task_execution_role_name
  description = "ECS Task Execution Role"

  assume_role_policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Action = "sts:AssumeRole"
          Principal = {
            Service = "ecs-tasks.amazonaws.com"
          }
          Effect = "Allow"
        }
      ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_db_instance" "main" {
  allocated_storage    = var.rds_allocated_storage
  engine               = var.rds_engine
  instance_class       = var.rds_instance_class
  db_name              = var.rds_db_name
  username             = var.rds_username
  password             = var.rds_password
  vpc_security_group_ids = [
    aws_security_group.rds.id
  ]
}

resource "aws_security_group" "rds" {
  name        = var.rds_security_group_name
  description = "RDS Security Group"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = var.rds_port
    to_port     = var.rds_port
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }
}

resource "aws_s3_bucket" "main" {
  bucket = var.s3_bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }
}
