resource "aws_internet_gateway" "sd2195_igw" {
  vpc_id = aws_vpc.sd2195_vpc.id

  tags = {
    Name = "sd2195_igw"

  }
}