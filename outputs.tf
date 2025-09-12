# Get all EC2 instances in the ASG by tag
data "aws_instances" "asg_instances" {
  instance_tags = {
    Name = "${var.project_name}-asg-instance"
  }
}

# Public IPs of all instances in the Auto Scaling Group
output "asg_instance_public_ips" {
  description = "Public IP addresses of the Auto Scaling Group instances"
  value       = data.aws_instances.asg_instances.public_ips
}

# IDs of all instances (helpful for debugging)
output "asg_instance_ids" {
  description = "Instance IDs of the Auto Scaling Group instances"
  value       = data.aws_instances.asg_instances.ids
}

# Subnet IDs where the ASG instances are running
output "asg_instance_subnets" {
  description = "Subnet IDs of the Auto Scaling Group instances"
  value       = data.aws_instances.asg_instances.subnet_ids
}

# S3 bucket name for Terraform remote backend
output "s3_bucket_name" {
  description = "S3 bucket created for Terraform remote backend"
  value       = aws_s3_bucket.tf_state.bucket
}
