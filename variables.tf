variable "aws_region" {
  description = "AWS region to deploy resources into"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Prefix for resource naming"
  type        = string
  default     = "skybound-travel"
}

variable "instance_type" {
  description = "EC2 instance type for ASG"
  type        = string
  default     = "t2.micro"
}

variable "allowed_ssh_ip" {
  description = "Your public IP for SSH access"
  default     = "0.0.0.0/0"
}

variable "asg_min_size" {
  description = "Minimum number of instances in the ASG"
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "Maximum number of instances in the ASG"
  type        = number
  default     = 5
}

