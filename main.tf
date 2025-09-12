# Networking: Default VPC + two existing subnets
data "aws_vpc" "default" {
  default = true
}

# Reference two existing subnets in the default VPC
data "aws_subnet" "subnet_a" {
  filter {
    name   = "cidr-block"
    values = ["172.31.16.0/20"]
  }

  vpc_id = data.aws_vpc.default.id
}

data "aws_subnet" "subnet_b" {
  filter {
    name   = "cidr-block"
    values = ["172.31.64.0/20"]
  }

  vpc_id = data.aws_vpc.default.id
}

locals {
  selected_subnets = [
    data.aws_subnet.subnet_a.id,
    data.aws_subnet.subnet_b.id
  ]
}


# Security Group for Instances
resource "aws_security_group" "web_sg" {
  name        = "${var.project_name}-sg"
  description = "Allow HTTP traffic from the internet"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "Allow HTTP Traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH Traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-sg"
  }
}


# Get latest Amazon Linux AMI
data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["137112412989"] # Amazon

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}


# Launch Template
resource "aws_launch_template" "web_lt" {
  name_prefix   = "${var.project_name}-lt-"
  image_id      = data.aws_ami.al2023.id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = filebase64("${path.module}/user_data.sh")

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.project_name}-instance"
    }
  }
}


# Auto Scaling Group
resource "aws_autoscaling_group" "web_asg" {
  name                = "${var.project_name}-asg"
  min_size            = var.asg_min_size
  max_size            = var.asg_max_size
  desired_capacity    = var.asg_min_size
  vpc_zone_identifier = local.selected_subnets
  health_check_type   = "EC2"

  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.project_name}-asg-instance"
    propagate_at_launch = true
  }
}


# S3 Bucket for Terraform Remote Backend
resource "aws_s3_bucket" "tf_state" {
  bucket = var.s3_bucket_name

  tags = {
    Name = "${var.project_name}-tfstate"
  }
}

resource "aws_s3_bucket_versioning" "tf_state" {
  bucket = aws_s3_bucket.tf_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state" {
  bucket = aws_s3_bucket.tf_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
