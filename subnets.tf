resource "aws_subnet" "sd2195_public_subnet_zone1" {
  vpc_id                  = aws_vpc.sd2195_vpc.id
  cidr_block              = var.subnet_cidr_blocks[0]
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = true

  tags = {
    "Name"                            = "sd2195_public_subnet_zone1"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

resource "aws_subnet" "sd2195_private_subnet_zone1" {
  vpc_id                  = aws_vpc.sd2195_vpc.id
  cidr_block              = var.subnet_cidr_blocks[1]
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "sd2195_private_subnet_zone1"
  }
}

resource "aws_subnet" "sd2195_public_subnet_zone2" {
  vpc_id            = aws_vpc.sd2195_vpc.id
  cidr_block        = var.subnet_cidr_blocks[2]
  availability_zone = var.availability_zones[1]

  tags = {
    "Name"                            = "sd2195_public_subnet_zone2"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

resource "aws_subnet" "sd2195_private_subnet_zone2" {
  vpc_id            = aws_vpc.sd2195_vpc.id
  cidr_block        = var.subnet_cidr_blocks[3]
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "sd2195_private_subnet_zone2"
  }
}