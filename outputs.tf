# Public DNS name for the ALB
output "alb_dns_name" {
  description = "Public DNS name of the Application Load Balancer"
  value       = aws_lb.app_lb.dns_name
}
