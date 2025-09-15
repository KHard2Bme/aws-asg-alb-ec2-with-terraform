terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.5.0"
}

terraform {
# Configure remote state (update with your bucket details after creating it)
  backend "s3" {
    bucket        = "skybound-tfstate-5cad309b"
    key           = "skybound-tfstate-5cad309b/backend/backend.tf"
    region        = "us-east-1"
    encrypt       =  true
  }
}


provider "aws" {
  region = var.aws_region
}