terraform {
  required_version = ">= 1.6.0"

  backend "s3" {
    bucket  = "teachbleat-cicd-state-bucket"
    key     = "envs/dev/terraform.tfstate"
    region  = "eu-west-1"
    encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}



# ============================
# nginx Instance (Standalone)
# ============================
resource "aws_instance" "nginx-node" {
  ami                    = var.project_ami
  instance_type          = var.project_instance_type
  subnet_id              = var.project_subnet_id
  vpc_security_group_ids = [aws_security_group.nginx_access.id]
  key_name               = var.project_keyname

  tags = {
    Name = "terraform-nginx-node"
  }
}



# ============================
# Web Node Security Group for nginx
# ============================
resource "aws_security_group" "nginx_access" {
  name        = "allow_ssh_http_nginx"
  description = "Allow SSH and HTTP inbound traffic"
  #vpc_id      = var.project_vpc




  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP on port 8080"
    from_port   = 80
    to_port     = 80
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
}

# ============================
# Security Group for Java
# ============================
resource "aws_security_group" "java_access" {
  name        = "allow_ssh_http_java"
  description = "Allow SSH and HTTP inbound traffic"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 9090
    to_port     = 9090
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
}

# ============================
# Java Instance (Standalone)
# ============================
resource "aws_instance" "java-node" {


  ami                    = var.project_ami
  instance_type          = var.project_instance_type
  subnet_id              = var.project_subnet_id
  vpc_security_group_ids = [aws_security_group.java_access.id]
  key_name               = var.project_keyname


  tags = {
    Name = "terraform-java-node"
  }
}


# ============================
# Security Group for Python
# ============================
resource "aws_security_group" "python_access" {
  name        = "allow_ssh_http_python"
  description = "Allow SSH and HTTP inbound traffic"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP on port 8080"
    from_port   = 8080
    to_port     = 8080
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
}


# ============================
# Python Instance (Standalone)
# ============================
resource "aws_instance" "python-node" {


  ami                    = var.project_ami
  instance_type          = var.project_instance_type
  subnet_id              = var.project_subnet_id
  vpc_security_group_ids = [aws_security_group.python_access.id]
  key_name               = var.project_keyname

  tags = {
    Name = "terraform-python-node"
  }
}
