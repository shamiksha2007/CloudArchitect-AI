variable "region" {
  type        = string
  default     = "us-west-2"
  description = "The AWS region to deploy to"
}

variable "cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "The CIDR block for the VPC"
}

variable "subnet_cidr_block" {
  type        = string
  default     = "10.0.1.0/24"
  description = "The CIDR block for the subnet"
}

variable "availability_zone" {
  type        = string
  default     = "us-west-2a"
  description = "The availability zone to deploy to"
}

variable "ecs_cluster_name" {
  type        = string
  default     = "main"
  description = "The name of the ECS cluster"
}

variable "ecs_task_definition_name" {
  type        = string
  default     = "main"
  description = "The name of the ECS task definition"
}

variable "ecs_task_definition_cpu" {
  type        = string
  default     = "256"
  description = "The amount of CPU to allocate to the task definition"
}

variable "ecs_task_definition_memory" {
  type        = string
  default     = "512"
  description = "The amount of memory to allocate to the task definition"
}

variable "container_name" {
  type        = string
  default     = "main"
  description = "The name of the container"
}

variable "container_image" {
  type        = string
  default     = "nginx:latest"
  description = "The image to use for the container"
}

variable "container_cpu" {
  type        = string
  default     = "10"
  description = "The amount of CPU to allocate to the container"
}

variable "container_port" {
  type        = number
  default     = 80
  description = "The port to use for the container"
}

variable "ecs_service_name" {
  type        = string
  default     = "main"
  description = "The name of the ECS service"
}

variable "ecs_service_desired_count" {
  type        = number
  default     = 1
  description = "The number of tasks to run in the service"
}

variable "rds_allocated_storage" {
  type        = number
  default     = 20
  description = "The amount of storage to allocate to the RDS instance"
}

variable "rds_engine" {
  type        = string
  default     = "postgres"
  description = "The engine to use for the RDS instance"
}

variable "rds_engine_version" {
  type        = string
  default     = "13.4"
  description = "The version of the engine to use for the RDS instance"
}

variable "rds_instance_class" {
  type        = string
  default     = "db.t3.micro"
  description = "The instance class to use for the RDS instance"
}

variable "rds_name" {
  type        = string
  default     = "main"
  description = "The name of the RDS instance"
}

variable "rds_username" {
  type        = string
  default     = "postgres"
  description = "The username to use for the RDS instance"
}

variable "rds_password" {
  type        = string
  sensitive   = true
  default     = "password"
  description = "The password to use for the RDS instance"
}

variable "rds_subnet_group_name" {
  type        = string
  default     = "main"
  description = "The name of the subnet group to use for the RDS instance"
}

variable "ebs_volume_size" {
  type        = number
  default     = 30
  description = "The size of the EBS volume"
}

variable "ebs_device_name" {
  type        = string
  default     = "/dev/sdh"
  description = "The device name to use for the EBS volume"
}

variable "iam_role_name" {
  type        = string
  default     = "main"
  description = "The name of the IAM role"
}

variable "iam_role_description" {
  type        = string
  default     = "The description of the IAM role"
  description = "The description of the IAM role"
}

variable "iam_policy_name" {
  type        = string
  default     = "main"
  description = "The name of the IAM policy"
}

variable "iam_policy_description" {
  type        = string
  default     = "The description of the IAM policy"
  description = "The description of the IAM policy"
}

variable "security_group_name" {
  type        = string
  default     = "main"
  description = "The name of the security group"
}

variable "security_group_description" {
  type        = string
  default     = "The description of the security group"
  description = "The description of the security group"
}

variable "security_group_ingress_port" {
  type        = number
  default     = 80
  description = "The port to use for the security group ingress rule"
}

variable "bucket_name" {
  type        = string
  default     = "my-bucket"
  description = "The name of the S3 bucket"
}

variable "origin_id" {
  type        = string
  default     = "my-origin"
  description = "The ID of the CloudFront origin"
}

variable "acm_certificate_arn" {
  type        = string
  default     = "arn:aws:acm:us-west-2:123456789012:certificate/12345678-1234-1234-1234-123456789012"
  description = "The ARN of the ACM certificate"
}