# Create VPC
resource "aws_vpc" "sd2195_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "sd2195_vpc"
  }
}

# Create a public Subnet
resource "aws_subnet" "sd2195_public_subnet_1" {
  vpc_id            = aws_vpc.sd2195_vpc.id
  cidr_block        = var.subnet_cidr_blocks[0]
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "sd2195_public_subnet_1"
  }
}

# resource "aws_subnet" "sd2195_public_subnet_2" {
#   vpc_id            = aws_vpc.sd2195_vpc.id
#   cidr_block        = "10.0.2.0/24"
#   availability_zone = "ap-southeast-1b"

#   tags = {
#     Name = "sd2195_public_subnet_b"
#   }
# }

# Create an Internet Gateway
resource "aws_internet_gateway" "sd2195_ig" {
  vpc_id = aws_vpc.sd2195_vpc.id

  tags = {
    Name = "sd2195_ig"
  }
}

resource "aws_route" "sd2195_route" {
  route_table_id         = data.aws_route_table.main.id
  destination_cidr_block = var.allow_anywhere_cidr_block
  gateway_id             = aws_internet_gateway.sd2195_ig.id
}

# Associate Route Table with public Subnet
resource "aws_route_table_association" "sd2195_rt_public_subnet" {
  subnet_id      = aws_subnet.sd2195_public_subnet_1.id
  route_table_id = data.aws_route_table.main.id
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