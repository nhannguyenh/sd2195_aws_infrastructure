resource "aws_eip" "sd2195_eip" {
  domain = "vpc"

  tags = {
    Name = "sd2195_eip"
  }
}

resource "aws_nat_gateway" "sd2195_nat" {
  allocation_id = aws_eip.sd2195_eip.id
  subnet_id     = aws_subnet.sd2195_public_subnet_zone1.id

  tags = {
    Name = "sd2195_nat"
  }

  depends_on = [aws_internet_gateway.sd2195_igw]
}