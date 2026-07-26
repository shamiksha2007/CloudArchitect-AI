provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.availability_zone
}

resource "aws_ecs_cluster" "main" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "main" {
  family                   = var.ecs_task_definition_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.ecs_task_definition_cpu
  memory                   = var.ecs_task_definition_memory
  execution_role_arn       = aws_iam_role.main.arn
  container_definitions    = jsonencode([
    {
      name      = var.container_name
      image      = var.container_image
      cpu        = var.container_cpu
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ]
    }
  ])
  depends_on = [aws_iam_role_policy_attachment.main]
}

resource "aws_ecs_service" "main" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.main.name
  task_definition = aws_ecs_task_definition.main.arn
  desired_count    = var.ecs_service_desired_count
  launch_type      = "FARGATE"
  network_configuration {
    subnets         = [aws_subnet.main.id]
    security_groups = [aws_security_group.main.id]
    assign_public_ip = "ENABLED"
  }
}

resource "aws_rds_instance" "main" {
  allocated_storage    = var.rds_allocated_storage
  engine                = var.rds_engine
  engine_version        = var.rds_engine_version
  instance_class       = var.rds_instance_class
  name                 = var.rds_name
  username             = var.rds_username
  password             = var.rds_password
  vpc_security_group_ids = [aws_security_group.main.id]
  db_subnet_group_name = aws_db_subnet_group.main.name
  publicly_accessible  = false
}

resource "aws_db_subnet_group" "main" {
  name       = var.rds_subnet_group_name
  subnet_ids = [aws_subnet.main.id]
}

resource "aws_ebs_volume" "main" {
  availability_zone = var.availability_zone
  size              = var.ebs_volume_size
  encrypted         = true
}

resource "aws_ebs_attachment" "main" {
  device_name = var.ebs_device_name
  volume_id   = aws_ebs_volume.main.id
  #instance_id = aws_ecs_service.main.id
  #ECS Service does not support instance_id for ebs attachment
}

resource "aws_iam_role" "main" {
  name        = var.iam_role_name
  description = var.iam_role_description

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
          Sid      = ""
        }
      ]
    }
  )
}

resource "aws_iam_policy" "main" {
  name        = var.iam_policy_name
  description = var.iam_policy_description

  policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Action = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
          Resource = "arn:aws:logs:*:*:*"
          Effect    = "Allow"
        },
        {
          Action = ["rds:*"]
          Resource = aws_rds_instance.main.arn
          Effect    = "Allow"
        }
      ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "main" {
  role       = aws_iam_role.main.name
  policy_arn = aws_iam_policy.main.arn
}

resource "aws_security_group" "main" {
  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = var.security_group_ingress_port
    to_port     = var.security_group_ingress_port
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }
}

resource "aws_s3_bucket" "main" {
  bucket = var.bucket_name
  acl    = "private"
}

resource "aws_cloudfront_distribution" "main" {
  origin {
    domain_name = aws_s3_bucket.main.bucket_regional_domain_name
    origin_id   = var.origin_id
  }

  enabled = true

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.acm_certificate_arn
  }
}