terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure AWS provider
provider "aws" {
  shared_config_files      = ["/Users/nhannguyenh/Documents/myws/PracticalDevOps/terraform/.aws/config"]
  shared_credentials_files = ["/Users/nhannguyenh/Documents/myws/PracticalDevOps/terraform/.aws/credentials"]

  region = "ap-southeast-1"
}

# Create a VPC
resource "aws_vpc" "sd2195_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "sd2195_practical_devops_vpc"
  }
}

# Create a public Subnet
resource "aws_subnet" "sd2195_public_subnet" {
  vpc_id            = aws_vpc.sd2195_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "sd2195_public_subnet"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "sd2195_ig" {
  vpc_id = aws_vpc.sd2195_vpc.id

  tags = {
    Name = "sd2195_ig"
  }
}

# Create a Route Table
resource "aws_route_table" "sd2195_rt" {
  vpc_id = aws_vpc.sd2195_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sd2195_ig.id
  }

  tags = {
    Name = "sd2195_rt"
  }
}

# Associate Route Table with public Subnet
resource "aws_route_table_association" "sd2195_rt_public_subnet" {
  subnet_id      = aws_subnet.sd2195_public_subnet.id
  route_table_id = aws_route_table.sd2195_rt.id
}

# Create Security Group for the EC2 instance
resource "aws_security_group" "sd2195_ec2_sg" {
  name        = "sd2195_ec2_sg"
  description = "Allow access on ports 8080 and 22"
  vpc_id      = aws_vpc.sd2195_vpc.id

  ingress {
    description = "http access"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sd2195_ec2_sg"
  }
}

# Create a EC2 instance
resource "aws_instance" "sd2195_ec2" {
  ami                         = "ami-0f935a2ecd3a7bd5c"
  availability_zone           = "ap-southeast-1a"
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  key_name                    = "ec2key"
  subnet_id                   = aws_subnet.sd2195_public_subnet.id
  vpc_security_group_ids      = [aws_security_group.sd2195_ec2_sg.id]
  user_data                   = file("init-installation.sh")

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = {
    Name = "sd2195_ec2"
  }
}

# print the url of the jenkins server
output "jenkins_url" {
  depends_on = [aws_instance.sd2195_ec2]
  value      = join("", ["http://", aws_instance.sd2195_ec2.public_ip, ":", "8080"])
}

# # Create ERC
# resource "aws_ecr_repository" "sd2195_ecr" {
#   name = "sd2195_ecr"
#   image_tag_mutability = "MUTABLE"

#   image_scanning_configuration {
#     scan_on_push = true
#   }
# }

# data "aws_iam_policy_document" "sd2195_eks_assume_role" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["eks.amazonaws.com"]
#     }

#     actions = ["sts:AssumeRole"]
#   }
# }

# # Create IAM role
# resource "aws_iam_role" "sd2195_eks_role" {
#   name = "sd2195_eks_role"
#   assume_role_policy = data.aws_iam_policy_document.sd2195_eks_assume_role.json
# }

# resource "aws_iam_role_policy_attachment" "sd2195-AmazonEKSClusterPolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   role       = aws_iam_role.sd2195_eks_role.name
# }

# # Create EKS
# resource "aws_eks_cluster" "sd2195_eks" {
#   name = "sd2195_eks"
#   role_arn = aws_iam_role.sd2195_eks_role.arn

#   vpc_config {
#     subnet_ids = [ aws_subnet.sd2195_public_subnet.id ]
#   }
# }