output "vpc_id" {
  description = "VPC used for the project"
  value       = var.project_vpc
}

output "subnet_id" {
  description = "Subnet used for the EC2 instance"
  value       = var.project_subnet_id
}

output "instance_type" {
  description = "EC2 instance type"
  value       = var.project_instance_type
}
