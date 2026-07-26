output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The ID of the VPC"
}

output "subnet_id" {
  value       = aws_subnet.main.id
  description = "The ID of the subnet"
}

output "ecs_cluster_name" {
  value       = aws_ecs_cluster.main.name
  description = "The name of the ECS cluster"
}

output "ecs_task_definition_arn" {
  value       = aws_ecs_task_definition.main.arn
  description = "The ARN of the ECS task definition"
}

output "ecs_service_name" {
  value       = aws_ecs_service.main.name
  description = "The name of the ECS service"
}

output "rds_instance_address" {
  value       = aws_rds_instance.main.address
  description = "The address of the RDS instance"
}

output "rds_instance_port" {
  value       = aws_rds_instance.main.port
  description = "The port of the RDS instance"
}

output "ebs_volume_id" {
  value       = aws_ebs_volume.main.id
  description = "The ID of the EBS volume"
}

output "iam_role_arn" {
  value       = aws_iam_role.main.arn
  description = "The ARN of the IAM role"
}

output "iam_policy_arn" {
  value       = aws_iam_policy.main.arn
  description = "The ARN of the IAM policy"
}

output "security_group_id" {
  value       = aws_security_group.main.id
  description = "The ID of the security group"
}

output "s3_bucket_name" {
  value       = aws_s3_bucket.main.bucket
  description = "The name of the S3 bucket"
}

output "cloudfront_distribution_id" {
  value       = aws_cloudfront_distribution.main.id
  description = "The ID of the CloudFront distribution"
}