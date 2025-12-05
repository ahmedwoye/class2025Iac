packer {
    required_version = ">=1.9.0"

    required_plugins {
        amazon = {
            source = "github.com/hashicorp/amazon"
            version = ">= 1.2.0"
        }
    }
}


#-----------------------------
# source: how we build the AMI For Nginx and GIT 
#-----------------------------

source "amazon-ebs" "nginx-git" {
    region = "eu-west-1"
    instance_type = "t3.micro"
    ssh_username = "ec2-user"
    source_ami  = "ami-0870af38096a5355b"
    ami_name = "nginx-git-by-packer-v2"
    ami_virtualization_type  = "hvm"

    tags = {
    Name        = "nginx-git-ami"
    Environment = "production"
    Project     = "nginx"
  }
}


#-----------------------------
# source: how we build the AMI For Nginx and GIT 
#-----------------------------

source "amazon-ebs" "java-git" {
    region = "eu-west-1"
    instance_type = "t3.micro"
    ssh_username = "ec2-user"
    source_ami  = "ami-0870af38096a5355b"
    ami_name = "java-git-by-packer-v2"
    ami_virtualization_type  = "hvm"

    tags = {
    Name        = "java-git-ami"
    Environment = "production"
    Project     = "Java"
  }
}


#-----------------------------
# source: how we build the AMI For Nginx and GIT 
#-----------------------------

source "amazon-ebs" "python-git" {
    region = "eu-west-1"
    instance_type = "t3.micro"
    ssh_username = "ec2-user"
    source_ami  = "ami-0870af38096a5355b"
    ami_name = "python-git-by-packer-v2"
    ami_virtualization_type  = "hvm"

    tags = {
    Name        = "python-git-ami"
    Environment = "production"
    Project     = "Python"
  }
}




#------------------------------------
# build: source + provisioning to do 
#------------------------------------

build  {
    name  = "nginx-git-ami-build"
    sources = [
        "source.amazon-ebs.nginx-git" 
    ]

    provisioner "shell" {
        inline = [
            "sudo yum update -y",
            "sudo yum install git -y"
        ]
    }

    post-processor "shell-local" {
        inline = ["echo 'AMI build is finished For Nginx' "]
    }

}

build  {
    name  = "java-git-ami-build"
    sources = [
        "source.amazon-ebs.java-git"
    ]

    provisioner "shell" {
        inline = [
            "sudo yum update -y",
            "sudo yum install java-17-amazon-corretto -y",
            "sudo yum install maven -y",
            "sudo yum install git -y"
        ]
    }

    post-processor "shell-local" {
        inline = ["echo 'AMI build is finished For Java' "]
    }

}


build  {
    name  = "python-git-ami-build"
    sources = [
        "source.amazon-ebs.python-git"
    ]

    provisioner "shell" {
        inline = [
            "sudo yum update -y",
            "sudo yum install git -y"
        ]
    }

    post-processor "shell-local" {
        inline = ["echo 'AMI build is finished For Python' "]
    }

}