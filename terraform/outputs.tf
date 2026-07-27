# File: outputs.tf
output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_id" {
  value = aws_subnet.main.id
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "ecs_task_definition_arn" {
  value = aws_ecs_task_definition.main.arn
}

output "rds_instance_endpoint" {
  value = aws_db_instance.main.endpoint
}

output "rds_instance_username" {
  value = aws_db_instance.main.username
  sensitive = false
}

output "rds_instance_password" {
  value     = aws_db_instance.main.password
  sensitive = true
}

output "s3_bucket_name" {
  value = aws_s3_bucket.main.bucket
}