# Create VPC
resource "aws_vpc" "sd2195_vpc" {
  cidr_block = var.vpc_cidr_block

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "sd2195_vpc"
  }
}

# Create Security Group for the EC2 instance
resource "aws_security_group" "sd2195_ec2_sg" {
  name        = "sd2195_ec2_sg"
  description = "Allow access on ports 8080 and 22"
  vpc_id      = aws_vpc.sd2195_vpc.id

  ingress {
    description = "HTTP access"
    from_port   = var.jenkins_port
    to_port     = var.jenkins_port
    protocol    = "tcp"
    cidr_blocks = [var.allow_anywhere_cidr_block]
  }

  ingress {
    description = "SSH access"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.allow_anywhere_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.allow_anywhere_cidr_block]
  }

  tags = {
    Name = "sd2195_ec2_sg"
  }
}