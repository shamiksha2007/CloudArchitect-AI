# File: variables.tf
variable "region" {
  default = "ap-south-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "availability_zone" {
  default = "ap-south-1a"
}

variable "cluster_name" {
  default = "main"
}

variable "task_definition_name" {
  default = "main"
}

variable "task_cpu" {
  default = 256
}

variable "task_memory" {
  default = 512
}

variable "container_name" {
  default = "main"
}

variable "container_image" {
  default = "nginx:latest"
}

variable "container_port" {
  default = 80
}

variable "ecs_task_execution_role_name" {
  default = "ecs-task-execution"
}

variable "rds_allocated_storage" {
  default = 20
}

variable "rds_engine" {
  default = "postgres"
}

variable "rds_instance_class" {
  default = "db.t2.micro"
}

variable "rds_db_name" {
  default = "main"
}

variable "rds_username" {
  default = "postgres"
}

variable "rds_password" {
  sensitive = true
}

variable "rds_port" {
  default = 5432
}

variable "rds_security_group_name" {
  default = "rds"
}

variable "s3_bucket_name" {
  default = "main"
}
