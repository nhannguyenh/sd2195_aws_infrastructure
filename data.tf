data "aws_route_table" "main" {
  route_table_id = aws_vpc.sd2195_vpc.main_route_table_id
}