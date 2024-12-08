resource "aws_route_table" "sd2195_public_rt" {
  vpc_id = aws_vpc.sd2195_vpc.id

  route {
    cidr_block = var.allow_anywhere_cidr_block
    gateway_id = aws_internet_gateway.sd2195_igw.id
  }
  tags = {
    Name = "sd2195_public_rt"
  }
}

resource "aws_route_table" "sd2195_private_rt" {
  vpc_id = aws_vpc.sd2195_vpc.id

  route {
    cidr_block     = var.allow_anywhere_cidr_block
    nat_gateway_id = aws_nat_gateway.sd2195_nat.id
  }
  tags = {
    Name = "sd2195_private_rt"
  }
}

resource "aws_route_table_association" "sd2195_rt_public_subnet_zone1" {
  subnet_id      = aws_subnet.sd2195_public_subnet_zone1.id
  route_table_id = aws_route_table.sd2195_public_rt.id
}

resource "aws_route_table_association" "sd2195_rt_public_subnet_zone2" {
  subnet_id      = aws_subnet.sd2195_public_subnet_zone2.id
  route_table_id = aws_route_table.sd2195_public_rt.id
}

resource "aws_route_table_association" "sd2195_rt_private_subnet_zone1" {
  subnet_id      = aws_subnet.sd2195_private_subnet_zone1.id
  route_table_id = aws_route_table.sd2195_private_rt.id
}

resource "aws_route_table_association" "sd2195_rt_private_subnet_zone2" {
  subnet_id      = aws_subnet.sd2195_private_subnet_zone2.id
  route_table_id = aws_route_table.sd2195_private_rt.id
}