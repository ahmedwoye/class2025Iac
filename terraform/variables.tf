variable "project_vpc" {
  type        = string
  description = "VPC ID where resources will be created"
}

variable "project_ami" {
  type        = string
  description = "AMI ID for EC2 instance"
}

variable "project_instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "project_subnet_id" {
  type        = string
  description = "Subnet ID for EC2 instance"
}

variable "project_keyname" {
  type        = string
  description = "EC2 key pair name"
}
